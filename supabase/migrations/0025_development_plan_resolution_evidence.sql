-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0025_development_plan_resolution_evidence.sql
--
-- PURPOSE
--
-- Provide before/after evidence for resolved Safety Gap Development Plans.
--
-- Initial Safety Score:
--   calculated from development_plans.attempt_id
--
-- Reassessment Safety Score:
--   calculated from the latest completed targeted reassessment tied to the plan
--
-- ============================================================================


create or replace view
v_development_plan_resolution_evidence
as

with initial_safety as (

  select

    dp.id
      as development_plan_id,

    dp.attempt_id
      as initial_attempt_id,

    count(*) filter (
      where aq.critical_safety = true
    )
      as initial_safety_questions,

    count(*) filter (
      where aq.critical_safety = true
        and ans.is_correct = true
    )
      as initial_safety_correct,

    case

      when count(*) filter (
        where aq.critical_safety = true
      ) = 0

      then null::numeric

      else round(

        100.0

        * count(*) filter (
            where aq.critical_safety = true
              and ans.is_correct = true
          )::numeric

        / count(*) filter (
            where aq.critical_safety = true
          )::numeric,

        1

      )

    end
      as initial_safety_score_percent

  from development_plans dp

  left join attempt_question_selections aqs
    on aqs.attempt_id =
      dp.attempt_id

  left join assessment_questions aq
    on aq.id =
      aqs.question_id

  left join attempt_answers ans
    on ans.attempt_id =
      dp.attempt_id

    and ans.question_id =
      aq.id

  where dp.action_type =
    'SAFETY_GAP'

  group by

    dp.id,
    dp.attempt_id

),

latest_targeted as (

  select distinct on (
    aa.development_plan_id
  )

    aa.development_plan_id,

    aa.id
      as reassessment_attempt_id,

    aa.completed_at
      as reassessment_completed_at

  from assessment_attempts aa

  where aa.attempt_mode =
      'targeted_reassessment'

    and aa.status =
      'completed'

    and aa.development_plan_id
      is not null

  order by

    aa.development_plan_id,

    aa.completed_at desc
      nulls last,

    aa.created_at desc

),

reassessment_safety as (

  select

    lt.development_plan_id,

    lt.reassessment_attempt_id,

    lt.reassessment_completed_at,

    count(*) filter (
      where aq.critical_safety = true
    )
      as reassessment_safety_questions,

    count(*) filter (
      where aq.critical_safety = true
        and ans.is_correct = true
    )
      as reassessment_safety_correct,

    case

      when count(*) filter (
        where aq.critical_safety = true
      ) = 0

      then null::numeric

      else round(

        100.0

        * count(*) filter (
            where aq.critical_safety = true
              and ans.is_correct = true
          )::numeric

        / count(*) filter (
            where aq.critical_safety = true
          )::numeric,

        1

      )

    end
      as reassessment_safety_score_percent

  from latest_targeted lt

  left join attempt_question_selections aqs
    on aqs.attempt_id =
      lt.reassessment_attempt_id

  left join assessment_questions aq
    on aq.id =
      aqs.question_id

  left join attempt_answers ans
    on ans.attempt_id =
      lt.reassessment_attempt_id

    and ans.question_id =
      aq.id

  group by

    lt.development_plan_id,
    lt.reassessment_attempt_id,
    lt.reassessment_completed_at

)

select

  dp.id
    as development_plan_id,

  dp.client_id,

  dp.employee_id,

  dp.action_type,

  dp.status
    as plan_status,

  dp.resolution_status,

  dp.resolved_at,

  initial.initial_attempt_id,

  initial.initial_safety_questions,

  initial.initial_safety_correct,

  initial.initial_safety_score_percent,

  reassessment.reassessment_attempt_id,

  reassessment.reassessment_completed_at,

  reassessment.reassessment_safety_questions,

  reassessment.reassessment_safety_correct,

  reassessment.reassessment_safety_score_percent,

  80.0::numeric
    as required_safety_threshold_percent,

  case

    when reassessment.reassessment_safety_score_percent
      is null
      then null

    when reassessment.reassessment_safety_score_percent
      >= 80.0
      then true

    else false

  end
    as reassessment_passed

from development_plans dp

left join initial_safety initial
  on initial.development_plan_id =
    dp.id

left join reassessment_safety reassessment
  on reassessment.development_plan_id =
    dp.id

where dp.action_type =
  'SAFETY_GAP';