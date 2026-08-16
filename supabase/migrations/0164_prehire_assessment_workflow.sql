-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0164_prehire_assessment_workflow.sql
--
-- PURPOSE
-- Adds the pre-hire candidate assessment workflow.
--
-- PRINCIPLES
--   1. Candidates are not employees.
--   2. Pre-hire attempts remain isolated from employee readiness/development.
--   3. Master assessments may be used directly for candidate evaluation.
--   4. Candidate assessment history is preserved if the candidate is hired.
--   5. Candidate-facing access will use secure invitation tokens.
-- ============================================================================


-- ============================================================================
-- PART 1 — PRE-HIRE CANDIDATES
-- ============================================================================

create table prehire_candidates (
  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  industry_id uuid not null
    references industries(id),

  first_name text not null,
  last_name text not null,
  email text not null,

  status text not null default 'candidate'
    check (
      status in (
        'candidate',
        'assessment_in_progress',
        'assessment_completed',
        'under_review',
        'hired',
        'not_hired',
        'withdrawn'
      )
    ),

  converted_employee_id uuid
    references employees(id)
    on delete restrict,

  converted_at timestamptz,

  created_by uuid,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),


  constraint prehire_candidates_conversion_check
    check (
      (
        converted_employee_id is null
        and converted_at is null
      )
      or
      (
        converted_employee_id is not null
        and converted_at is not null
      )
    ),

  constraint prehire_candidates_id_client_id_key
    unique (
      id,
      client_id
    )
);


-- ============================================================================
-- PART 2 — PRE-HIRE ASSESSMENT INVITATIONS
-- ============================================================================

create table prehire_assessment_invitations (
  id uuid primary key default gen_random_uuid(),

  candidate_id uuid not null
    references prehire_candidates(id)
    on delete cascade,

  client_id uuid not null
    references clients(id),

  master_role_template_id uuid not null
    references master_role_templates(id),

  token_hash bytea not null unique,

  status text not null default 'pending'
    check (
      status in (
        'pending',
        'sent',
        'opened',
        'in_progress',
        'completed',
        'expired',
        'revoked'
      )
    ),

  expires_at timestamptz not null,

  sent_at timestamptz,
  opened_at timestamptz,
  started_at timestamptz,
  completed_at timestamptz,
  revoked_at timestamptz,

  partial_coverage_approved boolean not null default false,
  partial_coverage_approved_by uuid,
  partial_coverage_approved_at timestamptz,

  created_by uuid,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint prehire_invitation_candidate_client_fkey
    foreign key (
      candidate_id,
      client_id
    )
    references prehire_candidates (
      id,
      client_id
    )
    on delete cascade,

  constraint prehire_invitation_expiration_check
    check (expires_at > created_at),

  constraint prehire_invitation_partial_coverage_check
    check (
      (
        partial_coverage_approved = false
        and partial_coverage_approved_by is null
        and partial_coverage_approved_at is null
      )
      or
      (
        partial_coverage_approved = true
        and partial_coverage_approved_by is not null
        and partial_coverage_approved_at is not null
      )
    )
);


-- ============================================================================
-- PART 3 — PRE-HIRE INVITATION ASSESSMENTS
-- ============================================================================

create table prehire_invitation_assessments (
  id uuid primary key default gen_random_uuid(),

  invitation_id uuid not null
    references prehire_assessment_invitations(id)
    on delete cascade,

  assessment_id uuid not null
    references assessments(id),

  assessment_order int not null
    check (assessment_order > 0),

  created_at timestamptz not null default now(),

  unique (
    invitation_id,
    assessment_id
  ),

  unique (
    invitation_id,
    assessment_order
  )
);


-- ============================================================================
-- PART 4 — PRE-HIRE ASSESSMENT ATTEMPTS
-- ============================================================================

create table prehire_assessment_attempts (
  id uuid primary key default gen_random_uuid(),

  candidate_id uuid not null
    references prehire_candidates(id)
    on delete cascade,

  invitation_id uuid not null
    references prehire_assessment_invitations(id)
    on delete cascade,

  invitation_assessment_id uuid not null
    references prehire_invitation_assessments(id)
    on delete cascade,

  client_id uuid not null
    references clients(id),

  assessment_id uuid not null
    references assessments(id),

  status text not null default 'not_started'
    check (
      status in (
        'not_started',
        'in_progress',
        'completed',
        'abandoned'
      )
    ),

  started_at timestamptz,
  completed_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  unique (
    candidate_id,
    invitation_assessment_id
  )
);


-- ============================================================================
-- PART 5 — PRE-HIRE ATTEMPT QUESTION SNAPSHOT
-- ============================================================================

create table prehire_attempt_question_selections (
  id uuid primary key default gen_random_uuid(),

  attempt_id uuid not null
    references prehire_assessment_attempts(id)
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


-- ============================================================================
-- PART 5A — PRE-HIRE QUESTION SNAPSHOT VALIDATION
-- ============================================================================

create or replace function
wri_validate_prehire_attempt_question_selection()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_attempt_assessment_id uuid;
  v_question_assessment_id uuid;

begin

  select assessment_id
  into v_attempt_assessment_id

  from prehire_assessment_attempts

  where id =
    new.attempt_id;


  if v_attempt_assessment_id is null then

    raise exception
      'pre-hire attempt % not found',
      new.attempt_id;

  end if;


  select assessment_id
  into v_question_assessment_id

  from assessment_questions

  where id =
    new.question_id;


  if v_question_assessment_id is null then

    raise exception
      'assessment question % not found',
      new.question_id;

  end if;


  if v_question_assessment_id <>
     v_attempt_assessment_id then

    raise exception
      'assessment question % does not belong to the pre-hire attempt assessment',
      new.question_id;

  end if;


  return new;

end;
$$;


create trigger trg_prehire_question_selection_validate
before insert or update
on prehire_attempt_question_selections
for each row
execute function wri_validate_prehire_attempt_question_selection();


-- ============================================================================
-- PART 6 — PRE-HIRE ATTEMPT ANSWERS
-- ============================================================================

create table prehire_attempt_answers (
  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  attempt_id uuid not null
    references prehire_assessment_attempts(id)
    on delete cascade,

  question_id uuid not null
    references assessment_questions(id),

  response jsonb not null,

  is_correct boolean,

  answered_at timestamptz not null default now(),
  created_at timestamptz not null default now(),

  unique (
    attempt_id,
    question_id
  )
);


-- ============================================================================
-- PART 6A — PRE-HIRE ANSWER SNAPSHOT VALIDATION
-- ============================================================================

create or replace function
wri_validate_prehire_attempt_answer()
returns trigger

language plpgsql

set search_path = public

as $$

begin

  if not exists (

    select 1

    from prehire_attempt_question_selections paqs

    where paqs.attempt_id =
        new.attempt_id

      and paqs.question_id =
        new.question_id

  ) then

    raise exception
      'assessment question % does not belong to pre-hire attempt %',
      new.question_id,
      new.attempt_id;

  end if;


  return new;

end;
$$;


create trigger trg_prehire_answer_validate_snapshot
before insert or update
on prehire_attempt_answers
for each row
execute function wri_validate_prehire_attempt_answer();


-- ============================================================================
-- PART 7 — PRE-HIRE COMPETENCY RESULTS
-- ============================================================================

create table prehire_competency_results (
  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  candidate_id uuid not null
    references prehire_candidates(id)
    on delete cascade,

  attempt_id uuid not null
    references prehire_assessment_attempts(id)
    on delete cascade,

  master_competency_template_id uuid not null
    references master_competency_templates(id),

  score_percent numeric not null
    check (
      score_percent >= 0
      and score_percent <= 100
    ),

  estimated_level integer not null
    check (
      estimated_level >= 1
      and estimated_level <= 4
    ),

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  unique (
    attempt_id,
    master_competency_template_id
  )
);


-- ============================================================================
-- PART 8 — INDEXES
-- ============================================================================

create index ix_prehire_candidates_client
  on prehire_candidates (
    client_id
  );

create index ix_prehire_candidates_email
  on prehire_candidates (
    lower(email)
  );

create index ix_prehire_candidates_industry
  on prehire_candidates (
    industry_id
  );

create index ix_prehire_invitations_candidate
  on prehire_assessment_invitations (
    candidate_id
  );

create index ix_prehire_invitations_client
  on prehire_assessment_invitations (
    client_id
  );

create index ix_prehire_invitations_status
  on prehire_assessment_invitations (
    status
  );

create index ix_prehire_invitation_assessments_invitation
  on prehire_invitation_assessments (
    invitation_id
  );

create index ix_prehire_attempts_candidate
  on prehire_assessment_attempts (
    candidate_id
  );

create index ix_prehire_attempts_invitation
  on prehire_assessment_attempts (
    invitation_id
  );

create index ix_prehire_attempts_assessment
  on prehire_assessment_attempts (
    assessment_id
  );

create index ix_prehire_question_selections_attempt
  on prehire_attempt_question_selections (
    attempt_id
  );

create index ix_prehire_answers_attempt
  on prehire_attempt_answers (
    attempt_id
  );

create index ix_prehire_results_candidate
  on prehire_competency_results (
    candidate_id
  );

create index ix_prehire_results_attempt
  on prehire_competency_results (
    attempt_id
  );


-- ============================================================================
-- PART 9 — BASIC DATA SYNCHRONIZATION TRIGGERS
-- ============================================================================

-- Keep invitation client_id synchronized with the candidate.
create trigger trg_prehire_invitation_sync_client
before insert or update
on prehire_assessment_invitations
for each row
execute function wri_sync_client_from_parent(
  'prehire_candidates',
  'candidate_id'
);


-- Keep answer client_id synchronized with the parent pre-hire attempt.
create trigger trg_prehire_answer_sync_client
before insert or update
on prehire_attempt_answers
for each row
execute function wri_sync_client_from_parent(
  'prehire_assessment_attempts',
  'attempt_id'
);


-- Standard updated_at maintenance.
create trigger trg_prehire_candidates_updated_at
before update
on prehire_candidates
for each row
execute function wri_set_updated_at();


create trigger trg_prehire_invitations_updated_at
before update
on prehire_assessment_invitations
for each row
execute function wri_set_updated_at();


create trigger trg_prehire_attempts_updated_at
before update
on prehire_assessment_attempts
for each row
execute function wri_set_updated_at();


create trigger trg_prehire_results_updated_at
before update
on prehire_competency_results
for each row
execute function wri_set_updated_at();


-- ============================================================================
-- PART 9A — CONVERTED EMPLOYEE TENANT VALIDATION
-- ============================================================================

create or replace function
wri_validate_prehire_candidate_converted_employee()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_employee_client_id uuid;

begin

  if new.converted_employee_id is null then
    return new;
  end if;


  select e.client_id
  into v_employee_client_id

  from employees e

  where e.id =
    new.converted_employee_id;


  if v_employee_client_id is null then

    raise exception
      'converted employee % not found',
      new.converted_employee_id;

  end if;


  if v_employee_client_id <>
     new.client_id then

    raise exception
      'converted employee must belong to the same client as the pre-hire candidate';

  end if;


  return new;

end;
$$;


create trigger trg_prehire_candidate_validate_converted_employee
before insert or update
on prehire_candidates
for each row
execute function wri_validate_prehire_candidate_converted_employee();


-- ============================================================================
-- PART 10 — INVITATION ASSESSMENT VALIDATION
-- ============================================================================

-- Tighten pre-hire assessment eligibility to competency-level Master assessments.
create or replace function
wri_validate_prehire_invitation_assessment()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;
  v_assessment assessments;

begin

  select *
  into v_invitation

  from prehire_assessment_invitations

  where id = new.invitation_id;


  if v_invitation is null then

    raise exception
      'pre-hire invitation % not found',
      new.invitation_id;

  end if;


  select *
  into v_candidate

  from prehire_candidates

  where id = v_invitation.candidate_id;


  if v_candidate is null then

    raise exception
      'pre-hire candidate % not found',
      v_invitation.candidate_id;

  end if;


  select *
  into v_assessment

  from assessments

  where id = new.assessment_id;


  if v_assessment is null then

    raise exception
      'assessment % not found',
      new.assessment_id;

  end if;


  if v_assessment.client_id is not null then

    raise exception
      'pre-hire invitations may only use Master assessments';

  end if;


  if not v_assessment.is_current then

    raise exception
      'assessment % is not the current published version',
      new.assessment_id;

  end if;


  if v_assessment.industry_id <> v_candidate.industry_id then

    raise exception
      'assessment % does not belong to the candidate industry',
      new.assessment_id;

  end if;


  if v_assessment.type <> 'competency' then

    raise exception
      'assessment % is not a competency assessment',
      new.assessment_id;

  end if;


  if v_assessment.master_competency_template_id is null then

    raise exception
      'assessment % is not linked to a Master competency',
      new.assessment_id;

  end if;


  if v_assessment.target_level is null
     or v_assessment.target_level not between 1 and 4 then

    raise exception
      'assessment % does not have a valid target level',
      new.assessment_id;

  end if;


  if not exists (

    select 1

    from master_role_competency_requirements mrcr

    where mrcr.master_role_template_id =
      v_invitation.master_role_template_id

      and mrcr.master_competency_template_id =
        v_assessment.master_competency_template_id

      and mrcr.required_level =
        v_assessment.target_level

  ) then

    raise exception
      'assessment % does not match a required competency level for Master role %',
      new.assessment_id,
      v_invitation.master_role_template_id;

  end if;


  return new;

end;
$$;


create trigger trg_prehire_invitation_assessment_validate
before insert or update
on prehire_invitation_assessments
for each row
execute function wri_validate_prehire_invitation_assessment();


-- ============================================================================
-- PART 11 — PRE-HIRE ATTEMPT RELATIONSHIP SYNCHRONIZATION
-- ============================================================================

create or replace function
wri_sync_prehire_attempt_relationships()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_invitation_assessment prehire_invitation_assessments;
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;

begin

  select *
  into v_invitation_assessment
  from prehire_invitation_assessments
  where id = new.invitation_assessment_id;


  if v_invitation_assessment is null then
    raise exception
      'pre-hire invitation assessment % not found',
      new.invitation_assessment_id;
  end if;


  select *
  into v_invitation
  from prehire_assessment_invitations
  where id = v_invitation_assessment.invitation_id;


  if v_invitation is null then
    raise exception
      'pre-hire invitation % not found',
      v_invitation_assessment.invitation_id;
  end if;


  select *
  into v_candidate
  from prehire_candidates
  where id = v_invitation.candidate_id;


  if v_candidate is null then
    raise exception
      'pre-hire candidate % not found',
      v_invitation.candidate_id;
  end if;


  new.invitation_id :=
    v_invitation.id;

  new.candidate_id :=
    v_candidate.id;

  new.client_id :=
    v_candidate.client_id;

  new.assessment_id :=
    v_invitation_assessment.assessment_id;


  return new;

end;
$$;


create trigger trg_prehire_attempt_sync_relationships
before insert or update
on prehire_assessment_attempts
for each row
execute function wri_sync_prehire_attempt_relationships();


-- ============================================================================
-- PART 12 — PRE-HIRE RESULT RELATIONSHIP SYNCHRONIZATION
-- ============================================================================

create or replace function
wri_sync_prehire_result_relationships()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_attempt prehire_assessment_attempts;
  v_assessment assessments;

begin

  select *
  into v_attempt
  from prehire_assessment_attempts
  where id = new.attempt_id;


  if v_attempt is null then
    raise exception
      'pre-hire attempt % not found',
      new.attempt_id;
  end if;


  select *
  into v_assessment
  from assessments
  where id = v_attempt.assessment_id;


  if v_assessment is null then
    raise exception
      'assessment % not found',
      v_attempt.assessment_id;
  end if;


  if v_assessment.master_competency_template_id is null then
    raise exception
      'assessment % is not linked to a Master competency',
      v_attempt.assessment_id;
  end if;


  new.client_id :=
    v_attempt.client_id;

  new.candidate_id :=
    v_attempt.candidate_id;

  new.master_competency_template_id :=
    v_assessment.master_competency_template_id;


  return new;

end;
$$;


create trigger trg_prehire_result_sync_relationships
before insert or update
on prehire_competency_results
for each row
execute function wri_sync_prehire_result_relationships();


-- ============================================================================
-- PART 13 — ROW LEVEL SECURITY
--
-- Candidates do not receive direct table access.
-- Candidate-facing access will be provided only through token-aware
-- SECURITY DEFINER RPC functions.
-- ============================================================================

alter table prehire_candidates
enable row level security;

alter table prehire_assessment_invitations
enable row level security;

alter table prehire_invitation_assessments
enable row level security;

alter table prehire_assessment_attempts
enable row level security;

alter table prehire_attempt_question_selections
enable row level security;

alter table prehire_attempt_answers
enable row level security;

alter table prehire_competency_results
enable row level security;


-- --------------------------------------------------------------------------
-- Candidates
-- --------------------------------------------------------------------------

create policy prehire_candidates_admin_all
on prehire_candidates
for all
to public
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


-- --------------------------------------------------------------------------
-- Invitations
-- --------------------------------------------------------------------------

create policy prehire_invitations_admin_all
on prehire_assessment_invitations
for all
to public
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


-- --------------------------------------------------------------------------
-- Invitation assessments
-- --------------------------------------------------------------------------

create policy prehire_invitation_assessments_admin_all
on prehire_invitation_assessments
for all
to public
using (
  exists (
    select 1

    from prehire_assessment_invitations i

    where i.id =
      prehire_invitation_assessments.invitation_id

      and (
        wri_is_integrateu_admin()
        or i.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
)
with check (
  exists (
    select 1

    from prehire_assessment_invitations i

    where i.id =
      prehire_invitation_assessments.invitation_id

      and (
        wri_is_integrateu_admin()
        or i.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
);


-- --------------------------------------------------------------------------
-- Attempts
-- --------------------------------------------------------------------------

create policy prehire_attempts_admin_all
on prehire_assessment_attempts
for all
to public
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


-- --------------------------------------------------------------------------
-- Question selections
-- --------------------------------------------------------------------------

create policy prehire_question_selections_admin_all
on prehire_attempt_question_selections
for all
to public
using (
  exists (
    select 1

    from prehire_assessment_attempts a

    where a.id =
      prehire_attempt_question_selections.attempt_id

      and (
        wri_is_integrateu_admin()
        or a.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
)
with check (
  exists (
    select 1

    from prehire_assessment_attempts a

    where a.id =
      prehire_attempt_question_selections.attempt_id

      and (
        wri_is_integrateu_admin()
        or a.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
);


-- --------------------------------------------------------------------------
-- Answers
-- --------------------------------------------------------------------------

create policy prehire_answers_admin_all
on prehire_attempt_answers
for all
to public
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


-- --------------------------------------------------------------------------
-- Results
-- --------------------------------------------------------------------------

create policy prehire_results_admin_all
on prehire_competency_results
for all
to public
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
-- PART 14 — SECURE PRE-HIRE INVITATION TOKEN LOOKUP
-- ============================================================================

create or replace function
wri_get_prehire_invitation_by_token(
  p_token text
)
returns prehire_assessment_invitations

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;

begin

  if p_token is null
     or btrim(p_token) = '' then

    raise exception
      'pre-hire invitation token is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where token_hash =
    digest(
      p_token,
      'sha256'
    )

  limit 1;


  if v_invitation is null then

    raise exception
      'invalid pre-hire invitation token';

  end if;


  if v_invitation.status = 'revoked'
     or v_invitation.revoked_at is not null then

    raise exception
      'pre-hire invitation has been revoked';

  end if;


  if v_invitation.status = 'expired'
     or v_invitation.expires_at <= now() then

    raise exception
      'pre-hire invitation has expired';

  end if;


  return v_invitation;

end;
$$;


revoke all
on function wri_get_prehire_invitation_by_token(text)
from public, anon, authenticated;

-- ============================================================================
-- PART 15 — PRE-HIRE INVITATION ROLE VALIDATION
-- ============================================================================

create or replace function
wri_validate_prehire_invitation_role()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_candidate prehire_candidates;
  v_role master_role_templates;

begin

  select *
  into v_candidate

  from prehire_candidates

  where id = new.candidate_id;


  if v_candidate is null then

    raise exception
      'pre-hire candidate % not found',
      new.candidate_id;

  end if;


  select *
  into v_role

  from master_role_templates

  where id = new.master_role_template_id;


  if v_role is null then

    raise exception
      'Master role % not found',
      new.master_role_template_id;

  end if;


  if not v_role.is_current then

    raise exception
      'Master role % is not the current published version',
      new.master_role_template_id;

  end if;


  if v_role.status <> 'active' then

    raise exception
      'Master role % is not active',
      new.master_role_template_id;

  end if;


  if v_role.industry_id <> v_candidate.industry_id then

    raise exception
      'Master role % does not belong to the candidate industry',
      new.master_role_template_id;

  end if;


  return new;

end;
$$;


create trigger trg_prehire_invitation_validate_role
before insert or update
on prehire_assessment_invitations
for each row
execute function wri_validate_prehire_invitation_role();


-- ============================================================================
-- PART 16 — PRE-HIRE MISSING ASSESSMENT COVERAGE SNAPSHOT
-- ============================================================================

create table prehire_invitation_missing_requirements (
  id uuid primary key default gen_random_uuid(),

  invitation_id uuid not null
    references prehire_assessment_invitations(id)
    on delete cascade,

  master_competency_template_id uuid not null
    references master_competency_templates(id),

  required_level integer not null
    check (
      required_level >= 1
      and required_level <= 4
    ),

  created_at timestamptz not null default now(),

  unique (
    invitation_id,
    master_competency_template_id
  )
);


create index ix_prehire_missing_requirements_invitation
  on prehire_invitation_missing_requirements (
    invitation_id
  );


alter table prehire_invitation_missing_requirements
enable row level security;


create policy prehire_missing_requirements_admin_all
on prehire_invitation_missing_requirements
for all
to public
using (
  exists (
    select 1

    from prehire_assessment_invitations i

    where i.id =
      prehire_invitation_missing_requirements.invitation_id

      and (
        wri_is_integrateu_admin()
        or i.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
)
with check (
  exists (
    select 1

    from prehire_assessment_invitations i

    where i.id =
      prehire_invitation_missing_requirements.invitation_id

      and (
        wri_is_integrateu_admin()
        or i.client_id in (
          select wri_allowed_client_ids()
        )
      )
  )
);


-- ============================================================================
-- PART 17 — CANDIDATE IDENTITY
-- ============================================================================

create unique index ux_prehire_candidates_client_industry_email
  on prehire_candidates (
    client_id,
    industry_id,
    lower(email)
  );


-- ============================================================================
-- PART 18 — ADMIN CREATE PRE-HIRE INVITATION
-- ============================================================================

create or replace function
wri_create_prehire_invitation(
  p_client_id uuid,
  p_industry_id uuid,
  p_first_name text,
  p_last_name text,
  p_email text,
  p_master_role_template_id uuid,
  p_expires_at timestamptz,
  p_allow_partial_coverage boolean default false
)
returns table (
  candidate_id uuid,
  invitation_id uuid,
  raw_token text,
  assigned_assessment_count integer,
  missing_requirement_count integer
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_candidate_id uuid;
  v_candidate_converted_employee_id uuid;

  v_invitation_id uuid;
  v_raw_token text;

  v_role master_role_templates;

  v_assigned_count integer := 0;
  v_missing_count integer := 0;

begin

  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or p_client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to create a pre-hire invitation for client %',
      p_client_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Required values
  -- --------------------------------------------------------------------------

  if p_client_id is null then
    raise exception
      'client is required';
  end if;


  if p_industry_id is null then
    raise exception
      'industry is required';
  end if;


  if nullif(trim(p_first_name), '') is null then
    raise exception
      'candidate first name is required';
  end if;


  if nullif(trim(p_last_name), '') is null then
    raise exception
      'candidate last name is required';
  end if;


  if nullif(trim(p_email), '') is null then
    raise exception
      'candidate email is required';
  end if;


  if p_master_role_template_id is null then
    raise exception
      'Master role is required';
  end if;


  if p_expires_at is null
     or p_expires_at <= now() then

    raise exception
      'invitation expiration must be in the future';

  end if;


  -- --------------------------------------------------------------------------
  -- Master role
  -- --------------------------------------------------------------------------

  select *
  into v_role

  from master_role_templates

  where id = p_master_role_template_id;


  if v_role is null then

    raise exception
      'Master role % not found',
      p_master_role_template_id;

  end if;


  if not v_role.is_current then

    raise exception
      'Master role % is not the current published version',
      p_master_role_template_id;

  end if;


  if v_role.status <> 'active' then

    raise exception
      'Master role % is not active',
      p_master_role_template_id;

  end if;


  if v_role.industry_id <> p_industry_id then

    raise exception
      'Master role % does not belong to industry %',
      p_master_role_template_id,
      p_industry_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Existing employee guard
  --
  -- Employees already belonging to this client must use the employee
  -- assessment/readiness workflow, not the pre-hire workflow.
  -- --------------------------------------------------------------------------

  if exists (

    select 1

    from employees e

    where e.client_id =
      p_client_id

      and e.email is not null

      and lower(trim(e.email)) =
        lower(trim(p_email))

  ) then

    raise exception
      'this person is already an employee of the selected company';

  end if;


  -- --------------------------------------------------------------------------
  -- Candidate
  --
  -- Candidate identity is client + industry + normalized email.
  -- Reuse an existing candidate record within the same industry so assessment
  -- history stays together without rewriting cross-industry history.
  -- --------------------------------------------------------------------------

  insert into prehire_candidates (
    client_id,
    industry_id,
    first_name,
    last_name,
    email,
    status,
    created_by
  )

  values (
    p_client_id,
    p_industry_id,
    trim(p_first_name),
    trim(p_last_name),
    lower(trim(p_email)),
    'candidate',
    auth.uid()
  )

  on conflict (
    client_id,
    industry_id,
    (lower(email))
  )

  do update

  set
    first_name = excluded.first_name,
    last_name = excluded.last_name,
    email = excluded.email

  returning
    id,
    converted_employee_id
  into
    v_candidate_id,
    v_candidate_converted_employee_id;


  if v_candidate_converted_employee_id is not null then

    raise exception
      'candidate % has already been converted to employee %',
      v_candidate_id,
      v_candidate_converted_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Generate secure invitation token.
  --
  -- Only the SHA-256 hash is stored.
  -- The raw token is returned exactly once to the caller.
  -- --------------------------------------------------------------------------

  v_raw_token :=
    encode(
      gen_random_bytes(32),
      'hex'
    );


  insert into prehire_assessment_invitations (
    candidate_id,
    client_id,
    master_role_template_id,
    token_hash,
    status,
    expires_at,
    created_by
  )

  values (
    v_candidate_id,
    p_client_id,
    p_master_role_template_id,
    digest(
      v_raw_token,
      'sha256'
    ),
    'pending',
    p_expires_at,
    auth.uid()
  )

  returning id
  into v_invitation_id;


  -- --------------------------------------------------------------------------
  -- Reopen candidate lifecycle for this invitation.
  --
  -- A reused candidate may have completed a prior hiring cycle. Creating a
  -- fresh invitation makes them an active candidate again. If another
  -- invitation is already in progress, preserve the aggregate in-progress
  -- candidate state.
  -- --------------------------------------------------------------------------

  update prehire_candidates

  set status =
    case

      when exists (

        select 1

        from prehire_assessment_invitations other_invitation

        where other_invitation.candidate_id =
            v_candidate_id

          and other_invitation.id <>
            v_invitation_id

          and other_invitation.status =
            'in_progress'

      ) then
        'assessment_in_progress'

      else
        'candidate'

    end

  where id =
      v_candidate_id

    and converted_employee_id
      is null;


  -- --------------------------------------------------------------------------
  -- Attach every currently available assessment that exactly matches a
  -- competency requirement for the selected Master role.
  -- --------------------------------------------------------------------------

  insert into prehire_invitation_assessments (
    invitation_id,
    assessment_id,
    assessment_order
  )

  select
    v_invitation_id,
    a.id,

    row_number() over (
      order by
        mct.name,
        mrcr.required_level,
        a.id
    )::integer

  from master_role_competency_requirements mrcr

  join master_competency_templates mct
    on mct.id =
      mrcr.master_competency_template_id

  join assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.industry_id = p_industry_id
   and a.master_competency_template_id =
       mrcr.master_competency_template_id
   and a.target_level =
       mrcr.required_level

  where mrcr.master_role_template_id =
    p_master_role_template_id;


  get diagnostics
    v_assigned_count = row_count;


  -- --------------------------------------------------------------------------
  -- Snapshot any required role competency level that does not currently have
  -- a matching current assessment.
  -- --------------------------------------------------------------------------

  insert into prehire_invitation_missing_requirements (
    invitation_id,
    master_competency_template_id,
    required_level
  )

  select
    v_invitation_id,
    mrcr.master_competency_template_id,
    mrcr.required_level

  from master_role_competency_requirements mrcr

  left join assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.industry_id = p_industry_id
   and a.master_competency_template_id =
       mrcr.master_competency_template_id
   and a.target_level =
       mrcr.required_level

  where mrcr.master_role_template_id =
      p_master_role_template_id

    and a.id is null;


  get diagnostics
    v_missing_count = row_count;


  -- --------------------------------------------------------------------------
  -- Partial coverage approval
  -- --------------------------------------------------------------------------

  if v_missing_count > 0 then

    if not coalesce(
      p_allow_partial_coverage,
      false
    ) then

      raise exception
        'selected role has % required competency levels without current assessments',
        v_missing_count;

    end if;


    update prehire_assessment_invitations

    set
      partial_coverage_approved = true,
      partial_coverage_approved_by = auth.uid(),
      partial_coverage_approved_at = now()

    where id = v_invitation_id;

  end if;


  if v_assigned_count = 0 then

    raise exception
      'selected role has no available pre-hire assessments';

  end if;


  return query

  select
    v_candidate_id,
    v_invitation_id,
    v_raw_token,
    v_assigned_count,
    v_missing_count;

end;
$$;


revoke all
on function wri_create_prehire_invitation(
  uuid,
  uuid,
  text,
  text,
  text,
  uuid,
  timestamptz,
  boolean
)
from public, anon;


grant execute
on function wri_create_prehire_invitation(
  uuid,
  uuid,
  text,
  text,
  text,
  uuid,
  timestamptz,
  boolean
)
to authenticated;


-- ============================================================================
-- PART 19 — PRE-HIRE ROLE ASSESSMENT COVERAGE PREVIEW
-- ============================================================================

create or replace function
wri_get_prehire_role_assessment_coverage(
  p_client_id uuid,
  p_master_role_template_id uuid
)
returns table (
  master_role_template_id uuid,
  role_name text,
  industry_id uuid,
  master_competency_template_id uuid,
  competency_name text,
  required_level integer,
  assessment_id uuid,
  assessment_name text,
  assessment_available boolean
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_role master_role_templates;

begin

  -- --------------------------------------------------------------------------
  -- Required values
  -- --------------------------------------------------------------------------

  if p_client_id is null then
    raise exception
      'client is required';
  end if;


  if p_master_role_template_id is null then
    raise exception
      'Master role is required';
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or p_client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to view pre-hire assessment coverage for client %',
      p_client_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Master role
  -- --------------------------------------------------------------------------

  select *
  into v_role

  from master_role_templates

  where id = p_master_role_template_id;


  if v_role is null then

    raise exception
      'Master role % not found',
      p_master_role_template_id;

  end if;


  if not v_role.is_current then

    raise exception
      'Master role % is not the current published version',
      p_master_role_template_id;

  end if;


  if v_role.status <> 'active' then

    raise exception
      'Master role % is not active',
      p_master_role_template_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Coverage
  --
  -- One row per required competency level.
  -- assessment_available = false means the role requirement currently has
  -- no exact current Master competency assessment.
  -- --------------------------------------------------------------------------

  return query

  select
    v_role.id,
    v_role.name,
    v_role.industry_id,

    mrcr.master_competency_template_id,
    mct.name,
    mrcr.required_level,

    a.id,
    a.name,

    (a.id is not null)

  from master_role_competency_requirements mrcr

  join master_competency_templates mct
    on mct.id =
      mrcr.master_competency_template_id

  left join assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.industry_id =
       v_role.industry_id
   and a.master_competency_template_id =
       mrcr.master_competency_template_id
   and a.target_level =
       mrcr.required_level

  where mrcr.master_role_template_id =
      v_role.id

  order by
    mct.name,
    mrcr.required_level;

end;
$$;


revoke all
on function wri_get_prehire_role_assessment_coverage(
  uuid,
  uuid
)
from public, anon;


grant execute
on function wri_get_prehire_role_assessment_coverage(
  uuid,
  uuid
)
to authenticated;


-- ============================================================================
-- PART 20 — CANDIDATE-SAFE PRE-HIRE INVITATION SUMMARY
-- ============================================================================

create or replace function
wri_get_prehire_candidate_invitation(
  p_token text
)
returns table (
  candidate_first_name text,
  candidate_last_name text,
  role_name text,
  industry_name text,
  invitation_status text,
  expires_at timestamptz,
  assessment_count integer,
  completed_assessment_count integer
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;

begin

  -- --------------------------------------------------------------------------
  -- Resolve and validate invitation token using the internal token helper.
  -- The helper remains non-executable by anon/authenticated callers directly.
  -- --------------------------------------------------------------------------

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  -- --------------------------------------------------------------------------
  -- First successful candidate access marks the invitation opened.
  --
  -- Do not move an invitation backward once assessment work has started.
  -- --------------------------------------------------------------------------

  if v_invitation.status in (
    'pending',
    'sent'
  ) then

    update prehire_assessment_invitations

    set
      status = 'opened',
      opened_at = coalesce(
        opened_at,
        now()
      )

    where id = v_invitation.id

    returning *
    into v_invitation;

  end if;


  -- --------------------------------------------------------------------------
  -- Safe candidate-facing summary only.
  --
  -- Intentionally excluded:
  --   token_hash
  --   client_id
  --   created_by
  --   partial coverage approval metadata
  --   scores/results
  --   answer keys
  -- --------------------------------------------------------------------------

  return query

  select
    c.first_name,
    c.last_name,
    mrt.name,
    i.name,
    v_invitation.status,
    v_invitation.expires_at,

    (
      select count(*)::integer

      from prehire_invitation_assessments pia

      where pia.invitation_id =
        v_invitation.id
    ),

    (
      select count(*)::integer

      from prehire_assessment_attempts paa

      where paa.invitation_id =
        v_invitation.id

        and paa.status =
          'completed'
    )

  from prehire_candidates c

  join master_role_templates mrt
    on mrt.id =
      v_invitation.master_role_template_id

  join industries i
    on i.id =
      c.industry_id

  where c.id =
    v_invitation.candidate_id;

end;
$$;


revoke all
on function wri_get_prehire_candidate_invitation(
  text
)
from public;


grant execute
on function wri_get_prehire_candidate_invitation(
  text
)
to anon, authenticated;


-- ============================================================================
-- PART 21 — CANDIDATE-SAFE PRE-HIRE ASSESSMENT LIST
-- ============================================================================

create or replace function
wri_get_prehire_candidate_assessments(
  p_token text
)
returns table (
  invitation_assessment_id uuid,
  assessment_name text,
  assessment_order integer,
  attempt_status text
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;

begin

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  return query

  select
    pia.id,
    a.name,
    pia.assessment_order,

    coalesce(
      paa.status,
      'not_started'
    )::text

  from prehire_invitation_assessments pia

  join assessments a
    on a.id =
      pia.assessment_id

  left join prehire_assessment_attempts paa
    on paa.invitation_assessment_id =
      pia.id

   and paa.candidate_id =
      v_invitation.candidate_id

  where pia.invitation_id =
    v_invitation.id

  order by
    pia.assessment_order;

end;
$$;


revoke all
on function wri_get_prehire_candidate_assessments(
  text
)
from public;


grant execute
on function wri_get_prehire_candidate_assessments(
  text
)
to anon, authenticated;


-- ============================================================================
-- PART 22 — CANDIDATE START / RESUME PRE-HIRE ASSESSMENT
-- ============================================================================

create or replace function
wri_start_prehire_assessment(
  p_token text,
  p_invitation_assessment_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_invitation_assessment prehire_invitation_assessments;
  v_assessment assessments;

  v_attempt_id uuid;
  v_existing_attempt_id uuid;

  v_rule record;
  v_question record;

  v_order integer := 0;

  v_expected_count integer;
  v_selected_count integer;
  v_answer_key_count integer;

begin

  -- --------------------------------------------------------------------------
  -- Invitation token
  -- --------------------------------------------------------------------------

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  if exists (

    select 1

    from prehire_candidates c

    where c.id =
        v_invitation.candidate_id

      and (
        c.converted_employee_id is not null

        or c.status in (
          'under_review',
          'hired',
          'not_hired',
          'withdrawn'
        )
      )

  ) then

    raise exception
      'this pre-hire invitation is no longer available';

  end if;


  -- --------------------------------------------------------------------------
  -- Invitation assessment
  -- --------------------------------------------------------------------------

  if p_invitation_assessment_id is null then

    raise exception
      'invitation assessment is required';

  end if;


  select *
  into v_invitation_assessment

  from prehire_invitation_assessments

  where id =
    p_invitation_assessment_id

  for update;


  if v_invitation_assessment.id is null then

    raise exception
      'pre-hire invitation assessment % not found',
      p_invitation_assessment_id;

  end if;


  if v_invitation_assessment.invitation_id <>
     v_invitation.id then

    raise exception
      'assessment does not belong to this pre-hire invitation';

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *
  into v_assessment

  from assessments

  where id =
    v_invitation_assessment.assessment_id;


  if v_assessment.id is null then

    raise exception
      'assessment % not found',
      v_invitation_assessment.assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Resume existing unfinished attempt
  -- --------------------------------------------------------------------------

  select id
  into v_existing_attempt_id

  from prehire_assessment_attempts

  where candidate_id =
      v_invitation.candidate_id

    and invitation_assessment_id =
      p_invitation_assessment_id

    and status in (
      'not_started',
      'in_progress'
    )

  order by created_at desc

  limit 1;


  if v_existing_attempt_id is not null then

    return
      v_existing_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Prevent restarting terminal attempts
  -- --------------------------------------------------------------------------

  if exists (

    select 1

    from prehire_assessment_attempts

    where candidate_id =
        v_invitation.candidate_id

      and invitation_assessment_id =
        p_invitation_assessment_id

      and status =
        'completed'

  ) then

    raise exception
      'this pre-hire assessment has already been completed';

  end if;


  if exists (

    select 1

    from prehire_assessment_attempts

    where candidate_id =
        v_invitation.candidate_id

      and invitation_assessment_id =
        p_invitation_assessment_id

      and status =
        'abandoned'

  ) then

    raise exception
      'this pre-hire assessment is no longer available';

  end if;


  -- --------------------------------------------------------------------------
  -- Create attempt
  --
  -- Relationship trigger derives:
  --   candidate_id
  --   invitation_id
  --   client_id
  --   assessment_id
  -- --------------------------------------------------------------------------

  insert into prehire_assessment_attempts (
    candidate_id,
    invitation_id,
    invitation_assessment_id,
    client_id,
    assessment_id,
    status,
    started_at
  )

  values (
    v_invitation.candidate_id,
    v_invitation.id,
    p_invitation_assessment_id,
    v_invitation.client_id,
    v_assessment.id,
    'in_progress',
    now()
  )

  returning id
  into v_attempt_id;


  -- --------------------------------------------------------------------------
  -- Expected question count
  -- --------------------------------------------------------------------------

  select
    coalesce(
      sum(question_count),
      0
    )

  into v_expected_count

  from assessment_blueprint_rules

  where assessment_id =
    v_assessment.id;


  if v_expected_count = 0 then

    raise exception
      'assessment % has no blueprint rules',
      v_assessment.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Randomized question snapshot
  -- --------------------------------------------------------------------------

  for v_rule in

    select *

    from assessment_blueprint_rules

    where assessment_id =
      v_assessment.id

    order by
      sort_order,
      id

  loop

    -- FOUNDATIONAL

    for v_question in

      select q.id

      from assessment_questions q

      where q.assessment_id =
          v_assessment.id

        and q.domain =
          v_rule.domain

        and q.difficulty =
          'foundational'

        and q.source_master_question_id
          is not null

      order by random()

      limit
        v_rule.foundational_count

    loop

      v_order :=
        v_order + 1;


      insert into prehire_attempt_question_selections (
        attempt_id,
        question_id,
        question_order
      )

      values (
        v_attempt_id,
        v_question.id,
        v_order
      );

    end loop;


    -- APPLICATION

    for v_question in

      select q.id

      from assessment_questions q

      where q.assessment_id =
          v_assessment.id

        and q.domain =
          v_rule.domain

        and q.difficulty =
          'application'

        and q.source_master_question_id
          is not null

      order by random()

      limit
        v_rule.application_count

    loop

      v_order :=
        v_order + 1;


      insert into prehire_attempt_question_selections (
        attempt_id,
        question_id,
        question_order
      )

      values (
        v_attempt_id,
        v_question.id,
        v_order
      );

    end loop;


    -- SCENARIO

    for v_question in

      select q.id

      from assessment_questions q

      where q.assessment_id =
          v_assessment.id

        and q.domain =
          v_rule.domain

        and q.difficulty =
          'scenario'

        and q.source_master_question_id
          is not null

      order by random()

      limit
        v_rule.scenario_count

    loop

      v_order :=
        v_order + 1;


      insert into prehire_attempt_question_selections (
        attempt_id,
        question_id,
        question_order
      )

      values (
        v_attempt_id,
        v_question.id,
        v_order
      );

    end loop;

  end loop;


  -- --------------------------------------------------------------------------
  -- Validate question count
  -- --------------------------------------------------------------------------

  select count(*)
  into v_selected_count

  from prehire_attempt_question_selections

  where attempt_id =
    v_attempt_id;


  if v_selected_count <>
     v_expected_count then

    raise exception
      'assessment blueprint expected % questions but only % could be selected',
      v_expected_count,
      v_selected_count;

  end if;


  -- --------------------------------------------------------------------------
  -- Validate answer keys
  -- --------------------------------------------------------------------------

  select count(*)
  into v_answer_key_count

  from prehire_attempt_question_selections paqs

  join assessment_question_answer_keys k
    on k.question_id =
      paqs.question_id

  where paqs.attempt_id =
    v_attempt_id;


  if v_answer_key_count <>
     v_selected_count then

    raise exception
      'pre-hire attempt % contains selected questions without answer keys',
      v_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Lifecycle state
  -- --------------------------------------------------------------------------

  update prehire_assessment_invitations

  set
    status = 'in_progress',
    opened_at = coalesce(
      opened_at,
      now()
    ),
    started_at = coalesce(
      started_at,
      now()
    )

  where id =
    v_invitation.id

    and status in (
      'pending',
      'sent',
      'opened'
    );


  update prehire_candidates

  set status =
    'assessment_in_progress'

  where id =
    v_invitation.candidate_id

    and status in (
      'candidate',
      'assessment_in_progress'
    );


  return
    v_attempt_id;

end;
$$;


revoke all
on function wri_start_prehire_assessment(
  text,
  uuid
)
from public;


grant execute
on function wri_start_prehire_assessment(
  text,
  uuid
)
to anon, authenticated;


-- ============================================================================
-- PART 23 — CANDIDATE-SAFE PRE-HIRE ASSESSMENT QUESTIONS
-- ============================================================================

create or replace function
wri_get_prehire_assessment_questions(
  p_token text,
  p_attempt_id uuid
)
returns table (
  question_id uuid,
  question_order integer,
  question_type text,
  prompt text,
  scenario text,
  image_url text,
  options jsonb,
  response jsonb
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_attempt prehire_assessment_attempts;

begin

  -- --------------------------------------------------------------------------
  -- Invitation token
  -- --------------------------------------------------------------------------

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  -- --------------------------------------------------------------------------
  -- Attempt
  -- --------------------------------------------------------------------------

  if p_attempt_id is null then

    raise exception
      'pre-hire assessment attempt is required';

  end if;


  select *
  into v_attempt

  from prehire_assessment_attempts

  where id =
    p_attempt_id;


  if v_attempt.id is null then

    raise exception
      'pre-hire assessment attempt % not found',
      p_attempt_id;

  end if;


  if v_attempt.invitation_id <>
     v_invitation.id

     or v_attempt.candidate_id <>
        v_invitation.candidate_id then

    raise exception
      'assessment attempt does not belong to this pre-hire invitation';

  end if;


  if v_attempt.status not in (
    'not_started',
    'in_progress'
  ) then

    raise exception
      'this pre-hire assessment is not available for answering';

  end if;


  -- --------------------------------------------------------------------------
  -- Candidate-safe randomized question snapshot.
  --
  -- Intentionally excluded:
  --   answer keys
  --   is_correct
  --   points
  --   difficulty
  --   domain
  --   competency identifiers
  --   source Master question identifiers
  --   internal scoring / readiness metadata
  -- --------------------------------------------------------------------------

  return query

  select
    q.id,
    paqs.question_order,
    q.type,
    q.prompt,
    q.scenario,
    q.image_url,
    q.options,
    paa.response

  from prehire_attempt_question_selections paqs

  join assessment_questions q
    on q.id =
      paqs.question_id

  left join prehire_attempt_answers paa
    on paa.attempt_id =
      v_attempt.id

   and paa.question_id =
      q.id

  where paqs.attempt_id =
    v_attempt.id

  order by
    paqs.question_order;

end;
$$;


revoke all
on function wri_get_prehire_assessment_questions(
  text,
  uuid
)
from public;


grant execute
on function wri_get_prehire_assessment_questions(
  text,
  uuid
)
to anon, authenticated;


-- ============================================================================
-- PART 24 — CANDIDATE SAVE PRE-HIRE ANSWER
-- ============================================================================

create or replace function
wri_save_prehire_answer(
  p_token text,
  p_attempt_id uuid,
  p_question_id uuid,
  p_response jsonb
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_attempt prehire_assessment_attempts;

begin

  -- --------------------------------------------------------------------------
  -- Invitation token
  -- --------------------------------------------------------------------------

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  -- --------------------------------------------------------------------------
  -- Required values
  -- --------------------------------------------------------------------------

  if p_attempt_id is null then

    raise exception
      'pre-hire assessment attempt is required';

  end if;


  if p_question_id is null then

    raise exception
      'assessment question is required';

  end if;


  if p_response is null then

    raise exception
      'assessment response is required';

  end if;


  -- --------------------------------------------------------------------------
  -- Attempt ownership / state
  -- --------------------------------------------------------------------------

  select *
  into v_attempt

  from prehire_assessment_attempts

  where id =
    p_attempt_id;


  if v_attempt.id is null then

    raise exception
      'pre-hire assessment attempt % not found',
      p_attempt_id;

  end if;


  if v_attempt.invitation_id <>
     v_invitation.id

     or v_attempt.candidate_id <>
        v_invitation.candidate_id then

    raise exception
      'assessment attempt does not belong to this pre-hire invitation';

  end if;


  if v_attempt.status <>
     'in_progress' then

    raise exception
      'this pre-hire assessment is not available for answering';

  end if;


  -- --------------------------------------------------------------------------
  -- Question must belong to this attempt's immutable randomized snapshot.
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from prehire_attempt_question_selections paqs

    where paqs.attempt_id =
      v_attempt.id

      and paqs.question_id =
        p_question_id

  ) then

    raise exception
      'question does not belong to this pre-hire assessment attempt';

  end if;


  -- --------------------------------------------------------------------------
  -- Save response.
  --
  -- is_correct intentionally remains null here.
  -- Scoring happens only during protected final submission.
  -- --------------------------------------------------------------------------

  insert into prehire_attempt_answers (
    client_id,
    attempt_id,
    question_id,
    response,
    is_correct,
    answered_at
  )

  values (
    v_attempt.client_id,
    v_attempt.id,
    p_question_id,
    p_response,
    null,
    now()
  )

  on conflict (
    attempt_id,
    question_id
  )

  do update

  set
    response = excluded.response,
    is_correct = null,
    answered_at = now();

end;
$$;


revoke all
on function wri_save_prehire_answer(
  text,
  uuid,
  uuid,
  jsonb
)
from public;


grant execute
on function wri_save_prehire_answer(
  text,
  uuid,
  uuid,
  jsonb
)
to anon, authenticated;


-- ============================================================================
-- PART 25 — CANDIDATE SUBMIT / SCORE PRE-HIRE ASSESSMENT
-- ============================================================================

create or replace function
wri_submit_prehire_assessment(
  p_token text,
  p_attempt_id uuid
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_attempt prehire_assessment_attempts;
  v_assessment assessments;

  v_selected_question_count integer;
  v_answered_question_count integer;

  v_score_percent numeric;
  v_estimated_level integer;

  v_total_assessment_count integer;
  v_completed_assessment_count integer;

begin

  -- --------------------------------------------------------------------------
  -- Invitation token
  -- --------------------------------------------------------------------------

  select *
  into v_invitation

  from wri_get_prehire_invitation_by_token(
    p_token
  );


  if v_invitation.id is null then

    raise exception
      'invalid or unavailable pre-hire invitation';

  end if;


  -- --------------------------------------------------------------------------
  -- Attempt
  -- --------------------------------------------------------------------------

  if p_attempt_id is null then

    raise exception
      'pre-hire assessment attempt is required';

  end if;


  select *
  into v_attempt

  from prehire_assessment_attempts

  where id =
    p_attempt_id

  for update;


  if v_attempt.id is null then

    raise exception
      'pre-hire assessment attempt % not found',
      p_attempt_id;

  end if;


  if v_attempt.invitation_id <>
     v_invitation.id

     or v_attempt.candidate_id <>
        v_invitation.candidate_id then

    raise exception
      'assessment attempt does not belong to this pre-hire invitation';

  end if;


  if v_attempt.status = 'completed' then

    raise exception
      'this pre-hire assessment has already been submitted';

  end if;


  if v_attempt.status = 'abandoned' then

    raise exception
      'this pre-hire assessment is no longer available';

  end if;


  if v_attempt.status <>
     'in_progress' then

    raise exception
      'this pre-hire assessment is not available for submission';

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *
  into v_assessment

  from assessments

  where id =
    v_attempt.assessment_id;


  if v_assessment.id is null then

    raise exception
      'assessment for pre-hire attempt % not found',
      p_attempt_id;

  end if;


  if v_assessment.master_competency_template_id is null then

    raise exception
      'pre-hire assessment % is not linked to a Master competency',
      v_assessment.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Validate randomized question snapshot
  -- --------------------------------------------------------------------------

  select count(*)
  into v_selected_question_count

  from prehire_attempt_question_selections

  where attempt_id =
    v_attempt.id;


  if v_selected_question_count = 0 then

    raise exception
      'pre-hire attempt % has no selected questions',
      v_attempt.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Require every selected question to have an answer
  -- --------------------------------------------------------------------------

  select count(*)
  into v_answered_question_count

  from prehire_attempt_answers paa

  join prehire_attempt_question_selections paqs
    on paqs.attempt_id =
      paa.attempt_id

   and paqs.question_id =
      paa.question_id

  where paa.attempt_id =
    v_attempt.id;


  if v_answered_question_count <>
     v_selected_question_count then

    raise exception
      'pre-hire assessment is incomplete: % of % questions answered',
      v_answered_question_count,
      v_selected_question_count;

  end if;


  -- --------------------------------------------------------------------------
  -- Secure answer comparison.
  --
  -- Mirrors the canonical employee assessment scorer:
  --   array key   vs array response
  --   scalar key  vs single-item array response
  --   scalar key  vs scalar response
  -- --------------------------------------------------------------------------

  update prehire_attempt_answers paa

  set is_correct = (

    select

      case

        when jsonb_typeof(k.correct_answer) =
          'array'

        then (

          select array_agg(x order by x)

          from jsonb_array_elements_text(
            k.correct_answer
          ) x

        ) = (

          select array_agg(y order by y)

          from jsonb_array_elements_text(
            paa.response
          ) y

        )


        when jsonb_typeof(paa.response) =
             'array'

         and jsonb_array_length(
           paa.response
         ) = 1

        then
          k.correct_answer =
            paa.response -> 0


        else
          k.correct_answer =
            paa.response

      end

    from assessment_question_answer_keys k

    where k.question_id =
      paa.question_id

  )

  where paa.attempt_id =
    v_attempt.id;


  -- --------------------------------------------------------------------------
  -- No missing answer keys allowed
  -- --------------------------------------------------------------------------

  if exists (

    select 1

    from prehire_attempt_answers

    where attempt_id =
      v_attempt.id

      and is_correct is null

  ) then

    raise exception
      'pre-hire attempt % contains one or more questions without a valid answer key',
      v_attempt.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Weighted score and estimated knowledge level.
  --
  -- Same scoring standard as employee assessments:
  --
  --   score % = correct weighted points / total weighted points
  --   level   = ceil(4 × weighted ratio), clamped to 1–4
  -- --------------------------------------------------------------------------

  select

    round(
      100.0
      * sum(
          case
            when paa.is_correct
            then q.points
            else 0
          end
        )
      / nullif(
          sum(q.points),
          0
        ),
      1
    ),

    least(
      4,
      greatest(
        1,
        ceil(
          4.0
          * sum(
              case
                when paa.is_correct
                then q.points
                else 0
              end
            )
          / nullif(
              sum(q.points),
              0
            )
        )::integer
      )
    )

  into
    v_score_percent,
    v_estimated_level

  from prehire_attempt_answers paa

  join prehire_attempt_question_selections paqs
    on paqs.attempt_id =
      paa.attempt_id

   and paqs.question_id =
      paa.question_id

  join assessment_questions q
    on q.id =
      paa.question_id

  where paa.attempt_id =
    v_attempt.id;


  if v_score_percent is null
     or v_estimated_level is null then

    raise exception
      'pre-hire attempt % could not be scored',
      v_attempt.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Persist internal pre-hire competency result.
  --
  -- Relationship trigger derives client_id, candidate_id, and the Master
  -- competency from the attempt / assessment relationship.
  --
  -- This does NOT create employee competency evidence or readiness.
  -- --------------------------------------------------------------------------

  insert into prehire_competency_results (
    client_id,
    candidate_id,
    attempt_id,
    master_competency_template_id,
    score_percent,
    estimated_level
  )

  values (
    v_attempt.client_id,
    v_attempt.candidate_id,
    v_attempt.id,
    v_assessment.master_competency_template_id,
    v_score_percent,
    v_estimated_level
  )

  on conflict (
    attempt_id,
    master_competency_template_id
  )

  do update

  set
    score_percent = excluded.score_percent,
    estimated_level = excluded.estimated_level,
    updated_at = now();


  -- --------------------------------------------------------------------------
  -- Complete this assessment attempt
  -- --------------------------------------------------------------------------

  update prehire_assessment_attempts

  set
    status = 'completed',
    completed_at = now()

  where id =
    v_attempt.id;


  -- --------------------------------------------------------------------------
  -- Determine invitation-level completion
  -- --------------------------------------------------------------------------

  select count(*)::integer
  into v_total_assessment_count

  from prehire_invitation_assessments

  where invitation_id =
    v_invitation.id;


  select count(*)::integer
  into v_completed_assessment_count

  from prehire_assessment_attempts

  where invitation_id =
      v_invitation.id

    and status =
      'completed';


  if v_total_assessment_count > 0

     and v_completed_assessment_count =
         v_total_assessment_count then

    update prehire_assessment_invitations

    set
      status = 'completed',
      completed_at = coalesce(
        completed_at,
        now()
      )

    where id =
      v_invitation.id;


    update prehire_candidates

    set status =
      case

        when exists (

          select 1

          from prehire_assessment_invitations other_invitation

          where other_invitation.candidate_id =
              v_invitation.candidate_id

            and other_invitation.id <>
              v_invitation.id

            and other_invitation.status in (
              'pending',
              'sent',
              'opened',
              'in_progress'
            )

        ) then
          'assessment_in_progress'

        else
          'assessment_completed'

      end

    where id =
      v_invitation.candidate_id

      and converted_employee_id is null;

  else

    update prehire_assessment_invitations

    set status =
      'in_progress'

    where id =
      v_invitation.id

      and status <>
        'completed';


    update prehire_candidates

    set status =
      'assessment_in_progress'

    where id =
      v_invitation.candidate_id

      and converted_employee_id is null;

  end if;

end;
$$;


revoke all
on function wri_submit_prehire_assessment(
  text,
  uuid
)
from public;


grant execute
on function wri_submit_prehire_assessment(
  text,
  uuid
)
to anon, authenticated;


-- ============================================================================
-- PART 26 — ADMIN PRE-HIRE ASSESSMENT REVIEW
-- ============================================================================

create or replace function
wri_get_prehire_assessment_review(
  p_invitation_id uuid
)
returns table (
  candidate_id uuid,
  candidate_first_name text,
  candidate_last_name text,
  candidate_email text,

  master_role_template_id uuid,
  role_name text,

  master_competency_template_id uuid,
  competency_name text,
  competency_category text,
  is_critical boolean,

  required_level integer,

  invitation_assessment_id uuid,
  assessment_id uuid,
  assessment_name text,

  attempt_id uuid,
  attempt_status text,

  score_percent numeric,
  estimated_level integer,

  meets_required_level boolean,
  coverage_status text
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;
  v_role master_role_templates;

begin

  -- --------------------------------------------------------------------------
  -- Required invitation
  -- --------------------------------------------------------------------------

  if p_invitation_id is null then

    raise exception
      'pre-hire invitation is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where id =
    p_invitation_id;


  if v_invitation.id is null then

    raise exception
      'pre-hire invitation % not found',
      p_invitation_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or v_invitation.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to review pre-hire invitation %',
      p_invitation_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Candidate
  -- --------------------------------------------------------------------------

  select *
  into v_candidate

  from prehire_candidates

  where id =
    v_invitation.candidate_id;


  if v_candidate.id is null then

    raise exception
      'candidate % not found',
      v_invitation.candidate_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Target Master role
  -- --------------------------------------------------------------------------

  select *
  into v_role

  from master_role_templates

  where id =
    v_invitation.master_role_template_id;


  if v_role.id is null then

    raise exception
      'Master role % not found',
      v_invitation.master_role_template_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Complete admin review.
  --
  -- One row per role competency requirement.
  --
  -- coverage_status:
  --
  --   missing_assessment
  --     No exact assessment existed when this invitation was created.
  --
  --   not_started
  --     Assessment assigned but candidate has not started it.
  --
  --   in_progress
  --     Candidate has an unfinished attempt.
  --
  --   completed
  --     Internal score / estimated level is available.
  --
  --   abandoned
  --     Attempt exists but is no longer available to the candidate.
  --
  -- Pre-hire knowledge is intentionally NOT written to employee readiness.
  -- --------------------------------------------------------------------------

  return query

  select
    v_candidate.id,
    v_candidate.first_name,
    v_candidate.last_name,
    v_candidate.email,

    v_role.id,
    v_role.name,

    mrcr.master_competency_template_id,
    mct.name,
    mct.category,
    mct.is_critical,

    mrcr.required_level,

    pia.id,
    a.id,
    a.name,

    paa.id,
    coalesce(
      paa.status,
      'not_started'
    )::text,

    pcr.score_percent,
    pcr.estimated_level,

    case

      when pcr.estimated_level is null
        then null

      else
        pcr.estimated_level >=
          mrcr.required_level

    end,

    case

      when pmr.id is not null
        then 'missing_assessment'

      when pia.id is null
        then 'missing_assessment'

      when paa.id is null
        then 'not_started'

      when paa.status = 'completed'
        then 'completed'

      when paa.status = 'in_progress'
        then 'in_progress'

      when paa.status = 'not_started'
        then 'not_started'

      when paa.status = 'abandoned'
        then 'abandoned'

      else
        paa.status

    end::text

  from master_role_competency_requirements mrcr

  join master_competency_templates mct
    on mct.id =
      mrcr.master_competency_template_id

  left join prehire_invitation_missing_requirements pmr
    on pmr.invitation_id =
      v_invitation.id

   and pmr.master_competency_template_id =
      mrcr.master_competency_template_id

   and pmr.required_level =
      mrcr.required_level

  left join prehire_invitation_assessments pia
    on pia.invitation_id =
      v_invitation.id

   and exists (

     select 1

     from assessments pia_assessment

     where pia_assessment.id =
       pia.assessment_id

       and pia_assessment.master_competency_template_id =
         mrcr.master_competency_template_id

       and pia_assessment.target_level =
         mrcr.required_level
   )

  left join assessments a
    on a.id =
      pia.assessment_id

  left join prehire_assessment_attempts paa
    on paa.invitation_assessment_id =
      pia.id

   and paa.candidate_id =
      v_candidate.id

  left join prehire_competency_results pcr
    on pcr.attempt_id =
      paa.id

   and pcr.master_competency_template_id =
      mrcr.master_competency_template_id

  where mrcr.master_role_template_id =
    v_role.id

  order by
    mct.category nulls last,
    mct.name,
    mrcr.required_level;

end;
$$;


revoke all
on function wri_get_prehire_assessment_review(
  uuid
)
from public, anon;


grant execute
on function wri_get_prehire_assessment_review(
  uuid
)
to authenticated;


-- ============================================================================
-- PART 27 — COMPANY ADMIN TENANT ISOLATION
-- ============================================================================

create unique index ux_user_client_roles_one_active_client_admin
  on user_client_roles (
    user_id
  )
  where role = 'CLIENT_ADMIN'
    and status = 'active';


-- ============================================================================
-- PART 28 — HARDEN WRI TENANT AUTHORIZATION HELPERS
-- ============================================================================

create or replace function
wri_allowed_client_ids()
returns setof uuid

language sql

stable

security definer

set search_path = public

as $$

  select distinct
    ucr.client_id

  from user_client_roles ucr

  where ucr.user_id =
      auth.uid()

    and ucr.role =
      'CLIENT_ADMIN'

    and lower(ucr.status) =
      'active'

    and ucr.client_id
      is not null;

$$;


create or replace function
wri_is_integrateu_admin()
returns boolean

language sql

stable

security definer

set search_path = public

as $$

  select exists (

    select 1

    from user_client_roles ucr

    where ucr.user_id =
        auth.uid()

      and ucr.role in (
        'INTEGRATEU_ADMIN',
        'INTEGRATEU_SUPER_ADMIN'
      )

      and lower(ucr.status) =
        'active'

      and ucr.client_id
        is null

  );

$$;


-- ============================================================================
-- PART 29 — HARDEN GLOBAL / CLIENT WORKFORCE AUTHORIZATION
-- ============================================================================

create or replace function
is_integrateu_admin(
  uid uuid
)
returns boolean

language sql

stable

as $$

  select exists (

    select 1

    from public.user_client_roles ucr

    where ucr.user_id = uid

      and ucr.client_id is null

      and lower(ucr.status) =
        'active'

      and ucr.role in (
        'INTEGRATEU_SUPER_ADMIN',
        'INTEGRATEU_ADMIN'
      )

  );

$$;


create or replace function
can_admin_execution(
  uid uuid,
  cid uuid
)
returns boolean

language sql

stable

as $$

  select
    public.is_integrateu_admin(uid)

    or public.is_client_role(
      uid,
      cid,
      array['INTEGRATEU_ADMIN']
    );

$$;


create or replace function
can_read_execution_broad(
  uid uuid,
  cid uuid
)
returns boolean

language sql

stable

as $$

  select
    public.is_integrateu_admin(uid)

    or public.is_client_role(
      uid,
      cid,
      array[
        'INTEGRATEU_ADMIN',
        'CLIENT_ADMIN'
      ]
    );

$$;


-- ============================================================================
-- PART 30 — CLIENT MASTER ROLE MAPPING
-- ============================================================================

create table client_master_role_mappings (
  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id)
    on delete cascade,

  master_role_template_id uuid not null
    references master_role_templates(id),

  role_id uuid not null,

  created_by uuid,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint client_master_role_mappings_role_client_fkey
    foreign key (
      role_id,
      client_id
    )
    references roles (
      id,
      client_id
    ),

  unique (
    client_id,
    master_role_template_id
  ),

  unique (
    client_id,
    role_id
  )
);


create index ix_client_master_role_mappings_role
  on client_master_role_mappings (
    role_id
  );


create or replace function
wri_validate_client_master_role_mapping()
returns trigger

language plpgsql

set search_path = public

as $$

declare
  v_master_role master_role_templates;
  v_role roles;

begin

  select *
  into v_master_role

  from master_role_templates

  where id =
    new.master_role_template_id;


  if v_master_role.id is null then

    raise exception
      'Master role % not found',
      new.master_role_template_id;

  end if;


  if not v_master_role.is_current then

    raise exception
      'Master role % is not the current published version',
      new.master_role_template_id;

  end if;


  if v_master_role.status <>
     'active' then

    raise exception
      'Master role % is not active',
      new.master_role_template_id;

  end if;


  select *
  into v_role

  from roles

  where id =
      new.role_id

    and client_id =
      new.client_id;


  if v_role.id is null then

    raise exception
      'company role % does not belong to client %',
      new.role_id,
      new.client_id;

  end if;


  if upper(v_role.status) <>
     'ACTIVE' then

    raise exception
      'company role % is not active',
      new.role_id;

  end if;


  return new;

end;
$$;


create trigger trg_client_master_role_mappings_validate
before insert or update
on client_master_role_mappings
for each row
execute function wri_validate_client_master_role_mapping();


create trigger trg_client_master_role_mappings_updated_at
before update
on client_master_role_mappings
for each row
execute function wri_set_updated_at();


alter table client_master_role_mappings
enable row level security;


create policy client_master_role_mappings_select
on client_master_role_mappings
for select
to public
using (
  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )
);


create policy client_master_role_mappings_insert
on client_master_role_mappings
for insert
to public
with check (
  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )
);


create policy client_master_role_mappings_update
on client_master_role_mappings
for update
to public
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
-- PART 31 — CONVERT PRE-HIRE CANDIDATE TO EMPLOYEE
-- ============================================================================

create or replace function
wri_convert_prehire_candidate_to_employee(
  p_invitation_id uuid,
  p_employee_number text default null,
  p_hire_date date default current_date
)
returns table (
  employee_id uuid,
  role_assignment_id uuid
)

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;

  v_mapping client_master_role_mappings;
  v_role roles;

  v_employee_id uuid;
  v_role_assignment_id uuid;

begin

  -- --------------------------------------------------------------------------
  -- Invitation
  -- --------------------------------------------------------------------------

  if p_invitation_id is null then

    raise exception
      'pre-hire invitation is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where id =
    p_invitation_id

  for update;


  if v_invitation.id is null then

    raise exception
      'pre-hire invitation % not found',
      p_invitation_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or v_invitation.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to convert this pre-hire candidate';

  end if;


  -- --------------------------------------------------------------------------
  -- Completed pre-hire assessment required
  -- --------------------------------------------------------------------------

  if v_invitation.status <>
     'completed' then

    raise exception
      'pre-hire assessment must be completed before conversion';

  end if;


  -- --------------------------------------------------------------------------
  -- Candidate
  -- --------------------------------------------------------------------------

  select *
  into v_candidate

  from prehire_candidates

  where id =
    v_invitation.candidate_id

  for update;


  if v_candidate.id is null then

    raise exception
      'pre-hire candidate % not found',
      v_invitation.candidate_id;

  end if;


  if v_candidate.converted_employee_id
     is not null then

    raise exception
      'candidate % has already been converted to employee %',
      v_candidate.id,
      v_candidate.converted_employee_id;

  end if;


  if v_candidate.status <>
     'under_review' then

    raise exception
      'candidate must be under review before conversion to employee';

  end if;


  -- --------------------------------------------------------------------------
  -- Master role -> company role mapping
  -- --------------------------------------------------------------------------

  select *
  into v_mapping

  from client_master_role_mappings

  where client_id =
      v_invitation.client_id

    and master_role_template_id =
      v_invitation.master_role_template_id;


  if v_mapping.id is null then

    raise exception
      'selected Master role has not been mapped to a company role';

  end if;


  select *
  into v_role

  from roles

  where id =
      v_mapping.role_id

    and client_id =
      v_invitation.client_id;


  if v_role.id is null then

    raise exception
      'mapped company role % not found',
      v_mapping.role_id;

  end if;


  if upper(v_role.status) <>
     'ACTIVE' then

    raise exception
      'mapped company role % is not active',
      v_role.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Prevent duplicate employee creation
  -- --------------------------------------------------------------------------

  if exists (

    select 1

    from employees e

    where e.client_id =
      v_invitation.client_id

      and e.email is not null

      and lower(trim(e.email)) =
        lower(trim(v_candidate.email))

  ) then

    raise exception
      'an employee with this email already exists in the company';

  end if;


  -- --------------------------------------------------------------------------
  -- Create employee
  --
  -- auth_user_id intentionally remains null.
  -- Account/login provisioning is a separate controlled workflow.
  -- --------------------------------------------------------------------------

  insert into employees (
    client_id,
    auth_user_id,
    first_name,
    last_name,
    email,
    employee_number,
    hire_date,
    status
  )

  values (
    v_invitation.client_id,
    null,
    v_candidate.first_name,
    v_candidate.last_name,
    lower(trim(v_candidate.email)),
    nullif(
      trim(p_employee_number),
      ''
    ),
    coalesce(
      p_hire_date,
      current_date
    ),
    'ACTIVE'
  )

  returning id
  into v_employee_id;


  -- --------------------------------------------------------------------------
  -- Assign company role
  -- --------------------------------------------------------------------------

  insert into employee_role_assignments (
    client_id,
    employee_id,
    role_id,
    is_primary,
    status,
    effective_start_date
  )

  values (
    v_invitation.client_id,
    v_employee_id,
    v_mapping.role_id,
    true,
    'ACTIVE',
    coalesce(
      p_hire_date,
      current_date
    )
  )

  returning id
  into v_role_assignment_id;


  -- --------------------------------------------------------------------------
  -- Convert candidate
  --
  -- Pre-hire scores remain pre-hire evidence only.
  -- No competency_scores, competency_evidence, or readiness rows are created.
  -- --------------------------------------------------------------------------

  update prehire_candidates

  set
    status = 'hired',
    converted_employee_id = v_employee_id,
    converted_at = now()

  where id =
    v_candidate.id;


  -- --------------------------------------------------------------------------
  -- Candidate is now an employee.
  -- Revoke any other unfinished invitations for this candidate.
  -- --------------------------------------------------------------------------

  update prehire_assessment_invitations

  set
    status = 'revoked',
    revoked_at = coalesce(
      revoked_at,
      now()
    )

  where candidate_id =
      v_candidate.id

    and id <>
      v_invitation.id

    and status in (
      'pending',
      'sent',
      'opened',
      'in_progress'
    );


  return query

  select
    v_employee_id,
    v_role_assignment_id;

end;
$$;


revoke all
on function wri_convert_prehire_candidate_to_employee(
  uuid,
  text,
  date
)
from public, anon;


grant execute
on function wri_convert_prehire_candidate_to_employee(
  uuid,
  text,
  date
)
to authenticated;


-- ============================================================================
-- PART 32 — ADMIN BEGIN PRE-HIRE REVIEW
-- ============================================================================

create or replace function
wri_begin_prehire_candidate_review(
  p_invitation_id uuid
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;

begin

  if p_invitation_id is null then

    raise exception
      'pre-hire invitation is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where id =
    p_invitation_id;


  if v_invitation.id is null then

    raise exception
      'pre-hire invitation % not found',
      p_invitation_id;

  end if;


  if not (
    wri_is_integrateu_admin()

    or v_invitation.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to review this pre-hire candidate';

  end if;


  if v_invitation.status <>
     'completed' then

    raise exception
      'pre-hire assessment must be completed before review';

  end if;


  select *
  into v_candidate

  from prehire_candidates

  where id =
    v_invitation.candidate_id

  for update;


  if v_candidate.id is null then

    raise exception
      'pre-hire candidate % not found',
      v_invitation.candidate_id;

  end if;


  if v_candidate.converted_employee_id
     is not null then

    raise exception
      'candidate has already been converted to an employee';

  end if;


  if v_candidate.status not in (
    'assessment_completed',
    'under_review'
  ) then

    raise exception
      'candidate is not available for pre-hire review';

  end if;


  update prehire_candidates

  set status =
    'under_review'

  where id =
    v_candidate.id;

end;
$$;


revoke all
on function wri_begin_prehire_candidate_review(
  uuid
)
from public, anon;


grant execute
on function wri_begin_prehire_candidate_review(
  uuid
)
to authenticated;


-- ============================================================================
-- PART 33 — PRESERVE PRE-HIRE HISTORY
-- ============================================================================
--
-- Pre-hire records are historical evidence and must not be deleted through
-- normal application roles. Existing admin policies continue to govern
-- SELECT / INSERT / UPDATE. These restrictive policies block direct DELETE.
-- ============================================================================

create policy prehire_candidates_no_delete
on prehire_candidates
as restrictive
for delete
to public
using (false);


create policy prehire_invitations_no_delete
on prehire_assessment_invitations
as restrictive
for delete
to public
using (false);


create policy prehire_invitation_assessments_no_delete
on prehire_invitation_assessments
as restrictive
for delete
to public
using (false);


create policy prehire_attempts_no_delete
on prehire_assessment_attempts
as restrictive
for delete
to public
using (false);


create policy prehire_question_selections_no_delete
on prehire_attempt_question_selections
as restrictive
for delete
to public
using (false);


create policy prehire_answers_no_delete
on prehire_attempt_answers
as restrictive
for delete
to public
using (false);


create policy prehire_results_no_delete
on prehire_competency_results
as restrictive
for delete
to public
using (false);


create policy prehire_missing_requirements_no_delete
on prehire_invitation_missing_requirements
as restrictive
for delete
to public
using (false);


-- ============================================================================
-- PART 34 — BLOCK DIRECT ANONYMOUS TABLE ACCESS
-- ============================================================================
--
-- Candidate access is RPC-only. Anonymous users must never query or mutate
-- pre-hire tables directly, even though project default privileges grant
-- table access to anon when new tables are created.
-- ============================================================================

revoke all
on table
  prehire_candidates,
  prehire_assessment_invitations,
  prehire_invitation_assessments,
  prehire_assessment_attempts,
  prehire_attempt_question_selections,
  prehire_attempt_answers,
  prehire_competency_results,
  prehire_invitation_missing_requirements,
  client_master_role_mappings
from anon;


-- ============================================================================
-- PART 35 — REQUIRE RPCS FOR AUTHENTICATED PRE-HIRE MUTATIONS
-- ============================================================================
--
-- Authenticated admins may read tenant-authorized pre-hire records through RLS,
-- but workflow mutations must pass through the protected SECURITY DEFINER RPCs.
--
-- client_master_role_mappings is intentionally excluded until its management
-- workflow/RPC is finalized.
-- ============================================================================

revoke
  insert,
  update,
  delete,
  truncate,
  references,
  trigger
on table
  prehire_candidates,
  prehire_assessment_invitations,
  prehire_invitation_assessments,
  prehire_assessment_attempts,
  prehire_attempt_question_selections,
  prehire_attempt_answers,
  prehire_competency_results,
  prehire_invitation_missing_requirements
from authenticated;


grant select
on table
  prehire_candidates,
  prehire_assessment_invitations,
  prehire_invitation_assessments,
  prehire_assessment_attempts,
  prehire_attempt_question_selections,
  prehire_attempt_answers,
  prehire_competency_results,
  prehire_invitation_missing_requirements
to authenticated;

-- ---------------------------------------------------------------------------
-- PART 36 — HARDEN CLIENT MASTER ROLE MAPPING PRIVILEGES
-- ---------------------------------------------------------------------------

-- Mapping management is intentionally available to authenticated tenant admins
-- through RLS, but destructive/bypass privileges are not required.
revoke delete, truncate, references, trigger
on table public.client_master_role_mappings
from authenticated;
