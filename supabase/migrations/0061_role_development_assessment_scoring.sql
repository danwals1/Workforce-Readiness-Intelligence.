create or replace function public.wri_score_attempt(
  p_attempt_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $function$

declare
  v_attempt assessment_attempts;
  v_assessment assessments;

  v_employee_auth_user_id uuid;

  v_selected_question_count int;
  v_answered_question_count int;

  v_master_role_template_id uuid;
  v_company_role_id uuid;

  v_role_development_competency_id uuid;
  v_role_development_required_level int;

begin

  select *
  into v_attempt
  from assessment_attempts
  where id = p_attempt_id;

  if v_attempt is null then
    raise exception
      'attempt % not found',
      p_attempt_id;
  end if;


  select *
  into v_assessment
  from assessments
  where id = v_attempt.assessment_id;

  if v_assessment is null then
    raise exception
      'assessment for attempt % not found',
      p_attempt_id;
  end if;


  select auth_user_id
  into v_employee_auth_user_id
  from employees
  where id = v_attempt.employee_id;

  if not (
    wri_is_integrateu_admin()
    or v_attempt.client_id in (
      select wri_allowed_client_ids()
    )
    or v_employee_auth_user_id = auth.uid()
  ) then
    raise exception
      'not authorized to score attempt %',
      p_attempt_id;
  end if;


  if v_attempt.status = 'completed' then
    raise exception
      'attempt % already scored',
      p_attempt_id;
  end if;


  select count(*)
  into v_selected_question_count
  from attempt_question_selections
  where attempt_id = p_attempt_id;

  if v_selected_question_count = 0 then
    raise exception
      'attempt % has no selected questions',
      p_attempt_id;
  end if;


  select count(*)
  into v_answered_question_count
  from attempt_answers aa
  join attempt_question_selections aqs
    on aqs.attempt_id = aa.attempt_id
   and aqs.question_id = aa.question_id
  where aa.attempt_id = p_attempt_id;

  if v_answered_question_count <> v_selected_question_count then
    raise exception
      'attempt % is incomplete: % of % selected questions answered',
      p_attempt_id,
      v_answered_question_count,
      v_selected_question_count;
  end if;


  update attempt_answers aa
  set is_correct = (
    select
      case

        when jsonb_typeof(k.correct_answer) = 'array'
        then (
          select array_agg(x order by x)
          from jsonb_array_elements_text(
            k.correct_answer
          ) x
        ) = (
          select array_agg(y order by y)
          from jsonb_array_elements_text(
            aa.response
          ) y
        )

        when jsonb_typeof(aa.response) = 'array'
         and jsonb_array_length(aa.response) = 1
        then
          k.correct_answer = aa.response -> 0

        else
          k.correct_answer = aa.response

      end
    from assessment_question_answer_keys k
    where k.question_id = aa.question_id
  )
  where aa.attempt_id = p_attempt_id;


  if exists (
    select 1
    from attempt_answers
    where attempt_id = p_attempt_id
      and is_correct is null
  ) then
    raise exception
      'attempt % contains one or more questions without a valid answer key',
      p_attempt_id;
  end if;


  delete from competency_scores
  where attempt_id = p_attempt_id;


  if v_attempt.attempt_mode = 'role_development_assessment' then

    if v_attempt.development_plan_activity_id is null then
      raise exception
        'role development assessment attempt % has no development plan activity',
        p_attempt_id;
    end if;


    select
      dpa.master_competency_template_id,
      dpa.target_required_level_snapshot
    into
      v_role_development_competency_id,
      v_role_development_required_level
    from development_plan_activities dpa
    where dpa.id =
      v_attempt.development_plan_activity_id
      and dpa.development_plan_id =
        v_attempt.development_plan_id;


    if v_role_development_competency_id is null then
      raise exception
        'role development assessment attempt % has no linked master competency',
        p_attempt_id;
    end if;


    if exists (
      select 1
      from attempt_question_selections aqs
      join assessment_questions q
        on q.id = aqs.question_id
      where aqs.attempt_id = p_attempt_id
        and q.master_competency_template_id
          is distinct from
          v_role_development_competency_id
    ) then
      raise exception
        'role development assessment attempt % contains a question outside its assigned competency',
        p_attempt_id;
    end if;


    insert into competency_scores (
      client_id,
      attempt_id,
      employee_id,
      competency_id,
      master_competency_template_id,
      score_percent,
      estimated_level,
      required_level
    )
    select
      v_attempt.client_id,
      p_attempt_id,
      v_attempt.employee_id,
      null,
      q.master_competency_template_id,

      round(
        100.0
        * sum(
            case
              when aa.is_correct
              then q.points
              else 0
            end
          )
        / nullif(
            sum(q.points),
            0
          ),
        1
      ),

      least(
        4,
        greatest(
          1,
          ceil(
            4.0
            * sum(
                case
                  when aa.is_correct
                  then q.points
                  else 0
                end
              )
            / nullif(
                sum(q.points),
                0
              )
          )::int
        )
      ),

      v_role_development_required_level

    from attempt_answers aa

    join attempt_question_selections aqs
      on aqs.attempt_id = aa.attempt_id
     and aqs.question_id = aa.question_id

    join assessment_questions q
      on q.id = aa.question_id

    where aa.attempt_id = p_attempt_id
      and q.master_competency_template_id =
        v_role_development_competency_id

    group by
      q.master_competency_template_id;


  elsif v_assessment.client_id is null then

    v_master_role_template_id :=
      coalesce(
        v_assessment.master_target_role_template_id,
        v_assessment.master_role_template_id
      );


    if v_master_role_template_id is null then
      raise exception
        'template assessment % has no master role template',
        v_assessment.id;
    end if;


    insert into competency_scores (
      client_id,
      attempt_id,
      employee_id,
      competency_id,
      master_competency_template_id,
      score_percent,
      estimated_level,
      required_level
    )
    select
      v_attempt.client_id,
      p_attempt_id,
      v_attempt.employee_id,
      null,
      q.master_competency_template_id,

      round(
        100.0
        * sum(
            case
              when aa.is_correct
              then q.points
              else 0
            end
          )
        / nullif(
            sum(q.points),
            0
          ),
        1
      ),

      least(
        4,
        greatest(
          1,
          ceil(
            4.0
            * sum(
                case
                  when aa.is_correct
                  then q.points
                  else 0
                end
              )
            / nullif(
                sum(q.points),
                0
              )
          )::int
        )
      ),

      mrcr.required_level

    from attempt_answers aa

    join attempt_question_selections aqs
      on aqs.attempt_id = aa.attempt_id
     and aqs.question_id = aa.question_id

    join assessment_questions q
      on q.id = aa.question_id

    left join master_role_competency_requirements mrcr
      on mrcr.master_role_template_id =
        v_master_role_template_id
     and mrcr.master_competency_template_id =
        q.master_competency_template_id

    where aa.attempt_id = p_attempt_id
      and q.master_competency_template_id
        is not null

    group by
      q.master_competency_template_id,
      mrcr.required_level;


  else

    v_company_role_id :=
      coalesce(
        v_attempt.role_id,
        v_assessment.target_role_id,
        v_assessment.role_id
      );


    insert into competency_scores (
      client_id,
      attempt_id,
      employee_id,
      competency_id,
      master_competency_template_id,
      score_percent,
      estimated_level,
      required_level
    )
    select
      v_attempt.client_id,
      p_attempt_id,
      v_attempt.employee_id,
      q.competency_id,
      null,

      round(
        100.0
        * sum(
            case
              when aa.is_correct
              then q.points
              else 0
            end
          )
        / nullif(
            sum(q.points),
            0
          ),
        1
      ),

      least(
        4,
        greatest(
          1,
          ceil(
            4.0
            * sum(
                case
                  when aa.is_correct
                  then q.points
                  else 0
                end
              )
            / nullif(
                sum(q.points),
                0
              )
          )::int
        )
      ),

      rcr.required_level

    from attempt_answers aa

    join attempt_question_selections aqs
      on aqs.attempt_id = aa.attempt_id
     and aqs.question_id = aa.question_id

    join assessment_questions q
      on q.id = aa.question_id

    left join role_competency_requirements rcr
      on rcr.role_id = v_company_role_id
     and rcr.competency_id =
        q.competency_id

    where aa.attempt_id = p_attempt_id
      and q.competency_id is not null

    group by
      q.competency_id,
      rcr.required_level;

  end if;


  update assessment_attempts
  set
    status = 'completed',
    completed_at = now(),
    updated_at = now()
  where id = p_attempt_id;


  if v_attempt.attempt_mode =
       'role_development_assessment'
     and v_attempt.development_plan_id
       is not null
  then
    perform
      wri_refresh_development_plan_resolution(
        v_attempt.development_plan_id
      );
  end if;

end;
$function$;
