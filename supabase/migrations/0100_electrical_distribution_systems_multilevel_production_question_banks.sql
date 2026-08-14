-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0100_electrical_distribution_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Distribution Systems
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

create temporary table _seed_electrical_distribution_systems_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_distribution_systems_l1_questions (
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
'What is the primary purpose of an electrical panelboard in a distribution system?',
'[{"key":"A","text":"To distribute electrical power to branch circuits through protective devices"},{"key":"B","text":"To generate electrical power"},{"key":"C","text":"To replace all branch-circuit wiring"},{"key":"D","text":"To increase utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'A panelboard distributes power to downstream circuits and contains associated protective devices.'),

(2,'multiple_choice','foundational',
'What is the main purpose of a circuit breaker or fuse?',
'[{"key":"A","text":"To provide overcurrent protection"},{"key":"B","text":"To increase conductor ampacity"},{"key":"C","text":"To identify grounded conductors"},{"key":"D","text":"To regulate utility voltage"}]'::jsonb,
'["A"]'::jsonb,
'Circuit breakers and fuses provide protection against excessive current.'),

(3,'multiple_choice','foundational',
'What does the term electrical load generally refer to?',
'[{"key":"A","text":"Equipment or devices that consume electrical power"},{"key":"B","text":"Only the service enclosure"},{"key":"C","text":"The grounding electrode alone"},{"key":"D","text":"The utility meter only"}]'::jsonb,
'["A"]'::jsonb,
'Loads are devices or equipment that use electrical energy.'),

(4,'multiple_choice','foundational',
'What is the purpose of equipment grounding and bonding in a distribution system?',
'[{"key":"A","text":"To provide an effective fault-current path and connect conductive parts appropriately"},{"key":"B","text":"To carry normal circuit load current as the primary path"},{"key":"C","text":"To eliminate overcurrent protection"},{"key":"D","text":"To increase system voltage"}]'::jsonb,
'["A"]'::jsonb,
'Grounding and bonding support an effective fault-current path and proper connection of conductive equipment parts.'),

(5,'multiple_choice','foundational',
'What is a branch circuit?',
'[{"key":"A","text":"The circuit conductors between the final overcurrent device and the outlets or loads supplied"},{"key":"B","text":"The utility transmission line"},{"key":"C","text":"The grounding electrode conductor only"},{"key":"D","text":"The service transformer winding"}]'::jsonb,
'["A"]'::jsonb,
'A branch circuit extends from the final overcurrent protective device to the supplied outlets or equipment.'),

(6,'multiple_choice','foundational',
'What is a feeder generally used for?',
'[{"key":"A","text":"To supply power from distribution equipment to downstream distribution or load equipment"},{"key":"B","text":"To replace grounding conductors"},{"key":"C","text":"To identify circuit directories"},{"key":"D","text":"To reduce system frequency"}]'::jsonb,
'["A"]'::jsonb,
'Feeders supply downstream distribution equipment or grouped loads rather than individual final branch-circuit outlets.'),

(7,'multiple_choice','foundational',
'Why should electrical distribution equipment be clearly identified?',
'[{"key":"A","text":"To support safe operation, isolation, maintenance, and troubleshooting"},{"key":"B","text":"To increase equipment interrupting rating"},{"key":"C","text":"To change conductor resistance"},{"key":"D","text":"To eliminate testing"}]'::jsonb,
'["A"]'::jsonb,
'Accurate identification helps workers operate and service distribution equipment correctly.'),

(8,'multiple_choice','foundational',
'Why is electrical distribution equipment kept accessible?',
'[{"key":"A","text":"So it can be safely operated, inspected, maintained, and serviced"},{"key":"B","text":"So conductors can be left unsupported"},{"key":"C","text":"To increase fault current"},{"key":"D","text":"To eliminate circuit directories"}]'::jsonb,
'["A"]'::jsonb,
'Distribution equipment requires appropriate access for operation and service.'),

-- APPLICATION — 8

(9,'situational_judgment','application',
'A breaker is repeatedly tripping. What is the BEST response for a Level 1 worker?',
'[{"key":"A","text":"Report the condition and avoid repeatedly resetting it without determining why it is tripping"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Hold the breaker in the ON position"},{"key":"D","text":"Bypass the breaker temporarily"}]'::jsonb,
'["A"]'::jsonb,
'Repeated operation of an overcurrent device can indicate a fault or overload that requires proper evaluation.'),

(10,'multiple_choice','application',
'Why should a panel directory accurately identify the circuits it serves?',
'[{"key":"A","text":"It helps workers locate and isolate the correct circuit"},{"key":"B","text":"It increases breaker capacity"},{"key":"C","text":"It changes system voltage"},{"key":"D","text":"It replaces lockout procedures"}]'::jsonb,
'["A"]'::jsonb,
'Accurate circuit identification supports safer isolation and troubleshooting.'),

(11,'situational_judgment','application',
'You notice a missing cover on energized distribution equipment. What is the BEST action?',
'[{"key":"A","text":"Keep clear, report the condition, and have the equipment properly secured before normal work continues"},{"key":"B","text":"Reach inside to identify the parts"},{"key":"C","text":"Cover it with cardboard"},{"key":"D","text":"Ignore it if nothing is sparking"}]'::jsonb,
'["A"]'::jsonb,
'Exposed energized parts present a serious hazard and require proper correction.'),

(12,'multiple_select','application',
'Which THREE practices support safe work around electrical distribution equipment?',
'[{"key":"A","text":"Maintain required access and working space"},{"key":"B","text":"Keep equipment identified"},{"key":"C","text":"Report damaged or open equipment"},{"key":"D","text":"Store materials in front of panels"},{"key":"E","text":"Defeat protective devices that trip"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Access, identification, and prompt correction of damaged equipment are basic distribution-system safety practices.'),

(13,'multiple_choice','application',
'What is the BEST reason to match a protective device to the circuit it protects?',
'[{"key":"A","text":"The protective device must coordinate appropriately with the conductors and connected equipment"},{"key":"B","text":"Any breaker that physically fits is acceptable"},{"key":"C","text":"A larger breaker always improves reliability"},{"key":"D","text":"Breaker rating affects only labeling"}]'::jsonb,
'["A"]'::jsonb,
'Overcurrent protection must be suitable for the conductors and equipment it protects.'),

(14,'situational_judgment','application',
'A panel circuit directory does not match the actual loads being turned off. What should happen?',
'[{"key":"A","text":"The circuit identification should be verified and corrected before relying on the directory"},{"key":"B","text":"Use the directory anyway"},{"key":"C","text":"Remove all labels"},{"key":"D","text":"Increase breaker ratings"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect identification can lead to unsafe assumptions during isolation and maintenance.'),

(15,'multiple_choice','application',
'Why should openings in distribution equipment be properly closed?',
'[{"key":"A","text":"To maintain the enclosure and prevent unintended access or entry of foreign material"},{"key":"B","text":"To increase system voltage"},{"key":"C","text":"To reduce conductor size"},{"key":"D","text":"To eliminate grounding"}]'::jsonb,
'["A"]'::jsonb,
'Unused openings should be properly closed to maintain the enclosure and protect internal parts.'),

(16,'situational_judgment','application',
'You find stored materials blocking access to an electrical panel. What is the BEST response?',
'[{"key":"A","text":"Restore the required access and keep the working area clear"},{"key":"B","text":"Leave the materials if the panel door can open slightly"},{"key":"C","text":"Move the panel"},{"key":"D","text":"Turn off one breaker"}]'::jsonb,
'["A"]'::jsonb,
'Electrical distribution equipment needs adequate working access for safe operation and service.'),

-- SCENARIO — 4

(17,'scenario','scenario',
'A worker is unsure which breaker supplies equipment that needs to be serviced. What is the BEST action?',
'[{"key":"A","text":"Verify the correct source before beginning the work rather than relying on an uncertain label"},{"key":"B","text":"Turn off the breaker that looks most likely"},{"key":"C","text":"Begin work and check for voltage later"},{"key":"D","text":"Assume the nearest panel supplies it"}]'::jsonb,
'["A"]'::jsonb,
'The correct electrical source should be established before service work begins.'),

(18,'scenario','scenario',
'A breaker trips immediately each time it is reset. What is the BEST response?',
'[{"key":"A","text":"Stop resetting it and have the circuit condition evaluated"},{"key":"B","text":"Replace it with a larger breaker"},{"key":"C","text":"Tape the handle in the ON position"},{"key":"D","text":"Bypass the breaker"}]'::jsonb,
'["A"]'::jsonb,
'Immediate repeated tripping can indicate a serious circuit problem and should not be defeated.'),

(19,'scenario','scenario',
'An electrical panel has visible damage around one breaker position. What should a Level 1 worker do?',
'[{"key":"A","text":"Avoid disturbing the damaged area and escalate it for qualified evaluation"},{"key":"B","text":"Push the breaker firmly into place"},{"key":"C","text":"Cover the damage with tape"},{"key":"D","text":"Ignore it if the circuit still operates"}]'::jsonb,
'["A"]'::jsonb,
'Visible damage in distribution equipment should be treated as a condition requiring qualified evaluation.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Electrical Distribution Systems?',
'[{"key":"A","text":"Replacing protective devices with larger sizes when they trip"},{"key":"B","text":"Recognizing basic distribution equipment and circuit functions, maintaining access and identification, and escalating abnormal or hazardous conditions"},{"key":"C","text":"Opening energized equipment to identify components"},{"key":"D","text":"Ignoring incorrect circuit directories"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance centers on recognizing basic distribution-system components, normal practices, and conditions requiring escalation.');

create temporary table _seed_electrical_distribution_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_distribution_systems_l3_questions (
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
'Why must electrical distribution equipment ratings be evaluated as a system rather than component by component only?',
'[{"key":"A","text":"Voltage, current, fault duty, conductor, protective-device, and equipment ratings must be suitable together"},{"key":"B","text":"Only enclosure size matters"},{"key":"C","text":"All distribution equipment has identical ratings"},{"key":"D","text":"Protective devices eliminate equipment-rating concerns"}]'::jsonb,
'["A"]'::jsonb,
'Distribution-system suitability depends on coordinated ratings and actual system conditions.'),

(2,'multiple_choice','foundational',
'What is the purpose of coordinating overcurrent protection with downstream conductors and equipment?',
'[{"key":"A","text":"To provide appropriate protection and limit damage under abnormal current conditions"},{"key":"B","text":"To increase normal operating current"},{"key":"C","text":"To eliminate grounding"},{"key":"D","text":"To replace load calculations"}]'::jsonb,
'["A"]'::jsonb,
'Protective devices should be selected and applied in coordination with the conductors and equipment they protect.'),

(3,'multiple_choice','foundational',
'Why is an effective fault-current path important in a distribution system?',
'[{"key":"A","text":"It supports operation of protective devices when a fault energizes normally non-current-carrying conductive parts"},{"key":"B","text":"It is intended to carry normal load current continuously"},{"key":"C","text":"It increases branch-circuit voltage"},{"key":"D","text":"It replaces overcurrent protection"}]'::jsonb,
'["A"]'::jsonb,
'An effective fault-current path supports prompt protective-device operation during applicable faults.'),

(4,'multiple_choice','foundational',
'Why should a journeyman understand the one-line or distribution path from source to load?',
'[{"key":"A","text":"It supports proper isolation, troubleshooting, load planning, and evaluation of upstream and downstream relationships"},{"key":"B","text":"It eliminates the need for field verification"},{"key":"C","text":"It determines conductor color"},{"key":"D","text":"It makes panel directories unnecessary"}]'::jsonb,
'["A"]'::jsonb,
'Understanding the distribution path is fundamental to safe system operation, troubleshooting, and modification.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A new load is being added to an existing panel. What should the journeyman evaluate before approving the connection?',
'[{"key":"A","text":"Panel capacity, circuit requirements, conductor and protective-device suitability, and the existing load conditions"},{"key":"B","text":"Only whether an unused breaker space exists"},{"key":"C","text":"Only the color of the conductors"},{"key":"D","text":"Whether the new breaker physically fits"}]'::jsonb,
'["A"]'::jsonb,
'An open physical space does not by itself establish electrical capacity or suitability.'),

(6,'multiple_select','application',
'Which THREE items commonly belong in an electrical distribution-system review?',
'[{"key":"A","text":"Equipment and protective-device ratings"},{"key":"B","text":"Conductor and load requirements"},{"key":"C","text":"Grounding, bonding, and system configuration"},{"key":"D","text":"Panel paint color"},{"key":"E","text":"Installer preference only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Distribution evaluation integrates equipment ratings, load and conductor requirements, and grounding and bonding conditions.'),

(7,'situational_judgment','application',
'A breaker is found to have a higher rating than the conductors it appears to protect. What is the BEST response?',
'[{"key":"A","text":"Verify the circuit design and correct any mismatch before the circuit remains in service"},{"key":"B","text":"Leave it because larger breakers trip less often"},{"key":"C","text":"Increase conductor load"},{"key":"D","text":"Change only the circuit label"}]'::jsonb,
'["A"]'::jsonb,
'Protective-device and conductor relationships must be verified rather than assumed acceptable.'),

(8,'multiple_choice','application',
'Why should a journeyman verify available system voltage and equipment voltage rating before connecting distribution equipment?',
'[{"key":"A","text":"Equipment must be suitable for the actual system voltage and configuration"},{"key":"B","text":"Voltage rating affects only labeling"},{"key":"C","text":"Any equipment can operate on any voltage"},{"key":"D","text":"Protective devices automatically correct voltage mismatch"}]'::jsonb,
'["A"]'::jsonb,
'Distribution equipment must match the system voltage and configuration for which it is applied.'),

(9,'situational_judgment','application',
'A panel is heavily loaded and a new circuit is requested. What should the journeyman do?',
'[{"key":"A","text":"Evaluate actual and calculated loading and equipment capacity before adding the circuit"},{"key":"B","text":"Install the circuit if a breaker space is available"},{"key":"C","text":"Replace the main breaker with a larger one"},{"key":"D","text":"Ignore existing loads"}]'::jsonb,
'["A"]'::jsonb,
'Available breaker spaces and available electrical capacity are not the same thing.'),

(10,'multiple_choice','application',
'Why should neutral and grounding relationships be verified when working on distribution equipment?',
'[{"key":"A","text":"Improper connections can create objectionable current paths or compromise fault-current performance"},{"key":"B","text":"Neutral and grounding conductors are always interchangeable"},{"key":"C","text":"Their relationship affects only appearance"},{"key":"D","text":"Grounding eliminates the need for neutrals"}]'::jsonb,
'["A"]'::jsonb,
'Grounded and grounding conductor relationships must be correct for the applicable point in the distribution system.'),

(11,'situational_judgment','application',
'An existing distribution panel has unclear circuit identification and undocumented modifications. What should happen before significant new work is added?',
'[{"key":"A","text":"Establish the existing system configuration, circuit identities, and equipment condition before relying on it"},{"key":"B","text":"Add new breakers wherever space exists"},{"key":"C","text":"Remove all labels"},{"key":"D","text":"Assume the original drawings are still exact"}]'::jsonb,
'["A"]'::jsonb,
'Existing distribution conditions should be verified before new work is integrated into the system.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A facility plans to add a significant new electrical load to an existing distribution panel. The panel has open breaker spaces. What is the BEST conclusion?',
'[{"key":"A","text":"Open spaces alone do not prove capacity; system loading, equipment ratings, conductors, and protection must be evaluated"},{"key":"B","text":"The load can be added because physical space is available"},{"key":"C","text":"A larger main breaker should automatically be installed"},{"key":"D","text":"Only the branch breaker rating matters"}]'::jsonb,
'["A"]'::jsonb,
'Physical breaker space is not equivalent to electrical system capacity.'),

(13,'scenario','scenario',
'A downstream panel loses power, but its main device appears normal. What is the BEST troubleshooting approach?',
'[{"key":"A","text":"Trace the distribution path systematically, verifying upstream source, protective devices, conductors, and connections"},{"key":"B","text":"Replace the downstream panel immediately"},{"key":"C","text":"Increase downstream breaker ratings"},{"key":"D","text":"Assume utility failure without testing"}]'::jsonb,
'["A"]'::jsonb,
'Understanding the source-to-load path allows faults to be isolated methodically.'),

(14,'scenario','scenario',
'Inspection reveals signs of overheating at a distribution-equipment termination. What should the journeyman do?',
'[{"key":"A","text":"Keep the affected condition from normal service and investigate the conductor, terminal, load, connection, and equipment condition"},{"key":"B","text":"Tighten it randomly while energized"},{"key":"C","text":"Install a larger breaker"},{"key":"D","text":"Replace only the panel label"}]'::jsonb,
'["A"]'::jsonb,
'Overheating can indicate a serious connection, loading, or equipment problem requiring systematic evaluation.'),

(15,'scenario','scenario',
'A protective device repeatedly opens under normal operating conditions after new equipment was added. What is the BEST response?',
'[{"key":"A","text":"Evaluate the new load, circuit conditions, equipment, conductors, and protective-device application rather than defeating the protection"},{"key":"B","text":"Install the next larger breaker"},{"key":"C","text":"Hold the device closed"},{"key":"D","text":"Bypass the protective device"}]'::jsonb,
'["A"]'::jsonb,
'Repeated protective-device operation indicates a condition that should be diagnosed, not bypassed.'),

(16,'scenario','scenario',
'A replacement breaker has the correct ampere rating but is not identified for use with the existing panel. What should the journeyman do?',
'[{"key":"A","text":"Use only a protective device suitable for the specific equipment and application"},{"key":"B","text":"Install it because the ampere rating matches"},{"key":"C","text":"Modify the breaker so it fits"},{"key":"D","text":"Leave the panel cover off"}]'::jsonb,
'["A"]'::jsonb,
'Matching ampere rating alone does not establish equipment compatibility.'),

(17,'scenario','scenario',
'A renovation changes the distribution arrangement so an existing panel will now be supplied differently than originally designed. What should happen?',
'[{"key":"A","text":"Reevaluate system configuration, equipment ratings, grounding and bonding, conductors, protection, and documentation before energization"},{"key":"B","text":"Reconnect it based only on conductor color"},{"key":"C","text":"Assume the previous configuration still applies"},{"key":"D","text":"Increase breaker sizes to avoid nuisance trips"}]'::jsonb,
'["A"]'::jsonb,
'Changes to distribution configuration can affect multiple electrical relationships and require full reevaluation.'),

(18,'scenario','scenario',
'A panel schedule identifies a circuit incorrectly, and the wrong equipment is de-energized during maintenance preparation. What is the BEST corrective action?',
'[{"key":"A","text":"Stop, verify actual circuit relationships, correct the identification, and reestablish the isolation plan before work proceeds"},{"key":"B","text":"Continue because some equipment is de-energized"},{"key":"C","text":"Remove all panel labels"},{"key":"D","text":"Rely on memory for future work"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect circuit identification compromises safe isolation and must be corrected before work continues.'),

(19,'scenario','scenario',
'An existing panel shows evidence of prior field modifications that are not reflected in project documentation. What is the BEST approach?',
'[{"key":"A","text":"Verify the actual distribution configuration and equipment condition, document the findings, and resolve discrepancies before relying on the system"},{"key":"B","text":"Assume the modifications are acceptable because the system is energized"},{"key":"C","text":"Ignore the modifications if the panel door closes"},{"key":"D","text":"Add new work without investigation"}]'::jsonb,
'["A"]'::jsonb,
'Undocumented changes should be verified and reconciled before additional work is based on the existing system.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Electrical Distribution Systems?',
'[{"key":"A","text":"Recognizing panelboards and breakers only"},{"key":"B","text":"Independently evaluating distribution paths, loads, equipment ratings, overcurrent protection, grounding and bonding, system modifications, and abnormal conditions while coordinating safe corrective action"},{"key":"C","text":"Using open breaker spaces as proof of available capacity"},{"key":"D","text":"Increasing breaker ratings whenever devices trip"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently evaluating and troubleshooting distribution systems while integrating loading, protection, equipment, grounding, and field conditions.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '9837175b-ab9d-4170-b064-0de31e2596cc';
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
      and c.name = 'Electrical Distribution Systems'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Distribution Systems Master Competency not found';
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
  v_assessment_name := 'Electrical Distribution Systems — Level 1 Competency Assessment';

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
    select * from _seed_electrical_distribution_systems_l1_questions
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
        'Electrical Distribution Systems',
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
      'IntegrateU Electrical Distribution Systems L1 production assessment v1.0.',
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
        'Electrical Distribution Systems',
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
        'IntegrateU Electrical Distribution Systems L1 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Distribution Systems — Level 3 Competency Assessment';

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
    select * from _seed_electrical_distribution_systems_l3_questions
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
        'Electrical Distribution Systems',
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
      'IntegrateU Electrical Distribution Systems L3 production assessment v1.0.',
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
        'Electrical Distribution Systems',
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
        'IntegrateU Electrical Distribution Systems L3 production assessment v1.0.',
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
   '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid
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
      '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid
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
  '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid;

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
    '9837175b-ab9d-4170-b064-0de31e2596cc'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
