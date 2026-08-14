-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0094_electrical_drawings_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Drawings & Construction Documents
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

create temporary table _seed_electrical_drawings_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_drawings_l2_questions (
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
'What is the primary purpose of a legend or symbol list on an electrical drawing set?',
'[{"key":"A","text":"To define symbols and abbreviations used on the drawings"},{"key":"B","text":"To replace all written specifications"},{"key":"C","text":"To show employee assignments"},{"key":"D","text":"To identify material prices"}]'::jsonb,
'["A"]'::jsonb,
'A legend or symbol list explains the graphical symbols and abbreviations used throughout the drawing set.'),

(2,'multiple_choice','foundational',
'What does a drawing scale communicate?',
'[{"key":"A","text":"The relationship between dimensions shown on the drawing and actual physical dimensions"},{"key":"B","text":"The electrical voltage of the building"},{"key":"C","text":"The sequence of construction inspections"},{"key":"D","text":"The number of workers required"}]'::jsonb,
'["A"]'::jsonb,
'Drawing scale establishes how a represented distance relates to the actual built dimension.'),

(3,'multiple_choice','foundational',
'What is a panel schedule primarily used to show?',
'[{"key":"A","text":"Circuit assignments and related panel information"},{"key":"B","text":"Only architectural room finishes"},{"key":"C","text":"Payroll information"},{"key":"D","text":"Equipment warranty dates"}]'::jsonb,
'["A"]'::jsonb,
'Panel schedules organize circuit, load, breaker, and related panel information used during installation and verification.'),

(4,'multiple_choice','foundational',
'What is the main purpose of a one-line diagram?',
'[{"key":"A","text":"To show major electrical distribution relationships in simplified form"},{"key":"B","text":"To show exact conduit routing for every branch circuit"},{"key":"C","text":"To show only architectural dimensions"},{"key":"D","text":"To replace equipment installation instructions"}]'::jsonb,
'["A"]'::jsonb,
'A one-line diagram simplifies electrical distribution so major sources, equipment, feeders, and relationships can be understood quickly.'),

(5,'multiple_choice','foundational',
'When a drawing references a detail number and sheet number, what should the installer do?',
'[{"key":"A","text":"Go to the referenced detail and sheet for additional information"},{"key":"B","text":"Ignore the reference unless an inspector asks about it"},{"key":"C","text":"Assume the detail is optional"},{"key":"D","text":"Use the closest architectural detail instead"}]'::jsonb,
'["A"]'::jsonb,
'Detail references direct the reader to additional construction information needed to understand the intended installation.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'An electrical plan shows a device symbol you do not recognize. What is the BEST first action?',
'[{"key":"A","text":"Check the drawing legend, notes, and applicable schedules"},{"key":"B","text":"Install the device that looks most similar"},{"key":"C","text":"Omit the device"},{"key":"D","text":"Assume it is an architectural symbol"}]'::jsonb,
'["A"]'::jsonb,
'The drawing legend, notes, and schedules should be checked before making assumptions about an unfamiliar symbol.'),

(7,'multiple_choice','application',
'A branch circuit homerun is shown from a group of devices to a panel. What information should you verify before installation?',
'[{"key":"A","text":"The panel designation and circuit assignment"},{"key":"B","text":"Only the room paint color"},{"key":"C","text":"Only the ceiling height"},{"key":"D","text":"Only the device manufacturer"}]'::jsonb,
'["A"]'::jsonb,
'Homerun information should be coordinated with the correct panel and circuit assignment.'),

(8,'situational_judgment','application',
'The electrical plan and panel schedule appear to assign different circuit numbers to the same load. What should you do?',
'[{"key":"A","text":"Stop and resolve the document conflict through the approved clarification process"},{"key":"B","text":"Choose whichever circuit number is easier"},{"key":"C","text":"Install both circuits"},{"key":"D","text":"Ignore the panel schedule"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting construction documents should be clarified before installation rather than resolved by assumption.'),

(9,'multiple_select','application',
'Which THREE document sources commonly help define an electrical installation?',
'[{"key":"A","text":"Plans"},{"key":"B","text":"Specifications"},{"key":"C","text":"Schedules and details"},{"key":"D","text":"Personal preference"},{"key":"E","text":"Unverified field rumor"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Plans, specifications, schedules, notes, and details work together to define construction requirements.'),

(10,'multiple_choice','application',
'A reflected ceiling plan shows lighting fixture locations. Why might an electrician still need to review architectural information?',
'[{"key":"A","text":"To coordinate fixture placement with ceiling layout and other building features"},{"key":"B","text":"Because electrical plans never show lighting"},{"key":"C","text":"To determine payroll rates"},{"key":"D","text":"Because architectural drawings replace electrical drawings"}]'::jsonb,
'["A"]'::jsonb,
'Electrical installation often requires coordination with architectural layouts and building features.'),

(11,'situational_judgment','application',
'A drawing note says “typical” beside one device installation. What is the BEST interpretation?',
'[{"key":"A","text":"The shown condition may apply to similar locations unless another detail or note indicates otherwise"},{"key":"B","text":"The note applies only to the single device shown"},{"key":"C","text":"The note can always be ignored"},{"key":"D","text":"The note overrides every specification"}]'::jsonb,
'["A"]'::jsonb,
'A typical detail generally communicates a repeated condition, but it still must be coordinated with other project requirements.'),

(12,'multiple_choice','application',
'Why should revision clouds and revision identifiers be reviewed before using a drawing set?',
'[{"key":"A","text":"They help identify changed information that may affect the installation"},{"key":"B","text":"They show weather conditions"},{"key":"C","text":"They indicate employee attendance"},{"key":"D","text":"They determine conductor insulation color"}]'::jsonb,
'["A"]'::jsonb,
'Revisions can alter installation requirements, so changed areas and revision status should be reviewed before construction.'),

(13,'situational_judgment','application',
'You are laying out electrical equipment and the drawing gives a dimension from a wall that has not yet been built. What should you do?',
'[{"key":"A","text":"Coordinate layout using the controlling construction dimensions and approved field references"},{"key":"B","text":"Guess the wall location"},{"key":"C","text":"Measure from the nearest temporary object"},{"key":"D","text":"Ignore the dimension"}]'::jsonb,
'["A"]'::jsonb,
'Layout should rely on approved controlling dimensions and coordinated field references, not temporary or guessed conditions.'),

(14,'multiple_choice','application',
'What is the benefit of cross-checking a device location against both the electrical plan and a referenced detail?',
'[{"key":"A","text":"It helps verify both general location and installation-specific requirements"},{"key":"B","text":"It eliminates the need for specifications"},{"key":"C","text":"It guarantees no field coordination is needed"},{"key":"D","text":"It changes the drawing scale"}]'::jsonb,
'["A"]'::jsonb,
'Plans and details often provide complementary information, and both should be reviewed when referenced.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'A drawing set shows a disconnect on the plan, but the equipment schedule lists a different equipment designation. What is the BEST action?',
'[{"key":"A","text":"Resolve the discrepancy before installation using the approved project clarification process"},{"key":"B","text":"Install both designations"},{"key":"C","text":"Choose the less expensive option"},{"key":"D","text":"Ignore the schedule"}]'::jsonb,
'["A"]'::jsonb,
'Document discrepancies should be resolved before installation so the field work reflects the approved design intent.'),

(16,'scenario','scenario',
'You discover that the latest drawing revision moved several receptacles after rough-in layout has started. What should you do?',
'[{"key":"A","text":"Confirm the current revision and adjust the work according to approved project direction"},{"key":"B","text":"Continue using the older drawing because layout already started"},{"key":"C","text":"Install devices in both locations"},{"key":"D","text":"Ignore the revision cloud"}]'::jsonb,
'["A"]'::jsonb,
'The current approved drawing revision governs the work, and field changes should follow project procedures.'),

(17,'scenario','scenario',
'A detail shows equipment mounted at a specific elevation, but the plan view does not show the mounting height. Which document should control that installation detail?',
'[{"key":"A","text":"The referenced detail, coordinated with the rest of the contract documents"},{"key":"B","text":"A guessed height"},{"key":"C","text":"The nearest unrelated detail"},{"key":"D","text":"Personal preference"}]'::jsonb,
'["A"]'::jsonb,
'When a referenced detail provides installation-specific information, it should be coordinated with the full drawing set and specifications.'),

(18,'situational_judgment','scenario',
'The electrical plan appears to route conduit through an area occupied by major mechanical equipment shown on another discipline drawing. What is the BEST response?',
'[{"key":"A","text":"Coordinate the conflict before installation rather than following one drawing in isolation"},{"key":"B","text":"Ignore the mechanical drawing"},{"key":"C","text":"Install through the equipment space"},{"key":"D","text":"Delete the electrical route"}]'::jsonb,
'["A"]'::jsonb,
'Construction documents must be coordinated across disciplines when field conditions or layouts conflict.'),

(19,'scenario','scenario',
'A circuit on the plan is labeled with a panel designation that does not exist anywhere in the panel schedules. What should the installer conclude?',
'[{"key":"A","text":"The documents require clarification before the circuit is installed"},{"key":"B","text":"The panel designation should be invented in the field"},{"key":"C","text":"The nearest panel should automatically be used"},{"key":"D","text":"The circuit can be omitted"}]'::jsonb,
'["A"]'::jsonb,
'A missing or inconsistent panel designation is a document coordination issue that should be resolved before installation.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Electrical Drawings & Construction Documents?',
'[{"key":"A","text":"Reading only the plan view and ignoring notes"},{"key":"B","text":"Using legends, plans, schedules, notes, and details together to perform routine layout and identify document conflicts"},{"key":"C","text":"Making field changes without documentation"},{"key":"D","text":"Ignoring revisions after work starts"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means using routine construction documents together and recognizing when information is incomplete or conflicting.');

create temporary table _seed_electrical_drawings_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_drawings_l3_questions (
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
'What is the purpose of comparing plan views, riser diagrams, and one-line diagrams during electrical coordination?',
'[{"key":"A","text":"To understand the same system from different levels of detail and identify inconsistencies"},{"key":"B","text":"To determine employee classifications"},{"key":"C","text":"To replace project specifications"},{"key":"D","text":"To avoid reviewing schedules"}]'::jsonb,
'["A"]'::jsonb,
'Different drawing types communicate different aspects of the system and should agree with one another.'),

(2,'multiple_choice','foundational',
'Why is drawing revision control important during construction?',
'[{"key":"A","text":"Because superseded information can cause incorrect installation or rework"},{"key":"B","text":"Because revisions automatically change contract price"},{"key":"C","text":"Because only revised sheets are valid"},{"key":"D","text":"Because revisions eliminate the need for coordination"}]'::jsonb,
'["A"]'::jsonb,
'Using current approved documents helps prevent work from being performed from superseded design information.'),

(3,'multiple_choice','foundational',
'What is the primary purpose of a specification section related to electrical work?',
'[{"key":"A","text":"To define material, execution, quality, and other written project requirements that drawings may not fully describe"},{"key":"B","text":"To show exact geometric location of every device"},{"key":"C","text":"To replace all drawing details"},{"key":"D","text":"To define employee work schedules"}]'::jsonb,
'["A"]'::jsonb,
'Specifications supplement drawings with written requirements for materials, methods, quality, testing, and execution.'),

(4,'multiple_choice','foundational',
'What is the value of an RFI or similar formal clarification process?',
'[{"key":"A","text":"It creates a documented path for resolving unclear or conflicting project information"},{"key":"B","text":"It lets installers change the design without approval"},{"key":"C","text":"It replaces field coordination"},{"key":"D","text":"It automatically approves substitutions"}]'::jsonb,
'["A"]'::jsonb,
'A formal clarification process documents questions and approved responses so construction can proceed from resolved information.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A feeder size on a one-line diagram differs from the feeder information shown in a schedule. What should a journeyman do?',
'[{"key":"A","text":"Identify the conflict, review all related documents, and obtain approved clarification before installation"},{"key":"B","text":"Choose the larger feeder automatically"},{"key":"C","text":"Choose whichever information appears first"},{"key":"D","text":"Ignore the one-line diagram"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting design information should be reconciled through the approved project process rather than interpreted by guesswork.'),

(6,'multiple_select','application',
'Which THREE actions support effective electrical document coordination?',
'[{"key":"A","text":"Verify current drawing revisions"},{"key":"B","text":"Cross-reference schedules, notes, details, and specifications"},{"key":"C","text":"Document unresolved conflicts for clarification"},{"key":"D","text":"Rely on memory instead of the current set"},{"key":"E","text":"Ignore other disciplines"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Revision control, cross-referencing, and documented clarification are core document-coordination practices.'),

(7,'situational_judgment','application',
'A layout dimension on the electrical drawing conflicts with a controlling architectural dimension. What is the BEST next step?',
'[{"key":"A","text":"Coordinate the discrepancy and obtain approved direction before fixing the installation location"},{"key":"B","text":"Average the two dimensions"},{"key":"C","text":"Use whichever dimension is easier"},{"key":"D","text":"Install both locations"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting dimensions should be resolved through coordination rather than field interpretation.'),

(8,'multiple_choice','application',
'Why should equipment submittals sometimes be compared with the construction drawings before installation?',
'[{"key":"A","text":"To verify that actual equipment characteristics and connection requirements coordinate with the design"},{"key":"B","text":"To replace the approved drawings"},{"key":"C","text":"To determine employee hours"},{"key":"D","text":"To change the project scope without approval"}]'::jsonb,
'["A"]'::jsonb,
'Approved equipment information may contain dimensions, connection points, and requirements that affect installation coordination.'),

(9,'situational_judgment','application',
'A drawing note refers to “existing conditions to remain,” but field observation shows the existing equipment has already been removed. What should you do?',
'[{"key":"A","text":"Document the changed field condition and seek project direction before proceeding"},{"key":"B","text":"Reinstall the removed equipment without approval"},{"key":"C","text":"Ignore the note"},{"key":"D","text":"Assume the note was never applicable"}]'::jsonb,
'["A"]'::jsonb,
'When field conditions differ from the documents, the discrepancy should be documented and resolved through the project process.'),

(10,'multiple_choice','application',
'What is the BEST reason to trace a circuit from a floor plan through a panel schedule and one-line diagram?',
'[{"key":"A","text":"To verify that the branch circuit, panel assignment, and upstream distribution relationship are consistent"},{"key":"B","text":"To determine room finish colors"},{"key":"C","text":"To avoid reviewing specifications"},{"key":"D","text":"To identify employee assignments"}]'::jsonb,
'["A"]'::jsonb,
'Cross-document tracing verifies that different representations of the electrical system agree.'),

(11,'situational_judgment','application',
'An approved change bulletin modifies equipment location and feeder routing. What should happen before field work continues in that area?',
'[{"key":"A","text":"The affected team should work from the current approved change information and coordinate its impact on existing work"},{"key":"B","text":"The original drawings should continue to govern"},{"key":"C","text":"The change should be ignored until project closeout"},{"key":"D","text":"Only the equipment location should be changed"}]'::jsonb,
'["A"]'::jsonb,
'Approved changes should be incorporated into the active construction information and coordinated with work already performed.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A journeyman finds that the electrical room plan, one-line diagram, and equipment submittal each show slightly different transformer locations and clearances. What is the BEST response?',
'[{"key":"A","text":"Coordinate the documents and field constraints, identify the conflict, and obtain approved direction before installation"},{"key":"B","text":"Use the first document issued"},{"key":"C","text":"Choose the location with the shortest conduit"},{"key":"D","text":"Install the transformer temporarily"}]'::jsonb,
'["A"]'::jsonb,
'Multi-document conflicts affecting equipment layout should be resolved before installation.'),

(13,'scenario','scenario',
'A revised lighting plan changes fixture types, but the fixture schedule was not revised and still lists the previous types. What should the journeyman do?',
'[{"key":"A","text":"Treat the mismatch as an unresolved document conflict and seek clarification"},{"key":"B","text":"Install whichever fixture is in stock"},{"key":"C","text":"Use the old schedule automatically"},{"key":"D","text":"Ignore the revised plan"}]'::jsonb,
'["A"]'::jsonb,
'Revision inconsistencies between plans and schedules require clarification before material or installation decisions are made.'),

(14,'scenario','scenario',
'A feeder route shown schematically would interfere with a structural element that is not obvious on the electrical drawing. What is the BEST approach?',
'[{"key":"A","text":"Coordinate with structural and other relevant documents before finalizing the route"},{"key":"B","text":"Alter the structural element"},{"key":"C","text":"Ignore the electrical route"},{"key":"D","text":"Assume schematic routing is exact"}]'::jsonb,
'["A"]'::jsonb,
'Schematic routing still requires field and multidisciplinary coordination before installation.'),

(15,'scenario','scenario',
'The panel schedule lists a three-pole load, while the plan identifies the equipment as single-phase. What should happen?',
'[{"key":"A","text":"The electrical characteristics should be reconciled through document review and approved clarification"},{"key":"B","text":"Install a three-pole circuit automatically"},{"key":"C","text":"Install a single-pole circuit automatically"},{"key":"D","text":"Delete the load"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting equipment and circuit information must be resolved before the circuit is installed.'),

(16,'situational_judgment','scenario',
'During coordination, a journeyman notices that an electrical detail calls for an installation method different from the written specification. What is the BEST response?',
'[{"key":"A","text":"Identify the conflict and obtain approved clarification instead of deciding which requirement to ignore"},{"key":"B","text":"Always follow the drawing"},{"key":"C","text":"Always follow the specification"},{"key":"D","text":"Use personal preference"}]'::jsonb,
'["A"]'::jsonb,
'Potential conflicts among contract documents should be formally resolved rather than handled by assumption.'),

(17,'scenario','scenario',
'A new revision changes the electrical equipment layout after underground raceways have already been installed. What should the journeyman do first?',
'[{"key":"A","text":"Evaluate the impact against current approved documents and escalate required rework or conflict resolution through the project process"},{"key":"B","text":"Ignore the revision because work is complete"},{"key":"C","text":"Move equipment without documentation"},{"key":"D","text":"Abandon the underground raceways immediately"}]'::jsonb,
'["A"]'::jsonb,
'Late design changes require coordinated evaluation of existing work, impacts, and approved corrective direction.'),

(18,'scenario','scenario',
'Two similar rooms appear identical on the plan, but one has a keyed note referencing a special detail. How should the journeyman treat the rooms?',
'[{"key":"A","text":"Apply the special detail only where the keyed note indicates, while confirming all related document requirements"},{"key":"B","text":"Assume both rooms are identical"},{"key":"C","text":"Ignore the keyed note"},{"key":"D","text":"Apply the special detail to the entire project"}]'::jsonb,
'["A"]'::jsonb,
'Keyed notes can create location-specific requirements that distinguish otherwise similar plan conditions.'),

(19,'scenario','scenario',
'A crew is about to install work using a printed drawing set, but the project document system shows a newer revision. What should the journeyman do?',
'[{"key":"A","text":"Stop use of the superseded set and confirm the current approved documents before proceeding"},{"key":"B","text":"Continue because the printed set is easier to read"},{"key":"C","text":"Use both revisions simultaneously"},{"key":"D","text":"Ignore revisions until inspection"}]'::jsonb,
'["A"]'::jsonb,
'Current approved documents should govern field work; superseded sets create substantial rework and coordination risk.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Electrical Drawings & Construction Documents?',
'[{"key":"A","text":"Reading only individual electrical sheets"},{"key":"B","text":"Independently coordinating plans, schedules, diagrams, specifications, revisions, and field conditions; identifying conflicts; and obtaining documented clarification when needed"},{"key":"C","text":"Making undocumented field interpretations whenever documents disagree"},{"key":"D","text":"Delegating all document review to others"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently integrating multiple construction-document sources, recognizing conflicts, and driving appropriate clarification and coordination.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b34ed3b8-2314-44a0-949d-656e1add9a3b';
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
      and c.name = 'Electrical Drawings & Construction Documents'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Drawings & Construction Documents Master Competency not found';
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
  v_assessment_name := 'Electrical Drawings & Construction Documents — Level 2 Competency Assessment';

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
    select * from _seed_electrical_drawings_l2_questions
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
        'Electrical Drawings & Construction Documents',
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
      'IntegrateU Electrical Drawings & Construction Documents L2 production assessment v1.0.',
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
        'Electrical Drawings & Construction Documents',
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
        'IntegrateU Electrical Drawings & Construction Documents L2 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Drawings & Construction Documents — Level 3 Competency Assessment';

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
    select * from _seed_electrical_drawings_l3_questions
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
        'Electrical Drawings & Construction Documents',
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
      'IntegrateU Electrical Drawings & Construction Documents L3 production assessment v1.0.',
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
        'Electrical Drawings & Construction Documents',
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
        'IntegrateU Electrical Drawings & Construction Documents L3 production assessment v1.0.',
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
   'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid
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
      'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid
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
  'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid;

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
    'b34ed3b8-2314-44a0-949d-656e1add9a3b'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
