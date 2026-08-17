create or replace function public.wri_publish_assessment_version(
  p_assessment_id uuid
)
returns table(
  new_id uuid,
  new_version integer
)
language plpgsql
security definer
set search_path = public
as $function$
declare
  v_old assessments;
  v_new_id uuid;
  v_new_version int;
  v_old_question record;
  v_new_question_id uuid;
begin
  if not wri_is_integrateu_admin() then
    raise exception
      'not authorized to publish an assessment version';
  end if;

  select *
  into v_old
  from assessments
  where id = p_assessment_id
  for update;

  if v_old is null then
    raise exception
      'assessment % not found',
      p_assessment_id;
  end if;

  if v_old.client_id is not null then
    raise exception
      'assessment % is a company-adopted assessment, not a template; publish the template it came from instead',
      p_assessment_id;
  end if;

  if not v_old.is_current then
    raise exception
      'assessment % is not the current version; publish from the current version only',
      p_assessment_id;
  end if;

  v_new_version := v_old.version + 1;

  update assessments
  set
    is_current = false,
    updated_at = now()
  where id = p_assessment_id;

  insert into assessments (
    family_id,
    version,
    is_current,
    published_by,
    industry_id,
    name,
    type,
    master_role_template_id,
    master_target_role_template_id,
    master_competency_template_id,
    target_level
  )
  values (
    v_old.family_id,
    v_new_version,
    true,
    auth.uid(),
    v_old.industry_id,
    v_old.name,
    v_old.type,
    v_old.master_role_template_id,
    v_old.master_target_role_template_id,
    v_old.master_competency_template_id,
    v_old.target_level
  )
  returning id
  into v_new_id;

  for v_old_question in
    select *
    from assessment_questions
    where assessment_id = p_assessment_id
    order by sort_order, id
  loop
    insert into assessment_questions (
      assessment_id,
      master_competency_template_id,
      competency_id,
      type,
      prompt,
      scenario,
      image_url,
      options,
      points,
      sort_order,
      source_master_question_id,
      domain,
      difficulty,
      critical_safety,
      practical_verification_required
    )
    values (
      v_new_id,
      v_old_question.master_competency_template_id,
      v_old_question.competency_id,
      v_old_question.type,
      v_old_question.prompt,
      v_old_question.scenario,
      v_old_question.image_url,
      v_old_question.options,
      v_old_question.points,
      v_old_question.sort_order,
      v_old_question.source_master_question_id,
      v_old_question.domain,
      v_old_question.difficulty,
      v_old_question.critical_safety,
      v_old_question.practical_verification_required
    )
    returning id
    into v_new_question_id;

    insert into assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_new_question_id,
      k.correct_answer,
      k.scoring_notes
    from assessment_question_answer_keys k
    where k.question_id = v_old_question.id;
  end loop;

  insert into assessment_blueprint_rules (
    assessment_id,
    domain,
    master_competency_template_id,
    question_count,
    foundational_count,
    application_count,
    scenario_count,
    sort_order
  )
  select
    v_new_id,
    b.domain,
    b.master_competency_template_id,
    b.question_count,
    b.foundational_count,
    b.application_count,
    b.scenario_count,
    b.sort_order
  from assessment_blueprint_rules b
  where b.assessment_id = p_assessment_id;

  update assessments
  set
    superseded_by = v_new_id,
    updated_at = now()
  where id = p_assessment_id;

  return query
  select
    v_new_id,
    v_new_version;
end;
$function$;
