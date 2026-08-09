-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0015_practical_verification_history_rpc.sql
--
-- PURPOSE
-- Secure audit/history access for practical competency verification.
--
-- Returns:
--   employee
--   competency
--   rating
--   status
--   verifier identity
--   notes
--   timestamps
--
-- AUTHORIZATION
--   IntegrateU Admin
--   Client Admin for employee's client
--   Dedicated verifier with access to that employee
--   Employee may read their OWN history
--
-- Self-verification remains prohibited. This RPC is read-only.
-- ============================================================================


create or replace function wri_list_practical_verification_history(

  p_employee_id uuid

)

returns table (

  verification_id uuid,

  employee_id uuid,

  client_id uuid,

  employee_first_name text,

  employee_last_name text,

  employee_number text,

  master_competency_template_id uuid,

  competency_name text,

  competency_category text,

  competency_is_critical boolean,

  rating_level int,

  status text,

  verifier_user_id uuid,

  verifier_email text,

  verifier_employee_id uuid,

  verifier_first_name text,

  verifier_last_name text,

  verified_at timestamptz,

  created_at timestamptz,

  notes text

)

language plpgsql

stable

security definer

set search_path = public

as $$

declare

  v_employee employees;

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
  -- Authorization
  --
  -- Employee may read own verification history.
  -- Verifiers/admins may read history within their authorized scope.
  -- --------------------------------------------------------------------------

  if not (

    v_employee.auth_user_id = auth.uid()

    or wri_can_verify_master_practical(
      p_employee_id
    )

    or wri_is_integrateu_admin()

    or v_employee.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to view practical verification history for employee %',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- History
  -- --------------------------------------------------------------------------

  return query

  select

    mpv.id
      as verification_id,

    mpv.employee_id,

    mpv.client_id,

    e.first_name
      as employee_first_name,

    e.last_name
      as employee_last_name,

    e.employee_number,

    mpv.master_competency_template_id,

    mct.name
      as competency_name,

    mct.category
      as competency_category,

    mct.is_critical
      as competency_is_critical,

    mpv.rating_level,

    mpv.status,

    mpv.verified_by
      as verifier_user_id,

    au.email::text
      as verifier_email,

    verifier_employee.id
      as verifier_employee_id,

    verifier_employee.first_name
      as verifier_first_name,

    verifier_employee.last_name
      as verifier_last_name,

    mpv.verified_at,

    mpv.created_at,

    mpv.notes


  from master_practical_verifications mpv


  join employees e

    on e.id =
       mpv.employee_id


  join master_competency_templates mct

    on mct.id =
       mpv.master_competency_template_id


  left join auth.users au

    on au.id =
       mpv.verified_by


  left join employees verifier_employee

    on verifier_employee.auth_user_id =
       mpv.verified_by


  where mpv.employee_id =
        p_employee_id


  order by

    coalesce(
      mpv.verified_at,
      mpv.created_at
    ) desc,

    mpv.created_at desc;


end;
$$;


revoke all
on function wri_list_practical_verification_history(uuid)
from public, anon;


grant execute
on function wri_list_practical_verification_history(uuid)
to authenticated;



-- ============================================================================
-- VERIFICATION
-- ============================================================================

select routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name = 'wri_list_practical_verification_history';