-- ============================================================================
-- 0040_clear_resolved_practical_failure_notes.sql
--
-- PURPOSE
--
-- Clear stale practical-verification failure notes once a Development Plan
-- successfully resolves.
--
-- A failed practical verification may set resolution_notes to explain that
-- additional development is required.
--
-- If the employee later completes additional development and successfully
-- passes practical verification, that prior failure note is no longer an
-- accurate description of the plan's current resolution state.
--
-- This migration:
--
--   1. Updates the practical-verification lifecycle handler so successful
--      resolution clears stale failure notes.
--
--   2. Cleans existing resolved practical plans that still contain one of
--      the generated "additional development required" failure notes.
--
-- Development activity history and practical verification history remain
-- unchanged.
-- ============================================================================


-- ============================================================================
-- PART 1 — UPDATE PRACTICAL VERIFICATION LIFECYCLE HANDLER
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

begin

  -- --------------------------------------------------------------------------
  -- Pending verification records do not complete a lifecycle decision.
  -- --------------------------------------------------------------------------

  if new.status = 'pending' then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Find Development Plans currently waiting for practical verification.
  --
  -- Reverification remains a separate lifecycle and is intentionally excluded.
  -- --------------------------------------------------------------------------

  for v_plan in

    select
      dp.id

    from public.development_plans dp

    where dp.employee_id =
      new.employee_id

      and dp.master_competency_template_id =
        new.master_competency_template_id

      and dp.status <> 'cancelled'

      and dp.resolution_status =
        'awaiting_verification'

      and dp.action_type in (
        'PRACTICAL_VERIFICATION_NEEDED',
        'PRACTICAL_DEVELOPMENT_NEEDED'
      )

  loop

    -- ------------------------------------------------------------------------
    -- Use the existing practical evidence view as the source of truth for
    -- required level and whether the newest verification satisfies it.
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
    -- Run the central Development Plan resolution engine first.
    -- ------------------------------------------------------------------------

    perform public.wri_refresh_development_plan_resolution(
      v_plan.id
    );


    -- ------------------------------------------------------------------------
    -- Reload the plan because the central refresh may have changed it.
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
    -- If the current verification satisfied the requirement and the central
    -- resolution engine resolved the plan, clear any stale failure note.
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
    -- Protect cancelled and otherwise terminal resolution states.
    --
    -- status = 'completed' is intentionally NOT terminal here.
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
    -- Verification satisfied but another readiness condition keeps the action
    -- open. Preserve the central resolution engine state.
    -- ------------------------------------------------------------------------

    if coalesce(
      v_verification_satisfied,
      false
    ) = true
    then
      continue;
    end if;


    -- ------------------------------------------------------------------------
    -- Verification NOT satisfied.
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
          then
            concat(
              'Practical verification was rejected. ',
              'Additional development is required.'
            )

          when v_required_level is null
          then
            concat(
              'Practical verification recorded at level ',
              new.rating_level::text,
              ', but no required competency level was available. ',
              'Additional development review is required.'
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

      and resolution_status =
        'awaiting_verification';

  end loop;


  return new;

end;

$$;


-- ============================================================================
-- PART 2 — FUNCTION ACCESS
-- ============================================================================

revoke all
on function
  public.wri_handle_practical_verification_plan_lifecycle()
from public, anon, authenticated;


comment on function
public.wri_handle_practical_verification_plan_lifecycle()
is
'Handles practical verification Development Plan lifecycle. Failed or insufficient verification reopens the plan for additional development while preserving prior activity and verification history. Successful practical resolution clears stale failure notes.';


-- ============================================================================
-- PART 3 — CLEAN EXISTING RESOLVED PRACTICAL PLANS
-- ============================================================================

update public.development_plans

set
  resolution_notes = null,
  updated_at = now()

where resolution_status =
  'resolved'

  and action_type in (
    'PRACTICAL_VERIFICATION_NEEDED',
    'PRACTICAL_DEVELOPMENT_NEEDED'
  )

  and (
    resolution_notes like
      'Practical verification recorded at level %Additional development is required.'

    or resolution_notes =
      'Practical verification was rejected. Additional development is required.'

    or resolution_notes like
      'Practical verification recorded at level %, but no required competency level was available. Additional development review is required.'
  );


-- ============================================================================
-- END 0040
-- ============================================================================
