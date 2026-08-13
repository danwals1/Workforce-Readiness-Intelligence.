-- ============================================================================
-- 0052_employee_competency_evidence.sql
--
-- Employee-level master competency evidence.
--
-- Purpose:
--   Establish one reusable evidence contract for comparing an employee
--   against ANY master role template.
--
-- Knowledge evidence:
--   latest completed competency score across:
--     - full assessment
--     - targeted_reassessment
--
-- Practical evidence:
--   latest immutable practical verification ATTEMPT
--   for employee + master competency.
--
-- Important:
--   We intentionally use the latest practical attempt rather than the
--   highest historical rating so a later failed/lower verification is not
--   hidden by an older passing verification.
-- ============================================================================


-- ============================================================================
-- PART 1 — EMPLOYEE MASTER COMPETENCY EVIDENCE
-- ============================================================================

create or replace view public.v_employee_master_competency_evidence
as

with knowledge_candidates as (

  select
    aa.client_id,
    aa.employee_id,

    cs.master_competency_template_id,

    aa.id
      as knowledge_attempt_id,

    aa.assessment_id,

    aa.attempt_mode,

    cs.score_percent
      as knowledge_score_percent,

    cs.estimated_level
      as knowledge_level,

    coalesce(
      aa.completed_at,
      cs.created_at,
      aa.created_at
    )
      as knowledge_evidenced_at,

    row_number() over (
      partition by
        aa.employee_id,
        cs.master_competency_template_id

      order by
        aa.completed_at desc nulls last,
        cs.created_at desc,
        aa.created_at desc,
        aa.id desc,
        cs.id desc
    )
      as evidence_rank

  from public.assessment_attempts aa

  join public.competency_scores cs
    on cs.attempt_id = aa.id
   and cs.employee_id = aa.employee_id

  where aa.status = 'completed'

    and aa.attempt_mode in (
      'full',
      'targeted_reassessment'
    )

    and cs.master_competency_template_id
      is not null
),

latest_knowledge as (

  select
    kc.client_id,
    kc.employee_id,

    kc.master_competency_template_id,

    kc.knowledge_attempt_id,
    kc.assessment_id,
    kc.attempt_mode,

    kc.knowledge_score_percent,
    kc.knowledge_level,
    kc.knowledge_evidenced_at

  from knowledge_candidates kc

  where kc.evidence_rank = 1
),

practical_candidates as (

  select
    pv.client_id,
    pv.employee_id,

    pv.master_competency_template_id,

    pv.id
      as practical_verification_id,

    pv.rating_level
      as practical_rating_level,

    pv.status
      as practical_verification_status,

    pv.verified_by,

    pv.verified_at,

    pv.notes
      as practical_notes,

    row_number() over (
      partition by
        pv.employee_id,
        pv.master_competency_template_id

      order by
        pv.verified_at desc nulls last,
        pv.created_at desc,
        pv.id desc
    )
      as evidence_rank

  from public.master_practical_verifications pv

  where pv.master_competency_template_id
    is not null
),

latest_practical as (

  select
    pc.client_id,
    pc.employee_id,

    pc.master_competency_template_id,

    pc.practical_verification_id,
    pc.practical_rating_level,
    pc.practical_verification_status,

    pc.verified_by,
    pc.verified_at,
    pc.practical_notes

  from practical_candidates pc

  where pc.evidence_rank = 1
),

evidence_keys as (

  select
    lk.client_id,
    lk.employee_id,
    lk.master_competency_template_id

  from latest_knowledge lk

  union

  select
    lp.client_id,
    lp.employee_id,
    lp.master_competency_template_id

  from latest_practical lp
),

combined as (

  select
    ek.client_id,
    ek.employee_id,

    ek.master_competency_template_id,

    mct.name
      as competency_name,

    mct.category
      as competency_category,

    mct.is_critical
      as competency_is_critical,

    mct.verifier_type,

    mct.reverification_period_months,

    lk.knowledge_attempt_id,
    lk.assessment_id
      as knowledge_assessment_id,

    lk.attempt_mode
      as knowledge_attempt_mode,

    lk.knowledge_score_percent,
    lk.knowledge_level,
    lk.knowledge_evidenced_at,

    lp.practical_verification_id,
    lp.practical_rating_level,
    lp.practical_verification_status,

    lp.verified_by
      as practical_verified_by,

    lp.verified_at
      as practical_verified_at,

    lp.practical_notes,

    case

      when lp.practical_verification_status
        <> 'verified'
        then null

      when lp.verified_at is null
        then null

      when mct.reverification_period_months
        is null
        then null

      when mct.reverification_period_months
        <= 0
        then null

      else
        lp.verified_at
        +
        make_interval(
          months =>
            mct.reverification_period_months
        )

    end
      as practical_verification_expires_at

  from evidence_keys ek

  join public.master_competency_templates mct
    on mct.id =
      ek.master_competency_template_id

  left join latest_knowledge lk
    on lk.employee_id =
      ek.employee_id
   and lk.master_competency_template_id =
      ek.master_competency_template_id

  left join latest_practical lp
    on lp.employee_id =
      ek.employee_id
   and lp.master_competency_template_id =
      ek.master_competency_template_id
)

select
  c.client_id,
  c.employee_id,

  c.master_competency_template_id,

  c.competency_name,
  c.competency_category,
  c.competency_is_critical,

  c.verifier_type,
  c.reverification_period_months,

  c.knowledge_attempt_id,
  c.knowledge_assessment_id,
  c.knowledge_attempt_mode,

  c.knowledge_score_percent,
  c.knowledge_level,
  c.knowledge_evidenced_at,

  c.practical_verification_id,
  c.practical_rating_level,
  c.practical_verification_status,

  c.practical_verified_by,
  c.practical_verified_at,
  c.practical_notes,

  c.practical_verification_expires_at,

  case

    when c.practical_verification_expires_at
      is null
      then false

    when c.practical_verification_expires_at
      <= now()
      then false

    when c.practical_verification_expires_at
      <= now() + interval '30 days'
      then true

    else false

  end
    as reverification_due,

  case

    when c.practical_verification_expires_at
      is null
      then false

    when c.practical_verification_expires_at
      <= now()
      then true

    else false

  end
    as verification_expired

from combined c;


comment on view
  public.v_employee_master_competency_evidence
is
'Latest employee-level knowledge and practical evidence by master competency, independent of current role assessment. Knowledge uses latest completed full or targeted reassessment evidence; practical uses latest verification attempt.';


-- ============================================================================
-- PART 2 — REPLACE TARGET ROLE COMPARISON WITH EMPLOYEE EVIDENCE
-- ============================================================================

create or replace function public.wri_compare_employee_role_readiness(
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
  -- Target role validation
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
  -- Comparison
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

      case
        when mct.verifier_type is null
          then false

        when btrim(mct.verifier_type) = ''
          then false

        else true
      end
        as practical_verification_required

    from public.master_role_competency_requirements mrcr

    join public.master_competency_templates mct
      on mct.id =
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

      ee.knowledge_evidenced_at,

      ee.practical_verified_at,

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

        and cb.current_knowledge_level
          >= cb.required_level
      )
        as knowledge_target_ready,

      (
        case

          when
            cb.practical_verification_required = false
            then true

          when cb.verification_expired
            then false

          when cb.practical_verification_status
            is distinct from 'verified'
            then false

          when cb.current_practical_level
            is null
            then false

          when cb.current_practical_level
            >= cb.required_level
            then true

          else false

        end
      )
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
      when 'reverification_required' then 1
      when 'knowledge_gap' then 2
      when 'practical_gap' then 3
      when 'not_assessed' then 4
      when 'reverification_due' then 5
      else 6
    end,

    s.competency_category,
    s.competency_name;

end;

$function$;


revoke all
on function public.wri_compare_employee_role_readiness(uuid, uuid)
from public, anon;


grant execute
on function public.wri_compare_employee_role_readiness(uuid, uuid)
to authenticated;


comment on function
  public.wri_compare_employee_role_readiness(uuid, uuid)
is
'Compares employee-level master competency evidence against any selected current master role template.';
