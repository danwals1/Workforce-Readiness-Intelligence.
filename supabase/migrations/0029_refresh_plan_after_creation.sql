create or replace function public.wri_create_development_plan_from_action(
  p_action_key text,
  p_title text default null::text,
  p_description text default null::text,
  p_development_type text default 'training'::text,
  p_priority text default null::text,
  p_due_date date default null::date
)
returns uuid
language plpgsql
security definer
set search_path to 'public'
as $function$

declare
  v_action v_readiness_action_queue%rowtype;
  v_plan_id uuid;
  v_priority text;

begin

  -- --------------------------------------------------
  -- Locate readiness action
  -- --------------------------------------------------

  select *
  into v_action
  from v_readiness_action_queue
  where action_key = p_action_key;

  if not found then
    raise exception
      'Readiness action not found.';
  end if;


  -- --------------------------------------------------
  -- Authorization
  -- --------------------------------------------------

  if not (
    wri_is_integrateu_admin()

    or v_action.client_id in (
      select wri_allowed_client_ids()
    )
  ) then
    raise exception
      'Not authorized to create a development plan for this employee.';
  end if;


  -- --------------------------------------------------
  -- Prevent duplicate active plan from same action
  -- --------------------------------------------------

  select id
  into v_plan_id
  from development_plans
  where action_key = p_action_key
    and status not in (
      'completed',
      'cancelled'
    )
  order by created_at desc
  limit 1;

  if v_plan_id is not null then

    -- Keep an existing active plan synchronized with
    -- the current readiness requirement.
    perform wri_refresh_development_plan_resolution(
      v_plan_id
    );

    return v_plan_id;
  end if;


  -- --------------------------------------------------
  -- Convert queue priority into Development Plan priority
  -- --------------------------------------------------

  v_priority :=
    coalesce(
      p_priority,

      case
        when v_action.priority = 1 then 'critical'
        when v_action.priority = 2 then 'high'
        when v_action.priority = 3 then 'medium'
        else 'medium'
      end
    );


  -- --------------------------------------------------
  -- Create Development Plan
  --
  -- attempt_id permanently records the assessment
  -- attempt that generated the readiness action.
  -- --------------------------------------------------

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


  -- --------------------------------------------------
  -- Immediately establish correct resolution state.
  --
  -- Example:
  -- PRACTICAL_VERIFICATION_NEEDED + 0 activities
  -- -> awaiting_verification
  -- --------------------------------------------------

  perform wri_refresh_development_plan_resolution(
    v_plan_id
  );

  return v_plan_id;

end;

$function$;


-- --------------------------------------------------
-- Backfill existing active practical-verification plans
-- so plans created before this migration are corrected.
-- --------------------------------------------------

do $$
declare
  v_plan record;
begin
  for v_plan in
    select id
    from development_plans
    where action_type = 'PRACTICAL_VERIFICATION_NEEDED'
      and status not in (
        'completed',
        'cancelled'
      )
  loop
    perform wri_refresh_development_plan_resolution(
      v_plan.id
    );
  end loop;
end;
$$;
