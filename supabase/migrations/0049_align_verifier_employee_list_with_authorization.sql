-- ============================================================================
-- 0049_align_verifier_employee_list_with_authorization.sql
--
-- Align the verification employee work queue with
-- wri_can_verify_master_practical().
--
-- Authorized verification sources:
--   1. IntegrateU Admin
--   2. Client Admin for allowed clients
--   3. Active practical verifier assignment
--
-- Self-verification remains prohibited in every case.
-- ============================================================================

create or replace function public.wri_list_my_verification_employees()
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
as $function$

with candidate_access as (

  -- --------------------------------------------------------------------------
  -- IntegrateU Admin
  --
  -- wri_can_verify_master_practical() grants IntegrateU Admins authority
  -- over employees other than their own linked employee record.
  -- --------------------------------------------------------------------------

  select
    e.id as employee_id,
    e.client_id,
    e.first_name,
    e.last_name,
    e.employee_number,

    'client'::text as verifier_scope,
    'IntegrateU Admin'::text as verifier_title,
    null::uuid as assignment_id,

    1 as access_priority,
    null::timestamptz as assigned_at

  from public.employees e

  where public.wri_is_integrateu_admin()

    and e.auth_user_id
      is distinct from auth.uid()


  union all


  -- --------------------------------------------------------------------------
  -- Client Admin
  --
  -- Client Admins may verify employees belonging to clients returned by
  -- wri_allowed_client_ids(), excluding their own linked employee record.
  -- --------------------------------------------------------------------------

  select
    e.id as employee_id,
    e.client_id,
    e.first_name,
    e.last_name,
    e.employee_number,

    'client'::text as verifier_scope,
    'Client Admin'::text as verifier_title,
    null::uuid as assignment_id,

    2 as access_priority,
    null::timestamptz as assigned_at

  from public.employees e

  where e.client_id in (
    select public.wri_allowed_client_ids()
  )

    and e.auth_user_id
      is distinct from auth.uid()


  union all


  -- --------------------------------------------------------------------------
  -- Dedicated Practical Verifier
  -- --------------------------------------------------------------------------

  select
    e.id as employee_id,
    e.client_id,
    e.first_name,
    e.last_name,
    e.employee_number,

    pva.scope as verifier_scope,
    pva.verifier_title,
    pva.id as assignment_id,

    case
      when pva.scope = 'employee'
        then 3
      else 4
    end as access_priority,

    pva.assigned_at

  from public.practical_verifier_assignments pva

  join public.employees e
    on e.client_id = pva.client_id

   and (
     pva.scope = 'client'

     or (
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

    -- Self-verification is never allowed.
    and e.auth_user_id
      is distinct from auth.uid()
),

ranked_access as (

  select
    ca.*,

    row_number() over (
      partition by ca.employee_id

      order by
        ca.access_priority,
        ca.assigned_at desc nulls last
    ) as access_rank

  from candidate_access ca
)

select
  ra.employee_id,
  ra.client_id,
  ra.first_name,
  ra.last_name,
  ra.employee_number,
  ra.verifier_scope,
  ra.verifier_title,
  ra.assignment_id

from ranked_access ra

where ra.access_rank = 1

order by
  ra.last_name,
  ra.first_name,
  ra.employee_id;

$function$;


revoke all
on function public.wri_list_my_verification_employees()
from public, anon;


grant execute
on function public.wri_list_my_verification_employees()
to authenticated;
