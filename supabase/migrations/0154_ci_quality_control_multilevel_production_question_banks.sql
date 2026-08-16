-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0152_ci_quality_control_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Quality Control
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level     -> Level 1
--   Operations Manager  -> Level 2
--   Systems Designer    -> Level 3
--   Technician III — Lead Technician -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess cabling and termination competency across
-- progressively higher levels of recognition, application, troubleshooting,
-- system judgment, and cross-system technical understanding.
-- ============================================================================

begin;

create temporary table _seed_ci_quality_control_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_quality_control_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of quality control during installation?',
  '[{"key":"A","text":"To verify that work meets project, company, workmanship, and completion expectations"},{"key":"B","text":"To make installation take longer"},{"key":"C","text":"To replace technician training"},{"key":"D","text":"To inspect only visible equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control confirms that work is complete, correct, and consistent with applicable standards.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes professional workmanship?',
  '[{"key":"A","text":"Work is functional, properly installed, organized, secure, clean, and consistent with project requirements"},{"key":"B","text":"Work functions even if it is loose or poorly organized"},{"key":"C","text":"Appearance is the only measure of quality"},{"key":"D","text":"Workmanship matters only when the client can see it"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional workmanship includes function, organization, protection, serviceability, and proper execution.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should hidden work be inspected before walls or ceilings are closed?',
  '[{"key":"A","text":"Defects are easier to identify and correct before access becomes limited"},{"key":"B","text":"Hidden work does not need to meet standards after it is covered"},{"key":"C","text":"Inspection is only required after finish"},{"key":"D","text":"The inspection replaces documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Early inspection reduces the risk of concealed defects and expensive rework.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a defect?',
  '[{"key":"A","text":"Work or a condition that does not meet the required standard, specification, function, or completion expectation"},{"key":"B","text":"Any task that takes longer than expected"},{"key":"C","text":"Any change requested by a client"},{"key":"D","text":"Only equipment that will not power on"}]'::jsonb,
  '["A"]'::jsonb,
  'A defect is any nonconforming condition that fails a required expectation.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why are cable and device labels part of quality control?',
  '[{"key":"A","text":"They support identification, testing, troubleshooting, documentation, and future service"},{"key":"B","text":"They are only decorative"},{"key":"C","text":"They matter only during sales"},{"key":"D","text":"They replace testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent identification improves reliability and serviceability throughout the system lifecycle.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What does it mean to verify work?',
  '[{"key":"A","text":"Check the completed work against the applicable requirements instead of assuming it is correct"},{"key":"B","text":"Ask the installer whether it is correct"},{"key":"C","text":"Confirm only that the task was started"},{"key":"D","text":"Wait for the client to find problems"}]'::jsonb,
  '["A"]'::jsonb,
  'Verification requires evidence that the work actually meets the expected result.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is cleanliness part of installation quality?',
  '[{"key":"A","text":"A clean work area protects finished surfaces, supports safety, and reflects professional execution"},{"key":"B","text":"Cleanliness matters only after the project is complete"},{"key":"C","text":"Cleaning is never part of technician responsibility"},{"key":"D","text":"Cleanliness has no relationship to workmanship"}]'::jsonb,
  '["A"]'::jsonb,
  'Cleanliness and protection of the work environment are part of professional job execution.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should happen when a quality issue is discovered?',
  '[{"key":"A","text":"It should be identified, communicated when required, and corrected or resolved according to the project process"},{"key":"B","text":"It should be hidden if the system still works"},{"key":"C","text":"It should always be left for service"},{"key":"D","text":"It should be ignored unless the client notices"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality issues should be addressed before work is accepted as complete.'
),
(
  9,
  'multiple_choice',
  'application',
  'A cable is functional but is loose, unsupported, and poorly routed above the ceiling. Does it meet a professional quality standard?',
  '[{"key":"A","text":"No; function alone does not replace proper routing, support, organization, and workmanship"},{"key":"B","text":"Yes; if signal passes, nothing else matters"},{"key":"C","text":"Yes; because the cable is hidden"},{"key":"D","text":"Only if the client cannot see it"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality includes proper physical installation and serviceability, not just electrical function.'
),
(
  10,
  'multiple_choice',
  'application',
  'A wall plate is working but is crooked, loose, and visibly damaged. What should the technician do?',
  '[{"key":"A","text":"Correct the installation so it is secure, aligned, undamaged, and meets finish expectations"},{"key":"B","text":"Leave it because it functions"},{"key":"C","text":"Cover the damage with a label"},{"key":"D","text":"Wait until the next service call"}]'::jsonb,
  '["A"]'::jsonb,
  'Finished-work quality includes function, fit, alignment, condition, and professional appearance.'
),
(
  11,
  'multiple_choice',
  'application',
  'Before declaring a rough-in area complete, what should the technician verify?',
  '[{"key":"A","text":"Required runs are present, identified, routed, supported, protected, and documented as required"},{"key":"B","text":"Only that cable has been pulled into the area"},{"key":"C","text":"Only that drywall is scheduled"},{"key":"D","text":"Only that the technician worked the planned hours"}]'::jsonb,
  '["A"]'::jsonb,
  'Rough-in quality includes completeness, identification, routing, protection, and required records.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician finishes installing a device. What should happen before the task is considered complete?',
  '[{"key":"A","text":"Inspect the installation and perform required functional or quality checks"},{"key":"B","text":"Assume it is correct because the device is mounted"},{"key":"C","text":"Mark the entire project complete"},{"key":"D","text":"Remove the device label"}]'::jsonb,
  '["A"]'::jsonb,
  'Completion should include verification, not just physical installation.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician sees debris accumulating around finished flooring during trim-out. What is the BEST action?',
  '[{"key":"A","text":"Protect the area and clean debris as work progresses"},{"key":"B","text":"Leave it until the project ends"},{"key":"C","text":"Push it into another room"},{"key":"D","text":"Assume another trade will clean it"}]'::jsonb,
  '["A"]'::jsonb,
  'Ongoing cleanliness helps prevent damage and maintains professional job-site standards.'
),
(
  14,
  'multiple_choice',
  'application',
  'A cable label is missing at one end of a run. What should the technician do?',
  '[{"key":"A","text":"Verify the cable identity and restore the required label before considering the work complete"},{"key":"B","text":"Guess the cable identity later"},{"key":"C","text":"Remove the label from the other end"},{"key":"D","text":"Leave it unlabeled because testing can identify it later"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing identification is a quality deficiency that should be corrected before turnover.'
),
(
  15,
  'multiple_choice',
  'application',
  'A technician finds a connector that is attached but visibly poorly terminated. What is the BEST action?',
  '[{"key":"A","text":"Correct or reterminate it according to the required method before acceptance"},{"key":"B","text":"Leave it if the signal currently passes"},{"key":"C","text":"Hide it inside the rack"},{"key":"D","text":"Mark it complete and monitor it later"}]'::jsonb,
  '["A"]'::jsonb,
  'A visibly deficient termination should not be accepted simply because it works momentarily.'
),
(
  16,
  'multiple_choice',
  'application',
  'A required installation photo does not clearly show the completed work. What should the technician do?',
  '[{"key":"A","text":"Capture usable documentation that clearly verifies the required condition while access is available"},{"key":"B","text":"Submit the unclear photo anyway"},{"key":"C","text":"Use a photo from another area"},{"key":"D","text":"Mark the requirement complete without evidence"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality documentation should provide meaningful evidence of the completed condition.'
),
(
  17,
  'scenario',
  'scenario',
  'During a rough-in quality check, one required cable is found at the wrong location and drywall is scheduled for the next morning. What is the BEST action?',
  '[{"key":"A","text":"Communicate the defect and correct the run according to project direction before the area is closed when possible"},{"key":"B","text":"Leave it and hope it can be fixed later"},{"key":"C","text":"Mark the area complete"},{"key":"D","text":"Hide the cable"}]'::jsonb,
  '["A"]'::jsonb,
  'Defects should be corrected before access is lost whenever possible to reduce rework.'
),
(
  18,
  'scenario',
  'scenario',
  'A completed rack powers on and passes a quick test, but cabling is tangled, unlabeled, and difficult to trace. How should the rack be evaluated?',
  '[{"key":"A","text":"It does not fully meet quality expectations because serviceability, identification, organization, and workmanship are deficient"},{"key":"B","text":"It passes because power is on"},{"key":"C","text":"It passes because the client cannot see the cables"},{"key":"D","text":"It only needs to be corrected if a failure occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control evaluates both functional performance and professional installation standards.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician discovers several devices were installed correctly but the required labels and completion records are missing. What is the BEST response?',
  '[{"key":"A","text":"Complete the required identification and documentation before the work is accepted as finished"},{"key":"B","text":"Accept the work because the devices function"},{"key":"C","text":"Delete the documentation requirement"},{"key":"D","text":"Leave the missing records for service"}]'::jsonb,
  '["A"]'::jsonb,
  'Completion expectations may include both physical work and required documentation.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is asked to sign off a room as complete but notices one loose wall plate, an unlabeled cable, and an untested device. What should the technician do?',
  '[{"key":"A","text":"Do not sign off until the deficiencies are corrected or properly resolved and required verification is completed"},{"key":"B","text":"Sign off because most work is complete"},{"key":"C","text":"Mark the issues as cosmetic"},{"key":"D","text":"Ask the client to inspect it instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality sign-off should reflect actual completion, not approximate completion.'
);

create temporary table _seed_ci_quality_control_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_quality_control_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of a quality checklist?',
  '[{"key":"A","text":"To provide a consistent set of items that must be inspected or verified before work is accepted"},{"key":"B","text":"To replace technician judgment completely"},{"key":"C","text":"To track only labor hours"},{"key":"D","text":"To document only visible defects"}]'::jsonb,
  '["A"]'::jsonb,
  'A checklist supports consistent verification of defined quality requirements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the difference between inspection and testing?',
  '[{"key":"A","text":"Inspection evaluates condition or workmanship, while testing verifies required functional or performance results"},{"key":"B","text":"They are always exactly the same"},{"key":"C","text":"Inspection is only for drawings"},{"key":"D","text":"Testing is only for appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control may require both visual or physical inspection and functional verification.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should defects be documented when discovered?',
  '[{"key":"A","text":"To create visibility, support correction, track status, and preserve accountability"},{"key":"B","text":"To delay project completion"},{"key":"C","text":"To assign blame"},{"key":"D","text":"To avoid fixing them"}]'::jsonb,
  '["A"]'::jsonb,
  'Documented defects are easier to assign, correct, verify, and prevent from being lost.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is rework?',
  '[{"key":"A","text":"Work that must be corrected or repeated because the original result did not meet the required expectation"},{"key":"B","text":"Any work performed twice by design"},{"key":"C","text":"Preventive maintenance"},{"key":"D","text":"Client training"}]'::jsonb,
  '["A"]'::jsonb,
  'Rework consumes time and resources to correct nonconforming work.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is consistency important when performing quality checks?',
  '[{"key":"A","text":"It reduces variation in what gets inspected and what is considered acceptable"},{"key":"B","text":"It guarantees no defects will ever occur"},{"key":"C","text":"It eliminates the need for standards"},{"key":"D","text":"It lets each technician define quality independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent criteria improve fairness, repeatability, and reliability in quality control.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician completes a rack installation. Which quality check is MOST appropriate before sign-off?',
  '[{"key":"A","text":"Verify equipment placement, secure mounting, cable organization and labels, required connections, cleanliness, and required functional checks"},{"key":"B","text":"Confirm only that equipment powers on"},{"key":"C","text":"Confirm only that all boxes were opened"},{"key":"D","text":"Confirm only that the rack looks full"}]'::jsonb,
  '["A"]'::jsonb,
  'Rack quality includes physical installation, identification, organization, and required function.'
),
(
  7,
  'multiple_choice',
  'application',
  'A cable passes a basic continuity check but its termination does not meet the required workmanship standard. What should happen?',
  '[{"key":"A","text":"Correct the termination before accepting the work"},{"key":"B","text":"Accept it because continuity passed"},{"key":"C","text":"Hide the termination"},{"key":"D","text":"Remove the label"}]'::jsonb,
  '["A"]'::jsonb,
  'Passing one test does not excuse a known workmanship defect.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician identifies three punch-list defects in one room. What is the BEST way to manage them?',
  '[{"key":"A","text":"Record each defect clearly, assign or communicate ownership as required, correct them, and verify closure"},{"key":"B","text":"Keep the list in personal memory"},{"key":"C","text":"Mark the room complete and fix them later"},{"key":"D","text":"Combine them into one vague note"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear defect tracking supports accountability and verified closure.'
),
(
  9,
  'multiple_choice',
  'application',
  'A finished device works but is mounted at a visibly inconsistent height compared with the approved installation requirement. What should the technician do?',
  '[{"key":"A","text":"Verify the requirement and correct the installation if it does not conform"},{"key":"B","text":"Leave it because it functions"},{"key":"C","text":"Move nearby devices to match it"},{"key":"D","text":"Ignore it unless the client complains"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality includes conformance to approved installation requirements, not just operation.'
),
(
  10,
  'multiple_choice',
  'application',
  'A warehouse associate is staging equipment and notices a box is damaged. What is the BEST quality-control action?',
  '[{"key":"A","text":"Inspect and verify the condition of the equipment before staging it as project-ready, and report or isolate any defect"},{"key":"B","text":"Send it to the field unopened"},{"key":"C","text":"Hide the damaged side of the box"},{"key":"D","text":"Assume packaging damage never affects equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control begins before installation by identifying damaged or incorrect materials.'
),
(
  11,
  'multiple_choice',
  'application',
  'A sales specialist reviews a proposal before it is sent to a client. Which action reflects quality control?',
  '[{"key":"A","text":"Check that scope, quantities, assumptions, exclusions, and key project details are internally consistent and complete"},{"key":"B","text":"Review only the font size"},{"key":"C","text":"Skip review if the deadline is close"},{"key":"D","text":"Assume missing details can be fixed after signing"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control applies to project information as well as physical installation.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician fixes a punch-list item. What should happen before it is marked closed?',
  '[{"key":"A","text":"Verify that the correction now meets the required standard"},{"key":"B","text":"Close it immediately after work begins"},{"key":"C","text":"Delete the original defect"},{"key":"D","text":"Wait for the client to test it"}]'::jsonb,
  '["A"]'::jsonb,
  'A corrected defect should be rechecked before closure.'
),
(
  13,
  'multiple_choice',
  'application',
  'A project area has passed functional testing but required labels are still missing. How should the area be classified?',
  '[{"key":"A","text":"Not fully complete until the required labeling deficiency is corrected"},{"key":"B","text":"Complete because function passed"},{"key":"C","text":"Complete if labels can be added after turnover"},{"key":"D","text":"Complete if the technician remembers the identities"}]'::jsonb,
  '["A"]'::jsonb,
  'Completion includes all defined quality requirements, not only functional testing.'
),
(
  14,
  'multiple_choice',
  'application',
  'A recurring defect is found across several similar installations. What should an experienced technician do?',
  '[{"key":"A","text":"Correct affected work and raise the pattern so the underlying cause can be addressed"},{"key":"B","text":"Fix only the first defect"},{"key":"C","text":"Ignore the pattern"},{"key":"D","text":"Lower the quality standard"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated defects may indicate a systemic issue that should be corrected beyond one location.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is told a room must be ready for client walkthrough, but two devices are untested and one wall plate is damaged. What is the BEST response?',
  '[{"key":"A","text":"Identify the remaining deficiencies, complete or resolve them, and verify the room before calling it ready"},{"key":"B","text":"Call the room ready because most work is finished"},{"key":"C","text":"Hide the damaged plate"},{"key":"D","text":"Ask the client to identify the issues"}]'::jsonb,
  '["A"]'::jsonb,
  'Readiness should be based on verified completion criteria rather than schedule pressure.'
),
(
  16,
  'scenario',
  'scenario',
  'A warehouse order is staged for a project, but the technician notices one required model number does not match the approved equipment list. What is the BEST action?',
  '[{"key":"A","text":"Stop the affected staging step, verify the discrepancy, and correct the material before release to the field"},{"key":"B","text":"Send it because the model looks similar"},{"key":"C","text":"Change the equipment list without approval"},{"key":"D","text":"Let the field team decide"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect equipment should be caught before it creates downstream installation problems.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician repeatedly finds loose connectors installed by the same crew. What is the BEST next step?',
  '[{"key":"A","text":"Correct the defects, inspect other affected work, and communicate the recurring workmanship issue for coaching or process correction"},{"key":"B","text":"Tighten only the connector currently visible"},{"key":"C","text":"Ignore the pattern"},{"key":"D","text":"Wait for service calls"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated defect pattern should trigger broader verification and corrective action.'
),
(
  18,
  'scenario',
  'scenario',
  'A project manager asks whether a phase is complete. Most devices are installed, but documentation, testing, and three punch items remain open. What is the BEST answer?',
  '[{"key":"A","text":"The phase is not complete because required verification, documentation, and defect closure remain outstanding"},{"key":"B","text":"The phase is complete because installation is mostly finished"},{"key":"C","text":"The phase is complete if the schedule says so"},{"key":"D","text":"The phase is complete if materials are gone"}]'::jsonb,
  '["A"]'::jsonb,
  'Completion should reflect all defined requirements, not just physical installation progress.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician performs a final quality review and finds several defects that appear minor individually but all affect finish quality. What should happen?',
  '[{"key":"A","text":"Track and correct the defects because cumulative finish issues can still prevent professional completion"},{"key":"B","text":"Ignore them because none causes system failure"},{"key":"C","text":"Correct only the most visible one"},{"key":"D","text":"Wait for the client to complain"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality standards include finish and workmanship, even when defects do not cause immediate functional failure.'
),
(
  20,
  'scenario',
  'scenario',
  'A completed area passes inspection, but the required closeout photos and test records are missing. What is the BEST action?',
  '[{"key":"A","text":"Complete the required records and verify the evidence before final acceptance"},{"key":"B","text":"Accept the area because physical work passed"},{"key":"C","text":"Create placeholder records"},{"key":"D","text":"Leave documentation for service"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality completion can include required evidence and documentation as part of acceptance.'
);

create temporary table _seed_ci_quality_control_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_quality_control_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of analyzing recurring quality defects?',
  '[{"key":"A","text":"To identify patterns and underlying causes so the same defects can be prevented"},{"key":"B","text":"To decide which technician should be blamed"},{"key":"C","text":"To reduce the number of inspections"},{"key":"D","text":"To accept defects that occur frequently"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring defects often signal a process, training, material, documentation, or execution problem that should be addressed at the source.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of a quality acceptance criterion?',
  '[{"key":"A","text":"To define the condition or evidence required before work is considered acceptable or complete"},{"key":"B","text":"To estimate project profit"},{"key":"C","text":"To replace project scope"},{"key":"D","text":"To identify only cosmetic preferences"}]'::jsonb,
  '["A"]'::jsonb,
  'Acceptance criteria make quality expectations measurable and consistent.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should quality issues be evaluated for downstream impact?',
  '[{"key":"A","text":"A defect in one stage can affect testing, programming, serviceability, schedule, documentation, or later installation work"},{"key":"B","text":"Defects never affect later phases"},{"key":"C","text":"Only project managers need to know about defects"},{"key":"D","text":"Downstream impact matters only after turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality problems can propagate into later phases and become more expensive to correct.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of verifying corrective action?',
  '[{"key":"A","text":"To confirm that the defect was actually resolved and the work now meets the required standard"},{"key":"B","text":"To prove someone attempted a repair"},{"key":"C","text":"To remove the defect from the list without inspection"},{"key":"D","text":"To avoid future quality reviews"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective action should be rechecked before a defect is considered closed.'
),
(
  5,
  'multiple_choice',
  'application',
  'A service technician finds the same termination defect on multiple devices from one project. What should happen next?',
  '[{"key":"A","text":"Correct the immediate issue, inspect similar affected work, and communicate the pattern so the underlying cause can be addressed"},{"key":"B","text":"Repair only the device currently failing"},{"key":"C","text":"Ignore working devices"},{"key":"D","text":"Wait for more client complaints"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated defect should trigger broader verification and corrective action.'
),
(
  6,
  'multiple_choice',
  'application',
  'A systems programmer discovers configuration errors caused by inconsistent device naming. What is the BEST quality-control response?',
  '[{"key":"A","text":"Correct the naming inconsistencies, verify affected programming, and reinforce the required naming standard upstream"},{"key":"B","text":"Create exceptions for every device"},{"key":"C","text":"Ignore the names if the system currently works"},{"key":"D","text":"Remove all device labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control includes identifying and correcting upstream conditions that create downstream configuration errors.'
),
(
  7,
  'multiple_choice',
  'application',
  'A systems designer reviews an installed project and finds that the system works but several device locations do not match approved design intent. What is the BEST response?',
  '[{"key":"A","text":"Identify the deviations, verify whether they were approved, and correct or reconcile them through the project process"},{"key":"B","text":"Accept them because the system works"},{"key":"C","text":"Update the design without review"},{"key":"D","text":"Ignore location quality if the client has not complained"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional performance does not automatically make unauthorized design deviations acceptable.'
),
(
  8,
  'multiple_choice',
  'application',
  'A logistics manager notices repeated project delays caused by incomplete staging. What quality-control improvement is MOST appropriate?',
  '[{"key":"A","text":"Define staging acceptance criteria and verify quantities, models, condition, labeling, and project readiness before release"},{"key":"B","text":"Ship materials faster without checking them"},{"key":"C","text":"Let field teams identify shortages after arrival"},{"key":"D","text":"Remove staging checklists"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear staging acceptance criteria can prevent incomplete or incorrect material packages from reaching the field.'
),
(
  9,
  'multiple_choice',
  'application',
  'A sales manager finds recurring proposal errors involving quantities and exclusions. What is the BEST quality-control response?',
  '[{"key":"A","text":"Introduce a structured pre-release review and analyze why the same errors are recurring"},{"key":"B","text":"Correct each proposal only after the client notices"},{"key":"C","text":"Reduce proposal detail"},{"key":"D","text":"Allow each salesperson to use different review standards"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring proposal errors should trigger both review controls and root-cause analysis.'
),
(
  10,
  'multiple_choice',
  'application',
  'A project has passed functional testing, but the service team says the installation will be difficult to maintain. What should quality review consider?',
  '[{"key":"A","text":"Serviceability, labeling, organization, access, documentation, and maintainability in addition to function"},{"key":"B","text":"Only whether the system powers on"},{"key":"C","text":"Only client-visible appearance"},{"key":"D","text":"Only labor hours"}]'::jsonb,
  '["A"]'::jsonb,
  'A high-quality installation should support reliable future maintenance and service.'
),
(
  11,
  'multiple_choice',
  'application',
  'A lead reviewer sees defects being corrected but notices no one is checking the corrections afterward. What process should be added?',
  '[{"key":"A","text":"A verification step that confirms corrected work meets the acceptance criteria before closure"},{"key":"B","text":"A rule that every correction is automatically accepted"},{"key":"C","text":"Fewer defect records"},{"key":"D","text":"Client approval for every minor correction"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective work should be re-inspected before defects are formally closed.'
),
(
  12,
  'scenario',
  'scenario',
  'A service technician responds to repeated failures in devices installed during the same project phase and finds the same installation defect each time. What is the BEST response?',
  '[{"key":"A","text":"Repair the current failure, identify the affected population, inspect similar installations, communicate the pattern, and pursue corrective action at the source"},{"key":"B","text":"Treat each service call as unrelated"},{"key":"C","text":"Replace only failed devices"},{"key":"D","text":"Wait until every device fails"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeating defect across similar installations suggests a systemic quality issue.'
),
(
  13,
  'scenario',
  'scenario',
  'A project team reports a phase as complete, but a quality review finds missing tests, incomplete labeling, outdated documentation, and unresolved punch items. What is the BEST response?',
  '[{"key":"A","text":"Reclassify the phase as incomplete, document the deficiencies, assign corrective actions, and verify closure before acceptance"},{"key":"B","text":"Keep the phase marked complete because installation is mostly finished"},{"key":"C","text":"Correct only the visible defects"},{"key":"D","text":"Transfer the problems to service"}]'::jsonb,
  '["A"]'::jsonb,
  'Completion should reflect all defined acceptance criteria, not just physical progress.'
),
(
  14,
  'scenario',
  'scenario',
  'A systems programmer finds that several control-system failures trace back to inconsistent installation and labeling practices. What is the BEST quality response?',
  '[{"key":"A","text":"Correct affected systems, identify the inconsistent field practice, standardize the requirement, and verify future work against it"},{"key":"B","text":"Add programming workarounds indefinitely"},{"key":"C","text":"Ignore field inconsistencies"},{"key":"D","text":"Remove labeling requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality problems should be corrected at both the symptom and root process level.'
),
(
  15,
  'scenario',
  'scenario',
  'A design review shows a recurring mismatch between approved drawings and installed device locations across multiple projects. What is the BEST next step?',
  '[{"key":"A","text":"Investigate where the breakdown occurs in handoff, field verification, revision control, or installation execution and correct the responsible process"},{"key":"B","text":"Update drawings after every project to match whatever was installed"},{"key":"C","text":"Stop checking device locations"},{"key":"D","text":"Assume all field changes were approved"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring design-to-field mismatches indicate a systemic execution or communication problem.'
),
(
  16,
  'scenario',
  'scenario',
  'A warehouse repeatedly ships projects with one or two missing small parts, creating field delays. What is the BEST quality-control improvement?',
  '[{"key":"A","text":"Analyze the staging failure pattern, improve pick verification and acceptance criteria, and measure whether the defect rate decreases"},{"key":"B","text":"Tell technicians to carry more spare parts"},{"key":"C","text":"Stop documenting shortages"},{"key":"D","text":"Ship earlier without verification"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring staging defect should be addressed with process correction and measurable follow-up.'
),
(
  17,
  'scenario',
  'scenario',
  'A client walkthrough reveals several minor workmanship issues that internal teams previously considered acceptable. What is the BEST response?',
  '[{"key":"A","text":"Correct the identified issues and review whether internal acceptance criteria are clear and aligned with the company quality standard"},{"key":"B","text":"Tell the client the issues are too minor to matter"},{"key":"C","text":"Ignore the issues because the system works"},{"key":"D","text":"Remove finish-quality expectations"}]'::jsonb,
  '["A"]'::jsonb,
  'Client-discovered defects can reveal gaps in internal quality criteria or inspection consistency.'
),
(
  18,
  'scenario',
  'scenario',
  'A manager sees that the same punch-list defects appear on nearly every project. What is the BEST quality strategy?',
  '[{"key":"A","text":"Trend the recurring defects, identify common causes, implement preventive changes, and verify whether future defect rates improve"},{"key":"B","text":"Accept the defects as normal"},{"key":"C","text":"Create larger punch lists"},{"key":"D","text":"Stop tracking the defects"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring punch items are valuable data for improving standards, training, and workflow.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician fixes a quality defect, but the correction creates a new problem elsewhere in the system. What should happen?',
  '[{"key":"A","text":"Evaluate the full impact of the corrective action, resolve the new issue, and verify the system against the required acceptance criteria"},{"key":"B","text":"Close the original defect and ignore the new one"},{"key":"C","text":"Undo all quality checks"},{"key":"D","text":"Mark both issues complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective actions should not be accepted until their broader system impact has been verified.'
),
(
  20,
  'scenario',
  'scenario',
  'A project repeatedly passes internal checks but generates service callbacks soon after turnover. What is the BEST quality-control response?',
  '[{"key":"A","text":"Compare callback causes with current inspection and testing criteria, identify gaps, strengthen acceptance checks, and verify whether callbacks decline"},{"key":"B","text":"Treat service callbacks as unrelated to project quality"},{"key":"C","text":"Reduce testing to save time"},{"key":"D","text":"Wait for the warranty period to end"}]'::jsonb,
  '["A"]'::jsonb,
  'Post-turnover failures are important feedback for evaluating whether internal quality controls are actually effective.'
);

create temporary table _seed_ci_quality_control_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_quality_control_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a quality-management system across projects?',
  '[{"key":"A","text":"To define standards, controls, ownership, verification, corrective action, and continuous improvement so quality is repeatable"},{"key":"B","text":"To eliminate all inspections"},{"key":"C","text":"To make quality the responsibility of one technician"},{"key":"D","text":"To focus only on client-visible defects"}]'::jsonb,
  '["A"]'::jsonb,
  'A quality-management system makes expectations and controls repeatable across teams and projects.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are leading quality indicators useful?',
  '[{"key":"A","text":"They help identify conditions that may predict future defects before failures or callbacks occur"},{"key":"B","text":"They only measure past warranty cost"},{"key":"C","text":"They eliminate the need for standards"},{"key":"D","text":"They are useful only after turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'Leading indicators can reveal risks early enough for preventive action.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest purpose of root-cause corrective action?',
  '[{"key":"A","text":"To eliminate or reduce the underlying cause of recurring defects rather than repeatedly fixing symptoms"},{"key":"B","text":"To document who made the mistake"},{"key":"C","text":"To reduce inspection effort"},{"key":"D","text":"To close defects faster without verification"}]'::jsonb,
  '["A"]'::jsonb,
  'Root-cause action addresses the conditions that create repeat failures.'
),
(
  4,
  'multiple_choice',
  'application',
  'A project manager sees that punch-list volume is increasing across projects. What is the BEST first management response?',
  '[{"key":"A","text":"Trend defect types, locations, phases, crews, and causes to identify patterns before choosing corrective actions"},{"key":"B","text":"Create longer punch lists"},{"key":"C","text":"Stop tracking minor defects"},{"key":"D","text":"Assume the increase is unavoidable"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality improvement should begin with evidence about where defects originate and repeat.'
),
(
  5,
  'multiple_choice',
  'application',
  'An operations manager wants to reduce rework. Which approach is MOST effective?',
  '[{"key":"A","text":"Define measurable quality criteria at each phase, inspect at the right checkpoints, analyze defect data, and correct recurring process causes"},{"key":"B","text":"Perform one inspection at project closeout"},{"key":"C","text":"Accept small defects to keep schedules moving"},{"key":"D","text":"Move all inspection responsibility to service"}]'::jsonb,
  '["A"]'::jsonb,
  'Rework prevention depends on clear criteria, timely verification, and process correction.'
),
(
  6,
  'multiple_choice',
  'application',
  'A lead technician finds that different crews interpret the same quality standard differently. What is the BEST response?',
  '[{"key":"A","text":"Clarify the acceptance criteria with examples, train the teams, and verify consistent application across crews"},{"key":"B","text":"Allow each crew to define its own standard"},{"key":"C","text":"Remove the standard"},{"key":"D","text":"Inspect only the weakest crew"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality criteria must be understood and applied consistently to produce repeatable results.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project is consistently passing internal inspections but still generating post-turnover callbacks. What should leadership review?',
  '[{"key":"A","text":"Whether current acceptance criteria and test methods actually detect the failure modes appearing after turnover"},{"key":"B","text":"Only technician attendance"},{"key":"C","text":"Only material cost"},{"key":"D","text":"Whether callbacks can be excluded from reporting"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality controls should be validated against actual downstream performance.'
),
(
  8,
  'multiple_choice',
  'application',
  'A manager wants to know whether a corrective-action program is working. What should be measured?',
  '[{"key":"A","text":"Whether the targeted defect rate, rework, callbacks, or related quality failures decrease after the corrective action"},{"key":"B","text":"Only how many meetings were held"},{"key":"C","text":"Only the number of emails sent"},{"key":"D","text":"Only whether the correction was announced"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective action should be evaluated by measurable improvement in the targeted outcome.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project manager is under schedule pressure and asks the team to skip a required quality checkpoint. What is the BEST leadership response?',
  '[{"key":"A","text":"Evaluate the schedule issue without silently removing the defined quality control; any change to acceptance requirements should follow the approved process"},{"key":"B","text":"Skip the checkpoint whenever the schedule is tight"},{"key":"C","text":"Mark the checkpoint complete without inspection"},{"key":"D","text":"Move all quality checks to warranty service"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule pressure should not create undocumented exceptions to established quality requirements.'
),
(
  10,
  'multiple_choice',
  'application',
  'A quality review identifies both technical defects and documentation deficiencies. How should they be treated?',
  '[{"key":"A","text":"As separate but related quality requirements that both must meet defined completion criteria"},{"key":"B","text":"Ignore documentation if the system functions"},{"key":"C","text":"Ignore technical defects if documentation is complete"},{"key":"D","text":"Treat only client-visible issues as quality defects"}]'::jsonb,
  '["A"]'::jsonb,
  'Project quality can include physical, functional, and documentation requirements.'
),
(
  11,
  'scenario',
  'scenario',
  'A company sees recurring service callbacks for loose terminations. Inspection data shows the issue originates during one installation phase. What is the BEST quality response?',
  '[{"key":"A","text":"Contain and correct affected work, identify why the phase is producing loose terminations, improve the method or training, and monitor callback and defect rates afterward"},{"key":"B","text":"Repair callbacks individually"},{"key":"C","text":"Stop measuring termination defects"},{"key":"D","text":"Replace all equipment regardless of cause"}]'::jsonb,
  '["A"]'::jsonb,
  'An effective response addresses immediate defects and the process creating them.'
),
(
  12,
  'scenario',
  'scenario',
  'A project repeatedly misses completion dates because defects are found only during final walkthrough. What is the BEST systemic improvement?',
  '[{"key":"A","text":"Move quality verification earlier into phase-gate checks so defects are found and corrected before final closeout"},{"key":"B","text":"Schedule longer final walkthroughs"},{"key":"C","text":"Accept more defects at turnover"},{"key":"D","text":"Reduce final inspection detail"}]'::jsonb,
  '["A"]'::jsonb,
  'Earlier quality checkpoints reduce late discovery and closeout rework.'
),
(
  13,
  'scenario',
  'scenario',
  'An operations manager learns that one crew has excellent speed but produces twice the rework of other crews. What is the BEST interpretation?',
  '[{"key":"A","text":"Productivity should be evaluated together with quality because fast work that creates rework may not represent efficient performance"},{"key":"B","text":"The crew is the most productive because it finishes first"},{"key":"C","text":"Rework should be excluded from performance review"},{"key":"D","text":"Quality and productivity are unrelated"}]'::jsonb,
  '["A"]'::jsonb,
  'True operational performance accounts for both output and the cost of correcting defects.'
),
(
  14,
  'scenario',
  'scenario',
  'A quality audit finds that different project managers use different definitions of "complete." What is the BEST corrective action?',
  '[{"key":"A","text":"Establish company-level completion criteria by phase, train managers and teams, and use the criteria consistently in project status and acceptance"},{"key":"B","text":"Allow each manager to keep a personal definition"},{"key":"C","text":"Stop using completion status"},{"key":"D","text":"Let clients define completion after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared completion criteria reduce inconsistent status reporting and acceptance.'
),
(
  15,
  'scenario',
  'scenario',
  'A project has a high number of minor cosmetic defects, but few functional failures. Leadership is considering dropping cosmetic inspections. What is the BEST response?',
  '[{"key":"A","text":"Keep finish-quality criteria appropriate to the company standard and client expectation while analyzing why cosmetic defects are recurring"},{"key":"B","text":"Remove cosmetic quality entirely"},{"key":"C","text":"Ignore anything that does not cause system failure"},{"key":"D","text":"Ask clients to repair cosmetic issues"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional quality includes finish and workmanship, not only technical function.'
),
(
  16,
  'scenario',
  'scenario',
  'A manager introduces a new checklist, but defect rates remain unchanged. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate whether the checklist targets the actual failure causes, whether teams use it correctly, and whether verification occurs at the right point in the workflow"},{"key":"B","text":"Assume the checklist works because it exists"},{"key":"C","text":"Create another checklist without analysis"},{"key":"D","text":"Stop measuring defects"}]'::jsonb,
  '["A"]'::jsonb,
  'A control is only effective if it addresses the real failure mode and is executed correctly.'
),
(
  17,
  'scenario',
  'scenario',
  'A client reports several quality issues that internal teams never recorded. What is the BEST leadership response?',
  '[{"key":"A","text":"Correct the client issues, compare them with internal inspection criteria, identify why they escaped detection, and strengthen the quality process where needed"},{"key":"B","text":"Treat client findings as unrelated"},{"key":"C","text":"Stop sharing quality results internally"},{"key":"D","text":"Remove the affected quality criteria"}]'::jsonb,
  '["A"]'::jsonb,
  'Escaped defects reveal gaps in inspection criteria, execution, or verification.'
),
(
  18,
  'scenario',
  'scenario',
  'A recurring equipment-staging error causes installation teams to lose hours on site. What is the BEST cross-functional quality response?',
  '[{"key":"A","text":"Map the staging failure, define the required readiness check, assign ownership, verify release quality, and measure whether field delays decline"},{"key":"B","text":"Tell installers to work around the shortages"},{"key":"C","text":"Add more site labor"},{"key":"D","text":"Stop reporting staging errors"}]'::jsonb,
  '["A"]'::jsonb,
  'Upstream quality failures should be corrected where they originate and measured by downstream improvement.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician repeatedly corrects the same type of defect, but leadership has never reviewed the pattern. What should happen?',
  '[{"key":"A","text":"Escalate the recurring defect data for root-cause analysis and preventive action rather than continuing isolated corrections"},{"key":"B","text":"Keep repairing each defect separately"},{"key":"C","text":"Stop documenting the defect"},{"key":"D","text":"Lower the acceptance standard"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring defects should trigger systemic improvement rather than endless symptom correction.'
),
(
  20,
  'scenario',
  'scenario',
  'Leadership sees rework, callbacks, delayed closeout, staging mistakes, and inconsistent completion standards across departments. What is the BEST organization-wide quality strategy?',
  '[{"key":"A","text":"Build a shared quality system with defined standards, phase-specific acceptance criteria, ownership, inspection points, defect tracking, root-cause correction, training, and measurable quality KPIs"},{"key":"B","text":"Add one final inspection at the end of every project"},{"key":"C","text":"Make service responsible for all defects"},{"key":"D","text":"Focus only on technician workmanship"}]'::jsonb,
  '["A"]'::jsonb,
  'Broad quality failures require a coordinated operating system across departments and project phases.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '2c3f55cf-25ba-4d24-9e0f-2da8306938dc';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l3_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
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
      and c.name = 'Quality Control'
      and c.is_current = true
  ) then
    raise exception 'Current Quality Control Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 Quality Control requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician II — Experienced'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Technician II — Experienced L2 Quality Control requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Service Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Service Technician L3 Quality Control requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Quality Control requirement not found';
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
  v_assessment_name := 'Quality Control — Level 1 Competency Assessment';

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
    select * from _seed_ci_quality_control_l1_questions
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
        'Quality Control',
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
      'IntegrateU Quality Control L1 production assessment v1.0.',
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
        'Quality Control',
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
        'IntegrateU Quality Control L1 production assessment v1.0.',
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
  v_assessment_name := 'Quality Control — Level 2 Competency Assessment';

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
    select * from _seed_ci_quality_control_l2_questions
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
        'Quality Control',
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
      'IntegrateU Quality Control L2 production assessment v1.0.',
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
        'Quality Control',
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
        'IntegrateU Quality Control L2 production assessment v1.0.',
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
  v_assessment_name := 'Quality Control — Level 3 Competency Assessment';

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
    select * from _seed_ci_quality_control_l3_questions
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
        'Quality Control',
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
      'IntegrateU Quality Control L3 production assessment v1.0.',
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
        'Quality Control',
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
        'IntegrateU Quality Control L3 production assessment v1.0.',
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
  v_assessment_name := 'Quality Control — Level 4 Competency Assessment';

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
    select * from _seed_ci_quality_control_l4_questions
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
        'Quality Control',
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
      'IntegrateU Quality Control L4 production assessment v1.0.',
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
        'Quality Control',
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
        'IntegrateU Quality Control L4 production assessment v1.0.',
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
