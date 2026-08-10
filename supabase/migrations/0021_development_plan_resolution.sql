-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0021_development_plan_resolution.sql
--
-- PURPOSE
--
-- Close the loop between:
--
-- Readiness Action
--      ↓
-- Development Plan
--      ↓
-- Development Activities
--      ↓
-- Verification / Reassessment
--      ↓
-- Readiness Engine
--      ↓
-- Resolution
--
-- IMPORTANT
--
-- Completing development activities does NOT automatically make an employee
-- ready.
--
-- Readiness remains controlled by the assessment / competency / practical
-- verification engine.
--
-- A development plan becomes RESOLVED only when its original readiness action
-- no longer exists in v_readiness_action_queue.
--
-- ============================================================================


-- ============================================================================
-- PART 1 — ADD RESOLUTION COLUMNS
-- ============================================================================

alter table development_plans

add column if not exists resolution_status text
  not null
  default 'development_in_progress',

add column if not exists development_completed_at timestamptz,

add column if not exists awaiting_evidence_since timestamptz,

add column if not exists resolved_at timestamptz,

add column if not exists resolution_notes text;


alter table development_plans
drop constraint if exists development_plans_resolution_status_check;


alter table development_plans
add constraint development_plans_resolution_status_check
check (
  resolution_status in (
    'development_in_progress',
    'awaiting_reassessment',
    'awaiting_verification',
    'awaiting_reverification',
    'resolved',
    'cancelled'
  )
);



-- ============================================================================
-- PART 2 — INDEXES
-- ============================================================================

create index if not exists
  development_plans_resolution_status_idx
on development_plans(
  resolution_status
);


create index if not exists
  development_plans_resolved_at_idx
on development_plans(
  resolved_at
);



-- ============================================================================
-- PART 3 — DETERMINE EXPECTED NEXT STEP
--
-- Converts the original readiness action into the evidence required after
-- development work is complete.
-- ============================================================================

create or replace function
wri_expected_resolution_status(
  p_action_type text
)
returns text

language sql

immutable

as $$

  select
    case

      when p_action_type in (
        'SAFETY_GAP',
        'CRITICAL_KNOWLEDGE_GAP',
        'KNOWLEDGE_DEVELOPMENT'
      )
        then 'awaiting_reassessment'

      when p_action_type in (
        'PRACTICAL_VERIFICATION_NEEDED',
        'PRACTICAL_DEVELOPMENT_NEEDED'
      )
        then 'awaiting_verification'

      when p_action_type in (
        'REVERIFICATION_DUE_SOON',
        'REVERIFICATION_REQUIRED'
      )
        then 'awaiting_reverification'

      else 'awaiting_reassessment'

    end;

$$;



-- ============================================================================
-- PART 4 — REFRESH ONE DEVELOPMENT PLAN RESOLUTION
--
-- LOGIC
--
-- 1. Cancelled plans remain cancelled.
--
-- 2. If the original readiness action no longer exists:
--      resolution_status = resolved
--
-- 3. If activities are not complete:
--      resolution_status = development_in_progress
--
-- 4. If activities ARE complete but the readiness action still exists:
--      knowledge / safety → awaiting_reassessment
--      practical          → awaiting_verification
--      reverification     → awaiting_reverification
-- ============================================================================

create or replace function
wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan development_plans%rowtype;

  v_action_exists boolean;

  v_activities_total integer;

  v_activities_remaining integer;

  v_expected_status text;

begin

  select *

  into v_plan

  from development_plans

  where id =
    p_development_plan_id;


  if not found then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancelled plan
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled' then

    update development_plans

    set
      resolution_status = 'cancelled',
      resolved_at = null

    where id =
      p_development_plan_id;

    return;

  end if;


  -- --------------------------------------------------------------------------
  -- Is original readiness action still active?
  -- --------------------------------------------------------------------------

  if v_plan.action_key is null then

    v_action_exists := true;

  else

    select exists (

      select 1

      from v_readiness_action_queue q

      where q.action_key =
        v_plan.action_key

    )

    into v_action_exists;

  end if;


  -- --------------------------------------------------------------------------
  -- If action has disappeared, readiness requirement has been satisfied.
  -- --------------------------------------------------------------------------

  if v_action_exists = false then

    update development_plans

    set
      resolution_status =
        'resolved',

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


  -- --------------------------------------------------------------------------
  -- Count active / unfinished development activities
  -- --------------------------------------------------------------------------

  select

    count(*) filter (
      where status <>
        'cancelled'
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

  from development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Development work still underway
  -- --------------------------------------------------------------------------

  if
    v_activities_total = 0

    or v_activities_remaining > 0
  then

    update development_plans

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
  -- Activities complete, but readiness action still exists.
  -- Employee now needs evidence / verification / reassessment.
  -- --------------------------------------------------------------------------

  v_expected_status :=
    wri_expected_resolution_status(
      v_plan.action_type
    );


  update development_plans

  set

    resolution_status =
      v_expected_status,

    development_completed_at =
      coalesce(
        development_completed_at,
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

$$;



-- ============================================================================
-- PART 5 — REFRESH ALL ACTIVE DEVELOPMENT PLANS
-- ============================================================================

create or replace function
wri_refresh_all_development_plan_resolutions()
returns integer

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan record;

  v_count integer := 0;

begin

  for v_plan in

    select id

    from development_plans

    where status <>
      'cancelled'

  loop

    perform
      wri_refresh_development_plan_resolution(
        v_plan.id
      );

    v_count :=
      v_count + 1;

  end loop;


  return v_count;

end;

$$;



-- ============================================================================
-- PART 6 — UPDATE ACTIVITY TRIGGER
--
-- Existing activity status changes already refresh the parent plan status.
--
-- Now they also refresh resolution status.
-- ============================================================================

create or replace function
wri_activity_refresh_parent_plan()
returns trigger

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan_id uuid;

begin

  v_plan_id :=
    coalesce(
      new.development_plan_id,
      old.development_plan_id
    );


  perform
    wri_refresh_development_plan_status(
      v_plan_id
    );


  perform
    wri_refresh_development_plan_resolution(
      v_plan_id
    );


  return
    coalesce(
      new,
      old
    );

end;

$$;



-- ============================================================================
-- PART 7 — RESOLUTION-AWARE SUMMARY VIEW
-- ============================================================================

create or replace view
v_development_plan_resolution
as

select

  s.*,

  dp.resolution_status,

  dp.development_completed_at,

  dp.awaiting_evidence_since,

  dp.resolved_at,

  dp.resolution_notes,

  case

    when dp.action_key is null
      then null

    else exists (

      select 1

      from v_readiness_action_queue q

      where q.action_key =
        dp.action_key

    )

  end
    as readiness_action_still_open,

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
      'cancelled'
      then 'Cancelled'

    else 'Development In Progress'

  end
    as resolution_label

from v_development_plan_summary s

join development_plans dp
  on dp.id =
    s.development_plan_id;



-- ============================================================================
-- PART 8 — PERMISSION-AWARE RESOLUTION LIST RPC
-- ============================================================================

create or replace function
wri_list_development_plan_resolutions(

  p_employee_id uuid default null,

  p_resolution_status text default null

)
returns setof v_development_plan_resolution

language sql

stable

security definer

set search_path = public

as $$

  select r.*

  from v_development_plan_resolution r

  where

    (
      wri_is_integrateu_admin()

      or r.client_id in (
        select wri_allowed_client_ids()
      )

      or exists (

        select 1

        from employees e

        where e.id =
          r.employee_id

          and e.auth_user_id =
            auth.uid()

      )

      or wri_can_verify_master_practical(
        r.employee_id
      )
    )

    and (
      p_employee_id is null

      or r.employee_id =
        p_employee_id
    )

    and (
      p_resolution_status is null

      or r.resolution_status =
        p_resolution_status
    )

  order by

    case r.resolution_status

      when 'awaiting_reverification'
        then 1

      when 'awaiting_verification'
        then 2

      when 'awaiting_reassessment'
        then 3

      when 'development_in_progress'
        then 4

      when 'resolved'
        then 5

      else 6

    end,

    r.due_date asc
      nulls last,

    r.created_at desc;

$$;



-- ============================================================================
-- PART 9 — GRANTS
-- ============================================================================

revoke all
on function
wri_refresh_development_plan_resolution(
  uuid
)
from public, anon;


grant execute
on function
wri_refresh_development_plan_resolution(
  uuid
)
to authenticated;



revoke all
on function
wri_refresh_all_development_plan_resolutions()
from public, anon;


grant execute
on function
wri_refresh_all_development_plan_resolutions()
to authenticated;



revoke all
on function
wri_list_development_plan_resolutions(
  uuid,
  text
)
from public, anon;


grant execute
on function
wri_list_development_plan_resolutions(
  uuid,
  text
)
to authenticated;



-- ============================================================================
-- PART 10 — INITIAL BACKFILL
--
-- Refresh resolution state for all plans currently in the system.
-- ============================================================================

select
  wri_refresh_all_development_plan_resolutions();



-- ============================================================================
-- PART 11 — INSTALLATION CHECKS
-- ============================================================================

select
  column_name
from information_schema.columns
where table_schema = 'public'
  and table_name = 'development_plans'
  and column_name in (
    'resolution_status',
    'development_completed_at',
    'awaiting_evidence_since',
    'resolved_at',
    'resolution_notes'
  )
order by column_name;


select
  table_name
from information_schema.views
where table_schema = 'public'
  and table_name =
    'v_development_plan_resolution';


select
  routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name in (
    'wri_expected_resolution_status',
    'wri_refresh_development_plan_resolution',
    'wri_refresh_all_development_plan_resolutions',
    'wri_list_development_plan_resolutions'
  )
order by routine_name;