-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0063_master_competency_assessment_standards.sql
--
-- Establishes production assessment-content standards by Master Competency
-- and proficiency target level.
--
-- Initial production batch:
--   Client Training                 L3 — 20 questions
--   Coaching & Development          L4 — 20 questions
--   Cross-Department Coordination   L3 — 20 questions
--   Team Leadership                 L4 — 20 questions
--
-- Question mix becomes increasingly application/scenario based as proficiency
-- expectations increase.
-- ============================================================================

create table if not exists public.master_competency_assessment_standards (
  id uuid primary key default gen_random_uuid(),

  master_competency_template_id uuid not null
    references public.master_competency_templates(id)
    on delete cascade,

  target_level integer not null
    check (target_level between 1 and 4),

  required_question_count integer not null
    check (required_question_count > 0),

  foundational_count integer not null default 0
    check (foundational_count >= 0),

  application_count integer not null default 0
    check (application_count >= 0),

  scenario_count integer not null default 0
    check (scenario_count >= 0),

  version integer not null default 1,

  is_current boolean not null default true,

  created_at timestamptz not null default now(),

  constraint master_competency_assessment_standards_count_check
    check (
      foundational_count
      + application_count
      + scenario_count
      = required_question_count
    )
);

create unique index if not exists
  uq_master_competency_assessment_standards_current
on public.master_competency_assessment_standards (
  master_competency_template_id,
  target_level
)
where is_current = true;


-- --------------------------------------------------------------------------
-- Batch 1 production standards
-- --------------------------------------------------------------------------

insert into public.master_competency_assessment_standards (
  master_competency_template_id,
  target_level,
  required_question_count,
  foundational_count,
  application_count,
  scenario_count
)
values

  (
    'd560aef6-3b56-4af0-a936-9b36ee457113',
    3,
    20,
    4,
    7,
    9
  ),

  (
    '4561c874-e2d4-4893-b09b-43ad1e2be929',
    4,
    20,
    3,
    7,
    10
  ),

  (
    '53386515-b536-4c8e-8a89-d1ff275e6121',
    3,
    20,
    4,
    7,
    9
  ),

  (
    'a351def3-cb03-4261-99eb-8ec43fb5d426',
    4,
    20,
    3,
    7,
    10
  )

on conflict (
  master_competency_template_id,
  target_level
)
where is_current = true

do update set
  required_question_count = excluded.required_question_count,
  foundational_count = excluded.foundational_count,
  application_count = excluded.application_count,
  scenario_count = excluded.scenario_count;
