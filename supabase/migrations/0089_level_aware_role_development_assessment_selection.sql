-- ============================================================================
-- 0089_level_aware_role_development_assessment_selection.sql
--
-- Makes Role Development competency-assessment selection explicitly
-- target-level aware.
--
-- Key behavior:
--
--   1. The activity's immutable target_required_level_snapshot determines
--      which authored assessment level is eligible.
--
--   2. Availability requires:
--        - current canonical readiness still = not_assessed
--        - assessment.target_level exactly matches activity target level
--        - exact production-standard question count
--        - exact production-standard difficulty mix
--        - complete answer-key coverage
--
--   3. Starting/resuming an assessment validates current availability BEFORE
--      resuming an unfinished attempt.
--
--   4. An unfinished attempt may resume only when its assessment is still the
--      currently selected target-level assessment.
--
-- Historical development-plan snapshots remain immutable.
-- ============================================================================


-- ============================================================================
-- 1. LEVEL-AWARE ROLE DEVELOPMENT ASSESSMENT AVAILABILITY
-- ============================================================================

create or replace function
public.wri_role_development_assessment_availability(
  p_development_plan_id uuid
)

returns table(
  activity_id uuid,
  master_competency_template_id uuid,
  competency_name text,
  target_required_level integer,
  assessment_id uuid,
  assessment_name text,
  question_count integer,
  answer_key_count integer,
  assessment_available boolean
)

language plpgsql

security definer

set search_path to 'public'

as $function$

declare

  v_plan
    public.development_plans%rowtype;

  v_employee
    public.employees%rowtype;

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


  if v_plan.origin <>
    'role_comparison'
  then

    raise exception
      'development plan % is not a role-comparison development plan',
      p_development_plan_id;

  end if;


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
      'not authorized to view role-development assessment availability';

  end if;


  return query


  with current_readiness as (

    select
      comparison.master_competency_template_id,
      comparison.target_status

    from public.wri_compare_employee_role_readiness(
      v_plan.employee_id,
      v_plan.target_master_role_template_id
    ) comparison

  ),


  activity_scope as (

    select

      dpa.id as activity_id,

      dpa.master_competency_template_id,

      dpa.target_required_level_snapshot
        as target_required_level

    from public.development_plan_activities dpa

    join current_readiness cr
      on cr.master_competency_template_id =
         dpa.master_competency_template_id

    where dpa.development_plan_id =
      p_development_plan_id

      -- Historical reason this activity exists.
      and dpa.target_status_snapshot =
        'not_assessed'

      -- Terminal activities must not relaunch.
      and dpa.status not in (
        'completed',
        'cancelled'
      )

      -- Live canonical readiness must still require assessment.
      and cr.target_status =
        'not_assessed'

      and dpa.master_competency_template_id
        is not null

      and dpa.target_required_level_snapshot
        between 1 and 4

  ),


  candidate_metrics as (

    select

      activity_scope.activity_id,

      activity_scope.master_competency_template_id,

      activity_scope.target_required_level,

      a.id as assessment_id,

      a.name as assessment_name,

      a.version,

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

    from activity_scope

    join public.master_competency_templates mct
      on mct.id =
         activity_scope.master_competency_template_id
     and mct.is_current = true

    join public.assessments a
      on a.client_id is null
     and a.is_current = true
     and a.type = 'competency'
     and a.master_competency_template_id =
         activity_scope.master_competency_template_id
     and a.industry_id =
         mct.industry_id

     -- Critical level-aware rule.
     and a.target_level =
         activity_scope.target_required_level

    left join public.assessment_questions q
      on q.assessment_id =
         a.id

     and q.master_competency_template_id =
         activity_scope.master_competency_template_id

     and q.source_master_question_id
         is not null

    left join public.assessment_question_answer_keys k
      on k.question_id =
         q.id

    group by

      activity_scope.activity_id,

      activity_scope.master_competency_template_id,

      activity_scope.target_required_level,

      a.id,

      a.name,

      a.version

  ),


  candidates_with_standard as (

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
        s.id is not null

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
         cm.master_competency_template_id

     and s.target_level =
         cm.target_required_level

     and s.is_current = true

  ),


  ranked_candidates as (

    select

      cws.*,

      row_number() over (

        partition by
          cws.activity_id

        order by

          cws.production_ready desc,

          (
            cws.question_count > 0

            and cws.answer_key_count =
                cws.question_count
          ) desc,

          cws.question_count desc,

          cws.version desc,

          cws.assessment_name,

          cws.assessment_id

      ) as candidate_rank

    from candidates_with_standard cws

  )


  select

    activity_scope.activity_id,

    activity_scope.master_competency_template_id,

    mct.name
      as competency_name,

    activity_scope.target_required_level,

    ranked_candidates.assessment_id,

    ranked_candidates.assessment_name,

    coalesce(
      ranked_candidates.question_count,
      0
    )::integer
      as question_count,

    coalesce(
      ranked_candidates.answer_key_count,
      0
    )::integer
      as answer_key_count,

    coalesce(
      ranked_candidates.production_ready,
      false
    )
      as assessment_available


  from activity_scope


  join public.master_competency_templates mct
    on mct.id =
       activity_scope.master_competency_template_id


  left join ranked_candidates
    on ranked_candidates.activity_id =
       activity_scope.activity_id

   and ranked_candidates.candidate_rank =
       1


  order by
    activity_scope.activity_id;

end;

$function$;


-- ============================================================================
-- 2. LEVEL-AWARE START / RESUME
-- ============================================================================

create or replace function
public.wri_start_role_development_competency_assessment(
  p_development_plan_activity_id uuid
)

returns uuid

language plpgsql

security definer

set search_path to 'public'

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

  v_existing_assessment_id uuid;

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


  if v_activity.target_required_level_snapshot
    not between 1 and 4
  then

    raise exception
      'development activity % has invalid target required level %',
      v_activity.id,
      v_activity.target_required_level_snapshot;

  end if;


  -- Confirm exact competency + target level still belong to the target role.

  if not exists (

    select 1

    from public.master_role_competency_requirements mrcr

    where mrcr.master_role_template_id =
      v_plan.target_master_role_template_id

      and mrcr.master_competency_template_id =
        v_activity.master_competency_template_id

      and mrcr.required_level =
        v_activity.target_required_level_snapshot

  ) then

    raise exception
      'activity competency/level is no longer a requirement of target role %',
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
  -- IMPORTANT:
  -- Validate LIVE availability BEFORE considering an unfinished attempt.
  --
  -- This prevents an old attempt from being resumed after canonical readiness
  -- has changed or after the target-level assessment is no longer eligible.
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
      'production assessment content is not available for development activity % at target level %',
      v_activity.id,
      v_activity.target_required_level_snapshot;

  end if;


  -- --------------------------------------------------------------------------
  -- Resume an unfinished attempt only when it uses the CURRENTLY VALIDATED
  -- target-level assessment.
  -- --------------------------------------------------------------------------

  select
    aa.id,
    aa.assessment_id

  into
    v_existing_attempt_id,
    v_existing_assessment_id

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

    if v_existing_assessment_id
      is distinct from
        v_assessment_id
    then

      raise exception
        'unfinished attempt % uses assessment %, but development activity % now requires target-level assessment %',
        v_existing_attempt_id,
        v_existing_assessment_id,
        v_activity.id,
        v_assessment_id;

    end if;


    return
      v_existing_attempt_id;

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
  -- Snapshot ONLY questions for this exact Master Competency.
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


-- ============================================================================
-- 3. VERIFICATION — ALEX TECHNICIAN III AVAILABILITY
--
-- This should continue to expose only currently-not-assessed activities whose
-- production assessment target_level exactly matches the Technician III
-- requirement.
-- ============================================================================

select
  availability.competency_name,
  availability.target_required_level,
  availability.assessment_id,
  availability.assessment_name,
  a.target_level as assessment_target_level,
  availability.question_count,
  availability.answer_key_count,
  availability.assessment_available

from public.wri_role_development_assessment_availability(
  'ec11a1ab-63c7-4dc9-af4c-aade2c4ca547'::uuid
) availability

left join public.assessments a
  on a.id =
     availability.assessment_id

order by
  availability.competency_name;


-- ============================================================================
-- 4. VERIFICATION — LEVEL MATCH INVARIANT
-- ============================================================================

select
  count(*) as mismatched_available_assessments

from public.wri_role_development_assessment_availability(
  'ec11a1ab-63c7-4dc9-af4c-aade2c4ca547'::uuid
) availability

join public.assessments a
  on a.id =
     availability.assessment_id

where availability.assessment_available = true

  and a.target_level
      is distinct from
      availability.target_required_level;

