-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0101_transformers_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Transformers
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   Electrician Apprentice  -> Level 3
--   Electrician Journeyman -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_transformers_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_transformers_l1_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 8

(1,'multiple_choice','foundational',
'What is the primary purpose of a transformer in an electrical system?',
'[{"key":"A","text":"To change voltage and current relationships through electromagnetic induction"},{"key":"B","text":"To generate utility frequency"},{"key":"C","text":"To replace all overcurrent protection"},{"key":"D","text":"To eliminate grounding"}]'::jsonb,
'["A"]'::jsonb,
'Transformers transfer electrical energy between windings and commonly change voltage and current relationships.'),

(2,'multiple_choice','foundational',
'What do the primary and secondary windings of a transformer represent?',
'[{"key":"A","text":"The input and output winding sides of the transformer"},{"key":"B","text":"Two grounding electrodes"},{"key":"C","text":"Two overcurrent devices"},{"key":"D","text":"Two mechanical supports"}]'::jsonb,
'["A"]'::jsonb,
'The primary winding is connected to the source side and the secondary winding supplies the transformed output.'),

(3,'multiple_choice','foundational',
'If a transformer reduces voltage from primary to secondary, what general type of transformer action is occurring?',
'[{"key":"A","text":"Step-down"},{"key":"B","text":"Step-up"},{"key":"C","text":"Isolation from frequency"},{"key":"D","text":"Overcurrent multiplication"}]'::jsonb,
'["A"]'::jsonb,
'A transformer that produces a lower secondary voltage than primary voltage is operating in a step-down application.'),

(4,'multiple_choice','foundational',
'What is a transformer nameplate used for?',
'[{"key":"A","text":"To identify ratings and connection information needed for proper application"},{"key":"B","text":"To replace electrical drawings"},{"key":"C","text":"To determine conductor color only"},{"key":"D","text":"To eliminate testing"}]'::jsonb,
'["A"]'::jsonb,
'The nameplate provides essential transformer rating and connection information.'),

(5,'multiple_choice','foundational',
'Why is transformer voltage rating important?',
'[{"key":"A","text":"The transformer must be suitable for the actual source and load voltage requirements"},{"key":"B","text":"Voltage rating affects only enclosure size"},{"key":"C","text":"Any transformer can be connected to any voltage"},{"key":"D","text":"Voltage rating replaces load calculations"}]'::jsonb,
'["A"]'::jsonb,
'Primary and secondary voltage ratings must match the intended system application.'),

(6,'multiple_choice','foundational',
'What does transformer kVA rating generally describe?',
'[{"key":"A","text":"The apparent-power capacity of the transformer"},{"key":"B","text":"The conductor insulation color"},{"key":"C","text":"The enclosure dimensions only"},{"key":"D","text":"The system frequency alone"}]'::jsonb,
'["A"]'::jsonb,
'Transformer capacity is commonly expressed as apparent power in volt-amperes or kilovolt-amperes.'),

(7,'multiple_choice','foundational',
'Why do transformers require ventilation or heat dissipation?',
'[{"key":"A","text":"Transformer operation produces heat that must be managed within equipment limits"},{"key":"B","text":"Ventilation increases system frequency"},{"key":"C","text":"Ventilation replaces grounding"},{"key":"D","text":"Heat always increases transformer capacity"}]'::jsonb,
'["A"]'::jsonb,
'Transformers generate heat during operation and must be installed so that heat can dissipate appropriately.'),

(8,'multiple_choice','foundational',
'Why must transformer terminals and connections be clearly identified?',
'[{"key":"A","text":"To support correct primary, secondary, and winding connections"},{"key":"B","text":"To increase transformer kVA"},{"key":"C","text":"To eliminate overcurrent protection"},{"key":"D","text":"To change the turns ratio"}]'::jsonb,
'["A"]'::jsonb,
'Correct terminal identification is essential for proper transformer connections.'),

-- APPLICATION — 8

(9,'situational_judgment','application',
'A transformer nameplate voltage does not match the planned source voltage. What is the BEST response?',
'[{"key":"A","text":"Stop and verify transformer suitability before making the connection"},{"key":"B","text":"Connect it anyway and check voltage afterward"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Change conductor color"}]'::jsonb,
'["A"]'::jsonb,
'A transformer should not be connected until its voltage ratings are confirmed suitable for the system.'),

(10,'multiple_choice','application',
'Why should transformer loading remain within its applicable rating?',
'[{"key":"A","text":"Excess loading can cause overheating and equipment damage"},{"key":"B","text":"Overloading improves efficiency"},{"key":"C","text":"Loading affects only labeling"},{"key":"D","text":"A larger breaker removes all loading limits"}]'::jsonb,
'["A"]'::jsonb,
'Transformer loading must stay within appropriate equipment limits to avoid overheating and damage.'),

(11,'situational_judgment','application',
'A dry-type transformer is installed where stored materials block its ventilation openings. What should happen?',
'[{"key":"A","text":"Restore required clearance and ventilation around the transformer"},{"key":"B","text":"Leave the materials if the transformer is still operating"},{"key":"C","text":"Increase the transformer fuse size"},{"key":"D","text":"Cover the ventilation openings"}]'::jsonb,
'["A"]'::jsonb,
'Transformer ventilation should not be obstructed because heat dissipation is necessary for reliable operation.'),

(12,'multiple_select','application',
'Which THREE items should be checked before making routine transformer connections?',
'[{"key":"A","text":"Nameplate voltage and rating"},{"key":"B","text":"Terminal identification"},{"key":"C","text":"Planned source and load connections"},{"key":"D","text":"Paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Ratings, terminal identification, and planned system connections should be verified before wiring a transformer.'),

(13,'multiple_choice','application',
'Why should transformer grounding and bonding connections be installed correctly?',
'[{"key":"A","text":"They support the intended fault-current path and system grounding arrangement"},{"key":"B","text":"They increase kVA rating"},{"key":"C","text":"They change the turns ratio"},{"key":"D","text":"They eliminate overcurrent protection"}]'::jsonb,
'["A"]'::jsonb,
'Grounding and bonding are part of the transformer installation and electrical safety system.'),

(14,'situational_judgment','application',
'A transformer produces an unexpected secondary voltage after installation. What is the BEST response?',
'[{"key":"A","text":"Stop and verify source voltage, winding connections, tap settings, and transformer ratings"},{"key":"B","text":"Increase the secondary breaker size"},{"key":"C","text":"Ignore the reading if equipment still operates"},{"key":"D","text":"Reverse grounding connections"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected secondary voltage should prompt verification of the transformer and its connections before use.'),

(15,'multiple_choice','application',
'Why should transformer mounting and support be suitable for the equipment?',
'[{"key":"A","text":"The transformer must be securely supported and installed for its weight and operating conditions"},{"key":"B","text":"Support changes the turns ratio"},{"key":"C","text":"Mounting increases voltage"},{"key":"D","text":"Support eliminates ventilation requirements"}]'::jsonb,
'["A"]'::jsonb,
'Transformer installations require adequate physical support as well as correct electrical connections.'),

(16,'situational_judgment','application',
'You notice unusual noise and excessive heat from a transformer during operation. What is the BEST Level 1 response?',
'[{"key":"A","text":"Report the abnormal condition and have it evaluated rather than assuming it is normal"},{"key":"B","text":"Increase the load"},{"key":"C","text":"Block the ventilation openings"},{"key":"D","text":"Install a larger protective device"}]'::jsonb,
'["A"]'::jsonb,
'Abnormal heat or noise can indicate loading, connection, or equipment problems requiring evaluation.'),

-- SCENARIO — 4

(17,'scenario','scenario',
'A transformer secondary voltage is much lower than expected. What should a Level 1 worker do?',
'[{"key":"A","text":"Avoid changing connections without direction and escalate the condition for qualified troubleshooting"},{"key":"B","text":"Move random conductors between terminals"},{"key":"C","text":"Increase the primary breaker size"},{"key":"D","text":"Ignore the condition"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected transformer output should be investigated by qualified personnel rather than corrected by guesswork.'),

(18,'scenario','scenario',
'A transformer has visible signs of overheating around one terminal. What is the BEST response?',
'[{"key":"A","text":"Keep the condition from normal service and escalate it for evaluation"},{"key":"B","text":"Tighten the terminal while energized"},{"key":"C","text":"Increase transformer loading"},{"key":"D","text":"Cover the discoloration"}]'::jsonb,
'["A"]'::jsonb,
'Visible overheating can indicate a serious connection or loading issue and should be evaluated.'),

(19,'scenario','scenario',
'A transformer installation has no readable nameplate information. What should happen before it is connected?',
'[{"key":"A","text":"The transformer ratings and connection information must be reliably established before use"},{"key":"B","text":"Connect it based on physical size"},{"key":"C","text":"Use any convenient voltage"},{"key":"D","text":"Install the largest available breaker"}]'::jsonb,
'["A"]'::jsonb,
'Transformer application depends on known ratings and connection information.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Transformers?',
'[{"key":"A","text":"Changing winding connections without verifying ratings"},{"key":"B","text":"Recognizing basic transformer purpose, ratings, terminals, ventilation, loading concerns, and abnormal conditions that require escalation"},{"key":"C","text":"Ignoring unexpected secondary voltage"},{"key":"D","text":"Using breaker size to determine transformer voltage"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance centers on recognizing basic transformer functions and installation conditions while escalating abnormal situations.');

create temporary table _seed_transformers_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_transformers_l3_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 4

(1,'multiple_choice','foundational',
'What primarily determines the voltage relationship between transformer windings?',
'[{"key":"A","text":"The turns ratio between the windings"},{"key":"B","text":"The enclosure color"},{"key":"C","text":"The mounting height"},{"key":"D","text":"The breaker handle position"}]'::jsonb,
'["A"]'::jsonb,
'Transformer voltage relationships are fundamentally tied to the winding turns ratio.'),

(2,'multiple_choice','foundational',
'Why must transformer kVA capacity be evaluated together with expected load?',
'[{"key":"A","text":"The transformer must be capable of supplying the intended apparent-power demand without improper overloading"},{"key":"B","text":"kVA affects only labeling"},{"key":"C","text":"Any transformer can supply any load if voltage matches"},{"key":"D","text":"Load has no effect on transformer heating"}]'::jsonb,
'["A"]'::jsonb,
'Transformer capacity and connected load must be compatible for reliable operation.'),

(3,'multiple_choice','foundational',
'Why can transformer connection configuration affect secondary system voltage and phase relationships?',
'[{"key":"A","text":"Winding connections determine how individual winding voltages combine and relate electrically"},{"key":"B","text":"Connections affect only enclosure temperature"},{"key":"C","text":"All connection configurations produce identical outputs"},{"key":"D","text":"Only conductor color controls phase relationships"}]'::jsonb,
'["A"]'::jsonb,
'Transformer winding configurations directly affect available system voltages and phase relationships.'),

(4,'multiple_choice','foundational',
'Why should a journeyman understand the grounding arrangement associated with a transformer-supplied system?',
'[{"key":"A","text":"Transformer system configuration can establish grounding, bonding, fault-current, and neutral relationships that must be applied correctly"},{"key":"B","text":"Grounding affects only equipment appearance"},{"key":"C","text":"Transformer systems never require grounding review"},{"key":"D","text":"Grounding replaces secondary overcurrent protection"}]'::jsonb,
'["A"]'::jsonb,
'Transformer applications can create system grounding and bonding relationships that must be understood and installed correctly.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A transformer is being selected for a new load. What should the journeyman evaluate?',
'[{"key":"A","text":"Primary and secondary voltage, phase, kVA demand, load characteristics, system configuration, and installation conditions"},{"key":"B","text":"Only physical size"},{"key":"C","text":"Only enclosure color"},{"key":"D","text":"Only the available breaker space"}]'::jsonb,
'["A"]'::jsonb,
'Transformer selection requires matching electrical ratings and actual load and installation conditions.'),

(6,'multiple_select','application',
'Which THREE items commonly belong in a transformer installation review?',
'[{"key":"A","text":"Voltage and kVA ratings"},{"key":"B","text":"Winding and terminal configuration"},{"key":"C","text":"Grounding, bonding, ventilation, and installation environment"},{"key":"D","text":"Panel paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Transformer installation review integrates electrical ratings, winding configuration, grounding and bonding, and environmental conditions.'),

(7,'situational_judgment','application',
'The available source voltage matches the transformer nameplate, but the planned secondary connection does not provide the load voltage needed. What should happen?',
'[{"key":"A","text":"Reevaluate the transformer configuration and application before installation"},{"key":"B","text":"Install it and increase the secondary breaker"},{"key":"C","text":"Change conductor colors"},{"key":"D","text":"Assume the equipment will adapt"}]'::jsonb,
'["A"]'::jsonb,
'Correct source voltage alone does not prove the transformer connection will provide the required secondary system.'),

(8,'multiple_choice','application',
'Why should transformer tap settings be verified before energization where taps are provided?',
'[{"key":"A","text":"Tap selection can affect the voltage relationship and resulting secondary voltage"},{"key":"B","text":"Tap settings change kVA labeling only"},{"key":"C","text":"Tap settings eliminate loading limits"},{"key":"D","text":"Taps control grounding conductor color"}]'::jsonb,
'["A"]'::jsonb,
'Transformer taps can adjust the winding relationship and therefore affect output voltage.'),

(9,'situational_judgment','application',
'A transformer serving new equipment appears adequately sized by steady-state load, but the equipment has significant starting demand. What should the journeyman do?',
'[{"key":"A","text":"Evaluate the transformer and system application for the actual load characteristics, including starting conditions"},{"key":"B","text":"Ignore starting demand"},{"key":"C","text":"Increase only the breaker size"},{"key":"D","text":"Use a smaller transformer"}]'::jsonb,
'["A"]'::jsonb,
'Load characteristics beyond steady-state demand can affect transformer application and performance.'),

(10,'multiple_choice','application',
'What is the BEST reason to verify transformer terminal torque or manufacturer connection requirements?',
'[{"key":"A","text":"Proper terminations affect reliability, heating, and equipment integrity"},{"key":"B","text":"Torque changes the turns ratio"},{"key":"C","text":"Torque determines source voltage"},{"key":"D","text":"Torque replaces conductor sizing"}]'::jsonb,
'["A"]'::jsonb,
'Transformer terminations should follow applicable manufacturer and equipment connection requirements.'),

(11,'situational_judgment','application',
'An existing transformer is being reused for a different load. What should happen before it is accepted?',
'[{"key":"A","text":"Verify transformer ratings, configuration, condition, load suitability, grounding, protection, and installation environment for the new application"},{"key":"B","text":"Reuse it because it operated previously"},{"key":"C","text":"Only repaint the enclosure"},{"key":"D","text":"Increase protective-device ratings"}]'::jsonb,
'["A"]'::jsonb,
'Previous service does not prove suitability for a different electrical application.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A transformer is delivering the correct no-load secondary voltage but voltage drops excessively under load. What is the BEST approach?',
'[{"key":"A","text":"Evaluate loading, transformer capacity, source conditions, connections, conductors, and equipment condition systematically"},{"key":"B","text":"Increase the breaker size"},{"key":"C","text":"Ignore the condition because no-load voltage is correct"},{"key":"D","text":"Change conductor identification"}]'::jsonb,
'["A"]'::jsonb,
'Voltage behavior under load can reveal loading, connection, source, conductor, or transformer problems.'),

(13,'scenario','scenario',
'A three-phase transformer installation has unexpected secondary phase-to-phase voltages after connection. What should the journeyman do?',
'[{"key":"A","text":"Keep the system from service and verify source voltage, winding configuration, terminal connections, taps, and transformer ratings"},{"key":"B","text":"Swap random secondary conductors while energized"},{"key":"C","text":"Increase secondary protection"},{"key":"D","text":"Assume the load will correct the voltage"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected secondary voltages require systematic verification of the transformer configuration and connections.'),

(14,'scenario','scenario',
'A transformer repeatedly overheats even though measured load appears below its nameplate kVA. What should the journeyman investigate?',
'[{"key":"A","text":"Ventilation, ambient conditions, load characteristics, connections, voltage conditions, harmonic effects where relevant, and transformer condition"},{"key":"B","text":"Only the enclosure paint"},{"key":"C","text":"Increase the transformer breaker size"},{"key":"D","text":"Block airflow to reduce dust"}]'::jsonb,
'["A"]'::jsonb,
'Transformer overheating can result from more than simple apparent-power loading and requires broader evaluation.'),

(15,'situational_judgment','scenario',
'A replacement transformer has the correct kVA rating but different primary and secondary voltage ratings from the original. What should the journeyman conclude?',
'[{"key":"A","text":"Matching kVA alone is insufficient; the transformer must be suitable for the actual system voltage and configuration"},{"key":"B","text":"Install it because kVA matches"},{"key":"C","text":"Use larger fuses"},{"key":"D","text":"Change only the labels"}]'::jsonb,
'["A"]'::jsonb,
'Transformer replacement requires compatibility across voltage, phase, configuration, capacity, and application requirements.'),

(16,'scenario','scenario',
'A transformer secondary system has an unexpected neutral-to-ground condition downstream. What is the BEST response?',
'[{"key":"A","text":"Evaluate the transformer grounding and bonding arrangement and downstream neutral-ground relationships before returning the system to service"},{"key":"B","text":"Bond neutral and ground everywhere"},{"key":"C","text":"Remove all equipment grounding conductors"},{"key":"D","text":"Increase transformer kVA"}]'::jsonb,
'["A"]'::jsonb,
'Transformer-supplied systems require correct grounding and bonding relationships to avoid improper current paths.'),

(17,'scenario','scenario',
'A facility wants to add substantial new load to an existing transformer with limited documentation. What should happen first?',
'[{"key":"A","text":"Establish transformer ratings, existing loading, system configuration, protection, and actual operating conditions before approving the added load"},{"key":"B","text":"Add the load if physical terminals are available"},{"key":"C","text":"Increase protective-device sizes"},{"key":"D","text":"Assume spare capacity exists"}]'::jsonb,
'["A"]'::jsonb,
'Available connection points do not establish available transformer capacity.'),

(18,'scenario','scenario',
'A transformer was connected according to an old drawing, but field verification shows its winding terminal arrangement differs from the drawing. What should the journeyman do?',
'[{"key":"A","text":"Stop and reconcile the actual transformer nameplate and terminal configuration with the intended design before energization"},{"key":"B","text":"Follow the old drawing regardless"},{"key":"C","text":"Energize briefly to determine the connection"},{"key":"D","text":"Increase overcurrent protection"}]'::jsonb,
'["A"]'::jsonb,
'Actual equipment information must control when documentation conflicts with the installed transformer.'),

(19,'scenario','scenario',
'A transformer produces persistent abnormal vibration and noise after a system modification. What is the BEST approach?',
'[{"key":"A","text":"Evaluate mounting, connections, voltage, loading, system conditions, and transformer condition rather than assuming the noise is normal"},{"key":"B","text":"Increase the load"},{"key":"C","text":"Loosen the mounting hardware"},{"key":"D","text":"Ignore it if voltage is present"}]'::jsonb,
'["A"]'::jsonb,
'Abnormal transformer noise and vibration can indicate mechanical or electrical problems that require investigation.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Transformers?',
'[{"key":"A","text":"Recognizing transformer nameplates only"},{"key":"B","text":"Independently evaluating transformer voltage relationships, connections, loading, grounding and bonding, protection, installation conditions, and abnormal performance while resolving field conflicts"},{"key":"C","text":"Selecting transformers only by physical size"},{"key":"D","text":"Increasing protective-device ratings when transformers overheat"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently applying transformer principles to selection, installation, verification, troubleshooting, and field coordination.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '75b217dd-53f8-4157-a82d-8b4b51232f3c';
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
      and c.name = 'Transformers'
      and c.is_current = true
  ) then
    raise exception 'Current Transformers Master Competency not found';
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
      and mrcr.required_level = 1
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Electrician Journeyman L4 safety requirement not found';
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

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
  end if;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 1;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Transformers — Level 1 Competency Assessment';

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
    select * from _seed_transformers_l1_questions
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
        'Transformers',
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
      'IntegrateU Transformers L1 production assessment v1.0.',
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
        'Transformers',
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
        'IntegrateU Transformers L1 production assessment v1.0.',
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

  v_level := 3;
  v_role_template_id := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid;
  v_assessment_name := 'Transformers — Level 3 Competency Assessment';

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
    select * from _seed_transformers_l3_questions
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
        'Transformers',
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
      'IntegrateU Transformers L3 production assessment v1.0.',
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
        'Transformers',
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
        'IntegrateU Transformers L3 production assessment v1.0.',
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
--   Level 3 -> 20 / 20 / 4 / 7 / 9
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
   '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid
  and a.target_level in (3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 3 Apprentice  -> 20
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
      '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 3 and ra.master_role_template_id =
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
  '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid;

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
    '75b217dd-53f8-4157-a82d-8b4b51232f3c'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
