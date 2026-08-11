-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0016_practical_reverification_status.sql
--
-- PURPOSE
-- Calculate practical-verification currency / reverification status.
--
-- A practical verification can be:
--
--   never_verified
--   current
--   due_soon
--   expired
--
-- RULES
--
-- 1. Uses the latest VERIFIED practical-verification event.
-- 2. Uses master_competency_templates.reverification_period_months.
-- 3. If no reverification period is configured, a verified competency
--    does not expire.
-- 4. "Due soon" begins 30 days before expiration.
-- 5. This migration DOES NOT yet change readiness calculations.
--
-- ============================================================================


create or replace function wri_list_practical_reverification_status(
  p_employee_id uuid
)
returns table (
  master_competency_template_id uuid,
  competency_name text,
  competency_category text,
  competency_is_critical boolean,

  reverification_period_months integer,

  latest_verification_id uuid,
  latest_rating_level integer,
  latest_verification_status text,
  latest_verified_at timestamptz,

  expires_at timestamptz,
  days_until_expiration integer,

  reverification_due boolean,
  verification_expired boolean,

  verification_currency_status text
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
  -- Same read-access model as practical verification history.
  --
  -- Employee:
  --   may view own status
  --
  -- IntegrateU Admin:
  --   may view all
  --
  -- Client Admin:
  --   may view employees in allowed clients
  --
  -- Practical Verifier:
  --   may view employees they are authorized to verify
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
      'not authorized to view practical reverification status for employee %',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Reverification status
  -- --------------------------------------------------------------------------

  return query

  with employee_competencies as (

    select distinct
      vacr.master_competency_template_id

    from v_assessment_competency_readiness vacr

    where vacr.employee_id =
          p_employee_id

      and vacr.practical_verification_required = true

  ),

  latest_verified as (

    select distinct on (
      mpv.master_competency_template_id
    )

      mpv.id,
      mpv.master_competency_template_id,
      mpv.rating_level,
      mpv.status,
      coalesce(
        mpv.verified_at,
        mpv.created_at
      ) as verified_at

    from master_practical_verifications mpv

    where mpv.employee_id =
          p_employee_id

      and mpv.status =
          'verified'

    order by
      mpv.master_competency_template_id,
      coalesce(
        mpv.verified_at,
        mpv.created_at
      ) desc,
      mpv.created_at desc,
      mpv.id desc

  ),

  calculated as (

    select

      mct.id
        as master_competency_template_id,

      mct.name
        as competency_name,

      mct.category
        as competency_category,

      mct.is_critical
        as competency_is_critical,

      mct.reverification_period_months,

      lv.id
        as latest_verification_id,

      lv.rating_level
        as latest_rating_level,

      lv.status
        as latest_verification_status,

      lv.verified_at
        as latest_verified_at,


      case

        when lv.id is null then
          null

        when mct.reverification_period_months is null then
          null

        when mct.reverification_period_months <= 0 then
          null

        else
          lv.verified_at
          +
          make_interval(
            months =>
              mct.reverification_period_months
          )

      end
        as expires_at


    from employee_competencies ec


    join master_competency_templates mct

      on mct.id =
         ec.master_competency_template_id


    left join latest_verified lv

      on lv.master_competency_template_id =
         mct.id

  )


  select

    c.master_competency_template_id,

    c.competency_name,

    c.competency_category,

    c.competency_is_critical,

    c.reverification_period_months,

    c.latest_verification_id,

    c.latest_rating_level,

    c.latest_verification_status,

    c.latest_verified_at,

    c.expires_at,


    case

      when c.expires_at is null then
        null

      else
        floor(
          extract(
            epoch from (
              c.expires_at -
              now()
            )
          )
          /
          86400
        )::integer

    end
      as days_until_expiration,


    case

      when c.latest_verification_id is null then
        false

      when c.expires_at is null then
        false

      when c.expires_at <= now() then
        false

      when c.expires_at <=
           now() + interval '30 days'
      then
        true

      else
        false

    end
      as reverification_due,


    case

      when c.latest_verification_id is null then
        false

      when c.expires_at is null then
        false

      when c.expires_at <= now() then
        true

      else
        false

    end
      as verification_expired,


    case

      when c.latest_verification_id is null then
        'never_verified'

      when c.expires_at is null then
        'current'

      when c.expires_at <= now() then
        'expired'

      when c.expires_at <=
           now() + interval '30 days'
      then
        'due_soon'

      else
        'current'

    end
      as verification_currency_status


  from calculated c

  order by
    c.competency_name;

end;
$$;


-- ============================================================================
-- SECURITY
-- ============================================================================

revoke all
on function wri_list_practical_reverification_status(uuid)
from public, anon;


grant execute
on function wri_list_practical_reverification_status(uuid)
to authenticated;


-- ============================================================================
-- VERIFICATION
-- ============================================================================

select routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name =
      'wri_list_practical_reverification_status';