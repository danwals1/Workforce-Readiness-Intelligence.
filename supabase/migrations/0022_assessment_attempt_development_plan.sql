-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0022_assessment_attempt_development_plan.sql
--
-- PURPOSE
--
-- Permanently connect a reassessment attempt to the Development Plan that
-- initiated it.
--
-- FLOW
--
-- Development Plan
--      ↓
-- Reassess Employee
--      ↓
-- Assessment Attempt
--      ↓
-- assessment_attempts.development_plan_id
--      ↓
-- Results / Readiness Recalculation
--      ↓
-- Development Plan Resolution Refresh
--
-- ============================================================================


-- ============================================================================
-- PART 1 — ADD DEVELOPMENT PLAN RELATIONSHIP
-- ============================================================================

alter table assessment_attempts
add column if not exists development_plan_id uuid;


alter table assessment_attempts
drop constraint if exists
  assessment_attempts_development_plan_id_fkey;


alter table assessment_attempts
add constraint
  assessment_attempts_development_plan_id_fkey
foreign key (
  development_plan_id
)
references development_plans(id)
on delete set null;


create index if not exists
  assessment_attempts_development_plan_idx
on assessment_attempts(
  development_plan_id
);


-- ============================================================================
-- PART 2 — VALIDATE PLAN / EMPLOYEE / ASSESSMENT RELATIONSHIP
-- ============================================================================

create or replace function
wri_validate_assessment_development_plan(
  p_employee_id uuid,
  p_assessment_id uuid,
  p_development_plan_id uuid
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan development_plans%rowtype;

begin

  if p_development_plan_id is null then
    return;
  end if;


  select *

  into v_plan

  from development_plans

  where id =
    p_development_plan_id;


  if not found then

    raise exception
      'development plan % not found',
      p_development_plan_id;

  end if;


  if v_plan.employee_id <>
     p_employee_id then

    raise exception
      'development plan % does not belong to employee %',
      p_development_plan_id,
      p_employee_id;

  end if;


  if v_plan.status =
     'cancelled' then

    raise exception
      'development plan % is cancelled',
      p_development_plan_id;

  end if;


  if v_plan.resolution_status not in (
    'awaiting_reassessment',
    'development_in_progress'
  ) then

    raise exception
      'development plan % is not awaiting reassessment',
      p_development_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- If the plan originated from a readiness action, confirm its assessment
  -- still matches the assessment being started.
  -- --------------------------------------------------------------------------

  if v_plan.action_key is not null then

    if not exists (

      select 1

      from v_readiness_action_queue q

      where q.action_key =
        v_plan.action_key

        and q.employee_id =
          p_employee_id

        and q.assessment_id =
          p_assessment_id

    ) then

      raise exception
        'assessment % does not match the active readiness action for development plan %',
        p_assessment_id,
        p_development_plan_id;

    end if;

  end if;

end;

$$;


-- ============================================================================
-- PART 3 — REPLACE STANDARD TWO-ARG START FUNCTION
--
-- IMPORTANT
--
-- Standard/self assessment attempts only resume OTHER standard attempts.
--
-- A reassessment connected to a Development Plan will no longer be accidentally
-- resumed by the normal learner flow.
-- ============================================================================

create or replace function
wri_start_master_assessment(
  p_employee_id uuid,
  p_assessment_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_employee employees;
  v_assessment assessments;

  v_attempt_id uuid;
  v_existing_attempt_id uuid;

  v_rule record;
  v_question record;

  v_order int := 0;

  v_expected_count int;
  v_selected_count int;
  v_answer_key_count int;

begin

  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select *

  into v_employee

  from employees

  where id =
    p_employee_id;


  if v_employee is null then

    raise exception
      'employee % not found',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (

    wri_is_integrateu_admin()

    or v_employee.client_id in (
      select wri_allowed_client_ids()
    )

    or v_employee.auth_user_id =
      auth.uid()

  ) then

    raise exception
      'not authorized to start assessment for employee %',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *

  into v_assessment

  from assessments

  where id =
    p_assessment_id;


  if v_assessment is null then

    raise exception
      'assessment % not found',
      p_assessment_id;

  end if;


  if v_assessment.client_id is not null then

    raise exception
      'wri_start_master_assessment only accepts template-mode assessments';

  end if;


  if not v_assessment.is_current then

    raise exception
      'assessment % is not the current published version',
      p_assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Resume only STANDARD unfinished attempts.
  --
  -- Development-plan reassessments are intentionally excluded.
  -- --------------------------------------------------------------------------

  select id

  into v_existing_attempt_id

  from assessment_attempts

  where employee_id =
      p_employee_id

    and assessment_id =
      p_assessment_id

    and development_plan_id
      is null

    and status in (
      'not_started',
      'in_progress'
    )

  order by created_at desc

  limit 1;


  if v_existing_attempt_id
     is not null then

    return
      v_existing_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Create standard attempt
  -- --------------------------------------------------------------------------

  insert into assessment_attempts (

    client_id,
    employee_id,
    assessment_id,
    role_id,

    development_plan_id,

    status,
    started_at,
    created_by

  )

  values (

    v_employee.client_id,
    p_employee_id,
    p_assessment_id,
    null,

    null,

    'in_progress',
    now(),
    auth.uid()

  )

  returning id
  into v_attempt_id;


  -- --------------------------------------------------------------------------
  -- Expected total from blueprint
  -- --------------------------------------------------------------------------

  select
    coalesce(
      sum(question_count),
      0
    )

  into v_expected_count

  from assessment_blueprint_rules

  where assessment_id =
    p_assessment_id;


  if v_expected_count = 0 then

    raise exception
      'assessment % has no blueprint rules',
      p_assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Build randomized question snapshot
  -- --------------------------------------------------------------------------

  for v_rule in

    select *

    from assessment_blueprint_rules

    where assessment_id =
      p_assessment_id

    order by
      sort_order,
      id

  loop

    -- FOUNDATIONAL

    for v_question in

      select q.id

      from assessment_questions q

      where q.assessment_id =
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
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
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
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
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
        v_attempt_id,
        v_question.id,
        v_order

      );

    end loop;

  end loop;


  -- --------------------------------------------------------------------------
  -- Validate selection count
  -- --------------------------------------------------------------------------

  select count(*)

  into v_selected_count

  from attempt_question_selections

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

  from attempt_question_selections aqs

  join assessment_question_answer_keys k
    on k.question_id =
      aqs.question_id

  where aqs.attempt_id =
    v_attempt_id;


  if v_answer_key_count <>
     v_selected_count then

    raise exception
      'attempt % contains selected questions without answer keys',
      v_attempt_id;

  end if;


  return
    v_attempt_id;

end;

$$;


-- ============================================================================
-- PART 4 — DEVELOPMENT-PLAN REASSESSMENT START FUNCTION
--
-- Three-argument overload.
--
-- This creates/resumes an assessment attempt specifically connected to the
-- Development Plan.
-- ============================================================================

create or replace function
wri_start_master_assessment(
  p_employee_id uuid,
  p_assessment_id uuid,
  p_development_plan_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_employee employees;
  v_assessment assessments;
  v_plan development_plans%rowtype;

  v_attempt_id uuid;
  v_existing_attempt_id uuid;

  v_rule record;
  v_question record;

  v_order int := 0;

  v_expected_count int;
  v_selected_count int;
  v_answer_key_count int;

begin

  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select *

  into v_employee

  from employees

  where id =
    p_employee_id;


  if v_employee is null then

    raise exception
      'employee % not found',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (

    wri_is_integrateu_admin()

    or v_employee.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to start reassessment for employee %',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *

  into v_assessment

  from assessments

  where id =
    p_assessment_id;


  if v_assessment is null then

    raise exception
      'assessment % not found',
      p_assessment_id;

  end if;


  if v_assessment.client_id
     is not null then

    raise exception
      'wri_start_master_assessment only accepts template-mode assessments';

  end if;


  if not v_assessment.is_current then

    raise exception
      'assessment % is not the current published version',
      p_assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Development Plan
  -- --------------------------------------------------------------------------

  perform
    wri_validate_assessment_development_plan(
      p_employee_id,
      p_assessment_id,
      p_development_plan_id
    );


  select *

  into v_plan

  from development_plans

  where id =
    p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Resume only an unfinished attempt for THIS development plan.
  -- --------------------------------------------------------------------------

  select id

  into v_existing_attempt_id

  from assessment_attempts

  where employee_id =
      p_employee_id

    and assessment_id =
      p_assessment_id

    and development_plan_id =
      p_development_plan_id

    and status in (
      'not_started',
      'in_progress'
    )

  order by created_at desc

  limit 1;


  if v_existing_attempt_id
     is not null then

    return
      v_existing_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Create reassessment attempt
  -- --------------------------------------------------------------------------

  insert into assessment_attempts (

    client_id,
    employee_id,
    assessment_id,
    role_id,

    development_plan_id,

    status,
    started_at,
    created_by

  )

  values (

    v_employee.client_id,
    p_employee_id,
    p_assessment_id,
    null,

    p_development_plan_id,

    'in_progress',
    now(),
    auth.uid()

  )

  returning id
  into v_attempt_id;


  -- --------------------------------------------------------------------------
  -- Expected total
  -- --------------------------------------------------------------------------

  select
    coalesce(
      sum(question_count),
      0
    )

  into v_expected_count

  from assessment_blueprint_rules

  where assessment_id =
    p_assessment_id;


  if v_expected_count = 0 then

    raise exception
      'assessment % has no blueprint rules',
      p_assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Randomized question snapshot
  -- --------------------------------------------------------------------------

  for v_rule in

    select *

    from assessment_blueprint_rules

    where assessment_id =
      p_assessment_id

    order by
      sort_order,
      id

  loop

    -- FOUNDATIONAL

    for v_question in

      select q.id

      from assessment_questions q

      where q.assessment_id =
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
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
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
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
          p_assessment_id

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


      insert into attempt_question_selections (

        client_id,
        attempt_id,
        question_id,
        question_order

      )

      values (

        v_employee.client_id,
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

  from attempt_question_selections

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

  from attempt_question_selections aqs

  join assessment_question_answer_keys k
    on k.question_id =
      aqs.question_id

  where aqs.attempt_id =
    v_attempt_id;


  if v_answer_key_count <>
     v_selected_count then

    raise exception
      'attempt % contains selected questions without answer keys',
      v_attempt_id;

  end if;


  return
    v_attempt_id;

end;

$$;


-- ============================================================================
-- PART 5 — GRANTS
-- ============================================================================

revoke all
on function
wri_start_master_assessment(
  uuid,
  uuid,
  uuid
)
from public, anon;


grant execute
on function
wri_start_master_assessment(
  uuid,
  uuid,
  uuid
)
to authenticated;


revoke all
on function
wri_validate_assessment_development_plan(
  uuid,
  uuid,
  uuid
)
from public, anon;


grant execute
on function
wri_validate_assessment_development_plan(
  uuid,
  uuid,
  uuid
)
to authenticated;


-- ============================================================================
-- PART 6 — INSTALLATION CHECKS
-- ============================================================================

select
  column_name,
  data_type
from information_schema.columns
where table_schema = 'public'
  and table_name =
    'assessment_attempts'
  and column_name =
    'development_plan_id';


select
  p.oid::regprocedure
    as signature

from pg_proc p

join pg_namespace n
  on n.oid =
    p.pronamespace

where n.nspname =
    'public'

  and p.proname =
    'wri_start_master_assessment'

order by
  p.oid::regprocedure::text;