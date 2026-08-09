-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0014_block_self_verification.sql
--
-- PURPOSE
-- Practical verifiers may NEVER verify their own competency.
--
-- ENFORCEMENT
--
--   1. wri_can_verify_master_practical()
--      returns FALSE when the target employee belongs to auth.uid()
--
--   2. wri_list_my_verification_employees()
--      excludes the verifier's own employee record
--
--   3. wri_record_master_practical_verification()
--      explicitly rejects self-verification
--
--   4. Database trigger on master_practical_verifications
--      prevents direct INSERT / UPDATE bypass through the API
--
-- IntegrateU Admin and Client Admin are also prohibited from verifying
-- themselves when they are linked to an employee record.
-- ============================================================================


-- ============================================================================
-- PART 1 — HARD DATABASE GUARD
-- ============================================================================

create or replace function wri_block_self_practical_verification()

returns trigger

language plpgsql

set search_path = public

as $$

declare

  v_employee_auth_user_id uuid;

begin

  select auth_user_id
  into v_employee_auth_user_id

  from employees

  where id = new.employee_id;


  if auth.uid() is not null
     and v_employee_auth_user_id = auth.uid() then

    raise exception
      'self-verification is not allowed';

  end if;


  return new;

end;
$$;


drop trigger if exists trg_block_self_practical_verification
on master_practical_verifications;


create trigger trg_block_self_practical_verification

before insert or update
on master_practical_verifications

for each row

execute function wri_block_self_practical_verification();



-- ============================================================================
-- PART 2 — CENTRAL AUTHORIZATION
--
-- Self-verification is denied BEFORE checking admin or verifier authority.
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

  v_employee_auth_user_id uuid;

begin

  select

    client_id,

    auth_user_id

  into

    v_client_id,

    v_employee_auth_user_id

  from employees

  where id = p_employee_id;


  if v_client_id is null then
    return false;
  end if;


  -- --------------------------------------------------------------------------
  -- SELF-VERIFICATION IS NEVER ALLOWED
  -- --------------------------------------------------------------------------

  if auth.uid() is not null
     and v_employee_auth_user_id = auth.uid() then

    return false;

  end if;


  -- --------------------------------------------------------------------------
  -- IntegrateU Admin
  -- --------------------------------------------------------------------------

  if wri_is_integrateu_admin() then
    return true;
  end if;


  -- --------------------------------------------------------------------------
  -- Client Admin
  -- --------------------------------------------------------------------------

  if v_client_id in (
    select wri_allowed_client_ids()
  ) then

    return true;

  end if;


  -- --------------------------------------------------------------------------
  -- Dedicated practical verifier
  -- --------------------------------------------------------------------------

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
-- PART 3 — VERIFIER EMPLOYEE LIST
--
-- The verifier's own linked employee record is excluded.
-- ============================================================================

create or replace function wri_list_my_verification_employees()

returns table (

  employee_id uuid,

  client_id uuid,

  first_name text,

  last_name text,

  employee_number text,

  verifier_scope text,

  verifier_title text,

  assignment_id uuid

)

language sql

stable

security definer

set search_path = public

as $$

  select distinct on (e.id)

    e.id as employee_id,

    e.client_id,

    e.first_name,

    e.last_name,

    e.employee_number,

    pva.scope as verifier_scope,

    pva.verifier_title,

    pva.id as assignment_id


  from practical_verifier_assignments pva


  join employees e

    on e.client_id = pva.client_id

   and (

      pva.scope = 'client'

      or

      (
        pva.scope = 'employee'
        and e.id = pva.employee_id
      )

   )


  where pva.verifier_user_id = auth.uid()

    and pva.is_active = true

    and (
      pva.expires_at is null
      or pva.expires_at > now()
    )

    -- Never display the logged-in verifier's own employee record.
    and e.auth_user_id is distinct from auth.uid()


  order by

    e.id,

    case
      when pva.scope = 'employee' then 0
      else 1
    end,

    pva.assigned_at desc;

$$;


revoke all
on function wri_list_my_verification_employees()
from public, anon;


grant execute
on function wri_list_my_verification_employees()
to authenticated;



-- ============================================================================
-- PART 4 — RECORD PRACTICAL VERIFICATION
--
-- Adds an explicit self-verification rejection before normal authorization.
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
  -- SELF-VERIFICATION IS NEVER ALLOWED
  -- --------------------------------------------------------------------------

  if auth.uid() is not null
     and v_employee.auth_user_id = auth.uid() then

    raise exception
      'self-verification is not allowed';

  end if;


  -- --------------------------------------------------------------------------
  -- Authorization
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
  -- Immutable verification history
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
-- PART 5 — VERIFICATION
-- ============================================================================

select

  routine_name

from information_schema.routines

where routine_schema = 'public'

  and routine_name in (
    'wri_block_self_practical_verification',
    'wri_can_verify_master_practical',
    'wri_list_my_verification_employees',
    'wri_record_master_practical_verification'
  )

order by routine_name;