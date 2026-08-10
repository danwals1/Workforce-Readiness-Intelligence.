-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0024_development_plan_origin_attempt.sql
--
-- PURPOSE
--
-- Permanently store the assessment attempt that generated a readiness action
-- when a Development Plan is created.
--
-- This enables reliable before/after evidence:
--
-- Original Assessment Attempt
--          ↓
-- Development Plan
--          ↓
-- Targeted Reassessment
--          ↓
-- Resolution Evidence
--
-- ============================================================================


-- ============================================================================
-- PART 1 — REPLACE DEVELOPMENT PLAN CREATION RPC
-- ============================================================================

create or replace function
wri_create_development_plan_from_action(

  p_action_key text,

  p_title text default null,

  p_description text default null,

  p_development_type text default 'training',

  p_priority text default null,

  p_due_date date default null

)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_action
    v_readiness_action_queue%rowtype;

  v_plan_id uuid;

  v_priority text;

begin

  -- --------------------------------------------------------------------------
  -- Locate readiness action
  -- --------------------------------------------------------------------------

  select *

  into v_action

  from v_readiness_action_queue

  where action_key =
    p_action_key;


  if not found then

    raise exception
      'Readiness action not found.';

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (

    wri_is_integrateu_admin()

    or v_action.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'Not authorized to create a development plan for this employee.';

  end if;


  -- --------------------------------------------------------------------------
  -- Prevent duplicate active plan from same action
  -- --------------------------------------------------------------------------

  select id

  into v_plan_id

  from development_plans

  where action_key =
      p_action_key

    and status not in (
      'completed',
      'cancelled'
    )

  order by created_at desc

  limit 1;


  if v_plan_id is not null then

    return
      v_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Convert queue priority into Development Plan priority
  -- --------------------------------------------------------------------------

  v_priority :=

    coalesce(

      p_priority,

      case

        when v_action.priority = 1
          then 'critical'

        when v_action.priority = 2
          then 'high'

        when v_action.priority = 3
          then 'medium'

        else 'medium'

      end

    );


  -- --------------------------------------------------------------------------
  -- Create Development Plan
  --
  -- IMPORTANT:
  --
  -- attempt_id now permanently records the assessment attempt that generated
  -- the readiness action.
  -- --------------------------------------------------------------------------

  insert into development_plans (

    client_id,

    employee_id,

    attempt_id,

    action_key,

    action_type,

    action_label,

    master_competency_template_id,

    competency_name_snapshot,

    role_name_snapshot,

    title,

    description,

    development_type,

    status,

    priority,

    start_date,

    due_date,

    created_by_user_id

  )

  values (

    v_action.client_id,

    v_action.employee_id,

    v_action.attempt_id,

    v_action.action_key,

    v_action.action_type,

    v_action.action_label,

    v_action.master_competency_template_id,

    v_action.competency_name,

    v_action.role_name,

    coalesce(

      nullif(
        trim(p_title),
        ''
      ),

      v_action.action_label

    ),

    coalesce(

      nullif(
        trim(p_description),
        ''
      ),

      v_action.action_detail

    ),

    p_development_type,

    'not_started',

    v_priority,

    current_date,

    p_due_date,

    auth.uid()

  )

  returning id

  into v_plan_id;


  return
    v_plan_id;

end;

$$;


-- ============================================================================
-- PART 2 — BACKFILL EXISTING DEVELOPMENT PLANS
--
-- Older readiness actions encoded their source attempt as:
--
-- ACTION_TYPE:EMPLOYEE_UUID:ATTEMPT_UUID
--
-- We only backfill when:
--
-- 1. attempt_id is currently NULL
-- 2. the third action_key component is a valid UUID
-- 3. that assessment_attempt actually exists
-- 4. it belongs to the same employee
--
-- This prevents arbitrary or malformed action keys from being written.
-- ============================================================================

with candidates as (

  select

    dp.id
      as development_plan_id,

    dp.employee_id,

    split_part(
      dp.action_key,
      ':',
      3
    )
      as possible_attempt_id

  from development_plans dp

  where dp.attempt_id
      is null

    and dp.action_key
      is not null

    and split_part(
      dp.action_key,
      ':',
      3
    ) ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$'

),

validated as (

  select

    c.development_plan_id,

    aa.id
      as attempt_id

  from candidates c

  join assessment_attempts aa
    on aa.id =
      c.possible_attempt_id::uuid

   and aa.employee_id =
      c.employee_id

)

update development_plans dp

set

  attempt_id =
    validated.attempt_id,

  updated_at =
    now()

from validated

where dp.id =
  validated.development_plan_id;


-- ============================================================================
-- PART 3 — INDEX
-- ============================================================================

create index if not exists
  development_plans_attempt_id_idx
on development_plans(
  attempt_id
);


-- ============================================================================
-- PART 4 — INSTALLATION CHECKS
-- ============================================================================

select

  id,

  employee_id,

  attempt_id,

  action_type,

  action_key,

  resolution_status

from development_plans

order by created_at desc;


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
    'wri_create_development_plan_from_action';