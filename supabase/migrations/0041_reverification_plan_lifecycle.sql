-- ============================================================================
-- 0041_reverification_plan_lifecycle.sql
--
-- PURPOSE
--
-- Complete the Development Plan reverification lifecycle and prevent
-- readiness-generated plans from resolving incorrectly when one readiness
-- action legitimately transitions into a successor action.
--
-- EXAMPLES
--
-- Practical:
--
--   PRACTICAL_VERIFICATION_NEEDED
--        ↓ failed verification
--   PRACTICAL_DEVELOPMENT_NEEDED
--
-- Reverification:
--
--   REVERIFICATION_DUE_SOON
--        ↓ time passes
--   REVERIFICATION_REQUIRED
--
--   REVERIFICATION_DUE_SOON / REQUIRED
--        ↓ failed reverification
--   PRACTICAL_DEVELOPMENT_NEEDED
--
-- In these cases the original action_key disappears, but the competency
-- requirement has NOT been satisfied.
--
-- This migration:
--
--   1. Updates the central Development Plan resolution engine to recognize
--      valid successor readiness actions.
--
--   2. Extends the practical verification lifecycle trigger to handle
--      awaiting_reverification.
--
--   3. Preserves prior completed development activity and immutable
--      practical verification history.
-- ============================================================================


-- ============================================================================
-- PART 1 — CENTRAL DEVELOPMENT PLAN RESOLUTION ENGINE
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
    development_plans%rowtype;

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

  from development_plans

  where id =
    p_development_plan_id;


  if not found then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancelled plans remain cancelled.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled' then

    update development_plans

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

  from development_plan_activities

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
  -- First determine whether the original readiness action still exists.
  -- --------------------------------------------------------------------------

  select exists (

    select 1

    from v_readiness_action_queue q

    where q.action_key =
      v_plan.action_key

  )

  into v_action_exists;


  v_successor_action_exists :=
    false;


  -- --------------------------------------------------------------------------
  -- PRACTICAL ACTION SUCCESSOR BRIDGE
  --
  -- A practical verification requirement can legitimately transition into
  -- practical development after an insufficient verification.
  --
  -- Do not resolve the original practical plan merely because its original
  -- action key disappeared.
  -- --------------------------------------------------------------------------

  if v_action_exists = false
     and v_plan.action_type in (
       'PRACTICAL_VERIFICATION_NEEDED',
       'PRACTICAL_DEVELOPMENT_NEEDED'
     )
     and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from v_readiness_action_queue q

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
  --
  -- Reverification may legitimately transition:
  --
  --   DUE SOON -> REQUIRED
  --
  -- or, after an unsuccessful reverification:
  --
  --   REVERIFICATION_* -> PRACTICAL_DEVELOPMENT_NEEDED
  --   REVERIFICATION_* -> PRACTICAL_VERIFICATION_NEEDED
  --
  -- These successor actions mean the competency still requires evidence.
  -- --------------------------------------------------------------------------

  if v_action_exists = false
     and v_plan.action_type in (
       'REVERIFICATION_DUE_SOON',
       'REVERIFICATION_REQUIRED'
     )
     and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from v_readiness_action_queue q

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
  -- No original or valid successor readiness action remains.
  --
  -- The readiness requirement has been satisfied.
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
  -- Activities are complete, but the original action or a valid successor
  -- readiness action still exists.
  --
  -- The Development Plan's original action type continues to determine the
  -- evidence phase.
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
-- PART 2 — PRACTICAL + REVERIFICATION INSERT LIFECYCLE
-- ============================================================================

create or replace function
public.wri_handle_practical_verification_plan_lifecycle()
returns trigger

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan record;

  v_current_plan
    public.development_plans%rowtype;

  v_required_level integer;

  v_verification_satisfied boolean;

  v_is_reverification boolean;

begin

  -- --------------------------------------------------------------------------
  -- Pending verification records do not complete a lifecycle decision.
  -- --------------------------------------------------------------------------

  if new.status = 'pending' then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Find active Development Plans currently waiting for either:
  --
  --   practical verification
  --   reverification
  -- --------------------------------------------------------------------------

  for v_plan in

    select
      dp.id,
      dp.action_type,
      dp.resolution_status

    from public.development_plans dp

    where dp.employee_id =
      new.employee_id

      and dp.master_competency_template_id =
        new.master_competency_template_id

      and dp.status <> 'cancelled'

      and (

        (
          dp.resolution_status =
            'awaiting_verification'

          and dp.action_type in (
            'PRACTICAL_VERIFICATION_NEEDED',
            'PRACTICAL_DEVELOPMENT_NEEDED'
          )
        )

        or

        (
          dp.resolution_status =
            'awaiting_reverification'

          and dp.action_type in (
            'REVERIFICATION_DUE_SOON',
            'REVERIFICATION_REQUIRED'
          )
        )

      )

  loop

    v_is_reverification :=
      v_plan.action_type in (
        'REVERIFICATION_DUE_SOON',
        'REVERIFICATION_REQUIRED'
      );


    -- ------------------------------------------------------------------------
    -- Use the existing practical evidence view as the source of truth for
    -- required level and verification satisfaction.
    -- ------------------------------------------------------------------------

    select
      pe.required_level,
      pe.verification_satisfied

    into
      v_required_level,
      v_verification_satisfied

    from public.v_development_plan_practical_evidence pe

    where pe.development_plan_id =
      v_plan.id;


    -- ------------------------------------------------------------------------
    -- Run the central resolution engine first.
    --
    -- PASS:
    --
    -- A successful new verification should remove the readiness requirement.
    -- The central engine then resolves the plan.
    --
    -- FAIL:
    --
    -- The central engine may keep the plan in its evidence phase because a
    -- successor practical action now exists. The lifecycle handler below then
    -- explicitly reopens development.
    -- ------------------------------------------------------------------------

    perform public.wri_refresh_development_plan_resolution(
      v_plan.id
    );


    -- ------------------------------------------------------------------------
    -- Reload plan after central refresh.
    -- ------------------------------------------------------------------------

    select *
    into v_current_plan

    from public.development_plans

    where id =
      v_plan.id;


    if not found then
      continue;
    end if;


    -- ------------------------------------------------------------------------
    -- SUCCESSFULLY RESOLVED
    --
    -- Clear stale failure notes.
    -- ------------------------------------------------------------------------

    if v_current_plan.resolution_status = 'resolved'
       and coalesce(
         v_verification_satisfied,
         false
       ) = true
    then

      update public.development_plans

      set
        resolution_notes = null,
        updated_at = now()

      where id =
        v_plan.id

        and resolution_status =
          'resolved';

      continue;

    end if;


    -- ------------------------------------------------------------------------
    -- Protect truly terminal plans.
    --
    -- status = completed is NOT terminal by itself because completed
    -- development may still be awaiting evidence.
    -- ------------------------------------------------------------------------

    if v_current_plan.status = 'cancelled'
       or v_current_plan.resolution_status in (
         'resolved',
         'cancelled'
       )
    then
      continue;
    end if;


    -- ------------------------------------------------------------------------
    -- Verification satisfied but another readiness condition still keeps the
    -- plan open. Preserve the central engine state.
    -- ------------------------------------------------------------------------

    if coalesce(
      v_verification_satisfied,
      false
    ) = true
    then
      continue;
    end if;


    -- ------------------------------------------------------------------------
    -- VERIFICATION / REVERIFICATION NOT SATISFIED
    --
    -- Reopen development.
    --
    -- Prior completed development activities remain unchanged.
    -- Verification history remains immutable.
    -- ------------------------------------------------------------------------

    update public.development_plans

    set
      status =
        case
          when status = 'completed'
          then 'in_progress'
          else status
        end,

      resolution_status =
        'development_in_progress',

      development_completed_at =
        null,

      awaiting_evidence_since =
        null,

      resolved_at =
        null,

      resolution_notes =
        case

          when new.status = 'rejected'
               and v_is_reverification
          then
            concat(
              'Practical reverification was rejected. ',
              'Additional development is required.'
            )

          when new.status = 'rejected'
          then
            concat(
              'Practical verification was rejected. ',
              'Additional development is required.'
            )

          when v_required_level is null
               and v_is_reverification
          then
            concat(
              'Practical reverification recorded at level ',
              new.rating_level::text,
              ', but no required competency level was available. ',
              'Additional development review is required.'
            )

          when v_required_level is null
          then
            concat(
              'Practical verification recorded at level ',
              new.rating_level::text,
              ', but no required competency level was available. ',
              'Additional development review is required.'
            )

          when v_is_reverification
          then
            concat(
              'Practical reverification recorded at level ',
              new.rating_level::text,
              ' against required level ',
              v_required_level::text,
              '. Additional development is required.'
            )

          else
            concat(
              'Practical verification recorded at level ',
              new.rating_level::text,
              ' against required level ',
              v_required_level::text,
              '. Additional development is required.'
            )

        end,

      updated_at =
        now()

    where id =
      v_plan.id

      and resolution_status in (
        'awaiting_verification',
        'awaiting_reverification'
      );

  end loop;


  return new;

end;

$$;


-- ============================================================================
-- PART 3 — FUNCTION ACCESS
-- ============================================================================

revoke all
on function
  public.wri_handle_practical_verification_plan_lifecycle()
from public, anon, authenticated;


comment on function
public.wri_handle_practical_verification_plan_lifecycle()
is
'Handles practical verification and reverification Development Plan lifecycles. Failed evidence reopens development while preserving prior completed activities and immutable verification history. Successful evidence resolves through the central Development Plan resolution engine.';


-- ============================================================================
-- END 0041
-- ============================================================================
