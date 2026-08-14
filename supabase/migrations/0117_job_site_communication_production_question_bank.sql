-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0117_job_site_communication_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Job-Site Communication
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

create temporary table _seed_job_site_communication_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_job_site_communication_l2_questions (
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
'What is the main purpose of clear job-site communication?',
'[{"key":"A","text":"To coordinate work, share accurate information, reduce misunderstandings, and support safe efficient execution"},{"key":"B","text":"To eliminate the need for planning"},{"key":"C","text":"To make conversations as brief as possible"},{"key":"D","text":"To allow each trade to work independently without coordination"}]'::jsonb,
'["A"]'::jsonb,
'Clear communication supports coordination, safety, quality, and reliable execution of work.'),

(2,'multiple_choice','foundational',
'What is an important feature of an effective work instruction?',
'[{"key":"A","text":"It is specific enough that the listener understands the task, location, expectations, and relevant constraints"},{"key":"B","text":"It uses as many technical terms as possible"},{"key":"C","text":"It assumes the listener already knows the details"},{"key":"D","text":"It avoids questions"}]'::jsonb,
'["A"]'::jsonb,
'Effective instructions are clear, specific, and appropriate to the task and audience.'),

(3,'multiple_choice','foundational',
'Why is active listening important on a construction site?',
'[{"key":"A","text":"It helps confirm that important instructions, concerns, and coordination information are understood accurately"},{"key":"B","text":"It allows workers to avoid taking notes"},{"key":"C","text":"It replaces the need to ask questions"},{"key":"D","text":"It is useful only during safety meetings"}]'::jsonb,
'["A"]'::jsonb,
'Active listening reduces misunderstanding and supports accurate two-way communication.'),

(4,'multiple_choice','foundational',
'What is the purpose of repeating back or confirming a critical instruction?',
'[{"key":"A","text":"To verify that the message was heard and understood correctly"},{"key":"B","text":"To challenge the person giving the instruction"},{"key":"C","text":"To delay the work"},{"key":"D","text":"To avoid documenting the instruction"}]'::jsonb,
'["A"]'::jsonb,
'Read-back or confirmation is a useful way to verify shared understanding.'),

(5,'multiple_choice','foundational',
'When should a worker ask for clarification?',
'[{"key":"A","text":"When an instruction, drawing reference, condition, responsibility, or expectation is unclear"},{"key":"B","text":"Only after the task is completed"},{"key":"C","text":"Only when a supervisor is unavailable"},{"key":"D","text":"Never if another worker seems confident"}]'::jsonb,
'["A"]'::jsonb,
'Clarification should happen before unclear information becomes incorrect work or a coordination problem.'),

(6,'situational_judgment','application',
'A supervisor gives a verbal instruction that conflicts with the drawing the worker has been using. What is the BEST response?',
'[{"key":"A","text":"Identify the conflict and confirm the correct direction through the established process before proceeding"},{"key":"B","text":"Ignore the supervisor and follow the drawing"},{"key":"C","text":"Ignore the drawing and proceed without question"},{"key":"D","text":"Choose whichever option is easier"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting project information should be surfaced and resolved rather than guessed.'),

(7,'multiple_select','application',
'Which THREE practices support effective job-site communication?',
'[{"key":"A","text":"Use clear and specific language"},{"key":"B","text":"Confirm important information when needed"},{"key":"C","text":"Communicate changes, hazards, and delays promptly"},{"key":"D","text":"Assume silence means agreement"},{"key":"E","text":"Withhold problems until the end of the shift"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Clear language, confirmation, and timely updates are core communication practices.'),

(8,'situational_judgment','application',
'A worker realizes the task will take significantly longer than planned because of an unexpected field condition. What is the BEST communication response?',
'[{"key":"A","text":"Notify the appropriate person promptly, explain the condition, and provide the best available status information"},{"key":"B","text":"Say nothing until the original deadline passes"},{"key":"C","text":"Blame another trade immediately"},{"key":"D","text":"Hide the delay by rushing the work"}]'::jsonb,
'["A"]'::jsonb,
'Early status communication helps supervisors and trade partners adjust sequencing and resources.'),

(9,'multiple_choice','application',
'What is the BEST way to communicate a job-site problem?',
'[{"key":"A","text":"State the condition clearly, describe its impact, and provide relevant facts without exaggeration"},{"key":"B","text":"Use vague language so no one is blamed"},{"key":"C","text":"Wait until several problems accumulate"},{"key":"D","text":"Discuss only who caused it"}]'::jsonb,
'["A"]'::jsonb,
'Problem communication is most useful when it is factual, specific, and focused on the work impact.'),

(10,'situational_judgment','application',
'Two workers believe they received different instructions for the same task. What is the BEST response?',
'[{"key":"A","text":"Stop the conflicting work and confirm the intended direction with the appropriate source"},{"key":"B","text":"Let each worker complete half the task their own way"},{"key":"C","text":"Have the more experienced worker decide without checking"},{"key":"D","text":"Continue until the difference becomes visible"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting instructions should be resolved before they result in inconsistent work.'),

(11,'multiple_choice','application',
'Why is it useful to identify the location or reference point when reporting a field issue?',
'[{"key":"A","text":"It helps others find and understand the exact condition being discussed"},{"key":"B","text":"It makes the report sound more technical"},{"key":"C","text":"It eliminates the need to describe the problem"},{"key":"D","text":"It is only necessary on large projects"}]'::jsonb,
'["A"]'::jsonb,
'Specific location information makes field communication actionable.'),

(12,'situational_judgment','application',
'A trade partner is about to cover work that your crew still needs to inspect or access. What is the BEST response?',
'[{"key":"A","text":"Communicate the access or inspection need immediately and coordinate the sequence before the work is covered"},{"key":"B","text":"Let them proceed and reopen the work later"},{"key":"C","text":"Wait until the end of the day to mention it"},{"key":"D","text":"Move their materials without telling them"}]'::jsonb,
'["A"]'::jsonb,
'Timely trade coordination prevents avoidable rework and access conflicts.'),

(13,'multiple_choice','application',
'What is the BEST way to respond when you do not understand a technical term used in an instruction?',
'[{"key":"A","text":"Ask for clarification rather than pretending to understand"},{"key":"B","text":"Guess from context and continue"},{"key":"C","text":"Ignore that part of the instruction"},{"key":"D","text":"Ask another worker later after completing the task"}]'::jsonb,
'["A"]'::jsonb,
'Clarifying unfamiliar terminology reduces errors caused by false assumptions.'),

(14,'situational_judgment','application',
'A worker notices a hazard affecting another crew. What is the BEST communication response?',
'[{"key":"A","text":"Communicate the hazard promptly to the affected workers and appropriate responsible person using the site process"},{"key":"B","text":"Ignore it because it belongs to another trade"},{"key":"C","text":"Wait until the next weekly meeting"},{"key":"D","text":"Post about it informally without notifying anyone responsible"}]'::jsonb,
'["A"]'::jsonb,
'Hazards affecting other crews should be communicated promptly through the appropriate job-site channels.'),

(15,'scenario','scenario',
'A supervisor asks for a status update on a task that is only 60% complete, but the worker worries that admitting the delay will reflect badly on the crew. What is the BEST response?',
'[{"key":"A","text":"Provide an accurate status, explain the cause of any delay, and identify what remains"},{"key":"B","text":"Report that the task is nearly complete"},{"key":"C","text":"Avoid giving a percentage"},{"key":"D","text":"Say the task is complete and fix the difference later"}]'::jsonb,
'["A"]'::jsonb,
'Reliable status communication depends on accurate, timely information rather than optimistic reporting.'),

(16,'scenario','scenario',
'A worker receives a radio message in a noisy area and is unsure whether the instruction was to stop or continue. What is the BEST response?',
'[{"key":"A","text":"Request confirmation before acting on an unclear message"},{"key":"B","text":"Assume the most likely instruction"},{"key":"C","text":"Continue working because stopping may hurt production"},{"key":"D","text":"Ask another worker what they think was said"}]'::jsonb,
'["A"]'::jsonb,
'Unclear instructions should be confirmed before action, especially when they affect work control.'),

(17,'scenario','scenario',
'A field issue has been discussed verbally several times, but no one is sure who is responsible for the next action. What is the BEST response?',
'[{"key":"A","text":"Clarify the responsibility, expected next step, and required follow-up through the appropriate communication process"},{"key":"B","text":"Assume someone else will handle it"},{"key":"C","text":"Repeat the same conversation without assigning ownership"},{"key":"D","text":"Wait until the issue becomes urgent"}]'::jsonb,
'["A"]'::jsonb,
'Effective coordination includes clear ownership and follow-up, not just discussion.'),

(18,'scenario','scenario',
'A worker realizes that instructions they gave another worker were incomplete and could lead to incorrect work. What is the BEST response?',
'[{"key":"A","text":"Correct the communication promptly and verify the other worker understands the updated instruction"},{"key":"B","text":"Wait to see whether the worker makes a mistake"},{"key":"C","text":"Say nothing to avoid embarrassment"},{"key":"D","text":"Correct the work later without explaining the change"}]'::jsonb,
'["A"]'::jsonb,
'When a communication error is discovered, prompt correction helps prevent downstream mistakes.'),

(19,'scenario','scenario',
'A disagreement between two trade partners is becoming personal and is delaying coordination. What is the BEST Level 2 response?',
'[{"key":"A","text":"Refocus the discussion on the work condition, facts, responsibilities, and needed next action, and involve the appropriate supervisor if necessary"},{"key":"B","text":"Take sides immediately"},{"key":"C","text":"Ignore the conflict"},{"key":"D","text":"Argue until one person gives in"}]'::jsonb,
'["A"]'::jsonb,
'Professional communication keeps coordination centered on the work rather than personalities.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Job-Site Communication?',
'[{"key":"A","text":"Speaking frequently even when information is uncertain"},{"key":"B","text":"Reliably giving and receiving clear work information, confirming important instructions, reporting hazards and status changes promptly, coordinating with others, and asking for clarification when needed"},{"key":"C","text":"Avoiding questions so work appears efficient"},{"key":"D","text":"Communicating problems only after they affect production"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means communicating routine job-site information clearly, accurately, promptly, and professionally while recognizing when clarification or coordination is required.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '882d07c1-93ad-47ad-9cfe-00fa0746d42e';
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
      and c.name = 'Job-Site Communication'
      and c.is_current = true
  ) then
    raise exception 'Current Job-Site Communication Master Competency not found';
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
  v_assessment_name := 'Job-Site Communication — Level 2 Competency Assessment';

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
    select * from _seed_job_site_communication_l2_questions
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
        'Job-Site Communication',
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
      'IntegrateU Job-Site Communication L2 production assessment v1.0.',
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
        'Job-Site Communication',
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
        'IntegrateU Job-Site Communication L2 production assessment v1.0.',
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
   '882d07c1-93ad-47ad-9cfe-00fa0746d42e'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '882d07c1-93ad-47ad-9cfe-00fa0746d42e'::uuid
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
      '882d07c1-93ad-47ad-9cfe-00fa0746d42e'::uuid
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
