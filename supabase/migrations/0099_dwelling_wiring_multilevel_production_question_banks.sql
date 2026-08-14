-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0099_dwelling_wiring_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Dwelling Wiring
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

create temporary table _seed_dwelling_wiring_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_dwelling_wiring_l2_questions (
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
'What is the primary purpose of a branch circuit in a dwelling?',
'[{"key":"A","text":"To supply power from the final overcurrent device to outlets or utilization equipment"},{"key":"B","text":"To replace the service disconnect"},{"key":"C","text":"To identify the utility transformer"},{"key":"D","text":"To eliminate device boxes"}]'::jsonb,
'["A"]'::jsonb,
'A branch circuit supplies loads from the final overcurrent protection point to outlets or equipment.'),

(2,'multiple_choice','foundational',
'Why must receptacles and switches be installed in suitable boxes?',
'[{"key":"A","text":"To provide enclosure, support, conductor space, and protection for connections"},{"key":"B","text":"To increase circuit voltage"},{"key":"C","text":"To eliminate grounding"},{"key":"D","text":"To reduce conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Boxes support devices and protect conductor terminations and splices.'),

(3,'multiple_choice','foundational',
'Why is correct conductor identification important in dwelling wiring?',
'[{"key":"A","text":"It helps distinguish ungrounded, grounded, grounding, and switched conductors for correct connection"},{"key":"B","text":"It changes conductor ampacity"},{"key":"C","text":"It replaces continuity testing"},{"key":"D","text":"It eliminates labeling"}]'::jsonb,
'["A"]'::jsonb,
'Correct identification supports proper wiring, testing, and future service.'),

(4,'multiple_choice','foundational',
'What is the purpose of grounding and bonding in typical dwelling wiring?',
'[{"key":"A","text":"To provide an effective fault-current path and maintain conductive parts at appropriate potential"},{"key":"B","text":"To increase normal load current"},{"key":"C","text":"To replace overcurrent devices"},{"key":"D","text":"To create switched conductors"}]'::jsonb,
'["A"]'::jsonb,
'Grounding and bonding help establish an effective fault-current path and proper equipment safety.'),

(5,'multiple_choice','foundational',
'Why should conductor length at device boxes be sufficient for termination and servicing?',
'[{"key":"A","text":"Adequate length allows proper connection without excessive strain and supports future maintenance"},{"key":"B","text":"Extra length increases voltage"},{"key":"C","text":"Longer conductors eliminate boxes"},{"key":"D","text":"Extra length allows smaller wire sizes"}]'::jsonb,
'["A"]'::jsonb,
'Conductors need enough usable length for proper termination and serviceability.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'A receptacle box has several conductors and device connections packed tightly inside. What is the BEST action?',
'[{"key":"A","text":"Verify box capacity, conductor arrangement, and device fit before completing the installation"},{"key":"B","text":"Force the device into the box"},{"key":"C","text":"Trim conductor insulation to create space"},{"key":"D","text":"Remove grounding conductors"}]'::jsonb,
'["A"]'::jsonb,
'Crowded boxes should be evaluated for capacity and proper conductor arrangement rather than forced closed.'),

(7,'multiple_choice','application',
'Why should cable be secured and supported properly in a dwelling installation?',
'[{"key":"A","text":"To prevent unnecessary movement, strain, and physical damage"},{"key":"B","text":"To increase conductor ampacity"},{"key":"C","text":"To eliminate overcurrent protection"},{"key":"D","text":"To change circuit frequency"}]'::jsonb,
'["A"]'::jsonb,
'Proper support protects wiring methods from movement, strain, and damage.'),

(8,'situational_judgment','application',
'A cable route passes close to a location where fasteners could penetrate the cable. What should the installer do?',
'[{"key":"A","text":"Use an appropriate protection method or revise the route"},{"key":"B","text":"Install it normally because the wall will cover it"},{"key":"C","text":"Reduce conductor size"},{"key":"D","text":"Add a circuit label only"}]'::jsonb,
'["A"]'::jsonb,
'Wiring should be protected where it may be exposed to screws, nails, or similar physical damage.'),

(9,'multiple_select','application',
'Which THREE practices support good dwelling-device installation?',
'[{"key":"A","text":"Maintain correct conductor identification"},{"key":"B","text":"Make secure terminations"},{"key":"C","text":"Provide proper grounding and bonding"},{"key":"D","text":"Leave damaged insulation in place"},{"key":"E","text":"Ignore device ratings"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Identification, secure connections, and proper grounding and bonding are core device-installation practices.'),

(10,'multiple_choice','application',
'What is the BEST reason to verify the rating of a receptacle, switch, or lighting device before installation?',
'[{"key":"A","text":"The device must be suitable for the circuit and intended load"},{"key":"B","text":"The rating determines conductor color"},{"key":"C","text":"The rating eliminates box requirements"},{"key":"D","text":"The rating controls wall thickness"}]'::jsonb,
'["A"]'::jsonb,
'Devices must be appropriate for the circuit and load they serve.'),

(11,'situational_judgment','application',
'A switch-controlled light does not operate correctly after installation. What should be checked first?',
'[{"key":"A","text":"Verify conductor identification, switch connections, supply, and load wiring systematically"},{"key":"B","text":"Replace the breaker with a larger one"},{"key":"C","text":"Remove the grounding conductor"},{"key":"D","text":"Assume the fixture is defective"}]'::jsonb,
'["A"]'::jsonb,
'Basic troubleshooting should verify the circuit path and terminations rather than assuming a component failure.'),

(12,'multiple_choice','application',
'Why should dwelling wiring be coordinated with framing, plumbing, HVAC, and other building systems?',
'[{"key":"A","text":"To avoid physical conflicts, damage, inaccessible locations, and poor routing"},{"key":"B","text":"To eliminate electrical drawings"},{"key":"C","text":"To increase circuit voltage"},{"key":"D","text":"To reduce grounding requirements"}]'::jsonb,
'["A"]'::jsonb,
'Coordination helps maintain suitable routing and access while avoiding conflicts with other systems.'),

(13,'situational_judgment','application',
'A device box is installed too deep behind the finished wall surface. What is the BEST response?',
'[{"key":"A","text":"Correct the installation using an approved method so the box and device are properly supported and finished"},{"key":"B","text":"Leave the device loose"},{"key":"C","text":"Pull the device outward using its conductors"},{"key":"D","text":"Remove the box"}]'::jsonb,
'["A"]'::jsonb,
'Device installations should be properly supported and coordinated with the finished surface.'),

(14,'multiple_choice','application',
'Why should dwelling branch circuits be labeled and identified accurately?',
'[{"key":"A","text":"To support safe operation, maintenance, troubleshooting, and future modifications"},{"key":"B","text":"To increase breaker capacity"},{"key":"C","text":"To eliminate testing"},{"key":"D","text":"To reduce wire size"}]'::jsonb,
'["A"]'::jsonb,
'Accurate identification improves operation and future serviceability.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'A receptacle is energized but a tester indicates an incorrect grounding condition. What is the BEST response?',
'[{"key":"A","text":"Keep the circuit from normal use and verify the grounding and wiring connections before acceptance"},{"key":"B","text":"Ignore the result if the receptacle has voltage"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Remove the equipment grounding conductor"}]'::jsonb,
'["A"]'::jsonb,
'An incorrect grounding condition should be investigated and corrected before the installation is accepted.'),

(16,'scenario','scenario',
'A cable was damaged by a screw during drywall installation. What is the BEST action?',
'[{"key":"A","text":"Evaluate and properly repair or replace the damaged wiring before the circuit is placed in service"},{"key":"B","text":"Cover the damaged area and energize"},{"key":"C","text":"Reduce the breaker size only"},{"key":"D","text":"Ignore the damage if the cable still works"}]'::jsonb,
'["A"]'::jsonb,
'Physical damage to dwelling wiring must be addressed before energization or acceptance.'),

(17,'situational_judgment','scenario',
'A multi-device box has correct conductors present, but the devices cannot be installed without excessive force. What should the installer do?',
'[{"key":"A","text":"Reevaluate box capacity, conductor arrangement, device selection, and usable space before proceeding"},{"key":"B","text":"Force the devices into place"},{"key":"C","text":"Cut off excess conductor strands"},{"key":"D","text":"Remove grounding connections"}]'::jsonb,
'["A"]'::jsonb,
'The installation should be corrected rather than forcing conductors or devices into inadequate space.'),

(18,'scenario','scenario',
'A bedroom lighting circuit works intermittently when a switch is moved. What is the BEST response?',
'[{"key":"A","text":"De-energize as appropriate and inspect the switch, terminations, conductor condition, and circuit connections"},{"key":"B","text":"Increase breaker size"},{"key":"C","text":"Keep operating the switch until the fault becomes obvious"},{"key":"D","text":"Ignore the issue if the light usually works"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent operation can indicate a loose or damaged connection and should be investigated.'),

(19,'scenario','scenario',
'A planned receptacle location conflicts with newly installed cabinetry. What should the installer do?',
'[{"key":"A","text":"Coordinate the final location so the installation remains compliant, accessible, and usable"},{"key":"B","text":"Hide the receptacle behind inaccessible cabinetry"},{"key":"C","text":"Delete the receptacle without review"},{"key":"D","text":"Install it loose inside the wall"}]'::jsonb,
'["A"]'::jsonb,
'Field changes should be coordinated so required devices remain properly located and accessible.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Dwelling Wiring?',
'[{"key":"A","text":"Installing devices without checking conductor identity or condition"},{"key":"B","text":"Installing and verifying routine dwelling branch circuits, devices, lighting, grounding, and wiring methods while recognizing common installation problems"},{"key":"C","text":"Forcing devices into overcrowded boxes"},{"key":"D","text":"Ignoring test results when equipment operates"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably completing routine dwelling wiring work and recognizing common defects or conflicts.');

create temporary table _seed_dwelling_wiring_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_dwelling_wiring_l3_questions (
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
'Why must dwelling circuit planning consider load type, device location, wiring method, and protection requirements together?',
'[{"key":"A","text":"Because the complete installation must function safely and suit the actual use and location"},{"key":"B","text":"Because only device color matters"},{"key":"C","text":"Because wiring method determines utility voltage"},{"key":"D","text":"Because protection requirements replace load calculations"}]'::jsonb,
'["A"]'::jsonb,
'Competent dwelling-circuit planning integrates load, location, wiring method, device, and protection requirements.'),

(2,'multiple_choice','foundational',
'Why is troubleshooting a dwelling circuit more reliable when the circuit path is understood from source through each device and load?',
'[{"key":"A","text":"It allows the journeyman to isolate faults systematically rather than replacing parts at random"},{"key":"B","text":"It eliminates the need for testing"},{"key":"C","text":"It increases available fault current"},{"key":"D","text":"It changes the breaker rating"}]'::jsonb,
'["A"]'::jsonb,
'Understanding the circuit path supports efficient and accurate troubleshooting.'),

(3,'multiple_choice','foundational',
'Why can a device that physically fits in a box still be an unacceptable installation?',
'[{"key":"A","text":"Box capacity, conductor condition, device rating, grounding, support, accessibility, or other requirements may still be unsatisfied"},{"key":"B","text":"Physical fit proves complete compliance"},{"key":"C","text":"Only wall finish determines acceptability"},{"key":"D","text":"Device rating does not matter"}]'::jsonb,
'["A"]'::jsonb,
'Physical fit alone does not establish a complete and acceptable dwelling-device installation.'),

(4,'multiple_choice','foundational',
'Why should a journeyman verify field conditions before finalizing dwelling wiring routes?',
'[{"key":"A","text":"Framing, finishes, equipment, other trades, and actual access can differ from planned conditions"},{"key":"B","text":"Field conditions never affect wiring"},{"key":"C","text":"Only conductor color can change"},{"key":"D","text":"Drawings eliminate the need for coordination"}]'::jsonb,
'["A"]'::jsonb,
'Actual field conditions can affect route suitability, accessibility, protection, and device placement.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A dwelling renovation adds several loads to an existing branch circuit. What should the journeyman do before approving the change?',
'[{"key":"A","text":"Evaluate the existing circuit, load, conductor, protection, and device suitability for the revised conditions"},{"key":"B","text":"Add the loads if spare device spaces exist"},{"key":"C","text":"Increase the breaker size without review"},{"key":"D","text":"Assume the original circuit can support any added load"}]'::jsonb,
'["A"]'::jsonb,
'Changes to existing dwelling circuits require evaluation of the complete circuit and revised loading.'),

(6,'multiple_select','application',
'Which THREE factors should a journeyman consider when planning dwelling branch-circuit routing?',
'[{"key":"A","text":"Physical protection and framing conditions"},{"key":"B","text":"Device and load locations"},{"key":"C","text":"Access, coordination, and wiring-method suitability"},{"key":"D","text":"Paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Routing should integrate protection, load locations, access, coordination, and wiring-method suitability.'),

(7,'situational_judgment','application',
'A kitchen remodeling plan relocates appliances and receptacles after rough-in is complete. What is the BEST response?',
'[{"key":"A","text":"Reevaluate affected circuits, device locations, load requirements, routing, and protection before revising the installation"},{"key":"B","text":"Extend any nearby circuit without review"},{"key":"C","text":"Leave inaccessible abandoned wiring energized"},{"key":"D","text":"Ignore the revised appliance layout"}]'::jsonb,
'["A"]'::jsonb,
'Layout changes can affect circuit loading, routing, device placement, and protection requirements.'),

(8,'multiple_choice','application',
'Why should a journeyman verify polarity and grounding during final dwelling-device checks?',
'[{"key":"A","text":"Correct device wiring is necessary for intended operation and electrical safety"},{"key":"B","text":"Polarity changes conductor ampacity"},{"key":"C","text":"Grounding replaces overcurrent protection"},{"key":"D","text":"Verification is only cosmetic"}]'::jsonb,
'["A"]'::jsonb,
'Final verification should confirm devices are connected and grounded as intended.'),

(9,'situational_judgment','application',
'A lighting circuit repeatedly trips after a new fixture is installed. What should the journeyman do?',
'[{"key":"A","text":"Systematically evaluate the new fixture, conductors, connections, load, and circuit condition before resetting repeatedly"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Bypass the breaker temporarily"},{"key":"D","text":"Assume nuisance tripping"}]'::jsonb,
'["A"]'::jsonb,
'Repeated tripping indicates a condition that should be diagnosed rather than defeated.'),

(10,'multiple_choice','application',
'What is the BEST reason to coordinate device-box locations before wall finishes are installed?',
'[{"key":"A","text":"Proper location affects accessibility, alignment, support, usability, and final finish quality"},{"key":"B","text":"Box location changes system frequency"},{"key":"C","text":"Box location eliminates grounding"},{"key":"D","text":"Location has no effect after rough-in"}]'::jsonb,
'["A"]'::jsonb,
'Good coordination prevents inaccessible, misaligned, or poorly finished device installations.'),

(11,'situational_judgment','application',
'An existing dwelling circuit has undocumented splices and modifications from prior work. What should the journeyman do before extending it?',
'[{"key":"A","text":"Establish the circuit condition, identify the conductors and connections, and verify suitability before adding new work"},{"key":"B","text":"Extend it from the nearest box without investigation"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Ignore hidden modifications"}]'::jsonb,
'["A"]'::jsonb,
'Existing conditions should be understood before they are incorporated into new work.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A newly wired dwelling circuit passes a basic voltage check but one receptacle tester indicates a wiring fault. What is the BEST response?',
'[{"key":"A","text":"Investigate the affected receptacle and circuit connections before accepting the circuit"},{"key":"B","text":"Ignore the tester because voltage is present"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Remove the equipment grounding path"}]'::jsonb,
'["A"]'::jsonb,
'A circuit should not be accepted until inconsistent test results are resolved.'),

(13,'scenario','scenario',
'Several receptacles on one circuit stop working, but the breaker is not tripped. What should the journeyman do?',
'[{"key":"A","text":"Trace the circuit systematically to identify the open connection, device, splice, or upstream condition"},{"key":"B","text":"Replace all receptacles immediately"},{"key":"C","text":"Install a larger breaker"},{"key":"D","text":"Assume utility failure"}]'::jsonb,
'["A"]'::jsonb,
'Understanding circuit sequence helps isolate an open condition efficiently.'),

(14,'scenario','scenario',
'A renovation exposes a cable that was installed where repeated physical damage is likely. What is the BEST response?',
'[{"key":"A","text":"Revise or protect the wiring method appropriately before the area is closed"},{"key":"B","text":"Leave it because the cable is currently intact"},{"key":"C","text":"Paint the cable"},{"key":"D","text":"Reduce the circuit load"}]'::jsonb,
'["A"]'::jsonb,
'The installation should address foreseeable physical damage, not only existing damage.'),

(15,'situational_judgment','scenario',
'A device box contains signs of overheating at one termination. What should the journeyman do?',
'[{"key":"A","text":"Investigate the device, conductor, connection condition, load, and related circuit factors before returning it to service"},{"key":"B","text":"Tighten the screw randomly and close the box"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Replace the cover plate only"}]'::jsonb,
'["A"]'::jsonb,
'Overheating can indicate a connection or loading problem and requires systematic evaluation.'),

(16,'scenario','scenario',
'A homeowner requests an additional high-load appliance on an existing general-purpose circuit. What should the journeyman do?',
'[{"key":"A","text":"Evaluate the appliance requirements and determine an appropriate circuit solution rather than simply tapping the existing circuit"},{"key":"B","text":"Connect it to the nearest receptacle circuit"},{"key":"C","text":"Increase the breaker size only"},{"key":"D","text":"Use an extension cord permanently"}]'::jsonb,
'["A"]'::jsonb,
'New significant loads should be evaluated against the actual circuit and equipment requirements.'),

(17,'scenario','scenario',
'After cabinets are installed, a required device location is inaccessible. What should the journeyman do?',
'[{"key":"A","text":"Coordinate a compliant and usable correction rather than leaving the device inaccessible"},{"key":"B","text":"Leave it hidden"},{"key":"C","text":"Remove the device without review"},{"key":"D","text":"Install an unlabeled extension inside the wall"}]'::jsonb,
'["A"]'::jsonb,
'Field conflicts should be resolved so devices remain properly located and accessible.'),

(18,'scenario','scenario',
'A lighting circuit has an intermittent fault that only appears when multiple switches are operated. What is the BEST approach?',
'[{"key":"A","text":"Use the circuit layout and systematic testing to isolate the affected switching, conductors, splices, and loads"},{"key":"B","text":"Replace every switch at once"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Ignore the fault until it becomes permanent"}]'::jsonb,
'["A"]'::jsonb,
'Complex intermittent faults are best resolved through systematic circuit tracing and testing.'),

(19,'scenario','scenario',
'A dwelling rough-in matches the drawings, but field framing changes make several cable routes poorly protected and difficult to service. What should the journeyman do?',
'[{"key":"A","text":"Coordinate revised routes or protection methods that suit the actual field conditions"},{"key":"B","text":"Follow the drawing route regardless of field conditions"},{"key":"C","text":"Install loose cable outside framing"},{"key":"D","text":"Reduce conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Good journeyman work adapts plans to actual field conditions while maintaining installation quality.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Dwelling Wiring?',
'[{"key":"A","text":"Completing only simple device replacements"},{"key":"B","text":"Independently planning, installing, verifying, troubleshooting, and correcting dwelling branch circuits while coordinating loads, devices, wiring methods, protection, and field conditions"},{"key":"C","text":"Increasing breaker sizes to solve circuit problems"},{"key":"D","text":"Ignoring undocumented existing wiring"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently managing dwelling wiring installation, verification, troubleshooting, and field coordination.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '2944b044-1282-49b3-8141-389ee282e1d8';
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
      and c.name = 'Dwelling Wiring'
      and c.is_current = true
  ) then
    raise exception 'Current Dwelling Wiring Master Competency not found';
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
  v_assessment_name := 'Dwelling Wiring — Level 2 Competency Assessment';

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
    select * from _seed_dwelling_wiring_l2_questions
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
        'Dwelling Wiring',
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
      'IntegrateU Dwelling Wiring L2 production assessment v1.0.',
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
        'Dwelling Wiring',
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
        'IntegrateU Dwelling Wiring L2 production assessment v1.0.',
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
  v_assessment_name := 'Dwelling Wiring — Level 3 Competency Assessment';

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
    select * from _seed_dwelling_wiring_l3_questions
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
        'Dwelling Wiring',
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
      'IntegrateU Dwelling Wiring L3 production assessment v1.0.',
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
        'Dwelling Wiring',
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
        'IntegrateU Dwelling Wiring L3 production assessment v1.0.',
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
   '2944b044-1282-49b3-8141-389ee282e1d8'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '2944b044-1282-49b3-8141-389ee282e1d8'::uuid
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
      '2944b044-1282-49b3-8141-389ee282e1d8'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      '2944b044-1282-49b3-8141-389ee282e1d8'::uuid
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
  '2944b044-1282-49b3-8141-389ee282e1d8'::uuid;

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
    '2944b044-1282-49b3-8141-389ee282e1d8'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
