-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0128_hvac_refrigerant_safety_environmental_practices_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Refrigerant Safety & Environmental Practices
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

create temporary table _seed_hvac_refrigerant_safety_environmental_practices_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_safety_environmental_practices_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should an HVAC worker avoid intentionally releasing refrigerant during service?',
  '[{"key":"A","text":"Because intentional venting of regulated refrigerants and covered substitutes is generally prohibited"},{"key":"B","text":"Because refrigerant can only be released indoors"},{"key":"C","text":"Because venting is allowed only on weekends"},{"key":"D","text":"Because refrigerant immediately damages every recovery machine"}]'::jsonb,
  '["A"]'::jsonb,
  'Section 608 generally prohibits intentional venting during maintenance, service, repair, or disposal, subject to limited permitted releases.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the main purpose of refrigerant recovery equipment?',
  '[{"key":"A","text":"To capture refrigerant from an appliance instead of intentionally releasing it"},{"key":"B","text":"To increase compressor amperage"},{"key":"C","text":"To replace the system vacuum pump"},{"key":"D","text":"To identify electrical faults"}]'::jsonb,
  '["A"]'::jsonb,
  'Recovery equipment is used to remove and capture refrigerant so it can be handled appropriately rather than intentionally vented.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Who generally must hold EPA Section 608 technician certification when performing covered refrigerant-service activities?',
  '[{"key":"A","text":"Technicians who maintain, service, repair, or dispose of covered equipment in ways that could release refrigerant"},{"key":"B","text":"Only company owners"},{"key":"C","text":"Only equipment manufacturers"},{"key":"D","text":"Any customer standing near the equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'EPA Section 608 requires certification for technicians performing covered service activities that could release refrigerant.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Can an apprentice perform covered refrigerant work without having Section 608 certification?',
  '[{"key":"A","text":"Never under any circumstances"},{"key":"B","text":"Yes, when the apprentice qualifies for the supervised-apprentice provision and is closely and continually supervised by a certified technician"},{"key":"C","text":"Yes, whenever the customer gives permission"},{"key":"D","text":"Yes, but only after normal business hours"}]'::jsonb,
  '["B"]'::jsonb,
  'EPA provides an apprentice exemption when the worker is closely and continually supervised by a properly certified technician.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is refrigerant identification important before recovery or charging?',
  '[{"key":"A","text":"Different refrigerants should be handled correctly and should not be mixed accidentally"},{"key":"B","text":"All refrigerants are interchangeable"},{"key":"C","text":"Identification matters only for billing"},{"key":"D","text":"It determines thermostat wiring"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct identification helps prevent contamination, improper charging, and unsafe or noncompliant handling.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What hazard can a significant refrigerant release create in a poorly ventilated area?',
  '[{"key":"A","text":"An unsafe atmosphere, including possible oxygen displacement"},{"key":"B","text":"Higher Wi-Fi interference"},{"key":"C","text":"Lower electrical resistance in copper wire"},{"key":"D","text":"Automatic compressor lubrication"}]'::jsonb,
  '["A"]'::jsonb,
  'A substantial refrigerant release can create an atmospheric hazard, especially in confined or poorly ventilated spaces.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why should refrigerant cylinders be clearly identified?',
  '[{"key":"A","text":"To help prevent mixing, misuse, and incorrect handling of refrigerants"},{"key":"B","text":"To make the cylinders heavier"},{"key":"C","text":"To eliminate the need for recovery equipment"},{"key":"D","text":"To show which technician owns the gauges"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear identification supports proper refrigerant segregation, handling, and transfer.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should an installer do if the refrigerant type on the equipment cannot be confirmed?',
  '[{"key":"A","text":"Guess based on equipment color"},{"key":"B","text":"Stop and obtain reliable refrigerant identification before handling or charging the system"},{"key":"C","text":"Use whichever refrigerant is available"},{"key":"D","text":"Mix two likely refrigerants together"}]'::jsonb,
  '["B"]'::jsonb,
  'Unknown refrigerant should be positively identified before recovery, charging, or other handling.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is preparing to disconnect a precharged line set and refrigerant may be released. What should happen before the connection is opened?',
  '[{"key":"A","text":"Open it quickly to minimize delay"},{"key":"B","text":"Follow the approved procedure for controlling and recovering refrigerant as applicable"},{"key":"C","text":"Ask the customer to stand back"},{"key":"D","text":"Vent the refrigerant outdoors"}]'::jsonb,
  '["B"]'::jsonb,
  'Connections that can release refrigerant should be handled using the applicable recovery and service procedure.'
),
(
  10,
  'multiple_choice',
  'application',
  'A helper finds a recovery cylinder with no readable refrigerant identification. What is the BEST action?',
  '[{"key":"A","text":"Use it if it feels empty"},{"key":"B","text":"Do not use it until its contents and suitability are properly determined"},{"key":"C","text":"Add the current system refrigerant and relabel it afterward"},{"key":"D","text":"Vent the cylinder first"}]'::jsonb,
  '["B"]'::jsonb,
  'An unidentified cylinder should not be used because its contents may be incompatible or contaminated.'
),
(
  11,
  'multiple_choice',
  'application',
  'A worker is moving a refrigerant cylinder to the roof. What is the BEST general practice?',
  '[{"key":"A","text":"Handle and secure the cylinder to prevent damage, tipping, or uncontrolled movement"},{"key":"B","text":"Roll it on its valve"},{"key":"C","text":"Lift it by the valve or service connection"},{"key":"D","text":"Leave it unsecured during transport"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant cylinders should be protected from physical damage and uncontrolled movement during handling and transport.'
),
(
  12,
  'multiple_choice',
  'application',
  'An apprentice is asked to connect gauges to a system containing refrigerant, but the certified technician leaves the work area to visit another job. What is the BEST response?',
  '[{"key":"A","text":"Proceed because the apprentice received instructions earlier"},{"key":"B","text":"Do not perform covered apprentice work unless the required close and continual supervision is being provided"},{"key":"C","text":"Proceed if the customer watches"},{"key":"D","text":"Connect only the high-side hose"}]'::jsonb,
  '["B"]'::jsonb,
  'The supervised-apprentice provision depends on close and continual supervision by a certified technician.'
),
(
  13,
  'multiple_choice',
  'application',
  'A new condensing unit requires a specific refrigerant. The installer has a cylinder with a similar but different refrigerant. What should the installer do?',
  '[{"key":"A","text":"Use the similar refrigerant because both are used in HVAC systems"},{"key":"B","text":"Use only the refrigerant specified for the equipment and approved procedure"},{"key":"C","text":"Blend the two refrigerants"},{"key":"D","text":"Charge by pressure until operation looks normal"}]'::jsonb,
  '["B"]'::jsonb,
  'Refrigerants are not automatically interchangeable; the specified refrigerant and approved service information should be followed.'
),
(
  14,
  'multiple_choice',
  'application',
  'A worker notices frost forming rapidly on a refrigerant connection during handling. What is the BEST response?',
  '[{"key":"A","text":"Touch the fitting with bare skin to find the leak"},{"key":"B","text":"Avoid skin contact and follow the appropriate procedure to control the refrigerant release"},{"key":"C","text":"Warm the fitting with an open flame"},{"key":"D","text":"Ignore it until the job is complete"}]'::jsonb,
  '["B"]'::jsonb,
  'Rapidly expanding refrigerant can create severe cold-contact hazards, so direct skin exposure should be avoided while the release is controlled.'
),
(
  15,
  'multiple_choice',
  'application',
  'A helper sees someone preparing to mix recovered refrigerant from two known different systems into the same cylinder. What is the BEST response?',
  '[{"key":"A","text":"Allow it because all recovered refrigerant is waste"},{"key":"B","text":"Stop and follow the company procedure for proper refrigerant segregation and recovery"},{"key":"C","text":"Mix them only if the cylinder is less than half full"},{"key":"D","text":"Add oil to stabilize the mixture"}]'::jsonb,
  '["B"]'::jsonb,
  'Mixing different refrigerants can contaminate the recovered material and complicate safe handling and reclamation.'
),
(
  16,
  'multiple_choice',
  'application',
  'A refrigerant service hose is visibly cracked near a fitting. What is the BEST action?',
  '[{"key":"A","text":"Use it only on the low side"},{"key":"B","text":"Remove it from service and use suitable service equipment in good condition"},{"key":"C","text":"Wrap it with tape and continue"},{"key":"D","text":"Use it only for recovery"}]'::jsonb,
  '["B"]'::jsonb,
  'Damaged hoses can leak refrigerant and expose workers, so defective service equipment should not remain in use.'
),
(
  17,
  'scenario',
  'scenario',
  'During installation, an apprentice begins disconnecting gauges and a noticeable amount of refrigerant starts escaping continuously. What is the BEST response?',
  '[{"key":"A","text":"Continue disconnecting and let the refrigerant escape"},{"key":"B","text":"Stop the uncontrolled release and follow the approved service or recovery procedure"},{"key":"C","text":"Move the hoses outdoors and continue venting"},{"key":"D","text":"Wait until the cylinder is empty"}]'::jsonb,
  '["B"]'::jsonb,
  'A continuing uncontrolled release should be stopped and managed using proper refrigerant-handling procedures rather than intentionally vented.'
),
(
  18,
  'scenario',
  'scenario',
  'A helper enters a small mechanical room and finds a strong refrigerant odor after a reported leak. The helper begins feeling dizzy. What should the helper do FIRST?',
  '[{"key":"A","text":"Stay and locate the leak"},{"key":"B","text":"Leave the affected area and initiate the appropriate emergency or supervisor response"},{"key":"C","text":"Turn on the equipment"},{"key":"D","text":"Use a dust mask and continue"}]'::jsonb,
  '["B"]'::jsonb,
  'Possible refrigerant exposure in a poorly ventilated space can create an atmospheric hazard; personal safety comes before leak diagnosis.'
),
(
  19,
  'scenario',
  'scenario',
  'An installer is told to release a small remaining refrigerant charge to atmosphere because recovering it will delay the job. What is the BEST response?',
  '[{"key":"A","text":"Release it because the amount is small"},{"key":"B","text":"Do not intentionally vent it; follow the applicable recovery and service requirements"},{"key":"C","text":"Release it only after dark"},{"key":"D","text":"Ask the customer to release it"}]'::jsonb,
  '["B"]'::jsonb,
  'Job schedule pressure does not justify intentional refrigerant venting outside applicable permitted releases.'
),
(
  20,
  'scenario',
  'scenario',
  'A recovery cylinder is already labeled for one refrigerant when a technician asks a helper to add recovered refrigerant of a different type. What is the BEST response?',
  '[{"key":"A","text":"Add it because both refrigerants came from HVAC equipment"},{"key":"B","text":"Stop and use the appropriate identified recovery container and segregation procedure"},{"key":"C","text":"Add it only if the second amount is small"},{"key":"D","text":"Remove the cylinder label first"}]'::jsonb,
  '["B"]'::jsonb,
  'Recovered refrigerants should be handled in a way that avoids inappropriate mixing and preserves correct identification.'
);

create temporary table _seed_hvac_refrigerant_safety_environmental_practices_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_safety_environmental_practices_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should HVAC design and sales personnel understand refrigerant type when selecting equipment?',
  '[{"key":"A","text":"Refrigerant affects equipment application, service requirements, safety considerations, and environmental compliance"},{"key":"B","text":"Refrigerant type only affects cabinet color"},{"key":"C","text":"All HVAC refrigerants are interchangeable"},{"key":"D","text":"Refrigerant matters only after the warranty expires"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection should account for the specified refrigerant because it affects application, service practices, safety, and compliance.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the BEST general description of EPA Section 608 technician certification?',
  '[{"key":"A","text":"A certification requirement for technicians performing covered refrigerant-service activities"},{"key":"B","text":"A building permit for installing thermostats"},{"key":"C","text":"A license required for selling all HVAC equipment"},{"key":"D","text":"A manufacturer warranty registration"}]'::jsonb,
  '["A"]'::jsonb,
  'Section 608 technician certification applies to covered activities involving regulated refrigerants.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is generally prohibited during covered HVAC service under refrigerant-management requirements?',
  '[{"key":"A","text":"Intentional venting of regulated refrigerant except for limited permitted releases"},{"key":"B","text":"Using recovery equipment"},{"key":"C","text":"Identifying the refrigerant before service"},{"key":"D","text":"Recording refrigerant information"}]'::jsonb,
  '["A"]'::jsonb,
  'Intentional venting is generally prohibited during maintenance, service, repair, and disposal, subject to limited exceptions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should different recovered refrigerants normally be kept properly identified and segregated?',
  '[{"key":"A","text":"To avoid contamination and improper handling"},{"key":"B","text":"To reduce electrical demand"},{"key":"C","text":"To improve thermostat communication"},{"key":"D","text":"To eliminate recovery requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper identification and segregation help prevent contamination and support correct recovery and reclamation practices.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why can refrigerant safety affect mechanical-room design?',
  '[{"key":"A","text":"A release can create atmospheric hazards that may need to be considered in equipment placement, ventilation, detection, and emergency planning"},{"key":"B","text":"Refrigerants make every mechanical room electrically classified"},{"key":"C","text":"Mechanical rooms cannot contain refrigerant equipment"},{"key":"D","text":"Refrigerant safety affects only exterior equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'System design should consider the consequences of a possible refrigerant release and applicable safety requirements for occupied or enclosed spaces.'
),
(
  6,
  'multiple_choice',
  'application',
  'A design engineer is selecting replacement equipment that uses a different refrigerant from the existing system. What is the BEST approach?',
  '[{"key":"A","text":"Assume existing piping, components, and service practices remain compatible"},{"key":"B","text":"Evaluate equipment, refrigerant, piping, component, safety, and service compatibility before specifying the replacement"},{"key":"C","text":"Change only the equipment name in the proposal"},{"key":"D","text":"Let the installer determine compatibility after delivery"}]'::jsonb,
  '["B"]'::jsonb,
  'A refrigerant change can affect materials, components, service practices, and safety requirements and should be evaluated during design.'
),
(
  7,
  'multiple_choice',
  'application',
  'A customer asks for a proposal that assumes the existing refrigerant can simply be released during demolition. What is the BEST response?',
  '[{"key":"A","text":"Include venting because demolition work is exempt"},{"key":"B","text":"Include proper refrigerant recovery and handling in the demolition scope"},{"key":"C","text":"Allow the demolition contractor to decide whether venting is acceptable"},{"key":"D","text":"Delete refrigerant work from the proposal"}]'::jsonb,
  '["B"]'::jsonb,
  'Project scope should account for compliant recovery and handling rather than assuming refrigerant may be intentionally released.'
),
(
  8,
  'multiple_choice',
  'application',
  'A mechanical room contains a large refrigerant charge in a relatively small enclosed space. What should the design team do?',
  '[{"key":"A","text":"Ignore the charge because the equipment is factory sealed"},{"key":"B","text":"Evaluate applicable refrigerant safety requirements, room volume, ventilation, detection, and other required safeguards"},{"key":"C","text":"Add a larger thermostat"},{"key":"D","text":"Place the equipment closer together"}]'::jsonb,
  '["B"]'::jsonb,
  'A significant refrigerant charge in an enclosed space should be evaluated against applicable safety and design requirements.'
),
(
  9,
  'multiple_choice',
  'application',
  'A proposal includes reclaiming refrigerant from equipment being replaced. What should the scope communicate?',
  '[{"key":"A","text":"That refrigerant will be handled using appropriate recovery, identification, transport, and reclamation practices"},{"key":"B","text":"That all refrigerant will be vented outdoors"},{"key":"C","text":"That mixed refrigerants can always be reused directly"},{"key":"D","text":"That refrigerant handling is unrelated to project planning"}]'::jsonb,
  '["A"]'::jsonb,
  'The project scope should reflect responsible refrigerant recovery and downstream handling rather than vague or noncompliant disposal assumptions.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer wants to reuse an unidentified refrigerant charge from existing equipment in new equipment. What is the BEST design-and-sales response?',
  '[{"key":"A","text":"Approve reuse because refrigerant is expensive"},{"key":"B","text":"Do not assume suitability; require proper identification and confirmation of compatibility before reuse is considered"},{"key":"C","text":"Blend it with the new refrigerant"},{"key":"D","text":"Use it only during startup"}]'::jsonb,
  '["B"]'::jsonb,
  'Unknown refrigerant should not be assumed suitable for reuse without identification and confirmation that it matches the equipment requirements.'
),
(
  11,
  'multiple_choice',
  'application',
  'A system proposal specifies a refrigerant that requires different service tools or procedures from the customer''s existing equipment. What should the proposal team consider?',
  '[{"key":"A","text":"Training, service equipment, technician capability, and lifecycle support requirements"},{"key":"B","text":"Only the equipment purchase price"},{"key":"C","text":"Only the thermostat model"},{"key":"D","text":"Nothing, because service practices do not affect system selection"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection should consider whether the organization can safely and competently service the selected refrigerant system throughout its lifecycle.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer asks whether an uncertified employee can independently perform covered refrigerant service after installation. What is the BEST response?',
  '[{"key":"A","text":"Yes, if the employee has worked in HVAC for one year"},{"key":"B","text":"Covered work generally requires the appropriate Section 608 certification, except where an applicable supervised-apprentice provision is satisfied"},{"key":"C","text":"Yes, if the equipment is under warranty"},{"key":"D","text":"Yes, if the refrigerant charge is small"}]'::jsonb,
  '["B"]'::jsonb,
  'Covered refrigerant-service work generally requires technician certification, subject to applicable provisions such as supervised apprenticeship.'
),
(
  13,
  'multiple_choice',
  'application',
  'A design review identifies service valves positioned where future technicians would have poor access during recovery. What is the BEST response?',
  '[{"key":"A","text":"Ignore it because recovery is a service issue"},{"key":"B","text":"Coordinate equipment placement or service access so refrigerant work can be performed safely and effectively"},{"key":"C","text":"Remove the service valves"},{"key":"D","text":"Tell future technicians to use longer hoses"}]'::jsonb,
  '["B"]'::jsonb,
  'Design should support safe serviceability, including practical access for refrigerant recovery and charging activities.'
),
(
  14,
  'multiple_choice',
  'application',
  'A project changes from one refrigerant to another late in design. What should be reviewed?',
  '[{"key":"A","text":"Equipment selection, piping, controls, safety requirements, service procedures, documentation, and proposal assumptions affected by the change"},{"key":"B","text":"Only the equipment model number"},{"key":"C","text":"Only the project title block"},{"key":"D","text":"Nothing if system capacity is unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'A refrigerant change can affect multiple design, service, and safety assumptions and should be coordinated comprehensively.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer wants to replace several systems but asks that recovered refrigerant be combined into one cylinder to reduce handling costs. The systems use different refrigerants. What is the BEST proposal response?',
  '[{"key":"A","text":"Agree because all refrigerant will eventually be reclaimed"},{"key":"B","text":"Require appropriate segregation and handling of the different refrigerants rather than intentionally mixing them"},{"key":"C","text":"Mix only equal quantities"},{"key":"D","text":"Vent the smaller quantity"}]'::jsonb,
  '["B"]'::jsonb,
  'Project planning should avoid intentional mixing that contaminates recovered refrigerant and complicates proper downstream handling.'
),
(
  16,
  'scenario',
  'scenario',
  'A design places refrigerant-containing equipment in a small enclosed room, and the estimated charge could create a serious exposure if released. What is the BEST next step?',
  '[{"key":"A","text":"Proceed because leaks are unlikely"},{"key":"B","text":"Evaluate applicable safety limits and required ventilation, detection, equipment-location, or other mitigation before issuing the design"},{"key":"C","text":"Add a warning sign only"},{"key":"D","text":"Reduce lighting in the room"}]'::jsonb,
  '["B"]'::jsonb,
  'Design should address foreseeable refrigerant-release hazards rather than relying solely on the assumption that leaks will not occur.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer requests a fixed price for equipment replacement but wants refrigerant recovery excluded because they believe the demolition crew can release the charge outside. What is the BEST response?',
  '[{"key":"A","text":"Exclude recovery to remain competitive"},{"key":"B","text":"Explain that the project scope needs compliant refrigerant recovery and handling and price the work accordingly"},{"key":"C","text":"State that outside venting is automatically acceptable"},{"key":"D","text":"Remove refrigerant references from the contract"}]'::jsonb,
  '["B"]'::jsonb,
  'Sales and estimating should not create a scope that depends on intentional venting or other noncompliant refrigerant practices.'
),
(
  18,
  'scenario',
  'scenario',
  'A replacement-system submittal shows a refrigerant different from what was specified, but capacity and efficiency are equivalent. What should the design engineer do?',
  '[{"key":"A","text":"Approve it because capacity is unchanged"},{"key":"B","text":"Review the refrigerant change for equipment, safety, service, piping, environmental, and project-document impacts before approval"},{"key":"C","text":"Change the refrigerant name on the schedule only"},{"key":"D","text":"Let the installer decide on site"}]'::jsonb,
  '["B"]'::jsonb,
  'Equivalent capacity does not mean a refrigerant change is technically or operationally equivalent.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer wants its maintenance staff to service newly selected refrigerant equipment, but none of the staff has the needed training or certification. What is the BEST design-and-sales response?',
  '[{"key":"A","text":"Ignore future service capability because installation is the only project concern"},{"key":"B","text":"Identify the training, certification, tools, and service-support gap before finalizing the solution"},{"key":"C","text":"Tell staff to learn during the first repair"},{"key":"D","text":"Remove service valves from the equipment"}]'::jsonb,
  '["B"]'::jsonb,
  'Lifecycle support and workforce readiness are legitimate equipment-selection considerations when refrigerant service requirements change.'
),
(
  20,
  'scenario',
  'scenario',
  'A project team discovers that existing drawings identify the wrong refrigerant for several systems being replaced. What is the BEST response?',
  '[{"key":"A","text":"Use the drawing information because it is official"},{"key":"B","text":"Field-verify the actual refrigerants and correct project documentation before recovery, equipment selection, or disposal planning proceeds"},{"key":"C","text":"Assume all systems use the newest refrigerant"},{"key":"D","text":"Recover everything into one unidentified cylinder"}]'::jsonb,
  '["B"]'::jsonb,
  'Incorrect refrigerant documentation can create equipment, handling, and compliance errors and should be resolved before project execution.'
);

create temporary table _seed_hvac_refrigerant_safety_environmental_practices_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_safety_environmental_practices_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Refrigerant Safety & Environmental Practices?',
  '[{"key":"A","text":"Following refrigerant instructions only when supervised"},{"key":"B","text":"Independently identifying refrigerant hazards, using compliant recovery and handling practices, and stopping work when conditions exceed training or authority"},{"key":"C","text":"Venting small refrigerant quantities when recovery is inconvenient"},{"key":"D","text":"Treating all refrigerants as interchangeable"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent and compliant refrigerant handling, hazard recognition, and judgment within the technician''s qualification.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is refrigerant identification important before recovery?',
  '[{"key":"A","text":"It helps prevent contamination and ensures the refrigerant is handled using appropriate procedures"},{"key":"B","text":"It determines thermostat voltage"},{"key":"C","text":"It eliminates the need for a recovery cylinder"},{"key":"D","text":"It matters only for billing"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct refrigerant identification supports proper recovery, segregation, service, and downstream handling.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST general approach when a technician encounters an unknown refrigerant?',
  '[{"key":"A","text":"Assume it is the refrigerant listed on the oldest service record"},{"key":"B","text":"Stop and positively identify the refrigerant before recovery, charging, or reuse decisions"},{"key":"C","text":"Mix it with a known refrigerant and test the result"},{"key":"D","text":"Vent a sample to identify it by odor"}]'::jsonb,
  '["B"]'::jsonb,
  'Unknown refrigerant should be positively identified before handling because misidentification can create contamination, equipment, and safety problems.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why can a refrigerant leak in an enclosed mechanical room be dangerous even if the refrigerant is not highly toxic?',
  '[{"key":"A","text":"A large release can displace oxygen or otherwise create an unsafe atmosphere"},{"key":"B","text":"Every refrigerant instantly becomes flammable"},{"key":"C","text":"Refrigerants eliminate electrical grounding"},{"key":"D","text":"Leaks always cause immediate equipment explosion"}]'::jsonb,
  '["A"]'::jsonb,
  'A significant refrigerant release can create an unsafe atmosphere, particularly in confined or poorly ventilated spaces.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician begins recovering refrigerant and the cylinder contents are uncertain. What is the BEST action?',
  '[{"key":"A","text":"Continue because the cylinder has available capacity"},{"key":"B","text":"Stop and confirm the cylinder identity and suitability before continuing recovery"},{"key":"C","text":"Add the refrigerant and label it later"},{"key":"D","text":"Vent the cylinder first"}]'::jsonb,
  '["B"]'::jsonb,
  'An uncertain recovery cylinder should not be used until its contents and suitability are known.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician sees frost forming on a service connection and suspects liquid refrigerant is escaping. What is the BEST response?',
  '[{"key":"A","text":"Touch the fitting to locate the leak"},{"key":"B","text":"Avoid skin contact, control the release, and follow the appropriate service procedure"},{"key":"C","text":"Warm the fitting with an open flame"},{"key":"D","text":"Continue working until the system pressure drops"}]'::jsonb,
  '["B"]'::jsonb,
  'Rapid refrigerant expansion can create severe cold-contact hazards, so the release should be controlled without direct skin exposure.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician is asked to add recovered refrigerant from a second system to a cylinder that already contains a different refrigerant. What is the BEST response?',
  '[{"key":"A","text":"Mix them if the cylinder is less than half full"},{"key":"B","text":"Use proper segregation and an appropriate identified recovery container"},{"key":"C","text":"Blend the refrigerants and record both names"},{"key":"D","text":"Vent the smaller amount"}]'::jsonb,
  '["B"]'::jsonb,
  'Different refrigerants should not be intentionally mixed during recovery because contamination complicates proper handling and reclamation.'
),
(
  8,
  'multiple_choice',
  'application',
  'A recovery cylinder is approaching its allowable fill limit. What should the technician do?',
  '[{"key":"A","text":"Continue until no more refrigerant will enter"},{"key":"B","text":"Stop transfer and manage the cylinder according to its approved capacity and procedure"},{"key":"C","text":"Vent some refrigerant to create space"},{"key":"D","text":"Heat the cylinder to increase capacity"}]'::jsonb,
  '["B"]'::jsonb,
  'Recovery cylinders should not be overfilled because excessive fill can create dangerous pressure conditions.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician notices a cracked recovery hose during a service call. What is the BEST action?',
  '[{"key":"A","text":"Use it only on the low side"},{"key":"B","text":"Remove it from service and replace it with suitable equipment"},{"key":"C","text":"Wrap it with tape and continue"},{"key":"D","text":"Use it only for vapor recovery"}]'::jsonb,
  '["B"]'::jsonb,
  'Damaged service equipment can leak refrigerant and should be removed from use.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician is servicing equipment with a refrigerant that requires procedures or tools unfamiliar to the technician. What is the BEST response?',
  '[{"key":"A","text":"Proceed because all refrigerants are serviced the same way"},{"key":"B","text":"Stop and obtain the required information, tools, training, or qualified assistance before continuing"},{"key":"C","text":"Use procedures from a similar refrigerant"},{"key":"D","text":"Ask the customer how the previous technician serviced it"}]'::jsonb,
  '["B"]'::jsonb,
  'Technicians should not improvise when unfamiliar refrigerants or equipment require different safe-service practices.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician is preparing to open a refrigerant circuit for repair. What should happen first?',
  '[{"key":"A","text":"Open the circuit quickly"},{"key":"B","text":"Follow the applicable recovery and pressure-control procedure before opening the system"},{"key":"C","text":"Turn the thermostat off only"},{"key":"D","text":"Release refrigerant until gauge pressure is zero"}]'::jsonb,
  '["B"]'::jsonb,
  'Refrigerant should be properly recovered or otherwise handled according to applicable procedures before the circuit is opened.'
),
(
  12,
  'scenario',
  'scenario',
  'During recovery, a technician realizes the equipment nameplate and service records identify different refrigerants. What is the BEST response?',
  '[{"key":"A","text":"Trust the newer-looking label"},{"key":"B","text":"Stop and positively identify the refrigerant before continuing recovery or reuse decisions"},{"key":"C","text":"Recover into a mixed-refrigerant cylinder"},{"key":"D","text":"Vent a small amount to determine the type"}]'::jsonb,
  '["B"]'::jsonb,
  'Conflicting refrigerant information should be resolved before handling to avoid contamination or unsafe service.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician enters a small mechanical room after a refrigerant alarm and immediately feels lightheaded. What is the BEST immediate response?',
  '[{"key":"A","text":"Remain inside and locate the leak"},{"key":"B","text":"Leave the area, prevent additional exposure, and initiate the appropriate emergency response"},{"key":"C","text":"Open the equipment cabinet and continue troubleshooting"},{"key":"D","text":"Use a dust mask"}]'::jsonb,
  '["B"]'::jsonb,
  'Possible atmospheric refrigerant exposure requires immediate removal from the hazard before diagnosis proceeds.'
),
(
  14,
  'scenario',
  'scenario',
  'A customer asks a technician to release a small remaining charge because recovery will take too long. What is the BEST response?',
  '[{"key":"A","text":"Release it because the amount is small"},{"key":"B","text":"Decline intentional venting and follow the applicable recovery requirements"},{"key":"C","text":"Release it outdoors only"},{"key":"D","text":"Ask the customer to release it"}]'::jsonb,
  '["B"]'::jsonb,
  'Schedule pressure does not justify intentional venting outside applicable permitted releases.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician discovers that recovered refrigerant from two different systems has accidentally been combined in one cylinder. What is the BEST response?',
  '[{"key":"A","text":"Use the mixture in either system"},{"key":"B","text":"Identify and quarantine the contaminated refrigerant and follow the appropriate company or reclamation procedure"},{"key":"C","text":"Add more of one refrigerant until the mixture is mostly uniform"},{"key":"D","text":"Vent the cylinder"}]'::jsonb,
  '["B"]'::jsonb,
  'Mixed refrigerants should be treated as contaminated material and handled through the appropriate recovery or reclamation process.'
),
(
  16,
  'scenario',
  'scenario',
  'A recovery cylinder becomes unusually hot and pressure rises rapidly during transfer. What is the BEST response?',
  '[{"key":"A","text":"Continue until the transfer is complete"},{"key":"B","text":"Stop the transfer and evaluate the cylinder, fill condition, temperature, and recovery setup before continuing"},{"key":"C","text":"Cool it with an open flame shield"},{"key":"D","text":"Vent refrigerant to reduce pressure"}]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected cylinder heating or pressure rise indicates a potentially unsafe condition that should be evaluated before transfer continues.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is assigned to service a system using a refrigerant the technician has never worked with. The manufacturer documentation lists different PPE and service procedures than the technician normally uses. What is the BEST response?',
  '[{"key":"A","text":"Use the technician''s usual procedure"},{"key":"B","text":"Follow the applicable manufacturer and safety requirements and obtain any needed training or equipment before service"},{"key":"C","text":"Ignore the differences because all HVAC refrigerants behave similarly"},{"key":"D","text":"Ask an apprentice to perform the unfamiliar steps"}]'::jsonb,
  '["B"]'::jsonb,
  'Different refrigerants and equipment may require different hazards controls, tools, and service practices.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician observes an apprentice performing covered refrigerant work while the certified supervising technician is working on another floor and cannot continuously observe or assist. What is the BEST response?',
  '[{"key":"A","text":"Allow the apprentice to continue because a certified person is somewhere in the building"},{"key":"B","text":"Stop the covered apprentice work until the required close and continual supervision can be provided"},{"key":"C","text":"Have the customer supervise instead"},{"key":"D","text":"Allow only high-side work"}]'::jsonb,
  '["B"]'::jsonb,
  'The apprentice provision requires close and continual supervision, not merely the presence of a certified technician elsewhere.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds a system with an unknown refrigerant and a partially full recovery cylinder with no readable label. What is the BEST approach?',
  '[{"key":"A","text":"Use the cylinder because both are unknown"},{"key":"B","text":"Stop and establish the identity and proper handling path for both the system refrigerant and recovery container"},{"key":"C","text":"Combine them and send the cylinder for disposal"},{"key":"D","text":"Vent both"}]'::jsonb,
  '["B"]'::jsonb,
  'Two unknowns compound the risk of contamination and improper handling and should be resolved before recovery proceeds.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes a repair and discovers the recovered refrigerant cylinder documentation is incomplete. The refrigerant is expected to be reused later. What is the BEST response?',
  '[{"key":"A","text":"Return the cylinder to storage without identification"},{"key":"B","text":"Correct the identification and handling documentation according to company procedure before the cylinder is stored or reused"},{"key":"C","text":"Write only the technician''s initials on it"},{"key":"D","text":"Transfer it into another unlabeled cylinder"}]'::jsonb,
  '["B"]'::jsonb,
  'Accurate identification and handling records help prevent later contamination, misapplication, and unsafe reuse.'
);

create temporary table _seed_hvac_refrigerant_safety_environmental_practices_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_safety_environmental_practices_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Refrigerant Safety & Environmental Practices?',
  '[{"key":"A","text":"Following refrigerant procedures only for personal service calls"},{"key":"B","text":"Leading compliant refrigerant practices, validating procedures, coaching technicians, and correcting recurring handling or environmental risks"},{"key":"C","text":"Allowing experienced technicians to choose their own refrigerant-handling methods"},{"key":"D","text":"Prioritizing recovery speed over refrigerant identification"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes leadership, validation, coaching, and correction of systemic refrigerant-safety and environmental weaknesses.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the BEST senior-level response when technicians repeatedly encounter refrigerants that do not match equipment labels or service records?',
  '[{"key":"A","text":"Tell technicians to use their best judgment each time"},{"key":"B","text":"Address each immediate case and investigate the broader documentation, labeling, or asset-management problem causing repeated discrepancies"},{"key":"C","text":"Assume the nameplate is always correct"},{"key":"D","text":"Recover all unknown refrigerants into one cylinder"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated refrigerant-identification failures indicate a systemic issue that should be corrected beyond the individual service call.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a senior HVAC technician evaluate refrigerant changes as a lifecycle issue rather than only an installation issue?',
  '[{"key":"A","text":"Refrigerant selection can affect safety, tools, training, service procedures, documentation, recovery, and long-term support"},{"key":"B","text":"Refrigerant affects only first cost"},{"key":"C","text":"All refrigerants require identical service practices"},{"key":"D","text":"Lifecycle considerations apply only to chillers"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant selection has ongoing workforce, safety, service, environmental, and support implications throughout equipment life.'
),
(
  4,
  'multiple_choice',
  'application',
  'A lead technician discovers that technicians are using one recovery cylinder for several different refrigerants because the branch office has limited cylinder inventory. What is the BEST response?',
  '[{"key":"A","text":"Allow it if each transfer is documented"},{"key":"B","text":"Stop the mixing practice and correct the equipment, inventory, and procedure gap that is causing it"},{"key":"C","text":"Allow mixing only for small quantities"},{"key":"D","text":"Vent recovered refrigerant when cylinders are unavailable"}]'::jsonb,
  '["B"]'::jsonb,
  'A recurring cylinder shortage that drives improper refrigerant mixing is both an immediate and systemic process problem.'
),
(
  5,
  'multiple_choice',
  'application',
  'A company is beginning service on equipment using a refrigerant unfamiliar to most technicians. What should the senior technical lead do before broad field rollout?',
  '[{"key":"A","text":"Let technicians learn during live service calls"},{"key":"B","text":"Verify hazards, service procedures, required tools, PPE, training, certification implications, and support resources before assigning independent work"},{"key":"C","text":"Issue the refrigerant name only"},{"key":"D","text":"Rely on equipment distributors to answer questions after problems occur"}]'::jsonb,
  '["B"]'::jsonb,
  'New refrigerant platforms should be supported with deliberate readiness planning before technicians are exposed to unfamiliar work.'
),
(
  6,
  'multiple_choice',
  'application',
  'A branch audit finds several recovery cylinders with incomplete or inconsistent identification. What is the BEST lead response?',
  '[{"key":"A","text":"Relabel them based on color"},{"key":"B","text":"Quarantine uncertain cylinders, determine contents through the approved process, and correct the labeling and tracking practice"},{"key":"C","text":"Use the cylinders only for disposal work"},{"key":"D","text":"Combine their contents into one cylinder"}]'::jsonb,
  '["B"]'::jsonb,
  'Uncertain refrigerant containers should be controlled and properly identified rather than guessed at or mixed.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician reports that a recovery procedure routinely causes cylinders to approach their fill limits before the expected amount of refrigerant is removed. What is the BEST senior response?',
  '[{"key":"A","text":"Tell technicians to continue until the cylinder is full"},{"key":"B","text":"Review cylinder sizing, expected charge, recovery planning, weighing practices, and procedure adequacy before the next job"},{"key":"C","text":"Vent excess refrigerant when necessary"},{"key":"D","text":"Remove the scale from the recovery setup"}]'::jsonb,
  '["B"]'::jsonb,
  'A recurring approach-to-overfill condition signals a planning or procedural weakness that should be corrected proactively.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer requests service practices that would intentionally vent refrigerant to shorten downtime. What is the BEST senior response?',
  '[{"key":"A","text":"Approve the practice if the customer accepts responsibility"},{"key":"B","text":"Reject the noncompliant approach and develop a recovery and service plan that meets applicable requirements"},{"key":"C","text":"Allow venting only outdoors"},{"key":"D","text":"Allow it for critical equipment"}]'::jsonb,
  '["B"]'::jsonb,
  'Customer pressure does not justify intentional venting outside applicable permitted releases.'
),
(
  9,
  'multiple_choice',
  'application',
  'A company is standardizing replacement equipment around a new refrigerant. What should the senior HVAC lead evaluate besides equipment performance?',
  '[{"key":"A","text":"Technician readiness, tools, recovery equipment, storage, documentation, emergency procedures, and service support"},{"key":"B","text":"Only equipment efficiency"},{"key":"C","text":"Only equipment color and dimensions"},{"key":"D","text":"Only first-year warranty cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A refrigerant-platform transition affects the full service ecosystem and should be planned accordingly.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician reports that service documentation directs workers to reuse recovered refrigerant without confirming its identity or condition. What is the BEST response?',
  '[{"key":"A","text":"Follow the documentation because it is written"},{"key":"B","text":"Stop relying on the flawed instruction and route the procedure for technical correction before reuse continues"},{"key":"C","text":"Reuse only half the recovered charge"},{"key":"D","text":"Add new refrigerant to dilute contamination"}]'::jsonb,
  '["B"]'::jsonb,
  'Written procedures should be corrected when they direct technicians toward unsafe or unreliable refrigerant handling.'
),
(
  11,
  'scenario',
  'scenario',
  'A near miss occurs when a technician begins recovering refrigerant into a cylinder believed to contain the same refrigerant, but the cylinder is later found to contain a different type. No injury occurs. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Relabel the cylinder and continue normal operations"},{"key":"B","text":"Control the contaminated material and investigate the identification, cylinder-management, and training failures that allowed the error"},{"key":"C","text":"Tell the technician to read labels more carefully"},{"key":"D","text":"Vent the mixed refrigerant"}]'::jsonb,
  '["B"]'::jsonb,
  'A near miss involving refrigerant contamination should trigger both immediate control and review of the system that allowed misidentification.'
),
(
  12,
  'scenario',
  'scenario',
  'A large refrigerant leak occurs in an enclosed mechanical room. Building staff want the HVAC lead to send a technician inside immediately to isolate the leak, but the atmosphere has not been evaluated. What is the BEST response?',
  '[{"key":"A","text":"Send the most experienced technician inside"},{"key":"B","text":"Prevent entry until the atmospheric hazard and required emergency controls are properly evaluated"},{"key":"C","text":"Send two technicians instead of one"},{"key":"D","text":"Use dust masks and enter"}]'::jsonb,
  '["B"]'::jsonb,
  'An unevaluated refrigerant release can create a dangerous atmosphere; worker entry should not occur until appropriate emergency controls are established.'
),
(
  13,
  'scenario',
  'scenario',
  'A senior technician learns that apprentices have routinely been performing covered refrigerant work while certified technicians are merely available by phone. What is the BEST response?',
  '[{"key":"A","text":"Continue because phone contact counts as supervision"},{"key":"B","text":"Stop the practice and correct supervision, training, and assignment procedures to meet applicable requirements"},{"key":"C","text":"Allow it only for residential systems"},{"key":"D","text":"Have apprentices sign a waiver"}]'::jsonb,
  '["B"]'::jsonb,
  'The supervised-apprentice provision requires close and continual supervision, not remote availability alone.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician reports that a new refrigerant causes unfamiliar pressure and temperature behavior compared with the company''s older equipment. Several technicians have begun using old charging rules anyway. What is the BEST response?',
  '[{"key":"A","text":"Allow experienced technicians to adapt informally"},{"key":"B","text":"Stop the unsupported practice and provide the correct manufacturer, refrigerant, tool, and training guidance before independent work continues"},{"key":"C","text":"Use the old rules only during mild weather"},{"key":"D","text":"Charge every system to the same pressure"}]'::jsonb,
  '["B"]'::jsonb,
  'Unfamiliar refrigerants should be serviced using current approved procedures rather than habits carried over from different systems.'
),
(
  15,
  'scenario',
  'scenario',
  'A branch repeatedly receives recovered refrigerant cylinders with missing paperwork, making reuse or reclamation decisions uncertain. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Let the reclamation vendor determine everything later"},{"key":"B","text":"Correct the chain-of-identification and documentation process so cylinders remain traceable from recovery through storage and disposition"},{"key":"C","text":"Store unidentified cylinders indefinitely"},{"key":"D","text":"Combine all recovered refrigerant at the end of each month"}]'::jsonb,
  '["B"]'::jsonb,
  'Recurring documentation gaps require a controlled process that preserves refrigerant identity and handling information.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer facility is converting many systems to a different refrigerant platform. The service department has not yet obtained suitable recovery equipment or technician training. Installation is scheduled to begin next week. What is the BEST senior response?',
  '[{"key":"A","text":"Proceed because service needs will occur later"},{"key":"B","text":"Escalate the readiness gap and ensure required service capability, tools, procedures, and training are addressed as part of the transition"},{"key":"C","text":"Tell technicians to borrow tools when service is needed"},{"key":"D","text":"Exclude refrigerant service from company responsibility"}]'::jsonb,
  '["B"]'::jsonb,
  'A major refrigerant transition should include workforce and service readiness rather than leaving known support gaps unresolved.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is injured by liquid refrigerant contact while disconnecting a hose. The worker says the fitting has leaked this way before and several technicians use the same technique. What is the BEST lead response?',
  '[{"key":"A","text":"Treat only the worker and keep the procedure unchanged"},{"key":"B","text":"Address the injury and immediate hazard, then investigate the recurring equipment or work-practice problem and correct the procedure"},{"key":"C","text":"Tell technicians to wear thicker gloves without reviewing the task"},{"key":"D","text":"Stop using service hoses entirely"}]'::jsonb,
  '["B"]'::jsonb,
  'A repeated exposure mechanism indicates a process or equipment issue requiring corrective action beyond the individual incident.'
),
(
  18,
  'scenario',
  'scenario',
  'A senior technician discovers that an equipment database lists the same model as using two different refrigerants depending on installation year, but asset records do not identify the year reliably. What is the BEST response before planning a large recovery project?',
  '[{"key":"A","text":"Assume all units use the newer refrigerant"},{"key":"B","text":"Establish a reliable field-verification process and correct asset records before recovery planning proceeds"},{"key":"C","text":"Recover all units into one cylinder type"},{"key":"D","text":"Use refrigerant color as the only identification method"}]'::jsonb,
  '["B"]'::jsonb,
  'Where asset data cannot reliably identify refrigerant, field verification and record correction are needed before large-scale handling.'
),
(
  19,
  'scenario',
  'scenario',
  'A project manager pressures the service team to reuse recovered refrigerant of uncertain quality because replacement refrigerant is delayed. What is the BEST senior response?',
  '[{"key":"A","text":"Reuse it because schedule pressure outweighs uncertainty"},{"key":"B","text":"Do not approve reuse until identity, suitability, and handling requirements are satisfied; escalate the material constraint instead"},{"key":"C","text":"Mix it with new refrigerant"},{"key":"D","text":"Use it only on less important equipment"}]'::jsonb,
  '["B"]'::jsonb,
  'Schedule pressure should not override basic refrigerant identification, suitability, and safe-handling requirements.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit finds that technicians understand recovery procedures individually, but branches use different cylinder labeling, storage, and disposition practices. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Allow each branch to continue its local method"},{"key":"B","text":"Standardize the critical identification, storage, handling, and disposition controls while preserving only justified local differences"},{"key":"C","text":"Stop tracking recovered refrigerant entirely"},{"key":"D","text":"Require all recovered refrigerant to be discarded"}]'::jsonb,
  '["B"]'::jsonb,
  'Inconsistent branch practices can create contamination and compliance risk and should be controlled through an appropriate standardized process.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b2bd3cea-5803-4d49-876c-bd435fbc7d24';
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
      and c.name = 'Refrigerant Safety & Environmental Practices'
      and c.is_current = true
  ) then
    raise exception 'Current Refrigerant Safety & Environmental Practices Master Competency not found';
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
  v_assessment_name := 'Refrigerant Safety & Environmental Practices — Level 1 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_safety_environmental_practices_l1_questions
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
        'Refrigerant Safety & Environmental Practices',
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
      'IntegrateU Refrigerant Safety & Environmental Practices L1 production assessment v1.0.',
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
        'Refrigerant Safety & Environmental Practices',
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
        'IntegrateU Refrigerant Safety & Environmental Practices L1 production assessment v1.0.',
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
  v_assessment_name := 'Refrigerant Safety & Environmental Practices — Level 2 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_safety_environmental_practices_l2_questions
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
        'Refrigerant Safety & Environmental Practices',
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
      'IntegrateU Refrigerant Safety & Environmental Practices L2 production assessment v1.0.',
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
        'Refrigerant Safety & Environmental Practices',
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
        'IntegrateU Refrigerant Safety & Environmental Practices L2 production assessment v1.0.',
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
  v_assessment_name := 'Refrigerant Safety & Environmental Practices — Level 3 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_safety_environmental_practices_l3_questions
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
        'Refrigerant Safety & Environmental Practices',
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
      'IntegrateU Refrigerant Safety & Environmental Practices L3 production assessment v1.0.',
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
        'Refrigerant Safety & Environmental Practices',
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
        'IntegrateU Refrigerant Safety & Environmental Practices L3 production assessment v1.0.',
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
  v_assessment_name := 'Refrigerant Safety & Environmental Practices — Level 4 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_safety_environmental_practices_l4_questions
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
        'Refrigerant Safety & Environmental Practices',
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
      'IntegrateU Refrigerant Safety & Environmental Practices L4 production assessment v1.0.',
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
        'Refrigerant Safety & Environmental Practices',
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
        'IntegrateU Refrigerant Safety & Environmental Practices L4 production assessment v1.0.',
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
   'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid
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
      'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid
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
  'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid;

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
    'b2bd3cea-5803-4d49-876c-bd435fbc7d24'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
