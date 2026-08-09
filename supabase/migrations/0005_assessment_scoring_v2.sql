-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0005_assessment_scoring_v2.sql
--
-- PURPOSE
-- Updates the assessment scoring engine to align with the approved
-- IntegrateU 1–4 proficiency scale and to prevent incomplete attempts
-- from being scored as complete.
--
-- CHANGES
--   1. Competency estimated_level now uses 1–4 instead of 1–5.
--   2. All selected questions for an attempt must be answered before scoring.
--   3. Existing secure answer-key comparison logic is preserved.
--   4. Existing competency gap/status logic is reused.
--
-- No tables are dropped or replaced.
-- ============================================================================


create or replace function wri_score_attempt(
  p_attempt_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attempt assessment_attempts;
  v_employee_auth_user_id uuid;

  v_selected_question_count int;
  v_answered_question_count int;

begin

  -- --------------------------------------------------------------------------
  -- Load attempt
  -- --------------------------------------------------------------------------

  select *
  into v_attempt
  from assessment_attempts
  where id = p_attempt_id;


  if v_attempt is null then
    raise exception
      'attempt % not found',
      p_attempt_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  select auth_user_id
  into v_employee_auth_user_id
  from employees
  where id = v_attempt.employee_id;


  if not (
    wri_is_integrateu_admin()
    or v_attempt.client_id in (
      select wri_allowed_client_ids()
    )
    or v_employee_auth_user_id = auth.uid()
  ) then

    raise exception
      'not authorized to score attempt %',
      p_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Prevent double scoring
  -- --------------------------------------------------------------------------

  if v_attempt.status = 'completed' then
    raise exception
      'attempt % already scored',
      p_attempt_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Require the attempt to have a question snapshot.
  --
  -- 0004 introduced attempt_question_selections so randomized assessments
  -- preserve the exact question set each employee received.
  -- --------------------------------------------------------------------------

  select count(*)
  into v_selected_question_count
  from attempt_question_selections
  where attempt_id = p_attempt_id;


  if v_selected_question_count = 0 then
    raise exception
      'attempt % has no selected questions',
      p_attempt_id;
  end if;


  -- --------------------------------------------------------------------------
  -- Require an answer for every selected question.
  -- --------------------------------------------------------------------------

  select count(*)
  into v_answered_question_count
  from attempt_answers aa
  join attempt_question_selections aqs
    on aqs.attempt_id = aa.attempt_id
   and aqs.question_id = aa.question_id
  where aa.attempt_id = p_attempt_id;


  if v_answered_question_count <> v_selected_question_count then
    raise exception
      'attempt % is incomplete: % of % selected questions answered',
      p_attempt_id,
      v_answered_question_count,
      v_selected_question_count;
  end if;


  -- --------------------------------------------------------------------------
  -- Score answers using the secure answer-key table.
  --
  -- Correct answers may be stored as JSON arrays.
  -- For arrays, order does not matter.
  -- --------------------------------------------------------------------------

  update attempt_answers aa

  set is_correct = (

    select

      case

        when jsonb_typeof(k.correct_answer) = 'array'
        then (

          select array_agg(x order by x)
          from jsonb_array_elements_text(
            k.correct_answer
          ) x

        ) = (

          select array_agg(y order by y)
          from jsonb_array_elements_text(
            aa.response
          ) y

        )

        else
          k.correct_answer = aa.response

      end

    from assessment_question_answer_keys k

    where k.question_id = aa.question_id

  )

  where aa.attempt_id = p_attempt_id;


  -- --------------------------------------------------------------------------
  -- Verify every answer received a score.
  --
  -- This catches missing answer keys instead of silently completing the
  -- attempt with NULL correctness values.
  -- --------------------------------------------------------------------------

  if exists (

    select 1

    from attempt_answers

    where attempt_id = p_attempt_id
      and is_correct is null

  ) then

    raise exception
      'attempt % contains one or more questions without a valid answer key',
      p_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Rebuild competency scores for this attempt.
  --
  -- IntegrateU proficiency scale:
  --
  --   Level 1 = Awareness
  --   Level 2 = Working Knowledge
  --   Level 3 = Proficient / Independent
  --   Level 4 = Advanced / Can Lead or Coach
  --
  -- Current conversion:
  --
  --   0–25%   -> Level 1
  --   >25–50% -> Level 2
  --   >50–75% -> Level 3
  --   >75–100%-> Level 4
  --
  -- score_percent remains the precise result.
  -- --------------------------------------------------------------------------

  insert into competency_scores (

    client_id,
    attempt_id,
    employee_id,
    competency_id,
    score_percent,
    estimated_level,
    required_level

  )

  select

    v_attempt.client_id,

    p_attempt_id,

    v_attempt.employee_id,

    q.competency_id,

    round(
      100.0
      * sum(
          case
            when aa.is_correct
            then q.points
            else 0
          end
        )
      / nullif(sum(q.points), 0),
      1
    ),

    least(
      4,
      greatest(
        1,
        ceil(
          4.0
          * sum(
              case
                when aa.is_correct
                then q.points
                else 0
              end
            )
          / nullif(sum(q.points), 0)
        )::int
      )
    ),

    rcr.required_level


  from attempt_answers aa


  join attempt_question_selections aqs
    on aqs.attempt_id = aa.attempt_id
   and aqs.question_id = aa.question_id


  join assessment_questions q
    on q.id = aa.question_id


  left join role_competency_requirements rcr
    on rcr.role_id = v_attempt.role_id
   and rcr.competency_id = q.competency_id


  where aa.attempt_id = p_attempt_id


  group by
    q.competency_id,
    rcr.required_level


  on conflict (
    attempt_id,
    competency_id
  )

  do update

  set
    score_percent = excluded.score_percent,
    estimated_level = excluded.estimated_level,
    required_level = excluded.required_level;


  -- --------------------------------------------------------------------------
  -- Complete attempt
  -- --------------------------------------------------------------------------

  update assessment_attempts

  set
    status = 'completed',
    completed_at = now(),
    updated_at = now()

  where id = p_attempt_id;


end;
$$;


revoke all
on function wri_score_attempt(uuid)
from public, anon;


grant execute
on function wri_score_attempt(uuid)
to authenticated;



-- ============================================================================
-- Verification
-- ============================================================================

select
  routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name = 'wri_score_attempt';