-- ============================================================================
-- 0038_practical_verification_plan_lifecycle.sql
--
-- PURPOSE
--
-- Connect immutable practical verification history to the Development Plan
-- lifecycle.
--
-- SUCCESS:
--   Refresh the existing Development Plan resolution engine.
--   If the readiness action disappears, the plan resolves normally.
--
-- NOT SATISFIED:
--   Return the plan to development_in_progress so additional development work
--   can be assigned without altering prior activity or verification history.
--
-- This migration handles practical verification only.
-- Reverification remains a separate lifecycle using awaiting_reverification.
-- ============================================================================


-- ============================================================================
-- PART 1 — HANDLE NEW PRACTICAL VERIFICATION
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
  -- Find active Development Plans tied to this employee + master competency
  -- that are currently waiting for practical verification.
  --
  -- Reverification plans are intentionally excluded from this lifecycle.
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
    -- Read the existing practical-evidence calculation.
    --
    -- This remains the source of truth for:
    --
    --   status = 'verified'
    --   AND
    --   rating_level >= required_level
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
    -- Run the existing central resolution engine first.
    --
    -- If this verification satisfies the readiness requirement, the
    -- readiness action should disappear and the plan will resolve here.
    -- ------------------------------------------------------------------------

    perform public.wri_refresh_development_plan_resolution(
      v_plan.id
    );


    -- ------------------------------------------------------------------------
    -- Reload because the refresh may have changed or resolved the plan.
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
    -- Never reopen terminal plans.
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
    -- The central resolution engine remains authoritative.
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
    -- Return the Development Plan to development_in_progress so the manager
    -- may add additional development.
    --
    -- Existing completed activities remain unchanged.
    -- Existing verification history remains unchanged.
    -- ------------------------------------------------------------------------

    update public.development_plans

    set
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
-- PART 2 — TRIGGER
-- ============================================================================

drop trigger if exists
  trg_practical_verification_plan_lifecycle
on public.master_practical_verifications;


create trigger
  trg_practical_verification_plan_lifecycle

after insert
on public.master_practical_verifications

for each row

execute function
  public.wri_handle_practical_verification_plan_lifecycle();


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
'Synchronizes the Development Plan lifecycle after practical verification. Satisfied verification uses the central resolution engine; rejected or insufficient verification returns the plan to development without altering prior development activity or immutable verification history. Reverification remains a separate lifecycle.';


-- ============================================================================
-- END 0038
-- ============================================================================
