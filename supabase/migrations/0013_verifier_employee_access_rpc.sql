-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0013_verifier_employee_access_rpc.sql
--
-- PURPOSE
-- Returns the employees the currently logged-in user is explicitly allowed
-- to practically verify through dedicated verifier assignments.
--
-- This is intentionally separate from CLIENT_ADMIN / INTEGRATEU_ADMIN.
--
-- Dedicated verifier behavior:
--
--   client scope
--     -> may verify all employees in the assigned company
--
--   employee scope
--     -> may verify only the specifically assigned employee
--
-- Expired or inactive assignments are ignored.
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
-- VERIFICATION
-- ============================================================================

select routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name = 'wri_list_my_verification_employees';