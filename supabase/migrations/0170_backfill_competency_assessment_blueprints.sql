-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0170_backfill_competency_assessment_blueprints.sql
--
-- PURPOSE
-- Backfills assessment_blueprint_rules for current global competency
-- assessments when:
--   1. the assessment has exactly one question domain,
--   2. the question inventory exactly matches the current Master assessment
--      standard for its competency + target level,
--   3. no blueprint rule already exists.
--
-- This preserves the Master competency assessment standard as the source of
-- truth for question counts and difficulty mix.
-- ============================================================================

insert into public.assessment_blueprint_rules (
  assessment_id,
  domain,
  master_competency_template_id,
  question_count,
  foundational_count,
  application_count,
  scenario_count,
  sort_order
)

select
  a.id,
  min(q.domain) as domain,
  a.master_competency_template_id,
  s.required_question_count,
  s.foundational_count,
  s.application_count,
  s.scenario_count,
  1

from public.assessments a

join public.master_competency_assessment_standards s
  on s.master_competency_template_id =
       a.master_competency_template_id
 and s.target_level =
       a.target_level
 and s.is_current = true

join public.assessment_questions q
  on q.assessment_id =
       a.id

where a.client_id is null
  and a.type = 'competency'
  and a.is_current = true

group by
  a.id,
  a.master_competency_template_id,
  s.required_question_count,
  s.foundational_count,
  s.application_count,
  s.scenario_count

having
  count(distinct q.domain) = 1

  and count(q.id) =
      s.required_question_count

  and count(q.id) filter (
        where q.difficulty = 'foundational'
      ) =
      s.foundational_count

  and count(q.id) filter (
        where q.difficulty = 'application'
      ) =
      s.application_count

  and count(q.id) filter (
        where q.difficulty = 'scenario'
      ) =
      s.scenario_count

  and not exists (
    select 1
    from public.assessment_blueprint_rules abr
    where abr.assessment_id = a.id
  );
