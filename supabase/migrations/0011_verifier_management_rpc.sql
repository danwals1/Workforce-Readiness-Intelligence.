-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0011_verifier_management_rpc.sql
--
-- PURPOSE
-- Secure RPC layer for managing practical verifiers.
--
-- ADDS
--   1. List verifier candidates without exposing auth.users directly
--   2. List current verifier assignments
--   3. Assign client-wide or employee-specific verifier access
--   4. Deactivate verifier access
--
-- AUTHORIZATION
--   INTEGRATEU_ADMIN
--   CLIENT_ADMIN for the applicable client
--
-- Dedicated verifiers may USE their assigned verification permissions,
-- but they may not grant/revoke verifier permissions.
-- ============================================================================


-- ============================================================================
-- PART 1 — LIST VERIFIER CANDIDATES
--
-- Returns authenticated users that are linked to employee records.
--
-- IntegrateU Admin:
--   may see all linked employees, or filter by p_client_id.
--
-- Client Admin:
--   may see only employees belonging to their allowed client(s).
-- ============================================================================

create or replace function wri_list_verifier_candidates(

  p_client_id uuid default null

)

returns table (

  auth_user_id uuid,

  email text,

  employee_id uuid,

  first_name text,

  last_name text,

  employee_number text,

  client_id uuid

)

language plpgsql

stable

security definer

set search_path = public

as $$

begin


  -- --------------------------------------------------------------------------
  -- Optional client filter authorization
  -- --------------------------------------------------------------------------

  if p_client_id is not null then

    if not (

      wri_is_integrateu_admin()

      or p_client_id in (
        select wri_allowed_client_ids()
      )

    ) then

      raise exception
        'not authorized to list verifier candidates for client %',
        p_client_id;

    end if;

  end if;



  -- --------------------------------------------------------------------------
  -- IntegrateU Admin
  -- --------------------------------------------------------------------------

  if wri_is_integrateu_admin() then

    return query

    select

      u.id as auth_user_id,

      u.email::text,

      e.id as employee_id,

      e.first_name,

      e.last_name,

      e.employee_number,

      e.client_id

    from employees e

    join auth.users u
      on u.id = e.auth_user_id

    where e.auth_user_id is not null

      and (
        p_client_id is null
        or e.client_id = p_client_id
      )

    order by

      e.last_name,

      e.first_name,

      u.email;

    return;

  end if;



  -- --------------------------------------------------------------------------
  -- Client Admin
  -- --------------------------------------------------------------------------

  return query

  select

    u.id as auth_user_id,

    u.email::text,

    e.id as employee_id,

    e.first_name,

    e.last_name,

    e.employee_number,

    e.client_id

  from employees e

  join auth.users u
    on u.id = e.auth_user_id

  where e.auth_user_id is not null

    and e.client_id in (
      select wri_allowed_client_ids()
    )

    and (
      p_client_id is null
      or e.client_id = p_client_id
    )

  order by

    e.last_name,

    e.first_name,

    u.email;


end;
$$;


revoke all
on function wri_list_verifier_candidates(uuid)
from public, anon;


grant execute
on function wri_list_verifier_candidates(uuid)
to authenticated;



-- ============================================================================
-- PART 2 — LIST VERIFIER ASSIGNMENTS
-- ============================================================================

create or replace function wri_list_practical_verifiers(

  p_client_id uuid default null

)

returns table (

  assignment_id uuid,

  client_id uuid,

  verifier_user_id uuid,

  verifier_email text,

  verifier_employee_id uuid,

  verifier_first_name text,

  verifier_last_name text,

  verifier_title text,

  scope text,

  employee_id uuid,

  employee_first_name text,

  employee_last_name text,

  is_active boolean,

  assigned_at timestamptz,

  expires_at timestamptz,

  notes text

)

language plpgsql

stable

security definer

set search_path = public

as $$

begin


  -- --------------------------------------------------------------------------
  -- Authorization for requested client
  -- --------------------------------------------------------------------------

  if p_client_id is not null then

    if not (

      wri_is_integrateu_admin()

      or p_client_id in (
        select wri_allowed_client_ids()
      )

    ) then

      raise exception
        'not authorized to list verifier assignments for client %',
        p_client_id;

    end if;

  end if;



  return query

  select

    pva.id as assignment_id,

    pva.client_id,

    pva.verifier_user_id,

    au.email::text as verifier_email,

    verifier_employee.id
      as verifier_employee_id,

    verifier_employee.first_name
      as verifier_first_name,

    verifier_employee.last_name
      as verifier_last_name,

    pva.verifier_title,

    pva.scope,

    pva.employee_id,

    target_employee.first_name
      as employee_first_name,

    target_employee.last_name
      as employee_last_name,

    pva.is_active,

    pva.assigned_at,

    pva.expires_at,

    pva.notes


  from practical_verifier_assignments pva


  left join auth.users au
    on au.id = pva.verifier_user_id


  left join employees verifier_employee
    on verifier_employee.auth_user_id =
       pva.verifier_user_id


  left join employees target_employee
    on target_employee.id =
       pva.employee_id


  where

    (

      wri_is_integrateu_admin()

      or pva.client_id in (
        select wri_allowed_client_ids()
      )

    )

    and (

      p_client_id is null

      or pva.client_id =
         p_client_id

    )


  order by

    pva.is_active desc,

    pva.assigned_at desc;


end;
$$;


revoke all
on function wri_list_practical_verifiers(uuid)
from public, anon;


grant execute
on function wri_list_practical_verifiers(uuid)
to authenticated;



-- ============================================================================
-- PART 3 — ASSIGN PRACTICAL VERIFIER
-- ============================================================================

create or replace function wri_assign_practical_verifier(

  p_client_id uuid,

  p_verifier_user_id uuid,

  p_scope text default 'client',

  p_employee_id uuid default null,

  p_verifier_title text default null,

  p_expires_at timestamptz default null,

  p_notes text default null

)

returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_assignment_id uuid;

  v_employee_client_id uuid;

begin


  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (

    wri_is_integrateu_admin()

    or p_client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to assign verifier for client %',
      p_client_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Validate verifier user exists
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from auth.users

    where id =
      p_verifier_user_id

  ) then

    raise exception
      'verifier auth user % not found',
      p_verifier_user_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Validate scope
  -- --------------------------------------------------------------------------

  if p_scope not in (
    'client',
    'employee'
  ) then

    raise exception
      'invalid verifier scope: %',
      p_scope;

  end if;



  -- --------------------------------------------------------------------------
  -- Employee-specific validation
  -- --------------------------------------------------------------------------

  if p_scope = 'employee' then

    if p_employee_id is null then

      raise exception
        'employee_id is required for employee-scoped verifier assignments';

    end if;


    select client_id
    into v_employee_client_id

    from employees

    where id =
      p_employee_id;


    if v_employee_client_id is null then

      raise exception
        'employee % not found',
        p_employee_id;

    end if;


    if v_employee_client_id <>
       p_client_id then

      raise exception
        'employee % does not belong to client %',
        p_employee_id,
        p_client_id;

    end if;

  end if;



  -- --------------------------------------------------------------------------
  -- Expiration validation
  -- --------------------------------------------------------------------------

  if p_expires_at is not null

    and p_expires_at <= now() then

    raise exception
      'expiration must be in the future';

  end if;



  -- --------------------------------------------------------------------------
  -- If an equivalent active assignment already exists, update it instead
  -- of creating a duplicate.
  -- --------------------------------------------------------------------------

  select id
  into v_assignment_id

  from practical_verifier_assignments

  where verifier_user_id =
        p_verifier_user_id

    and client_id =
        p_client_id

    and is_active = true

    and scope =
        p_scope

    and (

      (
        p_scope = 'client'
        and employee_id is null
      )

      or

      (
        p_scope = 'employee'
        and employee_id =
            p_employee_id
      )

    )

  limit 1;



  if v_assignment_id is not null then

    update practical_verifier_assignments

    set

      verifier_title =
        nullif(
          trim(p_verifier_title),
          ''
        ),

      expires_at =
        p_expires_at,

      notes =
        nullif(
          trim(p_notes),
          ''
        ),

      updated_at =
        now()

    where id =
      v_assignment_id;


    return v_assignment_id;

  end if;



  -- --------------------------------------------------------------------------
  -- New assignment
  -- --------------------------------------------------------------------------

  insert into practical_verifier_assignments (

    client_id,

    verifier_user_id,

    scope,

    employee_id,

    verifier_title,

    is_active,

    assigned_by,

    assigned_at,

    expires_at,

    notes

  )

  values (

    p_client_id,

    p_verifier_user_id,

    p_scope,

    case
      when p_scope = 'employee'
      then p_employee_id
      else null
    end,

    nullif(
      trim(p_verifier_title),
      ''
    ),

    true,

    auth.uid(),

    now(),

    p_expires_at,

    nullif(
      trim(p_notes),
      ''
    )

  )

  returning id
  into v_assignment_id;



  return v_assignment_id;


end;
$$;


revoke all
on function wri_assign_practical_verifier(
  uuid,
  uuid,
  text,
  uuid,
  text,
  timestamptz,
  text
)
from public, anon;


grant execute
on function wri_assign_practical_verifier(
  uuid,
  uuid,
  text,
  uuid,
  text,
  timestamptz,
  text
)
to authenticated;



-- ============================================================================
-- PART 4 — DEACTIVATE VERIFIER ASSIGNMENT
--
-- We deactivate instead of deleting so permission history is preserved.
-- ============================================================================

create or replace function wri_deactivate_practical_verifier(

  p_assignment_id uuid

)

returns void

language plpgsql

security definer

set search_path = public

as $$

declare

  v_assignment practical_verifier_assignments;

begin


  select *
  into v_assignment

  from practical_verifier_assignments

  where id =
    p_assignment_id;



  if v_assignment is null then

    raise exception
      'verifier assignment % not found',
      p_assignment_id;

  end if;



  if not (

    wri_is_integrateu_admin()

    or v_assignment.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to deactivate verifier assignment %',
      p_assignment_id;

  end if;



  update practical_verifier_assignments

  set

    is_active = false,

    updated_at = now()

  where id =
    p_assignment_id;


end;
$$;


revoke all
on function wri_deactivate_practical_verifier(uuid)
from public, anon;


grant execute
on function wri_deactivate_practical_verifier(uuid)
to authenticated;



-- ============================================================================
-- PART 5 — REACTIVATE VERIFIER ASSIGNMENT
-- ============================================================================

create or replace function wri_reactivate_practical_verifier(

  p_assignment_id uuid

)

returns void

language plpgsql

security definer

set search_path = public

as $$

declare

  v_assignment practical_verifier_assignments;

begin


  select *
  into v_assignment

  from practical_verifier_assignments

  where id =
    p_assignment_id;



  if v_assignment is null then

    raise exception
      'verifier assignment % not found',
      p_assignment_id;

  end if;



  if not (

    wri_is_integrateu_admin()

    or v_assignment.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to reactivate verifier assignment %',
      p_assignment_id;

  end if;



  if v_assignment.expires_at is not null

    and v_assignment.expires_at <=
        now() then

    raise exception
      'cannot reactivate an expired verifier assignment';

  end if;



  -- If another equivalent assignment is already active,
  -- don't allow a duplicate active permission.

  if exists (

    select 1

    from practical_verifier_assignments other

    where other.id <>
          v_assignment.id

      and other.verifier_user_id =
          v_assignment.verifier_user_id

      and other.client_id =
          v_assignment.client_id

      and other.scope =
          v_assignment.scope

      and other.is_active = true

      and (

        (
          v_assignment.scope = 'client'
          and other.employee_id is null
        )

        or

        (
          v_assignment.scope = 'employee'
          and other.employee_id =
              v_assignment.employee_id
        )

      )

  ) then

    raise exception
      'an equivalent active verifier assignment already exists';

  end if;



  update practical_verifier_assignments

  set

    is_active = true,

    updated_at = now()

  where id =
    p_assignment_id;


end;
$$;


revoke all
on function wri_reactivate_practical_verifier(uuid)
from public, anon;


grant execute
on function wri_reactivate_practical_verifier(uuid)
to authenticated;



-- ============================================================================
-- PART 6 — VERIFICATION
-- ============================================================================

select

  routine_name

from information_schema.routines

where routine_schema = 'public'

  and routine_name in (

    'wri_list_verifier_candidates',

    'wri_list_practical_verifiers',

    'wri_assign_practical_verifier',

    'wri_deactivate_practical_verifier',

    'wri_reactivate_practical_verifier'

  )

order by routine_name;