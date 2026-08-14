-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0103_feeders_services_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Feeders & Services
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

create temporary table _seed_feeders_services_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_feeders_services_l1_questions (
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
'What is the primary purpose of a feeder in an electrical distribution system?',
'[{"key":"A","text":"To carry power from service or other distribution equipment to downstream distribution or loads"},{"key":"B","text":"To generate utility power"},{"key":"C","text":"To replace branch-circuit overcurrent protection"},{"key":"D","text":"To identify grounding electrodes"}]'::jsonb,
'["A"]'::jsonb,
'A feeder supplies downstream distribution equipment or grouped loads from an upstream source.'),

(2,'multiple_choice','foundational',
'What is the general purpose of service conductors?',
'[{"key":"A","text":"To carry power from the service point toward the service equipment"},{"key":"B","text":"To supply only individual lighting outlets"},{"key":"C","text":"To replace equipment grounding conductors"},{"key":"D","text":"To control utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'Service conductors are part of the supply path from the service point to service equipment.'),

(3,'multiple_choice','foundational',
'What is the main function of service equipment?',
'[{"key":"A","text":"To provide the service disconnecting and associated control or protection functions"},{"key":"B","text":"To replace the utility transformer"},{"key":"C","text":"To eliminate grounding and bonding"},{"key":"D","text":"To supply only one receptacle"}]'::jsonb,
'["A"]'::jsonb,
'Service equipment provides the primary disconnecting and related functions at the service.'),

(4,'multiple_choice','foundational',
'Why must feeder and service conductors be sized appropriately?',
'[{"key":"A","text":"They must safely carry the calculated load under the applicable installation conditions"},{"key":"B","text":"Conductor size affects only color"},{"key":"C","text":"Any conductor can serve any load if the breaker is large enough"},{"key":"D","text":"Sizing matters only for branch circuits"}]'::jsonb,
'["A"]'::jsonb,
'Feeder and service conductor sizing must match the electrical load and installation requirements.'),

(5,'multiple_choice','foundational',
'What is the main purpose of overcurrent protection on feeders?',
'[{"key":"A","text":"To protect conductors and equipment from excessive current"},{"key":"B","text":"To increase available voltage"},{"key":"C","text":"To eliminate load calculations"},{"key":"D","text":"To identify the neutral"}]'::jsonb,
'["A"]'::jsonb,
'Overcurrent protection limits damage from overloads and faults when properly applied.'),

(6,'multiple_choice','foundational',
'Why is grounding and bonding important at service equipment?',
'[{"key":"A","text":"It establishes required system and fault-current relationships at the service"},{"key":"B","text":"It increases service voltage"},{"key":"C","text":"It replaces all protective devices"},{"key":"D","text":"It reduces conductor count automatically"}]'::jsonb,
'["A"]'::jsonb,
'Grounding and bonding at service equipment are fundamental to the intended system and fault-current path.'),

(7,'multiple_choice','foundational',
'Why should feeder and service equipment be clearly identified?',
'[{"key":"A","text":"To support safe operation, isolation, inspection, and maintenance"},{"key":"B","text":"To increase conductor ampacity"},{"key":"C","text":"To change fault current"},{"key":"D","text":"To eliminate testing"}]'::jsonb,
'["A"]'::jsonb,
'Clear identification helps workers understand and safely operate the distribution path.'),

(8,'multiple_choice','foundational',
'Why must required working space around service equipment be maintained?',
'[{"key":"A","text":"So the equipment can be safely operated, inspected, and serviced"},{"key":"B","text":"To increase service capacity"},{"key":"C","text":"To reduce grounding requirements"},{"key":"D","text":"To change the service voltage"}]'::jsonb,
'["A"]'::jsonb,
'Service equipment needs proper access for safe operation and maintenance.'),

(9,'situational_judgment','application',
'A feeder breaker repeatedly trips after additional loads are connected. What is the BEST Level 1 response?',
'[{"key":"A","text":"Report the condition and avoid repeatedly resetting or increasing protection without evaluation"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Hold the breaker closed"},{"key":"D","text":"Bypass the breaker"}]'::jsonb,
'["A"]'::jsonb,
'Repeated feeder overcurrent operation can indicate overload or fault conditions that require evaluation.'),

(10,'multiple_choice','application',
'Why should feeder conductors be identified correctly at both ends?',
'[{"key":"A","text":"To support correct termination, isolation, and future maintenance"},{"key":"B","text":"To increase conductor capacity"},{"key":"C","text":"To eliminate voltage testing"},{"key":"D","text":"To change phase sequence automatically"}]'::jsonb,
'["A"]'::jsonb,
'Accurate feeder identification reduces the risk of incorrect connection or isolation.'),

(11,'situational_judgment','application',
'Stored material is blocking access to service equipment. What should happen?',
'[{"key":"A","text":"Restore and maintain the required working access"},{"key":"B","text":"Leave it if the disconnect handle can be reached"},{"key":"C","text":"Move only the labels"},{"key":"D","text":"Increase the service rating"}]'::jsonb,
'["A"]'::jsonb,
'Service equipment must remain accessible for safe operation and servicing.'),

(12,'multiple_select','application',
'Which THREE conditions should a Level 1 worker recognize as important around feeders and services?',
'[{"key":"A","text":"Correct equipment identification"},{"key":"B","text":"Clear working space"},{"key":"C","text":"Visible damage or overheating"},{"key":"D","text":"Decorative enclosure color"},{"key":"E","text":"Installer preference"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Identification, access, and abnormal equipment conditions are basic feeder and service concerns.'),

(13,'multiple_choice','application',
'Why should unused openings in service equipment be properly closed?',
'[{"key":"A","text":"To maintain the enclosure and prevent unintended contact or entry of foreign material"},{"key":"B","text":"To increase service voltage"},{"key":"C","text":"To reduce conductor size"},{"key":"D","text":"To eliminate grounding"}]'::jsonb,
'["A"]'::jsonb,
'Properly closed openings help preserve the intended enclosure protection.'),

(14,'situational_judgment','application',
'A feeder conductor has visible insulation damage before termination. What is the BEST response?',
'[{"key":"A","text":"Stop and have the conductor condition evaluated and corrected before use"},{"key":"B","text":"Terminate it because the damage is near the end"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Cover the damage with paint"}]'::jsonb,
'["A"]'::jsonb,
'Known conductor damage should be addressed before the feeder is placed in service.'),

(15,'multiple_choice','application',
'Why should the service disconnect be accurately identified?',
'[{"key":"A","text":"So the correct service isolation point can be recognized quickly and reliably"},{"key":"B","text":"To increase fault current"},{"key":"C","text":"To eliminate lockout procedures"},{"key":"D","text":"To change conductor resistance"}]'::jsonb,
'["A"]'::jsonb,
'Accurate service-disconnect identification supports safe operation and emergency response.'),

(16,'situational_judgment','application',
'You notice discoloration and unusual heat at a feeder termination. What should a Level 1 worker do?',
'[{"key":"A","text":"Report the abnormal condition and keep it from being treated as normal until evaluated"},{"key":"B","text":"Increase the load to test it"},{"key":"C","text":"Tighten the connection while energized"},{"key":"D","text":"Ignore it if voltage is present"}]'::jsonb,
'["A"]'::jsonb,
'Heat and discoloration can indicate a serious connection or loading problem.'),

(17,'scenario','scenario',
'A service disconnect label does not match the equipment actually de-energized. What is the BEST response?',
'[{"key":"A","text":"Stop relying on the label, verify the actual service arrangement, and have the identification corrected"},{"key":"B","text":"Use the label anyway"},{"key":"C","text":"Remove every label"},{"key":"D","text":"Assume the nearest equipment is correct"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect service identification creates a serious isolation hazard and must be corrected.'),

(18,'scenario','scenario',
'A feeder protective device trips immediately each time it is reset. What is the BEST response?',
'[{"key":"A","text":"Stop resetting it and escalate the condition for qualified evaluation"},{"key":"B","text":"Install a larger device"},{"key":"C","text":"Bypass the device"},{"key":"D","text":"Hold it closed manually"}]'::jsonb,
'["A"]'::jsonb,
'Immediate repeated tripping can indicate a significant fault or overload and should not be defeated.'),

(19,'scenario','scenario',
'Service equipment has visible physical damage near energized parts. What should a Level 1 worker do?',
'[{"key":"A","text":"Keep clear and escalate the condition for qualified correction"},{"key":"B","text":"Push damaged parts back into place"},{"key":"C","text":"Cover the area with cardboard"},{"key":"D","text":"Ignore it if the service remains energized"}]'::jsonb,
'["A"]'::jsonb,
'Damage near energized service components requires qualified evaluation and correction.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Feeders & Services?',
'[{"key":"A","text":"Increasing breaker sizes when feeders trip"},{"key":"B","text":"Recognizing basic feeder, service, disconnect, protection, grounding, identification, and access requirements while escalating abnormal conditions"},{"key":"C","text":"Opening energized service equipment to investigate"},{"key":"D","text":"Ignoring damaged service conductors"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance centers on recognizing basic feeder and service functions and identifying conditions requiring qualified action.');

create temporary table _seed_feeders_services_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_feeders_services_l4_questions (
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
'Why must feeder and service design integrate calculated load, conductor sizing, protection, equipment ratings, and grounding rather than evaluate each independently?',
'[{"key":"A","text":"The complete distribution path must operate as a coordinated electrical system"},{"key":"B","text":"Only conductor size matters"},{"key":"C","text":"Grounding eliminates load calculations"},{"key":"D","text":"Equipment ratings apply only after energization"}]'::jsonb,
'["A"]'::jsonb,
'Advanced feeder and service work requires coordinated application of load, conductor, protection, equipment, and grounding requirements.'),

(2,'multiple_choice','foundational',
'Why is available fault current relevant when applying service and feeder equipment?',
'[{"key":"A","text":"Equipment and protective devices must be suitable for the fault duty they may experience"},{"key":"B","text":"Fault current affects only labels"},{"key":"C","text":"Fault current is unrelated to equipment ratings"},{"key":"D","text":"Larger conductors eliminate fault-current concerns"}]'::jsonb,
'["A"]'::jsonb,
'Service and feeder equipment must have ratings appropriate to the available fault-current conditions.'),

(3,'multiple_choice','foundational',
'Why can changes upstream of a feeder require reevaluation of downstream equipment?',
'[{"key":"A","text":"Upstream changes can affect voltage, fault duty, protection, grounding, and other downstream system conditions"},{"key":"B","text":"Upstream changes never affect downstream equipment"},{"key":"C","text":"Only panel labels change"},{"key":"D","text":"Feeder systems are electrically independent"}]'::jsonb,
'["A"]'::jsonb,
'Changes in source or upstream distribution can alter important conditions throughout the downstream system.'),

(4,'situational_judgment','application',
'A new feeder load is proposed for an existing service. What should the journeyman evaluate before approving it?',
'[{"key":"A","text":"Service and feeder calculated loading, conductor capacity, protection, equipment ratings, and system configuration"},{"key":"B","text":"Only whether breaker spaces exist"},{"key":"C","text":"Only feeder conductor color"},{"key":"D","text":"Only physical equipment dimensions"}]'::jsonb,
'["A"]'::jsonb,
'Adding feeder load requires evaluating both feeder and service capacity and associated equipment.'),

(5,'multiple_select','application',
'Which THREE items commonly belong in a Level 4 feeder and service review?',
'[{"key":"A","text":"Load and conductor sizing"},{"key":"B","text":"Overcurrent and equipment ratings"},{"key":"C","text":"Grounding, bonding, service configuration, and fault-duty considerations"},{"key":"D","text":"Enclosure paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced feeder and service evaluation integrates electrical capacity, protection, system configuration, and grounding relationships.'),

(6,'situational_judgment','application',
'A feeder conductor appears adequate by ampacity, but the connected equipment terminal is not suitable for the conductor configuration. What should happen?',
'[{"key":"A","text":"Resolve the conductor-to-equipment compatibility before installation"},{"key":"B","text":"Remove strands until it fits"},{"key":"C","text":"Force the conductor into the terminal"},{"key":"D","text":"Ignore the terminal limitation"}]'::jsonb,
'["A"]'::jsonb,
'Conductor ampacity alone does not establish a suitable feeder termination.'),

(7,'multiple_choice','application',
'Why should a journeyman verify service and feeder neutral and grounding relationships after a distribution change?',
'[{"key":"A","text":"Improper connections can create objectionable current paths or compromise fault-current performance"},{"key":"B","text":"Neutral and grounding conductors are always interchangeable"},{"key":"C","text":"Their relationship affects only labels"},{"key":"D","text":"Grounding replaces the neutral"}]'::jsonb,
'["A"]'::jsonb,
'Grounded and grounding conductor relationships must remain correct for the resulting system configuration.'),

(8,'situational_judgment','application',
'A replacement service disconnect has adequate current rating but a lower interrupting rating than the available fault current. What should the journeyman do?',
'[{"key":"A","text":"Select equipment suitable for the actual available fault-current condition"},{"key":"B","text":"Install it because the ampere rating matches"},{"key":"C","text":"Increase conductor size only"},{"key":"D","text":"Change the service label"}]'::jsonb,
'["A"]'::jsonb,
'Current rating and fault-duty rating address different requirements and both must be suitable.'),

(9,'multiple_choice','application',
'Why should feeder voltage drop be considered on long or heavily loaded runs?',
'[{"key":"A","text":"Excessive voltage drop can impair equipment performance even when ampacity is adequate"},{"key":"B","text":"Voltage drop increases conductor ampacity"},{"key":"C","text":"Voltage drop affects only labeling"},{"key":"D","text":"Overcurrent devices eliminate voltage drop"}]'::jsonb,
'["A"]'::jsonb,
'Feeder performance can be limited by voltage drop independently of ampacity.'),

(10,'situational_judgment','application',
'Existing service documentation conflicts with field conditions. What should happen before a major service modification?',
'[{"key":"A","text":"Verify and document the actual service configuration before finalizing the design or work plan"},{"key":"B","text":"Follow the old drawing regardless"},{"key":"C","text":"Assume field conditions are temporary"},{"key":"D","text":"Increase service protection"}]'::jsonb,
'["A"]'::jsonb,
'Major service work should be based on verified existing conditions, not unsupported documentation assumptions.'),

(11,'scenario','scenario',
'A service has open equipment space, but calculated demand is already near the service rating. A major new feeder is proposed. What is the BEST conclusion?',
'[{"key":"A","text":"Physical space does not establish electrical capacity; the full service and feeder loading must be evaluated"},{"key":"B","text":"The feeder can be added because there is space"},{"key":"C","text":"Install a larger main breaker automatically"},{"key":"D","text":"Ignore calculated demand"}]'::jsonb,
'["A"]'::jsonb,
'Available physical space and available electrical capacity are not equivalent.'),

(12,'scenario','scenario',
'A service upgrade changes the available fault current substantially. What should the journeyman review?',
'[{"key":"A","text":"The suitability of affected service, feeder, panel, and protective equipment for the new fault-duty condition"},{"key":"B","text":"Only the service label"},{"key":"C","text":"Only conductor colors"},{"key":"D","text":"Nothing downstream"}]'::jsonb,
'["A"]'::jsonb,
'Fault-current changes can affect the required ratings of multiple downstream components.'),

(13,'scenario','scenario',
'A feeder breaker is properly sized for the conductors, but it repeatedly opens after equipment changes. What is the BEST response?',
'[{"key":"A","text":"Evaluate the revised loads, operating characteristics, conductor conditions, equipment, and protective-device application"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Bypass the breaker"},{"key":"D","text":"Remove the circuit label"}]'::jsonb,
'["A"]'::jsonb,
'Repeated operation after load changes requires diagnosis of the actual electrical conditions rather than defeating protection.'),

(14,'scenario','scenario',
'A service replacement uses equipment with matching voltage and ampere ratings, but its grounding and bonding arrangement differs from the existing installation. What should happen?',
'[{"key":"A","text":"Reevaluate and implement the grounding and bonding arrangement appropriate to the resulting service configuration"},{"key":"B","text":"Copy every existing connection without review"},{"key":"C","text":"Bond neutral and ground at every downstream panel"},{"key":"D","text":"Remove equipment grounding conductors"}]'::jsonb,
'["A"]'::jsonb,
'Service changes can alter where and how grounding and bonding relationships must be established.'),

(15,'scenario','scenario',
'A feeder consists of parallel conductors, and one set follows a materially different route and length than the others. What should the journeyman do?',
'[{"key":"A","text":"Evaluate whether the parallel installation satisfies applicable conductor and installation requirements before proceeding"},{"key":"B","text":"Accept it because conductor sizes match"},{"key":"C","text":"Shorten one set after energization"},{"key":"D","text":"Increase the breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Parallel feeder conductors require coordinated conductor characteristics and installation conditions.'),

(16,'scenario','scenario',
'An existing service shows signs of overheating at the main termination. What is the BEST approach?',
'[{"key":"A","text":"Keep the affected condition from normal service and investigate load, conductor, terminal, torque, equipment condition, and source factors"},{"key":"B","text":"Increase the service rating"},{"key":"C","text":"Tighten it randomly while energized"},{"key":"D","text":"Ignore it if voltage remains normal"}]'::jsonb,
'["A"]'::jsonb,
'Main-terminal overheating can indicate a serious connection, loading, or equipment issue requiring systematic evaluation.'),

(17,'scenario','scenario',
'A service design was based on preliminary loads, but final equipment selections significantly increase demand. What should happen?',
'[{"key":"A","text":"Recalculate the service and affected feeders and reevaluate conductor, protection, and equipment sizing"},{"key":"B","text":"Keep the original design"},{"key":"C","text":"Increase only breaker sizes"},{"key":"D","text":"Reduce documented load values"}]'::jsonb,
'["A"]'::jsonb,
'Material load changes require the service and feeder design basis to be updated.'),

(18,'scenario','scenario',
'A building service is being reconfigured from one distribution arrangement to another. What should the journeyman coordinate before energization?',
'[{"key":"A","text":"Source and service configuration, load, conductors, protection, grounding and bonding, equipment ratings, identification, and documentation"},{"key":"B","text":"Only conductor color"},{"key":"C","text":"Only the service disconnect label"},{"key":"D","text":"Only the panel schedule"}]'::jsonb,
'["A"]'::jsonb,
'Major service reconfiguration affects multiple system relationships that must be coordinated together.'),

(19,'scenario','scenario',
'A proposed feeder installation technically fits the equipment and pathway, but leaves poor access for safe maintenance and future service. What should the journeyman do?',
'[{"key":"A","text":"Revise the installation so electrical requirements, access, maintainability, and workmanship are all acceptable"},{"key":"B","text":"Accept it because it physically fits"},{"key":"C","text":"Block the equipment after installation"},{"key":"D","text":"Remove identification labels"}]'::jsonb,
'["A"]'::jsonb,
'Level 4 work considers maintainability and safe access in addition to basic electrical fit.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 4 proficiency in Feeders & Services?',
'[{"key":"A","text":"Sizing feeders only from breaker ratings"},{"key":"B","text":"Independently integrating load calculations, conductor sizing, protection, service configuration, grounding and bonding, fault-duty ratings, voltage performance, field conditions, and system modifications while leading safe resolution of conflicts"},{"key":"C","text":"Using open breaker spaces as proof of capacity"},{"key":"D","text":"Increasing protective-device ratings whenever equipment trips"}]'::jsonb,
'["B"]'::jsonb,
'Level 4 performance means leading complex feeder and service planning, verification, modification, and troubleshooting as a coordinated electrical system.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '1a7221e8-53cf-4c2f-8371-4619d3dee2a6';
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
      and c.name = 'Feeders & Services'
      and c.is_current = true
  ) then
    raise exception 'Current Feeders & Services Master Competency not found';
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
      and mrcr.required_level = 4
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
  -- Seed Level 3
  -- ========================================================================

  v_level := 1;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Feeders & Services — Level 1 Competency Assessment';

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
    select * from _seed_feeders_services_l1_questions
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
        'Feeders & Services',
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
      'IntegrateU Feeders & Services L1 production assessment v1.0.',
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
        'Feeders & Services',
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
        'IntegrateU Feeders & Services L1 production assessment v1.0.',
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
  v_assessment_name := 'Feeders & Services — Level 4 Competency Assessment';

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
    select * from _seed_feeders_services_l4_questions
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
        'Feeders & Services',
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
      'IntegrateU Feeders & Services L4 production assessment v1.0.',
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
        'Feeders & Services',
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
        'IntegrateU Feeders & Services L4 production assessment v1.0.',
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
   '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid
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
      '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid
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
  '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid;

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
    '1a7221e8-53cf-4c2f-8371-4619d3dee2a6'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
