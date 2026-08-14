-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0102_electrical_load_calculations_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Load Calculations
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

create temporary table _seed_electrical_load_calculations_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_load_calculations_l1_questions (
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
'What does an electrical load calculation primarily help determine?',
'[{"key":"A","text":"The electrical demand or capacity required for a circuit, feeder, service, or equipment"},{"key":"B","text":"The paint color of electrical equipment"},{"key":"C","text":"The physical length of every conductor"},{"key":"D","text":"The utility frequency"}]'::jsonb,
'["A"]'::jsonb,
'Load calculations help determine the electrical demand that conductors, equipment, and protective devices must serve.'),

(2,'multiple_choice','foundational',
'What unit is commonly used to express electrical power?',
'[{"key":"A","text":"Watts"},{"key":"B","text":"Ohms per foot only"},{"key":"C","text":"Hertz per ampere"},{"key":"D","text":"Degrees"}]'::jsonb,
'["A"]'::jsonb,
'Electrical power is commonly expressed in watts or related units such as kilowatts.'),

(3,'multiple_choice','foundational',
'What is the basic relationship for single-phase power when voltage and current are known in a simple resistive case?',
'[{"key":"A","text":"Power equals voltage multiplied by current"},{"key":"B","text":"Power equals voltage divided by current"},{"key":"C","text":"Power equals current minus voltage"},{"key":"D","text":"Power equals resistance multiplied by frequency"}]'::jsonb,
'["A"]'::jsonb,
'For a simple resistive single-phase load, power is determined from voltage multiplied by current.'),

(4,'multiple_choice','foundational',
'Why is it important to identify the actual voltage of a load when performing calculations?',
'[{"key":"A","text":"Voltage affects current and power relationships used in sizing and planning"},{"key":"B","text":"Voltage affects only conductor color"},{"key":"C","text":"Voltage has no relationship to current"},{"key":"D","text":"Voltage replaces equipment ratings"}]'::jsonb,
'["A"]'::jsonb,
'Load calculations depend on the actual system voltage and electrical relationships involved.'),

(5,'multiple_choice','foundational',
'What does the term connected load generally mean?',
'[{"key":"A","text":"The total rating of electrical loads connected or planned to be connected"},{"key":"B","text":"Only the largest breaker in a panel"},{"key":"C","text":"The number of boxes on a circuit"},{"key":"D","text":"The grounding electrode resistance"}]'::jsonb,
'["A"]'::jsonb,
'Connected load refers to the combined ratings of the loads connected to a system or portion of a system.'),

(6,'multiple_choice','foundational',
'Why may calculated demand differ from the simple sum of every connected load?',
'[{"key":"A","text":"Applicable demand or diversity factors may recognize that not all loads operate at full value simultaneously"},{"key":"B","text":"Connected loads never matter"},{"key":"C","text":"Demand is always larger than connected load"},{"key":"D","text":"Breaker size automatically determines demand"}]'::jsonb,
'["A"]'::jsonb,
'Applicable calculation rules may account for expected simultaneous use rather than assuming every load operates at full rating at once.'),

(7,'multiple_choice','foundational',
'Why are load calculations important before selecting conductors or protective devices?',
'[{"key":"A","text":"The expected load helps establish appropriate electrical capacity requirements"},{"key":"B","text":"Calculations determine conductor insulation color"},{"key":"C","text":"Calculations eliminate equipment ratings"},{"key":"D","text":"Calculations replace installation drawings"}]'::jsonb,
'["A"]'::jsonb,
'Load information is a key input to selecting conductors, protective devices, and distribution equipment.'),

(8,'multiple_choice','foundational',
'What is the BEST first step when given several equipment nameplate ratings for a load calculation?',
'[{"key":"A","text":"Identify the relevant electrical ratings and organize the loads before calculating"},{"key":"B","text":"Add every number on every nameplate"},{"key":"C","text":"Choose the largest breaker available"},{"key":"D","text":"Ignore voltage ratings"}]'::jsonb,
'["A"]'::jsonb,
'Accurate calculations begin by identifying the correct electrical ratings and organizing the loads being evaluated.'),

-- APPLICATION — 8

(9,'multiple_choice','application',
'A 120-volt resistive load draws 10 amperes. What is its approximate power?',
'[{"key":"A","text":"1,200 watts"},{"key":"B","text":"120 watts"},{"key":"C","text":"12 watts"},{"key":"D","text":"12,000 watts"}]'::jsonb,
'["A"]'::jsonb,
'For this simple case, 120 volts multiplied by 10 amperes equals 1,200 watts.'),

(10,'multiple_choice','application',
'A 240-volt resistive load is rated 4,800 watts. What current does it draw approximately?',
'[{"key":"A","text":"20 amperes"},{"key":"B","text":"2 amperes"},{"key":"C","text":"200 amperes"},{"key":"D","text":"48 amperes"}]'::jsonb,
'["A"]'::jsonb,
'Current is approximately power divided by voltage: 4,800 divided by 240 equals 20 amperes.'),

(11,'situational_judgment','application',
'You are asked to calculate a circuit load, but one equipment nameplate is unreadable. What is the BEST response?',
'[{"key":"A","text":"Obtain reliable equipment rating information before completing the calculation"},{"key":"B","text":"Guess based on equipment size"},{"key":"C","text":"Use the breaker rating as the equipment load"},{"key":"D","text":"Ignore the equipment"}]'::jsonb,
'["A"]'::jsonb,
'Load calculations should be based on reliable rating information rather than assumptions.'),

(12,'multiple_select','application',
'Which THREE pieces of information commonly matter when performing basic electrical load calculations?',
'[{"key":"A","text":"Equipment or load rating"},{"key":"B","text":"System voltage"},{"key":"C","text":"Applicable calculation or demand rules"},{"key":"D","text":"Wall paint color"},{"key":"E","text":"Installer shoe size"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Load rating, system voltage, and applicable calculation rules are common calculation inputs.'),

(13,'situational_judgment','application',
'Two loads are added to an existing circuit. What should be checked before assuming the circuit can support them?',
'[{"key":"A","text":"The revised calculated load and the capacity of the circuit conductors and protection"},{"key":"B","text":"Only whether an outlet is nearby"},{"key":"C","text":"Only the number of open panel spaces"},{"key":"D","text":"Only conductor color"}]'::jsonb,
'["A"]'::jsonb,
'Adding loads requires evaluating the resulting circuit load against available circuit capacity.'),

(14,'multiple_choice','application',
'Why should the same unit basis be used consistently when combining electrical loads?',
'[{"key":"A","text":"Consistent units prevent calculation errors and allow values to be combined correctly"},{"key":"B","text":"Units affect only formatting"},{"key":"C","text":"Watts and amperes are always directly interchangeable without voltage"},{"key":"D","text":"Units are optional"}]'::jsonb,
'["A"]'::jsonb,
'Values should be converted to compatible units before being added or compared.'),

(15,'situational_judgment','application',
'A calculated load seems unexpectedly high compared with the equipment being served. What is the BEST next step?',
'[{"key":"A","text":"Recheck the source data, units, voltage assumptions, arithmetic, and applicable factors"},{"key":"B","text":"Immediately select larger equipment"},{"key":"C","text":"Delete the largest load from the calculation"},{"key":"D","text":"Use the previous project result"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected results should trigger verification of inputs, units, formulas, and applicable calculation factors.'),

(16,'multiple_choice','application',
'Why should calculated loads be documented clearly?',
'[{"key":"A","text":"So another qualified person can understand, verify, and use the calculation"},{"key":"B","text":"To increase equipment capacity"},{"key":"C","text":"To eliminate field verification"},{"key":"D","text":"To replace all project documents"}]'::jsonb,
'["A"]'::jsonb,
'Clear documentation supports review, coordination, and future use of the calculation.'),

-- SCENARIO — 4

(17,'scenario','scenario',
'An apprentice calculates a 240-volt, 6,000-watt resistive load as 2.5 amperes. What is the BEST response?',
'[{"key":"A","text":"Recheck the formula and arithmetic because the expected current is about 25 amperes"},{"key":"B","text":"Accept 2.5 amperes"},{"key":"C","text":"Use a 2-ampere breaker"},{"key":"D","text":"Ignore the voltage"}]'::jsonb,
'["A"]'::jsonb,
'Current is approximately 6,000 divided by 240, which equals 25 amperes.'),

(18,'scenario','scenario',
'A circuit calculation includes equipment that will not actually be connected to the circuit. What should happen?',
'[{"key":"A","text":"Correct the load list so the calculation reflects the actual planned circuit"},{"key":"B","text":"Leave the extra load because larger calculations are always better"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Remove a different load instead"}]'::jsonb,
'["A"]'::jsonb,
'The calculation should accurately represent the loads served by the circuit being evaluated.'),

(19,'scenario','scenario',
'A calculated load exceeds the apparent capacity of an existing circuit. What should a Level 1 worker do?',
'[{"key":"A","text":"Report the condition for review rather than assuming the circuit can accept the load"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Ignore the calculation"},{"key":"D","text":"Reduce the documented load without changing equipment"}]'::jsonb,
'["A"]'::jsonb,
'When a calculated load appears to exceed available capacity, the condition should be escalated for proper evaluation.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Electrical Load Calculations?',
'[{"key":"A","text":"Guessing equipment loads from breaker sizes"},{"key":"B","text":"Identifying load data, applying basic voltage-current-power relationships, checking arithmetic, documenting results, and escalating capacity concerns"},{"key":"C","text":"Ignoring units when combining loads"},{"key":"D","text":"Changing calculation results to fit existing equipment"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 performance means accurately applying basic load-calculation concepts and recognizing when results require further review.');

create temporary table _seed_electrical_load_calculations_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_load_calculations_l3_questions (
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
'Why must a journeyman distinguish connected load from calculated demand?',
'[{"key":"A","text":"Applicable calculation methods may permit demand factors or other adjustments that change the load used for system sizing"},{"key":"B","text":"Connected load is never relevant"},{"key":"C","text":"Demand always equals breaker size"},{"key":"D","text":"Calculated demand applies only to lighting"}]'::jsonb,
'["A"]'::jsonb,
'Connected load and calculated demand can differ because applicable calculation methods may account for load characteristics and expected use.'),

(2,'multiple_choice','foundational',
'Why should continuous and noncontinuous load characteristics be identified during calculations?',
'[{"key":"A","text":"Different load characteristics can affect required conductor and protective-device sizing"},{"key":"B","text":"They affect only equipment labels"},{"key":"C","text":"Continuous loads always use smaller conductors"},{"key":"D","text":"The distinction has no effect on planning"}]'::jsonb,
'["A"]'::jsonb,
'Load duration and applicable rules can affect the capacity required for conductors and overcurrent protection.'),

(3,'multiple_choice','foundational',
'Why can motor, HVAC, heating, or other specialized loads require more than simple wattage addition?',
'[{"key":"A","text":"Their calculation rules and operating characteristics may require specific treatment"},{"key":"B","text":"They have no electrical ratings"},{"key":"C","text":"They are always excluded from load calculations"},{"key":"D","text":"Only physical size matters"}]'::jsonb,
'["A"]'::jsonb,
'Specialized loads can have application-specific calculation requirements that must be applied correctly.'),

(4,'multiple_choice','foundational',
'Why should a journeyman understand whether a calculation is for a branch circuit, feeder, service, or distribution equipment?',
'[{"key":"A","text":"The applicable loads, calculation rules, and sizing decisions can differ depending on the system level being evaluated"},{"key":"B","text":"All electrical calculations are identical"},{"key":"C","text":"Only the final numerical answer matters"},{"key":"D","text":"System level affects only drawing symbols"}]'::jsonb,
'["A"]'::jsonb,
'The purpose and location of a calculation determine which loads and rules apply.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'An existing feeder will serve several new loads. What should the journeyman evaluate before approving the addition?',
'[{"key":"A","text":"Existing and proposed calculated demand, feeder capacity, protective equipment, and relevant load characteristics"},{"key":"B","text":"Only whether panel spaces are available"},{"key":"C","text":"Only the largest new breaker"},{"key":"D","text":"Only the physical size of the feeder"}]'::jsonb,
'["A"]'::jsonb,
'Adding loads to an existing feeder requires evaluating the revised calculated demand against feeder and equipment capacity.'),

(6,'multiple_select','application',
'Which THREE practices support reliable advanced load calculations?',
'[{"key":"A","text":"Use verified source data"},{"key":"B","text":"Apply the correct calculation method for each load type"},{"key":"C","text":"Document assumptions, factors, and intermediate results"},{"key":"D","text":"Round values randomly"},{"key":"E","text":"Use breaker size as a substitute for every equipment rating"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Reliable calculations depend on verified inputs, correct methods, and transparent documentation.'),

(7,'situational_judgment','application',
'Project documents list equipment at one voltage, but approved equipment submittals show a different voltage. What should happen before finalizing the load calculation?',
'[{"key":"A","text":"Reconcile the actual equipment ratings and update the calculation using the correct design basis"},{"key":"B","text":"Use whichever voltage produces the smaller load"},{"key":"C","text":"Average the two voltages"},{"key":"D","text":"Ignore the equipment submittal"}]'::jsonb,
'["A"]'::jsonb,
'Load calculations should use the actual approved equipment and system design information.'),

(8,'multiple_choice','application',
'A three-phase load calculation produces an implausible current value. What is the BEST first response?',
'[{"key":"A","text":"Verify the formula, phase relationship, voltage basis, units, power information, and arithmetic"},{"key":"B","text":"Increase conductor size immediately"},{"key":"C","text":"Change the breaker rating"},{"key":"D","text":"Use a single-phase formula without review"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected results should prompt verification of the electrical relationships and assumptions used.'),

(9,'situational_judgment','application',
'A load schedule contains several duplicated equipment entries. What should the journeyman do?',
'[{"key":"A","text":"Resolve the duplicated entries before relying on the total calculated load"},{"key":"B","text":"Keep the duplicates for extra safety"},{"key":"C","text":"Remove unrelated loads instead"},{"key":"D","text":"Increase service size automatically"}]'::jsonb,
'["A"]'::jsonb,
'Calculation inputs should accurately reflect the actual loads without unsupported duplication.'),

(10,'multiple_choice','application',
'Why should demand factors be applied only where appropriate?',
'[{"key":"A","text":"Using an unsupported demand reduction can understate the required electrical capacity"},{"key":"B","text":"Demand factors always apply to every load"},{"key":"C","text":"Demand factors affect only labels"},{"key":"D","text":"A larger breaker corrects any calculation error"}]'::jsonb,
'["A"]'::jsonb,
'Demand factors must be applied according to the applicable calculation method and load conditions.'),

(11,'situational_judgment','application',
'A service load calculation is being revised after major equipment changes. What is the BEST approach?',
'[{"key":"A","text":"Rebuild or update the calculation from verified current loads and assumptions rather than modifying only the final total"},{"key":"B","text":"Add a percentage to the old answer"},{"key":"C","text":"Use the previous service size as the new calculation"},{"key":"D","text":"Ignore deleted and added equipment"}]'::jsonb,
'["A"]'::jsonb,
'Major load changes require the calculation basis to be updated so the result reflects the current design.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A feeder load calculation is below the feeder rating, but a large continuous load was treated as an ordinary noncontinuous load. What should the journeyman do?',
'[{"key":"A","text":"Correct the load classification and recalculate before accepting the feeder sizing"},{"key":"B","text":"Accept the calculation because the total is below the rating"},{"key":"C","text":"Delete another load"},{"key":"D","text":"Increase the breaker only"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect load classification can materially understate required capacity and must be corrected.'),

(13,'scenario','scenario',
'A service calculation uses demand factors from a previous project with a different occupancy and load mix. What is the BEST response?',
'[{"key":"A","text":"Verify and apply only the demand treatment appropriate to the current project"},{"key":"B","text":"Reuse the prior factors automatically"},{"key":"C","text":"Choose whichever factors produce the smallest service"},{"key":"D","text":"Ignore demand factors entirely"}]'::jsonb,
'["A"]'::jsonb,
'Demand treatment must be supported by the current project conditions and applicable calculation method.'),

(14,'scenario','scenario',
'An equipment schedule changes after the feeder and service calculations are complete. Several new loads are larger than originally specified. What should happen?',
'[{"key":"A","text":"Update the affected calculations and reevaluate feeder, service, conductor, and equipment capacity"},{"key":"B","text":"Leave the original calculations unchanged"},{"key":"C","text":"Increase protective-device ratings without calculation"},{"key":"D","text":"Assume design contingency covers all changes"}]'::jsonb,
'["A"]'::jsonb,
'Material changes in equipment loads require affected calculations and capacity decisions to be revisited.'),

(15,'scenario','scenario',
'Two engineers produce different load totals from the same project documents. What is the BEST troubleshooting approach?',
'[{"key":"A","text":"Compare load inventories, classifications, units, assumptions, formulas, demand factors, and arithmetic step by step"},{"key":"B","text":"Average the two final totals"},{"key":"C","text":"Use the lower total"},{"key":"D","text":"Use the larger breaker and skip reconciliation"}]'::jsonb,
'["A"]'::jsonb,
'Differences should be resolved by tracing the calculation basis and intermediate steps rather than selecting a result arbitrarily.'),

(16,'scenario','scenario',
'An existing service appears lightly loaded from a short field observation, but the calculated connected and demand loads are much higher. What should the journeyman conclude?',
'[{"key":"A","text":"A brief observation alone does not replace an appropriate load calculation or approved load-study method"},{"key":"B","text":"The calculation must be wrong"},{"key":"C","text":"The service can automatically accept new loads"},{"key":"D","text":"Current breaker position determines available capacity"}]'::jsonb,
'["A"]'::jsonb,
'Momentary observed loading and calculated design demand address different questions and should not be confused.'),

(17,'scenario','scenario',
'A proposed equipment replacement has the same function as the old unit but substantially different electrical ratings. What should happen?',
'[{"key":"A","text":"Update the affected branch, feeder, and distribution calculations using the replacement equipment ratings"},{"key":"B","text":"Keep the original load because the equipment function is unchanged"},{"key":"C","text":"Use the old breaker rating as the new load"},{"key":"D","text":"Ignore the nameplate"}]'::jsonb,
'["A"]'::jsonb,
'Electrical calculations should reflect the actual ratings of the equipment being installed.'),

(18,'scenario','scenario',
'A calculation spreadsheet gives a correct-looking total, but several formulas reference the wrong rows. What is the BEST response?',
'[{"key":"A","text":"Correct and independently verify the calculation before using it for sizing decisions"},{"key":"B","text":"Accept the final total because it looks reasonable"},{"key":"C","text":"Hide the formula cells"},{"key":"D","text":"Round the total upward and continue"}]'::jsonb,
'["A"]'::jsonb,
'Calculation tools must be verified; a plausible final value does not make incorrect formulas acceptable.'),

(19,'scenario','scenario',
'A proposed load addition would bring calculated demand very close to the rating of existing distribution equipment. What should the journeyman do?',
'[{"key":"A","text":"Verify the calculation, equipment ratings, applicable loading limits, future conditions, and project requirements before approving the addition"},{"key":"B","text":"Approve it because the arithmetic is below the nameplate rating"},{"key":"C","text":"Increase protective-device settings automatically"},{"key":"D","text":"Remove loads from the documentation"}]'::jsonb,
'["A"]'::jsonb,
'Near-capacity conditions deserve careful verification of the calculation and all applicable equipment and system limitations.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Electrical Load Calculations?',
'[{"key":"A","text":"Adding nameplate values without considering load type or calculation rules"},{"key":"B","text":"Independently developing, checking, documenting, and revising branch, feeder, service, and distribution load calculations while resolving conflicting inputs and capacity concerns"},{"key":"C","text":"Using breaker ratings as the default load value"},{"key":"D","text":"Reusing previous-project demand factors without verification"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently applying and verifying load-calculation methods across electrical distribution planning and responding correctly to changing project conditions.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a';
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
      and c.name = 'Electrical Load Calculations'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Load Calculations Master Competency not found';
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
  v_assessment_name := 'Electrical Load Calculations — Level 1 Competency Assessment';

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
    select * from _seed_electrical_load_calculations_l1_questions
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
        'Electrical Load Calculations',
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
      'IntegrateU Electrical Load Calculations L1 production assessment v1.0.',
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
        'Electrical Load Calculations',
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
        'IntegrateU Electrical Load Calculations L1 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Load Calculations — Level 3 Competency Assessment';

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
    select * from _seed_electrical_load_calculations_l3_questions
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
        'Electrical Load Calculations',
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
      'IntegrateU Electrical Load Calculations L3 production assessment v1.0.',
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
        'Electrical Load Calculations',
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
        'IntegrateU Electrical Load Calculations L3 production assessment v1.0.',
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
   'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid
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
      'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid
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
  'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid;

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
    'd3aea729-f4ae-4ab8-b2a5-dae0fd82fd2a'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
