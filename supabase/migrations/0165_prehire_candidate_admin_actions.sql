-- ============================================================================
-- 0165 — PRE-HIRE CANDIDATE ADMIN ACTIONS
-- ============================================================================
--
-- Adds controlled admin workflows for:
--
--   1. Revoking an unfinished pre-hire invitation.
--   2. Marking a candidate as not hired or withdrawn.
--
-- Direct authenticated mutations of the pre-hire workflow tables remain
-- blocked. These SECURITY DEFINER RPCs are the approved mutation paths.
-- ============================================================================


-- ============================================================================
-- PART 1 — REVOKE PRE-HIRE INVITATION
-- ============================================================================

create or replace function public.wri_revoke_prehire_invitation(
  p_invitation_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_invitation prehire_assessment_invitations;
  v_candidate prehire_candidates;

begin

  if p_invitation_id is null then

    raise exception
      'pre-hire invitation is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where id =
    p_invitation_id

  for update;


  if v_invitation.id is null then

    raise exception
      'pre-hire invitation % not found',
      p_invitation_id;

  end if;


  if not (
    wri_is_integrateu_admin()

    or v_invitation.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to revoke this pre-hire invitation';

  end if;


  if v_invitation.status = 'revoked' then

    return;

  end if;


  if v_invitation.status = 'completed' then

    raise exception
      'completed pre-hire invitations cannot be revoked';

  end if;


  select *
  into v_candidate

  from prehire_candidates

  where id =
    v_invitation.candidate_id

  for update;


  if v_candidate.id is null then

    raise exception
      'pre-hire candidate % not found',
      v_invitation.candidate_id;

  end if;


  if v_candidate.converted_employee_id is not null
     or v_candidate.status = 'hired' then

    raise exception
      'candidate has already been converted to an employee';

  end if;


  update prehire_assessment_attempts

  set status =
    'abandoned'

  where invitation_id =
      v_invitation.id

    and status in (
      'not_started',
      'in_progress'
    );


  update prehire_assessment_invitations

  set
    status = 'revoked',
    revoked_at = coalesce(
      revoked_at,
      now()
    )

  where id =
    v_invitation.id;


  if v_candidate.status not in (
    'not_hired',
    'withdrawn'
  ) then

    update prehire_candidates

    set status =
      case

        when exists (

          select 1

          from prehire_assessment_invitations other_invitation

          where other_invitation.candidate_id =
              v_candidate.id

            and other_invitation.id <>
              v_invitation.id

            and other_invitation.status in (
              'pending',
              'sent',
              'opened',
              'in_progress'
            )

        ) then
          'assessment_in_progress'


        when exists (

          select 1

          from prehire_assessment_invitations completed_invitation

          where completed_invitation.candidate_id =
              v_candidate.id

            and completed_invitation.status =
              'completed'

        ) then
          'assessment_completed'


        else
          'candidate'

      end

    where id =
      v_candidate.id

      and converted_employee_id is null;

  end if;

end;
$$;


revoke all
on function public.wri_revoke_prehire_invitation(uuid)
from public, anon;

grant execute
on function public.wri_revoke_prehire_invitation(uuid)
to authenticated;


-- ============================================================================
-- PART 2 — SET CANDIDATE TERMINAL DISPOSITION
-- ============================================================================

create or replace function public.wri_set_prehire_candidate_disposition(
  p_candidate_id uuid,
  p_disposition text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_candidate prehire_candidates;
  v_disposition text;

begin

  if p_candidate_id is null then

    raise exception
      'pre-hire candidate is required';

  end if;


  v_disposition :=
    lower(
      btrim(
        coalesce(
          p_disposition,
          ''
        )
      )
    );


  if v_disposition not in (
    'not_hired',
    'withdrawn'
  ) then

    raise exception
      'pre-hire disposition must be not_hired or withdrawn';

  end if;


  select *
  into v_candidate

  from prehire_candidates

  where id =
    p_candidate_id

  for update;


  if v_candidate.id is null then

    raise exception
      'pre-hire candidate % not found',
      p_candidate_id;

  end if;


  if not (
    wri_is_integrateu_admin()

    or v_candidate.client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to update this pre-hire candidate';

  end if;


  if v_candidate.converted_employee_id is not null
     or v_candidate.status = 'hired' then

    raise exception
      'candidate has already been converted to an employee';

  end if;


  if v_candidate.status in (
    'not_hired',
    'withdrawn'
  ) then

    if v_candidate.status = v_disposition then
      return;
    end if;

    raise exception
      'candidate already has terminal disposition %',
      v_candidate.status;

  end if;


  update prehire_assessment_attempts

  set status =
    'abandoned'

  where candidate_id =
      v_candidate.id

    and status in (
      'not_started',
      'in_progress'
    );


  update prehire_assessment_invitations

  set
    status = 'revoked',
    revoked_at = coalesce(
      revoked_at,
      now()
    )

  where candidate_id =
      v_candidate.id

    and status in (
      'pending',
      'sent',
      'opened',
      'in_progress',
      'expired'
    );


  update prehire_candidates

  set status =
    v_disposition

  where id =
    v_candidate.id

    and converted_employee_id is null;

end;
$$;


revoke all
on function public.wri_set_prehire_candidate_disposition(uuid, text)
from public, anon;

grant execute
on function public.wri_set_prehire_candidate_disposition(uuid, text)
to authenticated;
