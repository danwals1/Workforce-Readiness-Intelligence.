-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0152_ci_documentation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Documentation
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level     -> Level 1
--   Operations Manager  -> Level 2
--   Systems Designer    -> Level 3
--   Service Technician  -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess cabling and termination competency across
-- progressively higher levels of recognition, application, troubleshooting,
-- system judgment, and cross-system technical understanding.
-- ============================================================================

begin;

create temporary table _seed_ci_documentation_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_documentation_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is accurate project documentation important during installation?',
  '[{"key":"A","text":"It helps the team understand what was planned, completed, changed, tested, and still requires attention"},{"key":"B","text":"It is mainly used for payroll"},{"key":"C","text":"It removes the need for field communication"},{"key":"D","text":"It is only useful after the project is complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate documentation supports communication, continuity, verification, troubleshooting, and project completion.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a consistent cable or device identifier?',
  '[{"key":"A","text":"To connect the physical installation to the project records and make items easier to identify later"},{"key":"B","text":"To show which technician installed it"},{"key":"C","text":"To determine equipment cost"},{"key":"D","text":"To replace testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent identifiers connect installed work to drawings, schedules, test records, and future service information.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should a technician do when completing required installation documentation?',
  '[{"key":"A","text":"Record information accurately, clearly, and according to the company or project standard"},{"key":"B","text":"Record only unusual conditions"},{"key":"C","text":"Wait until several weeks after the work"},{"key":"D","text":"Use personal abbreviations that only the technician understands"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation should be timely, understandable, and consistent with the required project process.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a revision in project documentation?',
  '[{"key":"A","text":"An updated version of a document that reflects an authorized change or correction"},{"key":"B","text":"A duplicate printed copy"},{"key":"C","text":"A technician time entry"},{"key":"D","text":"A warranty registration"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision information helps teams distinguish current documents from superseded versions.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should installation photos be associated with the correct room, device, cable, or work area?',
  '[{"key":"A","text":"So the photos can be understood and used later as part of the project record"},{"key":"B","text":"So the file size is larger"},{"key":"C","text":"So technicians do not need labels"},{"key":"D","text":"So drawings can be discarded"}]'::jsonb,
  '["A"]'::jsonb,
  'Photos provide more value when their location and subject can be reliably identified.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the purpose of a technician work note or daily project update?',
  '[{"key":"A","text":"To record relevant work completed, conditions, issues, blockers, or next steps"},{"key":"B","text":"To replace the entire project schedule"},{"key":"C","text":"To record only the technician arrival time"},{"key":"D","text":"To document unrelated personal observations"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful daily documentation preserves information the project team may need for coordination and follow-up.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why should test results be documented when the project requires them?',
  '[{"key":"A","text":"To create a record showing what was tested and the result obtained"},{"key":"B","text":"To avoid performing future maintenance"},{"key":"C","text":"To replace equipment labels"},{"key":"D","text":"To prove every system will always remain operational"}]'::jsonb,
  '["A"]'::jsonb,
  'Recorded test results provide evidence of the condition verified at the time of testing.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What is the BEST description of an as-built record?',
  '[{"key":"A","text":"Documentation updated to reflect the verified installed condition"},{"key":"B","text":"The original proposal only"},{"key":"C","text":"An employee training record"},{"key":"D","text":"A list of future sales opportunities"}]'::jsonb,
  '["A"]'::jsonb,
  'As-built records capture how the final installation actually exists after approved field changes.'
),
(
  9,
  'multiple_choice',
  'application',
  'A cable is labeled C-214 in the project documentation. What should the technician do when identifying the installed cable?',
  '[{"key":"A","text":"Use the required project labeling standard so the installed cable remains associated with C-214"},{"key":"B","text":"Create a different personal label"},{"key":"C","text":"Leave the cable unlabeled"},{"key":"D","text":"Label it only after the project closes"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintaining the approved identifier preserves the link between the physical installation and project records.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician completes three device installations but records only two as complete. What is the BEST action?',
  '[{"key":"A","text":"Update the project record so it accurately reflects all completed work"},{"key":"B","text":"Leave the record unchanged"},{"key":"C","text":"Wait for someone else to notice"},{"key":"D","text":"Mark every device on the project complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Progress documentation should accurately match the work that has actually been completed.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician discovers that an equipment serial number in the project record does not match the installed unit. What should the technician do?',
  '[{"key":"A","text":"Verify the installed equipment and correct or report the documentation discrepancy through the required process"},{"key":"B","text":"Change the equipment label to match the record"},{"key":"C","text":"Ignore the mismatch"},{"key":"D","text":"Enter a random serial number"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment records should reflect the verified equipment actually installed.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician takes photos before a wall is closed. What makes those photos most useful for future reference?',
  '[{"key":"A","text":"They clearly show the relevant work and are stored or labeled so the location and subject can be identified"},{"key":"B","text":"They include unrelated areas of the room"},{"key":"C","text":"They are kept only on the technician personal phone"},{"key":"D","text":"They are taken without any location context"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful construction photos must be identifiable and accessible as part of the project documentation.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician is documenting a project issue. Which note is BEST?',
  '[{"key":"A","text":"Display in Conference Room 2 has power but no video; HDMI path from rack output to display input was verified; issue escalated for further troubleshooting"},{"key":"B","text":"Display broken"},{"key":"C","text":"Something is wrong"},{"key":"D","text":"Could not finish"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective notes describe the location, condition, relevant verification, and status clearly enough for another person to act on them.'
),
(
  14,
  'multiple_choice',
  'application',
  'A required checklist contains an item the technician did not perform. What should the technician do?',
  '[{"key":"A","text":"Leave it incomplete or mark it according to the approved process and address the requirement rather than falsely documenting completion"},{"key":"B","text":"Mark it complete to finish the checklist"},{"key":"C","text":"Delete the checklist item"},{"key":"D","text":"Initial it using another technician name"}]'::jsonb,
  '["A"]'::jsonb,
  'Project records should truthfully reflect the work and verification actually performed.'
),
(
  15,
  'multiple_choice',
  'application',
  'A technician notices that a field-installed device had to be moved from its documented location after approved direction was received. What should happen to the project record?',
  '[{"key":"A","text":"The approved field change should be captured according to the project documentation or as-built process"},{"key":"B","text":"The original location should remain the only documented location"},{"key":"C","text":"No record is necessary if the device works"},{"key":"D","text":"The technician should keep the change only in memory"}]'::jsonb,
  '["A"]'::jsonb,
  'Approved field changes should be preserved so the documentation can reflect the installed condition.'
),
(
  16,
  'multiple_choice',
  'application',
  'A technician finishes work that another technician will continue tomorrow. What documentation is MOST useful for the handoff?',
  '[{"key":"A","text":"What was completed, what remains, known issues or blockers, and any important locations or identifiers"},{"key":"B","text":"Only the total hours worked"},{"key":"C","text":"Only the technician name"},{"key":"D","text":"No documentation if the technicians can speak later"}]'::jsonb,
  '["A"]'::jsonb,
  'A good handoff record preserves enough context for the next person to continue work efficiently and safely.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician finds two versions of an installation document and cannot tell which one is current. What is the BEST action?',
  '[{"key":"A","text":"Verify the current approved revision through the project document-control process before performing the affected work"},{"key":"B","text":"Use the older version because it was printed first"},{"key":"C","text":"Combine both versions"},{"key":"D","text":"Choose the version with fewer requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Using obsolete documentation can create incorrect installation, rework, and project risk.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician is about to connect a rack cable, but the physical cable label does not match the approved connection documentation. What should happen next?',
  '[{"key":"A","text":"Verify the cable identity and documentation and resolve or report the discrepancy before making the connection"},{"key":"B","text":"Connect it wherever it appears to fit"},{"key":"C","text":"Remove the label and continue"},{"key":"D","text":"Change the documentation immediately without verification"}]'::jsonb,
  '["A"]'::jsonb,
  'A mismatch between the physical installation and documentation should be verified before a potentially incorrect connection is made.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician completes rough-in work that will soon be hidden behind finished surfaces. The project requires photo documentation, but no photos were taken. What is the BEST response?',
  '[{"key":"A","text":"Complete the required documentation before the work becomes inaccessible when possible, and communicate the issue if the requirement cannot be met"},{"key":"B","text":"Mark the photo requirement complete anyway"},{"key":"C","text":"Use photos from another project"},{"key":"D","text":"Assume documentation is unnecessary because the cable is installed"}]'::jsonb,
  '["A"]'::jsonb,
  'Required concealed-work documentation should be captured before access is lost whenever possible.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician ends the day with one completed room, one partially completed room, and a blocked device location. What is the BEST project update?',
  '[{"key":"A","text":"Record the completed work, accurately identify the partial work, document the blocked location and reason, and note the needed next action"},{"key":"B","text":"Mark both rooms complete"},{"key":"C","text":"Write only that progress was made"},{"key":"D","text":"Wait until the entire project is finished to document the day"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate status documentation distinguishes completed, incomplete, and blocked work and supports effective project coordination.'
);

create temporary table _seed_ci_documentation_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_documentation_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the main purpose of maintaining consistent documentation standards across a project?',
  '[{"key":"A","text":"To make records easier for multiple team members to understand, use, and maintain"},{"key":"B","text":"To reduce the need for any field notes"},{"key":"C","text":"To eliminate project updates"},{"key":"D","text":"To let each person document work differently"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent standards improve clarity, continuity, and usability across teams.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a controlled document?',
  '[{"key":"A","text":"A document whose current version, status, and authorized use are managed through an established process"},{"key":"B","text":"Any file stored on a technician laptop"},{"key":"C","text":"A document with a password"},{"key":"D","text":"Any printed drawing"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled documents help teams distinguish current approved information from outdated or unofficial copies.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should documentation distinguish completed work from verified work?',
  '[{"key":"A","text":"Because completion and verification are different states and should not be treated as the same evidence"},{"key":"B","text":"Because only verified work is billable"},{"key":"C","text":"Because completed work should never be documented"},{"key":"D","text":"Because verification replaces installation"}]'::jsonb,
  '["A"]'::jsonb,
  'A task may be physically complete before required inspection, testing, or review has occurred.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a service record?',
  '[{"key":"A","text":"To document the reported issue, observations, work performed, results, and relevant follow-up information"},{"key":"B","text":"To replace all project drawings"},{"key":"C","text":"To track only travel time"},{"key":"D","text":"To record employee vacation"}]'::jsonb,
  '["A"]'::jsonb,
  'A useful service record preserves technical history for future troubleshooting and client support.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should documentation be updated close to when the work occurs?',
  '[{"key":"A","text":"Timely updates reduce missing details and keep project status useful for coordination"},{"key":"B","text":"Late documentation is always more accurate"},{"key":"C","text":"Documentation only matters at closeout"},{"key":"D","text":"Timing has no effect on accuracy"}]'::jsonb,
  '["A"]'::jsonb,
  'Prompt documentation reduces reliance on memory and improves current project visibility.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician replaces a failed device during service. What should the service record include?',
  '[{"key":"A","text":"The failed device condition, replacement performed, relevant identifiers, test result, and final status"},{"key":"B","text":"Only that the visit was completed"},{"key":"C","text":"Only the replacement cost"},{"key":"D","text":"Only the client name"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete service record should preserve enough technical detail to explain what was found and what changed.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project record shows a device as installed, but the field condition shows it is still incomplete. What should the technician do?',
  '[{"key":"A","text":"Correct the status through the approved project process so the record reflects the actual condition"},{"key":"B","text":"Leave the record unchanged"},{"key":"C","text":"Mark the entire room complete"},{"key":"D","text":"Wait until closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Status records should accurately reflect the current field condition.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician receives approved direction to reroute a cable pathway. What documentation should be updated?',
  '[{"key":"A","text":"The applicable field record or as-built documentation so the approved routing change is preserved"},{"key":"B","text":"Only the technician timecard"},{"key":"C","text":"Nothing if the cable functions"},{"key":"D","text":"Only the equipment warranty"}]'::jsonb,
  '["A"]'::jsonb,
  'Approved field changes should be incorporated into the project record.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician is handing off a service issue that has not been resolved. What is the BEST documentation?',
  '[{"key":"A","text":"Reported symptom, observations, tests performed, results, changes made, current condition, and recommended next step"},{"key":"B","text":"Could not fix"},{"key":"C","text":"Needs more work"},{"key":"D","text":"Only the client contact information"}]'::jsonb,
  '["A"]'::jsonb,
  'A detailed unresolved-service record prevents duplicate effort and preserves diagnostic history.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician notices that photos uploaded to the project record are difficult to identify. What is the BEST improvement?',
  '[{"key":"A","text":"Use a consistent naming, tagging, or folder structure tied to locations, devices, phases, or identifiers"},{"key":"B","text":"Take fewer photos regardless of requirements"},{"key":"C","text":"Store all photos in one unnamed folder"},{"key":"D","text":"Keep photos only on personal devices"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent organization makes photo documentation easier to retrieve and interpret.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician completes a cable test and the result fails. How should the result be documented?',
  '[{"key":"A","text":"Record the actual failed result and follow the required corrective or escalation process"},{"key":"B","text":"Record it as passed to avoid delay"},{"key":"C","text":"Delete the test"},{"key":"D","text":"Do not document failed results"}]'::jsonb,
  '["A"]'::jsonb,
  'Test records must accurately reflect actual results, including failures.'
),
(
  12,
  'multiple_choice',
  'application',
  'A project note says only "issue resolved." What would make the note more useful?',
  '[{"key":"A","text":"Add what the issue was, what action was taken, how the result was verified, and any relevant follow-up"},{"key":"B","text":"Make the note shorter"},{"key":"C","text":"Remove the date"},{"key":"D","text":"Replace it with a technician nickname"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful documentation explains enough context and outcome for another team member to understand the work.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician finds a discrepancy between a cable schedule and the labels in the field. What should happen first?',
  '[{"key":"A","text":"Verify the physical installation and current project documentation before changing either record"},{"key":"B","text":"Change the schedule immediately"},{"key":"C","text":"Remove all cable labels"},{"key":"D","text":"Assume the field label is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'Discrepancies should be verified before records or physical identifiers are changed.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician is documenting partially completed work. What is the BEST practice?',
  '[{"key":"A","text":"Record what is complete, what remains, and any condition affecting continuation"},{"key":"B","text":"Mark the entire task complete"},{"key":"C","text":"Leave the task undocumented"},{"key":"D","text":"Record only the estimated remaining hours"}]'::jsonb,
  '["A"]'::jsonb,
  'Partial-work documentation should make the exact current state clear.'
),
(
  15,
  'scenario',
  'scenario',
  'A team discovers that several technicians have been documenting the same type of installation using different naming conventions. What is the BEST response?',
  '[{"key":"A","text":"Standardize the naming convention, correct critical inconsistencies where needed, and communicate the standard to the team"},{"key":"B","text":"Allow every technician to continue using personal conventions"},{"key":"C","text":"Delete all prior documentation"},{"key":"D","text":"Stop using identifiers"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent naming improves traceability and reduces confusion across installation, testing, and service.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician discovers an approved field change was completed last week but never documented. What is the BEST action?',
  '[{"key":"A","text":"Verify the installed condition and approved change, then update the project record through the required documentation process"},{"key":"B","text":"Ignore it because the work is already complete"},{"key":"C","text":"Create a different undocumented change"},{"key":"D","text":"Wait for service to discover it"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing field-change documentation should be corrected while the information can still be verified.'
),
(
  17,
  'scenario',
  'scenario',
  'A service technician arrives at a site and finds that the previous service note contains no test results or description of the work performed. What is the BEST lesson for future documentation?',
  '[{"key":"A","text":"Service notes should preserve observations, tests, actions, results, and status so another technician can continue intelligently"},{"key":"B","text":"Service notes are unnecessary if the same technician returns"},{"key":"C","text":"Only billing information is needed"},{"key":"D","text":"Technicians should rely on memory"}]'::jsonb,
  '["A"]'::jsonb,
  'Service history is valuable only when it contains enough technical context to support future work.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician accidentally marks ten devices complete even though only eight were installed. What is the BEST response?',
  '[{"key":"A","text":"Correct the project record promptly and verify the actual status of all affected devices"},{"key":"B","text":"Leave the record because most devices are complete"},{"key":"C","text":"Install the remaining devices later without correcting the record"},{"key":"D","text":"Delete the entire project record"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect progress data should be corrected promptly so project decisions are based on accurate information.'
),
(
  19,
  'scenario',
  'scenario',
  'A project requires concealed-work photos before drywall. The technician has photos but they are unlabeled and show no clear location context. What is the BEST response?',
  '[{"key":"A","text":"Identify and organize the photos using verified location context while the work can still be confirmed, and improve the capture process going forward"},{"key":"B","text":"Submit them unchanged and assume someone can identify them later"},{"key":"C","text":"Delete the photos"},{"key":"D","text":"Use photos from another area"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation should be both captured and identifiable to be useful later.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes a repair but the client reports the same issue two days later. Which prior documentation would be MOST useful to the next technician?',
  '[{"key":"A","text":"Original symptom, conditions observed, tests performed, repair steps, components changed, verification results, and final status"},{"key":"B","text":"Only the invoice amount"},{"key":"C","text":"Only the technician arrival time"},{"key":"D","text":"A note saying repaired"}]'::jsonb,
  '["A"]'::jsonb,
  'Detailed service documentation helps distinguish a recurrence from a new issue and supports efficient troubleshooting.'
);

create temporary table _seed_ci_documentation_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_documentation_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of documentation quality control on an active project?',
  '[{"key":"A","text":"To ensure records are accurate, complete, current, traceable, and usable by the people who depend on them"},{"key":"B","text":"To reduce the amount of project information available"},{"key":"C","text":"To eliminate field communication"},{"key":"D","text":"To make documentation the responsibility of one person only"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation quality control helps ensure project records can reliably support execution, coordination, service, and closeout.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is traceability important when documenting project changes?',
  '[{"key":"A","text":"It connects the change to its source, approval, affected work, and resulting project record"},{"key":"B","text":"It guarantees the change has no cost impact"},{"key":"C","text":"It removes the need for approvals"},{"key":"D","text":"It allows technicians to make undocumented changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Traceability helps the team understand why a change occurred, who authorized it, and where it affected execution.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest reason to maintain accurate technical documentation after project completion?',
  '[{"key":"A","text":"It supports future service, troubleshooting, upgrades, warranty work, and operational continuity"},{"key":"B","text":"It prevents all future system failures"},{"key":"C","text":"It eliminates the need for testing"},{"key":"D","text":"It is only needed for accounting"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate technical records preserve project knowledge after the installation team leaves.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a documentation handoff?',
  '[{"key":"A","text":"The structured transfer of relevant project records, status, technical information, unresolved items, and ownership to the next responsible person or team"},{"key":"B","text":"Sending any project file without explanation"},{"key":"C","text":"Deleting draft records"},{"key":"D","text":"Moving equipment between technicians"}]'::jsonb,
  '["A"]'::jsonb,
  'A documentation handoff preserves context and responsibility as work moves between people, phases, or departments.'
),
(
  5,
  'multiple_choice',
  'application',
  'A lead technician reviews daily field updates and notices that one crew consistently reports tasks as complete without recording required test results. What is the BEST response?',
  '[{"key":"A","text":"Correct the documentation practice, verify affected work where needed, and reinforce that completion and verification must be documented separately"},{"key":"B","text":"Accept the updates because the work appears finished"},{"key":"C","text":"Delete all test requirements"},{"key":"D","text":"Wait until service discovers any problems"}]'::jsonb,
  '["A"]'::jsonb,
  'The documentation process should distinguish physical completion from required verification evidence.'
),
(
  6,
  'multiple_choice',
  'application',
  'Several technicians are documenting the same device type using different names and abbreviations. What should the lead technician do?',
  '[{"key":"A","text":"Standardize the naming convention and ensure future records use the approved terminology consistently"},{"key":"B","text":"Let each technician continue using personal terms"},{"key":"C","text":"Remove device identifiers entirely"},{"key":"D","text":"Keep separate terminology for every crew"}]'::jsonb,
  '["A"]'::jsonb,
  'Standard terminology improves searchability, traceability, handoffs, and future service.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project manager asks the lead technician to confirm whether a field change was properly documented. What should be verified?',
  '[{"key":"A","text":"The approved change source, affected location or system, actual installed condition, and corresponding project or as-built record"},{"key":"B","text":"Only whether the technician remembers the change"},{"key":"C","text":"Only the material cost"},{"key":"D","text":"Only the date the work occurred"}]'::jsonb,
  '["A"]'::jsonb,
  'A properly documented change should be traceable from authorization through installed condition and final record.'
),
(
  8,
  'multiple_choice',
  'application',
  'A service record lists several troubleshooting steps but does not include the results of those steps. What is the BEST improvement?',
  '[{"key":"A","text":"Record the result of each meaningful test or action so future technicians know what was confirmed, ruled out, or changed"},{"key":"B","text":"Remove the troubleshooting steps"},{"key":"C","text":"Record only the final invoice"},{"key":"D","text":"Add more general comments without test results"}]'::jsonb,
  '["A"]'::jsonb,
  'Troubleshooting history is useful when it preserves both actions and their outcomes.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project uses photos for concealed infrastructure documentation. What should the lead technician verify before an area is closed?',
  '[{"key":"A","text":"Required photos exist, clearly show the relevant work, can be tied to the correct location or identifier, and are stored in the approved project record"},{"key":"B","text":"Only that someone took photos"},{"key":"C","text":"Only that the photos are high resolution"},{"key":"D","text":"That the photos remain on a technician personal phone"}]'::jsonb,
  '["A"]'::jsonb,
  'Photo documentation must be identifiable, accessible, and complete enough to serve as reliable project evidence.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician discovers that a project checklist contains items that no longer match the current approved workflow. What is the BEST response?',
  '[{"key":"A","text":"Raise the discrepancy through the proper process and update the controlled checklist after the revised requirement is approved"},{"key":"B","text":"Edit the checklist informally without telling anyone"},{"key":"C","text":"Ignore all checklist items"},{"key":"D","text":"Tell technicians to choose which version they prefer"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled documentation should be updated deliberately so teams are not working from conflicting process requirements.'
),
(
  11,
  'multiple_choice',
  'application',
  'A project is transitioning from installation to service support. What documentation should the lead technician prioritize for handoff?',
  '[{"key":"A","text":"Verified as-builts, device and cable identifiers, configuration or technical records, test results, unresolved issues, service-relevant notes, and final system status"},{"key":"B","text":"Only original sales notes"},{"key":"C","text":"Only technician timecards"},{"key":"D","text":"Only the equipment invoice"}]'::jsonb,
  '["A"]'::jsonb,
  'Service teams need accurate technical and status information that reflects the completed installation.'
),
(
  12,
  'scenario',
  'scenario',
  'A crew completed several approved device relocations over the past week, but none were added to the field markups or as-built record. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Verify the installed locations and approved changes, update the controlled project record, and correct the field-change documentation process going forward"},{"key":"B","text":"Leave the records unchanged because the devices work"},{"key":"C","text":"Tell service to find the devices later"},{"key":"D","text":"Update only the easiest locations"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing change records should be corrected and the process failure addressed before more project knowledge is lost.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician marks a system as commissioned, but the required test evidence is missing from the project record. What should the lead technician do?',
  '[{"key":"A","text":"Verify whether commissioning was actually completed, obtain or repeat required evidence as appropriate, and correct the project status documentation"},{"key":"B","text":"Assume the commissioning occurred"},{"key":"C","text":"Delete the testing requirement"},{"key":"D","text":"Leave the system marked complete"}]'::jsonb,
  '["A"]'::jsonb,
  'A completion claim should be supported by the evidence required by the project process.'
),
(
  14,
  'scenario',
  'scenario',
  'A service technician reports that the project as-built shows a cable route that does not match the actual installation. What is the BEST response?',
  '[{"key":"A","text":"Verify the field condition, determine whether the documentation or installation is incorrect, correct the authoritative record through the proper process, and capture the discrepancy for future prevention"},{"key":"B","text":"Tell service to ignore the as-built"},{"key":"C","text":"Change the drawing without verification"},{"key":"D","text":"Assume the field condition is always correct"}]'::jsonb,
  '["A"]'::jsonb,
  'A discrepancy between documentation and field condition should be investigated before either is treated as authoritative.'
),
(
  15,
  'scenario',
  'scenario',
  'A project handoff occurs while several punch-list items remain open. What is the BEST documentation approach?',
  '[{"key":"A","text":"Clearly identify each open item, current status, responsible party, relevant location, known dependencies, and next action as part of the handoff"},{"key":"B","text":"Mark all items complete before the handoff"},{"key":"C","text":"Leave the open items in personal notes"},{"key":"D","text":"Transfer only the project schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Open work should remain visible and actionable when responsibility transfers.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician uploads dozens of project photos, but filenames and folders provide no indication of room, device, phase, or date. What is the BEST leadership response?',
  '[{"key":"A","text":"Reorganize critical documentation where practical and establish a consistent photo-capture and naming standard for future work"},{"key":"B","text":"Accept the photos because quantity is sufficient"},{"key":"C","text":"Delete all photos"},{"key":"D","text":"Require technicians to remember which photo belongs where"}]'::jsonb,
  '["A"]'::jsonb,
  'Large amounts of unstructured documentation may be unusable when the subject and context cannot be identified.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician enters a status update saying a project area is complete, but another crew arrives and discovers missing labels, incomplete tests, and two unresolved devices. What is the BEST response?',
  '[{"key":"A","text":"Correct the project status, document the specific incomplete items, determine why completion criteria were misunderstood, and reinforce the required definition of complete"},{"key":"B","text":"Leave the status as complete because most work was done"},{"key":"C","text":"Tell the second crew to finish everything without updating records"},{"key":"D","text":"Remove completion tracking"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation accuracy depends on shared completion criteria and truthful status updates.'
),
(
  18,
  'scenario',
  'scenario',
  'A service issue has been worked by three technicians. Each created separate notes with overlapping tests, but there is no clear consolidated history. What is the BEST next step?',
  '[{"key":"A","text":"Consolidate the relevant technical history, identify what has already been verified or changed, and establish the current unresolved condition before further troubleshooting"},{"key":"B","text":"Start troubleshooting from the beginning without reviewing prior notes"},{"key":"C","text":"Delete the older records"},{"key":"D","text":"Keep all information separate indefinitely"}]'::jsonb,
  '["A"]'::jsonb,
  'Consolidated service history prevents duplicate effort and improves diagnostic continuity.'
),
(
  19,
  'scenario',
  'scenario',
  'A project manager learns that technicians have been using an unofficial shared spreadsheet instead of the approved project tracking system. What is the BEST response?',
  '[{"key":"A","text":"Reconcile important current data into the approved system, determine why the unofficial tool emerged, and reinforce or improve the controlled documentation workflow"},{"key":"B","text":"Maintain both systems permanently without reconciliation"},{"key":"C","text":"Delete the unofficial spreadsheet before reviewing its contents"},{"key":"D","text":"Allow every technician to choose a tracking method"}]'::jsonb,
  '["A"]'::jsonb,
  'Parallel unofficial records create version and accountability risk and should be reconciled into the controlled workflow.'
),
(
  20,
  'scenario',
  'scenario',
  'Closeout review finds missing serial numbers, incomplete test records, inconsistent labels, and several undocumented field changes. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Create a structured closeout correction plan, verify missing information against the field, reconcile approved changes, complete required records, and address the process gaps that caused the deficiencies"},{"key":"B","text":"Submit the project as-is"},{"key":"C","text":"Correct only the serial numbers"},{"key":"D","text":"Assume service can complete the documentation later"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple documentation deficiencies should be corrected systematically before turnover and used to improve future project execution.'
);

create temporary table _seed_ci_documentation_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_documentation_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a documentation governance process?',
  '[{"key":"A","text":"To define how project information is created, approved, updated, controlled, retained, and used across the organization"},{"key":"B","text":"To reduce documentation to the smallest possible amount"},{"key":"C","text":"To make every employee use personal documentation methods"},{"key":"D","text":"To eliminate project communication"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation governance establishes consistent rules for how business-critical information is managed throughout its lifecycle.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is documentation consistency strategically important across departments?',
  '[{"key":"A","text":"It improves handoffs, accountability, reporting, serviceability, operational continuity, and decision quality"},{"key":"B","text":"It guarantees projects never change"},{"key":"C","text":"It removes the need for leadership review"},{"key":"D","text":"It only improves file appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent documentation enables different departments to rely on the same information and reduces operational friction.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest indicator of a mature documentation system?',
  '[{"key":"A","text":"Records are current, accurate, standardized, traceable, accessible to authorized users, and integrated into normal workflow"},{"key":"B","text":"The company has many files"},{"key":"C","text":"Only managers can create documentation"},{"key":"D","text":"Most documentation is completed at year-end"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature documentation system produces reliable information as part of normal operations rather than as an afterthought.'
),
(
  4,
  'multiple_choice',
  'application',
  'An operations manager finds that sales, project management, installation, and service each maintain separate versions of the same client project information. What is the BEST improvement?',
  '[{"key":"A","text":"Define authoritative records, ownership, update responsibilities, and a controlled cross-department workflow for shared project information"},{"key":"B","text":"Allow each department to continue maintaining independent versions"},{"key":"C","text":"Delete all project records except the sales version"},{"key":"D","text":"Move every document into one folder without defining ownership"}]'::jsonb,
  '["A"]'::jsonb,
  'A shared information problem is solved by defining authoritative sources and ownership, not merely by collecting files in one location.'
),
(
  5,
  'multiple_choice',
  'application',
  'A leadership team wants to reduce project closeout delays caused by missing documentation. What is the BEST approach?',
  '[{"key":"A","text":"Define required closeout records early, assign ownership by phase, track completion during the project, and verify documentation before turnover"},{"key":"B","text":"Wait until the final project day to request all records"},{"key":"C","text":"Make service responsible for reconstructing missing records later"},{"key":"D","text":"Remove documentation requirements from closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Closeout documentation is more reliable when requirements and ownership are embedded throughout project execution.'
),
(
  6,
  'multiple_choice',
  'application',
  'A company has recurring documentation errors because employees are unsure which system contains the official information. What should leadership establish?',
  '[{"key":"A","text":"A clear system of record for each information type, including ownership, update rules, and access expectations"},{"key":"B","text":"More unofficial spreadsheets"},{"key":"C","text":"Separate systems for every employee"},{"key":"D","text":"A rule that the newest email is always authoritative"}]'::jsonb,
  '["A"]'::jsonb,
  'Defining authoritative systems reduces duplicate records and version confusion.'
),
(
  7,
  'multiple_choice',
  'application',
  'A documentation audit finds that many records are technically complete but difficult for service teams to use. What is the BEST leadership response?',
  '[{"key":"A","text":"Evaluate usability requirements with downstream users and improve documentation standards for clarity, structure, identifiers, searchability, and technical completeness"},{"key":"B","text":"Accept the records because required fields are populated"},{"key":"C","text":"Tell service teams to create their own records"},{"key":"D","text":"Reduce documentation access"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation quality includes usability by the teams that depend on it, not just completion of fields.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project has several approved scope changes. What should the documentation process ensure?',
  '[{"key":"A","text":"Each change is traceable to approval, affected scope, project records, execution status, and final closeout documentation"},{"key":"B","text":"Only the final invoice reflects the change"},{"key":"C","text":"Only field technicians know about the change"},{"key":"D","text":"The original documents remain unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'Change documentation should connect authorization, execution, and final project records.'
),
(
  9,
  'multiple_choice',
  'application',
  'A manager wants to improve accountability for missing project records. What is the BEST process change?',
  '[{"key":"A","text":"Assign explicit ownership and due points for required documentation and include visibility into completion status"},{"key":"B","text":"Ask everyone to help whenever something is missing"},{"key":"C","text":"Wait until closeout to identify ownership"},{"key":"D","text":"Make one person responsible for every document in the company"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear ownership and timing make documentation expectations measurable and actionable.'
),
(
  10,
  'multiple_choice',
  'application',
  'A company is redesigning its project documentation standards. What should determine the required information?',
  '[{"key":"A","text":"Operational needs across sales, project execution, installation, service, finance, client handoff, compliance, and future support"},{"key":"B","text":"Only what is easiest for technicians to enter"},{"key":"C","text":"Only what fits on one screen"},{"key":"D","text":"Only historical habits"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation standards should support the full operational lifecycle and the teams that depend on the information.'
),
(
  11,
  'scenario',
  'scenario',
  'A company repeatedly loses project knowledge when experienced technicians leave because key information lives in personal notes, texts, and memory. What is the BEST leadership response?',
  '[{"key":"A","text":"Identify critical knowledge, move it into controlled shared records, define documentation expectations, and embed capture into the normal workflow"},{"key":"B","text":"Ask departing technicians to remember everything during an exit interview"},{"key":"C","text":"Allow personal notes to remain the primary system"},{"key":"D","text":"Stop documenting technician knowledge"}]'::jsonb,
  '["A"]'::jsonb,
  'Operational knowledge should belong to the organization through accessible controlled records rather than depend on individual memory.'
),
(
  12,
  'scenario',
  'scenario',
  'An executive review finds project status reports consistently show jobs as nearly complete while field records reveal major unfinished work. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the reporting logic with actual field completion criteria, correct current status, define authoritative data sources, and strengthen verification before status rolls up to leadership"},{"key":"B","text":"Continue using the reports because they are easier to read"},{"key":"C","text":"Stop reporting project status"},{"key":"D","text":"Ask field teams to mark more work complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Leadership reporting must be grounded in accurate operational records and shared definitions of completion.'
),
(
  13,
  'scenario',
  'scenario',
  'A client requests documentation six months after project completion, but the company cannot quickly locate final drawings, equipment records, or test results. What is the BEST systemic correction?',
  '[{"key":"A","text":"Establish standardized closeout packages, retention rules, storage locations, ownership, and verification before project closure"},{"key":"B","text":"Search employee laptops each time a client asks"},{"key":"C","text":"Tell clients documentation is unavailable after turnover"},{"key":"D","text":"Store future files without naming standards"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable closeout documentation requires a repeatable retention and ownership process.'
),
(
  14,
  'scenario',
  'scenario',
  'A company has frequent disputes over whether requested changes were approved because approvals are scattered across texts, emails, and verbal conversations. What is the BEST process improvement?',
  '[{"key":"A","text":"Create a controlled change-record process that captures request, approval status, scope impact, owner, execution status, and resulting documentation"},{"key":"B","text":"Continue using whichever communication method is convenient"},{"key":"C","text":"Allow field teams to interpret verbal requests independently"},{"key":"D","text":"Document changes only after invoicing"}]'::jsonb,
  '["A"]'::jsonb,
  'A controlled change process creates traceability and reduces ambiguity about authorization and scope.'
),
(
  15,
  'scenario',
  'scenario',
  'Service technicians repeatedly spend hours rediscovering system information that should have been captured during installation. What is the BEST leadership response?',
  '[{"key":"A","text":"Identify the missing service-critical information, add it to installation and closeout standards, assign ownership, and verify its capture before turnover"},{"key":"B","text":"Accept the extra troubleshooting time as unavoidable"},{"key":"C","text":"Ask service to maintain separate unofficial records"},{"key":"D","text":"Reduce the information given to service"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring service inefficiency should feed back into project documentation requirements.'
),
(
  16,
  'scenario',
  'scenario',
  'A company uses three systems for project information and employees frequently update the wrong one. What is the BEST leadership action?',
  '[{"key":"A","text":"Map what information belongs in each system, define authoritative sources and integration or handoff rules, train users, and eliminate unnecessary duplicate entry where possible"},{"key":"B","text":"Add a fourth system"},{"key":"C","text":"Let each department choose independently"},{"key":"D","text":"Require employees to update all systems manually without defining ownership"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple systems can work when information ownership and workflow are clearly defined.'
),
(
  17,
  'scenario',
  'scenario',
  'An audit shows field teams often complete required documentation only after reminders from project managers. What is the BEST long-term improvement?',
  '[{"key":"A","text":"Integrate documentation tasks into the workflow with clear triggers, ownership, completion criteria, visibility, and coaching instead of relying on memory and reminders"},{"key":"B","text":"Send more random reminders"},{"key":"C","text":"Remove documentation requirements"},{"key":"D","text":"Have project managers complete all field documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable process embeds documentation into work rather than depending on individual memory.'
),
(
  18,
  'scenario',
  'scenario',
  'A large project reaches closeout with inconsistent serial numbers, missing test records, outdated drawings, incomplete photos, and unresolved punch items. What is the BEST leadership response?',
  '[{"key":"A","text":"Create a structured recovery plan by documentation category and owner, verify missing information against field conditions, resolve open items, and identify process failures for correction"},{"key":"B","text":"Submit the available files immediately"},{"key":"C","text":"Correct only the drawings"},{"key":"D","text":"Transfer all missing documentation responsibility to service"}]'::jsonb,
  '["A"]'::jsonb,
  'A broad closeout failure requires coordinated recovery and process improvement rather than isolated corrections.'
),
(
  19,
  'scenario',
  'scenario',
  'A manager notices repeated client complaints because promised features discussed during sales are not consistently documented for project teams. What is the BEST response?',
  '[{"key":"A","text":"Strengthen the sales-to-project handoff so approved client expectations, scope details, exclusions, decisions, and commitments are captured in controlled records"},{"key":"B","text":"Ask installers to rely on client memory"},{"key":"C","text":"Tell sales to use more verbal communication"},{"key":"D","text":"Remove project managers from the handoff"}]'::jsonb,
  '["A"]'::jsonb,
  'Documentation should preserve important commitments as work moves between departments.'
),
(
  20,
  'scenario',
  'scenario',
  'Leadership identifies recurring rework, billing disputes, service delays, and missed commitments that all trace back to poor documentation. What is the BEST organization-wide response?',
  '[{"key":"A","text":"Treat documentation as an operational system: define standards, systems of record, ownership, workflow triggers, change control, quality checks, handoffs, retention, training, and measurable compliance"},{"key":"B","text":"Create one additional form"},{"key":"C","text":"Ask employees to take better notes without changing the process"},{"key":"D","text":"Focus only on closeout documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'When documentation failures affect multiple business outcomes, the solution must address the full operating system rather than a single form or department.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'e50dfd1b-dc8f-4873-bd28-3da156d7e009';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l3_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
  v_l4_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
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
      and c.name = 'Documentation'
      and c.is_current = true
  ) then
    raise exception 'Current Documentation Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 Documentation requirement not found';
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
    raise exception 'Current Technician II — Experienced L2 Documentation requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L3 Documentation requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Service Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Service Technician L4 Documentation requirement not found';
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
  v_assessment_name := 'Documentation — Level 1 Competency Assessment';

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
    select * from _seed_ci_documentation_l1_questions
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
        'Documentation',
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
      'IntegrateU Documentation L1 production assessment v1.0.',
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
        'Documentation',
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
        'IntegrateU Documentation L1 production assessment v1.0.',
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
  v_assessment_name := 'Documentation — Level 2 Competency Assessment';

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
    select * from _seed_ci_documentation_l2_questions
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
        'Documentation',
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
      'IntegrateU Documentation L2 production assessment v1.0.',
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
        'Documentation',
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
        'IntegrateU Documentation L2 production assessment v1.0.',
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
  v_assessment_name := 'Documentation — Level 3 Competency Assessment';

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
    select * from _seed_ci_documentation_l3_questions
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
        'Documentation',
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
      'IntegrateU Documentation L3 production assessment v1.0.',
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
        'Documentation',
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
        'IntegrateU Documentation L3 production assessment v1.0.',
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
  v_assessment_name := 'Documentation — Level 4 Competency Assessment';

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
    select * from _seed_ci_documentation_l4_questions
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
        'Documentation',
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
      'IntegrateU Documentation L4 production assessment v1.0.',
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
        'Documentation',
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
        'IntegrateU Documentation L4 production assessment v1.0.',
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
