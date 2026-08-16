-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0160_ci_lighting_control_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Lighting / Control Systems
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Logistics Manager                    -> Level 2
--   Technician III — Lead Technician                 -> Level 3
--   Systems Programmer                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess lighting-control fundamentals,
-- load compatibility, devices, scenes, sensors, system architecture, programming,
-- integration, commissioning, and progressively higher lighting-control judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_lighting_control_systems_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_lighting_control_systems_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a lighting-control system?',
  '[{"key":"A","text":"To control when, where, and how lighting operates"},{"key":"B","text":"To distribute audio signals"},{"key":"C","text":"To terminate network cabling"},{"key":"D","text":"To provide building structural support"}]'::jsonb,
  '["A"]'::jsonb,
  'Lighting-control systems manage the operation and behavior of lighting loads.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a lighting load?',
  '[{"key":"A","text":"The lighting equipment or circuit being controlled"},{"key":"B","text":"A network address assigned to a keypad"},{"key":"C","text":"A drawing used only for rack fabrication"},{"key":"D","text":"The weight of a light fixture"}]'::jsonb,
  '["A"]'::jsonb,
  'A lighting load is the fixture, lamp, driver, or circuit whose output is controlled.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of a dimmer in a lighting-control system?',
  '[{"key":"A","text":"To vary the light output of a compatible lighting load"},{"key":"B","text":"To increase network bandwidth"},{"key":"C","text":"To route video signals"},{"key":"D","text":"To amplify loudspeaker output"}]'::jsonb,
  '["A"]'::jsonb,
  'A dimmer changes the light output of a compatible load rather than providing only simple on-off control.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a lighting-control keypad?',
  '[{"key":"A","text":"To provide user commands for lights, scenes, or other programmed control functions"},{"key":"B","text":"To supply branch-circuit power to every fixture"},{"key":"C","text":"To terminate speaker wiring"},{"key":"D","text":"To measure network throughput"}]'::jsonb,
  '["A"]'::jsonb,
  'A keypad provides an interface for users to activate programmed lighting-control functions.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a lighting scene?',
  '[{"key":"A","text":"A programmed combination of lighting states or levels activated together"},{"key":"B","text":"A list of unused lighting circuits"},{"key":"C","text":"A physical mounting bracket"},{"key":"D","text":"A replacement for system documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A scene recalls predetermined lighting states or levels to create a desired condition.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is an occupancy sensor commonly used to do?',
  '[{"key":"A","text":"Detect occupancy so lighting can respond automatically according to the programmed logic"},{"key":"B","text":"Amplify a lighting circuit"},{"key":"C","text":"Distribute video to multiple displays"},{"key":"D","text":"Provide backup network storage"}]'::jsonb,
  '["A"]'::jsonb,
  'Occupancy sensing can trigger automatic lighting behavior when people enter or leave a space.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why must a technician identify the lighting load type before connecting a control device?',
  '[{"key":"A","text":"Because the control device must be compatible with the electrical characteristics and control method of the load"},{"key":"B","text":"Because every lighting load uses the same dimming method"},{"key":"C","text":"Because the load type determines the room name"},{"key":"D","text":"Because load identification replaces electrical documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Control equipment must be selected and connected according to the characteristics of the load it controls.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is labeling important in a lighting-control installation?',
  '[{"key":"A","text":"It helps identify circuits, loads, devices, control locations, and programmed relationships accurately"},{"key":"B","text":"It increases fixture brightness"},{"key":"C","text":"It eliminates the need for testing"},{"key":"D","text":"It automatically programs the system"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent labeling supports installation accuracy, programming, troubleshooting, documentation, and service.'
),
(
  9,
  'multiple_choice',
  'application',
  'A drawing identifies a dimmer as controlling the dining-room chandelier. What should the technician verify before making the final connection?',
  '[{"key":"A","text":"That the intended circuit and load match the drawing and are compatible with the specified dimmer"},{"key":"B","text":"That the dimmer is connected to any nearby lighting circuit"},{"key":"C","text":"That all room lighting is placed on one circuit"},{"key":"D","text":"That the keypad labels are removed"}]'::jsonb,
  '["A"]'::jsonb,
  'The field connection should match both the documented load assignment and the compatibility requirements of the control device.'
),
(
  10,
  'multiple_choice',
  'application',
  'A keypad button is labeled Evening. What should the technician expect that button to do after programming is complete?',
  '[{"key":"A","text":"Recall the lighting states or levels assigned to the Evening scene"},{"key":"B","text":"Disconnect power from the lighting processor"},{"key":"C","text":"Reset every device to factory defaults"},{"key":"D","text":"Change the electrical panel schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'A scene button should recall the programmed lighting behavior associated with its label.'
),
(
  11,
  'multiple_choice',
  'application',
  'A controlled light turns on and off correctly but does not dim. What should be checked FIRST?',
  '[{"key":"A","text":"Whether the load and control device are intended to support dimming and are correctly connected"},{"key":"B","text":"Whether the room has a television"},{"key":"C","text":"Whether the speaker wiring is labeled"},{"key":"D","text":"Whether the network router has internet access"}]'::jsonb,
  '["A"]'::jsonb,
  'Dimming depends on compatible equipment, correct load type, and proper connection.'
),
(
  12,
  'multiple_choice',
  'application',
  'A lighting-control panel schedule assigns Load 4 to the kitchen pendants. What is the BEST field practice?',
  '[{"key":"A","text":"Connect and label the kitchen-pendant circuit according to the documented Load 4 assignment unless an approved change exists"},{"key":"B","text":"Use any unused output in the panel and leave documentation unchanged"},{"key":"C","text":"Combine the circuit with another load without approval"},{"key":"D","text":"Ignore the panel schedule if the fixture turns on"}]'::jsonb,
  '["A"]'::jsonb,
  'Following documented load assignments preserves design intent and supports programming and future service.'
),
(
  13,
  'multiple_choice',
  'application',
  'An occupancy sensor is intended to turn lights on when the room becomes occupied. What should the technician verify during testing?',
  '[{"key":"A","text":"That occupancy is detected and the assigned lighting responds according to the programmed behavior"},{"key":"B","text":"That every light in the building turns on"},{"key":"C","text":"That the sensor changes the network password"},{"key":"D","text":"That the sensor controls an audio amplifier"}]'::jsonb,
  '["A"]'::jsonb,
  'Sensor testing should confirm both detection and the intended lighting response.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician installs a replacement control device. Which information is MOST important to verify before energizing the circuit?',
  '[{"key":"A","text":"The device rating, load compatibility, wiring connections, and documented circuit assignment"},{"key":"B","text":"Only the color of the wall plate"},{"key":"C","text":"Only the keypad engraving"},{"key":"D","text":"Only the project completion date"}]'::jsonb,
  '["A"]'::jsonb,
  'Safe and correct control operation depends on proper ratings, compatibility, wiring, and circuit identification.'
),
(
  15,
  'multiple_choice',
  'application',
  'A keypad is installed in the correct location but its buttons control the wrong lights. What should be verified?',
  '[{"key":"A","text":"The keypad identity, programmed button assignments, and relationship to the intended loads or scenes"},{"key":"B","text":"Only the wall-box depth"},{"key":"C","text":"Only the lighting fixture wattage"},{"key":"D","text":"The speaker-zone assignment"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect keypad behavior can result from device identification or programming assignments that do not match the design.'
),
(
  16,
  'multiple_choice',
  'application',
  'A lighting load is labeled differently in the control panel than on the project drawing. What should the technician do?',
  '[{"key":"A","text":"Resolve the discrepancy using approved project information before final connection, programming, or labeling"},{"key":"B","text":"Choose whichever label is easier to remember"},{"key":"C","text":"Connect the load randomly and correct it after turnover"},{"key":"D","text":"Remove both labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting identification should be resolved before the system is finalized so field work and documentation remain aligned.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is installing a basic lighting-control system with a dimmer, a compatible lighting load, and a wall keypad. What is the BEST installation approach?',
  '[{"key":"A","text":"Verify the documented circuit and load, confirm dimmer compatibility, connect and label the devices correctly, then test keypad control and dimming operation"},{"key":"B","text":"Install the devices without identifying the load and test only whether power is present"},{"key":"C","text":"Connect the keypad directly to the lighting load regardless of system design"},{"key":"D","text":"Skip labeling because the room is small"}]'::jsonb,
  '["A"]'::jsonb,
  'A basic lighting-control installation requires correct load identification, compatible control equipment, proper connections, labeling, and functional testing.'
),
(
  18,
  'scenario',
  'scenario',
  'A scene called Entertain is supposed to set several room lights to different levels. One light remains at full output every time the scene is activated. What is the BEST first response?',
  '[{"key":"A","text":"Verify that the affected load is correctly identified, connected to the intended control output, and included in the scene programming at the specified level"},{"key":"B","text":"Replace every lighting device in the room"},{"key":"C","text":"Delete all system scenes"},{"key":"D","text":"Disconnect the room keypad"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should verify the affected load path and programming before making broader system changes.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds two unlabeled lighting-control conductors at a panel during installation. What is the BEST response?',
  '[{"key":"A","text":"Identify the conductors using approved drawings, circuit records, endpoints, or appropriate test methods, then label them before final connection"},{"key":"B","text":"Connect each conductor to the nearest available output"},{"key":"C","text":"Join the conductors together"},{"key":"D","text":"Leave them unlabeled after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Lighting-control circuits should be positively identified before connection so the installed system matches the design and remains serviceable.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes installation of a room with controlled lighting, a keypad, and an occupancy sensor. Before handoff, what is the BEST final check?',
  '[{"key":"A","text":"Confirm each load responds correctly, keypad functions match their labels, sensor behavior matches the intended logic, and field labels align with the documentation"},{"key":"B","text":"Confirm only that the lights can be turned on manually"},{"key":"C","text":"Remove all circuit labels after testing"},{"key":"D","text":"Disable the occupancy sensor to simplify turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic commissioning should confirm load operation, user controls, sensor behavior, and documentation alignment.'
);

create temporary table _seed_ci_lighting_control_systems_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_lighting_control_systems_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of a centralized lighting-control processor?',
  '[{"key":"A","text":"To coordinate programmed control logic, devices, loads, and system communication"},{"key":"B","text":"To supply branch-circuit power directly to every fixture"},{"key":"C","text":"To route audio signals"},{"key":"D","text":"To replace electrical panelboards"}]'::jsonb,
  '["A"]'::jsonb,
  'A centralized processor manages lighting-control logic and communication across the system.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is load-type compatibility important when selecting dimming or switching equipment?',
  '[{"key":"A","text":"Different load types and drivers may require specific control methods, ratings, or interfaces"},{"key":"B","text":"All lighting loads respond identically to every dimmer"},{"key":"C","text":"Compatibility matters only for keypad labels"},{"key":"D","text":"Load type affects only fixture color"}]'::jsonb,
  '["A"]'::jsonb,
  'Control devices must match the electrical and control characteristics of the connected lighting load.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of a lighting-control zone?',
  '[{"key":"A","text":"To group one or more lighting loads that are intended to be controlled together"},{"key":"B","text":"To identify a network closet"},{"key":"C","text":"To define the size of a lighting fixture"},{"key":"D","text":"To replace a circuit schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Zones organize loads into logical control groups for operation and programming.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does integration mean in a lighting-control system?',
  '[{"key":"A","text":"Coordinating lighting with other controls, sensors, schedules, or building systems"},{"key":"B","text":"Connecting every fixture to one dimmer"},{"key":"C","text":"Removing all local controls"},{"key":"D","text":"Using only one manufacturer in every project"}]'::jsonb,
  '["A"]'::jsonb,
  'Integration allows lighting to respond to coordinated commands or conditions across connected systems.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of astronomical or time-based scheduling in lighting control?',
  '[{"key":"A","text":"To trigger programmed lighting behavior based on time or calculated sunrise and sunset conditions"},{"key":"B","text":"To increase dimmer capacity"},{"key":"C","text":"To configure speaker zones"},{"key":"D","text":"To assign video inputs"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedules automate lighting behavior based on time or environmental timing references.'
),
(
  6,
  'multiple_choice',
  'application',
  'A dimmable LED load flickers when reduced below 20 percent. What should the technician review first?',
  '[{"key":"A","text":"The dimmer-load compatibility, driver characteristics, configured dimming range, and wiring"},{"key":"B","text":"The room audio level"},{"key":"C","text":"The display resolution"},{"key":"D","text":"The network printer settings"}]'::jsonb,
  '["A"]'::jsonb,
  'Low-end flicker commonly requires review of control compatibility, driver behavior, configuration, and installation.'
),
(
  7,
  'multiple_choice',
  'application',
  'A scene controls six loads, but one load does not respond. What is the BEST first check?',
  '[{"key":"A","text":"Verify the load assignment, control output, device communication, and inclusion in the scene"},{"key":"B","text":"Replace every keypad in the project"},{"key":"C","text":"Delete all scenes"},{"key":"D","text":"Move the load to an unrelated circuit"}]'::jsonb,
  '["A"]'::jsonb,
  'A single nonresponsive load should be traced through its assignment, connection, communication, and programming.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project drawing shows a lighting zone controlled from two keypad locations. What should the technician verify?',
  '[{"key":"A","text":"That both keypads are correctly identified, communicating, and programmed to control the intended zone or scene"},{"key":"B","text":"That both keypads are wired directly to the lighting load regardless of system design"},{"key":"C","text":"That one keypad is disabled"},{"key":"D","text":"That the two locations use different room names"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple control locations should operate the intended lighting functions consistently through the system architecture.'
),
(
  9,
  'multiple_choice',
  'application',
  'An occupancy sensor turns lights off while people are still in the room. What should be reviewed?',
  '[{"key":"A","text":"Sensor placement, coverage, sensitivity, timeout settings, and programmed behavior"},{"key":"B","text":"Only the keypad engraving"},{"key":"C","text":"Only the circuit breaker size"},{"key":"D","text":"The audio source assignment"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected vacancy behavior may result from sensing coverage or configuration rather than a lighting-load failure.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician replaces a dimmer module with a different model. What must be confirmed before returning the system to service?',
  '[{"key":"A","text":"The replacement supports the connected load, required capacity, control method, and system configuration"},{"key":"B","text":"Only that the module fits physically"},{"key":"C","text":"Only that the front label matches"},{"key":"D","text":"That all other modules are also replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement control hardware must be compatible electrically and functionally with the existing system.'
),
(
  11,
  'multiple_choice',
  'application',
  'A keypad button labeled All Off leaves one room illuminated. What should the technician verify?',
  '[{"key":"A","text":"Whether the affected load is included in the All Off programming and correctly assigned to its control device"},{"key":"B","text":"Whether the keypad is mounted level"},{"key":"C","text":"Whether all wall plates match"},{"key":"D","text":"Whether the audio system is powered"}]'::jsonb,
  '["A"]'::jsonb,
  'The issue may be caused by missing programming or an incorrect load assignment.'
),
(
  12,
  'multiple_choice',
  'application',
  'A daylight sensor is intended to reduce electric lighting when sufficient daylight is available. What should be verified during commissioning?',
  '[{"key":"A","text":"Sensor placement, calibration, assigned zones, target levels, and actual lighting response"},{"key":"B","text":"Only that the sensor has power"},{"key":"C","text":"Only that every light reaches 100 percent output"},{"key":"D","text":"That the sensor controls unrelated AV equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Daylight harvesting requires correct sensing, calibration, zone assignment, and programmed response.'
),
(
  13,
  'multiple_choice',
  'application',
  'A project uses both switched and dimmed loads in the same control panel. What is the BEST installation practice?',
  '[{"key":"A","text":"Match each circuit to the correct output type and documented load assignment"},{"key":"B","text":"Connect all loads to dimming outputs regardless of load type"},{"key":"C","text":"Connect loads based only on circuit length"},{"key":"D","text":"Ignore the control-panel schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Each load must be connected to an output designed for its required control method.'
),
(
  14,
  'multiple_choice',
  'application',
  'A lighting-control processor reports a device offline. What should the technician verify before replacing the device?',
  '[{"key":"A","text":"Power, wiring or communication path, addressing or identification, and system configuration"},{"key":"B","text":"Only the room paint color"},{"key":"C","text":"Only the fixture lamp type"},{"key":"D","text":"The project invoice"}]'::jsonb,
  '["A"]'::jsonb,
  'Offline status should be investigated through the device power, communication, identity, and configuration path.'
),
(
  15,
  'scenario',
  'scenario',
  'A client reports that a dining scene works correctly from one keypad but not from another keypad in the same room. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Compare keypad identity, communication status, button programming, and scene assignments between the two locations"},{"key":"B","text":"Replace every lighting load in the room"},{"key":"C","text":"Rewire the entire lighting panel immediately"},{"key":"D","text":"Delete the dining scene"}]'::jsonb,
  '["A"]'::jsonb,
  'Because the scene works from one location, the investigation should focus on the nonworking control point and its programming or communication.'
),
(
  16,
  'scenario',
  'scenario',
  'A home has an Away mode intended to turn off interior lights and leave selected exterior lights on. Activating Away shuts off every light, including the exterior lights. What is the BEST correction?',
  '[{"key":"A","text":"Review the Away scene or mode programming and correct the affected exterior load states while confirming the load assignments"},{"key":"B","text":"Replace all exterior fixtures"},{"key":"C","text":"Disable Away mode permanently"},{"key":"D","text":"Move the exterior loads to unrelated circuits"}]'::jsonb,
  '["A"]'::jsonb,
  'The behavior indicates the mode is executing but the programmed load states do not match the intended outcome.'
),
(
  17,
  'scenario',
  'scenario',
  'A lighting-control panel has been installed and powered. Several loads respond from software but not from the wall keypads. What is the BEST next step?',
  '[{"key":"A","text":"Verify keypad communication, device identification, button assignments, and programming before changing the load wiring"},{"key":"B","text":"Replace all lighting loads"},{"key":"C","text":"Increase dimmer capacity"},{"key":"D","text":"Disconnect the processor"}]'::jsonb,
  '["A"]'::jsonb,
  'If the loads respond from software, the load path is likely functional and the control interface path should be checked next.'
),
(
  18,
  'scenario',
  'scenario',
  'A dimmed LED circuit operates normally at high levels but flickers and drops out near the bottom of the dimming range. What is the BEST response?',
  '[{"key":"A","text":"Review the LED driver and dimmer compatibility, minimum-load requirements, low-end trim, wiring, and manufacturer guidance"},{"key":"B","text":"Increase every lighting scene to full output"},{"key":"C","text":"Replace the control processor first"},{"key":"D","text":"Disable all keypads"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor low-end performance should be addressed through compatibility and configuration of the specific dimming path.'
),
(
  19,
  'scenario',
  'scenario',
  'A conference room uses occupancy sensing and a scheduled shutdown. Users report that lights sometimes remain on overnight. What is the BEST system-level check?',
  '[{"key":"A","text":"Review the occupancy logic, vacancy timeout, schedule, override conditions, and event history to determine which rule is keeping the lights active"},{"key":"B","text":"Replace all fixtures"},{"key":"C","text":"Remove the occupancy sensor"},{"key":"D","text":"Disable all schedules"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple control rules can interact, so the technician should review the complete programmed logic and conditions.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is preparing a lighting-control system for handoff after devices, keypads, sensors, and scenes have been configured. What is the BEST readiness check?',
  '[{"key":"A","text":"Verify each load, keypad, scene, sensor, schedule, labeling scheme, and documented control relationship operates as intended"},{"key":"B","text":"Confirm only that the processor is online"},{"key":"C","text":"Skip functional testing because programming is complete"},{"key":"D","text":"Remove the panel schedule after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete handoff requires verification of the physical, programmed, and documented lighting-control system.'
);

create temporary table _seed_ci_lighting_control_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_lighting_control_systems_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is system architecture important in a larger lighting-control deployment?',
  '[{"key":"A","text":"Loads, controllers, processors, sensors, user interfaces, communication paths, and integrations must operate together as one coordinated system"},{"key":"B","text":"It allows every device to be installed without documentation"},{"key":"C","text":"It eliminates the need to understand load types"},{"key":"D","text":"It guarantees factory-default settings will meet every project requirement"}]'::jsonb,
  '["A"]'::jsonb,
  'Larger lighting-control systems depend on coordinated architecture across physical loads, control devices, communication, programming, and integration.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of a lighting-control communication bus or network?',
  '[{"key":"A","text":"To allow compatible control devices, processors, sensors, and interfaces to exchange commands and status information"},{"key":"B","text":"To provide branch-circuit power to every fixture"},{"key":"C","text":"To replace all dimming modules"},{"key":"D","text":"To eliminate device addressing or identification"}]'::jsonb,
  '["A"]'::jsonb,
  'The control communication path allows distributed devices to participate in coordinated system behavior.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is sequence-of-operations documentation important for integrated lighting control?',
  '[{"key":"A","text":"It defines how lighting should respond to user actions, sensors, schedules, modes, and external system events"},{"key":"B","text":"It identifies only fixture mounting heights"},{"key":"C","text":"It replaces electrical drawings"},{"key":"D","text":"It is used only after the system fails"}]'::jsonb,
  '["A"]'::jsonb,
  'A sequence of operations communicates the intended control logic and interaction between system conditions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should control-system capacity be evaluated during lighting-system design?',
  '[{"key":"A","text":"The processor, panels, communication links, and control architecture must support the required devices, loads, logic, and foreseeable expansion"},{"key":"B","text":"Capacity matters only for wall-box depth"},{"key":"C","text":"Every system has unlimited capacity"},{"key":"D","text":"Capacity affects only keypad engraving"}]'::jsonb,
  '["A"]'::jsonb,
  'System capacity must support both the present control requirements and reasonable future growth.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project adds several lighting zones and sensors after the original control-system design is complete. What should be reviewed before implementation?',
  '[{"key":"A","text":"Processor and panel capacity, device limits, communication topology, power requirements, programming impact, and documentation"},{"key":"B","text":"Only the room names"},{"key":"C","text":"Only fixture finish colors"},{"key":"D","text":"Only the project schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding control points or loads can affect multiple architectural limits and should be evaluated as a system change.'
),
(
  6,
  'multiple_choice',
  'application',
  'A building uses occupancy sensors, daylight sensors, schedules, and manual keypads in the same spaces. What is the BEST programming approach?',
  '[{"key":"A","text":"Define clear priorities and interaction rules so automated and manual commands produce predictable behavior"},{"key":"B","text":"Allow every input to override every other input without defined logic"},{"key":"C","text":"Disable all manual controls"},{"key":"D","text":"Configure each device independently without considering shared loads"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple control sources require coordinated logic so their interactions are understandable and repeatable.'
),
(
  7,
  'multiple_choice',
  'application',
  'A lighting-control system is being integrated with an automation platform that will trigger scenes. What should be verified before commissioning?',
  '[{"key":"A","text":"The supported integration method, command mapping, scene identifiers, communication path, ownership of logic, and expected feedback"},{"key":"B","text":"Only that both systems have power"},{"key":"C","text":"Only that the keypad buttons work locally"},{"key":"D","text":"That both platforms use identical user interfaces"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable integration depends on clearly defined interfaces, commands, responsibilities, and expected responses.'
),
(
  8,
  'multiple_choice',
  'application',
  'A dimming panel controls multiple fixture types with different drivers. What is the BEST configuration practice?',
  '[{"key":"A","text":"Configure each load according to its supported control method, dimming range, electrical characteristics, and manufacturer requirements"},{"key":"B","text":"Use identical dimming settings for every load regardless of driver type"},{"key":"C","text":"Set all low-end trims to zero without testing"},{"key":"D","text":"Ignore fixture substitutions"}]'::jsonb,
  '["A"]'::jsonb,
  'Different fixture and driver combinations can require different control parameters for stable performance.'
),
(
  9,
  'multiple_choice',
  'application',
  'A lighting system has intermittent device communication failures on one branch of the control network. What should guide troubleshooting?',
  '[{"key":"A","text":"Review the documented topology, device status, power, terminations, addressing, communication limits, and errors specific to that branch"},{"key":"B","text":"Replace every lighting fixture in the building"},{"key":"C","text":"Delete all system programming"},{"key":"D","text":"Increase every dimmer output"}]'::jsonb,
  '["A"]'::jsonb,
  'Communication faults should be isolated systematically along the affected control path.'
),
(
  10,
  'multiple_choice',
  'application',
  'A client wants a building-wide Emergency mode that affects selected lighting while preserving code-required behavior. What is the BEST design approach?',
  '[{"key":"A","text":"Define the required emergency behavior, affected loads, control priorities, interfaces, fail states, and applicable project requirements before programming the mode"},{"key":"B","text":"Turn off every load in the system"},{"key":"C","text":"Allow any keypad button to override emergency behavior"},{"key":"D","text":"Treat the mode as a normal decorative scene"}]'::jsonb,
  '["A"]'::jsonb,
  'High-priority operating modes require deliberate definition of control authority, load behavior, and safety-related constraints.'
),
(
  11,
  'multiple_choice',
  'application',
  'A project has field-substituted several LED fixtures after the lighting-control design was approved. What should happen before final programming?',
  '[{"key":"A","text":"Reconcile the actual fixtures and drivers with the specified control methods, ratings, load assignments, and configuration requirements"},{"key":"B","text":"Program the system exactly as originally designed without reviewing substitutions"},{"key":"C","text":"Assume all LED drivers behave identically"},{"key":"D","text":"Remove the affected loads from documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Fixture substitutions can materially change compatibility and dimming behavior and must be reconciled with the control design.'
),
(
  12,
  'scenario',
  'scenario',
  'A residence has Home, Away, Entertain, and Goodnight modes that affect lighting, shades, security, and climate through an automation platform. Lighting behaves correctly locally but sometimes enters the wrong state during whole-home mode changes. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Trace the integration commands, scene identifiers, mode logic, timing, feedback, and ownership of each lighting action across both systems"},{"key":"B","text":"Replace every lighting keypad"},{"key":"C","text":"Delete all local lighting scenes"},{"key":"D","text":"Disconnect the lighting processor from the project"}]'::jsonb,
  '["A"]'::jsonb,
  'Because local lighting operation is correct, the investigation should focus on the integration and coordinated mode logic.'
),
(
  13,
  'scenario',
  'scenario',
  'A large room is divided into two spaces with separate occupancy sensors and keypads. When combined, the client wants both halves to operate as one lighting zone. What is the BEST control strategy?',
  '[{"key":"A","text":"Define divided and combined operating states that coordinate zone grouping, keypad behavior, sensing logic, scenes, and transitions between room modes"},{"key":"B","text":"Require technicians to rewire lighting circuits whenever the partition moves"},{"key":"C","text":"Disable one half of the lighting system in combined mode"},{"key":"D","text":"Use the same fixed programming regardless of partition state"}]'::jsonb,
  '["A"]'::jsonb,
  'Divisible spaces require deliberate state-based control behavior rather than physical rewiring for each configuration.'
),
(
  14,
  'scenario',
  'scenario',
  'A facility has hundreds of lighting-control devices. Several devices near the end of one communication segment drop offline intermittently. What is the BEST systems-level response?',
  '[{"key":"A","text":"Compare the affected segment with topology, distance, device-count, power, termination, and manufacturer communication limits, then isolate the failure point"},{"key":"B","text":"Replace all fixtures throughout the facility"},{"key":"C","text":"Increase every lighting level"},{"key":"D","text":"Reprogram unrelated scenes"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent failures on one segment should be evaluated against the physical and logical limits of that specific communication path.'
),
(
  15,
  'scenario',
  'scenario',
  'A multi-floor office uses scheduled lighting shutdown, occupancy sensing, and local overrides. Energy reports show several floors remain illuminated long after normal hours. What is the BEST corrective approach?',
  '[{"key":"A","text":"Review schedules, occupancy states, override duration, priority rules, event history, and zone assignments to identify why shutdown is being defeated"},{"key":"B","text":"Disable every occupancy sensor"},{"key":"C","text":"Remove local controls from all floors"},{"key":"D","text":"Replace all lighting fixtures"}]'::jsonb,
  '["A"]'::jsonb,
  'Persistent after-hours operation can result from interacting automation rules and should be investigated through system logic and history.'
),
(
  16,
  'scenario',
  'scenario',
  'A high-end residential project has multiple dimmable fixture types. After final trim, several circuits exhibit different low-end performance even though they use the same scene levels. What is the BEST response?',
  '[{"key":"A","text":"Evaluate each affected fixture-driver-control combination and configure appropriate low-end trim or control parameters rather than forcing identical settings"},{"key":"B","text":"Raise every scene to 100 percent"},{"key":"C","text":"Replace the lighting processor"},{"key":"D","text":"Use one universal trim value without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Different dimming technologies can require circuit-specific configuration to achieve consistent visual performance.'
),
(
  17,
  'scenario',
  'scenario',
  'A project manager discovers that field load numbering no longer matches the approved control-panel schedule after several electrical changes. Programming is scheduled to begin. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the actual circuits, loads, outputs, labels, and drawings before programming so system identities match the installed conditions"},{"key":"B","text":"Proceed with the original programming and correct identities after turnover"},{"key":"C","text":"Ignore field labels"},{"key":"D","text":"Rename loads randomly in software"}]'::jsonb,
  '["A"]'::jsonb,
  'Programming depends on accurate correspondence between physical loads, control outputs, and system documentation.'
),
(
  18,
  'scenario',
  'scenario',
  'An exterior-lighting system uses astronomical scheduling but exterior lights begin operating at unexpected times after the project location was changed in software. What should be reviewed?',
  '[{"key":"A","text":"The configured geographic location, time zone, daylight-saving behavior, astronomical offsets, schedules, and affected scene logic"},{"key":"B","text":"Only fixture wattage"},{"key":"C","text":"Only keypad labels"},{"key":"D","text":"The audio-zone configuration"}]'::jsonb,
  '["A"]'::jsonb,
  'Astronomical scheduling depends on correct location and time configuration as well as programmed offsets and schedules.'
),
(
  19,
  'scenario',
  'scenario',
  'A lighting-control processor is being replaced on a large project. What is the BEST preparation before removing the existing processor?',
  '[{"key":"A","text":"Confirm supported backups, configuration files, device addressing, integration dependencies, software compatibility, licensing if applicable, and a documented restoration plan"},{"key":"B","text":"Factory-reset every field device first"},{"key":"C","text":"Remove the processor before capturing any configuration information"},{"key":"D","text":"Assume the replacement will discover and recreate all programming automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Processor replacement should preserve the information and dependencies required to restore the complete system reliably.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex lighting project includes centralized panels, distributed dimmers, keypads, occupancy and daylight sensors, schedules, scenes, third-party integration, and multiple operating modes. What is the BEST pre-handoff technical review?',
  '[{"key":"A","text":"Verify installed architecture, load identities, control communication, device assignments, scene and schedule logic, sensor behavior, integrations, documentation, and all required operating modes end to end"},{"key":"B","text":"Confirm only that every light turns on"},{"key":"C","text":"Skip integrated testing because each device was tested separately"},{"key":"D","text":"Remove programming documentation after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'A complex lighting-control system requires end-to-end validation of physical installation, programming, automation, integration, and documentation.'
);

create temporary table _seed_ci_lighting_control_systems_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_lighting_control_systems_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary responsibility of an expert-level lighting-control practitioner?',
  '[{"key":"A","text":"To make system-level decisions that balance control architecture, load compatibility, user experience, integration, scalability, serviceability, and lifecycle support"},{"key":"B","text":"To focus only on individual dimmer installation"},{"key":"C","text":"To select the most expensive control hardware"},{"key":"D","text":"To avoid documenting design decisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Expert lighting-control work requires judgment across architecture, performance, integration, maintainability, and long-term system behavior.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are standards important in large lighting-control deployments?',
  '[{"key":"A","text":"They create consistent expectations for architecture, load naming, device configuration, programming, documentation, commissioning, and support"},{"key":"B","text":"They guarantee every project uses identical fixtures"},{"key":"C","text":"They eliminate the need for commissioning"},{"key":"D","text":"They prevent all project-specific variations"}]'::jsonb,
  '["A"]'::jsonb,
  'Standards improve consistency and serviceability while still allowing controlled project-specific variation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should lighting-control architecture be evaluated for scalability before deployment?',
  '[{"key":"A","text":"Future loads, devices, zones, integrations, processing, communication capacity, and operating requirements may exceed the original design"},{"key":"B","text":"Every project should be oversized without regard to need"},{"key":"C","text":"Scalability matters only for keypad quantity"},{"key":"D","text":"Scalability eliminates documentation requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'A scalable control architecture can accommodate foreseeable growth without forcing unnecessary redesign.'
),
(
  4,
  'multiple_choice',
  'application',
  'A client wants to expand an existing lighting-control system from one floor to an entire building. What is the BEST first design action?',
  '[{"key":"A","text":"Review current and future load counts, panel and processor capacity, communication topology, device limits, integrations, network requirements, power, programming structure, and documentation"},{"key":"B","text":"Add devices until the system stops accepting them"},{"key":"C","text":"Replace every existing control device first"},{"key":"D","text":"Use the same configuration without checking capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Large expansions should begin with system requirements and capacity analysis.'
),
(
  5,
  'multiple_choice',
  'application',
  'A portfolio includes many buildings using the same lighting-control platform. What is the BEST enterprise-level implementation practice?',
  '[{"key":"A","text":"Use governed standards for naming, programming structure, device configuration, backups, documentation, commissioning, remote support, and approved exceptions"},{"key":"B","text":"Allow every installer to invent a different programming method"},{"key":"C","text":"Standardize only keypad colors"},{"key":"D","text":"Avoid maintaining backups because systems are similar"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeatable standards improve consistency, supportability, training, and lifecycle management across multiple sites.'
),
(
  6,
  'multiple_choice',
  'application',
  'A mission-critical facility requires essential lighting-control functions to remain available if a central controller fails. What design principle should be considered?',
  '[{"key":"A","text":"Reduce single points of failure through appropriate distributed functionality, segmentation, redundancy, fail-safe behavior, or local fallback based on project requirements"},{"key":"B","text":"Place all control logic on one central device"},{"key":"C","text":"Remove all local controls"},{"key":"D","text":"Use identical labels for redundant paths"}]'::jsonb,
  '["A"]'::jsonb,
  'Critical environments may require an architecture that limits the impact of a single controller or communication failure.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project uses many different LED fixture and driver types. What is the BEST system-level control strategy?',
  '[{"key":"A","text":"Define approved control methods and compatibility requirements, validate fixture-driver-control combinations, and document exceptions before deployment"},{"key":"B","text":"Assume all LED loads can use the same dimmer settings"},{"key":"C","text":"Use only maximum output levels"},{"key":"D","text":"Ignore fixture substitutions"}]'::jsonb,
  '["A"]'::jsonb,
  'Mixed lighting technologies require deliberate compatibility governance and validated configuration standards.'
),
(
  8,
  'multiple_choice',
  'application',
  'A client has inconsistent scene behavior across similar rooms even though the same control platform is used. What is the BEST leadership-level response?',
  '[{"key":"A","text":"Compare programming standards, load naming, scene definitions, control priorities, device configuration, integration logic, commissioning results, and documentation across rooms"},{"key":"B","text":"Increase every scene to full output"},{"key":"C","text":"Replace all keypads"},{"key":"D","text":"Assume identical hardware guarantees identical behavior"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent hardware does not guarantee consistent system behavior when programming and implementation practices differ.'
),
(
  9,
  'multiple_choice',
  'application',
  'A major lighting-control device substitution is proposed late in a project. What is the BEST technical review?',
  '[{"key":"A","text":"Evaluate load compatibility, ratings, communication, programming impact, integration interfaces, physical requirements, software support, documentation, and downstream dependencies before approval"},{"key":"B","text":"Approve it if the device is the same size"},{"key":"C","text":"Approve it if the manufacturer is familiar"},{"key":"D","text":"Evaluate only the purchase price"}]'::jsonb,
  '["A"]'::jsonb,
  'A substitution can affect the full control architecture and should be reviewed against every relevant dependency.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician is standardizing lighting-control installations across projects. What is the BEST approach?',
  '[{"key":"A","text":"Establish repeatable standards for panel layout, load naming, addressing, wiring, labeling, programming structure, backups, documentation, commissioning, and service access"},{"key":"B","text":"Make every project unique to the installer"},{"key":"C","text":"Standardize only wall-plate appearance"},{"key":"D","text":"Remove labels after programming"}]'::jsonb,
  '["A"]'::jsonb,
  'Implementation standards should improve technical consistency, serviceability, documentation, and quality.'
),
(
  11,
  'scenario',
  'scenario',
  'A campus lighting-control system must support centralized monitoring while allowing each building to retain basic operation if the central management layer becomes unavailable. What is the BEST architecture?',
  '[{"key":"A","text":"Use an architecture that combines centralized management with appropriate local control and failure-domain separation"},{"key":"B","text":"Require every building to depend completely on one central controller"},{"key":"C","text":"Remove local controls"},{"key":"D","text":"Build unrelated systems with no shared standards"}]'::jsonb,
  '["A"]'::jsonb,
  'The requirements call for centralized visibility without making basic operation entirely dependent on one central failure point.'
),
(
  12,
  'scenario',
  'scenario',
  'A client wants to migrate several occupied buildings from an older lighting-control platform to a newer architecture. What is the BEST planning approach?',
  '[{"key":"A","text":"Evaluate existing loads, control methods, device compatibility, infrastructure, programming, integrations, phasing, rollback options, user impact, documentation, and operational risk before migration"},{"key":"B","text":"Replace every processor at once and address compatibility later"},{"key":"C","text":"Assume existing devices will automatically work with the new platform"},{"key":"D","text":"Migrate every building without a phased plan"}]'::jsonb,
  '["A"]'::jsonb,
  'Platform migration affects physical controls, programming, integrations, users, and operations and should be planned as a coordinated transition.'
),
(
  13,
  'scenario',
  'scenario',
  'A large hospitality project has guest rooms, public areas, exterior lighting, event spaces, and back-of-house areas with different control requirements. What is the BEST design strategy?',
  '[{"key":"A","text":"Create a common control framework with defined standards and approved variations for each space type, operating mode, sensing strategy, user interface, and integration requirement"},{"key":"B","text":"Use identical programming in every space regardless of use"},{"key":"C","text":"Allow each room to be designed without shared standards"},{"key":"D","text":"Standardize only fixture brands"}]'::jsonb,
  '["A"]'::jsonb,
  'A modular reference architecture creates consistency while allowing controlled variation for different functional spaces.'
),
(
  14,
  'scenario',
  'scenario',
  'A convention facility has several divisible ballrooms with multiple operating modes, scenes, sensors, shades, AV integration, and room-combine logic. What is the BEST control approach?',
  '[{"key":"A","text":"Define each room mode as a coordinated system state covering lighting zones, scenes, sensor behavior, user interfaces, shade behavior, integrations, and room-combine transitions"},{"key":"B","text":"Require staff to manually reprogram devices whenever partitions move"},{"key":"C","text":"Use one fixed lighting state for every room configuration"},{"key":"D","text":"Disable integrated systems whenever rooms are combined"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex divisible spaces require coordinated control states so multiple subsystems change predictably with the room configuration.'
),
(
  15,
  'scenario',
  'scenario',
  'A company wants one lighting-control standard deployed across fifty locations, but local building sizes and functional requirements vary. What is the BEST strategy?',
  '[{"key":"A","text":"Create a modular reference architecture with defined core standards, scalable tiers, approved device families, programming templates, and controlled exceptions"},{"key":"B","text":"Install the exact same quantities of hardware at every site"},{"key":"C","text":"Allow every site to invent a completely different system"},{"key":"D","text":"Standardize only user-interface colors"}]'::jsonb,
  '["A"]'::jsonb,
  'A reference architecture creates consistency while allowing controlled variation for site-specific needs.'
),
(
  16,
  'scenario',
  'scenario',
  'A high-end project performs well, but service requires extensive investigation because load names, processor files, panel schedules, backups, and programming notes are incomplete. What is the BEST design lesson?',
  '[{"key":"A","text":"Serviceability, documentation, naming, configuration backups, panel records, and maintainability are part of lighting-control system quality"},{"key":"B","text":"Only user-facing performance matters"},{"key":"C","text":"Service teams should recreate programming from memory"},{"key":"D","text":"Documentation should be removed after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful lighting-control system must perform well and remain practical to support throughout its lifecycle.'
),
(
  17,
  'scenario',
  'scenario',
  'A project includes lighting, shades, AV, security, occupancy, and environmental control. Each subsystem works independently, but the client expects unified building modes. What is the BEST leadership-level approach?',
  '[{"key":"A","text":"Define subsystem responsibilities, integration interfaces, control ownership, priorities, event sequences, state dependencies, documentation, and coordinated validation"},{"key":"B","text":"Assume independent subsystem operation guarantees successful integration"},{"key":"C","text":"Let every trade create overlapping logic without coordination"},{"key":"D","text":"Integrate only after client training"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated experiences require clearly defined interfaces and coordinated behavior across subsystem boundaries.'
),
(
  18,
  'scenario',
  'scenario',
  'A client expects the lighting-control platform to remain in service for many years while fixtures, drivers, user interfaces, and integration platforms evolve. What is the BEST lifecycle strategy?',
  '[{"key":"A","text":"Evaluate infrastructure, supported protocols, upgrade paths, processor capacity, software lifecycle, backup practices, integration methods, and replacement strategy for foreseeable change"},{"key":"B","text":"Design only for current equipment with no upgrade planning"},{"key":"C","text":"Replace all infrastructure whenever one device changes"},{"key":"D","text":"Assume present software will be supported indefinitely"}]'::jsonb,
  '["A"]'::jsonb,
  'Lifecycle planning should consider foreseeable technology change where it affects long-term support and upgradeability.'
),
(
  19,
  'scenario',
  'scenario',
  'A lead technician reviews several completed projects and finds repeated differences in load naming, keypad logic, scene structure, processor backups, sensor programming, and documentation. What is the BEST organizational response?',
  '[{"key":"A","text":"Develop and enforce lighting-control implementation standards, templates, naming conventions, programming baselines, backup practices, documentation requirements, and quality-review checkpoints"},{"key":"B","text":"Allow every project team to continue using unrelated methods"},{"key":"C","text":"Standardize only hardware brands"},{"key":"D","text":"Stop reviewing completed projects"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring inconsistency is best addressed through shared standards and repeatable implementation practices.'
),
(
  20,
  'scenario',
  'scenario',
  'An organization is creating a new enterprise lighting-control standard after years of inconsistent programming, difficult service, undocumented load assignments, incompatible substitutions, and unpredictable user experiences. What is the BEST long-term strategy?',
  '[{"key":"A","text":"Create a governed lighting-control framework covering reference architecture, approved technologies, load compatibility, naming, programming standards, integration rules, documentation, installation, commissioning, backups, serviceability, lifecycle planning, and controlled exceptions"},{"key":"B","text":"Select one manufacturer and allow all other practices to remain inconsistent"},{"key":"C","text":"Let each installer decide the architecture and programming independently"},{"key":"D","text":"Focus only on reducing initial equipment cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature lighting-control program requires an integrated technical framework that improves consistency, reliability, serviceability, and lifecycle management.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'fd153f9c-b07a-4b9c-b426-dd209a9193ac';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '006a91b3-38dc-4d13-9532-f22d839af945';
  v_l3_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
  v_l4_role_id uuid := '83a1e70f-ecc0-4364-9353-2ea511e51ede';
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
  where lower(i.slug) = 'custom-integration'
     or lower(i.name) = 'custom integration'
  order by case when lower(i.slug) = 'custom-integration' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Custom Integration industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Lighting / Control Systems'
      and c.is_current = true
  ) then
    raise exception 'Current Lighting / Control Systems Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician I — Entry Level'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Technician I — Entry Level L1 Lighting / Control Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Logistics Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Logistics Manager L2 Lighting / Control Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Technician III — Lead Technician L3 Lighting / Control Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Systems Programmer'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Systems Programmer L4 Lighting / Control Systems requirement not found';
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
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'Lighting / Control Systems — Level 1 Competency Assessment';

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
    select * from _seed_ci_lighting_control_systems_l1_questions
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
        'Lighting / Control Systems',
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
      'IntegrateU Lighting / Control Systems L1 production assessment v1.0.',
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
      v_l1_role_id
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
        'Lighting / Control Systems',
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
        'IntegrateU Lighting / Control Systems L1 production assessment v1.0.',
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
  v_role_template_id := v_l2_role_id;
  v_assessment_name := 'Lighting / Control Systems — Level 2 Competency Assessment';

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
    select * from _seed_ci_lighting_control_systems_l2_questions
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
        'Lighting / Control Systems',
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
      'IntegrateU Lighting / Control Systems L2 production assessment v1.0.',
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
      v_l2_role_id
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
        'Lighting / Control Systems',
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
        'IntegrateU Lighting / Control Systems L2 production assessment v1.0.',
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
  v_role_template_id := v_l3_role_id;
  v_assessment_name := 'Lighting / Control Systems — Level 3 Competency Assessment';

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
    select * from _seed_ci_lighting_control_systems_l3_questions
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
        'Lighting / Control Systems',
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
      'IntegrateU Lighting / Control Systems L3 production assessment v1.0.',
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
        'Lighting / Control Systems',
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
        'IntegrateU Lighting / Control Systems L3 production assessment v1.0.',
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
  v_role_template_id := v_l4_role_id;
  v_assessment_name := 'Lighting / Control Systems — Level 4 Competency Assessment';

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
    select * from _seed_ci_lighting_control_systems_l4_questions
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
        'Lighting / Control Systems',
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
      'IntegrateU Lighting / Control Systems L4 production assessment v1.0.',
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
        'Lighting / Control Systems',
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
        'IntegrateU Lighting / Control Systems L4 production assessment v1.0.',
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
