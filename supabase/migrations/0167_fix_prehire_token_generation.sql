-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0167_fix_prehire_token_generation.sql
--
-- PURPOSE
-- Fixes pre-hire invitation token generation by explicitly calling
-- extensions.gen_random_bytes(), because the pre-hire RPC runs with
-- search_path = public.
-- ============================================================================


create or replace function public.wri_create_prehire_invitation(
  p_client_id uuid,
  p_industry_id uuid,
  p_first_name text,
  p_last_name text,
  p_email text,
  p_master_role_template_id uuid,
  p_expires_at timestamptz,
  p_allow_partial_coverage boolean default false
)
returns table (
  candidate_id uuid,
  invitation_id uuid,
  raw_token text,
  assigned_assessment_count integer,
  missing_requirement_count integer
)

language plpgsql

security definer

set search_path = public

as $function$

declare
  v_candidate_id uuid;
  v_candidate_converted_employee_id uuid;

  v_invitation_id uuid;
  v_raw_token text;

  v_role master_role_templates;

  v_assigned_count integer := 0;
  v_missing_count integer := 0;

begin

  if not (
    wri_is_integrateu_admin()

    or p_client_id in (
      select wri_allowed_client_ids()
    )
  ) then

    raise exception
      'not authorized to create a pre-hire invitation for client %',
      p_client_id;

  end if;


  if p_client_id is null then
    raise exception
      'client is required';
  end if;


  if p_industry_id is null then
    raise exception
      'industry is required';
  end if;


  if nullif(trim(p_first_name), '') is null then
    raise exception
      'candidate first name is required';
  end if;


  if nullif(trim(p_last_name), '') is null then
    raise exception
      'candidate last name is required';
  end if;


  if nullif(trim(p_email), '') is null then
    raise exception
      'candidate email is required';
  end if;


  if p_master_role_template_id is null then
    raise exception
      'Master role is required';
  end if;


  if p_expires_at is null
     or p_expires_at <= now() then

    raise exception
      'invitation expiration must be in the future';

  end if;


  select *
  into v_role

  from master_role_templates

  where id = p_master_role_template_id;


  if v_role is null then

    raise exception
      'Master role % not found',
      p_master_role_template_id;

  end if;


  if not v_role.is_current then

    raise exception
      'Master role % is not the current published version',
      p_master_role_template_id;

  end if;


  if v_role.status <> 'active' then

    raise exception
      'Master role % is not active',
      p_master_role_template_id;

  end if;


  if v_role.industry_id <> p_industry_id then

    raise exception
      'Master role % does not belong to industry %',
      p_master_role_template_id,
      p_industry_id;

  end if;


  if exists (

    select 1

    from employees e

    where e.client_id =
      p_client_id

      and e.email is not null

      and lower(trim(e.email)) =
        lower(trim(p_email))

  ) then

    raise exception
      'this person is already an employee of the selected company';

  end if;


  insert into prehire_candidates (
    client_id,
    industry_id,
    first_name,
    last_name,
    email,
    status,
    created_by
  )

  values (
    p_client_id,
    p_industry_id,
    trim(p_first_name),
    trim(p_last_name),
    lower(trim(p_email)),
    'candidate',
    auth.uid()
  )

  on conflict (
    client_id,
    industry_id,
    (lower(email))
  )

  do update

  set
    first_name = excluded.first_name,
    last_name = excluded.last_name,
    email = excluded.email

  returning
    id,
    converted_employee_id
  into
    v_candidate_id,
    v_candidate_converted_employee_id;


  if v_candidate_converted_employee_id is not null then

    raise exception
      'candidate % has already been converted to employee %',
      v_candidate_id,
      v_candidate_converted_employee_id;

  end if;


  v_raw_token :=
    encode(
      extensions.gen_random_bytes(32),
      'hex'
    );


  insert into prehire_assessment_invitations (
    candidate_id,
    client_id,
    master_role_template_id,
    token_hash,
    status,
    expires_at,
    created_by
  )

  values (
    v_candidate_id,
    p_client_id,
    p_master_role_template_id,
    digest(
      v_raw_token,
      'sha256'
    ),
    'pending',
    p_expires_at,
    auth.uid()
  )

  returning id
  into v_invitation_id;


  update prehire_candidates

  set status =
    case

      when exists (

        select 1

        from prehire_assessment_invitations other_invitation

        where other_invitation.candidate_id =
            v_candidate_id

          and other_invitation.id <>
            v_invitation_id

          and other_invitation.status =
            'in_progress'

      ) then
        'assessment_in_progress'

      else
        'candidate'

    end

  where id =
      v_candidate_id

    and converted_employee_id
      is null;


  insert into prehire_invitation_assessments (
    invitation_id,
    assessment_id,
    assessment_order
  )

  select
    v_invitation_id,
    a.id,

    row_number() over (
      order by
        mct.name,
        mrcr.required_level,
        a.id
    )::integer

  from master_role_competency_requirements mrcr

  join master_competency_templates mct
    on mct.id =
      mrcr.master_competency_template_id

  join assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.industry_id = p_industry_id
   and a.master_competency_template_id =
       mrcr.master_competency_template_id
   and a.target_level =
       mrcr.required_level

  where mrcr.master_role_template_id =
    p_master_role_template_id;


  get diagnostics
    v_assigned_count = row_count;


  insert into prehire_invitation_missing_requirements (
    invitation_id,
    master_competency_template_id,
    required_level
  )

  select
    v_invitation_id,
    mrcr.master_competency_template_id,
    mrcr.required_level

  from master_role_competency_requirements mrcr

  left join assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.industry_id = p_industry_id
   and a.master_competency_template_id =
       mrcr.master_competency_template_id
   and a.target_level =
       mrcr.required_level

  where mrcr.master_role_template_id =
      p_master_role_template_id

    and a.id is null;


  get diagnostics
    v_missing_count = row_count;


  if v_missing_count > 0 then

    if not coalesce(
      p_allow_partial_coverage,
      false
    ) then

      raise exception
        'selected role has % required competency levels without current assessments',
        v_missing_count;

    end if;


    update prehire_assessment_invitations

    set
      partial_coverage_approved = true,
      partial_coverage_approved_by = auth.uid(),
      partial_coverage_approved_at = now()

    where id = v_invitation_id;

  end if;


  if v_assigned_count = 0 then

    raise exception
      'selected role has no available pre-hire assessments';

  end if;


  return query

  select
    v_candidate_id,
    v_invitation_id,
    v_raw_token,
    v_assigned_count,
    v_missing_count;

end;

$function$;


revoke all
on function public.wri_create_prehire_invitation(
  uuid,
  uuid,
  text,
  text,
  text,
  uuid,
  timestamptz,
  boolean
)
from public, anon;


grant execute
on function public.wri_create_prehire_invitation(
  uuid,
  uuid,
  text,
  text,
  text,
  uuid,
  timestamptz,
  boolean
)
to authenticated;


grant execute
on function public.wri_create_prehire_invitation(
  uuid,
  uuid,
  text,
  text,
  text,
  uuid,
  timestamptz,
  boolean
)
to service_role;
