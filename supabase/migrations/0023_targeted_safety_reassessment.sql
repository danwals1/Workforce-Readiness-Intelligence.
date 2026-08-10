-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0023_targeted_safety_reassessment.sql
--
-- PURPOSE
--
-- Add targeted reassessment support without allowing a partial reassessment
-- to replace the employee's full role-readiness assessment.
--
-- CURRENT TARGET:
--
-- SAFETY_GAP
--
-- Full assessment:
--   remains the source for competency / role readiness.
--
-- Targeted Safety reassessment:
--   becomes the newest Critical Safety evidence only.
--
-- ============================================================================


-- ============================================================================
-- PART 1 — ATTEMPT MODE
-- ============================================================================

alter table assessment_attempts
add column if not exists attempt_mode text
  not null
  default 'full';


alter table assessment_attempts
drop constraint if exists
  assessment_attempts_attempt_mode_check;


alter table assessment_attempts
add constraint
  assessment_attempts_attempt_mode_check
check (
  attempt_mode in (
    'full',
    'targeted_reassessment'
  )
);


create index if not exists
  assessment_attempts_attempt_mode_idx
on assessment_attempts(
  attempt_mode
);


create index if not exists
  assessment_attempts_targeted_plan_idx
on assessment_attempts(
  development_plan_id,
  attempt_mode,
  status
);


-- ============================================================================
-- PART 2 — FULL ASSESSMENT SNAPSHOT
--
-- Targeted reassessments must NEVER replace the latest full assessment used
-- for the employee's overall competency / role readiness.
-- ============================================================================

create or replace view
v_latest_master_assessment_attempt
as

select distinct on (
  aa.employee_id,
  aa.assessment_id
)

  aa.id
    as attempt_id,

  aa.client_id,

  aa.employee_id,

  aa.assessment_id,

  aa.started_at,

  aa.completed_at,

  a.name
    as assessment_name,

  a.master_role_template_id,

  a.master_target_role_template_id,

  coalesce(
    a.master_target_role_template_id,
    a.master_role_template_id
  )
    as effective_master_role_template_id

from assessment_attempts aa

join assessments a
  on a.id =
    aa.assessment_id

where aa.status =
    'completed'

  and a.client_id
    is null

  and coalesce(
    aa.attempt_mode,
    'full'
  ) = 'full'

order by

  aa.employee_id,

  aa.assessment_id,

  aa.completed_at desc
    nulls last,

  aa.created_at desc;


-- ============================================================================
-- PART 3 — START TARGETED SAFETY REASSESSMENT
--
-- Selects ALL current Critical Safety questions for the assessment.
--
-- Alex's current Technician I assessment contains 13 such questions.
-- ============================================================================

create or replace function
wri_start_targeted_safety_reassessment(
  p_development_plan_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan development_plans%rowtype;

  v_employee employees%rowtype;

  v_assessment assessments%rowtype;

  v_action record;

  v_existing_attempt_id uuid;

  v_attempt_id uuid;

  v_question record;

  v_order integer := 0;

  v_selected_count integer;

  v_answer_key_count integer;

begin

  -- --------------------------------------------------------------------------
  -- Development Plan
  -- --------------------------------------------------------------------------

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


  if v_plan.action_type <>
     'SAFETY_GAP' then

    raise exception
      'development plan % is not a Safety Gap plan',
      p_development_plan_id;

  end if;


  if v_plan.resolution_status <>
     'awaiting_reassessment' then

    raise exception
      'development plan % is not awaiting reassessment',
      p_development_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select *

  into v_employee

  from employees

  where id =
    v_plan.employee_id;


  if not found then

    raise exception
      'employee % not found',
      v_plan.employee_id;

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
      'not authorized to start targeted reassessment for employee %',
      v_employee.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Active readiness action
  -- --------------------------------------------------------------------------

  select
    q.action_key,
    q.employee_id,
    q.assessment_id

  into v_action

  from v_readiness_action_queue q

  where q.action_key =
    v_plan.action_key

    and q.employee_id =
      v_plan.employee_id

  limit 1;


  if not found then

    raise exception
      'the Safety Gap for development plan % is no longer active',
      p_development_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *

  into v_assessment

  from assessments

  where id =
    v_action.assessment_id;


  if not found then

    raise exception
      'assessment % not found',
      v_action.assessment_id;

  end if;


  if v_assessment.client_id
     is not null then

    raise exception
      'targeted Safety reassessment currently supports template assessments only';

  end if;


  if not v_assessment.is_current then

    raise exception
      'assessment % is not the current published version',
      v_assessment.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Resume existing targeted reassessment for THIS plan
  -- --------------------------------------------------------------------------

  select id

  into v_existing_attempt_id

  from assessment_attempts

  where development_plan_id =
      p_development_plan_id

    and attempt_mode =
      'targeted_reassessment'

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
  -- Create targeted attempt
  -- --------------------------------------------------------------------------

  insert into assessment_attempts (

    client_id,

    employee_id,

    assessment_id,

    role_id,

    development_plan_id,

    attempt_mode,

    status,

    started_at,

    created_by

  )

  values (

    v_employee.client_id,

    v_employee.id,

    v_assessment.id,

    null,

    p_development_plan_id,

    'targeted_reassessment',

    'in_progress',

    now(),

    auth.uid()

  )

  returning id

  into v_attempt_id;


  -- --------------------------------------------------------------------------
  -- Build targeted Safety question snapshot
  --
  -- ALL Critical Safety questions are selected.
  -- --------------------------------------------------------------------------

  for v_question in

    select
      q.id

    from assessment_questions q

    where q.assessment_id =
        v_assessment.id

      and q.critical_safety =
        true

      and q.source_master_question_id
        is not null

    order by
      q.sort_order,
      q.id

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


  -- --------------------------------------------------------------------------
  -- Validate selected question count
  -- --------------------------------------------------------------------------

  select count(*)

  into v_selected_count

  from attempt_question_selections

  where attempt_id =
    v_attempt_id;


  if v_selected_count = 0 then

    raise exception
      'assessment % contains no Critical Safety questions',
      v_assessment.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Validate secure answer keys
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
      'targeted reassessment % contains questions without secure answer keys',
      v_attempt_id;

  end if;


  return
    v_attempt_id;

end;

$$;


-- ============================================================================
-- PART 4 — LATEST TARGETED SAFETY EVIDENCE
-- ============================================================================

create or replace view
v_latest_targeted_safety_reassessment
as

select distinct on (
  aa.employee_id,
  aa.assessment_id
)

  aa.id
    as targeted_attempt_id,

  aa.client_id,

  aa.employee_id,

  aa.assessment_id,

  aa.development_plan_id,

  aa.completed_at,

  aa.created_at

from assessment_attempts aa

join development_plans dp
  on dp.id =
    aa.development_plan_id

where aa.status =
    'completed'

  and aa.attempt_mode =
    'targeted_reassessment'

  and dp.action_type =
    'SAFETY_GAP'

order by

  aa.employee_id,

  aa.assessment_id,

  aa.completed_at desc
    nulls last,

  aa.created_at desc;


-- ============================================================================
-- PART 5 — SAFETY READINESS
--
-- IMPORTANT:
--
-- attempt_id returned by this view remains the FULL baseline attempt_id.
--
-- This preserves the existing join:
--
-- v_assessment_role_readiness_current
--   LEFT JOIN v_assessment_safety_readiness
--     ON sr.attempt_id = cs.attempt_id
--
-- But safety questions may come from a newer targeted reassessment.
-- ============================================================================

create or replace view
v_assessment_safety_readiness
as

with safety_source as (

  select

    full_attempt.attempt_id,

    full_attempt.client_id,

    full_attempt.employee_id,

    full_attempt.assessment_id,

    case

      when
        targeted.targeted_attempt_id
          is not null

        and targeted.completed_at >
          full_attempt.completed_at

      then
        targeted.targeted_attempt_id

      else
        full_attempt.attempt_id

    end
      as safety_evidence_attempt_id

  from v_latest_master_assessment_attempt
    full_attempt

  left join
    v_latest_targeted_safety_reassessment
      targeted

    on targeted.employee_id =
      full_attempt.employee_id

    and targeted.assessment_id =
      full_attempt.assessment_id

)

select

  ss.attempt_id,

  ss.client_id,

  ss.employee_id,

  ss.assessment_id,

  count(*) filter (
    where aq.critical_safety =
      true
  )
    as critical_safety_questions,

  count(*) filter (
    where aq.critical_safety =
      true

      and aa.is_correct =
        true
  )
    as critical_safety_correct,

  case

    when count(*) filter (
      where aq.critical_safety =
        true
    ) = 0

    then null::numeric

    else

      round(

        100.0

        * count(*) filter (
            where aq.critical_safety =
              true

              and aa.is_correct =
                true
          )::numeric

        / count(*) filter (
            where aq.critical_safety =
              true
          )::numeric,

        1

      )

  end
    as critical_safety_score_percent

from safety_source ss

join attempt_question_selections aqs
  on aqs.attempt_id =
    ss.safety_evidence_attempt_id

join assessment_questions aq
  on aq.id =
    aqs.question_id

join attempt_answers aa
  on aa.attempt_id =
    ss.safety_evidence_attempt_id

  and aa.question_id =
    aq.id

group by

  ss.attempt_id,

  ss.client_id,

  ss.employee_id,

  ss.assessment_id;


-- ============================================================================
-- PART 6 — GRANTS
-- ============================================================================

revoke all
on function
wri_start_targeted_safety_reassessment(
  uuid
)
from public, anon;


grant execute
on function
wri_start_targeted_safety_reassessment(
  uuid
)
to authenticated;


-- ============================================================================
-- PART 7 — INSTALLATION CHECKS
-- ============================================================================

select
  column_name,
  data_type,
  column_default
from information_schema.columns
where table_schema = 'public'
  and table_name = 'assessment_attempts'
  and column_name = 'attempt_mode';


select
  routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name =
    'wri_start_targeted_safety_reassessment';


select
  table_name
from information_schema.views
where table_schema = 'public'
  and table_name in (
    'v_latest_targeted_safety_reassessment',
    'v_assessment_safety_readiness'
  )
order by table_name;