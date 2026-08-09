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

order by routine_name;