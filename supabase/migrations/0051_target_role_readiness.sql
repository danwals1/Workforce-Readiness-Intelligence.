-- ============================================================================
-- 0051_target_role_readiness.sql
--
-- Target / next-role readiness intelligence.
--
-- Compares an employee's current assessment + practical verification evidence
-- against a selected master role template's competency requirements.
--
-- This is intentionally read-only:
--   - does not change the employee's current role
--   - does not create employee_target_roles
--   - does not manufacture company competencies
--
-- Current evidence source:
--   v_assessment_competency_readiness_current
--
-- Target requirement source:
--   master_role_competency_requirements
-- ============================================================================


create or replace function public.wri_compare_employee_role_readiness(
  p_employee_id uuid,
  p_target_role_template_id uuid
)
returns table (
  employee_id uuid,
  employee_first_name text,
  employee_last_name text,

  current_role_template_id uuid,
  current_role_name text,
  current_readiness_percent numeric,

  target_role_template_id uuid,
  target_role_name text,
  target_role_department text,

  master_competency_template_id uuid,
  competency_name text,
  competency_category text,
  competency_is_critical boolean,

  current_knowledge_level integer,
  current_practical_level integer,
  practical_verification_required boolean,

  target_required_level integer,

  knowledge_target_ready boolean,
  practical_target_ready boolean,
  target_competency_ready boolean,

  reverification_due boolean,
  verification_expired boolean,

  target_status text,

  target_competencies_ready bigint,
  target_competencies_total bigint,
  target_readiness_percent numeric,

  knowledge_gap_count bigint,
  practical_gap_count bigint,
  not_assessed_count bigint,
  reverification_due_count bigint,
  reverification_required_count bigint
)
language plpgsql
stable
security definer
set search_path = public
as $function$

declare
  v_employee_client_id uuid;
  v_employee_auth_user_id uuid;

begin

  -- --------------------------------------------------------------------------
  -- Employee must exist.
  -- --------------------------------------------------------------------------

  select
    e.client_id,
    e.auth_user_id
  into
    v_employee_client_id,
    v_employee_auth_user_id
  from public.employees e
  where e.id = p_employee_id;

  if v_employee_client_id is null then
    raise exception
      'Employee % not found',
      p_employee_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  --
  -- IntegrateU Admin → any employee
  -- Client Admin     → employee in authorized client
  -- Employee         → self
  -- --------------------------------------------------------------------------

  if not (
    public.wri_is_integrateu_admin()

    or v_employee_client_id in (
      select public.wri_allowed_client_ids()
    )

    or v_employee_auth_user_id = auth.uid()
  ) then
    raise exception
      'Not authorized to view role readiness for employee %',
      p_employee_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Target role must be a current active master role template.
  -- --------------------------------------------------------------------------

  if not exists (
    select 1
    from public.master_role_templates mrt
    where mrt.id = p_target_role_template_id
      and mrt.is_current = true
      and mrt.status = 'active'
  ) then
    raise exception
      'Target role template % is not a current active role',
      p_target_role_template_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Target readiness comparison.
  --
  -- Important:
  -- Current evidence is NOT judged using the employee's current-role
  -- competency_ready flag. We re-evaluate the employee's actual knowledge
  -- and practical levels against the TARGET role's required level.
  -- --------------------------------------------------------------------------

  return query

  with current_role_readiness as (

    select
      rr.master_role_template_id,
      rr.role_name,
      rr.readiness_percent

    from public.v_assessment_role_readiness_current rr

    where rr.employee_id = p_employee_id

    limit 1
  ),

  target_role as (

    select
      mrt.id,
      mrt.name,
      mrt.department

    from public.master_role_templates mrt

    where mrt.id = p_target_role_template_id
  ),

  target_requirements as (

    select
      mrcr.master_competency_template_id,
      mrcr.required_level,

      mct.name as competency_name,
      mct.category as competency_category,
      mct.is_critical as competency_is_critical

    from public.master_role_competency_requirements mrcr

    join public.master_competency_templates mct
      on mct.id =
        mrcr.master_competency_template_id

    where mrcr.master_role_template_id =
      p_target_role_template_id
  ),

  comparison_base as (

    select
      tr.master_competency_template_id,
      tr.competency_name,
      tr.competency_category,
      tr.competency_is_critical,
      tr.required_level,

      acr.master_competency_template_id
        is not null
        as has_current_evidence,

      acr.knowledge_level
        as current_knowledge_level,

      acr.practical_rating_level
        as current_practical_level,

      coalesce(
        acr.practical_verification_required,
        false
      )
        as practical_verification_required,

      coalesce(
        acr.reverification_due,
        false
      )
        as reverification_due,

      coalesce(
        acr.verification_expired,
        false
      )
        as verification_expired

    from target_requirements tr

    left join
      public.v_assessment_competency_readiness_current acr

      on acr.employee_id =
        p_employee_id

     and acr.master_competency_template_id =
        tr.master_competency_template_id
  ),

  evaluated as (

    select
      cb.*,

      (
        cb.has_current_evidence
        and cb.current_knowledge_level
          is not null
        and cb.current_knowledge_level
          >= cb.required_level
      )
        as knowledge_target_ready,

      (
        case

          when not cb.has_current_evidence
            then false

          when
            cb.practical_verification_required = false
            then true

          when cb.verification_expired = true
            then false

          when cb.current_practical_level
            is null
            then false

          when cb.current_practical_level
            >= cb.required_level
            then true

          else false

        end
      )
        as practical_target_ready

    from comparison_base cb
  ),

  classified as (

    select
      ev.*,

      (
        ev.knowledge_target_ready
        and ev.practical_target_ready
      )
        as target_competency_ready,

      case

        when not ev.has_current_evidence
          then 'not_assessed'

        when not ev.knowledge_target_ready
          then 'knowledge_gap'

        when
          ev.practical_verification_required
          and ev.verification_expired
          then 'reverification_required'

        when
          ev.practical_verification_required
          and not ev.practical_target_ready
          then 'practical_gap'

        when ev.reverification_due
          then 'reverification_due'

        else 'ready'

      end
        as target_status

    from evaluated ev
  ),

  summarized as (

    select
      c.*,

      count(*) filter (
        where c.target_competency_ready
      ) over ()
        as target_competencies_ready,

      count(*) over ()
        as target_competencies_total,

      round(
        100.0
        *
        count(*) filter (
          where c.target_competency_ready
        ) over ()
        /
        nullif(
          count(*) over (),
          0
        ),
        1
      )
        as target_readiness_percent,

      count(*) filter (
        where c.target_status =
          'knowledge_gap'
      ) over ()
        as knowledge_gap_count,

      count(*) filter (
        where c.target_status =
          'practical_gap'
      ) over ()
        as practical_gap_count,

      count(*) filter (
        where c.target_status =
          'not_assessed'
      ) over ()
        as not_assessed_count,

      count(*) filter (
        where c.target_status =
          'reverification_due'
      ) over ()
        as reverification_due_count,

      count(*) filter (
        where c.target_status =
          'reverification_required'
      ) over ()
        as reverification_required_count

    from classified c
  )

  select
    e.id
      as employee_id,

    e.first_name
      as employee_first_name,

    e.last_name
      as employee_last_name,

    cr.master_role_template_id
      as current_role_template_id,

    cr.role_name
      as current_role_name,

    cr.readiness_percent
      as current_readiness_percent,

    tr.id
      as target_role_template_id,

    tr.name
      as target_role_name,

    tr.department
      as target_role_department,

    s.master_competency_template_id,

    s.competency_name,
    s.competency_category,
    s.competency_is_critical,

    s.current_knowledge_level,
    s.current_practical_level,

    s.practical_verification_required,

    s.required_level
      as target_required_level,

    s.knowledge_target_ready,
    s.practical_target_ready,
    s.target_competency_ready,

    s.reverification_due,
    s.verification_expired,

    s.target_status,

    s.target_competencies_ready,
    s.target_competencies_total,
    s.target_readiness_percent,

    s.knowledge_gap_count,
    s.practical_gap_count,
    s.not_assessed_count,
    s.reverification_due_count,
    s.reverification_required_count

  from summarized s

  cross join public.employees e
  cross join target_role tr
  left join current_role_readiness cr
    on true

  where e.id = p_employee_id

  order by
    case s.target_status
      when 'reverification_required' then 1
      when 'knowledge_gap' then 2
      when 'practical_gap' then 3
      when 'not_assessed' then 4
      when 'reverification_due' then 5
      else 6
    end,
    s.competency_category,
    s.competency_name;

end;

$function$;


revoke all
on function public.wri_compare_employee_role_readiness(uuid, uuid)
from public, anon;


grant execute
on function public.wri_compare_employee_role_readiness(uuid, uuid)
to authenticated;


comment on function public.wri_compare_employee_role_readiness(uuid, uuid)
is
'Compares an employee current competency evidence with a selected current master role template and returns target-role readiness plus competency-level gaps.';
