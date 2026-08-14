-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0108_electrical_installation_quality_verification_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Installation Quality & Verification
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

create temporary table _seed_electrical_installation_quality_verification_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_installation_quality_verification_l2_questions (
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
'What is the main purpose of verifying completed electrical work?',
'[{"key":"A","text":"To confirm the installation matches requirements and operates as intended"},{"key":"B","text":"To increase circuit capacity"},{"key":"C","text":"To replace project documentation"},{"key":"D","text":"To avoid testing"}]'::jsonb,
'["A"]'::jsonb,
'Verification confirms workmanship, installation requirements, and intended operation before acceptance.'),

(2,'multiple_choice','foundational',
'Why should electrical work be compared with project drawings and specifications?',
'[{"key":"A","text":"To verify the installed work aligns with the approved project requirements"},{"key":"B","text":"To change circuit voltage"},{"key":"C","text":"To eliminate inspection"},{"key":"D","text":"To increase conductor ampacity"}]'::jsonb,
'["A"]'::jsonb,
'Project documents provide the basis for checking whether installed work matches the intended design.'),

(3,'multiple_choice','foundational',
'What does good electrical workmanship generally include?',
'[{"key":"A","text":"Secure, orderly, undamaged, properly supported, and correctly terminated installation"},{"key":"B","text":"Only hidden wiring"},{"key":"C","text":"Only matching conductor colors"},{"key":"D","text":"Only energized equipment"}]'::jsonb,
'["A"]'::jsonb,
'Quality workmanship includes both proper electrical connections and sound physical installation.'),

(4,'multiple_choice','foundational',
'Why should installed equipment remain accessible where required?',
'[{"key":"A","text":"So it can be safely operated, inspected, serviced, and maintained"},{"key":"B","text":"To increase fault current"},{"key":"C","text":"To reduce conductor size"},{"key":"D","text":"To eliminate labeling"}]'::jsonb,
'["A"]'::jsonb,
'Required access supports safe operation and future inspection and maintenance.'),

(5,'multiple_choice','foundational',
'Why is accurate labeling part of installation quality?',
'[{"key":"A","text":"It supports correct operation, isolation, troubleshooting, and maintenance"},{"key":"B","text":"It increases voltage"},{"key":"C","text":"It replaces testing"},{"key":"D","text":"It changes breaker ratings"}]'::jsonb,
'["A"]'::jsonb,
'Accurate identification is part of a complete and maintainable electrical installation.'),

(6,'situational_judgment','application',
'A junction box cover is missing after installation work is complete. What should happen?',
'[{"key":"A","text":"Install the correct cover before the work is accepted"},{"key":"B","text":"Leave it if conductors are not touching the opening"},{"key":"C","text":"Tape cardboard over it"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Completed electrical enclosures should have the intended covers and protection in place.'),

(7,'multiple_choice','application',
'Why should conductor terminations be visually checked before energization?',
'[{"key":"A","text":"To identify loose, damaged, misplaced, or improperly prepared conductors"},{"key":"B","text":"To increase current capacity"},{"key":"C","text":"To eliminate functional testing"},{"key":"D","text":"To change conductor resistance"}]'::jsonb,
'["A"]'::jsonb,
'Visual verification can catch termination defects before they become operational problems.'),

(8,'situational_judgment','application',
'A panel directory does not match the circuits actually installed. What is the BEST response?',
'[{"key":"A","text":"Correct the directory so it accurately reflects the installed circuits"},{"key":"B","text":"Leave it because the wiring works"},{"key":"C","text":"Remove all labels"},{"key":"D","text":"Increase panel rating"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect circuit identification creates future operation and maintenance hazards.'),

(9,'multiple_select','application',
'Which THREE items should be checked during a basic installation-quality review?',
'[{"key":"A","text":"Support and physical condition"},{"key":"B","text":"Terminations and equipment connections"},{"key":"C","text":"Labels, covers, and documentation alignment"},{"key":"D","text":"Installer clothing"},{"key":"E","text":"Paint color preference"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Quality review includes physical installation, electrical connections, and identification or documentation.'),

(10,'situational_judgment','application',
'A conduit run is secure but visibly damaged near an equipment connection. What should happen?',
'[{"key":"A","text":"Have the damage evaluated and corrected before final acceptance"},{"key":"B","text":"Accept it because the conduit is supported"},{"key":"C","text":"Paint over the damage"},{"key":"D","text":"Increase conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Secure support does not make damaged raceway acceptable.'),

(11,'multiple_choice','application',
'Why should unused openings in electrical enclosures be properly closed?',
'[{"key":"A","text":"To maintain the enclosure and prevent unintended contact or entry of foreign material"},{"key":"B","text":"To increase voltage"},{"key":"C","text":"To eliminate grounding"},{"key":"D","text":"To change circuit load"}]'::jsonb,
'["A"]'::jsonb,
'Closing unused openings helps preserve the enclosure''s intended protection.'),

(12,'situational_judgment','application',
'A device is electrically connected correctly but is loose in its mounting. What should happen?',
'[{"key":"A","text":"Correct the mounting before the installation is accepted"},{"key":"B","text":"Accept it because it operates"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Remove the equipment grounding conductor"}]'::jsonb,
'["A"]'::jsonb,
'Functional operation alone does not establish acceptable installation quality.'),

(13,'multiple_choice','application',
'Why should electrical equipment be checked for physical damage before acceptance?',
'[{"key":"A","text":"Damage can compromise safety, reliability, or equipment performance"},{"key":"B","text":"Damage affects only appearance"},{"key":"C","text":"Damage is acceptable if voltage is present"},{"key":"D","text":"Damage increases conductor ampacity"}]'::jsonb,
'["A"]'::jsonb,
'Physical condition is part of confirming that equipment is suitable for service.'),

(14,'situational_judgment','application',
'An installed cable is under visible mechanical strain at its termination. What should be done?',
'[{"key":"A","text":"Correct the routing, support, or termination so the connection is not improperly strained"},{"key":"B","text":"Leave it if continuity is present"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Shorten the grounding conductor"}]'::jsonb,
'["A"]'::jsonb,
'Terminations should not be left under avoidable mechanical stress.'),

(15,'scenario','scenario',
'A newly installed receptacle has correct voltage but is not firmly secured in the box. What is the BEST conclusion?',
'[{"key":"A","text":"The installation is not complete until the mechanical mounting is corrected"},{"key":"B","text":"Correct voltage proves the installation is acceptable"},{"key":"C","text":"The breaker should be increased"},{"key":"D","text":"The box can be removed"}]'::jsonb,
'["A"]'::jsonb,
'Electrical performance and workmanship both matter in installation acceptance.'),

(16,'scenario','scenario',
'A fixture is installed according to the drawing, but field conditions leave it unsupported on one side. What should happen?',
'[{"key":"A","text":"Correct the support condition before acceptance rather than relying only on the drawing"},{"key":"B","text":"Accept it because the drawing was followed"},{"key":"C","text":"Increase lamp wattage"},{"key":"D","text":"Remove identification"}]'::jsonb,
'["A"]'::jsonb,
'Field verification must confirm the actual installation is secure and acceptable.'),

(17,'scenario','scenario',
'A branch circuit functions correctly, but the conductor identification in the panel is inconsistent with the field labeling. What should be done?',
'[{"key":"A","text":"Reconcile and correct the identification before final acceptance"},{"key":"B","text":"Leave it because the circuit works"},{"key":"C","text":"Remove all panel labels"},{"key":"D","text":"Increase protection"}]'::jsonb,
'["A"]'::jsonb,
'Accurate identification is part of a maintainable and verifiable installation.'),

(18,'scenario','scenario',
'During final inspection, you find a damaged equipment cover near energized parts. What should happen?',
'[{"key":"A","text":"Correct the damaged enclosure condition before the equipment is accepted for normal service"},{"key":"B","text":"Accept it if the breaker is on"},{"key":"C","text":"Cover it temporarily with paper"},{"key":"D","text":"Ignore it if no one is touching it"}]'::jsonb,
'["A"]'::jsonb,
'Damaged enclosure protection can expose energized components or compromise equipment safety.'),

(19,'scenario','scenario',
'A circuit passes a simple operational test, but several terminations were not checked after installation. What is the BEST response?',
'[{"key":"A","text":"Complete the required verification rather than treating one functional test as proof of total installation quality"},{"key":"B","text":"Accept it because the load turned on"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Skip documentation"}]'::jsonb,
'["A"]'::jsonb,
'Functional operation alone does not verify every important installation condition.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Electrical Installation Quality & Verification?',
'[{"key":"A","text":"Accepting work if equipment energizes"},{"key":"B","text":"Systematically checking workmanship, support, connections, physical condition, labeling, documentation alignment, and basic functionality before acceptance"},{"key":"C","text":"Ignoring minor enclosure damage"},{"key":"D","text":"Using drawings without checking field conditions"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means competently inspecting common electrical work for both workmanship and functional completion.');

create temporary table _seed_electrical_installation_quality_verification_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_installation_quality_verification_l4_questions (
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
'Why must final electrical verification integrate workmanship, project documents, code requirements, equipment instructions, and functional performance?',
'[{"key":"A","text":"Acceptance depends on the installation satisfying the complete set of applicable requirements, not one isolated check"},{"key":"B","text":"Only functional operation matters"},{"key":"C","text":"Only drawings matter"},{"key":"D","text":"Only appearance matters"}]'::jsonb,
'["A"]'::jsonb,
'Advanced verification requires confirming the installed system against all relevant acceptance criteria.'),

(2,'multiple_choice','foundational',
'Why should inspection findings be documented clearly and specifically?',
'[{"key":"A","text":"Clear findings support correction, accountability, retesting, closeout, and future maintenance"},{"key":"B","text":"Documentation replaces correction"},{"key":"C","text":"Documentation increases circuit capacity"},{"key":"D","text":"Findings should remain verbal"}]'::jsonb,
'["A"]'::jsonb,
'Specific documentation makes deficiencies traceable and supports reliable closeout.'),

(3,'multiple_choice','foundational',
'Why is functional verification different from visual inspection?',
'[{"key":"A","text":"Visual inspection checks observable installation conditions, while functional verification confirms intended operation under test conditions"},{"key":"B","text":"They are identical"},{"key":"C","text":"Functional verification checks only labels"},{"key":"D","text":"Visual inspection replaces testing"}]'::jsonb,
'["A"]'::jsonb,
'Both physical inspection and operational testing contribute different evidence to acceptance.'),

(4,'situational_judgment','application',
'A completed installation matches the drawings, but a manufacturer requirement for the installed equipment was not followed. What should the journeyman do?',
'[{"key":"A","text":"Resolve the equipment-installation deficiency before accepting the work"},{"key":"B","text":"Accept it because the drawing was followed"},{"key":"C","text":"Ignore manufacturer requirements"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Project documents do not eliminate the need to satisfy applicable equipment installation requirements.'),

(5,'multiple_select','application',
'Which THREE items commonly belong in a Level 4 installation-quality review?',
'[{"key":"A","text":"Workmanship and physical installation"},{"key":"B","text":"Documentation, code, equipment, and project requirements"},{"key":"C","text":"Functional testing, deficiencies, corrective action, and closeout evidence"},{"key":"D","text":"Installer preference"},{"key":"E","text":"Decorative finish only"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced installation verification integrates physical quality, compliance, documentation, and functional acceptance.'),

(6,'situational_judgment','application',
'A feeder installation appears correct visually, but measured operating performance does not match expectations. What should happen?',
'[{"key":"A","text":"Investigate the discrepancy before acceptance rather than relying on visual appearance alone"},{"key":"B","text":"Accept it because workmanship looks good"},{"key":"C","text":"Increase protection"},{"key":"D","text":"Ignore the measurement"}]'::jsonb,
'["A"]'::jsonb,
'Verification should reconcile visual condition with actual system performance.'),

(7,'multiple_choice','application',
'Why should deficiencies be categorized and tracked through correction?',
'[{"key":"A","text":"It helps ensure each issue is assigned, corrected, retested, and closed rather than lost during project turnover"},{"key":"B","text":"It changes equipment ratings"},{"key":"C","text":"It eliminates inspection"},{"key":"D","text":"It reduces conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Structured deficiency tracking supports complete and auditable project closeout.'),

(8,'situational_judgment','application',
'A contractor corrects a documented electrical deficiency. What is the BEST next step?',
'[{"key":"A","text":"Verify the correction and update the deficiency record before closing the item"},{"key":"B","text":"Close it immediately based on verbal confirmation"},{"key":"C","text":"Delete the original finding"},{"key":"D","text":"Skip retesting"}]'::jsonb,
'["A"]'::jsonb,
'Corrective action should be verified before a deficiency is considered resolved.'),

(9,'multiple_choice','application',
'Why should final field conditions be compared with as-built documentation?',
'[{"key":"A","text":"The closeout record should accurately represent what was actually installed"},{"key":"B","text":"As-built documents do not matter after energization"},{"key":"C","text":"Drawings should never change"},{"key":"D","text":"Field conditions affect only appearance"}]'::jsonb,
'["A"]'::jsonb,
'Accurate as-built information supports future operation, service, and modifications.'),

(10,'situational_judgment','application',
'An installation passes individual component tests, but the complete system sequence fails. What should the journeyman conclude?',
'[{"key":"A","text":"Component-level success does not prove system-level acceptance; the integrated failure must be resolved"},{"key":"B","text":"The system should be accepted"},{"key":"C","text":"Increase all circuit ratings"},{"key":"D","text":"Ignore the sequence"}]'::jsonb,
'["A"]'::jsonb,
'Final verification must confirm that components work together as the intended system.'),

(11,'scenario','scenario',
'A new electrical room installation is functional, but required working clearances are obstructed by permanent equipment added late in the project. What should happen?',
'[{"key":"A","text":"Resolve the clearance conflict before final acceptance"},{"key":"B","text":"Accept it because equipment operates"},{"key":"C","text":"Remove labels"},{"key":"D","text":"Increase panel capacity"}]'::jsonb,
'["A"]'::jsonb,
'Functional operation does not override required safe access and working conditions.'),

(12,'scenario','scenario',
'Several punch-list deficiencies are marked complete, but there is no evidence they were retested. What is the BEST response?',
'[{"key":"A","text":"Require verification evidence before closing the deficiencies"},{"key":"B","text":"Accept the completion marks without review"},{"key":"C","text":"Delete the punch list"},{"key":"D","text":"Treat verbal confirmation as final testing"}]'::jsonb,
'["A"]'::jsonb,
'Closeout should be supported by evidence that corrective work was actually verified.'),

(13,'scenario','scenario',
'A field-installed equipment substitution has the same nominal ratings as the specified equipment but different installation requirements. What should the journeyman do?',
'[{"key":"A","text":"Evaluate the substituted equipment against project, installation, compatibility, and acceptance requirements before approval"},{"key":"B","text":"Accept it based only on nominal rating"},{"key":"C","text":"Ignore manufacturer requirements"},{"key":"D","text":"Increase conductor size"}]'::jsonb,
'["A"]'::jsonb,
'Equivalent nominal ratings do not automatically establish equivalent installation suitability.'),

(14,'scenario','scenario',
'An installation repeatedly fails insulation or continuity verification after visible defects are corrected. What is the BEST approach?',
'[{"key":"A","text":"Continue systematic investigation until the underlying electrical defect is located and corrected, then retest"},{"key":"B","text":"Accept it because visible defects were fixed"},{"key":"C","text":"Increase breaker ratings"},{"key":"D","text":"Stop testing"}]'::jsonb,
'["A"]'::jsonb,
'Failed verification indicates unresolved conditions regardless of visible appearance.'),

(15,'scenario','scenario',
'A completed installation differs from the approved drawing because of a field change that was never documented. What should the journeyman do?',
'[{"key":"A","text":"Verify the field change is acceptable and ensure the project documentation is updated before closeout"},{"key":"B","text":"Ignore the difference"},{"key":"C","text":"Restore the drawing instead of the installation record"},{"key":"D","text":"Remove equipment labels"}]'::jsonb,
'["A"]'::jsonb,
'Final acceptance requires both an acceptable installation and accurate documentation of what was built.'),

(16,'scenario','scenario',
'An electrical system performs correctly under light load but shows overheating during normal operating load. What should the journeyman do?',
'[{"key":"A","text":"Treat the installation as not fully verified and investigate loading, connections, equipment, conductors, and operating conditions"},{"key":"B","text":"Accept it because the light-load test passed"},{"key":"C","text":"Increase protective-device size"},{"key":"D","text":"Ignore temperature"}]'::jsonb,
'["A"]'::jsonb,
'Verification should reflect realistic operating conditions, not only low-load testing.'),

(17,'scenario','scenario',
'A contractor disputes an inspection deficiency because the installation has worked for several weeks. What is the BEST response?',
'[{"key":"A","text":"Evaluate the installation against the applicable acceptance requirements rather than using continued operation as proof of compliance"},{"key":"B","text":"Withdraw the deficiency automatically"},{"key":"C","text":"Accept any installation that remains energized"},{"key":"D","text":"Remove the inspection record"}]'::jsonb,
'["A"]'::jsonb,
'Operational history does not replace compliance and installation-quality requirements.'),

(18,'scenario','scenario',
'The final test record shows one required function was never tested because the related equipment was unavailable. What should happen?',
'[{"key":"A","text":"Keep the item open until the missing verification can be completed or formally resolved through an approved process"},{"key":"B","text":"Mark the system fully verified"},{"key":"C","text":"Delete the missing test"},{"key":"D","text":"Assume the function works"}]'::jsonb,
'["A"]'::jsonb,
'Unperformed required testing should not be treated as completed verification.'),

(19,'scenario','scenario',
'Multiple installation deficiencies appear in different areas but share the same repeated workmanship issue. What should the journeyman do?',
'[{"key":"A","text":"Address the individual deficiencies and also evaluate whether a broader installation or quality-control problem exists"},{"key":"B","text":"Treat every item as unrelated"},{"key":"C","text":"Close the oldest deficiencies first without investigation"},{"key":"D","text":"Ignore the pattern"}]'::jsonb,
'["A"]'::jsonb,
'Repeated patterns can indicate a systemic workmanship or quality-control issue beyond isolated defects.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 4 proficiency in Electrical Installation Quality & Verification?',
'[{"key":"A","text":"Accepting work when it energizes successfully"},{"key":"B","text":"Leading systematic inspection, documentation review, compliance verification, functional testing, deficiency resolution, retesting, field reconciliation, and final acceptance across complex electrical installations"},{"key":"C","text":"Closing deficiencies without evidence"},{"key":"D","text":"Treating drawings as more important than actual field conditions"}]'::jsonb,
'["B"]'::jsonb,
'Level 4 performance means leading comprehensive installation-quality verification and project acceptance using objective evidence.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '8d1b46a4-609a-4413-959d-eff14d67b341';
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
      and c.name = 'Electrical Installation Quality & Verification'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Installation Quality & Verification Master Competency not found';
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
  v_assessment_name := 'Electrical Installation Quality & Verification — Level 2 Competency Assessment';

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
    select * from _seed_electrical_installation_quality_verification_l2_questions
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
        'Electrical Installation Quality & Verification',
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
      'IntegrateU Electrical Installation Quality & Verification L2 production assessment v1.0.',
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
        'Electrical Installation Quality & Verification',
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
        'IntegrateU Electrical Installation Quality & Verification L2 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Installation Quality & Verification — Level 4 Competency Assessment';

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
    select * from _seed_electrical_installation_quality_verification_l4_questions
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
        'Electrical Installation Quality & Verification',
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
      'IntegrateU Electrical Installation Quality & Verification L4 production assessment v1.0.',
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
        'Electrical Installation Quality & Verification',
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
        'IntegrateU Electrical Installation Quality & Verification L4 production assessment v1.0.',
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
   '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid
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
      '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid
    and a.target_level in (2,4)
    and aq.master_competency_template_id =
      '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid
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
  '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid;

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
    '8d1b46a4-609a-4413-959d-eff14d67b341'::uuid
  and a.target_level in (2,4)
group by a.target_level
having count(*) > 1;
