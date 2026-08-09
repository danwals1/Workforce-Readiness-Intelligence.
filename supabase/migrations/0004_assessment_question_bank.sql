-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0004_assessment_question_bank.sql
--
-- PURPOSE
-- Adds the reusable IntegrateU Master Question Bank and assessment blueprint
-- architecture without replacing the assessment engine already installed.
--
-- EXISTING TABLES REUSED:
--   assessments
--   assessment_questions
--   assessment_question_answer_keys
--   assessment_attempts
--   attempt_answers
--   competency_scores
--
-- NEW CAPABILITIES:
--   - Versioned reusable master question bank
--   - Secure master answer keys
--   - Role applicability
--   - Assessment blueprint/domain rules
--   - Assessment-specific copies linked back to master questions
--   - Difficulty / critical-safety / practical-verification metadata
--   - Per-attempt question selection snapshots
--
-- No existing rows are deleted or replaced.
-- ============================================================================


-- ============================================================================
-- 1. MASTER QUESTION BANK
-- ============================================================================

create table if not exists master_question_bank (
  id uuid primary key default gen_random_uuid(),

  family_id uuid,
  version int not null default 1,

  is_current boolean not null default true,

  superseded_by uuid
    references master_question_bank(id),

  published_at timestamptz not null default now(),
  published_by uuid,

  industry_id uuid not null
    references industries(id),

  master_competency_template_id uuid not null
    references master_competency_templates(id),

  domain text not null,

  type text not null
    check (
      type in (
        'multiple_choice',
        'multiple_select',
        'scenario',
        'image_based',
        'troubleshooting',
        'situational_judgment'
      )
    ),

  difficulty text not null
    check (
      difficulty in (
        'foundational',
        'application',
        'scenario'
      )
    ),

  prompt text not null,

  scenario text,

  image_url text,

  options jsonb not null,

  points numeric not null default 1
    check (points > 0),

  critical_safety boolean not null default false,

  practical_verification_required boolean not null default false,

  status text not null default 'draft'
    check (
      status in (
        'draft',
        'approved',
        'retired'
      )
    ),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);


-- Automatically establish the family on the first version.
drop trigger if exists trg_master_question_family
  on master_question_bank;

create trigger trg_master_question_family
before insert on master_question_bank
for each row
execute function wri_default_family_id();


drop trigger if exists trg_master_question_updated_at
  on master_question_bank;

create trigger trg_master_question_updated_at
before update on master_question_bank
for each row
execute function wri_set_updated_at();


create unique index if not exists uq_master_question_family_version
  on master_question_bank (family_id, version);


-- Only one current version may exist within a question family.
create unique index if not exists uq_master_question_current
  on master_question_bank (family_id)
  where is_current;


create index if not exists ix_master_question_industry
  on master_question_bank (industry_id);


create index if not exists ix_master_question_competency
  on master_question_bank (master_competency_template_id);


create index if not exists ix_master_question_domain
  on master_question_bank (domain);


create index if not exists ix_master_question_status
  on master_question_bank (status);


create index if not exists ix_master_question_difficulty
  on master_question_bank (difficulty);



-- ============================================================================
-- 2. MASTER QUESTION BANK RLS
-- ============================================================================

alter table master_question_bank
enable row level security;


drop policy if exists master_question_admin_all
  on master_question_bank;

create policy master_question_admin_all
on master_question_bank
for all
using (
  wri_is_integrateu_admin()
)
with check (
  wri_is_integrateu_admin()
);



-- ============================================================================
-- 3. SECURE MASTER QUESTION ANSWER KEYS
--
-- Correct answers deliberately remain separate from question content.
-- Only IntegrateU admins may directly access this table.
-- ============================================================================

create table if not exists master_question_answer_keys (
  id uuid primary key default gen_random_uuid(),

  master_question_id uuid not null unique
    references master_question_bank(id)
    on delete cascade,

  correct_answer jsonb not null,

  scoring_notes text,

  rationale text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);


drop trigger if exists trg_master_answer_key_updated_at
  on master_question_answer_keys;

create trigger trg_master_answer_key_updated_at
before update on master_question_answer_keys
for each row
execute function wri_set_updated_at();


alter table master_question_answer_keys
enable row level security;


drop policy if exists master_answer_key_admin_all
  on master_question_answer_keys;

create policy master_answer_key_admin_all
on master_question_answer_keys
for all
using (
  wri_is_integrateu_admin()
)
with check (
  wri_is_integrateu_admin()
);


revoke all
on master_question_answer_keys
from authenticated, anon;


grant select, insert, update, delete
on master_question_answer_keys
to authenticated;



-- ============================================================================
-- 4. QUESTION → MASTER ROLE APPLICABILITY
--
-- A reusable question may be appropriate for more than one role.
-- Example:
--   Cable testing may apply to Technician I, II, III and Service Technician.
-- ============================================================================

create table if not exists master_question_role_applicability (
  id uuid primary key default gen_random_uuid(),

  master_question_id uuid not null
    references master_question_bank(id)
    on delete cascade,

  master_role_template_id uuid not null
    references master_role_templates(id)
    on delete cascade,

  created_at timestamptz not null default now(),

  unique (
    master_question_id,
    master_role_template_id
  )
);


create index if not exists ix_mqra_role
  on master_question_role_applicability (
    master_role_template_id
  );


create index if not exists ix_mqra_question
  on master_question_role_applicability (
    master_question_id
  );


alter table master_question_role_applicability
enable row level security;


drop policy if exists mqra_admin_all
  on master_question_role_applicability;

create policy mqra_admin_all
on master_question_role_applicability
for all
using (
  wri_is_integrateu_admin()
)
with check (
  wri_is_integrateu_admin()
);



-- ============================================================================
-- 5. EXTEND EXISTING ASSESSMENT QUESTIONS
--
-- assessment_questions remains the actual assessment-specific question table.
--
-- A row can now optionally identify the reusable Master Question it originated
-- from while retaining its own copy of the prompt/options. This gives an
-- assessment historical stability even if the master question changes later.
-- ============================================================================

alter table assessment_questions
add column if not exists source_master_question_id uuid
references master_question_bank(id);


alter table assessment_questions
add column if not exists domain text;


alter table assessment_questions
add column if not exists difficulty text;


alter table assessment_questions
add column if not exists critical_safety boolean
not null default false;


alter table assessment_questions
add column if not exists practical_verification_required boolean
not null default false;


-- Existing questions may have NULL difficulty because they predate this
-- architecture. New Master Question copies will always populate it.
do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'assessment_questions_difficulty_check'
  ) then

    alter table assessment_questions
    add constraint assessment_questions_difficulty_check
    check (
      difficulty is null
      or difficulty in (
        'foundational',
        'application',
        'scenario'
      )
    );

  end if;
end $$;


create index if not exists ix_aq_source_master_question
  on assessment_questions (
    source_master_question_id
  );


create index if not exists ix_aq_domain
  on assessment_questions (
    domain
  );


create index if not exists ix_aq_difficulty
  on assessment_questions (
    difficulty
  );



-- ============================================================================
-- 6. ASSESSMENT BLUEPRINT RULES
--
-- Defines the standard composition of an assessment.
--
-- Example Technician I:
--   Safety                         15
--   Low Voltage                    10
--   Cabling                        15
--   ...
--
-- Difficulty counts allow a blueprint to control depth as well as quantity.
-- ============================================================================

create table if not exists assessment_blueprint_rules (
  id uuid primary key default gen_random_uuid(),

  assessment_id uuid not null
    references assessments(id)
    on delete cascade,

  domain text not null,

  master_competency_template_id uuid
    references master_competency_templates(id),

  question_count int not null
    check (question_count > 0),

  foundational_count int not null default 0
    check (foundational_count >= 0),

  application_count int not null default 0
    check (application_count >= 0),

  scenario_count int not null default 0
    check (scenario_count >= 0),

  sort_order int not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  check (
    foundational_count
    + application_count
    + scenario_count
    = question_count
  ),

  unique (
    assessment_id,
    domain,
    master_competency_template_id
  )
);


drop trigger if exists trg_blueprint_updated_at
  on assessment_blueprint_rules;

create trigger trg_blueprint_updated_at
before update on assessment_blueprint_rules
for each row
execute function wri_set_updated_at();


create index if not exists ix_blueprint_assessment
  on assessment_blueprint_rules (
    assessment_id
  );


create index if not exists ix_blueprint_competency
  on assessment_blueprint_rules (
    master_competency_template_id
  );


alter table assessment_blueprint_rules
enable row level security;


drop policy if exists blueprint_select
  on assessment_blueprint_rules;

create policy blueprint_select
on assessment_blueprint_rules
for select
using (
  wri_is_integrateu_admin()
  or exists (
    select 1
    from assessments a
    where a.id = assessment_blueprint_rules.assessment_id
      and (
        a.client_id is null
        or a.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
);


drop policy if exists blueprint_write_admin
  on assessment_blueprint_rules;

create policy blueprint_write_admin
on assessment_blueprint_rules
for all
using (
  wri_is_integrateu_admin()
)
with check (
  wri_is_integrateu_admin()
);



-- ============================================================================
-- 7. ATTEMPT QUESTION SNAPSHOT
--
-- Each attempt receives its own selected question set.
--
-- This is essential for:
--   - randomized assessments
--   - 100-question delivery from a larger question pool
--   - preserving which questions the technician actually received
--   - keeping question order stable after the attempt starts
--
-- attempt_answers continues to reference assessment_questions as it does today.
-- ============================================================================

create table if not exists attempt_question_selections (
  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  attempt_id uuid not null
    references assessment_attempts(id)
    on delete cascade,

  question_id uuid not null
    references assessment_questions(id),

  question_order int not null
    check (question_order > 0),

  created_at timestamptz not null default now(),

  unique (
    attempt_id,
    question_id
  ),

  unique (
    attempt_id,
    question_order
  )
);


drop trigger if exists trg_attempt_question_sync_client
  on attempt_question_selections;

create trigger trg_attempt_question_sync_client
before insert or update
on attempt_question_selections
for each row
execute function wri_sync_client_from_parent(
  'assessment_attempts',
  'attempt_id'
);


create index if not exists ix_attempt_question_attempt
  on attempt_question_selections (
    attempt_id
  );


create index if not exists ix_attempt_question_question
  on attempt_question_selections (
    question_id
  );


alter table attempt_question_selections
enable row level security;


drop policy if exists attempt_question_all
  on attempt_question_selections;

create policy attempt_question_all
on attempt_question_selections
for all
using (
  wri_is_integrateu_admin()
  or client_id in (
    select wri_allowed_client_ids()
  )
)
with check (
  wri_is_integrateu_admin()
  or client_id in (
    select wri_allowed_client_ids()
  )
);



-- ============================================================================
-- 8. RPC — COPY MASTER QUESTION INTO AN ASSESSMENT
--
-- The question and answer key are copied.
--
-- IMPORTANT:
-- This is a COPY, not a live reference.
-- Future edits/version changes in the Master Question Bank do not silently
-- alter already-published assessments.
-- ============================================================================

create or replace function wri_add_master_question_to_assessment(
  p_assessment_id uuid,
  p_master_question_id uuid,
  p_sort_order int default 0
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_assessment assessments;
  v_question master_question_bank;
  v_answer_key master_question_answer_keys;
  v_new_question_id uuid;
begin

  if not wri_is_integrateu_admin() then
    raise exception 'IntegrateU admin access required';
  end if;


  select *
  into v_assessment
  from assessments
  where id = p_assessment_id;


  if not found then
    raise exception 'Assessment not found';
  end if;

if v_assessment.client_id is not null then
  raise exception 'Master questions may only be added directly to template-mode assessments';
end if;


  select *
  into v_question
  from master_question_bank
  where id = p_master_question_id;


  if not found then
    raise exception 'Master question not found';
  end if;


  if not v_question.is_current then
    raise exception 'Only a current master question version may be added';
  end if;


  if v_question.status <> 'approved' then
    raise exception 'Only approved master questions may be added to an assessment';
  end if;


  if v_question.industry_id <> v_assessment.industry_id then
    raise exception 'Question and assessment industry do not match';
  end if;


  select *
  into v_answer_key
  from master_question_answer_keys
  where master_question_id = p_master_question_id;


  if not found then
    raise exception 'Master question has no answer key';
  end if;


  insert into assessment_questions (
    assessment_id,
    master_competency_template_id,
    type,
    prompt,
    scenario,
    image_url,
    options,
    points,
    sort_order,
    source_master_question_id,
    domain,
    difficulty,
    critical_safety,
    practical_verification_required
  )
  values (
    p_assessment_id,
    v_question.master_competency_template_id,
    v_question.type,
    v_question.prompt,
    v_question.scenario,
    v_question.image_url,
    v_question.options,
    v_question.points,
    p_sort_order,
    v_question.id,
    v_question.domain,
    v_question.difficulty,
    v_question.critical_safety,
    v_question.practical_verification_required
  )
  returning id
  into v_new_question_id;


  insert into assessment_question_answer_keys (
    question_id,
    correct_answer,
    scoring_notes
  )
  values (
    v_new_question_id,
    v_answer_key.correct_answer,
    concat_ws(
      E'\n\n',
      v_answer_key.scoring_notes,
      case
        when v_answer_key.rationale is not null
        then 'Rationale: ' || v_answer_key.rationale
        else null
      end
    )
  );


  return v_new_question_id;

end;
$$;



-- ============================================================================
-- 9. RPC — PUBLISH A NEW MASTER QUESTION VERSION
--
-- Publishing creates a new immutable version in the same family.
-- Existing assessments continue to use their copied question snapshot.
-- ============================================================================

create or replace function wri_publish_master_question_version(
  p_master_question_id uuid
)
returns table (
  new_id uuid,
  new_version int
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_old master_question_bank;
  v_old_key master_question_answer_keys;
  v_new_id uuid;
  v_new_version int;
begin

  if not wri_is_integrateu_admin() then
    raise exception 'IntegrateU admin access required';
  end if;


  select *
  into v_old
  from master_question_bank
  where id = p_master_question_id
  for update;


  if not found then
    raise exception 'Master question not found';
  end if;


  if not v_old.is_current then
    raise exception 'Only the current question version may be published';
  end if;


  select *
  into v_old_key
  from master_question_answer_keys
  where master_question_id = p_master_question_id;


  v_new_version := v_old.version + 1;


  -- Release the unique-current position before inserting the replacement.
  update master_question_bank
  set
    is_current = false,
    updated_at = now()
  where id = v_old.id;


  insert into master_question_bank (
    family_id,
    version,
    is_current,
    published_at,
    published_by,
    industry_id,
    master_competency_template_id,
    domain,
    type,
    difficulty,
    prompt,
    scenario,
    image_url,
    options,
    points,
    critical_safety,
    practical_verification_required,
    status
  )
  values (
    v_old.family_id,
    v_new_version,
    true,
    now(),
    auth.uid(),
    v_old.industry_id,
    v_old.master_competency_template_id,
    v_old.domain,
    v_old.type,
    v_old.difficulty,
    v_old.prompt,
    v_old.scenario,
    v_old.image_url,
    v_old.options,
    v_old.points,
    v_old.critical_safety,
    v_old.practical_verification_required,
    'draft'
  )
  returning id
  into v_new_id;


  update master_question_bank
  set
    superseded_by = v_new_id,
    updated_at = now()
  where id = v_old.id;


  -- Copy role applicability to the new version.
  insert into master_question_role_applicability (
    master_question_id,
    master_role_template_id
  )
  select
    v_new_id,
    master_role_template_id
  from master_question_role_applicability
  where master_question_id = v_old.id;


  -- Copy the secure answer key when one exists.
  if v_old_key.id is not null then

    insert into master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    values (
      v_new_id,
      v_old_key.correct_answer,
      v_old_key.scoring_notes,
      v_old_key.rationale
    );

  end if;


  return query
  select
    v_new_id,
    v_new_version;

end;
$$;



-- ============================================================================
-- 10. VERIFICATION
-- ============================================================================

select
  'master_question_bank' as object_name,
  count(*) as row_count
from master_question_bank

union all

select
  'master_question_answer_keys',
  count(*)
from master_question_answer_keys

union all

select
  'master_question_role_applicability',
  count(*)
from master_question_role_applicability

union all

select
  'assessment_blueprint_rules',
  count(*)
from assessment_blueprint_rules

union all

select
  'attempt_question_selections',
  count(*)
from attempt_question_selections;