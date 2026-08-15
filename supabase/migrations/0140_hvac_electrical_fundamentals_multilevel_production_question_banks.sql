-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0140_hvac_electrical_fundamentals_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Electrical Fundamentals
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

create temporary table _seed_hvac_electrical_fundamentals_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_fundamentals_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is voltage in an electrical circuit?',
  '[{"key":"A","text":"The electrical potential that can cause current to flow"},{"key":"B","text":"The amount of airflow through a duct"},{"key":"C","text":"The resistance of refrigerant piping"},{"key":"D","text":"The temperature of a conductor"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage is electrical potential difference and is one of the basic quantities used to understand HVAC electrical circuits.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is electrical current?',
  '[{"key":"A","text":"The flow of electric charge through a circuit"},{"key":"B","text":"The pressure inside a refrigerant line"},{"key":"C","text":"The temperature difference across a coil"},{"key":"D","text":"The speed of air through a grille"}]'::jsonb,
  '["A"]'::jsonb,
  'Current is the flow of electric charge and is commonly measured in amperes.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does electrical resistance describe?',
  '[{"key":"A","text":"How strongly a material or circuit opposes current flow"},{"key":"B","text":"How fast a blower turns"},{"key":"C","text":"How much refrigerant is in a system"},{"key":"D","text":"How much static pressure is in a duct"}]'::jsonb,
  '["A"]'::jsonb,
  'Resistance opposes current flow and is commonly measured in ohms.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a fuse or circuit breaker in an HVAC electrical circuit?',
  '[{"key":"A","text":"To provide overcurrent protection"},{"key":"B","text":"To regulate refrigerant flow"},{"key":"C","text":"To increase motor speed"},{"key":"D","text":"To measure airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Fuses and circuit breakers protect conductors and equipment from excessive current.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of equipment grounding?',
  '[{"key":"A","text":"To provide a low-resistance fault-current path that supports protective-device operation"},{"key":"B","text":"To increase operating voltage"},{"key":"C","text":"To reduce refrigerant pressure"},{"key":"D","text":"To improve airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment grounding helps reduce shock risk by providing an intentional path for fault current.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is a basic difference between line voltage and low-voltage control wiring in HVAC systems?',
  '[{"key":"A","text":"They serve different circuit functions and may operate at different voltage levels"},{"key":"B","text":"Low-voltage wiring cannot carry current"},{"key":"C","text":"Line voltage is used only for thermostats"},{"key":"D","text":"They are always interchangeable"}]'::jsonb,
  '["A"]'::jsonb,
  'HVAC equipment commonly uses higher-voltage power circuits and lower-voltage control circuits for different purposes.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an electrical schematic?',
  '[{"key":"A","text":"To show how electrical components and circuits are connected and intended to operate"},{"key":"B","text":"To show duct insulation thickness only"},{"key":"C","text":"To show refrigerant charge amount only"},{"key":"D","text":"To replace all field measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Schematics help technicians understand circuit relationships and the intended electrical sequence.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should electrical measurements be made with a meter rated for the circuit being tested?',
  '[{"key":"A","text":"To help ensure the instrument is suitable for the voltage and environment involved"},{"key":"B","text":"To increase circuit voltage"},{"key":"C","text":"To reduce airflow"},{"key":"D","text":"To make the fuse larger"}]'::jsonb,
  '["A"]'::jsonb,
  'The test instrument must be appropriate for the circuit and conditions being measured.'
),
(
  9,
  'multiple_choice',
  'application',
  'A thermostat is blank and the HVAC system will not respond. What is a reasonable first electrical check?',
  '[{"key":"A","text":"Verify that the control circuit has the required power"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Replace the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'A blank thermostat can result from loss of control power, so the control-power path should be checked before major components are replaced.'
),
(
  10,
  'multiple_choice',
  'application',
  'A wire connection is visibly loose at a terminal. What should be done?',
  '[{"key":"A","text":"De-energize as required and correct the connection using the approved procedure"},{"key":"B","text":"Leave it if the equipment still runs"},{"key":"C","text":"Increase the fuse size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Loose electrical connections can create intermittent operation, overheating, or failure and should be corrected safely.'
),
(
  11,
  'multiple_choice',
  'application',
  'A fuse opens again immediately after replacement. What is the BEST response?',
  '[{"key":"A","text":"Stop and investigate the electrical fault causing excessive current rather than installing a larger fuse"},{"key":"B","text":"Install the next larger fuse"},{"key":"C","text":"Bypass the fuse"},{"key":"D","text":"Increase control voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated fuse operation indicates a fault or overcurrent condition that should be diagnosed, not overridden.'
),
(
  12,
  'multiple_choice',
  'application',
  'An installer finds damaged insulation on a control wire where it passes through sheet metal. What is the BEST action?',
  '[{"key":"A","text":"Repair or replace the damaged wiring and protect it from the metal edge"},{"key":"B","text":"Leave it because the circuit is low voltage"},{"key":"C","text":"Increase transformer size"},{"key":"D","text":"Tape the metal panel only"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged insulation can create shorts or unintended contact and should be corrected.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician measures no voltage where voltage is expected in a circuit. What should happen next?',
  '[{"key":"A","text":"Trace the circuit upstream to determine where the expected voltage is lost"},{"key":"B","text":"Replace every downstream component"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'Tracing the circuit helps identify the point where power is interrupted.'
),
(
  14,
  'multiple_choice',
  'application',
  'A motor will not start and the disconnect serving the equipment is off. What is the BEST conclusion?',
  '[{"key":"A","text":"The missing power condition should be corrected through the approved startup procedure before assuming motor failure"},{"key":"B","text":"The motor is defective"},{"key":"C","text":"The thermostat must be replaced"},{"key":"D","text":"The refrigerant charge is low"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic power availability should be confirmed before equipment components are condemned.'
),
(
  15,
  'multiple_choice',
  'application',
  'A technician sees a conductor that is not fully inserted under a terminal screw. What should be done?',
  '[{"key":"A","text":"Correct the termination so the conductor is securely connected as intended"},{"key":"B","text":"Leave it because some contact exists"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable electrical connection requires proper conductor termination.'
),
(
  16,
  'multiple_choice',
  'application',
  'A schematic shows a switch in series with a load. What happens to current through that branch when the switch opens?',
  '[{"key":"A","text":"The circuit path is interrupted and current through that branch stops"},{"key":"B","text":"Current doubles automatically"},{"key":"C","text":"Voltage becomes refrigerant pressure"},{"key":"D","text":"The load operates faster"}]'::jsonb,
  '["A"]'::jsonb,
  'An open series switch interrupts the current path through the load.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer energizes a new system and the low-voltage fuse opens immediately. What is the BEST response?',
  '[{"key":"A","text":"De-energize as required and inspect the control circuit for miswiring, damaged conductors, or a short before replacing the fuse again"},{"key":"B","text":"Install a larger fuse"},{"key":"C","text":"Bypass the fuse"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Immediate fuse operation after installation strongly suggests an electrical fault that should be located before power is restored.'
),
(
  18,
  'scenario',
  'scenario',
  'A blower works intermittently. Lightly moving a wire at a terminal causes the blower to start and stop. What is the BEST response?',
  '[{"key":"A","text":"Treat the terminal or conductor as an intermittent electrical connection and correct it safely"},{"key":"B","text":"Replace the blower motor immediately"},{"key":"C","text":"Increase the fuse size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Operation that changes with wire movement indicates a likely connection or conductor fault.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician measures the correct supply voltage entering a disconnect but no voltage leaving it when the disconnect should be closed. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate the disconnect and its connections as the likely point where power is being interrupted"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparing voltage before and after a device helps isolate where the power path is interrupted.'
),
(
  20,
  'scenario',
  'scenario',
  'A helper sees another worker preparing to replace a breaker with a larger one because the existing breaker keeps tripping. What is the BEST electrical principle?',
  '[{"key":"A","text":"The cause of the overcurrent or trip should be diagnosed before changing protective-device rating"},{"key":"B","text":"A larger breaker is always safer"},{"key":"C","text":"Breakers should be sized by convenience"},{"key":"D","text":"Protective devices are optional on HVAC equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Protective-device operation is a warning of an electrical condition that should be investigated rather than overridden.'
);

create temporary table _seed_hvac_electrical_fundamentals_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_fundamentals_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is electrical load information important when selecting HVAC equipment?',
  '[{"key":"A","text":"It helps determine whether the available electrical service and branch circuit can support the equipment"},{"key":"B","text":"It determines refrigerant type"},{"key":"C","text":"It replaces load calculations"},{"key":"D","text":"It determines duct insulation thickness"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment electrical requirements must be compatible with the available electrical supply and intended circuit design.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does nameplate voltage indicate?',
  '[{"key":"A","text":"The electrical supply voltage range or rating intended for the equipment"},{"key":"B","text":"The refrigerant pressure at startup"},{"key":"C","text":"The required airflow through the coil"},{"key":"D","text":"The thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment nameplate voltage identifies the supply characteristics for which the equipment is designed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should HVAC electrical requirements be coordinated during equipment replacement design?',
  '[{"key":"A","text":"Replacement equipment may have different voltage, current, overcurrent-protection, or disconnect requirements"},{"key":"B","text":"All HVAC equipment uses identical electrical requirements"},{"key":"C","text":"Electrical requirements matter only after installation"},{"key":"D","text":"Thermostat voltage determines branch-circuit size"}]'::jsonb,
  '["A"]'::jsonb,
  'A replacement unit should be compatible with the building electrical system and required protective devices.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a disconnecting means near HVAC equipment?',
  '[{"key":"A","text":"To provide a means of isolating equipment from its electrical supply for service as required"},{"key":"B","text":"To control refrigerant flow"},{"key":"C","text":"To balance duct airflow"},{"key":"D","text":"To drain condensate"}]'::jsonb,
  '["A"]'::jsonb,
  'A disconnect provides a defined means of isolating equipment from electrical power for servicing and safety.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is phase information important when specifying some HVAC equipment?',
  '[{"key":"A","text":"The equipment must be compatible with the type of electrical supply available at the site"},{"key":"B","text":"Phase determines duct static pressure"},{"key":"C","text":"Phase determines refrigerant type"},{"key":"D","text":"Phase applies only to thermostat circuits"}]'::jsonb,
  '["A"]'::jsonb,
  'Some HVAC equipment is designed for specific single-phase or three-phase electrical supplies.'
),
(
  6,
  'multiple_choice',
  'application',
  'A replacement condensing unit requires a different voltage than the existing unit. What is the BEST response?',
  '[{"key":"A","text":"Verify the site electrical supply and coordinate an approved electrical solution before selecting or installing the equipment"},{"key":"B","text":"Install the unit and use the existing circuit anyway"},{"key":"C","text":"Change the thermostat"},{"key":"D","text":"Adjust refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should not be selected without confirming compatibility with the available electrical supply.'
),
(
  7,
  'multiple_choice',
  'application',
  'A proposed rooftop unit has higher electrical current requirements than the unit being replaced. What should be evaluated?',
  '[{"key":"A","text":"Branch-circuit conductors, overcurrent protection, disconnect, available service capacity, and other applicable electrical requirements"},{"key":"B","text":"Thermostat color only"},{"key":"C","text":"Duct liner only"},{"key":"D","text":"Condensate slope only"}]'::jsonb,
  '["A"]'::jsonb,
  'Higher electrical load may require changes to the circuit and supporting electrical infrastructure.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer wants to add electric auxiliary heat to an existing system. What electrical issue should be considered?',
  '[{"key":"A","text":"The added heating load may significantly increase electrical demand and require circuit or service evaluation"},{"key":"B","text":"Electric heat reduces branch-circuit demand"},{"key":"C","text":"Electric heat has no effect on service capacity"},{"key":"D","text":"Only thermostat wiring matters"}]'::jsonb,
  '["A"]'::jsonb,
  'Electric resistance heat can add substantial electrical load and must be considered in system planning.'
),
(
  9,
  'multiple_choice',
  'application',
  'A design includes equipment requiring three-phase power, but the site has only single-phase service available. What is the BEST response?',
  '[{"key":"A","text":"Select compatible equipment or coordinate an approved electrical-supply solution before proceeding"},{"key":"B","text":"Install the three-phase equipment on the single-phase circuit"},{"key":"C","text":"Increase fuse size"},{"key":"D","text":"Use thermostat wiring to supply the missing phase"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment and available electrical supply must be compatible.'
),
(
  10,
  'multiple_choice',
  'application',
  'A replacement air handler has a larger electric-heater package than the original. What should be reviewed before final equipment selection?',
  '[{"key":"A","text":"Electrical load, circuit requirements, overcurrent protection, conductors, disconnecting means, and service capacity"},{"key":"B","text":"Filter color"},{"key":"C","text":"Return-grille finish"},{"key":"D","text":"Refrigerant line insulation only"}]'::jsonb,
  '["A"]'::jsonb,
  'Larger electric heat can materially change the electrical requirements of the installation.'
),
(
  11,
  'multiple_choice',
  'application',
  'A system design uses several HVAC units on a commercial project. Why should the electrical requirements of all units be coordinated?',
  '[{"key":"A","text":"Their combined demand can affect panel, feeder, service, and distribution planning"},{"key":"B","text":"Each HVAC unit creates its own electrical supply"},{"key":"C","text":"Combined demand affects refrigerant type only"},{"key":"D","text":"Electrical coordination is unnecessary if thermostats are low voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple pieces of equipment contribute to total electrical demand and must be coordinated with the building distribution system.'
),
(
  12,
  'multiple_choice',
  'application',
  'A nameplate indicates equipment requires a dedicated branch circuit. What should the design reflect?',
  '[{"key":"A","text":"An appropriate dedicated electrical circuit and associated protection consistent with the equipment requirements"},{"key":"B","text":"Sharing the circuit with lighting"},{"key":"C","text":"Supplying the equipment from thermostat wiring"},{"key":"D","text":"Eliminating the disconnect"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment requirements should be reflected in the electrical design and installation plan.'
),
(
  13,
  'multiple_choice',
  'application',
  'A proposed HVAC replacement appears to fit mechanically but has significantly different electrical requirements. What is the BEST conclusion?',
  '[{"key":"A","text":"Mechanical fit alone is not enough; electrical compatibility must also be verified before selection"},{"key":"B","text":"Electrical requirements can be ignored if the cabinet dimensions match"},{"key":"C","text":"The thermostat will adapt automatically"},{"key":"D","text":"Refrigerant charge can compensate"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment replacement requires coordination of mechanical and electrical requirements.'
),
(
  14,
  'multiple_choice',
  'application',
  'A customer asks whether a larger HVAC system can be installed on the existing electrical circuit. What is the BEST response?',
  '[{"key":"A","text":"Review the proposed equipment electrical requirements and existing circuit capacity before making that determination"},{"key":"B","text":"Assume any larger unit will work"},{"key":"C","text":"Install a larger breaker without further review"},{"key":"D","text":"Use a smaller thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Circuit suitability must be based on actual equipment requirements and existing electrical capacity.'
),
(
  15,
  'scenario',
  'scenario',
  'A replacement heat pump is selected without checking the existing electrical service. During project review, the new unit is found to require substantially more current than the old one. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate equipment selection and electrical-system capacity before installation proceeds"},{"key":"B","text":"Install a larger breaker only"},{"key":"C","text":"Reduce refrigerant charge"},{"key":"D","text":"Change thermostat settings"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical compatibility should be resolved before installation rather than improvised in the field.'
),
(
  16,
  'scenario',
  'scenario',
  'A commercial HVAC proposal includes equipment with three-phase requirements, but the project drawings show single-phase service at the installation area. What is the BEST Level 2 response?',
  '[{"key":"A","text":"Flag the mismatch and coordinate equipment or electrical-design changes before finalizing the proposal"},{"key":"B","text":"Assume the installer can convert the power"},{"key":"C","text":"Increase thermostat voltage"},{"key":"D","text":"Ignore the discrepancy"}]'::jsonb,
  '["A"]'::jsonb,
  'An electrical-supply mismatch should be resolved during design and proposal coordination.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer wants to upgrade from gas heat to a large electric heat package. The existing HVAC branch circuit is modestly sized. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the added electrical load and coordinate any necessary circuit, panel, feeder, or service changes before recommending the conversion"},{"key":"B","text":"Reuse the existing circuit automatically"},{"key":"C","text":"Increase thermostat wire size only"},{"key":"D","text":"Lower the heating setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Changing to electric resistance heat can significantly alter electrical demand and infrastructure requirements.'
),
(
  18,
  'scenario',
  'scenario',
  'A design uses multiple new rooftop units on a building whose electrical service is already heavily loaded. What is the BEST response?',
  '[{"key":"A","text":"Coordinate the combined HVAC electrical demand with the building electrical capacity before final equipment selection"},{"key":"B","text":"Select equipment without considering total load"},{"key":"C","text":"Reduce duct size"},{"key":"D","text":"Use smaller thermostats"}]'::jsonb,
  '["A"]'::jsonb,
  'Aggregate HVAC load can affect the building electrical system and should be coordinated during design.'
),
(
  19,
  'scenario',
  'scenario',
  'A project proposal specifies replacement equipment based only on heating and cooling capacity. No one has reviewed voltage, phase, or current requirements. What is the BEST response?',
  '[{"key":"A","text":"Add electrical compatibility review before the equipment selection is finalized"},{"key":"B","text":"Proceed because capacity is the only important criterion"},{"key":"C","text":"Let the installer decide after delivery"},{"key":"D","text":"Increase the refrigerant charge allowance"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical requirements are a basic part of equipment application and should be reviewed before procurement.'
),
(
  20,
  'scenario',
  'scenario',
  'A sales proposal includes a larger HVAC unit that would require electrical upgrades not included in the quoted scope. What is the BEST Level 2 response?',
  '[{"key":"A","text":"Identify and communicate the required electrical work or revise the equipment solution before the proposal is finalized"},{"key":"B","text":"Leave the electrical upgrades for the customer to discover later"},{"key":"C","text":"Install the unit on the existing circuit"},{"key":"D","text":"Increase thermostat voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A technically sound proposal should account for known electrical requirements and scope impacts.'
);

create temporary table _seed_hvac_electrical_fundamentals_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_fundamentals_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in HVAC Electrical Fundamentals?',
  '[{"key":"A","text":"Replacing electrical components whenever equipment will not start"},{"key":"B","text":"Independently interpreting schematics, tracing power and control circuits, taking appropriate measurements, and isolating electrical faults"},{"key":"C","text":"Increasing breaker size when circuits trip"},{"key":"D","text":"Treating every electrical problem as a thermostat fault"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires systematic electrical diagnosis using circuit knowledge, schematics, and measurements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is voltage measured across a component or circuit point during troubleshooting?',
  '[{"key":"A","text":"To determine the electrical potential difference present at that location"},{"key":"B","text":"To measure airflow"},{"key":"C","text":"To determine refrigerant type"},{"key":"D","text":"To measure resistance without isolating the circuit"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage measurements help determine whether the expected electrical potential is available at a component or point in the circuit.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should resistance or continuity generally be checked on a de-energized circuit using the approved procedure?',
  '[{"key":"A","text":"The meter applies its own test signal, and energized circuits can create unsafe conditions or invalid measurements"},{"key":"B","text":"Resistance can only exist when power is off"},{"key":"C","text":"De-energizing increases circuit resistance permanently"},{"key":"D","text":"Voltage and resistance are the same measurement"}]'::jsonb,
  '["A"]'::jsonb,
  'Resistance and continuity checks are normally performed with the circuit safely de-energized and isolated as required.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to compare measured motor current with expected operating information?',
  '[{"key":"A","text":"Abnormal current can indicate loading, voltage, motor, or system problems that require further diagnosis"},{"key":"B","text":"Current directly determines refrigerant type"},{"key":"C","text":"All motors should draw the same current"},{"key":"D","text":"Current is unrelated to motor operation"}]'::jsonb,
  '["A"]'::jsonb,
  'Motor current provides useful evidence about electrical and mechanical operating conditions.'
),
(
  5,
  'multiple_choice',
  'application',
  'A contactor coil receives the correct control voltage, but the contactor does not pull in. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate the contactor coil and mechanical condition before condemning upstream controls"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Increase control voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct control voltage at the coil narrows the fault toward the contactor itself or its mechanical operation.'
),
(
  6,
  'multiple_choice',
  'application',
  'A motor has proper supply voltage but draws excessive current and runs hot. What should the technician evaluate?',
  '[{"key":"A","text":"Motor condition, mechanical loading, supply voltage quality, and the driven system"},{"key":"B","text":"Thermostat color"},{"key":"C","text":"Refrigerant line insulation only"},{"key":"D","text":"Duct paint"}]'::jsonb,
  '["A"]'::jsonb,
  'High motor current can result from motor defects, abnormal load, or poor electrical supply conditions.'
),
(
  7,
  'multiple_choice',
  'application',
  'A fuse repeatedly opens when a particular load is energized. What is the BEST diagnostic approach?',
  '[{"key":"A","text":"Isolate and inspect the load circuit for short circuits, grounded conductors, failed components, or excessive current draw"},{"key":"B","text":"Install a larger fuse"},{"key":"C","text":"Bypass the fuse"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated overcurrent protection operation associated with one load points to a fault or abnormal current condition in that circuit.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician measures correct voltage entering a switch but no voltage leaving it when the switch should be closed. What does this suggest?',
  '[{"key":"A","text":"The switch or its connection may be interrupting the circuit and should be evaluated"},{"key":"B","text":"The thermostat is definitely failed"},{"key":"C","text":"The refrigerant charge is low"},{"key":"D","text":"The blower is oversized"}]'::jsonb,
  '["A"]'::jsonb,
  'A voltage comparison across a device helps identify where the circuit path is interrupted.'
),
(
  9,
  'multiple_choice',
  'application',
  'A three-phase motor hums but does not start correctly after electrical work. What should the technician verify?',
  '[{"key":"A","text":"The presence and condition of all required phases, connections, protective devices, and motor circuit components"},{"key":"B","text":"Refrigerant charge"},{"key":"C","text":"Thermostat setpoint"},{"key":"D","text":"Filter size"}]'::jsonb,
  '["A"]'::jsonb,
  'A phase-loss or connection problem can prevent proper three-phase motor operation.'
),
(
  10,
  'multiple_choice',
  'application',
  'A low-voltage transformer has proper primary voltage but no secondary voltage. What is the BEST diagnostic direction?',
  '[{"key":"A","text":"Evaluate the transformer, its protective device, and the secondary circuit for a fault or failed transformer"},{"key":"B","text":"Replace the thermostat only"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Primary power with no secondary output narrows the problem toward the transformer or its secondary protection and circuit.'
),
(
  11,
  'multiple_choice',
  'application',
  'A motor contactor chatters during operation. What should the technician investigate?',
  '[{"key":"A","text":"Control voltage stability, coil condition, wiring connections, and the control circuit feeding the coil"},{"key":"B","text":"Refrigerant type"},{"key":"C","text":"Duct size only"},{"key":"D","text":"Condensate drain slope"}]'::jsonb,
  '["A"]'::jsonb,
  'Contactor chatter can result from unstable control voltage, poor connections, or a failing coil.'
),
(
  12,
  'scenario',
  'scenario',
  'A condenser fan motor does not run. Proper line voltage is present at the motor terminals, but the motor does not rotate and becomes hot. What is the BEST response?',
  '[{"key":"A","text":"Continue diagnosis of the motor, starting components if applicable, and mechanical condition rather than replacing upstream controls"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper voltage at the motor terminals indicates that the fault is likely downstream of the supply path.'
),
(
  13,
  'scenario',
  'scenario',
  'An indoor blower intermittently stops. Voltage at the motor disappears when the fault occurs, but remains present upstream of a relay. What is the BEST diagnostic conclusion?',
  '[{"key":"A","text":"The relay or its connections are a likely interruption point and should be evaluated"},{"key":"B","text":"The blower motor is definitely failed"},{"key":"C","text":"The thermostat is definitely failed"},{"key":"D","text":"The refrigerant charge is low"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparing voltage on both sides of circuit devices helps isolate where power is being lost.'
),
(
  14,
  'scenario',
  'scenario',
  'A compressor contactor repeatedly drops out even though the thermostat call remains present. Control voltage at the contactor coil also drops out. What is the BEST response?',
  '[{"key":"A","text":"Trace the control circuit upstream to identify which control or safety is removing coil voltage"},{"key":"B","text":"Replace the contactor automatically"},{"key":"C","text":"Increase line voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'If coil voltage disappears, the technician should trace the upstream control path rather than assume the contactor itself is the cause.'
),
(
  15,
  'scenario',
  'scenario',
  'A breaker trips only when an electric heater stage energizes. Other HVAC functions operate normally. What is the BEST response?',
  '[{"key":"A","text":"Isolate and evaluate the heater circuit, wiring, current draw, and associated components before resetting or changing protection"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A fault tied to one stage should be isolated to that circuit and diagnosed rather than masked by changing protective-device size.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician finds one leg of a three-phase supply missing at the equipment disconnect. What is the BEST response?',
  '[{"key":"A","text":"Do not continue normal operation; identify and correct the upstream supply or protective-device issue using the approved procedure"},{"key":"B","text":"Run the equipment on the remaining phases"},{"key":"C","text":"Increase thermostat voltage"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing phase voltage is an abnormal electrical condition that can damage equipment and should be corrected before operation.'
),
(
  17,
  'scenario',
  'scenario',
  'A motor is drawing significantly higher current than expected, but supply voltage is normal. The driven blower wheel is difficult to turn. What is the BEST conclusion?',
  '[{"key":"A","text":"The excessive mechanical load may be contributing to the high motor current and should be corrected"},{"key":"B","text":"The thermostat is causing the high current"},{"key":"C","text":"The refrigerant charge must be low"},{"key":"D","text":"The breaker should be enlarged"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical current can reflect mechanical loading, so both electrical and mechanical conditions should be considered.'
),
(
  18,
  'scenario',
  'scenario',
  'A transformer replacement fails again shortly after installation. The secondary circuit has not been checked for shorts or excessive load. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Diagnose the secondary circuit and connected load before installing another transformer"},{"key":"B","text":"Install a larger transformer without review"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase fuse size"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated transformer failure suggests an unresolved downstream fault or loading problem.'
),
(
  19,
  'scenario',
  'scenario',
  'A compressor will not run. The contactor is closed, correct supply voltage is present at the compressor, and the control circuit is satisfied. What is the BEST next step?',
  '[{"key":"A","text":"Continue diagnosis of the compressor circuit and compressor condition using appropriate electrical tests and manufacturer information"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'With power and control conditions confirmed, diagnosis should focus on the compressor circuit and component itself.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician replaces a motor after finding it inoperative, but the replacement motor also fails to run. No voltage measurements were taken before replacement. What is the BEST troubleshooting lesson?',
  '[{"key":"A","text":"Verify the electrical supply and control path before condemning the load component"},{"key":"B","text":"Replace the motor again"},{"key":"C","text":"Install a larger breaker"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Component replacement without confirming power and control conditions can lead to unnecessary parts replacement.'
);

create temporary table _seed_hvac_electrical_fundamentals_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_electrical_fundamentals_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in HVAC Electrical Fundamentals?',
  '[{"key":"A","text":"Replacing components whenever a fault appears"},{"key":"B","text":"Leading complex electrical diagnosis, validating system interactions, and guiding others using measurements, schematics, and manufacturer requirements"},{"key":"C","text":"Increasing protective-device ratings to prevent nuisance trips"},{"key":"D","text":"Treating all faults as isolated component failures"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes advanced diagnosis, system-level reasoning, technical leadership, and verification of safe corrective action.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is voltage imbalance important when evaluating three-phase HVAC equipment?',
  '[{"key":"A","text":"Even modest voltage imbalance can create much larger current imbalance and excessive motor heating"},{"key":"B","text":"Voltage imbalance affects refrigerant type only"},{"key":"C","text":"It is harmless if average voltage is correct"},{"key":"D","text":"It applies only to thermostat circuits"}]'::jsonb,
  '["A"]'::jsonb,
  'Three-phase voltage imbalance can produce disproportionate current imbalance and motor heating, so phase-to-phase conditions should be evaluated.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of comparing measured electrical values with manufacturer data and the schematic sequence of operation?',
  '[{"key":"A","text":"To determine whether the circuit and components are operating as designed and to isolate abnormal conditions"},{"key":"B","text":"To avoid taking measurements"},{"key":"C","text":"To determine refrigerant color"},{"key":"D","text":"To increase circuit capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced diagnosis relies on measured evidence compared with expected values and intended sequence.'
),
(
  4,
  'multiple_choice',
  'application',
  'A three-phase compressor has acceptable average voltage but one phase-to-phase reading differs noticeably from the others. What should a senior technician do?',
  '[{"key":"A","text":"Calculate and evaluate voltage imbalance and investigate the source before assuming the compressor is defective"},{"key":"B","text":"Ignore the difference because average voltage is acceptable"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Average voltage alone can conceal harmful phase imbalance.'
),
(
  5,
  'multiple_choice',
  'application',
  'A motor repeatedly fails after replacement. Supply voltage appears normal during a quick unloaded check. What is the BEST advanced approach?',
  '[{"key":"A","text":"Evaluate voltage and current under operating load, connections, phase balance if applicable, mechanical loading, and control conditions"},{"key":"B","text":"Install another motor immediately"},{"key":"C","text":"Increase overcurrent protection"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures require system-level diagnosis under actual operating conditions rather than repeated component replacement.'
),
(
  6,
  'multiple_choice',
  'application',
  'A control transformer repeatedly opens its secondary protection. What should be verified before increasing transformer capacity?',
  '[{"key":"A","text":"Actual connected load, short circuits, grounded conductors, wiring defects, and the manufacturer-required transformer rating"},{"key":"B","text":"Only thermostat setpoint"},{"key":"C","text":"Refrigerant charge"},{"key":"D","text":"Blower-wheel cleanliness only"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated secondary overcurrent indicates an underlying load or circuit problem that should be identified before capacity is changed.'
),
(
  7,
  'multiple_choice',
  'application',
  'A senior technician finds excessive voltage drop across a closed contactor under load. What does that evidence suggest?',
  '[{"key":"A","text":"High resistance at the contacts or connections may be causing heating and loss of voltage to the load"},{"key":"B","text":"The contactor is functioning perfectly"},{"key":"C","text":"The thermostat requires replacement"},{"key":"D","text":"The refrigerant charge is low"}]'::jsonb,
  '["A"]'::jsonb,
  'A significant voltage drop across a closed connection or contact under load indicates abnormal resistance.'
),
(
  8,
  'multiple_choice',
  'application',
  'A variable-speed HVAC motor receives proper line voltage but does not operate as commanded. What is the BEST next diagnostic direction?',
  '[{"key":"A","text":"Evaluate the required control signals, communication inputs if applicable, module status, and manufacturer diagnostic information"},{"key":"B","text":"Assume the motor is mechanically seized"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Change refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Electronically controlled motors may require correct power plus control or communication inputs, so both sides must be evaluated.'
),
(
  9,
  'multiple_choice',
  'application',
  'A rooftop unit experiences intermittent electrical faults only during peak operation. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Capture voltage, current, control states, and operating conditions during the failure to correlate the electrical event with system load"},{"key":"B","text":"Replace random components between failures"},{"key":"C","text":"Increase fuse sizes"},{"key":"D","text":"Ignore the fault if the unit restarts"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent faults are best diagnosed by gathering evidence during the actual failure condition.'
),
(
  10,
  'multiple_choice',
  'application',
  'A junior technician proposes bypassing a safety control because it repeatedly interrupts operation. What is the BEST senior-level response?',
  '[{"key":"A","text":"Determine why the safety is opening and correct the underlying condition rather than defeating the protective function"},{"key":"B","text":"Approve the bypass if comfort is restored"},{"key":"C","text":"Increase control voltage"},{"key":"D","text":"Replace the thermostat without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Protective controls should not be defeated as a substitute for diagnosing the condition that causes them to operate.'
),
(
  11,
  'scenario',
  'scenario',
  'A three-phase compressor trips on overload after several minutes. Line voltage is within the nominal range, but measured phase currents are significantly unequal. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate phase-to-phase voltage imbalance, connections, contactor condition, winding condition, and system loading before condemning the compressor"},{"key":"B","text":"Install larger overload protection"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Add refrigerant automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Unequal phase current requires investigation of supply imbalance, connection resistance, motor condition, and mechanical or refrigerant loading.'
),
(
  12,
  'scenario',
  'scenario',
  'A large air handler intermittently loses control power. The transformer tests normally when the unit is idle. Failures occur only when several actuators energize together. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Measure secondary voltage and current during simultaneous actuator operation and compare total control load with transformer capacity"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Increase primary breaker size"},{"key":"D","text":"Ignore the failure because idle voltage is normal"}]'::jsonb,
  '["A"]'::jsonb,
  'A control transformer can appear normal at light load yet experience excessive voltage drop or overload under peak control demand.'
),
(
  13,
  'scenario',
  'scenario',
  'A compressor contactor shows discoloration and one pole has substantially higher voltage drop than the other poles under load. What is the BEST conclusion?',
  '[{"key":"A","text":"The abnormal contact resistance is likely creating heating and phase imbalance and the contactor should be addressed"},{"key":"B","text":"The contactor is operating normally"},{"key":"C","text":"The thermostat is the cause"},{"key":"D","text":"The refrigerant circuit must be restricted"}]'::jsonb,
  '["A"]'::jsonb,
  'Unequal voltage drop across contactor poles is strong evidence of abnormal contact resistance.'
),
(
  14,
  'scenario',
  'scenario',
  'A new inverter-driven HVAC system experiences repeated communication faults after installation. Power wiring and low-voltage communication wiring share a routing path for a long distance. What is the BEST response?',
  '[{"key":"A","text":"Review manufacturer wiring, shielding, grounding, separation, and routing requirements and correct any installation that can introduce electrical interference"},{"key":"B","text":"Increase the branch-circuit breaker"},{"key":"C","text":"Replace the compressor immediately"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Sensitive communication circuits can be affected by improper routing, grounding, shielding, or electrical interference.'
),
(
  15,
  'scenario',
  'scenario',
  'A senior technician is called after two compressors have failed on the same system within a year. What is the BEST electrical strategy before authorizing another replacement?',
  '[{"key":"A","text":"Review operating voltage, phase balance, current, contactor condition, connections, protective controls, and fault history under actual load"},{"key":"B","text":"Install the same compressor and clear the history"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Replace the thermostat only"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated major-component failure warrants root-cause analysis of the electrical and operating environment.'
),
(
  16,
  'scenario',
  'scenario',
  'A unit trips a breaker only on the hottest afternoons. Static electrical checks in the morning show no problem. What is the BEST Level 4 diagnostic plan?',
  '[{"key":"A","text":"Collect voltage, current, temperature, and operating-load data during peak conditions when the trip occurs"},{"key":"B","text":"Install a larger breaker"},{"key":"C","text":"Replace all contactors"},{"key":"D","text":"Reduce thermostat wire size"}]'::jsonb,
  '["A"]'::jsonb,
  'Faults tied to peak operating conditions require measurements during those conditions to identify the actual cause.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician reports that a motor has correct voltage, but the senior technician notices the voltage was measured with the motor disconnected. What is the BEST response?',
  '[{"key":"A","text":"Repeat appropriate measurements under load because poor connections or supply problems may only appear when current is flowing"},{"key":"B","text":"Accept the unloaded reading as conclusive"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase overcurrent protection"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage under load can reveal resistance and supply problems that are not visible in an unloaded measurement.'
),
(
  18,
  'scenario',
  'scenario',
  'A packaged unit has repeated low-voltage control failures. Several field-installed accessories were added over time, but no one updated the control-load calculation. What is the BEST response?',
  '[{"key":"A","text":"Inventory the connected control loads, calculate actual demand, verify transformer capacity, and inspect the circuit for faults before modifying the system"},{"key":"B","text":"Install the largest available transformer"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Bypass the fuse"}]'::jsonb,
  '["A"]'::jsonb,
  'Control-system modifications should be evaluated against transformer capacity and actual connected load.'
),
(
  19,
  'scenario',
  'scenario',
  'A junior technician finds a repeated breaker trip and recommends replacing the breaker because it is warm. What is the BEST senior-level response?',
  '[{"key":"A","text":"Measure circuit current, inspect connections, verify breaker and conductor ratings, evaluate the connected load, and determine whether the breaker is responding to an actual overcurrent condition"},{"key":"B","text":"Replace it with a larger breaker"},{"key":"C","text":"Bypass it temporarily"},{"key":"D","text":"Reduce thermostat voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Breaker temperature alone does not establish breaker failure; circuit loading, connections, ratings, and operating conditions must be evaluated.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex HVAC system has an intermittent fault involving line power, low-voltage controls, and equipment safeties. Several technicians have replaced parts without resolving it. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Reconstruct the intended sequence from schematics and manufacturer data, define measurement points, reproduce the fault safely, collect evidence, and isolate the exact stage where operation deviates"},{"key":"B","text":"Continue replacing likely components"},{"key":"C","text":"Increase protective-device ratings"},{"key":"D","text":"Bypass the safeties until the failure becomes permanent"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 diagnosis uses a structured evidence-based process to isolate complex system-level electrical faults rather than relying on parts swapping.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'ad5897f1-65b3-49fe-83ad-800b238d68ff';
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
      and c.name = 'HVAC Electrical Fundamentals'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Electrical Fundamentals Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 HVAC Electrical Fundamentals requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L2 HVAC Electrical Fundamentals requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 HVAC Electrical Fundamentals requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 HVAC Electrical Fundamentals requirement not found';
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
  v_assessment_name := 'HVAC Electrical Fundamentals — Level 1 Competency Assessment';

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
    select * from _seed_hvac_electrical_fundamentals_l1_questions
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
        'HVAC Electrical Fundamentals',
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
      'IntegrateU HVAC Electrical Fundamentals L1 production assessment v1.0.',
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
        'HVAC Electrical Fundamentals',
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
        'IntegrateU HVAC Electrical Fundamentals L1 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Electrical Fundamentals — Level 2 Competency Assessment';

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
    select * from _seed_hvac_electrical_fundamentals_l2_questions
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
        'HVAC Electrical Fundamentals',
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
      'IntegrateU HVAC Electrical Fundamentals L2 production assessment v1.0.',
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
        'HVAC Electrical Fundamentals',
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
        'IntegrateU HVAC Electrical Fundamentals L2 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Electrical Fundamentals — Level 3 Competency Assessment';

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
    select * from _seed_hvac_electrical_fundamentals_l3_questions
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
        'HVAC Electrical Fundamentals',
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
      'IntegrateU HVAC Electrical Fundamentals L3 production assessment v1.0.',
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
        'HVAC Electrical Fundamentals',
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
        'IntegrateU HVAC Electrical Fundamentals L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Electrical Fundamentals — Level 4 Competency Assessment';

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
    select * from _seed_hvac_electrical_fundamentals_l4_questions
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
        'HVAC Electrical Fundamentals',
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
      'IntegrateU HVAC Electrical Fundamentals L4 production assessment v1.0.',
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
        'HVAC Electrical Fundamentals',
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
        'IntegrateU HVAC Electrical Fundamentals L4 production assessment v1.0.',
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
   'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid
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
      'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid
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
  'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid;

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
    'ad5897f1-65b3-49fe-83ad-800b238d68ff'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
