-- ============================================================================
-- 0048_add_resolution_lifecycle_to_development_plan_summary.sql
--
-- Extend the Development Plan summary view with resolution lifecycle fields.
--
-- Existing columns remain unchanged and in the same order.
-- New lifecycle columns are appended so existing consumers remain compatible.
-- ============================================================================

begin;


create or replace view public.v_development_plan_summary
as

select
  dp.id
    as development_plan_id,

  dp.client_id,

  dp.employee_id,

  e.first_name,

  e.last_name,

  e.employee_number,

  dp.action_key,

  dp.action_type,

  dp.action_label,

  dp.master_competency_template_id,

  dp.competency_name_snapshot,

  dp.role_name_snapshot,

  dp.title,

  dp.description,

  dp.development_type,

  dp.status,

  dp.priority,

  dp.start_date,

  dp.due_date,

  dp.completed_at,

  dp.owner_user_id,

  dp.manager_notes,

  dp.employee_notes,

  dp.created_by_user_id,

  dp.created_at,

  dp.updated_at,

  count(dpa.id)
    as activities_total,

  count(dpa.id) filter (
    where dpa.status = 'completed'
  )
    as activities_completed,

  count(dpa.id) filter (
    where dpa.status = 'blocked'
  )
    as activities_blocked,

  case

    when count(dpa.id) = 0
      then 0::numeric

    else round(
      100.0
      * count(dpa.id) filter (
          where dpa.status = 'completed'
        )::numeric
      / count(dpa.id)::numeric,
      1
    )

  end
    as completion_percent,

  case

    when dp.status = 'completed'
      then false

    when dp.status = 'cancelled'
      then false

    when dp.due_date is null
      then false

    when dp.due_date < current_date
      then true

    else false

  end
    as overdue,


  -- --------------------------------------------------------------------------
  -- Resolution lifecycle
  -- --------------------------------------------------------------------------

  dp.resolution_status,

  dp.development_completed_at,

  dp.awaiting_evidence_since,

  dp.resolved_at,

  dp.resolution_notes


from public.development_plans dp

join public.employees e
  on e.id =
    dp.employee_id

left join public.development_plan_activities dpa
  on dpa.development_plan_id =
    dp.id


group by
  dp.id,
  dp.client_id,
  dp.employee_id,
  e.first_name,
  e.last_name,
  e.employee_number,
  dp.action_key,
  dp.action_type,
  dp.action_label,
  dp.master_competency_template_id,
  dp.competency_name_snapshot,
  dp.role_name_snapshot,
  dp.title,
  dp.description,
  dp.development_type,
  dp.status,
  dp.priority,
  dp.start_date,
  dp.due_date,
  dp.completed_at,
  dp.owner_user_id,
  dp.manager_notes,
  dp.employee_notes,
  dp.created_by_user_id,
  dp.created_at,
  dp.updated_at,
  dp.resolution_status,
  dp.development_completed_at,
  dp.awaiting_evidence_since,
  dp.resolved_at,
  dp.resolution_notes;


notify pgrst, 'reload schema';


commit;
