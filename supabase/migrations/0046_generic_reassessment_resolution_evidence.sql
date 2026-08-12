-- ============================================================================
-- 0046_generic_reassessment_resolution_evidence.sql
--
-- Expand Development Plan resolution evidence from Safety-only evidence
-- to a shared Safety + Knowledge reassessment evidence contract.
--
-- Supported action types:
--
--   SAFETY_GAP
--   CRITICAL_KNOWLEDGE_GAP
--   KNOWLEDGE_DEVELOPMENT
--
-- The original Safety columns are preserved in their existing order so
-- current application consumers remain compatible.
-- ============================================================================

begin;


-- ============================================================================
-- DROP OLD SAFETY-ONLY VIEW
-- ============================================================================

drop view if exists
  public.v_development_plan_resolution_evidence;


-- ============================================================================
-- CREATE GENERIC REASSESSMENT EVIDENCE VIEW
-- ============================================================================

create view public.v_development_plan_resolution_evidence
as

with


-- ============================================================================
-- INITIAL SAFETY EVIDENCE
-- ============================================================================

initial_safety as (

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

  from public.development_plans dp

  left join public.attempt_question_selections aqs
    on aqs.attempt_id = dp.attempt_id

  left join public.assessment_questions aq
    on aq.id = aqs.question_id

  left join public.attempt_answers ans
    on ans.attempt_id = dp.attempt_id
   and ans.question_id = aq.id

  where dp.action_type = 'SAFETY_GAP'

  group by
    dp.id,
    dp.attempt_id
),


-- ============================================================================
-- INITIAL KNOWLEDGE EVIDENCE
--
-- Uses the competency score from the original assessment that generated
-- the Development Plan.
-- ============================================================================

initial_knowledge as (

  select
    dp.id
      as development_plan_id,

    dp.attempt_id
      as initial_attempt_id,

    cs.score_percent
      as initial_knowledge_score_percent,

    cs.estimated_level
      as initial_knowledge_level,

    cs.required_level
      as initial_required_level

  from public.development_plans dp

  left join public.competency_scores cs
    on cs.attempt_id = dp.attempt_id
   and cs.master_competency_template_id =
       dp.master_competency_template_id

  where dp.action_type in (
    'CRITICAL_KNOWLEDGE_GAP',
    'KNOWLEDGE_DEVELOPMENT'
  )
),


-- ============================================================================
-- LATEST COMPLETED TARGETED REASSESSMENT BY DEVELOPMENT PLAN
-- ============================================================================

latest_targeted as (

  select distinct on (
    aa.development_plan_id
  )
    aa.development_plan_id,

    aa.id
      as reassessment_attempt_id,

    aa.completed_at
      as reassessment_completed_at,

    aa.created_at
      as reassessment_created_at

  from public.assessment_attempts aa

  where aa.development_plan_id is not null
    and aa.attempt_mode = 'targeted_reassessment'
    and aa.status = 'completed'

  order by
    aa.development_plan_id,
    aa.completed_at desc nulls last,
    aa.created_at desc
),


-- ============================================================================
-- TARGETED SAFETY REASSESSMENT EVIDENCE
-- ============================================================================

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

  join public.development_plans dp
    on dp.id = lt.development_plan_id
   and dp.action_type = 'SAFETY_GAP'

  left join public.attempt_question_selections aqs
    on aqs.attempt_id = lt.reassessment_attempt_id

  left join public.assessment_questions aq
    on aq.id = aqs.question_id

  left join public.attempt_answers ans
    on ans.attempt_id = lt.reassessment_attempt_id
   and ans.question_id = aq.id

  group by
    lt.development_plan_id,
    lt.reassessment_attempt_id,
    lt.reassessment_completed_at
),


-- ============================================================================
-- TARGETED KNOWLEDGE REASSESSMENT EVIDENCE
--
-- Uses competency_scores generated by the targeted reassessment and matches
-- the exact competency represented by the Development Plan.
-- ============================================================================

reassessment_knowledge as (

  select
    lt.development_plan_id,

    lt.reassessment_attempt_id,

    lt.reassessment_completed_at,

    cs.score_percent
      as reassessment_knowledge_score_percent,

    cs.estimated_level
      as reassessment_knowledge_level,

    cs.required_level
      as reassessment_required_level

  from latest_targeted lt

  join public.development_plans dp
    on dp.id = lt.development_plan_id
   and dp.action_type in (
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
   )

  left join public.competency_scores cs
    on cs.attempt_id = lt.reassessment_attempt_id
   and cs.master_competency_template_id =
       dp.master_competency_template_id
)


-- ============================================================================
-- FINAL CONTRACT
--
-- Columns 1–18 preserve the original Safety-only view contract.
-- New generic fields follow those columns.
-- ============================================================================

select

  -- --------------------------------------------------------------------------
  -- EXISTING COLUMNS 1–18
  -- --------------------------------------------------------------------------

  dp.id
    as development_plan_id,

  dp.client_id,

  dp.employee_id,

  dp.action_type,

  dp.status
    as plan_status,

  dp.resolution_status,

  dp.resolved_at,

  coalesce(
    initial_safety.initial_attempt_id,
    initial_knowledge.initial_attempt_id
  )
    as initial_attempt_id,

  coalesce(
    initial_safety.initial_safety_questions,
    0::bigint
  )
    as initial_safety_questions,

  coalesce(
    initial_safety.initial_safety_correct,
    0::bigint
  )
    as initial_safety_correct,

  initial_safety.initial_safety_score_percent,

  coalesce(
    reassessment_safety.reassessment_attempt_id,
    reassessment_knowledge.reassessment_attempt_id
  )
    as reassessment_attempt_id,

  coalesce(
    reassessment_safety.reassessment_completed_at,
    reassessment_knowledge.reassessment_completed_at
  )
    as reassessment_completed_at,

  coalesce(
    reassessment_safety.reassessment_safety_questions,
    0::bigint
  )
    as reassessment_safety_questions,

  coalesce(
    reassessment_safety.reassessment_safety_correct,
    0::bigint
  )
    as reassessment_safety_correct,

  reassessment_safety.reassessment_safety_score_percent,

  case
    when dp.action_type = 'SAFETY_GAP'
      then 80.0::numeric
    else null::numeric
  end
    as required_safety_threshold_percent,

  case

    when dp.action_type = 'SAFETY_GAP'
    then
      case
        when reassessment_safety.reassessment_safety_score_percent
          is null
          then null::boolean

        when reassessment_safety.reassessment_safety_score_percent
          >= 80.0
          then true

        else false
      end


    when dp.action_type in (
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )
    then
      case
        when reassessment_knowledge.reassessment_knowledge_level
          is null
          then null::boolean

        when coalesce(
          reassessment_knowledge.reassessment_required_level,
          initial_knowledge.initial_required_level
        ) is null
          then null::boolean

        when reassessment_knowledge.reassessment_knowledge_level
          >= coalesce(
            reassessment_knowledge.reassessment_required_level,
            initial_knowledge.initial_required_level
          )
          then true

        else false
      end

    else null::boolean

  end
    as reassessment_passed,


  -- --------------------------------------------------------------------------
  -- NEW GENERIC EVIDENCE FIELDS
  -- --------------------------------------------------------------------------

  dp.master_competency_template_id,

  dp.competency_name_snapshot,

  case
    when dp.action_type = 'SAFETY_GAP'
      then 'safety'::text

    when dp.action_type in (
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )
      then 'knowledge'::text

    else null::text
  end
    as evidence_type,


  -- Generic score values

  case
    when dp.action_type = 'SAFETY_GAP'
      then initial_safety.initial_safety_score_percent

    when dp.action_type in (
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )
      then initial_knowledge.initial_knowledge_score_percent

    else null::numeric
  end
    as initial_score_percent,


  case
    when dp.action_type = 'SAFETY_GAP'
      then reassessment_safety.reassessment_safety_score_percent

    when dp.action_type in (
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )
      then reassessment_knowledge.reassessment_knowledge_score_percent

    else null::numeric
  end
    as reassessment_score_percent,


  case
    when dp.action_type = 'SAFETY_GAP'
      then 80.0::numeric

    else null::numeric
  end
    as required_score_percent,


  -- Knowledge-specific values

  initial_knowledge.initial_knowledge_score_percent,

  initial_knowledge.initial_knowledge_level,

  reassessment_knowledge.reassessment_knowledge_score_percent,

  reassessment_knowledge.reassessment_knowledge_level,

  coalesce(
    reassessment_knowledge.reassessment_required_level,
    initial_knowledge.initial_required_level
  )
    as required_level


from public.development_plans dp

left join initial_safety
  on initial_safety.development_plan_id = dp.id

left join initial_knowledge
  on initial_knowledge.development_plan_id = dp.id

left join reassessment_safety
  on reassessment_safety.development_plan_id = dp.id

left join reassessment_knowledge
  on reassessment_knowledge.development_plan_id = dp.id

where dp.action_type in (
  'SAFETY_GAP',
  'CRITICAL_KNOWLEDGE_GAP',
  'KNOWLEDGE_DEVELOPMENT'
);


-- ============================================================================
-- PERMISSIONS
-- ============================================================================

grant select
on public.v_development_plan_resolution_evidence
to authenticated;

notify pgrst, 'reload schema';


commit;
