-- ============================================================================
-- 0045_correct_readiness_resolution_timestamp.sql
--
-- Prevent a failed reassessment from immediately returning to an
-- evidence-waiting state merely because all activities from the previous
-- development cycle remain completed.
--
-- Lifecycle invariant:
--
--   Development Plan status = in_progress
--       =>
--   resolution_status = development_in_progress
--
-- Once new development work is completed, the existing activity lifecycle
-- refresh changes the plan status to completed and the resolution engine may
-- advance it back to awaiting reassessment / verification / reverification.
-- ============================================================================


create or replace function
public.wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare

  v_plan
    public.development_plans%rowtype;

  v_action_exists boolean;

  v_successor_action_exists boolean;

  v_activities_total integer;

  v_activities_remaining integer;

  v_expected_status text;

begin

  -- --------------------------------------------------------------------------
  -- Locate plan.
  -- --------------------------------------------------------------------------

  select *
  into v_plan

  from public.development_plans

  where id =
    p_development_plan_id;

  if not found then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancelled plans remain cancelled.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled' then

    update public.development_plans

    set
      resolution_status =
        'cancelled',

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
  -- DEVELOPMENT CYCLE HOLD
  --
  -- A plan that has been deliberately reopened after failed evidence must
  -- remain in development until the parent plan status becomes completed
  -- again.
  --
  -- This also establishes the general invariant that evidence phases only
  -- begin after development status is completed.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'in_progress' then

    update public.development_plans

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
  -- Count active / unfinished development activities.
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

  from public.development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Development work is still underway.
  --
  -- A plan with zero activities remains development_in_progress.
  -- --------------------------------------------------------------------------

  if
    v_activities_total = 0
    or v_activities_remaining > 0
  then

    update public.development_plans

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
  -- --------------------------------------------------------------------------

  if v_plan.action_key is null then

    update public.development_plans

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
  -- --------------------------------------------------------------------------

  select exists (

    select 1

    from public.v_readiness_action_queue q

    where q.action_key =
      v_plan.action_key

  )
  into v_action_exists;


  v_successor_action_exists :=
    false;


  -- --------------------------------------------------------------------------
  -- PRACTICAL ACTION SUCCESSOR BRIDGE
  -- --------------------------------------------------------------------------

  if
    v_action_exists = false
    and v_plan.action_type in (
      'PRACTICAL_VERIFICATION_NEEDED',
      'PRACTICAL_DEVELOPMENT_NEEDED'
    )
    and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from public.v_readiness_action_queue q

      where q.employee_id =
        v_plan.employee_id

        and q.master_competency_template_id =
          v_plan.master_competency_template_id

        and q.action_type in (
          'PRACTICAL_VERIFICATION_NEEDED',
          'PRACTICAL_DEVELOPMENT_NEEDED'
        )

    )
    into v_successor_action_exists;


    if v_successor_action_exists then
      v_action_exists := true;
    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- REVERIFICATION ACTION SUCCESSOR BRIDGE
  -- --------------------------------------------------------------------------

  if
    v_action_exists = false
    and v_plan.action_type in (
      'REVERIFICATION_DUE_SOON',
      'REVERIFICATION_REQUIRED'
    )
    and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from public.v_readiness_action_queue q

      where q.employee_id =
        v_plan.employee_id

        and q.master_competency_template_id =
          v_plan.master_competency_template_id

        and q.action_type in (
          'REVERIFICATION_DUE_SOON',
          'REVERIFICATION_REQUIRED',
          'PRACTICAL_VERIFICATION_NEEDED',
          'PRACTICAL_DEVELOPMENT_NEEDED'
        )

    )
    into v_successor_action_exists;


    if v_successor_action_exists then
      v_action_exists := true;
    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- KNOWLEDGE ACTION SUCCESSOR BRIDGE
  --
  -- Targeted reassessment can legitimately transform the readiness action
  -- among the knowledge/safety action family while the same competency gap
  -- remains unresolved.
  -- --------------------------------------------------------------------------

  if
    v_action_exists = false
    and v_plan.action_type in (
      'SAFETY_GAP',
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )
    and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from public.v_readiness_action_queue q

      where q.employee_id =
        v_plan.employee_id

        and q.master_competency_template_id =
          v_plan.master_competency_template_id

        and q.action_type in (
          'SAFETY_GAP',
          'CRITICAL_KNOWLEDGE_GAP',
          'KNOWLEDGE_DEVELOPMENT'
        )

    )
    into v_successor_action_exists;


    if v_successor_action_exists then
      v_action_exists := true;
    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- No original or valid successor readiness action remains.
  -- --------------------------------------------------------------------------

  if v_action_exists = false then

    update public.development_plans

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
          now()
        ),

      awaiting_evidence_since =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Original Development Plan action type determines required evidence phase.
  -- --------------------------------------------------------------------------

  v_expected_status :=
    public.wri_expected_resolution_status(
      v_plan.action_type
    );


  update public.development_plans

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
-- END 0045
-- ============================================================================
