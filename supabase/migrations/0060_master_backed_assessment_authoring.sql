-- ============================================================================
-- 0060_master_backed_assessment_authoring.sql
--
-- Purpose
-- -------
-- Ensure questions authored from the Assessment Library originate in the
-- reusable Master Question Bank instead of being inserted directly into
-- assessment_questions.
--
-- Flow:
--
-- Admin authors question
--   -> Master Question Bank
--   -> secure Master answer key
--   -> optional role applicability
--   -> existing wri_add_master_question_to_assessment()
--   -> assessment-specific snapshot
--   -> source_master_question_id preserved
-- ============================================================================


create or replace function
public.wri_create_master_backed_assessment_question(
  p_assessment_id uuid,
  p_master_competency_template_id uuid,
  p_domain text,
  p_type text,
  p_difficulty text,
  p_prompt text,
  p_options jsonb,
  p_correct_answer jsonb,
  p_scenario text default null,
  p_image_url text default null,
  p_points numeric default 1,
  p_sort_order integer default 0,
  p_critical_safety boolean default false,
  p_practical_verification_required boolean default false
)
returns uuid

language plpgsql

security definer

set search_path = public

as $function$

declare

  v_assessment
    public.assessments%rowtype;

  v_competency
    public.master_competency_templates%rowtype;

  v_master_question_id uuid;

  v_assessment_question_id uuid;

begin

  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not public.wri_is_integrateu_admin() then

    raise exception
      'not authorized to author Master Questions';

  end if;


  -- --------------------------------------------------------------------------
  -- Assessment
  -- --------------------------------------------------------------------------

  select *
  into v_assessment

  from public.assessments

  where id =
    p_assessment_id;


  if not found then

    raise exception
      'assessment % not found',
      p_assessment_id;

  end if;


  if v_assessment.client_id
    is not null
  then

    raise exception
      'Master-backed questions may only be authored on template assessments';

  end if;


  if not v_assessment.is_current then

    raise exception
      'questions may only be authored on the current assessment version';

  end if;


  -- --------------------------------------------------------------------------
  -- Competency
  -- --------------------------------------------------------------------------

  select *
  into v_competency

  from public.master_competency_templates

  where id =
    p_master_competency_template_id;


  if not found then

    raise exception
      'master competency template % not found',
      p_master_competency_template_id;

  end if;


  if not v_competency.is_current then

    raise exception
      'questions may only target a current master competency template';

  end if;


  if v_competency.industry_id
    is distinct from
      v_assessment.industry_id
  then

    raise exception
      'competency and assessment industry do not match';

  end if;


  -- --------------------------------------------------------------------------
  -- Required authoring values
  -- --------------------------------------------------------------------------

  if nullif(trim(p_domain), '')
    is null
  then

    raise exception
      'question domain is required';

  end if;


  if nullif(trim(p_prompt), '')
    is null
  then

    raise exception
      'question prompt is required';

  end if;


  if p_options is null
    or jsonb_typeof(p_options) <> 'array'
    or jsonb_array_length(p_options) < 2
  then

    raise exception
      'question must contain at least two answer options';

  end if;


  if p_correct_answer is null then

    raise exception
      'question answer key is required';

  end if;


  -- --------------------------------------------------------------------------
  -- Create approved Master Question.
  --
  -- Assessment Library authoring is an IntegrateU-admin publishing workflow,
  -- so questions authored here are immediately approved/current.
  -- --------------------------------------------------------------------------

  insert into public.master_question_bank (

    industry_id,

    master_competency_template_id,

    domain,

    type,

    difficulty,

    prompt,

    scenario,

    image_url,

    options,

    points,

    critical_safety,

    practical_verification_required,

    status,

    version,

    is_current,

    published_at,

    published_by

  )

  values (

    v_assessment.industry_id,

    p_master_competency_template_id,

    trim(p_domain),

    p_type,

    p_difficulty,

    trim(p_prompt),

    nullif(trim(p_scenario), ''),

    nullif(trim(p_image_url), ''),

    p_options,

    coalesce(p_points, 1),

    coalesce(
      p_critical_safety,
      false
    ),

    coalesce(
      p_practical_verification_required,
      false
    ),

    'approved',

    1,

    true,

    now(),

    auth.uid()

  )

  returning id
  into v_master_question_id;


  -- --------------------------------------------------------------------------
  -- Master answer key
  -- --------------------------------------------------------------------------

  insert into
  public.master_question_answer_keys (

    master_question_id,

    correct_answer

  )

  values (

    v_master_question_id,

    p_correct_answer

  );


  -- --------------------------------------------------------------------------
  -- Role applicability.
  --
  -- Initial/role assessments use master_role_template_id.
  -- Role qualification assessments may additionally identify a target role.
  -- Competency assessments may intentionally have no role applicability.
  -- --------------------------------------------------------------------------

  if v_assessment.master_role_template_id
    is not null
  then

    insert into
    public.master_question_role_applicability (

      master_question_id,

      master_role_template_id

    )

    values (

      v_master_question_id,

      v_assessment.master_role_template_id

    )

    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

  end if;


  if v_assessment.master_target_role_template_id
    is not null

    and v_assessment.master_target_role_template_id
      is distinct from
        v_assessment.master_role_template_id

  then

    insert into
    public.master_question_role_applicability (

      master_question_id,

      master_role_template_id

    )

    values (

      v_master_question_id,

      v_assessment.master_target_role_template_id

    )

    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

  end if;


  -- --------------------------------------------------------------------------
  -- Create stable assessment snapshot using the existing canonical copier.
  -- This copies both question content and the secure answer key.
  -- --------------------------------------------------------------------------

  v_assessment_question_id :=
    public.wri_add_master_question_to_assessment(
      p_assessment_id,
      v_master_question_id,
      coalesce(
        p_sort_order,
        0
      )
    );


  return
    v_assessment_question_id;

end;

$function$;


revoke all
on function
public.wri_create_master_backed_assessment_question(
  uuid,
  uuid,
  text,
  text,
  text,
  text,
  jsonb,
  jsonb,
  text,
  text,
  numeric,
  integer,
  boolean,
  boolean
)
from public, anon;


grant execute
on function
public.wri_create_master_backed_assessment_question(
  uuid,
  uuid,
  text,
  text,
  text,
  text,
  jsonb,
  jsonb,
  text,
  text,
  numeric,
  integer,
  boolean,
  boolean
)
to authenticated;


comment on function
public.wri_create_master_backed_assessment_question(
  uuid,
  uuid,
  text,
  text,
  text,
  text,
  jsonb,
  jsonb,
  text,
  text,
  numeric,
  integer,
  boolean,
  boolean
)
is
'Creates an approved reusable Master Question and secure answer key, records applicable master roles, then copies a stable source-linked snapshot into the selected current template assessment.';
