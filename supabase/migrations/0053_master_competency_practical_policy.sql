-- ============================================================================
-- 0053_master_competency_practical_policy.sql
--
-- Establishes reusable practical-verification policy by master competency
-- from the same source used by the existing assessment readiness engine:
--
--   assessment_questions.practical_verification_required
--
-- This allows target-role readiness to evaluate practical requirements even
-- when the target role does not yet have its own assessment.
--
-- IMPORTANT:
--   No assessment questions for a competency does NOT manufacture practical
--   evidence. The target-role comparison still reports that competency as
--   not_assessed when employee knowledge evidence is absent.
-- ============================================================================


-- ============================================================================
-- PART 1 — MASTER COMPETENCY PRACTICAL POLICY
-- ============================================================================

create or replace view
  public.v_master_competency_practical_policy
as

select
  mct.id
    as master_competency_template_id,

  count(aq.id)
    as question_count,

  coalesce(
    bool_or(
      aq.practical_verification_required
    ),
    false
  )
    as practical_verification_required

from public.master_competency_templates mct

left join public.assessment_questions aq
  on aq.master_competency_template_id =
     mct.id

group by
  mct.id;


comment on view
  public.v_master_competency_practical_policy
is
'Reusable practical-verification policy by master competency, derived from assessment question definitions using the same bool_or rule as assessment readiness.';


-- ============================================================================
-- PART 2 — TARGET ROLE READINESS
-- ============================================================================

create or replace function
  public.wri_compare_employee_role_readiness(
    p_employee_id uuid,
    p_target_role_template_id uuid
  )
returns table (
  employee_id uuid,
  employee_first_name text,
  employee_last_name text,

  current_role_template_id uuid,
  current_role_name text,
  current_readiness_percent numeric,

  target_role_template_id uuid,
  target_role_name text,
  target_role_department text,

  master_competency_template_id uuid,
  competency_name text,
  competency_category text,
  competency_is_critical boolean,

  current_knowledge_level integer,
  current_practical_level integer,
  practical_verification_required boolean,

  target_required_level integer,

  knowledge_target_ready boolean,
  practical_target_ready boolean,
  target_competency_ready boolean,

  reverification_due boolean,
  verification_expired boolean,

  target_status text,

  target_competencies_ready bigint,
  target_competencies_total bigint,
  target_readiness_percent numeric,

  knowledge_gap_count bigint,
  practical_gap_count bigint,
  not_assessed_count bigint,
  reverification_due_count bigint,
  reverification_required_count bigint
)
language plpgsql
stable
security definer
set search_path = public
as $function$

declare
  v_employee_client_id uuid;
  v_employee_auth_user_id uuid;

begin

  -- --------------------------------------------------------------------------
  -- Employee existence / authorization
  -- --------------------------------------------------------------------------

  select
    e.client_id,
    e.auth_user_id

  into
    v_employee_client_id,
    v_employee_auth_user_id

  from public.employees e

  where e.id =
    p_employee_id;


  if v_employee_client_id is null then

    raise exception
      'Employee % not found',
      p_employee_id;

  end if;


  if not (

    public.wri_is_integrateu_admin()

    or v_employee_client_id in (
      select public.wri_allowed_client_ids()
    )

    or v_employee_auth_user_id =
      auth.uid()

  ) then

    raise exception
      'Not authorized to view role readiness for employee %',
      p_employee_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Target master role validation
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_role_templates mrt

    where mrt.id =
      p_target_role_template_id

      and mrt.is_current = true

      and mrt.status = 'active'

  ) then

    raise exception
      'Target role template % is not a current active role',
      p_target_role_template_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Target-role comparison
  -- --------------------------------------------------------------------------

  return query

  with current_role_readiness as (

    select
      rr.master_role_template_id,
      rr.role_name,
      rr.readiness_percent

    from public.v_assessment_role_readiness_current rr

    where rr.employee_id =
      p_employee_id

    limit 1
  ),


  target_role as (

    select
      mrt.id,
      mrt.name,
      mrt.department

    from public.master_role_templates mrt

    where mrt.id =
      p_target_role_template_id
  ),


  target_requirements as (

    select
      mrcr.master_competency_template_id,

      mrcr.required_level,

      mct.name
        as competency_name,

      mct.category
        as competency_category,

      mct.is_critical
        as competency_is_critical,

      coalesce(
        mcpp.practical_verification_required,
        false
      )
        as practical_verification_required

    from public.master_role_competency_requirements mrcr

    join public.master_competency_templates mct
      on mct.id =
         mrcr.master_competency_template_id

    left join
      public.v_master_competency_practical_policy mcpp

      on mcpp.master_competency_template_id =
         mrcr.master_competency_template_id

    where mrcr.master_role_template_id =
      p_target_role_template_id
  ),


  comparison_base as (

    select
      tr.master_competency_template_id,

      tr.competency_name,
      tr.competency_category,
      tr.competency_is_critical,

      tr.required_level,

      tr.practical_verification_required,

      ee.knowledge_level
        as current_knowledge_level,

      ee.practical_rating_level
        as current_practical_level,

      ee.practical_verification_status,

      coalesce(
        ee.reverification_due,
        false
      )
        as reverification_due,

      coalesce(
        ee.verification_expired,
        false
      )
        as verification_expired

    from target_requirements tr

    left join
      public.v_employee_master_competency_evidence ee

      on ee.employee_id =
         p_employee_id

     and ee.master_competency_template_id =
         tr.master_competency_template_id
  ),


  evaluated as (

    select
      cb.*,

      (
        cb.current_knowledge_level
          is not null

        and cb.current_knowledge_level >=
            cb.required_level
      )
        as knowledge_target_ready,


      case

        when
          cb.practical_verification_required = false

          then true


        when cb.verification_expired = true

          then false


        when cb.practical_verification_status
          is distinct from 'verified'

          then false


        when cb.current_practical_level
          is null

          then false


        when cb.current_practical_level >=
             cb.required_level

          then true


        else false

      end
        as practical_target_ready

    from comparison_base cb
  ),


  classified as (

    select
      ev.*,

      (
        ev.knowledge_target_ready
        and ev.practical_target_ready
      )
        as target_competency_ready,


      case

        -- No knowledge evidence for this competency yet.
        when ev.current_knowledge_level
          is null

          then 'not_assessed'


        when not ev.knowledge_target_ready

          then 'knowledge_gap'


        when
          ev.practical_verification_required
          and ev.verification_expired

          then 'reverification_required'


        when
          ev.practical_verification_required
          and not ev.practical_target_ready

          then 'practical_gap'


        when ev.reverification_due

          then 'reverification_due'


        else 'ready'

      end
        as target_status

    from evaluated ev
  ),


  summarized as (

    select
      c.*,


      count(*) filter (
        where c.target_competency_ready
      ) over ()
        as target_competencies_ready,


      count(*) over ()
        as target_competencies_total,


      round(
        100.0
        *
        count(*) filter (
          where c.target_competency_ready
        ) over ()
        /
        nullif(
          count(*) over (),
          0
        ),
        1
      )
        as target_readiness_percent,


      count(*) filter (
        where c.target_status =
          'knowledge_gap'
      ) over ()
        as knowledge_gap_count,


      count(*) filter (
        where c.target_status =
          'practical_gap'
      ) over ()
        as practical_gap_count,


      count(*) filter (
        where c.target_status =
          'not_assessed'
      ) over ()
        as not_assessed_count,


      count(*) filter (
        where c.target_status =
          'reverification_due'
      ) over ()
        as reverification_due_count,


      count(*) filter (
        where c.target_status =
          'reverification_required'
      ) over ()
        as reverification_required_count

    from classified c
  )


  select
    e.id
      as employee_id,

    e.first_name
      as employee_first_name,

    e.last_name
      as employee_last_name,

    cr.master_role_template_id
      as current_role_template_id,

    cr.role_name
      as current_role_name,

    cr.readiness_percent
      as current_readiness_percent,

    tr.id
      as target_role_template_id,

    tr.name
      as target_role_name,

    tr.department
      as target_role_department,

    s.master_competency_template_id,

    s.competency_name,
    s.competency_category,
    s.competency_is_critical,

    s.current_knowledge_level,
    s.current_practical_level,

    s.practical_verification_required,

    s.required_level
      as target_required_level,

    s.knowledge_target_ready,
    s.practical_target_ready,
    s.target_competency_ready,

    s.reverification_due,
    s.verification_expired,

    s.target_status,

    s.target_competencies_ready,
    s.target_competencies_total,
    s.target_readiness_percent,

    s.knowledge_gap_count,
    s.practical_gap_count,
    s.not_assessed_count,
    s.reverification_due_count,
    s.reverification_required_count

  from summarized s

  cross join public.employees e

  cross join target_role tr

  left join current_role_readiness cr
    on true

  where e.id =
    p_employee_id

  order by

    case s.target_status

      when 'reverification_required'
        then 1

      when 'knowledge_gap'
        then 2

      when 'practical_gap'
        then 3

      when 'not_assessed'
        then 4

      when 'reverification_due'
        then 5

      else 6

    end,

    s.competency_category,
    s.competency_name;

end;

$function$;


revoke all
on function
  public.wri_compare_employee_role_readiness(uuid, uuid)
from public, anon;


grant execute
on function
  public.wri_compare_employee_role_readiness(uuid, uuid)
to authenticated;


comment on function
  public.wri_compare_employee_role_readiness(uuid, uuid)
is
'Compares reusable employee master-competency evidence against a selected current master role, using question-bank practical requirements and target-role required levels.';
