-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0095_electrical_code_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Code Application
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

create temporary table _seed_electrical_code_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_code_l2_questions (
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
'What is the BEST reason to identify the code edition and local adoption requirements before applying an electrical code rule?',
'[{"key":"A","text":"Because the governing edition and local amendments determine which requirements apply"},{"key":"B","text":"Because every project automatically uses the newest edition"},{"key":"C","text":"Because code requirements never change between editions"},{"key":"D","text":"Because local requirements only affect inspections"}]'::jsonb,
'["A"]'::jsonb,
'Code application begins with identifying the governing edition and any applicable local amendments or project requirements.'),

(2,'multiple_choice','foundational',
'What is the primary purpose of using the NEC index or table of contents during code research?',
'[{"key":"A","text":"To locate likely articles, sections, and subjects efficiently"},{"key":"B","text":"To replace reading the actual code text"},{"key":"C","text":"To determine project labor rates"},{"key":"D","text":"To identify approved manufacturers"}]'::jsonb,
'["A"]'::jsonb,
'Indexes and contents help locate relevant subjects, but the actual requirement must still be read in context.'),

(3,'multiple_choice','foundational',
'Why should definitions be reviewed when a code term has a specific technical meaning?',
'[{"key":"A","text":"Because defined terms can control how a requirement is interpreted"},{"key":"B","text":"Because definitions replace all installation rules"},{"key":"C","text":"Because definitions apply only to inspectors"},{"key":"D","text":"Because definitions determine drawing scale"}]'::jsonb,
'["A"]'::jsonb,
'Code-defined terminology can materially affect how a requirement applies to an installation.'),

(4,'multiple_choice','foundational',
'What is the BEST approach when a code section references another section?',
'[{"key":"A","text":"Read the referenced section and apply both provisions in context"},{"key":"B","text":"Ignore the reference if the first section seems clear"},{"key":"C","text":"Use only the referenced section"},{"key":"D","text":"Assume the reference is optional"}]'::jsonb,
'["A"]'::jsonb,
'Cross-references often contain conditions, exceptions, or additional requirements needed for correct application.'),

(5,'multiple_choice','foundational',
'What should an apprentice do when a code requirement is unclear or appears to conflict with project documents?',
'[{"key":"A","text":"Escalate the question through the appropriate supervision or project clarification process"},{"key":"B","text":"Choose the interpretation that is easiest to install"},{"key":"C","text":"Ignore the code requirement"},{"key":"D","text":"Make an undocumented field change"}]'::jsonb,
'["A"]'::jsonb,
'Unclear or conflicting requirements should be resolved through the proper technical and project channels rather than by assumption.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'You need to determine whether a particular wiring method is permitted in a specific location. What is the BEST first research approach?',
'[{"key":"A","text":"Locate the article for the wiring method, review uses permitted and uses not permitted, and check related location requirements"},{"key":"B","text":"Ask whether another project used it"},{"key":"C","text":"Use the method if it is available in stock"},{"key":"D","text":"Rely only on a product catalog"}]'::jsonb,
'["A"]'::jsonb,
'Code research should begin with the directly applicable article and then consider cross-referenced location and installation requirements.'),

(7,'multiple_choice','application',
'Why is it important to read exceptions immediately following a general code rule?',
'[{"key":"A","text":"They may modify when or how the general requirement applies"},{"key":"B","text":"Exceptions are always optional"},{"key":"C","text":"Exceptions apply only after inspection"},{"key":"D","text":"Exceptions replace the entire article"}]'::jsonb,
'["A"]'::jsonb,
'Exceptions can materially change the scope or application of a general requirement.'),

(8,'situational_judgment','application',
'A plan specifies an installation method, but your code research suggests the method may not be permitted in that location. What should you do?',
'[{"key":"A","text":"Document the concern and obtain clarification before installation"},{"key":"B","text":"Follow the drawing regardless of code"},{"key":"C","text":"Ignore the drawing and redesign the system yourself"},{"key":"D","text":"Install it and wait for inspection"}]'::jsonb,
'["A"]'::jsonb,
'Potential conflicts between design documents and code requirements should be resolved before installation.'),

(9,'multiple_select','application',
'Which THREE sources may need to be considered when determining an installation requirement?',
'[{"key":"A","text":"The adopted electrical code"},{"key":"B","text":"Applicable local amendments or authority requirements"},{"key":"C","text":"Project plans and specifications"},{"key":"D","text":"Personal preference"},{"key":"E","text":"Unverified memory from a previous project"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Code, local requirements, and project documents often work together to define the applicable installation requirement.'),

(10,'multiple_choice','application',
'What is the BEST reason to verify that a table note or footnote applies before using a value from a code table?',
'[{"key":"A","text":"Notes can limit or modify how the table value is used"},{"key":"B","text":"Notes are never enforceable"},{"key":"C","text":"Notes only apply to designers"},{"key":"D","text":"Notes determine equipment color"}]'::jsonb,
'["A"]'::jsonb,
'Table notes can contain essential conditions, limitations, or adjustments that affect the correct value.'),

(11,'situational_judgment','application',
'You locate a code section that appears relevant, but the section is under an article scope that does not cover your installation. What should you do?',
'[{"key":"A","text":"Continue researching within the article or section that actually governs the installation"},{"key":"B","text":"Use the section anyway because the wording seems useful"},{"key":"C","text":"Apply the requirement only if it is stricter"},{"key":"D","text":"Ignore article scopes"}]'::jsonb,
'["A"]'::jsonb,
'Applicability depends on article and section scope, not just finding similar wording.'),

(12,'multiple_choice','application',
'Why should code research be documented when it affects a field decision?',
'[{"key":"A","text":"So the basis for the decision can be reviewed, communicated, and verified"},{"key":"B","text":"So no one else needs to read the code"},{"key":"C","text":"So project drawings can be discarded"},{"key":"D","text":"So inspections can be skipped"}]'::jsonb,
'["A"]'::jsonb,
'Documenting the source and reasoning behind a code decision improves consistency and reviewability.'),

(13,'situational_judgment','application',
'A manufacturer instruction imposes a more restrictive installation limitation than your general code reading. What should you do?',
'[{"key":"A","text":"Treat the listed or labeled equipment instructions as part of the installation requirements and escalate any conflict"},{"key":"B","text":"Ignore the manufacturer instruction"},{"key":"C","text":"Use whichever requirement is easier"},{"key":"D","text":"Modify the equipment to fit the original plan"}]'::jsonb,
'["A"]'::jsonb,
'Listed and labeled equipment must be installed in accordance with applicable instructions, and conflicts should be resolved appropriately.'),

(14,'multiple_choice','application',
'What is the BEST way to use a code handbook, commentary, or training aid?',
'[{"key":"A","text":"As explanatory support while verifying the governing requirement in the adopted code and applicable rules"},{"key":"B","text":"As a replacement for the adopted code"},{"key":"C","text":"As the final authority on every project"},{"key":"D","text":"Only after inspection"}]'::jsonb,
'["A"]'::jsonb,
'Secondary resources can help explain requirements, but the governing code and authority requirements remain controlling.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'An apprentice finds two code sections that appear to address the same installation differently. What is the BEST next step?',
'[{"key":"A","text":"Review scope, definitions, exceptions, cross-references, and any special provisions before escalating unresolved conflicts"},{"key":"B","text":"Choose the shorter section"},{"key":"C","text":"Apply both requirements without considering context"},{"key":"D","text":"Ignore the newer-looking section"}]'::jsonb,
'["A"]'::jsonb,
'Apparent conflicts often resolve when scope, definitions, exceptions, and special provisions are read together.'),

(16,'scenario','scenario',
'A project drawing calls for equipment in a location that appears to have special electrical requirements. What should the apprentice do?',
'[{"key":"A","text":"Identify the applicable location requirements, compare them with the documents, and raise any discrepancy before installation"},{"key":"B","text":"Install exactly as drawn without research"},{"key":"C","text":"Move the equipment without approval"},{"key":"D","text":"Wait until inspection to mention it"}]'::jsonb,
'["A"]'::jsonb,
'Special locations often have additional requirements that must be coordinated with the project design.'),

(17,'situational_judgment','scenario',
'You cannot determine whether an exception applies because one required condition is not documented. What is the BEST response?',
'[{"key":"A","text":"Do not assume the exception applies; obtain the missing information or clarification"},{"key":"B","text":"Use the exception automatically"},{"key":"C","text":"Ignore the condition"},{"key":"D","text":"Select the least expensive interpretation"}]'::jsonb,
'["A"]'::jsonb,
'An exception should not be applied unless its stated conditions are actually satisfied.'),

(18,'scenario','scenario',
'A code table provides a value, but a note references another section requiring an adjustment. What should you do?',
'[{"key":"A","text":"Apply the table together with the referenced adjustment requirements"},{"key":"B","text":"Use the table value alone"},{"key":"C","text":"Ignore the note because it is below the table"},{"key":"D","text":"Use the highest possible value"}]'::jsonb,
'["A"]'::jsonb,
'Code tables and their notes must be read together with referenced adjustment or condition requirements.'),

(19,'scenario','scenario',
'An installer says, “We have always done it this way,” but the current code research indicates a different requirement. What is the BEST response?',
'[{"key":"A","text":"Use the governing current requirement and escalate the discrepancy through the proper process"},{"key":"B","text":"Follow past practice automatically"},{"key":"C","text":"Ignore the current requirement"},{"key":"D","text":"Choose based on schedule pressure"}]'::jsonb,
'["A"]'::jsonb,
'Past practice does not override the governing adopted requirements for the current project.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Electrical Code Application?',
'[{"key":"A","text":"Memorizing isolated section numbers without checking applicability"},{"key":"B","text":"Locating relevant requirements, checking scope and references, applying routine provisions, and escalating unclear conditions"},{"key":"C","text":"Making independent design interpretations beyond assigned responsibility"},{"key":"D","text":"Ignoring local amendments"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably locating and applying routine requirements while recognizing when clarification is needed.');

create temporary table _seed_electrical_code_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_code_l4_questions (
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
'What is the MOST important principle when interpreting a code requirement that appears broad or ambiguous?',
'[{"key":"A","text":"Read the requirement in context with scope, definitions, exceptions, referenced sections, and applicable special provisions"},{"key":"B","text":"Choose the strictest imaginable interpretation"},{"key":"C","text":"Rely on memory of a previous edition"},{"key":"D","text":"Use only the section heading"}]'::jsonb,
'["A"]'::jsonb,
'Advanced code application depends on interpreting requirements in their full structural and technical context.'),

(2,'multiple_choice','foundational',
'Why must a journeyman distinguish between a general requirement and a special or supplementary requirement?',
'[{"key":"A","text":"Because special provisions may modify or add to the general rule for a particular installation"},{"key":"B","text":"Because general rules are never enforceable"},{"key":"C","text":"Because special rules apply only to inspections"},{"key":"D","text":"Because supplementary rules replace all project documents"}]'::jsonb,
'["A"]'::jsonb,
'Correct application requires understanding when special provisions modify, supplement, or supersede general requirements.'),

(3,'multiple_choice','foundational',
'What is the BEST basis for defending a code-related field decision?',
'[{"key":"A","text":"A documented interpretation tied to the governing code, applicable amendments, equipment requirements, and project conditions"},{"key":"B","text":"Personal experience alone"},{"key":"C","text":"What another contractor normally does"},{"key":"D","text":"The fastest installation method"}]'::jsonb,
'["A"]'::jsonb,
'High-level code application should be traceable to governing requirements and actual project conditions.'),

-- APPLICATION — 7

(4,'situational_judgment','application',
'A journeyman identifies a conflict between a general code rule and a more specific requirement for the equipment being installed. What should happen?',
'[{"key":"A","text":"Determine which provision governs by reviewing scope, specificity, listing information, and applicable cross-references"},{"key":"B","text":"Always use the general rule"},{"key":"C","text":"Always use the shorter requirement"},{"key":"D","text":"Ignore the equipment-specific information"}]'::jsonb,
'["A"]'::jsonb,
'Specific provisions and equipment requirements can control how a general rule applies.'),

(5,'multiple_select','application',
'Which THREE practices support defensible advanced code interpretation?',
'[{"key":"A","text":"Verify the adopted edition and amendments"},{"key":"B","text":"Trace definitions, exceptions, notes, and cross-references"},{"key":"C","text":"Document the reasoning and unresolved assumptions"},{"key":"D","text":"Rely on memory instead of checking the current requirement"},{"key":"E","text":"Apply exceptions without confirming conditions"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced interpretation should be based on current governing text, complete context, and documented reasoning.'),

(6,'situational_judgment','application',
'A project specification is more restrictive than the minimum code requirement. What is the BEST response?',
'[{"key":"A","text":"Recognize that code establishes minimum requirements and coordinate compliance with the more restrictive contractual requirement where applicable"},{"key":"B","text":"Ignore the specification because code is less restrictive"},{"key":"C","text":"Reduce the installation to the code minimum automatically"},{"key":"D","text":"Treat the specification as advisory"}]'::jsonb,
'["A"]'::jsonb,
'Code minimums do not automatically eliminate more restrictive contractual project requirements.'),

(7,'multiple_choice','application',
'When a code rule depends on classification of a space, equipment, or condition, what should the journeyman do first?',
'[{"key":"A","text":"Verify the actual classification and facts that trigger the requirement"},{"key":"B","text":"Assume the most common classification"},{"key":"C","text":"Apply every possible classification simultaneously"},{"key":"D","text":"Ignore classification language"}]'::jsonb,
'["A"]'::jsonb,
'The factual condition or classification must be established before a dependent requirement can be applied correctly.'),

(8,'situational_judgment','application',
'An inspector interprets a requirement differently from the project team. What is the BEST professional response?',
'[{"key":"A","text":"Review the governing text and project facts, document the issue, and resolve it through the authority and project clarification process"},{"key":"B","text":"Argue from memory"},{"key":"C","text":"Ignore the inspector"},{"key":"D","text":"Change the work without documenting why"}]'::jsonb,
'["A"]'::jsonb,
'Code disagreements should be resolved through documented technical review and the appropriate authority process.'),

(9,'multiple_choice','application',
'Why should a journeyman avoid citing only a section number without recording the actual requirement and context?',
'[{"key":"A","text":"Because the reasoning depends on the section text, scope, conditions, exceptions, and project facts"},{"key":"B","text":"Because section numbers are never useful"},{"key":"C","text":"Because code citations are prohibited"},{"key":"D","text":"Because project teams should rely on memory"}]'::jsonb,
'["A"]'::jsonb,
'A bare citation may not explain applicability; defensible decisions include both the governing text and factual context.'),

(10,'situational_judgment','application',
'You discover that a design appears code-compliant only if a particular exception applies, but the field condition does not satisfy one of the exception criteria. What should you do?',
'[{"key":"A","text":"Treat the exception as unavailable and escalate the resulting design conflict"},{"key":"B","text":"Apply the exception because it was probably intended"},{"key":"C","text":"Ignore the missing criterion"},{"key":"D","text":"Change the field condition without approval"}]'::jsonb,
'["A"]'::jsonb,
'Exceptions apply only when their stated conditions are satisfied.'),

-- SCENARIO — 10

(11,'scenario','scenario',
'A feeder installation appears acceptable under a general requirement, but a special occupancy provision imposes an additional restriction. What should govern?',
'[{"key":"A","text":"The general requirement together with the applicable special occupancy provision"},{"key":"B","text":"Only the general requirement"},{"key":"C","text":"Only whichever provision is easier"},{"key":"D","text":"The previous project standard"}]'::jsonb,
'["A"]'::jsonb,
'Special occupancy or installation provisions may supplement or modify general requirements.'),

(12,'scenario','scenario',
'A journeyman is reviewing a proposed field change. The change affects conductor routing, equipment clearances, and a listed assembly. What is the BEST code-review approach?',
'[{"key":"A","text":"Evaluate each affected requirement, listed-system limitation, and project condition before approving or escalating the change"},{"key":"B","text":"Review only the conductor routing"},{"key":"C","text":"Approve the change if materials fit"},{"key":"D","text":"Rely on the original design approval"}]'::jsonb,
'["A"]'::jsonb,
'Field changes can trigger multiple independent code and listing requirements that must be reviewed together.'),

(13,'scenario','scenario',
'Two authorities involved in a project have different published interpretations of the same requirement. What should the journeyman do?',
'[{"key":"A","text":"Identify which authority governs the specific work, document the interpretations, and resolve the issue through the project and authority process"},{"key":"B","text":"Choose the interpretation that costs less"},{"key":"C","text":"Apply neither interpretation"},{"key":"D","text":"Use whichever interpretation was issued first"}]'::jsonb,
'["A"]'::jsonb,
'Jurisdiction and authority must be established when differing interpretations affect the work.'),

(14,'scenario','scenario',
'A piece of equipment is listed for installation only under specific conditions, but the proposed field layout does not meet those conditions. What is the BEST response?',
'[{"key":"A","text":"Do not treat the listing as satisfied; resolve the installation conflict before proceeding"},{"key":"B","text":"Install it because the equipment itself is listed"},{"key":"C","text":"Remove the listing label"},{"key":"D","text":"Ignore the manufacturer conditions"}]'::jsonb,
'["A"]'::jsonb,
'Listing and labeling requirements include the conditions of use associated with the equipment.'),

(15,'scenario','scenario',
'A design note references a code requirement from an older edition than the one adopted for the project. What should the journeyman do?',
'[{"key":"A","text":"Verify the currently governing requirement and raise any conflict with the design documents"},{"key":"B","text":"Use the older edition automatically"},{"key":"C","text":"Use both editions simultaneously"},{"key":"D","text":"Ignore the design note without documenting it"}]'::jsonb,
'["A"]'::jsonb,
'The adopted governing edition controls unless project or authority requirements establish otherwise.'),

(16,'scenario','scenario',
'A code calculation appears correct mathematically, but one input value was taken from a table without applying a required note. What is the BEST conclusion?',
'[{"key":"A","text":"The calculation must be reevaluated using the table together with its applicable notes and conditions"},{"key":"B","text":"The calculation is valid because the arithmetic is correct"},{"key":"C","text":"Table notes are optional"},{"key":"D","text":"Only the final number matters"}]'::jsonb,
'["A"]'::jsonb,
'Correct arithmetic does not compensate for using an input value outside its stated conditions.'),

(17,'scenario','scenario',
'A field condition falls near the boundary between two different code classifications. What should the journeyman do?',
'[{"key":"A","text":"Establish the actual facts, definitions, and governing classification criteria before applying the requirement"},{"key":"B","text":"Choose whichever classification is more convenient"},{"key":"C","text":"Apply no classification"},{"key":"D","text":"Use the classification from another project"}]'::jsonb,
'["A"]'::jsonb,
'Boundary conditions require careful fact-finding and use of the governing definitions and criteria.'),

(18,'situational_judgment','scenario',
'A crew has already installed work that a later code review indicates may be noncompliant. What should the journeyman do?',
'[{"key":"A","text":"Stop affected work as appropriate, document the issue, verify the governing requirement, and escalate corrective action through the project process"},{"key":"B","text":"Hide the issue until inspection"},{"key":"C","text":"Continue because the work is already installed"},{"key":"D","text":"Remove everything without review"}]'::jsonb,
'["A"]'::jsonb,
'Potential noncompliance should be verified and addressed through controlled corrective action rather than ignored or handled informally.'),

(19,'scenario','scenario',
'A proposed installation satisfies the literal wording of one section but appears inconsistent with a referenced requirement and the equipment instructions. What is the BEST response?',
'[{"key":"A","text":"Read all applicable provisions and equipment requirements together before concluding the installation is compliant"},{"key":"B","text":"Use the single favorable sentence"},{"key":"C","text":"Ignore cross-references"},{"key":"D","text":"Assume literal compliance with one sentence is sufficient"}]'::jsonb,
'["A"]'::jsonb,
'Compliance must be evaluated using the complete set of applicable requirements rather than isolated language.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 4 proficiency in Electrical Code Application?',
'[{"key":"A","text":"Memorizing many isolated section numbers"},{"key":"B","text":"Independently interpreting complex requirements, reconciling general and special provisions, documenting defensible decisions, and leading escalation of unresolved code conflicts"},{"key":"C","text":"Avoiding difficult code questions"},{"key":"D","text":"Applying past practice without verification"}]'::jsonb,
'["B"]'::jsonb,
'Level 4 performance means independently handling complex code interpretation, documenting reasoning, and leading resolution when requirements conflict or remain uncertain.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '4e2dcd39-37a8-41ca-bb76-eb8072244f5d';
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
      and c.name = 'Electrical Code Application'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Code Application Master Competency not found';
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
  v_assessment_name := 'Electrical Code Application — Level 2 Competency Assessment';

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
    select * from _seed_electrical_code_l2_questions
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
        'Electrical Code Application',
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
      'IntegrateU Electrical Code Application L2 production assessment v1.0.',
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
        'Electrical Code Application',
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
        'IntegrateU Electrical Code Application L2 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Code Application — Level 4 Competency Assessment';

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
    select * from _seed_electrical_code_l4_questions
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
        'Electrical Code Application',
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
      'IntegrateU Electrical Code Application L4 production assessment v1.0.',
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
        'Electrical Code Application',
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
        'IntegrateU Electrical Code Application L4 production assessment v1.0.',
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
   '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid
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
      '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid
    and a.target_level in (2,4)
    and aq.master_competency_template_id =
      '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid
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
  '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid;

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
    '4e2dcd39-37a8-41ca-bb76-eb8072244f5d'::uuid
  and a.target_level in (2,4)
group by a.target_level
having count(*) > 1;
