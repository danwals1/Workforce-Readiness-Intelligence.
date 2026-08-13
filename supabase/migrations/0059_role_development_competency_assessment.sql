-- ============================================================================
-- 0059_role_development_competency_assessment.sql
--
-- Purpose
-- -------
-- Add competency-specific assessment attempts for Role Development plans.
--
-- Design:
--
-- Role Development activity
--   -> exact master competency
--   -> validated current assessment content
--   -> one resumable attempt per development activity
--   -> existing assessment scoring engine
--   -> canonical employee competency evidence
--   -> target-role readiness recalculates
--
-- Completing assessment evidence does NOT automatically complete the
-- Development Plan activity.
-- ============================================================================


-- ============================================================================
-- PART 1 — ASSESSMENT ATTEMPT PROVENANCE
-- ============================================================================

alter table public.assessment_attempts
  add column if not exists
  development_plan_activity_id uuid;


alter table public.assessment_attempts
  drop constraint if exists
  assessment_attempts_development_plan_activity_id_fkey;


alter table public.assessment_attempts
  add constraint
  assessment_attempts_development_plan_activity_id_fkey
  foreign key (
    development_plan_activity_id
  )
  references public.development_plan_activities(id)
  on delete set null;


create index if not exists
  assessment_attempts_development_plan_activity_idx
on public.assessment_attempts(
  development_plan_activity_id
);


-- ============================================================================
-- PART 2 — ADD ROLE DEVELOPMENT ATTEMPT MODE
-- ============================================================================

alter table public.assessment_attempts
  drop constraint if exists
  assessment_attempts_attempt_mode_check;


alter table public.assessment_attempts
  add constraint
  assessment_attempts_attempt_mode_check
  check (
    attempt_mode in (
      'full',
      'targeted_reassessment',
      'role_development_assessment'
    )
  );


-- Only one unfinished Role Development assessment may exist for a given
-- Development Plan activity.

create unique index if not exists
  assessment_attempts_role_development_open_activity_uidx
on public.assessment_attempts(
  development_plan_activity_id
)
where
  attempt_mode =
    'role_development_assessment'
  and status in (
    'not_started',
    'in_progress'
  )
  and development_plan_activity_id
    is not null;


-- ============================================================================
-- PART 3 — START / RESUME ROLE DEVELOPMENT COMPETENCY ASSESSMENT
-- ============================================================================

create or replace function
public.wri_start_role_development_competency_assessment(
  p_development_plan_activity_id uuid
)
returns uuid

language plpgsql

security definer

set search_path = public

as $function$

declare

  v_activity
    public.development_plan_activities%rowtype;

  v_plan
    public.development_plans%rowtype;

  v_employee
    public.employees%rowtype;

  v_assessment_id uuid;

  v_assessment_name text;

  v_assessment_available boolean;

  v_existing_attempt_id uuid;

  v_attempt_id uuid;

  v_question record;

  v_order integer := 0;

  v_selected_count integer := 0;

  v_answer_key_count integer := 0;

begin

  -- --------------------------------------------------------------------------
  -- Activity
  -- --------------------------------------------------------------------------

  select *
  into v_activity

  from public.development_plan_activities

  where id =
    p_development_plan_activity_id;


  if not found then

    raise exception
      'development plan activity % not found',
      p_development_plan_activity_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Parent Role Development plan
  -- --------------------------------------------------------------------------

  select *
  into v_plan

  from public.development_plans

  where id =
    v_activity.development_plan_id;


  if not found then

    raise exception
      'development plan % not found',
      v_activity.development_plan_id;

  end if;


  if v_plan.origin
    is distinct from
      'role_comparison'
  then

    raise exception
      'development plan % is not a role-comparison development plan',
      v_plan.id;

  end if;


  if v_plan.status =
      'cancelled'

    or v_plan.resolution_status in (
      'resolved',
      'cancelled'
    )

  then

    raise exception
      'development plan % is no longer available for assessment',
      v_plan.id;

  end if;


  if v_activity.employee_id
    is distinct from
      v_plan.employee_id
  then

    raise exception
      'development activity employee does not match development plan employee';

  end if;


  if v_activity.target_status_snapshot
    is distinct from
      'not_assessed'
  then

    raise exception
      'development activity % is not a not-assessed target-role competency',
      v_activity.id;

  end if;


  if v_activity.master_competency_template_id
    is null
  then

    raise exception
      'development activity % has no linked master competency',
      v_activity.id;

  end if;


  -- Confirm the linked competency is still part of the target role.

  if not exists (

    select 1

    from public.master_role_competency_requirements mrcr

    where mrcr.master_role_template_id =
      v_plan.target_master_role_template_id

      and mrcr.master_competency_template_id =
        v_activity.master_competency_template_id

  ) then

    raise exception
      'activity competency is not a requirement of target role %',
      v_plan.target_master_role_template_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Employee / authorization
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


  if not (

    public.wri_is_integrateu_admin()

    or v_employee.client_id in (
      select public.wri_allowed_client_ids()
    )

    or v_employee.auth_user_id =
      auth.uid()

  ) then

    raise exception
      'not authorized to start role-development assessment';

  end if;


  -- --------------------------------------------------------------------------
  -- Resume existing unfinished attempt for THIS activity.
  -- --------------------------------------------------------------------------

  select aa.id
  into v_existing_attempt_id

  from public.assessment_attempts aa

  where aa.development_plan_activity_id =
    v_activity.id

    and aa.attempt_mode =
      'role_development_assessment'

    and aa.status in (
      'not_started',
      'in_progress'
    )

  order by
    aa.created_at desc,
    aa.id desc

  limit 1;


  if v_existing_attempt_id
    is not null
  then

    return
      v_existing_attempt_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Determine validated assessment content from 0058.
  -- --------------------------------------------------------------------------

  select
    availability.assessment_id,
    availability.assessment_name,
    availability.assessment_available

  into
    v_assessment_id,
    v_assessment_name,
    v_assessment_available

  from public.wri_role_development_assessment_availability(
    v_plan.id
  ) availability

  where availability.activity_id =
    v_activity.id

  limit 1;


  if
    v_assessment_available
      is distinct from true

    or v_assessment_id
      is null

  then

    raise exception
      'assessment content is not available for development activity %',
      v_activity.id;

  end if;


  -- --------------------------------------------------------------------------
  -- Create attempt.
  -- --------------------------------------------------------------------------

  insert into public.assessment_attempts (

    client_id,

    employee_id,

    assessment_id,

    role_id,

    development_plan_id,

    development_plan_activity_id,

    attempt_mode,

    status,

    started_at,

    created_by

  )

  values (

    v_employee.client_id,

    v_employee.id,

    v_assessment_id,

    null,

    v_plan.id,

    v_activity.id,

    'role_development_assessment',

    'in_progress',

    now(),

    auth.uid()

  )

  returning id
  into v_attempt_id;


  -- --------------------------------------------------------------------------
  -- Snapshot ONLY questions for this exact master competency.
  -- --------------------------------------------------------------------------

  for v_question in

    select q.id

    from public.assessment_questions q

    where q.assessment_id =
      v_assessment_id

      and q.master_competency_template_id =
        v_activity.master_competency_template_id

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


  -- --------------------------------------------------------------------------
  -- Validate snapshot.
  -- --------------------------------------------------------------------------

  select count(*)
  into v_selected_count

  from public.attempt_question_selections aqs

  where aqs.attempt_id =
    v_attempt_id;


  if v_selected_count = 0 then

    raise exception
      'no eligible questions found for development activity %',
      v_activity.id;

  end if;


  select
    count(
      distinct aqak.question_id
    )

  into v_answer_key_count

  from public.attempt_question_selections aqs

  join public.assessment_question_answer_keys aqak

    on aqak.question_id =
      aqs.question_id

  where aqs.attempt_id =
    v_attempt_id;


  if v_answer_key_count
    <> v_selected_count
  then

    raise exception
      'assessment questions for development activity % do not all have secure answer keys',
      v_activity.id;

  end if;


  return
    v_attempt_id;

end;

$function$;


revoke all
on function
public.wri_start_role_development_competency_assessment(uuid)
from public, anon;


grant execute
on function
public.wri_start_role_development_competency_assessment(uuid)
to authenticated;


comment on function
public.wri_start_role_development_competency_assessment(uuid)
is
'Starts or resumes a competency-specific assessment for one Role Development activity. Uses validated current assessment content, snapshots only the linked master competency questions, and does not complete the Development Plan activity.';


-- ============================================================================
-- PART 4 — INCLUDE ROLE DEVELOPMENT ASSESSMENTS IN CANONICAL KNOWLEDGE EVIDENCE
-- ============================================================================

create or replace view
public.v_employee_master_competency_evidence
as

with knowledge_candidates as (

  select

    aa.client_id,

    aa.employee_id,

    cs.master_competency_template_id,

    aa.id
      as knowledge_attempt_id,

    aa.assessment_id,

    aa.attempt_mode,

    cs.score_percent
      as knowledge_score_percent,

    cs.estimated_level
      as knowledge_level,

    coalesce(
      aa.completed_at,
      cs.created_at,
      aa.created_at
    )
      as knowledge_evidenced_at,

    row_number() over (

      partition by
        aa.employee_id,
        cs.master_competency_template_id

      order by
        aa.completed_at desc nulls last,
        cs.created_at desc,
        aa.created_at desc,
        aa.id desc,
        cs.id desc

    )
      as evidence_rank

  from public.assessment_attempts aa

  join public.competency_scores cs

    on cs.attempt_id =
      aa.id

    and cs.employee_id =
      aa.employee_id

  where aa.status =
    'completed'

    and aa.attempt_mode in (
      'full',
      'targeted_reassessment',
      'role_development_assessment'
    )

    and cs.master_competency_template_id
      is not null

),

latest_knowledge as (

  select

    kc.client_id,

    kc.employee_id,

    kc.master_competency_template_id,

    kc.knowledge_attempt_id,

    kc.assessment_id,

    kc.attempt_mode,

    kc.knowledge_score_percent,

    kc.knowledge_level,

    kc.knowledge_evidenced_at

  from knowledge_candidates kc

  where kc.evidence_rank =
    1

),

practical_candidates as (

  select

    pv.client_id,

    pv.employee_id,

    pv.master_competency_template_id,

    pv.id
      as practical_verification_id,

    pv.rating_level
      as practical_rating_level,

    pv.status
      as practical_verification_status,

    pv.verified_by,

    pv.verified_at,

    pv.notes
      as practical_notes,

    row_number() over (

      partition by
        pv.employee_id,
        pv.master_competency_template_id

      order by
        pv.verified_at desc nulls last,
        pv.created_at desc,
        pv.id desc

    )
      as evidence_rank

  from public.master_practical_verifications pv

  where pv.master_competency_template_id
    is not null

),

latest_practical as (

  select

    pc.client_id,

    pc.employee_id,

    pc.master_competency_template_id,

    pc.practical_verification_id,

    pc.practical_rating_level,

    pc.practical_verification_status,

    pc.verified_by,

    pc.verified_at,

    pc.practical_notes

  from practical_candidates pc

  where pc.evidence_rank =
    1

),

evidence_keys as (

  select

    lk.client_id,

    lk.employee_id,

    lk.master_competency_template_id

  from latest_knowledge lk

  union

  select

    lp.client_id,

    lp.employee_id,

    lp.master_competency_template_id

  from latest_practical lp

),

combined as (

  select

    ek.client_id,

    ek.employee_id,

    ek.master_competency_template_id,

    mct.name
      as competency_name,

    mct.category
      as competency_category,

    mct.is_critical
      as competency_is_critical,

    mct.verifier_type,

    mct.reverification_period_months,

    lk.knowledge_attempt_id,

    lk.assessment_id
      as knowledge_assessment_id,

    lk.attempt_mode
      as knowledge_attempt_mode,

    lk.knowledge_score_percent,

    lk.knowledge_level,

    lk.knowledge_evidenced_at,

    lp.practical_verification_id,

    lp.practical_rating_level,

    lp.practical_verification_status,

    lp.verified_by
      as practical_verified_by,

    lp.verified_at
      as practical_verified_at,

    lp.practical_notes,

    case

      when lp.practical_verification_status
        <> 'verified'
        then null

      when lp.verified_at is null
        then null

      when mct.reverification_period_months
        is null
        then null

      when mct.reverification_period_months
        <= 0
        then null

      else

        lp.verified_at
        +
        make_interval(
          months =>
            mct.reverification_period_months
        )

    end
      as practical_verification_expires_at

  from evidence_keys ek

  join public.master_competency_templates mct

    on mct.id =
      ek.master_competency_template_id

  left join latest_knowledge lk

    on lk.employee_id =
      ek.employee_id

    and lk.master_competency_template_id =
      ek.master_competency_template_id

  left join latest_practical lp

    on lp.employee_id =
      ek.employee_id

    and lp.master_competency_template_id =
      ek.master_competency_template_id

)

select

  c.client_id,

  c.employee_id,

  c.master_competency_template_id,

  c.competency_name,

  c.competency_category,

  c.competency_is_critical,

  c.verifier_type,

  c.reverification_period_months,

  c.knowledge_attempt_id,

  c.knowledge_assessment_id,

  c.knowledge_attempt_mode,

  c.knowledge_score_percent,

  c.knowledge_level,

  c.knowledge_evidenced_at,

  c.practical_verification_id,

  c.practical_rating_level,

  c.practical_verification_status,

  c.practical_verified_by,

  c.practical_verified_at,

  c.practical_notes,

  c.practical_verification_expires_at,

  case

    when c.practical_verification_expires_at
      is null
      then false

    when c.practical_verification_expires_at
      <= now()
      then false

    when c.practical_verification_expires_at
      <= now() + interval '30 days'
      then true

    else false

  end
    as reverification_due,

  case

    when c.practical_verification_expires_at
      is null
      then false

    when c.practical_verification_expires_at
      <= now()
      then true

    else false

  end
    as verification_expired

from combined c;


comment on view
public.v_employee_master_competency_evidence
is
'Latest employee-level knowledge and practical evidence by master competency, independent of current role assessment. Knowledge uses latest completed full, targeted reassessment, or Role Development assessment evidence; practical uses latest verification attempt.';
