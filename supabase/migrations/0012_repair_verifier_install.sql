-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0010_verifier_permissions.sql
--
-- PURPOSE
-- Adds dedicated practical-verifier permissions.
--
-- A verifier can be authorized for:
--
--   CLIENT SCOPE
--     Verify practical competencies for any employee in one client/company.
--
--   EMPLOYEE SCOPE
--     Verify practical competencies for one specific employee.
--
-- Existing permissions remain valid:
--
--   INTEGRATEU_ADMIN
--   CLIENT_ADMIN
--
-- A verifier DOES NOT become a CLIENT_ADMIN and does not receive unrelated
-- administrative permissions.
-- ============================================================================


-- ============================================================================
-- PART 1 — VERIFIER ASSIGNMENTS
-- ============================================================================

create table if not exists practical_verifier_assignments (

  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  -- Supabase Auth user id.
  -- Intentionally not FK'd to auth.users so application-domain migrations
  -- remain independent of auth-schema ownership/permissions.
  verifier_user_id uuid not null,

  scope text not null default 'client'
    check (
      scope in (
        'client',
        'employee'
      )
    ),

  -- Required only when scope = employee.
  employee_id uuid
    references employees(id)
    on delete cascade,

  -- Friendly description of why this person may verify.
  -- Examples:
  -- Supervisor, Lead Technician, Trainer, Instructor.
  verifier_title text,

  is_active boolean not null default true,

  assigned_by uuid,

  assigned_at timestamptz not null default now(),

  expires_at timestamptz,

  notes text,

  created_at timestamptz not null default now(),

  updated_at timestamptz not null default now(),

  check (

    (
      scope = 'client'
      and employee_id is null
    )

    or

    (
      scope = 'employee'
      and employee_id is not null
    )

  )

);


create index if not exists ix_verifier_assignments_client
on practical_verifier_assignments(client_id);


create index if not exists ix_verifier_assignments_user
on practical_verifier_assignments(verifier_user_id);


create index if not exists ix_verifier_assignments_employee
on practical_verifier_assignments(employee_id);


create index if not exists ix_verifier_assignments_active
on practical_verifier_assignments(
  verifier_user_id,
  client_id
)
where is_active = true;



-- Prevent duplicate active client-wide assignments.

create unique index if not exists uq_verifier_active_client_scope
on practical_verifier_assignments(
  verifier_user_id,
  client_id
)
where
  scope = 'client'
  and is_active = true;



-- Prevent duplicate active employee-specific assignments.

create unique index if not exists uq_verifier_active_employee_scope
on practical_verifier_assignments(
  verifier_user_id,
  employee_id
)
where
  scope = 'employee'
  and is_active = true;



-- ============================================================================
-- PART 2 — VALIDATION TRIGGER
--
-- Ensures an employee-scoped assignment belongs to the same client as the
-- assignment itself.
-- ============================================================================

create or replace function wri_validate_practical_verifier_assignment()

returns trigger

language plpgsql

set search_path = public

as $$

declare

  v_employee_client_id uuid;

begin


  if new.scope = 'client' then

    new.employee_id := null;

    return new;

  end if;



  if new.employee_id is null then

    raise exception
      'employee_id is required for employee-scoped verifier assignments';

  end if;



  select client_id
  into v_employee_client_id

  from employees

  where id = new.employee_id;



  if v_employee_client_id is null then

    raise exception
      'employee % not found',
      new.employee_id;

  end if;



  if new.client_id <> v_employee_client_id then

    raise exception
      'verifier assignment client does not match employee client';

  end if;



  return new;


end;
$$;



drop trigger if exists trg_validate_practical_verifier_assignment
on practical_verifier_assignments;


create trigger trg_validate_practical_verifier_assignment

before insert or update
on practical_verifier_assignments

for each row

execute function wri_validate_practical_verifier_assignment();



drop trigger if exists trg_verifier_assignments_updated_at
on practical_verifier_assignments;


create trigger trg_verifier_assignments_updated_at

before update
on practical_verifier_assignments

for each row

execute function wri_set_updated_at();



-- ============================================================================
-- PART 3 — ROW LEVEL SECURITY
-- ============================================================================

alter table practical_verifier_assignments
enable row level security;



-- --------------------------------------------------------------------------
-- SELECT
--
-- IntegrateU admins:
--   all assignments
--
-- Client admins:
--   assignments for their clients
--
-- Verifier:
--   their own assignment records
-- --------------------------------------------------------------------------

drop policy if exists verifier_assignments_select
on practical_verifier_assignments;


create policy verifier_assignments_select

on practical_verifier_assignments

for select

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

  or verifier_user_id = auth.uid()

);



-- --------------------------------------------------------------------------
-- WRITE
--
-- IntegrateU Admin and Client Admin may assign/revoke verifiers.
-- A verifier cannot grant themselves verifier authority.
-- --------------------------------------------------------------------------

drop policy if exists verifier_assignments_write
on practical_verifier_assignments;


create policy verifier_assignments_write

on practical_verifier_assignments

for all

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
-- PART 4 — CENTRAL AUTHORIZATION FUNCTION
--
-- This becomes the single source of truth for:
--
--   "May the current logged-in user practically verify this employee?"
--
-- TRUE when:
--
--   IntegrateU Admin
--   OR Client Admin for employee's client
--   OR active client-wide verifier assignment
--   OR active employee-specific verifier assignment
--
-- Expired assignments are ignored.
-- ============================================================================

create or replace function wri_can_verify_master_practical(

  p_employee_id uuid

)

returns boolean

language plpgsql

stable

security definer

set search_path = public

as $$

declare

  v_client_id uuid;

begin


  select client_id
  into v_client_id

  from employees

  where id = p_employee_id;



  if v_client_id is null then
    return false;
  end if;



  -- IntegrateU administrator.

  if wri_is_integrateu_admin() then
    return true;
  end if;



  -- Existing company administrator.

  if v_client_id in (
    select wri_allowed_client_ids()
  ) then
    return true;
  end if;



  -- Dedicated verifier permission.

  return exists (

    select 1

    from practical_verifier_assignments pva

    where pva.verifier_user_id = auth.uid()

      and pva.client_id = v_client_id

      and pva.is_active = true

      and (
        pva.expires_at is null
        or pva.expires_at > now()
      )

      and (

        pva.scope = 'client'

        or

        (
          pva.scope = 'employee'
          and pva.employee_id = p_employee_id
        )

      )

  );


end;
$$;


revoke all
on function wri_can_verify_master_practical(uuid)
from public, anon;


grant execute
on function wri_can_verify_master_practical(uuid)
to authenticated;



-- ============================================================================
-- PART 5 — UPDATE PRACTICAL-VERIFICATION RPC
--
-- Authorization now uses wri_can_verify_master_practical().
-- Everything else continues to work exactly as before.
-- ============================================================================

create or replace function wri_record_master_practical_verification(

  p_employee_id uuid,

  p_master_competency_template_id uuid,

  p_rating_level int,

  p_status text default 'verified',

  p_notes text default null

)

returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_employee employees;

  v_id uuid;

begin


  -- --------------------------------------------------------------------------
  -- Employee
  -- --------------------------------------------------------------------------

  select *
  into v_employee

  from employees

  where id = p_employee_id;



  if v_employee is null then

    raise exception
      'employee % not found',
      p_employee_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Dedicated verification authorization
  -- --------------------------------------------------------------------------

  if not wri_can_verify_master_practical(
    p_employee_id
  ) then

    raise exception
      'not authorized to verify practical competency for employee %',
      p_employee_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Rating
  -- --------------------------------------------------------------------------

  if p_rating_level < 1
     or p_rating_level > 4 then

    raise exception
      'rating level must be between 1 and 4';

  end if;



  -- --------------------------------------------------------------------------
  -- Status
  -- --------------------------------------------------------------------------

  if p_status not in (
    'pending',
    'verified',
    'rejected'
  ) then

    raise exception
      'invalid practical verification status: %',
      p_status;

  end if;



  -- --------------------------------------------------------------------------
  -- Master competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from master_competency_templates

    where id =
      p_master_competency_template_id

  ) then

    raise exception
      'master competency template % not found',
      p_master_competency_template_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Insert immutable verification-history record
  -- --------------------------------------------------------------------------

  insert into master_practical_verifications (

    client_id,

    employee_id,

    master_competency_template_id,

    rating_level,

    status,

    verified_by,

    verified_at,

    notes

  )

  values (

    v_employee.client_id,

    p_employee_id,

    p_master_competency_template_id,

    p_rating_level,

    p_status,

    auth.uid(),

    case

      when p_status = 'verified'
        then now()

      else null

    end,

    p_notes

  )

  returning id
  into v_id;



  return v_id;


end;
$$;


revoke all
on function wri_record_master_practical_verification(
  uuid,
  uuid,
  int,
  text,
  text
)
from public, anon;


grant execute
on function wri_record_master_practical_verification(
  uuid,
  uuid,
  int,
  text,
  text
)
to authenticated;



-- ============================================================================
-- PART 6 — VERIFIER-ACCESS VIEW
--
-- Useful for future verifier dashboards.
--
-- Shows which employees the current verifier may access.
-- ============================================================================

create or replace view v_my_practical_verification_access

with (
  security_invoker = true
)

as

select

  e.id as employee_id,

  e.client_id,

  e.first_name,

  e.last_name,

  e.employee_number,

  pva.id as verifier_assignment_id,

  pva.scope as verifier_scope,

  pva.verifier_title,

  pva.expires_at


from practical_verifier_assignments pva


join employees e

  on e.client_id =
     pva.client_id

 and (

   pva.scope = 'client'

   or

   (
     pva.scope = 'employee'
     and e.id =
         pva.employee_id
   )

 )


where pva.verifier_user_id =
      auth.uid()

  and pva.is_active = true

  and (

    pva.expires_at is null

    or pva.expires_at >
       now()

  );



-- ============================================================================
-- PART 7 — VERIFICATION
-- ============================================================================

select

  table_name

from information_schema.tables

where table_schema = 'public'

  and table_name in (

    'practical_verifier_assignments',

    'master_practical_verifications'

  )

order by table_name;



select

  routine_name

from information_schema.routines

where routine_schema = 'public'

  and routine_name in (

    'wri_can_verify_master_practical',

    'wri_record_master_practical_verification'

  )

order by routine_name;-- ============================================================================
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