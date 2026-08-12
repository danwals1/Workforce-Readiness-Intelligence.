-- ============================================================================
-- 0039_fix_practical_verification_failed_lifecycle.sql
--
-- PURPOSE
--
-- Correct the practical verification Development Plan lifecycle introduced
-- in migration 0038.
--
-- ISSUE
--
-- A Development Plan waiting for practical verification has:
--
--   status = 'completed'
--   resolution_status = 'awaiting_verification'
--
-- The completed status represents completion of the assigned development
-- activities. It does NOT mean the Development Plan lifecycle is resolved.
--
-- Migration 0038 incorrectly treated status = 'completed' as terminal and
-- exited before a failed practical verification could return the plan to
-- development.
--
-- CORRECT BEHAVIOR
--
-- PASS:
--   Existing central resolution engine remains authoritative.
--
-- FAIL:
--   status            -> in_progress
--   resolution_status -> development_in_progress
--
--   Prior completed development activities remain unchanged.
--   Practical verification history remains immutable.
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
    --
    -- If the practical verification satisfies the competency requirement,
    -- the readiness action should disappear and the existing engine owns
    -- final plan resolution.
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
    -- Only truly terminal resolution states are protected.
    --
    -- IMPORTANT:
    --
    -- status = 'completed' is intentionally NOT treated as terminal here.
    --
    -- A practical Development Plan normally reaches:
    --
    --   status = completed
    --   resolution_status = awaiting_verification
    --
    -- after its development activities are completed.
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
    -- Verification satisfied.
    --
    -- Preserve the state selected by the central resolution engine.
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
    --
    -- Includes:
    --
    --   * rejected verification
    --   * verified rating below required level
    --   * verification with no usable required level
    --
    -- Reopen the Development Plan so additional development may be assigned.
    --
    -- Existing development_plan_activities rows are NOT changed.
    -- Existing practical verification history is NOT changed.
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
-- FUNCTION ACCESS
-- ============================================================================

revoke all
on function
  public.wri_handle_practical_verification_plan_lifecycle()
from public, anon, authenticated;


comment on function
public.wri_handle_practical_verification_plan_lifecycle()
is
'Handles practical verification Development Plan lifecycle. A failed or insufficient practical verification reopens a completed-but-awaiting-verification plan to in_progress / development_in_progress while preserving prior completed activities and immutable verification history.';


-- ============================================================================
-- END 0039
-- ============================================================================
