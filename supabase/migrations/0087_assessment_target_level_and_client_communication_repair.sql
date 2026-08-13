-- ============================================================================
-- 0087_assessment_target_level_and_client_communication_repair.sql
--
-- Corrective migration:
--
-- 1. Adds explicit target_level to assessments.
-- 2. Backfills existing Master competency assessment target levels from the
--    actual production difficulty mix.
-- 3. Removes 20 contaminated Client Communication assessment snapshots and
--    their duplicated/incorrect Master Question records.
-- 4. Preserves the one legitimate existing Client Communication question.
-- 5. Hardens coverage so assessments are evaluated against their declared
--    authored target level instead of the highest level required by any role.
--
-- No attempt history is lost: the contaminated snapshot rows were verified
-- to have zero references from attempt_answers and attempt_question_selections.
-- ============================================================================


-- ============================================================================
-- 1. ADD EXPLICIT ASSESSMENT TARGET LEVEL
-- ============================================================================

alter table public.assessments
add column if not exists target_level integer;


do $$
begin

  if not exists (
    select 1
    from pg_constraint
    where conname = 'assessments_target_level_check'
      and conrelid = 'public.assessments'::regclass
  ) then

    alter table public.assessments

    add constraint assessments_target_level_check

    check (
      target_level is null
      or target_level between 1 and 4
    );

  end if;

end;
$$;


comment on column public.assessments.target_level is
'Optional authored proficiency level for Master competency assessments. Used for level-specific production standards and assessment selection.';


create index if not exists
  assessments_master_competency_target_level_idx

on public.assessments (
  master_competency_template_id,
  target_level
)

where
  client_id is null
  and is_current = true
  and type = 'competency';


-- ============================================================================
-- 2. BACKFILL TARGET LEVEL FROM ACTUAL PRODUCTION DIFFICULTY MIX
--
-- Level 1 = 8 / 8 / 4
-- Level 2 = 5 / 9 / 6
-- Level 3 = 4 / 7 / 9
-- Level 4 = 3 / 7 / 10
--
-- Only exact 20-question Master-backed banks are classified.
-- ============================================================================

with metrics as (

  select
    a.id as assessment_id,

    count(distinct q.id)::integer as question_count,

    count(distinct q.id) filter (
      where q.difficulty = 'foundational'
    )::integer as foundational_count,

    count(distinct q.id) filter (
      where q.difficulty = 'application'
    )::integer as application_count,

    count(distinct q.id) filter (
      where q.difficulty = 'scenario'
    )::integer as scenario_count

  from public.assessments a

  left join public.assessment_questions q
    on q.assessment_id = a.id
   and q.source_master_question_id is not null

  where
    a.client_id is null
    and a.is_current = true
    and a.type = 'competency'

  group by
    a.id

),

classified as (

  select
    assessment_id,

    case

      when question_count = 20
       and foundational_count = 8
       and application_count = 8
       and scenario_count = 4
        then 1

      when question_count = 20
       and foundational_count = 5
       and application_count = 9
       and scenario_count = 6
        then 2

      when question_count = 20
       and foundational_count = 4
       and application_count = 7
       and scenario_count = 9
        then 3

      when question_count = 20
       and foundational_count = 3
       and application_count = 7
       and scenario_count = 10
        then 4

      else null

    end as inferred_target_level

  from metrics

)

update public.assessments a

set target_level = c.inferred_target_level

from classified c

where a.id = c.assessment_id
  and a.target_level is null
  and c.inferred_target_level is not null;


-- ============================================================================
-- 3. CLIENT COMMUNICATION CONTAMINATION SAFETY ASSERTION
-- ============================================================================

do $$
declare
  v_bad_snapshot_count integer;
  v_attempt_answer_refs integer;
  v_attempt_selection_refs integer;
begin

  select count(*)
  into v_bad_snapshot_count
  from public.assessment_questions aq
  where aq.assessment_id =
    'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid
    and aq.sort_order between 1 and 20;

  if v_bad_snapshot_count <> 20 then
    raise exception
      'Expected 20 contaminated Client Communication snapshots, found %',
      v_bad_snapshot_count;
  end if;


  select count(*)
  into v_attempt_answer_refs
  from public.attempt_answers aa
  where aa.question_id in (
    select aq.id
    from public.assessment_questions aq
    where aq.assessment_id =
      'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid
      and aq.sort_order between 1 and 20
  );

  if v_attempt_answer_refs <> 0 then
    raise exception
      'Contaminated Client Communication snapshots have % attempt answer references',
      v_attempt_answer_refs;
  end if;


  select count(*)
  into v_attempt_selection_refs
  from public.attempt_question_selections aqs
  where aqs.question_id in (
    select aq.id
    from public.assessment_questions aq
    where aq.assessment_id =
      'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid
      and aq.sort_order between 1 and 20
  );

  if v_attempt_selection_refs <> 0 then
    raise exception
      'Contaminated Client Communication snapshots have % attempt selection references',
      v_attempt_selection_refs;
  end if;

end;
$$;


-- ============================================================================
-- 4. CAPTURE CONTAMINATED MASTER QUESTION IDS
-- ============================================================================

create temporary table tmp_bad_client_communication_questions
on commit drop
as

select
  aq.id as assessment_question_id,
  aq.source_master_question_id as master_question_id

from public.assessment_questions aq

where aq.assessment_id =
  'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid

  and aq.sort_order between 1 and 20;


-- ============================================================================
-- 5. DELETE CONTAMINATED ASSESSMENT SNAPSHOT ANSWER KEYS
-- ============================================================================

delete from public.assessment_question_answer_keys k

using tmp_bad_client_communication_questions bad

where k.question_id = bad.assessment_question_id;


-- ============================================================================
-- 6. DELETE CONTAMINATED ASSESSMENT SNAPSHOTS
-- ============================================================================

delete from public.assessment_questions aq

using tmp_bad_client_communication_questions bad

where aq.id = bad.assessment_question_id;


-- ============================================================================
-- 7. DELETE CONTAMINATED MASTER QUESTION ROLE APPLICABILITY
-- ============================================================================

delete from public.master_question_role_applicability mra

using tmp_bad_client_communication_questions bad

where mra.master_question_id = bad.master_question_id;


-- ============================================================================
-- 8. DELETE CONTAMINATED MASTER QUESTION ANSWER KEYS
-- ============================================================================

delete from public.master_question_answer_keys mak

using tmp_bad_client_communication_questions bad

where mak.master_question_id = bad.master_question_id;


-- ============================================================================
-- 9. DELETE CONTAMINATED MASTER QUESTIONS
--
-- These were duplicated Cross-Department Coordination prompts incorrectly
-- created under Client Communication. Correct originals already exist under
-- Cross-Department Coordination.
-- ============================================================================

delete from public.master_question_bank mq

using tmp_bad_client_communication_questions bad

where mq.id = bad.master_question_id;


-- ============================================================================
-- 10. PRESERVE / CLASSIFY CLIENT COMMUNICATION ASSESSMENT
--
-- It now contains only its one legitimate historical question.
-- The full L3 production bank will be rebuilt in a later content migration.
-- ============================================================================

update public.assessments

set target_level = 3

where id =
  'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid;


-- ============================================================================
-- 11. LEVEL-AWARE COVERAGE
--
-- Each current Master competency assessment is judged against the standard
-- matching its own declared target_level.
--
-- The function still returns one row per competency. Candidate ranking prefers:
--
--   1. production-ready assessment
--   2. declared target level
--   3. complete answer keys
--   4. more Master-backed questions
--   5. higher target level
--   6. newer assessment version
--
-- This avoids guessing from the highest role requirement.
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

candidate_assessments as (

  select
    c.id as competency_id,

    a.id as assessment_id,
    a.family_id as assessment_family_id,
    a.name as assessment_name,
    a.version,
    a.target_level

  from current_competencies c

  join public.assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.master_competency_template_id = c.id
   and a.industry_id = c.industry_id

),

candidate_metrics as (

  select
    ca.competency_id,
    ca.assessment_id,
    ca.assessment_family_id,
    ca.assessment_name,
    ca.version,
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
    ca.version,
    ca.target_level

),

candidate_with_standard as (

  select
    cm.*,

    s.required_question_count,
    s.foundational_count
      as required_foundational_count,
    s.application_count
      as required_application_count,
    s.scenario_count
      as required_scenario_count,

    (
      cm.target_level is not null

      and s.id is not null

      and cm.question_count =
          s.required_question_count

      and cm.answer_key_count =
          cm.question_count

      and cm.foundational_count =
          s.foundational_count

      and cm.application_count =
          s.application_count

      and cm.scenario_count =
          s.scenario_count

    ) as production_ready

  from candidate_metrics cm

  left join public.master_competency_assessment_standards s
    on s.master_competency_template_id =
         cm.competency_id
   and s.target_level =
         cm.target_level
   and s.is_current = true

),

ranked_candidates as (

  select
    cws.*,

    row_number() over (

      partition by cws.competency_id

      order by

        cws.production_ready desc,

        (cws.target_level is not null) desc,

        (
          cws.question_count > 0
          and cws.answer_key_count =
              cws.question_count
        ) desc,

        cws.question_count desc,

        cws.target_level desc nulls last,

        cws.version desc,

        cws.assessment_name,

        cws.assessment_id

    ) as assessment_rank

  from candidate_with_standard cws

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

    when sa.assessment_id is null
      then 'needs_assessment'

    when sa.target_level is null
      then 'needs_target_level'

    when sa.required_question_count is null
      then 'needs_standard'

    when coalesce(sa.question_count, 0) = 0
      then 'needs_questions'

    when coalesce(sa.answer_key_count, 0)
       < coalesce(sa.question_count, 0)
      then 'needs_answer_keys'

    when sa.question_count <>
         sa.required_question_count
      then 'needs_question_count'

    when
         sa.foundational_count <>
           sa.required_foundational_count

      or sa.application_count <>
           sa.required_application_count

      or sa.scenario_count <>
           sa.required_scenario_count

      then 'needs_difficulty_mix'

    else 'ready'

  end as coverage_status,

  coalesce(sa.production_ready, false)
    as assessment_ready

from current_competencies c

left join selected_assessments sa
  on sa.competency_id = c.id

where
  public.wri_is_integrateu_admin()

order by
  c.category nulls last,
  c.name;

$function$;


-- ============================================================================
-- 12. VERIFICATION — CLIENT COMMUNICATION REPAIR
-- ============================================================================

select
  a.id as assessment_id,
  a.name,
  a.target_level,

  count(aq.id) as question_count,

  count(*) filter (
    where aq.difficulty = 'foundational'
  ) as foundational_count,

  count(*) filter (
    where aq.difficulty = 'application'
  ) as application_count,

  count(*) filter (
    where aq.difficulty = 'scenario'
  ) as scenario_count

from public.assessments a

left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
     a.master_competency_template_id
 and aq.source_master_question_id is not null

where a.id =
  'cb5b2fcb-5028-4fc6-a8bc-416a8dd3fee4'::uuid

group by
  a.id,
  a.name,
  a.target_level;


-- ============================================================================
-- 13. VERIFICATION — TARGET LEVEL BACKFILL
-- ============================================================================

select
  mct.name as competency_name,
  a.name as assessment_name,
  a.target_level,

  count(aq.id) as question_count,

  count(*) filter (
    where aq.difficulty = 'foundational'
  ) as foundational_count,

  count(*) filter (
    where aq.difficulty = 'application'
  ) as application_count,

  count(*) filter (
    where aq.difficulty = 'scenario'
  ) as scenario_count

from public.assessments a

join public.master_competency_templates mct
  on mct.id = a.master_competency_template_id

left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id = mct.id
 and aq.source_master_question_id is not null

where
  a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.target_level is not null

group by
  mct.name,
  a.id,
  a.name,
  a.target_level

order by
  mct.name,
  a.name;


-- ============================================================================
-- 14. VERIFICATION — CONTAMINATED MASTER QUESTIONS REMOVED
-- ============================================================================

select
  count(*) as remaining_contaminated_client_communication_questions

from public.master_question_bank mq

where mq.master_competency_template_id =
  '442b0afc-48ee-44ef-a46c-f9bfbbd6ec9b'::uuid

  and mq.prompt in (

    'What is the primary purpose of cross-department coordination?',
    'What is a handoff between departments?',
    'Why are clear handoff expectations important?'

  );
