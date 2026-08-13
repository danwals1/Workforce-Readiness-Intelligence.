-- ============================================================================
-- 0058_role_development_assessment_availability.sql
--
-- Purpose
-- -------
-- Provide database-driven assessment availability for competency-specific
-- Role Development activities.
--
-- A competency is assessment-ready only when:
--   1. it belongs to at least one current template assessment,
--   2. that assessment contains published/source-backed questions for the
--      exact master competency,
--   3. every selected question has a secure answer key.
--
-- This migration does NOT create assessment attempts.
-- It only exposes whether valid assessment content currently exists.
-- ============================================================================


create or replace function
public.wri_role_development_assessment_availability(
  p_development_plan_id uuid
)
returns table (
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

set search_path = public

as $$

declare

  v_plan
    public.development_plans%rowtype;

  v_employee
    public.employees%rowtype;

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


  if v_plan.origin <>
    'role_comparison'
  then

    raise exception
      'development plan % is not a role-comparison development plan',
      p_development_plan_id;

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
      'not authorized to view role-development assessment availability';

  end if;


  -- --------------------------------------------------------------------------
  -- Availability
  --
  -- One row per linked not-assessed Role Development activity.
  --
  -- If multiple current template assessments contain the competency,
  -- choose the assessment with the strongest usable question coverage.
  -- Ties are resolved deterministically by assessment name then id.
  -- --------------------------------------------------------------------------

  return query

  with activity_scope as (

    select

      dpa.id as activity_id,

      dpa.master_competency_template_id,

      dpa.target_required_level_snapshot
        as target_required_level

    from
      public.development_plan_activities dpa

    where dpa.development_plan_id =
      p_development_plan_id

      and dpa.target_status_snapshot =
        'not_assessed'

      and dpa.master_competency_template_id
        is not null

  ),

  candidate_assessments as (

    select

      activity_scope.activity_id,

      activity_scope.master_competency_template_id,

      activity_scope.target_required_level,

      a.id as assessment_id,

      a.name as assessment_name,

      count(distinct q.id)::integer
        as question_count,

      count(distinct k.question_id)::integer
        as answer_key_count

    from activity_scope

    join public.assessment_questions q

      on q.master_competency_template_id =
        activity_scope.master_competency_template_id

      and q.source_master_question_id
        is not null

    join public.assessments a

      on a.id =
        q.assessment_id

      and a.client_id
        is null

      and a.is_current =
        true

    left join
      public.assessment_question_answer_keys k

      on k.question_id =
        q.id

    group by

      activity_scope.activity_id,

      activity_scope.master_competency_template_id,

      activity_scope.target_required_level,

      a.id,

      a.name

  ),

  ranked_candidates as (

    select

      candidate_assessments.*,

      row_number() over (

        partition by
          candidate_assessments.activity_id

        order by

          (
            candidate_assessments.question_count > 0

            and

            candidate_assessments.answer_key_count =
              candidate_assessments.question_count
          ) desc,

          candidate_assessments.question_count desc,

          candidate_assessments.assessment_name,

          candidate_assessments.assessment_id

      ) as candidate_rank

    from candidate_assessments

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

    (
      coalesce(
        ranked_candidates.question_count,
        0
      ) > 0

      and

      coalesce(
        ranked_candidates.answer_key_count,
        0
      ) =
      coalesce(
        ranked_candidates.question_count,
        0
      )
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

$$;


comment on function
public.wri_role_development_assessment_availability(uuid)
is
'Returns competency-specific assessment-content availability for linked not-assessed Role Development activities. Availability requires a current template assessment with source-backed questions and secure answer keys for every selected question.';


revoke all
on function
public.wri_role_development_assessment_availability(uuid)
from public, anon;


grant execute
on function
public.wri_role_development_assessment_availability(uuid)
to authenticated;
