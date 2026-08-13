-- ============================================================================
-- 0056_role_development_readiness_lifecycle.sql
--
-- Role-comparison Development Plans have two independent concepts:
--
--   1. Development execution
--      - represented by development_plans.status / activity completion
--
--   2. Target-role readiness
--      - represented by canonical competency evidence against the target
--        master role
--
-- Lifecycle:
--
--   activities incomplete
--     -> development_in_progress
--
--   activities complete, target role not fully ready
--     -> awaiting_target_readiness
--
--   activities complete, target role fully ready
--     -> resolved
--
-- A resolved role-development plan is historical and sticky. Later evidence
-- expiry does not reopen that historical plan.
-- ============================================================================


-- ============================================================================
-- PART 1 — ADD RESOLUTION STATUS
-- ============================================================================

alter table public.development_plans
  drop constraint if exists
  development_plans_resolution_status_check;

alter table public.development_plans
  add constraint
  development_plans_resolution_status_check
  check (
    resolution_status in (
      'development_in_progress',
      'awaiting_reassessment',
      'awaiting_verification',
      'awaiting_reverification',
      'awaiting_target_readiness',
      'resolved',
      'cancelled'
    )
  );


-- ============================================================================
-- PART 2 — INTERNAL CANONICAL TARGET-ROLE READINESS HELPER
--
-- This deliberately does NOT call the public comparison RPC because that RPC
-- contains interactive-user authorization checks.
--
-- The evidence rules below mirror
-- wri_compare_employee_role_readiness():
--
--   knowledge:
--     knowledge_level >= required_level
--
--   practical:
--     automatically satisfied if practical verification is not required
--     otherwise:
--       - verification must not be expired
--       - status must be verified
--       - rating must exist
--       - rating >= required level
--
-- Reverification-due evidence still counts as currently ready, matching the
-- comparison engine. Expired evidence does not.
-- ============================================================================

create or replace function
public.wri_role_target_readiness_percent(
  p_employee_id uuid,
  p_target_role_template_id uuid
)
returns numeric

language sql
stable
security definer

set search_path = public

as $function$

  with target_requirements as (

    select
      mrcr.master_competency_template_id,
      mrcr.required_level,

      coalesce(
        mcpp.practical_verification_required,
        false
      ) as practical_verification_required

    from public.master_role_competency_requirements mrcr

    left join
      public.v_master_competency_practical_policy mcpp

      on mcpp.master_competency_template_id =
         mrcr.master_competency_template_id

    where mrcr.master_role_template_id =
      p_target_role_template_id

  ),

  evaluated as (

    select
      tr.master_competency_template_id,

      (
        ee.knowledge_level is not null

        and ee.knowledge_level >=
            tr.required_level
      ) as knowledge_ready,

      case

        when
          tr.practical_verification_required = false
          then true

        when
          coalesce(
            ee.verification_expired,
            false
          ) = true
          then false

        when
          ee.practical_verification_status
            is distinct from 'verified'
          then false

        when
          ee.practical_rating_level is null
          then false

        when
          ee.practical_rating_level >=
            tr.required_level
          then true

        else false

      end as practical_ready

    from target_requirements tr

    left join
      public.v_employee_master_competency_evidence ee

      on ee.employee_id =
         p_employee_id

     and ee.master_competency_template_id =
         tr.master_competency_template_id

  )

  select

    case
      when count(*) = 0
        then null

      else
        round(
          100.0
          *
          count(*) filter (
            where knowledge_ready
              and practical_ready
          )
          /
          count(*),
          1
        )
    end

  from evaluated;

$function$;


revoke all
on function
public.wri_role_target_readiness_percent(
  uuid,
  uuid
)
from public, anon, authenticated;


comment on function
public.wri_role_target_readiness_percent(
  uuid,
  uuid
)
is
'Internal canonical target-role readiness percentage used by Development Plan lifecycle resolution. Mirrors master-role comparison evidence rules without interactive auth checks.';


-- ============================================================================
-- PART 3 — ROLE-COMPARISON-AWARE DEVELOPMENT PLAN RESOLVER
-- ============================================================================

create or replace function
public.wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void

language plpgsql
security definer

set search_path = public

as $function$

declare

  v_plan
    public.development_plans%rowtype;

  v_action_exists boolean;

  v_successor_action_exists boolean;

  v_activities_total integer;

  v_activities_remaining integer;

  v_expected_status text;

  v_required_level integer;

  v_evidence_required_since timestamptz;

  v_qualifying_verification_id uuid;

  v_qualifying_verified_at timestamptz;

  v_target_readiness_percent numeric;

begin


  -- --------------------------------------------------------------------------
  -- Locate plan.
  -- --------------------------------------------------------------------------

  select *
  into v_plan

  from public.development_plans

  where id =
    p_development_plan_id;


  if not found then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancelled plans remain cancelled.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled' then

    update public.development_plans

    set
      resolution_status =
        'cancelled',

      development_completed_at =
        null,

      awaiting_evidence_since =
        null,

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Sticky historical role-development resolution.
  --
  -- Once a role-comparison plan reaches its target and resolves, later
  -- reverification expiry must not rewrite that historical outcome.
  -- --------------------------------------------------------------------------

  if
    v_plan.origin =
      'role_comparison'

    and v_plan.resolution_status =
      'resolved'
  then

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- DEVELOPMENT CYCLE HOLD
  --
  -- Evidence / readiness phases begin only after development status completes.
  -- --------------------------------------------------------------------------

  if v_plan.status = 'in_progress' then

    update public.development_plans

    set
      resolution_status =
        'development_in_progress',

      development_completed_at =
        null,

      awaiting_evidence_since =
        null,

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Count active / unfinished development activities.
  -- --------------------------------------------------------------------------

  select

    count(*) filter (
      where status <> 'cancelled'
    ),

    count(*) filter (
      where status not in (
        'completed',
        'cancelled'
      )
    )

  into
    v_activities_total,
    v_activities_remaining

  from public.development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Development work is still underway.
  --
  -- A plan with zero activities remains development_in_progress.
  -- --------------------------------------------------------------------------

  if
    v_activities_total = 0
    or v_activities_remaining > 0
  then

    update public.development_plans

    set
      resolution_status =
        'development_in_progress',

      development_completed_at =
        null,

      awaiting_evidence_since =
        null,

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- ==========================================================================
  -- ROLE-COMPARISON DEVELOPMENT PLAN
  --
  -- IMPORTANT:
  -- This branch MUST precede the manual-plan action_key-null branch.
  -- ==========================================================================

  if v_plan.origin = 'role_comparison' then

    -- Target metadata is mandatory for this origin.

    if v_plan.target_master_role_template_id is null then

      raise exception
        'Role-comparison Development Plan % is missing target master role',
        p_development_plan_id;

    end if;


    -- Capture when assigned development work finished.

    v_evidence_required_since :=
      coalesce(
        v_plan.development_completed_at,
        v_plan.completed_at,
        now()
      );


    -- Canonical current target-role readiness.

    v_target_readiness_percent :=
      public.wri_role_target_readiness_percent(
        v_plan.employee_id,
        v_plan.target_master_role_template_id
      );


    -- No requirements is not considered successful readiness.

    if
      v_target_readiness_percent is not null
      and v_target_readiness_percent >= 100
    then

      update public.development_plans

      set
        resolution_status =
          'resolved',

        development_completed_at =
          v_evidence_required_since,

        awaiting_evidence_since =
          null,

        resolved_at =
          coalesce(
            resolved_at,
            now()
          ),

        resolution_notes =
          coalesce(
            resolution_notes,
            'Target-role readiness reached 100% after completion of assigned development work.'
          )

      where id =
        p_development_plan_id;

      return;

    end if;


    -- Development execution is complete, but competency evidence does not yet
    -- satisfy the entire target role.

    update public.development_plans

    set
      resolution_status =
        'awaiting_target_readiness',

      development_completed_at =
        v_evidence_required_since,

      awaiting_evidence_since =
        coalesce(
          awaiting_evidence_since,
          v_evidence_required_since
        ),

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- MANUAL DEVELOPMENT PLAN
  -- --------------------------------------------------------------------------

  if v_plan.action_key is null then

    update public.development_plans

    set
      resolution_status =
        'resolved',

      development_completed_at =
        coalesce(
          development_completed_at,
          completed_at,
          now()
        ),

      awaiting_evidence_since =
        null,

      resolved_at =
        coalesce(
          resolved_at,
          completed_at,
          now()
        )

    where id =
      p_development_plan_id;

    return;

  end if;


  -- ==========================================================================
  -- PRACTICAL / REVERIFICATION EVIDENCE GATE
  -- ==========================================================================

  if
    v_plan.action_type in (
      'PRACTICAL_VERIFICATION_NEEDED',
      'PRACTICAL_DEVELOPMENT_NEEDED',
      'REVERIFICATION_DUE_SOON',
      'REVERIFICATION_REQUIRED'
    )
    and v_plan.master_competency_template_id is not null
  then


    v_evidence_required_since :=
      coalesce(
        v_plan.development_completed_at,
        v_plan.completed_at,
        now()
      );


    select
      acr.required_level

    into
      v_required_level

    from public.v_assessment_competency_readiness_current acr

    where acr.employee_id =
      v_plan.employee_id

      and acr.master_competency_template_id =
        v_plan.master_competency_template_id

    limit 1;


    v_qualifying_verification_id :=
      null;

    v_qualifying_verified_at :=
      null;


    if v_required_level is not null then

      select
        pv.id,
        pv.verified_at

      into
        v_qualifying_verification_id,
        v_qualifying_verified_at

      from public.master_practical_verifications pv

      where pv.employee_id =
        v_plan.employee_id

        and pv.master_competency_template_id =
          v_plan.master_competency_template_id

        and pv.status =
          'verified'

        and pv.rating_level >=
          v_required_level

        and pv.verified_at >=
          v_evidence_required_since

      order by
        pv.verified_at asc,
        pv.id asc

      limit 1;

    end if;


    if v_qualifying_verification_id is not null then

      update public.development_plans

      set
        resolution_status =
          'resolved',

        development_completed_at =
          v_evidence_required_since,

        awaiting_evidence_since =
          null,

        resolved_at =
          v_qualifying_verified_at

      where id =
        p_development_plan_id;

      return;

    end if;


    v_expected_status :=
      public.wri_expected_resolution_status(
        v_plan.action_type
      );


    update public.development_plans

    set
      resolution_status =
        v_expected_status,

      development_completed_at =
        v_evidence_required_since,

      awaiting_evidence_since =
        coalesce(
          awaiting_evidence_since,
          v_evidence_required_since
        ),

      resolved_at =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- ==========================================================================
  -- READINESS-GENERATED NON-PRACTICAL DEVELOPMENT PLAN
  -- ==========================================================================

  select exists (

    select 1

    from public.v_readiness_action_queue q

    where q.action_key =
      v_plan.action_key

  )
  into v_action_exists;


  v_successor_action_exists :=
    false;


  if
    v_action_exists = false

    and v_plan.action_type in (
      'SAFETY_GAP',
      'CRITICAL_KNOWLEDGE_GAP',
      'KNOWLEDGE_DEVELOPMENT'
    )

    and v_plan.master_competency_template_id is not null
  then

    select exists (

      select 1

      from public.v_readiness_action_queue q

      where q.employee_id =
        v_plan.employee_id

        and q.master_competency_template_id =
          v_plan.master_competency_template_id

        and q.action_type in (
          'SAFETY_GAP',
          'CRITICAL_KNOWLEDGE_GAP',
          'KNOWLEDGE_DEVELOPMENT'
        )

    )
    into v_successor_action_exists;


    if v_successor_action_exists then
      v_action_exists := true;
    end if;

  end if;


  if v_action_exists = false then

    update public.development_plans

    set
      resolution_status =
        'resolved',

      development_completed_at =
        coalesce(
          development_completed_at,
          completed_at,
          now()
        ),

      resolved_at =
        coalesce(
          resolved_at,
          now()
        ),

      awaiting_evidence_since =
        null

    where id =
      p_development_plan_id;

    return;

  end if;


  v_expected_status :=
    public.wri_expected_resolution_status(
      v_plan.action_type
    );


  update public.development_plans

  set
    resolution_status =
      v_expected_status,

    development_completed_at =
      coalesce(
        development_completed_at,
        completed_at,
        now()
      ),

    awaiting_evidence_since =
      coalesce(
        awaiting_evidence_since,
        now()
      ),

    resolved_at =
      null

  where id =
    p_development_plan_id;


end;

$function$;


-- ============================================================================
-- PART 4 — RESOLUTION VIEW LABEL
-- ============================================================================

create or replace view
public.v_development_plan_resolution
as

select
  s.development_plan_id,
  s.client_id,
  s.employee_id,
  s.first_name,
  s.last_name,
  s.employee_number,
  s.action_key,
  s.action_type,
  s.action_label,
  s.master_competency_template_id,
  s.competency_name_snapshot,
  s.role_name_snapshot,
  s.title,
  s.description,
  s.development_type,
  s.status,
  s.priority,
  s.start_date,
  s.due_date,
  s.completed_at,
  s.owner_user_id,
  s.manager_notes,
  s.employee_notes,
  s.created_by_user_id,
  s.created_at,
  s.updated_at,
  s.activities_total,
  s.activities_completed,
  s.activities_blocked,
  s.completion_percent,
  s.overdue,

  dp.resolution_status,
  dp.development_completed_at,
  dp.awaiting_evidence_since,
  dp.resolved_at,
  dp.resolution_notes,

  case

    when dp.action_key is null
      then null::boolean

    else exists (

      select 1

      from public.v_readiness_action_queue q

      where q.action_key =
        dp.action_key

    )

  end as readiness_action_still_open,

  case

    when dp.resolution_status =
      'resolved'
      then 'Resolved'

    when dp.resolution_status =
      'awaiting_reassessment'
      then 'Awaiting Reassessment'

    when dp.resolution_status =
      'awaiting_verification'
      then 'Awaiting Practical Verification'

    when dp.resolution_status =
      'awaiting_reverification'
      then 'Awaiting Reverification'

    when dp.resolution_status =
      'awaiting_target_readiness'
      then 'Awaiting Target Readiness'

    when dp.resolution_status =
      'cancelled'
      then 'Cancelled'

    else
      'Development In Progress'

  end as resolution_label

from public.v_development_plan_summary s

join public.development_plans dp
  on dp.id =
     s.development_plan_id;


-- ============================================================================
-- PART 5 — REFRESH EXISTING OPEN ROLE-COMPARISON PLANS
-- ============================================================================

do $block$

declare
  v_plan_id uuid;

begin

  for v_plan_id in

    select id

    from public.development_plans

    where origin =
      'role_comparison'

      and resolution_status not in (
        'resolved',
        'cancelled'
      )

  loop

    perform
      public.wri_refresh_development_plan_status(
        v_plan_id
      );

    perform
      public.wri_refresh_development_plan_resolution(
        v_plan_id
      );

  end loop;

end;

$block$;


comment on column
public.development_plans.resolution_status
is
'Development lifecycle state. awaiting_target_readiness means role-development execution is complete but canonical evidence does not yet satisfy 100% of the target master role.';
