-- ============================================================================
-- 0032_development_plan_owners.sql
--
-- Permission-aware Development Plan owner candidates.
--
-- Eligible owners:
--   - active CLIENT_ADMIN users for the selected employee's client
--   - active INTEGRATEU_ADMIN users
--   - owner must have an employee record with auth_user_id
--
-- Caller must be:
--   - active INTEGRATEU_ADMIN
--   - or active CLIENT_ADMIN for the selected employee's client
-- ============================================================================

create or replace function public.wri_list_development_plan_owners(
  p_employee_id uuid
)
returns table (
  user_id uuid,
  employee_id uuid,
  first_name text,
  last_name text,
  employee_number text,
  role text,
  client_id uuid
)
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_client_id uuid;
begin

  -- --------------------------------------------------------------------------
  -- Locate target employee / client
  -- --------------------------------------------------------------------------

  select e.client_id
  into v_client_id
  from employees e
  where e.id = p_employee_id;

  if v_client_id is null then
    raise exception
      'Employee not found.';
  end if;


  -- --------------------------------------------------------------------------
  -- Caller authorization
  -- --------------------------------------------------------------------------

  if not exists (
    select 1
    from user_client_roles caller_role
    where caller_role.user_id = auth.uid()
      and caller_role.status = 'active'
      and (
        caller_role.role = 'INTEGRATEU_ADMIN'

        or (
          caller_role.role = 'CLIENT_ADMIN'
          and caller_role.client_id = v_client_id
        )
      )
  ) then
    raise exception
      'Not authorized to manage development plans for this employee.';
  end if;


  -- --------------------------------------------------------------------------
  -- Eligible owners
  -- --------------------------------------------------------------------------

  return query

  select distinct
    ucr.user_id,
    e.id as employee_id,
    e.first_name,
    e.last_name,
    e.employee_number,
    ucr.role,
    ucr.client_id

  from user_client_roles ucr

  join employees e
    on e.auth_user_id = ucr.user_id

  where
    ucr.status = 'active'

    and e.auth_user_id is not null

    and (
      (
        ucr.role = 'CLIENT_ADMIN'
        and ucr.client_id = v_client_id
        and e.client_id = v_client_id
      )

      or ucr.role = 'INTEGRATEU_ADMIN'
    )

  order by
    case
      when ucr.role = 'CLIENT_ADMIN' then 1
      when ucr.role = 'INTEGRATEU_ADMIN' then 2
      else 3
    end,
    e.last_name,
    e.first_name;

end;
$$;


revoke all
on function public.wri_list_development_plan_owners(uuid)
from public, anon;

grant execute
on function public.wri_list_development_plan_owners(uuid)
to authenticated;


select routine_name
from information_schema.routines
where routine_schema = 'public'
and routine_name =
  'wri_list_development_plan_owners';
