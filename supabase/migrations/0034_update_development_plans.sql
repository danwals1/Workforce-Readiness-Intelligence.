-- ============================================================================
-- 0034 — UPDATE DEVELOPMENT PLAN
-- ============================================================================
-- Allows authorized users to update active development-plan management fields.
--
-- Resolved and cancelled plans are intentionally locked.
-- Employee, client, readiness source, competency and resolution fields cannot
-- be changed through this RPC.
-- ============================================================================

create or replace function public.wri_update_development_plan(
  p_development_plan_id uuid,
  p_title text,
  p_description text default null,
  p_development_type text default 'training',
  p_priority text default 'medium',
  p_due_date date default null,
  p_owner_user_id uuid default null,
  p_manager_notes text default null
)
returns void

language plpgsql

security definer

set search_path = public

as $$

declare
  v_plan public.development_plans%rowtype;
  v_owner_allowed boolean := false;

begin

  -- --------------------------------------------------------------------------
  -- Load plan
  -- --------------------------------------------------------------------------

  select *
  into v_plan
  from public.development_plans
  where id = p_development_plan_id;

  if not found then
    raise exception
      'Development plan not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    public.wri_is_integrateu_admin()
    or v_plan.client_id in (
      select public.wri_allowed_client_ids()
    )
  ) then
    raise exception
      'Not authorized to modify this development plan.';
  end if;


  -- --------------------------------------------------------------------------
  -- Locked plans
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled'
     or v_plan.resolution_status in (
       'resolved',
       'cancelled'
     )
  then
    raise exception
      'Resolved or cancelled development plans cannot be edited.';
  end if;


  -- --------------------------------------------------------------------------
  -- Validation
  -- --------------------------------------------------------------------------

  if nullif(trim(p_title), '') is null then
    raise exception
      'Development plan title is required.';
  end if;

  if p_development_type not in (
    'training',
    'coaching',
    'field_practice',
    'practical_verification',
    'reassessment',
    'mentoring',
    'observation',
    'other'
  ) then
    raise exception
      'Invalid development plan type.';
  end if;

  if p_priority not in (
    'critical',
    'high',
    'medium',
    'low'
  ) then
    raise exception
      'Invalid development plan priority.';
  end if;

  if p_due_date is not null
     and v_plan.start_date is not null
     and p_due_date < v_plan.start_date
  then
    raise exception
      'Due date cannot be before the plan start date.';
  end if;


  -- --------------------------------------------------------------------------
  -- Validate owner
  -- --------------------------------------------------------------------------

  if p_owner_user_id is not null then

    select exists (
      select 1
      from public.wri_list_development_plan_owners(
        v_plan.employee_id
      ) owner
      where owner.user_id = p_owner_user_id
    )
    into v_owner_allowed;

    if not v_owner_allowed then
      raise exception
        'Selected plan owner is not eligible for this employee.';
    end if;

  end if;


  -- --------------------------------------------------------------------------
  -- Update management fields
  -- --------------------------------------------------------------------------

  update public.development_plans
  set
    title = trim(p_title),

    description =
      nullif(
        trim(coalesce(p_description, '')),
        ''
      ),

    development_type =
      p_development_type,

    priority =
      p_priority,

    due_date =
      p_due_date,

    owner_user_id =
      p_owner_user_id,

    manager_notes =
      nullif(
        trim(coalesce(p_manager_notes, '')),
        ''
      ),

    updated_at =
      now()

  where id =
    p_development_plan_id;

end;

$$;


-- ============================================================================
-- PERMISSIONS
-- ============================================================================

revoke all
on function public.wri_update_development_plan(
  uuid,
  text,
  text,
  text,
  text,
  date,
  uuid,
  text
)
from public, anon;

grant execute
on function public.wri_update_development_plan(
  uuid,
  text,
  text,
  text,
  text,
  date,
  uuid,
  text
)
to authenticated;


comment on function public.wri_update_development_plan(
  uuid,
  text,
  text,
  text,
  text,
  date,
  uuid,
  text
)
is
  'Updates authorized management fields on an active development plan while protecting readiness and resolution history.';
