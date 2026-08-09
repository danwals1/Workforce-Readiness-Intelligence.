-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0009_fix_assessment_readiness_calculation.sql
--
-- PURPOSE
-- Fixes competency readiness when practical verification is required.
--
-- BUG
-- In 0008, this expression was used:
--
--   not (
--     pv.status = 'verified'
--     and pv.rating_level >= cs.required_level
--   )
--
-- When no practical verification existed, pv.status and pv.rating_level
-- were NULL. PostgreSQL three-valued boolean logic caused:
--
--   NOT (NULL) = NULL
--
-- A CASE WHEN condition of NULL is not TRUE, so execution fell through
-- to ELSE TRUE. This incorrectly marked competencies as ready even though
-- practical verification was still outstanding.
--
-- FIX
-- Explicitly COALESCE the practical-verification test to FALSE.
--
-- Result:
--   practical verification required + no valid verification
--   = competency_ready FALSE
--
-- The legacy role_readiness table remains untouched.
-- ============================================================================


create or replace view v_assessment_competency_readiness

with (
  security_invoker = true
)

as

with latest_attempts as (

  select *

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


  where aq.master_competency_template_id
    is not null


  group by

    aq.assessment_id,

    aq.master_competency_template_id

)

select

  la.attempt_id,

  la.client_id,

  la.employee_id,

  la.assessment_id,

  la.assessment_name,

  la.effective_master_role_template_id
    as master_role_template_id,


  cs.master_competency_template_id,


  mct.name as competency_name,

  mct.category as competency_category,

  mct.is_critical as competency_is_critical,


  cs.score_percent
    as knowledge_score_percent,

  cs.estimated_level
    as knowledge_level,

  cs.required_level,


  -- --------------------------------------------------------------------------
  -- KNOWLEDGE READY
  -- --------------------------------------------------------------------------

  case

    when cs.required_level is null
      then false

    when cs.estimated_level >=
         cs.required_level
      then true

    else false

  end as knowledge_ready,


  -- --------------------------------------------------------------------------
  -- PRACTICAL REQUIREMENT
  -- --------------------------------------------------------------------------

  coalesce(
    pr.practical_verification_required,
    false
  ) as practical_verification_required,


  pv.rating_level
    as practical_rating_level,

  pv.status
    as practical_verification_status,

  pv.verified_at
    as practical_verified_at,


  -- --------------------------------------------------------------------------
  -- PRACTICAL READY
  --
  -- Competencies that do not require practical verification automatically
  -- satisfy this portion.
  --
  -- When verification IS required, NULL must evaluate to FALSE.
  -- --------------------------------------------------------------------------

  case

    when coalesce(
      pr.practical_verification_required,
      false
    ) = false

      then true


    else coalesce(

      (
        pv.status = 'verified'

        and pv.rating_level >=
            cs.required_level
      ),

      false

    )

  end as practical_ready,


  -- --------------------------------------------------------------------------
  -- COMPETENCY READY
  --
  -- Must satisfy BOTH:
  --
  --   knowledge requirement
  --   practical requirement, when applicable
  -- --------------------------------------------------------------------------

  case

    when cs.required_level is null
      then false


    when cs.estimated_level <
         cs.required_level
      then false


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and coalesce(

        (
          pv.status = 'verified'

          and pv.rating_level >=
              cs.required_level
        ),

        false

      ) = false

      then false


    else true

  end as competency_ready,


  -- --------------------------------------------------------------------------
  -- READINESS STATUS
  -- --------------------------------------------------------------------------

  case

    when cs.required_level is null
      then 'not_required'


    when cs.estimated_level <
         cs.required_level - 1
      then 'critical_gap'


    when cs.estimated_level <
         cs.required_level
      then 'developing'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and pv.status is null

      then 'practical_verification_needed'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and pv.status <> 'verified'

      then 'practical_verification_needed'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and coalesce(
        pv.rating_level,
        0
      ) < cs.required_level

      then 'practical_development_needed'


    else 'ready'

  end as readiness_status


from latest_attempts la


join competency_scores cs

  on cs.attempt_id =
     la.attempt_id

 and cs.master_competency_template_id
     is not null


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
     cs.master_competency_template_id;



-- ============================================================================
-- VERIFICATION 1 — COMPETENCY DETAIL
-- ============================================================================

select

  employee_id,

  competency_name,

  knowledge_score_percent,

  knowledge_level,

  required_level,

  knowledge_ready,

  practical_verification_required,

  practical_rating_level,

  practical_verification_status,

  practical_ready,

  competency_ready,

  readiness_status

from v_assessment_competency_readiness

order by
  employee_id,
  competency_name;



-- ============================================================================
-- VERIFICATION 2 — ROLE SUMMARY
--
-- v_assessment_role_readiness and v_employee_assessment_summary automatically
-- consume the corrected competency view above.
-- ============================================================================

select

  employee_id,

  first_name,

  last_name,

  role_name,

  average_knowledge_score,

  critical_safety_score_percent,

  competencies_ready,

  competencies_total,

  readiness_percent,

  developing_count,

  critical_gap_count,

  practical_gap_count,

  readiness_status

from v_employee_assessment_summary

order by completed_at desc;