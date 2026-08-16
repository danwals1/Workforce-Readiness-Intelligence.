-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0150_ci_cabling_termination_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Cabling & Termination
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

create temporary table _seed_ci_cabling_termination_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_cabling_termination_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which cable type is commonly used for Ethernet network connections?',
  '[{"key":"A","text":"Category twisted-pair cable"},{"key":"B","text":"Speaker cable"},{"key":"C","text":"Two-conductor security cable"},{"key":"D","text":"RG6 used only as a speaker cable"}]'::jsonb,
  '["A"]'::jsonb,
  'Category twisted-pair cable is commonly used for Ethernet networking.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Which cable type is commonly associated with RF, antenna, satellite, and similar signal applications?',
  '[{"key":"A","text":"Coaxial cable"},{"key":"B","text":"Speaker cable"},{"key":"C","text":"Two-conductor control cable"},{"key":"D","text":"Fiber used only for power"}]'::jsonb,
  '["A"]'::jsonb,
  'Coaxial cable is commonly used for RF, antenna, satellite, and similar signal applications.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What distinguishes fiber-optic cable from copper communications cable?',
  '[{"key":"A","text":"It transmits information using light rather than electrical signals through copper conductors"},{"key":"B","text":"It can carry only audio"},{"key":"C","text":"It never requires connectors"},{"key":"D","text":"It is used only for security systems"}]'::jsonb,
  '["A"]'::jsonb,
  'Fiber-optic cable carries information using light rather than electrical signals through copper conductors.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of labeling a cable?',
  '[{"key":"A","text":"To identify the cable and its intended source, destination, or function"},{"key":"B","text":"To improve signal strength"},{"key":"C","text":"To eliminate the need for testing"},{"key":"D","text":"To change the cable category"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent labeling supports installation, testing, troubleshooting, documentation, and future service.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is cable bend radius important?',
  '[{"key":"A","text":"Excessive bending can damage the cable or degrade performance"},{"key":"B","text":"It determines the room number"},{"key":"C","text":"It changes the connector type"},{"key":"D","text":"It increases available voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Following applicable bend-radius requirements helps protect cable construction and performance.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should low-voltage cable be properly supported above a ceiling?',
  '[{"key":"A","text":"To protect the cable and maintain a professional, serviceable installation"},{"key":"B","text":"To increase network speed automatically"},{"key":"C","text":"To replace pathway planning"},{"key":"D","text":"To eliminate labeling"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper support protects installed cable and contributes to safe, professional workmanship.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is a service loop?',
  '[{"key":"A","text":"Extra usable cable length intentionally left for installation or future service"},{"key":"B","text":"A cable tied in a decorative circle"},{"key":"C","text":"A network troubleshooting command"},{"key":"D","text":"A temporary power circuit"}]'::jsonb,
  '["A"]'::jsonb,
  'A service loop provides usable cable length for installation, service, or future retermination.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should primarily determine which connector is installed on a cable?',
  '[{"key":"A","text":"Cable type, equipment interface, application, and project or manufacturer requirements"},{"key":"B","text":"Whichever connector is cheapest"},{"key":"C","text":"The connector the technician uses most often"},{"key":"D","text":"The cable jacket color"}]'::jsonb,
  '["A"]'::jsonb,
  'Connector selection should follow the cable type, equipment interface, application, and documented requirements.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician is preparing twisted-pair communications cable for termination. What should be avoided?',
  '[{"key":"A","text":"Unnecessarily untwisting a large portion of the conductor pairs"},{"key":"B","text":"Following the termination standard"},{"key":"C","text":"Inspecting the conductors"},{"key":"D","text":"Using the proper termination tool"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive untwisting can negatively affect twisted-pair cable performance.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician is terminating a connector. Why is using the proper tool important?',
  '[{"key":"A","text":"It helps produce a termination consistent with the cable and connector manufacturer requirements"},{"key":"B","text":"It guarantees testing is unnecessary"},{"key":"C","text":"Every connector uses exactly the same tool"},{"key":"D","text":"It automatically corrects wiring errors"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper tooling is part of producing a reliable termination.'
),
(
  11,
  'multiple_choice',
  'application',
  'Before beginning a cable pull, what should the technician verify?',
  '[{"key":"A","text":"The intended source, destination, cable type, pathway, and relevant project requirements"},{"key":"B","text":"Only the cable color"},{"key":"C","text":"Only the shortest possible route"},{"key":"D","text":"Only which technician is available"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper preparation reduces wrong pulls, damaged cable, rework, and installation delays.'
),
(
  12,
  'multiple_choice',
  'application',
  'A cable route passes through an area with potential interference or hazards. What should the installer do?',
  '[{"key":"A","text":"Follow the approved route and applicable separation, pathway, and project requirements"},{"key":"B","text":"Use the shortest route regardless of conditions"},{"key":"C","text":"Bundle the cable with any nearby wiring"},{"key":"D","text":"Ignore the condition because the cable is low voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable routing should consider pathway requirements, field conditions, interference, hazards, accessibility, and project documentation.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician finds visible jacket damage on a cable during installation. What is the BEST action?',
  '[{"key":"A","text":"Stop and evaluate the cable according to project and company requirements before continuing"},{"key":"B","text":"Hide the damaged section"},{"key":"C","text":"Cover it with tape automatically"},{"key":"D","text":"Terminate it first and inspect it later"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible cable damage can affect performance and reliability and should be evaluated before installation continues.'
),
(
  14,
  'multiple_choice',
  'application',
  'A cable has been pulled to its destination but has not yet been terminated. What should happen next?',
  '[{"key":"A","text":"Label and secure the cable according to the project standard"},{"key":"B","text":"Remove any temporary identification"},{"key":"C","text":"Leave it loose and identify it later by trial and error"},{"key":"D","text":"Cut off all extra cable immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable identification and management should be maintained throughout installation, not deferred until final testing.'
),
(
  15,
  'multiple_choice',
  'application',
  'Before terminating a cable at a finished device location, what should the technician verify?',
  '[{"key":"A","text":"Cable identity, intended device or connection, and visible cable condition"},{"key":"B","text":"Only the connector color"},{"key":"C","text":"Only whether the cable reaches the device"},{"key":"D","text":"Only the room number"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable identity, intended use, and physical condition should be confirmed before termination.'
),
(
  16,
  'multiple_choice',
  'application',
  'A cable must change direction sharply inside a pathway. What should the technician do?',
  '[{"key":"A","text":"Maintain the applicable bend radius instead of forcing a sharp bend"},{"key":"B","text":"Flatten the cable"},{"key":"C","text":"Remove the jacket at the bend"},{"key":"D","text":"Force the cable around the corner"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintaining appropriate bend radius helps avoid physical damage and performance degradation.'
),
(
  17,
  'scenario',
  'scenario',
  'The specified cable for a project is unavailable. Another cable physically fits the pathway. What is the BEST action?',
  '[{"key":"A","text":"Use the available cable because all low-voltage cables are interchangeable"},{"key":"B","text":"Install it and document the substitution afterward"},{"key":"C","text":"Verify the required specification and obtain approval before making a substitution"},{"key":"D","text":"Choose whichever cable has the largest diameter"}]'::jsonb,
  '["C"]'::jsonb,
  'Physical fit does not establish performance, code, manufacturer, or project-specification compatibility.'
),
(
  18,
  'scenario',
  'scenario',
  'During a cable pull, the cable suddenly becomes difficult to move and requires much more force. What should the technician do?',
  '[{"key":"A","text":"Pull harder until it moves"},{"key":"B","text":"Stop and investigate the obstruction or pathway before continuing"},{"key":"C","text":"Use a vehicle or powered device to increase force"},{"key":"D","text":"Remove the cable jacket"}]'::jsonb,
  '["B"]'::jsonb,
  'Excessive pulling force can damage cable, so the cause should be identified before continuing.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds several low-voltage cables lying unsupported across ceiling tiles. What is the BEST response?',
  '[{"key":"A","text":"Leave them because they are hidden"},{"key":"B","text":"Properly route and support them using the approved pathway or support method"},{"key":"C","text":"Attach them to the nearest plumbing pipe"},{"key":"D","text":"Bundle them around electrical conduit"}]'::jsonb,
  '["B"]'::jsonb,
  'Hidden work still needs to meet installation, support, and workmanship standards.'
),
(
  20,
  'scenario',
  'scenario',
  'A wall location has more cable than is needed for the immediate termination. What is the BEST approach?',
  '[{"key":"A","text":"Follow project requirements for service length, cable management, and future serviceability before trimming"},{"key":"B","text":"Cut away all extra cable immediately"},{"key":"C","text":"Push an uncontrolled bundle into the wall"},{"key":"D","text":"Remove the cable and pull a shorter one"}]'::jsonb,
  '["A"]'::jsonb,
  'Enough usable cable should remain for proper installation and future service while maintaining professional cable management.'
);

create temporary table _seed_ci_cabling_termination_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_cabling_termination_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should twisted-pair cable maintain the pair twists as close as practical to the termination point?',
  '[{"key":"A","text":"To help preserve the cable performance characteristics"},{"key":"B","text":"To increase conductor voltage"},{"key":"C","text":"To make the connector physically larger"},{"key":"D","text":"To eliminate the need for cable testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintaining pair geometry through the termination helps preserve the electrical characteristics of twisted-pair cabling.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the main purpose of testing a completed cable run?',
  '[{"key":"A","text":"To verify that the installed cable and terminations meet the required connectivity or performance criteria"},{"key":"B","text":"To replace cable labeling"},{"key":"C","text":"To determine the room paint color"},{"key":"D","text":"To eliminate project documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Testing provides evidence that the installed cable path and terminations satisfy the required criteria.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is maximum pulling tension important during cable installation?',
  '[{"key":"A","text":"Excessive pulling force can physically damage the cable and affect performance"},{"key":"B","text":"It determines the cable label format"},{"key":"C","text":"It changes the connector pinout"},{"key":"D","text":"It increases the cable category"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable manufacturers establish pulling limits because excessive mechanical stress can damage conductors, insulation, geometry, or other cable elements.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does a wiremap-type test primarily help identify on a twisted-pair cable?',
  '[{"key":"A","text":"Conductor continuity and termination errors such as opens, shorts, reversals, or miswires"},{"key":"B","text":"The client network password"},{"key":"C","text":"The mounting height of the device"},{"key":"D","text":"The available amplifier power"}]'::jsonb,
  '["A"]'::jsonb,
  'Wiremap testing helps verify that individual conductors are connected to the intended positions and can reveal common wiring faults.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should connector and termination hardware be compatible with the specific cable construction?',
  '[{"key":"A","text":"Cable geometry and conductor construction affect how the connector must make a reliable connection"},{"key":"B","text":"Every cable can use every connector if the color matches"},{"key":"C","text":"Compatibility matters only for fiber"},{"key":"D","text":"The connector automatically changes the cable specification"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable termination depends on using components designed for the cable type, conductor construction, application, and required performance.'
),
(
  6,
  'multiple_choice',
  'application',
  'A Category cable tests with an open conductor after termination. What should the technician do FIRST?',
  '[{"key":"A","text":"Inspect the affected termination and conductor path for an incomplete or damaged connection"},{"key":"B","text":"Replace the network switch"},{"key":"C","text":"Increase PoE power"},{"key":"D","text":"Change the device IP address"}]'::jsonb,
  '["A"]'::jsonb,
  'An open-conductor result points first toward the physical cable path or termination rather than unrelated active equipment.'
),
(
  7,
  'multiple_choice',
  'application',
  'A cable has been pulled with a severe kink in the middle of the run. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the cable against manufacturer and project requirements and replace it if its integrity or performance may be compromised"},{"key":"B","text":"Straighten it and automatically accept it"},{"key":"C","text":"Hide the kink above the ceiling"},{"key":"D","text":"Add another connector at the kink"}]'::jsonb,
  '["A"]'::jsonb,
  'A severe kink can alter cable geometry or damage internal elements and should not simply be hidden or assumed acceptable.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician is terminating shielded cabling. What should determine how the shield is handled?',
  '[{"key":"A","text":"The approved system design, cable and connector requirements, and manufacturer instructions"},{"key":"B","text":"The technician''s personal preference"},{"key":"C","text":"Whichever metal surface is closest"},{"key":"D","text":"The cable jacket color"}]'::jsonb,
  '["A"]'::jsonb,
  'Shield continuity and termination should follow the intended system design rather than improvised field practices.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician discovers that the cable label at one end does not match the label at the other end. What is the BEST action?',
  '[{"key":"A","text":"Trace and verify the actual run, then correct the identification before final acceptance"},{"key":"B","text":"Choose whichever label looks newer"},{"key":"C","text":"Remove both labels permanently"},{"key":"D","text":"Wait until a service call occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable identification must accurately represent the physical run so installation, testing, and future service can rely on it.'
),
(
  10,
  'multiple_choice',
  'application',
  'A cable path is nearly full and additional cables must be installed. What should the technician do?',
  '[{"key":"A","text":"Verify pathway capacity and project requirements before adding more cable"},{"key":"B","text":"Force the new cables into the pathway"},{"key":"C","text":"Remove labels to make more space"},{"key":"D","text":"Use smaller connectors"}]'::jsonb,
  '["A"]'::jsonb,
  'Pathway capacity and cable-management requirements should be considered before additional cable is installed.'
),
(
  11,
  'multiple_choice',
  'application',
  'A cable passes its basic continuity test but fails the required performance test. What should the technician conclude?',
  '[{"key":"A","text":"Electrical continuity alone does not prove that the installed link meets its required performance specification"},{"key":"B","text":"The performance test can be ignored"},{"key":"C","text":"Any cable with continuity is acceptable"},{"key":"D","text":"The failure must be caused by the active network switch"}]'::jsonb,
  '["A"]'::jsonb,
  'A cable can be electrically continuous yet still fail performance requirements because of termination quality, installation damage, excessive length, or other factors.'
),
(
  12,
  'multiple_choice',
  'application',
  'A copper communications cable has excessive jacket removed at the termination. Why can this be a concern?',
  '[{"key":"A","text":"It can expose conductors unnecessarily and disturb the cable geometry intended to be maintained near the connector"},{"key":"B","text":"It increases the cable category"},{"key":"C","text":"It improves shielding automatically"},{"key":"D","text":"It eliminates crosstalk"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable preparation should remove only what is required for the specified termination while preserving cable construction.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician is routing cable through a congested equipment rack. What is the BEST approach?',
  '[{"key":"A","text":"Maintain appropriate bend radius, support, identification, separation, and serviceability while following the rack and project design"},{"key":"B","text":"Pull every cable as tight as possible"},{"key":"C","text":"Remove labels after dressing"},{"key":"D","text":"Bundle all cable types together regardless of requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Rack cabling should remain organized, protected, identifiable, and serviceable while respecting cable-specific installation requirements.'
),
(
  14,
  'multiple_choice',
  'application',
  'A connector has been reterminated several times and the remaining cable is becoming too short for proper service. What should the technician do?',
  '[{"key":"A","text":"Evaluate the remaining service length and follow the approved repair or replacement method rather than forcing another marginal termination"},{"key":"B","text":"Stretch the conductors"},{"key":"C","text":"Remove the cable label"},{"key":"D","text":"Use any connector that reaches"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated retermination can consume service length and create an installation that is difficult to maintain or terminate reliably.'
),
(
  15,
  'scenario',
  'scenario',
  'A newly terminated Category cable shows split-pair behavior on the tester even though every pin has continuity. What is the BEST response?',
  '[{"key":"A","text":"Correct the pair assignments at the termination and retest the link"},{"key":"B","text":"Accept the cable because continuity exists"},{"key":"C","text":"Replace the network switch"},{"key":"D","text":"Increase PoE voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A split pair can maintain end-to-end continuity while violating the intended twisted-pair pairing and degrading link performance.'
),
(
  16,
  'scenario',
  'scenario',
  'Several cables routed through one pathway fail testing after construction. Inspection shows they were sharply compressed by an over-tightened support. What is the BEST response?',
  '[{"key":"A","text":"Assess and replace damaged cabling as required, correct the support method, and retest affected runs"},{"key":"B","text":"Loosen the support and automatically accept every cable"},{"key":"C","text":"Increase network transmit power"},{"key":"D","text":"Relabel the cables"}]'::jsonb,
  '["A"]'::jsonb,
  'Mechanical compression can damage cable geometry; both the affected cabling and the installation method should be addressed.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is asked to substitute a different connector because the specified model is out of stock. The replacement physically fits the cable. What is the BEST action?',
  '[{"key":"A","text":"Verify compatibility with the cable, required performance, application, tooling, and approved project requirements before substitution"},{"key":"B","text":"Use it because physical fit proves compatibility"},{"key":"C","text":"Install it without testing"},{"key":"D","text":"Modify the cable until it fits"}]'::jsonb,
  '["A"]'::jsonb,
  'Connector compatibility involves more than physical fit and should be validated before a substitution is made.'
),
(
  18,
  'scenario',
  'scenario',
  'A completed run passes immediately after termination but fails intermittently when the cable near the connector is moved. What is the BEST technical response?',
  '[{"key":"A","text":"Inspect the termination, strain relief, conductor engagement, and cable preparation, then reterminate or replace as required"},{"key":"B","text":"Assume intermittent behavior is normal"},{"key":"C","text":"Replace the active equipment first"},{"key":"D","text":"Secure the cable so nobody can move it and close the issue"}]'::jsonb,
  '["A"]'::jsonb,
  'Movement-related failures near a termination suggest a mechanical or conductor-connection problem that should be corrected rather than hidden.'
),
(
  19,
  'scenario',
  'scenario',
  'A project requires documented test results for every installed communications cable. A technician has tested the runs but did not save the results. What is the BEST response?',
  '[{"key":"A","text":"Retest as necessary and capture the required results so the installation has complete verification records"},{"key":"B","text":"Mark every run passed from memory"},{"key":"C","text":"Skip documentation because testing already occurred"},{"key":"D","text":"Save results for only the longest cable"}]'::jsonb,
  '["A"]'::jsonb,
  'Where test documentation is required, the recorded evidence is part of the completed installation.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician inherits a rack with poorly labeled cables and several unidentified patch connections. A device must be moved without disrupting unrelated systems. What is the BEST approach?',
  '[{"key":"A","text":"Trace and verify the relevant cable path, document the existing condition, identify the correct connection, and make the change in a controlled manner"},{"key":"B","text":"Disconnect cables one at a time until the correct device stops working"},{"key":"C","text":"Move every patch cable"},{"key":"D","text":"Rely only on cable color"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled tracing and documentation reduce the risk of disrupting unrelated systems when identification is unreliable.'
);

create temporary table _seed_ci_cabling_termination_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_cabling_termination_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary difference between basic continuity verification and cable certification?',
  '[{"key":"A","text":"Certification evaluates the installed link against defined performance requirements, while continuity primarily verifies conductor connectivity"},{"key":"B","text":"Continuity testing is always more comprehensive than certification"},{"key":"C","text":"Certification only checks cable labels"},{"key":"D","text":"There is no meaningful difference"}]'::jsonb,
  '["A"]'::jsonb,
  'Certification evaluates defined performance parameters in addition to basic connectivity.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why can excessive untwisting at a Category cable termination degrade performance?',
  '[{"key":"A","text":"It disrupts the pair geometry that helps control interference and crosstalk"},{"key":"B","text":"It increases conductor voltage"},{"key":"C","text":"It converts the cable to coaxial construction"},{"key":"D","text":"It changes the cable label"}]'::jsonb,
  '["A"]'::jsonb,
  'Twisted-pair geometry is part of the cable design and should be preserved through the termination as required.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is cable pathway planning important before large cable bundles are installed?',
  '[{"key":"A","text":"It helps manage capacity, support, bend radius, separation, accessibility, and future service requirements"},{"key":"B","text":"It eliminates the need for drawings"},{"key":"C","text":"It allows all cable types to be bundled together"},{"key":"D","text":"It guarantees active equipment configuration"}]'::jsonb,
  '["A"]'::jsonb,
  'Pathway planning affects installation quality, performance, maintainability, and the ability to support the required cable quantity.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of establishing a consistent cable labeling standard across a project?',
  '[{"key":"A","text":"To create reliable identification that supports installation, testing, documentation, troubleshooting, and future service"},{"key":"B","text":"To replace cable testing"},{"key":"C","text":"To indicate cable performance by label color alone"},{"key":"D","text":"To eliminate as-built documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A consistent identification standard allows multiple technicians and future service teams to understand the installed infrastructure.'
),
(
  5,
  'multiple_choice',
  'application',
  'Several Category links fail certification with similar performance symptoms after being installed in the same pathway. What should the technician evaluate?',
  '[{"key":"A","text":"Shared installation conditions such as routing, compression, bend radius, separation, pulling stress, and termination practices"},{"key":"B","text":"Only the device IP addresses"},{"key":"C","text":"Only the cable labels"},{"key":"D","text":"Only the rack paint color"}]'::jsonb,
  '["A"]'::jsonb,
  'Similar failures across multiple links can indicate a common installation or workmanship issue rather than isolated endpoint failures.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician must reterminate a failed cable in a crowded rack. What should be verified before cutting the existing connector off?',
  '[{"key":"A","text":"Correct cable identity, available service length, required termination method, and impact on the active system"},{"key":"B","text":"Only whether a spare connector is nearby"},{"key":"C","text":"Only the cable jacket color"},{"key":"D","text":"Nothing if the connector already failed"}]'::jsonb,
  '["A"]'::jsonb,
  'Controlled retermination requires verification of cable identity, serviceability, approved method, and system impact.'
),
(
  7,
  'multiple_choice',
  'application',
  'A field team wants to combine several cable bundles onto one support path. What should determine whether this is acceptable?',
  '[{"key":"A","text":"Support capacity, pathway requirements, cable types, separation requirements, bundle management, and project specifications"},{"key":"B","text":"Whether the bundles physically fit"},{"key":"C","text":"Whether all jackets are the same color"},{"key":"D","text":"Whether the route is hidden"}]'::jsonb,
  '["A"]'::jsonb,
  'Bundle consolidation must preserve applicable support, capacity, separation, cable-performance, and project requirements.'
),
(
  8,
  'multiple_choice',
  'application',
  'A cable certification result identifies a performance failure near one end of the link. What is the BEST next step?',
  '[{"key":"A","text":"Inspect the indicated termination area and associated cable preparation, correct any defect, and retest"},{"key":"B","text":"Replace every cable on the project"},{"key":"C","text":"Ignore the location information"},{"key":"D","text":"Change the network addressing"}]'::jsonb,
  '["A"]'::jsonb,
  'Diagnostic information should be used to narrow the physical fault before unnecessary components are replaced.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project drawing and field condition disagree about a cable destination. What should the lead technician do?',
  '[{"key":"A","text":"Stop the affected work, verify the intended scope through the approved project communication process, document the resolution, and then proceed"},{"key":"B","text":"Choose the nearest device"},{"key":"C","text":"Follow whichever source requires less cable"},{"key":"D","text":"Install both without authorization"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting installation information should be resolved through controlled project communication before work continues.'
),
(
  10,
  'multiple_choice',
  'application',
  'A completed cable bundle looks neat but is pulled extremely tight between supports with almost no serviceability. What should the technician recognize?',
  '[{"key":"A","text":"Appearance alone does not establish a compliant or serviceable installation; cable stress and service requirements must also be satisfied"},{"key":"B","text":"A tight bundle always improves performance"},{"key":"C","text":"Serviceability matters only after warranty expiration"},{"key":"D","text":"Cable tension is irrelevant for low-voltage systems"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional cable management must protect cable integrity and allow appropriate service rather than merely look organized.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician is reviewing another installer''s terminations before project closeout. What is the BEST quality-control approach?',
  '[{"key":"A","text":"Verify workmanship, labeling, connector compatibility, cable preparation, test results, and documentation against project standards"},{"key":"B","text":"Check only whether the connectors are attached"},{"key":"C","text":"Accept all work if devices currently operate"},{"key":"D","text":"Review only visible cables"}]'::jsonb,
  '["A"]'::jsonb,
  'Quality control should confirm both physical workmanship and documented verification against the project requirements.'
),
(
  12,
  'scenario',
  'scenario',
  'A group of newly installed network cables passes wiremap but several fail certification. The lead technician notices excessive pair untwist at many terminations. What is the BEST corrective action?',
  '[{"key":"A","text":"Correct the affected terminations using the required preparation method and retest the links"},{"key":"B","text":"Accept them because wiremap passed"},{"key":"C","text":"Replace the network switches first"},{"key":"D","text":"Increase PoE power"}]'::jsonb,
  '["A"]'::jsonb,
  'Wiremap verifies basic conductor relationships but does not prove that the link meets required performance characteristics.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician discovers that a subcontractor used unapproved cable supports throughout a finished ceiling area. The cables currently test correctly. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the installation against project and applicable support requirements and correct nonconforming work before acceptance"},{"key":"B","text":"Accept it because the cables currently pass tests"},{"key":"C","text":"Document it only after the client complains"},{"key":"D","text":"Remove the cable labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Passing signal tests does not override installation, support, workmanship, or project requirements.'
),
(
  14,
  'scenario',
  'scenario',
  'A rack has intermittent network failures after cables were aggressively bundled with very tight fasteners. What should the lead technician do?',
  '[{"key":"A","text":"Inspect affected cabling for compression or geometry damage, correct the cable-management method, replace damaged runs as required, and retest"},{"key":"B","text":"Tighten the fasteners further"},{"key":"C","text":"Replace all active equipment before inspecting the cabling"},{"key":"D","text":"Hide the bundles behind panels"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive compression can damage cable geometry and should be addressed along with the installation practice that caused it.'
),
(
  15,
  'scenario',
  'scenario',
  'A cable test report shows repeated failures only on the longest installed links. What is the BEST next step?',
  '[{"key":"A","text":"Compare actual installed lengths, routing, terminations, cable specifications, and test requirements to determine whether the links exceed or approach design limits"},{"key":"B","text":"Assume all testers are defective"},{"key":"C","text":"Shorten the labels"},{"key":"D","text":"Replace only the patch cords without investigating"}]'::jsonb,
  '["A"]'::jsonb,
  'A length-related failure pattern should prompt evaluation of installed length and the full channel or permanent-link design.'
),
(
  16,
  'scenario',
  'scenario',
  'During renovation, another trade relocates a pathway and several low-voltage cables are now routed tightly around structural obstacles. What is the BEST action?',
  '[{"key":"A","text":"Inspect the affected routes for bend-radius, support, damage, separation, and pathway compliance, then correct and retest as needed"},{"key":"B","text":"Assume the cables are fine because they remain connected"},{"key":"C","text":"Pull them tighter to improve appearance"},{"key":"D","text":"Remove all labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes by other trades can affect cable integrity and installation compliance even when connectivity remains intact.'
),
(
  17,
  'scenario',
  'scenario',
  'A field technician proposes splicing a damaged communications cable in a concealed location to avoid repulling it. What should the lead technician do?',
  '[{"key":"A","text":"Verify whether the cable type, system design, project specification, manufacturer requirements, and approved repair method permit the splice before authorizing it"},{"key":"B","text":"Approve any splice if it restores continuity"},{"key":"C","text":"Hide the splice and omit it from documentation"},{"key":"D","text":"Use any available connector"}]'::jsonb,
  '["A"]'::jsonb,
  'A repair method must be compatible with the cable system and approved requirements, not merely restore basic continuity.'
),
(
  18,
  'scenario',
  'scenario',
  'A project is ready for closeout, but several cable labels in the rack do not match the as-built documentation. The systems currently operate correctly. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the physical labels and documentation to the verified installed condition before closeout"},{"key":"B","text":"Close the project because operation is all that matters"},{"key":"C","text":"Remove the labels entirely"},{"key":"D","text":"Update only the labels that are visible to the client"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate identification and as-built documentation are part of a serviceable and supportable infrastructure.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician repeatedly produces failed terminations of the same connector type even though the cable is correct. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Review the technician''s preparation method, tooling, connector compatibility, and manufacturer procedure, coach the correct process, and verify subsequent work"},{"key":"B","text":"Tell the technician to terminate faster"},{"key":"C","text":"Replace every cable"},{"key":"D","text":"Stop testing future terminations"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated workmanship failures call for root-cause review and process correction rather than accepting rework as normal.'
),
(
  20,
  'scenario',
  'scenario',
  'A completed project has intermittent failures on cables serving several systems, and all affected runs share one congested pathway. What is the BEST diagnostic strategy?',
  '[{"key":"A","text":"Treat the shared pathway as a possible common cause, inspect routing and physical conditions, review test data, isolate affected links, correct defects, and verify each repair"},{"key":"B","text":"Replace every endpoint device first"},{"key":"C","text":"Assume unrelated simultaneous device failures"},{"key":"D","text":"Change all cable labels"}]'::jsonb,
  '["A"]'::jsonb,
  'When multiple failures share physical infrastructure, the common installation path should be evaluated systematically as a potential root cause.'
);

create temporary table _seed_ci_cabling_termination_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_cabling_termination_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the strongest basis for defining cabling workmanship standards across an integration company?',
  '[{"key":"A","text":"Documented company standards aligned with project requirements, manufacturer instructions, applicable codes, and accepted installation practices"},{"key":"B","text":"Each technician using a preferred method"},{"key":"C","text":"Whatever method is fastest on each project"},{"key":"D","text":"Only the appearance of the finished rack"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent workmanship requires documented standards that align field execution with technical, project, manufacturer, and applicable regulatory requirements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a lead technician distinguish between a recurring installation defect and an isolated failed cable?',
  '[{"key":"A","text":"A recurring pattern may indicate a systemic issue in tooling, training, materials, pathway design, or installation process"},{"key":"B","text":"Recurring defects never require corrective action"},{"key":"C","text":"An isolated cable always requires redesigning the project"},{"key":"D","text":"The distinction matters only for billing"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failure patterns can reveal root causes that require process-level correction rather than repeated individual repairs.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should a cabling quality-control process establish before project closeout?',
  '[{"key":"A","text":"That installed infrastructure is identifiable, supported, terminated, tested, documented, and serviceable according to the required standard"},{"key":"B","text":"Only that devices power on"},{"key":"C","text":"Only that cables are hidden from view"},{"key":"D","text":"Only that the original cable quantities were used"}]'::jsonb,
  '["A"]'::jsonb,
  'Closeout should validate the physical installation and its supporting test and documentation evidence.'
),
(
  4,
  'multiple_choice',
  'application',
  'A lead technician reviews test reports and sees the same failure type appearing across work completed by multiple technicians. What is the BEST response?',
  '[{"key":"A","text":"Investigate the common process, tooling, material, training, or installation condition and correct the root cause"},{"key":"B","text":"Tell each technician to retest until the result passes"},{"key":"C","text":"Delete the failed reports"},{"key":"D","text":"Replace active equipment without investigating the cabling"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures across multiple installers suggest a shared root cause that should be identified and corrected systematically.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project will require unusually dense cabling through several shared pathways. What should the technical lead address during planning?',
  '[{"key":"A","text":"Pathway capacity, cable quantities and types, support strategy, separation, bend requirements, access, serviceability, and future expansion"},{"key":"B","text":"Only the shortest cable routes"},{"key":"C","text":"Only connector inventory"},{"key":"D","text":"Only rack elevations"}]'::jsonb,
  '["A"]'::jsonb,
  'High-density infrastructure should be engineered for capacity, performance, installation quality, accessibility, and lifecycle serviceability.'
),
(
  6,
  'multiple_choice',
  'application',
  'A field team repeatedly damages cable while pulling through one section of pathway. What should the lead technician do?',
  '[{"key":"A","text":"Stop repeated pulling, inspect the pathway and pulling method, identify the physical cause, correct it, and evaluate affected cable"},{"key":"B","text":"Increase pulling force"},{"key":"C","text":"Order stronger labels"},{"key":"D","text":"Continue until enough cables survive"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated damage indicates the installation condition or process must be corrected rather than treated as unavoidable waste.'
),
(
  7,
  'multiple_choice',
  'application',
  'A client requests a late design change that would require using cable outside the originally approved infrastructure design. What should the technical lead do?',
  '[{"key":"A","text":"Evaluate the technical impact, verify requirements and compatibility, document the change, and obtain the appropriate approval before implementation"},{"key":"B","text":"Make the change immediately because the client requested it"},{"key":"C","text":"Use whichever cable is already onsite"},{"key":"D","text":"Avoid documenting the change to save time"}]'::jsonb,
  '["A"]'::jsonb,
  'Late changes should be technically evaluated and controlled so performance, scope, documentation, and accountability remain aligned.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician can make reliable terminations but consistently produces poor cable dressing and support. What is the BEST leadership response?',
  '[{"key":"A","text":"Coach the complete workmanship standard, demonstrate the required method, observe execution, and verify sustained improvement"},{"key":"B","text":"Ignore it because the connectors work"},{"key":"C","text":"Assign the technician only hidden work"},{"key":"D","text":"Stop inspecting cable management"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical leadership includes developing consistent end-to-end workmanship, not merely functional terminations.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project has hundreds of cable test reports. What is the BEST way to make those results useful for closeout and future service?',
  '[{"key":"A","text":"Associate test records with consistent cable identifiers and preserve them in the project documentation structure"},{"key":"B","text":"Store them without cable identifiers"},{"key":"C","text":"Keep only failed reports"},{"key":"D","text":"Delete them after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Test records are most useful when they can be reliably matched to the installed and labeled cable infrastructure.'
),
(
  10,
  'multiple_choice',
  'application',
  'When evaluating whether an installed cable should be repaired or replaced, what should the technical lead consider?',
  '[{"key":"A","text":"Cable type, damage location and severity, approved repair methods, performance requirements, accessibility, reliability, and lifecycle serviceability"},{"key":"B","text":"Only material cost"},{"key":"C","text":"Only whether continuity exists"},{"key":"D","text":"Only how much cable remains on the reel"}]'::jsonb,
  '["A"]'::jsonb,
  'Repair-versus-replacement decisions should account for technical compliance, reliability, accessibility, and long-term support.'
),
(
  11,
  'scenario',
  'scenario',
  'A large project has an elevated failure rate on Category cable certification. Failures occur across multiple floors and technicians, but all teams use the same termination tool model. What is the BEST first leadership action?',
  '[{"key":"A","text":"Audit the shared tooling, calibration or condition, termination procedure, connector compatibility, and training before treating failures as isolated workmanship issues"},{"key":"B","text":"Replace every installed cable immediately"},{"key":"C","text":"Blame the newest technician"},{"key":"D","text":"Stop certification testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A shared tool or process across multiple crews is a logical common cause and should be investigated before broad replacement or individual blame.'
),
(
  12,
  'scenario',
  'scenario',
  'During closeout, a lead technician discovers that many installed cable identifiers do not match the final drawings even though all systems are operational. What is the BEST action?',
  '[{"key":"A","text":"Reconcile and correct the physical identification and as-built documentation to the verified installed condition before final acceptance"},{"key":"B","text":"Ignore it because the systems operate"},{"key":"C","text":"Remove all labels"},{"key":"D","text":"Correct only the client-visible cables"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate cable identification and as-built records are essential to serviceability and should be resolved before closeout.'
),
(
  13,
  'scenario',
  'scenario',
  'A project manager wants the field team to exceed a cable manufacturer''s published pulling limit to meet the schedule. What should the technical lead do?',
  '[{"key":"A","text":"Do not authorize the method; identify an approved installation alternative and communicate the schedule impact"},{"key":"B","text":"Proceed because schedule takes priority"},{"key":"C","text":"Pull harder only on hidden cables"},{"key":"D","text":"Proceed if two technicians share the load"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical leadership requires protecting cable integrity and installation requirements even when schedule pressure exists.'
),
(
  14,
  'scenario',
  'scenario',
  'Multiple cable failures appear several weeks after turnover. Investigation shows a pathway location where cables are being compressed by later construction work. What is the BEST response?',
  '[{"key":"A","text":"Address the physical cause, determine the affected population of cables, test and replace damaged runs as required, and document the corrective action"},{"key":"B","text":"Repair only the first reported cable"},{"key":"C","text":"Increase active equipment power"},{"key":"D","text":"Wait for each cable to fail individually"}]'::jsonb,
  '["A"]'::jsonb,
  'A shared environmental cause requires both immediate correction and evaluation of all potentially affected infrastructure.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician proposes using an unverified connector substitution across dozens of cables because the specified connector is backordered. What should the lead technician do?',
  '[{"key":"A","text":"Validate cable compatibility, performance, tooling, manufacturer requirements, project requirements, and approval before allowing a broad substitution"},{"key":"B","text":"Approve it because the connector physically fits"},{"key":"C","text":"Use it only on the longest cables"},{"key":"D","text":"Skip testing to save schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'A large-scale substitution can create systemic risk and should be technically validated before deployment.'
),
(
  16,
  'scenario',
  'scenario',
  'A team is producing excellent test results but cable bundles are difficult to trace, service loops are inconsistent, and rack dressing varies by technician. What is the BEST leadership response?',
  '[{"key":"A","text":"Standardize the workmanship expectations, train the team, inspect execution, and include serviceability and documentation in quality control"},{"key":"B","text":"Make no changes because the tests pass"},{"key":"C","text":"Remove cable labels to simplify the racks"},{"key":"D","text":"Allow each technician to keep a different method"}]'::jsonb,
  '["A"]'::jsonb,
  'Passing tests are necessary but do not replace standards for identification, management, consistency, and future serviceability.'
),
(
  17,
  'scenario',
  'scenario',
  'A project experiences repeated intermittent failures on cables routed near one newly installed building system. What is the BEST technical-lead approach?',
  '[{"key":"A","text":"Investigate the shared routing condition, separation and interference requirements, test affected links, isolate the cause, and implement a documented correction"},{"key":"B","text":"Replace endpoint devices randomly"},{"key":"C","text":"Change cable labels"},{"key":"D","text":"Assume all failures are unrelated"}]'::jsonb,
  '["A"]'::jsonb,
  'A common physical location associated with repeated failures should be treated as a potential systemic cause and evaluated methodically.'
),
(
  18,
  'scenario',
  'scenario',
  'A junior technician repeatedly fails cable terminations even after being told the correct method verbally. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Demonstrate the correct process, have the technician perform it under observation, identify the specific gap, coach it, and verify consistent results"},{"key":"B","text":"Repeat the same verbal instruction louder"},{"key":"C","text":"Stop testing the technician''s work"},{"key":"D","text":"Let failed terminations remain if the device connects"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective technical coaching combines demonstration, observed practice, feedback, and verification of competent execution.'
),
(
  19,
  'scenario',
  'scenario',
  'A client reports that service visits take too long because technicians cannot reliably trace installed cables. What is the BEST long-term corrective action?',
  '[{"key":"A","text":"Audit the identification and documentation system, correct deficient records and labels, and strengthen the installation and closeout standards that prevent recurrence"},{"key":"B","text":"Tell service technicians to trace faster"},{"key":"C","text":"Replace all cable with different jacket colors"},{"key":"D","text":"Stop maintaining as-built documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring service inefficiency caused by poor identification requires correction of both the existing infrastructure records and the process that created the deficiency.'
),
(
  20,
  'scenario',
  'scenario',
  'Post-project review shows repeated cable rework, inconsistent test documentation, and different termination practices across crews. What is the BEST improvement plan?',
  '[{"key":"A","text":"Use the failure data to identify recurring causes, establish or refine standardized procedures, verify tooling and materials, train crews, and audit future work against measurable quality expectations"},{"key":"B","text":"Accept rework as a normal cost of installation"},{"key":"C","text":"Stop tracking failures"},{"key":"D","text":"Allow each crew to develop independent standards"}]'::jsonb,
  '["A"]'::jsonb,
  'Systemic quality improvement requires using field evidence to improve standards, training, tools, materials, and verification processes.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '9cb6bf0f-88f3-48af-8078-f8e8d29437f7';
  v_l1_role_id uuid := '006a91b3-38dc-4d13-9532-f22d839af945';
  v_l2_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
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
      and c.name = 'Cabling & Termination'
      and c.is_current = true
  ) then
    raise exception 'Current Cabling & Termination Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Logistics Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Logistics Manager L1 Cabling & Termination requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician I — Entry Level'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Technician I — Entry Level L2 Cabling & Termination requirement not found';
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
    raise exception 'Current Technician II — Experienced L3 Cabling & Termination requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Cabling & Termination requirement not found';
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
  v_assessment_name := 'Cabling & Termination — Level 1 Competency Assessment';

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
    select * from _seed_ci_cabling_termination_l1_questions
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
        'Cabling & Termination',
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
      'IntegrateU Cabling & Termination L1 production assessment v1.0.',
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
        'Cabling & Termination',
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
        'IntegrateU Cabling & Termination L1 production assessment v1.0.',
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
  v_assessment_name := 'Cabling & Termination — Level 2 Competency Assessment';

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
    select * from _seed_ci_cabling_termination_l2_questions
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
        'Cabling & Termination',
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
      'IntegrateU Cabling & Termination L2 production assessment v1.0.',
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
        'Cabling & Termination',
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
        'IntegrateU Cabling & Termination L2 production assessment v1.0.',
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
  v_assessment_name := 'Cabling & Termination — Level 3 Competency Assessment';

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
    select * from _seed_ci_cabling_termination_l3_questions
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
        'Cabling & Termination',
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
      'IntegrateU Cabling & Termination L3 production assessment v1.0.',
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
        'Cabling & Termination',
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
        'IntegrateU Cabling & Termination L3 production assessment v1.0.',
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
  v_assessment_name := 'Cabling & Termination — Level 4 Competency Assessment';

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
    select * from _seed_ci_cabling_termination_l4_questions
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
        'Cabling & Termination',
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
      'IntegrateU Cabling & Termination L4 production assessment v1.0.',
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
        'Cabling & Termination',
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
        'IntegrateU Cabling & Termination L4 production assessment v1.0.',
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
