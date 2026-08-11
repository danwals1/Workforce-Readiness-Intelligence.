-- ============================================================================
-- 0035_cancel_development_plans.sql
--
-- Adds an authorized lifecycle operation for cancelling Development Plans.
--
-- Cancellation:
--   - is allowed only for authorized users
--   - cannot be applied to an already resolved plan
--   - marks the plan status as cancelled
--   - delegates resolution cleanup to the existing resolution engine
--   - is intentionally terminal; reopening is not included here
-- ============================================================================

create or replace function public.wri_cancel_development_plan(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_plan public.development_plans%rowtype;
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
      'Not authorized to cancel this development plan.';
  end if;


  -- --------------------------------------------------------------------------
  -- Protect resolved plans
  -- --------------------------------------------------------------------------

  if v_plan.resolution_status = 'resolved' then
    raise exception
      'Resolved development plans cannot be cancelled.';
  end if;


  -- --------------------------------------------------------------------------
  -- Idempotent cancellation
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled'
     or v_plan.resolution_status = 'cancelled'
  then
    return;
  end if;


  -- --------------------------------------------------------------------------
  -- Cancel plan
  -- --------------------------------------------------------------------------

  update public.development_plans
  set
    status = 'cancelled',
    updated_at = now()
  where id = p_development_plan_id;


  -- --------------------------------------------------------------------------
  -- Let the existing resolution engine perform lifecycle cleanup.
  -- --------------------------------------------------------------------------

  perform public.wri_refresh_development_plan_resolution(
    p_development_plan_id
  );

end;
$$;


-- ============================================================================
-- PERMISSIONS
-- ============================================================================

revoke all
on function public.wri_cancel_development_plan(uuid)
from public, anon;

grant execute
on function public.wri_cancel_development_plan(uuid)
to authenticated;


comment on function public.wri_cancel_development_plan(uuid)
is
'Cancels an authorized active development plan and refreshes its resolution lifecycle.';
