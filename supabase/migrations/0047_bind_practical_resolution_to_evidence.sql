-- ============================================================================
-- 0047_bind_practical_resolution_to_evidence.sql
--
-- Make practical and reverification Development Plan resolution depend on
-- actual immutable practical verification evidence.
--
-- A practical/reverification plan may resolve only when:
--
--   1. Development activities are complete, and
--   2. A verification exists for the exact employee + competency, and
--   3. verification.status = 'verified', and
--   4. verification.rating_level >= the required level, and
--   5. verification.verified_at >= the time development completed.
--
-- This prevents disappearance/transformation of a readiness action from
-- resolving a practical plan before the required verification exists.
--
-- The practical evidence view is also changed so resolved plans point to
-- the verification that actually satisfied the plan rather than whatever
-- happens to be the employee's newest verification later.
-- ============================================================================

begin;


-- ============================================================================
-- PART 1 — CENTRAL DEVELOPMENT PLAN RESOLVER
-- ============================================================================

create or replace function
public.wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $function$

declare

  v_plan
    public.development_plans%rowtype;

  v_action_exists boolean;

  v_successor_action_exists boolean;

  v_activities_total integer;

  v_activities_remaining integer;

  v_expected_status text;

  v_required_level integer;

  v_evidence_required_since timestamptz;

  v_qualifying_verification_id uuid;

  v_qualifying_verified_at timestamptz;

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
  -- Evidence phases begin only after development status is completed.
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


  -- ==========================================================================
  -- PRACTICAL / REVERIFICATION EVIDENCE GATE
  --
  -- These action families are resolved from immutable verification evidence,
  -- NOT from readiness-action disappearance.
  -- ==========================================================================

  if
    v_plan.action_type in (
      'PRACTICAL_VERIFICATION_NEEDED',
      'PRACTICAL_DEVELOPMENT_NEEDED',
      'REVERIFICATION_DUE_SOON',
      'REVERIFICATION_REQUIRED'
    )
    and v_plan.master_competency_template_id is not null
  then


    -- ------------------------------------------------------------------------
    -- Establish when new practical evidence became required.
    --
    -- Existing historical plans use their persisted development completion
    -- timestamp. New plans normally already have completed_at at this point.
    -- ------------------------------------------------------------------------

    v_evidence_required_since :=
      coalesce(
        v_plan.development_completed_at,
        v_plan.completed_at,
        now()
      );


    -- ------------------------------------------------------------------------
    -- Required competency level.
    -- ------------------------------------------------------------------------

    select
      acr.required_level

    into
      v_required_level

    from public.v_assessment_competency_readiness_current acr

    where acr.employee_id =
      v_plan.employee_id

      and acr.master_competency_template_id =
        v_plan.master_competency_template_id

    limit 1;


    -- ------------------------------------------------------------------------
    -- Find the FIRST qualifying verification after development completed.
    --
    -- Choosing the first qualifying verification permanently identifies the
    -- evidence event that satisfied this Development Plan. Later verification
    -- records do not change the resolution evidence.
    -- ------------------------------------------------------------------------

    v_qualifying_verification_id :=
      null;

    v_qualifying_verified_at :=
      null;


    if v_required_level is not null then

      select
        pv.id,
        pv.verified_at

      into
        v_qualifying_verification_id,
        v_qualifying_verified_at

      from public.master_practical_verifications pv

      where pv.employee_id =
        v_plan.employee_id

        and pv.master_competency_template_id =
          v_plan.master_competency_template_id

        and pv.status =
          'verified'

        and pv.rating_level >=
          v_required_level

        and pv.verified_at >=
          v_evidence_required_since

      order by
        pv.verified_at asc,
        pv.id asc

      limit 1;

    end if;


    -- ------------------------------------------------------------------------
    -- Qualifying evidence exists: resolve from its timestamp.
    -- ------------------------------------------------------------------------

    if v_qualifying_verification_id is not null then

      update public.development_plans

      set
        resolution_status =
          'resolved',

        development_completed_at =
          v_evidence_required_since,

        awaiting_evidence_since =
          null,

        resolved_at =
          v_qualifying_verified_at

      where id =
        p_development_plan_id;

      return;

    end if;


    -- ------------------------------------------------------------------------
    -- No qualifying evidence yet.
    --
    -- The original plan action determines whether the employee is awaiting
    -- verification or awaiting reverification.
    -- ------------------------------------------------------------------------

    v_expected_status :=
      public.wri_expected_resolution_status(
        v_plan.action_type
      );


    update public.development_plans

    set
      resolution_status =
        v_expected_status,

      development_completed_at =
        v_evidence_required_since,

      awaiting_evidence_since =
        coalesce(
          awaiting_evidence_since,
          v_evidence_required_since
        ),

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- ==========================================================================
  -- READINESS-GENERATED NON-PRACTICAL DEVELOPMENT PLAN
  -- ==========================================================================

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
  -- KNOWLEDGE / SAFETY ACTION SUCCESSOR BRIDGE
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

$function$;


-- ============================================================================
-- PART 2 — PRACTICAL EVIDENCE VIEW
--
-- The existing column contract is retained first.
--
-- For a resolved plan:
--   verification_* identifies the FIRST qualifying verification after
--   development completion.
--
-- For an unresolved plan:
--   verification_* identifies the latest practical verification attempt
--   since development completion so admins can see the current evidence.
-- ============================================================================

drop view if exists
  public.v_development_plan_practical_evidence;


create view public.v_development_plan_practical_evidence
as

with plan_context as (

  select
    dp.id
      as development_plan_id,

    dp.client_id,

    dp.employee_id,

    dp.master_competency_template_id,

    dp.competency_name_snapshot,

    dp.action_type,

    dp.status
      as plan_status,

    dp.resolution_status,

    dp.resolved_at,

    acr.required_level,

    coalesce(
      dp.development_completed_at,
      dp.completed_at,
      dp.created_at
    )
      as evidence_required_since

  from public.development_plans dp

  left join public.v_assessment_competency_readiness_current acr
    on acr.employee_id =
      dp.employee_id

   and acr.master_competency_template_id =
      dp.master_competency_template_id

  where dp.action_type in (
    'PRACTICAL_VERIFICATION_NEEDED',
    'PRACTICAL_DEVELOPMENT_NEEDED',
    'REVERIFICATION_DUE_SOON',
    'REVERIFICATION_REQUIRED'
  )
),

evidence as (

  select
    pc.*,

    qualifying.id
      as qualifying_verification_id,

    qualifying.rating_level
      as qualifying_verified_level,

    qualifying.status
      as qualifying_verification_status,

    qualifying.verified_by
      as qualifying_verified_by,

    qualifying.verified_at
      as qualifying_verified_at,

    qualifying.notes
      as qualifying_notes,

    latest_attempt.id
      as latest_attempt_verification_id,

    latest_attempt.rating_level
      as latest_attempt_verified_level,

    latest_attempt.status
      as latest_attempt_verification_status,

    latest_attempt.verified_by
      as latest_attempt_verified_by,

    latest_attempt.verified_at
      as latest_attempt_verified_at,

    latest_attempt.notes
      as latest_attempt_notes,

    previous.id
      as previous_verification_id,

    previous.rating_level
      as previous_verified_level,

    previous.status
      as previous_verification_status,

    previous.verified_at
      as previous_verified_at

  from plan_context pc


  -- --------------------------------------------------------------------------
  -- First qualifying verification in this plan's evidence window.
  -- --------------------------------------------------------------------------

  left join lateral (

    select
      pv.id,
      pv.rating_level,
      pv.status,
      pv.verified_by,
      pv.verified_at,
      pv.notes

    from public.master_practical_verifications pv

    where pv.employee_id =
      pc.employee_id

      and pv.master_competency_template_id =
        pc.master_competency_template_id

      and pv.status =
        'verified'

      and pc.required_level is not null

      and pv.rating_level >=
        pc.required_level

      and pv.verified_at >=
        pc.evidence_required_since

    order by
      pv.verified_at asc,
      pv.id asc

    limit 1

  ) qualifying
    on true


  -- --------------------------------------------------------------------------
  -- Latest verification attempt in this plan's evidence window.
  -- Used while the plan is still awaiting evidence.
  -- --------------------------------------------------------------------------

  left join lateral (

    select
      pv.id,
      pv.rating_level,
      pv.status,
      pv.verified_by,
      pv.verified_at,
      pv.notes

    from public.master_practical_verifications pv

    where pv.employee_id =
      pc.employee_id

      and pv.master_competency_template_id =
        pc.master_competency_template_id

      and pv.verified_at >=
        pc.evidence_required_since

    order by
      pv.verified_at desc,
      pv.id desc

    limit 1

  ) latest_attempt
    on true


  -- --------------------------------------------------------------------------
  -- Verification immediately before this evidence window.
  -- Useful for showing the prior practical/reverification state.
  -- --------------------------------------------------------------------------

  left join lateral (

    select
      pv.id,
      pv.rating_level,
      pv.status,
      pv.verified_at

    from public.master_practical_verifications pv

    where pv.employee_id =
      pc.employee_id

      and pv.master_competency_template_id =
        pc.master_competency_template_id

      and pv.verified_at <
        pc.evidence_required_since

    order by
      pv.verified_at desc,
      pv.id desc

    limit 1

  ) previous
    on true

)

select

  -- --------------------------------------------------------------------------
  -- EXISTING CONTRACT
  -- --------------------------------------------------------------------------

  evidence.development_plan_id,

  evidence.client_id,

  evidence.employee_id,

  evidence.master_competency_template_id,

  evidence.competency_name_snapshot,

  evidence.action_type,

  evidence.plan_status,

  evidence.resolution_status,

  evidence.resolved_at,

  evidence.required_level,


  -- Once qualifying evidence exists, these columns bind to that immutable
  -- event. Otherwise they show the latest attempt in the evidence window.

  coalesce(
    evidence.qualifying_verification_id,
    evidence.latest_attempt_verification_id
  )
    as verification_id,

  coalesce(
    evidence.qualifying_verified_level,
    evidence.latest_attempt_verified_level
  )
    as verified_level,

  coalesce(
    evidence.qualifying_verification_status,
    evidence.latest_attempt_verification_status
  )
    as verification_status,

  coalesce(
    evidence.qualifying_verified_by,
    evidence.latest_attempt_verified_by
  )
    as verified_by,

  coalesce(
    evidence.qualifying_verified_at,
    evidence.latest_attempt_verified_at
  )
    as verified_at,

  coalesce(
    evidence.qualifying_notes,
    evidence.latest_attempt_notes
  )
    as notes,

  case

    when evidence.qualifying_verification_id is not null
      then true

    else false

  end
    as verification_satisfied,


  -- --------------------------------------------------------------------------
  -- NEW EVIDENCE-PROVENANCE FIELDS
  -- --------------------------------------------------------------------------

  evidence.evidence_required_since,

  case
    when evidence.action_type in (
      'REVERIFICATION_DUE_SOON',
      'REVERIFICATION_REQUIRED'
    )
      then 'reverification'::text

    else 'practical_verification'::text
  end
    as evidence_type,

  evidence.previous_verification_id,

  evidence.previous_verified_level,

  evidence.previous_verification_status,

  evidence.previous_verified_at,

  evidence.qualifying_verification_id,

  evidence.qualifying_verified_level,

  evidence.qualifying_verification_status,

  evidence.qualifying_verified_at

from evidence;


grant select
on public.v_development_plan_practical_evidence
to authenticated;


-- ============================================================================
-- PART 3 — RE-EVALUATE EXISTING PRACTICAL / REVERIFICATION PLANS
--
-- This also repairs historical resolved_at timestamps where a plan was
-- previously marked resolved before qualifying verification existed.
-- ============================================================================

do $$
declare
  v_plan record;
begin

  for v_plan in

    select id

    from public.development_plans

    where action_type in (
      'PRACTICAL_VERIFICATION_NEEDED',
      'PRACTICAL_DEVELOPMENT_NEEDED',
      'REVERIFICATION_DUE_SOON',
      'REVERIFICATION_REQUIRED'
    )

  loop

    perform
      public.wri_refresh_development_plan_resolution(
        v_plan.id
      );

  end loop;

end;
$$;


notify pgrst, 'reload schema';


commit;
