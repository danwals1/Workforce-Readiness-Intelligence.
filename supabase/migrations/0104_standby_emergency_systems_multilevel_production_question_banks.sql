-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0104_standby_emergency_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Standby & Emergency Systems
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

create temporary table _seed_standby_emergency_systems_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_standby_emergency_systems_l1_questions (
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
'What is the basic purpose of a standby electrical system?',
'[{"key":"A","text":"To supply selected loads when the normal source is unavailable"},{"key":"B","text":"To increase normal utility voltage"},{"key":"C","text":"To replace all branch circuits"},{"key":"D","text":"To eliminate overcurrent protection"}]'::jsonb,
'["A"]'::jsonb,
'Standby systems provide an alternate source for selected loads when normal power is unavailable.'),

(2,'multiple_choice','foundational',
'What is the purpose of a transfer switch in a backup power system?',
'[{"key":"A","text":"To transfer connected loads between normal and alternate power sources"},{"key":"B","text":"To increase generator frequency"},{"key":"C","text":"To replace the generator"},{"key":"D","text":"To eliminate grounding"}]'::jsonb,
'["A"]'::jsonb,
'A transfer switch manages the connection of loads between normal and alternate sources.'),

(3,'multiple_choice','foundational',
'What does a generator provide in a typical standby system?',
'[{"key":"A","text":"An alternate source of electrical power"},{"key":"B","text":"Only overcurrent protection"},{"key":"C","text":"Only grounding"},{"key":"D","text":"Only circuit identification"}]'::jsonb,
'["A"]'::jsonb,
'A generator commonly serves as the alternate electrical source in standby and emergency systems.'),

(4,'multiple_choice','foundational',
'Why must normal and alternate sources be connected through an appropriate transfer method?',
'[{"key":"A","text":"To control which source supplies the load and prevent improper source interconnection"},{"key":"B","text":"To increase conductor ampacity"},{"key":"C","text":"To change panel color"},{"key":"D","text":"To eliminate disconnects"}]'::jsonb,
'["A"]'::jsonb,
'Proper transfer equipment controls source selection and prevents unsafe or unintended source connections.'),

(5,'multiple_choice','foundational',
'What is the purpose of identifying emergency or standby equipment clearly?',
'[{"key":"A","text":"To support safe operation, maintenance, and source identification"},{"key":"B","text":"To increase generator output"},{"key":"C","text":"To reduce conductor size"},{"key":"D","text":"To eliminate testing"}]'::jsonb,
'["A"]'::jsonb,
'Clear identification helps workers understand the purpose and source relationships of backup-system equipment.'),

(6,'multiple_choice','foundational',
'Why is ventilation important around many generator installations?',
'[{"key":"A","text":"Generators can produce heat and exhaust that must be managed safely"},{"key":"B","text":"Ventilation changes electrical frequency"},{"key":"C","text":"Ventilation replaces grounding"},{"key":"D","text":"Ventilation increases conductor capacity"}]'::jsonb,
'["A"]'::jsonb,
'Generator installations may require ventilation for heat and exhaust management.'),

(7,'multiple_choice','foundational',
'Why must standby-system conductors and equipment be properly rated?',
'[{"key":"A","text":"They must safely carry and control the intended electrical load"},{"key":"B","text":"Ratings affect only labeling"},{"key":"C","text":"Any conductor can serve any generator"},{"key":"D","text":"Ratings matter only during normal utility operation"}]'::jsonb,
'["A"]'::jsonb,
'Backup-system components must be suitable for the electrical conditions they will serve.'),

(8,'multiple_choice','foundational',
'Why should emergency and standby systems be tested periodically?',
'[{"key":"A","text":"To verify that the system can operate as intended when needed"},{"key":"B","text":"To increase generator kVA"},{"key":"C","text":"To eliminate maintenance"},{"key":"D","text":"To change system voltage"}]'::jsonb,
'["A"]'::jsonb,
'Periodic testing helps confirm that alternate-source and transfer functions remain operational.'),

(9,'situational_judgment','application',
'A generator is running but the connected standby loads are not energized. What is the BEST Level 1 response?',
'[{"key":"A","text":"Report the condition and verify the system is not being operated outside established procedures"},{"key":"B","text":"Move conductors between terminals"},{"key":"C","text":"Bypass the transfer switch"},{"key":"D","text":"Increase breaker sizes"}]'::jsonb,
'["A"]'::jsonb,
'An unexpected standby-system condition should be evaluated through established procedures rather than improvised changes.'),

(10,'multiple_choice','application',
'Why should a transfer switch remain accessible?',
'[{"key":"A","text":"So it can be safely operated, inspected, tested, and maintained"},{"key":"B","text":"To increase generator output"},{"key":"C","text":"To eliminate source identification"},{"key":"D","text":"To change conductor resistance"}]'::jsonb,
'["A"]'::jsonb,
'Transfer equipment needs suitable access for operation and service.'),

(11,'situational_judgment','application',
'Stored materials are blocking a generator ventilation opening. What should happen?',
'[{"key":"A","text":"Restore the required ventilation and clearance"},{"key":"B","text":"Leave the materials if the generator still starts"},{"key":"C","text":"Increase the generator breaker"},{"key":"D","text":"Cover the remaining ventilation openings"}]'::jsonb,
'["A"]'::jsonb,
'Generator ventilation should not be obstructed because overheating and exhaust hazards can result.'),

(12,'multiple_select','application',
'Which THREE conditions are important in basic standby-system work?',
'[{"key":"A","text":"Clear source and equipment identification"},{"key":"B","text":"Proper access to transfer and generator equipment"},{"key":"C","text":"Recognition of abnormal heat, damage, or operation"},{"key":"D","text":"Decorative enclosure color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Identification, access, and recognition of abnormal conditions are core Level 1 standby-system practices.'),

(13,'multiple_choice','application',
'Why should generator and transfer-equipment ratings be checked before use?',
'[{"key":"A","text":"The equipment must be suitable for the intended voltage and load"},{"key":"B","text":"Ratings affect only labels"},{"key":"C","text":"Any generator can supply any load"},{"key":"D","text":"Ratings replace load calculations"}]'::jsonb,
'["A"]'::jsonb,
'Backup equipment must match the electrical system and loads it is intended to supply.'),

(14,'situational_judgment','application',
'A standby-system breaker trips repeatedly during testing. What is the BEST response?',
'[{"key":"A","text":"Stop repeated resetting and have the condition evaluated"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Bypass the breaker"},{"key":"D","text":"Hold it closed"}]'::jsonb,
'["A"]'::jsonb,
'Repeated protective-device operation can indicate overload or fault conditions that require evaluation.'),

(15,'multiple_choice','application',
'Why should standby-system operating instructions be available and followed?',
'[{"key":"A","text":"Backup systems can involve multiple sources and operating sequences that require controlled procedures"},{"key":"B","text":"Instructions increase generator capacity"},{"key":"C","text":"Instructions replace electrical testing"},{"key":"D","text":"Instructions change the transfer-switch rating"}]'::jsonb,
'["A"]'::jsonb,
'Standby systems often involve multiple-source operation that should follow established procedures.'),

(16,'situational_judgment','application',
'You notice unusual heat and odor from transfer equipment during a test. What should a Level 1 worker do?',
'[{"key":"A","text":"Report the abnormal condition and stop treating the equipment as normal until evaluated"},{"key":"B","text":"Increase the load"},{"key":"C","text":"Ignore it if transfer completed"},{"key":"D","text":"Increase the breaker rating"}]'::jsonb,
'["A"]'::jsonb,
'Heat and odor can indicate an electrical problem requiring qualified evaluation.'),

(17,'scenario','scenario',
'Normal power fails and the standby system does not start as expected. What is the BEST Level 1 response?',
'[{"key":"A","text":"Follow established emergency procedures and escalate the failed standby operation for qualified evaluation"},{"key":"B","text":"Bypass the transfer equipment"},{"key":"C","text":"Randomly change generator controls"},{"key":"D","text":"Connect the load directly to the generator"}]'::jsonb,
'["A"]'::jsonb,
'Failed standby operation should be handled through approved procedures rather than improvised electrical changes.'),

(18,'scenario','scenario',
'During testing, both normal and alternate source indicators appear active in a way that does not match the expected transfer sequence. What should happen?',
'[{"key":"A","text":"Stop and have the source and transfer condition evaluated before continuing"},{"key":"B","text":"Assume the indicators are wrong"},{"key":"C","text":"Increase generator output"},{"key":"D","text":"Ignore the condition if loads remain energized"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected source status in transfer equipment can indicate a serious system issue and should be evaluated.'),

(19,'scenario','scenario',
'A generator enclosure shows visible electrical damage near conductors or terminals. What should a Level 1 worker do?',
'[{"key":"A","text":"Keep clear and escalate the condition for qualified correction"},{"key":"B","text":"Push damaged parts back into place"},{"key":"C","text":"Cover the damage with tape"},{"key":"D","text":"Run the generator to see whether it clears"}]'::jsonb,
'["A"]'::jsonb,
'Visible electrical damage requires qualified evaluation before normal system use.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Standby & Emergency Systems?',
'[{"key":"A","text":"Bypassing transfer equipment when backup power fails"},{"key":"B","text":"Recognizing basic generator, transfer, source, load, testing, identification, and abnormal-condition concepts while following procedures and escalating problems"},{"key":"C","text":"Increasing breaker sizes during failed tests"},{"key":"D","text":"Ignoring abnormal generator heat"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance centers on understanding basic backup-system functions and recognizing conditions that require qualified action.');

create temporary table _seed_standby_emergency_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_standby_emergency_systems_l3_questions (
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
'Why must a journeyman understand whether a backup system is emergency, legally required standby, optional standby, or another defined system type?',
'[{"key":"A","text":"Different system classifications can carry different performance, transfer, wiring, and installation requirements"},{"key":"B","text":"All backup systems are governed identically"},{"key":"C","text":"Classification affects only labels"},{"key":"D","text":"Classification changes utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'Backup-system classification can materially affect how the system must be designed, installed, and operated.'),

(2,'multiple_choice','foundational',
'Why is transfer-switch configuration important in generator-backed systems?',
'[{"key":"A","text":"It determines how normal and alternate sources connect to loads and can affect grounding and neutral relationships"},{"key":"B","text":"It affects only enclosure size"},{"key":"C","text":"It eliminates generator sizing"},{"key":"D","text":"It changes conductor insulation color"}]'::jsonb,
'["A"]'::jsonb,
'Transfer-switch configuration affects source interconnection and can influence grounding and neutral treatment.'),

(3,'multiple_choice','foundational',
'Why must generator capacity be evaluated against the loads it is intended to serve?',
'[{"key":"A","text":"The generator must support the required load and operating characteristics without improper overloading"},{"key":"B","text":"Any generator can serve any load if voltage matches"},{"key":"C","text":"Capacity affects only fuel use"},{"key":"D","text":"Transfer switches determine generator capacity"}]'::jsonb,
'["A"]'::jsonb,
'Generator selection must account for the electrical demand and characteristics of the loads being supplied.'),

(4,'multiple_choice','foundational',
'Why should a journeyman understand the complete sequence of operation for a standby system?',
'[{"key":"A","text":"Source failure, generator start, transfer, retransfer, and shutdown events must occur in a coordinated sequence"},{"key":"B","text":"Sequence affects only indicator lights"},{"key":"C","text":"Sequence eliminates testing"},{"key":"D","text":"Only generator voltage matters"}]'::jsonb,
'["A"]'::jsonb,
'Understanding sequence of operation is essential to installation, testing, and troubleshooting of standby systems.'),

(5,'situational_judgment','application',
'A new generator is being selected for an existing standby system. What should the journeyman evaluate?',
'[{"key":"A","text":"System voltage, phase, load demand, starting characteristics, transfer equipment, grounding, protection, and installation conditions"},{"key":"B","text":"Only generator physical size"},{"key":"C","text":"Only fuel type"},{"key":"D","text":"Only the largest branch breaker"}]'::jsonb,
'["A"]'::jsonb,
'Generator selection requires coordinated evaluation of electrical loads, equipment, and system configuration.'),

(6,'multiple_select','application',
'Which THREE items commonly belong in a standby-system review?',
'[{"key":"A","text":"Generator and transfer-equipment ratings"},{"key":"B","text":"Load priorities and required backup loads"},{"key":"C","text":"Grounding, bonding, neutral, and source configuration"},{"key":"D","text":"Paint color"},{"key":"E","text":"Installer preference"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Standby-system review integrates source equipment, intended loads, and system grounding and transfer configuration.'),

(7,'situational_judgment','application',
'A standby generator starts normally but stalls when several large loads transfer at once. What should the journeyman evaluate?',
'[{"key":"A","text":"Generator capacity, load sequencing, starting demand, transfer logic, and equipment condition"},{"key":"B","text":"Only generator paint"},{"key":"C","text":"Increase all branch breakers"},{"key":"D","text":"Ignore the condition if the generator restarts"}]'::jsonb,
'["A"]'::jsonb,
'Large simultaneous load pickup can exceed generator capability or reveal sequencing and equipment problems.'),

(8,'multiple_choice','application',
'Why should neutral switching and grounding relationships be reviewed when transfer equipment is changed?',
'[{"key":"A","text":"The transfer configuration can alter how the alternate source is grounded and how neutral current paths behave"},{"key":"B","text":"Neutral switching affects only labels"},{"key":"C","text":"Grounding is unrelated to transfer equipment"},{"key":"D","text":"Every transfer switch must use the same neutral arrangement"}]'::jsonb,
'["A"]'::jsonb,
'Transfer equipment configuration can directly affect grounded-conductor and source-grounding relationships.'),

(9,'situational_judgment','application',
'An existing generator is being reused for additional standby loads. What should happen before those loads are approved?',
'[{"key":"A","text":"Verify generator capacity, load characteristics, transfer equipment, conductors, protection, and operating sequence for the revised system"},{"key":"B","text":"Add loads if breaker spaces exist"},{"key":"C","text":"Increase generator breaker size only"},{"key":"D","text":"Assume spare capacity exists"}]'::jsonb,
'["A"]'::jsonb,
'Added standby loads require reevaluation of the entire backup power path and operating sequence.'),

(10,'multiple_choice','application',
'Why should a standby-system test simulate realistic operating conditions when practical?',
'[{"key":"A","text":"A realistic test is more likely to reveal problems with starting, transfer, load pickup, retransfer, and shutdown"},{"key":"B","text":"Testing only verifies indicator lights"},{"key":"C","text":"Testing eliminates maintenance"},{"key":"D","text":"A no-load test proves full system capacity"}]'::jsonb,
'["A"]'::jsonb,
'Testing under representative conditions can reveal failures that a simple no-load start may not expose.'),

(11,'situational_judgment','application',
'Project documents and installed transfer equipment show different source and neutral configurations. What should the journeyman do?',
'[{"key":"A","text":"Reconcile the actual equipment and intended system configuration before energization or testing"},{"key":"B","text":"Follow the drawing regardless"},{"key":"C","text":"Energize to determine which is correct"},{"key":"D","text":"Ignore the neutral arrangement"}]'::jsonb,
'["A"]'::jsonb,
'Backup-system source and neutral configuration should be verified before operation because errors can affect system grounding and safety.'),

(12,'scenario','scenario',
'A generator starts on loss of normal power, but the transfer switch never transfers the emergency loads. What is the BEST troubleshooting approach?',
'[{"key":"A","text":"Verify source sensing, generator output, transfer controls, interlocks, wiring, and transfer-switch condition systematically"},{"key":"B","text":"Bypass the transfer switch immediately"},{"key":"C","text":"Increase generator breaker size"},{"key":"D","text":"Assume the generator is too small"}]'::jsonb,
'["A"]'::jsonb,
'Failure to transfer can result from sensing, control, source, wiring, or transfer-equipment problems and should be traced systematically.'),

(13,'scenario','scenario',
'During a standby test, the generator voltage is correct with no load but drops sharply when the load transfers. What should the journeyman investigate?',
'[{"key":"A","text":"Generator capacity, load demand, starting current, connections, voltage regulation, and equipment condition"},{"key":"B","text":"Only the transfer-switch label"},{"key":"C","text":"Increase every breaker"},{"key":"D","text":"Ignore the condition because no-load voltage is correct"}]'::jsonb,
'["A"]'::jsonb,
'Voltage collapse under load can indicate capacity, connection, regulation, or load-characteristic problems.'),

(14,'scenario','scenario',
'A generator-backed emergency system has undocumented field modifications to transfer controls. What should happen before relying on the system?',
'[{"key":"A","text":"Verify the actual control logic, source relationships, sequence of operation, and equipment condition and document the findings"},{"key":"B","text":"Assume the modifications are acceptable because the generator starts"},{"key":"C","text":"Remove all labels"},{"key":"D","text":"Increase generator output"}]'::jsonb,
'["A"]'::jsonb,
'Undocumented transfer-control modifications should be understood and reconciled before the emergency system is relied upon.'),

(15,'scenario','scenario',
'A generator is adequately sized for running load, but repeated starts fail when a large motor is included in the first load block. What is the BEST response?',
'[{"key":"A","text":"Evaluate motor starting demand, generator capability, load sequencing, and transfer strategy"},{"key":"B","text":"Increase the motor breaker"},{"key":"C","text":"Ignore starting demand"},{"key":"D","text":"Reduce conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Running load alone may not capture the transient demand imposed by large motor starting.'),

(16,'scenario','scenario',
'A transfer-switch replacement changes whether the grounded conductor is switched. What should the journeyman reevaluate?',
'[{"key":"A","text":"Source grounding, bonding, neutral-current paths, equipment grounding, and overall system configuration"},{"key":"B","text":"Only enclosure size"},{"key":"C","text":"Only generator fuel supply"},{"key":"D","text":"Nothing else"}]'::jsonb,
'["A"]'::jsonb,
'A change in grounded-conductor switching can alter important system grounding and current-path relationships.'),

(17,'scenario','scenario',
'A standby system passes its monthly no-load test but fails during a real outage with actual building loads. What is the BEST conclusion?',
'[{"key":"A","text":"The testing program and system performance should be reevaluated under representative load and operating conditions"},{"key":"B","text":"The monthly test proved the system was adequate"},{"key":"C","text":"Increase all protective-device ratings"},{"key":"D","text":"Stop future testing"}]'::jsonb,
'["A"]'::jsonb,
'No-load testing may not expose capacity, transfer, sequencing, or load-performance problems.'),

(18,'scenario','scenario',
'Normal power returns, but the standby system does not retransfer as expected. What is the BEST approach?',
'[{"key":"A","text":"Verify normal-source quality, sensing, programmed delays, transfer controls, interlocks, and equipment condition"},{"key":"B","text":"Force the transfer mechanism without investigation"},{"key":"C","text":"Increase generator speed"},{"key":"D","text":"Disconnect the normal source permanently"}]'::jsonb,
'["A"]'::jsonb,
'Retransfer failures can involve source sensing, timing, control logic, or transfer-equipment problems.'),

(19,'scenario','scenario',
'A major renovation changes which loads are designated for standby power. What should the journeyman do?',
'[{"key":"A","text":"Reevaluate generator capacity, load priorities, transfer equipment, conductors, protection, sequence of operation, and documentation"},{"key":"B","text":"Move loads without reviewing generator capacity"},{"key":"C","text":"Increase generator breaker size only"},{"key":"D","text":"Assume the original design remains valid"}]'::jsonb,
'["A"]'::jsonb,
'Changes to designated standby loads can affect the entire backup power system and operating sequence.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Standby & Emergency Systems?',
'[{"key":"A","text":"Starting generators only"},{"key":"B","text":"Independently evaluating generator capacity, transfer configuration, load sequencing, grounding and bonding, controls, testing, troubleshooting, and field changes while coordinating safe system operation"},{"key":"C","text":"Bypassing transfer equipment when testing fails"},{"key":"D","text":"Using no-load testing as proof of full system performance"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently installing, evaluating, testing, and troubleshooting standby and emergency systems as coordinated multi-source systems.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '4f229b0b-4922-42b5-8653-33826eb5e498';
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
      and c.name = 'Standby & Emergency Systems'
      and c.is_current = true
  ) then
    raise exception 'Current Standby & Emergency Systems Master Competency not found';
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
  v_assessment_name := 'Standby & Emergency Systems — Level 1 Competency Assessment';

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
    select * from _seed_standby_emergency_systems_l1_questions
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
        'Standby & Emergency Systems',
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
      'IntegrateU Standby & Emergency Systems L1 production assessment v1.0.',
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
        'Standby & Emergency Systems',
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
        'IntegrateU Standby & Emergency Systems L1 production assessment v1.0.',
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
  v_assessment_name := 'Standby & Emergency Systems — Level 3 Competency Assessment';

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
    select * from _seed_standby_emergency_systems_l3_questions
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
        'Standby & Emergency Systems',
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
      'IntegrateU Standby & Emergency Systems L3 production assessment v1.0.',
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
        'Standby & Emergency Systems',
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
        'IntegrateU Standby & Emergency Systems L3 production assessment v1.0.',
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
   '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid
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
      '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid
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
  '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid;

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
    '4f229b0b-4922-42b5-8653-33826eb5e498'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
