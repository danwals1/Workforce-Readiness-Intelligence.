-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0152_ci_blueprint_drawing_reading_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Blueprint / Drawing Reading
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Logistics Manager   -> Level 1
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

create temporary table _seed_ci_blueprint_drawing_reading_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_blueprint_drawing_reading_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is a floor plan primarily used to show?',
  '[{"key":"A","text":"A top-down representation of spaces and the locations of project elements"},{"key":"B","text":"Only rack wiring"},{"key":"C","text":"Employee schedules"},{"key":"D","text":"Manufacturer warranty information"}]'::jsonb,
  '["A"]'::jsonb,
  'A floor plan provides a top-down view that helps technicians understand spaces and locate project elements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Which drawing commonly shows the planned locations of ceiling-mounted speakers, sensors, and other ceiling devices?',
  '[{"key":"A","text":"Reflected ceiling plan"},{"key":"B","text":"Purchase order"},{"key":"C","text":"Equipment warranty"},{"key":"D","text":"Employee time sheet"}]'::jsonb,
  '["A"]'::jsonb,
  'A reflected ceiling plan commonly communicates ceiling-mounted elements and their locations.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a drawing legend or key?',
  '[{"key":"A","text":"To define symbols, abbreviations, and other drawing conventions"},{"key":"B","text":"To list employee responsibilities"},{"key":"C","text":"To replace all dimensions"},{"key":"D","text":"To show project billing"}]'::jsonb,
  '["A"]'::jsonb,
  'The legend or key helps the reader interpret symbols and abbreviations used on the drawings.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary value of a wiring or connection diagram?',
  '[{"key":"A","text":"It shows how system components and connections are intended to relate to one another"},{"key":"B","text":"It determines employee compensation"},{"key":"C","text":"It shows only architectural dimensions"},{"key":"D","text":"It replaces manufacturer documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Wiring and connection diagrams communicate intended relationships between components and connections.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What does a drawing dimension communicate?',
  '[{"key":"A","text":"A measured distance, size, or location relationship"},{"key":"B","text":"The equipment warranty period"},{"key":"C","text":"The project profit margin"},{"key":"D","text":"The technician skill level"}]'::jsonb,
  '["A"]'::jsonb,
  'Dimensions communicate measured information used to locate, size, or position project elements.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is an elevation drawing primarily used to communicate?',
  '[{"key":"A","text":"A vertical view of a wall, surface, equipment arrangement, or installed element"},{"key":"B","text":"Only cable test results"},{"key":"C","text":"A project invoice"},{"key":"D","text":"Only the building roof"}]'::jsonb,
  '["A"]'::jsonb,
  'Elevations help show vertical placement, arrangement, dimensions, and relationships not easily communicated on a floor plan.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is the drawing title block important?',
  '[{"key":"A","text":"It commonly identifies information such as the drawing title, number, project, date, or revision"},{"key":"B","text":"It contains only client payment information"},{"key":"C","text":"It replaces the drawing legend"},{"key":"D","text":"It identifies only the installer"}]'::jsonb,
  '["A"]'::jsonb,
  'The title block helps identify and manage the specific drawing being used.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What does drawing scale help a technician understand?',
  '[{"key":"A","text":"The relationship between dimensions shown on the drawing and the represented real-world size"},{"key":"B","text":"The weight of installed equipment"},{"key":"C","text":"The network speed"},{"key":"D","text":"The project labor rate"}]'::jsonb,
  '["A"]'::jsonb,
  'Scale defines how the drawing representation relates to actual physical dimensions.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician encounters an unfamiliar symbol on a project drawing. What is the BEST first action?',
  '[{"key":"A","text":"Check the drawing legend or key and applicable project documentation"},{"key":"B","text":"Guess based on the room type"},{"key":"C","text":"Ignore the symbol"},{"key":"D","text":"Install the most common device"}]'::jsonb,
  '["A"]'::jsonb,
  'Symbols and abbreviations should be verified from the project documentation rather than guessed.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician needs to determine the specified mounting height of a wall device. What should be checked?',
  '[{"key":"A","text":"The applicable drawing, elevation, detail, schedule, note, or other approved project documentation"},{"key":"B","text":"Only the height used on the last project"},{"key":"C","text":"Only nearby furniture"},{"key":"D","text":"The technician personal preference"}]'::jsonb,
  '["A"]'::jsonb,
  'Mounting heights should come from approved project requirements rather than habit or visual estimation.'
),
(
  11,
  'multiple_choice',
  'application',
  'A device tag on a floor plan refers to a device schedule. What should the technician do?',
  '[{"key":"A","text":"Use the tag to locate the corresponding schedule entry and verify the device information"},{"key":"B","text":"Ignore the schedule"},{"key":"C","text":"Assume all devices with similar symbols are identical"},{"key":"D","text":"Use the nearest device in inventory"}]'::jsonb,
  '["A"]'::jsonb,
  'Tags and schedules work together to provide information that may not fit directly on the drawing.'
),
(
  12,
  'multiple_choice',
  'application',
  'Two drawing sheets provide different types of information about the same room. What is the BEST approach?',
  '[{"key":"A","text":"Read the applicable sheets together and use their references, notes, and details to understand the complete requirement"},{"key":"B","text":"Use only the first sheet opened"},{"key":"C","text":"Choose whichever requires less work"},{"key":"D","text":"Ignore all cross-references"}]'::jsonb,
  '["A"]'::jsonb,
  'Project requirements are often distributed across plans, elevations, details, schedules, and notes.'
),
(
  13,
  'multiple_choice',
  'application',
  'A floor plan references Detail 3 on another sheet. What should the technician do?',
  '[{"key":"A","text":"Locate and review the referenced detail before completing the affected work"},{"key":"B","text":"Ignore the reference if the floor plan looks clear"},{"key":"C","text":"Use a detail from another project"},{"key":"D","text":"Ask another trade to interpret it"}]'::jsonb,
  '["A"]'::jsonb,
  'Drawing references direct the reader to additional information required to understand the installation.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician is reviewing a drawing that has several revision entries. What should be verified before using it?',
  '[{"key":"A","text":"That the drawing is the current approved revision for the work being performed"},{"key":"B","text":"Only that the drawing is printed in color"},{"key":"C","text":"Only that the technician has used it before"},{"key":"D","text":"Only the original issue date"}]'::jsonb,
  '["A"]'::jsonb,
  'Using the current approved revision reduces the risk of installing from superseded information.'
),
(
  15,
  'multiple_choice',
  'application',
  'A wiring diagram shows a source device connected through an intermediate component before reaching the destination. What should the technician understand?',
  '[{"key":"A","text":"The documented signal or connection path includes the intermediate component"},{"key":"B","text":"The intermediate component can be omitted"},{"key":"C","text":"The drawing shows only physical room locations"},{"key":"D","text":"Connection order never matters"}]'::jsonb,
  '["A"]'::jsonb,
  'Connection diagrams communicate the intended relationship and path between system components.'
),
(
  16,
  'multiple_choice',
  'application',
  'A note on a drawing applies to several device locations. What should the technician do?',
  '[{"key":"A","text":"Apply the note to every location within its stated scope"},{"key":"B","text":"Apply it only to the closest device"},{"key":"C","text":"Ignore notes unless repeated at every device"},{"key":"D","text":"Apply it only if another technician mentions it"}]'::jsonb,
  '["A"]'::jsonb,
  'Drawing notes must be interpreted according to the scope indicated by the documentation.'
),
(
  17,
  'scenario',
  'scenario',
  'A drawing shows a wall device at a specific location, but an unexpected structural condition occupies that space in the field. What is the BEST response?',
  '[{"key":"A","text":"Document and communicate the discrepancy through the established project process and obtain direction before changing the location"},{"key":"B","text":"Move the device wherever it fits"},{"key":"C","text":"Skip the device"},{"key":"D","text":"Modify the structural condition"}]'::jsonb,
  '["A"]'::jsonb,
  'Field conflicts should be documented and resolved through the approved project process rather than through unauthorized design changes.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician is preparing to install a wall device but finds two different mounting heights shown in separate project documents. What is the BEST action?',
  '[{"key":"A","text":"Stop the affected work, identify the conflict, and obtain clarification through the approved project process"},{"key":"B","text":"Use the lower height"},{"key":"C","text":"Use the height from the oldest document"},{"key":"D","text":"Average the two heights"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting project requirements should be resolved before permanent installation proceeds.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician receives a printed drawing from an older project meeting, while the project file contains a newer revision. What is the BEST action?',
  '[{"key":"A","text":"Verify and use the current approved revision and remove or clearly identify the superseded copy from active use"},{"key":"B","text":"Use whichever drawing is easier to read"},{"key":"C","text":"Use the printed copy because it was received first"},{"key":"D","text":"Combine details from both without verification"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision control prevents work from being performed using outdated project information.'
),
(
  20,
  'scenario',
  'scenario',
  'A device symbol appears on the floor plan, but the technician cannot find enough information to determine the exact device or installation requirement. What is the BEST response?',
  '[{"key":"A","text":"Review the legend, schedules, notes, details, cross-references, and other applicable project documents before requesting clarification if information is still missing"},{"key":"B","text":"Install the most common device used by the company"},{"key":"C","text":"Ignore the symbol"},{"key":"D","text":"Choose the least expensive device"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should use the complete drawing set and supporting documentation before concluding that information is missing.'
);

create temporary table _seed_ci_blueprint_drawing_reading_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_blueprint_drawing_reading_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of a drawing detail?',
  '[{"key":"A","text":"To provide an enlarged or more specific view of a particular construction or installation condition"},{"key":"B","text":"To show employee schedules"},{"key":"C","text":"To replace the entire drawing set"},{"key":"D","text":"To list project invoices"}]'::jsonb,
  '["A"]'::jsonb,
  'Details provide additional information about specific conditions that cannot be fully communicated on the main plan.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a device or equipment schedule?',
  '[{"key":"A","text":"To organize repeated project information such as tags, types, models, locations, or requirements"},{"key":"B","text":"To show only building dimensions"},{"key":"C","text":"To replace every drawing note"},{"key":"D","text":"To document employee time"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedules organize information that applies to multiple tagged devices or equipment items.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why are drawing revisions tracked?',
  '[{"key":"A","text":"To identify changes and help ensure teams are working from current approved information"},{"key":"B","text":"To increase drawing scale"},{"key":"C","text":"To identify technician skill level"},{"key":"D","text":"To change device warranties"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision tracking helps distinguish current requirements from superseded project information.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does a section drawing commonly show?',
  '[{"key":"A","text":"A cut-through view that reveals vertical or internal relationships not visible on a plan"},{"key":"B","text":"Only equipment pricing"},{"key":"C","text":"Only cable labels"},{"key":"D","text":"Only project milestones"}]'::jsonb,
  '["A"]'::jsonb,
  'Section views help explain vertical relationships, construction depth, and concealed conditions.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a general note on a drawing set?',
  '[{"key":"A","text":"A requirement or instruction that may apply broadly to the project or a defined portion of the work"},{"key":"B","text":"A personal note from the installer"},{"key":"C","text":"A billing reminder"},{"key":"D","text":"A substitute for all project specifications"}]'::jsonb,
  '["A"]'::jsonb,
  'General notes communicate requirements that may apply beyond one individual drawing symbol or location.'
),
(
  6,
  'multiple_choice',
  'application',
  'A floor plan shows a device tag but the exact model is not identified on the plan. What should the technician do?',
  '[{"key":"A","text":"Use the tag to locate the matching device schedule, specification, or referenced documentation"},{"key":"B","text":"Install the most common model"},{"key":"C","text":"Ignore the tag"},{"key":"D","text":"Select the least expensive model"}]'::jsonb,
  '["A"]'::jsonb,
  'Tagged information is often completed through schedules, specifications, or other referenced documents.'
),
(
  7,
  'multiple_choice',
  'application',
  'A reflected ceiling plan and a wall elevation both show information for the same room. How should they be used?',
  '[{"key":"A","text":"Together, because each view may communicate different location and installation requirements"},{"key":"B","text":"Use only the reflected ceiling plan"},{"key":"C","text":"Use only the elevation"},{"key":"D","text":"Choose whichever drawing is newer without checking revisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Different drawing views often provide complementary information needed to understand the complete installation.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician sees a keyed note symbol beside several devices. What should happen?',
  '[{"key":"A","text":"Locate the corresponding keyed note and apply it to the devices within its indicated scope"},{"key":"B","text":"Ignore it unless the note is repeated in text beside each device"},{"key":"C","text":"Apply it only to the nearest device"},{"key":"D","text":"Assume it is an architectural note only"}]'::jsonb,
  '["A"]'::jsonb,
  'Keyed notes connect symbols or references on the drawing to specific instructions elsewhere on the sheet.'
),
(
  9,
  'multiple_choice',
  'application',
  'A plan shows a device location dimensioned from a finished wall. Why is that reference important?',
  '[{"key":"A","text":"The technician must understand the stated reference point before laying out the location"},{"key":"B","text":"All dimensions can be estimated visually"},{"key":"C","text":"Finished-wall dimensions are only for architects"},{"key":"D","text":"The dimension can be taken from any nearby object"}]'::jsonb,
  '["A"]'::jsonb,
  'Dimensions are meaningful only when the reader uses the correct reference points and drawing conventions.'
),
(
  10,
  'multiple_choice',
  'application',
  'A device schedule lists multiple device types with similar symbols. What is the BEST way to avoid installing the wrong one?',
  '[{"key":"A","text":"Match the drawing tag or identifier to the correct schedule entry and verify associated notes or specifications"},{"key":"B","text":"Use whichever device looks similar"},{"key":"C","text":"Use device color as the identifier"},{"key":"D","text":"Ignore the schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Tags and schedules should be cross-checked so the installed device matches the documented requirement.'
),
(
  11,
  'multiple_choice',
  'application',
  'A drawing references a mounting detail on another sheet. When should the detail be reviewed?',
  '[{"key":"A","text":"Before the affected installation is completed"},{"key":"B","text":"Only after the device is mounted"},{"key":"C","text":"Only if the client complains"},{"key":"D","text":"Only during final billing"}]'::jsonb,
  '["A"]'::jsonb,
  'Referenced details should be reviewed before execution because they may contain required mounting, dimensional, or coordination information.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician notices that a device location on the drawing conflicts with a door swing shown on the architectural plan. What is the BEST response?',
  '[{"key":"A","text":"Identify and communicate the coordination conflict before installation and obtain approved direction"},{"key":"B","text":"Install the device anyway"},{"key":"C","text":"Move the door"},{"key":"D","text":"Choose a new device location independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Coordination conflicts between drawing disciplines should be resolved before permanent work proceeds.'
),
(
  13,
  'multiple_choice',
  'application',
  'A project sheet has several revision clouds. What should the technician do?',
  '[{"key":"A","text":"Review the associated revision information and determine whether the changes affect the planned work"},{"key":"B","text":"Ignore the clouds because they are decorative"},{"key":"C","text":"Review only the title block"},{"key":"D","text":"Assume every cloud applies to every room"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision clouds call attention to changed areas that should be reviewed in context with the revision record.'
),
(
  14,
  'multiple_choice',
  'application',
  'A wiring diagram and rack elevation appear to disagree about where a component is installed. What should the technician do?',
  '[{"key":"A","text":"Verify the current documents, identify the discrepancy, and obtain clarification before changing the installation"},{"key":"B","text":"Follow whichever drawing requires less work"},{"key":"C","text":"Use only the rack elevation"},{"key":"D","text":"Use only the wiring diagram"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicts between project documents should be resolved rather than guessed through.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is roughing in device locations from a printed plan. Midway through the work, the technician learns that a newer revision changed several locations. What is the BEST response?',
  '[{"key":"A","text":"Stop affected work, compare completed and pending locations to the current revision, communicate impacts, and correct work as directed"},{"key":"B","text":"Finish the old plan first"},{"key":"C","text":"Ignore the revision because rough-in already started"},{"key":"D","text":"Move only the easiest locations"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision changes should trigger controlled review of both completed and remaining work.'
),
(
  16,
  'scenario',
  'scenario',
  'A wall elevation shows a device at 48 inches, but the plan note says 42 inches. What is the BEST action?',
  '[{"key":"A","text":"Treat the difference as a documentation conflict and obtain clarification before installation"},{"key":"B","text":"Average the two dimensions"},{"key":"C","text":"Use whichever dimension is more convenient"},{"key":"D","text":"Use the higher dimension automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting dimensions should be resolved through the approved project process before permanent work.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician finds a device symbol on the plan but no matching entry in the device schedule. What is the BEST response?',
  '[{"key":"A","text":"Review the complete drawing set, notes, specifications, and revisions, then request clarification if the requirement remains unresolved"},{"key":"B","text":"Install a generic device"},{"key":"C","text":"Ignore the location"},{"key":"D","text":"Copy a device from the nearest room"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing or inconsistent documentation should be researched across the full project set before being escalated.'
),
(
  18,
  'scenario',
  'scenario',
  'A drawing detail indicates one mounting condition, but the actual wall construction differs from what is shown. What should the technician do?',
  '[{"key":"A","text":"Document the field condition and obtain approved direction before adapting the detail"},{"key":"B","text":"Force the documented detail to fit"},{"key":"C","text":"Ignore the detail"},{"key":"D","text":"Create a new mounting method without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Field conditions that invalidate a documented detail should be resolved before installation continues.'
),
(
  19,
  'scenario',
  'scenario',
  'A project manager asks whether a recent drawing revision changes labor or material needs. What is the BEST approach?',
  '[{"key":"A","text":"Compare the revised documents to the prior approved set and identify changes in locations, quantities, devices, pathways, or installation requirements"},{"key":"B","text":"Answer based on memory"},{"key":"C","text":"Review only the revision date"},{"key":"D","text":"Assume revisions never affect labor"}]'::jsonb,
  '["A"]'::jsonb,
  'Evaluating revision impact requires comparing the changed requirements against the prior approved scope.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician sees that a drawing note conflicts with a manufacturer requirement for the specified equipment. What is the BEST response?',
  '[{"key":"A","text":"Identify the conflict and obtain technical or project clarification before proceeding"},{"key":"B","text":"Ignore the manufacturer requirement"},{"key":"C","text":"Ignore the drawing note"},{"key":"D","text":"Choose whichever requirement is easier"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting technical requirements should be resolved through the proper project process rather than selected arbitrarily.'
);

create temporary table _seed_ci_blueprint_drawing_reading_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_blueprint_drawing_reading_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is drawing coordination across disciplines important on an integration project?',
  '[{"key":"A","text":"Different drawing sets may contain related architectural, electrical, structural, mechanical, and low-voltage requirements that affect the same installation"},{"key":"B","text":"Only the low-voltage drawings matter"},{"key":"C","text":"Coordination is required only after installation"},{"key":"D","text":"Each discipline always works independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Integration work often depends on conditions and requirements shown across multiple drawing disciplines.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of comparing an as-built condition to the original design documents?',
  '[{"key":"A","text":"To document how the completed installation differs from or confirms the planned design"},{"key":"B","text":"To replace all test reports"},{"key":"C","text":"To eliminate revision control"},{"key":"D","text":"To determine technician compensation"}]'::jsonb,
  '["A"]'::jsonb,
  'As-built documentation should accurately reflect the verified installed condition.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a lead technician understand drawing hierarchy and references?',
  '[{"key":"A","text":"Because plans, elevations, sections, details, schedules, notes, and specifications may collectively define one installation requirement"},{"key":"B","text":"Because only floor plans contain useful information"},{"key":"C","text":"Because references can always be ignored"},{"key":"D","text":"Because drawings never conflict"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete requirement may be distributed across multiple coordinated project documents.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of documenting a field discrepancy against the drawings?',
  '[{"key":"A","text":"To create a clear record that supports technical review, project communication, resolution, and future documentation"},{"key":"B","text":"To blame another trade"},{"key":"C","text":"To avoid completing the work"},{"key":"D","text":"To replace the drawing set"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear discrepancy documentation supports controlled decisions and accurate project records.'
),
(
  5,
  'multiple_choice',
  'application',
  'A device layout appears workable on the low-voltage plan but conflicts with cabinetry shown on the architectural elevations. What should the lead technician do?',
  '[{"key":"A","text":"Treat it as a coordination issue, verify the current documents, and obtain approved direction before installation"},{"key":"B","text":"Follow only the low-voltage plan"},{"key":"C","text":"Ignore the cabinetry"},{"key":"D","text":"Move the device independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-discipline conflicts should be resolved before permanent installation proceeds.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician asks whether a drawing revision changes only device locations or also affects cabling and labor. What is the BEST response?',
  '[{"key":"A","text":"Compare the revised documents to the prior approved set and evaluate downstream impacts on devices, pathways, cabling, quantities, labor, and sequencing"},{"key":"B","text":"Review only the revision date"},{"key":"C","text":"Assume location changes never affect labor"},{"key":"D","text":"Review only the title block"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision impact should be evaluated across all dependent installation requirements.'
),
(
  7,
  'multiple_choice',
  'application',
  'A rack elevation shows equipment positions that do not match the latest equipment schedule. What should the lead technician do?',
  '[{"key":"A","text":"Verify the current versions, identify the inconsistency, and obtain clarification before final rack assembly"},{"key":"B","text":"Use whichever document was printed first"},{"key":"C","text":"Choose the arrangement that looks best"},{"key":"D","text":"Ignore the equipment schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting project documents should be reconciled before equipment is installed.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project detail applies only when a specific wall type is present. What should the technician verify before using the detail?',
  '[{"key":"A","text":"That the actual field condition matches the condition for which the detail is intended"},{"key":"B","text":"Only that the detail is on the current sheet"},{"key":"C","text":"Only that the device model is correct"},{"key":"D","text":"Nothing if the detail looks familiar"}]'::jsonb,
  '["A"]'::jsonb,
  'A detail should be applied only when the field condition matches its documented intent.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project contains several similarly named drawing files. What is the BEST way to control which one the team uses?',
  '[{"key":"A","text":"Use the project document-control process to verify current approved sheet numbers, revision identifiers, and issue status"},{"key":"B","text":"Use the largest file"},{"key":"C","text":"Use the file with the shortest name"},{"key":"D","text":"Let each technician choose"}]'::jsonb,
  '["A"]'::jsonb,
  'Document control reduces the risk of field work being performed from obsolete or unapproved information.'
),
(
  10,
  'multiple_choice',
  'application',
  'A drawing shows a cable pathway passing through a room where another discipline has added equipment. What should be evaluated?',
  '[{"key":"A","text":"Whether the revised field condition affects route feasibility, access, separation, support, or other project requirements"},{"key":"B","text":"Only whether the cable is long enough"},{"key":"C","text":"Only the device labels"},{"key":"D","text":"Nothing if the original route was approved"}]'::jsonb,
  '["A"]'::jsonb,
  'Field and drawing changes can affect the feasibility and compliance of planned pathways.'
),
(
  11,
  'multiple_choice',
  'application',
  'A lead technician is preparing a field team for a complex installation. What is the BEST drawing-review approach?',
  '[{"key":"A","text":"Identify the relevant plans, details, elevations, schedules, notes, revisions, dependencies, and known conflicts before work begins"},{"key":"B","text":"Review only the floor plan"},{"key":"C","text":"Let each technician interpret the drawings independently"},{"key":"D","text":"Wait for field problems before reviewing details"}]'::jsonb,
  '["A"]'::jsonb,
  'Pre-installation drawing review helps the team understand requirements and identify coordination risks before work starts.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician discovers that several installed devices match an older revision but not the current approved drawing. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Stop affected work, determine the extent of the revision mismatch, document completed conditions, communicate impacts, and correct work according to approved direction"},{"key":"B","text":"Leave the devices because they are already installed"},{"key":"C","text":"Change only the easiest locations"},{"key":"D","text":"Hide the older drawings"}]'::jsonb,
  '["A"]'::jsonb,
  'A revision-control failure requires evaluation of all affected work and controlled corrective action.'
),
(
  13,
  'scenario',
  'scenario',
  'A wall elevation, reflected ceiling plan, and architectural plan all show related device conditions, but one location appears impossible in the field. What is the BEST approach?',
  '[{"key":"A","text":"Review all related documents and field conditions together, document the conflict, and obtain coordinated direction before installation"},{"key":"B","text":"Follow only the low-voltage drawing"},{"key":"C","text":"Pick the nearest open location"},{"key":"D","text":"Skip the device"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex field conflicts should be evaluated using the complete coordinated document set.'
),
(
  14,
  'scenario',
  'scenario',
  'A project manager asks the lead technician to estimate the impact of a drawing revision that adds devices in three rooms. What is the BEST method?',
  '[{"key":"A","text":"Compare old and new documents and evaluate device quantities, cable routes, hardware, labor, programming, coordination, and schedule effects"},{"key":"B","text":"Count only the added device symbols"},{"key":"C","text":"Estimate from memory"},{"key":"D","text":"Assume only material cost changes"}]'::jsonb,
  '["A"]'::jsonb,
  'A design revision can have downstream impacts beyond the directly visible device count.'
),
(
  15,
  'scenario',
  'scenario',
  'A drawing detail calls for a mounting method that cannot be used because of a verified structural condition in the field. What should the lead technician do?',
  '[{"key":"A","text":"Document the condition, communicate the issue, and obtain an approved alternate detail or method before proceeding"},{"key":"B","text":"Invent a field solution without approval"},{"key":"C","text":"Force the documented method to fit"},{"key":"D","text":"Remove the device from scope"}]'::jsonb,
  '["A"]'::jsonb,
  'When a documented detail cannot be executed as designed, the alternate method should be technically reviewed and approved.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician reports that a device schedule, floor plan, and specification use slightly different descriptions for what appears to be the same device. What is the BEST response?',
  '[{"key":"A","text":"Cross-reference the identifiers, current revisions, notes, and specifications and obtain clarification if the intended requirement remains ambiguous"},{"key":"B","text":"Choose the description that sounds most familiar"},{"key":"C","text":"Use whichever device is in stock"},{"key":"D","text":"Ignore the specification"}]'::jsonb,
  '["A"]'::jsonb,
  'Apparent naming inconsistencies should be reconciled through the project documentation rather than assumed equivalent.'
),
(
  17,
  'scenario',
  'scenario',
  'During installation, another trade relocates equipment that blocks several documented low-voltage pathways. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Document the new condition, evaluate affected routes and dependencies, coordinate the issue through the project process, and update installation direction before proceeding"},{"key":"B","text":"Route cables anywhere they fit"},{"key":"C","text":"Move the other trade equipment"},{"key":"D","text":"Ignore the original drawings"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes by other trades can invalidate documented pathways and should be resolved through coordinated project communication.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician marks up field changes on a personal printed drawing but does not transfer the information to the project record. What is the BEST response?',
  '[{"key":"A","text":"Capture the verified changes in the approved project documentation or as-built process so the information is preserved for the team and future service"},{"key":"B","text":"Keep only the personal marked-up copy"},{"key":"C","text":"Discard the changes after installation"},{"key":"D","text":"Rely on the technician to remember them"}]'::jsonb,
  '["A"]'::jsonb,
  'Field changes must be incorporated into the controlled project record to remain useful after the individual technician leaves the site.'
),
(
  19,
  'scenario',
  'scenario',
  'A project has several drawing conflicts that are causing repeated field questions and delays. What is the BEST leadership response?',
  '[{"key":"A","text":"Consolidate the known conflicts, obtain coordinated resolutions, communicate the approved answers to the team, and ensure current documentation reflects them"},{"key":"B","text":"Answer each technician separately without documenting anything"},{"key":"C","text":"Let every crew decide independently"},{"key":"D","text":"Stop reviewing drawings"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring drawing ambiguity should be resolved systematically so the field team works from consistent information.'
),
(
  20,
  'scenario',
  'scenario',
  'Closeout begins and the installed system differs from the original drawings because of multiple approved field changes. What is the BEST action?',
  '[{"key":"A","text":"Reconcile the approved changes with the installed condition and update the as-built documentation before final closeout"},{"key":"B","text":"Submit the original drawings unchanged"},{"key":"C","text":"Document only the largest changes"},{"key":"D","text":"Rely on service technicians to discover differences later"}]'::jsonb,
  '["A"]'::jsonb,
  'As-built documentation should reflect the verified final installation, including approved field changes.'
);

create temporary table _seed_ci_blueprint_drawing_reading_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_blueprint_drawing_reading_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the strongest purpose of a coordinated drawing-review process before complex project execution?',
  '[{"key":"A","text":"To identify dependencies, conflicts, revisions, missing information, and installation risks before they become field rework"},{"key":"B","text":"To reduce the number of drawings used"},{"key":"C","text":"To eliminate project communication"},{"key":"D","text":"To allow each technician to interpret requirements independently"}]'::jsonb,
  '["A"]'::jsonb,
  'A coordinated drawing review helps identify design and documentation issues before they affect installation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is document control important on projects with frequent drawing changes?',
  '[{"key":"A","text":"It helps ensure teams work from the current approved information and that superseded documents are not used accidentally"},{"key":"B","text":"It makes drawings easier to print"},{"key":"C","text":"It replaces project management"},{"key":"D","text":"It eliminates the need for revisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Document control protects field execution from obsolete or unapproved information.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should final as-built documentation represent?',
  '[{"key":"A","text":"The verified final installed condition, including approved changes from the original design"},{"key":"B","text":"Only the original bid drawings"},{"key":"C","text":"Only changes visible to the client"},{"key":"D","text":"Only equipment serial numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'As-built documentation should accurately represent what was actually installed.'
),
(
  4,
  'multiple_choice',
  'application',
  'A technical lead is reviewing a large drawing set before mobilization. What is the BEST approach?',
  '[{"key":"A","text":"Identify the sheets, revisions, details, schedules, notes, discipline interfaces, known conflicts, and installation dependencies relevant to the team"},{"key":"B","text":"Review only the floor plans"},{"key":"C","text":"Wait for technicians to find issues in the field"},{"key":"D","text":"Review only equipment schedules"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex work benefits from an intentional review of all relevant project information and interfaces.'
),
(
  5,
  'multiple_choice',
  'application',
  'A revision changes several device locations after cable pathways have already been planned. What should the technical lead evaluate?',
  '[{"key":"A","text":"Device locations, pathway feasibility, cable lengths, supports, labor, hardware, coordination, programming impact, and schedule effects"},{"key":"B","text":"Only device quantities"},{"key":"C","text":"Only the revision date"},{"key":"D","text":"Only equipment cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A location change can create multiple downstream impacts beyond the visible symbol change.'
),
(
  6,
  'multiple_choice',
  'application',
  'Several recurring RFIs originate from the same ambiguous drawing detail. What is the BEST leadership response?',
  '[{"key":"A","text":"Consolidate the issue, obtain a definitive coordinated resolution, communicate it to the team, and ensure the controlled documentation reflects the answer"},{"key":"B","text":"Answer each technician separately"},{"key":"C","text":"Let each crew decide independently"},{"key":"D","text":"Ignore the ambiguity until closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated documentation ambiguity should be resolved systematically rather than answered repeatedly in isolation.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project contains separate architectural, electrical, structural, and low-voltage sets. What should the technical lead emphasize to the field team?',
  '[{"key":"A","text":"Relevant requirements may exist across disciplines and must be coordinated rather than read in isolation"},{"key":"B","text":"Only the low-voltage drawings apply"},{"key":"C","text":"Structural drawings never affect device locations"},{"key":"D","text":"Architectural drawings are only for general contractors"}]'::jsonb,
  '["A"]'::jsonb,
  'Integration work often depends on building conditions and requirements documented by other disciplines.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project manager asks whether a drawing change should trigger a change-order review. What should the technical lead provide?',
  '[{"key":"A","text":"A documented comparison of the prior and revised requirements with identified impacts to scope, labor, materials, sequencing, and coordination"},{"key":"B","text":"Only a verbal opinion"},{"key":"C","text":"Only the number of revised sheets"},{"key":"D","text":"Only the equipment cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A change-impact review should connect drawing changes to actual scope and execution consequences.'
),
(
  9,
  'multiple_choice',
  'application',
  'A team is creating as-built markups during installation. What is the BEST process?',
  '[{"key":"A","text":"Capture verified field changes consistently, reference approved changes where applicable, and transfer them into the controlled closeout documentation"},{"key":"B","text":"Allow each technician to keep personal notes only"},{"key":"C","text":"Document only major changes"},{"key":"D","text":"Wait until months after turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'As-built information should be captured consistently while project knowledge is current and preserved in the official record.'
),
(
  10,
  'multiple_choice',
  'application',
  'A field condition conflicts with both the drawing and the written specification. What should the technical lead do?',
  '[{"key":"A","text":"Document the condition, identify the conflicting requirements, and obtain coordinated technical direction before proceeding"},{"key":"B","text":"Choose whichever requirement is easier"},{"key":"C","text":"Ignore the specification"},{"key":"D","text":"Ignore the drawing"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting technical requirements should be resolved through an approved coordination process.'
),
(
  11,
  'scenario',
  'scenario',
  'A project has multiple crews working from different drawing revisions, and several device locations now conflict. What is the BEST first leadership action?',
  '[{"key":"A","text":"Stop affected work, establish the current approved document set, identify completed work impacted by obsolete revisions, and communicate one controlled basis for execution"},{"key":"B","text":"Let each crew finish the revision it started"},{"key":"C","text":"Use whichever revision has fewer changes"},{"key":"D","text":"Correct conflicts only during closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'The immediate priority is restoring document control and determining the extent of work affected by superseded information.'
),
(
  12,
  'scenario',
  'scenario',
  'A drawing revision relocates equipment into a space that conflicts with structural framing and electrical clearances. What is the BEST technical-lead response?',
  '[{"key":"A","text":"Coordinate the conflict across the affected disciplines, document the issue, and obtain an approved location or design resolution before installation"},{"key":"B","text":"Follow the newest drawing regardless of field conditions"},{"key":"C","text":"Move the equipment independently"},{"key":"D","text":"Ignore the clearance issue"}]'::jsonb,
  '["A"]'::jsonb,
  'A new revision does not eliminate the need to coordinate the design with actual building and cross-discipline conditions.'
),
(
  13,
  'scenario',
  'scenario',
  'A client requests a late device relocation verbally during construction, but no revised documentation exists. What is the BEST response?',
  '[{"key":"A","text":"Document the requested change, route it through the approved project-change process, assess its impact, and update controlled documentation before execution"},{"key":"B","text":"Move the device immediately"},{"key":"C","text":"Rely on the technician to remember the request"},{"key":"D","text":"Make the change without recording it"}]'::jsonb,
  '["A"]'::jsonb,
  'Field requests that alter documented scope should be controlled and incorporated into the project record.'
),
(
  14,
  'scenario',
  'scenario',
  'A project has dozens of approved field changes, but the closeout drawings still match the original design. What is the BEST corrective action?',
  '[{"key":"A","text":"Reconcile approved field changes with the verified installed condition and update the as-built documentation before turnover"},{"key":"B","text":"Submit the original drawings"},{"key":"C","text":"Add a note saying conditions may vary"},{"key":"D","text":"Document only changes affecting equipment rooms"}]'::jsonb,
  '["A"]'::jsonb,
  'Closeout documentation should accurately represent the final installed condition.'
),
(
  15,
  'scenario',
  'scenario',
  'A technical lead discovers that repeated installation errors stem from technicians missing keyed notes and cross-references. What is the BEST improvement plan?',
  '[{"key":"A","text":"Strengthen drawing-review training, pre-installation checks, use of legends and references, and field verification of critical notes before work begins"},{"key":"B","text":"Remove keyed notes from future drawings"},{"key":"C","text":"Tell technicians to read more carefully without changing the process"},{"key":"D","text":"Stop using details"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring documentation-reading errors should be addressed through process and competency improvement.'
),
(
  16,
  'scenario',
  'scenario',
  'A project manager asks the technical lead why a small drawing revision caused substantial rework. What is the BEST explanation?',
  '[{"key":"A","text":"The revision changed an upstream requirement that affected dependent device locations, cabling, mounting, programming, and completed work"},{"key":"B","text":"Small drawing changes cannot cause major impacts"},{"key":"C","text":"The technicians should have ignored the revision"},{"key":"D","text":"Rework is unrelated to drawings"}]'::jsonb,
  '["A"]'::jsonb,
  'A visually small document change can have large downstream effects when multiple installation elements depend on it.'
),
(
  17,
  'scenario',
  'scenario',
  'A complex project has repeated delays because field technicians cannot quickly determine which detail or schedule applies to a location. What is the BEST leadership response?',
  '[{"key":"A","text":"Improve pre-task planning by identifying applicable sheets, details, schedules, notes, and cross-references before crews begin each work area"},{"key":"B","text":"Let technicians search during installation"},{"key":"C","text":"Remove schedules from the drawing set"},{"key":"D","text":"Use only floor plans"}]'::jsonb,
  '["A"]'::jsonb,
  'Pre-task planning can reduce delays caused by fragmented project information.'
),
(
  18,
  'scenario',
  'scenario',
  'A completed installation differs from the approved drawings because field teams made several unauthorized location changes. What is the BEST leadership response?',
  '[{"key":"A","text":"Identify and document the deviations, evaluate technical and scope impacts, obtain required approvals or corrections, and address the process failure that allowed unauthorized changes"},{"key":"B","text":"Update the drawings to match without review"},{"key":"C","text":"Ignore the differences if the system works"},{"key":"D","text":"Remove the affected devices from documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Unauthorized deviations require both project-level resolution and correction of the execution process that allowed them.'
),
(
  19,
  'scenario',
  'scenario',
  'A client service team later discovers that as-built drawings omit several approved cable-route changes, making troubleshooting difficult. What is the BEST long-term correction?',
  '[{"key":"A","text":"Correct the existing records and strengthen the field-change capture and closeout verification process so future as-builts reflect verified installation conditions"},{"key":"B","text":"Tell service technicians to trace cables manually"},{"key":"C","text":"Stop using as-built drawings"},{"key":"D","text":"Document only equipment locations"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor as-built accuracy should be corrected both in the current records and in the process that produced the deficiency.'
),
(
  20,
  'scenario',
  'scenario',
  'Post-project review shows recurring rework from obsolete drawings, missed details, cross-discipline conflicts, and incomplete as-builts. What is the BEST improvement plan?',
  '[{"key":"A","text":"Strengthen document control, drawing-review standards, pre-install coordination, revision-impact review, field-change capture, team training, and closeout verification"},{"key":"B","text":"Treat each issue as unrelated"},{"key":"C","text":"Stop tracking drawing-related rework"},{"key":"D","text":"Reduce the number of drawings available to technicians"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring documentation-related failures require a coordinated improvement across document control, field execution, and closeout.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '171d873e-1bac-414b-ab97-919dd9c99341';
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
      and c.name = 'Blueprint / Drawing Reading'
      and c.is_current = true
  ) then
    raise exception 'Current Blueprint / Drawing Reading Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 Blueprint / Drawing Reading requirement not found';
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
    raise exception 'Current Logistics Manager L2 Blueprint / Drawing Reading requirement not found';
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
    raise exception 'Current Technician II — Experienced L3 Blueprint / Drawing Reading requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Blueprint / Drawing Reading requirement not found';
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
  v_assessment_name := 'Blueprint / Drawing Reading — Level 1 Competency Assessment';

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
    select * from _seed_ci_blueprint_drawing_reading_l1_questions
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
        'Blueprint / Drawing Reading',
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
      'IntegrateU Blueprint / Drawing Reading L1 production assessment v1.0.',
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
        'Blueprint / Drawing Reading',
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
        'IntegrateU Blueprint / Drawing Reading L1 production assessment v1.0.',
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
  v_assessment_name := 'Blueprint / Drawing Reading — Level 2 Competency Assessment';

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
    select * from _seed_ci_blueprint_drawing_reading_l2_questions
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
        'Blueprint / Drawing Reading',
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
      'IntegrateU Blueprint / Drawing Reading L2 production assessment v1.0.',
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
        'Blueprint / Drawing Reading',
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
        'IntegrateU Blueprint / Drawing Reading L2 production assessment v1.0.',
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
  v_assessment_name := 'Blueprint / Drawing Reading — Level 3 Competency Assessment';

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
    select * from _seed_ci_blueprint_drawing_reading_l3_questions
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
        'Blueprint / Drawing Reading',
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
      'IntegrateU Blueprint / Drawing Reading L3 production assessment v1.0.',
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
        'Blueprint / Drawing Reading',
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
        'IntegrateU Blueprint / Drawing Reading L3 production assessment v1.0.',
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
  v_assessment_name := 'Blueprint / Drawing Reading — Level 4 Competency Assessment';

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
    select * from _seed_ci_blueprint_drawing_reading_l4_questions
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
        'Blueprint / Drawing Reading',
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
      'IntegrateU Blueprint / Drawing Reading L4 production assessment v1.0.',
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
        'Blueprint / Drawing Reading',
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
        'IntegrateU Blueprint / Drawing Reading L4 production assessment v1.0.',
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
