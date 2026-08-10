create or replace function public.wri_refresh_development_plan_resolution(
  p_development_plan_id uuid
)
returns void
language plpgsql
security definer
set search_path to 'public'
as $function$
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
  where id = p_development_plan_id;

  if not found then
    return;
  end if;

  if v_plan.status = 'cancelled' then
    update development_plans
    set
      resolution_status = 'cancelled',
      resolved_at = null
    where id = p_development_plan_id;

    return;
  end if;

  if v_plan.action_key is null then
    v_action_exists := true;
  else
    select exists (
      select 1
      from v_readiness_action_queue q
      where q.action_key = v_plan.action_key
    )
    into v_action_exists;
  end if;

  -- Readiness requirement satisfied.
  if v_action_exists = false then
    update development_plans
    set
      status = 'completed',
      resolution_status = 'resolved',
      completed_at = coalesce(completed_at, now()),
      resolved_at = coalesce(resolved_at, now()),
      awaiting_evidence_since = null
    where id = p_development_plan_id;

    return;
  end if;

  select
    count(*) filter (
      where status <> 'cancelled'
    ),
    count(*) filter (
      where status not in ('completed', 'cancelled')
    )
  into
    v_activities_total,
    v_activities_remaining
  from development_plan_activities
  where development_plan_id = p_development_plan_id;

  -- Practical verification plans can move directly to verification
  -- without requiring a development activity.
  if v_plan.action_type = 'PRACTICAL_VERIFICATION_NEEDED'
     and v_activities_total = 0 then

    update development_plans
    set
      resolution_status = 'awaiting_verification',
      development_completed_at =
        coalesce(development_completed_at, now()),
      awaiting_evidence_since =
        coalesce(awaiting_evidence_since, now()),
      resolved_at = null
    where id = p_development_plan_id;

    return;
  end if;

  if v_activities_total = 0
     or v_activities_remaining > 0 then

    update development_plans
    set
      resolution_status = 'development_in_progress',
      development_completed_at = null,
      awaiting_evidence_since = null,
      resolved_at = null
    where id = p_development_plan_id;

    return;
  end if;

  v_expected_status :=
    wri_expected_resolution_status(
      v_plan.action_type
    );

  update development_plans
  set
    resolution_status = v_expected_status,
    development_completed_at =
      coalesce(development_completed_at, now()),
    awaiting_evidence_since =
      coalesce(awaiting_evidence_since, now()),
    resolved_at = null
  where id = p_development_plan_id;
end;
$function$;


-- Backfill already-resolved plans so plan status matches resolution state.
update development_plans
set
  status = 'completed',
  completed_at = coalesce(completed_at, resolved_at, now())
where resolution_status = 'resolved'
  and status <> 'completed';
