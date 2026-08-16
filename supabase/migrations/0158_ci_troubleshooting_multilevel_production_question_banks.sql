-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0158_ci_troubleshooting_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Troubleshooting
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Logistics Manager                    -> Level 2
--   Technician II — Experienced                 -> Level 3
--   Technician III — Lead Technician                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess systematic diagnosis of equipment,
-- signal, network, configuration, and integration issues, including isolation,
-- verification, root cause, corrective action, and escalating troubleshooting judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_troubleshooting_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_troubleshooting_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary goal of troubleshooting?',
  '[{"key":"A","text":"To identify the cause of a problem and restore correct system operation"},{"key":"B","text":"To replace equipment before testing it"},{"key":"C","text":"To make random changes until something works"},{"key":"D","text":"To avoid documenting the issue"}]'::jsonb,
  '["A"]'::jsonb,
  'Troubleshooting is a structured process for identifying causes and restoring proper operation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should usually happen before changing equipment or configuration during troubleshooting?',
  '[{"key":"A","text":"Confirm and clearly define the reported symptom"},{"key":"B","text":"Replace the most expensive component"},{"key":"C","text":"Reset every device"},{"key":"D","text":"Assume the original diagnosis is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'A technician should understand the actual symptom before making corrective changes.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is changing one variable at a time useful during troubleshooting?',
  '[{"key":"A","text":"It helps show which change affected the problem"},{"key":"B","text":"It guarantees the first change will fix the issue"},{"key":"C","text":"It eliminates the need for testing"},{"key":"D","text":"It makes documentation unnecessary"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled changes make cause-and-effect easier to identify.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a symptom in troubleshooting?',
  '[{"key":"A","text":"The observable behavior or condition indicating that something is not working as expected"},{"key":"B","text":"The confirmed root cause of the problem"},{"key":"C","text":"The replacement part required"},{"key":"D","text":"The final service invoice"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom describes what is observed; it is not necessarily the underlying cause.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should a known-good condition or expected result be identified during troubleshooting?',
  '[{"key":"A","text":"It gives the technician something reliable to compare against the failing condition"},{"key":"B","text":"It eliminates the need to inspect the system"},{"key":"C","text":"It proves the customer caused the problem"},{"key":"D","text":"It guarantees the equipment must be replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'Troubleshooting depends on comparing actual behavior with expected behavior.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What does it mean to isolate a troubleshooting problem?',
  '[{"key":"A","text":"Narrow the issue to a smaller section, device, signal path, connection, or configuration area"},{"key":"B","text":"Disconnect the entire system permanently"},{"key":"C","text":"Replace every device in the system"},{"key":"D","text":"Ignore parts of the system that appear normal"}]'::jsonb,
  '["A"]'::jsonb,
  'Isolation reduces the number of possible causes and focuses testing.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why should troubleshooting findings be documented?',
  '[{"key":"A","text":"To create a record of symptoms, tests, findings, changes, and resolution for future reference"},{"key":"B","text":"Only to increase the length of the service report"},{"key":"C","text":"To avoid explaining the repair"},{"key":"D","text":"Only when a device is replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation helps others understand what was observed, tested, changed, and resolved.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should happen after a troubleshooting repair or corrective change is made?',
  '[{"key":"A","text":"Verify that the original problem is resolved and the affected system operates correctly"},{"key":"B","text":"Leave immediately after making the change"},{"key":"C","text":"Assume the repair worked if no error message appears"},{"key":"D","text":"Reset unrelated equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'A corrective action should be verified against the original symptom and expected operation.'
),
(
  9,
  'multiple_choice',
  'application',
  'A display has no picture. What is the BEST first troubleshooting action?',
  '[{"key":"A","text":"Confirm the symptom and check basic power, input selection, source operation, and signal connections"},{"key":"B","text":"Replace the display immediately"},{"key":"C","text":"Reprogram the entire control system"},{"key":"D","text":"Assume the HDMI cable is defective"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic verification should occur before more invasive or expensive troubleshooting.'
),
(
  10,
  'multiple_choice',
  'application',
  'A device does not power on. What should a technician check before replacing the device?',
  '[{"key":"A","text":"Verify the expected power source, connection, and any relevant power supply or protection device"},{"key":"B","text":"Replace the network switch"},{"key":"C","text":"Change the client password"},{"key":"D","text":"Reconfigure unrelated equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Loss of power can be caused upstream and should be verified before the device is condemned.'
),
(
  11,
  'multiple_choice',
  'application',
  'A network-connected device is offline while nearby devices are working normally. What is the BEST next step?',
  '[{"key":"A","text":"Check that device connection, link status, power, and network configuration before changing the wider network"},{"key":"B","text":"Restart every network device in the building"},{"key":"C","text":"Replace the router immediately"},{"key":"D","text":"Assume the internet provider is down"}]'::jsonb,
  '["A"]'::jsonb,
  'When the problem appears isolated to one device, troubleshooting should begin locally.'
),
(
  12,
  'multiple_choice',
  'application',
  'An audio zone has no sound but the source is playing correctly in another zone. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Trace the affected signal path and compare it with the working zone to isolate where the failure begins"},{"key":"B","text":"Replace the source"},{"key":"C","text":"Increase the volume on every zone"},{"key":"D","text":"Reset all system programming"}]'::jsonb,
  '["A"]'::jsonb,
  'A working comparison can help isolate the fault to the affected zone signal path.'
),
(
  13,
  'multiple_choice',
  'application',
  'A control command works sometimes and fails other times. What is the BEST first response?',
  '[{"key":"A","text":"Reproduce the issue and observe the conditions under which it succeeds or fails"},{"key":"B","text":"Replace every control device"},{"key":"C","text":"Assume the customer is using it incorrectly"},{"key":"D","text":"Delete the programming and start over"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent issues should be reproduced and correlated with conditions before corrective action is chosen.'
),
(
  14,
  'multiple_choice',
  'application',
  'A newly terminated cable does not pass a basic continuity or wire-map test. What is the BEST next step?',
  '[{"key":"A","text":"Inspect and retest the terminations and cable path before replacing unrelated equipment"},{"key":"B","text":"Replace the network switch"},{"key":"C","text":"Change system programming"},{"key":"D","text":"Ignore the failed test if the cable looks correct"}]'::jsonb,
  '["A"]'::jsonb,
  'A failed cable test should be addressed at the cable and termination level first.'
),
(
  15,
  'multiple_choice',
  'application',
  'A device worked before a configuration change and stopped working immediately afterward. What is the BEST troubleshooting clue?',
  '[{"key":"A","text":"The recent configuration change should be reviewed because it may be related to the new symptom"},{"key":"B","text":"The device must have failed at the same time"},{"key":"C","text":"The wiring should automatically be replaced"},{"key":"D","text":"The client network must be rebuilt"}]'::jsonb,
  '["A"]'::jsonb,
  'Recent changes are useful evidence when the timing aligns with the start of a problem.'
),
(
  16,
  'multiple_choice',
  'application',
  'A replacement component is installed but the original problem remains. What should the technician do?',
  '[{"key":"A","text":"Reconsider the diagnosis and continue isolating the actual cause rather than replacing more parts at random"},{"key":"B","text":"Replace the same component again"},{"key":"C","text":"Close the service ticket"},{"key":"D","text":"Assume the entire system is defective"}]'::jsonb,
  '["A"]'::jsonb,
  'If the predicted repair does not change the symptom, the diagnosis should be reevaluated.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician arrives for a service call reporting that a television has no picture. The television powers on and its menus display normally. Another source works on the same input path, but one source device does not. What is the BEST next step?',
  '[{"key":"A","text":"Focus troubleshooting on the failing source device and its immediate output or configuration rather than the television"},{"key":"B","text":"Replace the television"},{"key":"C","text":"Replace all cabling in the room"},{"key":"D","text":"Reset every device in the system"}]'::jsonb,
  '["A"]'::jsonb,
  'The working display and alternate source narrow the problem toward the failing source or its immediate connection.'
),
(
  18,
  'scenario',
  'scenario',
  'A newly installed network device is offline. Its power is on, but the network-port link indicator is dark. A known-good device connected to the same cable also shows no link. What is the BEST next action?',
  '[{"key":"A","text":"Test the cable path and termination because the evidence points toward the physical network connection"},{"key":"B","text":"Reprogram the original device"},{"key":"C","text":"Replace the internet service"},{"key":"D","text":"Change the client Wi-Fi password"}]'::jsonb,
  '["A"]'::jsonb,
  'A known-good device failing on the same connection strongly suggests the cable path or port should be investigated.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer reports that an audio zone cuts out occasionally. The technician cannot reproduce the issue immediately. What is the BEST response?',
  '[{"key":"A","text":"Gather details about when the failure occurs, attempt to reproduce it under those conditions, and inspect likely connections and components based on the evidence"},{"key":"B","text":"Replace the amplifier immediately"},{"key":"C","text":"Tell the customer nothing is wrong because it works now"},{"key":"D","text":"Replace every speaker in the zone"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent problems require evidence gathering and reproduction rather than unsupported part replacement.'
),
(
  20,
  'scenario',
  'scenario',
  'After repairing a faulty termination, a technician sees the device come online. What is the BEST final troubleshooting step?',
  '[{"key":"A","text":"Verify stable operation, confirm the original symptom is resolved, and document the cause and corrective action"},{"key":"B","text":"Leave as soon as the device appears online"},{"key":"C","text":"Replace the device anyway"},{"key":"D","text":"Reset unrelated systems"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful repair should be verified for stability and documented before the issue is considered resolved.'
);

create temporary table _seed_ci_troubleshooting_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_troubleshooting_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is a structured troubleshooting sequence more effective than making several changes at once?',
  '[{"key":"A","text":"It preserves evidence and makes it easier to identify which test or change affected the symptom"},{"key":"B","text":"It guarantees every problem can be solved without tools"},{"key":"C","text":"It eliminates the need to verify repairs"},{"key":"D","text":"It requires replacing fewer parts regardless of cause"}]'::jsonb,
  '["A"]'::jsonb,
  'A structured sequence helps preserve cause-and-effect evidence while narrowing the fault.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of dividing a system into functional sections during troubleshooting?',
  '[{"key":"A","text":"To isolate the failure by determining which section is working and which section is not"},{"key":"B","text":"To avoid testing individual components"},{"key":"C","text":"To reset the entire system more quickly"},{"key":"D","text":"To document only the final repair"}]'::jsonb,
  '["A"]'::jsonb,
  'Dividing the system into sections reduces the number of possible fault locations.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is a known-good substitute useful during troubleshooting?',
  '[{"key":"A","text":"It can help determine whether the original component, cable, port, or source is contributing to the failure"},{"key":"B","text":"It proves every original component is defective"},{"key":"C","text":"It eliminates the need to reproduce the issue"},{"key":"D","text":"It should replace the original permanently without further testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A known-good substitute is a controlled comparison that can help isolate a suspected failure.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is root cause in troubleshooting?',
  '[{"key":"A","text":"The underlying condition that produced the observed problem rather than only the visible symptom"},{"key":"B","text":"The first component a technician replaces"},{"key":"C","text":"The most expensive part of the system"},{"key":"D","text":"Any error message displayed by a device"}]'::jsonb,
  '["A"]'::jsonb,
  'Root cause explains why the symptom occurred and is the condition that must be corrected to prevent recurrence.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should a technician review recent system changes when diagnosing a new problem?',
  '[{"key":"A","text":"A recent hardware, wiring, configuration, firmware, or network change may be related to when the symptom began"},{"key":"B","text":"Recent changes are always the cause"},{"key":"C","text":"Older system components can then be ignored"},{"key":"D","text":"It eliminates the need for testing"}]'::jsonb,
  '["A"]'::jsonb,
  'The timing of recent changes can provide useful evidence, although the relationship still must be verified.'
),
(
  6,
  'multiple_choice',
  'application',
  'Several devices connected to one network switch are offline while devices on another switch are working. What is the BEST next step?',
  '[{"key":"A","text":"Check the affected switch, its power, uplink, port status, and related connections before changing the wider network"},{"key":"B","text":"Replace every offline device"},{"key":"C","text":"Restart the internet service immediately"},{"key":"D","text":"Change all device addresses"}]'::jsonb,
  '["A"]'::jsonb,
  'A shared failure among devices connected to one switch points toward common infrastructure that should be tested first.'
),
(
  7,
  'multiple_choice',
  'application',
  'A video source works when connected directly to a display but fails when routed through the installed signal path. What should be tested next?',
  '[{"key":"A","text":"The intermediate cable, extender, matrix, or other devices in the installed signal path"},{"key":"B","text":"The source power supply only"},{"key":"C","text":"The display menu system"},{"key":"D","text":"The client internet connection"}]'::jsonb,
  '["A"]'::jsonb,
  'Direct operation confirms the source and display can work, narrowing the fault to the intermediate path.'
),
(
  8,
  'multiple_choice',
  'application',
  'A controlled device responds correctly from its local controls but not from the automation system. What is the BEST troubleshooting direction?',
  '[{"key":"A","text":"Focus on the control path, communication, addressing, configuration, or programming between the automation system and the device"},{"key":"B","text":"Replace the controlled device immediately"},{"key":"C","text":"Assume the local controls are defective"},{"key":"D","text":"Replace all network equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct local operation suggests the problem is more likely in the external control path than in the device basic function.'
),
(
  9,
  'multiple_choice',
  'application',
  'A rack device repeatedly reboots under load but appears normal when idle. What is the BEST next step?',
  '[{"key":"A","text":"Observe power, thermal conditions, load behavior, and relevant system logs while reproducing the failure"},{"key":"B","text":"Replace all connected devices"},{"key":"C","text":"Ignore the issue because it works when idle"},{"key":"D","text":"Delete the device configuration"}]'::jsonb,
  '["A"]'::jsonb,
  'A load-dependent failure should be tested under the conditions that trigger it while likely power and thermal causes are observed.'
),
(
  10,
  'multiple_choice',
  'application',
  'A client reports slow network performance only in one area of the building. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Compare performance, connection method, signal conditions, cabling, and device behavior in the affected area with a known-good area"},{"key":"B","text":"Replace the internet router immediately"},{"key":"C","text":"Increase every network setting"},{"key":"D","text":"Assume the service provider is at fault"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparative testing helps determine whether the problem is local to the affected area or system-wide.'
),
(
  11,
  'multiple_choice',
  'application',
  'An audio system produces noise on one input but not on others. What should the technician do next?',
  '[{"key":"A","text":"Trace and test the affected input path, source, connection, and gain conditions while comparing them with a working input"},{"key":"B","text":"Replace every loudspeaker"},{"key":"C","text":"Increase the master volume"},{"key":"D","text":"Reset all unrelated devices"}]'::jsonb,
  '["A"]'::jsonb,
  'A problem isolated to one input should be traced through that specific signal path.'
),
(
  12,
  'multiple_choice',
  'application',
  'A replacement device has the same symptom as the original device. What does this evidence suggest?',
  '[{"key":"A","text":"The fault may be elsewhere in the shared power, signal, network, configuration, or integration path"},{"key":"B","text":"Both devices are definitely defective"},{"key":"C","text":"The replacement should be replaced again"},{"key":"D","text":"The symptom should be ignored"}]'::jsonb,
  '["A"]'::jsonb,
  'When two devices show the same symptom in the same environment, common upstream or downstream causes should be investigated.'
),
(
  13,
  'multiple_choice',
  'application',
  'A device communicates correctly after a reboot but fails again several hours later. What is the BEST next step?',
  '[{"key":"A","text":"Investigate the recurring condition using logs, timing, network behavior, resource use, power, or other evidence rather than treating the reboot as the repair"},{"key":"B","text":"Schedule automatic reboots and close the issue"},{"key":"C","text":"Replace unrelated cabling"},{"key":"D","text":"Assume the client is causing the failure"}]'::jsonb,
  '["A"]'::jsonb,
  'A temporary recovery does not establish root cause and should not be mistaken for a permanent repair.'
),
(
  14,
  'multiple_choice',
  'application',
  'A warehouse associate reports that several returned devices were labeled defective, but each powers on normally when tested. What is the BEST troubleshooting response?',
  '[{"key":"A","text":"Review the original symptoms and test conditions to determine whether the problem may have involved cabling, configuration, power, or another shared system factor"},{"key":"B","text":"Discard all returned devices"},{"key":"C","text":"Assume the original technicians tested incorrectly"},{"key":"D","text":"Return the devices to stock without documenting anything"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated no-fault-found returns should trigger review of the conditions surrounding the original failures.'
),
(
  15,
  'scenario',
  'scenario',
  'Three displays connected through the same distribution device lose video at the same time, while a fourth display connected directly to the source continues working. What is the BEST next troubleshooting step?',
  '[{"key":"A","text":"Investigate the shared distribution device, its power, input, output paths, and related configuration because the failure is common to the affected displays"},{"key":"B","text":"Replace all three displays"},{"key":"C","text":"Replace the source"},{"key":"D","text":"Change the internet service"}]'::jsonb,
  '["A"]'::jsonb,
  'The common point among the failed displays is the strongest place to focus initial testing.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer reports that a control system stops responding every afternoon. The technician confirms the issue occurs at roughly the same time each day. What is the BEST response?',
  '[{"key":"A","text":"Correlate the failure with scheduled events, network activity, power conditions, temperature, automation routines, or other time-based changes and test those hypotheses"},{"key":"B","text":"Replace every control processor immediately"},{"key":"C","text":"Ignore the timing because it may be coincidence"},{"key":"D","text":"Reset the system each morning"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeatable time pattern is valuable evidence and should be compared with other scheduled or environmental events.'
),
(
  17,
  'scenario',
  'scenario',
  'A network camera is reachable from the local network but cannot be viewed from the remote-access service. Other cameras are remotely accessible. What is the BEST troubleshooting direction?',
  '[{"key":"A","text":"Compare the affected camera remote-access configuration, registration, addressing, and service status with a working camera"},{"key":"B","text":"Replace the camera power supply first"},{"key":"C","text":"Rebuild the entire local network"},{"key":"D","text":"Replace every camera"}]'::jsonb,
  '["A"]'::jsonb,
  'Successful local communication narrows the issue toward the remote-access path or device-specific configuration.'
),
(
  18,
  'scenario',
  'scenario',
  'An intermittent audio dropout follows one source when that source is moved between two otherwise working inputs. What is the BEST conclusion?',
  '[{"key":"A","text":"The evidence points toward the source or its immediate connection because the symptom follows it"},{"key":"B","text":"Both inputs are defective"},{"key":"C","text":"The amplifier must be replaced"},{"key":"D","text":"The speaker wiring is definitely faulty"}]'::jsonb,
  '["A"]'::jsonb,
  'Moving a component between known-good paths is a useful isolation test; if the symptom follows the component, suspicion moves with it.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician changes several configuration settings at once and the problem disappears. Why is this a weak troubleshooting result?',
  '[{"key":"A","text":"The technician cannot identify which change corrected the issue or confidently determine the root cause"},{"key":"B","text":"Configuration changes can never solve problems"},{"key":"C","text":"The issue must have been hardware-related"},{"key":"D","text":"A working system never needs verification"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple simultaneous changes destroy useful evidence about which variable affected the failure.'
),
(
  20,
  'scenario',
  'scenario',
  'A repeated equipment failure has been corrected twice by replacing the same component, but the component fails again after several weeks. What is the BEST next step?',
  '[{"key":"A","text":"Investigate upstream and environmental causes such as power, heat, load, cabling, configuration, or operating conditions that may be damaging or destabilizing the component"},{"key":"B","text":"Replace the component a third time and take no other action"},{"key":"C","text":"Assume the manufacturer always sends defective units"},{"key":"D","text":"Disable the affected feature permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring failure of the same component suggests the replacement may be treating the symptom rather than the underlying cause.'
);

create temporary table _seed_ci_troubleshooting_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_troubleshooting_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What distinguishes advanced troubleshooting from basic fault finding?',
  '[{"key":"A","text":"It uses evidence, system dependencies, logs, controlled tests, and root-cause reasoning across multiple subsystems"},{"key":"B","text":"It replaces more components faster"},{"key":"C","text":"It avoids using known-good comparisons"},{"key":"D","text":"It focuses only on the most visible symptom"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced troubleshooting requires broader system reasoning and evidence-based isolation across interacting components.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are system logs and status data valuable during troubleshooting?',
  '[{"key":"A","text":"They can reveal timing, errors, state changes, communication failures, or patterns that are not visible from the symptom alone"},{"key":"B","text":"They replace the need to reproduce the issue"},{"key":"C","text":"They prove the hardware is always functioning correctly"},{"key":"D","text":"They should be reviewed only after replacing equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Logs and status information provide evidence that can help correlate symptoms with underlying events.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of forming a troubleshooting hypothesis?',
  '[{"key":"A","text":"To identify a plausible cause that can be tested with specific evidence and expected results"},{"key":"B","text":"To justify replacing the most likely device"},{"key":"C","text":"To avoid documenting test results"},{"key":"D","text":"To guarantee the technician is correct before testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A hypothesis turns observations into a testable explanation rather than an unsupported guess.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is rollback important after a recent system change causes instability?',
  '[{"key":"A","text":"Returning to a known-good state can help confirm whether the change contributed to the problem and restore service safely"},{"key":"B","text":"Rollback eliminates the need to determine root cause"},{"key":"C","text":"Every change should always be permanently reversed"},{"key":"D","text":"Rollback should be used only for hardware replacements"}]'::jsonb,
  '["A"]'::jsonb,
  'A controlled rollback is both a recovery tool and a diagnostic test when a recent change is suspected.'
),
(
  5,
  'multiple_choice',
  'application',
  'A system has intermittent control failures, but device power and network connectivity appear normal. What is the BEST next step?',
  '[{"key":"A","text":"Review control-system logs, communication status, addressing, configuration changes, and failure timing while reproducing the issue"},{"key":"B","text":"Replace the control processor immediately"},{"key":"C","text":"Restart every device repeatedly"},{"key":"D","text":"Replace all cabling before checking configuration"}]'::jsonb,
  '["A"]'::jsonb,
  'When basic infrastructure appears normal, deeper evidence from the control path and failure timing should guide isolation.'
),
(
  6,
  'multiple_choice',
  'application',
  'A video system fails only when routed through a specific matrix output, while the same source and display work through another output. What is the BEST conclusion?',
  '[{"key":"A","text":"The evidence narrows the fault toward that output path, related configuration, cabling, or downstream interface"},{"key":"B","text":"The source is definitely defective"},{"key":"C","text":"The display should be replaced"},{"key":"D","text":"The entire matrix must be replaced immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparative testing isolates the issue to the specific path without yet proving which element in that path is at fault.'
),
(
  7,
  'multiple_choice',
  'application',
  'A device becomes unreachable only after a configuration update. Rolling back the configuration restores communication. What is the BEST interpretation?',
  '[{"key":"A","text":"The update is strongly implicated, and the changed settings should be reviewed to identify the specific cause before reapplying them"},{"key":"B","text":"The device hardware must still be replaced"},{"key":"C","text":"The rollback proves the network is defective"},{"key":"D","text":"The updated configuration should be reapplied without review"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful rollback provides strong evidence that the configuration change contributed to the failure.'
),
(
  8,
  'multiple_choice',
  'application',
  'A system experiences packet loss only when several high-bandwidth devices are active. What is the BEST troubleshooting direction?',
  '[{"key":"A","text":"Observe network utilization, interface errors, uplink capacity, switching behavior, and affected traffic paths under load"},{"key":"B","text":"Replace every endpoint"},{"key":"C","text":"Change all device names"},{"key":"D","text":"Assume the internet provider is responsible"}]'::jsonb,
  '["A"]'::jsonb,
  'A load-dependent network symptom should be diagnosed under the conditions that trigger it using relevant performance evidence.'
),
(
  9,
  'multiple_choice',
  'application',
  'A recurring service issue is resolved temporarily by rebooting a processor. What should an experienced technician do next?',
  '[{"key":"A","text":"Treat the reboot as a temporary recovery and investigate logs, resource conditions, communication state, software behavior, and recurrence patterns"},{"key":"B","text":"Automate daily reboots and close the issue"},{"key":"C","text":"Replace unrelated devices"},{"key":"D","text":"Document only that the reboot worked"}]'::jsonb,
  '["A"]'::jsonb,
  'Temporary recovery is not equivalent to root-cause resolution.'
),
(
  10,
  'multiple_choice',
  'application',
  'A device intermittently drops offline, but the local cable tests correctly. What is the BEST next step?',
  '[{"key":"A","text":"Correlate the dropouts with switch-port status, logs, power, addressing, configuration, traffic conditions, and device behavior"},{"key":"B","text":"Replace the tested cable anyway"},{"key":"C","text":"Ignore the issue until it fails permanently"},{"key":"D","text":"Rebuild the entire network"}]'::jsonb,
  '["A"]'::jsonb,
  'Once a basic physical-layer test passes, troubleshooting should move to other evidence that can explain intermittent communication loss.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician identifies a likely firmware defect affecting several devices. What is the BEST next action?',
  '[{"key":"A","text":"Collect reproducible evidence, confirm affected versions and conditions, review approved remedies, and escalate or update through controlled change procedures"},{"key":"B","text":"Install any available firmware immediately on every system"},{"key":"C","text":"Replace all affected devices before documenting the issue"},{"key":"D","text":"Ignore the pattern until more failures occur"}]'::jsonb,
  '["A"]'::jsonb,
  'Suspected systemic defects should be supported by evidence and handled through controlled corrective action and escalation.'
),
(
  12,
  'scenario',
  'scenario',
  'A home has intermittent automation failures across lighting, audio, and climate control. The failures occur at the same time, and all affected systems depend on the same control processor. What is the BEST next step?',
  '[{"key":"A","text":"Investigate the shared processor, its communication state, power, logs, resource usage, and dependencies because it is a common failure point"},{"key":"B","text":"Replace devices in each subsystem separately"},{"key":"C","text":"Rewire the lighting system first"},{"key":"D","text":"Assume three unrelated failures occurred simultaneously"}]'::jsonb,
  '["A"]'::jsonb,
  'A shared dependency across multiple failing subsystems should be tested before treating the symptoms as separate faults.'
),
(
  13,
  'scenario',
  'scenario',
  'A client reports that video freezes only during certain automated scenes. Manual source selection works normally. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Reproduce the scene, review the sequence of commands and timing, compare it with successful manual operation, and isolate the step that causes the failure"},{"key":"B","text":"Replace the display"},{"key":"C","text":"Replace all video cabling"},{"key":"D","text":"Disable automation permanently without further testing"}]'::jsonb,
  '["A"]'::jsonb,
  'The difference between automated and manual operation points toward sequence, timing, configuration, or control interaction.'
),
(
  14,
  'scenario',
  'scenario',
  'A networked audio system works normally until a new managed switch configuration is deployed. Afterward, multicast audio becomes unstable. What is the BEST response?',
  '[{"key":"A","text":"Compare the new switch configuration with the previous known-good state, review multicast-related settings and traffic behavior, and roll back if needed to confirm the change"},{"key":"B","text":"Replace all audio endpoints"},{"key":"C","text":"Increase amplifier gain"},{"key":"D","text":"Assume every cable failed at once"}]'::jsonb,
  '["A"]'::jsonb,
  'The timing of the configuration change and multicast-specific symptom make controlled comparison and rollback appropriate.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician replaces a processor because of repeated lockups, but the replacement begins locking up under the same conditions. What is the BEST next step?',
  '[{"key":"A","text":"Investigate shared environmental and system causes such as power quality, heat, network traffic, connected devices, software conditions, or configuration"},{"key":"B","text":"Replace the processor again"},{"key":"C","text":"Assume the manufacturer sent two defective units"},{"key":"D","text":"Disable logging to reduce processor load"}]'::jsonb,
  '["A"]'::jsonb,
  'The same symptom on multiple processors suggests a shared external or systemic cause rather than repeated independent hardware failure.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer reports a failure that occurs only once every few days. The team has already made several undocumented changes and can no longer tell which conditions matter. What is the BEST recovery approach?',
  '[{"key":"A","text":"Establish a known baseline, document current configuration, stop uncontrolled changes, capture logs and timing, and reproduce the failure systematically"},{"key":"B","text":"Continue changing settings until the issue disappears"},{"key":"C","text":"Replace all equipment at once"},{"key":"D","text":"Close the issue because it is intermittent"}]'::jsonb,
  '["A"]'::jsonb,
  'When prior uncontrolled changes have damaged the evidence trail, troubleshooting should reestablish a baseline and controlled process.'
),
(
  17,
  'scenario',
  'scenario',
  'A complex system fails after a software update, but only on sites using one specific hardware revision. What is the BEST troubleshooting response?',
  '[{"key":"A","text":"Compare affected and unaffected sites, confirm the hardware and software combination, reproduce the behavior, and escalate with evidence if the pattern holds"},{"key":"B","text":"Downgrade every site regardless of hardware"},{"key":"C","text":"Replace all hardware revisions"},{"key":"D","text":"Assume the issue is unrelated to the update"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparing affected and unaffected populations can reveal compatibility patterns and provide strong escalation evidence.'
),
(
  18,
  'scenario',
  'scenario',
  'A control system intermittently misses commands. Logs show the command leaves the processor, but the target device sometimes never acknowledges it. What is the BEST next step?',
  '[{"key":"A","text":"Investigate the communication path between processor and target, including transport reliability, addressing, interface state, device response, and timing"},{"key":"B","text":"Rewrite the user interface"},{"key":"C","text":"Replace unrelated sources"},{"key":"D","text":"Assume the processor never sent the command"}]'::jsonb,
  '["A"]'::jsonb,
  'The logs move the fault boundary beyond command generation and toward the downstream communication or device-response path.'
),
(
  19,
  'scenario',
  'scenario',
  'A recurring service issue has been resolved several times by different technicians, but it keeps returning. What is the BEST leadership-level technical response?',
  '[{"key":"A","text":"Review prior service history, compare previous fixes, identify common conditions, reproduce the failure, and determine whether earlier work addressed symptoms rather than root cause"},{"key":"B","text":"Assign a different technician each time without reviewing history"},{"key":"C","text":"Replace all equipment in the system"},{"key":"D","text":"Stop documenting repeat visits"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated recurrence should trigger a broader root-cause review using the accumulated service evidence.'
),
(
  20,
  'scenario',
  'scenario',
  'An experienced technician cannot resolve a complex multi-vendor integration issue within the available evidence and authorized scope. What is the BEST next step?',
  '[{"key":"A","text":"Escalate with a concise record of symptoms, environment, tests performed, results, logs, changes, and the remaining hypotheses"},{"key":"B","text":"Continue making unapproved changes indefinitely"},{"key":"C","text":"Replace random components before escalating"},{"key":"D","text":"Escalate without documenting any prior work"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective escalation preserves troubleshooting progress and gives the next resource usable evidence rather than forcing the process to restart.'
);

create temporary table _seed_ci_troubleshooting_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_troubleshooting_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an expert-level troubleshooting process?',
  '[{"key":"A","text":"To resolve complex failures through disciplined evidence gathering, hypothesis testing, root-cause analysis, controlled corrective action, and prevention of recurrence"},{"key":"B","text":"To replace failed equipment as quickly as possible"},{"key":"C","text":"To rely primarily on technician experience without documentation"},{"key":"D","text":"To restore operation without determining why the failure occurred"}]'::jsonb,
  '["A"]'::jsonb,
  'Expert troubleshooting combines technical recovery with root-cause determination and recurrence prevention.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should complex troubleshooting distinguish correlation from causation?',
  '[{"key":"A","text":"Two events occurring together do not prove that one caused the other, so the suspected relationship must be tested"},{"key":"B","text":"Correlated events should always be treated as unrelated"},{"key":"C","text":"Causation can be established from timing alone"},{"key":"D","text":"Only hardware failures require proof of causation"}]'::jsonb,
  '["A"]'::jsonb,
  'Strong troubleshooting validates whether an observed relationship actually explains the failure.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the value of a post-incident root-cause review after a major technical failure?',
  '[{"key":"A","text":"It identifies contributing conditions, corrective actions, process improvements, and lessons that can reduce future recurrence"},{"key":"B","text":"It determines which individual should be blamed"},{"key":"C","text":"It eliminates the need to document the repair"},{"key":"D","text":"It should occur only when equipment is permanently damaged"}]'::jsonb,
  '["A"]'::jsonb,
  'Post-incident review converts a resolved failure into organizational learning and preventive action.'
),
(
  4,
  'multiple_choice',
  'application',
  'Several projects using the same device model begin experiencing an identical intermittent failure after a firmware release. What is the BEST response?',
  '[{"key":"A","text":"Compare affected versions and environments, reproduce the issue where possible, preserve evidence, evaluate approved rollback or remediation, and coordinate escalation with the manufacturer"},{"key":"B","text":"Replace every affected device immediately without testing"},{"key":"C","text":"Assume each site has a different wiring problem"},{"key":"D","text":"Ignore the pattern until all devices fail"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated cross-site pattern should be treated as a potential systemic issue and investigated with controlled evidence.'
),
(
  5,
  'multiple_choice',
  'application',
  'A senior technician is troubleshooting a complex system where each subsystem works independently, but failures occur when the subsystems interact. What is the BEST approach?',
  '[{"key":"A","text":"Focus on integration boundaries, dependencies, timing, data exchange, control paths, shared infrastructure, and state transitions between subsystems"},{"key":"B","text":"Replace the individual subsystems even though they work independently"},{"key":"C","text":"Ignore subsystem interaction because each component passes standalone testing"},{"key":"D","text":"Test only the user interface"}]'::jsonb,
  '["A"]'::jsonb,
  'Failures that appear only during interaction point toward interfaces, dependencies, timing, or integration logic.'
),
(
  6,
  'multiple_choice',
  'application',
  'A team repeatedly resolves the same service symptom using different temporary fixes. What should the lead technician do?',
  '[{"key":"A","text":"Review the service history, identify common conditions, standardize evidence collection, reproduce the issue, and drive the team toward root cause rather than repeated symptom relief"},{"key":"B","text":"Allow each technician to continue using a preferred temporary fix"},{"key":"C","text":"Replace unrelated equipment on every visit"},{"key":"D","text":"Stop reviewing previous service records"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring symptoms require coordinated analysis rather than repeated isolated recovery actions.'
),
(
  7,
  'multiple_choice',
  'application',
  'A complex intermittent failure cannot be reproduced during normal service hours. What is the BEST troubleshooting plan?',
  '[{"key":"A","text":"Define the suspected conditions, increase targeted logging or monitoring, preserve timestamps and environmental context, and collect evidence when the event recurs"},{"key":"B","text":"Close the issue because it cannot be reproduced immediately"},{"key":"C","text":"Replace every possible component"},{"key":"D","text":"Disable logging because it may complicate the diagnosis"}]'::jsonb,
  '["A"]'::jsonb,
  'For rare intermittent failures, targeted monitoring can capture evidence that direct observation misses.'
),
(
  8,
  'multiple_choice',
  'application',
  'A troubleshooting team has three plausible causes for a major system failure. What is the BEST way to proceed?',
  '[{"key":"A","text":"Prioritize hypotheses by evidence, likelihood, impact, and testability, then run controlled tests that distinguish among them"},{"key":"B","text":"Make corrective changes for all three causes simultaneously"},{"key":"C","text":"Choose the most expensive possible cause first"},{"key":"D","text":"Vote on the cause and repair it without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Competing hypotheses should be differentiated using tests designed to produce meaningful evidence.'
),
(
  9,
  'multiple_choice',
  'application',
  'A vendor recommends replacing a major component, but the team evidence does not yet isolate the failure to that component. What is the BEST response?',
  '[{"key":"A","text":"Review the vendor recommendation against the collected evidence and perform reasonable isolation tests before authorizing replacement unless urgency or safety requires otherwise"},{"key":"B","text":"Replace the component solely because the vendor suggested it"},{"key":"C","text":"Ignore the vendor entirely"},{"key":"D","text":"Replace several additional components at the same time"}]'::jsonb,
  '["A"]'::jsonb,
  'Vendor guidance is useful, but high-impact corrective actions should still align with evidence and controlled diagnosis.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician discovers that different technicians document troubleshooting in inconsistent ways. What is the BEST improvement?',
  '[{"key":"A","text":"Establish a standard troubleshooting record that captures symptom, environment, hypothesis, tests, results, changes, root cause, resolution, and verification"},{"key":"B","text":"Require documentation only when escalation occurs"},{"key":"C","text":"Let each technician use personal notes only"},{"key":"D","text":"Document only the final replacement part"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent troubleshooting records make technical evidence reusable across technicians, service visits, and escalation.'
),
(
  11,
  'scenario',
  'scenario',
  'A large integrated system begins failing after several unrelated changes were made during the same maintenance window. Network settings, device firmware, and control programming were all modified. What is the BEST recovery strategy?',
  '[{"key":"A","text":"Establish the last known-good baseline, document all changes, prioritize likely dependencies, and roll back or test changes in a controlled sequence until the failure boundary is identified"},{"key":"B","text":"Change additional settings until the problem disappears"},{"key":"C","text":"Replace all equipment touched during the maintenance window"},{"key":"D","text":"Assume the final change made must be the cause"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple simultaneous changes require controlled reconstruction of the change history and a return toward a known baseline.'
),
(
  12,
  'scenario',
  'scenario',
  'A company has the same intermittent networked-control failure at five sites. Each site uses different local cabling but the same controller model and software version. What is the BEST next step?',
  '[{"key":"A","text":"Treat the shared controller and software combination as a leading hypothesis, compare logs and conditions across sites, and build reproducible evidence for controlled remediation or vendor escalation"},{"key":"B","text":"Replace all local cabling at every site"},{"key":"C","text":"Assume all five sites have unrelated failures"},{"key":"D","text":"Reboot the controllers periodically and stop investigating"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated failure across different environments with a shared technology stack is strong evidence of a systemic pattern worth testing.'
),
(
  13,
  'scenario',
  'scenario',
  'A system outage affects audio, video, lighting control, and security interfaces. All subsystems rely on the same core network, but basic internet access still works. What is the BEST troubleshooting response?',
  '[{"key":"A","text":"Investigate the shared internal network services, switching, segmentation, addressing, multicast, control traffic, and dependencies used by the integrated subsystems rather than assuming internet access proves the network is healthy"},{"key":"B","text":"Replace devices in each subsystem separately"},{"key":"C","text":"Contact the internet provider first"},{"key":"D","text":"Reset only the audio system"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic internet connectivity does not prove that internal services required by integrated systems are operating correctly.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician determines that an equipment failure was caused by overheating in a poorly ventilated rack. The failed component is replaced and operation is restored. What is the BEST next action?',
  '[{"key":"A","text":"Correct the thermal condition, verify operating temperature under load, document the root cause, and evaluate whether other equipment may have been affected"},{"key":"B","text":"Close the ticket because the failed component was replaced"},{"key":"C","text":"Replace every rack component"},{"key":"D","text":"Increase system load to test the new device"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacing the failed component treats the immediate failure; correcting the thermal cause prevents recurrence.'
),
(
  15,
  'scenario',
  'scenario',
  'A senior technician receives an escalation with only the note system does not work and no record of prior testing. What is the BEST leadership response?',
  '[{"key":"A","text":"Reestablish the evidence baseline for the current issue and coach the team to include symptoms, tests, results, changes, logs, and remaining hypotheses in future escalations"},{"key":"B","text":"Start replacing equipment immediately"},{"key":"C","text":"Refuse all future escalations"},{"key":"D","text":"Assume the previous technician already eliminated basic causes"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor escalation documentation wastes troubleshooting progress and should be corrected as both a technical and coaching issue.'
),
(
  16,
  'scenario',
  'scenario',
  'A complex system occasionally fails during high client activity, but all individual devices pass bench tests. What is the BEST next troubleshooting approach?',
  '[{"key":"A","text":"Reproduce the system under realistic load while monitoring shared resources, network traffic, processing capacity, power, heat, timing, and subsystem interactions"},{"key":"B","text":"Replace devices that passed bench tests"},{"key":"C","text":"Test only during low activity"},{"key":"D","text":"Assume the client behavior is the root cause"}]'::jsonb,
  '["A"]'::jsonb,
  'System-level failures may appear only under realistic load and interaction conditions that bench testing does not reproduce.'
),
(
  17,
  'scenario',
  'scenario',
  'A firmware update resolves one known problem but introduces a new integration failure on a critical system. What is the BEST response?',
  '[{"key":"A","text":"Assess operational impact, preserve evidence, compare with the known-good version, use an approved rollback or mitigation when appropriate, and escalate the compatibility issue with reproducible findings"},{"key":"B","text":"Leave the new failure because the original problem was fixed"},{"key":"C","text":"Update unrelated devices until the issue changes"},{"key":"D","text":"Delete previous firmware records"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective changes must be evaluated for new failures and managed through controlled recovery and escalation.'
),
(
  18,
  'scenario',
  'scenario',
  'A team resolves a critical outage but cannot prove which of several emergency changes restored service. What should happen after stability is restored?',
  '[{"key":"A","text":"Document the emergency changes, establish a controlled baseline, recreate or test the likely failure conditions where safe, and determine root cause before considering the incident fully closed"},{"key":"B","text":"Leave all emergency changes undocumented because the system works"},{"key":"C","text":"Undo every change immediately in production"},{"key":"D","text":"Select one change as the cause without further evidence"}]'::jsonb,
  '["A"]'::jsonb,
  'Emergency recovery may restore service without establishing cause; controlled follow-up is needed to understand and prevent recurrence.'
),
(
  19,
  'scenario',
  'scenario',
  'A lead technician notices that field teams frequently escalate problems that could have been isolated with basic comparison tests. What is the BEST organizational response?',
  '[{"key":"A","text":"Coach technicians on a standard diagnostic sequence, provide troubleshooting checklists and known-good test methods, review escalations for evidence quality, and reinforce progressive technical judgment"},{"key":"B","text":"Stop technicians from escalating problems"},{"key":"C","text":"Require senior technicians to solve every issue personally"},{"key":"D","text":"Replace troubleshooting training with more documentation forms"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature troubleshooting system develops technician capability while improving the quality of evidence sent to higher-level resources.'
),
(
  20,
  'scenario',
  'scenario',
  'An organization sees repeated callbacks caused by misdiagnosis, uncontrolled configuration changes, incomplete documentation, and temporary fixes being treated as permanent repairs. What is the BEST long-term response?',
  '[{"key":"A","text":"Standardize the troubleshooting workflow around symptom confirmation, evidence collection, hypothesis testing, controlled changes, root-cause analysis, verification, documentation, escalation standards, and review of recurring failures"},{"key":"B","text":"Require technicians to replace more components on the first visit"},{"key":"C","text":"Measure only how quickly service tickets are closed"},{"key":"D","text":"Allow each technician to create a different troubleshooting method"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring troubleshooting failures require a repeatable diagnostic operating system rather than isolated corrections.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '64c2993f-de84-406a-aafa-09d710d1d7ec';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '006a91b3-38dc-4d13-9532-f22d839af945';
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
      and c.name = 'Troubleshooting'
      and c.is_current = true
  ) then
    raise exception 'Current Troubleshooting Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 Troubleshooting requirement not found';
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
    raise exception 'Current Logistics Manager L2 Troubleshooting requirement not found';
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
    raise exception 'Current Technician II — Experienced L3 Troubleshooting requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Troubleshooting requirement not found';
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
  v_assessment_name := 'Troubleshooting — Level 1 Competency Assessment';

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
    select * from _seed_ci_troubleshooting_l1_questions
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
        'Troubleshooting',
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
      'IntegrateU Troubleshooting L1 production assessment v1.0.',
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
        'Troubleshooting',
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
        'IntegrateU Troubleshooting L1 production assessment v1.0.',
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
  v_assessment_name := 'Troubleshooting — Level 2 Competency Assessment';

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
    select * from _seed_ci_troubleshooting_l2_questions
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
        'Troubleshooting',
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
      'IntegrateU Troubleshooting L2 production assessment v1.0.',
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
        'Troubleshooting',
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
        'IntegrateU Troubleshooting L2 production assessment v1.0.',
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
  v_assessment_name := 'Troubleshooting — Level 3 Competency Assessment';

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
    select * from _seed_ci_troubleshooting_l3_questions
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
        'Troubleshooting',
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
      'IntegrateU Troubleshooting L3 production assessment v1.0.',
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
        'Troubleshooting',
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
        'IntegrateU Troubleshooting L3 production assessment v1.0.',
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
  v_assessment_name := 'Troubleshooting — Level 4 Competency Assessment';

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
    select * from _seed_ci_troubleshooting_l4_questions
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
        'Troubleshooting',
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
      'IntegrateU Troubleshooting L4 production assessment v1.0.',
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
        'Troubleshooting',
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
        'IntegrateU Troubleshooting L4 production assessment v1.0.',
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
