-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0092_electrical_testing_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Testing & Measurement
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

create temporary table _seed_electrical_testing_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_testing_l2_questions (
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
'What is the primary purpose of a digital multimeter when troubleshooting an electrical circuit?',
'[{"key":"A","text":"To physically disconnect conductors"},{"key":"B","text":"To measure electrical quantities such as voltage, resistance, and current when the meter is properly configured"},{"key":"C","text":"To replace overcurrent protection"},{"key":"D","text":"To identify conductor size visually"}]'::jsonb,
'["B"]'::jsonb,
'A properly selected and configured multimeter can measure electrical quantities that help verify circuit conditions.'),

(2,'multiple_choice','foundational',
'How is voltage normally measured across a component?',
'[{"key":"A","text":"Across the two points of interest"},{"key":"B","text":"By placing the meter in series with the load"},{"key":"C","text":"By disconnecting every load from the circuit"},{"key":"D","text":"By measuring resistance while energized"}]'::jsonb,
'["A"]'::jsonb,
'Voltage is a potential difference between two points, so the measurement is made across those points.'),

(3,'multiple_choice','foundational',
'Before using test leads, what should a worker do?',
'[{"key":"A","text":"Assume they are safe if they worked yesterday"},{"key":"B","text":"Inspect the leads, probes, insulation, and meter for damage or defects"},{"key":"C","text":"Remove probe guards for easier contact"},{"key":"D","text":"Short the probes together on an energized source"}]'::jsonb,
'["B"]'::jsonb,
'Test equipment should be inspected before use so damaged leads, insulation, or equipment are not placed into service.'),

(4,'multiple_choice','foundational',
'When measuring resistance or continuity, what circuit condition is generally required?',
'[{"key":"A","text":"The circuit should be energized at full operating voltage"},{"key":"B","text":"The circuit should be placed in the safe condition required by the applicable procedure before resistance or continuity testing"},{"key":"C","text":"The meter should be set to AC current"},{"key":"D","text":"The load should be running"}]'::jsonb,
'["B"]'::jsonb,
'Resistance and continuity measurements are generally performed only after the circuit is placed in the required safe condition.'),

(5,'multiple_choice','foundational',
'Why must a meter and its leads be appropriately rated for the electrical environment?',
'[{"key":"A","text":"Only to improve display brightness"},{"key":"B","text":"Because test equipment must be suitable for the voltage and transient conditions it may encounter"},{"key":"C","text":"Because higher ratings always produce higher readings"},{"key":"D","text":"Because ratings determine conductor color"}]'::jsonb,
'["B"]'::jsonb,
'Electrical test equipment must be suitable for the measurement environment and possible electrical stresses.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'You expect approximately 120 volts AC at a receptacle. Which meter setup is MOST appropriate?',
'[{"key":"A","text":"A suitable meter configured for AC voltage with leads in the correct input terminals"},{"key":"B","text":"Resistance mode with the circuit energized"},{"key":"C","text":"DC current mode with both probes across the source"},{"key":"D","text":"Continuity mode because it provides the fastest result"}]'::jsonb,
'["A"]'::jsonb,
'The meter function, input terminals, and rating must match the quantity and environment being measured.'),

(7,'multiple_choice','application',
'A meter displays approximately 0 volts across a closed switch that is carrying current normally. What does that reading usually indicate?',
'[{"key":"A","text":"A large voltage drop across the switch"},{"key":"B","text":"A low-resistance conducting path through the closed switch"},{"key":"C","text":"An open switch"},{"key":"D","text":"A failed voltage source"}]'::jsonb,
'["B"]'::jsonb,
'A properly closed switch normally has very little voltage drop across it.'),

(8,'situational_judgment','application',
'You need to determine whether a conductor is carrying load current without opening the circuit. Which tool is generally best suited to that task when properly rated and used?',
'[{"key":"A","text":"A clamp meter"},{"key":"B","text":"A continuity tester"},{"key":"C","text":"A tape measure"},{"key":"D","text":"An insulation stripper"}]'::jsonb,
'["A"]'::jsonb,
'A clamp meter can measure current around an individual conductor without inserting the meter directly into the current path.'),

(9,'multiple_select','application',
'Which THREE actions belong in good electrical measurement practice?',
'[{"key":"A","text":"Select the correct measurement function"},{"key":"B","text":"Use test equipment with suitable ratings"},{"key":"C","text":"Inspect the meter and leads before use"},{"key":"D","text":"Change meter functions randomly until a useful reading appears"},{"key":"E","text":"Assume every circuit is deenergized when a disconnect is open"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Correct function selection, suitable ratings, and equipment inspection are fundamental measurement practices.'),

(10,'situational_judgment','application',
'A circuit is expected to be deenergized before work begins. What should the worker rely on to establish the electrical condition?',
'[{"key":"A","text":"The OFF position of a switch alone"},{"key":"B","text":"The required energy-control and absence-of-voltage verification procedure using suitable test equipment"},{"key":"C","text":"The absence of equipment noise"},{"key":"D","text":"A handwritten panel label alone"}]'::jsonb,
'["B"]'::jsonb,
'The electrical condition should be established through the required isolation and verification process rather than assumptions or labels alone.'),

(11,'multiple_choice','application',
'A 120-volt source measures correctly at the supply, but you measure nearly 0 volts across a load that should be energized. What is a reasonable next troubleshooting question?',
'[{"key":"A","text":"Is the load actually connected to both required circuit points?"},{"key":"B","text":"Should the meter be placed in resistance mode while energized?"},{"key":"C","text":"Should the overcurrent device be bypassed?"},{"key":"D","text":"Should a larger fuse be installed?"}]'::jsonb,
'["A"]'::jsonb,
'Comparing expected and measured voltage helps determine whether the intended circuit path is actually reaching the load.'),

(12,'situational_judgment','application',
'You receive a negative DC voltage reading when you expected a positive value. What is the MOST likely basic explanation?',
'[{"key":"A","text":"The test leads may be reversed relative to the expected polarity"},{"key":"B","text":"The meter has converted DC to AC"},{"key":"C","text":"Resistance has become zero"},{"key":"D","text":"The conductor size is too small"}]'::jsonb,
'["A"]'::jsonb,
'A negative DC indication commonly means the measurement polarity is opposite the assumed polarity.'),

(13,'multiple_choice','application',
'What is the benefit of recording expected values along with actual measured values during troubleshooting?',
'[{"key":"A","text":"It makes measurements unnecessary"},{"key":"B","text":"It makes deviations easier to identify and communicate"},{"key":"C","text":"It guarantees the equipment is safe"},{"key":"D","text":"It eliminates the need to identify test points"}]'::jsonb,
'["B"]'::jsonb,
'Comparing expected and actual values helps turn measurements into useful diagnostic evidence.'),

(14,'situational_judgment','application',
'You are not certain whether the source is AC or DC. What is the BEST action?',
'[{"key":"A","text":"Guess based on wire color"},{"key":"B","text":"Use documentation and an appropriate safe testing method to establish the source type before relying on a reading"},{"key":"C","text":"Use resistance mode first"},{"key":"D","text":"Connect the meter to the highest-current input and test across the source"}]'::jsonb,
'["B"]'::jsonb,
'The measurement method and meter configuration should be based on a verified understanding of the electrical source.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'A load does not operate. You measure correct source voltage at the supply but no voltage at the load input. What does the measurement pattern MOST strongly suggest?',
'[{"key":"A","text":"A problem somewhere in the circuit path between the source and the load"},{"key":"B","text":"The load is definitely shorted"},{"key":"C","text":"The source voltage is too high"},{"key":"D","text":"The meter must be defective"}]'::jsonb,
'["A"]'::jsonb,
'Correct voltage at the source but missing voltage at the load points toward an interruption or connection problem between those locations.'),

(16,'scenario','scenario',
'A circuit is operating, but a connection is overheating. You measure an unusually large voltage drop across that connection. What does the reading suggest?',
'[{"key":"A","text":"The connection may have excessive resistance"},{"key":"B","text":"The connection has zero resistance"},{"key":"C","text":"No current is flowing"},{"key":"D","text":"The source frequency is necessarily incorrect"}]'::jsonb,
'["A"]'::jsonb,
'An abnormal voltage drop across a current-carrying connection can indicate excessive resistance at that point.'),

(17,'situational_judgment','scenario',
'A meter gives a reading that conflicts with the circuit diagram and expected behavior. What should you do NEXT?',
'[{"key":"A","text":"Assume the diagram is correct and ignore the reading"},{"key":"B","text":"Verify meter setup, test equipment condition, test points, and actual field circuit conditions before drawing a conclusion"},{"key":"C","text":"Replace the load immediately"},{"key":"D","text":"Increase the overcurrent device rating"}]'::jsonb,
'["B"]'::jsonb,
'Unexpected measurements should trigger verification of both the measurement process and actual field conditions.'),

(18,'scenario','scenario',
'You are checking an energized circuit and the meter reading changes dramatically when the probe is moved slightly. What is the BEST response?',
'[{"key":"A","text":"Average the readings mentally and continue"},{"key":"B","text":"Stop and verify the test connection, probe contact, equipment condition, and safe test method before relying on the measurement"},{"key":"C","text":"Switch to resistance mode"},{"key":"D","text":"Hold the probe more forcefully regardless of access"}]'::jsonb,
'["B"]'::jsonb,
'An unstable reading can result from poor contact, incorrect setup, equipment issues, or changing circuit conditions and should be investigated safely.'),

(19,'scenario','scenario',
'A clamp meter is placed around both the outgoing and returning conductors of the same normal load circuit. The reading is near zero. Why?',
'[{"key":"A","text":"The meter cannot measure AC current"},{"key":"B","text":"The opposing magnetic fields from equal outgoing and returning current largely cancel"},{"key":"C","text":"The circuit has no voltage"},{"key":"D","text":"The load resistance is infinite"}]'::jsonb,
'["B"]'::jsonb,
'For normal load-current measurement, a clamp meter is placed around an individual conductor because equal opposite currents together largely cancel magnetically.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Electrical Testing & Measurement?',
'[{"key":"A","text":"Taking readings without first identifying the measurement needed"},{"key":"B","text":"Selecting suitable test equipment, configuring it correctly, obtaining routine measurements, and comparing them with expected circuit values"},{"key":"C","text":"Performing advanced diagnostic work without documentation"},{"key":"D","text":"Using one meter setting for every measurement"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably performing routine measurements and using expected values to interpret basic electrical conditions.');

create temporary table _seed_electrical_testing_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_testing_l3_questions (
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
'Why is it useful to compare measurements at multiple points in a circuit rather than relying on one reading?',
'[{"key":"A","text":"It helps localize where actual circuit behavior stops matching expected behavior"},{"key":"B","text":"It guarantees the first meter reading was wrong"},{"key":"C","text":"It removes the need for circuit documentation"},{"key":"D","text":"It eliminates electrical hazards"}]'::jsonb,
'["A"]'::jsonb,
'Strategic measurements at multiple points can narrow the location of an open, excessive resistance, incorrect source, or other abnormal condition.'),

(2,'multiple_choice','foundational',
'What does an abnormal voltage drop across a current-carrying connection generally indicate?',
'[{"key":"A","text":"Possible excessive resistance at the connection"},{"key":"B","text":"Guaranteed zero resistance"},{"key":"C","text":"No source voltage"},{"key":"D","text":"Normal operation in every circuit"}]'::jsonb,
'["A"]'::jsonb,
'Excess resistance in a current path produces additional voltage drop and can cause heating.'),

(3,'multiple_choice','foundational',
'Why should a technician understand the meter input terminals before changing from voltage measurement to direct current measurement?',
'[{"key":"A","text":"Different functions may require different meter connections, and incorrect setup can create a hazardous condition"},{"key":"B","text":"The terminals only affect display color"},{"key":"C","text":"Current and voltage are always measured identically"},{"key":"D","text":"Input terminals matter only for resistance"}]'::jsonb,
'["A"]'::jsonb,
'Incorrect meter lead placement or function selection can expose the meter and worker to unintended current paths.'),

(4,'multiple_choice','foundational',
'What makes a measurement diagnostically useful?',
'[{"key":"A","text":"It is taken at a test point chosen to distinguish between plausible circuit conditions"},{"key":"B","text":"It produces the largest number"},{"key":"C","text":"It is repeated without changing the test point"},{"key":"D","text":"It is taken before reviewing expected circuit behavior"}]'::jsonb,
'["A"]'::jsonb,
'A good diagnostic measurement is chosen because different possible faults would produce meaningfully different expected readings.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A 120-volt load is not operating. You measure 120 volts from the source conductor to neutral at the panel and 120 volts at the load input, but the load still does not operate. What should you investigate NEXT?',
'[{"key":"A","text":"The load itself and its return path or connections"},{"key":"B","text":"Whether the utility voltage is 480 volts"},{"key":"C","text":"Whether the breaker should be replaced with a larger one"},{"key":"D","text":"Whether all meter readings should be ignored"}]'::jsonb,
'["A"]'::jsonb,
'If expected supply voltage reaches the load, the next diagnostic focus shifts toward the load, return path, and associated connections.'),

(6,'multiple_select','application',
'Which THREE pieces of information strengthen a troubleshooting record?',
'[{"key":"A","text":"The test point or circuit location"},{"key":"B","text":"The measurement obtained"},{"key":"C","text":"The expected value or condition used for comparison"},{"key":"D","text":"An unsupported guess about the failed component"},{"key":"E","text":"Only the technician name"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Useful documentation connects a measurement to its test point and expected circuit behavior.'),

(7,'situational_judgment','application',
'A motor circuit is drawing substantially more current than its normal documented operating value. What is the BEST interpretation?',
'[{"key":"A","text":"The higher current is diagnostic evidence that should be investigated with the circuit and load conditions"},{"key":"B","text":"The reading proves the motor is healthy"},{"key":"C","text":"Current measurements cannot help troubleshoot loads"},{"key":"D","text":"The overcurrent device should automatically be upsized"}]'::jsonb,
'["A"]'::jsonb,
'Current significantly different from an established normal value is useful diagnostic evidence and should lead to further investigation.'),

(8,'multiple_choice','application',
'You measure nearly full source voltage across a device that is supposed to be closed and conducting. What condition is MOST consistent with that reading?',
'[{"key":"A","text":"The device may be open or have very high resistance"},{"key":"B","text":"The device has an ideal zero-resistance connection"},{"key":"C","text":"No source voltage is present"},{"key":"D","text":"The meter is measuring current"}]'::jsonb,
'["A"]'::jsonb,
'A large voltage drop across a device expected to conduct can indicate an open or excessive-resistance condition.'),

(9,'situational_judgment','application',
'A technician obtains a plausible voltage reading but realizes the test lead is inserted into the meter current terminal. What should happen?',
'[{"key":"A","text":"Continue because the displayed number looks correct"},{"key":"B","text":"Stop and correct the meter setup before taking or relying on further measurements"},{"key":"C","text":"Change only the display range"},{"key":"D","text":"Short the probes together to verify the meter"}]'::jsonb,
'["B"]'::jsonb,
'Meter lead placement must match the selected measurement function; incorrect setup can create dangerous unintended current paths.'),

(10,'situational_judgment','application',
'A circuit shows correct voltage with no load connected, but voltage drops severely when the load operates. What should the technician suspect?',
'[{"key":"A","text":"A high-resistance connection, weak source, or other condition that becomes apparent under load"},{"key":"B","text":"The meter automatically lowers circuit voltage"},{"key":"C","text":"The load has no current"},{"key":"D","text":"The unloaded voltage reading proves the circuit is perfect"}]'::jsonb,
'["A"]'::jsonb,
'Some faults become visible only under load because current creates a measurable voltage drop across unwanted resistance.'),

(11,'multiple_choice','application',
'Why can measuring only continuity be insufficient when evaluating a suspected poor connection?',
'[{"key":"A","text":"A connection may show continuity with very little test current yet develop excessive voltage drop under operating load"},{"key":"B","text":"Continuity always measures operating current"},{"key":"C","text":"Continuity testing measures power factor"},{"key":"D","text":"Continuity testing automatically energizes the load"}]'::jsonb,
'["A"]'::jsonb,
'A marginal connection can pass a low-energy continuity test while still failing under actual load current.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'An energized load intermittently stops operating. During the failure you measure full source voltage on the line side of a switch and full source voltage across the switch itself. What is the BEST interpretation?',
'[{"key":"A","text":"The switch or its connection may be open or excessively resistive during the failure"},{"key":"B","text":"The switch is definitely closed normally"},{"key":"C","text":"The source is deenergized"},{"key":"D","text":"No current path problem exists"}]'::jsonb,
'["A"]'::jsonb,
'Full source voltage across a device that should be conducting points toward an open or high-resistance condition at that device or connection.'),

(13,'situational_judgment','scenario',
'A circuit has correct voltage from line to ground but an unexpected reading from line to neutral. What is the BEST next diagnostic approach?',
'[{"key":"A","text":"Investigate the neutral/return path and compare measurements at logical points rather than assuming the source conductor is the problem"},{"key":"B","text":"Replace the breaker immediately"},{"key":"C","text":"Ignore the neutral measurement"},{"key":"D","text":"Increase the circuit voltage"}]'::jsonb,
'["A"]'::jsonb,
'Comparing line-to-ground and line-to-neutral measurements can help isolate problems involving the return or neutral path.'),

(14,'scenario','scenario',
'A branch circuit works normally until a high-load device starts, then several downstream loads experience low voltage. What measurement strategy is MOST useful?',
'[{"key":"A","text":"Measure voltage under load at successive points in the supply path to identify where excessive drop occurs"},{"key":"B","text":"Measure conductor color at each junction"},{"key":"C","text":"Test resistance while the circuit remains energized"},{"key":"D","text":"Replace every downstream device"}]'::jsonb,
'["A"]'::jsonb,
'Loaded voltage measurements at successive points can localize unwanted resistance or a weak connection in the supply path.'),

(15,'situational_judgment','scenario',
'During absence-of-voltage verification, the tester does not respond at the circuit. The worker is unsure whether the circuit is truly deenergized or the tester has failed. What should happen?',
'[{"key":"A","text":"Treat the circuit as safe because the tester showed zero"},{"key":"B","text":"Follow the required verification process for confirming the tester operates correctly before relying on the result"},{"key":"C","text":"Touch the conductor with an insulated tool"},{"key":"D","text":"Proceed if the disconnect is open"}]'::jsonb,
'["B"]'::jsonb,
'A zero indication is meaningful only when the test instrument itself has been verified according to the required procedure.'),

(16,'scenario','scenario',
'A current measurement is much lower than expected, but voltage at the load is normal. Which possibility is MOST consistent with those measurements?',
'[{"key":"A","text":"The load may have higher effective impedance or may not be operating at its expected load condition"},{"key":"B","text":"The source voltage must be zero"},{"key":"C","text":"The circuit must be a dead short"},{"key":"D","text":"Current cannot vary when voltage is correct"}]'::jsonb,
'["A"]'::jsonb,
'Normal voltage with unexpectedly low current points toward the load condition or effective impedance rather than loss of source voltage.'),

(17,'scenario','scenario',
'A technician gets inconsistent voltage readings from the same circuit using two different meters. What is the BEST response?',
'[{"key":"A","text":"Choose the higher reading"},{"key":"B","text":"Verify meter ratings, setup, leads, test method, reference points, and known-source operation before deciding which reading reflects the circuit"},{"key":"C","text":"Average the two readings"},{"key":"D","text":"Assume the circuit changes whenever a meter is connected"}]'::jsonb,
'["B"]'::jsonb,
'Conflicting measurements require verification of the instruments and test method before conclusions are drawn.'),

(18,'scenario','scenario',
'A control device has the expected supply voltage and appears to send the expected output voltage when commanded, but the downstream device does not respond. What is the BEST next step?',
'[{"key":"A","text":"Continue tracing the expected signal or power through the downstream circuit and return path using planned measurements"},{"key":"B","text":"Replace the control device immediately"},{"key":"C","text":"Increase the supply voltage"},{"key":"D","text":"Stop using measurements because two readings were normal"}]'::jsonb,
'["A"]'::jsonb,
'Once expected input and output conditions are confirmed, the troubleshooting boundary moves downstream to the next logical points.'),

(19,'scenario','scenario',
'A connection shows only a small resistance value when deenergized, but under normal load it develops a significant voltage drop and heat. Which evidence should carry more diagnostic weight?',
'[{"key":"A","text":"The loaded voltage-drop and heating evidence because it demonstrates behavior under actual operating current"},{"key":"B","text":"Only the low resistance reading"},{"key":"C","text":"Neither measurement"},{"key":"D","text":"The conductor color"}]'::jsonb,
'["A"]'::jsonb,
'Loaded measurements can expose resistance problems that are not obvious from a low-energy resistance or continuity test.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Electrical Testing & Measurement?',
'[{"key":"A","text":"Taking isolated readings without predicting expected results"},{"key":"B","text":"Independently selecting safe and appropriate tests, predicting expected values, comparing measurements, narrowing likely faults, and documenting the evidence"},{"key":"C","text":"Replacing components until the problem disappears"},{"key":"D","text":"Using resistance testing on energized circuits"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently using planned measurements and expected circuit behavior to diagnose routine electrical conditions and communicate evidence.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'a4e8adcb-107f-4280-a770-2f80966f0b1b';
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
      and c.name = 'Electrical Testing & Measurement'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Testing & Measurement Master Competency not found';
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
  v_assessment_name := 'Electrical Testing & Measurement — Level 2 Competency Assessment';

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
    select * from _seed_electrical_testing_l2_questions
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
        'Electrical Testing & Measurement',
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
      'IntegrateU Electrical Testing & Measurement L2 production assessment v1.0.',
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
        'Electrical Testing & Measurement',
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
        'IntegrateU Electrical Testing & Measurement L2 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Testing & Measurement — Level 3 Competency Assessment';

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
    select * from _seed_electrical_testing_l3_questions
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
        'Electrical Testing & Measurement',
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
      'IntegrateU Electrical Testing & Measurement L3 production assessment v1.0.',
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
        'Electrical Testing & Measurement',
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
        'IntegrateU Electrical Testing & Measurement L3 production assessment v1.0.',
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
   'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
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
      'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
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
  'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid;

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
    'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
