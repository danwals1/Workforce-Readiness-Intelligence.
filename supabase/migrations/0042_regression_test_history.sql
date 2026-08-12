-- ============================================================================
-- 0042_regression_test_history.sql
--
-- PURPOSE
--
-- Add an immutable regression-event history for TEST employees.
--
-- This gives /admin/testing a durable audit trail of Development Plan
-- lifecycle transitions without hard-coding specific employees or plans.
--
-- Only employees whose employee_number contains TEST are recorded.
--
-- Examples captured automatically:
--
--   development_in_progress
--      -> awaiting_reassessment
--
--   awaiting_reassessment
--      -> development_in_progress
--
--   awaiting_reassessment
--      -> resolved
--
--   awaiting_verification
--      -> development_in_progress
--
--   awaiting_verification
--      -> resolved
--
--   awaiting_reverification
--      -> development_in_progress
--
--   awaiting_reverification
--      -> resolved
--
--   any active lifecycle
--      -> cancelled
--
-- The event also snapshots the current readiness action for the same
-- employee + competency so successor-action transitions can be seen later.
-- ============================================================================


-- ============================================================================
-- PART 1 — EVENT TABLE
-- ============================================================================

create table if not exists
public.system_regression_test_events
(
  id uuid
    primary key
    default gen_random_uuid(),

  employee_id uuid
    not null
    references public.employees(id)
    on delete cascade,

  development_plan_id uuid
    not null
    references public.development_plans(id)
    on delete cascade,

  event_type text
    not null,

  plan_title text
    not null,

  action_type text,

  action_key text,

  old_status text,

  new_status text,

  old_resolution_status text,

  new_resolution_status text,

  current_readiness_action_type text,

  current_readiness_action_key text,

  recorded_by_user_id uuid,

  event_at timestamptz
    not null
    default now(),

  constraint
    system_regression_test_events_event_type_check
  check (
    event_type in (
      'plan_created',
      'lifecycle_transition'
    )
  )
);


create index if not exists
system_regression_test_events_employee_idx
on public.system_regression_test_events
(
  employee_id,
  event_at desc
);


create index if not exists
system_regression_test_events_plan_idx
on public.system_regression_test_events
(
  development_plan_id,
  event_at desc
);


create index if not exists
system_regression_test_events_resolution_idx
on public.system_regression_test_events
(
  new_resolution_status,
  event_at desc
);


comment on table
public.system_regression_test_events
is
'Immutable lifecycle-event history used by the IntegrateU Admin regression testing workspace. Only Development Plans belonging to TEST employees are recorded.';


-- ============================================================================
-- PART 2 — ROW LEVEL SECURITY
-- ============================================================================

alter table
public.system_regression_test_events
enable row level security;


drop policy if exists
"IntegrateU admins can view regression test events"
on public.system_regression_test_events;


create policy
"IntegrateU admins can view regression test events"

on public.system_regression_test_events

for select

to authenticated

using (
  public.wri_is_integrateu_admin()
);


-- No INSERT / UPDATE / DELETE policies are intentionally provided.
--
-- Application users cannot directly write regression history.
-- Events are created only through the SECURITY DEFINER lifecycle trigger.


-- ============================================================================
-- PART 3 — REGRESSION EVENT RECORDER
-- ============================================================================

create or replace function
public.wri_record_development_plan_regression_event()
returns trigger

language plpgsql

security definer

set search_path = public

as $$

declare

  v_is_test_employee boolean;

  v_current_readiness_action_type text;

  v_current_readiness_action_key text;

  v_event_type text;

begin

  -- --------------------------------------------------------------------------
  -- Only TEST employees participate in regression history.
  -- --------------------------------------------------------------------------

  select exists (

    select 1

    from public.employees e

    where e.id =
      new.employee_id

      and coalesce(
        e.employee_number,
        ''
      ) ilike '%TEST%'

  )

  into v_is_test_employee;


  if v_is_test_employee = false then
    return new;
  end if;


  -- --------------------------------------------------------------------------
  -- UPDATE events are lifecycle events only when the resolution state or
  -- readiness-action identity changes.
  --
  -- Development Plan status can change in an intermediate UPDATE before the
  -- resolution engine performs the actual lifecycle transition. Recording
  -- that intermediate UPDATE creates duplicate/noisy regression events.
  -- --------------------------------------------------------------------------

  if tg_op = 'UPDATE' then

    if
      old.resolution_status
        is not distinct from
        new.resolution_status

      and old.action_type
        is not distinct from
        new.action_type

      and old.action_key
        is not distinct from
        new.action_key

    then
      return new;
    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- Snapshot the current readiness action for the same competency.
  --
  -- This is especially useful when:
  --
  --   REVERIFICATION_DUE_SOON
  --      -> failed reverification
  --      -> PRACTICAL_DEVELOPMENT_NEEDED
  --
  -- The Development Plan retains its original reverification action type,
  -- while this event records the successor action that currently exists.
  -- --------------------------------------------------------------------------

  v_current_readiness_action_type :=
    null;

  v_current_readiness_action_key :=
    null;


  if new.master_competency_template_id is not null then

    select
      q.action_type,
      q.action_key

    into
      v_current_readiness_action_type,
      v_current_readiness_action_key

    from public.v_readiness_action_queue q

    where q.employee_id =
      new.employee_id

      and q.master_competency_template_id =
        new.master_competency_template_id

    order by
      q.priority asc,
      q.action_type asc

    limit 1;

  end if;


  -- --------------------------------------------------------------------------
  -- Event type.
  -- --------------------------------------------------------------------------

  if tg_op = 'INSERT' then

    v_event_type :=
      'plan_created';

  else

    v_event_type :=
      'lifecycle_transition';

  end if;


  -- --------------------------------------------------------------------------
  -- Write immutable history record.
  -- --------------------------------------------------------------------------

  insert into
  public.system_regression_test_events
  (
    employee_id,
    development_plan_id,

    event_type,

    plan_title,

    action_type,
    action_key,

    old_status,
    new_status,

    old_resolution_status,
    new_resolution_status,

    current_readiness_action_type,
    current_readiness_action_key,

    recorded_by_user_id,

    event_at
  )

  values
  (
    new.employee_id,
    new.id,

    v_event_type,

    new.title,

    new.action_type,
    new.action_key,

    case
      when tg_op = 'UPDATE'
      then old.status
      else null
    end,

    new.status,

    case
      when tg_op = 'UPDATE'
      then old.resolution_status
      else null
    end,

    new.resolution_status,

    v_current_readiness_action_type,
    v_current_readiness_action_key,

    auth.uid(),

    now()
  );


  return new;

end;

$$;


revoke all
on function
public.wri_record_development_plan_regression_event()
from public, anon, authenticated;


comment on function
public.wri_record_development_plan_regression_event()
is
'Automatically records Development Plan lifecycle changes for TEST employees for the IntegrateU regression testing workspace.';


-- ============================================================================
-- PART 4 — DEVELOPMENT PLAN TRIGGERS
-- ============================================================================

drop trigger if exists
wri_regression_plan_created
on public.development_plans;


create trigger
wri_regression_plan_created

after insert

on public.development_plans

for each row

execute function
public.wri_record_development_plan_regression_event();


drop trigger if exists
wri_regression_plan_lifecycle_transition
on public.development_plans;


create trigger
wri_regression_plan_lifecycle_transition

after update of
  resolution_status,
  action_type,
  action_key

on public.development_plans

for each row

execute function
public.wri_record_development_plan_regression_event();


-- ============================================================================
-- PART 5 — READ-ONLY ADMIN VIEW
-- ============================================================================

create or replace view
public.v_system_regression_test_history

with (security_invoker = true)

as

select

  evt.id,

  evt.event_at,

  evt.event_type,

  evt.employee_id,

  e.first_name,
  e.last_name,
  e.employee_number,

  evt.development_plan_id,

  evt.plan_title,

  evt.action_type,
  evt.action_key,

  evt.old_status,
  evt.new_status,

  evt.old_resolution_status,
  evt.new_resolution_status,

  evt.current_readiness_action_type,
  evt.current_readiness_action_key,

  evt.recorded_by_user_id

from public.system_regression_test_events evt

join public.employees e
  on e.id =
    evt.employee_id;


comment on view
public.v_system_regression_test_history
is
'IntegrateU Admin read-only history of automatically captured regression lifecycle events for TEST employees.';


-- ============================================================================
-- END 0042
-- ============================================================================
