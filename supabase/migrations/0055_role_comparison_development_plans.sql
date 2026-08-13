-- ============================================================================
-- 0055_role_comparison_development_plans.sql
--
-- Adds explicit Development Plan origin metadata and supports creating
-- Development Plans from master-role readiness comparisons.
--
-- IMPORTANT:
--   Role-comparison Development Plans are NOT current-readiness actions.
--   They intentionally use action_key = NULL.
--
-- Existing plan/activity lifecycle machinery remains authoritative.
-- ============================================================================


-- ============================================================================
-- PART 1 — DEVELOPMENT PLAN ORIGIN
-- ============================================================================

alter table public.development_plans
  add column if not exists origin text;

update public.development_plans
set origin =
  case
    when action_key is not null
      then 'current_readiness'
    else 'manual'
  end
where origin is null;

alter table public.development_plans
  alter column origin
  set default 'manual';

alter table public.development_plans
  alter column origin
  set not null;

alter table public.development_plans
  drop constraint if exists
  development_plans_origin_check;

alter table public.development_plans
  add constraint development_plans_origin_check
  check (
    origin in (
      'current_readiness',
      'manual',
      'role_comparison'
    )
  );


-- ============================================================================
-- PART 2 — TARGET MASTER ROLE METADATA
-- ============================================================================

alter table public.development_plans
  add column if not exists
  target_master_role_template_id uuid;

alter table public.development_plans
  add column if not exists
  target_role_name_snapshot text;

alter table public.development_plans
  drop constraint if exists
  development_plans_target_master_role_template_id_fkey;

alter table public.development_plans
  add constraint
  development_plans_target_master_role_template_id_fkey
  foreign key (
    target_master_role_template_id
  )
  references public.master_role_templates(id)
  on delete set null;


create index if not exists
  development_plans_origin_idx
on public.development_plans(origin);


create index if not exists
  development_plans_target_master_role_idx
on public.development_plans(
  target_master_role_template_id
);


-- Only one unresolved role-comparison plan for the same employee / target role.
create unique index if not exists
  development_plans_open_role_comparison_unique
on public.development_plans(
  employee_id,
  target_master_role_template_id
)
where
  origin = 'role_comparison'
  and target_master_role_template_id is not null
  and resolution_status not in (
    'resolved',
    'cancelled'
  );


-- ============================================================================
-- PART 3 — ROLE COMPARISON DEVELOPMENT PLAN CREATION
-- ============================================================================

create or replace function
public.wri_create_role_comparison_development_plan(
  p_employee_id uuid,
  p_target_role_template_id uuid,
  p_due_date date default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $function$

declare
  v_client_id uuid;
  v_target_role_name text;
  v_current_role_name text;
  v_existing_plan_id uuid;
  v_plan_id uuid;
  v_need_count integer;
begin

  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select
    e.client_id
  into
    v_client_id
  from public.employees e
  where e.id = p_employee_id;

  if v_client_id is null then
    raise exception
      'employee % was not found',
      p_employee_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  --
  -- Role-development plans are management actions.
  -- --------------------------------------------------------------------------

  if not (
    public.wri_is_integrateu_admin()
    or v_client_id in (
      select
        public.wri_allowed_client_ids()
    )
  ) then
    raise exception
      'not authorized to create a role development plan for employee %',
      p_employee_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Target role
  -- --------------------------------------------------------------------------

  select
    mrt.name
  into
    v_target_role_name
  from public.master_role_templates mrt
  where
    mrt.id =
      p_target_role_template_id
    and mrt.is_current = true
    and mrt.status = 'active';

  if v_target_role_name is null then
    raise exception
      'target master role % is not a current active role',
      p_target_role_template_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Existing unresolved plan
  --
  -- Creation is idempotent for employee + target role.
  -- --------------------------------------------------------------------------

  select
    dp.id
  into
    v_existing_plan_id
  from public.development_plans dp
  where
    dp.employee_id =
      p_employee_id
    and dp.origin =
      'role_comparison'
    and dp.target_master_role_template_id =
      p_target_role_template_id
    and dp.resolution_status not in (
      'resolved',
      'cancelled'
    )
  order by
    dp.created_at desc
  limit 1;

  if v_existing_plan_id is not null then
    return v_existing_plan_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Evaluate target role using the canonical comparison engine.
  -- --------------------------------------------------------------------------

  select
    count(*)
  into
    v_need_count
  from public.wri_compare_employee_role_readiness(
    p_employee_id,
    p_target_role_template_id
  ) comparison
  where comparison.target_status <>
    'ready';

  if coalesce(v_need_count, 0) = 0 then
    raise exception
      'employee already meets all requirements for target role %',
      v_target_role_name;
  end if;


  select
    comparison.current_role_name
  into
    v_current_role_name
  from public.wri_compare_employee_role_readiness(
    p_employee_id,
    p_target_role_template_id
  ) comparison
  limit 1;


  -- --------------------------------------------------------------------------
  -- Create parent plan.
  --
  -- action_key remains NULL by design:
  -- this must not appear as a current-readiness action.
  -- --------------------------------------------------------------------------

  insert into public.development_plans (
    client_id,
    employee_id,

    attempt_id,

    created_by,
    created_by_user_id,

    action_key,
    action_type,
    action_label,

    master_competency_template_id,
    competency_name_snapshot,

    role_name_snapshot,

    title,
    description,

    development_type,
    status,
    priority,

    start_date,
    due_date,

    owner_user_id,

    resolution_status,

    origin,

    target_master_role_template_id,
    target_role_name_snapshot
  )
  values (
    v_client_id,
    p_employee_id,

    null,

    auth.uid(),
    auth.uid(),

    null,
    null,
    'Role Development',

    null,
    null,

    v_current_role_name,

    'Role Development — ' ||
      v_target_role_name,

    'Development plan generated from role-readiness comparison. ' ||
    'This plan supports development toward ' ||
    v_target_role_name ||
    ' and does not change current-role readiness.',

    'other',
    'not_started',
    'medium',

    current_date,
    p_due_date,

    null,

    'development_in_progress',

    'role_comparison',

    p_target_role_template_id,
    v_target_role_name
  )
  returning id
  into v_plan_id;


  -- --------------------------------------------------------------------------
  -- Generate activities from every target-role requirement that is not ready.
  -- --------------------------------------------------------------------------

  insert into public.development_plan_activities (
    development_plan_id,
    client_id,
    employee_id,

    title,
    description,

    activity_type,
    status,
    sequence_number,

    due_date,

    created_by_user_id
  )
  select
    v_plan_id,
    v_client_id,
    p_employee_id,

    case comparison.target_status

      when 'knowledge_gap'
        then
          'Build target-role knowledge — ' ||
          comparison.competency_name

      when 'practical_gap'
        then
          'Develop target-role practical proficiency — ' ||
          comparison.competency_name

      when 'not_assessed'
        then
          'Assess target-role competency — ' ||
          comparison.competency_name

      when 'reverification_due'
        then
          'Refresh practical verification — ' ||
          comparison.competency_name

      when 'reverification_required'
        then
          'Reverify target-role competency — ' ||
          comparison.competency_name

      else
        'Develop target-role competency — ' ||
        comparison.competency_name

    end as title,


    case comparison.target_status

      when 'knowledge_gap'
        then concat(
          'Current knowledge level: ',
          coalesce(
            comparison.current_knowledge_level::text,
            'not assessed'
          ),
          '. Target role requires Level ',
          comparison.target_required_level,
          '.'
        )

      when 'practical_gap'
        then concat(
          'Current practical level: ',
          coalesce(
            comparison.current_practical_level::text,
            'not verified'
          ),
          '. Target role requires Level ',
          comparison.target_required_level,
          '. Knowledge currently meets the target requirement.'
        )

      when 'not_assessed'
        then concat(
          'No current knowledge evidence is available for this competency. ',
          'Target role requires Level ',
          comparison.target_required_level,
          '.'
        )

      when 'reverification_due'
        then concat(
          'Existing practical evidence meets the target level but is due for ',
          'reverification. Target role requires Level ',
          comparison.target_required_level,
          '.'
        )

      when 'reverification_required'
        then concat(
          'Existing practical evidence has expired and must be renewed. ',
          'Target role requires Level ',
          comparison.target_required_level,
          '.'
        )

      else
        concat(
          'Target role requires Level ',
          comparison.target_required_level,
          '.'
        )

    end as description,


    case comparison.target_status

      when 'knowledge_gap'
        then 'training'

      when 'practical_gap'
        then 'field_practice'

      when 'reverification_due'
        then 'practical_verification'

      when 'reverification_required'
        then 'practical_verification'

      when 'not_assessed'
        then 'other'

      else
        'other'

    end as activity_type,


    'not_started',

    row_number() over (
      order by
        case comparison.target_status
          when 'reverification_required' then 1
          when 'knowledge_gap' then 2
          when 'practical_gap' then 3
          when 'reverification_due' then 4
          when 'not_assessed' then 5
          else 6
        end,
        comparison.competency_name
    )::integer,

    p_due_date,

    auth.uid()

  from public.wri_compare_employee_role_readiness(
    p_employee_id,
    p_target_role_template_id
  ) comparison

  where comparison.target_status <>
    'ready';


  -- --------------------------------------------------------------------------
  -- Re-run existing lifecycle calculation after the generated activities exist.
  -- --------------------------------------------------------------------------

  perform
    public.wri_refresh_development_plan_status(
      v_plan_id
    );

  perform
    public.wri_refresh_development_plan_resolution(
      v_plan_id
    );


  return v_plan_id;

end;

$function$;


-- ============================================================================
-- PART 4 — PERMISSIONS
-- ============================================================================

revoke all
on function
public.wri_create_role_comparison_development_plan(
  uuid,
  uuid,
  date
)
from public, anon;


grant execute
on function
public.wri_create_role_comparison_development_plan(
  uuid,
  uuid,
  date
)
to authenticated;


comment on function
public.wri_create_role_comparison_development_plan(
  uuid,
  uuid,
  date
)
is
'Creates an idempotent Development Plan from employee-to-master-role comparison gaps. Role-comparison plans use action_key NULL and therefore do not become current-readiness actions.';


comment on column
public.development_plans.origin
is
'Development Plan source: current_readiness, manual, or role_comparison.';


comment on column
public.development_plans.target_master_role_template_id
is
'Master role being developed toward when origin = role_comparison.';


comment on column
public.development_plans.target_role_name_snapshot
is
'Immutable role-name snapshot captured when a role-comparison Development Plan is created.';
