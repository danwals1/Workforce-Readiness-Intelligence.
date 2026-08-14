-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0107_electrical_troubleshooting_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Troubleshooting
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

create temporary table _seed_electrical_troubleshooting_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_troubleshooting_l1_questions (
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
'What is the first goal of electrical troubleshooting?',
'[{"key":"A","text":"Identify the actual problem and gather reliable information before changing the system"},{"key":"B","text":"Replace the nearest component"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Disconnect grounding"}]'::jsonb,
'["A"]'::jsonb,
'Good troubleshooting begins by defining the symptom and collecting accurate information.'),

(2,'multiple_choice','foundational',
'Why should a worker verify the expected circuit operation before troubleshooting?',
'[{"key":"A","text":"You need to know what normal operation should look like before identifying what is abnormal"},{"key":"B","text":"It increases conductor ampacity"},{"key":"C","text":"It eliminates testing"},{"key":"D","text":"It changes circuit voltage"}]'::jsonb,
'["A"]'::jsonb,
'Understanding normal operation provides the baseline for identifying faults.'),

(3,'multiple_choice','foundational',
'What is the purpose of using an electrical test instrument during troubleshooting?',
'[{"key":"A","text":"To gather measured evidence about circuit conditions"},{"key":"B","text":"To replace documentation"},{"key":"C","text":"To increase system voltage"},{"key":"D","text":"To bypass protective devices"}]'::jsonb,
'["A"]'::jsonb,
'Test instruments provide objective information about voltage, current, continuity, and other circuit conditions.'),

(4,'multiple_choice','foundational',
'Why should troubleshooting measurements be compared with expected values?',
'[{"key":"A","text":"The comparison helps determine where actual circuit behavior differs from intended operation"},{"key":"B","text":"Expected values are only for design"},{"key":"C","text":"Measurements do not need interpretation"},{"key":"D","text":"Any nonzero reading proves normal operation"}]'::jsonb,
'["A"]'::jsonb,
'Troubleshooting depends on comparing measured conditions against what should be present.'),

(5,'multiple_choice','foundational',
'Why is documentation useful during troubleshooting?',
'[{"key":"A","text":"Drawings, labels, and equipment information help identify circuit paths and intended operation"},{"key":"B","text":"Documentation replaces testing"},{"key":"C","text":"Documentation increases breaker capacity"},{"key":"D","text":"Documentation eliminates faults"}]'::jsonb,
'["A"]'::jsonb,
'Accurate documentation helps a worker understand the system before taking measurements or making changes.'),

(6,'multiple_choice','foundational',
'Why should a troubleshooting process change only one relevant condition at a time when practical?',
'[{"key":"A","text":"It helps identify which change affected the symptom"},{"key":"B","text":"It increases voltage"},{"key":"C","text":"It eliminates the need for retesting"},{"key":"D","text":"It prevents documentation"}]'::jsonb,
'["A"]'::jsonb,
'Controlled changes make cause-and-effect easier to identify.'),

(7,'multiple_choice','foundational',
'What does an unexpected open circuit generally indicate?',
'[{"key":"A","text":"A break or interruption exists somewhere in the intended current path"},{"key":"B","text":"The circuit is overloaded"},{"key":"C","text":"Voltage is too high"},{"key":"D","text":"The grounding electrode is too large"}]'::jsonb,
'["A"]'::jsonb,
'An unintended open interrupts the current path and can prevent equipment operation.'),

(8,'multiple_choice','foundational',
'Why is a repeated protective-device trip important troubleshooting information?',
'[{"key":"A","text":"It may indicate an overload, short circuit, ground fault, or equipment problem"},{"key":"B","text":"It means the protective device should automatically be enlarged"},{"key":"C","text":"It proves the circuit is normal"},{"key":"D","text":"It affects only labeling"}]'::jsonb,
'["A"]'::jsonb,
'Protective-device operation is a symptom that can point to excessive current or a fault condition.'),

(9,'situational_judgment','application',
'A motor stops unexpectedly. What is the BEST Level 1 troubleshooting approach?',
'[{"key":"A","text":"Confirm the symptom, review the circuit, and gather safe measurements before replacing parts"},{"key":"B","text":"Replace the motor immediately"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Bypass the controls"}]'::jsonb,
'["A"]'::jsonb,
'Basic troubleshooting should verify the problem and collect evidence before deciding on corrective action.'),

(10,'multiple_choice','application',
'A device has the correct supply voltage at its input but does not operate. What should be checked next?',
'[{"key":"A","text":"The device, its output or load path, controls, neutral or return path, and associated connections as applicable"},{"key":"B","text":"Only the service grounding electrode"},{"key":"C","text":"Increase branch-circuit protection"},{"key":"D","text":"Assume the voltage measurement was irrelevant"}]'::jsonb,
'["A"]'::jsonb,
'Correct supply voltage narrows the troubleshooting focus toward downstream connections, controls, return paths, or the device itself.'),

(11,'situational_judgment','application',
'A breaker trips immediately every time it is reset. What should a Level 1 worker do?',
'[{"key":"A","text":"Stop repeated resetting and escalate for qualified fault evaluation"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Hold it closed"},{"key":"D","text":"Bypass it"}]'::jsonb,
'["A"]'::jsonb,
'Immediate repeated tripping can indicate a significant fault and should not be defeated.'),

(12,'multiple_select','application',
'Which THREE practices support good basic electrical troubleshooting?',
'[{"key":"A","text":"Define the symptom clearly"},{"key":"B","text":"Use drawings and measurements"},{"key":"C","text":"Document findings and changes"},{"key":"D","text":"Replace parts randomly"},{"key":"E","text":"Increase protection until the problem stops"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Systematic troubleshooting relies on clear symptoms, evidence, and documentation.'),

(13,'multiple_choice','application',
'Why should test leads and meters be checked before relying on a measurement?',
'[{"key":"A","text":"A damaged lead or incorrect meter setup can produce unsafe or misleading results"},{"key":"B","text":"Meters automatically correct every setup error"},{"key":"C","text":"Test leads affect only display brightness"},{"key":"D","text":"Instrument condition is unrelated to troubleshooting"}]'::jsonb,
'["A"]'::jsonb,
'Reliable troubleshooting requires suitable and correctly configured test equipment.'),

(14,'situational_judgment','application',
'A circuit works intermittently when equipment is moved or vibrates. What should be suspected?',
'[{"key":"A","text":"A loose connection, damaged conductor, or intermittent component should be investigated"},{"key":"B","text":"The breaker is definitely too small"},{"key":"C","text":"The system needs more voltage"},{"key":"D","text":"The grounding conductor should be removed"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent operation associated with movement often points to a marginal physical connection or conductor condition.'),

(15,'multiple_choice','application',
'Why should a worker record where measurements were taken?',
'[{"key":"A","text":"The location gives the measurement meaning within the circuit path"},{"key":"B","text":"Location never matters"},{"key":"C","text":"It increases meter accuracy"},{"key":"D","text":"It changes circuit loading"}]'::jsonb,
'["A"]'::jsonb,
'A reading is most useful when tied to a specific point in the circuit.'),

(16,'situational_judgment','application',
'A fuse has opened. What is the BEST response before replacing it?',
'[{"key":"A","text":"Investigate why it opened and verify the correct replacement rating"},{"key":"B","text":"Install the largest fuse that fits"},{"key":"C","text":"Bypass the fuse"},{"key":"D","text":"Replace it repeatedly until it stays closed"}]'::jsonb,
'["A"]'::jsonb,
'An opened fuse is a symptom; the underlying cause and correct rating should be addressed.'),

(17,'scenario','scenario',
'Lighting in one area suddenly stops working, but other circuits remain normal. What is the BEST Level 1 approach?',
'[{"key":"A","text":"Identify the affected circuit and systematically verify source, protection, controls, connections, and load path"},{"key":"B","text":"Replace all fixtures"},{"key":"C","text":"Increase the main breaker"},{"key":"D","text":"Assume a utility outage"}]'::jsonb,
'["A"]'::jsonb,
'Systematic sectional troubleshooting helps locate where normal circuit operation stops.'),

(18,'scenario','scenario',
'A receptacle tester gives an unexpected indication that does not match previous documentation. What should happen?',
'[{"key":"A","text":"Verify the condition with appropriate testing and reconcile the actual wiring before making assumptions"},{"key":"B","text":"Trust the old documentation instead"},{"key":"C","text":"Ignore the tester"},{"key":"D","text":"Replace the branch breaker"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting evidence should be verified rather than resolved by assumption.'),

(19,'scenario','scenario',
'You find visible overheating at a termination while troubleshooting an intermittent circuit. What should a Level 1 worker do?',
'[{"key":"A","text":"Treat the condition as abnormal, stop unsafe operation, and escalate for qualified correction"},{"key":"B","text":"Increase load to confirm it"},{"key":"C","text":"Ignore it if voltage is present"},{"key":"D","text":"Increase protective-device size"}]'::jsonb,
'["A"]'::jsonb,
'Visible overheating can indicate a serious connection or loading problem requiring correction.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 working knowledge of Electrical Troubleshooting?',
'[{"key":"A","text":"Replacing parts until the problem disappears"},{"key":"B","text":"Using symptoms, drawings, safe measurements, expected values, and documentation to narrow faults while escalating hazards and complex conditions"},{"key":"C","text":"Increasing breakers when circuits trip"},{"key":"D","text":"Ignoring intermittent faults"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 troubleshooting focuses on systematic observation and evidence gathering within the worker''s scope.');

create temporary table _seed_electrical_troubleshooting_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_troubleshooting_l4_questions (
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
'Why is hypothesis-driven troubleshooting more effective than replacing components based only on symptoms?',
'[{"key":"A","text":"It uses system behavior and evidence to test likely causes and progressively isolate the fault"},{"key":"B","text":"It avoids measurements"},{"key":"C","text":"It guarantees the first guess is correct"},{"key":"D","text":"It eliminates documentation"}]'::jsonb,
'["A"]'::jsonb,
'Advanced troubleshooting uses evidence to form and test explanations rather than relying on trial-and-error replacement.'),

(2,'multiple_choice','foundational',
'Why must a journeyman consider source, load, control, protection, grounding, and mechanical conditions together when troubleshooting?',
'[{"key":"A","text":"A symptom can result from interactions among multiple parts of the electrical system"},{"key":"B","text":"Electrical faults always occur in one isolated component"},{"key":"C","text":"Only the load can cause failures"},{"key":"D","text":"Grounding never affects troubleshooting"}]'::jsonb,
'["A"]'::jsonb,
'Complex faults often involve interactions among system components and operating conditions.'),

(3,'multiple_choice','foundational',
'Why is trend or historical information valuable in advanced troubleshooting?',
'[{"key":"A","text":"Repeated timing, load, environmental, or operational patterns can reveal conditions not visible during a single test"},{"key":"B","text":"Historical data replaces measurements"},{"key":"C","text":"Past behavior never matters"},{"key":"D","text":"Trend data affects only documentation"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent and load-dependent faults often become clearer when historical patterns are considered.'),

(4,'situational_judgment','application',
'A feeder trips only during peak production periods. What should the journeyman evaluate?',
'[{"key":"A","text":"Actual loading, load profile, protective-device behavior, conductor conditions, equipment operation, and fault possibilities during the event"},{"key":"B","text":"Only breaker age"},{"key":"C","text":"Increase breaker size immediately"},{"key":"D","text":"Ignore the timing pattern"}]'::jsonb,
'["A"]'::jsonb,
'Peak-period tripping should be evaluated under the conditions that produce the symptom.'),

(5,'multiple_select','application',
'Which THREE practices support Level 4 troubleshooting?',
'[{"key":"A","text":"Develop and rank plausible fault hypotheses"},{"key":"B","text":"Select measurements that distinguish among those hypotheses"},{"key":"C","text":"Document evidence, corrective action, and verification"},{"key":"D","text":"Replace several components at once"},{"key":"E","text":"Defeat protection to keep equipment running"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Advanced troubleshooting is structured around hypotheses, discriminating tests, and verified corrective action.'),

(6,'situational_judgment','application',
'A three-phase motor shows unequal current among phases. What should the journeyman investigate?',
'[{"key":"A","text":"Supply voltage balance, connections, conductor condition, motor winding condition, mechanical load, and upstream equipment"},{"key":"B","text":"Only the motor nameplate"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Assume imbalance is normal"}]'::jsonb,
'["A"]'::jsonb,
'Current imbalance can result from electrical supply, connection, motor, or mechanical conditions.'),

(7,'multiple_choice','application',
'Why can voltage measurements appear normal on an unloaded circuit but become abnormal under load?',
'[{"key":"A","text":"High-resistance connections or source limitations may only produce significant voltage drop when current flows"},{"key":"B","text":"Voltage drop occurs only with no load"},{"key":"C","text":"Meters create the fault"},{"key":"D","text":"Load cannot affect voltage"}]'::jsonb,
'["A"]'::jsonb,
'Some connection and source problems become visible only when the circuit carries current.'),

(8,'situational_judgment','application',
'A control circuit operates manually but fails in automatic mode. What should the journeyman focus on?',
'[{"key":"A","text":"Automatic inputs, interlocks, logic, control power, programming, wiring, and sequence of operation"},{"key":"B","text":"Only branch-circuit ampacity"},{"key":"C","text":"Only the load motor"},{"key":"D","text":"Increase service voltage"}]'::jsonb,
'["A"]'::jsonb,
'When manual operation succeeds, the fault may lie in the automatic control path or logic.'),

(9,'multiple_choice','application',
'Why should corrective action be followed by verification under realistic operating conditions?',
'[{"key":"A","text":"A repair is not proven until the original symptom is resolved without creating new problems"},{"key":"B","text":"Verification is unnecessary after parts are replaced"},{"key":"C","text":"No-load operation proves every repair"},{"key":"D","text":"Documentation alone proves success"}]'::jsonb,
'["A"]'::jsonb,
'Effective troubleshooting includes confirming that the system performs correctly after the repair.'),

(10,'situational_judgment','application',
'An intermittent fault disappears when test equipment is connected. What should the journeyman consider?',
'[{"key":"A","text":"The test setup may be altering the circuit, and a nonintrusive or alternative measurement method may be needed"},{"key":"B","text":"The fault is permanently fixed"},{"key":"C","text":"Increase the protective-device rating"},{"key":"D","text":"Stop documenting the issue"}]'::jsonb,
'["A"]'::jsonb,
'Measurement methods can sometimes influence sensitive or intermittent circuit behavior.'),

(11,'scenario','scenario',
'A motor starter drops out randomly, but supply voltage remains normal at the starter line terminals. What is the BEST next direction?',
'[{"key":"A","text":"Trace the control circuit under the failure condition, including control voltage, interlocks, overload contacts, coils, terminals, and commands"},{"key":"B","text":"Replace the motor"},{"key":"C","text":"Increase feeder breaker size"},{"key":"D","text":"Assume the utility is at fault"}]'::jsonb,
'["A"]'::jsonb,
'Normal line voltage shifts troubleshooting toward the starter control circuit and commanded operation.'),

(12,'scenario','scenario',
'A breaker trips after several minutes rather than immediately. What should the journeyman evaluate?',
'[{"key":"A","text":"Sustained or increasing load, heating, overload characteristics, equipment condition, conductor conditions, and time-current behavior"},{"key":"B","text":"Only short-circuit faults"},{"key":"C","text":"Increase breaker size immediately"},{"key":"D","text":"Ignore the time pattern"}]'::jsonb,
'["A"]'::jsonb,
'Trip timing provides important evidence about whether the condition behaves like overload, fault, or equipment heating.'),

(13,'scenario','scenario',
'A circuit has acceptable voltage at the source but excessive drop at the load only during operation. What is the BEST troubleshooting method?',
'[{"key":"A","text":"Measure voltage drop across successive connections and conductors under load to isolate excessive resistance"},{"key":"B","text":"Replace the load immediately"},{"key":"C","text":"Increase source voltage"},{"key":"D","text":"Measure only with the circuit de-energized"}]'::jsonb,
'["A"]'::jsonb,
'Loaded voltage-drop testing can isolate excessive resistance in the current path.'),

(14,'scenario','scenario',
'Equipment fails only after warming up for twenty minutes. What should the journeyman do?',
'[{"key":"A","text":"Reproduce the time-dependent condition and monitor temperatures, voltages, currents, connections, and control behavior as the fault develops"},{"key":"B","text":"Test only when cold"},{"key":"C","text":"Replace every control component"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
'["A"]'::jsonb,
'Thermal and time-dependent failures must be evaluated under the conditions that create them.'),

(15,'scenario','scenario',
'A production line has multiple unrelated symptoms after recent electrical work. What is the BEST approach?',
'[{"key":"A","text":"Review what changed, identify common sources or controls, establish a timeline, and test shared dependencies before treating every symptom separately"},{"key":"B","text":"Replace every affected load"},{"key":"C","text":"Increase the main breaker"},{"key":"D","text":"Ignore the recent-work history"}]'::jsonb,
'["A"]'::jsonb,
'Multiple symptoms after a common change may share a single upstream or control cause.'),

(16,'scenario','scenario',
'A ground fault appears only when a machine is wet from washdown. What should the journeyman investigate?',
'[{"key":"A","text":"Moisture intrusion, insulation condition, enclosures, cable entries, equipment grounding, and affected components under safe conditions"},{"key":"B","text":"Increase the ground-fault protection threshold"},{"key":"C","text":"Ignore the environmental pattern"},{"key":"D","text":"Remove grounding conductors"}]'::jsonb,
'["A"]'::jsonb,
'Environment-dependent faults often point to insulation or enclosure problems that become conductive when wet.'),

(17,'scenario','scenario',
'A panel shows normal phase-to-phase voltage but unstable phase-to-neutral voltage under changing loads. What should the journeyman investigate?',
'[{"key":"A","text":"Neutral integrity, connections, load balance, source conditions, and upstream grounded-conductor path"},{"key":"B","text":"Only branch breaker size"},{"key":"C","text":"Only grounding-electrode resistance"},{"key":"D","text":"Increase service voltage"}]'::jsonb,
'["A"]'::jsonb,
'Unstable phase-to-neutral voltage can indicate a compromised neutral or related source condition.'),

(18,'scenario','scenario',
'Repeated component replacements temporarily restore operation, but the same failure keeps returning. What is the BEST conclusion?',
'[{"key":"A","text":"The replaced component may be a symptom rather than the root cause, so upstream conditions and operating stresses must be investigated"},{"key":"B","text":"Continue replacing the component indefinitely"},{"key":"C","text":"Increase protective-device ratings"},{"key":"D","text":"Stop recording failures"}]'::jsonb,
'["A"]'::jsonb,
'Recurring failures often indicate an unresolved root cause affecting the replaced component.'),

(19,'scenario','scenario',
'A system fault cannot be reproduced during scheduled downtime but appears under production load. What should the journeyman do?',
'[{"key":"A","text":"Plan safe monitoring or data collection under the actual operating conditions that produce the fault"},{"key":"B","text":"Declare the system normal"},{"key":"C","text":"Replace random components during downtime"},{"key":"D","text":"Increase circuit ratings"}]'::jsonb,
'["A"]'::jsonb,
'Intermittent production-dependent faults often require evidence gathered under representative operating conditions.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 4 proficiency in Electrical Troubleshooting?',
'[{"key":"A","text":"Replacing components based only on the first symptom"},{"key":"B","text":"Independently using system theory, historical patterns, drawings, targeted measurements, fault hypotheses, safe testing, root-cause analysis, and post-repair verification to resolve complex electrical problems"},{"key":"C","text":"Defeating protective devices to keep equipment running"},{"key":"D","text":"Treating every repeated failure as an isolated bad part"}]'::jsonb,
'["B"]'::jsonb,
'Level 4 troubleshooting means leading systematic diagnosis of complex, intermittent, and interacting electrical faults through evidence and verified root-cause correction.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'ac62d968-9c26-4374-aca9-5aa451edfe9c';
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
      and c.name = 'Electrical Troubleshooting'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Troubleshooting Master Competency not found';
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
  v_assessment_name := 'Electrical Troubleshooting — Level 1 Competency Assessment';

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
    select * from _seed_electrical_troubleshooting_l1_questions
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
        'Electrical Troubleshooting',
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
      'IntegrateU Electrical Troubleshooting L1 production assessment v1.0.',
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
        'Electrical Troubleshooting',
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
        'IntegrateU Electrical Troubleshooting L1 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Troubleshooting — Level 4 Competency Assessment';

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
    select * from _seed_electrical_troubleshooting_l4_questions
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
        'Electrical Troubleshooting',
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
      'IntegrateU Electrical Troubleshooting L4 production assessment v1.0.',
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
        'Electrical Troubleshooting',
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
        'IntegrateU Electrical Troubleshooting L4 production assessment v1.0.',
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
   'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid
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
      'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid
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
  'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid;

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
    'ac62d968-9c26-4374-aca9-5aa451edfe9c'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
