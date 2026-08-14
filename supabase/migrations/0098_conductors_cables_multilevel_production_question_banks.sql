-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0098_conductors_cables_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Conductors & Cables
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   Electrician Apprentice  -> Level 2
--   Electrician Journeyman -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Code note: these questions assess code navigation, interpretation, application,
-- documentation, and recognition of when clarification or escalation is required.
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_conductors_cables_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_conductors_cables_l2_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 5

(1,'multiple_choice','foundational',
'What is the primary purpose of conductor insulation?',
'[{"key":"A","text":"To electrically isolate the conductor from other conductive parts and its surroundings"},{"key":"B","text":"To increase conductor length"},{"key":"C","text":"To replace overcurrent protection"},{"key":"D","text":"To identify the circuit panel"}]'::jsonb,
'["A"]'::jsonb,
'Insulation provides electrical separation appropriate to the conductor type and installation conditions.'),

(2,'multiple_choice','foundational',
'Why must conductor size be appropriate for the intended circuit?',
'[{"key":"A","text":"To carry the intended current under applicable installation conditions"},{"key":"B","text":"Only to fit the terminal color"},{"key":"C","text":"To change system frequency"},{"key":"D","text":"To eliminate all voltage drop"}]'::jsonb,
'["A"]'::jsonb,
'Conductor size must be suitable for the electrical load and applicable installation requirements.'),

(3,'multiple_choice','foundational',
'What is the main purpose of identifying conductors correctly during installation?',
'[{"key":"A","text":"To distinguish circuit function, phase, grounded, grounding, or other required conductor roles"},{"key":"B","text":"To increase conductor ampacity"},{"key":"C","text":"To make splicing unnecessary"},{"key":"D","text":"To reduce cable length"}]'::jsonb,
'["A"]'::jsonb,
'Correct identification helps maintain circuit integrity, safe termination, and future serviceability.'),

(4,'multiple_choice','foundational',
'Why should conductor insulation be inspected before installation?',
'[{"key":"A","text":"To identify cuts, abrasion, or other damage that could compromise the conductor"},{"key":"B","text":"To determine circuit voltage by appearance alone"},{"key":"C","text":"To increase conductor flexibility"},{"key":"D","text":"To eliminate testing"}]'::jsonb,
'["A"]'::jsonb,
'Damaged insulation can compromise the suitability and safety of the conductor installation.'),

(5,'multiple_choice','foundational',
'What is the purpose of leaving adequate conductor length at a termination point?',
'[{"key":"A","text":"To allow proper termination, maintenance, and future handling without excessive strain"},{"key":"B","text":"To increase circuit current"},{"key":"C","text":"To eliminate the need for connectors"},{"key":"D","text":"To reduce box volume"}]'::jsonb,
'["A"]'::jsonb,
'Adequate conductor length supports proper termination and future service without damaging or overstressing the conductor.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'You discover a conductor with damaged insulation before it is pulled into a raceway. What is the BEST action?',
'[{"key":"A","text":"Replace or properly address the damaged conductor before installation"},{"key":"B","text":"Install it because the raceway will protect it"},{"key":"C","text":"Hide the damaged section inside a box"},{"key":"D","text":"Reduce the circuit load"}]'::jsonb,
'["A"]'::jsonb,
'Known insulation damage should be corrected before the conductor becomes part of the installation.'),

(7,'multiple_choice','application',
'Why should conductor pulling tension be controlled?',
'[{"key":"A","text":"Excessive force can damage conductors, insulation, or associated equipment"},{"key":"B","text":"Higher tension increases ampacity"},{"key":"C","text":"Pulling tension changes conductor color"},{"key":"D","text":"Tension eliminates the need for lubricant"}]'::jsonb,
'["A"]'::jsonb,
'Excessive pulling force can damage the conductor or insulation and compromise the installation.'),

(8,'situational_judgment','application',
'A conductor does not fit the terminal for which it is intended. What should you do?',
'[{"key":"A","text":"Verify conductor size, terminal rating, and approved termination method before proceeding"},{"key":"B","text":"Trim strands until it fits"},{"key":"C","text":"Force it into the terminal"},{"key":"D","text":"Use any available adapter"}]'::jsonb,
'["A"]'::jsonb,
'Conductors and terminals must be compatible with the intended size, type, and approved connection method.'),

(9,'multiple_select','application',
'Which THREE practices support good conductor installation?',
'[{"key":"A","text":"Protect insulation from damage"},{"key":"B","text":"Maintain correct conductor identification"},{"key":"C","text":"Use suitable routing and termination methods"},{"key":"D","text":"Remove strands to fit terminals"},{"key":"E","text":"Ignore minimum bending limitations"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Protection, identification, routing, and proper termination are core conductor-installation practices.'),

(10,'multiple_choice','application',
'What is the BEST reason to avoid sharply bending conductors at termination points?',
'[{"key":"A","text":"Sharp bends can damage conductors or create unnecessary mechanical stress"},{"key":"B","text":"Sharp bends increase source voltage"},{"key":"C","text":"Sharp bends improve terminal contact"},{"key":"D","text":"Sharp bends reduce conductor resistance"}]'::jsonb,
'["A"]'::jsonb,
'Conductors should be routed and terminated without unnecessary mechanical stress or damage.'),

(11,'situational_judgment','application',
'A cable is being routed through an area where it may be exposed to physical damage. What should the installer do?',
'[{"key":"A","text":"Use an appropriate protection method or revise the route"},{"key":"B","text":"Install it normally because insulation provides all required protection"},{"key":"C","text":"Paint the cable"},{"key":"D","text":"Reduce conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Cable routing should account for environmental and physical-damage exposure.'),

(12,'multiple_choice','application',
'Why should conductor and cable routing be coordinated before installation?',
'[{"key":"A","text":"To avoid damage, excessive bends, congestion, unsuitable environments, and conflicts with other systems"},{"key":"B","text":"To eliminate all supports"},{"key":"C","text":"To guarantee zero voltage drop"},{"key":"D","text":"To avoid conductor labeling"}]'::jsonb,
'["A"]'::jsonb,
'Good routing reduces installation problems and protects conductor integrity.'),

(13,'situational_judgment','application',
'A conductor identification label becomes unreadable before termination. What is the BEST response?',
'[{"key":"A","text":"Reestablish the conductor identity before making the termination"},{"key":"B","text":"Guess based on conductor position"},{"key":"C","text":"Terminate it to the nearest available point"},{"key":"D","text":"Ignore identification if continuity exists"}]'::jsonb,
'["A"]'::jsonb,
'Conductor identity should be verified before termination rather than assumed.'),

(14,'multiple_choice','application',
'What is the BEST reason to verify terminal torque or manufacturer connection instructions where applicable?',
'[{"key":"A","text":"Proper connection requirements affect the integrity and reliability of the termination"},{"key":"B","text":"Torque determines conductor insulation color"},{"key":"C","text":"Torque increases circuit voltage"},{"key":"D","text":"Torque makes conductor sizing unnecessary"}]'::jsonb,
'["A"]'::jsonb,
'Terminations must be made according to applicable equipment and connection requirements.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'A cable pull is becoming increasingly difficult, and the crew is applying much more force than expected. What is the BEST response?',
'[{"key":"A","text":"Stop and evaluate the route, bend conditions, pulling method, and possible obstruction before continuing"},{"key":"B","text":"Increase force until the cable moves"},{"key":"C","text":"Use smaller conductors without review"},{"key":"D","text":"Pull from both ends simultaneously without coordination"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected pulling resistance can indicate an obstruction, poor route, or risk of conductor damage and should be investigated.'),

(16,'scenario','scenario',
'A conductor reaches the equipment but is too short to terminate without placing the conductor under tension. What is the BEST action?',
'[{"key":"A","text":"Correct the conductor length using an approved installation method rather than forcing the termination"},{"key":"B","text":"Stretch the conductor"},{"key":"C","text":"Pull the equipment toward the conductor"},{"key":"D","text":"Loosen the terminal and clamp only part of the conductor"}]'::jsonb,
'["A"]'::jsonb,
'Terminations should not rely on excessive mechanical tension or improper engagement.'),

(17,'situational_judgment','scenario',
'Several conductors have similar insulation colors and their labels were lost during pulling. What should happen before termination?',
'[{"key":"A","text":"Identify and verify each conductor using an appropriate method before connecting them"},{"key":"B","text":"Terminate them in the order they exit the raceway"},{"key":"C","text":"Guess based on length"},{"key":"D","text":"Connect them temporarily and energize to identify them"}]'::jsonb,
'["A"]'::jsonb,
'Conductor identity must be established before termination to avoid incorrect connections.'),

(18,'scenario','scenario',
'A conductor jacket is scraped during installation but the extent of damage is uncertain. What is the BEST response?',
'[{"key":"A","text":"Stop and evaluate the damage before accepting the conductor for service"},{"key":"B","text":"Assume the conductor is acceptable if copper is not visible"},{"key":"C","text":"Cover the area with paint"},{"key":"D","text":"Increase the breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Uncertain conductor damage should be evaluated before the installation is accepted.'),

(19,'scenario','scenario',
'A cable route shown on the drawings passes through an area that has changed and now exposes the cable to likely mechanical damage. What should the installer do?',
'[{"key":"A","text":"Coordinate a suitable protected route or approved protection method before installation"},{"key":"B","text":"Follow the original route regardless of field conditions"},{"key":"C","text":"Install the cable and add warning tape"},{"key":"D","text":"Reduce conductor count"}]'::jsonb,
'["A"]'::jsonb,
'Actual field conditions must be considered when determining whether the intended route remains suitable.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Conductors & Cables?',
'[{"key":"A","text":"Pulling and terminating conductors without checking identification or condition"},{"key":"B","text":"Selecting, identifying, protecting, routing, and terminating routine conductors and cables while recognizing installation problems"},{"key":"C","text":"Trimming strands whenever terminals are tight"},{"key":"D","text":"Ignoring cable routing hazards"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably performing routine conductor and cable installation while protecting conductor integrity.');

create temporary table _seed_conductors_cables_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_conductors_cables_l4_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 3

(1,'multiple_choice','foundational',
'Why must conductor selection consider more than nominal conductor size?',
'[{"key":"A","text":"Insulation type, temperature conditions, installation method, termination limitations, grouping, and environment can affect suitability"},{"key":"B","text":"Nominal size alone determines every installation condition"},{"key":"C","text":"Only conductor color affects suitability"},{"key":"D","text":"Conductor material never matters"}]'::jsonb,
'["A"]'::jsonb,
'Advanced conductor selection requires considering the full installation environment and equipment limitations.'),

(2,'multiple_choice','foundational',
'What is the BEST reason to coordinate conductor ampacity with terminal limitations and equipment ratings?',
'[{"key":"A","text":"The complete circuit must be suitable at the actual points of connection, not just along the conductor run"},{"key":"B","text":"Terminal limitations apply only after energization"},{"key":"C","text":"Equipment ratings do not affect conductor selection"},{"key":"D","text":"Only conductor insulation controls termination suitability"}]'::jsonb,
'["A"]'::jsonb,
'Conductor suitability includes the conditions and limitations at its terminations.'),

(3,'multiple_choice','foundational',
'Why can a conductor installation that worked on another project be unsuitable on a new project?',
'[{"key":"A","text":"Different loads, environments, routing, grouping, equipment, code requirements, or project conditions may apply"},{"key":"B","text":"Conductors change size between projects"},{"key":"C","text":"Past installations are always controlling"},{"key":"D","text":"Only conductor color changes"}]'::jsonb,
'["A"]'::jsonb,
'Conductor and cable selection must be based on the actual current installation conditions.'),

-- APPLICATION — 7

(4,'situational_judgment','application',
'A group of conductors will be routed through a hotter environment than originally planned. What should the journeyman do?',
'[{"key":"A","text":"Reevaluate conductor suitability and applicable adjustment requirements before installation"},{"key":"B","text":"Install them because conductor size has not changed"},{"key":"C","text":"Increase pulling tension"},{"key":"D","text":"Change conductor identification"}]'::jsonb,
'["A"]'::jsonb,
'Temperature and installation conditions can affect conductor suitability and must be considered when conditions change.'),

(5,'multiple_select','application',
'Which THREE factors commonly belong in advanced conductor-selection review?',
'[{"key":"A","text":"Load and required ampacity"},{"key":"B","text":"Installation environment and grouping conditions"},{"key":"C","text":"Termination and equipment limitations"},{"key":"D","text":"Installer preference only"},{"key":"E","text":"Conductor color alone"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Load, environment, installation conditions, and termination limitations all influence conductor selection.'),

(6,'situational_judgment','application',
'A proposed conductor size appears adequate for load current, but the connected equipment terminal is not suitable for that conductor configuration. What should happen?',
'[{"key":"A","text":"Resolve the conductor-to-terminal compatibility before installation"},{"key":"B","text":"Force the conductor into the terminal"},{"key":"C","text":"Remove strands"},{"key":"D","text":"Ignore the terminal limitation"}]'::jsonb,
'["A"]'::jsonb,
'An otherwise adequate conductor is not suitable if the termination method or equipment is incompatible.'),

(7,'multiple_choice','application',
'Why should a journeyman review conductor routing when multiple circuits are added to an existing raceway or cable pathway?',
'[{"key":"A","text":"The changed grouping and occupancy conditions may affect the suitability of the installation"},{"key":"B","text":"Added conductors always increase ampacity"},{"key":"C","text":"Existing pathways automatically accept unlimited conductors"},{"key":"D","text":"Routing affects only appearance"}]'::jsonb,
'["A"]'::jsonb,
'Added conductors can alter occupancy, thermal conditions, and installation constraints.'),

(8,'situational_judgment','application',
'A cable is approved for the intended electrical use but not for the environmental exposure present at the proposed route. What is the BEST response?',
'[{"key":"A","text":"Select a suitable cable or approved protection and routing method for the actual environment"},{"key":"B","text":"Install it because the electrical rating is adequate"},{"key":"C","text":"Paint the cable"},{"key":"D","text":"Increase conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Electrical capacity does not by itself establish environmental suitability.'),

(9,'multiple_choice','application',
'What is the BEST reason to document conductor identification and circuit relationships on complex installations?',
'[{"key":"A","text":"It supports correct termination, testing, future maintenance, and troubleshooting"},{"key":"B","text":"It increases conductor ampacity"},{"key":"C","text":"It eliminates testing"},{"key":"D","text":"It replaces drawings"}]'::jsonb,
'["A"]'::jsonb,
'Clear identification improves commissioning, troubleshooting, and future serviceability.'),

(10,'situational_judgment','application',
'A conductor termination shows signs of overheating during inspection. What should the journeyman do?',
'[{"key":"A","text":"Investigate conductor, terminal, connection condition, load, and applicable installation factors before returning it to service"},{"key":"B","text":"Tighten it randomly and energize"},{"key":"C","text":"Replace only the label"},{"key":"D","text":"Increase the overcurrent device rating"}]'::jsonb,
'["A"]'::jsonb,
'Overheating can result from connection, loading, compatibility, or conductor issues and requires systematic evaluation.'),

-- SCENARIO — 10

(11,'scenario','scenario',
'A feeder conductor is adequate by a basic ampacity check, but the route includes conditions that require additional adjustment. What should the journeyman conclude?',
'[{"key":"A","text":"The conductor must be reevaluated using the actual installation conditions before acceptance"},{"key":"B","text":"The basic ampacity check is always final"},{"key":"C","text":"Adjustment conditions can be ignored if the conductor is large"},{"key":"D","text":"Only voltage drop matters"}]'::jsonb,
'["A"]'::jsonb,
'Advanced conductor evaluation must account for all applicable installation conditions.'),

(12,'scenario','scenario',
'A long conductor run meets minimum ampacity requirements, but calculated and measured performance indicates excessive voltage drop for the intended equipment. What is the BEST response?',
'[{"key":"A","text":"Evaluate conductor size, route, load, and project performance requirements before finalizing the installation"},{"key":"B","text":"Ignore voltage drop because ampacity is adequate"},{"key":"C","text":"Increase overcurrent protection"},{"key":"D","text":"Reduce conductor insulation"}]'::jsonb,
'["A"]'::jsonb,
'Ampacity and voltage-drop performance are separate considerations that may both affect conductor selection.'),

(13,'scenario','scenario',
'An existing raceway is being reused for new conductors, but its current contents and circuit loading are poorly documented. What should happen first?',
'[{"key":"A","text":"Verify the existing conductors, circuit conditions, pathway occupancy, and applicable installation constraints before adding new conductors"},{"key":"B","text":"Add the new conductors if there is visible space"},{"key":"C","text":"Remove random existing conductors"},{"key":"D","text":"Assume the original installation has spare capacity"}]'::jsonb,
'["A"]'::jsonb,
'Existing pathway conditions should be established before new conductors are added.'),

(14,'situational_judgment','scenario',
'A cable tray route is changed in the field and now passes through a different environmental condition. What should the journeyman do?',
'[{"key":"A","text":"Reevaluate cable suitability, support, protection, and applicable installation requirements for the revised route"},{"key":"B","text":"Continue because cable size is unchanged"},{"key":"C","text":"Ignore environmental changes"},{"key":"D","text":"Use additional cable ties only"}]'::jsonb,
'["A"]'::jsonb,
'Changing the route can change environmental and mechanical conditions that affect cable suitability.'),

(15,'scenario','scenario',
'A large conductor is difficult to terminate because the equipment layout provides inadequate bending space. What is the BEST response?',
'[{"key":"A","text":"Reevaluate conductor routing, equipment entry, termination geometry, and approved installation options rather than forcing the conductor"},{"key":"B","text":"Sharply bend the conductor"},{"key":"C","text":"Cut away insulation"},{"key":"D","text":"Leave the terminal partially engaged"}]'::jsonb,
'["A"]'::jsonb,
'Large-conductor terminations require coordinated routing and adequate usable space.'),

(16,'scenario','scenario',
'A conductor shows repeated insulation damage at the same point during pulling. What should the journeyman investigate?',
'[{"key":"A","text":"The raceway, pull path, fittings, bend geometry, and pulling method for a recurring damage source"},{"key":"B","text":"Only the conductor manufacturer"},{"key":"C","text":"The circuit label"},{"key":"D","text":"The breaker handle position"}]'::jsonb,
'["A"]'::jsonb,
'Repeated damage at one location strongly suggests a problem in the pathway or pulling process.'),

(17,'scenario','scenario',
'Two parallel conductor sets are planned, but one route differs significantly in length and conditions from the other. What should the journeyman do?',
'[{"key":"A","text":"Evaluate whether the proposed parallel arrangement satisfies the applicable electrical and installation requirements before proceeding"},{"key":"B","text":"Install them because conductor sizes match"},{"key":"C","text":"Ignore the different route"},{"key":"D","text":"Shorten one conductor after installation"}]'::jsonb,
'["A"]'::jsonb,
'Parallel conductor arrangements require coordinated conductor characteristics and installation conditions.'),

(18,'situational_judgment','scenario',
'A crew discovers that a conductor type specified in the documents is not suitable for the actual wet location found in the field. What should the journeyman do?',
'[{"key":"A","text":"Stop the affected installation and coordinate a suitable conductor or revised installation method"},{"key":"B","text":"Install it because it was specified"},{"key":"C","text":"Wrap the conductor with general-purpose tape"},{"key":"D","text":"Ignore the wet condition"}]'::jsonb,
'["A"]'::jsonb,
'Field conditions can reveal suitability conflicts that must be resolved before installation.'),

(19,'scenario','scenario',
'Testing after installation suggests an unexpected conductor-to-conductor condition in a newly pulled circuit. What is the BEST response?',
'[{"key":"A","text":"Keep the circuit out of service and systematically investigate conductor identification, insulation condition, routing, and terminations"},{"key":"B","text":"Energize it briefly to see whether it clears"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Assume the test result is irrelevant"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected test results should be investigated before energization or acceptance.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 4 proficiency in Conductors & Cables?',
'[{"key":"A","text":"Selecting conductors only by nominal size"},{"key":"B","text":"Independently evaluating complex conductor selection, routing, environmental conditions, grouping, terminations, performance, and field changes while leading resolution of conflicts"},{"key":"C","text":"Ignoring terminal limitations when ampacity is adequate"},{"key":"D","text":"Using previous-project selections without verification"}]'::jsonb,
'["B"]'::jsonb,
'Level 4 performance means independently integrating conductor electrical requirements, installation conditions, equipment limitations, and field coordination.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b313405e-13ce-445b-b4ba-b238afafe9bb';
  v_apprentice_role_id uuid := 'a3807562-0a94-43a3-a7b5-2389573138d2';
  v_journeyman_role_id uuid := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60';
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
  where lower(i.slug) = 'electrical'
     or lower(i.name) = 'electrical'
  order by case when lower(i.slug) = 'electrical' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Electrical industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Conductors & Cables'
      and c.is_current = true
  ) then
    raise exception 'Current Conductors & Cables Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_apprentice_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Apprentice'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Electrician Apprentice L3 safety requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_journeyman_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Journeyman'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Electrician Journeyman L4 safety requirement not found';
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

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 4
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 3
      and s.application_count = 7
      and s.scenario_count = 10
  ) then
    raise exception 'Expected current L4 assessment standard 20 / 3 / 7 / 10 not found';
  end if;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Conductors & Cables — Level 2 Competency Assessment';

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
    select * from _seed_conductors_cables_l2_questions
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
        'Conductors & Cables',
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
      'IntegrateU Conductors & Cables L2 production assessment v1.0.',
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
        'Conductors & Cables',
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
        'IntegrateU Conductors & Cables L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 4
  -- ========================================================================

  v_level := 4;
  v_role_template_id := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid;
  v_assessment_name := 'Conductors & Cables — Level 4 Competency Assessment';

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
    select * from _seed_conductors_cables_l4_questions
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
        'Conductors & Cables',
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
      'IntegrateU Conductors & Cables L4 production assessment v1.0.',
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
        'Conductors & Cables',
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
        'IntegrateU Conductors & Cables L4 production assessment v1.0.',
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
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 4 -> 20 / 20 / 3 / 7 / 10
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (where aq.difficulty = 'foundational')::integer as foundational_count,
  count(distinct aq.id) filter (where aq.difficulty = 'application')::integer as application_count,
  count(distinct aq.id) filter (where aq.difficulty = 'scenario')::integer as scenario_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid
  and a.target_level in (2,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 2 Apprentice  -> 20
--   Level 4 Journeyman -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid
    and a.target_level in (2,4)
    and aq.master_competency_template_id =
      'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 2 and ra.master_role_template_id =
    'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid;

-- ============================================================================
-- VERIFICATION 4 — NO DUPLICATE CURRENT ASSESSMENTS PER TARGET LEVEL
-- Expected: zero rows
-- ============================================================================

select
  a.target_level,
  count(*) as current_assessment_count
from public.assessments a
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b313405e-13ce-445b-b4ba-b238afafe9bb'::uuid
  and a.target_level in (2,4)
group by a.target_level
having count(*) > 1;
