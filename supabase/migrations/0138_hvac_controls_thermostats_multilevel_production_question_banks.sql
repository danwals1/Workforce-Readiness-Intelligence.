-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_controls_thermostats_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Controls & Thermostats
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Service & Repair Technician -> Level 3
--   HVAC Design & Sales Engineer     -> Level 3
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

create temporary table _seed_hvac_controls_thermostats_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_controls_thermostats_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a thermostat in a basic HVAC system?',
  '[{"key":"A","text":"To sense space conditions and call for heating or cooling as required"},{"key":"B","text":"To regulate refrigerant pressure directly"},{"key":"C","text":"To lubricate the compressor"},{"key":"D","text":"To drain condensate"}]'::jsonb,
  '["A"]'::jsonb,
  'A thermostat senses space conditions and sends control signals that initiate or stop HVAC operation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should control power be de-energized before working on thermostat wiring when required by the procedure?',
  '[{"key":"A","text":"To reduce electrical shock and accidental short-circuit risk"},{"key":"B","text":"To increase blower speed"},{"key":"C","text":"To raise refrigerant pressure"},{"key":"D","text":"To improve duct airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Control circuits can still be damaged or create shock and short-circuit hazards, so the approved electrical-safety procedure should be followed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does a thermostat cooling call generally request from the HVAC control system?',
  '[{"key":"A","text":"Cooling operation"},{"key":"B","text":"Condensate drainage"},{"key":"C","text":"Filter replacement"},{"key":"D","text":"Refrigerant recovery"}]'::jsonb,
  '["A"]'::jsonb,
  'A cooling call tells the control system that the conditioned space requires cooling.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should thermostat wire conductors be identified before disconnecting them?',
  '[{"key":"A","text":"So they can be reconnected to the correct terminals"},{"key":"B","text":"So the wire becomes insulated"},{"key":"C","text":"So refrigerant pressure remains stable"},{"key":"D","text":"So airflow increases"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct conductor identification helps prevent miswiring during thermostat replacement or service.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a likely result of a loose thermostat-wire connection?',
  '[{"key":"A","text":"Intermittent or failed control operation"},{"key":"B","text":"Higher refrigerant purity"},{"key":"C","text":"Improved airflow"},{"key":"D","text":"Stronger duct joints"}]'::jsonb,
  '["A"]'::jsonb,
  'Loose control connections can interrupt low-voltage signals and cause unreliable HVAC operation.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should a thermostat be mounted in an appropriate location?',
  '[{"key":"A","text":"So it senses conditions representative of the occupied space"},{"key":"B","text":"So it can measure refrigerant pressure"},{"key":"C","text":"So it can drain condensate"},{"key":"D","text":"So it can cool the electrical panel"}]'::jsonb,
  '["A"]'::jsonb,
  'A thermostat located near unusual heat, drafts, or direct sunlight may sense conditions that do not represent the occupied space.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What should an installer do before connecting thermostat wires to unfamiliar equipment terminals?',
  '[{"key":"A","text":"Use the approved wiring diagram or equipment documentation to verify the terminal functions"},{"key":"B","text":"Connect wires by color only"},{"key":"C","text":"Guess based on the previous job"},{"key":"D","text":"Short terminals together until the equipment runs"}]'::jsonb,
  '["A"]'::jsonb,
  'Terminal functions should be verified from reliable equipment information rather than assumed from wire color or habit.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is damaged thermostat-wire insulation a concern?',
  '[{"key":"A","text":"Exposed conductors can short together or contact grounded metal and disrupt the control circuit"},{"key":"B","text":"It increases cooling capacity"},{"key":"C","text":"It improves signal strength"},{"key":"D","text":"It reduces static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged insulation can create unintended electrical contact and cause control faults.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is replacing a thermostat and the existing conductors are not labeled. What is the BEST response?',
  '[{"key":"A","text":"Identify and document each conductor and terminal before disconnecting the old thermostat"},{"key":"B","text":"Remove all wires and reconnect them by color later"},{"key":"C","text":"Twist all conductors together"},{"key":"D","text":"Cut the cable back to the wall"}]'::jsonb,
  '["A"]'::jsonb,
  'Documenting existing connections helps prevent wiring errors during replacement.'
),
(
  10,
  'multiple_choice',
  'application',
  'A thermostat wire has a nick in its insulation where it passes through a metal opening. What should the installer do?',
  '[{"key":"A","text":"Repair or replace the damaged wiring and protect it from the metal edge"},{"key":"B","text":"Leave it because it is low voltage"},{"key":"C","text":"Increase control voltage"},{"key":"D","text":"Wrap only the metal opening with insulation"}]'::jsonb,
  '["A"]'::jsonb,
  'Low-voltage wiring still requires protection from abrasion and damaged insulation.'
),
(
  11,
  'multiple_choice',
  'application',
  'A newly installed thermostat does not power up. What is a reasonable first check?',
  '[{"key":"A","text":"Verify control power and the required wiring connections using the equipment documentation"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Close all registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic control troubleshooting begins with verifying power and correct connections.'
),
(
  12,
  'multiple_choice',
  'application',
  'A thermostat is mounted directly above a warm supply register and cycles the system too quickly. What is the BEST response?',
  '[{"key":"A","text":"Relocate the thermostat to an approved location that better represents room conditions"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Close the return grille"},{"key":"D","text":"Raise blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A thermostat exposed to supply air may sense artificial conditions and control the system poorly.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer sees unused thermostat conductors behind the wall plate. What is the BEST practice?',
  '[{"key":"A","text":"Keep unused conductors safely isolated so they cannot contact active terminals or grounded metal"},{"key":"B","text":"Connect all unused wires together"},{"key":"C","text":"Attach them to any open terminal"},{"key":"D","text":"Strip all insulation from them"}]'::jsonb,
  '["A"]'::jsonb,
  'Unused conductors should be managed so they cannot create unintended electrical connections.'
),
(
  14,
  'multiple_choice',
  'application',
  'A thermostat terminal screw is loose after wiring is completed. What should the installer do?',
  '[{"key":"A","text":"Secure the conductor correctly at the terminal and verify the connection"},{"key":"B","text":"Leave it because the wire touches the terminal"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A secure electrical connection is necessary for reliable control operation.'
),
(
  15,
  'multiple_choice',
  'application',
  'A thermostat replacement has different terminal labels from the old thermostat. What is the BEST response?',
  '[{"key":"A","text":"Use the new thermostat and equipment documentation to determine the correct terminal mapping"},{"key":"B","text":"Match terminals only by their physical position"},{"key":"C","text":"Use wire color alone"},{"key":"D","text":"Connect the old wires randomly and test"}]'::jsonb,
  '["A"]'::jsonb,
  'Different control products may use different terminal arrangements, so terminal functions should be verified from documentation.'
),
(
  16,
  'multiple_choice',
  'application',
  'After thermostat installation, the system does not respond to a cooling call. What should the installer do before replacing components?',
  '[{"key":"A","text":"Check the thermostat setup, control power, wiring, and required equipment connections"},{"key":"B","text":"Replace the compressor immediately"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic setup and wiring should be verified before assuming a major component has failed.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer replaces a thermostat and the indoor blower now runs continuously even when there is no heating or cooling call. What is the BEST response?',
  '[{"key":"A","text":"Verify thermostat settings and control-wire connections against the approved wiring information"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Close supply registers"},{"key":"D","text":"Increase transformer size"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected blower operation after thermostat work can result from setup or wiring errors and should be checked systematically.'
),
(
  18,
  'scenario',
  'scenario',
  'During startup, the system heats when the thermostat is calling for cooling. What is the BEST installer response?',
  '[{"key":"A","text":"Stop and verify thermostat configuration and control wiring before continuing startup"},{"key":"B","text":"Let the system run longer"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Raise the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Opposite-mode operation indicates a control configuration or wiring problem that should be corrected before continued operation.'
),
(
  19,
  'scenario',
  'scenario',
  'A thermostat works intermittently. Inspection finds two conductors barely touching under a loose terminal. What is the BEST response?',
  '[{"key":"A","text":"Correct the terminal connections and verify stable control operation"},{"key":"B","text":"Replace the air filter"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor terminal connections can cause intermittent control signals and should be corrected.'
),
(
  20,
  'scenario',
  'scenario',
  'An installer is about to connect a thermostat to equipment with terminal functions they do not recognize. The wiring diagram is missing from the job packet. What is the BEST response?',
  '[{"key":"A","text":"Stop and obtain reliable equipment documentation before making the control connections"},{"key":"B","text":"Connect the wires by color"},{"key":"C","text":"Try different combinations until the system runs"},{"key":"D","text":"Bypass the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Unknown control terminals should be verified from reliable documentation rather than guessed.'
);

create temporary table _seed_hvac_controls_thermostats_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_controls_thermostats_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in HVAC Controls & Thermostats?',
  '[{"key":"A","text":"Replacing thermostats by matching wire colors only"},{"key":"B","text":"Independently interpreting control sequences, verifying inputs and outputs, diagnosing low-voltage faults, and confirming correct system response"},{"key":"C","text":"Bypassing controls whenever equipment does not start"},{"key":"D","text":"Treating all control failures as thermostat failures"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires systematic control diagnosis rather than component guessing.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is a sequence of operation important when troubleshooting HVAC controls?',
  '[{"key":"A","text":"It shows what conditions and signals should occur in order for the system to operate correctly"},{"key":"B","text":"It determines refrigerant type"},{"key":"C","text":"It replaces electrical measurements"},{"key":"D","text":"It applies only to duct systems"}]'::jsonb,
  '["A"]'::jsonb,
  'The sequence of operation provides the expected control logic against which actual system behavior can be compared.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to verify control voltage before condemning a thermostat or controller?',
  '[{"key":"A","text":"A missing or incorrect power supply can make a good control appear failed"},{"key":"B","text":"Control voltage determines duct size"},{"key":"C","text":"Control voltage increases refrigerant charge"},{"key":"D","text":"Controllers generate their own power in every system"}]'::jsonb,
  '["A"]'::jsonb,
  'Power supply problems can prevent otherwise functional controls from operating.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should a technician distinguish between an input problem and an output problem in a control circuit?',
  '[{"key":"A","text":"The distinction helps isolate whether the control is receiving the correct command and whether it is sending the expected response"},{"key":"B","text":"Inputs and outputs are always the same signal"},{"key":"C","text":"Only outputs can fail"},{"key":"D","text":"Inputs affect refrigerant pressure only"}]'::jsonb,
  '["A"]'::jsonb,
  'Separating inputs from outputs is a basic way to localize control-system faults.'
),
(
  5,
  'multiple_choice',
  'application',
  'A thermostat is calling for cooling, but the outdoor unit does not start. What is the BEST next diagnostic step?',
  '[{"key":"A","text":"Trace the control sequence and verify whether the expected cooling signal reaches each required device"},{"key":"B","text":"Replace the thermostat immediately"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'The control signal should be followed through the sequence before a specific component is condemned.'
),
(
  6,
  'multiple_choice',
  'application',
  'A thermostat display is blank and control voltage is absent at the thermostat. What should the technician investigate next?',
  '[{"key":"A","text":"The control-power source, protective devices, wiring, and upstream circuit conditions"},{"key":"B","text":"Refrigerant charge"},{"key":"C","text":"Supply-air grille size"},{"key":"D","text":"Condensate insulation"}]'::jsonb,
  '["A"]'::jsonb,
  'When control power is missing, the upstream power path should be checked before replacing the thermostat.'
),
(
  7,
  'multiple_choice',
  'application',
  'A system receives a cooling call, but a safety device is open and prevents compressor operation. What is the BEST response?',
  '[{"key":"A","text":"Determine why the safety device is open and correct the underlying condition rather than bypassing it"},{"key":"B","text":"Jump the safety permanently"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety devices should not be bypassed as a substitute for diagnosing the condition that opened them.'
),
(
  8,
  'multiple_choice',
  'application',
  'A thermostat is configured for the wrong equipment type after replacement. What is a likely result?',
  '[{"key":"A","text":"Incorrect staging or operating behavior even if the wiring is otherwise correct"},{"key":"B","text":"Higher refrigerant purity"},{"key":"C","text":"Lower duct leakage"},{"key":"D","text":"Improved compressor lubrication"}]'::jsonb,
  '["A"]'::jsonb,
  'Thermostat configuration must match the connected equipment and control strategy.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician measures the expected control signal leaving the thermostat, but the signal is not present at the equipment terminal. What should be checked?',
  '[{"key":"A","text":"The wiring path, connections, splices, and conductor continuity between the thermostat and equipment"},{"key":"B","text":"Refrigerant charge"},{"key":"C","text":"Air filter size"},{"key":"D","text":"Duct insulation"}]'::jsonb,
  '["A"]'::jsonb,
  'A signal present at one end but absent at the other points to a wiring or connection problem in between.'
),
(
  10,
  'multiple_choice',
  'application',
  'A control transformer repeatedly loses its protective device after thermostat work. What is the BEST approach?',
  '[{"key":"A","text":"Inspect the low-voltage circuit for shorts, miswiring, or damaged conductors before restoring power again"},{"key":"B","text":"Install a larger protective device"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Replace the blower motor"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated protective-device operation indicates an electrical fault that should be located rather than overridden.'
),
(
  11,
  'multiple_choice',
  'application',
  'A space temperature is stable, but the customer reports excessive system cycling after a thermostat replacement. What should be evaluated?',
  '[{"key":"A","text":"Thermostat location, configuration, differential or cycle settings, wiring, and actual equipment response"},{"key":"B","text":"Refrigerant type only"},{"key":"C","text":"Duct color"},{"key":"D","text":"Condensate piping size only"}]'::jsonb,
  '["A"]'::jsonb,
  'Rapid cycling can result from control setup, sensing location, or equipment-response issues.'
),
(
  12,
  'scenario',
  'scenario',
  'A system intermittently loses cooling calls. The thermostat remains powered, but movement of the thermostat cable causes the call to appear and disappear. What is the BEST response?',
  '[{"key":"A","text":"Inspect and correct the wiring or connection fault causing the intermittent control signal"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A control signal that changes with cable movement strongly suggests an intermittent wiring or connection problem.'
),
(
  13,
  'scenario',
  'scenario',
  'A heat-pump system cools normally but heats incorrectly after a thermostat replacement. The technician confirms the thermostat supports the equipment. What is the BEST next step?',
  '[{"key":"A","text":"Verify the heat-pump configuration and control-terminal functions against the equipment documentation"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the indoor blower"},{"key":"D","text":"Close supply registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect heat-pump setup or control mapping can cause improper heating behavior after replacement.'
),
(
  14,
  'scenario',
  'scenario',
  'A thermostat calls for second-stage heating, but the additional stage never operates. First-stage heating works normally. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Trace the second-stage command through the control sequence and verify configuration, wiring, safeties, and the controlled device"},{"key":"B","text":"Replace the thermostat immediately"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Reduce airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'A stage-specific failure should be diagnosed through the control path associated with that stage.'
),
(
  15,
  'scenario',
  'scenario',
  'A rooftop unit receives the correct thermostat call, but the unit control board does not energize the expected output. The required safety inputs are satisfied. What should the technician do?',
  '[{"key":"A","text":"Verify board power, configuration, input status, and expected output before determining whether the controller has failed"},{"key":"B","text":"Bypass the board permanently"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'A controller should be evaluated using its required power, inputs, configuration, and expected outputs before replacement.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer reports the system runs when no heating or cooling is requested. The thermostat indicates no call. What is the BEST response?',
  '[{"key":"A","text":"Check for stuck outputs, shorted control conductors, relay or contactor faults, and controller commands downstream of the thermostat"},{"key":"B","text":"Replace the thermostat automatically"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close the return grille"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected operation with no thermostat call requires checking the downstream control circuit for unintended commands.'
),
(
  17,
  'scenario',
  'scenario',
  'A low-voltage fuse opens immediately whenever one specific control wire is connected. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Isolate and inspect that circuit for a short or miswired device before replacing the fuse again"},{"key":"B","text":"Install a larger fuse"},{"key":"C","text":"Connect the wire directly to line voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'A fault associated with one circuit should be isolated and corrected rather than protected with an oversized device.'
),
(
  18,
  'scenario',
  'scenario',
  'A thermostat senses several degrees warmer than a calibrated room instrument. The thermostat is mounted on a wall containing warm mechanical piping. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the mounting location and relocate or correct the sensing condition as appropriate"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Reduce blower speed"},{"key":"D","text":"Ignore the difference"}]'::jsonb,
  '["A"]'::jsonb,
  'A thermostat can be biased by local heat sources and may need a more representative sensing location.'
),
(
  19,
  'scenario',
  'scenario',
  'A system intermittently stops because a safety input opens. Resetting the thermostat restores operation temporarily. What is the BEST response?',
  '[{"key":"A","text":"Diagnose the condition causing the safety input to open instead of treating thermostat reset as the repair"},{"key":"B","text":"Program the thermostat to reset automatically"},{"key":"C","text":"Bypass the safety"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring safety interruption requires diagnosis of the underlying operating condition.'
),
(
  20,
  'scenario',
  'scenario',
  'A replacement thermostat works in cooling but does not operate the intended fan mode correctly. Wiring appears intact. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Verify thermostat configuration, fan-control logic, terminal assignments, and equipment sequence before replacing hardware"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Control behavior should be checked against configuration and sequence before hardware is condemned.'
);

create temporary table _seed_hvac_controls_thermostats_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_controls_thermostats_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in HVAC Controls & Thermostats?',
  '[{"key":"A","text":"Replacing failed controls without reviewing recurring patterns"},{"key":"B","text":"Leading control-system standards, troubleshooting methods, configuration practices, documentation, and corrective action across technicians and projects"},{"key":"C","text":"Bypassing safeties to keep equipment running"},{"key":"D","text":"Using thermostat replacement as the first response to most control faults"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership over control-system reliability, troubleshooting quality, configuration, documentation, and recurring-failure prevention.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should recurring HVAC control failures be reviewed as a process or system issue?',
  '[{"key":"A","text":"Patterns may reveal common problems with wiring, configuration, power quality, installation, sequence logic, or troubleshooting practices"},{"key":"B","text":"Recurring failures always mean the thermostat brand is defective"},{"key":"C","text":"Each failure should be assumed unrelated"},{"key":"D","text":"Control failures are normal after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures can point to shared root causes that should be corrected beyond the individual service call.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of standardized control documentation?',
  '[{"key":"A","text":"To make sequences, setpoints, configuration, wiring intent, and service changes understandable and traceable"},{"key":"B","text":"To eliminate all field judgment"},{"key":"C","text":"To replace electrical measurements"},{"key":"D","text":"To allow every technician to use different terminal definitions"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear documentation improves troubleshooting consistency, commissioning, future service, and technical accountability.'
),
(
  4,
  'multiple_choice',
  'application',
  'A senior technician finds crews repeatedly replacing thermostats for intermittent faults that later return. What is the BEST response?',
  '[{"key":"A","text":"Require systematic verification of power, wiring, inputs, outputs, configuration, and sequence before condemning controls"},{"key":"B","text":"Stock more thermostats"},{"key":"C","text":"Replace thermostats in pairs"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring unresolved faults suggest the troubleshooting process is too component-focused and needs stronger diagnostic discipline.'
),
(
  5,
  'multiple_choice',
  'application',
  'A branch has frequent low-voltage fuse failures after thermostat replacements. What should the technical lead investigate?',
  '[{"key":"A","text":"Wiring damage, shorts, incorrect terminations, transformer loading, and replacement practices"},{"key":"B","text":"Refrigerant charge"},{"key":"C","text":"Supply duct size"},{"key":"D","text":"Filter replacement frequency only"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated protective-device failures indicate a recurring electrical or installation problem that should be investigated systematically.'
),
(
  6,
  'multiple_choice',
  'application',
  'A controls audit finds inconsistent thermostat configuration across identical equipment. What is the BEST corrective action?',
  '[{"key":"A","text":"Define and verify the approved configuration standard for that equipment and application"},{"key":"B","text":"Allow technicians to select any configuration that appears to work"},{"key":"C","text":"Remove staging capability"},{"key":"D","text":"Increase thermostat setpoint limits"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent equipment applications should use controlled configuration standards to reduce avoidable operating differences.'
),
(
  7,
  'multiple_choice',
  'application',
  'A senior technician reviews a system where a safety input is routinely bypassed during troubleshooting. What is the BEST response?',
  '[{"key":"A","text":"Stop the bypass practice and require diagnosis of the condition that causes the safety to open"},{"key":"B","text":"Make the bypass permanent"},{"key":"C","text":"Increase fuse size"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Safeties should not be defeated as a substitute for diagnosing the underlying operating condition.'
),
(
  8,
  'multiple_choice',
  'application',
  'A company is standardizing thermostat replacements across several equipment types. What should the process include?',
  '[{"key":"A","text":"Equipment compatibility, terminal mapping, configuration, staging, fan logic, safety interaction, startup verification, and documentation"},{"key":"B","text":"Wire color matching only"},{"key":"C","text":"Physical thermostat dimensions only"},{"key":"D","text":"Setpoint adjustment only"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable replacement process must address both electrical compatibility and the intended operating sequence.'
),
(
  9,
  'multiple_choice',
  'application',
  'A facility has recurring comfort complaints caused by thermostats mounted near heat sources. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct affected locations and establish thermostat-placement standards for future work"},{"key":"B","text":"Change setpoints to compensate permanently"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Reduce return airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated sensing-location problem should be corrected both locally and through future installation standards.'
),
(
  10,
  'multiple_choice',
  'application',
  'A senior technician finds control-board replacements being made without documenting failed inputs, outputs, or configuration. What is the BEST response?',
  '[{"key":"A","text":"Require diagnostic evidence and configuration records before and after controller replacement"},{"key":"B","text":"Stop documenting controller work"},{"key":"C","text":"Replace boards whenever a fault code appears"},{"key":"D","text":"Bypass the controller during startup"}]'::jsonb,
  '["A"]'::jsonb,
  'Traceable diagnostic evidence reduces unnecessary replacements and improves future troubleshooting.'
),
(
  11,
  'scenario',
  'scenario',
  'A building has repeated nuisance shutdowns from the same safety input. Multiple technicians reset the system but no one records the operating condition when the safety opens. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Establish a diagnostic plan that captures operating conditions, identifies the root cause, and documents corrective action"},{"key":"B","text":"Program automatic resets"},{"key":"C","text":"Bypass the safety"},{"key":"D","text":"Replace thermostats throughout the building"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated safety trips require data-driven root-cause diagnosis rather than repeated resets.'
),
(
  12,
  'scenario',
  'scenario',
  'A senior technician audits identical rooftop units and finds each has different thermostat staging settings because installers used personal preferences. What is the BEST response?',
  '[{"key":"A","text":"Establish the approved staging configuration, correct affected units, and verify commissioning results"},{"key":"B","text":"Leave them because all units operate"},{"key":"C","text":"Disable second-stage operation"},{"key":"D","text":"Increase thermostat deadband on every unit"}]'::jsonb,
  '["A"]'::jsonb,
  'Identical equipment should use a deliberate, documented control strategy rather than uncontrolled field variation.'
),
(
  13,
  'scenario',
  'scenario',
  'A project experiences repeated transformer failures after controls modifications. Several new field devices were added without checking total control-circuit loading. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the control-power design and connected load, correct the circuit as required, and update modification procedures"},{"key":"B","text":"Install larger fuses"},{"key":"C","text":"Replace transformers with the largest available size without review"},{"key":"D","text":"Remove thermostat displays"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated transformer failures after added loads point to a control-power design and modification-control problem.'
),
(
  14,
  'scenario',
  'scenario',
  'A facility reports several units running unexpectedly with no thermostat call. Investigation finds control wires damaged where they share a rough penetration. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct the damaged wiring, improve physical protection at the penetration, and inspect similar installations for the same defect"},{"key":"B","text":"Replace all thermostats"},{"key":"C","text":"Increase control voltage"},{"key":"D","text":"Ignore the penetration once the wire is repaired"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated physical wiring defect should be corrected at both the affected circuit and the installation-standard level.'
),
(
  15,
  'scenario',
  'scenario',
  'A new building has widespread short cycling after occupancy. The thermostats are installed correctly, but the commissioning records show inconsistent cycle and staging settings. What is the BEST response?',
  '[{"key":"A","text":"Review the intended control sequence, standardize the required configuration, and recommission affected systems"},{"key":"B","text":"Replace every thermostat"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Reduce duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'Widespread configuration inconsistency should be corrected through systematic recommissioning rather than mass component replacement.'
),
(
  16,
  'scenario',
  'scenario',
  'A senior technician finds that technicians frequently jumper control terminals during troubleshooting but do not document what was bypassed or restore wiring consistently. What is the BEST response?',
  '[{"key":"A","text":"Establish controlled diagnostic procedures for temporary test connections, restoration, and documentation"},{"key":"B","text":"Ban all electrical measurements"},{"key":"C","text":"Allow permanent jumpers when equipment runs"},{"key":"D","text":"Increase fuse size"}]'::jsonb,
  '["A"]'::jsonb,
  'Temporary diagnostic actions should be controlled so they do not create unsafe or undocumented permanent changes.'
),
(
  17,
  'scenario',
  'scenario',
  'A repeated control fault disappears whenever a technician opens the electrical panel. No component consistently tests failed. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Investigate intermittent wiring, terminal, connector, vibration, or harness conditions rather than continuing to replace components"},{"key":"B","text":"Replace the thermostat after every occurrence"},{"key":"C","text":"Increase transformer voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'A fault affected by physical movement suggests an intermittent connection that requires targeted diagnosis.'
),
(
  18,
  'scenario',
  'scenario',
  'A controls retrofit works during manual testing but fails under normal automatic operation. The documented sequence was never updated after the retrofit. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the actual control logic with the intended sequence, correct the programming or configuration, and update documentation"},{"key":"B","text":"Keep the system in manual mode"},{"key":"C","text":"Replace all thermostats"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Automatic operation should match the intended sequence, and documentation should reflect the actual approved control logic.'
),
(
  19,
  'scenario',
  'scenario',
  'A senior lead sees repeated callbacks where technicians replace controllers but the original fault returns because a field sensor is intermittently failing. What is the BEST process correction?',
  '[{"key":"A","text":"Strengthen input verification and fault-isolation practices before controller replacement"},{"key":"B","text":"Stock additional controllers"},{"key":"C","text":"Replace controllers and sensors together every time"},{"key":"D","text":"Disable the sensor input"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor input verification can lead to unnecessary controller replacement and unresolved root causes.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit finds recurring control miswiring, inconsistent thermostat setup, undocumented bypasses, unnecessary board replacements, and repeated safety trips across multiple crews. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement a controlled HVAC-controls program with standardized procedures, training, diagnostic methods, documentation, field audits, and corrective-action tracking"},{"key":"B","text":"Replace all thermostats with one model"},{"key":"C","text":"Increase control-transformer sizes everywhere"},{"key":"D","text":"Allow each crew to maintain its own process"}]'::jsonb,
  '["A"]'::jsonb,
  'A broad recurring control-quality problem requires systematic technical and quality-control management.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '333586ac-06a6-4d4e-8a74-916fb0351a5a';
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
      and c.name = 'HVAC Controls & Thermostats'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Controls & Thermostats Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 HVAC Controls & Thermostats requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 HVAC Controls & Thermostats requirement not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L3 HVAC Controls & Thermostats requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 HVAC Controls & Thermostats requirement not found';
  end if;

v_level := 1;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'HVAC Controls & Thermostats — Level 1 Competency Assessment';

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
    select * from _seed_hvac_controls_thermostats_l1_questions
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
        'HVAC Controls & Thermostats',
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
      'IntegrateU HVAC Controls & Thermostats L1 production assessment v1.0.',
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
    values
      (v_master_question_id, v_installer_role_id)
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
        'HVAC Controls & Thermostats',
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
        'IntegrateU HVAC Controls & Thermostats L1 production assessment v1.0.',
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

  v_level := 3;
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'HVAC Controls & Thermostats — Level 3 Competency Assessment';

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
    select * from _seed_hvac_controls_thermostats_l3_questions
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
        'HVAC Controls & Thermostats',
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
      'IntegrateU HVAC Controls & Thermostats L3 production assessment v1.0.',
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
    values
      (v_master_question_id, v_service_role_id),
      (v_master_question_id, v_design_sales_role_id)
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
        'HVAC Controls & Thermostats',
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
        'IntegrateU HVAC Controls & Thermostats L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Controls & Thermostats — Level 4 Competency Assessment';

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
    select * from _seed_hvac_controls_thermostats_l4_questions
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
        'HVAC Controls & Thermostats',
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
      'IntegrateU HVAC Controls & Thermostats L4 production assessment v1.0.',
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
    values
      (v_master_question_id, v_senior_role_id)
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
        'HVAC Controls & Thermostats',
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
        'IntegrateU HVAC Controls & Thermostats L4 production assessment v1.0.',
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
   '333586ac-06a6-4d4e-8a74-916fb0351a5a'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '333586ac-06a6-4d4e-8a74-916fb0351a5a'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L1 HVAC Installer / Helper = 20
--   L3 HVAC Service & Repair Technician = 20
--   L3 HVAC Design & Sales Engineer = 20
--   L4 Senior / Lead HVAC Technician = 20
-- ============================================================================

with q as (
  select
    aq.source_master_question_id,
    a.target_level
  from public.assessments a
  join public.assessment_questions aq
    on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '333586ac-06a6-4d4e-8a74-916fb0351a5a'::uuid
    and a.target_level in (1,3,4)
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  mrt.name as role_name,
  count(distinct ra.master_question_id)::integer
    as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
join public.master_role_templates mrt
  on mrt.id = ra.master_role_template_id
where
  (
    q.target_level = 1
    and mrt.id =
      '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid
  )
  or
  (
    q.target_level = 3
    and mrt.id in (
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid,
      '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid
    )
  )
  or
  (
    q.target_level = 4
    and mrt.id =
      'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
  )
group by
  q.target_level,
  mrt.id,
  mrt.name
order by
  q.target_level,
  mrt.name;

-- ============================================================================

-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '333586ac-06a6-4d4e-8a74-916fb0351a5a'::uuid;

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
    '333586ac-06a6-4d4e-8a74-916fb0351a5a'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
