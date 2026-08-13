-- ============================================================================
-- 0050_workforce_readiness_matrix.sql
--
-- Authoritative management-facing workforce readiness dataset.
--
-- Access:
--   IntegrateU Admin → all employees
--   Client Admin     → employees in allowed client(s)
--   Other users      → no company-wide workforce rows
--
-- Readiness truth comes from:
--   v_assessment_role_readiness_current
--   v_assessment_competency_readiness_current
--
-- Development lifecycle remains separate from current readiness.
-- ============================================================================


create or replace function public.wri_list_workforce_readiness()
returns table (
  employee_id uuid,
  client_id uuid,
  first_name text,
  last_name text,
  employee_number text,

  assessment_id uuid,
  assessment_name text,
  master_role_template_id uuid,
  role_name text,

  average_knowledge_score numeric,
  critical_safety_score_percent numeric,

  competencies_ready bigint,
  competencies_total bigint,
  readiness_percent numeric,

  developing_count bigint,
  critical_gap_count bigint,
  practical_gap_count bigint,

  reverification_due_count bigint,
  reverification_required_count bigint,

  readiness_status text,

  knowledge_ready_count bigint,
  knowledge_total_count bigint,

  practical_ready_count bigint,
  practical_total_count bigint,

  current_gap_count bigint,

  open_plan_count bigint,
  awaiting_evidence_count bigint
)
language sql
stable
security definer
set search_path = public
as $function$

with authorized_employees as (

  select
    e.id,
    e.client_id,
    e.first_name,
    e.last_name,
    e.employee_number

  from public.employees e

  where
    public.wri_is_integrateu_admin()

    or e.client_id in (
      select public.wri_allowed_client_ids()
    )
),

competency_summary as (

  select
    acr.employee_id,

    count(*) filter (
      where acr.knowledge_ready = true
    )::bigint
      as knowledge_ready_count,

    count(*)::bigint
      as knowledge_total_count,

    count(*) filter (
      where
        acr.practical_verification_required = true
        and acr.practical_ready = true
    )::bigint
      as practical_ready_count,

    count(*) filter (
      where acr.practical_verification_required = true
    )::bigint
      as practical_total_count,

    count(*) filter (
      where acr.competency_ready = false
    )::bigint
      as current_gap_count

  from public.v_assessment_competency_readiness_current acr

  group by
    acr.employee_id
),

plan_summary as (

  select
    dpr.employee_id,

    count(*) filter (
      where dpr.resolution_status not in (
        'resolved',
        'cancelled'
      )
    )::bigint
      as open_plan_count,

    count(*) filter (
      where dpr.resolution_status in (
        'awaiting_reassessment',
        'awaiting_verification',
        'awaiting_reverification'
      )
    )::bigint
      as awaiting_evidence_count

  from public.v_development_plan_resolution dpr

  group by
    dpr.employee_id
)

select
  ae.id
    as employee_id,

  ae.client_id,
  ae.first_name,
  ae.last_name,
  ae.employee_number,

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

  rr.readiness_status,

  coalesce(
    cs.knowledge_ready_count,
    0
  )::bigint
    as knowledge_ready_count,

  coalesce(
    cs.knowledge_total_count,
    0
  )::bigint
    as knowledge_total_count,

  coalesce(
    cs.practical_ready_count,
    0
  )::bigint
    as practical_ready_count,

  coalesce(
    cs.practical_total_count,
    0
  )::bigint
    as practical_total_count,

  coalesce(
    cs.current_gap_count,
    0
  )::bigint
    as current_gap_count,

  coalesce(
    ps.open_plan_count,
    0
  )::bigint
    as open_plan_count,

  coalesce(
    ps.awaiting_evidence_count,
    0
  )::bigint
    as awaiting_evidence_count

from authorized_employees ae

left join
  public.v_assessment_role_readiness_current rr
    on rr.employee_id = ae.id

left join competency_summary cs
  on cs.employee_id = ae.id

left join plan_summary ps
  on ps.employee_id = ae.id

order by
  ae.last_name,
  ae.first_name,
  ae.id;

$function$;


revoke all
on function public.wri_list_workforce_readiness()
from public, anon;


grant execute
on function public.wri_list_workforce_readiness()
to authenticated;


comment on function public.wri_list_workforce_readiness()
is
'Authorization-aware company workforce readiness matrix combining current assessment readiness with unresolved Development Plan lifecycle counts.';
