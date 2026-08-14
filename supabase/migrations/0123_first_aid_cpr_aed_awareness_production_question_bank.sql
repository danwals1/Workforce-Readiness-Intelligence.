-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0123_first_aid_cpr_aed_awareness_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: First Aid / CPR / AED Awareness
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--
-- Roles:
--   Construction Worker -> Level 1
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_first_aid_cpr_aed_awareness_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_first_aid_cpr_aed_awareness_l1_questions (
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
'What is the FIRST priority when approaching an injured or ill person on a construction site?',
'[{"key":"A","text":"Check that the scene is safe to enter before providing assistance"},{"key":"B","text":"Move the person immediately"},{"key":"C","text":"Give the person water"},{"key":"D","text":"Ask coworkers what happened before looking for hazards"}]'::jsonb,
'["A"]'::jsonb,
'An emergency responder should first avoid becoming another victim by checking for hazards before approaching.'),

(2,'multiple_choice','foundational',
'When should emergency medical services be activated for a serious or potentially life-threatening emergency?',
'[{"key":"A","text":"As soon as the need for emergency help is recognized"},{"key":"B","text":"Only after the end of the shift"},{"key":"C","text":"Only if a supervisor personally makes the call"},{"key":"D","text":"After trying every possible first-aid measure"}]'::jsonb,
'["A"]'::jsonb,
'Prompt activation of the emergency response system is a foundational part of managing serious emergencies.'),

(3,'multiple_choice','foundational',
'What is the main purpose of CPR?',
'[{"key":"A","text":"To help circulate oxygenated blood when a person is unresponsive and not breathing normally"},{"key":"B","text":"To treat every type of injury"},{"key":"C","text":"To stop all bleeding"},{"key":"D","text":"To wake a person who is sleeping"}]'::jsonb,
'["A"]'::jsonb,
'CPR is used when normal circulation and breathing are absent or severely impaired.'),

(4,'multiple_choice','foundational',
'What is an AED designed to do?',
'[{"key":"A","text":"Analyze the heart rhythm and, when appropriate, deliver a shock according to its programmed instructions"},{"key":"B","text":"Measure blood pressure only"},{"key":"C","text":"Replace all CPR efforts"},{"key":"D","text":"Treat broken bones"}]'::jsonb,
'["A"]'::jsonb,
'An AED analyzes rhythm and gives prompts, including shock delivery when indicated.'),

(5,'multiple_choice','foundational',
'Why are gloves or another appropriate barrier used when providing first aid when available?',
'[{"key":"A","text":"To reduce exposure to blood and other potentially infectious body fluids"},{"key":"B","text":"To keep the injured person warm"},{"key":"C","text":"To make CPR more effective"},{"key":"D","text":"To replace handwashing"}]'::jsonb,
'["A"]'::jsonb,
'Barrier protection helps reduce occupational exposure to blood and body fluids.'),

(6,'multiple_choice','foundational',
'What is the BEST general response to severe external bleeding?',
'[{"key":"A","text":"Apply appropriate direct pressure and activate emergency help as needed"},{"key":"B","text":"Ignore it if the person is awake"},{"key":"C","text":"Wash the wound continuously before controlling bleeding"},{"key":"D","text":"Have the person walk around"}]'::jsonb,
'["A"]'::jsonb,
'Controlling serious bleeding promptly and obtaining appropriate emergency assistance are key priorities.'),

(7,'multiple_choice','foundational',
'Why should an injured person generally not be moved unless there is an immediate danger or movement is necessary for care?',
'[{"key":"A","text":"Movement can worsen some injuries, including possible spinal or musculoskeletal injuries"},{"key":"B","text":"Moving a person always causes bleeding"},{"key":"C","text":"Only supervisors are allowed to move people"},{"key":"D","text":"Emergency responders cannot treat someone who has been moved"}]'::jsonb,
'["A"]'::jsonb,
'Unnecessary movement can aggravate certain injuries, so movement should be limited unless conditions require it.'),

(8,'multiple_choice','foundational',
'Why is prompt incident notification important after a workplace injury or medical event?',
'[{"key":"A","text":"It helps trigger the required response, documentation, follow-up, and hazard review"},{"key":"B","text":"It guarantees the employee will not need medical care"},{"key":"C","text":"It replaces emergency services"},{"key":"D","text":"It is needed only when equipment is damaged"}]'::jsonb,
'["A"]'::jsonb,
'Timely notification supports emergency response, required reporting, and follow-up actions.'),

(9,'situational_judgment','application',
'A coworker collapses, is unresponsive, and is not breathing normally. What is the BEST response?',
'[{"key":"A","text":"Activate emergency response, begin CPR if trained and able, and have an AED brought and used as soon as available"},{"key":"B","text":"Wait several minutes to see if the person wakes up"},{"key":"C","text":"Give the person food or water"},{"key":"D","text":"Move the person to a break area first"}]'::jsonb,
'["A"]'::jsonb,
'Unresponsiveness with absent or abnormal breathing requires immediate emergency activation, CPR, and early AED use.'),

(10,'situational_judgment','application',
'A worker receives an electrical shock and is still in contact with an energized source. What is the BEST first action?',
'[{"key":"A","text":"Do not touch the worker directly; have the electrical hazard safely de-energized or otherwise controlled and activate emergency response"},{"key":"B","text":"Pull the worker away with bare hands"},{"key":"C","text":"Pour water on the source"},{"key":"D","text":"Ask the worker to remain still until the shift ends"}]'::jsonb,
'["A"]'::jsonb,
'The electrical hazard must be controlled before direct contact so the responder does not become exposed.'),

(11,'multiple_choice','application',
'A coworker suffers a minor cut. Before helping, what is the BEST action?',
'[{"key":"A","text":"Use appropriate barrier protection and follow the site first-aid process"},{"key":"B","text":"Touch the wound directly to inspect it"},{"key":"C","text":"Ignore the injury if bleeding is limited"},{"key":"D","text":"Have the worker return to work immediately"}]'::jsonb,
'["A"]'::jsonb,
'Even apparently minor injuries should be handled using appropriate exposure-control and first-aid practices.'),

(12,'situational_judgment','application',
'A worker is showing signs of heat illness, including confusion and worsening condition. What is the BEST response?',
'[{"key":"A","text":"Treat it as a medical emergency, activate appropriate emergency help, and begin site-approved cooling measures while awaiting responders"},{"key":"B","text":"Tell the worker to finish the task first"},{"key":"C","text":"Leave the worker alone to rest"},{"key":"D","text":"Assume the worker only needs coffee"}]'::jsonb,
'["A"]'::jsonb,
'Confusion or severe symptoms can indicate a serious heat-related emergency requiring immediate action.'),

(13,'multiple_choice','application',
'An AED arrives while CPR is in progress. What should rescuers do?',
'[{"key":"A","text":"Turn on the AED, follow its prompts, and minimize interruptions to CPR as directed"},{"key":"B","text":"Stop all care until a supervisor arrives"},{"key":"C","text":"Ignore the AED if CPR has already started"},{"key":"D","text":"Use the AED only after the person regains consciousness"}]'::jsonb,
'["A"]'::jsonb,
'AEDs are designed to guide rescuers through rhythm analysis and shock decisions while supporting continued resuscitation efforts.'),

(14,'situational_judgment','application',
'A worker falls from a short height and reports severe neck pain but is conscious. There is no immediate environmental danger. What is the BEST response?',
'[{"key":"A","text":"Keep the worker as still as practical, activate appropriate medical assistance, and avoid unnecessary movement"},{"key":"B","text":"Help the worker stand and walk it off"},{"key":"C","text":"Massage the neck"},{"key":"D","text":"Move the worker into a vehicle immediately"}]'::jsonb,
'["A"]'::jsonb,
'Potential neck or spinal injuries should be protected from unnecessary movement while appropriate help is obtained.'),

(15,'multiple_choice','application',
'A coworker has a chemical splash in the eyes. What is the BEST response?',
'[{"key":"A","text":"Immediately use the appropriate eyewash or flushing method and follow the site emergency procedure"},{"key":"B","text":"Rub the eyes to remove the chemical"},{"key":"C","text":"Wait to see whether irritation goes away"},{"key":"D","text":"Cover both eyes without flushing"}]'::jsonb,
'["A"]'::jsonb,
'Chemical eye exposure generally requires immediate flushing using the designated emergency equipment or procedure.'),

(16,'situational_judgment','application',
'A worker experiences a medical event, receives first aid, and says not to tell anyone because the worker feels better. What is the BEST response?',
'[{"key":"A","text":"Follow the required incident-notification and reporting process even if symptoms improve"},{"key":"B","text":"Keep the event secret"},{"key":"C","text":"Report it only if the worker misses the next shift"},{"key":"D","text":"Let a coworker decide whether it matters"}]'::jsonb,
'["A"]'::jsonb,
'Workplace emergency and incident procedures should still be followed after first aid is provided.'),

(17,'scenario','scenario',
'A worker is bleeding heavily from an arm after a tool-related injury. Another worker calls emergency services. What is the BEST next response for someone providing first aid?',
'[{"key":"A","text":"Use appropriate barrier protection, apply effective bleeding control, and continue monitoring until higher-level care takes over"},{"key":"B","text":"Have the injured worker walk to the parking lot"},{"key":"C","text":"Wait for emergency responders without doing anything"},{"key":"D","text":"Remove any deeply embedded object from the wound"}]'::jsonb,
'["A"]'::jsonb,
'After emergency activation, appropriate first aid should continue within the responder''s training until professional care arrives.'),

(18,'scenario','scenario',
'A worker becomes unresponsive in an area where a hazardous gas may be present. What is the BEST response?',
'[{"key":"A","text":"Do not enter an unsafe atmosphere without proper protection; activate the site emergency-rescue process"},{"key":"B","text":"Enter immediately while holding your breath"},{"key":"C","text":"Send the nearest untrained coworker inside"},{"key":"D","text":"Wait until the end of the shift"}]'::jsonb,
'["A"]'::jsonb,
'Scene safety remains the first priority; an unprotected rescuer should not enter a potentially hazardous atmosphere.'),

(19,'scenario','scenario',
'A coworker collapses near you. One person starts CPR and another brings the AED. What is the BEST way for the crew to respond?',
'[{"key":"A","text":"Coordinate emergency activation, CPR, AED use, access for responders, and clear communication until help arrives"},{"key":"B","text":"Have everyone crowd around the person"},{"key":"C","text":"Stop CPR whenever someone has a question"},{"key":"D","text":"Move the person repeatedly so more workers can help"}]'::jsonb,
'["A"]'::jsonb,
'Effective emergency response depends on coordinated roles, uninterrupted lifesaving care, and clear access for responders.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 proficiency in First Aid / CPR / AED Awareness?',
'[{"key":"A","text":"Attempting advanced medical treatment without training"},{"key":"B","text":"Recognizing common emergencies, protecting scene safety, activating the correct response, understanding basic CPR and AED principles, providing appropriate basic first aid within training, and following incident-notification requirements"},{"key":"C","text":"Waiting for supervisors before taking any emergency action"},{"key":"D","text":"Moving every injured person immediately"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 proficiency means recognizing emergencies and correctly applying foundational first-aid, CPR, AED, emergency-response, and notification principles.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '99692ce3-8880-4d68-b807-8fb9db78af29';
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
      and c.name = 'First Aid / CPR / AED Awareness'
      and c.is_current = true
  ) then
    raise exception 'Current First Aid / CPR / AED Awareness Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Construction Worker L2 safety requirement not found';
  end if;



  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 1
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 8
      and s.application_count = 8
      and s.scenario_count = 4
  ) then
    raise exception 'Expected current L1 assessment standard 20 / 8 / 8 / 4 not found';
  end if;

  -- ========================================================================
  -- Seed Level 1
  v_level := 1;
  v_role_template_id := '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid;
  v_assessment_name := 'First Aid / CPR / AED Awareness — Level 1 Competency Assessment';

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
    select * from _seed_first_aid_cpr_aed_awareness_l1_questions
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
        'First Aid / CPR / AED Awareness',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU First Aid / CPR / AED Awareness L1 production assessment v1.0.',
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
        'First Aid / CPR / AED Awareness',
        v_row.difficulty,
        true,
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
        'IntegrateU First Aid / CPR / AED Awareness L1 production assessment v1.0.',
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
   '99692ce3-8880-4d68-b807-8fb9db78af29'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '99692ce3-8880-4d68-b807-8fb9db78af29'::uuid
  and a.target_level = 1
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
      '99692ce3-8880-4d68-b807-8fb9db78af29'::uuid
    and a.target_level = 1
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
