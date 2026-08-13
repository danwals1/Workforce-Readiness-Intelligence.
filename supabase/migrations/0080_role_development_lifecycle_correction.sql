-- ============================================================================
-- 0080_role_development_lifecycle_correction.sql
--
-- Correct Role Development lifecycle behavior.
--
-- 1. Preserve target_status_snapshot as historical plan-generation context.
-- 2. Add awaiting_target_readiness resolution state.
-- 3. Assessment availability uses CURRENT canonical target readiness.
-- 4. Completed Role Development assessments complete their linked activity.
-- 5. Role-comparison plans cannot resolve until current target-role readiness
--    reaches 100%.
-- ============================================================================


-- ============================================================================
-- 1. ADD ROLE-COMPARISON RESOLUTION STATE
-- ============================================================================

alter table public.development_plans
drop constraint if exists development_plans_resolution_status_check;

alter table public.development_plans
add constraint development_plans_resolution_status_check
check (
  resolution_status = any (
    array[
      'development_in_progress'::text,
      'awaiting_reassessment'::text,
      'awaiting_verification'::text,
      'awaiting_reverification'::text,
      'awaiting_target_readiness'::text,
      'resolved'::text,
      'cancelled'::text
    ]
  )
);


-- ============================================================================
-- 2. CURRENT ROLE-DEVELOPMENT ASSESSMENT AVAILABILITY
--
-- target_status_snapshot remains immutable history.
--
-- An assessment activity is available only while:
--   - it originated as not_assessed,
--   - the activity itself is still active, and
--   - canonical CURRENT target-role readiness still says not_assessed.
-- ============================================================================

create or replace function public.wri_role_development_assessment_availability(
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
set search_path = public
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
  where id = p_development_plan_id;

  if not found then
    raise exception
      'development plan % not found',
      p_development_plan_id;
  end if;


  if v_plan.origin <> 'role_comparison' then
    raise exception
      'development plan % is not a role-comparison development plan',
      p_development_plan_id;
  end if;


  select *
  into v_employee
  from public.employees
  where id = v_plan.employee_id;

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

    or v_employee.auth_user_id = auth.uid()
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

      -- Historical origin of this activity.
      and dpa.target_status_snapshot =
        'not_assessed'

      -- Completed/cancelled assessment activities must not relaunch.
      and dpa.status not in (
        'completed',
        'cancelled'
      )

      -- Current canonical state must still require assessment.
      and cr.target_status =
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

    left join public.assessment_question_answer_keys k

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

$function$;


-- ============================================================================
-- 3. COMPLETE LINKED ACTIVITY WHEN ROLE-DEVELOPMENT ASSESSMENT COMPLETES
--
-- Assessment completion is development-activity completion.
-- Practical verification remains a separate evidence lifecycle.
-- ============================================================================

create or replace function
public.wri_complete_role_development_assessment_activity()
returns trigger
language plpgsql
security definer
set search_path = public
as $function$

declare
  v_plan_id uuid;

begin

  if
    new.attempt_mode = 'role_development_assessment'

    and new.status = 'completed'

    and old.status is distinct from 'completed'

    and new.development_plan_activity_id
      is not null
  then

    update public.development_plan_activities

    set
      status = 'completed',

      completed_at =
        coalesce(
          completed_at,
          new.completed_at,
          now()
        ),

      updated_at = now()

    where id =
      new.development_plan_activity_id

      and status <> 'cancelled'

    returning development_plan_id
    into v_plan_id;


    if v_plan_id is not null then

      perform
        public.wri_refresh_development_plan_status(
          v_plan_id
        );

      perform
        public.wri_refresh_development_plan_resolution(
          v_plan_id
        );

    end if;

  end if;


  return new;

end;

$function$;


drop trigger if exists
  trg_wri_complete_role_development_assessment_activity
on public.assessment_attempts;


create trigger
  trg_wri_complete_role_development_assessment_activity

after update of status
on public.assessment_attempts

for each row

execute function
  public.wri_complete_role_development_assessment_activity();


-- ============================================================================
-- 4. ROLE-COMPARISON RESOLUTION GUARD
--
-- Existing resolver currently reaches the generic/manual resolved path because
-- role-comparison plans intentionally have action_key = NULL.
--
-- Intercept that transition:
--
--   activities complete + target readiness < 100
--       => awaiting_target_readiness
--
--   activities complete + target readiness = 100
--       => resolved
--
-- Historical resolved Role Development plans remain resolved.
-- ============================================================================

create or replace function
public.wri_guard_role_comparison_resolution()
returns trigger
language plpgsql
security definer
set search_path = public
as $function$

declare
  v_not_ready_count integer;

begin

  -- Only intercept a NEW transition into resolved.
  --
  -- Once historically resolved, a Role Development plan remains resolved even
  -- if evidence later expires.

  if
    new.origin = 'role_comparison'

    and new.resolution_status = 'resolved'

    and old.resolution_status
      is distinct from 'resolved'
  then

    if
      new.employee_id is null

      or new.target_master_role_template_id
        is null
    then

      raise exception
        'role-comparison development plan % is missing employee or target role',
        new.id;

    end if;


    select
      count(*) filter (
        where comparison.target_status <> 'ready'
      )::integer

    into
      v_not_ready_count

    from public.wri_compare_employee_role_readiness(
      new.employee_id,
      new.target_master_role_template_id
    ) comparison;


    if coalesce(v_not_ready_count, 0) > 0 then

      new.resolution_status :=
        'awaiting_target_readiness';

      new.development_completed_at :=
        coalesce(
          new.development_completed_at,
          new.completed_at,
          now()
        );

      new.awaiting_evidence_since :=
        coalesce(
          new.awaiting_evidence_since,
          new.completed_at,
          now()
        );

      new.resolved_at :=
        null;

    end if;

  end if;


  return new;

end;

$function$;


drop trigger if exists
  trg_wri_guard_role_comparison_resolution
on public.development_plans;


create trigger
  trg_wri_guard_role_comparison_resolution

before update of resolution_status
on public.development_plans

for each row

execute function
  public.wri_guard_role_comparison_resolution();


-- ============================================================================
-- 5. BACKFILL ALREADY-COMPLETED ROLE-DEVELOPMENT ASSESSMENT ACTIVITIES
--
-- Only assessment activities with an actual completed linked assessment attempt
-- are completed here.
--
-- We do NOT infer activity completion merely because current readiness is ready.
-- ============================================================================

update public.development_plan_activities dpa

set
  status = 'completed',

  completed_at =
    coalesce(
      dpa.completed_at,
      evidence.completed_at,
      now()
    ),

  updated_at = now()

from (

  select
    aa.development_plan_activity_id,

    min(
      coalesce(
        aa.completed_at,
        aa.updated_at,
        aa.created_at
      )
    ) as completed_at

  from public.assessment_attempts aa

  where aa.attempt_mode =
    'role_development_assessment'

    and aa.status =
      'completed'

    and aa.development_plan_activity_id
      is not null

  group by
    aa.development_plan_activity_id

) evidence

where dpa.id =
  evidence.development_plan_activity_id

  and dpa.target_status_snapshot =
    'not_assessed'

  and dpa.status not in (
    'completed',
    'cancelled'
  );


-- Refresh parent development status for affected plans.
--
-- Resolution will continue through the normal lifecycle whenever the plan
-- reaches activity completion.

do $$
declare
  r record;
begin

  for r in

    select distinct
      dpa.development_plan_id

    from public.development_plan_activities dpa

    join public.assessment_attempts aa
      on aa.development_plan_activity_id =
         dpa.id

    where aa.attempt_mode =
      'role_development_assessment'

      and aa.status =
        'completed'

  loop

    perform
      public.wri_refresh_development_plan_status(
        r.development_plan_id
      );

  end loop;

end;
$$;


-- ============================================================================
-- 6. VERIFICATION
-- ============================================================================

select
  conname,
  pg_get_constraintdef(oid) as definition
from pg_constraint
where conrelid =
  'public.development_plans'::regclass
  and conname =
    'development_plans_resolution_status_check';


select
  dpa.id as activity_id,
  mct.name as competency_name,
  dpa.target_status_snapshot,
  dpa.status as activity_status,
  dpa.completed_at
from public.development_plan_activities dpa
join public.master_competency_templates mct
  on mct.id =
     dpa.master_competency_template_id
where dpa.development_plan_id =
  'ec11a1ab-63c7-4dc9-af4c-aade2c4ca547'::uuid
  and mct.name in (
    'Client Communication',
    'AV Systems'
  )
order by mct.name;


select
  count(*) as currently_assessable_activities
from public.wri_role_development_assessment_availability(
  'ec11a1ab-63c7-4dc9-af4c-aade2c4ca547'::uuid
);
