-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0019_readiness_action_queue.sql
--
-- PURPOSE
--
-- Turn readiness intelligence into an actionable management queue.
--
-- ACTION TYPES
--
--   SAFETY_GAP
--   CRITICAL_KNOWLEDGE_GAP
--   KNOWLEDGE_DEVELOPMENT
--   PRACTICAL_VERIFICATION_NEEDED
--   PRACTICAL_DEVELOPMENT_NEEDED
--   REVERIFICATION_DUE_SOON
--   REVERIFICATION_REQUIRED
--
-- PRIORITY
--
--   1 = Critical
--   2 = High
--   3 = Medium
--
-- This migration does NOT modify:
--
--   v_assessment_competency_readiness
--   v_assessment_role_readiness
--   v_employee_assessment_summary
--
-- It reads from the new expiration-aware _current views.
-- ============================================================================


-- ============================================================================
-- PART 1 — READINESS ACTION QUEUE VIEW
-- ============================================================================

create or replace view v_readiness_action_queue as

with

-- ----------------------------------------------------------------------------
-- Base employee / role readiness
-- ----------------------------------------------------------------------------

role_base as (

  select

    rr.attempt_id,
    rr.client_id,
    rr.employee_id,

    e.first_name,
    e.last_name,
    e.employee_number,

    rr.assessment_id,
    rr.assessment_name,

    rr.master_role_template_id,
    rr.role_name,

    rr.average_knowledge_score,
    rr.critical_safety_score_percent,

    rr.competencies_ready,
    rr.competencies_total,
    rr.readiness_percent,

    rr.developing_count,
    rr.critical_gap_count,
    rr.practical_gap_count,

    rr.reverification_due_count,
    rr.reverification_required_count,

    rr.readiness_status

  from v_assessment_role_readiness_current rr

  join employees e
    on e.id = rr.employee_id

),


-- ----------------------------------------------------------------------------
-- Competency readiness
-- ----------------------------------------------------------------------------

competency_base as (

  select

    cr.attempt_id,
    cr.client_id,
    cr.employee_id,

    e.first_name,
    e.last_name,
    e.employee_number,

    cr.assessment_id,
    cr.assessment_name,

    cr.master_role_template_id,

    rr.role_name,

    cr.master_competency_template_id,
    cr.competency_name,
    cr.competency_category,
    cr.competency_is_critical,

    cr.knowledge_score_percent,
    cr.knowledge_level,
    cr.required_level,
    cr.knowledge_ready,

    cr.practical_verification_required,
    cr.practical_rating_level,
    cr.practical_verification_status,
    cr.practical_verified_at,
    cr.practical_ready,

    cr.competency_ready,
    cr.readiness_status,

    cr.reverification_period_months,
    cr.practical_verification_expires_at,
    cr.days_until_expiration,
    cr.reverification_due,
    cr.verification_expired,
    cr.verification_currency_status

  from v_assessment_competency_readiness_current cr

  join employees e
    on e.id = cr.employee_id

  left join v_assessment_role_readiness_current rr
    on rr.attempt_id = cr.attempt_id

),


-- ============================================================================
-- ACTION 1 — CRITICAL SAFETY GAP
-- ============================================================================

safety_actions as (

  select

    concat(
      'SAFETY_GAP:',
      rb.employee_id::text,
      ':',
      rb.attempt_id::text
    )
      as action_key,

    rb.client_id,
    rb.employee_id,

    rb.first_name,
    rb.last_name,
    rb.employee_number,

    rb.attempt_id,
    rb.assessment_id,
    rb.assessment_name,

    rb.master_role_template_id,
    rb.role_name,

    null::uuid
      as master_competency_template_id,

    null::text
      as competency_name,

    null::text
      as competency_category,

    false
      as competency_is_critical,

    'SAFETY_GAP'::text
      as action_type,

    'Critical Safety Gap'::text
      as action_label,

    1
      as priority,

    'critical'::text
      as priority_label,

    concat(
      'Critical safety score is ',
      coalesce(
        rb.critical_safety_score_percent::text,
        'not available'
      ),
      '%. Required threshold is 80%.'
    )
      as action_detail,

    null::timestamptz
      as due_at,

    null::integer
      as days_until_due,

    rb.readiness_percent,

    rb.critical_safety_score_percent,

    null::numeric
      as knowledge_score_percent,

    null::integer
      as knowledge_level,

    null::integer
      as required_level,

    null::integer
      as practical_rating_level,

    null::text
      as practical_verification_status,

    null::timestamptz
      as practical_verified_at,

    null::integer
      as reverification_period_months,

    null::text
      as verification_currency_status

  from role_base rb

  where rb.critical_safety_score_percent is not null

    and rb.critical_safety_score_percent < 80

),


-- ============================================================================
-- ACTION 2 — CRITICAL KNOWLEDGE GAP
-- ============================================================================

critical_knowledge_actions as (

  select

    concat(
      'CRITICAL_KNOWLEDGE_GAP:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'CRITICAL_KNOWLEDGE_GAP'::text
      as action_type,

    'Critical Knowledge Gap'::text
      as action_label,

    1
      as priority,

    'critical'::text
      as priority_label,

    concat(
      'Knowledge level ',
      coalesce(
        cb.knowledge_level::text,
        '0'
      ),
      ' is below required Level ',
      coalesce(
        cb.required_level::text,
        '—'
      ),
      '.'
    )
      as action_detail,

    null::timestamptz
      as due_at,

    null::integer
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.readiness_status =
        'critical_gap'

),


-- ============================================================================
-- ACTION 3 — KNOWLEDGE DEVELOPMENT
-- ============================================================================

knowledge_development_actions as (

  select

    concat(
      'KNOWLEDGE_DEVELOPMENT:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'KNOWLEDGE_DEVELOPMENT'::text
      as action_type,

    'Knowledge Development Needed'::text
      as action_label,

    3
      as priority,

    'medium'::text
      as priority_label,

    concat(
      'Knowledge Level ',
      coalesce(
        cb.knowledge_level::text,
        '0'
      ),
      ' does not yet meet required Level ',
      coalesce(
        cb.required_level::text,
        '—'
      ),
      '.'
    )
      as action_detail,

    null::timestamptz
      as due_at,

    null::integer
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.readiness_status =
        'developing'

),


-- ============================================================================
-- ACTION 4 — PRACTICAL VERIFICATION NEEDED
-- ============================================================================

practical_verification_actions as (

  select

    concat(
      'PRACTICAL_VERIFICATION_NEEDED:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'PRACTICAL_VERIFICATION_NEEDED'::text
      as action_type,

    'Practical Verification Needed'::text
      as action_label,

    2
      as priority,

    'high'::text
      as priority_label,

    'Knowledge requirement has been met, but practical verification is still required.'::text
      as action_detail,

    null::timestamptz
      as due_at,

    null::integer
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.readiness_status =
        'practical_verification_needed'

),


-- ============================================================================
-- ACTION 5 — PRACTICAL DEVELOPMENT NEEDED
-- ============================================================================

practical_development_actions as (

  select

    concat(
      'PRACTICAL_DEVELOPMENT_NEEDED:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'PRACTICAL_DEVELOPMENT_NEEDED'::text
      as action_type,

    'Practical Development Needed'::text
      as action_label,

    2
      as priority,

    'high'::text
      as priority_label,

    concat(
      'Practical rating Level ',
      coalesce(
        cb.practical_rating_level::text,
        '0'
      ),
      ' is below required Level ',
      coalesce(
        cb.required_level::text,
        '—'
      ),
      '.'
    )
      as action_detail,

    null::timestamptz
      as due_at,

    null::integer
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.readiness_status =
        'practical_development_needed'

),


-- ============================================================================
-- ACTION 6 — REVERIFICATION DUE SOON
-- ============================================================================

reverification_due_actions as (

  select

    concat(
      'REVERIFICATION_DUE_SOON:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'REVERIFICATION_DUE_SOON'::text
      as action_type,

    'Reverification Due Soon'::text
      as action_label,

    2
      as priority,

    'high'::text
      as priority_label,

    concat(
      'Practical verification expires in ',
      coalesce(
        cb.days_until_expiration::text,
        '—'
      ),
      ' days.'
    )
      as action_detail,

    cb.practical_verification_expires_at
      as due_at,

    cb.days_until_expiration
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.reverification_due = true

    and cb.verification_expired = false

),


-- ============================================================================
-- ACTION 7 — REVERIFICATION REQUIRED
-- ============================================================================

reverification_required_actions as (

  select

    concat(
      'REVERIFICATION_REQUIRED:',
      cb.employee_id::text,
      ':',
      cb.master_competency_template_id::text
    )
      as action_key,

    cb.client_id,
    cb.employee_id,

    cb.first_name,
    cb.last_name,
    cb.employee_number,

    cb.attempt_id,
    cb.assessment_id,
    cb.assessment_name,

    cb.master_role_template_id,
    cb.role_name,

    cb.master_competency_template_id,
    cb.competency_name,
    cb.competency_category,
    cb.competency_is_critical,

    'REVERIFICATION_REQUIRED'::text
      as action_type,

    'Reverification Required'::text
      as action_label,

    1
      as priority,

    'critical'::text
      as priority_label,

    concat(
      'Practical verification expired ',
      abs(
        coalesce(
          cb.days_until_expiration,
          0
        )
      ),
      ' days ago.'
    )
      as action_detail,

    cb.practical_verification_expires_at
      as due_at,

    cb.days_until_expiration
      as days_until_due,

    null::numeric
      as readiness_percent,

    null::numeric
      as critical_safety_score_percent,

    cb.knowledge_score_percent,

    cb.knowledge_level,

    cb.required_level,

    cb.practical_rating_level,

    cb.practical_verification_status,

    cb.practical_verified_at,

    cb.reverification_period_months,

    cb.verification_currency_status

  from competency_base cb

  where cb.verification_expired = true

)


-- ============================================================================
-- FINAL ACTION QUEUE
-- ============================================================================

select * from safety_actions

union all

select * from critical_knowledge_actions

union all

select * from knowledge_development_actions

union all

select * from practical_verification_actions

union all

select * from practical_development_actions

union all

select * from reverification_due_actions

union all

select * from reverification_required_actions;



-- ============================================================================
-- PART 2 — PERMISSION-AWARE ACTION QUEUE RPC
--
-- IntegrateU Admin:
--   sees all actions
--
-- Client Admin:
--   sees employees in allowed clients
--
-- Dedicated Practical Verifier:
--   sees employees they are authorized to verify
--
-- Regular employee:
--   does not receive the management action queue
-- ============================================================================

create or replace function wri_list_readiness_actions(
  p_client_id uuid default null,
  p_employee_id uuid default null,
  p_action_type text default null,
  p_priority integer default null
)
returns setof v_readiness_action_queue
language sql
stable
security definer
set search_path = public
as $$

  select q.*

  from v_readiness_action_queue q

  where

    (
      wri_is_integrateu_admin()

      or q.client_id in (
        select wri_allowed_client_ids()
      )

      or wri_can_verify_master_practical(
        q.employee_id
      )
    )

    and (
      p_client_id is null
      or q.client_id = p_client_id
    )

    and (
      p_employee_id is null
      or q.employee_id = p_employee_id
    )

    and (
      p_action_type is null
      or q.action_type = p_action_type
    )

    and (
      p_priority is null
      or q.priority = p_priority
    )

  order by

    q.priority asc,

    case
      when q.due_at is null then 1
      else 0
    end asc,

    q.due_at asc nulls last,

    q.last_name asc,

    q.first_name asc,

    q.competency_name asc nulls last;

$$;



-- ============================================================================
-- SECURITY
-- ============================================================================

revoke all
on function wri_list_readiness_actions(
  uuid,
  uuid,
  text,
  integer
)
from public, anon;


grant execute
on function wri_list_readiness_actions(
  uuid,
  uuid,
  text,
  integer
)
to authenticated;



-- ============================================================================
-- TEST 1 — VIEW EXISTS
-- ============================================================================

select table_name
from information_schema.views
where table_schema = 'public'
  and table_name =
      'v_readiness_action_queue';



-- ============================================================================
-- TEST 2 — RPC EXISTS
-- ============================================================================

select routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name =
      'wri_list_readiness_actions';



-- ============================================================================
-- TEST 3 — ALEX ACTIONS
--
-- Run while logged in through the application when testing the RPC.
-- For SQL Editor inspection, the underlying view can be queried directly.
-- ============================================================================

select

  priority,
  priority_label,

  action_type,
  action_label,

  first_name,
  last_name,

  role_name,

  competency_name,

  action_detail,

  due_at,
  days_until_due

from v_readiness_action_queue

where employee_id =
  '9892d84b-6d06-4727-a817-aaea9f87a558'::uuid

order by
  priority,
  action_type,
  competency_name;