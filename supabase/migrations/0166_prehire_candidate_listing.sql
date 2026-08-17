-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0166_prehire_candidate_listing.sql
--
-- PURPOSE
-- Adds the authenticated admin list RPC used by the RISE Candidates workspace.
--
-- PRINCIPLES
--   1. One row represents one pre-hire invitation / hiring cycle.
--   2. IntegrateU admins may view all authorized tenant records.
--   3. Client admins may view only their allowed client records.
--   4. Candidate-facing token/security data is never exposed.
-- ============================================================================


create or replace function public.wri_list_prehire_candidate_invitations(
  p_client_id uuid default null,
  p_candidate_status text default null,
  p_invitation_status text default null
)
returns table (
  candidate_id uuid,
  invitation_id uuid,

  client_id uuid,
  client_name text,

  industry_id uuid,
  industry_name text,

  candidate_first_name text,
  candidate_last_name text,
  candidate_email text,
  candidate_status text,

  master_role_template_id uuid,
  role_name text,

  invitation_status text,
  expires_at timestamptz,
  sent_at timestamptz,
  opened_at timestamptz,
  started_at timestamptz,
  completed_at timestamptz,
  revoked_at timestamptz,

  partial_coverage_approved boolean,

  assigned_assessment_count bigint,
  completed_assessment_count bigint,
  missing_requirement_count bigint,

  converted_employee_id uuid,
  converted_at timestamptz,

  candidate_created_at timestamptz,
  invitation_created_at timestamptz
)

language sql

stable

security definer

set search_path = public

as $$

  select
    c.id
      as candidate_id,

    inv.id
      as invitation_id,

    c.client_id,
    cl.name
      as client_name,

    c.industry_id,
    ind.name
      as industry_name,

    c.first_name
      as candidate_first_name,

    c.last_name
      as candidate_last_name,

    c.email
      as candidate_email,

    c.status
      as candidate_status,

    inv.master_role_template_id,
    mrt.name
      as role_name,

    inv.status
      as invitation_status,

    inv.expires_at,
    inv.sent_at,
    inv.opened_at,
    inv.started_at,
    inv.completed_at,
    inv.revoked_at,

    inv.partial_coverage_approved,

    (
      select count(*)::bigint
      from public.prehire_invitation_assessments pia
      where pia.invitation_id = inv.id
    )
      as assigned_assessment_count,

    (
      select count(*)::bigint
      from public.prehire_assessment_attempts paa
      where paa.invitation_id = inv.id
        and paa.status = 'completed'
    )
      as completed_assessment_count,

    (
      select count(*)::bigint
      from public.prehire_invitation_missing_requirements pmr
      where pmr.invitation_id = inv.id
    )
      as missing_requirement_count,

    c.converted_employee_id,
    c.converted_at,

    c.created_at
      as candidate_created_at,

    inv.created_at
      as invitation_created_at

  from public.prehire_assessment_invitations inv

  join public.prehire_candidates c
    on c.id = inv.candidate_id

  join public.clients cl
    on cl.id = c.client_id

  join public.industries ind
    on ind.id = c.industry_id

  join public.master_role_templates mrt
    on mrt.id = inv.master_role_template_id

  where
    (
      public.wri_is_integrateu_admin()

      or c.client_id in (
        select public.wri_allowed_client_ids()
      )
    )

    and (
      p_client_id is null
      or c.client_id = p_client_id
    )

    and (
      p_candidate_status is null
      or c.status = p_candidate_status
    )

    and (
      p_invitation_status is null
      or inv.status = p_invitation_status
    )

  order by
    inv.created_at desc,
    c.last_name,
    c.first_name,
    inv.id;

$$;


revoke all
on function public.wri_list_prehire_candidate_invitations(
  uuid,
  text,
  text
)
from public, anon;


grant execute
on function public.wri_list_prehire_candidate_invitations(
  uuid,
  text,
  text
)
to authenticated;


grant execute
on function public.wri_list_prehire_candidate_invitations(
  uuid,
  text,
  text
)
to service_role;
