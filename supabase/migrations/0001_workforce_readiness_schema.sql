-- ============================================================================
-- Workforce Readiness Intelligence — Assessments feature schema (additive)
-- REVISION 3 — supersedes revisions 1 and 2 before any of them have run.
-- ============================================================================
-- Preserves, unchanged: employees, user_client_roles, role_readiness, all
-- existing auth/RLS, and every existing app file.
--
-- ASSUMPTIONS: see revision 1 (public.clients(id) exists; gen_random_uuid()
-- available). RLS helper functions are prefixed wri_ to avoid any collision
-- with objects you already have.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 0. Shared helper functions
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

create or replace function wri_sync_client_from_parent(parent_table text, parent_id_col text)
returns trigger language plpgsql as $$
begin
  execute format('select client_id from %I where id = $1', parent_table)
    into strict new.client_id using (row_to_json(new)->>parent_id_col)::uuid;
  return new;
end;
$$;

-- new: give a fresh versioned template row its own family_id when one
-- isn't supplied (i.e. it's starting a brand new family, not a republish)
create or replace function wri_default_family_id()
returns trigger language plpgsql as $$
begin
  if new.family_id is null then new.family_id := new.id; end if;
  return new;
end;
$$;


-- ============================================================================
-- PART A — Master Library versioning (industries / job_roles / competencies /
--          assessments / assessment_questions / template adoption)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. industries — DECISION: IntegrateU-controlled global catalog only.
--    (Revision 1's comment implying nullable client_id here was wrong — the
--    table never had a client_id column. Documenting the decision instead
--    of adding one: industries are a fixed product taxonomy IntegrateU
--    curates. If a company ever needs a custom industry, that is a
--    deliberate future feature, not an accidental side door.)
-- ----------------------------------------------------------------------------
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


-- ----------------------------------------------------------------------------
-- 2. job_roles — now versioned.
--    family_id is stable across republishes; (id, version) is the
--    physical row. A "publish v2" operation INSERTs a new row with the
--    same family_id and version+1, then flips the OLD row's is_current to
--    false and sets superseded_by — the old row's substantive columns
--    (name, description, level_scale_max) are never edited in place, so
--    any company still pointing at it by id sees no change.
-- ----------------------------------------------------------------------------
create table job_roles (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id), -- null = IntegrateU template, set = company's own
  family_id uuid,                        -- stable identity across versions; defaults to id
  version int not null default 1,
  is_current boolean not null default true,
  superseded_by uuid references job_roles(id),
  published_at timestamptz not null default now(),
  published_by uuid,
  industry_id uuid not null references industries(id),
  name text not null,
  description text,
  level_scale_max int not null default 5,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_job_roles_family before insert on job_roles
  for each row execute function wri_default_family_id();
create trigger trg_job_roles_updated_at before update on job_roles
  for each row execute function wri_set_updated_at();

create unique index uq_job_roles_family_version on job_roles (family_id, version);
create index ix_job_roles_client on job_roles (client_id);
create index ix_job_roles_industry on job_roles (industry_id);
create index ix_job_roles_current on job_roles (family_id) where is_current;

alter table job_roles enable row level security;
create policy job_roles_select on job_roles for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy job_roles_write on job_roles for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- ----------------------------------------------------------------------------
-- 3. competencies — same versioning shape as job_roles.
-- ----------------------------------------------------------------------------
create table competencies (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  family_id uuid,
  version int not null default 1,
  is_current boolean not null default true,
  superseded_by uuid references competencies(id),
  published_at timestamptz not null default now(),
  published_by uuid,
  industry_id uuid not null references industries(id),
  name text not null,
  category text,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_competencies_family before insert on competencies
  for each row execute function wri_default_family_id();
create trigger trg_competencies_updated_at before update on competencies
  for each row execute function wri_set_updated_at();

create unique index uq_competencies_family_version on competencies (family_id, version);
create index ix_competencies_client on competencies (client_id);
create index ix_competencies_industry on competencies (industry_id);
create index ix_competencies_current on competencies (family_id) where is_current;

alter table competencies enable row level security;
create policy competencies_select on competencies for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy competencies_write on competencies for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- ----------------------------------------------------------------------------
-- 4. role_competency_requirements — scoped to one exact job_role version
--    (a republish gets its own fresh set of requirement rows under the new
--    job_role_id — no separate versioning columns needed here).
-- ----------------------------------------------------------------------------
create table role_competency_requirements (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  job_role_id uuid not null references job_roles(id) on delete cascade,
  competency_id uuid not null references competencies(id) on delete cascade,
  required_level int not null check (required_level between 1 and 5),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (job_role_id, competency_id)
);
create trigger trg_rcr_sync_client before insert or update on role_competency_requirements
  for each row execute function wri_sync_client_from_parent('job_roles', 'job_role_id');
create trigger trg_rcr_updated_at before update on role_competency_requirements
  for each row execute function wri_set_updated_at();

create index ix_rcr_client on role_competency_requirements (client_id);
create index ix_rcr_competency on role_competency_requirements (competency_id);

alter table role_competency_requirements enable row level security;
create policy rcr_select on role_competency_requirements for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy rcr_write on role_competency_requirements for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- ----------------------------------------------------------------------------
-- 5. assessments — versioned like job_roles/competencies.
-- ----------------------------------------------------------------------------
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
  job_role_id uuid references job_roles(id),
  target_job_role_id uuid references job_roles(id),
  competency_id uuid references competencies(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_assessments_family before insert on assessments
  for each row execute function wri_default_family_id();
create trigger trg_assessments_updated_at before update on assessments
  for each row execute function wri_set_updated_at();

create unique index uq_assessments_family_version on assessments (family_id, version);
create index ix_assessments_client on assessments (client_id);
create index ix_assessments_role on assessments (job_role_id);
create index ix_assessments_current on assessments (family_id) where is_current;

alter table assessments enable row level security;
create policy assessments_select on assessments for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy assessments_write on assessments for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));


-- ----------------------------------------------------------------------------
-- 6. assessment_questions — PUBLIC-SAFE content only. correct_answer has
--    been split out into assessment_question_answer_keys (Part C) so a
--    permissive select policy here can never leak answers.
-- ----------------------------------------------------------------------------
create table assessment_questions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id),
  assessment_id uuid not null references assessments(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  type text not null check (type in
    ('multiple_choice', 'multiple_select', 'scenario', 'image_based',
     'troubleshooting', 'situational_judgment')),
  prompt text not null,
  scenario text,
  image_url text,
  options jsonb, -- [{ "id": "a", "label": "..." }, ...] — no correctness info
  points numeric not null default 1,
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
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

-- This SELECT policy is intentionally readable by any assessment-taking
-- employee (they need prompts/options to take the test) — that's exactly
-- why correct_answer must never live in this table.


-- ----------------------------------------------------------------------------
-- 7. template_adoptions — a company's record of which IntegrateU template
--    (and which version of it) it copied, so "newer version available"
--    can be answered without ever mutating what they adopted.
-- ----------------------------------------------------------------------------
create table template_adoptions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  entity_type text not null check (entity_type in ('job_role', 'competency', 'assessment')),
  source_template_id uuid not null,  -- the global row's id at adoption time (loose ref; polymorphic across 3 tables)
  source_family_id uuid not null,
  source_version int not null,
  adopted_row_id uuid not null,      -- the company's own copy's id, in the same table as entity_type
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

-- Convenience view: is a newer published version of what this company
-- adopted now available? Computed on read, never stored, so it can't go stale.
create or replace view v_template_adoption_status as
select
  ta.*,
  case ta.entity_type
    when 'job_role'    then (select max(version) from job_roles where family_id = ta.source_family_id and is_current)
    when 'competency'  then (select max(version) from competencies where family_id = ta.source_family_id and is_current)
    when 'assessment'  then (select max(version) from assessments where family_id = ta.source_family_id and is_current)
  end as current_published_version,
  case ta.entity_type
    when 'job_role'    then (select max(version) from job_roles where family_id = ta.source_family_id and is_current) > ta.source_version
    when 'competency'  then (select max(version) from competencies where family_id = ta.source_family_id and is_current) > ta.source_version
    when 'assessment'  then (select max(version) from assessments where family_id = ta.source_family_id and is_current) > ta.source_version
  end as newer_version_available
from template_adoptions ta;


-- ============================================================================
-- PART B — Company-specific assessment activity (unchanged from revision 1)
-- ============================================================================

create table assessment_attempts (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  assessment_id uuid not null references assessments(id),
  job_role_id uuid references job_roles(id),
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
  is_correct boolean, -- filled in server-side only, see wri_score_attempt() in Part C
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


-- ============================================================================
-- PART C — Secure scoring (answer keys never reach the browser)
-- ============================================================================

-- Correct answers live ONLY here. No policy below grants select to the
-- authenticated role used by the browser client — RLS is enabled with zero
-- permissive read policies for ordinary users, so the default is deny.
-- Only wri_is_integrateu_admin()/CLIENT_ADMIN authoring policies exist, for
-- managing question content — never for taking a test.
create table assessment_question_answer_keys (
  id uuid primary key default gen_random_uuid(),
  client_id uuid,
  question_id uuid not null unique references assessment_questions(id) on delete cascade,
  correct_answer jsonb not null, -- e.g. "a" or ["a","c"]
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
-- Authoring only (writing/managing the key) — still no SELECT policy for
-- plain employees; admins/client admins can manage content they own.
create policy akeys_admin_all on assessment_question_answer_keys for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));
revoke all on assessment_question_answer_keys from authenticated, anon;
grant select, insert, update, delete on assessment_question_answer_keys to authenticated; -- RLS above still gates every row

-- Server-side scoring: runs with definer rights so it can read answer keys
-- regardless of the calling user's RLS visibility, but it NEVER returns the
-- correct_answer values themselves — only writes is_correct + scores.
-- Call this from a trusted context only (a Supabase Edge Function using the
-- service role, or a Postgres RPC invoked after the employee submits the
-- whole attempt) — never let the browser call it mid-assessment per question.
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

  -- REVISION 3 hardening: SECURITY DEFINER means this function can read
  -- rows the caller's own RLS would hide, so the function itself — not
  -- just the UI/RLS — must decide whether the caller may score THIS
  -- attempt. Three allowed callers only:
  --   1. an INTEGRATEU_ADMIN,
  --   2. a CLIENT_ADMIN whose allowed clients include this attempt's client, or
  --   3. the employee who owns the attempt (scoring their own submission).
  -- Everyone else is rejected before any row is touched. Prefer invoking
  -- this from a service-role Edge Function after the caller's JWT has
  -- already been verified server-side; this check is the DB-level
  -- backstop either way, not the only line of defense.
  select auth_user_id into v_employee_auth_user_id
  from employees where id = v_attempt.employee_id;

  if not (
    wri_is_integrateu_admin()
    or v_attempt.client_id in (select wri_allowed_client_ids())
    or v_employee_auth_user_id = auth.uid()
  ) then
    raise exception 'not authorized to score attempt %', p_attempt_id;
  end if;

  -- prevent replay: an attempt can only be scored once, from in_progress.
  -- Blocks calling this repeatedly to re-derive/probe for answer content
  -- via side channels (score deltas, timing, etc.) and blocks re-scoring
  -- an attempt that was already finalized.
  if v_attempt.status = 'completed' then
    raise exception 'attempt % already scored', p_attempt_id;
  end if;

  -- grade each answer against its (invisible-to-the-client) key
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

  -- roll answers up into a score per competency, snapshot the role's
  -- required level, and upsert competency_scores
  insert into competency_scores (client_id, attempt_id, employee_id, competency_id, score_percent, estimated_level, required_level)
  select
    v_attempt.client_id,
    p_attempt_id,
    v_attempt.employee_id,
    q.competency_id,
    round(100.0 * sum(case when aa.is_correct then q.points else 0 end) / sum(q.points), 1) as score_percent,
    least(5, greatest(1, ceil(5.0 * sum(case when aa.is_correct then q.points else 0 end) / sum(q.points))::int)) as estimated_level,
    rcr.required_level
  from attempt_answers aa
  join assessment_questions q on q.id = aa.question_id
  left join role_competency_requirements rcr
    on rcr.job_role_id = v_attempt.job_role_id and rcr.competency_id = q.competency_id
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
grant execute on function wri_score_attempt(uuid) to authenticated; -- gate is the in-function check above, not this grant alone


-- ============================================================================
-- PART D1 — Reusable Training Library (catalog tables, created before
--           development_plan_items so it can reference training_opportunities)
-- ============================================================================

create table vendors (
  id uuid primary key default gen_random_uuid(),
  client_id uuid references clients(id), -- null = well-known manufacturer, shared across companies
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
  client_id uuid references clients(id), -- null = shared/global provider (e.g. a national trade school)
  name text not null,
  provider_type text not null check (provider_type in
    ('integrateu_internal', 'company_internal', 'vendor_manufacturer', 'trade_school',
     'community_college', 'online_platform', 'industry_association',
     'certification_body', 'apprenticeship_sponsor')),
  vendor_id uuid references vendors(id), -- set when provider_type = 'vendor_manufacturer'
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
  client_id uuid references clients(id), -- null = available to every company
  provider_id uuid not null references training_providers(id),
  name text not null,
  description text,
  source_type text not null check (source_type in
    ('integrateu_internal', 'company_internal', 'vendor_manufacturer', 'trade_school',
     'community_college', 'online_platform', 'industry_association',
     'certification_body', 'apprenticeship_sponsor')),
  delivery_format text not null check (delivery_format in
    ('online', 'in_person', 'hybrid', 'self_paced', 'hands_on', 'blended')),
  duration_label text,        -- e.g. "2 hrs", "3 supervised installs"
  duration_minutes int,       -- structured form when known, for sorting/reporting
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
  integrateu_recommended boolean not null default false, -- distinct from source_type: an IntegrateU endorsement, even on a vendor/external course
  location text, -- freeform city/region, or 'Online' / 'Nationwide'
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
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
  client_id uuid, -- synced from the training_opportunity
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
  job_role_id uuid not null references job_roles(id),
  relevance_note text,
  created_at timestamptz not null default now(),
  unique (training_opportunity_id, job_role_id)
);
create trigger trg_trm_sync_client before insert or update on training_role_map
  for each row execute function wri_sync_client_from_parent('training_opportunities', 'training_opportunity_id');
create index ix_trm_role on training_role_map (job_role_id);
alter table training_role_map enable row level security;
create policy trm_select on training_role_map for select
  using (client_id is null or wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));
create policy trm_write on training_role_map for all
  using (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())))
  with check (wri_is_integrateu_admin() or (client_id is not null and client_id in (select wri_allowed_client_ids())));



-- ============================================================================
-- PART D — Development plans, S²DE coaching, evidence, ratings, reports
--          (development_plan_items references training_opportunities, above)
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


create table development_plan_items (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  plan_id uuid not null references development_plans(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  priority int not null default 0,
  current_level int,
  required_level int,
  training_opportunity_id uuid references training_opportunities(id), -- preferred: link a real catalog record
  recommended_training text,             -- fallback free text when no catalog record exists yet
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


create table competency_evidence (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  competency_id uuid not null references competencies(id),
  evidence_type text not null check (evidence_type in
    ('knowledge_assessment', 'completed_training', 'certification',
     'manager_evaluation', 'demonstrated_skill', 'practical_assessment', 'work_experience')),
  detail text not null,
  source_ref uuid,
  evidence_date date,
  created_by uuid,
  created_at timestamptz not null default now()
);
create trigger trg_evidence_sync_client before insert or update on competency_evidence
  for each row execute function wri_sync_client_from_employee();
create index ix_evidence_client on competency_evidence (client_id);
create index ix_evidence_employee on competency_evidence (employee_id);
create index ix_evidence_competency on competency_evidence (competency_id);
alter table competency_evidence enable row level security;
create policy evidence_all on competency_evidence for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


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




-- ============================================================================
-- PART D2 — Employee training assignments (after development_plan_items,
--           which it references)
-- ============================================================================

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
-- PART F — Recommendation-ranking support (REVISION 3)
-- Schema only — no ranking/AI engine is built here. These tables just make
-- sure every input the future engine needs already has somewhere to live,
-- so adding the engine later doesn't require another schema redesign:
--   competency gap        -> competency_scores (existing, Part B)
--   current / target role -> employee_role_assignments (below)
--   company vendors used  -> client_vendors (below)
--   company-required training -> company_training_requirements (below)
--   IntegrateU-recommended training -> training_opportunities.integrateu_recommended (above)
--   employee's completed training -> employee_training_assignments (existing)
--   certifications held   -> employee_certifications (below)
--   practical skill evidence -> practical_skill_ratings (existing, Part D)
--   location/online availability -> training_opportunities.delivery_format/location (above)
--   cost                  -> training_opportunities.cost_amount/cost_currency (above)
-- ============================================================================

-- Which vendors/manufacturers a company actually uses — lets a future
-- recommendation engine prioritize training from vendors they're already
-- invested in over generic/unrelated vendor training.
create table client_vendors (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  vendor_id uuid not null references vendors(id),
  status text not null default 'active' check (status in ('active', 'inactive')),
  is_preferred boolean not null default false,
  tier text check (tier in ('primary', 'secondary')),
  product_categories jsonb, -- e.g. ["lighting","networking"]
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


-- An employee's current and (optional) target role as standing facts —
-- distinct from a one-off assessment_attempts.job_role_id snapshot, this is
-- the durable "who they are now / where they're headed" the engine reads.
create table employee_role_assignments (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  job_role_id uuid not null references job_roles(id),
  assignment_type text not null check (assignment_type in ('current', 'target')),
  effective_date date not null default current_date,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_role_assignments_sync_client before insert or update on employee_role_assignments
  for each row execute function wri_sync_client_from_employee();
create trigger trg_role_assignments_updated_at before update on employee_role_assignments
  for each row execute function wri_set_updated_at();
create unique index uq_role_assignment_active on employee_role_assignments (employee_id, assignment_type) where is_active;
create index ix_role_assignments_client on employee_role_assignments (client_id);
create index ix_role_assignments_role on employee_role_assignments (job_role_id);
alter table employee_role_assignments enable row level security;
create policy role_assignments_all on employee_role_assignments for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));


-- Structured certifications (distinct from competency_evidence's freeform
-- detail text) so expiry/provider/opportunity can be queried directly.
create table employee_certifications (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  employee_id uuid not null references employees(id) on delete cascade,
  training_opportunity_id uuid references training_opportunities(id), -- set if earned via a cataloged opportunity
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


-- Training a company mandates itself (independent of role/competency
-- requirements) — e.g. an annual safety refresher every technician must
-- take regardless of assessed gaps. The engine can rank these highest.
create table company_training_requirements (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id),
  training_opportunity_id uuid not null references training_opportunities(id),
  job_role_id uuid references job_roles(id), -- null = required for every role
  required boolean not null default true,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (client_id, training_opportunity_id, job_role_id)
);
create trigger trg_company_reqs_updated_at before update on company_training_requirements
  for each row execute function wri_set_updated_at();
create index ix_company_reqs_client on company_training_requirements (client_id);
create index ix_company_reqs_opportunity on company_training_requirements (training_opportunity_id);
alter table company_training_requirements enable row level security;
create policy company_reqs_all on company_training_requirements for all
  using (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()))
  with check (wri_is_integrateu_admin() or client_id in (select wri_allowed_client_ids()));

-- ============================================================================
-- End of migration. role_readiness, employees, user_client_roles are
-- untouched. app/employees/[id]/page.tsx and page.backup.tsx are untouched.
-- ============================================================================
