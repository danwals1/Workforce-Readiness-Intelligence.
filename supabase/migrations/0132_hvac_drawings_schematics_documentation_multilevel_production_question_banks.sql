-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_drawings_schematics_documentation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Drawings, Schematics & Documentation
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Service & Repair Technician -> Level 3
--   HVAC Design & Sales Engineer     -> Level 4
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

create temporary table _seed_hvac_drawings_schematics_documentation_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_drawings_schematics_documentation_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an HVAC equipment schedule on a drawing set?',
  '[{"key":"A","text":"To list equipment identifiers and key equipment information"},{"key":"B","text":"To show only wall locations"},{"key":"C","text":"To replace all installation instructions"},{"key":"D","text":"To show employee work schedules"}]'::jsonb,
  '["A"]'::jsonb,
  'An equipment schedule identifies equipment and typically provides key information used to coordinate installation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'On a drawing, what does a legend primarily help a worker understand?',
  '[{"key":"A","text":"The meaning of symbols and abbreviations"},{"key":"B","text":"Payroll classifications"},{"key":"C","text":"Tool calibration dates"},{"key":"D","text":"Warranty expiration dates"}]'::jsonb,
  '["A"]'::jsonb,
  'A drawing legend explains symbols, line types, and abbreviations used in the document.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does a plan view generally show?',
  '[{"key":"A","text":"A view looking down on the layout from above"},{"key":"B","text":"Only a side view of equipment"},{"key":"C","text":"Only electrical test readings"},{"key":"D","text":"A list of replacement parts"}]'::jsonb,
  '["A"]'::jsonb,
  'A plan view represents the layout as viewed from above.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a schematic diagram primarily used to show?',
  '[{"key":"A","text":"Functional relationships and connections between components"},{"key":"B","text":"The exact physical size of every component"},{"key":"C","text":"The building exterior finish"},{"key":"D","text":"Employee assignments"}]'::jsonb,
  '["A"]'::jsonb,
  'Schematics emphasize how components are connected or function together rather than exact physical placement.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why are drawing revision dates important?',
  '[{"key":"A","text":"They help identify whether the worker is using the latest issued information"},{"key":"B","text":"They indicate the age of the building"},{"key":"C","text":"They show equipment operating temperature"},{"key":"D","text":"They replace equipment serial numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision information helps workers confirm that they are using the current issued drawing or document.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is an equipment tag such as AHU-1 or RTU-2 used for?',
  '[{"key":"A","text":"To uniquely identify a specific piece of equipment on drawings and schedules"},{"key":"B","text":"To show the price of the equipment"},{"key":"C","text":"To indicate employee ownership"},{"key":"D","text":"To replace the manufacturer name permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment tags provide a consistent identifier that can be cross-referenced between plans, schedules, and notes.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What should an installer do if a drawing abbreviation is unfamiliar?',
  '[{"key":"A","text":"Check the drawing legend, notes, or approved project documents"},{"key":"B","text":"Guess based on the nearest symbol"},{"key":"C","text":"Ignore the abbreviation"},{"key":"D","text":"Change the abbreviation on the drawing"}]'::jsonb,
  '["A"]'::jsonb,
  'Unknown abbreviations should be verified using the project legend, notes, or other approved documentation.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What is the purpose of a detail callout on a drawing?',
  '[{"key":"A","text":"To direct the reader to an enlarged or more specific view"},{"key":"B","text":"To show payroll information"},{"key":"C","text":"To identify tool storage"},{"key":"D","text":"To indicate building occupancy"}]'::jsonb,
  '["A"]'::jsonb,
  'A detail callout points the reader to another drawing location containing more specific construction or installation information.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer sees RTU-3 on the roof plan. What is the BEST next reference for finding the specified unit information?',
  '[{"key":"A","text":"The equipment schedule matching RTU-3"},{"key":"B","text":"The employee handbook"},{"key":"C","text":"The parking plan"},{"key":"D","text":"The time sheet"}]'::jsonb,
  '["A"]'::jsonb,
  'The matching equipment schedule is the normal place to cross-reference equipment tag information.'
),
(
  10,
  'multiple_choice',
  'application',
  'A plan note says “See Detail 5/M-402.” What should the installer do?',
  '[{"key":"A","text":"Locate Detail 5 on sheet M-402"},{"key":"B","text":"Measure 5 feet from the equipment"},{"key":"C","text":"Use sheet M-5"},{"key":"D","text":"Ignore the note unless a problem occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'The notation directs the reader to Detail 5 on drawing sheet M-402.'
),
(
  11,
  'multiple_choice',
  'application',
  'A drawing shows a duct route using a line type identified in the legend as “existing.” What should the installer understand?',
  '[{"key":"A","text":"The indicated duct is existing rather than new work"},{"key":"B","text":"The duct must always be removed"},{"key":"C","text":"The duct is electrical conduit"},{"key":"D","text":"The duct has already passed inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Line types must be interpreted according to the drawing legend; an existing designation distinguishes existing work from new work.'
),
(
  12,
  'multiple_choice',
  'application',
  'An installer is comparing a floor plan with an equipment schedule. Which identifier should match between them?',
  '[{"key":"A","text":"The equipment tag"},{"key":"B","text":"The installer initials"},{"key":"C","text":"The drawing print size"},{"key":"D","text":"The job trailer number"}]'::jsonb,
  '["A"]'::jsonb,
  'The equipment tag is the primary cross-reference between the plan location and the equipment schedule.'
),
(
  13,
  'multiple_choice',
  'application',
  'A mechanical drawing contains a note stating “dimensions are to finished surface.” How should an installer use that note?',
  '[{"key":"A","text":"Measure from the finished surface indicated by the documents"},{"key":"B","text":"Always measure from rough framing instead"},{"key":"C","text":"Add an arbitrary allowance"},{"key":"D","text":"Ignore written notes when dimensions are shown"}]'::jsonb,
  '["A"]'::jsonb,
  'Drawing notes define how dimensions are to be interpreted and should be followed unless superseded by approved information.'
),
(
  14,
  'multiple_choice',
  'application',
  'An installer finds a symbol on the plan that appears several times but is not immediately recognizable. What is the BEST first step?',
  '[{"key":"A","text":"Check the legend and general notes"},{"key":"B","text":"Assume all repeated symbols mean supply air"},{"key":"C","text":"Remove the symbol from the working copy"},{"key":"D","text":"Use the nearest equipment tag as the meaning"}]'::jsonb,
  '["A"]'::jsonb,
  'The legend and notes are the appropriate first references for interpreting unfamiliar symbols.'
),
(
  15,
  'multiple_choice',
  'application',
  'A drawing has Revision 3 dated later than Revision 2. Which revision should normally be used for current work if Revision 3 is the latest approved issue?',
  '[{"key":"A","text":"Revision 3"},{"key":"B","text":"Revision 2"},{"key":"C","text":"Either revision without checking"},{"key":"D","text":"The oldest revision"}]'::jsonb,
  '["A"]'::jsonb,
  'The latest approved revision should normally govern current work.'
),
(
  16,
  'multiple_choice',
  'application',
  'A duct size is labeled 24 x 12 on the mechanical plan. What does this notation most commonly communicate?',
  '[{"key":"A","text":"The duct cross-sectional dimensions shown by the drawing convention"},{"key":"B","text":"The duct length in feet"},{"key":"C","text":"The duct weight"},{"key":"D","text":"The equipment voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct size notation communicates the cross-sectional dimensions according to the project drawing convention.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer arrives with a printed mechanical plan marked Revision 1, but the project document station shows an approved Revision 2. What is the BEST action?',
  '[{"key":"A","text":"Use the approved Revision 2 and verify whether the changes affect the installation"},{"key":"B","text":"Continue with Revision 1 because it is already printed"},{"key":"C","text":"Choose whichever revision is easier to read"},{"key":"D","text":"Ignore all revision markings"}]'::jsonb,
  '["A"]'::jsonb,
  'Current approved documentation should be used, and the installer should determine whether the revision changes the planned work.'
),
(
  18,
  'scenario',
  'scenario',
  'A plan locates AHU-2 in one room, but the equipment schedule lists AHU-2 with characteristics that appear inconsistent with the unit delivered to the site. What should the installer do?',
  '[{"key":"A","text":"Stop and verify the discrepancy through the approved project process before installing"},{"key":"B","text":"Install the delivered unit because the tag is close enough"},{"key":"C","text":"Change the equipment schedule by hand"},{"key":"D","text":"Ignore the schedule and use only the room location"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting project information should be resolved before installation rather than guessed or informally altered.'
),
(
  19,
  'scenario',
  'scenario',
  'An installer cannot determine from the plan whether a shown duct is new or existing because two line types look similar on a poor print. What is the BEST response?',
  '[{"key":"A","text":"Verify the line type using a clear current drawing, legend, or approved digital document"},{"key":"B","text":"Assume it is new work"},{"key":"C","text":"Assume it is existing work"},{"key":"D","text":"Ignore the distinction"}]'::jsonb,
  '["A"]'::jsonb,
  'When print quality creates ambiguity, the installer should verify the information from a clear approved source rather than guess.'
),
(
  20,
  'scenario',
  'scenario',
  'A detail callout on the plan conflicts with an older field sketch kept in the installer’s toolbox. The detail is part of the current approved drawing set. Which information should guide the work?',
  '[{"key":"A","text":"The current approved drawing detail, unless formally superseded"},{"key":"B","text":"The older field sketch because it is physically closer"},{"key":"C","text":"Whichever document shows less work"},{"key":"D","text":"Neither document should ever be used"}]'::jsonb,
  '["A"]'::jsonb,
  'Current approved project documentation governs unless a newer authorized instruction supersedes it.'
);

create temporary table _seed_hvac_drawings_schematics_documentation_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_drawings_schematics_documentation_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary advantage of a ladder-style electrical schematic when troubleshooting HVAC controls?',
  '[{"key":"A","text":"It shows the logical relationship of control components and circuits"},{"key":"B","text":"It shows the exact physical location of every wire"},{"key":"C","text":"It replaces all manufacturer service literature"},{"key":"D","text":"It shows only mechanical dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'A ladder schematic is intended to show circuit logic and component relationships so a technician can trace expected operation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does a normally open contact symbol indicate on a control schematic?',
  '[{"key":"A","text":"The contact is shown open in its normal, unactuated state"},{"key":"B","text":"The contact must always remain open"},{"key":"C","text":"The contact is physically broken"},{"key":"D","text":"The circuit has no power source"}]'::jsonb,
  '["A"]'::jsonb,
  'Schematic contacts are normally shown in their normal or unactuated state unless otherwise noted.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a service technician compare the equipment nameplate with the wiring diagram before replacing a component?',
  '[{"key":"A","text":"To confirm the diagram and component information apply to the actual equipment being serviced"},{"key":"B","text":"To determine the technician labor rate"},{"key":"C","text":"To eliminate the need for electrical testing"},{"key":"D","text":"To verify the building address"}]'::jsonb,
  '["A"]'::jsonb,
  'Model-specific documentation and equipment identification should be confirmed before relying on a diagram or selecting a replacement component.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a sequence-of-operation document?',
  '[{"key":"A","text":"To describe how the system is intended to respond under defined operating conditions"},{"key":"B","text":"To list only equipment purchase prices"},{"key":"C","text":"To replace all electrical schematics"},{"key":"D","text":"To show only duct dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'A sequence of operation explains the intended functional progression of system components and controls.'
),
(
  5,
  'multiple_choice',
  'application',
  'A schematic shows a thermostat contact, a safety switch, and a contactor coil in series. If the thermostat is calling but the safety switch is open, what should the technician expect?',
  '[{"key":"A","text":"The contactor coil should remain de-energized"},{"key":"B","text":"The contactor coil must energize"},{"key":"C","text":"The safety switch is bypassed automatically"},{"key":"D","text":"The thermostat contact becomes irrelevant"}]'::jsonb,
  '["A"]'::jsonb,
  'An open series safety interrupts the control circuit, preventing the downstream contactor coil from energizing.'
),
(
  6,
  'multiple_choice',
  'application',
  'A wiring diagram identifies terminals R, C, Y, G, and W. Which document should the technician consult if the function of one terminal is unclear on this specific unit?',
  '[{"key":"A","text":"The manufacturer wiring legend or service documentation for that unit"},{"key":"B","text":"A generic plumbing diagram"},{"key":"C","text":"The building evacuation map"},{"key":"D","text":"The employee time sheet"}]'::jsonb,
  '["A"]'::jsonb,
  'Manufacturer documentation should be used to verify terminal functions and unit-specific conventions.'
),
(
  7,
  'multiple_choice',
  'application',
  'A service technician finds that the field wiring differs from the current approved schematic. What is the BEST interpretation?',
  '[{"key":"A","text":"The discrepancy must be investigated before assuming either the field wiring or drawing is correct"},{"key":"B","text":"The drawing is always wrong"},{"key":"C","text":"The field wiring is always correct"},{"key":"D","text":"The discrepancy can be ignored if the unit operates"}]'::jsonb,
  '["A"]'::jsonb,
  'A mismatch between documentation and field conditions should be resolved before relying on either source for diagnosis or repair.'
),
(
  8,
  'multiple_choice',
  'application',
  'A control schematic shows two safety contacts in series ahead of a compressor contactor coil. What does this arrangement imply?',
  '[{"key":"A","text":"Both safety contacts must be closed for the coil circuit to be complete"},{"key":"B","text":"Only one safety contact is needed"},{"key":"C","text":"The safeties are electrically bypassed"},{"key":"D","text":"The compressor contactor controls the safeties"}]'::jsonb,
  '["A"]'::jsonb,
  'Series contacts must all provide continuity for current to reach the downstream load.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician is tracing a low-voltage control circuit and reaches a relay contact labeled with a relay designation. What is the BEST next step?',
  '[{"key":"A","text":"Locate the corresponding relay coil on the schematic and determine what controls it"},{"key":"B","text":"Assume the relay is defective"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Ignore the relay designation"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-referencing the relay contact to its controlling coil helps determine the logic that changes the contact state.'
),
(
  10,
  'multiple_choice',
  'application',
  'A service drawing contains a revision cloud around a control wiring change. What should the technician do?',
  '[{"key":"A","text":"Review the associated revision information before relying on the affected circuit"},{"key":"B","text":"Ignore the cloud because it is only decorative"},{"key":"C","text":"Use the previous circuit automatically"},{"key":"D","text":"Delete the marked change from the working copy"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision clouds identify changed areas that should be reviewed along with the associated revision record.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician replaces a control board and discovers that the terminal arrangement differs from the old board. What documentation is most important before moving conductors?',
  '[{"key":"A","text":"The approved replacement-board wiring instructions or manufacturer diagram"},{"key":"B","text":"The old conductor positions only"},{"key":"C","text":"The building floor plan"},{"key":"D","text":"The equipment sales brochure"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement components may use different terminal arrangements, so the correct manufacturer documentation should govern reconnection.'
),
(
  12,
  'scenario',
  'scenario',
  'A cooling unit will not start. The schematic shows the thermostat call, condensate safety, high-pressure safety, and contactor coil in series. The thermostat is calling and the high-pressure safety is closed, but the condensate safety is open. What is the BEST diagnostic conclusion?',
  '[{"key":"A","text":"The open condensate safety is interrupting the control circuit to the contactor coil"},{"key":"B","text":"The contactor coil must still energize"},{"key":"C","text":"The high-pressure safety is the confirmed fault"},{"key":"D","text":"The thermostat should be replaced first"}]'::jsonb,
  '["A"]'::jsonb,
  'The open series condensate safety prevents continuity to the contactor coil and explains why the coil does not energize.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician measures voltage at a control-board input that should only be energized after a relay closes. The schematic shows the relay contact open in the normal state. What should the technician investigate NEXT?',
  '[{"key":"A","text":"Whether the relay is being commanded or whether the contact is stuck or miswired"},{"key":"B","text":"Whether the duct size is correct"},{"key":"C","text":"Whether the equipment schedule lists the right weight"},{"key":"D","text":"Whether the thermostat mounting height is exact"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected voltage downstream of a normally open relay contact points toward relay actuation, a stuck contact, or wiring that does not match the schematic.'
),
(
  14,
  'scenario',
  'scenario',
  'A rooftop unit has intermittent operation after prior field modifications. The current schematic does not show two added conductors found at the control board. What is the BEST action?',
  '[{"key":"A","text":"Trace and document the added conductors and verify their purpose before changing the circuit"},{"key":"B","text":"Remove both conductors immediately"},{"key":"C","text":"Assume they are abandoned"},{"key":"D","text":"Replace the control board without further investigation"}]'::jsonb,
  '["A"]'::jsonb,
  'Undocumented field modifications should be traced and understood before they are altered or removed.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is troubleshooting a blower that does not run. The schematic shows the blower relay coil energized by the control board and a separate relay contact switching blower power. The coil has proper voltage but the switched output remains open. What does the documentation suggest checking?',
  '[{"key":"A","text":"The relay contact operation or relay assembly"},{"key":"B","text":"The thermostat mounting screws"},{"key":"C","text":"The duct insulation thickness"},{"key":"D","text":"The equipment pad dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'If the relay coil is energized but its associated contact does not change state, the relay contact or relay assembly becomes a logical focus.'
),
(
  16,
  'scenario',
  'scenario',
  'A manufacturer service bulletin shows a wiring revision for the exact model and serial range being serviced, but the unit door diagram shows the older circuit. What should the technician do?',
  '[{"key":"A","text":"Use the applicable current manufacturer information and verify how the revision affects the unit"},{"key":"B","text":"Ignore the service bulletin because the door diagram is physically attached"},{"key":"C","text":"Use whichever diagram is simpler"},{"key":"D","text":"Combine both diagrams without verification"}]'::jsonb,
  '["A"]'::jsonb,
  'Applicable current manufacturer service information may supersede older equipment documentation and should be verified before work proceeds.'
),
(
  17,
  'scenario',
  'scenario',
  'A system is supposed to energize an economizer before mechanical cooling under certain conditions. The sequence-of-operation document says the economizer should be enabled, but the observed sequence skips directly to compressor operation. What is the BEST use of the documentation?',
  '[{"key":"A","text":"Use the sequence to identify the missing expected step and investigate the controls responsible for economizer enable"},{"key":"B","text":"Assume the sequence document has no diagnostic value"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Ignore the economizer because cooling is occurring"}]'::jsonb,
  '["A"]'::jsonb,
  'The documented sequence provides the expected operating progression and helps isolate where actual operation departs from design intent.'
),
(
  18,
  'scenario',
  'scenario',
  'A service report states “repaired wiring” but does not identify the circuit, terminals, or change made. Why is this documentation inadequate?',
  '[{"key":"A","text":"It does not provide enough information for future technicians to understand or verify the repair"},{"key":"B","text":"Service reports should never mention wiring"},{"key":"C","text":"Only equipment model numbers belong in a service report"},{"key":"D","text":"Repair documentation is unnecessary after the unit runs"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful service documentation should clearly identify the affected circuit and the work performed so future diagnosis is not based on guesswork.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician discovers that a pressure-switch jumper shown on an old troubleshooting sketch is not present on the current approved schematic. What is the BEST response?',
  '[{"key":"A","text":"Do not assume the jumper belongs there; verify the current approved circuit and equipment documentation"},{"key":"B","text":"Install the jumper because it appears on any older document"},{"key":"C","text":"Bypass the pressure switch permanently"},{"key":"D","text":"Ignore the current schematic"}]'::jsonb,
  '["A"]'::jsonb,
  'Old informal sketches should not override current approved documentation, especially where safety or control devices may be affected.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes a control repair that changes field wiring from an undocumented prior condition back to the approved schematic. What is the BEST closeout action?',
  '[{"key":"A","text":"Document the corrected condition, relevant terminals or conductors, and verification of proper operation"},{"key":"B","text":"Leave no record because the circuit now matches the schematic"},{"key":"C","text":"Discard the service notes"},{"key":"D","text":"Change the equipment tag"}]'::jsonb,
  '["A"]'::jsonb,
  'Documenting the correction and verification creates a clear service history and supports future troubleshooting.'
);

create temporary table _seed_hvac_drawings_schematics_documentation_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_drawings_schematics_documentation_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of coordinating mechanical drawings with architectural, structural, and electrical documents?',
  '[{"key":"A","text":"To identify conflicts and confirm that the HVAC design can be installed as intended"},{"key":"B","text":"To eliminate the need for field verification"},{"key":"C","text":"To make every discipline use identical symbols"},{"key":"D","text":"To replace equipment submittals"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-discipline coordination helps identify conflicts, access issues, routing constraints, and other conditions that could prevent the HVAC design from being installed as intended.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is an as-built or record drawing intended to communicate?',
  '[{"key":"A","text":"The documented installed condition, including approved field changes where required"},{"key":"B","text":"Only the original bid concept"},{"key":"C","text":"Only equipment pricing"},{"key":"D","text":"A future maintenance schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Record documentation is intended to capture the installed condition and authorized changes from the original design documents.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is a documented sequence of operation important when reviewing HVAC control drawings?',
  '[{"key":"A","text":"It defines intended system behavior that can be checked against the control design and field operation"},{"key":"B","text":"It establishes equipment purchase cost"},{"key":"C","text":"It replaces all wiring diagrams"},{"key":"D","text":"It determines duct insulation color"}]'::jsonb,
  '["A"]'::jsonb,
  'The sequence of operation provides the intended functional behavior against which control logic, schematics, and system operation can be reviewed.'
),
(
  4,
  'multiple_choice',
  'application',
  'A mechanical plan shows a supply duct passing through a structural beam location. What is the BEST response during design or coordination review?',
  '[{"key":"A","text":"Identify the conflict and resolve the routing or approved structural accommodation before installation"},{"key":"B","text":"Assume the installer will cut the beam as needed"},{"key":"C","text":"Ignore the conflict if the duct size is correct"},{"key":"D","text":"Reduce the duct size without engineering review"}]'::jsonb,
  '["A"]'::jsonb,
  'A structural conflict should be formally coordinated rather than left for unapproved field modification.'
),
(
  5,
  'multiple_choice',
  'application',
  'A control diagram and sequence of operation disagree about when a fan should start. What is the BEST next step?',
  '[{"key":"A","text":"Resolve the document conflict through the approved design or controls coordination process"},{"key":"B","text":"Use whichever document was printed first"},{"key":"C","text":"Let the installer choose the preferred sequence"},{"key":"D","text":"Delete the sequence from the project file"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting design documents should be reconciled through the approved process so the intended control sequence is unambiguous.'
),
(
  6,
  'multiple_choice',
  'application',
  'A rooftop equipment plan shows a unit location that satisfies curb layout but blocks the required service access shown in the manufacturer documentation. What should be done?',
  '[{"key":"A","text":"Revise or coordinate the layout so required service access is maintained"},{"key":"B","text":"Ignore service access because the curb fits"},{"key":"C","text":"Remove the manufacturer documentation from the project record"},{"key":"D","text":"Reduce the access requirement without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment layout should account for installation, code, manufacturer, and service-access requirements rather than footprint alone.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project revision changes an air-handler location but the corresponding equipment schedule and detail references were not updated. What is the BEST review finding?',
  '[{"key":"A","text":"The documents are internally inconsistent and should be coordinated before release or installation"},{"key":"B","text":"The plan automatically overrides all other documents without review"},{"key":"C","text":"Only the schedule should be deleted"},{"key":"D","text":"The inconsistency is acceptable if the equipment model is unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'Related plans, schedules, details, and references should remain coordinated when revisions change equipment location or configuration.'
),
(
  8,
  'multiple_choice',
  'application',
  'A senior technician documents a field reroute of refrigerant piping that was approved during construction. What information is most useful for record documentation?',
  '[{"key":"A","text":"The actual approved routing and relevant changes from the issued design"},{"key":"B","text":"Only the technician name"},{"key":"C","text":"Only the original routing"},{"key":"D","text":"Only the material purchase order"}]'::jsonb,
  '["A"]'::jsonb,
  'Record documentation should capture the approved installed condition so future service and project records reflect what is actually in place.'
),
(
  9,
  'multiple_choice',
  'application',
  'A control schematic references a sensor designation that does not appear on the points list. What is the BEST design-review action?',
  '[{"key":"A","text":"Flag the mismatch and reconcile the schematic, sequence, and points documentation"},{"key":"B","text":"Assume the sensor is unnecessary"},{"key":"C","text":"Delete the schematic reference"},{"key":"D","text":"Allow the field technician to invent a designation"}]'::jsonb,
  '["A"]'::jsonb,
  'Control schematics, sequences, and points lists should use coordinated device references so commissioning and service personnel can trace intended operation.'
),
(
  10,
  'multiple_choice',
  'application',
  'A drawing detail shows a service clearance that conflicts with a larger clearance required by the approved equipment submittal. What should govern the next action?',
  '[{"key":"A","text":"The discrepancy should be resolved so the final coordinated documents reflect the applicable requirement"},{"key":"B","text":"Always use the smaller clearance"},{"key":"C","text":"Ignore the submittal once drawings are issued"},{"key":"D","text":"Average the two clearance dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting requirements should be formally reconciled rather than arbitrarily selecting one value.'
),
(
  11,
  'scenario',
  'scenario',
  'During coordination, a design engineer finds that the proposed main duct route occupies the same ceiling zone as a large electrical feeder tray. Both systems are already shown on issued drawings. What is the BEST response?',
  '[{"key":"A","text":"Coordinate the disciplines and issue an approved routing resolution before field installation proceeds in the conflict area"},{"key":"B","text":"Tell the first trade on site to use the space"},{"key":"C","text":"Reduce the duct size without analysis"},{"key":"D","text":"Omit the conflict from the coordination record"}]'::jsonb,
  '["A"]'::jsonb,
  'Interdisciplinary spatial conflicts should be resolved through coordinated design changes rather than informal field priority.'
),
(
  12,
  'scenario',
  'scenario',
  'A senior technician is called to a recurring control problem. The current sequence says a proof-of-flow signal must be received before the next stage starts, but the field wiring bypasses that input. What is the BEST approach?',
  '[{"key":"A","text":"Document the discrepancy, verify the approved control intent, and correct or escalate the condition through the authorized process"},{"key":"B","text":"Leave the bypass because the system runs"},{"key":"C","text":"Delete the proof requirement from the sequence"},{"key":"D","text":"Replace unrelated sensors first"}]'::jsonb,
  '["A"]'::jsonb,
  'A bypass that conflicts with documented control intent should be investigated and resolved through the approved process, not normalized without review.'
),
(
  13,
  'scenario',
  'scenario',
  'A design package shows RTU-4 on the roof plan, RTU-5 in the equipment schedule, and Detail 7 references RTU-4 for the same location. What is the BEST review conclusion?',
  '[{"key":"A","text":"The equipment identification is inconsistent and must be reconciled before release or installation"},{"key":"B","text":"The installer should choose whichever tag appears twice"},{"key":"C","text":"The schedule should always be ignored"},{"key":"D","text":"Different tags are acceptable for the same unit"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment tags should be consistent across plans, schedules, details, controls documents, and other project references.'
),
(
  14,
  'scenario',
  'scenario',
  'A field team requests approval to shift an air handler three feet because of an unforeseen structural obstruction. What documentation concern should be evaluated before approving the change?',
  '[{"key":"A","text":"Whether the shift affects duct routing, piping, electrical connections, controls, access, clearances, and coordinated record documents"},{"key":"B","text":"Only whether the unit still fits inside the room"},{"key":"C","text":"Only whether the equipment tag remains the same"},{"key":"D","text":"No documentation review is needed for field shifts"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment relocation can affect multiple systems and documents, so the change should be evaluated and coordinated comprehensively.'
),
(
  15,
  'scenario',
  'scenario',
  'A senior technician discovers that three prior service modifications are not reflected on the unit wiring diagram or service history. The system now has an intermittent fault. What is the BEST first documentation strategy?',
  '[{"key":"A","text":"Create a verified record of the current field wiring and compare it with approved manufacturer and project documentation"},{"key":"B","text":"Assume every undocumented change is correct"},{"key":"C","text":"Remove all three modifications immediately"},{"key":"D","text":"Troubleshoot only from the original schematic"}]'::jsonb,
  '["A"]'::jsonb,
  'Establishing an accurate current-condition record helps distinguish approved design from later modifications and supports disciplined troubleshooting.'
),
(
  16,
  'scenario',
  'scenario',
  'A controls contractor submits a diagram showing an occupied-mode sequence that does not match the engineer’s approved sequence of operation. What should happen before commissioning?',
  '[{"key":"A","text":"The discrepancy should be resolved and the approved controls documentation aligned before functional verification"},{"key":"B","text":"Commission both sequences and choose the better one"},{"key":"C","text":"Ignore the written sequence"},{"key":"D","text":"Allow each technician to interpret the logic independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning should verify operation against a coordinated approved sequence, so conflicting control documents need resolution first.'
),
(
  17,
  'scenario',
  'scenario',
  'A renovation drawing identifies an existing duct as “remain,” but field inspection shows it was previously removed. What is the BEST response?',
  '[{"key":"A","text":"Document the differing field condition and coordinate the design response before relying on the shown connection"},{"key":"B","text":"Fabricate a replacement immediately without review"},{"key":"C","text":"Pretend the duct exists for record purposes"},{"key":"D","text":"Ignore the affected branch"}]'::jsonb,
  '["A"]'::jsonb,
  'Existing-condition discrepancies can affect design intent and should be documented and resolved before dependent work proceeds.'
),
(
  18,
  'scenario',
  'scenario',
  'A project team receives a revised mechanical sheet that changes duct routing, but the revision narrative does not mention the change. What is the BEST quality-control response?',
  '[{"key":"A","text":"Verify the change, its authorization, and all affected coordination before distributing it for construction"},{"key":"B","text":"Assume every graphical difference is automatically approved"},{"key":"C","text":"Remove the revision date"},{"key":"D","text":"Use both routing versions simultaneously"}]'::jsonb,
  '["A"]'::jsonb,
  'Revision control should make authorized changes traceable and coordinated so construction teams know which information governs.'
),
(
  19,
  'scenario',
  'scenario',
  'A senior technician completes a major control-system repair and finds that the final installed wiring differs from the original factory schematic because of an approved retrofit kit. What is the BEST documentation outcome?',
  '[{"key":"A","text":"Retain the applicable retrofit documentation and update service or record information so the approved current configuration is traceable"},{"key":"B","text":"Discard the retrofit instructions after startup"},{"key":"C","text":"Restore the original schematic regardless of the retrofit"},{"key":"D","text":"Document only that the unit is operational"}]'::jsonb,
  '["A"]'::jsonb,
  'Future technicians need access to documentation that explains the approved current configuration when it differs from the original factory arrangement.'
),
(
  20,
  'scenario',
  'scenario',
  'A design engineer is preparing a final drawing package after construction. Several approved field changes affect equipment locations, duct routing, and control sensor locations. What is the BEST closeout approach?',
  '[{"key":"A","text":"Incorporate or clearly capture the approved installed changes in the record documentation and maintain coordinated references across affected sheets"},{"key":"B","text":"Issue the original design unchanged"},{"key":"C","text":"Document only equipment locations"},{"key":"D","text":"Leave all field changes in separate verbal notes"}]'::jsonb,
  '["A"]'::jsonb,
  'Final record documentation should provide a coordinated, traceable representation of approved installed conditions across the affected documents.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '29fa5def-392f-474e-9cb0-d9ad74302a3a';
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
      and c.name = 'HVAC Drawings, Schematics & Documentation'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Drawings, Schematics & Documentation Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 HVAC Drawings, Schematics & Documentation requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 HVAC Drawings, Schematics & Documentation requirement not found';
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
      and mrcr.required_level = 4
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L4 HVAC Drawings, Schematics & Documentation requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 HVAC Drawings, Schematics & Documentation requirement not found';
  end if;

v_level := 1;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'HVAC Drawings, Schematics & Documentation — Level 1 Competency Assessment';

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
    select * from _seed_hvac_drawings_schematics_documentation_l1_questions
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
        'HVAC Drawings, Schematics & Documentation',
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
      'IntegrateU HVAC Drawings, Schematics & Documentation L1 production assessment v1.0.',
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
        'HVAC Drawings, Schematics & Documentation',
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
        'IntegrateU HVAC Drawings, Schematics & Documentation L1 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Drawings, Schematics & Documentation — Level 3 Competency Assessment';

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
    select * from _seed_hvac_drawings_schematics_documentation_l3_questions
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
        'HVAC Drawings, Schematics & Documentation',
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
      'IntegrateU HVAC Drawings, Schematics & Documentation L3 production assessment v1.0.',
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
        'HVAC Drawings, Schematics & Documentation',
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
        'IntegrateU HVAC Drawings, Schematics & Documentation L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Drawings, Schematics & Documentation — Level 4 Competency Assessment';

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
    select * from _seed_hvac_drawings_schematics_documentation_l4_questions
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
        'HVAC Drawings, Schematics & Documentation',
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
      'IntegrateU HVAC Drawings, Schematics & Documentation L4 production assessment v1.0.',
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
      (v_master_question_id, v_design_sales_role_id),
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
        'HVAC Drawings, Schematics & Documentation',
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
        'IntegrateU HVAC Drawings, Schematics & Documentation L4 production assessment v1.0.',
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
   '29fa5def-392f-474e-9cb0-d9ad74302a3a'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '29fa5def-392f-474e-9cb0-d9ad74302a3a'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L1 HVAC Installer / Helper = 20
--   L3 HVAC Service & Repair Technician = 20
--   L4 HVAC Design & Sales Engineer = 20
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
      '29fa5def-392f-474e-9cb0-d9ad74302a3a'::uuid
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
    and mrt.id in (
      '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid,
      'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
    )
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
  '29fa5def-392f-474e-9cb0-d9ad74302a3a'::uuid;

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
    '29fa5def-392f-474e-9cb0-d9ad74302a3a'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
