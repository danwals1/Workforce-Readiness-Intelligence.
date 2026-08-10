create or replace view public.v_development_plan_practical_evidence
as

select
  dp.id as development_plan_id,
  dp.client_id,
  dp.employee_id,
  dp.master_competency_template_id,
  dp.competency_name_snapshot,
  dp.action_type,
  dp.status as plan_status,
  dp.resolution_status,
  dp.resolved_at,

  acr.required_level,

  pv.id as verification_id,
  pv.rating_level as verified_level,
  pv.status as verification_status,
  pv.verified_by,
  pv.verified_at,
  pv.notes,

  case
    when pv.status = 'verified'
      and acr.required_level is not null
      and pv.rating_level >= acr.required_level
    then true
    else false
  end as verification_satisfied

from development_plans dp

left join v_assessment_competency_readiness_current acr
  on acr.employee_id = dp.employee_id
 and acr.master_competency_template_id =
      dp.master_competency_template_id

left join v_latest_master_practical_verification pv
  on pv.employee_id = dp.employee_id
 and pv.master_competency_template_id =
      dp.master_competency_template_id

where dp.action_type in (
  'PRACTICAL_VERIFICATION_NEEDED',
  'PRACTICAL_DEVELOPMENT_NEEDED',
  'REVERIFICATION_DUE_SOON',
  'REVERIFICATION_REQUIRED'
);
