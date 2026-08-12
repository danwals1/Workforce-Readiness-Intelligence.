-- ============================================================================
-- 0043_targeted_competency_reassessment.sql
--
-- Extends targeted reassessment beyond Safety Gap plans.
--
-- Supported reassessment plan types:
--
--   SAFETY_GAP
--     -> all Critical Safety questions from the source assessment
--
--   CRITICAL_KNOWLEDGE_GAP
--   KNOWLEDGE_DEVELOPMENT
--     -> questions for only the Development Plan competency
--
-- Knowledge reassessment results become current knowledge evidence for the
-- targeted competency until superseded by a later full assessment.
--
-- Lifecycle:
--
--   development_in_progress
--          ↓
--   awaiting_reassessment
--          ↓
--   targeted reassessment
--
--     FAIL
--       ↓
--   development_in_progress
--
--     PASS
--       ↓
--   readiness action disappears
--       ↓
--   resolved
-- ============================================================================


-- ============================================================================
-- PART 1 — LATEST TARGETED KNOWLEDGE REASSESSMENT
--
-- Keep targeted reassessments separate from full assessment history.
--
-- This view identifies the latest completed targeted knowledge reassessment
-- for each employee / assessment / competency.
-- ============================================================================

create or replace view public.v_latest_targeted_knowledge_reassessment
as

select distinct on (
  aa.employee_id,
  aa.assessment_id,
  cs.master_competency_template_id
)

  aa.id
    as targeted_attempt_id,

  aa.client_id,

  aa.employee_id,

  aa.assessment_id,

  aa.development_plan_id,

  cs.master_competency_template_id,

  cs.score_percent,

  cs.estimated_level,

  cs.required_level,

  aa.completed_at,

  aa.created_at

from public.assessment_attempts aa

join public.development_plans dp
  on dp.id =
    aa.development_plan_id

join public.competency_scores cs
  on cs.attempt_id =
    aa.id

where
  aa.status =
    'completed'

  and aa.attempt_mode =
    'targeted_reassessment'

  and dp.action_type in (
    'CRITICAL_KNOWLEDGE_GAP',
    'KNOWLEDGE_DEVELOPMENT'
  )

  and cs.master_competency_template_id
    is not null

order by

  aa.employee_id,

  aa.assessment_id,

  cs.master_competency_template_id,

  aa.completed_at desc nulls last,

  aa.created_at desc;


comment on view
public.v_latest_targeted_knowledge_reassessment
is
'Latest completed targeted knowledge reassessment for each employee, assessment, and master competency. Does not replace full assessment history; it provides competency-specific knowledge evidence.';


-- ============================================================================
-- PART 2 — OVERLAY TARGETED KNOWLEDGE EVIDENCE ON CURRENT READINESS
--
-- Full assessments remain the baseline.
--
-- A targeted knowledge reassessment overrides the baseline score only when:
--
--   1. it targets the same employee
--   2. it targets the same assessment
--   3. it targets the same master competency
--   4. it was completed after the current full assessment
--
-- A later full assessment automatically supersedes old targeted evidence.
-- ============================================================================

create or replace view public.v_assessment_competency_readiness
as

with latest_attempts as (

  select

    v_latest_master_assessment_attempt.attempt_id,

    v_latest_master_assessment_attempt.client_id,

    v_latest_master_assessment_attempt.employee_id,

    v_latest_master_assessment_attempt.assessment_id,

    v_latest_master_assessment_attempt.started_at,

    v_latest_master_assessment_attempt.completed_at,

    v_latest_master_assessment_attempt.assessment_name,

    v_latest_master_assessment_attempt.master_role_template_id,

    v_latest_master_assessment_attempt.master_target_role_template_id,

    v_latest_master_assessment_attempt.effective_master_role_template_id

  from public.v_latest_master_assessment_attempt

),

practical_requirements as (

  select

    aq.assessment_id,

    aq.master_competency_template_id,

    bool_or(
      aq.practical_verification_required
    )
      as practical_verification_required

  from public.assessment_questions aq

  where aq.master_competency_template_id
    is not null

  group by

    aq.assessment_id,

    aq.master_competency_template_id

),

effective_scores as (

  select

    la.attempt_id,

    la.client_id,

    la.employee_id,

    la.assessment_id,

    la.assessment_name,

    la.effective_master_role_template_id
      as master_role_template_id,

    cs.master_competency_template_id,

    case

      when
        tkr.targeted_attempt_id is not null

        and tkr.completed_at is not null

        and (
          la.completed_at is null
          or tkr.completed_at > la.completed_at
        )

      then
        tkr.score_percent

      else
        cs.score_percent

    end
      as knowledge_score_percent,

    case

      when
        tkr.targeted_attempt_id is not null

        and tkr.completed_at is not null

        and (
          la.completed_at is null
          or tkr.completed_at > la.completed_at
        )

      then
        tkr.estimated_level

      else
        cs.estimated_level

    end
      as knowledge_level,

    cs.required_level

  from latest_attempts la

  join public.competency_scores cs

    on cs.attempt_id =
      la.attempt_id

   and cs.master_competency_template_id
      is not null

  left join
    public.v_latest_targeted_knowledge_reassessment tkr

    on tkr.employee_id =
      la.employee_id

   and tkr.assessment_id =
      la.assessment_id

   and tkr.master_competency_template_id =
      cs.master_competency_template_id

)

select

  es.attempt_id,

  es.client_id,

  es.employee_id,

  es.assessment_id,

  es.assessment_name,

  es.master_role_template_id,

  es.master_competency_template_id,

  mct.name
    as competency_name,

  mct.category
    as competency_category,

  mct.is_critical
    as competency_is_critical,

  es.knowledge_score_percent,

  es.knowledge_level,

  es.required_level,

  case

    when es.required_level
      is null
      then false

    when es.knowledge_level >=
      es.required_level
      then true

    else false

  end
    as knowledge_ready,

  coalesce(
    pr.practical_verification_required,
    false
  )
    as practical_verification_required,

  pv.rating_level
    as practical_rating_level,

  pv.status
    as practical_verification_status,

  pv.verified_at
    as practical_verified_at,

  case

    when coalesce(
      pr.practical_verification_required,
      false
    ) = false
      then true

    else coalesce(
      pv.status = 'verified'
      and pv.rating_level >=
        es.required_level,
      false
    )

  end
    as practical_ready,

  case

    when es.required_level
      is null
      then false

    when es.knowledge_level <
      es.required_level
      then false

    when
      coalesce(
        pr.practical_verification_required,
        false
      ) = true

      and coalesce(
        pv.status = 'verified'
        and pv.rating_level >=
          es.required_level,
        false
      ) = false
      then false

    else true

  end
    as competency_ready,

  case

    when es.required_level
      is null
      then 'not_required'

    when es.knowledge_level <
      (es.required_level - 1)
      then 'critical_gap'

    when es.knowledge_level <
      es.required_level
      then 'developing'

    when
      coalesce(
        pr.practical_verification_required,
        false
      ) = true

      and pv.status is null
      then 'practical_verification_needed'

    when
      coalesce(
        pr.practical_verification_required,
        false
      ) = true

      and pv.status <>
        'verified'
      then 'practical_verification_needed'

    when
      coalesce(
        pr.practical_verification_required,
        false
      ) = true

      and coalesce(
        pv.rating_level,
        0
      ) <
        es.required_level
      then 'practical_development_needed'

    else 'ready'

  end
    as readiness_status

from effective_scores es

join public.master_competency_templates mct

  on mct.id =
    es.master_competency_template_id

left join practical_requirements pr

  on pr.assessment_id =
    es.assessment_id

 and pr.master_competency_template_id =
    es.master_competency_template_id

left join public.v_latest_master_practical_verification pv

  on pv.employee_id =
    es.employee_id

 and pv.master_competency_template_id =
    es.master_competency_template_id;


-- ============================================================================
-- PART 3 — GENERAL TARGETED REASSESSMENT START FUNCTION
-- ============================================================================

create or replace function
public.wri_start_targeted_reassessment(
  p_development_plan_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan
    public.development_plans%rowtype;

  v_employee
    public.employees%rowtype;

  v_assessment
    public.assessments%rowtype;

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
  from public.development_plans
  where id =
    p_development_plan_id;

  if not found then

    raise exception
      'development plan % not found',
      p_development_plan_id;

  end if;


  if v_plan.action_type not in (
    'SAFETY_GAP',
    'CRITICAL_KNOWLEDGE_GAP',
    'KNOWLEDGE_DEVELOPMENT'
  ) then

    raise exception
      'development plan % is not a reassessment-based plan',
      p_development_plan_id;

  end if;


  if v_plan.resolution_status <>
    'awaiting_reassessment'
  then

    raise exception
      'development plan % is not awaiting reassessment',
      p_development_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select *
  into v_employee
  from public.employees
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

    public.wri_is_integrateu_admin()

    or v_employee.client_id in (
      select public.wri_allowed_client_ids()
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

  from public.v_readiness_action_queue q

  where q.action_key =
    v_plan.action_key

    and q.employee_id =
      v_plan.employee_id

  limit 1;


  if not found then

    raise exception
      'the readiness action for development plan % is no longer active',
      p_development_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *
  into v_assessment
  from public.assessments
  where id =
    v_action.assessment_id;


  if not found then

    raise exception
      'assessment % not found',
      v_action.assessment_id;

  end if;


  if v_assessment.client_id
    is not null
  then

    raise exception
      'targeted reassessment currently supports template assessments only';

  end if;


  if not v_assessment.is_current then

    raise exception
      'assessment % is not the current published version',
      v_assessment.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Resume unfinished targeted reassessment for this plan
  -- --------------------------------------------------------------------------

  select id
  into v_existing_attempt_id

  from public.assessment_attempts

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
    is not null
  then

    return
      v_existing_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Create targeted attempt
  -- --------------------------------------------------------------------------

  insert into public.assessment_attempts (

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
  -- Build targeted question snapshot
  --
  -- Safety Gap:
  --   all Critical Safety questions
  --
  -- Knowledge:
  --   all questions for the Development Plan competency
  -- --------------------------------------------------------------------------

  if v_plan.action_type =
    'SAFETY_GAP'
  then

    for v_question in

      select q.id

      from public.assessment_questions q

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


      insert into
      public.attempt_question_selections (

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


  else

    if v_plan.master_competency_template_id
      is null
    then

      raise exception
        'development plan % has no master competency for targeted knowledge reassessment',
        p_development_plan_id;

    end if;


    for v_question in

      select q.id

      from public.assessment_questions q

      where q.assessment_id =
        v_assessment.id

        and q.master_competency_template_id =
          v_plan.master_competency_template_id

        and q.source_master_question_id
          is not null

      order by
        q.sort_order,
        q.id

    loop

      v_order :=
        v_order + 1;


      insert into
      public.attempt_question_selections (

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

  end if;


  -- --------------------------------------------------------------------------
  -- Validate selected question count
  -- --------------------------------------------------------------------------

  select count(*)
  into v_selected_count

  from public.attempt_question_selections

  where attempt_id =
    v_attempt_id;


  if v_selected_count = 0 then

    if v_plan.action_type =
      'SAFETY_GAP'
    then

      raise exception
        'assessment % contains no Critical Safety questions',
        v_assessment.id;

    else

      raise exception
        'assessment % contains no questions for competency %',
        v_assessment.id,
        v_plan.master_competency_template_id;

    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- Validate secure answer keys
  -- --------------------------------------------------------------------------

  select count(*)
  into v_answer_key_count

  from public.attempt_question_selections aqs

  join public.assessment_question_answer_keys k

    on k.question_id =
      aqs.question_id

  where aqs.attempt_id =
    v_attempt_id;


  if v_answer_key_count <>
    v_selected_count
  then

    raise exception
      'targeted reassessment % contains questions without secure answer keys',
      v_attempt_id;

  end if;


  return
    v_attempt_id;

end;

$$;


comment on function
public.wri_start_targeted_reassessment(uuid)
is
'Starts or resumes a targeted reassessment for Safety Gap, Critical Knowledge Gap, or Knowledge Development plans. Safety plans receive all Critical Safety questions; knowledge plans receive only questions for the plan competency.';


-- ============================================================================
-- PART 4 — BACKWARD-COMPATIBLE SAFETY RPC
--
-- Existing clients that still call the old function continue to work.
-- ============================================================================

create or replace function
public.wri_start_targeted_safety_reassessment(
  p_development_plan_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan
    public.development_plans%rowtype;

begin

  select *
  into v_plan
  from public.development_plans
  where id =
    p_development_plan_id;


  if not found then

    raise exception
      'development plan % not found',
      p_development_plan_id;

  end if;


  if v_plan.action_type <>
    'SAFETY_GAP'
  then

    raise exception
      'development plan % is not a Safety Gap plan',
      p_development_plan_id;

  end if;


  return
    public.wri_start_targeted_reassessment(
      p_development_plan_id
    );

end;

$$;


-- ============================================================================
-- PART 5 — GENERAL TARGETED REASSESSMENT LIFECYCLE
-- ============================================================================

create or replace function
public.wri_handle_completed_targeted_reassessment()
returns trigger

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan
    public.development_plans%rowtype;

  v_safety_questions integer := 0;

  v_safety_correct integer := 0;

  v_safety_score numeric := null;

  v_knowledge_score numeric := null;

  v_knowledge_level integer := null;

  v_required_level integer := null;

  v_failed boolean := false;

  v_failure_note text := null;

begin

  -- --------------------------------------------------------------------------
  -- Only react when an assessment transitions into completed.
  -- --------------------------------------------------------------------------

  if new.status <>
    'completed'

    or old.status =
      'completed'
  then

    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Only targeted reassessments tied to a Development Plan participate.
  -- --------------------------------------------------------------------------

  if new.attempt_mode
      is distinct from
      'targeted_reassessment'

    or new.development_plan_id
      is null
  then

    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Load parent Development Plan.
  -- --------------------------------------------------------------------------

  select *
  into v_plan

  from public.development_plans

  where id =
    new.development_plan_id;


  if not found then

    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Never reopen terminal plans.
  -- --------------------------------------------------------------------------

  if v_plan.status =
      'cancelled'

    or v_plan.resolution_status in (
      'resolved',
      'cancelled'
    )
  then

    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Ignore non-reassessment plan types.
  -- --------------------------------------------------------------------------

  if v_plan.action_type not in (
    'SAFETY_GAP',
    'CRITICAL_KNOWLEDGE_GAP',
    'KNOWLEDGE_DEVELOPMENT'
  )
  then

    perform
      public.wri_refresh_development_plan_resolution(
        new.development_plan_id
      );

    return new;

  end if;


  -- ==========================================================================
  -- SAFETY GAP
  -- ==========================================================================

  if v_plan.action_type =
    'SAFETY_GAP'
  then

    select

      count(*) filter (
        where aq.critical_safety =
          true
      ),

      count(*) filter (
        where aq.critical_safety =
          true

          and ans.is_correct =
            true
      )

    into

      v_safety_questions,

      v_safety_correct

    from
      public.attempt_question_selections aqs

    join public.assessment_questions aq

      on aq.id =
        aqs.question_id

    left join public.attempt_answers ans

      on ans.attempt_id =
        aqs.attempt_id

     and ans.question_id =
        aqs.question_id

    where aqs.attempt_id =
      new.id;


    if v_safety_questions > 0 then

      v_safety_score :=
        round(
          100.0
          * v_safety_correct::numeric
          / v_safety_questions::numeric,
          1
        );

    end if;


    if
      v_safety_score is not null

      and v_safety_score < 80.0
    then

      v_failed := true;

      v_failure_note :=
        concat(
          'Targeted safety reassessment completed at ',
          coalesce(
            new.completed_at::text,
            now()::text
          ),
          ' with a score of ',
          v_safety_score::text,
          '%. Additional development is required.'
        );

    end if;


  -- ==========================================================================
  -- KNOWLEDGE DEVELOPMENT
  -- ==========================================================================

  else

    select

      cs.score_percent,

      cs.estimated_level,

      cs.required_level

    into

      v_knowledge_score,

      v_knowledge_level,

      v_required_level

    from public.competency_scores cs

    where cs.attempt_id =
      new.id

      and cs.master_competency_template_id =
        v_plan.master_competency_template_id

    limit 1;


    if not found then

      raise exception
        'targeted knowledge reassessment % produced no competency score for competency %',
        new.id,
        v_plan.master_competency_template_id;

    end if;


    if v_required_level is null then

      raise exception
        'targeted knowledge reassessment % has no required level for competency %',
        new.id,
        v_plan.master_competency_template_id;

    end if;


    if
      v_knowledge_level is null

      or v_knowledge_level <
        v_required_level
    then

      v_failed := true;

      v_failure_note :=
        concat(
          'Targeted knowledge reassessment completed at ',
          coalesce(
            new.completed_at::text,
            now()::text
          ),
          ' with a score of ',
          coalesce(
            v_knowledge_score::text,
            'unknown'
          ),
          '% and demonstrated level ',
          coalesce(
            v_knowledge_level::text,
            'unknown'
          ),
          ' against required level ',
          v_required_level::text,
          '. Additional development is required.'
        );

    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- Refresh readiness-driven resolution first.
  --
  -- A successful knowledge reassessment is now visible to the readiness engine
  -- through v_assessment_competency_readiness.
  -- --------------------------------------------------------------------------

  perform
    public.wri_refresh_development_plan_resolution(
      new.development_plan_id
    );


  -- --------------------------------------------------------------------------
  -- Reload after resolution refresh.
  -- --------------------------------------------------------------------------

  select *
  into v_plan

  from public.development_plans

  where id =
    new.development_plan_id;


  -- --------------------------------------------------------------------------
  -- Successful reassessment
  -- --------------------------------------------------------------------------

  if v_failed = false then

    if v_plan.resolution_status =
      'resolved'
    then

      update public.development_plans

      set
        resolution_notes =
          null,

        updated_at =
          now()

      where id =
        new.development_plan_id;

    end if;


    return new;

  end if;


  -- --------------------------------------------------------------------------
  -- Failed reassessment
  --
  -- Preserve completed activity history but reopen the Development Plan.
  -- New development work can then be added.
  -- --------------------------------------------------------------------------

  update public.development_plans

  set

    status =
      case

        when status =
          'completed'
          then 'in_progress'

        else status

      end,

    resolution_status =
      'development_in_progress',

    development_completed_at =
      null,

    awaiting_evidence_since =
      null,

    resolved_at =
      null,

    resolution_notes =
      v_failure_note,

    updated_at =
      now()

  where id =
    new.development_plan_id;


  return new;

end;

$$;


comment on function
public.wri_handle_completed_targeted_reassessment()
is
'Synchronizes Development Plan lifecycle after targeted Safety or competency knowledge reassessment. Passing results use the standard readiness resolution engine; failures reopen the plan for additional development.';


-- ============================================================================
-- PART 6 — PERMISSIONS
-- ============================================================================

revoke all
on function
public.wri_start_targeted_reassessment(uuid)
from public;

grant execute
on function
public.wri_start_targeted_reassessment(uuid)
to authenticated;


revoke all
on function
public.wri_start_targeted_safety_reassessment(uuid)
from public;

grant execute
on function
public.wri_start_targeted_safety_reassessment(uuid)
to authenticated;


revoke all
on function
public.wri_handle_completed_targeted_reassessment()
from public;


-- ============================================================================
-- PART 7 — REFRESH CURRENT DEVELOPMENT PLAN RESOLUTIONS
-- ============================================================================

select
  public.wri_refresh_all_development_plan_resolutions();