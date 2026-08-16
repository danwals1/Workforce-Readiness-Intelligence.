-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0163_ci_testing_commissioning_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Testing & Commissioning
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Operations Manager                          -> Level 2
--   Technician II — Experienced                 -> Level 3
--   Technician III — Lead Technician            -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess testing and commissioning fundamentals,
-- functional verification, design-intent validation, documentation, troubleshooting,
-- integrated-system readiness, handoff, and progressively higher commissioning judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_testing_commissioning_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_testing_commissioning_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of testing completed system work?',
  '[{"key":"A","text":"To verify that installed devices and functions operate as intended"},{"key":"B","text":"To avoid documenting the project"},{"key":"C","text":"To replace the project scope"},{"key":"D","text":"To eliminate client training"}]'::jsonb,
  '["A"]'::jsonb,
  'Testing confirms that completed work operates correctly before the project is handed off.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does commissioning a system mean?',
  '[{"key":"A","text":"Systematically verifying, configuring, and validating the installed system for intended operation"},{"key":"B","text":"Ordering additional equipment after installation"},{"key":"C","text":"Removing all system labels"},{"key":"D","text":"Creating a sales proposal"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning verifies that the installed system is configured and functioning according to its intended design.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should testing follow the approved scope or design documents?',
  '[{"key":"A","text":"They define the functions and outcomes the completed system is expected to deliver"},{"key":"B","text":"They eliminate the need to inspect the installation"},{"key":"C","text":"They are only used for billing"},{"key":"D","text":"They replace manufacturer instructions"}]'::jsonb,
  '["A"]'::jsonb,
  'Scope and design documents provide the reference for confirming whether the finished system meets the intended requirements.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a functional test?',
  '[{"key":"A","text":"A test that confirms a device, feature, or workflow performs its intended function"},{"key":"B","text":"A test of the technician time clock"},{"key":"C","text":"A count of warehouse inventory"},{"key":"D","text":"A review of the sales commission"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional testing confirms that an installed feature behaves as expected.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should test results be documented?',
  '[{"key":"A","text":"To create evidence of what was tested, what passed, and what still requires correction"},{"key":"B","text":"To avoid future service records"},{"key":"C","text":"To remove the need for labels"},{"key":"D","text":"To replace system backups"}]'::jsonb,
  '["A"]'::jsonb,
  'Documented results create a record of system readiness and unresolved issues.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is a punch-list item?',
  '[{"key":"A","text":"An identified issue or incomplete item that must be corrected before final completion"},{"key":"B","text":"A list of employee birthdays"},{"key":"C","text":"A warehouse shipping label"},{"key":"D","text":"A completed client invoice"}]'::jsonb,
  '["A"]'::jsonb,
  'Punch-list items are remaining deficiencies that must be resolved before the project can be considered complete.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What does design intent mean during commissioning?',
  '[{"key":"A","text":"The expected system behavior and performance described by the project scope, drawings, specifications, or approved requirements"},{"key":"B","text":"The personal preference of the last technician onsite"},{"key":"C","text":"The default factory settings of every device"},{"key":"D","text":"The equipment purchase price"}]'::jsonb,
  '["A"]'::jsonb,
  'Design intent describes what the completed system is supposed to accomplish.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is a final visual inspection useful before functional testing?',
  '[{"key":"A","text":"It can identify obvious installation, labeling, connection, cleanliness, or completion issues before deeper testing begins"},{"key":"B","text":"It replaces all functional testing"},{"key":"C","text":"It automatically fixes programming errors"},{"key":"D","text":"It guarantees every system will pass"}]'::jsonb,
  '["A"]'::jsonb,
  'A visual inspection can catch basic deficiencies before time is spent on functional testing.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician finishes installing a display but has not confirmed that every intended source can be viewed. What should happen next?',
  '[{"key":"A","text":"Test each intended source and control function against the project requirements"},{"key":"B","text":"Mark the display complete because it powers on"},{"key":"C","text":"Remove the source labels"},{"key":"D","text":"Skip testing until a client reports a problem"}]'::jsonb,
  '["A"]'::jsonb,
  'Power alone does not prove functionality; intended source and control operation must be verified.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lighting keypad powers on but one programmed scene does not operate correctly. What should the technician do?',
  '[{"key":"A","text":"Record the failure, verify the expected scene behavior, troubleshoot it, correct it, and retest"},{"key":"B","text":"Ignore the scene because the keypad has power"},{"key":"C","text":"Delete all project documentation"},{"key":"D","text":"Replace every lighting load immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'A failed function should be documented, corrected, and retested before completion.'
),
(
  11,
  'multiple_choice',
  'application',
  'A camera is online but its view does not cover the area shown on the approved plan. What should the technician do?',
  '[{"key":"A","text":"Adjust or correct the camera installation and verify the final view matches the intended coverage"},{"key":"B","text":"Mark it complete because video is visible"},{"key":"C","text":"Disable recording"},{"key":"D","text":"Remove the camera label"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning requires verifying intended coverage, not merely confirming that a camera is online.'
),
(
  12,
  'multiple_choice',
  'application',
  'A room audio zone plays but the left and right channels are reversed. How should this be handled?',
  '[{"key":"A","text":"Correct the channel assignment or connection and retest the zone"},{"key":"B","text":"Accept it because audio is present"},{"key":"C","text":"Increase the volume"},{"key":"D","text":"Delete the room from documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Testing should identify incorrect operation and verify the correction.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician completes a device test successfully. What is the BEST next step?',
  '[{"key":"A","text":"Record the result according to the project testing or commissioning process"},{"key":"B","text":"Reset the device to factory defaults"},{"key":"C","text":"Remove its label"},{"key":"D","text":"Change its configuration without reason"}]'::jsonb,
  '["A"]'::jsonb,
  'Recording successful test results creates traceable evidence of completion.'
),
(
  14,
  'multiple_choice',
  'application',
  'A system feature fails during testing. What should happen before it is marked complete?',
  '[{"key":"A","text":"The issue should be corrected and the affected function retested successfully"},{"key":"B","text":"The test result should be deleted"},{"key":"C","text":"The feature should be removed from the scope without approval"},{"key":"D","text":"The failure should be ignored if most other features work"}]'::jsonb,
  '["A"]'::jsonb,
  'Failed items must be corrected and verified before they can be considered complete.'
),
(
  15,
  'multiple_choice',
  'application',
  'A technician is preparing a system for client handoff. Which item should be verified?',
  '[{"key":"A","text":"That required functions have been tested and unresolved issues are clearly identified"},{"key":"B","text":"That all device labels have been removed"},{"key":"C","text":"That testing records have been discarded"},{"key":"D","text":"That every device remains on factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'Handoff readiness requires verified functionality and clear visibility of anything still unresolved.'
),
(
  16,
  'multiple_choice',
  'application',
  'A control button works sometimes but fails intermittently during testing. What is the BEST response?',
  '[{"key":"A","text":"Treat it as a failure, investigate the intermittent condition, correct it, and repeat the test"},{"key":"B","text":"Pass it because it worked once"},{"key":"C","text":"Remove the button from the user interface without approval"},{"key":"D","text":"Skip all remaining tests"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent operation is not reliable operation and should be resolved before commissioning is complete.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician finishes a media room installation. The display, receiver, and sources all power on, but no one has tested source switching, audio, control, or shutdown. What is the BEST next step?',
  '[{"key":"A","text":"Run a complete functional test of the intended room workflows and document the results"},{"key":"B","text":"Mark the room complete because all equipment powers on"},{"key":"C","text":"Remove the equipment labels"},{"key":"D","text":"Wait for the client to identify failures"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning must validate intended workflows, not just device power status.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician tests ten installed shades. Nine operate correctly, but one stops before reaching the expected closed position. What is the BEST response?',
  '[{"key":"A","text":"Record the failed shade, correct its setup or installation, and retest it before closing the task"},{"key":"B","text":"Pass the group because most shades worked"},{"key":"C","text":"Remove the shade from the project records"},{"key":"D","text":"Change all other shade limits"}]'::jsonb,
  '["A"]'::jsonb,
  'Each required device or function must meet its expected operation before completion.'
),
(
  19,
  'scenario',
  'scenario',
  'A project drawing shows four cameras, but only three appear in the recorder during commissioning. What is the BEST next step?',
  '[{"key":"A","text":"Reconcile the installed system with the project documents, identify the missing camera, correct the issue, and retest"},{"key":"B","text":"Change the drawing to three cameras without approval"},{"key":"C","text":"Mark the recorder complete because it has video"},{"key":"D","text":"Delete the fourth camera from the scope"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning should reconcile actual installed functionality with the approved project requirements.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is about to leave a completed project area. All tested functions pass, but the test checklist has not been updated. What is the BEST action?',
  '[{"key":"A","text":"Complete the testing documentation so the verified results are recorded before handoff"},{"key":"B","text":"Leave without recording the results"},{"key":"C","text":"Delete the checklist"},{"key":"D","text":"Retest only after the client reports an issue"}]'::jsonb,
  '["A"]'::jsonb,
  'Testing is not fully complete until the results are documented according to the project process.'
);


create temporary table _seed_ci_testing_commissioning_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_testing_commissioning_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of a commissioning checklist?',
  '[{"key":"A","text":"To provide a repeatable record of required tests, expected results, actual results, and completion status"},{"key":"B","text":"To replace the project scope"},{"key":"C","text":"To eliminate troubleshooting"},{"key":"D","text":"To record only equipment prices"}]'::jsonb,
  '["A"]'::jsonb,
  'A commissioning checklist creates a consistent process for verifying and documenting required system functions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is acceptance criteria during testing and commissioning?',
  '[{"key":"A","text":"The defined condition or result that determines whether a tested item passes"},{"key":"B","text":"The amount of time spent installing a device"},{"key":"C","text":"The shipping status of equipment"},{"key":"D","text":"The manufacturer warranty period"}]'::jsonb,
  '["A"]'::jsonb,
  'Acceptance criteria define what successful performance looks like for each required test.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should commissioning include integrated workflows rather than only individual devices?',
  '[{"key":"A","text":"Because devices may work independently but still fail when required to operate together as a system"},{"key":"B","text":"Because individual device testing is never useful"},{"key":"C","text":"Because integrated systems do not require documentation"},{"key":"D","text":"Because factory defaults prove all workflows"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated-system commissioning verifies that connected components perform the intended end-to-end workflows.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is regression testing after a system change?',
  '[{"key":"A","text":"Retesting previously working functions to confirm the change did not create new failures"},{"key":"B","text":"Removing old project documentation"},{"key":"C","text":"Repeating the sales proposal"},{"key":"D","text":"Testing only the newly installed device"}]'::jsonb,
  '["A"]'::jsonb,
  'Regression testing helps confirm that a correction or change has not negatively affected other system functions.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why are configuration backups important during commissioning?',
  '[{"key":"A","text":"They provide a known system state that can support recovery, service, and future changes"},{"key":"B","text":"They eliminate the need for functional tests"},{"key":"C","text":"They replace device labels"},{"key":"D","text":"They guarantee all programming is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'A verified configuration backup preserves the commissioned system state for recovery and future support.'
),
(
  6,
  'multiple_choice',
  'application',
  'A completed room passes device-level tests, but the programmed shutdown sequence leaves one source powered on. What should happen?',
  '[{"key":"A","text":"Record the workflow failure, correct the sequence, retest the entire shutdown workflow, and document the result"},{"key":"B","text":"Pass the room because most devices shut down"},{"key":"C","text":"Remove the source from the system"},{"key":"D","text":"Skip the remaining commissioning steps"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning should validate the complete workflow and require correction and retesting when any intended step fails.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician changes programming to correct one control issue. What should be done before declaring the change successful?',
  '[{"key":"A","text":"Retest the corrected function and related workflows that could have been affected by the change"},{"key":"B","text":"Test only that the processor still has power"},{"key":"C","text":"Delete the previous test record"},{"key":"D","text":"Reset all devices to factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'A programming correction should be verified directly and through appropriate regression testing.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project specification requires every camera to record continuously for 30 days. What should commissioning verify?',
  '[{"key":"A","text":"That each required camera is recording as intended and the configured storage and retention support the 30-day requirement"},{"key":"B","text":"Only that live video is visible"},{"key":"C","text":"Only that the recorder powers on"},{"key":"D","text":"Only that cameras have labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning must validate the required recording behavior and retention outcome, not merely live camera operation.'
),
(
  9,
  'multiple_choice',
  'application',
  'A lighting system has 25 programmed scenes. What is the BEST commissioning approach?',
  '[{"key":"A","text":"Test the required scenes against documented expected behavior and record failures or deviations"},{"key":"B","text":"Test one scene and assume the rest are correct"},{"key":"C","text":"Verify only keypad backlights"},{"key":"D","text":"Delete unused scene documentation before testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Required programmed functions should be verified against defined expected behavior.'
),
(
  10,
  'multiple_choice',
  'application',
  'A networked subsystem works locally but fails during an integrated control sequence. What should be checked?',
  '[{"key":"A","text":"The end-to-end workflow, device communication, configuration, dependencies, timing, and related control logic"},{"key":"B","text":"Only the device mounting height"},{"key":"C","text":"Only the rack label"},{"key":"D","text":"Only the client password"}]'::jsonb,
  '["A"]'::jsonb,
  'An integrated failure should be traced across the complete workflow and its technical dependencies.'
),
(
  11,
  'multiple_choice',
  'application',
  'A punch-list item is corrected in the field. What is required before it can be closed?',
  '[{"key":"A","text":"Verify the correction through the appropriate test and update the punch-list status and evidence"},{"key":"B","text":"Close it as soon as the technician says it is fixed"},{"key":"C","text":"Delete the original issue"},{"key":"D","text":"Wait until the warranty period ends"}]'::jsonb,
  '["A"]'::jsonb,
  'A punch-list item should be closed only after the correction has been verified and documented.'
),
(
  12,
  'multiple_choice',
  'application',
  'A commissioning test produces an unexpected result that cannot immediately be explained. What is the BEST response?',
  '[{"key":"A","text":"Document the actual result, compare it with expected behavior, isolate the cause, correct if necessary, and retest"},{"key":"B","text":"Change the expected result to match what happened"},{"key":"C","text":"Mark the test passed without investigation"},{"key":"D","text":"Delete the test from the checklist"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected results should be investigated rather than accepted or hidden.'
),
(
  13,
  'multiple_choice',
  'application',
  'A system uses scheduled events that must occur at specific times. How should this be commissioned?',
  '[{"key":"A","text":"Verify system time and scheduling configuration, then test or simulate the required scheduled behavior"},{"key":"B","text":"Check only that the controller is online"},{"key":"C","text":"Assume the schedule works because it is programmed"},{"key":"D","text":"Disable the schedule before handoff"}]'::jsonb,
  '["A"]'::jsonb,
  'Scheduled behavior must be validated against correct time settings, configuration, and expected operation.'
),
(
  14,
  'multiple_choice',
  'application',
  'A completed system is ready for handoff, but the latest configuration backup predates several final corrections. What should be done?',
  '[{"key":"A","text":"Create and verify a current backup that reflects the commissioned final configuration"},{"key":"B","text":"Use the old backup because it exists"},{"key":"C","text":"Delete all backups"},{"key":"D","text":"Reset the system before handoff"}]'::jsonb,
  '["A"]'::jsonb,
  'The final backup should represent the actual commissioned system state.'
),
(
  15,
  'scenario',
  'scenario',
  'A conference room passes display, audio, and control tests separately, but during a real meeting workflow the first source selection takes 45 seconds and users repeatedly press buttons. What is the BEST response?',
  '[{"key":"A","text":"Test the workflow end to end, identify the delay or feedback problem, correct the behavior or user interface, and retest under realistic use"},{"key":"B","text":"Pass the room because every device works individually"},{"key":"C","text":"Remove source-selection controls"},{"key":"D","text":"Tell the client to wait longer without investigation"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning should include realistic workflows and usability, not only isolated device operation.'
),
(
  16,
  'scenario',
  'scenario',
  'A whole-home audio system passes at low volume, but several zones distort when operated at expected listening levels. What is the BEST commissioning response?',
  '[{"key":"A","text":"Reproduce the failure at expected operating conditions, inspect signal path and system settings, correct the cause, and retest affected zones"},{"key":"B","text":"Pass the system because audio is present"},{"key":"C","text":"Limit every zone permanently without review"},{"key":"D","text":"Delete the affected zones from the test plan"}]'::jsonb,
  '["A"]'::jsonb,
  'Testing must verify performance under the operating conditions the system is expected to support.'
),
(
  17,
  'scenario',
  'scenario',
  'A client reports during pre-handoff review that an automation scene behaves differently from the approved description. The technician says the current behavior is easier to program. What is the BEST response?',
  '[{"key":"A","text":"Compare the behavior to approved design intent, obtain clarification if needed, correct the system to the approved requirement, and retest"},{"key":"B","text":"Accept the easier programming approach automatically"},{"key":"C","text":"Change the project scope without approval"},{"key":"D","text":"Remove the scene from testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning validates approved design intent rather than substituting undocumented field preferences.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician corrects intermittent communication to one subsystem. Immediately afterward another previously passing workflow begins failing. What is the BEST next step?',
  '[{"key":"A","text":"Perform regression testing around the change, identify what was affected, correct the new issue, and retest both workflows"},{"key":"B","text":"Ignore the new failure because the original problem is fixed"},{"key":"C","text":"Factory-reset every system"},{"key":"D","text":"Close the punch list"}]'::jsonb,
  '["A"]'::jsonb,
  'A new failure following a change is exactly why regression testing is required.'
),
(
  19,
  'scenario',
  'scenario',
  'A multi-room project appears complete, but the commissioning checklist shows several tests with blank results and no technician initials. What is the BEST response?',
  '[{"key":"A","text":"Treat those items as unverified, complete the required tests, record the results, and resolve any failures before handoff"},{"key":"B","text":"Assume blank items passed"},{"key":"C","text":"Delete the incomplete rows"},{"key":"D","text":"Have someone initial them without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing evidence means the required commissioning work has not been demonstrated as complete.'
),
(
  20,
  'scenario',
  'scenario',
  'A system passes all functional tests, but the final drawings, labels, configuration backup, and commissioning results do not match several field changes. What is the BEST handoff decision?',
  '[{"key":"A","text":"Reconcile the documentation and backup with the actual commissioned system before final handoff"},{"key":"B","text":"Hand off immediately because the system works"},{"key":"C","text":"Delete the outdated documents"},{"key":"D","text":"Make no record of the field changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning includes accurate final documentation and recoverable configuration, not just functional performance.'
);


create temporary table _seed_ci_testing_commissioning_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_testing_commissioning_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should a commissioning plan define test prerequisites before functional testing begins?',
  '[{"key":"A","text":"Because power, connectivity, configuration, documentation, dependencies, and installation readiness must be established before meaningful functional results can be trusted"},{"key":"B","text":"Because prerequisites replace acceptance criteria"},{"key":"C","text":"Because all systems should be tested before installation is complete"},{"key":"D","text":"Because commissioning requires only visual inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Defined prerequisites prevent invalid test results caused by incomplete installation, configuration, or supporting dependencies.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of traceability in a commissioning process?',
  '[{"key":"A","text":"To connect requirements and design intent to specific tests, results, deficiencies, corrections, and final acceptance evidence"},{"key":"B","text":"To eliminate project documentation"},{"key":"C","text":"To track only equipment shipping"},{"key":"D","text":"To replace functional testing with technician notes"}]'::jsonb,
  '["A"]'::jsonb,
  'Traceability provides evidence that required outcomes were actually tested and verified.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is repeatability important in commissioning tests?',
  '[{"key":"A","text":"A reliable system should produce the expected result consistently when the same defined conditions and workflow are repeated"},{"key":"B","text":"A function only needs to work once"},{"key":"C","text":"Repeatability matters only for factory testing"},{"key":"D","text":"Repeated tests should always use different acceptance criteria"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeatable results help demonstrate that system behavior is stable rather than intermittent or accidental.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should commissioning include failure and recovery behavior when it is part of the design intent?',
  '[{"key":"A","text":"Because normal operation alone does not prove the system will respond correctly to loss of power, communication, equipment, or other defined failure conditions"},{"key":"B","text":"Because failure testing eliminates the need for backups"},{"key":"C","text":"Because every device should be intentionally damaged"},{"key":"D","text":"Because recovery behavior is unrelated to system readiness"}]'::jsonb,
  '["A"]'::jsonb,
  'Resilient systems must be validated under the failure and recovery conditions they are expected to handle.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project has passed individual subsystem tests. What should happen before final acceptance of an integrated automation workflow?',
  '[{"key":"A","text":"Test the complete end-to-end workflow across all dependent subsystems using defined expected results"},{"key":"B","text":"Assume integration works because each subsystem passed separately"},{"key":"C","text":"Remove integration steps from the checklist"},{"key":"D","text":"Reset each subsystem to factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'Subsystem success does not prove integrated success; the full workflow must be commissioned.'
),
(
  6,
  'multiple_choice',
  'application',
  'A commissioning test passes once but fails twice when repeated under the same conditions. How should the result be classified?',
  '[{"key":"A","text":"As a failure or unresolved intermittent condition requiring investigation before acceptance"},{"key":"B","text":"As a pass because it worked once"},{"key":"C","text":"As complete if the client did not see the failures"},{"key":"D","text":"As a documentation-only issue"}]'::jsonb,
  '["A"]'::jsonb,
  'Inconsistent results do not demonstrate reliable commissioned performance.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project change modifies the sequence used by several automation scenes. What is the BEST commissioning response?',
  '[{"key":"A","text":"Update the expected behavior, test the changed sequence, run appropriate regression tests on affected scenes, and document the final results"},{"key":"B","text":"Test only the newly edited line of code"},{"key":"C","text":"Assume unrelated scenes cannot be affected"},{"key":"D","text":"Delete prior commissioning records"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes to shared logic can affect multiple workflows and require both direct and regression testing.'
),
(
  8,
  'multiple_choice',
  'application',
  'A system is required to recover automatically after a brief power interruption. How should that requirement be commissioned?',
  '[{"key":"A","text":"Use an approved controlled test to simulate the interruption, observe shutdown and recovery behavior, verify restored functionality, and document the result"},{"key":"B","text":"Assume recovery works because devices have power supplies"},{"key":"C","text":"Test only normal startup"},{"key":"D","text":"Disconnect equipment without a defined test procedure"}]'::jsonb,
  '["A"]'::jsonb,
  'A required recovery behavior should be tested deliberately and safely against defined acceptance criteria.'
),
(
  9,
  'multiple_choice',
  'application',
  'A commissioning record shows several passed tests but no recorded firmware or software versions. Why can this be a problem?',
  '[{"key":"A","text":"The tested system state may not be reproducible or comparable during future troubleshooting, upgrades, or regression testing"},{"key":"B","text":"Firmware versions affect only shipping records"},{"key":"C","text":"Software versions are never relevant after installation"},{"key":"D","text":"Version records replace configuration backups"}]'::jsonb,
  '["A"]'::jsonb,
  'System-state information helps establish exactly what configuration and software environment was commissioned.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician finds that field conditions prevent one required commissioning test from being completed. What should happen?',
  '[{"key":"A","text":"Record the blocked test, reason, dependency, owner, and required follow-up rather than marking it passed or complete"},{"key":"B","text":"Mark it passed because testing was attempted"},{"key":"C","text":"Delete the requirement"},{"key":"D","text":"Change the acceptance criteria without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Blocked testing must remain visible and traceable until the requirement can actually be verified.'
),
(
  11,
  'multiple_choice',
  'application',
  'A complex project has multiple technicians recording commissioning results. What is the BEST control for consistent evidence?',
  '[{"key":"A","text":"Use defined test procedures, shared acceptance criteria, consistent result formats, issue tracking, and clear ownership"},{"key":"B","text":"Allow each technician to define different pass criteria"},{"key":"C","text":"Record only failed tests"},{"key":"D","text":"Avoid assigning test ownership"}]'::jsonb,
  '["A"]'::jsonb,
  'A standardized process improves consistency and comparability across multiple people and system areas.'
),
(
  12,
  'scenario',
  'scenario',
  'A residence has lighting, shades, HVAC, audio, security, and automation. Each subsystem passes individually, but the Away scene sometimes leaves one HVAC zone in occupied mode. What is the BEST commissioning approach?',
  '[{"key":"A","text":"Reproduce the complete Away workflow, trace commands and dependencies across subsystems, correct the cause, and repeat the integrated test until results are consistent"},{"key":"B","text":"Pass the scene because most subsystems work"},{"key":"C","text":"Remove HVAC from the scene without approval"},{"key":"D","text":"Retest only the lighting system"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated commissioning must validate the whole workflow and resolve intermittent cross-system failures.'
),
(
  13,
  'scenario',
  'scenario',
  'A conference facility has twenty rooms built from the same design. Nineteen pass, but one repeatedly takes much longer to establish a video call. What is the BEST response?',
  '[{"key":"A","text":"Compare the failing room with a known-good room using configuration, firmware, network path, device status, timing, and logs to isolate the deviation"},{"key":"B","text":"Accept the room because the other nineteen passed"},{"key":"C","text":"Reconfigure every room before investigating"},{"key":"D","text":"Remove call setup time from acceptance criteria"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated design provides useful known-good comparisons for isolating an abnormal commissioning result.'
),
(
  14,
  'scenario',
  'scenario',
  'A system passes commissioning during the day but fails scheduled nighttime functions after the team leaves. What is the BEST response?',
  '[{"key":"A","text":"Validate time settings, schedules, environmental or operating-state dependencies, logs, and the actual nighttime workflow under representative conditions"},{"key":"B","text":"Pass the system because daytime testing succeeded"},{"key":"C","text":"Disable all schedules"},{"key":"D","text":"Change unrelated device addresses"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning must represent the conditions under which required functions are expected to operate.'
),
(
  15,
  'scenario',
  'scenario',
  'A firmware update is required to correct a commissioning defect, but the project was otherwise nearly complete. What is the BEST plan after the update?',
  '[{"key":"A","text":"Verify the corrected defect, perform regression testing on functions that could be affected, record versions and results, and update the final backup"},{"key":"B","text":"Test only that devices reboot"},{"key":"C","text":"Assume the update cannot affect previously passing functions"},{"key":"D","text":"Delete all pre-update test evidence"}]'::jsonb,
  '["A"]'::jsonb,
  'A late firmware change alters the commissioned system state and requires direct verification and appropriate regression testing.'
),
(
  16,
  'scenario',
  'scenario',
  'A client demonstration reveals that a control workflow technically works but requires a confusing sequence different from the approved user experience. What is the BEST commissioning decision?',
  '[{"key":"A","text":"Treat the workflow as not meeting design intent, reconcile the approved user experience, correct the behavior, and retest"},{"key":"B","text":"Pass it because the devices eventually respond"},{"key":"C","text":"Train the client on the unintended sequence and close the project"},{"key":"D","text":"Remove the workflow from documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning validates intended operational behavior and user experience, not merely technical response.'
),
(
  17,
  'scenario',
  'scenario',
  'A large project has dozens of open punch-list items. Several are dependencies for other commissioning tests. What is the BEST project approach?',
  '[{"key":"A","text":"Identify dependency relationships, prioritize blockers, assign ownership, verify corrections, and release downstream tests only when prerequisites are satisfied"},{"key":"B","text":"Run all blocked tests and mark them passed"},{"key":"C","text":"Close minor items without verification"},{"key":"D","text":"Ignore dependencies and test randomly"}]'::jsonb,
  '["A"]'::jsonb,
  'Managing commissioning dependencies prevents wasted testing and false completion status.'
),
(
  18,
  'scenario',
  'scenario',
  'A system loses network connectivity during a controlled commissioning test and recovers, but several devices do not automatically reconnect. What is the BEST response?',
  '[{"key":"A","text":"Document which devices failed recovery, investigate dependency and reconnect behavior, correct the issue, then repeat the failure-and-recovery test"},{"key":"B","text":"Pass the test because the network itself recovered"},{"key":"C","text":"Power-cycle the devices manually and record a pass"},{"key":"D","text":"Remove recovery testing from the plan"}]'::jsonb,
  '["A"]'::jsonb,
  'Recovery testing must confirm restoration of the complete required system state, not just the shared infrastructure.'
),
(
  19,
  'scenario',
  'scenario',
  'A commissioning team finds that several field changes were never incorporated into the approved test plan. What is the BEST response before final acceptance?',
  '[{"key":"A","text":"Reconcile actual field conditions with design intent, update affected requirements and tests through the proper change process, execute the necessary tests, and document results"},{"key":"B","text":"Use the old test plan without changes"},{"key":"C","text":"Mark changed items passed automatically"},{"key":"D","text":"Delete the field-change records"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning evidence must correspond to the actual approved system that was built.'
),
(
  20,
  'scenario',
  'scenario',
  'A project is technically functional, but commissioning evidence is scattered across technician notes, screenshots, emails, and incomplete checklists. What is the BEST final-readiness action?',
  '[{"key":"A","text":"Consolidate requirements, test results, unresolved issues, corrections, final configurations, backups, and acceptance evidence into the defined project record before handoff"},{"key":"B","text":"Hand off immediately because the system works"},{"key":"C","text":"Delete informal records"},{"key":"D","text":"Create evidence only if a service issue occurs later"}]'::jsonb,
  '["A"]'::jsonb,
  'A commissioned system should have organized, traceable evidence showing what was required, tested, corrected, and accepted.'
);


create temporary table _seed_ci_testing_commissioning_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_testing_commissioning_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary responsibility of an expert-level practitioner leading testing and commissioning?',
  '[{"key":"A","text":"To establish and govern a complete verification process that proves design intent, functional performance, integration, resilience, documentation, and readiness for handoff"},{"key":"B","text":"To confirm only that devices have power"},{"key":"C","text":"To focus only on individual device setup"},{"key":"D","text":"To avoid defining acceptance criteria"}]'::jsonb,
  '["A"]'::jsonb,
  'Expert commissioning requires system-level ownership of the evidence that the completed installation meets its intended requirements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are commissioning standards important across multiple projects or teams?',
  '[{"key":"A","text":"They create consistent expectations for prerequisites, test methods, acceptance criteria, evidence, issue handling, regression testing, documentation, backups, and final readiness"},{"key":"B","text":"They guarantee every project has identical scope"},{"key":"C","text":"They eliminate the need for judgment"},{"key":"D","text":"They replace project-specific requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Standards improve consistency and quality while still allowing project-specific acceptance requirements.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should commissioning strategy be designed early in the project lifecycle?',
  '[{"key":"A","text":"Testability, acceptance criteria, dependencies, documentation, access, tooling, responsibilities, and evidence requirements can affect design and execution decisions"},{"key":"B","text":"Commissioning can always be improvised at the end without impact"},{"key":"C","text":"Early planning matters only for equipment ordering"},{"key":"D","text":"Commissioning strategy is unrelated to design intent"}]'::jsonb,
  '["A"]'::jsonb,
  'Early commissioning planning helps ensure the finished system can actually be verified efficiently and objectively.'
),
(
  4,
  'multiple_choice',
  'application',
  'A company wants consistent commissioning across many project teams. What is the BEST approach?',
  '[{"key":"A","text":"Create governed templates for prerequisites, requirements traceability, test procedures, acceptance criteria, issue tracking, regression testing, backups, documentation, evidence, and controlled exceptions"},{"key":"B","text":"Let each technician invent a different process"},{"key":"C","text":"Standardize only the checklist filename"},{"key":"D","text":"Record only failed tests"}]'::jsonb,
  '["A"]'::jsonb,
  'A governed commissioning framework improves repeatability, accountability, and quality across teams.'
),
(
  5,
  'multiple_choice',
  'application',
  'A large integrated project has hundreds of required functions and many subsystem dependencies. What is the BEST commissioning strategy?',
  '[{"key":"A","text":"Organize requirements into structured test groups, define prerequisites and dependencies, assign ownership, sequence tests logically, capture evidence, and manage failures through retest and regression"},{"key":"B","text":"Test functions randomly until most appear to work"},{"key":"C","text":"Verify only the largest subsystem"},{"key":"D","text":"Wait until client handoff to discover issues"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex projects require structured sequencing and ownership so testing remains traceable and efficient.'
),
(
  6,
  'multiple_choice',
  'application',
  'A critical system must continue operating in a defined degraded mode if one shared component fails. What should commissioning include?',
  '[{"key":"A","text":"Controlled failure testing that verifies the expected degraded operation, alarms or notifications, recovery behavior, and restoration to normal service"},{"key":"B","text":"Normal-operation testing only"},{"key":"C","text":"Unplanned equipment disconnection without procedure"},{"key":"D","text":"A visual inspection of the failed component"}]'::jsonb,
  '["A"]'::jsonb,
  'Resilience requirements must be demonstrated through controlled testing of failure, degraded operation, and recovery.'
),
(
  7,
  'multiple_choice',
  'application',
  'A late software update is required across several controllers on a nearly commissioned project. What is the BEST technical response?',
  '[{"key":"A","text":"Document the change, verify updated versions and backups, retest corrected functions, run risk-based regression tests on affected workflows, and refresh final evidence"},{"key":"B","text":"Install the update and keep all previous results without review"},{"key":"C","text":"Test only whether the controllers reboot"},{"key":"D","text":"Delete pre-update commissioning records"}]'::jsonb,
  '["A"]'::jsonb,
  'A late change alters the commissioned system state and must be reflected in verification and evidence.'
),
(
  8,
  'multiple_choice',
  'application',
  'A portfolio of similar sites shows recurring commissioning failures in the same workflow. What is the BEST leadership response?',
  '[{"key":"A","text":"Analyze the recurring defect pattern, identify whether the root cause is design, configuration, installation, documentation, training, or test-process related, then update the standard and verify the improvement"},{"key":"B","text":"Treat every site as unrelated"},{"key":"C","text":"Remove the workflow from future testing"},{"key":"D","text":"Accept the defect because it is common"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated commissioning failures should drive systemic corrective action rather than isolated project fixes.'
),
(
  9,
  'multiple_choice',
  'application',
  'A client requests final acceptance while several commissioning tests are still blocked by an unresolved third-party dependency. What is the BEST response?',
  '[{"key":"A","text":"Clearly identify the unverified requirements, dependency, risk, owner, and acceptance status rather than representing the system as fully commissioned"},{"key":"B","text":"Mark blocked tests passed"},{"key":"C","text":"Delete the blocked requirements"},{"key":"D","text":"Change acceptance criteria without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Final acceptance should accurately reflect what has and has not been verified.'
),
(
  10,
  'multiple_choice',
  'application',
  'A commissioning lead is reviewing whether a project is ready for handoff. What is the BEST readiness standard?',
  '[{"key":"A","text":"Required tests are complete or formally dispositioned, failures are resolved or accepted through the proper process, regression is complete, final documentation and backups match the field system, and evidence is traceable"},{"key":"B","text":"All equipment has been delivered"},{"key":"C","text":"The installation team has left the site"},{"key":"D","text":"Most systems appear to work"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning readiness depends on complete and traceable verification of the actual finished system.'
),
(
  11,
  'scenario',
  'scenario',
  'A campus project includes multiple buildings, redundant network paths, distributed control, security, AV, lighting, and centralized monitoring. The client requires defined local operation during a core-network outage. What is the BEST commissioning approach?',
  '[{"key":"A","text":"Create controlled failure scenarios that verify local operation, loss-of-core behavior, alarms, communication boundaries, recovery, synchronization after restoration, and documented acceptance criteria"},{"key":"B","text":"Test only normal campus operation"},{"key":"C","text":"Disconnect random equipment without a recovery plan"},{"key":"D","text":"Assume redundancy guarantees correct behavior"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex resilience requirements need deliberate end-to-end failure and recovery testing.'
),
(
  12,
  'scenario',
  'scenario',
  'A client has fifty similar sites and wants one commissioning standard, but the sites vary in size and system complexity. What is the BEST strategy?',
  '[{"key":"A","text":"Create a modular commissioning framework with common core tests, scalable test tiers, project-specific acceptance criteria, standard evidence formats, and controlled exceptions"},{"key":"B","text":"Use an identical checklist with identical tests at every site regardless of scope"},{"key":"C","text":"Let every site invent its own process"},{"key":"D","text":"Test only systems that failed at previous sites"}]'::jsonb,
  '["A"]'::jsonb,
  'A modular framework supports consistency while allowing the testing depth to match actual project requirements.'
),
(
  13,
  'scenario',
  'scenario',
  'A convention facility changes room configurations frequently and uses temporary AV, control, streaming, lighting, and network resources for events. What is the BEST commissioning model?',
  '[{"key":"A","text":"Use repeatable pre-event and post-change test procedures with defined baselines, temporary-configuration documentation, functional workflows, rollback plans, and rapid issue tracking"},{"key":"B","text":"Assume previously working rooms remain correct after every change"},{"key":"C","text":"Test only the network"},{"key":"D","text":"Avoid documenting temporary changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Dynamic environments require fast but disciplined recommissioning after meaningful configuration changes.'
),
(
  14,
  'scenario',
  'scenario',
  'A high-end residence is ready for handoff, but the client demonstration reveals intermittent failures that were not seen during the original commissioning tests. What is the BEST leadership response?',
  '[{"key":"A","text":"Treat the demonstration as new evidence, reproduce the failures under realistic conditions, review gaps in the original test process, correct root causes, and recommission affected workflows"},{"key":"B","text":"Dismiss the failures because the checklist was already signed"},{"key":"C","text":"Train the client to avoid the failing workflows"},{"key":"D","text":"Delete the original test records"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning evidence should be updated when real-world use reveals behavior that the test process failed to expose.'
),
(
  15,
  'scenario',
  'scenario',
  'A multi-system project has passed every subsystem test, but cross-system workflows have never been tested because different vendors own each subsystem. What is the BEST commissioning decision?',
  '[{"key":"A","text":"Define ownership for integrated tests, establish expected end-to-end behavior, coordinate vendors, execute the workflows, and document shared issues before acceptance"},{"key":"B","text":"Accept the project because each vendor passed its own system"},{"key":"C","text":"Remove integrated workflows from the scope"},{"key":"D","text":"Let the client discover integration issues after handoff"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated requirements must have clear test ownership even when responsibility spans multiple vendors.'
),
(
  16,
  'scenario',
  'scenario',
  'A large project has hundreds of commissioning results, but technicians used inconsistent naming, screenshots, and notes, making it difficult to prove which requirements passed. What is the BEST organizational correction?',
  '[{"key":"A","text":"Standardize requirement IDs, test names, result formats, evidence naming, issue links, ownership, and final reporting so results are traceable across the project"},{"key":"B","text":"Keep the inconsistent process and rely on memory"},{"key":"C","text":"Delete supporting evidence"},{"key":"D","text":"Record only future failures"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent evidence structure is essential for traceability and defensible project acceptance.'
),
(
  17,
  'scenario',
  'scenario',
  'A system was fully commissioned, then several devices were replaced under warranty before handoff. What is the BEST final-readiness approach?',
  '[{"key":"A","text":"Treat the replacements as system changes, verify configuration and firmware, retest affected functions, perform appropriate regression testing, and update backups and documentation"},{"key":"B","text":"Use the original commissioning results unchanged"},{"key":"C","text":"Test only whether replacement devices power on"},{"key":"D","text":"Remove the replacements from project records"}]'::jsonb,
  '["A"]'::jsonb,
  'Device replacement changes the commissioned state and requires verification of the affected system behavior.'
),
(
  18,
  'scenario',
  'scenario',
  'A project repeatedly reaches the end of installation with large numbers of commissioning failures caused by incomplete labels, missing configuration details, and unfinished prerequisites. What is the BEST long-term improvement?',
  '[{"key":"A","text":"Move commissioning readiness gates earlier, define prerequisite checklists, assign ownership, validate documentation progressively, and prevent formal testing from starting until required conditions are met"},{"key":"B","text":"Add more testing at the very end without changing workflow"},{"key":"C","text":"Accept missing prerequisites as normal"},{"key":"D","text":"Remove documentation from commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring end-stage failures often indicate that commissioning readiness must be built into earlier project phases.'
),
(
  19,
  'scenario',
  'scenario',
  'A service team struggles to support completed projects because final backups, firmware records, test evidence, credentials, and as-built documentation are inconsistent. What is the BEST commissioning-program lesson?',
  '[{"key":"A","text":"Serviceability and lifecycle support should be explicit commissioning deliverables with standardized final records and verified handoff requirements"},{"key":"B","text":"Commissioning ends when the client sees the system work once"},{"key":"C","text":"Service teams should reconstruct project information later"},{"key":"D","text":"Backups are optional if the system passed testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature commissioning process prepares the project not only for acceptance but also for reliable lifecycle support.'
),
(
  20,
  'scenario',
  'scenario',
  'An organization is creating an enterprise commissioning standard after years of inconsistent testing, undocumented field changes, weak handoffs, repeated callbacks, and unclear acceptance. What is the BEST long-term strategy?',
  '[{"key":"A","text":"Create a governed commissioning framework covering requirements traceability, prerequisites, test design, acceptance criteria, integrated workflows, resilience, regression, issue management, evidence, configuration control, backups, documentation, handoff, serviceability, metrics, and continuous improvement"},{"key":"B","text":"Create one generic checklist and leave all other practices unchanged"},{"key":"C","text":"Allow each technician to decide independently what counts as complete"},{"key":"D","text":"Focus only on reducing testing time"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature commissioning program requires an integrated framework that produces consistent, traceable, supportable evidence of system readiness.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '8afaef4d-439a-468f-8998-f6abc1413b76';
  v_l3_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l4_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
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
      and c.name = 'Testing & Commissioning'
      and c.is_current = true
  ) then
    raise exception 'Current Testing & Commissioning Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 Testing & Commissioning requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Operations Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Operations Manager L2 Testing & Commissioning requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician II — Experienced'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Technician II — Experienced L3 Testing & Commissioning requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Technician III — Lead Technician L4 Testing & Commissioning requirement not found';
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
  v_assessment_name := 'Testing & Commissioning — Level 1 Competency Assessment';

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
    select * from _seed_ci_testing_commissioning_l1_questions
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
        'Testing & Commissioning',
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
      'IntegrateU Testing & Commissioning L1 production assessment v1.0.',
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
        'Testing & Commissioning',
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
        'IntegrateU Testing & Commissioning L1 production assessment v1.0.',
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
  v_assessment_name := 'Testing & Commissioning — Level 2 Competency Assessment';

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
    select * from _seed_ci_testing_commissioning_l2_questions
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
        'Testing & Commissioning',
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
      'IntegrateU Testing & Commissioning L2 production assessment v1.0.',
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
        'Testing & Commissioning',
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
        'IntegrateU Testing & Commissioning L2 production assessment v1.0.',
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
  v_assessment_name := 'Testing & Commissioning — Level 3 Competency Assessment';

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
    select * from _seed_ci_testing_commissioning_l3_questions
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
        'Testing & Commissioning',
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
      'IntegrateU Testing & Commissioning L3 production assessment v1.0.',
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
        'Testing & Commissioning',
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
        'IntegrateU Testing & Commissioning L3 production assessment v1.0.',
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
  v_assessment_name := 'Testing & Commissioning — Level 4 Competency Assessment';

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
    select * from _seed_ci_testing_commissioning_l4_questions
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
        'Testing & Commissioning',
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
      'IntegrateU Testing & Commissioning L4 production assessment v1.0.',
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
        'Testing & Commissioning',
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
        'IntegrateU Testing & Commissioning L4 production assessment v1.0.',
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
   'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid
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
      'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid
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
    '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '8afaef4d-439a-468f-8998-f6abc1413b76'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '925c6250-5991-4179-afed-e47fa6a08a31'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    'cefefd09-9d5b-4a67-87a9-830180b5a016'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid;

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
    'fcde1e1b-6e9e-40b5-90cf-1c8e62f8971c'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
