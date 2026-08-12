-- ============================================================================
-- 0036_development_activity_evidence.sql
--
-- Adds optional evidence URL support to development activity completion.
-- Replaces the original 3-argument activity status RPC with a single
-- 4-argument version.
-- ============================================================================

drop function if exists
public.wri_update_development_activity_status(
  uuid,
  text,
  text
);


create function public.wri_update_development_activity_status(
  p_activity_id uuid,
  p_status text,
  p_completion_notes text default null,
  p_evidence_url text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_activity public.development_plan_activities%rowtype;
  v_plan public.development_plans%rowtype;
begin

  -- --------------------------------------------------------------------------
  -- Validate status
  -- --------------------------------------------------------------------------

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


  -- --------------------------------------------------------------------------
  -- Load activity
  -- --------------------------------------------------------------------------

  select *
  into v_activity
  from public.development_plan_activities
  where id = p_activity_id;

  if not found then
    raise exception
      'Development activity not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Load parent plan
  -- --------------------------------------------------------------------------

  select *
  into v_plan
  from public.development_plans
  where id = v_activity.development_plan_id;

  if not found then
    raise exception
      'Parent development plan not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (
    public.wri_is_integrateu_admin()
    or v_activity.client_id in (
      select public.wri_allowed_client_ids()
    )
  ) then
    raise exception
      'Not authorized to modify this development activity.';
  end if;


  -- --------------------------------------------------------------------------
  -- Protect terminal plans
  -- --------------------------------------------------------------------------

  if v_plan.status = 'cancelled'
     or v_plan.resolution_status in (
       'resolved',
       'cancelled'
     )
  then
    raise exception
      'Resolved or cancelled development plans are read-only.';
  end if;


  -- --------------------------------------------------------------------------
  -- Update activity
  -- --------------------------------------------------------------------------

  update public.development_plan_activities
  set
    status = p_status,

    completion_notes =
      case
        when p_completion_notes is not null
          then nullif(
            trim(p_completion_notes),
            ''
          )
        else completion_notes
      end,

    evidence_url =
      case
        when p_evidence_url is not null
          then nullif(
            trim(p_evidence_url),
            ''
          )
        else evidence_url
      end,

    completed_at =
      case
        when p_status = 'completed'
          then coalesce(
            completed_at,
            now()
          )
        else null
      end,

    updated_at = now()

  where id = p_activity_id;

end;
$$;


-- ============================================================================
-- PERMISSIONS
-- ============================================================================

revoke all
on function public.wri_update_development_activity_status(
  uuid,
  text,
  text,
  text
)
from public, anon;

grant execute
on function public.wri_update_development_activity_status(
  uuid,
  text,
  text,
  text
)
to authenticated;


comment on function public.wri_update_development_activity_status(
  uuid,
  text,
  text,
  text
)
is
  'Updates development activity status, completion notes, and optional supporting evidence URL.';
