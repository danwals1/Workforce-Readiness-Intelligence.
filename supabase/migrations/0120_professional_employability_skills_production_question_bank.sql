-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0120_professional_employability_skills_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Professional & Employability Skills
--   Level 2: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Construction Worker -> Level 2
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_professional_employability_skills_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_professional_employability_skills_l2_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values
(1,'multiple_choice','foundational',
'Which behavior BEST demonstrates reliability on a construction crew?',
'[{"key":"A","text":"Consistently arriving prepared, completing assigned work, and communicating when an issue may affect commitments"},{"key":"B","text":"Working quickly only when a supervisor is nearby"},{"key":"C","text":"Waiting for coworkers to remind you about assigned tasks"},{"key":"D","text":"Leaving unfinished work without providing status"}]'::jsonb,
'["A"]'::jsonb,
'Reliability is demonstrated through consistent preparation, follow-through, and timely communication about commitments.'),

(2,'multiple_choice','foundational',
'What does workplace accountability mean?',
'[{"key":"A","text":"Taking responsibility for assigned work, decisions, mistakes, and required follow-up"},{"key":"B","text":"Accepting responsibility only when work goes well"},{"key":"C","text":"Avoiding difficult assignments"},{"key":"D","text":"Letting a supervisor handle every problem"}]'::jsonb,
'["A"]'::jsonb,
'Accountability includes ownership of both results and corrective actions.'),

(3,'multiple_choice','foundational',
'Which behavior BEST reflects professionalism on a job site?',
'[{"key":"A","text":"Treating others respectfully, following workplace expectations, and maintaining appropriate conduct"},{"key":"B","text":"Speaking differently to coworkers depending on their position"},{"key":"C","text":"Ignoring procedures that seem inconvenient"},{"key":"D","text":"Discussing private workplace matters with anyone who asks"}]'::jsonb,
'["A"]'::jsonb,
'Professionalism includes respectful conduct, appropriate boundaries, and consistent adherence to workplace expectations.'),

(4,'multiple_choice','foundational',
'Why is punctuality important in construction work?',
'[{"key":"A","text":"Crew activities are often coordinated, so one person''s delay can affect other workers and scheduled tasks"},{"key":"B","text":"It matters only for payroll records"},{"key":"C","text":"It matters only at the beginning of a project"},{"key":"D","text":"It is optional when the employee works quickly"}]'::jsonb,
'["A"]'::jsonb,
'Construction work depends on coordinated crews, sequencing, and timely readiness.'),

(5,'multiple_choice','foundational',
'What does adaptability mean in the workplace?',
'[{"key":"A","text":"Adjusting appropriately when priorities, conditions, assignments, or procedures change"},{"key":"B","text":"Changing procedures without approval"},{"key":"C","text":"Avoiding unfamiliar tasks"},{"key":"D","text":"Ignoring changes until someone provides written instructions"}]'::jsonb,
'["A"]'::jsonb,
'Adaptability is the ability to respond constructively to legitimate changes while still following requirements.'),

(6,'situational_judgment','application',
'You realize you may be late for the start of your shift because of an unexpected delay. What is the BEST response?',
'[{"key":"A","text":"Notify the appropriate supervisor as soon as possible and provide an accurate update"},{"key":"B","text":"Wait until after the shift starts to see whether anyone notices"},{"key":"C","text":"Ask a coworker to clock in for you"},{"key":"D","text":"Arrive late and explain only if questioned"}]'::jsonb,
'["A"]'::jsonb,
'Professional reliability includes early, accurate communication when a commitment may not be met.'),

(7,'multiple_select','application',
'Which THREE behaviors support effective teamwork?',
'[{"key":"A","text":"Sharing relevant information"},{"key":"B","text":"Following through on agreed responsibilities"},{"key":"C","text":"Helping resolve work issues respectfully"},{"key":"D","text":"Withholding information to protect your own assignment"},{"key":"E","text":"Blaming another trade before checking facts"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Strong teamwork depends on communication, dependable follow-through, and constructive problem solving.'),

(8,'situational_judgment','application',
'You make a mistake that will require part of the work to be corrected. What is the BEST response?',
'[{"key":"A","text":"Report the mistake promptly, explain the known facts, and participate in correcting it"},{"key":"B","text":"Hide the mistake if it may not be noticed"},{"key":"C","text":"Blame the instructions before reviewing what happened"},{"key":"D","text":"Wait for another worker to discover it"}]'::jsonb,
'["A"]'::jsonb,
'Accountability requires timely ownership and corrective follow-through.'),

(9,'multiple_choice','application',
'A supervisor assigns you a task you have not performed before. What is the BEST response?',
'[{"key":"A","text":"Clarify expectations, identify any training or guidance you need, and proceed within your qualifications"},{"key":"B","text":"Pretend you understand so you appear capable"},{"key":"C","text":"Refuse every unfamiliar task"},{"key":"D","text":"Copy another worker without asking questions"}]'::jsonb,
'["A"]'::jsonb,
'Professional adaptability includes learning new work while recognizing limits and asking for appropriate guidance.'),

(10,'situational_judgment','application',
'A coworker is struggling to complete an assigned task that affects your crew''s work. What is the BEST response?',
'[{"key":"A","text":"Offer appropriate help or coordinate with the supervisor while still meeting your own responsibilities"},{"key":"B","text":"Ignore the issue because it is not your assignment"},{"key":"C","text":"Complete their work without telling anyone"},{"key":"D","text":"Criticize the coworker in front of the crew"}]'::jsonb,
'["A"]'::jsonb,
'Teamwork involves constructive support and coordination without abandoning assigned responsibilities.'),

(11,'multiple_choice','application',
'What is the BEST way to respond to constructive feedback from a supervisor?',
'[{"key":"A","text":"Listen, clarify expectations if needed, and apply the feedback to future work"},{"key":"B","text":"Defend every decision immediately"},{"key":"C","text":"Ignore feedback you disagree with"},{"key":"D","text":"Discuss the supervisor negatively with coworkers"}]'::jsonb,
'["A"]'::jsonb,
'Professional development requires receiving and applying appropriate feedback.'),

(12,'situational_judgment','application',
'Two coworkers are frustrated and begin arguing about who caused a delay. What is the BEST professional response?',
'[{"key":"A","text":"Keep the discussion factual and respectful, focus on resolving the work issue, and involve supervision if needed"},{"key":"B","text":"Take sides immediately"},{"key":"C","text":"Raise your voice so the discussion ends faster"},{"key":"D","text":"Spread the disagreement to the rest of the crew"}]'::jsonb,
'["A"]'::jsonb,
'Professional conduct focuses on facts, respectful communication, and resolution rather than escalation.'),

(13,'multiple_choice','application',
'You finish your assigned task earlier than expected. What is the BEST next step?',
'[{"key":"A","text":"Confirm the work is complete and acceptable, then check for the next priority or assignment"},{"key":"B","text":"Leave the work area without telling anyone"},{"key":"C","text":"Slow down future work so assignments last longer"},{"key":"D","text":"Begin another trade''s work without authorization"}]'::jsonb,
'["A"]'::jsonb,
'Reliable employees close out assigned work and proactively coordinate the next appropriate priority.'),

(14,'situational_judgment','application',
'A project priority changes and your crew is reassigned to different work. What is the BEST response?',
'[{"key":"A","text":"Confirm the new expectations, adjust your work plan, and communicate any unresolved impacts from the previous assignment"},{"key":"B","text":"Continue the original work because it was assigned first"},{"key":"C","text":"Complain to coworkers and delay starting"},{"key":"D","text":"Choose whichever assignment you prefer"}]'::jsonb,
'["A"]'::jsonb,
'Adaptability means responding productively to legitimate changes while managing unfinished commitments.'),

(15,'scenario','scenario',
'You promised to complete a task by the end of the shift, but midway through the work you realize the deadline is unlikely. What is the BEST response?',
'[{"key":"A","text":"Notify the supervisor early, explain the current status and reason, and coordinate the revised plan"},{"key":"B","text":"Say nothing and hope the task is completed"},{"key":"C","text":"Mark the task complete before it is actually finished"},{"key":"D","text":"Leave the remaining work for the next shift without notice"}]'::jsonb,
'["A"]'::jsonb,
'Professional accountability includes communicating foreseeable delays before they become surprises.'),

(16,'scenario','scenario',
'A coworker repeatedly makes disrespectful comments during work. What is the BEST response?',
'[{"key":"A","text":"Maintain professional conduct, address the issue through appropriate workplace channels, and avoid escalating the behavior"},{"key":"B","text":"Respond with similar comments"},{"key":"C","text":"Post about the coworker publicly"},{"key":"D","text":"Encourage the crew to exclude the coworker"}]'::jsonb,
'["A"]'::jsonb,
'Appropriate workplace conduct requires respectful behavior and use of proper channels when problems persist.'),

(17,'scenario','scenario',
'You are asked why a crew task was not completed, and part of the delay resulted from your own work. What is the BEST response?',
'[{"key":"A","text":"Give an accurate account of the delay, including your own contribution, and explain the corrective plan"},{"key":"B","text":"Mention only the factors caused by others"},{"key":"C","text":"Say you do not know even though you do"},{"key":"D","text":"Wait to see whether someone else accepts responsibility"}]'::jsonb,
'["A"]'::jsonb,
'Accountability means presenting the facts accurately, including one''s own role in a problem.'),

(18,'scenario','scenario',
'Your supervisor changes a familiar work process because of a new project requirement. You prefer the old method. What is the BEST response?',
'[{"key":"A","text":"Follow the approved change, ask questions needed to understand it, and raise concerns through the appropriate channel"},{"key":"B","text":"Continue using the old method when the supervisor is absent"},{"key":"C","text":"Tell coworkers to ignore the change"},{"key":"D","text":"Refuse to learn the new process"}]'::jsonb,
'["A"]'::jsonb,
'Adaptability combines compliance with approved changes and constructive communication about legitimate concerns.'),

(19,'scenario','scenario',
'A new employee joins your crew and does not yet understand the normal workflow. What is the BEST Level 2 response?',
'[{"key":"A","text":"Provide appropriate guidance, share relevant expectations, and help the employee integrate into the crew while maintaining your own responsibilities"},{"key":"B","text":"Ignore the employee until the supervisor handles everything"},{"key":"C","text":"Give the employee the least desirable tasks without explanation"},{"key":"D","text":"Expect the employee to learn by making mistakes"}]'::jsonb,
'["A"]'::jsonb,
'Level 2 teamwork includes constructive support of coworkers while maintaining personal responsibility for assigned work.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Professional & Employability Skills?',
'[{"key":"A","text":"Working well only when closely supervised"},{"key":"B","text":"Consistently demonstrating reliability, punctuality, accountability, teamwork, professionalism, adaptability, and appropriate workplace conduct while communicating early when commitments or conditions change"},{"key":"C","text":"Avoiding responsibility for problems outside your immediate task"},{"key":"D","text":"Prioritizing speed over workplace expectations"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means consistently applying professional and employability behaviors during routine construction work.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b472f8bd-ac6a-455f-aac9-0290191ee175';
  v_construction_worker_role_id uuid := '0f5d7696-f36f-4413-b617-ee20f8c15a9f';
  v_assessment_id uuid;
  v_master_question_id uuid;
  v_assessment_question_id uuid;
  v_row record;
  v_level integer;
  v_role_template_id uuid;
  v_assessment_name text;
begin
  select i.id into v_industry_id
  from public.industries i
  where lower(i.slug) = 'construction'
     or lower(i.name) = 'construction'
  order by case when lower(i.slug) = 'construction' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Construction industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Professional & Employability Skills'
      and c.is_current = true
  ) then
    raise exception 'Current Professional & Employability Skills Master Competency not found';
  end if;



  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_construction_worker_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Construction Worker'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Construction Worker L2 safety requirement not found';
  end if;



  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 2
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 5
      and s.application_count = 9
      and s.scenario_count = 6
  ) then
    raise exception 'Expected current L2 assessment standard 20 / 5 / 9 / 6 not found';
  end if;

  -- ========================================================================
  -- Seed Level 2
  v_level := 2;
  v_role_template_id := '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid;
  v_assessment_name := 'Professional & Employability Skills — Level 2 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_professional_employability_skills_l2_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Professional & Employability Skills',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        false,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Professional & Employability Skills L2 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_role_template_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
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
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Professional & Employability Skills',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Professional & Employability Skills L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — ASSESSMENT CONTENT
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'foundational'
  )::integer as foundational_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'application'
  )::integer as application_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'scenario'
  )::integer as scenario_count,
  count(distinct aq.id) filter (
    where aq.critical_safety
  )::integer as critical_safety_count,
  count(distinct aq.id) filter (
    where aq.practical_verification_required
  )::integer as practical_verification_required_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   'b472f8bd-ac6a-455f-aac9-0290191ee175'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b472f8bd-ac6a-455f-aac9-0290191ee175'::uuid
  and a.target_level = 2
group by a.id, a.target_level, a.name;


-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY
-- ============================================================================

with q as (
  select
    a.target_level,
    aq.source_master_question_id
  from public.assessments a
  join public.assessment_questions aq
    on aq.assessment_id = a.id
   and aq.source_master_question_id is not null
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'b472f8bd-ac6a-455f-aac9-0290191ee175'::uuid
    and a.target_level = 2
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer
    as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where ra.master_role_template_id =
  '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid
group by q.target_level;
