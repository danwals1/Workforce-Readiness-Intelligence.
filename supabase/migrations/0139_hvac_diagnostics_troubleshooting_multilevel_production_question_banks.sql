-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0127_hvac_diagnostics_troubleshooting_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Diagnostics & Troubleshooting
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Design & Sales Engineer     -> Level 2
--   HVAC Service & Repair Technician -> Level 3
--   Senior / Lead HVAC Technician    -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_diagnostics_troubleshooting_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_diagnostics_troubleshooting_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the main purpose of HVAC troubleshooting?',
  '[{"key":"A","text":"To identify the actual cause of a system problem before selecting a repair"},{"key":"B","text":"To replace the most expensive component first"},{"key":"C","text":"To increase refrigerant charge on every service call"},{"key":"D","text":"To bypass controls until the equipment runs"}]'::jsonb,
  '["A"]'::jsonb,
  'Troubleshooting is a systematic process for identifying the cause of a problem rather than guessing at repairs.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should a technician or installer do before beginning diagnostic work on equipment?',
  '[{"key":"A","text":"Understand the reported problem and follow the required safety procedure for the work"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Change every control setting"}]'::jsonb,
  '["A"]'::jsonb,
  'A clear problem description and safe work setup provide the foundation for effective troubleshooting.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is it useful to observe the equipment operating before making changes when it is safe to do so?',
  '[{"key":"A","text":"The actual symptoms can help narrow down where the problem may be occurring"},{"key":"B","text":"Operating equipment automatically fixes control faults"},{"key":"C","text":"It eliminates the need for measurements"},{"key":"D","text":"It proves the refrigerant charge is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'Observing the symptom before changing the system helps preserve useful diagnostic evidence.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should a technician check simple causes before replacing major components?',
  '[{"key":"A","text":"Basic issues such as power, settings, loose connections, or blocked airflow can create symptoms that resemble major failures"},{"key":"B","text":"Major components never fail"},{"key":"C","text":"Simple checks always require more time"},{"key":"D","text":"Replacing parts first is safer"}]'::jsonb,
  '["A"]'::jsonb,
  'Simple faults can produce major symptoms, so basic checks can prevent unnecessary component replacement.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a symptom in HVAC troubleshooting?',
  '[{"key":"A","text":"An observable condition that indicates something may not be operating correctly"},{"key":"B","text":"The confirmed root cause of every failure"},{"key":"C","text":"A replacement part number"},{"key":"D","text":"A refrigerant type"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom is what is observed; troubleshooting is used to determine the cause behind it.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should diagnostic measurements be compared with expected or specified values?',
  '[{"key":"A","text":"The comparison helps determine whether the measured condition is normal or abnormal"},{"key":"B","text":"Every measured value should be the same"},{"key":"C","text":"Specifications are only used during installation"},{"key":"D","text":"Measurements replace visual inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'A measurement has diagnostic value when it can be compared with an expected operating condition.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is changing several things at once a poor troubleshooting practice?',
  '[{"key":"A","text":"It can make it difficult to know which change affected the symptom"},{"key":"B","text":"It always damages the compressor"},{"key":"C","text":"It lowers duct pressure"},{"key":"D","text":"It prevents thermostat operation"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled troubleshooting changes one relevant condition at a time so results can be interpreted.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should be done after a suspected problem has been corrected?',
  '[{"key":"A","text":"Verify that the system now operates correctly and that the original symptom is resolved"},{"key":"B","text":"Immediately leave without testing"},{"key":"C","text":"Change another component"},{"key":"D","text":"Reset all control settings"}]'::jsonb,
  '["A"]'::jsonb,
  'A repair is not complete until proper operation is verified.'
),
(
  9,
  'multiple_choice',
  'application',
  'A system will not start. The thermostat display is blank. What is a reasonable first diagnostic direction?',
  '[{"key":"A","text":"Check whether the thermostat and control circuit have the required power"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A blank thermostat suggests a control-power or wiring problem that should be checked before major components are considered.'
),
(
  10,
  'multiple_choice',
  'application',
  'An indoor blower runs but very little air comes from the supply registers. What is a useful basic check?',
  '[{"key":"A","text":"Inspect for obvious airflow restrictions such as a dirty filter, blocked return, or damaged duct"},{"key":"B","text":"Replace the thermostat immediately"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic airflow restrictions can cause low delivered airflow and should be checked early.'
),
(
  11,
  'multiple_choice',
  'application',
  'A system worked before thermostat wiring was changed and now does not respond. What is the BEST first step?',
  '[{"key":"A","text":"Compare the thermostat wiring and configuration with the approved equipment information"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'A problem that appears immediately after control work should first be checked against the work that was changed.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician hears a new rattling sound after a panel was reinstalled. What is a reasonable first action?',
  '[{"key":"A","text":"Inspect the panel and nearby components for loose or improperly secured parts"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the blower motor"},{"key":"D","text":"Change thermostat settings"}]'::jsonb,
  '["A"]'::jsonb,
  'A new noise after recent work should prompt inspection of the area that was disturbed.'
),
(
  13,
  'multiple_choice',
  'application',
  'A cooling system runs but one room has almost no airflow. What should be checked before changing equipment settings?',
  '[{"key":"A","text":"The branch duct, register, damper, and other obvious airflow restrictions serving that room"},{"key":"B","text":"The refrigerant charge only"},{"key":"C","text":"The outdoor disconnect"},{"key":"D","text":"The compressor oil"}]'::jsonb,
  '["A"]'::jsonb,
  'A problem isolated to one room often points to the local air-distribution path rather than the entire HVAC system.'
),
(
  14,
  'multiple_choice',
  'application',
  'A system repeatedly stops after a safety device opens. What is the BEST response?',
  '[{"key":"A","text":"Identify why the safety device is opening rather than bypassing it"},{"key":"B","text":"Permanently jumper the safety"},{"key":"C","text":"Install a larger fuse"},{"key":"D","text":"Raise the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'A safety opening is a symptom of another condition and should be investigated rather than defeated.'
),
(
  15,
  'multiple_choice',
  'application',
  'A service call reports that the system stopped immediately after a filter was replaced. What is a useful first check?',
  '[{"key":"A","text":"Inspect the filter installation and nearby panels or switches that may have been disturbed"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Change thermostat type"}]'::jsonb,
  '["A"]'::jsonb,
  'When a symptom begins after recent work, the changed area should be inspected first.'
),
(
  16,
  'multiple_choice',
  'application',
  'A technician corrects a loose low-voltage connection that appeared to cause intermittent operation. What should happen next?',
  '[{"key":"A","text":"Operate the system and verify that the intermittent symptom is resolved"},{"key":"B","text":"Replace the thermostat anyway"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase transformer size"}]'::jsonb,
  '["A"]'::jsonb,
  'The suspected correction should be verified under operating conditions before the job is considered complete.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer starts a new system and the outdoor unit does not run. The thermostat is calling for cooling, but the disconnect serving the outdoor unit is still off. What is the BEST response?',
  '[{"key":"A","text":"Recognize the missing power condition, follow the approved startup procedure, and verify operation after power is properly restored"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Bypass the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'A missing power source is a basic condition that should be identified before assuming equipment failure.'
),
(
  18,
  'scenario',
  'scenario',
  'A homeowner reports that the system is running but the house is not cooling well. The return filter is heavily loaded with debris and airflow is very low. What is the BEST first response?',
  '[{"key":"A","text":"Correct the obvious airflow restriction and then reassess system operation"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Replace the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'An obvious airflow restriction should be corrected before interpreting other system symptoms.'
),
(
  19,
  'scenario',
  'scenario',
  'A system begins making noise immediately after a line-set cover is installed. Inspection shows the cover pressing tightly against refrigerant tubing that vibrates during operation. What is the BEST response?',
  '[{"key":"A","text":"Correct the contact condition and verify the noise is eliminated without damaging the tubing"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom that begins after recent work should be traced to the changed condition when evidence supports that connection.'
),
(
  20,
  'scenario',
  'scenario',
  'A helper sees a technician replace two parts during troubleshooting without checking whether the first replacement changed the symptom. What is the BEST troubleshooting principle?',
  '[{"key":"A","text":"Make controlled diagnostic changes and verify the effect of each change before moving on"},{"key":"B","text":"Replace as many likely parts as possible"},{"key":"C","text":"Avoid taking measurements"},{"key":"D","text":"Always begin with the most expensive component"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled troubleshooting preserves cause-and-effect information and reduces unnecessary parts replacement.'
);

create temporary table _seed_hvac_diagnostics_troubleshooting_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_diagnostics_troubleshooting_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is a clear problem statement important before troubleshooting an HVAC system?',
  '[{"key":"A","text":"It helps define the symptom and prevents diagnosis from drifting into unrelated issues"},{"key":"B","text":"It determines refrigerant type"},{"key":"C","text":"It replaces equipment measurements"},{"key":"D","text":"It guarantees the first suspected part is failed"}]'::jsonb,
  '["A"]'::jsonb,
  'A precise problem statement keeps troubleshooting focused on the actual complaint and observed symptoms.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the difference between a symptom and a root cause?',
  '[{"key":"A","text":"A symptom is what is observed, while the root cause is the underlying condition producing it"},{"key":"B","text":"They are always the same thing"},{"key":"C","text":"A root cause is only a fault code"},{"key":"D","text":"Symptoms occur only in electrical systems"}]'::jsonb,
  '["A"]'::jsonb,
  'Troubleshooting separates what the system is doing from why it is doing it.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should recent changes to equipment or controls be considered during diagnosis?',
  '[{"key":"A","text":"A newly introduced condition may be related to the start of the symptom"},{"key":"B","text":"Recent work can never cause faults"},{"key":"C","text":"Recent changes only affect comfort complaints"},{"key":"D","text":"They are less important than replacing components"}]'::jsonb,
  '["A"]'::jsonb,
  'When a problem begins after a change, that change is useful diagnostic evidence.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is it useful to verify whether a fault affects the entire system or only one zone or component?',
  '[{"key":"A","text":"The scope of the symptom helps narrow the likely fault location"},{"key":"B","text":"All HVAC faults affect the entire system"},{"key":"C","text":"Zone-specific symptoms always mean thermostat failure"},{"key":"D","text":"System-wide faults never involve controls"}]'::jsonb,
  '["A"]'::jsonb,
  'Determining the scope of a problem is a basic diagnostic step that helps isolate likely causes.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the BEST use of equipment documentation during troubleshooting?',
  '[{"key":"A","text":"To compare actual operation, settings, wiring, and sequence with the intended design"},{"key":"B","text":"To avoid taking measurements"},{"key":"C","text":"To determine customer preferences only"},{"key":"D","text":"To replace field observations"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable documentation provides expected conditions against which actual system behavior can be compared.'
),
(
  6,
  'multiple_choice',
  'application',
  'A comfort complaint affects only one room while nearby rooms are normal. What is the BEST first diagnostic direction?',
  '[{"key":"A","text":"Investigate the local airflow path, room conditions, and controls serving that space before assuming a whole-system fault"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed for the entire building"}]'::jsonb,
  '["A"]'::jsonb,
  'A localized symptom usually calls for localized checks before changes are made to the entire system.'
),
(
  7,
  'multiple_choice',
  'application',
  'A newly commissioned system has poor comfort even though the equipment runs. What should be reviewed early in diagnosis?',
  '[{"key":"A","text":"System setup, airflow, thermostat configuration, equipment application, and whether commissioning matched the intended design"},{"key":"B","text":"Compressor replacement history only"},{"key":"C","text":"Paint color"},{"key":"D","text":"Outdoor-unit label placement"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor comfort after commissioning can result from setup or application issues even when equipment operates.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer reports the system has never maintained the desired temperature since installation. What is the BEST approach?',
  '[{"key":"A","text":"Confirm the complaint, review equipment selection and design assumptions, and verify actual system performance"},{"key":"B","text":"Assume the thermostat is defective"},{"key":"C","text":"Add refrigerant immediately"},{"key":"D","text":"Replace the indoor unit"}]'::jsonb,
  '["A"]'::jsonb,
  'A system that has never performed correctly may have an application, design, setup, or installation issue rather than a newly failed part.'
),
(
  9,
  'multiple_choice',
  'application',
  'A thermostat is satisfied, but occupants still complain that one area feels uncomfortable. What should be considered?',
  '[{"key":"A","text":"Thermostat location, air distribution, room load, zoning, and whether the sensor represents the problem area"},{"key":"B","text":"Refrigerant charge only"},{"key":"C","text":"Compressor oil only"},{"key":"D","text":"Outdoor-unit paint condition"}]'::jsonb,
  '["A"]'::jsonb,
  'Comfort can be poor even when the thermostat is satisfied if sensing and air distribution do not represent the occupied space.'
),
(
  10,
  'multiple_choice',
  'application',
  'A system appears oversized because it satisfies the thermostat quickly but comfort and humidity remain poor. What is the BEST diagnostic response?',
  '[{"key":"A","text":"Review load assumptions, equipment capacity, airflow, staging, control settings, and actual operating behavior"},{"key":"B","text":"Increase equipment capacity further"},{"key":"C","text":"Close return grilles"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Short runtime and poor comfort may indicate an application or control issue that should be evaluated as a system.'
),
(
  11,
  'multiple_choice',
  'application',
  'A proposed equipment replacement is based only on a complaint that the current system runs continuously on very hot days. What should happen before concluding the equipment is undersized?',
  '[{"key":"A","text":"Verify actual indoor conditions, load, equipment performance, airflow, and outdoor design conditions"},{"key":"B","text":"Select the next larger unit automatically"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Reduce duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'Long runtime alone does not prove undersizing; actual performance and load conditions should be checked.'
),
(
  12,
  'multiple_choice',
  'application',
  'A system has repeated comfort complaints after interior walls were added during a remodel. What should be investigated?',
  '[{"key":"A","text":"Whether room loads, airflow distribution, zoning, and thermostat sensing still match the modified space"},{"key":"B","text":"Refrigerant type only"},{"key":"C","text":"Compressor model only"},{"key":"D","text":"Outdoor disconnect size only"}]'::jsonb,
  '["A"]'::jsonb,
  'Building changes can alter loads and air distribution even when the HVAC equipment itself has not changed.'
),
(
  13,
  'multiple_choice',
  'application',
  'A customer reports frequent cycling after a thermostat upgrade. What is the BEST diagnostic direction?',
  '[{"key":"A","text":"Review thermostat configuration, staging, cycle settings, sensor location, and equipment response"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase duct leakage"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom that begins after a control change should prompt review of the new setup and its interaction with the equipment.'
),
(
  14,
  'multiple_choice',
  'application',
  'A design assumes adequate airflow, but field testing shows high static pressure and low delivered air. What is the BEST response?',
  '[{"key":"A","text":"Investigate duct resistance, filter and coil pressure drop, blower setup, and whether the installed system matches the design assumptions"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Reduce outdoor-air temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Measured airflow and static conditions should be compared with the design and installed system to identify the restriction or mismatch.'
),
(
  15,
  'scenario',
  'scenario',
  'A newly installed system cools the thermostat location quickly, but distant rooms remain warm. What is the BEST Level 2 diagnostic response?',
  '[{"key":"A","text":"Evaluate thermostat placement, room-by-room airflow, branch distribution, balancing, and whether the design matches the space loads"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Lower the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'A comfort problem isolated away from the thermostat requires evaluation of sensing and distribution, not just equipment operation.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer says a replacement system is noisier than the old one. The equipment is operating normally, but airflow velocity is high at several registers. What is the BEST response?',
  '[{"key":"A","text":"Evaluate air-distribution sizing, register selection, airflow, and blower setup before assuming equipment failure"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase fan speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Noise can be an air-distribution or setup issue even when the equipment itself is functioning.'
),
(
  17,
  'scenario',
  'scenario',
  'A system repeatedly trips a safety during peak conditions but operates normally at mild outdoor temperatures. What is the BEST diagnostic approach?',
  '[{"key":"A","text":"Compare operating conditions at the time of failure with the expected sequence and system design instead of simply resetting the safety"},{"key":"B","text":"Bypass the safety"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Ignore the pattern because the unit runs at other times"}]'::jsonb,
  '["A"]'::jsonb,
  'A fault that appears only under certain loads or conditions should be diagnosed under those conditions.'
),
(
  18,
  'scenario',
  'scenario',
  'An addition is connected to an existing HVAC system and comfort becomes poor in both the original space and the addition. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate the total load, equipment capacity, airflow distribution, return path, and control strategy for the modified system"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace every thermostat"},{"key":"D","text":"Close registers in the original space"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding load and distribution demand can affect the performance of the entire system and should be evaluated as a system-level change.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer wants a larger replacement unit because the existing system runs for long periods but still maintains temperature and humidity well. What is the BEST response?',
  '[{"key":"A","text":"Evaluate actual load and performance before recommending a larger unit, because long stable runtimes can be normal and beneficial"},{"key":"B","text":"Select the largest unit that fits"},{"key":"C","text":"Double the equipment capacity"},{"key":"D","text":"Reduce duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'Runtime must be interpreted with actual comfort and performance data rather than treated as proof of inadequate capacity.'
),
(
  20,
  'scenario',
  'scenario',
  'A project has repeated post-installation comfort callbacks across several homes using the same equipment package. What is the BEST Level 2 response?',
  '[{"key":"A","text":"Look for a common application, design, setup, airflow, or control pattern across the installations rather than treating every callback as unrelated"},{"key":"B","text":"Replace thermostats in all homes"},{"key":"C","text":"Add refrigerant to every system"},{"key":"D","text":"Increase blower speed universally"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated similar complaints across installations can reveal a common system-selection, design, setup, or commissioning issue.'
);

create temporary table _seed_hvac_diagnostics_troubleshooting_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_diagnostics_troubleshooting_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in HVAC Diagnostics & Troubleshooting?',
  '[{"key":"A","text":"Replacing the most likely component first"},{"key":"B","text":"Independently using symptoms, sequence of operation, measurements, and system relationships to isolate root causes and verify repairs"},{"key":"C","text":"Adding refrigerant whenever cooling is weak"},{"key":"D","text":"Bypassing safeties until the equipment operates"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 troubleshooting requires systematic fault isolation using evidence rather than guesswork.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a technician understand the expected sequence of operation before diagnosing a system fault?',
  '[{"key":"A","text":"It provides a reference for identifying where actual operation departs from the intended process"},{"key":"B","text":"It eliminates the need for measurements"},{"key":"C","text":"It determines duct size"},{"key":"D","text":"It applies only to thermostats"}]'::jsonb,
  '["A"]'::jsonb,
  'The expected sequence helps the technician locate the point where normal operation stops or becomes abnormal.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is confirming a diagnosis before replacing a component important?',
  '[{"key":"A","text":"The same symptom can be caused by multiple faults, and confirmation reduces unnecessary parts replacement"},{"key":"B","text":"Components rarely fail"},{"key":"C","text":"Replacement parts correct every upstream problem"},{"key":"D","text":"Diagnosis is only needed for electrical faults"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom alone does not prove a specific component has failed.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to verify system operation after completing a repair?',
  '[{"key":"A","text":"To confirm the original fault is resolved and the system operates correctly through the required sequence"},{"key":"B","text":"To increase refrigerant pressure"},{"key":"C","text":"To reset all customer settings"},{"key":"D","text":"To avoid documenting the repair"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful repair should resolve the reported problem and restore correct system operation.'
),
(
  5,
  'multiple_choice',
  'application',
  'A cooling system has low airflow and the evaporator is beginning to frost. What should the technician evaluate before changing refrigerant charge?',
  '[{"key":"A","text":"Air filter condition, blower operation, coil condition, duct restrictions, and actual airflow"},{"key":"B","text":"Thermostat color"},{"key":"C","text":"Outdoor-unit paint condition"},{"key":"D","text":"Compressor replacement history only"}]'::jsonb,
  '["A"]'::jsonb,
  'Low airflow can create refrigeration symptoms, so airflow should be evaluated before charge is adjusted.'
),
(
  6,
  'multiple_choice',
  'application',
  'A thermostat is calling for cooling and the indoor blower runs, but the outdoor unit does not. What is the BEST diagnostic approach?',
  '[{"key":"A","text":"Trace the cooling command through the control sequence, power circuit, safeties, and outdoor components"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the thermostat immediately"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'The fault should be isolated by following the expected control and power sequence.'
),
(
  7,
  'multiple_choice',
  'application',
  'A compressor will not start, but proper line voltage is present at the equipment. What should be done next?',
  '[{"key":"A","text":"Continue diagnosis of the starting circuit, controls, protective devices, and compressor condition using approved procedures"},{"key":"B","text":"Assume the compressor is failed"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage at the equipment does not by itself identify which downstream component or condition is preventing compressor operation.'
),
(
  8,
  'multiple_choice',
  'application',
  'A system repeatedly trips a protective device during high-load operation. What is the BEST response?',
  '[{"key":"A","text":"Capture operating conditions when the trip occurs and diagnose the cause rather than repeatedly resetting the device"},{"key":"B","text":"Install a larger protective device"},{"key":"C","text":"Bypass the protection"},{"key":"D","text":"Lower the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent trips should be diagnosed under the conditions that produce them.'
),
(
  9,
  'multiple_choice',
  'application',
  'A system has poor cooling and abnormal refrigerant pressures, but the condenser coil is heavily blocked with debris. What is the BEST next step?',
  '[{"key":"A","text":"Correct the known airflow problem and then reevaluate system pressures and performance"},{"key":"B","text":"Adjust refrigerant charge first"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Reduce indoor airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Known heat-transfer and airflow problems should be corrected before refrigerant conditions are interpreted.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician finds the expected control signal entering a relay but no output from the relay when it should be energized. What is the BEST conclusion?',
  '[{"key":"A","text":"The relay circuit should be evaluated further to confirm whether the relay or its power path has failed"},{"key":"B","text":"The thermostat must be defective"},{"key":"C","text":"The refrigerant charge is low"},{"key":"D","text":"The duct system is undersized"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparing expected input and output conditions helps isolate faults within a control circuit.'
),
(
  11,
  'multiple_choice',
  'application',
  'A system has repeated low-pressure safety trips. What should the technician do before assuming low refrigerant charge?',
  '[{"key":"A","text":"Evaluate airflow, coil condition, refrigerant circuit operation, operating conditions, and the safety circuit itself"},{"key":"B","text":"Add refrigerant automatically"},{"key":"C","text":"Bypass the safety"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'A safety trip can result from several system conditions and should be diagnosed rather than treated as proof of one cause.'
),
(
  12,
  'scenario',
  'scenario',
  'A heat pump heats normally for several minutes and then shuts down on a safety. Outdoor airflow is severely restricted by debris. What is the BEST response?',
  '[{"key":"A","text":"Correct the airflow restriction and reevaluate operation and the safety condition before replacing components"},{"key":"B","text":"Bypass the safety"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Add refrigerant immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'An obvious airflow problem that can drive abnormal operating conditions should be corrected before other components are condemned.'
),
(
  13,
  'scenario',
  'scenario',
  'A cooling system has weak capacity. Suction pressure appears low, but measured indoor airflow is also well below expected. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Diagnose and correct the airflow problem before using refrigerant pressures alone to judge charge"},{"key":"B","text":"Add refrigerant until suction pressure rises"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase thermostat differential"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow and refrigeration conditions interact, so charge should not be diagnosed from pressure alone when airflow is abnormal.'
),
(
  14,
  'scenario',
  'scenario',
  'A system intermittently loses control power. Moving one wire bundle causes power to return. What is the BEST response?',
  '[{"key":"A","text":"Inspect the affected wiring, terminals, splices, and connectors for an intermittent connection or conductor fault"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Increase transformer size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'A fault that changes with physical movement strongly suggests an intermittent electrical connection.'
),
(
  15,
  'scenario',
  'scenario',
  'A compressor has been replaced twice for the same failure pattern. The current system shows abnormal operating conditions before another failure. What is the BEST response?',
  '[{"key":"A","text":"Investigate the operating conditions and system root cause before replacing the compressor again"},{"key":"B","text":"Install another compressor immediately"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase fuse size"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated component failure often indicates an unresolved system condition rather than isolated bad components.'
),
(
  16,
  'scenario',
  'scenario',
  'A rooftop unit operates correctly during mild weather but shuts down during the hottest part of the day. What is the BEST diagnostic strategy?',
  '[{"key":"A","text":"Capture temperatures, pressures, airflow, electrical conditions, and control status when the failure actually occurs"},{"key":"B","text":"Replace the thermostat during mild weather"},{"key":"C","text":"Add refrigerant without measurements"},{"key":"D","text":"Bypass protective controls"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent faults should be evaluated under the conditions that reproduce them.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer reports intermittent cooling. The thermostat call remains present, but the outdoor contactor drops out because a safety circuit opens. What is the BEST response?',
  '[{"key":"A","text":"Determine which safety opens and diagnose the operating condition causing it"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Jumper the safety permanently"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'The safety circuit is interrupting operation, so the technician should identify and correct the reason for the interruption.'
),
(
  18,
  'scenario',
  'scenario',
  'A repaired system now starts and cools, but the technician notices the compressor current is still abnormally high. What is the BEST response?',
  '[{"key":"A","text":"Continue diagnosis of the abnormal operating condition rather than closing the job because cooling has returned"},{"key":"B","text":"Ignore the current because the system is running"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Restored operation does not prove the system is healthy if important measurements remain abnormal.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician replaces a control board and the original fault remains unchanged. What is the BEST next response?',
  '[{"key":"A","text":"Return to the diagnostic sequence, verify board inputs and outputs, and identify the actual cause rather than replacing more parts blindly"},{"key":"B","text":"Replace another board"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase transformer voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'An unchanged symptom after component replacement is evidence that the original diagnosis may have been incorrect.'
),
(
  20,
  'scenario',
  'scenario',
  'A service history shows repeated refrigerant additions for low-cooling complaints, but no leak was ever documented. The system now has abnormal charge indicators. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Reestablish proper diagnostic conditions, evaluate airflow and refrigeration performance, check for leaks as appropriate, and correct the root cause before adjusting charge"},{"key":"B","text":"Add the same amount of refrigerant again"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase blower speed without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated charge adjustments without diagnosis can obscure the actual problem and should be replaced with systematic evaluation.'
);

create temporary table _seed_hvac_diagnostics_troubleshooting_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_diagnostics_troubleshooting_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in HVAC Diagnostics & Troubleshooting?',
  '[{"key":"A","text":"Replacing common failure parts before collecting evidence"},{"key":"B","text":"Leading systematic diagnostic standards, root-cause analysis, technical escalation, verification, documentation, and recurring-failure prevention across technicians and systems"},{"key":"C","text":"Resetting safeties until equipment remains running"},{"key":"D","text":"Using refrigerant charge adjustments as the first response to most performance complaints"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership over diagnostic quality, root-cause identification, verification, and prevention of repeat failures.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should repeated failures of the same component trigger root-cause analysis?',
  '[{"key":"A","text":"The component may be failing because of an unresolved system condition rather than isolated part defects"},{"key":"B","text":"Repeated failures prove every replacement part is defective"},{"key":"C","text":"The correct response is always a larger replacement component"},{"key":"D","text":"Root-cause analysis applies only to electrical failures"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring component failure often indicates an upstream operating, installation, application, or control problem.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of standardized diagnostic documentation?',
  '[{"key":"A","text":"To record symptoms, measurements, findings, corrective actions, and verification so recurring patterns can be understood"},{"key":"B","text":"To eliminate technician judgment"},{"key":"C","text":"To replace field measurements"},{"key":"D","text":"To document only the replacement part number"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent diagnostic records support technical review, repeat-failure analysis, and better future troubleshooting.'
),
(
  4,
  'multiple_choice',
  'application',
  'A senior technician finds that different technicians diagnose the same complaint using completely different methods and frequently reach different conclusions. What is the BEST response?',
  '[{"key":"A","text":"Establish a consistent diagnostic framework based on symptoms, sequence, measurements, fault isolation, and repair verification"},{"key":"B","text":"Let each technician continue using personal preference"},{"key":"C","text":"Replace more components during each visit"},{"key":"D","text":"Reduce documentation requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'A structured troubleshooting process reduces variation and unsupported conclusions.'
),
(
  5,
  'multiple_choice',
  'application',
  'A branch has several compressor replacements followed by repeat failures. What should the senior lead review?',
  '[{"key":"A","text":"Electrical conditions, refrigerant-system operation, airflow, installation quality, application, controls, and prior failure evidence"},{"key":"B","text":"Thermostat brand only"},{"key":"C","text":"Filter color"},{"key":"D","text":"Outdoor cabinet appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated compressor failures require evaluation of the system conditions that may be damaging the compressor.'
),
(
  6,
  'multiple_choice',
  'application',
  'A service team frequently adds refrigerant when suction pressure appears low, but callback rates remain high. What is the BEST corrective action?',
  '[{"key":"A","text":"Require airflow, load, refrigeration performance, leak status, and other relevant conditions to be evaluated before charge is changed"},{"key":"B","text":"Standardize a fixed amount of refrigerant to add"},{"key":"C","text":"Raise suction-pressure targets universally"},{"key":"D","text":"Replace thermostats on every callback"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant pressures should be interpreted in context rather than used alone to justify charge adjustments.'
),
(
  7,
  'multiple_choice',
  'application',
  'A recurring intermittent fault is difficult to reproduce during normal service hours. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Develop a plan to capture operating data and control status under the conditions when the fault actually occurs"},{"key":"B","text":"Replace likely components until the fault stops"},{"key":"C","text":"Ignore the issue until it becomes permanent"},{"key":"D","text":"Bypass protective devices"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent failures are best diagnosed by gathering evidence under the conditions that trigger them.'
),
(
  8,
  'multiple_choice',
  'application',
  'A senior technician discovers repeated control-board replacements where the original fault was actually caused by field wiring. What should change?',
  '[{"key":"A","text":"Strengthen verification of power, inputs, outputs, wiring, and sequence before controllers are condemned"},{"key":"B","text":"Stock more control boards"},{"key":"C","text":"Replace boards and wiring together automatically"},{"key":"D","text":"Disable fault codes"}]'::jsonb,
  '["A"]'::jsonb,
  'Better fault isolation prevents unnecessary controller replacement and improves diagnostic accuracy.'
),
(
  9,
  'multiple_choice',
  'application',
  'A company sees repeated service calls where technicians correct the immediate symptom but do not verify the full system sequence afterward. What is the BEST response?',
  '[{"key":"A","text":"Make post-repair operational verification part of the required diagnostic closeout process"},{"key":"B","text":"Reduce test time"},{"key":"C","text":"Document only whether the equipment starts"},{"key":"D","text":"Skip verification when a part was replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'The repair should be verified across the intended sequence rather than assumed successful because the immediate symptom disappeared.'
),
(
  10,
  'multiple_choice',
  'application',
  'A fleet of similar systems has the same recurring high-pressure shutdown pattern. What is the BEST technical response?',
  '[{"key":"A","text":"Compare common application, airflow, heat-rejection, control, installation, and maintenance factors across the affected systems"},{"key":"B","text":"Replace high-pressure switches on all units"},{"key":"C","text":"Bypass the safeties"},{"key":"D","text":"Reduce refrigerant charge on every unit without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated pattern across similar equipment suggests a shared system or process issue worth investigating broadly.'
),
(
  11,
  'scenario',
  'scenario',
  'A commercial site has repeated compressor failures on the same unit. Each compressor was replaced after electrical winding damage, but no one recorded voltage, current, refrigerant conditions, or airflow before replacement. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Stop treating the failures as isolated events and perform a full root-cause investigation before another compressor is installed"},{"key":"B","text":"Install a larger compressor"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase fuse size"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures without operating evidence require a broader investigation before another replacement repeats the same outcome.'
),
(
  12,
  'scenario',
  'scenario',
  'A service department reports many low-cooling callbacks. Review shows technicians often diagnose charge from pressure alone and rarely measure airflow. What is the BEST corrective response?',
  '[{"key":"A","text":"Standardize a diagnostic process that evaluates airflow and relevant refrigeration conditions before charge decisions are made"},{"key":"B","text":"Increase standard refrigerant charge amounts"},{"key":"C","text":"Replace thermostats during every callback"},{"key":"D","text":"Stop recording system pressures"}]'::jsonb,
  '["A"]'::jsonb,
  'Cooling diagnostics require system context because airflow problems can create refrigeration symptoms.'
),
(
  13,
  'scenario',
  'scenario',
  'Several identical rooftop units trip the same safety only during the hottest afternoons. The units operate normally in the morning. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Capture and compare operating data during peak-load failures to identify the shared condition causing the safety trips"},{"key":"B","text":"Bypass the safety during afternoons"},{"key":"C","text":"Replace all thermostats"},{"key":"D","text":"Reset the units each evening"}]'::jsonb,
  '["A"]'::jsonb,
  'Condition-dependent failures require data from the conditions under which they occur.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician replaces a control board for an intermittent shutdown. The new board behaves exactly like the old one. What should the senior lead reinforce?',
  '[{"key":"A","text":"Verify inputs, outputs, wiring, power, safeties, and sequence before condemning another board"},{"key":"B","text":"Replace the board again"},{"key":"C","text":"Increase transformer voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'An unchanged symptom after replacement is strong evidence that the original diagnosis was incomplete or incorrect.'
),
(
  15,
  'scenario',
  'scenario',
  'A recurring airflow complaint is repeatedly addressed by increasing blower speed. Static pressure is already excessive and several ducts are undersized. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct the air-distribution restriction and stop using blower adjustments to compensate for the underlying system defect"},{"key":"B","text":"Increase blower speed again"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close additional registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment settings should not be used to mask known distribution-system restrictions.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer has repeated nuisance shutdowns. The service history shows different technicians resetting the same safety but no one has captured why it opens. What is the BEST response?',
  '[{"key":"A","text":"Create a diagnostic plan to identify the triggering operating condition and verify the corrective action"},{"key":"B","text":"Program automatic resets"},{"key":"C","text":"Bypass the safety"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated reset-only service does not address the condition causing the safety to operate.'
),
(
  17,
  'scenario',
  'scenario',
  'A senior technician reviews recurring refrigerant-loss complaints. Technicians repeatedly recharge systems but leak findings are rarely documented. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Require systematic leak diagnosis, repair verification, charge documentation, and trend review rather than repeated recharge-only service"},{"key":"B","text":"Standardize the amount of refrigerant added"},{"key":"C","text":"Replace compressors after the second recharge"},{"key":"D","text":"Stop tracking refrigerant history"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring refrigerant loss should be diagnosed and repaired rather than managed through repeated additions.'
),
(
  18,
  'scenario',
  'scenario',
  'A newly installed equipment package generates the same comfort complaint at multiple sites. Individual technicians keep treating each case independently. What is the BEST senior response?',
  '[{"key":"A","text":"Compare the installations for a common design, application, setup, airflow, or control cause and address the pattern systematically"},{"key":"B","text":"Replace thermostats at every site"},{"key":"C","text":"Add refrigerant at every site"},{"key":"D","text":"Increase blower speed everywhere"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated complaint across similar installations suggests a shared root cause rather than unrelated failures.'
),
(
  19,
  'scenario',
  'scenario',
  'A repair restores cooling, but measured compressor current remains abnormal and discharge conditions are still outside expected limits. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Continue diagnosis until the abnormal operating conditions are understood and corrected before closing the job"},{"key":"B","text":"Close the job because cooling returned"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Ignore measurements once comfort improves"}]'::jsonb,
  '["A"]'::jsonb,
  'A resolved symptom does not prove a healthy system when important operating measurements remain abnormal.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit shows recurring misdiagnosis, repeated parts replacement, incomplete measurements, undocumented safety resets, recharge-only leak calls, and poor post-repair verification across several crews. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement a controlled HVAC diagnostic program with standardized methods, training, escalation criteria, documentation, technical review, verification, and corrective-action tracking"},{"key":"B","text":"Increase parts inventory"},{"key":"C","text":"Let each technician keep a personal troubleshooting method"},{"key":"D","text":"Reduce diagnostic time targets"}]'::jsonb,
  '["A"]'::jsonb,
  'A broad pattern of diagnostic-quality failures requires systematic technical and quality-control improvement.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '03a8af61-555e-4e4a-bb99-43225c7ecf80';
  v_installer_role_id uuid := '7a7a4a06-45d7-4bca-af67-ede5df4fb915';
  v_design_sales_role_id uuid := '0264d850-dbb5-4c65-b968-78e49e46e186';
  v_service_role_id uuid := '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52';
  v_senior_role_id uuid := 'df49a251-f3d9-44f1-84a2-dd62858bffb0';
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
  where lower(i.slug) = 'hvac'
     or lower(i.name) = 'hvac'
  order by case when lower(i.slug) = 'hvac' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'HVAC industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'HVAC Diagnostics & Troubleshooting'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Diagnostics & Troubleshooting Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_installer_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Installer / Helper'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current HVAC Installer / Helper L1 HVAC Diagnostics & Troubleshooting requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_design_sales_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Design & Sales Engineer'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L2 HVAC Diagnostics & Troubleshooting requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_service_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Service & Repair Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current HVAC Service & Repair Technician L3 HVAC Diagnostics & Troubleshooting requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_senior_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Senior / Lead HVAC Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Senior / Lead HVAC Technician L4 HVAC Diagnostics & Troubleshooting requirement not found';
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
  -- Seed Level 1
  -- ========================================================================

  v_level := 1;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'HVAC Diagnostics & Troubleshooting — Level 1 Competency Assessment';

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
    select * from _seed_hvac_diagnostics_troubleshooting_l1_questions
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
        'HVAC Diagnostics & Troubleshooting',
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
      'IntegrateU HVAC Diagnostics & Troubleshooting L1 production assessment v1.0.',
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
      v_installer_role_id
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
        'HVAC Diagnostics & Troubleshooting',
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
        'IntegrateU HVAC Diagnostics & Troubleshooting L1 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'HVAC Diagnostics & Troubleshooting — Level 2 Competency Assessment';

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
    select * from _seed_hvac_diagnostics_troubleshooting_l2_questions
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
        'HVAC Diagnostics & Troubleshooting',
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
      'IntegrateU HVAC Diagnostics & Troubleshooting L2 production assessment v1.0.',
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
      v_design_sales_role_id
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
        'HVAC Diagnostics & Troubleshooting',
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
        'IntegrateU HVAC Diagnostics & Troubleshooting L2 production assessment v1.0.',
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
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'HVAC Diagnostics & Troubleshooting — Level 3 Competency Assessment';

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
    select * from _seed_hvac_diagnostics_troubleshooting_l3_questions
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
        'HVAC Diagnostics & Troubleshooting',
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
      'IntegrateU HVAC Diagnostics & Troubleshooting L3 production assessment v1.0.',
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
        'HVAC Diagnostics & Troubleshooting',
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
        'IntegrateU HVAC Diagnostics & Troubleshooting L3 production assessment v1.0.',
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
  v_role_template_id := v_senior_role_id;
  v_assessment_name := 'HVAC Diagnostics & Troubleshooting — Level 4 Competency Assessment';

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
    select * from _seed_hvac_diagnostics_troubleshooting_l4_questions
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
        'HVAC Diagnostics & Troubleshooting',
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
      'IntegrateU HVAC Diagnostics & Troubleshooting L4 production assessment v1.0.',
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
        'HVAC Diagnostics & Troubleshooting',
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
        'IntegrateU HVAC Diagnostics & Troubleshooting L4 production assessment v1.0.',
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
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
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
   '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid
  and a.target_level in (1,2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 3 Service & Repair        -> 20
--   Level 4 Senior / Lead           -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 1 and ra.master_role_template_id =
    '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid;

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
    '03a8af61-555e-4e4a-bb99-43225c7ecf80'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
