-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0017_reverification_readiness.sql
--
-- PURPOSE
--
-- Make practical-verification expiration part of the actual readiness engine.
--
-- RULES
--
--   current
--     -> practical verification counts normally
--
--   due_soon
--     -> still counts as practically ready
--     -> warning status is exposed for UI
--
--   expired
--     -> no longer counts as practically ready
--     -> competency readiness becomes false
--     -> readiness_status becomes 'reverification_required'
--
--   never_verified
--     -> existing practical-verification-needed behavior remains
--
-- This migration preserves all existing columns used by the application
-- and appends reverification-specific fields.
-- ============================================================================


-- ============================================================================
-- PART 1 — COMPETENCY READINESS
-- ============================================================================

create or replace view v_assessment_competency_readiness as

with latest_attempts as (

  select
    v_latest_master_assessment_attempt.attempt_id,
    v_latest_master_assessment_attempt.client_id,
    v_latest_master_assessment_attempt.employee_id,
    v_latest_master_assessment_attempt.assessment_id,
    v_latest_master_assessment_attempt.started_at,
    v_latest_master_assessment_attempt.completed_at,
    v_latest_master_assessment_attempt.assessment_name,
    v_latest_master_assessment_attempt.master_role_template_id,
    v_latest_master_assessment_attempt.master_target_role_template_id,
    v_latest_master_assessment_attempt.effective_master_role_template_id

  from v_latest_master_assessment_attempt

),

practical_requirements as (

  select
    aq.assessment_id,
    aq.master_competency_template_id,
    bool_or(
      aq.practical_verification_required
    ) as practical_verification_required

  from assessment_questions aq

  where aq.master_competency_template_id is not null

  group by
    aq.assessment_id,
    aq.master_competency_template_id

),

base as (

  select

    la.attempt_id,
    la.client_id,
    la.employee_id,
    la.assessment_id,
    la.assessment_name,

    la.effective_master_role_template_id
      as master_role_template_id,

    cs.master_competency_template_id,

    mct.name
      as competency_name,

    mct.category
      as competency_category,

    mct.is_critical
      as competency_is_critical,

    cs.score_percent
      as knowledge_score_percent,

    cs.estimated_level
      as knowledge_level,

    cs.required_level,

    case
      when cs.required_level is null then false
      when cs.estimated_level >= cs.required_level then true
      else false
    end
      as knowledge_ready,

    coalesce(
      pr.practical_verification_required,
      false
    )
      as practical_verification_required,

    pv.rating_level
      as practical_rating_level,

    pv.status
      as practical_verification_status,

    pv.verified_at
      as practical_verified_at,

    mct.reverification_period_months,

    case

      when coalesce(
        pr.practical_verification_required,
        false
      ) = false
      then null

      when pv.status <> 'verified'
      then null

      when pv.verified_at is null
      then null

      when mct.reverification_period_months is null
      then null

      when mct.reverification_period_months <= 0
      then null

      else
        pv.verified_at
        +
        make_interval(
          months =>
            mct.reverification_period_months
        )

    end
      as practical_verification_expires_at

  from latest_attempts la

  join competency_scores cs
    on cs.attempt_id = la.attempt_id
   and cs.master_competency_template_id is not null

  join master_competency_templates mct
    on mct.id =
       cs.master_competency_template_id

  left join practical_requirements pr
    on pr.assessment_id =
       la.assessment_id
   and pr.master_competency_template_id =
       cs.master_competency_template_id

  left join v_latest_master_practical_verification pv
    on pv.employee_id =
       la.employee_id
   and pv.master_competency_template_id =
       cs.master_competency_template_id

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

    end
      as verification_currency_status,

    case

      when b.practical_verification_expires_at is null
      then null

      else
        floor(
          extract(
            epoch from (
              b.practical_verification_expires_at -
              now()
            )
          )
          /
          86400
        )::integer

    end
      as days_until_expiration,

    case

      when b.practical_verification_expires_at is null
      then false

      when b.practical_verification_expires_at <= now()
      then false

      when b.practical_verification_expires_at
           <= now() + interval '30 days'
      then true

      else false

    end
      as reverification_due,

    case

      when b.practical_verification_expires_at is null
      then false

      when b.practical_verification_expires_at <= now()
      then true

      else false

    end
      as verification_expired

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


  -- --------------------------------------------------------------------------
  -- Existing practical_ready column
  --
  -- Due soon remains ready.
  -- Expired does not.
  -- --------------------------------------------------------------------------

  case

    when c.practical_verification_required = false
    then true

    else coalesce(

      c.practical_verification_status = 'verified'

      and c.practical_rating_level >=
          c.required_level

      and c.verification_expired = false,

      false
    )

  end
    as practical_ready,


  -- --------------------------------------------------------------------------
  -- Existing competency_ready column
  -- --------------------------------------------------------------------------

  case

    when c.required_level is null
    then false

    when c.knowledge_level <
         c.required_level
    then false

    when c.practical_verification_required = true

      and coalesce(

        c.practical_verification_status = 'verified'

        and c.practical_rating_level >=
            c.required_level

        and c.verification_expired = false,

        false

      ) = false

    then false

    else true

  end
    as competency_ready,


  -- --------------------------------------------------------------------------
  -- Existing readiness_status column
  --
  -- Knowledge gaps remain higher priority than practical status.
  -- An expired verification becomes reverification_required.
  -- --------------------------------------------------------------------------

  case

    when c.required_level is null
    then 'not_required'

    when c.knowledge_level <
         (c.required_level - 1)
    then 'critical_gap'

    when c.knowledge_level <
         c.required_level
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
         and coalesce(
           c.practical_rating_level,
           0
         ) < c.required_level
    then 'practical_development_needed'

    else 'ready'

  end
    as readiness_status,


  -- ==========================================================================
  -- NEW REVERIFICATION COLUMNS
  -- ==========================================================================

  c.reverification_period_months,

  c.practical_verification_expires_at,

  c.days_until_expiration,

  c.reverification_due,

  c.verification_expired,

  c.verification_currency_status


from currency c;



-- ============================================================================
-- PART 2 — ROLE READINESS
--
-- Preserve the existing readiness calculation while counting expired
-- verifications as practical gaps.
-- ============================================================================

create or replace view v_assessment_role_readiness as

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
    )
      as competencies_total,


    count(*) filter (
      where acr.required_level is not null
        and acr.competency_ready = true
    )
      as competencies_ready,


    count(*) filter (
      where acr.readiness_status = 'developing'
    )
      as developing_count,


    count(*) filter (
      where acr.readiness_status = 'critical_gap'
    )
      as critical_gap_count,


    count(*) filter (
      where acr.readiness_status in (
        'practical_verification_needed',
        'practical_development_needed',
        'reverification_required'
      )
    )
      as practical_gap_count,


    round(
      avg(
        acr.knowledge_score_percent
      ),
      1
    )
      as average_knowledge_score,


    -- ------------------------------------------------------------------------
    -- New summary counters
    -- ------------------------------------------------------------------------

    count(*) filter (
      where acr.reverification_due = true
    )
      as reverification_due_count,


    count(*) filter (
      where acr.readiness_status =
            'reverification_required'
    )
      as reverification_required_count


  from v_assessment_competency_readiness acr


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

  mrt.name
    as role_name,

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

  end
    as readiness_percent,


  cs.developing_count,

  cs.critical_gap_count,

  cs.practical_gap_count,


  case

    when sr.critical_safety_score_percent is not null
         and sr.critical_safety_score_percent < 80
    then 'safety_gap'

    when cs.competencies_total > 0
         and cs.competencies_ready =
             cs.competencies_total
    then 'ready'

    when cs.critical_gap_count > 0
    then 'critical_gap'

    when cs.reverification_required_count > 0
    then 'reverification_required'

    when cs.practical_gap_count > 0
    then 'practical_verification_needed'

    else 'developing'

  end
    as readiness_status,


  -- ==========================================================================
  -- NEW ROLE-LEVEL REVERIFICATION COUNTS
  -- ==========================================================================

  cs.reverification_due_count,

  cs.reverification_required_count


from competency_summary cs


join master_role_templates mrt

  on mrt.id =
     cs.master_role_template_id


left join v_assessment_safety_readiness sr

  on sr.attempt_id =
     cs.attempt_id;



-- ============================================================================
-- PART 3 — VERIFICATION
--
-- Check Alex's Safety competency after rebuilding the views.
-- ============================================================================

select

  employee_id,

  competency_name,

  practical_rating_level,

  practical_ready,

  competency_ready,

  reverification_period_months,

  practical_verified_at,

  practical_verification_expires_at,

  days_until_expiration,

  reverification_due,

  verification_expired,

  verification_currency_status,

  readiness_status

from v_assessment_competency_readiness

where employee_id =
  '9892d84b-6d06-4727-a817-aaea9f87a558'::uuid

and competency_name =
  'Safety & Job-Site Standards';



-- ============================================================================
-- PART 4 — EMPLOYEE SUMMARY CHECK
-- ============================================================================

select

  employee_id,

  first_name,

  last_name,

  competencies_ready,

  competencies_total,

  readiness_percent,

  practical_gap_count,

  readiness_status

from v_employee_assessment_summary

where employee_id =
  '9892d84b-6d06-4727-a817-aaea9f87a558'::uuid;