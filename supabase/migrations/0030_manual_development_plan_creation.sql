-- ============================================================================
-- 0030_manual_development_plan_creation.sql
--
-- Adds manager-created Development Plans that are not tied to a readiness
-- action.
--
-- Manual plan lifecycle:
--
--   Created
--      ↓
--   Development In Progress
--      ↓
--   Activities Completed
--      ↓
--   Resolved
--
-- Readiness-generated plans retain their existing reassessment,
-- practical-verification, and reverification resolution behavior.
-- ============================================================================


-- ============================================================================
-- PART 1 — MANUAL-PLAN-AWARE RESOLUTION ENGINE
-- ============================================================================

create or replace function public.wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_plan development_plans%rowtype;

  v_action_exists boolean;

  v_activities_total integer;

  v_activities_remaining integer;

  v_expected_status text;
begin

  -- --------------------------------------------------------------------------
  -- Locate plan
  -- --------------------------------------------------------------------------

  select *
  into v_plan
  from development_plans
  where id = p_development_plan_id;

  if not found then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancelled plans remain cancelled
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled' then

    update development_plans
    set
      resolution_status = 'cancelled',
      development_completed_at = null,
      awaiting_evidence_since = null,
      resolved_at = null
    where id = p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Count active / unfinished development activities
  -- --------------------------------------------------------------------------

  select
    count(*) filter (
      where status <> 'cancelled'
    ),

    count(*) filter (
      where status not in (
        'completed',
        'cancelled'
      )
    )

  into
    v_activities_total,
    v_activities_remaining

  from development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Development work is still underway.
  --
  -- A plan with zero activities remains development_in_progress. This gives
  -- managers time to create the plan first and then add its activities.
  -- --------------------------------------------------------------------------

  if
    v_activities_total = 0
    or v_activities_remaining > 0
  then

    update development_plans
    set
      resolution_status =
        'development_in_progress',

      development_completed_at =
        null,

      awaiting_evidence_since =
        null,

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- MANUAL DEVELOPMENT PLAN
  --
  -- No readiness action means this plan was not created to resolve a specific
  -- readiness-engine requirement.
  --
  -- Once all active activities are complete, the development requirement is
  -- itself complete and the plan resolves.
  -- --------------------------------------------------------------------------

  if v_plan.action_key is null then

    update development_plans
    set
      resolution_status =
        'resolved',

      development_completed_at =
        coalesce(
          development_completed_at,
          completed_at,
          now()
        ),

      awaiting_evidence_since =
        null,

      resolved_at =
        coalesce(
          resolved_at,
          completed_at,
          now()
        )

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- READINESS-GENERATED DEVELOPMENT PLAN
  --
  -- Determine whether the original readiness action still exists.
  -- --------------------------------------------------------------------------

  select exists (
    select 1
    from v_readiness_action_queue q
    where q.action_key =
      v_plan.action_key
  )
  into v_action_exists;


  -- --------------------------------------------------------------------------
  -- If the readiness action disappeared, the readiness requirement has
  -- already been satisfied.
  -- --------------------------------------------------------------------------

  if v_action_exists = false then

    update development_plans
    set
      resolution_status =
        'resolved',

      development_completed_at =
        coalesce(
          development_completed_at,
          completed_at,
          now()
        ),

      resolved_at =
        coalesce(
          resolved_at,
          completed_at,
          now()
        ),

      awaiting_evidence_since =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Activities are complete but the readiness action still exists.
  --
  -- The original readiness action determines the evidence required next.
  -- --------------------------------------------------------------------------

  v_expected_status :=
    wri_expected_resolution_status(
      v_plan.action_type
    );


  update development_plans
  set
    resolution_status =
      v_expected_status,

    development_completed_at =
      coalesce(
        development_completed_at,
        completed_at,
        now()
      ),

    awaiting_evidence_since =
      coalesce(
        awaiting_evidence_since,
        now()
      ),

    resolved_at =
      null

  where id =
    p_development_plan_id;

end;
$$;


-- ============================================================================
-- PART 2 — MANUAL DEVELOPMENT PLAN CREATION RPC
-- ============================================================================

create or replace function public.wri_create_manual_development_plan(
  p_employee_id uuid,
  p_title text,
  p_description text default null,
  p_development_type text default 'training',
  p_priority text default 'medium',
  p_due_date date default null,
  p_owner_user_id uuid default null,
  p_manager_notes text default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_employee employees%rowtype;

  v_plan_id uuid;

  v_title text;

  v_description text;

  v_manager_notes text;
begin

  -- --------------------------------------------------------------------------
  -- Required employee
  -- --------------------------------------------------------------------------

  if p_employee_id is null then
    raise exception
      'Employee is required.';
  end if;


  select *
  into v_employee
  from employees
  where id = p_employee_id;

  if not found then
    raise exception
      'Employee not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  --
  -- Manual plan creation is intentionally restricted to organizational
  -- management access:
  --
  --   IntegrateU Admin
  --   Client Admin / allowed client
  --
  -- Employees and practical verifiers may continue to read plans according
  -- to existing policies but cannot create manual plans.
  -- --------------------------------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or v_employee.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'Not authorized to create a development plan for this employee.';

  end if;


  -- --------------------------------------------------------------------------
  -- Title
  -- --------------------------------------------------------------------------

  v_title :=
    nullif(
      trim(p_title),
      ''
    );

  if v_title is null then
    raise exception
      'Development plan title is required.';
  end if;


  -- --------------------------------------------------------------------------
  -- Development type validation
  -- --------------------------------------------------------------------------

  if p_development_type not in (
    'training',
    'coaching',
    'field_practice',
    'practical_verification',
    'reassessment',
    'mentoring',
    'observation',
    'other'
  ) then

    raise exception
      'Invalid development type: %',
      p_development_type;

  end if;


  -- --------------------------------------------------------------------------
  -- Priority validation
  -- --------------------------------------------------------------------------

  if p_priority not in (
    'critical',
    'high',
    'medium',
    'low'
  ) then

    raise exception
      'Invalid development plan priority: %',
      p_priority;

  end if;


  -- --------------------------------------------------------------------------
  -- Due date validation
  -- --------------------------------------------------------------------------

  if
    p_due_date is not null
    and p_due_date < current_date
  then

    raise exception
      'Due date cannot be earlier than the plan start date.';

  end if;


  -- --------------------------------------------------------------------------
  -- Normalize optional text
  -- --------------------------------------------------------------------------

  v_description :=
    nullif(
      trim(p_description),
      ''
    );

  v_manager_notes :=
    nullif(
      trim(p_manager_notes),
      ''
    );


  -- --------------------------------------------------------------------------
  -- Create manual development plan
  --
  -- Readiness-source fields intentionally remain null:
  --
  --   action_key
  --   action_type
  --   action_label
  --   master_competency_template_id
  --
  -- This keeps manually assigned development separate from automated
  -- readiness-gap remediation.
  -- --------------------------------------------------------------------------

  insert into development_plans (
    client_id,
    employee_id,

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

    created_by_user_id,
    owner_user_id,

    manager_notes
  )
  values (
    v_employee.client_id,
    v_employee.id,

    null,
    null,
    null,

    null,
    null,
    null,

    v_title,
    v_description,

    p_development_type,
    'not_started',
    p_priority,

    current_date,
    p_due_date,

    auth.uid(),
    p_owner_user_id,

    v_manager_notes
  )
  returning id
  into v_plan_id;


  -- --------------------------------------------------------------------------
  -- Initialize resolution state.
  --
  -- With zero activities, a manual plan begins as development_in_progress.
  -- --------------------------------------------------------------------------

  perform
    wri_refresh_development_plan_resolution(
      v_plan_id
    );


  return v_plan_id;

end;
$$;


-- ============================================================================
-- PART 3 — PERMISSIONS
-- ============================================================================

revoke all
on function public.wri_create_manual_development_plan(
  uuid,
  text,
  text,
  text,
  text,
  date,
  uuid,
  text
)
from public, anon;


grant execute
on function public.wri_create_manual_development_plan(
  uuid,
  text,
  text,
  text,
  text,
  date,
  uuid,
  text
)
to authenticated;


-- ============================================================================
-- PART 4 — REFRESH EXISTING PLAN RESOLUTION STATE
--
-- This preserves the existing readiness-driven behavior while ensuring any
-- actionless/manual plans already in the database follow the new lifecycle.
-- ============================================================================

select
  wri_refresh_all_development_plan_resolutions();


-- ============================================================================
-- PART 5 — INSTALLATION CHECKS
-- ============================================================================

select
  routine_name
from information_schema.routines
where routine_schema = 'public'
and routine_name in (
  'wri_refresh_development_plan_resolution',
  'wri_create_manual_development_plan'
)
order by routine_name;
