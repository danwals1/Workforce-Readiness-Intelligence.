-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0105_lighting_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Lighting Systems
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Electrician Apprentice  -> Level 2
--   Electrician Journeyman -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_lighting_systems_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_lighting_systems_l2_questions (
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
'What is the primary function of a lighting fixture or luminaire?',
'[{"key":"A","text":"To support and control a light source and distribute light as intended"},{"key":"B","text":"To replace branch-circuit protection"},{"key":"C","text":"To increase service voltage"},{"key":"D","text":"To eliminate switching"}]'::jsonb,
'["A"]'::jsonb,
'A luminaire houses or supports the light-producing components and directs light for the intended application.'),

(2,'multiple_choice','foundational',
'What is the purpose of an LED driver in many lighting systems?',
'[{"key":"A","text":"To provide the electrical conditions required by the LED load"},{"key":"B","text":"To replace the branch circuit"},{"key":"C","text":"To increase conductor ampacity"},{"key":"D","text":"To eliminate grounding"}]'::jsonb,
'["A"]'::jsonb,
'LED drivers convert and regulate electrical power for the LED components they serve.'),

(3,'multiple_choice','foundational',
'What is the purpose of a ballast in a lighting system that uses one?',
'[{"key":"A","text":"To regulate electrical conditions for the connected lamp"},{"key":"B","text":"To act as the service disconnect"},{"key":"C","text":"To replace all controls"},{"key":"D","text":"To increase utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'Ballasts control current and operating conditions for compatible lamp types.'),

(4,'multiple_choice','foundational',
'Why must replacement lamps, drivers, or ballasts be compatible with the fixture and control system?',
'[{"key":"A","text":"Incorrect components can cause poor operation, damage, or unsafe conditions"},{"key":"B","text":"Compatibility affects only appearance"},{"key":"C","text":"Any component with the same shape is acceptable"},{"key":"D","text":"Compatibility matters only outdoors"}]'::jsonb,
'["A"]'::jsonb,
'Lighting components must match the electrical and control characteristics of the system.'),

(5,'multiple_choice','foundational',
'Why should lighting equipment be properly supported?',
'[{"key":"A","text":"To prevent mechanical failure and maintain the intended installation"},{"key":"B","text":"To increase lamp wattage"},{"key":"C","text":"To change circuit voltage"},{"key":"D","text":"To eliminate equipment grounding"}]'::jsonb,
'["A"]'::jsonb,
'Proper support prevents fixtures and associated components from becoming mechanically unsafe.'),

(6,'situational_judgment','application',
'A replacement LED driver has the correct physical size but different input and output ratings. What should you do?',
'[{"key":"A","text":"Verify electrical compatibility before installing it"},{"key":"B","text":"Install it because it fits"},{"key":"C","text":"Increase the branch breaker"},{"key":"D","text":"Remove the fixture label"}]'::jsonb,
'["A"]'::jsonb,
'Physical fit does not establish electrical compatibility.'),

(7,'multiple_choice','application',
'A lighting circuit operates normally from one switch location but not another in a multi-location control arrangement. What should be checked?',
'[{"key":"A","text":"The control devices, conductors, terminations, and intended switching configuration"},{"key":"B","text":"Only the lamp wattage"},{"key":"C","text":"Only the panel directory"},{"key":"D","text":"The service grounding electrode"}]'::jsonb,
'["A"]'::jsonb,
'Multi-location lighting control depends on correct devices, wiring, and terminations.'),

(8,'situational_judgment','application',
'A fixture flickers after a new dimmer is installed. What is the BEST next step?',
'[{"key":"A","text":"Verify dimmer, lamp or driver compatibility and the associated wiring"},{"key":"B","text":"Increase the breaker size"},{"key":"C","text":"Bypass the grounding conductor"},{"key":"D","text":"Ignore the flicker"}]'::jsonb,
'["A"]'::jsonb,
'Flicker after a control change commonly warrants checking compatibility and wiring.'),

(9,'multiple_select','application',
'Which THREE items should be verified when replacing a lighting fixture?',
'[{"key":"A","text":"Circuit voltage and fixture rating"},{"key":"B","text":"Support and mounting suitability"},{"key":"C","text":"Grounding and conductor connections"},{"key":"D","text":"Wall paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Fixture replacement requires electrical compatibility, proper support, and correct connections.'),

(10,'situational_judgment','application',
'A recessed light shows evidence of overheating around the housing. What should happen?',
'[{"key":"A","text":"Stop treating the condition as normal and evaluate fixture rating, installation, insulation clearance, lamp or driver, and connections"},{"key":"B","text":"Install a higher-wattage lamp"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Paint over the discoloration"}]'::jsonb,
'["A"]'::jsonb,
'Overheating can indicate improper component selection, installation conditions, or electrical problems.'),

(11,'multiple_choice','application',
'Why should lighting control conductors be identified accurately during installation and service?',
'[{"key":"A","text":"To support correct connections, troubleshooting, and future maintenance"},{"key":"B","text":"To increase circuit capacity"},{"key":"C","text":"To eliminate testing"},{"key":"D","text":"To change fixture output"}]'::jsonb,
'["A"]'::jsonb,
'Accurate conductor identification reduces control-wiring errors and supports future service.'),

(12,'situational_judgment','application',
'A fixture does not operate after installation, but branch-circuit voltage is present at the fixture location. What should be checked next?',
'[{"key":"A","text":"Fixture connections, lamp or LED module, driver or ballast, controls, and neutral path as applicable"},{"key":"B","text":"Increase the panel main"},{"key":"C","text":"Replace the grounding electrode"},{"key":"D","text":"Ignore the neutral"}]'::jsonb,
'["A"]'::jsonb,
'Voltage at the location narrows troubleshooting toward the fixture, control, neutral, and internal components.'),

(13,'multiple_choice','application',
'Why should lighting fixtures installed in damp or wet locations be selected for the environment?',
'[{"key":"A","text":"The fixture must be suitable for the moisture exposure it will experience"},{"key":"B","text":"Environmental ratings affect only color"},{"key":"C","text":"Any indoor fixture is acceptable outdoors"},{"key":"D","text":"Moisture has no effect on lighting equipment"}]'::jsonb,
'["A"]'::jsonb,
'Environmental suitability is necessary for safe and reliable lighting equipment operation.'),

(14,'situational_judgment','application',
'A fixture is repeatedly failing shortly after replacement. What is the BEST response?',
'[{"key":"A","text":"Investigate voltage, component compatibility, heat, connections, control behavior, and installation conditions"},{"key":"B","text":"Keep replacing the fixture without investigation"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Remove the equipment grounding conductor"}]'::jsonb,
'["A"]'::jsonb,
'Repeated failures indicate an underlying condition that should be diagnosed rather than repeatedly replacing components.'),

(15,'multiple_choice','scenario',
'A room has new LED fixtures controlled by an older dimmer. The lights shimmer and do not dim smoothly. What is the BEST approach?',
'[{"key":"A","text":"Verify that the dimmer and LED drivers or lamps are designed to operate together"},{"key":"B","text":"Increase branch-circuit voltage"},{"key":"C","text":"Replace the grounding conductor with a larger one"},{"key":"D","text":"Bypass the dimmer permanently without evaluation"}]'::jsonb,
'["A"]'::jsonb,
'LED dimming performance depends strongly on control and driver compatibility.'),

(16,'scenario','scenario',
'Several fixtures on one lighting circuit are out, while others remain operational. What is the BEST troubleshooting approach?',
'[{"key":"A","text":"Use the circuit layout and systematic testing to locate the point where the supply or control path changes"},{"key":"B","text":"Replace every fixture"},{"key":"C","text":"Increase the breaker rating"},{"key":"D","text":"Assume the panel is defective"}]'::jsonb,
'["A"]'::jsonb,
'Systematic sectional troubleshooting can identify where the lighting circuit stops operating correctly.'),

(17,'scenario','scenario',
'A lighting fixture is securely mounted, but the branch conductors are strained at the connection point. What should happen?',
'[{"key":"A","text":"Correct the conductor routing or support so connections are not under improper mechanical strain"},{"key":"B","text":"Leave it because the fixture is secure"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Remove the grounding connection"}]'::jsonb,
'["A"]'::jsonb,
'Electrical terminations should not be subjected to avoidable mechanical strain.'),

(18,'scenario','scenario',
'A lighting-control replacement works manually but no longer responds to its intended sensor or automatic control. What should be verified?',
'[{"key":"A","text":"Control compatibility, wiring, programming or settings, and the sensor or control input"},{"key":"B","text":"Only fixture mounting"},{"key":"C","text":"Only breaker size"},{"key":"D","text":"Only equipment grounding"}]'::jsonb,
'["A"]'::jsonb,
'Automatic lighting controls require correct wiring, compatibility, settings, and control inputs.'),

(19,'scenario','scenario',
'Exterior lighting works when tested during the day but does not operate automatically at night. What should be checked?',
'[{"key":"A","text":"Photocell or sensor operation, control settings, wiring, and source availability"},{"key":"B","text":"Increase lamp wattage"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Remove the control device"}]'::jsonb,
'["A"]'::jsonb,
'Automatic exterior lighting depends on the control device, settings, and associated wiring.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Lighting Systems?',
'[{"key":"A","text":"Replacing parts based only on physical fit"},{"key":"B","text":"Correctly installing, connecting, verifying, and troubleshooting common fixtures, lamps, drivers, ballasts, controls, and lighting circuits while recognizing compatibility and abnormal conditions"},{"key":"C","text":"Increasing breaker sizes when fixtures fail"},{"key":"D","text":"Ignoring control compatibility"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means competently installing and servicing common lighting-system components using correct ratings, wiring, controls, and troubleshooting practices.');

create temporary table _seed_lighting_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_lighting_systems_l3_questions (
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
'Why must lighting-system design consider the interaction among fixtures, drivers, controls, branch circuits, and environmental conditions?',
'[{"key":"A","text":"The components operate as an integrated system and incompatibility can affect safety, performance, and reliability"},{"key":"B","text":"Only fixture wattage matters"},{"key":"C","text":"Controls are electrically independent of fixtures"},{"key":"D","text":"Environmental conditions affect appearance only"}]'::jsonb,
'["A"]'::jsonb,
'Advanced lighting work requires understanding the lighting system as an interacting combination of electrical and control components.'),

(2,'multiple_choice','foundational',
'Why can LED lighting introduce different troubleshooting considerations than simple resistive lighting loads?',
'[{"key":"A","text":"Electronic drivers and controls can introduce compatibility, inrush, leakage, dimming, and power-quality behaviors"},{"key":"B","text":"LED systems contain no electronics"},{"key":"C","text":"LED fixtures never fail intermittently"},{"key":"D","text":"LED loads eliminate circuit calculations"}]'::jsonb,
'["A"]'::jsonb,
'Electronic lighting equipment can behave differently from simpler traditional loads.'),

(3,'multiple_choice','foundational',
'Why should a journeyman distinguish line-voltage switching from low-voltage or networked lighting control?',
'[{"key":"A","text":"The control architecture affects wiring, devices, troubleshooting, commissioning, and system behavior"},{"key":"B","text":"All control systems use identical wiring"},{"key":"C","text":"Control architecture affects only labels"},{"key":"D","text":"Low-voltage controls replace branch circuits"}]'::jsonb,
'["A"]'::jsonb,
'Different lighting-control architectures require different installation and diagnostic approaches.'),

(4,'multiple_choice','foundational',
'Why should lighting-system changes be evaluated for total connected load and control compatibility rather than fixture count alone?',
'[{"key":"A","text":"Fixtures can have different electrical characteristics, inrush behavior, drivers, and control requirements"},{"key":"B","text":"All fixtures have identical electrical behavior"},{"key":"C","text":"Fixture count alone determines branch-circuit capacity"},{"key":"D","text":"Controls never affect loading"}]'::jsonb,
'["A"]'::jsonb,
'Lighting-system capacity and behavior depend on electrical characteristics, not simply the number of fixtures.'),

(5,'situational_judgment','application',
'A project replaces fluorescent fixtures with LED retrofit equipment while retaining existing controls. What should the journeyman verify?',
'[{"key":"A","text":"Voltage, retrofit compatibility, control compatibility, wiring configuration, loading, and equipment condition"},{"key":"B","text":"Only fixture dimensions"},{"key":"C","text":"Only lamp color temperature"},{"key":"D","text":"Only breaker size"}]'::jsonb,
'["A"]'::jsonb,
'A retrofit can change electrical and control characteristics even when the physical fixture remains.'),

(6,'multiple_select','application',
'Which THREE items commonly belong in a Level 3 lighting-system review?',
'[{"key":"A","text":"Fixture and driver ratings and compatibility"},{"key":"B","text":"Control architecture and sequence of operation"},{"key":"C","text":"Circuit loading, wiring, environment, and installation conditions"},{"key":"D","text":"Decorative preferences only"},{"key":"E","text":"Installer brand preference"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced lighting review integrates equipment, controls, circuit conditions, and the installation environment.'),

(7,'situational_judgment','application',
'A large LED lighting circuit trips a breaker only when all fixtures energize simultaneously. What should the journeyman evaluate?',
'[{"key":"A","text":"Steady-state load, driver inrush current, protective-device characteristics, grouping, and equipment condition"},{"key":"B","text":"Only fixture color"},{"key":"C","text":"Increase the breaker automatically"},{"key":"D","text":"Remove equipment grounding"}]'::jsonb,
'["A"]'::jsonb,
'Electronic lighting drivers can create startup conditions that differ significantly from steady-state load.'),

(8,'multiple_choice','application',
'Why should control sequence be verified during commissioning of occupancy-sensor or daylight-controlled lighting?',
'[{"key":"A","text":"Correct devices can still produce incorrect operation if settings, zones, or control logic are wrong"},{"key":"B","text":"Commissioning changes conductor ampacity"},{"key":"C","text":"Controls require no settings"},{"key":"D","text":"Sequence affects only labels"}]'::jsonb,
'["A"]'::jsonb,
'Lighting controls require functional verification in addition to correct physical installation.'),

(9,'situational_judgment','application',
'A group of dimmable fixtures operates correctly at full output but becomes unstable at low dimming levels. What should be reviewed?',
'[{"key":"A","text":"Driver and dimmer compatibility, minimum load, control method, wiring, programming, and manufacturer operating range"},{"key":"B","text":"Only branch breaker size"},{"key":"C","text":"Only fixture mounting"},{"key":"D","text":"Increase service voltage"}]'::jsonb,
'["A"]'::jsonb,
'Low-end dimming instability can result from compatibility, control, load, or configuration issues.'),

(10,'situational_judgment','application',
'Lighting plans call for a fixture type that conflicts with the actual ceiling and environmental conditions. What should the journeyman do?',
'[{"key":"A","text":"Resolve the fixture, support, environmental, and installation requirements before proceeding"},{"key":"B","text":"Install it exactly as drawn regardless of field conditions"},{"key":"C","text":"Modify the fixture without approval"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Field conflicts should be reconciled before installation so the fixture remains suitable and properly supported.'),

(11,'situational_judgment','application',
'An existing lighting control panel is being extended to new fixtures. What should be verified first?',
'[{"key":"A","text":"Control-panel capacity, circuit and control compatibility, addressing or zoning, power requirements, and sequence of operation"},{"key":"B","text":"Only the number of empty terminals"},{"key":"C","text":"Only fixture color"},{"key":"D","text":"Only panel enclosure size"}]'::jsonb,
'["A"]'::jsonb,
'Extending a lighting-control system requires evaluating both electrical capacity and control-system architecture.'),

(12,'scenario','scenario',
'An office lighting system intermittently turns off occupied areas even though fixtures and branch circuits test normally. What is the BEST troubleshooting direction?',
'[{"key":"A","text":"Investigate occupancy sensors, control logic, timing, communications, zoning, and programmed sequence"},{"key":"B","text":"Replace all fixtures"},{"key":"C","text":"Increase branch breakers"},{"key":"D","text":"Replace the service disconnect"}]'::jsonb,
'["A"]'::jsonb,
'When power circuits and fixtures are healthy, intermittent area-wide behavior may point to the lighting-control system.'),

(13,'scenario','scenario',
'A newly installed LED lighting system produces nuisance operation on controls that worked with the previous fixtures. What should the journeyman evaluate?',
'[{"key":"A","text":"Electronic-driver characteristics, control compatibility, leakage or inrush behavior, wiring, and device ratings"},{"key":"B","text":"Only fixture appearance"},{"key":"C","text":"Increase all control ratings without calculation"},{"key":"D","text":"Remove neutral conductors"}]'::jsonb,
'["A"]'::jsonb,
'Changing lighting technology can alter the electrical behavior seen by existing controls.'),

(14,'scenario','scenario',
'Several fixtures at the end of a long lighting run are noticeably dimmer than fixtures near the source. What should be evaluated?',
'[{"key":"A","text":"Voltage at operating load, conductor sizing and length, connections, circuit loading, and fixture or driver requirements"},{"key":"B","text":"Only fixture mounting height"},{"key":"C","text":"Only lamp color temperature"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Voltage drop, connections, and loading can affect lighting performance along a long circuit.'),

(15,'scenario','scenario',
'A lighting-control system loses its programmed behavior after power interruptions. What is the BEST approach?',
'[{"key":"A","text":"Verify controller configuration, backup or retained settings, power supply, communications, and commissioning requirements"},{"key":"B","text":"Replace every fixture"},{"key":"C","text":"Increase circuit voltage"},{"key":"D","text":"Remove the controls"}]'::jsonb,
'["A"]'::jsonb,
'Loss of programmed behavior points toward control configuration, retained memory, power, or communication issues.'),

(16,'scenario','scenario',
'A renovation changes fixture types and substantially reduces steady-state wattage, but the existing lighting breaker still trips during startup. What should the journeyman investigate?',
'[{"key":"A","text":"Driver inrush, simultaneous startup, protective-device characteristics, circuit configuration, and equipment condition"},{"key":"B","text":"Assume the breaker is defective because wattage decreased"},{"key":"C","text":"Install a larger breaker immediately"},{"key":"D","text":"Remove fixture grounding"}]'::jsonb,
'["A"]'::jsonb,
'Lower steady-state wattage does not necessarily mean lower startup current for electronic lighting loads.'),

(17,'scenario','scenario',
'Exterior lighting repeatedly fails in one location exposed to moisture, while identical equipment works elsewhere. What should be reviewed?',
'[{"key":"A","text":"Environmental rating, enclosure integrity, water entry, connections, drainage, mounting, and component suitability"},{"key":"B","text":"Only lamp wattage"},{"key":"C","text":"Only branch breaker size"},{"key":"D","text":"Increase fixture voltage"}]'::jsonb,
'["A"]'::jsonb,
'Location-specific repeated failures suggest environmental or installation conditions should be investigated.'),

(18,'scenario','scenario',
'A project requires lighting to respond to occupancy, daylight, schedules, and manual overrides. What should the journeyman verify during commissioning?',
'[{"key":"A","text":"Each input, zone, programmed interaction, override, timing behavior, and resulting fixture response"},{"key":"B","text":"Only whether fixtures turn on manually"},{"key":"C","text":"Only breaker sizes"},{"key":"D","text":"Only fixture labels"}]'::jsonb,
'["A"]'::jsonb,
'Complex lighting controls should be commissioned against the intended sequence of operation.'),

(19,'scenario','scenario',
'Lighting fixtures work correctly, but one control zone commands fixtures that belong to another area. What is the BEST response?',
'[{"key":"A","text":"Verify control addressing, zoning, wiring, programming, and documentation and correct the system mapping"},{"key":"B","text":"Move the fixtures physically"},{"key":"C","text":"Increase control voltage"},{"key":"D","text":"Replace all lamps"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect zone behavior can result from addressing, wiring, or programming errors.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Lighting Systems?',
'[{"key":"A","text":"Replacing fixtures without evaluating controls"},{"key":"B","text":"Independently integrating fixture and driver selection, circuit loading, environmental suitability, control architecture, commissioning, troubleshooting, and field coordination to deliver reliable lighting-system performance"},{"key":"C","text":"Increasing breakers whenever electronic loads trip"},{"key":"D","text":"Treating every lighting control system as simple line-voltage switching"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently installing, commissioning, evaluating, and troubleshooting lighting systems as coordinated electrical and control systems.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '07ad5e8e-bcfc-411c-98e4-102a2334b384';
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
      and c.name = 'Lighting Systems'
      and c.is_current = true
  ) then
    raise exception 'Current Lighting Systems Master Competency not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Electrician Journeyman L3 Electrical Testing requirement not found';
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
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Lighting Systems — Level 2 Competency Assessment';

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
    select * from _seed_lighting_systems_l2_questions
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
        'Lighting Systems',
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
      'IntegrateU Lighting Systems L2 production assessment v1.0.',
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
        'Lighting Systems',
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
        'IntegrateU Lighting Systems L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 3;
  v_role_template_id := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid;
  v_assessment_name := 'Lighting Systems — Level 3 Competency Assessment';

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
    select * from _seed_lighting_systems_l3_questions
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
        'Lighting Systems',
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
      'IntegrateU Lighting Systems L3 production assessment v1.0.',
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
        'Lighting Systems',
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
        'IntegrateU Lighting Systems L3 production assessment v1.0.',
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
--   Level 3 -> 20 / 20 / 4 / 7 / 9
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
   '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid
  and a.target_level in (2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 2 Apprentice  -> 20
--   Level 3 Journeyman -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid
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
  (q.target_level = 3 and ra.master_role_template_id =
    '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid;

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
    '07ad5e8e-bcfc-411c-98e4-102a2334b384'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
