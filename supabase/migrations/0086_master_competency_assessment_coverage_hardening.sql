-- ============================================================================
-- 0086_master_competency_assessment_coverage_hardening.sql
--
-- Hardens Master Competency assessment production standards and coverage.
--
-- Production question-bank standards:
--
--   Level 1 = 20 questions
--             8 foundational
--             8 application
--             4 scenario
--
--   Level 2 = 20 questions
--             5 foundational
--             9 application
--             6 scenario
--
--   Level 3 = 20 questions
--             4 foundational
--             7 application
--             9 scenario
--
--   Level 4 = 20 questions
--             3 foundational
--             7 application
--            10 scenario
--
-- Standards are seeded for each competency / target-level combination
-- currently required by a current Master Role.
--
-- Coverage evaluates each competency against the highest target level
-- currently required by any current Master Role.
--
-- A production-ready assessment must have:
--   - the required total question count
--   - complete answer-key coverage
--   - the exact required difficulty mix
--   - Master Question-backed assessment questions
--
-- Existing function signature is intentionally preserved.
-- ============================================================================


-- ============================================================================
-- 1. SEED MISSING CURRENT ASSESSMENT STANDARDS
-- ============================================================================

with required_levels as (

  select distinct
    mrcr.master_competency_template_id,
    mrcr.required_level as target_level

  from public.master_role_competency_requirements mrcr

  join public.master_role_templates mrt
    on mrt.id = mrcr.master_role_template_id
   and mrt.is_current = true
   and mrt.status = 'active'

  join public.master_competency_templates mct
    on mct.id = mrcr.master_competency_template_id
   and mct.is_current = true
   and mct.status = 'active'

),

standard_values as (

  select
    rl.master_competency_template_id,
    rl.target_level,

    20::integer as required_question_count,

    case rl.target_level
      when 1 then 8
      when 2 then 5
      when 3 then 4
      when 4 then 3
    end::integer as foundational_count,

    case rl.target_level
      when 1 then 8
      when 2 then 9
      when 3 then 7
      when 4 then 7
    end::integer as application_count,

    case rl.target_level
      when 1 then 4
      when 2 then 6
      when 3 then 9
      when 4 then 10
    end::integer as scenario_count

  from required_levels rl

  where rl.target_level between 1 and 4

)

insert into public.master_competency_assessment_standards (
  master_competency_template_id,
  target_level,
  required_question_count,
  foundational_count,
  application_count,
  scenario_count,
  is_current
)

select
  sv.master_competency_template_id,
  sv.target_level,
  sv.required_question_count,
  sv.foundational_count,
  sv.application_count,
  sv.scenario_count,
  true

from standard_values sv

where not exists (

  select 1

  from public.master_competency_assessment_standards existing

  where existing.master_competency_template_id =
          sv.master_competency_template_id

    and existing.target_level =
          sv.target_level

    and existing.is_current = true

);


-- ============================================================================
-- 2. VALIDATE CURRENT STANDARDS AGAINST THE PRODUCTION CONVENTION
--
-- Do not silently rewrite pre-existing standards.
-- Fail the migration if a current role-required standard conflicts with
-- the production convention.
-- ============================================================================

do $$
declare
  v_invalid_count integer;
begin

  with required_levels as (

    select distinct
      mrcr.master_competency_template_id,
      mrcr.required_level as target_level

    from public.master_role_competency_requirements mrcr

    join public.master_role_templates mrt
      on mrt.id = mrcr.master_role_template_id
     and mrt.is_current = true
     and mrt.status = 'active'

    join public.master_competency_templates mct
      on mct.id = mrcr.master_competency_template_id
     and mct.is_current = true
     and mct.status = 'active'

  )

  select count(*)
  into v_invalid_count

  from required_levels rl

  left join public.master_competency_assessment_standards s
    on s.master_competency_template_id =
         rl.master_competency_template_id
   and s.target_level = rl.target_level
   and s.is_current = true

  where
       s.id is null

    or s.required_question_count <> 20

    or s.foundational_count <>
       case rl.target_level
         when 1 then 8
         when 2 then 5
         when 3 then 4
         when 4 then 3
       end

    or s.application_count <>
       case rl.target_level
         when 1 then 8
         when 2 then 9
         when 3 then 7
         when 4 then 7
       end

    or s.scenario_count <>
       case rl.target_level
         when 1 then 4
         when 2 then 6
         when 3 then 9
         when 4 then 10
       end;

  if v_invalid_count <> 0 then

    raise exception
      'Found % role-required competency standards that do not match the production convention',
      v_invalid_count;

  end if;

end;
$$;


-- ============================================================================
-- 3. HARDEN MASTER COMPETENCY ASSESSMENT COVERAGE
--
-- Existing return signature is preserved:
--
--   master_competency_template_id
--   industry_id
--   competency_name
--   competency_category
--   assessment_id
--   assessment_family_id
--   assessment_name
--   question_count
--   answer_key_count
--   coverage_status
--   assessment_ready
--
-- Coverage status values:
--
--   needs_standard
--   needs_assessment
--   needs_questions
--   needs_answer_keys
--   needs_question_count
--   needs_difficulty_mix
--   ready
-- ============================================================================

create or replace function
public.wri_master_competency_assessment_coverage()

returns table (

  master_competency_template_id uuid,
  industry_id uuid,
  competency_name text,
  competency_category text,

  assessment_id uuid,
  assessment_family_id uuid,
  assessment_name text,

  question_count integer,
  answer_key_count integer,

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

  where c.is_current = true

),


-- --------------------------------------------------------------------------
-- Highest target level currently required by a current Master Role.
-- --------------------------------------------------------------------------

highest_role_requirement as (

  select
    mrcr.master_competency_template_id as competency_id,
    max(mrcr.required_level)::integer as target_level

  from public.master_role_competency_requirements mrcr

  join public.master_role_templates mrt
    on mrt.id = mrcr.master_role_template_id
   and mrt.is_current = true
   and mrt.status = 'active'

  group by
    mrcr.master_competency_template_id

),


-- --------------------------------------------------------------------------
-- Production standard used by the coverage dashboard.
-- --------------------------------------------------------------------------

coverage_standard as (

  select
    c.id as competency_id,

    hrr.target_level,

    s.required_question_count,
    s.foundational_count,
    s.application_count,
    s.scenario_count

  from current_competencies c

  left join highest_role_requirement hrr
    on hrr.competency_id = c.id

  left join public.master_competency_assessment_standards s
    on s.master_competency_template_id = c.id
   and s.target_level = hrr.target_level
   and s.is_current = true

),


-- --------------------------------------------------------------------------
-- Every current Master assessment candidate for the competency.
-- --------------------------------------------------------------------------

candidate_assessments as (

  select
    c.id as competency_id,

    a.id as assessment_id,
    a.family_id as assessment_family_id,
    a.name as assessment_name,
    a.version

  from current_competencies c

  join public.assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.master_competency_template_id = c.id
   and a.industry_id = c.industry_id

),


-- --------------------------------------------------------------------------
-- Count Master-backed questions, answer keys, and production difficulty mix
-- for every candidate assessment.
-- --------------------------------------------------------------------------

candidate_metrics as (

  select
    ca.competency_id,
    ca.assessment_id,
    ca.assessment_family_id,
    ca.assessment_name,
    ca.version,

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

  from candidate_assessments ca

  left join public.assessment_questions q
    on q.assessment_id = ca.assessment_id
   and q.master_competency_template_id =
       ca.competency_id
   and q.source_master_question_id is not null

  left join public.assessment_question_answer_keys k
    on k.question_id = q.id

  group by
    ca.competency_id,
    ca.assessment_id,
    ca.assessment_family_id,
    ca.assessment_name,
    ca.version

),


-- --------------------------------------------------------------------------
-- Rank candidates by actual production usability.
--
-- 1. Exact production-ready assessment first.
-- 2. Complete answer-key coverage.
-- 3. Larger Master-backed question bank.
-- 4. Newer version.
-- 5. Stable name/id ordering.
-- --------------------------------------------------------------------------

ranked_candidates as (

  select
    cm.*,

    cs.required_question_count,
    cs.foundational_count
      as required_foundational_count,
    cs.application_count
      as required_application_count,
    cs.scenario_count
      as required_scenario_count,

    (
      cs.required_question_count is not null

      and cm.question_count =
          cs.required_question_count

      and cm.answer_key_count =
          cm.question_count

      and cm.foundational_count =
          cs.foundational_count

      and cm.application_count =
          cs.application_count

      and cm.scenario_count =
          cs.scenario_count

    ) as production_ready,

    row_number() over (

      partition by cm.competency_id

      order by

        (
          cs.required_question_count is not null

          and cm.question_count =
              cs.required_question_count

          and cm.answer_key_count =
              cm.question_count

          and cm.foundational_count =
              cs.foundational_count

          and cm.application_count =
              cs.application_count

          and cm.scenario_count =
              cs.scenario_count

        ) desc,

        (
          cm.question_count > 0
          and cm.answer_key_count =
              cm.question_count
        ) desc,

        cm.question_count desc,

        cm.version desc,

        cm.assessment_name,

        cm.assessment_id

    ) as assessment_rank

  from candidate_metrics cm

  left join coverage_standard cs
    on cs.competency_id = cm.competency_id

),


selected_assessments as (

  select *
  from ranked_candidates
  where assessment_rank = 1

)


select
  c.id as master_competency_template_id,
  c.industry_id,
  c.name as competency_name,
  c.category as competency_category,

  sa.assessment_id,
  sa.assessment_family_id,
  sa.assessment_name,

  coalesce(sa.question_count, 0)::integer
    as question_count,

  coalesce(sa.answer_key_count, 0)::integer
    as answer_key_count,

  case

    when cs.required_question_count is null
      then 'needs_standard'

    when sa.assessment_id is null
      then 'needs_assessment'

    when coalesce(sa.question_count, 0) = 0
      then 'needs_questions'

    when coalesce(sa.answer_key_count, 0)
       < coalesce(sa.question_count, 0)
      then 'needs_answer_keys'

    when sa.question_count <>
         cs.required_question_count
      then 'needs_question_count'

    when
         sa.foundational_count <>
           cs.foundational_count

      or sa.application_count <>
           cs.application_count

      or sa.scenario_count <>
           cs.scenario_count

      then 'needs_difficulty_mix'

    else 'ready'

  end as coverage_status,

  (
       cs.required_question_count is not null

   and sa.assessment_id is not null

   and sa.question_count =
       cs.required_question_count

   and sa.answer_key_count =
       sa.question_count

   and sa.foundational_count =
       cs.foundational_count

   and sa.application_count =
       cs.application_count

   and sa.scenario_count =
       cs.scenario_count

  ) as assessment_ready

from current_competencies c

left join coverage_standard cs
  on cs.competency_id = c.id

left join selected_assessments sa
  on sa.competency_id = c.id

where
  public.wri_is_integrateu_admin()

order by
  c.category nulls last,
  c.name;

$function$;


-- ============================================================================
-- 4. VERIFICATION — STANDARD COVERAGE BY INDUSTRY
-- ============================================================================

with highest_required as (

  select
    mrcr.master_competency_template_id,
    max(mrcr.required_level)::integer as highest_required_level

  from public.master_role_competency_requirements mrcr

  join public.master_role_templates mrt
    on mrt.id = mrcr.master_role_template_id
   and mrt.is_current = true
   and mrt.status = 'active'

  group by
    mrcr.master_competency_template_id

)

select
  i.name as industry_name,

  count(*) as role_required_competencies,

  count(*) filter (
    where s.id is not null
  ) as competencies_with_current_standard,

  count(*) filter (
    where s.id is null
  ) as competencies_missing_current_standard

from highest_required hr

join public.master_competency_templates mct
  on mct.id = hr.master_competency_template_id
 and mct.is_current = true

join public.industries i
  on i.id = mct.industry_id

left join public.master_competency_assessment_standards s
  on s.master_competency_template_id = mct.id
 and s.target_level = hr.highest_required_level
 and s.is_current = true

group by
  i.id,
  i.name

order by
  i.name;


-- ============================================================================
-- 5. VERIFICATION — CURRENT STANDARD DISTRIBUTION
-- ============================================================================

select
  i.name as industry_name,
  s.target_level,
  count(*) as standard_count

from public.master_competency_assessment_standards s

join public.master_competency_templates mct
  on mct.id = s.master_competency_template_id
 and mct.is_current = true

join public.industries i
  on i.id = mct.industry_id

where s.is_current = true

group by
  i.name,
  s.target_level

order by
  i.name,
  s.target_level;


-- ============================================================================
-- 6. VERIFICATION — FUNCTION DEFINITION EXISTS
-- ============================================================================

select
  p.proname as function_name,
  pg_get_function_result(p.oid) as return_type

from pg_proc p

join pg_namespace n
  on n.oid = p.pronamespace

where n.nspname = 'public'
  and p.proname =
      'wri_master_competency_assessment_coverage';

