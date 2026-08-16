-- ============================================================================
-- 0148_master_competency_assessment_level_coverage.sql
--
-- Adds a level-aware Master competency assessment coverage RPC.
--
-- Unlike wri_master_competency_assessment_coverage(), which intentionally
-- returns one representative assessment row per competency, this function
-- returns one row per current Master competency assessment target level.
--
-- This allows the Master Library UI to expose every current L1/L2/L3/L4
-- assessment independently without changing the existing summary RPC.
-- ============================================================================


create or replace function
public.wri_master_competency_assessment_level_coverage()

returns table (

  master_competency_template_id uuid,
  industry_id uuid,
  competency_name text,
  competency_category text,

  assessment_id uuid,
  assessment_family_id uuid,
  assessment_name text,
  target_level integer,

  question_count integer,
  answer_key_count integer,

  foundational_count integer,
  application_count integer,
  scenario_count integer,

  required_question_count integer,
  required_foundational_count integer,
  required_application_count integer,
  required_scenario_count integer,

  coverage_status text,
  assessment_ready boolean

)

language sql

security definer

set search_path to 'public'

as $function$

with current_competencies as (

  select
    c.id,
    c.industry_id,
    c.name,
    c.category

  from public.master_competency_templates c

  where
    c.is_current = true
    and c.status = 'active'

),

current_assessments as (

  select
    c.id as competency_id,
    c.industry_id,
    c.name as competency_name,
    c.category as competency_category,

    a.id as assessment_id,
    a.family_id as assessment_family_id,
    a.name as assessment_name,
    a.target_level

  from current_competencies c

  join public.assessments a
    on a.master_competency_template_id = c.id
   and a.industry_id = c.industry_id
   and a.client_id is null
   and a.is_current = true
   and a.type = 'competency'

),

assessment_metrics as (

  select
    ca.competency_id,
    ca.industry_id,
    ca.competency_name,
    ca.competency_category,

    ca.assessment_id,
    ca.assessment_family_id,
    ca.assessment_name,
    ca.target_level,

    count(distinct q.id)::integer
      as question_count,

    count(distinct k.question_id)::integer
      as answer_key_count,

    count(distinct q.id) filter (
      where q.difficulty = 'foundational'
    )::integer
      as foundational_count,

    count(distinct q.id) filter (
      where q.difficulty = 'application'
    )::integer
      as application_count,

    count(distinct q.id) filter (
      where q.difficulty = 'scenario'
    )::integer
      as scenario_count

  from current_assessments ca

  left join public.assessment_questions q
    on q.assessment_id = ca.assessment_id
   and q.master_competency_template_id = ca.competency_id
   and q.source_master_question_id is not null

  left join public.assessment_question_answer_keys k
    on k.question_id = q.id

  group by
    ca.competency_id,
    ca.industry_id,
    ca.competency_name,
    ca.competency_category,
    ca.assessment_id,
    ca.assessment_family_id,
    ca.assessment_name,
    ca.target_level

),

with_standard as (

  select
    am.*,

    s.required_question_count,

    s.foundational_count
      as required_foundational_count,

    s.application_count
      as required_application_count,

    s.scenario_count
      as required_scenario_count

  from assessment_metrics am

  left join public.master_competency_assessment_standards s
    on s.master_competency_template_id = am.competency_id
   and s.target_level = am.target_level
   and s.is_current = true

)

select
  ws.competency_id
    as master_competency_template_id,

  ws.industry_id,
  ws.competency_name,
  ws.competency_category,

  ws.assessment_id,
  ws.assessment_family_id,
  ws.assessment_name,
  ws.target_level,

  ws.question_count,
  ws.answer_key_count,

  ws.foundational_count,
  ws.application_count,
  ws.scenario_count,

  ws.required_question_count,
  ws.required_foundational_count,
  ws.required_application_count,
  ws.required_scenario_count,

  case

    when ws.target_level is null
      then 'needs_target_level'

    when ws.required_question_count is null
      then 'needs_standard'

    when ws.question_count = 0
      then 'needs_questions'

    when ws.answer_key_count < ws.question_count
      then 'needs_answer_keys'

    when ws.question_count <> ws.required_question_count
      then 'needs_question_count'

    when
         ws.foundational_count <> ws.required_foundational_count
      or ws.application_count <> ws.required_application_count
      or ws.scenario_count <> ws.required_scenario_count
      then 'needs_difficulty_mix'

    else 'ready'

  end as coverage_status,

  (
       ws.target_level is not null

   and ws.required_question_count is not null

   and ws.question_count =
       ws.required_question_count

   and ws.answer_key_count =
       ws.question_count

   and ws.foundational_count =
       ws.required_foundational_count

   and ws.application_count =
       ws.required_application_count

   and ws.scenario_count =
       ws.required_scenario_count

  ) as assessment_ready

from with_standard ws

where
  public.wri_is_integrateu_admin()

order by
  ws.industry_id,
  ws.competency_category nulls last,
  ws.competency_name,
  ws.target_level nulls last,
  ws.assessment_name;

$function$;


revoke all
on function public.wri_master_competency_assessment_level_coverage()
from public;


grant execute
on function public.wri_master_competency_assessment_level_coverage()
to authenticated;


-- ============================================================================
-- VERIFICATION
-- ============================================================================

select
  competency_name,
  target_level,
  assessment_name,
  question_count,
  answer_key_count,
  foundational_count,
  application_count,
  scenario_count,
  coverage_status,
  assessment_ready

from public.wri_master_competency_assessment_level_coverage()

where competency_name =
  'Airflow, Static Pressure & Ventilation'

order by target_level;
