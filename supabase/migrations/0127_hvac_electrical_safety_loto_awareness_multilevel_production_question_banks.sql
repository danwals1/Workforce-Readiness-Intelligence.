-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0127_hvac_electrical_safety_loto_awareness_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Safety & LOTO Awareness
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

create temporary table _seed_hvac_electrical_safety_loto_awareness_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_safety_loto_awareness_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of lockout/tagout during HVAC service?',
  '[{"key":"A","text":"To prevent unexpected energization or release of hazardous energy while work is being performed"},{"key":"B","text":"To identify which technician arrived first"},{"key":"C","text":"To keep customers from adjusting the thermostat"},{"key":"D","text":"To reduce electrical energy consumption"}]'::jsonb,
  '["A"]'::jsonb,
  'Lockout/tagout is used to control hazardous energy and prevent unexpected energization, startup, or energy release during service work.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Is turning a thermostat to OFF normally the same as isolating hazardous electrical energy?',
  '[{"key":"A","text":"Yes, because the equipment should stop running"},{"key":"B","text":"No, operating controls such as thermostats are not normally energy-isolating devices"},{"key":"C","text":"Yes, but only on residential systems"},{"key":"D","text":"Yes, if the thermostat display turns blank"}]'::jsonb,
  '["B"]'::jsonb,
  'A thermostat or other operating control does not normally provide the physical energy isolation required for hazardous-energy control.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'After opening an HVAC disconnect, what should a qualified worker do before treating exposed electrical parts as deenergized?',
  '[{"key":"A","text":"Assume the equipment is safe because the handle is OFF"},{"key":"B","text":"Verify the absence of voltage using the appropriate procedure and test instrument"},{"key":"C","text":"Wait one minute and begin work"},{"key":"D","text":"Touch the conductor with an insulated screwdriver"}]'::jsonb,
  '["B"]'::jsonb,
  'The position of a disconnect alone does not prove an electrically safe condition; absence of voltage must be properly verified.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Which item can retain hazardous electrical energy after equipment power has been disconnected?',
  '[{"key":"A","text":"A charged capacitor"},{"key":"B","text":"A clean air filter"},{"key":"C","text":"A condensate drain"},{"key":"D","text":"A sheet-metal access panel"}]'::jsonb,
  '["A"]'::jsonb,
  'Capacitors can retain electrical energy after normal power has been disconnected and must be addressed safely.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What should a worker do if a lockout/tagout device has been applied by another authorized worker?',
  '[{"key":"A","text":"Remove it when the equipment is needed"},{"key":"B","text":"Leave it in place and follow the established procedure for the person who applied it or for authorized removal"},{"key":"C","text":"Cut it off if the shift has ended"},{"key":"D","text":"Replace it with a handwritten note"}]'::jsonb,
  '["B"]'::jsonb,
  'Another worker''s lock or tag should not be casually removed; established energy-control procedures govern removal.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should HVAC workers identify all energy sources before beginning service?',
  '[{"key":"A","text":"Because equipment may contain electrical, mechanical, pressure, thermal, or other hazardous energy"},{"key":"B","text":"Because only electrical energy can cause injury"},{"key":"C","text":"Because identifying energy sources replaces the need for verification"},{"key":"D","text":"Because every HVAC unit has exactly two energy sources"}]'::jsonb,
  '["A"]'::jsonb,
  'HVAC equipment can contain multiple forms of hazardous energy, all of which may need to be controlled before work begins.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is the safest basic rule when a worker is not trained or authorized to perform electrical work?',
  '[{"key":"A","text":"Proceed carefully if voltage is below 240 volts"},{"key":"B","text":"Do not perform the electrical task; obtain a qualified and authorized person"},{"key":"C","text":"Use insulated tools and continue"},{"key":"D","text":"Ask the customer for permission"}]'::jsonb,
  '["B"]'::jsonb,
  'Workers should not perform electrical tasks beyond their training, qualification, or authorization.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What does a lockout device primarily do?',
  '[{"key":"A","text":"Physically holds an energy-isolating device in a safe or off position"},{"key":"B","text":"Measures voltage"},{"key":"C","text":"Warns customers about refrigerant"},{"key":"D","text":"Automatically discharges capacitors"}]'::jsonb,
  '["A"]'::jsonb,
  'A lockout device secures an energy-isolating device in a position that prevents energization.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer turns a furnace switch off before replacing a blower assembly. What should happen before hands enter the equipment?',
  '[{"key":"A","text":"Begin work because the switch is off"},{"key":"B","text":"Apply the required energy-control procedure and verify a safe condition"},{"key":"C","text":"Ask another installer to watch the switch"},{"key":"D","text":"Remove the thermostat batteries"}]'::jsonb,
  '["B"]'::jsonb,
  'A switch position alone does not establish complete hazardous-energy control; required isolation and verification must be completed.'
),
(
  10,
  'multiple_choice',
  'application',
  'A disconnect is labeled for one rooftop unit, but the installer is unsure whether the label is correct. What is the BEST action?',
  '[{"key":"A","text":"Trust the label and begin work"},{"key":"B","text":"Confirm the correct energy source and verify the equipment is deenergized before work"},{"key":"C","text":"Turn off every rooftop unit in the building"},{"key":"D","text":"Ask the customer whether the label looks correct"}]'::jsonb,
  '["B"]'::jsonb,
  'Labels can be incorrect or outdated; the correct source and safe condition must be verified before exposure.'
),
(
  11,
  'multiple_choice',
  'application',
  'A helper sees a capacitor inside an outdoor unit after the disconnect has been opened. What should the helper assume?',
  '[{"key":"A","text":"It is safe because line power is off"},{"key":"B","text":"It may still contain stored electrical energy and should be handled only using the required safe procedure"},{"key":"C","text":"It is safe if it is not visibly damaged"},{"key":"D","text":"It can be discharged by touching both terminals with pliers"}]'::jsonb,
  '["B"]'::jsonb,
  'Capacitors may retain stored energy after line power is removed and require proper control and verification.'
),
(
  12,
  'multiple_choice',
  'application',
  'Before using a meter to verify absence of voltage, what should a qualified worker confirm?',
  '[{"key":"A","text":"The meter and test leads are appropriate for the task and in serviceable condition"},{"key":"B","text":"The meter display is the technician''s preferred color"},{"key":"C","text":"The equipment has been off for at least ten minutes"},{"key":"D","text":"The thermostat is set below room temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage verification depends on using an appropriate and serviceable test instrument correctly.'
),
(
  13,
  'multiple_choice',
  'application',
  'An HVAC unit has both a main electrical disconnect and a separate control-power source. What should the energy-control process do?',
  '[{"key":"A","text":"Address only the main disconnect"},{"key":"B","text":"Identify and control every hazardous energy source that could expose the worker"},{"key":"C","text":"Ignore control voltage because it is always harmless"},{"key":"D","text":"Disconnect the thermostat only"}]'::jsonb,
  '["B"]'::jsonb,
  'Multiple energy sources must be identified and controlled when they can create hazardous exposure.'
),
(
  14,
  'multiple_choice',
  'application',
  'A worker discovers a damaged electrical cord on a portable HVAC tool. What is the BEST action?',
  '[{"key":"A","text":"Continue using it if the copper is not visible"},{"key":"B","text":"Remove it from service and follow the employer''s repair or replacement procedure"},{"key":"C","text":"Wrap it loosely with paper tape"},{"key":"D","text":"Use it only on a GFCI circuit"}]'::jsonb,
  '["B"]'::jsonb,
  'Damaged electrical equipment should be removed from service rather than relied upon in an unsafe condition.'
),
(
  15,
  'multiple_choice',
  'application',
  'A technician finishes work and is ready to restore power. What should happen first?',
  '[{"key":"A","text":"Restore power immediately to save time"},{"key":"B","text":"Follow the established restoration procedure and confirm tools, guards, and affected people are in a safe condition"},{"key":"C","text":"Ask the customer to turn the breaker on"},{"key":"D","text":"Remove another worker''s lock"}]'::jsonb,
  '["B"]'::jsonb,
  'Energy restoration should occur only after the equipment and affected personnel are prepared for safe reenergization.'
),
(
  16,
  'multiple_choice',
  'application',
  'An installer is told that a unit cannot start because the thermostat is disconnected. How should the installer treat the equipment before intrusive service?',
  '[{"key":"A","text":"As safely isolated"},{"key":"B","text":"As potentially energized until proper isolation and verification are completed"},{"key":"C","text":"As safe if the indoor fan is not running"},{"key":"D","text":"As safe if the customer confirms the thermostat is disconnected"}]'::jsonb,
  '["B"]'::jsonb,
  'Removing a control signal does not necessarily isolate electrical energy; proper energy-control steps remain necessary.'
),
(
  17,
  'scenario',
  'scenario',
  'An HVAC installer opens the disconnect for an air handler. When the access panel is removed, a small control transformer is still energized from another circuit. What should the installer do?',
  '[{"key":"A","text":"Continue while avoiding the transformer"},{"key":"B","text":"Stop work, identify and isolate the additional source, then verify the equipment is safe"},{"key":"C","text":"Cover the transformer with cardboard"},{"key":"D","text":"Ask another worker to watch the energized area"}]'::jsonb,
  '["B"]'::jsonb,
  'Discovery of an additional energized source means the equipment is not fully isolated and the energy-control process must be corrected.'
),
(
  18,
  'scenario',
  'scenario',
  'A helper sees a technician preparing to remove a lock placed by a coworker who has left the site. What is the BEST response?',
  '[{"key":"A","text":"Help remove it because the coworker is gone"},{"key":"B","text":"Stop and require the employer''s authorized lock-removal procedure to be followed"},{"key":"C","text":"Replace the lock with a tag"},{"key":"D","text":"Cut the lock and text the coworker afterward"}]'::jsonb,
  '["B"]'::jsonb,
  'Removal of another authorized worker''s lock requires the employer''s established exceptional-removal procedure rather than informal removal.'
),
(
  19,
  'scenario',
  'scenario',
  'A rooftop unit has been shut off, but its condenser fan is still spinning from stored mechanical motion and wind. The installer needs to reach through the fan section. What is the BEST action?',
  '[{"key":"A","text":"Reach in because electrical power is off"},{"key":"B","text":"Wait for and control the hazardous motion and verify a safe state before entering the area"},{"key":"C","text":"Stop the blade by hand while wearing gloves"},{"key":"D","text":"Use a screwdriver to jam the fan"}]'::jsonb,
  '["B"]'::jsonb,
  'Hazardous-energy control includes mechanical motion and other stored or residual energy, not only electrical power.'
),
(
  20,
  'scenario',
  'scenario',
  'An installer completes work on equipment under lockout/tagout. Another worker is still servicing a connected component under the same shutdown. What should the installer do?',
  '[{"key":"A","text":"Restore power because the installer''s work is finished"},{"key":"B","text":"Leave the system under the required energy-control process until restoration requirements for all affected workers are satisfied"},{"key":"C","text":"Remove every lock except the other worker''s"},{"key":"D","text":"Energize the unit briefly for testing"}]'::jsonb,
  '["B"]'::jsonb,
  'Energy must not be restored while another protected worker remains exposed; the established restoration procedure must protect everyone involved.'
);

create temporary table _seed_hvac_electrical_safety_loto_awareness_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_safety_loto_awareness_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an energy-isolating device in lockout/tagout?',
  '[{"key":"A","text":"To physically prevent transmission or release of hazardous energy"},{"key":"B","text":"To provide a convenient equipment on/off control"},{"key":"C","text":"To display operating status to the customer"},{"key":"D","text":"To replace voltage verification"}]'::jsonb,
  '["A"]'::jsonb,
  'An energy-isolating device physically prevents the transmission or release of hazardous energy and is distinct from normal operating controls.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is a thermostat normally not considered an energy-isolating device?',
  '[{"key":"A","text":"It controls operation but does not physically isolate all hazardous energy sources"},{"key":"B","text":"It operates only on batteries"},{"key":"C","text":"It cannot affect HVAC equipment"},{"key":"D","text":"It is installed too far from the disconnect"}]'::jsonb,
  '["A"]'::jsonb,
  'A thermostat may command equipment off but does not physically isolate electrical or other hazardous energy.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does verification of absence of voltage establish?',
  '[{"key":"A","text":"That the intended conductors or parts are not energized at the time of testing when the procedure is properly performed"},{"key":"B","text":"That the equipment can never become energized again"},{"key":"C","text":"That every mechanical hazard has been eliminated"},{"key":"D","text":"That lockout/tagout is unnecessary"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage verification confirms the electrical condition at the tested points but does not replace control of all hazardous-energy sources.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Which HVAC component commonly presents stored electrical-energy risk after normal power is removed?',
  '[{"key":"A","text":"Capacitor"},{"key":"B","text":"Air filter"},{"key":"C","text":"Condensate trap"},{"key":"D","text":"Supply grille"}]'::jsonb,
  '["A"]'::jsonb,
  'Capacitors may retain hazardous electrical energy after equipment has been disconnected from line power.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'When should hazardous-energy controls be reconsidered during a job?',
  '[{"key":"A","text":"When the equipment, work scope, or site conditions reveal an energy source not addressed by the original plan"},{"key":"B","text":"Only after an injury occurs"},{"key":"C","text":"Only when the customer requests a change"},{"key":"D","text":"Never once the original plan has been written"}]'::jsonb,
  '["A"]'::jsonb,
  'Energy-control planning must be updated when changed conditions expose hazards not adequately addressed by the original plan.'
),
(
  6,
  'multiple_choice',
  'application',
  'A design engineer reviewing a replacement rooftop unit sees that the existing disconnect does not match the new equipment electrical requirements. What is the BEST response?',
  '[{"key":"A","text":"Specify the new unit and assume the installer will adapt the disconnect"},{"key":"B","text":"Flag the electrical mismatch and require appropriate electrical review and correction in the project scope"},{"key":"C","text":"Reduce the thermostat setting"},{"key":"D","text":"Ignore the disconnect because it is existing equipment"}]'::jsonb,
  '["B"]'::jsonb,
  'Design work should identify electrical conditions that affect safe installation and ensure they are addressed by qualified personnel in the project scope.'
),
(
  7,
  'multiple_choice',
  'application',
  'A mechanical schedule shows an HVAC unit supplied by two electrical sources. How should this affect service-planning documentation?',
  '[{"key":"A","text":"Document only the larger source"},{"key":"B","text":"Identify both sources so hazardous-energy control can account for each one"},{"key":"C","text":"List only the source controlled by the thermostat"},{"key":"D","text":"Delete the electrical information from the schedule"}]'::jsonb,
  '["B"]'::jsonb,
  'Multiple electrical sources should be clearly identified so installers and service personnel can control all applicable hazardous energy.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project drawing places an HVAC disconnect where it would be difficult to access safely during service. What is the BEST action during design review?',
  '[{"key":"A","text":"Leave it unchanged because disconnect location is only an installation concern"},{"key":"B","text":"Coordinate a safe, code-compliant, serviceable location before construction proceeds"},{"key":"C","text":"Remove the disconnect from the design"},{"key":"D","text":"Add a note telling technicians to use extra caution"}]'::jsonb,
  '["B"]'::jsonb,
  'Design review should address safe access and serviceability rather than knowingly passing an avoidable electrical-safety problem into the field.'
),
(
  9,
  'multiple_choice',
  'application',
  'A proposed control package includes a separate transformer that can energize part of the HVAC control circuit when the main unit disconnect is open. What should the project documentation do?',
  '[{"key":"A","text":"Clearly identify the additional source and associated isolation requirements"},{"key":"B","text":"Omit it because control circuits are always harmless"},{"key":"C","text":"Show only the main disconnect"},{"key":"D","text":"Rely on technicians to discover it during service"}]'::jsonb,
  '["A"]'::jsonb,
  'Separate control-power sources are important hazardous-energy information and should be clearly communicated in design and service documentation.'
),
(
  10,
  'multiple_choice',
  'application',
  'An HVAC salesperson is discussing replacement equipment with a customer who wants technicians to service the system without shutting down adjacent processes. What is the BEST response?',
  '[{"key":"A","text":"Promise that energized service will always be possible"},{"key":"B","text":"Avoid promising unsafe work methods and identify operational constraints that may require safe shutdown or qualified electrical planning"},{"key":"C","text":"Tell the customer lockout/tagout applies only to factories"},{"key":"D","text":"Remove electrical service requirements from the proposal"}]'::jsonb,
  '["B"]'::jsonb,
  'Commercial commitments should not assume unsafe service practices; shutdown and energy-control constraints should be recognized during project planning.'
),
(
  11,
  'multiple_choice',
  'application',
  'A replacement project will reuse existing electrical feeders, but their identification in the field is inconsistent with the drawings. What should happen before relying on that information?',
  '[{"key":"A","text":"Use the drawing labels because drawings are always correct"},{"key":"B","text":"Require field verification and correction of discrepancies before the design relies on the identified sources"},{"key":"C","text":"Choose whichever label appears newest"},{"key":"D","text":"Ignore the discrepancy if the equipment currently operates"}]'::jsonb,
  '["B"]'::jsonb,
  'Conflicting field and drawing information should be resolved rather than carried into new work where it could create isolation and service hazards.'
),
(
  12,
  'multiple_choice',
  'application',
  'A project includes equipment with capacitor banks that remain charged after disconnecting line power. What is the BEST design-documentation approach?',
  '[{"key":"A","text":"Provide clear manufacturer and service information addressing stored-energy hazards"},{"key":"B","text":"Omit the information because trained technicians already know every product"},{"key":"C","text":"State that opening the disconnect removes all electrical hazards"},{"key":"D","text":"Recommend discharging capacitors with a screwdriver"}]'::jsonb,
  '["A"]'::jsonb,
  'Known stored-energy hazards should be communicated through appropriate equipment and service documentation.'
),
(
  13,
  'multiple_choice',
  'application',
  'During a proposal review, the customer asks whether a local disconnect can be omitted to reduce cost. What is the BEST response?',
  '[{"key":"A","text":"Remove it immediately because cost controls the design"},{"key":"B","text":"Confirm applicable electrical, equipment, service, and code requirements before changing the design"},{"key":"C","text":"Replace it with a thermostat"},{"key":"D","text":"Let the installer decide after equipment delivery"}]'::jsonb,
  '["B"]'::jsonb,
  'Electrical safety and isolation requirements should be verified before value-engineering decisions alter disconnecting means.'
),
(
  14,
  'multiple_choice',
  'application',
  'An HVAC project includes several identical rooftop units. Why is accurate equipment-to-disconnect labeling important?',
  '[{"key":"A","text":"It helps prevent workers from isolating the wrong unit during service"},{"key":"B","text":"It improves refrigerant efficiency"},{"key":"C","text":"It eliminates the need for voltage testing"},{"key":"D","text":"It allows every disconnect to use the same lock"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear identification reduces the risk of isolating the wrong equipment, though proper verification is still required.'
),
(
  15,
  'scenario',
  'scenario',
  'During design verification, an engineer discovers that an air handler can receive power from both normal building power and an emergency source. The current drawings show only normal power. What is the BEST response?',
  '[{"key":"A","text":"Leave the drawings unchanged because emergency power is rarely used"},{"key":"B","text":"Correct the documentation and coordinate isolation requirements for both sources before the design is issued"},{"key":"C","text":"Add a generic note saying use caution"},{"key":"D","text":"Tell the installer verbally and make no drawing change"}]'::jsonb,
  '["B"]'::jsonb,
  'Multiple power sources create a significant isolation hazard and should be accurately documented and coordinated before construction or service.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer requests a proposal that keeps a critical HVAC system running continuously during a controls retrofit. The planned work may expose technicians to energized parts. What is the BEST design-and-sales response?',
  '[{"key":"A","text":"Promise uninterrupted operation and let the field crew determine how to work live"},{"key":"B","text":"Identify the safety constraint, coordinate qualified electrical planning, and develop a safe shutdown, temporary-system, or approved work strategy"},{"key":"C","text":"Remove electrical work from the written scope but still expect technicians to perform it"},{"key":"D","text":"State that low-voltage controls eliminate all electrical hazards"}]'::jsonb,
  '["B"]'::jsonb,
  'Project planning should surface safety constraints early and develop a safe operational strategy instead of transferring an unsafe commitment to field personnel.'
),
(
  17,
  'scenario',
  'scenario',
  'An equipment submittal shows a factory-installed accessory powered from a separate source that is not shown on the project electrical drawings. What should the HVAC design engineer do?',
  '[{"key":"A","text":"Approve the submittal because the accessory is factory installed"},{"key":"B","text":"Coordinate the additional source into the drawings, labeling, and service-isolation information before approval"},{"key":"C","text":"Delete the accessory without consulting the project team"},{"key":"D","text":"Assume the installer will recognize the extra source"}]'::jsonb,
  '["B"]'::jsonb,
  'A separately powered accessory changes the hazardous-energy profile and should be formally coordinated into project documentation.'
),
(
  18,
  'scenario',
  'scenario',
  'A site survey finds a disconnect labeled AHU-2, while tracing indicates it appears to feed AHU-3. The project will replace AHU-2. What is the BEST next step?',
  '[{"key":"A","text":"Use the label and continue design"},{"key":"B","text":"Treat the discrepancy as unresolved until qualified field verification identifies the actual source and documentation can be corrected"},{"key":"C","text":"Assume AHU-2 and AHU-3 share power"},{"key":"D","text":"Remove both labels"}]'::jsonb,
  '["B"]'::jsonb,
  'An apparent mislabeled disconnect is a serious safety issue and should be resolved through qualified verification before the project relies on it.'
),
(
  19,
  'scenario',
  'scenario',
  'A packaged HVAC system is being selected for an area where service clearance around the electrical compartment would be severely restricted by nearby piping. What is the BEST design response?',
  '[{"key":"A","text":"Proceed because service technicians can work around the piping"},{"key":"B","text":"Coordinate equipment placement and surrounding systems to provide safe required access and working space"},{"key":"C","text":"Specify smaller hand tools"},{"key":"D","text":"Put a warning note on the equipment"}]'::jsonb,
  '["B"]'::jsonb,
  'Safe electrical service access should be addressed during design coordination rather than knowingly creating a hazardous service condition.'
),
(
  20,
  'scenario',
  'scenario',
  'A project team proposes using one disconnecting means for equipment that the manufacturer documentation shows has multiple independent energy inputs. What is the BEST response?',
  '[{"key":"A","text":"Approve it because one visible disconnect is easier to use"},{"key":"B","text":"Reevaluate the design against actual equipment energy sources and applicable requirements so all hazardous inputs can be safely controlled"},{"key":"C","text":"Label the single disconnect ALL POWER regardless of wiring"},{"key":"D","text":"Rely on the thermostat for the remaining sources"}]'::jsonb,
  '["B"]'::jsonb,
  'The energy-control strategy must reflect the equipment''s actual hazardous inputs rather than an oversimplified assumption.'
);

create temporary table _seed_hvac_electrical_safety_loto_awareness_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_safety_loto_awareness_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Electrical Safety & LOTO Awareness?',
  '[{"key":"A","text":"Following electrical instructions only when a supervisor is present"},{"key":"B","text":"Independently identifying hazardous energy, applying appropriate controls, verifying safe conditions, and stopping when conditions exceed authority or qualification"},{"key":"C","text":"Performing energized work whenever it speeds diagnosis"},{"key":"D","text":"Relying on equipment labels without field verification"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent application of electrical-safety and hazardous-energy controls within the technician''s training and authority.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why must HVAC service technicians consider backfeed or alternate electrical sources during lockout/tagout?',
  '[{"key":"A","text":"Because equipment can remain energized from sources other than the obvious main disconnect"},{"key":"B","text":"Because backfeed only affects meter accuracy"},{"key":"C","text":"Because alternate sources are always low voltage"},{"key":"D","text":"Because opening the thermostat creates backfeed"}]'::jsonb,
  '["A"]'::jsonb,
  'Alternate feeds, control transformers, generators, interconnected equipment, or other sources can energize circuits even when the expected disconnect is open.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of testing an electrical meter on a known source before and after verifying absence of voltage?',
  '[{"key":"A","text":"To confirm the test instrument is functioning as expected during the verification process"},{"key":"B","text":"To calibrate the HVAC equipment"},{"key":"C","text":"To eliminate the need for lockout/tagout"},{"key":"D","text":"To discharge all capacitors automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Confirming meter operation before and after testing helps establish that a zero indication reflects the circuit condition rather than a failed instrument.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'When live electrical diagnostic work is necessary, what is the BEST general principle?',
  '[{"key":"A","text":"Treat it as routine HVAC work"},{"key":"B","text":"Perform it only when justified and permitted, using the required qualified-work practices, tools, PPE, and boundaries"},{"key":"C","text":"Use any available meter if the reading is quick"},{"key":"D","text":"Have an unqualified helper hold the probes"}]'::jsonb,
  '["B"]'::jsonb,
  'Energized diagnostic work requires appropriate justification, qualification, and electrical safe-work practices rather than casual exposure.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician opens the rooftop-unit disconnect and verifies zero volts line-to-line but has not checked line-to-ground. What is the BEST response?',
  '[{"key":"A","text":"Begin work because line-to-line is zero"},{"key":"B","text":"Complete the required verification at all relevant points before treating the circuit as deenergized"},{"key":"C","text":"Touch each conductor with an insulated tool"},{"key":"D","text":"Check only the thermostat circuit"}]'::jsonb,
  '["B"]'::jsonb,
  'Absence-of-voltage verification must be completed according to the applicable procedure at the relevant conductors and reference points.'
),
(
  6,
  'multiple_choice',
  'application',
  'A service technician finds a disconnect that opens the compressor circuit but leaves crankcase-heater power energized. What should the technician do before service that could expose that circuit?',
  '[{"key":"A","text":"Ignore the heater because the compressor cannot run"},{"key":"B","text":"Identify and control the remaining electrical source and reverify the equipment condition"},{"key":"C","text":"Remove the heater wires while energized"},{"key":"D","text":"Turn the thermostat off"}]'::jsonb,
  '["B"]'::jsonb,
  'All electrical sources capable of creating hazardous exposure must be identified and controlled, including accessory circuits.'
),
(
  7,
  'multiple_choice',
  'application',
  'A capacitor is suspected to be charged after disconnecting power. What is the BEST technician response?',
  '[{"key":"A","text":"Short the terminals with a screwdriver"},{"key":"B","text":"Follow the approved method for controlling, discharging if required, and verifying stored electrical energy"},{"key":"C","text":"Wait thirty seconds and assume it is discharged"},{"key":"D","text":"Touch one terminal at a time"}]'::jsonb,
  '["B"]'::jsonb,
  'Stored capacitor energy should be controlled using an approved procedure rather than improvised shorting methods.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician needs a live voltage reading to diagnose a contactor problem. What should be established before opening the energized compartment?',
  '[{"key":"A","text":"That the measurement is necessary, the technician is qualified, and the required safe-work controls are in place"},{"key":"B","text":"That the customer is watching"},{"key":"C","text":"That the reading will take less than one minute"},{"key":"D","text":"That insulated gloves are available, regardless of task requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Energized diagnostics should be planned and performed only by qualified personnel using the appropriate electrical-safety controls.'
),
(
  9,
  'multiple_choice',
  'application',
  'A lockout procedure identifies one disconnect, but the technician''s inspection finds a second feed entering the control panel. What is the BEST action?',
  '[{"key":"A","text":"Follow the written procedure exactly and ignore the second feed"},{"key":"B","text":"Stop and correct the energy-control plan to address the additional source before proceeding"},{"key":"C","text":"Place warning tape on the second feed"},{"key":"D","text":"Work around the second feed if it is insulated"}]'::jsonb,
  '["B"]'::jsonb,
  'Field conditions that reveal an unaddressed source require the energy-control plan to be corrected before exposure continues.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician discovers that a lockout device cannot be applied to an older disconnect. What is the BEST response?',
  '[{"key":"A","text":"Use a handwritten tag automatically and continue"},{"key":"B","text":"Follow the employer''s approved energy-control procedure for the specific condition and ensure equivalent required protection is established"},{"key":"C","text":"Have another worker stand at the disconnect"},{"key":"D","text":"Turn off the thermostat instead"}]'::jsonb,
  '["B"]'::jsonb,
  'When normal lockout cannot be applied, the technician must use the employer''s approved procedure and required protective measures rather than improvising.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician completes electrical service and prepares to reenergize the unit. What should be verified before power is restored?',
  '[{"key":"A","text":"Only that the thermostat is calling"},{"key":"B","text":"That tools are removed, guards and covers are restored as required, personnel are clear, and the restoration procedure is satisfied"},{"key":"C","text":"That the customer has paid the invoice"},{"key":"D","text":"That another technician is holding the disconnect"}]'::jsonb,
  '["B"]'::jsonb,
  'Safe reenergization requires restoring the equipment and work area to an appropriate condition and protecting affected personnel.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician locks out a rooftop unit and verifies zero voltage. While replacing a motor, another contractor connects temporary generator power to the same building distribution system. What is the BEST response?',
  '[{"key":"A","text":"Continue because the technician''s lock is still installed"},{"key":"B","text":"Stop work and determine whether the new source can energize the equipment, updating and reverifying energy controls before resuming"},{"key":"C","text":"Ask the contractor not to start the generator until lunch"},{"key":"D","text":"Continue if the motor leads are disconnected"}]'::jsonb,
  '["B"]'::jsonb,
  'A newly introduced source can invalidate the original safe condition and requires reassessment and verification.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician tests a circuit and receives zero volts. The meter is then checked on a known live source and does not respond. What is the BEST conclusion?',
  '[{"key":"A","text":"The HVAC circuit is proven deenergized"},{"key":"B","text":"The original zero reading is not reliable; the instrument issue must be resolved and verification repeated"},{"key":"C","text":"The known live source must also be deenergized"},{"key":"D","text":"The meter can still be used for resistance only"}]'::jsonb,
  '["B"]'::jsonb,
  'A failed post-test instrument check means the absence-of-voltage result cannot be relied upon and must be repeated with a functioning instrument.'
),
(
  14,
  'scenario',
  'scenario',
  'A service technician is troubleshooting an intermittent fault. The unit is energized and the technician notices a loose meter lead with damaged insulation. What is the BEST response?',
  '[{"key":"A","text":"Finish the measurement quickly"},{"key":"B","text":"Stop the energized diagnostic task and replace or properly address the defective test equipment before continuing"},{"key":"C","text":"Wrap the damaged area with paper tape"},{"key":"D","text":"Ask a helper to hold the damaged section"}]'::jsonb,
  '["B"]'::jsonb,
  'Defective electrical test equipment should not be used where it can expose the technician to shock or arc hazards.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician has locked out a furnace but finds the blower wheel still rotating due to airflow from another connected system. Hands must enter the blower compartment. What is the BEST response?',
  '[{"key":"A","text":"Proceed because electrical energy is isolated"},{"key":"B","text":"Control the remaining hazardous mechanical motion and verify a safe state before entering"},{"key":"C","text":"Stop the wheel with a gloved hand"},{"key":"D","text":"Disconnect the thermostat"}]'::jsonb,
  '["B"]'::jsonb,
  'LOTO planning must control hazardous non-electrical energy as well as electrical energy.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician discovers that the disconnect label for RTU-4 actually isolates RTU-5. What is the BEST immediate response?',
  '[{"key":"A","text":"Correct the label after the repair is complete"},{"key":"B","text":"Stop affected work, establish the correct isolation, and report or correct the labeling hazard according to procedure"},{"key":"C","text":"Remember the discrepancy for future visits"},{"key":"D","text":"Turn both thermostats off"}]'::jsonb,
  '["B"]'::jsonb,
  'A mislabeled disconnect can cause serious unexpected energization and should be addressed before service continues.'
),
(
  17,
  'scenario',
  'scenario',
  'Two technicians are working under a group lockout arrangement. One technician finishes and wants the system energized for testing while the other is still exposed. What is the BEST response?',
  '[{"key":"A","text":"Energize briefly if both technicians are verbally warned"},{"key":"B","text":"Maintain hazardous-energy control until the group procedure permits restoration and all protected workers are clear"},{"key":"C","text":"Remove the second technician''s lock"},{"key":"D","text":"Energize only the control circuit"}]'::jsonb,
  '["B"]'::jsonb,
  'Group energy control must protect every worker covered by the shutdown before restoration occurs.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer asks a technician to bypass a disconnect interlock so the cabinet can remain open during normal operation for easier future testing. What is the BEST response?',
  '[{"key":"A","text":"Bypass it if the customer accepts responsibility"},{"key":"B","text":"Do not defeat the safety feature without an approved and applicable procedure; maintain required safeguards"},{"key":"C","text":"Bypass it only during summer"},{"key":"D","text":"Install a warning sticker and leave it bypassed"}]'::jsonb,
  '["B"]'::jsonb,
  'Electrical safety features should not be casually defeated for convenience.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician is preparing to remove a coworker''s personal lock because that coworker left unexpectedly and cannot be reached. What is the BEST action?',
  '[{"key":"A","text":"Cut the lock because production is waiting"},{"key":"B","text":"Follow the employer''s specific authorized removal procedure and required safeguards before any removal occurs"},{"key":"C","text":"Ask the customer to remove it"},{"key":"D","text":"Replace it with a tag and continue"}]'::jsonb,
  '["B"]'::jsonb,
  'Removal of another worker''s personal lock requires the employer''s controlled exceptional-removal process.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician verifies a unit deenergized, begins work, and later hears a control relay energize unexpectedly from a building automation system. What is the BEST response?',
  '[{"key":"A","text":"Continue because the main equipment remains off"},{"key":"B","text":"Stop work immediately, withdraw from the exposure, identify the uncontrolled source, and reestablish verified energy control"},{"key":"C","text":"Ignore the relay if no motor starts"},{"key":"D","text":"Disable the thermostat only"}]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected energization indicates that hazardous energy is not fully controlled and requires immediate stop-work and correction.'
);

create temporary table _seed_hvac_electrical_safety_loto_awareness_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_safety_loto_awareness_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Electrical Safety & LOTO Awareness?',
  '[{"key":"A","text":"Following the written lockout procedure without evaluating changing conditions"},{"key":"B","text":"Leading hazardous-energy planning, validating isolation methods, coaching others, and correcting systemic electrical-safety weaknesses"},{"key":"C","text":"Delegating all electrical-safety decisions to field technicians"},{"key":"D","text":"Allowing experienced workers to decide individually whether lockout is necessary"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes leadership, validation, coaching, and correction of broader hazardous-energy and electrical-safety risks.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the BEST senior-level response when field conditions repeatedly differ from the written energy-control procedure?',
  '[{"key":"A","text":"Tell technicians to improvise as needed"},{"key":"B","text":"Evaluate the recurring discrepancy and route the procedure through the appropriate formal correction or revision process"},{"key":"C","text":"Ignore differences if no injury has occurred"},{"key":"D","text":"Remove the procedure from use without replacement"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated field discrepancies indicate the written procedure may no longer reflect actual energy sources or equipment conditions and should be formally reviewed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a senior HVAC technician treat unexpected energization during verification as more than a one-time field mistake?',
  '[{"key":"A","text":"Because it may indicate a broader failure in labeling, documentation, isolation planning, or energy-control practices"},{"key":"B","text":"Because every unexpected voltage reading requires equipment replacement"},{"key":"C","text":"Because voltage verification should not be performed"},{"key":"D","text":"Because the technician should always assume the meter is defective"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected energization can reveal systemic weaknesses that should be investigated beyond correcting the immediate condition.'
),
(
  4,
  'multiple_choice',
  'application',
  'A lead technician reviews a lockout procedure for a large air handler and sees that it identifies only the main disconnect even though the unit has a separately fed electric heater. What is the BEST response?',
  '[{"key":"A","text":"Approve the procedure because the main disconnect controls the fan"},{"key":"B","text":"Correct the procedure so all hazardous electrical sources are identified and controlled before it is used"},{"key":"C","text":"Add a note telling technicians to be careful around the heater"},{"key":"D","text":"Have technicians discover the heater feed during voltage testing"}]'::jsonb,
  '["B"]'::jsonb,
  'Senior review should identify missing energy sources before workers rely on an incomplete procedure.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician reports that a zero-voltage verification step is difficult to perform because the test points are poorly accessible. What is the BEST lead-level response?',
  '[{"key":"A","text":"Allow the technician to skip verification"},{"key":"B","text":"Evaluate a safe method, equipment modification, approved test point, or other compliant solution that allows proper verification"},{"key":"C","text":"Use the disconnect handle position as proof"},{"key":"D","text":"Require the technician to reach into the energized space"}]'::jsonb,
  '["B"]'::jsonb,
  'A difficult verification step should be solved through safe engineering or procedural controls rather than omitted.'
),
(
  6,
  'multiple_choice',
  'application',
  'A senior technician discovers that technicians are using different informal methods to discharge capacitors. What is the BEST response?',
  '[{"key":"A","text":"Allow each technician to use the method they prefer"},{"key":"B","text":"Establish and reinforce an approved method for controlling and verifying stored capacitor energy"},{"key":"C","text":"Require all capacitors to be shorted with a screwdriver"},{"key":"D","text":"Prohibit capacitor testing entirely"}]'::jsonb,
  '["B"]'::jsonb,
  'Inconsistent control of stored electrical energy should be replaced with an approved, repeatable procedure.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project includes HVAC equipment supplied by normal power, emergency power, and a control transformer. What should the senior technician expect from the energy-control documentation?',
  '[{"key":"A","text":"Only the normal-power disconnect needs to be shown"},{"key":"B","text":"All relevant sources and isolation points should be clearly identified and coordinated"},{"key":"C","text":"Emergency power can be ignored because it is rarely active"},{"key":"D","text":"Control power does not need documentation"}]'::jsonb,
  '["B"]'::jsonb,
  'Effective hazardous-energy control depends on accurate identification of every source that can create exposure.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician proposes performing energized diagnostics because shutting down the system will inconvenience the customer. What is the BEST senior response?',
  '[{"key":"A","text":"Approve it because customer inconvenience is sufficient justification"},{"key":"B","text":"Evaluate whether energized work is actually necessary and permitted, and require the appropriate qualified-work controls if it is"},{"key":"C","text":"Allow it if the technician has performed the task before"},{"key":"D","text":"Have an apprentice perform the measurement"}]'::jsonb,
  '["B"]'::jsonb,
  'Operational inconvenience alone should not automatically justify energized exposure; the task must be evaluated and controlled appropriately.'
),
(
  9,
  'multiple_choice',
  'application',
  'A lead discovers that several rooftop disconnect labels do not match the equipment they actually control. What is the BEST response?',
  '[{"key":"A","text":"Tell technicians to verify carefully and leave the labels unchanged"},{"key":"B","text":"Control the immediate risk and initiate correction of the labeling and documentation systemically"},{"key":"C","text":"Remove all labels permanently"},{"key":"D","text":"Label every disconnect as HVAC"}]'::jsonb,
  '["B"]'::jsonb,
  'Multiple labeling failures indicate a broader safety and documentation problem requiring systematic correction.'
),
(
  10,
  'multiple_choice',
  'application',
  'During planning for a group lockout, several technicians will work on different parts of the same system. What should the lead ensure?',
  '[{"key":"A","text":"Only one person needs protection if the main disconnect is locked"},{"key":"B","text":"The group-control method provides clear personal protection, accountability, communication, and controlled restoration for all covered workers"},{"key":"C","text":"The newest technician holds the only key"},{"key":"D","text":"Workers remove one another''s locks when their tasks finish"}]'::jsonb,
  '["B"]'::jsonb,
  'Group hazardous-energy control must preserve individual worker protection and clear accountability throughout the shutdown.'
),
(
  11,
  'scenario',
  'scenario',
  'A near miss occurs when a technician opens a disconnect labeled RTU-6, verifies zero volts at one point, and then finds another section energized from an undocumented control transformer. No injury occurs. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Isolate the transformer and resume work without further action"},{"key":"B","text":"Control the immediate hazard, correct the energy-control plan and documentation, and evaluate whether similar undocumented sources exist elsewhere"},{"key":"C","text":"Tell the technician to test more locations next time"},{"key":"D","text":"Replace the transformer"}]'::jsonb,
  '["B"]'::jsonb,
  'A serious near miss should trigger both immediate correction and investigation of whether the same systemic hazard may exist on other equipment.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician is troubleshooting a critical cooling system under pressure to restore service quickly. The technician wants to remove electrical PPE because it makes meter placement harder. What is the BEST lead response?',
  '[{"key":"A","text":"Allow it because the outage is critical"},{"key":"B","text":"Stop the unsafe approach and require the diagnostic task to be performed using the applicable safe-work method and protective controls"},{"key":"C","text":"Allow it for measurements under one minute"},{"key":"D","text":"Have another technician hold the meter instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Schedule or operational pressure does not justify abandoning required electrical-safety controls.'
),
(
  13,
  'scenario',
  'scenario',
  'During a group lockout, one technician leaves the site unexpectedly with a personal lock still applied. Operations requests immediate restoration. What is the BEST lead response?',
  '[{"key":"A","text":"Cut the lock because the technician is absent"},{"key":"B","text":"Follow the employer''s specific exceptional-removal procedure and all required safeguards before restoration"},{"key":"C","text":"Have the customer remove the lock"},{"key":"D","text":"Remove every other lock first and energize around it"}]'::jsonb,
  '["B"]'::jsonb,
  'Personal locks require controlled removal procedures when the person who applied the lock is unavailable.'
),
(
  14,
  'scenario',
  'scenario',
  'A replacement air handler is commissioned and the lead discovers that the local disconnect does not isolate a separately fed accessory installed during construction. What is the BEST response?',
  '[{"key":"A","text":"Accept the condition because the accessory is optional"},{"key":"B","text":"Do not close out the safety issue; coordinate correction of isolation, labeling, documentation, and service information before normal use"},{"key":"C","text":"Tell future technicians to unplug the accessory"},{"key":"D","text":"Write the second source on the inside of the panel only"}]'::jsonb,
  '["B"]'::jsonb,
  'Commissioning should identify and resolve hazardous-energy discrepancies before the system enters routine service.'
),
(
  15,
  'scenario',
  'scenario',
  'A senior technician observes an experienced technician repeatedly skipping the post-test meter check after verifying absence of voltage. The readings have always appeared correct. What is the BEST response?',
  '[{"key":"A","text":"Allow it because the technician is experienced"},{"key":"B","text":"Correct the practice and reinforce the complete verification method because instrument function must be confirmed"},{"key":"C","text":"Require the step only on equipment above 480 volts"},{"key":"D","text":"Replace the technician''s meter"}]'::jsonb,
  '["B"]'::jsonb,
  'Experience does not justify omitting a verification step intended to confirm that the test instrument remained functional.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician reports intermittent control voltage even after the expected control source is isolated. The building automation contractor believes the signal cannot be hazardous. What is the BEST lead response?',
  '[{"key":"A","text":"Accept the contractor''s statement and continue"},{"key":"B","text":"Stop affected work until the source is positively identified, evaluated, controlled, and the safe condition is verified"},{"key":"C","text":"Ignore the voltage if the current is believed to be low"},{"key":"D","text":"Disconnect random control wires until the reading disappears"}]'::jsonb,
  '["B"]'::jsonb,
  'An unexplained energized condition should be treated as uncontrolled energy until it is properly identified and controlled.'
),
(
  17,
  'scenario',
  'scenario',
  'A maintenance team reports that a particular disconnect is difficult to lock and workers sometimes rely on tags alone. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Accept tag-only practice because the equipment is old"},{"key":"B","text":"Evaluate and correct the isolation arrangement or establish the approved protective method required for the specific condition"},{"key":"C","text":"Tell technicians to hide the disconnect handle"},{"key":"D","text":"Use verbal notification instead"}]'::jsonb,
  '["B"]'::jsonb,
  'A recurring inability to apply proper energy control is a system-level issue requiring correction rather than normalization of an informal workaround.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician receives a shock while performing energized diagnostics but reports no injury and wants to continue the call. What is the BEST lead response?',
  '[{"key":"A","text":"Continue if the technician feels fine"},{"key":"B","text":"Stop affected work, address the technician according to company and medical-response procedures, control the hazard, and investigate why the exposure occurred"},{"key":"C","text":"Replace the meter and continue"},{"key":"D","text":"Document it only if symptoms appear later"}]'::jsonb,
  '["B"]'::jsonb,
  'An electrical shock event requires immediate attention to the worker and the hazardous condition rather than being treated as an insignificant near miss.'
),
(
  19,
  'scenario',
  'scenario',
  'During a shutdown, another trade requests temporary power restoration for testing while HVAC technicians still have equipment open and locks applied. What is the BEST lead response?',
  '[{"key":"A","text":"Restore power briefly if everyone is verbally warned"},{"key":"B","text":"Maintain energy control until the established group procedure permits restoration and all protected workers are clear"},{"key":"C","text":"Remove the HVAC locks and replace them later"},{"key":"D","text":"Energize only one phase"}]'::jsonb,
  '["B"]'::jsonb,
  'Temporary operational needs do not override the personal protection provided by an active hazardous-energy control process.'
),
(
  20,
  'scenario',
  'scenario',
  'A lead learns that field technicians have created their own handwritten disconnect map because the official drawings are often wrong. What is the BEST response?',
  '[{"key":"A","text":"Continue using the unofficial map indefinitely"},{"key":"B","text":"Verify the actual system, correct the authoritative documentation and labeling, and control how revised information is maintained"},{"key":"C","text":"Destroy both maps"},{"key":"D","text":"Tell technicians to rely only on memory"}]'::jsonb,
  '["B"]'::jsonb,
  'Recurring unofficial workarounds indicate a documentation-control failure that should be formally corrected and maintained.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '9d3ea4c3-0c12-4177-a6df-db5f565c03c4';
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
      and c.name = 'Electrical Safety & LOTO Awareness'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Safety & LOTO Awareness Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 electrical safety requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L2 safety requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 safety requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 safety requirement not found';
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
  v_assessment_name := 'Electrical Safety & LOTO Awareness — Level 1 Competency Assessment';

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
    select * from _seed_hvac_electrical_safety_loto_awareness_l1_questions
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
        'Electrical Safety & LOTO Awareness',
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
      'IntegrateU Electrical Safety & LOTO Awareness L1 production assessment v1.0.',
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
        'Electrical Safety & LOTO Awareness',
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
        'IntegrateU Electrical Safety & LOTO Awareness L1 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Safety & LOTO Awareness — Level 2 Competency Assessment';

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
    select * from _seed_hvac_electrical_safety_loto_awareness_l2_questions
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
        'Electrical Safety & LOTO Awareness',
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
      'IntegrateU Electrical Safety & LOTO Awareness L2 production assessment v1.0.',
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
        'Electrical Safety & LOTO Awareness',
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
        'IntegrateU Electrical Safety & LOTO Awareness L2 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Safety & LOTO Awareness — Level 3 Competency Assessment';

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
    select * from _seed_hvac_electrical_safety_loto_awareness_l3_questions
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
        'Electrical Safety & LOTO Awareness',
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
      'IntegrateU Electrical Safety & LOTO Awareness L3 production assessment v1.0.',
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
        'Electrical Safety & LOTO Awareness',
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
        'IntegrateU Electrical Safety & LOTO Awareness L3 production assessment v1.0.',
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
  v_assessment_name := 'Electrical Safety & LOTO Awareness — Level 4 Competency Assessment';

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
    select * from _seed_hvac_electrical_safety_loto_awareness_l4_questions
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
        'Electrical Safety & LOTO Awareness',
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
      'IntegrateU Electrical Safety & LOTO Awareness L4 production assessment v1.0.',
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
        'Electrical Safety & LOTO Awareness',
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
        'IntegrateU Electrical Safety & LOTO Awareness L4 production assessment v1.0.',
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
   '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
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
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
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
  '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid;

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
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
