-- ============================================================================
-- Workforce Readiness Intelligence — Assessments feature schema (additive)
-- REVISION 4 — supersedes revisions 1–3. Written after inspecting the live
-- database, which already has tables not visible in the GitHub repo:
--   roles, competencies, competency_evidence, employee_role_assignments,
--   learning_modules, role_readiness, employees, clients, user_client_roles
-- This revision REUSES those tables everywhere the earlier drafts invented
-- job_roles / competencies / competency_evidence / employee_role_assignments.
-- It does not create, drop, rename, or restructure any of them. The ONE
-- exception is a single additive column on competency_evidence (Part D).
--
-- ASSUMPTIONS: public.clients(id) exists; gen_random_uuid() available.
-- employee_role_assignments is NOT modified anywhere in this file — it is
-- actual/current-role history (is_primary, status, effective dates) per
-- the schema provided. Target/future role tracking lives instead in a new
-- additive table, employee_target_roles (Part A).
--
-- learning_modules (client-scoped internal content, part of the existing
-- learning-path system: learning_path_id, sequence, prerequisite_module_id,
-- verify_method, etc.) is preserved completely and never duplicated.
-- training_opportunities.learning_module_id bridges to it for internal
-- content only; a trigger derives/validates that the bridging row's
-- client_id always matches the learning_module's client_id, so a training
-- opportunity can never be wired to another company's module.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 0. Shared helper functions (unchanged from revision 3)
-- ----------------------------------------------------------------------------
create or replace function wri_is_integrateu_admin()
returns boolean language sql stable security definer set search_path = public
as $$
  select exists (select 1 from user_client_roles
    where user_id = auth.uid() and role = 'INTEGRATEU_ADMIN');
$$;

create or replace function wri_allowed_client_ids()
returns setof uuid language sql stable security definer set search_path = public
as $$
  select client_id from user_client_roles
  where user_id = auth.uid() and role = 'CLIENT_ADMIN';
$$;

create or replace function wri_set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end;
$$;

create or replace function wri_sync_client_from_employee()
returns trigger language plpgsql as $$
begin
  select client_id into strict new.client_id from employees where id = new.employee_id;
  return new;
end;
$$;

create or replace function wri_sync_client_from_parent()
returns trigger language plpgsql as $$
declare
  parent_table text := TG_ARGV[0];
  parent_id_col text := TG_ARGV[1];
begin
  execute format('select client_id from %I where id = $1', parent_table)
    into strict new.client_id using (row_to_json(new)->>parent_id_col)::uuid;
  return new;
end;
$$;

create or replace function wri_default_family_id()
returns trigger language plpgsql as $$
begin
  if new.family_id is null then new.family_id := new.id; end if;
  return new;
end;
$$;

-- Enforces that a training_opportunity wrapping an internal learning_module
-- can never point at another company's module: derives/validates client_id
-- from the learning_module itself rather than trusting whatever the caller
-- passed in. learning_modules.client_id is NOT NULL, so any row that
-- bridges to one is necessarily company-scoped too.
create or replace function wri_sync_client_from_learning_module()
returns trigger language plpgsql as $$
declare
  v_lm_client uuid;
begin
  if new.learning_module_id is not null then
    select client_id into strict v_lm_client from learning_modules where id = new.learning_module_id;
    if new.client_id is not null and new.client_id <> v_lm_client then
      raise exception 'training_opportunity.client_id (%) does not match its learning_module''s client_id (%)',
        new.client_id, v_lm_client;
    end if;
    new.client_id := v_lm_client;
  end if;
  return new;
end;
$$;


-- ============================================================================
-- PART A — IntegrateU Master Library (all NEW tables; roles/competencies
--          are never modified — adopting a template copies its fields into
--          a new roles/competencies row instead of sharing one)
-- ============================================================================

create table industries (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  description text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_industries_updated_at before update on industries
  for each row execute function wri_set_updated_at();
alter table industries enable row level security;
create policy industries_select on industries for select using (true);
create policy industries_write_admin on industries for all
  using (wri_is_integrateu_admin()) with check (wri_is_integrateu_admin());


-- Versioned template of a role. Mirrors the authorable fields on the real
-- `roles` table (name/department/purpose/description) plus publishing
-- metadata. Adopting one INSERTs a new row into `roles` — this table is
-- never referenced by employee_role_assignments or anything operational.
create table master_role_templates (
  id uuid primary key default gen_random_uuid(),
  family_id uuid,
  version int not null default 1,
  is_current boolean not null default true,
  superseded_by uuid references master_role_templates(id),
  published_at timestamptz not null default now(),
  published_by uuid,
  industry_id uuid not null references industries(id),
  name text not null,
  department text,
  purpose text,
  description text,
  level_scale_max int not null default 5,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_mrt_family before insert on master_role_templates
  for each row execute function wri_default_family_id();
create trigger trg_mrt_updated_at before update on master_role_templates
  for each row execute function wri_set_updated_at();
create unique index uq_mrt_family_version on master_role_templates (family_id, version);
create index ix_mrt_industry on master_role_templates (industry_id);
create index ix_mrt_current on master_role_templates (family_id) where is_current;
alter table master_role_templates enable row level security;
create policy mrt_select on master_role_templates for select using (true);
create policy mrt_write_admin on master_role_templates for all
  using (wri_is_integrateu_admin()) with check (wri_is_integrateu_admin());


-- Versioned template of a competency. Mirrors the real `competencies`
-- table's authorable fields (category, critical, verifier_type,
-- evidence_requirements, reverification_period). Adopting one INSERTs a
-- new row into `competencies`.
create table master_competency_templates (
  id uuid primary key default gen_random_uuid(),
  family_id uuid,
  version int not null default 1,
  is_current boolean not null default true,
  superseded_by uuid references master_competency_templates(id),
  published_at timestamptz not null default now(),
  published_by uuid,
  industry_id uuid not null references industries(id),
  name text not null,
  category text,
  is_critical boolean not null default false,
  verifier_type text,
  evidence_requirements text,
  reverification_period_months int,
  description text,
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_mct_family before insert on master_competency_templates
  for each row execute function wri_default_family_id();
create trigger trg_mct_updated_at before update on master_competency_templates
  for each row execute function wri_set_updated_at();
create unique index uq_mct_family_version on master_competency_templates (family_id, version);
create index ix_mct_industry on master_competency_templates (industry_id);
create index ix_mct_current on master_competency_templates (family_id) where is_current;
alter table master_competency_templates enable row level security;
create policy mct_select on master_competency_templates for select using (true);
create policy mct_write_admin on master_competency_templates for all
  using (wri_is_integrateu_admin()) with check (wri_is_integrateu_admin());


-- Template-side required-level matrix — the master equivalent of
-- role_competency_requirements (Part B), scoped to specific template
-- versions rather than to a company's adopted roles/competencies.
create table master_role_competency_requirements (
  id uuid primary key default gen_random_uuid(),
  master_role_template_id uuid not null references master_role_templates(id) on delete cascade,
  master_competency_template_id uuid not null references master_competency_templates(id) on delete cascade,
  required_level int not null check (required_level between 1 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (master_role_template_id, master_competency_template_id)
);
create trigger trg_mrcr_updated_at before update on master_role_competency_requirements
  for each row execute function wri_set_updated_at();
create index ix_mrcr_competency on master_role_competency_requirements (master_competency_template_id);
alter table master_role_competency_requirements enable row level security;
create policy mrcr_select on master_role_competency_requirements for select using (true);
create policy mrcr_write_admin on master_role_competency_requirements for all
  using (wri_is_integrateu_admin()) with check (wri_is_integrateu_admin());


-- A company's record of which template (and version) it adopted, for each
-- of the three adoptable entity types. source_template_id/adopted_row_id
-- are loose (polymorphic) references — application-enforced, since a
-- single FK can't target three different tables.
create table template_adoptions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  entity_type text not null check (entity_type in ('role', 'competency', 'assessment')),
  source_template_id uuid not null,   -- master_role_templates.id / master_competency_templates.id / assessments.id (global row)
  source_family_id uuid not null,
  source_version int not null,
  adopted_row_id uuid not null,       -- roles.id / competencies.id / assessments.id (the company's own copy)
  adopted_at timestamptz not null default now(),
  adopted_by uuid,
  created_at timestamptz not null default now()
);
create index ix_adoptions_client on template_adoptions (client_id);
create index ix_adoptions_family on template_adoptions (source_family_id, source_version);
alter table template_adoptions enable row level security;
create policy adoptions_all on template_adoptions for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));

create or replace view v_template_adoption_status as
select
  ta.*,
  case ta.entity_type
    when 'role'       then (select max(version) from master_role_templates where family_id = ta.source_family_id and is_current)
    when 'competency' then (select max(version) from master_competency_templates where family_id = ta.source_family_id and is_current)
    when 'assessment' then (select max(version) from assessments where family_id = ta.source_family_id and is_current)
  end as current_published_version,
  case ta.entity_type
    when 'role'       then (select max(version) from master_role_templates where family_id = ta.source_family_id and is_current) > ta.source_version
    when 'competency' then (select max(version) from master_competency_templates where family_id = ta.source_family_id and is_current) > ta.source_version
    when 'assessment' then (select max(version) from assessments where family_id = ta.source_family_id and is_current) > ta.source_version
  end as newer_version_available
from template_adoptions ta;


-- ============================================================================
-- PART B — Assessments (dual-mode: a template row, client_id null,
--          references the master_* tables; a company row, client_id set,
--          references the EXISTING roles/competencies tables directly)
-- ============================================================================

create table assessments (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  family_id uuid,
  version int not null default 1,
  is_current boolean not null default true,
  superseded_by uuid references assessments(id),
  published_at timestamptz not null default now(),
  published_by uuid,
  industry_id uuid not null references industries(id),
  name text not null,
  type text not null check (type in ('initial', 'competency', 'role_qualification')),

  -- template mode (client_id is null) — reference the master library
  master_role_template_id uuid references master_role_templates(id),
  master_target_role_template_id uuid references master_role_templates(id),
  master_competency_template_id uuid references master_competency_templates(id),

  -- company mode (client_id is not null) — reference the real, existing tables
  role_id uuid references roles(id),
  target_role_id uuid references roles(id),
  competency_id uuid references competencies(id),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  check (
    (client_id is null  and role_id is null and target_role_id is null and competency_id is null)
    or
    (client_id is not null and master_role_template_id is null and master_target_role_template_id is null and master_competency_template_id is null)
  )
);
create trigger trg_assessments_family before insert on assessments
  for each row execute function wri_default_family_id();
create trigger trg_assessments_updated_at before update on assessments
  for each row execute function wri_set_updated_at();
create unique index uq_assessments_family_version on assessments (family_id, version);
create index ix_assessments_client on assessments (client_id);
create index ix_assessments_role on assessments (role_id);
create index ix_assessments_current on assessments (family_id) where is_current;
alter table assessments enable row level security;
create policy assessments_select on assessments for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy assessments_write on assessments for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- Public-safe question content only — correct_answer lives in
-- assessment_question_answer_keys (Part C), never here.
create table assessment_questions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  assessment_id uuid not null references assessments(id) on delete cascade,

  master_competency_template_id uuid references master_competency_templates(id), -- set when the parent assessment is template-mode
  competency_id uuid references competencies(id),                                -- set when the parent assessment is company-mode

  type text not null check (type in
    ('multiple_choice', 'multiple_select', 'scenario', 'image_based',
     'troubleshooting', 'situational_judgment')),
  prompt text not null,
  scenario text,
  image_url text,
  options jsonb,
  points numeric not null default 1,
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  check (master_competency_template_id is not null or competency_id is not null),
  check (not (master_competency_template_id is not null and competency_id is not null))
);
create trigger trg_aq_sync_client before insert or update on assessment_questions
  for each row execute function wri_sync_client_from_parent('assessments', 'assessment_id');
create trigger trg_aq_updated_at before update on assessment_questions
  for each row execute function wri_set_updated_at();
create index ix_aq_client on assessment_questions (client_id);
create index ix_aq_assessment on assessment_questions (assessment_id);
create index ix_aq_competency on assessment_questions (competency_id);
alter table assessment_questions enable row level security;
create policy aq_select on assessment_questions for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy aq_write on assessment_questions for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- Company-side required-level matrix. Genuinely new — `competencies`
-- carries attributes of the competency itself, not a per-role required
-- level, and `roles` has no requirement linkage either.
create table role_competency_requirements (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  role_id uuid not null references roles(id) on delete cascade,
  competency_id uuid not null references competencies(id) on delete cascade,
  required_level int not null check (required_level between 1 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (role_id, competency_id)
);
create trigger trg_rcr_sync_client before insert or update on role_competency_requirements
  for each row execute function wri_sync_client_from_parent('roles', 'role_id');
create trigger trg_rcr_updated_at before update on role_competency_requirements
  for each row execute function wri_set_updated_at();
create index ix_rcr_client on role_competency_requirements (client_id);
create index ix_rcr_competency on role_competency_requirements (competency_id);
alter table role_competency_requirements enable row level security;
create policy rcr_all on role_competency_requirements for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- ============================================================================
-- PART C — Attempts, secure scoring, competency scores
-- ============================================================================

create table assessment_attempts (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  assessment_id uuid not null references assessments(id), -- must be a company-mode (client_id not null) assessment
  role_id uuid references roles(id),
  status text not null default 'not_started'
    check (status in ('not_started', 'in_progress', 'completed', 'abandoned')),
  started_at timestamptz,
  completed_at timestamptz,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_attempts_sync_client before insert or update on assessment_attempts
  for each row execute function wri_sync_client_from_employee();
create trigger trg_attempts_updated_at before update on assessment_attempts
  for each row execute function wri_set_updated_at();
create index ix_attempts_client on assessment_attempts (client_id);
create index ix_attempts_employee on assessment_attempts (employee_id);
create index ix_attempts_assessment on assessment_attempts (assessment_id);
alter table assessment_attempts enable row level security;
create policy attempts_all on assessment_attempts for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table attempt_answers (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  attempt_id uuid not null references assessment_attempts(id) on delete cascade,
  question_id uuid not null references assessment_questions(id),
  response jsonb not null,
  is_correct boolean, -- server-side only, see wri_score_attempt() below
  answered_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (attempt_id, question_id)
);
create trigger trg_answers_sync_client before insert or update on attempt_answers
  for each row execute function wri_sync_client_from_parent('assessment_attempts', 'attempt_id');
create index ix_answers_client on attempt_answers (client_id);
create index ix_answers_attempt on attempt_answers (attempt_id);
alter table attempt_answers enable row level security;
create policy answers_all on attempt_answers for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table competency_scores (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  attempt_id uuid not null references assessment_attempts(id) on delete cascade,
  employee_id uuid not null references employees(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  score_percent numeric not null check (score_percent between 0 and 100),
  estimated_level int not null check (estimated_level between 1 and 5),
  required_level int,
  gap int generated always as (
    case when required_level is null then null else greatest(required_level - estimated_level, 0) end
  ) stored,
  status text generated always as (
    case
      when required_level is null then 'not_assessed'
      when estimated_level >= required_level then 'ready'
      when required_level - estimated_level = 1 then 'developing'
      else 'critical_gap'
    end
  ) stored,
  created_at timestamptz not null default now(),
  unique (attempt_id, competency_id)
);
create trigger trg_scores_sync_client before insert or update on competency_scores
  for each row execute function wri_sync_client_from_employee();
create index ix_scores_client on competency_scores (client_id);
create index ix_scores_employee on competency_scores (employee_id);
create index ix_scores_competency on competency_scores (competency_id);
alter table competency_scores enable row level security;
create policy scores_all on competency_scores for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- Correct answers live ONLY here. No SELECT policy grants ordinary users
-- read access — default deny. Only content-authoring admins may write.
create table assessment_question_answer_keys (
  id uuid primary key default gen_random_uuid(),
  client_id uuid,
  question_id uuid not null unique references assessment_questions(id) on delete cascade,
  correct_answer jsonb not null,
  scoring_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_akeys_sync_client before insert or update on assessment_question_answer_keys
  for each row execute function wri_sync_client_from_parent('assessment_questions', 'question_id');
create trigger trg_akeys_updated_at before update on assessment_question_answer_keys
  for each row execute function wri_set_updated_at();
create index ix_akeys_client on assessment_question_answer_keys (client_id);
alter table assessment_question_answer_keys enable row level security;
create policy akeys_admin_all on assessment_question_answer_keys for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));
revoke all on assessment_question_answer_keys from authenticated, anon;
grant select, insert, update, delete on assessment_question_answer_keys to authenticated; -- RLS above still gates every row

-- Server-side scoring only. SECURITY DEFINER, so the in-function
-- authorization check below — not the grant, not the UI — is the real
-- gate. Prefer invoking from a service-role Edge Function after verifying
-- the caller's JWT server-side; this is the DB-level backstop regardless.
create or replace function wri_score_attempt(p_attempt_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attempt assessment_attempts;
  v_employee_auth_user_id uuid;
begin
  select * into v_attempt from assessment_attempts where id = p_attempt_id;
  if v_attempt is null then
    raise exception 'attempt % not found', p_attempt_id;
  end if;

  select auth_user_id into v_employee_auth_user_id from employees where id = v_attempt.employee_id;

  if not (
    wri_is_integrateu_admin()
    or v_attempt.client_id in (select wri_allowed_client_ids())
    or v_employee_auth_user_id = auth.uid()
  ) then
    raise exception 'not authorized to score attempt %', p_attempt_id;
  end if;

  if v_attempt.status = 'completed' then
    raise exception 'attempt % already scored', p_attempt_id;
  end if;

  update attempt_answers aa
  set is_correct = (
    select
      case
        when jsonb_typeof(k.correct_answer) = 'array' then
          (select array_agg(x order by x) from jsonb_array_elements_text(k.correct_answer) x)
          = (select array_agg(y order by y) from jsonb_array_elements_text(aa.response) y)
        else k.correct_answer = aa.response
      end
    from assessment_question_answer_keys k
    where k.question_id = aa.question_id
  )
  where aa.attempt_id = p_attempt_id;

  insert into competency_scores (client_id, attempt_id, employee_id, competency_id, score_percent, estimated_level, required_level)
  select
    v_attempt.client_id,
    p_attempt_id,
    v_attempt.employee_id,
    q.competency_id,
    round(100.0 * sum(case when aa.is_correct then q.points else 0 end) / sum(q.points), 1),
    least(5, greatest(1, ceil(5.0 * sum(case when aa.is_correct then q.points else 0 end) / sum(q.points))::int)),
    rcr.required_level
  from attempt_answers aa
  join assessment_questions q on q.id = aa.question_id
  left join role_competency_requirements rcr
    on rcr.role_id = v_attempt.role_id and rcr.competency_id = q.competency_id
  where aa.attempt_id = p_attempt_id
  group by q.competency_id, rcr.required_level
  on conflict (attempt_id, competency_id) do update
    set score_percent = excluded.score_percent,
        estimated_level = excluded.estimated_level,
        required_level = excluded.required_level;

  update assessment_attempts set status = 'completed', completed_at = now() where id = p_attempt_id;
end;
$$;
revoke all on function wri_score_attempt(uuid) from public, anon;
grant execute on function wri_score_attempt(uuid) to authenticated;


-- ============================================================================
-- PART D — Development plans, S²DE coaching, evidence extension, ratings,
--          reports. competency_evidence gets ONE additive column; every
--          other existing table here is untouched.
-- ============================================================================

create table development_plans (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  attempt_id uuid references assessment_attempts(id),
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_plans_sync_client before insert or update on development_plans
  for each row execute function wri_sync_client_from_employee();
create trigger trg_plans_updated_at before update on development_plans
  for each row execute function wri_set_updated_at();
create index ix_plans_client on development_plans (client_id);
create index ix_plans_employee on development_plans (employee_id);
alter table development_plans enable row level security;
create policy plans_all on development_plans for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- (training_opportunities is created in Part E, before this table, so the
-- FK below is valid — see file order.)


-- ============================================================================
-- PART E — Reusable Training Library. Internal content stays authored in
--          the existing `learning_modules` — training_opportunities wraps
--          it with one thin row rather than duplicating it; external
--          training (vendor/trade school/online/etc.) carries its own
--          metadata directly.
-- ============================================================================

create table vendors (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  name text not null,
  website_url text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_vendors_updated_at before update on vendors
  for each row execute function wri_set_updated_at();
create index ix_vendors_client on vendors (client_id);
alter table vendors enable row level security;
create policy vendors_select on vendors for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy vendors_write on vendors for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


create table training_providers (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  name text not null,
  provider_type text not null check (provider_type in
    ('integrateu_internal', 'company_internal', 'vendor_manufacturer', 'trade_school',
     'community_college', 'online_platform', 'industry_association',
     'certification_body', 'apprenticeship_sponsor')),
  vendor_id uuid references vendors(id),
  website_url text,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_providers_updated_at before update on training_providers
  for each row execute function wri_set_updated_at();
create index ix_providers_client on training_providers (client_id);
create index ix_providers_vendor on training_providers (vendor_id);
alter table training_providers enable row level security;
create policy providers_select on training_providers for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy providers_write on training_providers for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


create table training_opportunities (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  provider_id uuid not null references training_providers(id),

  learning_module_id uuid references learning_modules(id), -- bridge to existing internal content; see check below

  name text not null,
  description text,
  source_type text not null check (source_type in
    ('integrateu_internal', 'company_internal', 'vendor_manufacturer', 'trade_school',
     'community_college', 'online_platform', 'industry_association',
     'certification_body', 'apprenticeship_sponsor')),
  delivery_format text not null check (delivery_format in
    ('online', 'in_person', 'hybrid', 'self_paced', 'hands_on', 'blended')),
  duration_label text,
  duration_minutes int,
  cost_amount numeric,
  cost_currency text default 'USD',
  is_certification boolean not null default false,
  certification_name text,
  certification_expires_after_months int,
  url text,
  verification_status text not null default 'unverified'
    check (verification_status in ('unverified', 'verified', 'outdated')),
  last_verified_at date,
  discovered_by_ai boolean not null default false,
  ai_model text,
  integrateu_recommended boolean not null default false,
  location text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  -- internal training MUST wrap an existing learning_modules row (never a
  -- second copy of internal content); external training MUST NOT.
  check (
    (source_type in ('integrateu_internal', 'company_internal') and learning_module_id is not null)
    or
    (source_type not in ('integrateu_internal', 'company_internal') and learning_module_id is null)
  )
);
create unique index uq_opportunities_learning_module on training_opportunities (learning_module_id) where learning_module_id is not null;
create trigger trg_opportunities_sync_client_from_module before insert or update on training_opportunities
  for each row execute function wri_sync_client_from_learning_module();
create trigger trg_opportunities_updated_at before update on training_opportunities
  for each row execute function wri_set_updated_at();
create index ix_opportunities_client on training_opportunities (client_id);
create index ix_opportunities_provider on training_opportunities (provider_id);
alter table training_opportunities enable row level security;
create policy opportunities_select on training_opportunities for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy opportunities_write on training_opportunities for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


create table training_competency_map (
  id uuid primary key default gen_random_uuid(),
  client_id uuid,
  training_opportunity_id uuid not null references training_opportunities(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  relevance_note text,
  created_at timestamptz not null default now(),
  unique (training_opportunity_id, competency_id)
);
create trigger trg_tcm_sync_client before insert or update on training_competency_map
  for each row execute function wri_sync_client_from_parent('training_opportunities', 'training_opportunity_id');
create index ix_tcm_competency on training_competency_map (competency_id);
alter table training_competency_map enable row level security;
create policy tcm_select on training_competency_map for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy tcm_write on training_competency_map for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


create table training_role_map (
  id uuid primary key default gen_random_uuid(),
  client_id uuid,
  training_opportunity_id uuid not null references training_opportunities(id) on delete cascade,
  role_id uuid not null references roles(id),
  relevance_note text,
  created_at timestamptz not null default now(),
  unique (training_opportunity_id, role_id)
);
create trigger trg_trm_sync_client before insert or update on training_role_map
  for each row execute function wri_sync_client_from_parent('training_opportunities', 'training_opportunity_id');
create index ix_trm_role on training_role_map (role_id);
alter table training_role_map enable row level security;
create policy trm_select on training_role_map for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy trm_write on training_role_map for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- ============================================================================
-- back to PART D — development_plan_items can now legally reference
-- training_opportunities (created just above).
-- ============================================================================

create table development_plan_items (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  plan_id uuid not null references development_plans(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  priority int not null default 0,
  current_level int,
  required_level int,
  training_opportunity_id uuid references training_opportunities(id),
  recommended_training text,
  recommended_vendor_training text,
  recommended_internal_training text,
  recommended_external_training text,
  hands_on_practice text,
  reassessment_recommendation text,
  status text not null default 'not_started'
    check (status in ('not_started', 'in_progress', 'completed')),
  added_to_plan boolean not null default true,
  ai_generated boolean not null default false,
  ai_model text,
  ai_prompt_version text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_plan_items_sync_client before insert or update on development_plan_items
  for each row execute function wri_sync_client_from_parent('development_plans', 'plan_id');
create trigger trg_plan_items_updated_at before update on development_plan_items
  for each row execute function wri_set_updated_at();
create index ix_plan_items_client on development_plan_items (client_id);
create index ix_plan_items_plan on development_plan_items (plan_id);
create index ix_plan_items_competency on development_plan_items (competency_id);
create index ix_plan_items_training on development_plan_items (training_opportunity_id);
alter table development_plan_items enable row level security;
create policy plan_items_all on development_plan_items for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table coaching_cycles (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  plan_item_id uuid references development_plan_items(id),
  coach_user_id uuid,
  status text not null default 'not_started'
    check (status in ('not_started', 'in_progress', 'awaiting_evaluation', 'approved', 'needs_more_development')),
  due_date date,
  say_notes text,
  see_notes text,
  do_notes text,
  evaluate_notes text,
  success_criteria jsonb,
  evidence_required text,
  evidence_url text,
  evaluation_result text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_cycles_sync_client before insert or update on coaching_cycles
  for each row execute function wri_sync_client_from_employee();
create trigger trg_cycles_updated_at before update on coaching_cycles
  for each row execute function wri_set_updated_at();
create index ix_cycles_client on coaching_cycles (client_id);
create index ix_cycles_employee on coaching_cycles (employee_id);
create index ix_cycles_competency on coaching_cycles (competency_id);
alter table coaching_cycles enable row level security;
create policy cycles_all on coaching_cycles for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table coaching_history (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  cycle_id uuid not null references coaching_cycles(id) on delete cascade,
  event_date timestamptz not null default now(),
  event_type text not null check (event_type in
    ('say_completed', 'see_completed', 'do_completed', 'evaluation_completed',
     'note_added', 'evidence_uploaded', 'status_changed')),
  notes text,
  readiness_before int,
  readiness_after int,
  recorded_by uuid,
  created_at timestamptz not null default now()
);
create trigger trg_history_sync_client before insert or update on coaching_history
  for each row execute function wri_sync_client_from_parent('coaching_cycles', 'cycle_id');
create index ix_history_client on coaching_history (client_id);
create index ix_history_cycle on coaching_history (cycle_id);
alter table coaching_history enable row level security;
create policy history_all on coaching_history for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- The ONLY change to an existing table in this entire migration: one
-- additive, nullable column so external/vendor training completions can
-- also produce evidence, alongside the existing learning_module_id path.
alter table competency_evidence
  add column if not exists training_opportunity_id uuid references training_opportunities(id);
create index if not exists ix_evidence_training_opportunity on competency_evidence (training_opportunity_id);


create table practical_skill_ratings (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  rating text not null check (rating in
    ('not_observed', 'observed', 'can_perform_with_guidance',
     'can_perform_independently', 'advanced', 'can_train_others')),
  rated_by uuid,
  rated_at timestamptz not null default now(),
  notes text,
  created_at timestamptz not null default now()
);
create trigger trg_ratings_sync_client before insert or update on practical_skill_ratings
  for each row execute function wri_sync_client_from_employee();
create index ix_ratings_client on practical_skill_ratings (client_id);
create index ix_ratings_employee_competency on practical_skill_ratings (employee_id, competency_id);
alter table practical_skill_ratings enable row level security;
create policy ratings_all on practical_skill_ratings for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table reports (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  report_type text not null check (report_type in ('summary', 'complete')),
  sections jsonb,
  attempt_id uuid references assessment_attempts(id),
  plan_id uuid references development_plans(id),
  generated_by uuid,
  generated_at timestamptz not null default now(),
  readiness_snapshot jsonb,
  pdf_url text,
  created_at timestamptz not null default now()
);
create trigger trg_reports_sync_client before insert or update on reports
  for each row execute function wri_sync_client_from_employee();
create index ix_reports_client on reports (client_id);
create index ix_reports_employee on reports (employee_id);
alter table reports enable row level security;
create policy reports_all on reports for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table employee_training_assignments (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  training_opportunity_id uuid not null references training_opportunities(id),
  plan_item_id uuid references development_plan_items(id),
  assigned_by uuid,
  assigned_at timestamptz not null default now(),
  due_date date,
  status text not null default 'assigned'
    check (status in ('assigned', 'in_progress', 'completed', 'waived')),
  completed_at timestamptz,
  completion_evidence_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_assignments_sync_client before insert or update on employee_training_assignments
  for each row execute function wri_sync_client_from_employee();
create trigger trg_assignments_updated_at before update on employee_training_assignments
  for each row execute function wri_set_updated_at();
create index ix_assignments_client on employee_training_assignments (client_id);
create index ix_assignments_employee on employee_training_assignments (employee_id);
create index ix_assignments_opportunity on employee_training_assignments (training_opportunity_id);
alter table employee_training_assignments enable row level security;
create policy assignments_all on employee_training_assignments for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- ============================================================================
-- PART F — Company vendor profiles, certifications, company-mandated training
-- ============================================================================

create table client_vendors (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  vendor_id uuid not null references vendors(id),
  status text not null default 'active' check (status in ('active', 'inactive')),
  is_preferred boolean not null default false,
  tier text check (tier in ('primary', 'secondary')),
  product_categories jsonb,
  notes text,
  added_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (client_id, vendor_id)
);
create trigger trg_client_vendors_updated_at before update on client_vendors
  for each row execute function wri_set_updated_at();
create index ix_client_vendors_client on client_vendors (client_id);
create index ix_client_vendors_vendor on client_vendors (vendor_id);
alter table client_vendors enable row level security;
create policy client_vendors_all on client_vendors for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table employee_certifications (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  training_opportunity_id uuid references training_opportunities(id),
  certification_name text not null,
  issued_by text,
  issued_date date,
  expires_date date,
  evidence_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_certifications_sync_client before insert or update on employee_certifications
  for each row execute function wri_sync_client_from_employee();
create trigger trg_certifications_updated_at before update on employee_certifications
  for each row execute function wri_set_updated_at();
create index ix_certifications_client on employee_certifications (client_id);
create index ix_certifications_employee on employee_certifications (employee_id);
create index ix_certifications_expiry on employee_certifications (expires_date);
alter table employee_certifications enable row level security;
create policy certifications_all on employee_certifications for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


create table company_training_requirements (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  training_opportunity_id uuid not null references training_opportunities(id),
  role_id uuid references roles(id), -- null = required for every role
  required boolean not null default true,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (client_id, training_opportunity_id, role_id)
);
create trigger trg_company_reqs_updated_at before update on company_training_requirements
  for each row execute function wri_set_updated_at();
create index ix_company_reqs_client on company_training_requirements (client_id);
create index ix_company_reqs_opportunity on company_training_requirements (training_opportunity_id);
alter table company_training_requirements enable row level security;
create policy company_reqs_all on company_training_requirements for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));

-- Target/future role tracking. employee_role_assignments (existing,
-- untouched) is actual/current-role history — is_primary, status,
-- effective_start_date/end_date all say "this is the role they hold," not
-- "this is the role they're working toward." Kept as a separate additive
-- table rather than overloading that table's meaning.
create table employee_target_roles (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  role_id uuid not null references roles(id),
  status text not null default 'active' check (status in ('active', 'achieved', 'abandoned')),
  set_by uuid,
  effective_start_date date not null default current_date,
  effective_end_date date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_target_roles_sync_client before insert or update on employee_target_roles
  for each row execute function wri_sync_client_from_employee();
create trigger trg_target_roles_updated_at before update on employee_target_roles
  for each row execute function wri_set_updated_at();
create unique index uq_target_role_active on employee_target_roles (employee_id) where status = 'active';
create index ix_target_roles_client on employee_target_roles (client_id);
create index ix_target_roles_role on employee_target_roles (role_id);
alter table employee_target_roles enable row level security;
create policy target_roles_all on employee_target_roles for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- ============================================================================
-- End of migration.
--
-- UNCHANGED, in full: employees, clients, user_client_roles, role_readiness,
-- roles, competencies, employee_role_assignments, learning_modules, and
-- every existing RLS policy and app file (app/employees/[id]/page.tsx,
-- page.backup.tsx included).
--
-- ONLY existing-table change anywhere in this file: one additive nullable
-- column, competency_evidence.training_opportunity_id.
-- ============================================================================
