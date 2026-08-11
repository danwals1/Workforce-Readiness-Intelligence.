-- ============================================================================
-- 0031_lock_resolved_development_plans.sql
--
-- Resolved development plans are historical records.
--
-- Once resolution_status = 'resolved':
--
--   - no new activities may be added
--   - existing activity statuses may not be changed
--
-- This applies at the database layer so the rule cannot be bypassed by UI.
-- ============================================================================


-- ============================================================================
-- PART 1 — LOCK ADD ACTIVITY
-- ============================================================================

create or replace function public.wri_add_development_activity(
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
  where id = p_development_plan_id;

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


  -- --------------------------------------------------------------------------
  -- Resolved plans are locked.
  -- --------------------------------------------------------------------------

  if v_plan.resolution_status = 'resolved' then
    raise exception
      'Resolved development plans cannot be modified.';
  end if;


  if v_plan.status = 'cancelled' then
    raise exception
      'Cancelled development plans cannot be modified.';
  end if;


  if nullif(trim(p_title), '') is null then
    raise exception
      'Activity title is required.';
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
    trim(p_title),
    nullif(trim(p_description), ''),
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
-- PART 2 — LOCK ACTIVITY STATUS CHANGES
-- ============================================================================

create or replace function public.wri_update_development_activity_status(
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
  v_activity development_plan_activities%rowtype;
  v_plan development_plans%rowtype;
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
  where id = p_activity_id;

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


  select *
  into v_plan
  from development_plans
  where id = v_activity.development_plan_id;

  if not found then
    raise exception
      'Development plan not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Resolved plans are historical/read-only.
  -- --------------------------------------------------------------------------

  if v_plan.resolution_status = 'resolved' then
    raise exception
      'Resolved development plans cannot be modified.';
  end if;


  if v_plan.status = 'cancelled' then
    raise exception
      'Cancelled development plans cannot be modified.';
  end if;


  update development_plan_activities
  set
    status = p_status,

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

  where id = p_activity_id;

end;
$$;


-- ============================================================================
-- PART 3 — PERMISSIONS
-- ============================================================================

revoke all
on function public.wri_add_development_activity(
  uuid,
  text,
  text,
  text,
  date
)
from public, anon;

grant execute
on function public.wri_add_development_activity(
  uuid,
  text,
  text,
  text,
  date
)
to authenticated;


revoke all
on function public.wri_update_development_activity_status(
  uuid,
  text,
  text
)
from public, anon;

grant execute
on function public.wri_update_development_activity_status(
  uuid,
  text,
  text
)
to authenticated;


-- ============================================================================
-- PART 4 — INSTALLATION CHECK
-- ============================================================================

select routine_name
from information_schema.routines
where routine_schema = 'public'
and routine_name in (
  'wri_add_development_activity',
  'wri_update_development_activity_status'
)
order by routine_name;
