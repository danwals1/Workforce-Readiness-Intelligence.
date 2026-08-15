-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_airflow_static_pressure_ventilation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Brazing, Joining & Leak Prevention
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
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

create temporary table _seed_hvac_brazing_joining_leak_prevention_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_brazing_joining_leak_prevention_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of brazing in HVAC refrigerant-piping work?',
  '[{"key":"A","text":"To create a strong, leak-resistant joint between compatible piping components"},{"key":"B","text":"To increase refrigerant pressure"},{"key":"C","text":"To clean the inside of the tubing"},{"key":"D","text":"To replace pressure testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Brazing is used to create strong, properly joined refrigerant-piping connections that can remain leak resistant under service conditions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should copper tubing and fittings be clean before making a brazed joint?',
  '[{"key":"A","text":"Clean mating surfaces help support a sound, reliable joint"},{"key":"B","text":"Cleaning increases tubing wall thickness"},{"key":"C","text":"Cleaning eliminates the need for heat"},{"key":"D","text":"Cleaning changes the refrigerant type"}]'::jsonb,
  '["A"]'::jsonb,
  'Contamination on joining surfaces can interfere with proper brazing and joint quality.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is dry nitrogen commonly flowed through refrigerant tubing during brazing?',
  '[{"key":"A","text":"To limit internal oxidation and scale formation inside the tubing"},{"key":"B","text":"To increase brazing temperature"},{"key":"C","text":"To pressurize the system to operating pressure while brazing"},{"key":"D","text":"To cool the torch flame"}]'::jsonb,
  '["A"]'::jsonb,
  'A low flow of dry nitrogen during brazing helps reduce internal oxidation that can contaminate the refrigerant circuit.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should be done before applying a torch near combustible materials?',
  '[{"key":"A","text":"Identify and control the fire exposure using the approved hot-work precautions"},{"key":"B","text":"Increase the flame size so the work finishes faster"},{"key":"C","text":"Wet only the copper tubing"},{"key":"D","text":"Turn off the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Torch work creates an ignition hazard, so combustible exposures and required hot-work controls should be addressed before heating begins.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of properly supporting refrigerant tubing near joined connections?',
  '[{"key":"A","text":"To limit unnecessary stress and movement at the joints"},{"key":"B","text":"To increase refrigerant velocity"},{"key":"C","text":"To eliminate the need for leak testing"},{"key":"D","text":"To make the tubing conduct more heat"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper support helps keep piping movement and mechanical stress from being transferred into joined connections.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should a completed refrigerant-piping joint be checked for leaks before the system is placed into normal operation?',
  '[{"key":"A","text":"A joint can appear acceptable but still leak under pressure"},{"key":"B","text":"Leak checking increases system capacity"},{"key":"C","text":"Leak checking replaces evacuation"},{"key":"D","text":"Every brazed joint is expected to leak initially"}]'::jsonb,
  '["A"]'::jsonb,
  'Visual appearance alone does not prove a joint is leak tight, so appropriate leak verification is required.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is a likely risk of overheating a brazed connection?',
  '[{"key":"A","text":"Damage to tubing, fittings, nearby components, or joint quality"},{"key":"B","text":"Improved joint strength in every case"},{"key":"C","text":"Automatic removal of all contamination"},{"key":"D","text":"Elimination of the need for filler material"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive heat can damage components and compromise a properly controlled brazing process.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should nearby valves, sensors, or other heat-sensitive components be protected during brazing?',
  '[{"key":"A","text":"Excessive heat can damage components that are not intended to reach brazing temperatures"},{"key":"B","text":"Protection increases refrigerant flow"},{"key":"C","text":"Protection replaces system isolation"},{"key":"D","text":"Heat-sensitive components improve when heated"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat from brazing can travel into adjacent components and damage seals, sensors, valves, or other heat-sensitive parts.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is preparing a copper joint and notices dirt and oil on the mating surfaces. What should happen before brazing?',
  '[{"key":"A","text":"Clean and prepare the joint surfaces using the approved method"},{"key":"B","text":"Apply more heat to burn the contamination away"},{"key":"C","text":"Add extra filler material over the contamination"},{"key":"D","text":"Braze the joint and clean it afterward"}]'::jsonb,
  '["A"]'::jsonb,
  'Joint surfaces should be properly prepared before heating so contamination does not interfere with joint quality.'
),
(
  10,
  'multiple_choice',
  'application',
  'An installer is ready to braze refrigerant tubing but the nitrogen cylinder is empty. What is the BEST response?',
  '[{"key":"A","text":"Obtain the required dry nitrogen and proper setup before brazing the refrigerant circuit"},{"key":"B","text":"Use oxygen instead"},{"key":"C","text":"Braze without nitrogen because the joint is small"},{"key":"D","text":"Use refrigerant vapor as the purge gas"}]'::jsonb,
  '["A"]'::jsonb,
  'The approved nitrogen-purge practice should be available before brazing rather than skipped for convenience.'
),
(
  11,
  'multiple_choice',
  'application',
  'A copper tube does not fully seat into the fitting before brazing. What should the installer do?',
  '[{"key":"A","text":"Correct the fit and insertion before heating the joint"},{"key":"B","text":"Fill the gap with extra brazing alloy"},{"key":"C","text":"Heat the fitting until the tube drops into place"},{"key":"D","text":"Braze only the visible side"}]'::jsonb,
  '["A"]'::jsonb,
  'The tubing and fitting should have the intended mechanical fit before the brazing process begins.'
),
(
  12,
  'multiple_choice',
  'application',
  'A service valve is close to a connection that must be brazed. What is the BEST approach?',
  '[{"key":"A","text":"Use the approved heat-control and component-protection method while making the connection"},{"key":"B","text":"Heat the valve body directly so the joint warms faster"},{"key":"C","text":"Remove all valve protection"},{"key":"D","text":"Assume the valve cannot be damaged"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat-sensitive components near the joint should be protected using the appropriate installation procedure.'
),
(
  13,
  'multiple_choice',
  'application',
  'After brazing, an installer sees that a refrigerant line is pulling sideways on the new joint because the tubing is poorly supported. What should be done?',
  '[{"key":"A","text":"Correct the piping support and alignment so the joint is not left under unnecessary stress"},{"key":"B","text":"Leave it because the brazed joint will hold the tubing in place"},{"key":"C","text":"Heat the joint again to make it flexible"},{"key":"D","text":"Add refrigerant to stabilize the tubing"}]'::jsonb,
  '["A"]'::jsonb,
  'Joined piping should be aligned and supported so mechanical loads are not unnecessarily carried by the joint.'
),
(
  14,
  'multiple_choice',
  'application',
  'A joint has been brazed and visually looks complete. What is the BEST next quality step before final system operation?',
  '[{"key":"A","text":"Perform the required leak-verification process and continue the approved commissioning steps"},{"key":"B","text":"Assume the joint is leak free"},{"key":"C","text":"Paint the joint to seal it"},{"key":"D","text":"Immediately energize the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'A completed joint should be verified through the required leak-checking process rather than accepted by appearance alone.'
),
(
  15,
  'multiple_choice',
  'application',
  'An installer notices black scale forming inside an open piece of copper tubing while practicing a brazed connection without nitrogen. What does this demonstrate?',
  '[{"key":"A","text":"Heating copper in air can create internal oxidation that a nitrogen purge is intended to reduce"},{"key":"B","text":"The tubing has too much refrigerant in it"},{"key":"C","text":"The filler material is automatically defective"},{"key":"D","text":"The tubing is properly cleaned by the flame"}]'::jsonb,
  '["A"]'::jsonb,
  'Internal oxidation forms when heated copper is exposed to oxygen, which is why nitrogen purging is used during refrigerant-circuit brazing.'
),
(
  16,
  'multiple_choice',
  'application',
  'An installer needs to braze near finished wall material that could be damaged by heat or flame. What is the BEST response?',
  '[{"key":"A","text":"Protect or remove the exposed material as required and follow the approved hot-work precautions"},{"key":"B","text":"Aim the flame away and ignore the material"},{"key":"C","text":"Use a larger torch tip to finish faster"},{"key":"D","text":"Rely on the copper tube to block the heat"}]'::jsonb,
  '["A"]'::jsonb,
  'Nearby combustible or heat-sensitive building materials should be controlled before hot work begins.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer finishes brazing several line-set joints and is preparing for evacuation. One joint shows oily residue at the connection after the piping has been pressurized for leak checking. What is the BEST response?',
  '[{"key":"A","text":"Treat the joint as suspect, verify the leak, and correct it before evacuation and charging"},{"key":"B","text":"Wipe the oil away and continue"},{"key":"C","text":"Add more refrigerant after startup"},{"key":"D","text":"Cover the joint with insulation"}]'::jsonb,
  '["A"]'::jsonb,
  'Oily residue at a refrigerant connection can indicate leakage and should be investigated and corrected before proceeding.'
),
(
  18,
  'scenario',
  'scenario',
  'A brazing task is planned inside a mechanical room. Cardboard packaging and insulation scraps are directly behind the joint, and no one has addressed them. What is the BEST response?',
  '[{"key":"A","text":"Stop and control the combustible exposure before starting the torch work"},{"key":"B","text":"Begin brazing and watch the materials closely"},{"key":"C","text":"Increase nitrogen flow"},{"key":"D","text":"Use more filler material"}]'::jsonb,
  '["A"]'::jsonb,
  'Combustible materials near torch work should be removed or otherwise controlled before brazing begins.'
),
(
  19,
  'scenario',
  'scenario',
  'An installer finds a newly brazed joint leaking during the pressure test. What is the BEST response?',
  '[{"key":"A","text":"Safely depressurize as required, correct the defective joint using the approved procedure, and repeat leak verification"},{"key":"B","text":"Apply sealant to the outside of the pressurized joint"},{"key":"C","text":"Ignore a small leak and continue to evacuation"},{"key":"D","text":"Increase the test pressure until the leak seals"}]'::jsonb,
  '["A"]'::jsonb,
  'A leaking joint should be properly repaired under safe conditions and then rechecked before the system proceeds to later commissioning steps.'
),
(
  20,
  'scenario',
  'scenario',
  'A helper sees another worker preparing to braze a refrigerant connection while the piping is still under pressure from a previous test. What is the BEST action?',
  '[{"key":"A","text":"Stop the brazing setup and verify the piping is in the proper safe condition for hot work before heating it"},{"key":"B","text":"Proceed because pressure improves the joint"},{"key":"C","text":"Open the torch valve fully before checking"},{"key":"D","text":"Heat only one side of the fitting"}]'::jsonb,
  '["A"]'::jsonb,
  'Brazing should not begin until the piping and work area have been placed in the proper safe condition for the approved joining procedure.'
);

create temporary table _seed_hvac_brazing_joining_leak_prevention_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_brazing_joining_leak_prevention_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Brazing, Joining & Leak Prevention?',
  '[{"key":"A","text":"Making joints primarily by visual appearance"},{"key":"B","text":"Independently preparing, joining, protecting, testing, and evaluating refrigerant-piping connections while recognizing conditions that can compromise joint integrity"},{"key":"C","text":"Skipping nitrogen when access is difficult"},{"key":"D","text":"Treating every leak as a defective fitting"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent control of joint preparation, heat application, component protection, piping support, and leak verification.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is nitrogen purging especially important during refrigerant-circuit brazing?',
  '[{"key":"A","text":"It reduces internal oxidation and contamination that can circulate through the system"},{"key":"B","text":"It raises the melting temperature of copper"},{"key":"C","text":"It replaces pressure testing"},{"key":"D","text":"It cools the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'Limiting internal oxidation helps keep scale and contaminants out of valves, metering devices, compressors, and other refrigerant-circuit components.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to evaluate piping alignment before reheating a leaking brazed joint?',
  '[{"key":"A","text":"Mechanical stress or poor fit may have contributed to the failure and should be corrected rather than simply reheated"},{"key":"B","text":"Alignment determines refrigerant type"},{"key":"C","text":"Misalignment always means the fitting is oversized"},{"key":"D","text":"Reheating automatically corrects alignment"}]'::jsonb,
  '["A"]'::jsonb,
  'A leaking connection may reflect fit-up, alignment, support, contamination, or brazing problems that should be corrected at the root cause.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should a technician distinguish between leak detection and leak repair?',
  '[{"key":"A","text":"Finding the leak identifies the problem location, while repair requires correcting the underlying defective connection or component and then verifying integrity"},{"key":"B","text":"Leak detection automatically seals the leak"},{"key":"C","text":"Repair is unnecessary after a leak is located"},{"key":"D","text":"Leak detection applies only to new installations"}]'::jsonb,
  '["A"]'::jsonb,
  'Locating a leak is only one part of the process; the defective condition must be properly corrected and verified.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician finds a refrigerant leak at a brazed elbow. The tubing is visibly pulling sideways on the fitting. What is the BEST repair approach?',
  '[{"key":"A","text":"Correct the piping alignment and support, remake the joint as required, and verify it is leak tight"},{"key":"B","text":"Heat the joint until filler material flows over the outside"},{"key":"C","text":"Apply sealant around the fitting"},{"key":"D","text":"Increase system pressure after repair without checking alignment"}]'::jsonb,
  '["A"]'::jsonb,
  'Mechanical stress should be corrected along with the defective joint so the repaired connection is not left under the same damaging load.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician must braze near a service valve containing heat-sensitive seals. What is the BEST approach?',
  '[{"key":"A","text":"Follow the approved procedure for heat control and component protection while limiting unnecessary heat exposure"},{"key":"B","text":"Direct the torch at the valve body first"},{"key":"C","text":"Use maximum flame size to shorten the job"},{"key":"D","text":"Assume the valve will tolerate any brazing temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat-sensitive valves and components require controlled heating and the appropriate protection method during nearby brazing.'
),
(
  7,
  'multiple_choice',
  'application',
  'A repaired joint passes an initial leak check, but system pressure later falls during the standing test. What should the technician do?',
  '[{"key":"A","text":"Investigate the pressure loss and verify the full test setup and piping system before declaring the repair complete"},{"key":"B","text":"Assume the original joint is repaired and ignore the pressure change"},{"key":"C","text":"Immediately begin evacuation"},{"key":"D","text":"Add refrigerant to restore pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'A pressure decrease should be investigated rather than dismissed, including possible leaks and test-equipment or temperature effects.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician opens a failed system and finds heavy black oxidation scale inside recently brazed tubing. What is the BEST conclusion?',
  '[{"key":"A","text":"The brazing process may not have adequately controlled internal oxidation, and the resulting contamination should be considered during repair"},{"key":"B","text":"The scale proves the refrigerant was overcharged"},{"key":"C","text":"The scale is normal and beneficial"},{"key":"D","text":"The compressor created the scale mechanically"}]'::jsonb,
  '["A"]'::jsonb,
  'Heavy internal oxidation is consistent with poor oxidation control during brazing and may create contamination problems elsewhere in the circuit.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician suspects a leak at a connection covered by insulation. What is the BEST approach?',
  '[{"key":"A","text":"Expose the connection as needed and use an appropriate leak-detection method to identify the actual source before repairing"},{"key":"B","text":"Replace the entire line set without inspection"},{"key":"C","text":"Add sealant over the insulation"},{"key":"D","text":"Assume the nearest fitting is leaking"}]'::jsonb,
  '["A"]'::jsonb,
  'The actual leak source should be identified before the repair is selected.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician is preparing to braze a replacement component into a refrigerant circuit. What should be confirmed before heating begins?',
  '[{"key":"A","text":"The circuit is in the proper safe condition, joint fit is correct, nitrogen purge and heat protection are ready, and surrounding hazards are controlled"},{"key":"B","text":"Only that the torch has fuel"},{"key":"C","text":"Only that the thermostat is off"},{"key":"D","text":"Only that the replacement part fits visually"}]'::jsonb,
  '["A"]'::jsonb,
  'Successful brazing requires preparation of the circuit, joint, purge, heat-sensitive components, and work area before torch work begins.'
),
(
  11,
  'multiple_choice',
  'application',
  'A newly repaired system repeatedly loses charge, but electronic leak detection finds nothing at the repaired joint. What is the BEST next step?',
  '[{"key":"A","text":"Expand the leak investigation systematically rather than assuming the repaired joint is the only possible source"},{"key":"B","text":"Add refrigerant and return later"},{"key":"C","text":"Rebraze the repaired joint automatically"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring refrigerant loss calls for a systematic leak investigation across the relevant circuit rather than fixation on one prior repair.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician repairs a leaking suction-line joint. During the pressure test, bubbles appear at the joint again. The piping is properly supported, but the joint surfaces were not fully cleaned before rebrazing. What is the BEST response?',
  '[{"key":"A","text":"Safely prepare the system for repair, remake the joint with proper surface preparation and brazing practice, then repeat leak verification"},{"key":"B","text":"Apply more filler to the outside while the system is pressurized"},{"key":"C","text":"Cover the joint with insulation"},{"key":"D","text":"Proceed to evacuation because the leak is small"}]'::jsonb,
  '["A"]'::jsonb,
  'A confirmed leaking joint should be properly remade after correcting the likely preparation defect and then tested again.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician replaces a compressor and brazes the connections without nitrogen flow. After startup, a restriction develops at a small refrigerant-control passage. What should the technician consider?',
  '[{"key":"A","text":"Internal oxidation from the brazing process may have introduced contamination that contributed to the restriction"},{"key":"B","text":"Nitrogen flow would have increased the restriction"},{"key":"C","text":"The thermostat caused the contamination"},{"key":"D","text":"Brazing cannot affect refrigerant-circuit cleanliness"}]'::jsonb,
  '["A"]'::jsonb,
  'Oxidation debris created during brazing can migrate through the refrigerant circuit and affect small passages and components.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician must repair a joint inside a finished wall cavity. Combustible framing and insulation are close to the connection. What is the BEST response?',
  '[{"key":"A","text":"Establish the required hot-work controls and protect or remove combustible exposures before brazing"},{"key":"B","text":"Use a hotter flame so the joint is completed faster"},{"key":"C","text":"Rely only on nitrogen purge"},{"key":"D","text":"Braze without inspection because the cavity is enclosed"}]'::jsonb,
  '["A"]'::jsonb,
  'Confined or finished spaces can increase hot-work risk and require deliberate control of nearby combustible materials.'
),
(
  15,
  'scenario',
  'scenario',
  'A system passes a brief leak check immediately after repair but loses pressure during a longer standing test. Ambient temperature also changed significantly during the test. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Evaluate both actual leakage and the effect of temperature on test pressure before concluding whether the system is tight"},{"key":"B","text":"Assume any pressure change proves a leak"},{"key":"C","text":"Assume temperature explains every pressure change"},{"key":"D","text":"Skip further testing and begin charging"}]'::jsonb,
  '["A"]'::jsonb,
  'Pressure-test interpretation should consider both system leakage and temperature-related pressure changes.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician finds repeated leaks at several joints along the same poorly supported line set. What is the BEST response?',
  '[{"key":"A","text":"Correct the piping support and mechanical stress problem as part of the joint repairs"},{"key":"B","text":"Repair each joint individually without changing support"},{"key":"C","text":"Increase filler material thickness on every joint"},{"key":"D","text":"Reduce refrigerant charge permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated joint failures along poorly supported piping suggest a mechanical root cause that should be corrected with the leak repairs.'
),
(
  17,
  'scenario',
  'scenario',
  'A refrigerant circuit loses charge slowly. Oil staining is present near a flare connection rather than a brazed joint. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the flare connection and correct the actual leak source using the appropriate joining procedure rather than rebrazing nearby tubing"},{"key":"B","text":"Braze over the flare nut"},{"key":"C","text":"Replace the nearest brazed elbow"},{"key":"D","text":"Add refrigerant and ignore the oil stain"}]'::jsonb,
  '["A"]'::jsonb,
  'Leak repair should match the actual connection type and failure location rather than defaulting to brazing.'
),
(
  18,
  'scenario',
  'scenario',
  'A repaired system holds pressure, but the technician notices one brazed fitting was overheated badly enough to discolor and distort nearby insulation and a valve body. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the affected components and joint for heat damage before accepting the repair"},{"key":"B","text":"Accept the repair because the pressure test passed"},{"key":"C","text":"Cover the discoloration with new insulation"},{"key":"D","text":"Increase test pressure to prove the valve is good"}]'::jsonb,
  '["A"]'::jsonb,
  'Passing a pressure test does not rule out heat damage to adjacent components that may affect future reliability.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician is troubleshooting a system with recurring refrigerant loss. Previous service records repeatedly say “added refrigerant” but contain no leak location or repair documentation. What is the BEST response?',
  '[{"key":"A","text":"Perform a systematic leak investigation, repair confirmed defects, verify integrity, and document the findings and repair"},{"key":"B","text":"Add the same amount of refrigerant again"},{"key":"C","text":"Replace the compressor automatically"},{"key":"D","text":"Assume normal operation causes refrigerant loss"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring charge loss should be addressed through leak detection, proper repair, verification, and useful service documentation.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes several brazed repairs and prepares to close the job. The system passed a leak test, but no one recorded which joints were repaired or how the test was performed. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Document the repaired locations and relevant leak-verification information before closing out the work"},{"key":"B","text":"Close the job because documentation does not affect future service"},{"key":"C","text":"Record only the amount of refrigerant charged"},{"key":"D","text":"Remove identifying marks from the repaired joints"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear repair and test documentation supports future troubleshooting, quality review, and traceability.'
);

create temporary table _seed_hvac_brazing_joining_leak_prevention_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_brazing_joining_leak_prevention_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Brazing, Joining & Leak Prevention?',
  '[{"key":"A","text":"Judging joint quality mainly by appearance"},{"key":"B","text":"Leading consistent joining, hot-work, contamination-control, leak-verification, and corrective-action practices across technicians and jobs"},{"key":"C","text":"Allowing experienced technicians to use personal methods without review"},{"key":"D","text":"Treating leak repair as separate from piping support and installation quality"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership over joining quality, safety, contamination control, leak prevention, and recurring defect correction.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should recurring brazed-joint failures be reviewed as a system or process issue?',
  '[{"key":"A","text":"Repeated failures may indicate common problems with preparation, fit-up, heat control, nitrogen use, support, or verification practices"},{"key":"B","text":"Repeated failures always mean the tubing brand is defective"},{"key":"C","text":"Each leak should be treated as unrelated"},{"key":"D","text":"Recurring leaks are normal after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'A pattern of joint failures can reveal common workmanship or process weaknesses that should be corrected broadly.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of a standardized leak-verification procedure?',
  '[{"key":"A","text":"To make test methods, acceptance criteria, documentation, and follow-up consistent across work"},{"key":"B","text":"To eliminate technician judgment entirely"},{"key":"C","text":"To replace joint preparation"},{"key":"D","text":"To shorten every pressure test to the same duration regardless of procedure"}]'::jsonb,
  '["A"]'::jsonb,
  'Standardized verification improves consistency, traceability, and confidence that repaired or newly joined systems are leak tight.'
),
(
  4,
  'multiple_choice',
  'application',
  'A branch has repeated compressor and metering-device contamination after major piping repairs. What should a senior technical lead investigate?',
  '[{"key":"A","text":"Brazing cleanliness, nitrogen-purge practices, debris control, repair procedures, and refrigerant-circuit contamination handling"},{"key":"B","text":"Thermostat programming only"},{"key":"C","text":"Building paint products"},{"key":"D","text":"Equipment labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated contamination after piping work should trigger review of joining and cleanliness practices across the refrigerant circuit.'
),
(
  5,
  'multiple_choice',
  'application',
  'A senior technician observes crews using widely different nitrogen flow practices during brazing. What is the BEST response?',
  '[{"key":"A","text":"Establish and reinforce the approved purge method so oxidation control is consistent"},{"key":"B","text":"Allow every technician to decide by flame color"},{"key":"C","text":"Eliminate nitrogen purging"},{"key":"D","text":"Use oxygen instead"}]'::jsonb,
  '["A"]'::jsonb,
  'A controlled approved purge method helps make internal oxidation prevention consistent across technicians.'
),
(
  6,
  'multiple_choice',
  'application',
  'A quality review finds that technicians pass leak tests but do not document test medium, pressure, duration, or relevant conditions. What is the BEST response?',
  '[{"key":"A","text":"Improve the leak-test documentation standard so results are traceable and reviewable"},{"key":"B","text":"Stop documenting leak tests"},{"key":"C","text":"Record only whether the test passed"},{"key":"D","text":"Replace pressure testing with visual inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful test records should provide enough context to understand how integrity was verified.'
),
(
  7,
  'multiple_choice',
  'application',
  'A senior technician finds multiple leaks at joints on the same unsupported vertical riser. What is the BEST corrective approach?',
  '[{"key":"A","text":"Correct the support and mechanical loading problem as part of the joint repairs"},{"key":"B","text":"Repair each joint without changing the piping support"},{"key":"C","text":"Use more filler material on every joint"},{"key":"D","text":"Lower system pressure permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures along inadequately supported piping indicate a mechanical root cause that should be addressed with the repairs.'
),
(
  8,
  'multiple_choice',
  'application',
  'A branch routinely performs torch work near combustible materials without a consistent hot-work setup. What should the senior lead do?',
  '[{"key":"A","text":"Enforce the approved hot-work controls, planning, and supervision requirements before further brazing work"},{"key":"B","text":"Rely on technician experience"},{"key":"C","text":"Use smaller torch tips only"},{"key":"D","text":"Perform brazing faster"}]'::jsonb,
  '["A"]'::jsonb,
  'Hot-work hazards require consistent controls and should not depend solely on individual experience.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician is reviewing a repair procedure for heat-sensitive valves. What should the procedure address?',
  '[{"key":"A","text":"Heat control, component protection, joint preparation, purge method, and verification after repair"},{"key":"B","text":"Only torch fuel type"},{"key":"C","text":"Only final refrigerant charge"},{"key":"D","text":"Only valve orientation"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable repair procedure should control the full joining process and protect vulnerable components from heat damage.'
),
(
  10,
  'multiple_choice',
  'application',
  'A company sees recurring callbacks for very small refrigerant leaks after installation. What is the BEST quality-control response?',
  '[{"key":"A","text":"Review joint-preparation, brazing, support, pressure-testing, and leak-detection practices to identify common failure causes"},{"key":"B","text":"Increase refrigerant charge at startup"},{"key":"C","text":"Shorten leak tests"},{"key":"D","text":"Stop documenting callbacks"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring leak callbacks should trigger a process-level review rather than only individual repair actions.'
),
(
  11,
  'scenario',
  'scenario',
  'A senior technician audits several installations and finds heavy internal oxidation in tubing from multiple crews. All crews say they use nitrogen, but no standard purge setup exists. What is the BEST response?',
  '[{"key":"A","text":"Define and verify the approved purge method, train crews, and audit its use during brazing"},{"key":"B","text":"Assume the oxidation is harmless"},{"key":"C","text":"Increase system flushing after every job instead"},{"key":"D","text":"Stop inspecting tubing interiors"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated contamination pattern requires standardizing and verifying the process intended to prevent it.'
),
(
  12,
  'scenario',
  'scenario',
  'A project has several leaking joints near vibration-prone equipment. Technicians repeatedly repair the joints, but the connected piping remains rigidly misaligned. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct the piping alignment, support, and vibration-related stress in addition to repairing the joints"},{"key":"B","text":"Continue rebrazing joints as they fail"},{"key":"C","text":"Use larger amounts of filler material"},{"key":"D","text":"Reduce refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring failures caused by mechanical stress will continue unless the underlying alignment and support conditions are corrected.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician passes a pressure test after a major repair, but the senior reviewer finds that the test pressure was not appropriate for the approved procedure. What is the BEST response?',
  '[{"key":"A","text":"Repeat or otherwise complete the required verification using the approved procedure before accepting the repair"},{"key":"B","text":"Accept the result because no leak was found"},{"key":"C","text":"Use visual inspection instead"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'A test performed outside the approved method may not provide adequate evidence of system integrity.'
),
(
  14,
  'scenario',
  'scenario',
  'A branch has a pattern of damaged service valves after brazing. Technicians are protecting the valves inconsistently. What is the BEST corrective action?',
  '[{"key":"A","text":"Standardize the heat-control and valve-protection method, train technicians, and verify field compliance"},{"key":"B","text":"Replace every valve after brazing"},{"key":"C","text":"Use larger flames"},{"key":"D","text":"Stop documenting valve failures"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated heat damage indicates the protection method should be standardized and supervised.'
),
(
  15,
  'scenario',
  'scenario',
  'A quality review finds repeated refrigerant-loss callbacks, but service records usually say only “recharged system.” What is the BEST Level 4 response?',
  '[{"key":"A","text":"Require systematic leak investigation, repair, verification, and useful documentation rather than repeated recharge-only service"},{"key":"B","text":"Standardize the amount of refrigerant added"},{"key":"C","text":"Replace compressors after the second callback"},{"key":"D","text":"Stop tracking refrigerant-loss history"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated refrigerant loss should be addressed through root-cause leak repair and traceable service practices.'
),
(
  16,
  'scenario',
  'scenario',
  'A crew discovers an active leak during a pressure test immediately before scheduled startup. The project manager wants the system charged and started to avoid delay. What is the BEST senior response?',
  '[{"key":"A","text":"Do not proceed to charging or startup until the leak is properly repaired and system integrity is reverified"},{"key":"B","text":"Charge the system and repair the leak later"},{"key":"C","text":"Lower the test pressure and accept the joint"},{"key":"D","text":"Cover the leak with insulation"}]'::jsonb,
  '["A"]'::jsonb,
  'A known leak should be corrected and verified before the system proceeds to charging and operation.'
),
(
  17,
  'scenario',
  'scenario',
  'A senior technician reviews a failed repair where a brazed fitting split after startup. The fitting was visibly distorted before installation but used anyway. What is the BEST process response?',
  '[{"key":"A","text":"Reinforce material inspection and rejection criteria so damaged fittings are not installed"},{"key":"B","text":"Use more filler material on distorted fittings"},{"key":"C","text":"Increase pressure-test duration only"},{"key":"D","text":"Assume the failure was random"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged joining components should be identified and rejected before installation rather than compensated for during brazing.'
),
(
  18,
  'scenario',
  'scenario',
  'A company has good brazing procedures, but field audits show technicians often skip them under schedule pressure. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Address supervision, accountability, scheduling expectations, and field verification so the required process is actually followed"},{"key":"B","text":"Write a longer procedure"},{"key":"C","text":"Stop auditing field work"},{"key":"D","text":"Allow exceptions whenever jobs are behind schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'A written process is ineffective if organizational practices allow it to be routinely bypassed.'
),
(
  19,
  'scenario',
  'scenario',
  'A repaired system passes a leak test but later fails because a heat-damaged valve seal begins leaking. What lesson should the senior technician apply?',
  '[{"key":"A","text":"Leak-test success does not replace evaluation of heat exposure and component condition during the repair"},{"key":"B","text":"Pressure tests should be eliminated"},{"key":"C","text":"Valve seals cannot be damaged by brazing"},{"key":"D","text":"Only tubing joints need inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful pressure test may not reveal all latent damage caused by excessive heat during joining.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit shows recurring brazing defects, inconsistent nitrogen use, incomplete leak-test records, and repeated callbacks. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement a controlled joining and leak-prevention program with standardized procedures, training, field audits, documentation, and corrective-action tracking"},{"key":"B","text":"Buy larger torches"},{"key":"C","text":"Stop recording callback causes"},{"key":"D","text":"Let each technician create a personal process"}]'::jsonb,
  '["A"]'::jsonb,
  'A broad recurring quality problem requires a standardized technical and quality-control system rather than isolated fixes.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '7abf84e9-9f89-4131-8bf2-06104014bf04';
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
      and c.name = 'Brazing, Joining & Leak Prevention'
      and c.is_current = true
  ) then
    raise exception 'Current Brazing, Joining & Leak Prevention Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 Brazing, Joining & Leak Prevention requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 Brazing, Joining & Leak Prevention requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Brazing, Joining & Leak Prevention requirement not found';
  end if;

v_level := 1;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'Brazing, Joining & Leak Prevention — Level 1 Competency Assessment';

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
    select * from _seed_hvac_brazing_joining_leak_prevention_l1_questions
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
        'Brazing, Joining & Leak Prevention',
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
      'IntegrateU Brazing, Joining & Leak Prevention L1 production assessment v1.0.',
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
        'Brazing, Joining & Leak Prevention',
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
        'IntegrateU Brazing, Joining & Leak Prevention L1 production assessment v1.0.',
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
  v_assessment_name := 'Brazing, Joining & Leak Prevention — Level 3 Competency Assessment';

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
    select * from _seed_hvac_brazing_joining_leak_prevention_l3_questions
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
        'Brazing, Joining & Leak Prevention',
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
      'IntegrateU Brazing, Joining & Leak Prevention L3 production assessment v1.0.',
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
      (v_master_question_id, v_service_role_id)
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
        'Brazing, Joining & Leak Prevention',
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
        'IntegrateU Brazing, Joining & Leak Prevention L3 production assessment v1.0.',
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
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Brazing, Joining & Leak Prevention — Level 4 Competency Assessment';

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
    select * from _seed_hvac_brazing_joining_leak_prevention_l4_questions
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
        'Brazing, Joining & Leak Prevention',
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
      'IntegrateU Brazing, Joining & Leak Prevention L4 production assessment v1.0.',
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
        'Brazing, Joining & Leak Prevention',
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
        'IntegrateU Brazing, Joining & Leak Prevention L4 production assessment v1.0.',
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
   '7abf84e9-9f89-4131-8bf2-06104014bf04'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '7abf84e9-9f89-4131-8bf2-06104014bf04'::uuid
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
      '7abf84e9-9f89-4131-8bf2-06104014bf04'::uuid
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
    and mrt.id =
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
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
  '7abf84e9-9f89-4131-8bf2-06104014bf04'::uuid;

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
    '7abf84e9-9f89-4131-8bf2-06104014bf04'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
