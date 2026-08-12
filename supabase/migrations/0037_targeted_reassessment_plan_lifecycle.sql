-- ============================================================================
-- 0037_targeted_reassessment_plan_lifecycle.sql
--
-- PURPOSE
--
-- Keep Development Plan resolution synchronized with completed targeted
-- Safety reassessments.
--
-- PASS:
--   Refresh the Development Plan normally. If the readiness action has been
--   satisfied, the existing resolution engine will resolve the plan.
--
-- FAIL:
--   Return the plan to development_in_progress so additional development work
--   can be assigned without altering previously completed activity history.
-- ============================================================================


-- ============================================================================
-- PART 1 — HANDLE COMPLETED TARGETED REASSESSMENT
-- ============================================================================

create or replace function public.wri_handle_completed_targeted_reassessment()
returns trigger

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan
    public.development_plans%rowtype;

  v_safety_questions integer := 0;

  v_safety_correct integer := 0;

  v_safety_score numeric := null;

begin

  -- --------------------------------------------------------------------------
  -- Only react when an assessment transitions into completed.
  -- --------------------------------------------------------------------------

  if new.status <> 'completed'
     or old.status = 'completed'
  then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Only targeted reassessments tied to a Development Plan participate.
  -- --------------------------------------------------------------------------

  if new.attempt_mode is distinct from 'targeted_reassessment'
     or new.development_plan_id is null
  then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Load parent Development Plan.
  -- --------------------------------------------------------------------------

  select *
  into v_plan
  from public.development_plans
  where id = new.development_plan_id;

  if not found then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Never reopen terminal plans.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled'
     or v_plan.resolution_status in (
       'resolved',
       'cancelled'
     )
  then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Targeted reassessment currently applies to Safety Gap plans.
  -- --------------------------------------------------------------------------

  if v_plan.action_type <> 'SAFETY_GAP' then

    perform public.wri_refresh_development_plan_resolution(
      new.development_plan_id
    );

    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Calculate the targeted critical-safety score for THIS attempt.
  -- --------------------------------------------------------------------------

  select

    count(*) filter (
      where aq.critical_safety = true
    ),

    count(*) filter (
      where aq.critical_safety = true
        and ans.is_correct = true
    )

  into
    v_safety_questions,
    v_safety_correct

  from public.attempt_question_selections aqs

  join public.assessment_questions aq
    on aq.id = aqs.question_id

  left join public.attempt_answers ans
    on ans.attempt_id = aqs.attempt_id
   and ans.question_id = aqs.question_id

  where aqs.attempt_id = new.id;


  if v_safety_questions > 0 then

    v_safety_score :=
      round(
        100.0
        * v_safety_correct::numeric
        / v_safety_questions::numeric,
        1
      );

  end if;


  -- --------------------------------------------------------------------------
  -- First let the existing readiness engine determine whether the underlying
  -- readiness action has disappeared.
  --
  -- This preserves the existing single source of truth for resolution.
  -- --------------------------------------------------------------------------

  perform public.wri_refresh_development_plan_resolution(
    new.development_plan_id
  );


  -- --------------------------------------------------------------------------
  -- Reload plan because the refresh may have resolved it.
  -- --------------------------------------------------------------------------

  select *
  into v_plan
  from public.development_plans
  where id = new.development_plan_id;


  if v_plan.resolution_status = 'resolved'
     or v_plan.status = 'completed'
  then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- Failed targeted reassessment:
  --
  -- Keep historical completed activities intact, but reopen the Development
  -- Plan so a manager can assign additional development work.
  --
  -- The next added/incomplete activity will remain development_in_progress.
  -- When the new development work is completed, the existing resolution
  -- engine will move the plan back to awaiting_reassessment.
  -- --------------------------------------------------------------------------

  if v_safety_score is not null
     and v_safety_score < 80.0
  then

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
        concat(
          'Targeted safety reassessment completed at ',
          coalesce(
            new.completed_at::text,
            now()::text
          ),
          ' with a score of ',
          v_safety_score::text,
          '%. Additional development is required.'
        ),

      updated_at =
        now()

    where id =
      new.development_plan_id;

  end if;


  return new;

end;

$$;


-- ============================================================================
-- PART 2 — TRIGGER
-- ============================================================================

drop trigger if exists
trg_targeted_reassessment_plan_lifecycle
on public.assessment_attempts;


create trigger trg_targeted_reassessment_plan_lifecycle

after update of status
on public.assessment_attempts

for each row

when (
  new.status = 'completed'
  and old.status is distinct from 'completed'
)

execute function
public.wri_handle_completed_targeted_reassessment();


-- ============================================================================
-- PART 3 — FUNCTION PERMISSIONS
--
-- Trigger function is not intended to be called directly by application users.
-- ============================================================================

revoke all
on function public.wri_handle_completed_targeted_reassessment()
from public, anon, authenticated;


comment on function
public.wri_handle_completed_targeted_reassessment()
is
  'Synchronizes Development Plan lifecycle after completion of a targeted Safety reassessment. Passing results use the standard resolution engine; failed results return the plan to development without altering completed activity history.';
