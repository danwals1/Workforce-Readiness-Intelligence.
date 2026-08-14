-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0090_electrical_safety_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Safety & Job-Site Standards
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

create temporary table _seed_electrical_safety_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_safety_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Before beginning work where an electrical circuit could expose a worker to shock, what is the preferred safety approach?',
  '[{"key":"A","text":"Work energized if the task will take only a few minutes"},{"key":"B","text":"Deenergize the circuit when feasible and apply the required energy-control procedure before work begins"},{"key":"C","text":"Rely on insulated hand tools instead of deenergizing"},{"key":"D","text":"Ask another worker to watch the circuit while the work is performed"}]'::jsonb,
  '["B"]'::jsonb,
  'Deenergizing and controlling hazardous electrical energy is the preferred approach when exposure to live parts could occur.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'A circuit has been switched off at a breaker. What should a qualified worker do before treating exposed conductors as deenergized?',
  '[{"key":"A","text":"Begin work because the breaker handle is in the OFF position"},{"key":"B","text":"Verify the absence of voltage using an appropriate test instrument and the employer''s established procedure"},{"key":"C","text":"Touch the conductor with an insulated tool"},{"key":"D","text":"Wait several minutes and assume stored electrical energy has dissipated"}]'::jsonb,
  '["B"]'::jsonb,
  'A switch or breaker position alone does not prove that conductors are deenergized; absence of voltage must be verified using the required procedure.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of a ground-fault circuit interrupter (GFCI) on temporary construction power?',
  '[{"key":"A","text":"To increase the amount of current a tool can draw"},{"key":"B","text":"To provide personnel protection by quickly interrupting a circuit when an unintended ground-fault current is detected"},{"key":"C","text":"To replace the equipment grounding conductor on every circuit"},{"key":"D","text":"To prevent every possible electrical fire"}]'::jsonb,
  '["B"]'::jsonb,
  'GFCIs are used for personnel protection against ground-fault shock hazards on applicable construction-site receptacles and temporary power.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'You notice a flexible cord with damaged outer insulation and exposed internal conductors. What is the correct action?',
  '[{"key":"A","text":"Wrap the damaged area with ordinary tape and keep using the cord"},{"key":"B","text":"Remove the cord from service and follow the employer''s process for repair, replacement, or disposal"},{"key":"C","text":"Use it only for low-power tools"},{"key":"D","text":"Use it only when the floor is dry"}]'::jsonb,
  '["B"]'::jsonb,
  'Damaged cords can expose workers to shock and fire hazards and should be removed from service rather than improvised back into use.'
),

(
  5,
  'situational_judgment',
  'application',
  'You are assigned to work on a circuit that has been deenergized and tagged. Another worker says the tag is enough and wants to start immediately. What is the BEST response?',
  '[{"key":"A","text":"Start work because a tag proves the circuit is safe"},{"key":"B","text":"Confirm the required energy-control steps have been completed and verify the circuit is in the expected deenergized condition before work"},{"key":"C","text":"Remove the tag so no one becomes confused"},{"key":"D","text":"Turn the breaker on briefly to see whether the equipment runs"}]'::jsonb,
  '["B"]'::jsonb,
  'A tag is part of an energy-control process; workers still need to follow the required isolation and verification procedure before exposure.'
),

(
  6,
  'multiple_select',
  'application',
  'Which THREE conditions should prompt an electrician to stop and reassess the electrical safety plan before continuing?',
  '[{"key":"A","text":"The identified circuit does not match the field labeling"},{"key":"B","text":"Unexpected voltage is detected where the circuit was expected to be deenergized"},{"key":"C","text":"The work area or equipment condition has changed from what was covered in the job briefing"},{"key":"D","text":"The task is taking longer than the estimate"},{"key":"E","text":"The worker has already brought tools to the area"}]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Unexpected circuit identity, unexpected voltage, or changed conditions can invalidate the original hazard assessment and require reassessment.'
),

(
  7,
  'situational_judgment',
  'application',
  'A portable tool is being used from temporary power on a construction site. The receptacle protection is unknown. What is the BEST action?',
  '[{"key":"A","text":"Use the tool because temporary power is always protected upstream"},{"key":"B","text":"Confirm the required GFCI or approved assured-equipment-grounding protection is in place before use"},{"key":"C","text":"Use a longer extension cord to reduce the hazard"},{"key":"D","text":"Wear leather gloves and proceed"}]'::jsonb,
  '["B"]'::jsonb,
  'Construction-site temporary power requires the applicable ground-fault or assured equipment grounding protection; workers should verify the required protection rather than assume it exists.'
),

(
  8,
  'situational_judgment',
  'application',
  'You need to use a meter on equipment that may be energized. What is the BEST preparation?',
  '[{"key":"A","text":"Use whichever meter is closest as long as it displays voltage"},{"key":"B","text":"Select an appropriately rated instrument and leads, inspect them for damage, and use the employer''s required safe-work procedure and PPE"},{"key":"C","text":"Hold both probes in one hand so the reading is faster"},{"key":"D","text":"Remove protective probe guards because they make contact easier"}]'::jsonb,
  '["B"]'::jsonb,
  'Electrical test instruments and leads must be suitable for the task and environment, in safe condition, and used with required work practices and PPE.'
),

(
  9,
  'multiple_choice',
  'application',
  'Why should an electrical worker identify possible alternate energy sources or backfeed before relying on a disconnect?',
  '[{"key":"A","text":"Backfeed only affects equipment operation, not worker safety"},{"key":"B","text":"Another source can keep conductors energized even after the expected source is opened"},{"key":"C","text":"Backfeed is only possible on battery-powered equipment"},{"key":"D","text":"It matters only after the work is complete"}]'::jsonb,
  '["B"]'::jsonb,
  'Multiple sources, stored energy, generators, control power, or backfeed can leave a circuit hazardous even when the expected disconnect is open.'
),

(
  10,
  'situational_judgment',
  'application',
  'A ladder setup would place you and your tools close to exposed energized conductors. What should you do?',
  '[{"key":"A","text":"Proceed if the ladder is fiberglass"},{"key":"B","text":"Replan the work so the electrical hazard is eliminated, deenergized, guarded, or otherwise controlled before exposure"},{"key":"C","text":"Ask a coworker to hold the ladder"},{"key":"D","text":"Work faster to reduce exposure time"}]'::jsonb,
  '["B"]'::jsonb,
  'A ladder material alone does not eliminate the hazard; the work must be planned to prevent unsafe proximity to energized parts.'
),

(
  11,
  'situational_judgment',
  'application',
  'Water has entered an area where extension cords and portable electrical tools are being used. What is the BEST response?',
  '[{"key":"A","text":"Continue if the cords are elevated a few inches"},{"key":"B","text":"Stop and reassess the area, remove or control the electrical exposure, and use equipment and protection suitable for the conditions"},{"key":"C","text":"Dry your gloves and continue"},{"key":"D","text":"Move the cords to the edge of the puddle"}]'::jsonb,
  '["B"]'::jsonb,
  'Wet conditions can increase electrical risk and require the work area, equipment, and protective measures to be reassessed before work continues.'
),

(
  12,
  'scenario',
  'scenario',
  'You open a panel identified for the task, but the circuit directory appears inaccurate and several conductors are unlabeled. The work order says the circuit should already be off. What is the BEST next step?',
  '[{"key":"A","text":"Trace the conductor by touching it with an insulated screwdriver"},{"key":"B","text":"Stop, identify the actual circuit and sources using an approved method, and complete the required isolation and verification before work"},{"key":"C","text":"Choose the breaker most likely to feed the circuit and begin"},{"key":"D","text":"Continue because the work order says the circuit is off"}]'::jsonb,
  '["B"]'::jsonb,
  'Unreliable labeling creates uncertainty about circuit identity and energy sources; the worker must establish the actual condition before exposure.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'A coworker receives a shock and is still in contact with an energized conductor. What is the BEST immediate priority?',
  '[{"key":"A","text":"Grab the coworker and pull them away"},{"key":"B","text":"Avoid becoming a second victim, have the energy source safely disconnected if possible, and activate the site''s emergency response process"},{"key":"C","text":"Throw water on the conductor"},{"key":"D","text":"Wait to see whether the coworker can release the conductor alone"}]'::jsonb,
  '["B"]'::jsonb,
  'Direct contact with a person who is still energized can create a second victim; safe isolation and emergency response take priority.'
),

(
  14,
  'scenario',
  'scenario',
  'You are preparing to verify absence of voltage after disconnecting and applying the required energy controls. Which approach BEST demonstrates a reliable test?',
  '[{"key":"A","text":"Check the circuit once and put the meter away"},{"key":"B","text":"Use an appropriately rated tester and follow the required process for confirming the tester operates and verifying the circuit condition"},{"key":"C","text":"Use a noncontact tester as the only method regardless of the employer procedure"},{"key":"D","text":"Assume zero voltage if equipment indicator lights are off"}]'::jsonb,
  '["B"]'::jsonb,
  'Reliable verification uses suitable test equipment and the employer''s established process for proving the instrument and confirming the circuit condition.'
),

(
  15,
  'scenario',
  'scenario',
  'An extension cord has a missing grounding pin, but the connected tool is double-insulated. A worker wants to keep using the cord for other tools too. What is the BEST response?',
  '[{"key":"A","text":"Keep using the cord because one tool is double-insulated"},{"key":"B","text":"Remove the damaged cord from service; do not rely on the connected tool''s construction to make a defective cord acceptable"},{"key":"C","text":"Use the cord only indoors"},{"key":"D","text":"Mark the cord ''double-insulated tools only'' and continue"}]'::jsonb,
  '["B"]'::jsonb,
  'A defective cord should be removed from service; the characteristics of one connected tool do not repair or validate a damaged cord set.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A supervisor asks you to move a metal scaffold beneath overhead electrical conductors without confirming clearance or whether the lines are energized. What should you do?',
  '[{"key":"A","text":"Move it if someone watches the top of the scaffold"},{"key":"B","text":"Stop and have the overhead-line hazard identified and controlled before moving the scaffold"},{"key":"C","text":"Wear rubber-soled shoes and proceed"},{"key":"D","text":"Move the scaffold only during daylight"}]'::jsonb,
  '["B"]'::jsonb,
  'Before work may bring people, tools, or equipment into contact with electrical conductors, the hazard must be identified and controlled.'
),

(
  17,
  'scenario',
  'scenario',
  'During a job briefing, the task is described as fully deenergized. At the equipment, you discover a control transformer and a separate source not mentioned in the briefing. What is the BEST action?',
  '[{"key":"A","text":"Ignore the smaller source because the main feeder is off"},{"key":"B","text":"Stop and update the energy-control and job-safety plan to address all sources before continuing"},{"key":"C","text":"Disconnect the small wires without testing them"},{"key":"D","text":"Continue as long as the equipment is not operating"}]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected additional sources invalidate the original isolation assumptions and must be incorporated into the energy-control plan.'
),

(
  18,
  'scenario',
  'scenario',
  'A worker has the correct PPE for a planned electrical task, but the equipment condition appears damaged and there are signs of overheating. What is the BEST decision?',
  '[{"key":"A","text":"Proceed because PPE makes the task safe"},{"key":"B","text":"Stop and reassess the equipment condition and work method before proceeding"},{"key":"C","text":"Add a second pair of gloves and continue"},{"key":"D","text":"Stand farther away and complete the task"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE is one layer of protection; abnormal equipment conditions may change the hazard and require a new assessment or different work method.'
),

(
  19,
  'situational_judgment',
  'scenario',
  'A breaker trips repeatedly while powering temporary job-site equipment. What is the BEST response?',
  '[{"key":"A","text":"Reset the breaker repeatedly until it holds"},{"key":"B","text":"Stop using the affected circuit or equipment and have the cause evaluated before returning it to service"},{"key":"C","text":"Replace the breaker with a higher-rated one"},{"key":"D","text":"Move the equipment to a power strip on the same circuit"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated tripping can indicate an overload, fault, or equipment problem; defeating or repeatedly resetting protection without finding the cause is unsafe.'
),

(
  20,
  'multiple_choice',
  'scenario',
  'Which behavior BEST demonstrates Level 3 proficiency in electrical job-site safety?',
  '[{"key":"A","text":"Following a checklist only when a supervisor is present"},{"key":"B","text":"Independently recognizing hazards, applying the required controls, verifying safe conditions, and stopping when conditions no longer match the plan"},{"key":"C","text":"Completing work quickly even when conditions change"},{"key":"D","text":"Relying on PPE instead of eliminating or controlling electrical hazards"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance means independently applying safe-work practices, verifying conditions, and stopping or escalating when the planned controls are no longer adequate.'
);


create temporary table _seed_electrical_safety_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_safety_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'When planning electrical work, which principle should guide the choice of work method?',
  '[{"key":"A","text":"Choose energized work whenever shutdown would inconvenience operations"},{"key":"B","text":"Establish an electrically safe condition when feasible and use energized work only when the applicable requirements and justification are satisfied"},{"key":"C","text":"Choose the method requiring the least documentation"},{"key":"D","text":"Let the most experienced worker decide without a documented hazard assessment"}]'::jsonb,
  '["B"]'::jsonb,
  'The safer planning hierarchy is to eliminate electrical exposure through deenergization when feasible; energized work requires specific justification, controls, and qualified personnel.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an electrical job briefing before a higher-risk task?',
  '[{"key":"A","text":"To assign blame in case something goes wrong"},{"key":"B","text":"To align the team on the task, hazards, energy sources, controls, roles, and changes that would require stopping or reassessing"},{"key":"C","text":"To replace the employer''s written procedures"},{"key":"D","text":"To document only the expected completion time"}]'::jsonb,
  '["B"]'::jsonb,
  'A useful briefing creates shared understanding of hazards, controls, responsibilities, and stop/reassessment triggers before work begins.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why should a lead electrician treat field labels and one-line drawings as inputs to verification rather than absolute proof of circuit condition?',
  '[{"key":"A","text":"Documentation is never useful for electrical work"},{"key":"B","text":"Field conditions can change, labels can be wrong or outdated, and the actual energy state still must be established using the required procedure"},{"key":"C","text":"Only apprentices need to verify circuit identity"},{"key":"D","text":"Verification is unnecessary when drawings have an engineer''s stamp"}]'::jsonb,
  '["B"]'::jsonb,
  'Documentation helps plan the task, but safe work depends on establishing the actual circuit identity and energy condition in the field.'
),

(
  4,
  'situational_judgment',
  'application',
  'A production manager asks your crew to troubleshoot an exposed energized component because shutdown would interrupt operations. What is the BEST leadership response?',
  '[{"key":"A","text":"Proceed because operational impact is a valid reason by itself"},{"key":"B","text":"Determine whether energized work is actually permitted and justified, ensure qualified personnel and required controls are in place, and refuse the task if those conditions are not met"},{"key":"C","text":"Let the apprentice perform the test while you supervise"},{"key":"D","text":"Proceed if the task can be completed in under five minutes"}]'::jsonb,
  '["B"]'::jsonb,
  'Operational pressure does not replace the required energized-work decision process, qualifications, hazard controls, or authorization.'
),

(
  5,
  'multiple_select',
  'application',
  'Which THREE items should a lead electrician confirm when coordinating electrical energy control with another contractor?',
  '[{"key":"A","text":"The energy sources and isolation points affecting both crews"},{"key":"B","text":"How each employer''s energy-control procedure will be coordinated"},{"key":"C","text":"Who has authority and responsibility for changes, release, and re-energization"},{"key":"D","text":"Which crew can finish first"},{"key":"E","text":"Which contractor supplied the equipment"}]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Multi-employer work requires clear coordination of energy sources, procedures, responsibilities, and re-energization so one crew cannot unknowingly expose another.'
),

(
  6,
  'situational_judgment',
  'application',
  'A qualified worker reports that the planned test point cannot be reached without entering a more hazardous position than expected. What should the lead do?',
  '[{"key":"A","text":"Tell the worker to continue because the permit is already approved"},{"key":"B","text":"Stop and reassess the method, access, boundaries, PPE, and whether the task can be deenergized or otherwise redesigned"},{"key":"C","text":"Use a longer metal probe"},{"key":"D","text":"Assign a second worker to hold the first worker steady"}]'::jsonb,
  '["B"]'::jsonb,
  'A changed work position or exposure can invalidate the original hazard assessment; the plan must be revised before work continues.'
),

(
  7,
  'situational_judgment',
  'application',
  'A meter passes a visual inspection but its rating is not suitable for the available fault energy or measurement environment. What is the correct decision?',
  '[{"key":"A","text":"Use it for a quick reading only"},{"key":"B","text":"Do not use it; select test equipment and accessories with ratings suitable for the task and environment"},{"key":"C","text":"Use it only while wearing additional PPE"},{"key":"D","text":"Connect it through an extension lead"}]'::jsonb,
  '["B"]'::jsonb,
  'Test equipment must be suitable and properly rated for the electrical environment; PPE does not compensate for an inadequately rated instrument.'
),

(
  8,
  'multiple_choice',
  'application',
  'What is the BEST reason to define stop-work criteria during an electrical job briefing?',
  '[{"key":"A","text":"It gives the crew permission to stop only after an incident occurs"},{"key":"B","text":"It makes clear which unexpected conditions require the team to pause and reassess before exposure increases"},{"key":"C","text":"It prevents workers from asking questions during the task"},{"key":"D","text":"It eliminates the need for a qualified person"}]'::jsonb,
  '["B"]'::jsonb,
  'Predefined stop-work triggers help workers recognize when assumptions or controls have changed and a new assessment is required.'
),

(
  9,
  'situational_judgment',
  'application',
  'A crew has verified one source is isolated, but the equipment can also be supplied by a generator or stored-energy system. What should the lead require?',
  '[{"key":"A","text":"Proceed because the normal utility source is off"},{"key":"B","text":"Identify, isolate, control, and verify all relevant sources and stored energy before treating the equipment as deenergized"},{"key":"C","text":"Disconnect only the generator neutral"},{"key":"D","text":"Post a warning sign and continue"}]'::jsonb,
  '["B"]'::jsonb,
  'An electrically safe condition depends on controlling all sources that can energize the equipment, including alternate and stored-energy sources.'
),

(
  10,
  'situational_judgment',
  'application',
  'During a planned outage, an operations employee asks the crew to re-energize briefly so equipment can be tested before everyone has cleared the work zone. What is the BEST response?',
  '[{"key":"A","text":"Re-energize if the test will take less than a minute"},{"key":"B","text":"Follow the established temporary-energization/testing sequence, including clearing personnel, managing energy-control devices as required, testing, and restoring the safe condition before work resumes"},{"key":"C","text":"Have workers stand back while the circuit is energized"},{"key":"D","text":"Remove only the lead electrician''s lock and test"}]'::jsonb,
  '["B"]'::jsonb,
  'Temporary energization for testing requires a controlled sequence so workers are not exposed to unexpected energization and energy controls are properly restored.'
),

(
  11,
  'scenario',
  'scenario',
  'Your crew arrives to replace equipment under an outage plan. The disconnect shown on the drawing is present, but field tracing indicates a second feeder was added during a prior renovation. What is the BEST lead response?',
  '[{"key":"A","text":"Use the original outage plan because it was approved"},{"key":"B","text":"Stop the task, revise the isolation plan to include the newly discovered source, communicate the change, and verify all sources before work begins"},{"key":"C","text":"Open the second feeder without documenting the change"},{"key":"D","text":"Assign one worker to watch the second feeder"}]'::jsonb,
  '["B"]'::jsonb,
  'Discovery of an unplanned source changes the hazard and requires the outage and energy-control plan to be updated before exposure.'
),

(
  12,
  'scenario',
  'scenario',
  'An apprentice asks whether an arc-flash label alone tells them exactly what PPE and work method to use for every task on the equipment. What is the BEST answer?',
  '[{"key":"A","text":"Yes; the label replaces the need for a task-specific assessment"},{"key":"B","text":"No; the label is important information, but the qualified person must still use the applicable procedure and task-specific hazard assessment"},{"key":"C","text":"Yes, unless the equipment is more than five years old"},{"key":"D","text":"No; arc-flash labels should never be used for planning"}]'::jsonb,
  '["B"]'::jsonb,
  'Equipment labels are valuable hazard information, but they do not replace task-specific planning, equipment condition assessment, qualifications, or employer procedures.'
),

(
  13,
  'scenario',
  'scenario',
  'A worker testing for absence of voltage gets an unexpected nonzero reading on one phase after the planned isolation. What should the lead do FIRST?',
  '[{"key":"A","text":"Assume the meter is wrong and continue"},{"key":"B","text":"Treat the condition as energized, stop the work, and investigate the unexpected source or test result using the required safe-work process"},{"key":"C","text":"Short the conductor to ground"},{"key":"D","text":"Ask the worker to repeat the test without PPE"}]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected voltage means the assumed safe condition has not been established; the circuit must be treated as energized until the cause is resolved.'
),

(
  14,
  'situational_judgment',
  'scenario',
  'A subcontractor wants to remove another worker''s lock because the worker has left the site and the schedule is slipping. What is the BEST response?',
  '[{"key":"A","text":"Remove it if two supervisors agree"},{"key":"B","text":"Use only the employer''s established lock-removal procedure, including required verification and authorization; do not improvise"},{"key":"C","text":"Cut the lock and leave a note"},{"key":"D","text":"Energize around the lock using another disconnect"}]'::jsonb,
  '["B"]'::jsonb,
  'Removal of another person''s energy-control device must follow the employer''s specific procedure and safeguards, not schedule pressure or improvisation.'
),

(
  15,
  'scenario',
  'scenario',
  'During an energized diagnostic task that has been properly authorized, the equipment begins making an abnormal sound and shows signs of arcing. What should the qualified lead do?',
  '[{"key":"A","text":"Finish the measurement before conditions worsen"},{"key":"B","text":"Stop the task and withdraw to a safe condition; reassess before any further work"},{"key":"C","text":"Increase PPE and continue without changing the plan"},{"key":"D","text":"Have a second person take over the measurement"}]'::jsonb,
  '["B"]'::jsonb,
  'Abnormal equipment behavior is a material change in condition and can signal increasing electrical hazard; the task should stop and be reassessed.'
),

(
  16,
  'scenario',
  'scenario',
  'A temporary-power system has been modified several times as the project progressed. The crew cannot confirm whether all required GFCI or grounding-program inspections are current. What should the lead do?',
  '[{"key":"A","text":"Assume earlier inspections still cover the system"},{"key":"B","text":"Pause use of affected temporary power until the required protection and inspection status are confirmed"},{"key":"C","text":"Use only battery chargers on the system"},{"key":"D","text":"Post a sign stating ''use at your own risk''"}]'::jsonb,
  '["B"]'::jsonb,
  'Temporary-power protection must be maintained as the site changes; uncertain protection or inspection status should be resolved before continued use.'
),

(
  17,
  'situational_judgment',
  'scenario',
  'A worker suggests bypassing an interlock so the team can troubleshoot faster. What is the BEST lead response?',
  '[{"key":"A","text":"Allow it if the worker is qualified"},{"key":"B","text":"Do not bypass a safety interlock casually; evaluate the task under the applicable energized-work and equipment procedures and use only an authorized method"},{"key":"C","text":"Allow it if the bypass is removed before lunch"},{"key":"D","text":"Have an apprentice hold the interlock instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Interlocks are protective features; defeating them can materially change electrical exposure and requires an authorized, hazard-controlled procedure if permitted at all.'
),

(
  18,
  'scenario',
  'scenario',
  'After electrical work is complete, several employees from another trade are still inside the equipment boundary when operations asks to restore power. What should the lead do?',
  '[{"key":"A","text":"Energize because the electrical crew is finished"},{"key":"B","text":"Confirm the work area is clear, tools and temporary protective measures are addressed as required, personnel are accounted for, and the re-energization procedure is complete before restoring power"},{"key":"C","text":"Warn the other employees and energize immediately"},{"key":"D","text":"Restore one phase at a time"}]'::jsonb,
  '["B"]'::jsonb,
  'Safe re-energization requires confirmation that personnel and the work area are ready and that the established restoration sequence has been completed.'
),

(
  19,
  'scenario',
  'scenario',
  'A near miss occurs when a mislabeled circuit is found energized during verification. No one is injured. What is the BEST Level 4 response after the immediate hazard is controlled?',
  '[{"key":"A","text":"Correct the label and say nothing so the project is not delayed"},{"key":"B","text":"Preserve and report the near-miss information, correct the immediate condition, investigate contributing causes, and improve the procedure or documentation so the exposure is less likely to recur"},{"key":"C","text":"Discipline the worker who found the problem"},{"key":"D","text":"Resume work without changing the plan because the tester prevented injury"}]'::jsonb,
  '["B"]'::jsonb,
  'Advanced safety leadership includes learning from near misses and correcting system causes, not only fixing the immediate hazard.'
),

(
  20,
  'multiple_choice',
  'scenario',
  'Which behavior BEST demonstrates Level 4 performance in Electrical Safety & Job-Site Standards?',
  '[{"key":"A","text":"Following established safety steps only for personally assigned work"},{"key":"B","text":"Leading hazard assessment and energy-control planning, coaching others, recognizing when conditions invalidate the plan, and stopping or redesigning work before unsafe exposure occurs"},{"key":"C","text":"Accepting higher risk when the schedule is behind"},{"key":"D","text":"Relying on experience to replace written procedures and verification"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes leading and coaching safe work, validating controls, and changing the plan when conditions create unacceptable electrical risk.'
);



do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '5def935e-5ccc-492c-a1b7-40936df9db58';
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
      and c.name = 'Electrical Safety & Job-Site Standards'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Safety & Job-Site Standards Master Competency not found';
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
      and mrcr.required_level = 3
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
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
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

  v_level := 3;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Electrical Safety & Job-Site Standards — Level 3 Competency Assessment';

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
    select * from _seed_electrical_safety_l3_questions
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
        'Electrical Safety & Job-Site Standards',
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
      'IntegrateU Electrical Safety & Job-Site Standards L3 production assessment v1.0.',
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
        'Electrical Safety & Job-Site Standards',
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
        'IntegrateU Electrical Safety & Job-Site Standards L3 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Safety & Job-Site Standards — Level 4 Competency Assessment';

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
    select * from _seed_electrical_safety_l4_questions
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
        'Electrical Safety & Job-Site Standards',
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
      'IntegrateU Electrical Safety & Job-Site Standards L4 production assessment v1.0.',
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
        'Electrical Safety & Job-Site Standards',
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
        'IntegrateU Electrical Safety & Job-Site Standards L4 production assessment v1.0.',
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
   '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid
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
      '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid
    and a.target_level in (3,4)
    and aq.master_competency_template_id =
      '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid
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
  '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid;

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
    '5def935e-5ccc-492c-a1b7-40936df9db58'::uuid
  and a.target_level in (3,4)
group by a.target_level
having count(*) > 1;
