-- ============================================================================
-- 0018_reverification_readiness_layer.sql
--
-- Adds expiration-aware readiness WITHOUT replacing the existing working
-- readiness views.
--
-- Existing views remain untouched:
--   v_assessment_competency_readiness
--   v_assessment_role_readiness
--   v_employee_assessment_summary
--
-- New views:
--   v_assessment_competency_readiness_current
--   v_assessment_role_readiness_current
-- ============================================================================


-- ============================================================================
-- PART 1 — CURRENT COMPETENCY READINESS
-- ============================================================================

create or replace view v_assessment_competency_readiness_current as

with base as (

  select

    acr.*,

    mct.reverification_period_months,

    case
      when acr.practical_verification_required = false
        then null

      when acr.practical_verification_status <> 'verified'
        then null

      when acr.practical_verified_at is null
        then null

      when mct.reverification_period_months is null
        then null

      when mct.reverification_period_months <= 0
        then null

      else
        acr.practical_verified_at
        +
        make_interval(
          months => mct.reverification_period_months
        )

    end as practical_verification_expires_at

  from v_assessment_competency_readiness acr

  join master_competency_templates mct
    on mct.id = acr.master_competency_template_id

),

currency as (

  select

    b.*,

    case
      when b.practical_verification_required = false
        then 'not_required'

      when b.practical_verification_status is null
        then 'never_verified'

      when b.practical_verification_status <> 'verified'
        then 'not_verified'

      when b.practical_verification_expires_at is null
        then 'current'

      when b.practical_verification_expires_at <= now()
        then 'expired'

      when b.practical_verification_expires_at
           <= now() + interval '30 days'
        then 'due_soon'

      else 'current'
    end as verification_currency_status,

    case
      when b.practical_verification_expires_at is null
        then null

      else floor(
        extract(
          epoch from (
            b.practical_verification_expires_at - now()
          )
        ) / 86400
      )::integer
    end as days_until_expiration,

    case
      when b.practical_verification_expires_at is null
        then false

      when b.practical_verification_expires_at <= now()
        then false

      when b.practical_verification_expires_at
           <= now() + interval '30 days'
        then true

      else false
    end as reverification_due,

    case
      when b.practical_verification_expires_at is null
        then false

      when b.practical_verification_expires_at <= now()
        then true

      else false
    end as verification_expired

  from base b

)

select

  c.attempt_id,
  c.client_id,
  c.employee_id,
  c.assessment_id,
  c.assessment_name,
  c.master_role_template_id,
  c.master_competency_template_id,
  c.competency_name,
  c.competency_category,
  c.competency_is_critical,
  c.knowledge_score_percent,
  c.knowledge_level,
  c.required_level,
  c.knowledge_ready,
  c.practical_verification_required,
  c.practical_rating_level,
  c.practical_verification_status,
  c.practical_verified_at,

  case
    when c.practical_verification_required = false
      then true

    else coalesce(
      c.practical_verification_status = 'verified'
      and c.practical_rating_level >= c.required_level
      and c.verification_expired = false,
      false
    )
  end as practical_ready,

  case
    when c.required_level is null
      then false

    when c.knowledge_level < c.required_level
      then false

    when c.practical_verification_required = true
      and coalesce(
        c.practical_verification_status = 'verified'
        and c.practical_rating_level >= c.required_level
        and c.verification_expired = false,
        false
      ) = false
      then false

    else true
  end as competency_ready,

  case
    when c.required_level is null
      then 'not_required'

    when c.knowledge_level < (c.required_level - 1)
      then 'critical_gap'

    when c.knowledge_level < c.required_level
      then 'developing'

    when c.practical_verification_required = true
         and c.practical_verification_status is null
      then 'practical_verification_needed'

    when c.practical_verification_required = true
         and c.practical_verification_status <> 'verified'
      then 'practical_verification_needed'

    when c.practical_verification_required = true
         and c.verification_expired = true
      then 'reverification_required'

    when c.practical_verification_required = true
         and coalesce(c.practical_rating_level, 0) < c.required_level
      then 'practical_development_needed'

    else 'ready'
  end as readiness_status,

  c.reverification_period_months,
  c.practical_verification_expires_at,
  c.days_until_expiration,
  c.reverification_due,
  c.verification_expired,
  c.verification_currency_status

from currency c;



-- ============================================================================
-- PART 2 — CURRENT ROLE READINESS
-- ============================================================================

create or replace view v_assessment_role_readiness_current as

with competency_summary as (

  select

    acr.attempt_id,
    acr.client_id,
    acr.employee_id,
    acr.assessment_id,
    acr.assessment_name,
    acr.master_role_template_id,

    count(*) filter (
      where acr.required_level is not null
    ) as competencies_total,

    count(*) filter (
      where acr.required_level is not null
        and acr.competency_ready = true
    ) as competencies_ready,

    count(*) filter (
      where acr.readiness_status = 'developing'
    ) as developing_count,

    count(*) filter (
      where acr.readiness_status = 'critical_gap'
    ) as critical_gap_count,

    count(*) filter (
      where acr.readiness_status in (
        'practical_verification_needed',
        'practical_development_needed',
        'reverification_required'
      )
    ) as practical_gap_count,

    count(*) filter (
      where acr.reverification_due = true
    ) as reverification_due_count,

    count(*) filter (
      where acr.verification_expired = true
    ) as reverification_required_count,

    round(
      avg(acr.knowledge_score_percent),
      1
    ) as average_knowledge_score

  from v_assessment_competency_readiness_current acr

  group by
    acr.attempt_id,
    acr.client_id,
    acr.employee_id,
    acr.assessment_id,
    acr.assessment_name,
    acr.master_role_template_id

)

select

  cs.attempt_id,
  cs.client_id,
  cs.employee_id,
  cs.assessment_id,
  cs.assessment_name,
  cs.master_role_template_id,

  mrt.name as role_name,

  cs.average_knowledge_score,

  sr.critical_safety_score_percent,

  cs.competencies_ready,
  cs.competencies_total,

  case
    when cs.competencies_total = 0
      then 0::numeric

    else round(
      100.0 *
      cs.competencies_ready::numeric /
      cs.competencies_total::numeric,
      1
    )
  end as readiness_percent,

  cs.developing_count,
  cs.critical_gap_count,
  cs.practical_gap_count,
  cs.reverification_due_count,
  cs.reverification_required_count,

  case
    when sr.critical_safety_score_percent is not null
         and sr.critical_safety_score_percent < 80
      then 'safety_gap'

    when cs.competencies_total > 0
         and cs.competencies_ready = cs.competencies_total
      then 'ready'

    when cs.critical_gap_count > 0
      then 'critical_gap'

    when cs.reverification_required_count > 0
      then 'reverification_required'

    when cs.practical_gap_count > 0
      then 'practical_verification_needed'

    else 'developing'
  end as readiness_status

from competency_summary cs

join master_role_templates mrt
  on mrt.id = cs.master_role_template_id

left join v_assessment_safety_readiness sr
  on sr.attempt_id = cs.attempt_id;



-- ============================================================================
-- VERIFICATION
-- ============================================================================

select
  competency_name,
  practical_ready,
  competency_ready,
  reverification_period_months,
  practical_verification_expires_at,
  days_until_expiration,
  reverification_due,
  verification_expired,
  verification_currency_status,
  readiness_status

from v_assessment_competency_readiness_current

where employee_id =
  '9892d84b-6d06-4727-a817-aaea9f87a558'::uuid

and competency_name =
  'Safety & Job-Site Standards';