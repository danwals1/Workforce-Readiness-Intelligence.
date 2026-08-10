-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0020_development_plans.sql
--
-- PURPOSE
--
-- Convert readiness gaps into trackable employee development plans.
--
-- FLOW
--
-- Readiness Action
--      ↓
-- Development Plan
--      ↓
-- Development Activities
--      ↓
-- Completion / Coaching / Training / Field Practice
--      ↓
-- Reassessment or Practical Verification
--      ↓
-- Readiness engine recalculates automatically
--
-- THIS MIGRATION IS ADDITIVE.
--
-- It does NOT modify:
--
--   v_assessment_competency_readiness_current
--   v_assessment_role_readiness_current
--   v_readiness_action_queue
--   wri_list_readiness_actions
--
-- ============================================================================


-- ============================================================================
-- PART 1 — DEVELOPMENT PLANS
-- ============================================================================

create table if not exists development_plans (

  id uuid
    primary key
    default gen_random_uuid(),

  client_id uuid
    not null
    references clients(id)
    on delete cascade,

  employee_id uuid
    not null
    references employees(id)
    on delete cascade,

  -- --------------------------------------------------------------------------
  -- Readiness source
  --
  -- action_key corresponds to v_readiness_action_queue.action_key.
  --
  -- We intentionally do NOT use a foreign key because the action queue is a
  -- calculated view. Once the readiness gap is resolved, the queue action may
  -- disappear while the development-plan history must remain.
  -- --------------------------------------------------------------------------

  action_key text,

  action_type text,

  action_label text,

  -- --------------------------------------------------------------------------
  -- Optional competency relationship.
  --
  -- Safety-gap actions may be role-level rather than competency-level.
  -- --------------------------------------------------------------------------

  master_competency_template_id uuid
    references master_competency_templates(id)
    on delete set null,

  competency_name_snapshot text,

  role_name_snapshot text,

  -- --------------------------------------------------------------------------
  -- Plan
  -- --------------------------------------------------------------------------

  title text
    not null,

  description text,

  development_type text
    not null
    default 'training',

  status text
    not null
    default 'not_started',

  priority text
    not null
    default 'medium',

  start_date date
    default current_date,

  due_date date,

  completed_at timestamptz,

  -- --------------------------------------------------------------------------
  -- Ownership
  -- --------------------------------------------------------------------------

  created_by_user_id uuid
    not null
    default auth.uid(),

  owner_user_id uuid,

  -- --------------------------------------------------------------------------
  -- Notes
  -- --------------------------------------------------------------------------

  manager_notes text,

  employee_notes text,

  -- --------------------------------------------------------------------------
  -- Audit
  -- --------------------------------------------------------------------------

  created_at timestamptz
    not null
    default now(),

  updated_at timestamptz
    not null
    default now(),

  -- --------------------------------------------------------------------------
  -- Validation
  -- --------------------------------------------------------------------------

  constraint development_plans_type_check
    check (
      development_type in (
        'training',
        'coaching',
        'field_practice',
        'practical_verification',
        'reassessment',
        'mentoring',
        'observation',
        'other'
      )
    ),

  constraint development_plans_status_check
    check (
      status in (
        'not_started',
        'in_progress',
        'blocked',
        'completed',
        'cancelled'
      )
    ),

  constraint development_plans_priority_check
    check (
      priority in (
        'critical',
        'high',
        'medium',
        'low'
      )
    ),

  constraint development_plans_due_date_check
    check (
      due_date is null
      or start_date is null
      or due_date >= start_date
    )

);



-- ============================================================================
-- PART 2 — DEVELOPMENT ACTIVITIES
--
-- A development plan may contain multiple activities.
--
-- Example:
--
-- Plan:
--   Networking Practical Verification
--
-- Activities:
--   1. Review network configuration training
--   2. Complete supervised network installation
--   3. Demonstrate troubleshooting
--   4. Complete practical verification
-- ============================================================================

create table if not exists development_plan_activities (

  id uuid
    primary key
    default gen_random_uuid(),

  development_plan_id uuid
    not null
    references development_plans(id)
    on delete cascade,

  client_id uuid
    not null
    references clients(id)
    on delete cascade,

  employee_id uuid
    not null
    references employees(id)
    on delete cascade,

  title text
    not null,

  description text,

  activity_type text
    not null
    default 'training',

  status text
    not null
    default 'not_started',

  sequence_number integer
    not null
    default 1,

  due_date date,

  completed_at timestamptz,

  completion_notes text,

  evidence_url text,

  created_by_user_id uuid
    not null
    default auth.uid(),

  created_at timestamptz
    not null
    default now(),

  updated_at timestamptz
    not null
    default now(),

  constraint development_plan_activities_type_check
    check (
      activity_type in (
        'training',
        'coaching',
        'field_practice',
        'practical_verification',
        'reassessment',
        'mentoring',
        'observation',
        'documentation',
        'other'
      )
    ),

  constraint development_plan_activities_status_check
    check (
      status in (
        'not_started',
        'in_progress',
        'blocked',
        'completed',
        'cancelled'
      )
    ),

  constraint development_plan_activities_sequence_check
    check (
      sequence_number > 0
    )

);



-- ============================================================================
-- PART 3 — INDEXES
-- ============================================================================

create index if not exists
  development_plans_employee_idx
on development_plans(
  employee_id
);


create index if not exists
  development_plans_client_idx
on development_plans(
  client_id
);


create index if not exists
  development_plans_status_idx
on development_plans(
  status
);


create index if not exists
  development_plans_due_date_idx
on development_plans(
  due_date
);


create index if not exists
  development_plans_action_key_idx
on development_plans(
  action_key
);


create index if not exists
  development_plans_competency_idx
on development_plans(
  master_competency_template_id
);


create index if not exists
  development_plan_activities_plan_idx
on development_plan_activities(
  development_plan_id
);


create index if not exists
  development_plan_activities_employee_idx
on development_plan_activities(
  employee_id
);


create index if not exists
  development_plan_activities_status_idx
on development_plan_activities(
  status
);



-- ============================================================================
-- PART 4 — UPDATED_AT TRIGGERS
--
-- Uses existing wri_set_updated_at().
-- ============================================================================

drop trigger if exists
  development_plans_set_updated_at
on development_plans;


create trigger
  development_plans_set_updated_at

before update
on development_plans

for each row

execute function
  wri_set_updated_at();



drop trigger if exists
  development_plan_activities_set_updated_at
on development_plan_activities;


create trigger
  development_plan_activities_set_updated_at

before update
on development_plan_activities

for each row

execute function
  wri_set_updated_at();



-- ============================================================================
-- PART 5 — CLIENT PROTECTION
--
-- Forces development_plans.client_id to always match employee.client_id.
-- ============================================================================

create or replace function
wri_sync_development_plan_client()
returns trigger
language plpgsql
security definer
set search_path = public
as $$

declare

  v_client_id uuid;

begin

  select e.client_id
  into v_client_id

  from employees e

  where e.id = new.employee_id;


  if v_client_id is null then

    raise exception
      'Employee does not exist or has no client.';

  end if;


  new.client_id :=
    v_client_id;


  return new;

end;

$$;



drop trigger if exists
  development_plans_sync_client
on development_plans;


create trigger
  development_plans_sync_client

before insert or update
on development_plans

for each row

execute function
  wri_sync_development_plan_client();



-- ============================================================================
-- PART 6 — ACTIVITY CLIENT / EMPLOYEE PROTECTION
--
-- Activities inherit employee/client from their parent plan.
-- ============================================================================

create or replace function
wri_sync_development_activity_scope()
returns trigger
language plpgsql
security definer
set search_path = public
as $$

declare

  v_client_id uuid;

  v_employee_id uuid;

begin

  select
    dp.client_id,
    dp.employee_id

  into
    v_client_id,
    v_employee_id

  from development_plans dp

  where dp.id =
    new.development_plan_id;


  if v_client_id is null
     or v_employee_id is null then

    raise exception
      'Development plan does not exist.';

  end if;


  new.client_id :=
    v_client_id;

  new.employee_id :=
    v_employee_id;


  return new;

end;

$$;



drop trigger if exists
  development_plan_activities_sync_scope
on development_plan_activities;


create trigger
  development_plan_activities_sync_scope

before insert or update
on development_plan_activities

for each row

execute function
  wri_sync_development_activity_scope();



-- ============================================================================
-- PART 7 — AUTOMATIC PLAN COMPLETION
--
-- When every active activity is completed, automatically complete the parent
-- development plan.
--
-- Cancelled activities do not block completion.
-- ============================================================================

create or replace function
wri_refresh_development_plan_status(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$

declare

  v_activity_count integer;

  v_incomplete_count integer;

begin

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
    v_activity_count,
    v_incomplete_count

  from development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  if v_activity_count > 0
     and v_incomplete_count = 0 then

    update development_plans

    set
      status = 'completed',
      completed_at =
        coalesce(
          completed_at,
          now()
        )

    where id =
      p_development_plan_id

      and status <>
        'cancelled';

  elsif v_incomplete_count > 0 then

    update development_plans

    set
      status =
        case
          when status =
               'not_started'
            then 'in_progress'
          when status =
               'completed'
            then 'in_progress'
          else status
        end,

      completed_at = null

    where id =
      p_development_plan_id

      and status <>
        'cancelled';

  end if;

end;

$$;



create or replace function
wri_activity_refresh_parent_plan()
returns trigger
language plpgsql
security definer
set search_path = public
as $$

begin

  perform
    wri_refresh_development_plan_status(
      coalesce(
        new.development_plan_id,
        old.development_plan_id
      )
    );


  return coalesce(
    new,
    old
  );

end;

$$;



drop trigger if exists
  development_activity_refresh_plan
on development_plan_activities;


create trigger
  development_activity_refresh_plan

after insert
or update
or delete

on development_plan_activities

for each row

execute function
  wri_activity_refresh_parent_plan();



-- ============================================================================
-- PART 8 — ROW LEVEL SECURITY
-- ============================================================================

alter table development_plans
enable row level security;


alter table development_plan_activities
enable row level security;



-- ============================================================================
-- DEVELOPMENT PLAN READ POLICY
--
-- IntegrateU Admin
-- Client Admin
-- Employee viewing own plan
-- Practical verifier assigned to employee
-- ============================================================================

drop policy if exists
  development_plans_select_policy
on development_plans;


create policy
  development_plans_select_policy

on development_plans

for select

to authenticated

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

  or exists (

    select 1

    from employees e

    where e.id =
      development_plans.employee_id

      and e.auth_user_id =
        auth.uid()

  )

  or wri_can_verify_master_practical(
    development_plans.employee_id
  )

);



-- ============================================================================
-- DEVELOPMENT PLAN MANAGEMENT POLICY
--
-- Only IntegrateU Admin or Client Admin may directly manage plans.
--
-- Writes from the UI will primarily use RPCs below.
-- ============================================================================

drop policy if exists
  development_plans_manage_policy
on development_plans;


create policy
  development_plans_manage_policy

on development_plans

for all

to authenticated

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

)

with check (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

);



-- ============================================================================
-- ACTIVITY READ POLICY
-- ============================================================================

drop policy if exists
  development_plan_activities_select_policy
on development_plan_activities;


create policy
  development_plan_activities_select_policy

on development_plan_activities

for select

to authenticated

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

  or exists (

    select 1

    from employees e

    where e.id =
      development_plan_activities.employee_id

      and e.auth_user_id =
        auth.uid()

  )

  or wri_can_verify_master_practical(
    development_plan_activities.employee_id
  )

);



-- ============================================================================
-- ACTIVITY MANAGEMENT POLICY
-- ============================================================================

drop policy if exists
  development_plan_activities_manage_policy
on development_plan_activities;


create policy
  development_plan_activities_manage_policy

on development_plan_activities

for all

to authenticated

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

)

with check (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

);



-- ============================================================================
-- PART 9 — CREATE DEVELOPMENT PLAN FROM READINESS ACTION
--
-- This is the primary Action Center → Development Plan workflow.
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

    return v_plan_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Convert queue priority into plan priority
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
  -- Create plan
  -- --------------------------------------------------------------------------

  insert into development_plans (

    client_id,
    employee_id,

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


  return v_plan_id;

end;

$$;



-- ============================================================================
-- PART 10 — ADD ACTIVITY RPC
-- ============================================================================

create or replace function
wri_add_development_activity(

  p_development_plan_id uuid,

  p_title text,

  p_description text default null,

  p_activity_type text default 'training',

  p_due_date date default null

)
returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_plan development_plans%rowtype;

  v_activity_id uuid;

  v_sequence integer;

begin

  select *

  into v_plan

  from development_plans

  where id =
    p_development_plan_id;


  if not found then

    raise exception
      'Development plan not found.';

  end if;


  if not (

    wri_is_integrateu_admin()

    or v_plan.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'Not authorized to modify this development plan.';

  end if;


  select
    coalesce(
      max(sequence_number),
      0
    ) + 1

  into v_sequence

  from development_plan_activities

  where development_plan_id =
    p_development_plan_id;


  insert into development_plan_activities (

    development_plan_id,

    client_id,

    employee_id,

    title,

    description,

    activity_type,

    status,

    sequence_number,

    due_date,

    created_by_user_id

  )

  values (

    v_plan.id,

    v_plan.client_id,

    v_plan.employee_id,

    p_title,

    p_description,

    p_activity_type,

    'not_started',

    v_sequence,

    p_due_date,

    auth.uid()

  )

  returning id
  into v_activity_id;


  return v_activity_id;

end;

$$;



-- ============================================================================
-- PART 11 — UPDATE ACTIVITY STATUS RPC
-- ============================================================================

create or replace function
wri_update_development_activity_status(

  p_activity_id uuid,

  p_status text,

  p_completion_notes text default null

)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare

  v_activity
    development_plan_activities%rowtype;

begin

  if p_status not in (
    'not_started',
    'in_progress',
    'blocked',
    'completed',
    'cancelled'
  ) then

    raise exception
      'Invalid development activity status.';

  end if;


  select *

  into v_activity

  from development_plan_activities

  where id =
    p_activity_id;


  if not found then

    raise exception
      'Development activity not found.';

  end if;


  if not (

    wri_is_integrateu_admin()

    or v_activity.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'Not authorized to modify this development activity.';

  end if;


  update development_plan_activities

  set

    status =
      p_status,

    completion_notes =
      case
        when p_completion_notes is not null
          then p_completion_notes
        else completion_notes
      end,

    completed_at =
      case
        when p_status = 'completed'
          then coalesce(
            completed_at,
            now()
          )

        else null
      end

  where id =
    p_activity_id;

end;

$$;



-- ============================================================================
-- PART 12 — DEVELOPMENT PLAN DETAIL VIEW
-- ============================================================================

create or replace view
v_development_plan_summary
as

select

  dp.id
    as development_plan_id,

  dp.client_id,

  dp.employee_id,

  e.first_name,

  e.last_name,

  e.employee_number,

  dp.action_key,

  dp.action_type,

  dp.action_label,

  dp.master_competency_template_id,

  dp.competency_name_snapshot,

  dp.role_name_snapshot,

  dp.title,

  dp.description,

  dp.development_type,

  dp.status,

  dp.priority,

  dp.start_date,

  dp.due_date,

  dp.completed_at,

  dp.owner_user_id,

  dp.manager_notes,

  dp.employee_notes,

  dp.created_by_user_id,

  dp.created_at,

  dp.updated_at,

  count(
    dpa.id
  )
    as activities_total,

  count(
    dpa.id
  ) filter (
    where dpa.status =
      'completed'
  )
    as activities_completed,

  count(
    dpa.id
  ) filter (
    where dpa.status =
      'blocked'
  )
    as activities_blocked,

  case

    when count(
      dpa.id
    ) = 0
      then 0::numeric

    else round(

      100.0
      *
      count(
        dpa.id
      ) filter (
        where dpa.status =
          'completed'
      )::numeric

      /

      count(
        dpa.id
      )::numeric,

      1

    )

  end
    as completion_percent,

  case

    when dp.status =
      'completed'
      then false

    when dp.status =
      'cancelled'
      then false

    when dp.due_date is null
      then false

    when dp.due_date <
      current_date
      then true

    else false

  end
    as overdue

from development_plans dp

join employees e
  on e.id =
    dp.employee_id

left join development_plan_activities dpa
  on dpa.development_plan_id =
    dp.id

group by

  dp.id,

  dp.client_id,

  dp.employee_id,

  e.first_name,

  e.last_name,

  e.employee_number,

  dp.action_key,

  dp.action_type,

  dp.action_label,

  dp.master_competency_template_id,

  dp.competency_name_snapshot,

  dp.role_name_snapshot,

  dp.title,

  dp.description,

  dp.development_type,

  dp.status,

  dp.priority,

  dp.start_date,

  dp.due_date,

  dp.completed_at,

  dp.owner_user_id,

  dp.manager_notes,

  dp.employee_notes,

  dp.created_by_user_id,

  dp.created_at,

  dp.updated_at;



-- ============================================================================
-- PART 13 — PERMISSION-AWARE DEVELOPMENT PLAN LIST
-- ============================================================================

create or replace function
wri_list_development_plans(

  p_employee_id uuid default null,

  p_status text default null

)
returns setof v_development_plan_summary

language sql

stable

security definer

set search_path = public

as $$

  select s.*

  from v_development_plan_summary s

  where

    (
      wri_is_integrateu_admin()

      or s.client_id in (
        select wri_allowed_client_ids()
      )

      or exists (

        select 1

        from employees e

        where e.id =
          s.employee_id

          and e.auth_user_id =
            auth.uid()

      )

      or wri_can_verify_master_practical(
        s.employee_id
      )
    )

    and (
      p_employee_id is null

      or s.employee_id =
        p_employee_id
    )

    and (
      p_status is null

      or s.status =
        p_status
    )

  order by

    case s.priority

      when 'critical'
        then 1

      when 'high'
        then 2

      when 'medium'
        then 3

      when 'low'
        then 4

      else 5

    end,

    case
      when s.overdue
        then 0
      else 1
    end,

    s.due_date asc
      nulls last,

    s.created_at desc;

$$;



-- ============================================================================
-- PART 14 — GRANTS
-- ============================================================================

revoke all
on function
wri_create_development_plan_from_action(
  text,
  text,
  text,
  text,
  text,
  date
)
from public, anon;


grant execute
on function
wri_create_development_plan_from_action(
  text,
  text,
  text,
  text,
  text,
  date
)
to authenticated;



revoke all
on function
wri_add_development_activity(
  uuid,
  text,
  text,
  text,
  date
)
from public, anon;


grant execute
on function
wri_add_development_activity(
  uuid,
  text,
  text,
  text,
  date
)
to authenticated;



revoke all
on function
wri_update_development_activity_status(
  uuid,
  text,
  text
)
from public, anon;


grant execute
on function
wri_update_development_activity_status(
  uuid,
  text,
  text
)
to authenticated;



revoke all
on function
wri_list_development_plans(
  uuid,
  text
)
from public, anon;


grant execute
on function
wri_list_development_plans(
  uuid,
  text
)
to authenticated;



-- ============================================================================
-- PART 15 — BASIC INSTALLATION TESTS
-- ============================================================================

select table_name
from information_schema.tables
where table_schema = 'public'
  and table_name in (
    'development_plans',
    'development_plan_activities'
  )
order by table_name;



select table_name
from information_schema.views
where table_schema = 'public'
  and table_name =
    'v_development_plan_summary';



select routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name in (
    'wri_create_development_plan_from_action',
    'wri_add_development_activity',
    'wri_update_development_activity_status',
    'wri_list_development_plans'
  )
order by routine_name;