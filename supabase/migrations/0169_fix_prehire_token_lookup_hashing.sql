-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0169_fix_prehire_token_lookup_hashing.sql
--
-- PURPOSE
-- Fixes pre-hire invitation token lookup by explicitly calling
-- extensions.digest(), because the helper runs with search_path = public.
-- ============================================================================

create or replace function public.wri_get_prehire_invitation_by_token(
  p_token text
)
returns prehire_assessment_invitations

language plpgsql

security definer

set search_path = public

as $$

declare
  v_invitation prehire_assessment_invitations;

begin

  if p_token is null
     or btrim(p_token) = '' then

    raise exception
      'pre-hire invitation token is required';

  end if;


  select *
  into v_invitation

  from prehire_assessment_invitations

  where token_hash =
    extensions.digest(
      p_token,
      'sha256'
    )

  limit 1;


  if v_invitation is null then

    raise exception
      'invalid pre-hire invitation token';

  end if;


  if v_invitation.status = 'revoked'
     or v_invitation.revoked_at is not null then

    raise exception
      'pre-hire invitation has been revoked';

  end if;


  if v_invitation.status = 'expired'
     or v_invitation.expires_at <= now() then

    raise exception
      'pre-hire invitation has expired';

  end if;


  return v_invitation;

end;
$$;


revoke all
on function public.wri_get_prehire_invitation_by_token(text)
from public, anon, authenticated;
