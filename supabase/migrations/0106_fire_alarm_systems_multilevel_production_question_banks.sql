-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0106_fire_alarm_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Fire & Alarm Systems
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

create temporary table _seed_fire_alarm_systems_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_fire_alarm_systems_l1_questions (
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
'What is the basic purpose of a fire alarm system?',
'[{"key":"A","text":"To detect or receive alarm conditions and provide required notification or system response"},{"key":"B","text":"To replace normal lighting"},{"key":"C","text":"To increase service voltage"},{"key":"D","text":"To eliminate emergency planning"}]'::jsonb,
'["A"]'::jsonb,
'Fire alarm systems monitor initiating conditions and provide notification or other required responses.'),

(2,'multiple_choice','foundational',
'What is an initiating device in a fire alarm system?',
'[{"key":"A","text":"A device that detects or reports a condition that can initiate a system signal"},{"key":"B","text":"A branch-circuit breaker"},{"key":"C","text":"A grounding electrode"},{"key":"D","text":"A lighting contactor"}]'::jsonb,
'["A"]'::jsonb,
'Initiating devices provide inputs such as detection or manual alarm signals to the fire alarm system.'),

(3,'multiple_choice','foundational',
'What is the purpose of a notification appliance?',
'[{"key":"A","text":"To alert occupants or other intended recipients to a system condition"},{"key":"B","text":"To replace initiating devices"},{"key":"C","text":"To increase circuit voltage"},{"key":"D","text":"To act as the service disconnect"}]'::jsonb,
'["A"]'::jsonb,
'Notification appliances provide audible, visible, or other required indications of alarm-system conditions.'),

(4,'multiple_choice','foundational',
'Why must fire alarm devices be installed in their intended locations?',
'[{"key":"A","text":"Location can affect detection, notification, accessibility, and system performance"},{"key":"B","text":"Location affects only appearance"},{"key":"C","text":"Any device can be installed anywhere"},{"key":"D","text":"Location changes utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'Device placement is part of how a fire alarm system achieves its intended detection and notification performance.'),

(5,'multiple_choice','foundational',
'Why is device and circuit identification important in fire alarm work?',
'[{"key":"A","text":"It supports correct installation, testing, troubleshooting, and maintenance"},{"key":"B","text":"It increases circuit capacity"},{"key":"C","text":"It replaces documentation"},{"key":"D","text":"It eliminates testing"}]'::jsonb,
'["A"]'::jsonb,
'Accurate identification helps workers understand system circuits and devices throughout installation and service.'),

(6,'multiple_choice','foundational',
'Why should fire alarm wiring be protected from physical damage?',
'[{"key":"A","text":"Damage can impair system reliability or create faults"},{"key":"B","text":"Protection increases device volume"},{"key":"C","text":"Protection changes system programming"},{"key":"D","text":"Protection replaces supervision"}]'::jsonb,
'["A"]'::jsonb,
'Physical damage to alarm-system conductors can cause opens, shorts, grounds, or unreliable operation.'),

(7,'multiple_choice','foundational',
'What is the basic purpose of system supervision in many fire alarm circuits?',
'[{"key":"A","text":"To detect certain wiring or equipment conditions that could impair system operation"},{"key":"B","text":"To increase alarm volume"},{"key":"C","text":"To replace backup power"},{"key":"D","text":"To reduce conductor count automatically"}]'::jsonb,
'["A"]'::jsonb,
'Supervision helps identify impairments such as wiring faults that could prevent normal system operation.'),

(8,'multiple_choice','foundational',
'Why is backup power important in many fire alarm systems?',
'[{"key":"A","text":"It helps maintain required system operation when normal power is unavailable"},{"key":"B","text":"It increases normal service voltage"},{"key":"C","text":"It replaces notification appliances"},{"key":"D","text":"It eliminates testing"}]'::jsonb,
'["A"]'::jsonb,
'Backup power supports continued alarm-system functionality during loss of normal power.'),

(9,'situational_judgment','application',
'A fire alarm device has been removed temporarily and its circuit is left incomplete. What is the BEST Level 1 response?',
'[{"key":"A","text":"Report the impairment and follow the approved procedure for restoring or managing the affected system"},{"key":"B","text":"Ignore it until final inspection"},{"key":"C","text":"Twist unrelated conductors together"},{"key":"D","text":"Disable the entire panel"}]'::jsonb,
'["A"]'::jsonb,
'Known fire alarm impairments should be controlled and addressed through approved procedures.'),

(10,'multiple_choice','application',
'Why should polarity and terminal identification be verified when installing compatible fire alarm devices?',
'[{"key":"A","text":"Incorrect connections can prevent proper operation or create faults"},{"key":"B","text":"Polarity affects only device color"},{"key":"C","text":"Terminal markings are optional"},{"key":"D","text":"Polarity increases conductor ampacity"}]'::jsonb,
'["A"]'::jsonb,
'Correct device connection is necessary for reliable operation of many alarm-system components.'),

(11,'situational_judgment','application',
'A fire alarm cable is visibly damaged before final testing. What should happen?',
'[{"key":"A","text":"Have the damaged wiring corrected before the system is relied upon"},{"key":"B","text":"Leave it if continuity is present"},{"key":"C","text":"Cover it with paint"},{"key":"D","text":"Increase power-supply voltage"}]'::jsonb,
'["A"]'::jsonb,
'Visible cable damage can compromise fire alarm reliability and should be corrected.'),

(12,'multiple_select','application',
'Which THREE items should a Level 1 worker recognize as important in fire alarm installation?',
'[{"key":"A","text":"Correct device location and identification"},{"key":"B","text":"Secure, protected wiring and proper terminations"},{"key":"C","text":"Following drawings, instructions, and test procedures"},{"key":"D","text":"Decorative device color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Basic fire alarm work depends on correct placement, wiring, documentation, and verification.'),

(13,'multiple_choice','application',
'Why should fire alarm devices not be painted, covered, or obstructed unless specifically permitted?',
'[{"key":"A","text":"Obstruction or contamination can impair detection, notification, or device operation"},{"key":"B","text":"It increases circuit current"},{"key":"C","text":"It changes panel programming automatically"},{"key":"D","text":"It improves supervision"}]'::jsonb,
'["A"]'::jsonb,
'Alarm devices must remain able to perform their intended function.'),

(14,'situational_judgment','application',
'A device address or circuit label does not match the project documentation. What should a Level 1 worker do?',
'[{"key":"A","text":"Stop relying on the mismatch and have the identification or documentation reconciled"},{"key":"B","text":"Ignore the difference"},{"key":"C","text":"Change random labels"},{"key":"D","text":"Disable supervision"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect identification can cause commissioning and troubleshooting errors and should be corrected.'),

(15,'multiple_choice','application',
'Why should a fire alarm system be tested after devices or wiring are installed or modified?',
'[{"key":"A","text":"To verify that the affected system functions operate as intended"},{"key":"B","text":"To increase device sensitivity automatically"},{"key":"C","text":"To replace documentation"},{"key":"D","text":"To change circuit classification"}]'::jsonb,
'["A"]'::jsonb,
'Functional testing confirms that installation or modification work produces the intended system response.'),

(16,'situational_judgment','application',
'A notification appliance is loose and partially detached from its mounting surface. What should happen?',
'[{"key":"A","text":"Correct the mounting and verify the device before the system is returned to normal service"},{"key":"B","text":"Leave it if it still sounds"},{"key":"C","text":"Increase circuit voltage"},{"key":"D","text":"Remove its label"}]'::jsonb,
'["A"]'::jsonb,
'Alarm-system devices must be securely installed so mechanical problems do not compromise operation.'),

(17,'scenario','scenario',
'During a test, activating a manual station does not produce the expected alarm response. What is the BEST Level 1 response?',
'[{"key":"A","text":"Report the failed function and follow the established test and troubleshooting procedure"},{"key":"B","text":"Bypass the alarm panel"},{"key":"C","text":"Increase branch-circuit protection"},{"key":"D","text":"Assume the manual station is unnecessary"}]'::jsonb,
'["A"]'::jsonb,
'A failed alarm function is a system impairment that requires controlled evaluation and correction.'),

(18,'scenario','scenario',
'A detector has been installed behind a new obstruction that may interfere with its intended coverage. What should happen?',
'[{"key":"A","text":"Escalate the condition so device location and coverage can be evaluated and corrected if necessary"},{"key":"B","text":"Leave it because the detector is powered"},{"key":"C","text":"Increase detector sensitivity without approval"},{"key":"D","text":"Remove nearby notification devices"}]'::jsonb,
'["A"]'::jsonb,
'Physical changes can compromise detector effectiveness even when the device remains electrically operational.'),

(19,'scenario','scenario',
'A fire alarm control panel shows a persistent trouble condition after installation work. What should a Level 1 worker do?',
'[{"key":"A","text":"Do not treat the system as fully normal; report and assist with approved troubleshooting of the trouble condition"},{"key":"B","text":"Silence and ignore it permanently"},{"key":"C","text":"Disconnect backup power"},{"key":"D","text":"Increase the panel supply breaker"}]'::jsonb,
'["A"]'::jsonb,
'A persistent trouble indication may represent a supervised system impairment requiring correction.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Fire & Alarm Systems?',
'[{"key":"A","text":"Ignoring persistent trouble signals"},{"key":"B","text":"Recognizing basic initiating, notification, wiring, supervision, backup-power, documentation, and testing concepts while escalating impairments"},{"key":"C","text":"Bypassing supervised circuits when faults occur"},{"key":"D","text":"Relocating devices without review"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance centers on recognizing basic fire alarm components, installation practices, and system conditions that require qualified action.');

create temporary table _seed_fire_alarm_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_fire_alarm_systems_l3_questions (
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
'Why must a journeyman understand the relationship among initiating devices, notification appliances, control equipment, power supplies, and interfaces?',
'[{"key":"A","text":"Fire alarm performance depends on coordinated operation of the complete system"},{"key":"B","text":"Each device operates independently of the rest of the system"},{"key":"C","text":"Only notification appliances matter"},{"key":"D","text":"Interfaces affect only labels"}]'::jsonb,
'["A"]'::jsonb,
'Advanced fire alarm work requires understanding how inputs, control logic, outputs, power, and interfaces operate together.'),

(2,'multiple_choice','foundational',
'Why is circuit supervision important when troubleshooting a fire alarm system?',
'[{"key":"A","text":"Supervision can help distinguish wiring or equipment impairments from normal system conditions"},{"key":"B","text":"Supervision increases alarm volume"},{"key":"C","text":"Supervision replaces functional testing"},{"key":"D","text":"Supervision eliminates backup power"}]'::jsonb,
'["A"]'::jsonb,
'Supervised circuits provide information about certain faults that can impair system operation.'),

(3,'multiple_choice','foundational',
'Why should alarm-system interfaces with other building systems be documented and tested?',
'[{"key":"A","text":"An alarm event may be required to command or monitor other systems as part of the intended sequence"},{"key":"B","text":"Interfaces affect only device labels"},{"key":"C","text":"Building systems never interact with fire alarm systems"},{"key":"D","text":"Interfaces replace notification appliances"}]'::jsonb,
'["A"]'::jsonb,
'Fire alarm systems may interact with other building systems, making interface verification essential.'),

(4,'multiple_choice','foundational',
'Why must fire alarm modifications be evaluated against the existing system architecture and equipment compatibility?',
'[{"key":"A","text":"Adding or changing devices can affect circuit capacity, communication, programming, power, supervision, and system operation"},{"key":"B","text":"Any listed alarm device can be added to any system"},{"key":"C","text":"Only physical fit matters"},{"key":"D","text":"System architecture affects only documentation"}]'::jsonb,
'["A"]'::jsonb,
'Alarm-system modifications can affect electrical, communication, software, and power relationships throughout the system.'),

(5,'situational_judgment','application',
'Several new notification appliances are proposed on an existing circuit. What should the journeyman evaluate?',
'[{"key":"A","text":"Circuit loading, voltage performance, power-supply capacity, device compatibility, wiring, and intended operation"},{"key":"B","text":"Only whether physical space exists"},{"key":"C","text":"Only device color"},{"key":"D","text":"Only panel enclosure size"}]'::jsonb,
'["A"]'::jsonb,
'Adding notification appliances requires verifying that the circuit and power source can support the revised load.'),

(6,'multiple_select','application',
'Which THREE items commonly belong in a Level 3 fire alarm system review?',
'[{"key":"A","text":"Device and control-equipment compatibility"},{"key":"B","text":"Power, circuit loading, supervision, and wiring integrity"},{"key":"C","text":"Programming, sequence of operation, interfaces, and documentation"},{"key":"D","text":"Decorative device finish"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced fire alarm review integrates hardware, wiring, power, programming, interfaces, and documentation.'),

(7,'situational_judgment','application',
'A fire alarm panel reports an intermittent ground fault that disappears before technicians arrive. What is the BEST approach?',
'[{"key":"A","text":"Use system history and systematic circuit isolation and testing to locate the intermittent fault without defeating required supervision"},{"key":"B","text":"Disable ground-fault monitoring"},{"key":"C","text":"Replace every device"},{"key":"D","text":"Ignore it because it cleared"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent supervised faults require systematic troubleshooting rather than disabling monitoring.'),

(8,'multiple_choice','application',
'Why should backup-power capacity be reevaluated after expanding a fire alarm system?',
'[{"key":"A","text":"Additional devices or loads can change required standby and alarm power demand"},{"key":"B","text":"Battery capacity never changes with system size"},{"key":"C","text":"Backup power affects only labels"},{"key":"D","text":"Normal branch-circuit size determines battery capacity"}]'::jsonb,
'["A"]'::jsonb,
'System expansion can increase both standby and alarm current requirements.'),

(9,'situational_judgment','application',
'A replacement detector is electrically compatible but requires different programming or addressing than the original. What should happen?',
'[{"key":"A","text":"Complete the required programming, addressing, documentation, and functional testing before relying on the device"},{"key":"B","text":"Install it and ignore programming"},{"key":"C","text":"Increase panel voltage"},{"key":"D","text":"Disable supervision"}]'::jsonb,
'["A"]'::jsonb,
'Compatible hardware still requires correct system configuration and testing.'),

(10,'situational_judgment','application',
'Project drawings show one alarm sequence, but the approved system programming reflects a different sequence. What should the journeyman do?',
'[{"key":"A","text":"Reconcile the approved sequence, programming, drawings, and intended system operation before final acceptance"},{"key":"B","text":"Use whichever sequence activates first"},{"key":"C","text":"Ignore the discrepancy"},{"key":"D","text":"Remove interface modules"}]'::jsonb,
'["A"]'::jsonb,
'Fire alarm sequence discrepancies should be resolved before the system is accepted or relied upon.'),

(11,'situational_judgment','application',
'An alarm interface activates connected equipment correctly but does not report status back as intended. What should be checked?',
'[{"key":"A","text":"Interface wiring, module configuration, monitored contacts, programming, and the expected sequence of operation"},{"key":"B","text":"Only notification volume"},{"key":"C","text":"Only detector spacing"},{"key":"D","text":"Increase branch-circuit voltage"}]'::jsonb,
'["A"]'::jsonb,
'Interface operation may involve both command and status paths that must each be verified.'),

(12,'scenario','scenario',
'A notification circuit operates normally with a few devices but fails when the full alarm load is activated. What should the journeyman investigate?',
'[{"key":"A","text":"Circuit loading, voltage drop, power-supply capacity, wiring resistance, connections, and device compatibility"},{"key":"B","text":"Only device mounting height"},{"key":"C","text":"Increase protective-device size"},{"key":"D","text":"Remove supervision"}]'::jsonb,
'["A"]'::jsonb,
'Full-load failures can indicate capacity, voltage, wiring, or connection problems not visible under light load.'),

(13,'scenario','scenario',
'A renovated area receives new detectors, but the ceiling layout and airflow differ substantially from the original design. What should happen?',
'[{"key":"A","text":"Reevaluate detector placement and intended coverage against the actual field conditions before acceptance"},{"key":"B","text":"Reuse the original locations automatically"},{"key":"C","text":"Increase sensitivity without review"},{"key":"D","text":"Ignore ceiling changes"}]'::jsonb,
'["A"]'::jsonb,
'Building changes can materially affect detector placement and performance.'),

(14,'scenario','scenario',
'A fire alarm system repeatedly reports an open circuit only during building vibration. What is the BEST troubleshooting direction?',
'[{"key":"A","text":"Inspect and test conductors, terminals, splices, devices, and mechanical conditions for intermittent connection failure"},{"key":"B","text":"Disable the trouble signal"},{"key":"C","text":"Increase power-supply voltage"},{"key":"D","text":"Replace the panel immediately"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent opens associated with vibration often point to marginal physical connections or damaged wiring.'),

(15,'scenario','scenario',
'A new control module is installed and appears normal, but the connected building function does not occur during alarm testing. What should the journeyman evaluate?',
'[{"key":"A","text":"Module programming, wiring, relay or interface logic, connected equipment conditions, and the approved sequence"},{"key":"B","text":"Only device labeling"},{"key":"C","text":"Only detector sensitivity"},{"key":"D","text":"Increase panel breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Successful interface operation requires correct programming, wiring, logic, and connected-system response.'),

(16,'scenario','scenario',
'An existing alarm system is expanded, and battery calculations now show inadequate standby capacity. What is the BEST response?',
'[{"key":"A","text":"Provide a compliant power solution and verify the revised system rather than accepting inadequate backup capacity"},{"key":"B","text":"Ignore the calculation if normal power is reliable"},{"key":"C","text":"Reduce alarm volume"},{"key":"D","text":"Disable trouble monitoring"}]'::jsonb,
'["A"]'::jsonb,
'Backup power must remain adequate for the actual system after modifications.'),

(17,'scenario','scenario',
'After a programming change, one alarm input activates the wrong notification zone. What should the journeyman do?',
'[{"key":"A","text":"Verify input mapping, zone logic, programming, documentation, and functional response and correct the configuration"},{"key":"B","text":"Move devices physically to match the programming"},{"key":"C","text":"Increase circuit voltage"},{"key":"D","text":"Ignore it if some notification occurs"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect zone response indicates a configuration or mapping issue that must be corrected and retested.'),

(18,'scenario','scenario',
'A fire alarm system passes device-by-device tests but fails a complete integrated sequence involving multiple interfaces. What is the BEST conclusion?',
'[{"key":"A","text":"Individual device operation does not prove the full system sequence; integrated logic and interfaces must be troubleshot and retested"},{"key":"B","text":"The system should be accepted because every device works alone"},{"key":"C","text":"Increase all circuit ratings"},{"key":"D","text":"Remove interface supervision"}]'::jsonb,
'["A"]'::jsonb,
'Integrated system behavior must be verified in addition to individual component operation.'),

(19,'scenario','scenario',
'A field modification was made to an alarm circuit but never added to the drawings or device records. What should the journeyman do?',
'[{"key":"A","text":"Verify the modification, correct documentation and identification, and perform appropriate testing"},{"key":"B","text":"Leave documentation unchanged"},{"key":"C","text":"Remove device addresses"},{"key":"D","text":"Disable system history"}]'::jsonb,
'["A"]'::jsonb,
'Accurate documentation is essential for future testing, maintenance, and troubleshooting of fire alarm systems.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Fire & Alarm Systems?',
'[{"key":"A","text":"Installing devices without reviewing system programming"},{"key":"B","text":"Independently integrating devices, circuits, power, supervision, programming, interfaces, documentation, testing, and troubleshooting while resolving field and system conflicts safely"},{"key":"C","text":"Disabling trouble signals when faults are intermittent"},{"key":"D","text":"Treating individual device operation as proof of complete system performance"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently installing, evaluating, testing, and troubleshooting fire alarm systems as coordinated life-safety systems.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '68fe27c2-f209-43ec-ae38-362a0a8b87b5';
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
      and c.name = 'Fire & Alarm Systems'
      and c.is_current = true
  ) then
    raise exception 'Current Fire & Alarm Systems Master Competency not found';
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
  v_assessment_name := 'Fire & Alarm Systems — Level 1 Competency Assessment';

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
    select * from _seed_fire_alarm_systems_l1_questions
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
        'Fire & Alarm Systems',
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
      'IntegrateU Fire & Alarm Systems L1 production assessment v1.0.',
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
        'Fire & Alarm Systems',
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
        'IntegrateU Fire & Alarm Systems L1 production assessment v1.0.',
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
  v_assessment_name := 'Fire & Alarm Systems — Level 3 Competency Assessment';

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
    select * from _seed_fire_alarm_systems_l3_questions
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
        'Fire & Alarm Systems',
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
      'IntegrateU Fire & Alarm Systems L3 production assessment v1.0.',
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
        'Fire & Alarm Systems',
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
        'IntegrateU Fire & Alarm Systems L3 production assessment v1.0.',
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
   '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid
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
      '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid
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
  '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid;

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
    '68fe27c2-f209-43ec-ae38-362a0a8b87b5'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
