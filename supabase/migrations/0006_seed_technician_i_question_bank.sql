-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0006_seed_technician_i_question_bank.sql
--
-- Seeds:
--   100 approved Technician I master questions
--   100 secure answer keys
--   100 Technician I role-applicability mappings
--   1 template-mode Technician I pre-assessment
--   12 assessment blueprint rules totaling 100 questions
--
-- Idempotent: reuses current CI industry, Technician I role, competencies,
-- assessment, questions, answer keys, mappings, and blueprint rows when found.
-- Existing seeded/manual content is not overwritten.
-- ============================================================================

begin;

create temporary table _seed_tech1_questions (
  question_number int primary key,
  domain text not null,
  competency_name text not null,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text,
  critical_safety boolean not null,
  practical_verification_required boolean not null
);

insert into _seed_tech1_questions (
  question_number, domain, competency_name, question_type, difficulty,
  prompt, options, correct_answer, rationale,
  critical_safety, practical_verification_required
)
values
(1, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_choice', 'foundational', 'What is OSHA''s primary purpose?', '[{"key":"A","text":"To establish pricing standards for construction projects"},{"key":"B","text":"To help ensure safe and healthful working conditions"},{"key":"C","text":"To certify low-voltage equipment"},{"key":"D","text":"To license audiovisual technicians"}]'::jsonb, '"B"'::jsonb, 'OSHA establishes and enforces workplace safety and health requirements and provides related education and assistance.', false, false),
(2, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'application', 'A technician notices an unsafe condition while preparing to begin work. What is the BEST action?', '[{"key":"A","text":"Continue working until the supervisor arrives"},{"key":"B","text":"Correct it personally regardless of the hazard"},{"key":"C","text":"Stop, avoid exposure to the hazard, and report the condition through the proper process"},{"key":"D","text":"Ignore it if another trade created it"}]'::jsonb, '"C"'::jsonb, 'Production does not take priority over an unsafe work condition. Technicians should avoid exposure and follow the appropriate reporting and escalation process.', true, true),
(3, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_choice', 'foundational', 'Why are safety codes and standards relevant to low-voltage technicians?', '[{"key":"A","text":"They apply only to electricians working with line voltage"},{"key":"B","text":"They establish expectations that help protect workers, property, and system installations"},{"key":"C","text":"They are recommendations that only apply to government projects"},{"key":"D","text":"They primarily determine equipment pricing"}]'::jsonb, '"B"'::jsonb, 'Low-voltage technicians still work in environments with physical, electrical, structural, and job-site hazards.', false, false),
(4, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_select', 'foundational', 'Which THREE actions can help reduce the risk of falls while working?', '[{"key":"A","text":"Keep work areas and walking surfaces clear"},{"key":"B","text":"Use appropriate fall-protection measures when required"},{"key":"C","text":"Stand on the highest available ladder step for additional reach"},{"key":"D","text":"Inspect access equipment before use"},{"key":"E","text":"Carry as many tools as possible while climbing"}]'::jsonb, '["A","B","D"]'::jsonb, 'Housekeeping, appropriate fall protection, and equipment inspection are fundamental fall-prevention behaviors.', true, true),
(5, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_choice', 'application', 'A technician needs a ladder for a job. What should be considered FIRST when selecting it?', '[{"key":"A","text":"Which ladder is closest to the technician"},{"key":"B","text":"The required working height, task, environment, and ladder rating/type"},{"key":"C","text":"Whether another technician used it yesterday"},{"key":"D","text":"Which ladder is easiest to carry"}]'::jsonb, '"B"'::jsonb, 'Ladder selection should be based on the work being performed and the conditions in which it will be used.', true, true),
(6, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'application', 'During a pre-use inspection, a technician discovers that a ladder has a damaged component. What should the technician do?', '[{"key":"A","text":"Use it only for a short task"},{"key":"B","text":"Have another technician hold it"},{"key":"C","text":"Remove it from service according to company procedure and obtain suitable equipment"},{"key":"D","text":"Use it as long as the damaged area is below the technician''s feet"}]'::jsonb, '"C"'::jsonb, 'Damaged access equipment should not remain in service simply because the task is brief.', true, true),
(7, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'scenario', 'A technician positions a ladder but realizes it must be leaned sideways to reach the final device location. What is the BEST response?', '[{"key":"A","text":"Keep one hand on the ladder while leaning"},{"key":"B","text":"Ask someone to hold the ladder while leaning farther"},{"key":"C","text":"Climb down and reposition the ladder to maintain a safe working position"},{"key":"D","text":"Stand one step higher to improve reach"}]'::jsonb, '"C"'::jsonb, 'Repositioning the ladder is preferable to overreaching and compromising stability.', true, true),
(8, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'scenario', 'A technician needs to set up a ladder in an active hallway where people are regularly walking. What is the BEST approach?', '[{"key":"A","text":"Set it up immediately because technicians have priority"},{"key":"B","text":"Control or protect the work area according to job-site procedures before using the ladder"},{"key":"C","text":"Ask pedestrians to walk underneath it"},{"key":"D","text":"Complete the task quickly before anyone notices"}]'::jsonb, '"B"'::jsonb, 'Technicians must consider hazards created for themselves and other people when establishing a work area.', true, true),
(9, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_choice', 'foundational', 'What does PPE stand for?', '[{"key":"A","text":"Personal Protection Equipment"},{"key":"B","text":"Professional Protection Equipment"},{"key":"C","text":"Personal Protective Equipment"},{"key":"D","text":"Project Prevention Equipment"}]'::jsonb, '"C"'::jsonb, 'PPE stands for Personal Protective Equipment.', false, true),
(10, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'multiple_choice', 'application', 'How should a technician determine what PPE is appropriate for a task?', '[{"key":"A","text":"Wear the same PPE for every task"},{"key":"B","text":"Base the decision on the hazards, task requirements, job-site/company rules, and applicable requirements"},{"key":"C","text":"PPE is only necessary when a supervisor is present"},{"key":"D","text":"Use whatever another technician happens to be wearing"}]'::jsonb, '"B"'::jsonb, 'PPE should correspond to the hazards and requirements of the work being performed.', true, true),
(11, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'scenario', 'A technician is about to perform work that could create flying particles or debris. What should happen before the work begins?', '[{"key":"A","text":"Close one eye while performing the task"},{"key":"B","text":"Select and properly wear appropriate eye protection"},{"key":"C","text":"Have another technician watch for debris"},{"key":"D","text":"Complete the task quickly to minimize exposure"}]'::jsonb, '"B"'::jsonb, 'Appropriate eye protection should be selected and worn before performing work that can create flying particles or debris.', true, true),
(12, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'application', 'A technician discovers that a hand tool is damaged. What is the BEST action?', '[{"key":"A","text":"Continue using it carefully"},{"key":"B","text":"Repair it temporarily with tape"},{"key":"C","text":"Remove it from use and follow the company''s process for damaged tools"},{"key":"D","text":"Give it to a Technician I with less experience"}]'::jsonb, '"C"'::jsonb, 'Damaged tools can create unnecessary risk and should be handled according to established safety procedures.', true, true),
(13, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'application', 'A technician is about to use an unfamiliar power tool for the first time. What is the BEST action?', '[{"key":"A","text":"Experiment with it until its operation becomes clear"},{"key":"B","text":"Ask another entry-level technician how they think it works"},{"key":"C","text":"Obtain proper instruction and understand the tool''s safe operating requirements before using it"},{"key":"D","text":"Use it at its highest setting so the task finishes faster"}]'::jsonb, '"C"'::jsonb, 'A technician should understand safe operation before using unfamiliar equipment.', true, true),
(14, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'scenario', 'During an installation, cable scraps, packaging, tools, and equipment begin accumulating in the work area. What should the technician do?', '[{"key":"A","text":"Leave everything until the project is finished"},{"key":"B","text":"Maintain an organized work area and regularly remove or properly store materials that create hazards"},{"key":"C","text":"Push everything against the nearest wall"},{"key":"D","text":"Leave cleanup entirely to the general contractor"}]'::jsonb, '"B"'::jsonb, 'Maintaining a clean and organized work area is part of safe, professional installation practice.', false, true),
(15, 'Safety, OSHA & Job-Site Practices', 'Safety & Job-Site Standards', 'scenario', 'scenario', 'A technician is under pressure to finish an installation before the end of the day. The technician believes the next task cannot be completed safely with the equipment and conditions currently available. What is the BEST decision?', '[{"key":"A","text":"Complete it because meeting the deadline is more important"},{"key":"B","text":"Attempt it once and stop only if something goes wrong"},{"key":"C","text":"Stop the task, communicate the safety concern, and obtain the proper equipment or direction before proceeding"},{"key":"D","text":"Ask the least-experienced technician to perform it"}]'::jsonb, '"C"'::jsonb, 'Schedule pressure does not justify knowingly performing work under unsafe conditions.', true, true),
(16, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'foundational', 'In systems integration, what does “low voltage” generally describe?', '[{"key":"A","text":"Systems operating at lower electrical voltages than standard line-voltage power systems"},{"key":"B","text":"Any electrical system that does not use batteries"},{"key":"C","text":"Only audio systems"},{"key":"D","text":"Electrical circuits that contain no current"}]'::jsonb, '"A"'::jsonb, 'Low-voltage systems operate at lower voltages than typical building power circuits and commonly support communications, AV, networking, security, and control applications.', false, false),
(17, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'foundational', 'What does voltage represent in an electrical circuit?', '[{"key":"A","text":"The opposition to current flow"},{"key":"B","text":"Electrical potential difference"},{"key":"C","text":"The physical diameter of a conductor"},{"key":"D","text":"The amount of data carried by a cable"}]'::jsonb, '"B"'::jsonb, 'Voltage represents electrical potential difference between two points.', false, false),
(18, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'foundational', 'Electrical current describes:', '[{"key":"A","text":"The flow of electric charge"},{"key":"B","text":"The resistance of insulation"},{"key":"C","text":"The length of a cable"},{"key":"D","text":"The strength of a network connection"}]'::jsonb, '"A"'::jsonb, 'Electrical current is the flow of electric charge.', false, false),
(19, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'foundational', 'What does electrical resistance describe?', '[{"key":"A","text":"The ability of a cable to transmit video"},{"key":"B","text":"Opposition to the flow of electric current"},{"key":"C","text":"The amount of voltage generated by a network switch"},{"key":"D","text":"The physical strength of a connector"}]'::jsonb, '"B"'::jsonb, 'Electrical resistance describes opposition to the flow of electric current.', false, false),
(20, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'application', 'Which statement BEST describes the difference between AC and DC?', '[{"key":"A","text":"AC periodically changes direction, while DC flows with consistent polarity/direction"},{"key":"B","text":"AC is used only for audio and DC only for video"},{"key":"C","text":"DC is always more dangerous than AC"},{"key":"D","text":"There is no meaningful difference"}]'::jsonb, '"A"'::jsonb, 'Understanding the basic distinction helps technicians recognize different power requirements encountered with system equipment.', false, false),
(21, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'application', 'A technician is looking at project documentation containing both equipment power requirements and signal connections. Why is it important to distinguish between the two?', '[{"key":"A","text":"Signal cables and power connections perform different functions and may have different installation requirements"},{"key":"B","text":"Signal and power connections are interchangeable"},{"key":"C","text":"Power connections are only relevant to electricians"},{"key":"D","text":"Signal cables never carry electrical energy"}]'::jsonb, '"A"'::jsonb, 'Signal and power connections serve different functions and can have different installation requirements.', false, false),
(22, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'multiple_choice', 'application', 'A device connection specifies positive (+) and negative (–) terminals. Why should the technician maintain the specified polarity?', '[{"key":"A","text":"Polarity is only used to make drawings easier to read"},{"key":"B","text":"Reversing connections can cause incorrect operation or system-performance problems"},{"key":"C","text":"Positive wires always carry network data"},{"key":"D","text":"Polarity matters only during rough-in"}]'::jsonb, '"B"'::jsonb, 'Technicians should follow equipment documentation and maintain required polarity throughout installation.', false, true),
(23, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'scenario', 'scenario', 'While installing a low-voltage system, a technician encounters line-voltage wiring in the planned work area. The technician is not qualified or authorized to modify it. What is the BEST action?', '[{"key":"A","text":"Move the line-voltage wiring to make room"},{"key":"B","text":"Continue without considering it because low-voltage work is unrelated"},{"key":"C","text":"Stop the affected work and communicate the condition so it can be handled by an appropriately qualified person"},{"key":"D","text":"Disconnect the circuit and reconnect it after completing the installation"}]'::jsonb, '"C"'::jsonb, 'Technicians should recognize the limits of their authorization and qualifications rather than modifying systems outside their scope.', true, true),
(24, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'scenario', 'scenario', 'A replacement device physically fits and has the correct signal connections, but its specified power requirements differ from the original device. What should the technician do?', '[{"key":"A","text":"Connect it because the connectors fit"},{"key":"B","text":"Verify the manufacturer''s power requirements and confirm compatibility before applying power"},{"key":"C","text":"Apply power briefly to see what happens"},{"key":"D","text":"Assume all low-voltage equipment uses the same power"}]'::jsonb, '"B"'::jsonb, 'Physical connector compatibility does not prove electrical compatibility.', false, true),
(25, 'Low-Voltage & Electrical Fundamentals', 'Low-Voltage Fundamentals', 'troubleshooting', 'scenario', 'A newly installed low-voltage device does not power on. What is the BEST initial approach?', '[{"key":"A","text":"Immediately replace the device"},{"key":"B","text":"Begin changing unrelated system settings"},{"key":"C","text":"Verify the expected power source, connections, polarity where applicable, and manufacturer requirements before assuming the device has failed"},{"key":"D","text":"Increase the supplied voltage"}]'::jsonb, '"C"'::jsonb, 'Basic troubleshooting starts by verifying fundamentals before replacing equipment or making unrelated changes.', false, true),
(26, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'foundational', 'Which cable type is commonly used for Ethernet network connections?', '[{"key":"A","text":"RG6 coaxial cable"},{"key":"B","text":"Category twisted-pair cable"},{"key":"C","text":"Speaker cable"},{"key":"D","text":"Two-conductor security cable"}]'::jsonb, '"B"'::jsonb, 'Category twisted-pair cable is commonly used for Ethernet networking.', false, false),
(27, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'foundational', 'Which cable type is commonly associated with RF, antenna, satellite, and similar signal applications?', '[{"key":"A","text":"Coaxial cable"},{"key":"B","text":"Speaker cable"},{"key":"C","text":"Category cable"},{"key":"D","text":"Two-conductor control cable"}]'::jsonb, '"A"'::jsonb, 'Coaxial cable is commonly used for RF, antenna, satellite, and similar signal applications.', false, false),
(28, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'A technician needs to connect a passive speaker to its amplifier using the specified project wiring. Which cable would generally be associated with this connection?', '[{"key":"A","text":"Speaker cable"},{"key":"B","text":"Fiber-optic cable"},{"key":"C","text":"Coaxial cable"},{"key":"D","text":"Category cable used as an Ethernet connection"}]'::jsonb, '"A"'::jsonb, 'Passive loudspeakers are commonly connected to amplification using appropriately specified speaker cable.', false, false),
(29, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'foundational', 'What distinguishes fiber-optic cable from traditional copper communications cable?', '[{"key":"A","text":"It transmits information using light rather than electrical signals through copper conductors"},{"key":"B","text":"It can only carry audio"},{"key":"C","text":"It does not require connectors"},{"key":"D","text":"It is used exclusively for residential security systems"}]'::jsonb, '"A"'::jsonb, 'Fiber-optic cable transmits information using light rather than electrical signals through copper conductors.', false, false),
(30, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'scenario', 'A technician discovers that the specified cable is unavailable but finds another cable that physically fits the pathway. What is the BEST action?', '[{"key":"A","text":"Use the available cable because all low-voltage cables are interchangeable"},{"key":"B","text":"Install it and document the substitution afterward"},{"key":"C","text":"Verify the required cable specification and obtain approval before making a substitution"},{"key":"D","text":"Choose whichever cable has the largest diameter"}]'::jsonb, '"C"'::jsonb, 'Physical fit does not establish performance, code, manufacturer, or project-specification compatibility.', false, true),
(31, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'What should primarily determine which connector a technician installs on a cable?', '[{"key":"A","text":"The connector the technician has used most often"},{"key":"B","text":"The cable type, equipment interface, application, and project/manufacturer requirements"},{"key":"C","text":"Whichever connector is least expensive"},{"key":"D","text":"The color of the cable jacket"}]'::jsonb, '"B"'::jsonb, 'Connector selection should follow the cable type, equipment interface, application, and project/manufacturer requirements.', false, true),
(32, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'While preparing a cable for termination, what should the technician avoid?', '[{"key":"A","text":"Following the connector manufacturer''s preparation requirements"},{"key":"B","text":"Inspecting conductors before completing the termination"},{"key":"C","text":"Damaging conductors or removing more jacket than necessary"},{"key":"D","text":"Using the appropriate cable-preparation tool"}]'::jsonb, '"C"'::jsonb, 'Poor cable preparation can create weak, unreliable, or noncompliant terminations.', false, true),
(33, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'Why is using the proper termination tool important?', '[{"key":"A","text":"It guarantees that testing is unnecessary"},{"key":"B","text":"It helps produce a termination consistent with the connector/cable manufacturer''s requirements"},{"key":"C","text":"Every connector requires exactly the same tool"},{"key":"D","text":"It changes the electrical characteristics of any cable to match the device"}]'::jsonb, '"B"'::jsonb, 'Proper tooling is part of producing a reliable termination.', false, true),
(34, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'When terminating twisted-pair communications cable, why should the technician avoid unnecessarily untwisting large portions of the conductor pairs?', '[{"key":"A","text":"The twists are only used to identify the cable"},{"key":"B","text":"Excessive untwisting can negatively affect cable performance"},{"key":"C","text":"Untwisting changes the cable''s jacket color"},{"key":"D","text":"The cable will become line voltage"}]'::jsonb, '"B"'::jsonb, 'Excessive untwisting can negatively affect twisted-pair cable performance.', false, true),
(35, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'scenario', 'A cable must make a change in direction inside a pathway. The easiest route would require a very sharp bend. What should the technician do?', '[{"key":"A","text":"Make the sharp bend as long as the cable does not immediately break"},{"key":"B","text":"Follow the applicable cable/manufacturer bend-radius requirements"},{"key":"C","text":"Flatten the cable at the bend"},{"key":"D","text":"Remove the jacket at the bend to make the cable more flexible"}]'::jsonb, '"B"'::jsonb, 'Excessive bending can damage cable and degrade performance.', false, true),
(36, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'scenario', 'A technician has completed a long cable run above a ceiling. What should happen before considering the run complete?', '[{"key":"A","text":"Leave the cable resting wherever it naturally falls"},{"key":"B","text":"Properly support and secure it using the approved pathway/support method"},{"key":"C","text":"Tie it to any available pipe"},{"key":"D","text":"Lay it directly on ceiling tiles"}]'::jsonb, '"B"'::jsonb, 'Proper support protects the installation and contributes to safe, professional workmanship.', false, true),
(37, 'Cable, Connectors & Termination', 'Cabling & Termination', 'multiple_choice', 'application', 'What is a primary purpose of leaving an appropriate service loop when required?', '[{"key":"A","text":"To intentionally increase signal loss"},{"key":"B","text":"To provide usable cable length for installation, service, or future retermination"},{"key":"C","text":"To eliminate the need to label the cable"},{"key":"D","text":"To make the cable easier to hide regardless of documentation"}]'::jsonb, '"B"'::jsonb, 'A service loop provides usable cable length for installation, service, or future retermination.', false, true),
(38, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'scenario', 'A technician pulls 20 cables to multiple device locations. The cables have not yet been terminated. What is the BEST practice?', '[{"key":"A","text":"Wait until every device is installed and identify cables by trial and error"},{"key":"B","text":"Label the cables according to the project''s labeling standard so each run can be identified"},{"key":"C","text":"Label only the longest cables"},{"key":"D","text":"Use cable color as the only identification method"}]'::jsonb, '"B"'::jsonb, 'Consistent labeling supports installation, testing, troubleshooting, documentation, and future service.', false, true),
(39, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'application', 'During a cable pull, a technician notices that part of the cable jacket has been damaged. What is the BEST action?', '[{"key":"A","text":"Cover the damaged area with tape and continue"},{"key":"B","text":"Hide the damaged section inside the wall"},{"key":"C","text":"Stop and evaluate the cable according to company/project requirements rather than assuming it is acceptable"},{"key":"D","text":"Terminate the cable first and decide later"}]'::jsonb, '"C"'::jsonb, 'Visible damage can affect cable performance and reliability and should be evaluated before the installation continues.', false, true),
(40, 'Cable, Connectors & Termination', 'Cabling & Termination', 'scenario', 'scenario', 'While pulling cable through a pathway, the cable becomes difficult to move and requires significantly more force. What should the technician do?', '[{"key":"A","text":"Pull as hard as possible"},{"key":"B","text":"Stop and investigate the obstruction or pathway before continuing"},{"key":"C","text":"Use a vehicle or power tool to increase pulling force"},{"key":"D","text":"Remove the cable jacket"}]'::jsonb, '"B"'::jsonb, 'Excessive pulling force can damage cable. The technician should identify the cause instead of simply applying more force.', false, true),
(41, 'Tools & Installation Methods', 'Tools & Installation Methods', 'multiple_choice', 'foundational', 'What should determine which tool a technician selects for a task?', '[{"key":"A","text":"Whichever tool is closest"},{"key":"B","text":"The task, material, manufacturer instructions, and intended use of the tool"},{"key":"C","text":"The largest tool available"},{"key":"D","text":"Whichever tool the technician used most recently"}]'::jsonb, '"B"'::jsonb, 'Correct tool selection contributes to safety, workmanship, and preventing damage to materials or equipment.', false, true),
(42, 'Tools & Installation Methods', 'Tools & Installation Methods', 'multiple_choice', 'application', 'A technician needs to remove the outer jacket from a communications cable before termination. What is the BEST approach?', '[{"key":"A","text":"Use an appropriate cable-preparation tool and avoid damaging the conductors"},{"key":"B","text":"Use any sharp object available"},{"key":"C","text":"Pull the jacket off with pliers"},{"key":"D","text":"Cut deeply through the jacket to ensure it separates completely"}]'::jsonb, '"A"'::jsonb, 'Cable preparation should remove the required jacket without nicking or damaging the conductors underneath.', false, true),
(43, 'Tools & Installation Methods', 'Tools & Installation Methods', 'multiple_choice', 'application', 'A connector requires a specific crimping or termination method. What should the technician do?', '[{"key":"A","text":"Use standard pliers instead"},{"key":"B","text":"Use the appropriate termination tool and follow the connector manufacturer''s requirements"},{"key":"C","text":"Modify the connector until another tool fits"},{"key":"D","text":"Hand-tighten the connector regardless of its design"}]'::jsonb, '"B"'::jsonb, 'Proper tooling is part of producing a reliable termination.', false, true),
(44, 'Tools & Installation Methods', 'Tools & Installation Methods', 'scenario', 'scenario', 'A technician needs to drill through a building surface to create a cable pathway but is unsure what may be behind it. What is the BEST action?', '[{"key":"A","text":"Drill slowly and see what happens"},{"key":"B","text":"Select a longer drill bit"},{"key":"C","text":"Verify the drilling location and potential concealed hazards before proceeding"},{"key":"D","text":"Increase drill speed so the hole is completed quickly"}]'::jsonb, '"C"'::jsonb, 'Technicians should consider concealed electrical wiring, plumbing, structural components, and other hazards before drilling.', true, true),
(45, 'Tools & Installation Methods', 'Tools & Installation Methods', 'scenario', 'scenario', 'A technician must install equipment in a finished room with completed flooring, cabinetry, and painted surfaces. What is the BEST approach?', '[{"key":"A","text":"Treat finished surfaces the same as an unfinished construction site"},{"key":"B","text":"Protect the work area and finished surfaces before beginning installation"},{"key":"C","text":"Assume any damage can be repaired later"},{"key":"D","text":"Place tools directly on finished surfaces so they remain accessible"}]'::jsonb, '"B"'::jsonb, 'Protecting the client''s property is part of professional installation workmanship.', false, true),
(46, 'Tools & Installation Methods', 'Tools & Installation Methods', 'multiple_choice', 'application', 'Why should technicians verify measurements and installation locations before drilling, cutting, or mounting equipment?', '[{"key":"A","text":"To reduce the likelihood of incorrect placement, rework, and property damage"},{"key":"B","text":"Measurements are only needed by designers"},{"key":"C","text":"Measuring is unnecessary when drawings exist"},{"key":"D","text":"It allows technicians to ignore device-location documentation"}]'::jsonb, '"A"'::jsonb, 'Verification reduces incorrect placement, rework, and property damage.', false, true),
(47, 'Tools & Installation Methods', 'Tools & Installation Methods', 'scenario', 'scenario', 'A technician does not have the correct tool for a task but believes another tool could probably be made to work. What is the BEST decision?', '[{"key":"A","text":"Modify the available tool"},{"key":"B","text":"Use additional force"},{"key":"C","text":"Obtain the appropriate tool or approved method before proceeding"},{"key":"D","text":"Ask the least-experienced technician to attempt it"}]'::jsonb, '"C"'::jsonb, 'Improvised tool use can create safety hazards, damage equipment, and reduce installation quality.', false, true),
(48, 'Tools & Installation Methods', 'Quality Control', 'scenario', 'scenario', 'Two installations are electrically functional. Installation A has organized, supported and labeled cabling. Installation B has loose, poorly routed and unlabeled cabling. Why is Installation A the better installation?', '[{"key":"A","text":"Appearance is the only difference"},{"key":"B","text":"Organized workmanship improves serviceability, identification, quality, and professional execution"},{"key":"C","text":"Cable organization only matters inside equipment racks"},{"key":"D","text":"Once a system works, installation quality no longer matters"}]'::jsonb, '"B"'::jsonb, 'Professional workmanship affects reliability, troubleshooting, maintenance, and future service.', false, true),
(49, 'Drawings, Schematics & Documentation', 'Blueprint / Drawing Reading', 'multiple_choice', 'foundational', 'What is a floor plan primarily used to show?', '[{"key":"A","text":"A top-down representation of spaces and the location of project elements"},{"key":"B","text":"Only equipment rack wiring"},{"key":"C","text":"Employee work schedules"},{"key":"D","text":"Manufacturer warranty information"}]'::jsonb, '"A"'::jsonb, 'Floor plans help technicians understand the layout of spaces and locate devices or other project elements.', false, true),
(50, 'Drawings, Schematics & Documentation', 'Blueprint / Drawing Reading', 'multiple_choice', 'foundational', 'A technician needs to determine the planned locations of ceiling-mounted speakers and other ceiling devices. Which document would commonly provide this information?', '[{"key":"A","text":"Reflected ceiling plan"},{"key":"B","text":"Purchase order"},{"key":"C","text":"Employee time sheet"},{"key":"D","text":"Equipment warranty"}]'::jsonb, '"A"'::jsonb, 'Reflected ceiling plans commonly communicate the locations of ceiling-mounted elements.', false, true),
(51, 'Drawings, Schematics & Documentation', 'Blueprint / Drawing Reading', 'multiple_choice', 'application', 'What is the primary value of a wiring or connection diagram to an installation technician?', '[{"key":"A","text":"It shows how system components and connections are intended to relate to one another"},{"key":"B","text":"It determines employee compensation"},{"key":"C","text":"It replaces all equipment manufacturer instructions"},{"key":"D","text":"It shows only the architectural dimensions of the building"}]'::jsonb, '"A"'::jsonb, 'Wiring and connection diagrams show how components and connections are intended to relate.', false, true),
(52, 'Drawings, Schematics & Documentation', 'Blueprint / Drawing Reading', 'multiple_choice', 'application', 'A technician encounters an unfamiliar symbol on a project drawing. What is the BEST first action?', '[{"key":"A","text":"Assume it represents the device most commonly installed in that room"},{"key":"B","text":"Ignore the symbol"},{"key":"C","text":"Check the drawing legend/key and applicable project documentation"},{"key":"D","text":"Install a device and see whether anyone asks for it to be changed"}]'::jsonb, '"C"'::jsonb, 'Technicians should verify the meaning of symbols and abbreviations rather than guess.', false, true),
(53, 'Drawings, Schematics & Documentation', 'Documentation', 'multiple_choice', 'application', 'Project documentation identifies a device as TV-03 and its associated cable with a specific cable identifier. Why should the technician maintain those identifiers during installation?', '[{"key":"A","text":"They connect the physical installation to the project documentation and make testing, troubleshooting, and service easier"},{"key":"B","text":"Identifiers are only useful to the sales team"},{"key":"C","text":"They are unnecessary once equipment is installed"},{"key":"D","text":"They are used primarily to determine cable pricing"}]'::jsonb, '"A"'::jsonb, 'Identifiers connect the physical installation to project documentation and improve testing, troubleshooting, and serviceability.', false, true),
(54, 'Drawings, Schematics & Documentation', 'Documentation', 'scenario', 'scenario', 'A technician has two versions of the same project drawing. One is marked as a newer revision. What should the technician do BEFORE performing the affected work?', '[{"key":"A","text":"Use whichever drawing is easier to read"},{"key":"B","text":"Assume the older drawing is still correct"},{"key":"C","text":"Verify which revision is currently approved for construction/installation and work from the authorized documentation"},{"key":"D","text":"Combine information from both versions without asking"}]'::jsonb, '"C"'::jsonb, 'Working from outdated documentation can cause incorrect placement, cabling, installation, and rework.', false, true),
(55, 'Drawings, Schematics & Documentation', 'Blueprint / Drawing Reading', 'scenario', 'scenario', 'A drawing shows a device at a particular wall location. At the job site, the technician discovers that the location cannot be used because an unexpected structural condition occupies the space. What is the BEST response?', '[{"key":"A","text":"Move the device wherever it fits without telling anyone"},{"key":"B","text":"Skip the device"},{"key":"C","text":"Document and communicate the discrepancy through the project''s established process and obtain direction before making a change"},{"key":"D","text":"Modify the structural condition"}]'::jsonb, '"C"'::jsonb, 'Technicians should recognize discrepancies, communicate them, and avoid making unauthorized scope or design changes.', false, true),
(56, 'Rough-In & Infrastructure', 'Tools & Installation Methods', 'multiple_choice', 'foundational', 'What is a primary purpose of the rough-in stage of a low-voltage project?', '[{"key":"A","text":"Perform final client training"},{"key":"B","text":"Install the infrastructure, pathways, cabling, and related components needed before finished surfaces limit access"},{"key":"C","text":"Complete final system programming"},{"key":"D","text":"Close all service tickets"}]'::jsonb, '"B"'::jsonb, 'Rough-in establishes the infrastructure required for later trim-out, equipment installation, and system completion.', false, true),
(57, 'Rough-In & Infrastructure', 'Cabling & Termination', 'multiple_select', 'application', 'Which THREE actions should a technician take before beginning a cable pull?', '[{"key":"A","text":"Review the applicable plans and cable requirements"},{"key":"B","text":"Verify the intended source and destination"},{"key":"C","text":"Confirm the pathway and identify potential obstructions or hazards"},{"key":"D","text":"Pull whatever cable is closest and identify it later"},{"key":"E","text":"Ignore device locations until trim-out"}]'::jsonb, '["A","B","C"]'::jsonb, 'Proper preparation reduces wrong pulls, damaged cable, rework, and installation delays.', false, true),
(58, 'Rough-In & Infrastructure', 'Blueprint / Drawing Reading', 'scenario', 'scenario', 'A technician is preparing to install a mud ring for a wall-mounted device but is unsure of the required mounting height. What is the BEST action?', '[{"key":"A","text":"Match the height used on the technician''s previous project"},{"key":"B","text":"Choose a height that looks appropriate"},{"key":"C","text":"Verify the approved project documentation and applicable installation requirements before installing it"},{"key":"D","text":"Ask another trade to choose the location"}]'::jsonb, '"C"'::jsonb, 'Device locations should follow approved project requirements rather than personal preference.', false, true),
(59, 'Rough-In & Infrastructure', 'Cabling & Termination', 'multiple_choice', 'application', 'When choosing a route for low-voltage cable, what should the technician consider?', '[{"key":"A","text":"Only the shortest possible distance"},{"key":"B","text":"Approved pathways, cable requirements, potential interference/hazards, accessibility, and project documentation"},{"key":"C","text":"Only whether the cable can physically fit"},{"key":"D","text":"Whichever route requires the least documentation"}]'::jsonb, '"B"'::jsonb, 'Cable routing should follow approved pathways, cable requirements, field conditions, and project documentation.', false, true),
(60, 'Rough-In & Infrastructure', 'Cabling & Termination', 'scenario', 'scenario', 'During rough-in, a technician sees several low-voltage cables lying unsupported across ceiling tiles. What is the BEST response?', '[{"key":"A","text":"Leave them because the ceiling hides them"},{"key":"B","text":"Properly route and support the cables using the approved support/pathway method"},{"key":"C","text":"Attach them to the nearest plumbing pipe"},{"key":"D","text":"Bundle them around electrical conduit"}]'::jsonb, '"B"'::jsonb, 'Hidden work still needs to meet installation and workmanship standards.', false, true),
(61, 'Rough-In & Infrastructure', 'Cabling & Termination', 'scenario', 'scenario', 'A cable has been pulled through an area where later construction activity could damage it. What should the technician do?', '[{"key":"A","text":"Assume the other trades will avoid it"},{"key":"B","text":"Protect and secure the cable appropriately and communicate/document the condition when necessary"},{"key":"C","text":"Remove all cable from the project"},{"key":"D","text":"Wait until trim-out to determine whether it survived"}]'::jsonb, '"B"'::jsonb, 'Installed cable should be protected from foreseeable construction damage.', false, true),
(62, 'Rough-In & Infrastructure', 'Tools & Installation Methods', 'multiple_choice', 'application', 'A project requires low-voltage cable to be routed through conduit. What is the BEST approach?', '[{"key":"A","text":"Fill the conduit with as much cable as physically possible"},{"key":"B","text":"Follow the project''s pathway requirements and applicable cable/conduit installation standards"},{"key":"C","text":"Remove cable jackets to create additional space"},{"key":"D","text":"Force cables through any obstruction"}]'::jsonb, '"B"'::jsonb, 'Conduit use must account for proper cable installation, protection, and applicable project requirements.', false, true),
(63, 'Rough-In & Infrastructure', 'Documentation', 'multiple_choice', 'application', 'When should cables be identified during the rough-in process?', '[{"key":"A","text":"Only after the entire system is programmed"},{"key":"B","text":"According to the project''s labeling standard as the cables are installed so their identity is maintained"},{"key":"C","text":"Only when two cables are the same color"},{"key":"D","text":"Labeling is unnecessary during rough-in"}]'::jsonb, '"B"'::jsonb, 'Early, consistent labeling prevents confusion during trim-out, testing, commissioning, and service.', false, true),
(64, 'Rough-In & Infrastructure', 'Quality Control', 'multiple_select', 'scenario', 'Before declaring an area of rough-in complete, which THREE items should the technician verify?', '[{"key":"A","text":"Required cable runs are present and correctly identified"},{"key":"B","text":"Cables are appropriately routed, supported, and protected"},{"key":"C","text":"Required documentation or installation records are completed according to company/project standards"},{"key":"D","text":"Every device has been programmed"},{"key":"E","text":"Client training has been completed"}]'::jsonb, '["A","B","C"]'::jsonb, 'Rough-in completion should be verified before access becomes more difficult or finished surfaces conceal the work.', false, true),
(65, 'Rough-In & Infrastructure', 'Quality Control', 'scenario', 'scenario', 'During a final rough-in check, a technician discovers that one required cable was pulled to the wrong location. Drywall installation is scheduled to begin soon. What is the BEST action?', '[{"key":"A","text":"Leave it and hope the location can be changed later"},{"key":"B","text":"Mark the cable complete because it was technically pulled"},{"key":"C","text":"Immediately communicate the issue and correct the run according to project direction before the area is closed when possible"},{"key":"D","text":"Hide the incorrectly located cable"}]'::jsonb, '"C"'::jsonb, 'Correcting rough-in errors before walls or ceilings are closed can prevent significant rework later.', false, true),
(66, 'Trim-Out, Device Installation & Finish', 'Tools & Installation Methods', 'multiple_choice', 'foundational', 'What is a primary purpose of the trim-out stage?', '[{"key":"A","text":"Develop the original system proposal"},{"key":"B","text":"Complete terminations and install wall plates, connectors, devices, and related finish components"},{"key":"C","text":"Perform only system programming"},{"key":"D","text":"Conduct the initial site survey"}]'::jsonb, '"B"'::jsonb, 'Trim-out converts rough-in infrastructure into finished connection and device locations ready for equipment installation and testing.', false, true),
(67, 'Trim-Out, Device Installation & Finish', 'Cabling & Termination', 'multiple_select', 'application', 'Before terminating a cable at a finished wall location, which THREE actions are appropriate?', '[{"key":"A","text":"Verify the cable identification"},{"key":"B","text":"Confirm the intended connection/device using project documentation"},{"key":"C","text":"Inspect the cable for visible damage"},{"key":"D","text":"Remove the cable label permanently"},{"key":"E","text":"Cut the cable as short as possible before checking requirements"}]'::jsonb, '["A","B","C"]'::jsonb, 'Cable identity, intended use, and physical condition should be confirmed before termination.', false, true),
(68, 'Trim-Out, Device Installation & Finish', 'Quality Control', 'multiple_choice', 'application', 'A technician is installing a finished wall plate. Which result BEST represents professional workmanship?', '[{"key":"A","text":"The plate is secure, properly aligned, clean, undamaged, and installed according to the project requirements"},{"key":"B","text":"The plate is functional even though it is loose"},{"key":"C","text":"The plate covers most of the opening, so alignment does not matter"},{"key":"D","text":"The plate is installed with whatever hardware happens to fit"}]'::jsonb, '"A"'::jsonb, 'Finished installation quality includes function, fit, alignment, cleanliness, and protection of the surrounding surface.', false, true),
(69, 'Trim-Out, Device Installation & Finish', 'AV Systems', 'scenario', 'scenario', 'A technician is preparing to cut a finished ceiling for an in-ceiling speaker. What should happen BEFORE the opening is cut?', '[{"key":"A","text":"Cut the opening based only on the speaker''s approximate size"},{"key":"B","text":"Verify the approved location, check for obstructions, confirm the required cutout, and protect the surrounding area"},{"key":"C","text":"Make the opening larger than necessary so the speaker is easier to install"},{"key":"D","text":"Cut first and check the drawing afterward"}]'::jsonb, '"B"'::jsonb, 'Verification before cutting reduces incorrect placement, hidden conflicts, property damage, and unnecessary rework.', false, true),
(70, 'Trim-Out, Device Installation & Finish', 'Cabling & Termination', 'scenario', 'scenario', 'A technician finds more cable at a wall location than is needed for the immediate termination. What is the BEST approach?', '[{"key":"A","text":"Cut away all excess cable immediately"},{"key":"B","text":"Follow the project''s requirements for serviceability, cable management, and appropriate service length before trimming or dressing the cable"},{"key":"C","text":"Push an uncontrolled bundle into the wall"},{"key":"D","text":"Remove the cable and pull a shorter one"}]'::jsonb, '"B"'::jsonb, 'Enough usable cable should remain for proper installation and future service while maintaining professional cable management.', false, true),
(71, 'Trim-Out, Device Installation & Finish', 'Quality Control', 'scenario', 'scenario', 'During trim-out, a technician notices drywall dust and installation debris accumulating around completed flooring and client finishes. What should the technician do?', '[{"key":"A","text":"Continue until the entire project is finished"},{"key":"B","text":"Maintain the work area, protect finished surfaces, and clean installation debris as work progresses"},{"key":"C","text":"Push the debris into an unfinished room"},{"key":"D","text":"Assume another trade will clean it"}]'::jsonb, '"B"'::jsonb, 'Cleanliness and protection of finished spaces are part of professional installation standards.', false, true),
(72, 'Trim-Out, Device Installation & Finish', 'Tools & Installation Methods', 'scenario', 'scenario', 'A specified device does not properly fit the prepared opening or mounting location. What is the BEST action?', '[{"key":"A","text":"Force the device into place"},{"key":"B","text":"Enlarge the opening immediately without checking anything"},{"key":"C","text":"Stop and verify the device, mounting requirements, documentation, and field condition before making a modification"},{"key":"D","text":"Substitute another device without authorization"}]'::jsonb, '"C"'::jsonb, 'A fit problem can indicate an incorrect device, opening, documentation issue, or field-condition problem and should be investigated before altering finished work.', false, true),
(73, 'Trim-Out, Device Installation & Finish', 'Quality Control', 'multiple_select', 'scenario', 'Before considering a trim-out area complete, which FOUR items should the technician verify?', '[{"key":"A","text":"Required devices, plates, and terminations are properly installed"},{"key":"B","text":"Cable/device labels are present according to project standards"},{"key":"C","text":"Completed work is visually inspected and required testing is performed"},{"key":"D","text":"The work area is clean and finished surfaces are protected from damage"},{"key":"E","text":"Every future system upgrade has already been designed"},{"key":"F","text":"All project invoices have been paid"}]'::jsonb, '["A","B","C","D"]'::jsonb, 'Trim-out completion includes installation, identification, inspection/testing, and workmanship.', false, true),
(74, 'AV Systems Fundamentals', 'AV Systems', 'multiple_choice', 'foundational', 'What does AV stand for in systems integration?', '[{"key":"A","text":"Automated Voltage"},{"key":"B","text":"Audio Visual"},{"key":"C","text":"Analog Verification"},{"key":"D","text":"Auxiliary Video"}]'::jsonb, '"B"'::jsonb, 'AV refers to audio and visual/video technologies and the systems used to distribute, reproduce, and control them.', false, false),
(75, 'AV Systems Fundamentals', 'AV Systems', 'multiple_choice', 'foundational', 'What is the primary role of a source device in an AV system?', '[{"key":"A","text":"Provide content or a signal to another component in the system"},{"key":"B","text":"Supply structural support for equipment"},{"key":"C","text":"Label installed cabling"},{"key":"D","text":"Cool an equipment rack"}]'::jsonb, '"A"'::jsonb, 'A source originates or provides content/signals that are passed through the AV system.', false, false),
(76, 'AV Systems Fundamentals', 'AV Systems', 'multiple_choice', 'application', 'A basic video system consists of a media player, an AV receiver, and a display. Which sequence BEST represents the expected signal flow?', '[{"key":"A","text":"Display → receiver → media player"},{"key":"B","text":"Media player → receiver → display"},{"key":"C","text":"Receiver → display → media player"},{"key":"D","text":"Display → media player → receiver"}]'::jsonb, '"B"'::jsonb, 'Understanding source-to-destination signal flow is fundamental to installation and troubleshooting.', false, true),
(77, 'AV Systems Fundamentals', 'AV Systems', 'multiple_choice', 'application', 'A technician needs to connect a source device to a display. The source device provides an HDMI OUT, and the display provides an HDMI IN. What is the correct connection?', '[{"key":"A","text":"Source OUT → Display IN"},{"key":"B","text":"Display IN → Source IN"},{"key":"C","text":"Source OUT → Source IN"},{"key":"D","text":"Display OUT → Display IN"}]'::jsonb, '"A"'::jsonb, 'Signals normally travel from an output on the transmitting/source device to an input on the receiving/destination device.', false, true),
(78, 'AV Systems Fundamentals', 'AV Systems', 'multiple_choice', 'foundational', 'What is the primary function of an audio power amplifier in a typical AV system?', '[{"key":"A","text":"Provide the power needed to drive connected passive loudspeakers"},{"key":"B","text":"Assign IP addresses to network devices"},{"key":"C","text":"Convert every video signal to audio"},{"key":"D","text":"Provide cable labeling"}]'::jsonb, '"A"'::jsonb, 'An audio power amplifier provides the power needed to drive connected passive loudspeakers.', false, false),
(79, 'AV Systems Fundamentals', 'Documentation', 'scenario', 'scenario', 'A technician is connecting equipment in an AV rack and discovers that a cable label does not match the connection shown on the approved system documentation. What should the technician do?', '[{"key":"A","text":"Connect it based on where it appears to fit"},{"key":"B","text":"Ignore the label and continue"},{"key":"C","text":"Verify the cable identity and documentation and resolve or report the discrepancy before making the connection"},{"key":"D","text":"Change the documentation without telling anyone"}]'::jsonb, '"C"'::jsonb, 'Cable identity and signal path should be verified rather than assumed.', false, true),
(80, 'AV Systems Fundamentals', 'Troubleshooting', 'troubleshooting', 'scenario', 'A display powers on but shows no video from the selected source. What is the BEST initial approach for a Technician I?', '[{"key":"A","text":"Replace the display immediately"},{"key":"B","text":"Verify the source is operating, the correct input is selected, and the signal-path connections are correct before replacing equipment"},{"key":"C","text":"Reprogram the entire control system"},{"key":"D","text":"Increase the voltage supplied to the display"}]'::jsonb, '"B"'::jsonb, 'Basic AV troubleshooting should follow the signal path and verify simple causes before equipment is replaced.', false, true),
(81, 'Networking Fundamentals', 'Networking', 'multiple_choice', 'foundational', 'What is a primary purpose of a computer network in an integrated AV system?', '[{"key":"A","text":"Allow connected devices to communicate and exchange data"},{"key":"B","text":"Replace all speaker wiring"},{"key":"C","text":"Eliminate the need for electrical power"},{"key":"D","text":"Physically support equipment"}]'::jsonb, '"A"'::jsonb, 'Modern AV, control, security, surveillance, and automation systems frequently rely on network communication between devices.', false, false),
(82, 'Networking Fundamentals', 'Networking', 'multiple_choice', 'foundational', 'What is the primary purpose of an Ethernet network switch?', '[{"key":"A","text":"Connect devices on a network and forward network traffic"},{"key":"B","text":"Amplify speaker signals"},{"key":"C","text":"Convert every video signal to audio"},{"key":"D","text":"Supply line voltage to a building"}]'::jsonb, '"A"'::jsonb, 'An Ethernet switch connects devices on a network and forwards network traffic.', false, true),
(83, 'Networking Fundamentals', 'Networking', 'multiple_choice', 'application', 'Which statement BEST describes the basic purpose of a router?', '[{"key":"A","text":"It routes traffic between different networks"},{"key":"B","text":"It terminates speaker cable"},{"key":"C","text":"It amplifies audio signals"},{"key":"D","text":"It functions only as a cable tester"}]'::jsonb, '"A"'::jsonb, 'At the Technician I level, the important distinction is that a switch primarily connects devices within a network while a router routes traffic between networks.', false, true),
(84, 'Networking Fundamentals', 'Networking', 'multiple_choice', 'application', 'A newly connected network device is configured to obtain its network settings automatically. Which service commonly provides an IP address and other network configuration information automatically?', '[{"key":"A","text":"HDMI"},{"key":"B","text":"DHCP"},{"key":"C","text":"XLR"},{"key":"D","text":"AC"}]'::jsonb, '"B"'::jsonb, 'DHCP is commonly used to automatically assign network configuration information to devices.', false, true),
(85, 'Networking Fundamentals', 'Networking', 'multiple_choice', 'application', 'What does PoE allow compatible network equipment to do?', '[{"key":"A","text":"Carry network data and electrical power over Ethernet cabling"},{"key":"B","text":"Convert Ethernet into speaker-level audio automatically"},{"key":"C","text":"Operate without any source of electrical power"},{"key":"D","text":"Increase the maximum resolution of every display"}]'::jsonb, '"A"'::jsonb, 'Power over Ethernet can provide both network connectivity and power to compatible devices.', false, true),
(86, 'Networking Fundamentals', 'Networking', 'troubleshooting', 'scenario', 'A newly installed network-connected AV device powers on but does not appear to be communicating with the system. What is the BEST initial approach for a Technician I?', '[{"key":"A","text":"Factory-reset every network device in the building"},{"key":"B","text":"Replace the network switch"},{"key":"C","text":"Verify the physical network connection, cable/termination, expected network connection point, and device status before escalating the issue"},{"key":"D","text":"Begin changing advanced network settings without direction"}]'::jsonb, '"C"'::jsonb, 'Technician I should verify the physical and basic connectivity layer before assuming an advanced configuration problem.', false, true),
(87, 'Security & Surveillance Fundamentals', 'Security / Surveillance', 'multiple_choice', 'foundational', 'Which statement BEST describes the difference between a security/alarm system and a surveillance system?', '[{"key":"A","text":"They are always the same system"},{"key":"B","text":"Security systems commonly detect or report events such as intrusion, while surveillance systems commonly use cameras to monitor and record activity"},{"key":"C","text":"Surveillance systems only work when an alarm is sounding"},{"key":"D","text":"Security systems never use network connections"}]'::jsonb, '"B"'::jsonb, 'The systems may be integrated, but they perform different primary functions.', false, false),
(88, 'Security & Surveillance Fundamentals', 'Security / Surveillance', 'multiple_select', 'application', 'Which THREE could commonly be components of an intrusion/security system?', '[{"key":"A","text":"Door/window contact"},{"key":"B","text":"Motion detector"},{"key":"C","text":"Security control panel"},{"key":"D","text":"Passive loudspeaker used for music playback"},{"key":"E","text":"Video distribution amplifier"}]'::jsonb, '["A","B","C"]'::jsonb, 'Contacts and motion detectors provide detection inputs, while a security control panel processes and manages the system.', false, true),
(89, 'Security & Surveillance Fundamentals', 'Security / Surveillance', 'scenario', 'scenario', 'A drawing specifies a surveillance camera location. Before permanently mounting the camera, what should the technician verify?', '[{"key":"A","text":"Only that the camera physically fits"},{"key":"B","text":"The approved location, mounting requirements, intended coverage/orientation, required cabling, and potential obstructions"},{"key":"C","text":"That it is mounted at the same height as every other camera"},{"key":"D","text":"That the camera points toward the nearest doorway regardless of the design"}]'::jsonb, '"B"'::jsonb, 'Proper camera installation requires verification of location, coverage, mounting, cabling, and field conditions.', false, true),
(90, 'Security & Surveillance Fundamentals', 'Security / Surveillance', 'scenario', 'scenario', 'During installation, a technician discovers that a security device''s cable has been pulled to a location different from the approved documentation. What is the BEST response?', '[{"key":"A","text":"Move the security device without authorization"},{"key":"B","text":"Install the device at the cable location because moving cable takes longer"},{"key":"C","text":"Verify the documentation and communicate the discrepancy through the project''s established process before proceeding"},{"key":"D","text":"Abandon the cable and mark the installation complete"}]'::jsonb, '"C"'::jsonb, 'Technician I should recognize and report a discrepancy rather than independently altering the security design.', false, true),
(91, 'Lighting, Shades & Control Fundamentals', 'Lighting / Control Systems', 'multiple_choice', 'foundational', 'What is a luminaire?', '[{"key":"A","text":"A complete lighting unit that includes the components needed to produce and distribute light"},{"key":"B","text":"A network router used in lighting systems"},{"key":"C","text":"A motorized window shade"},{"key":"D","text":"A type of speaker"}]'::jsonb, '"A"'::jsonb, 'A luminaire is a complete lighting unit that includes the components needed to produce and distribute light.', false, false),
(92, 'Lighting, Shades & Control Fundamentals', 'Lighting / Control Systems', 'multiple_choice', 'application', 'What is a primary purpose of a lighting-control system?', '[{"key":"A","text":"Control lighting behavior such as on/off operation, dimming, scenes, or automated operation"},{"key":"B","text":"Provide audio amplification"},{"key":"C","text":"Replace the building''s network"},{"key":"D","text":"Record surveillance video"}]'::jsonb, '"A"'::jsonb, 'Lighting-control systems allow lighting to be controlled individually, collectively, or automatically depending on system design.', false, true),
(93, 'Lighting, Shades & Control Fundamentals', 'Lighting / Control Systems', 'multiple_choice', 'application', 'Why might motorized shades be integrated with a lighting and automation system?', '[{"key":"A","text":"To coordinate natural light, privacy, comfort, and automated room behavior"},{"key":"B","text":"To provide Ethernet switching"},{"key":"C","text":"To amplify an audio signal"},{"key":"D","text":"To replace security sensors"}]'::jsonb, '"A"'::jsonb, 'Shade systems can work with lighting and automation to manage natural light and the environment within a space.', false, true),
(94, 'Lighting, Shades & Control Fundamentals', 'Lighting / Control Systems', 'scenario', 'scenario', 'A client presses a single button labeled “Movie” and the system lowers the shades, adjusts the lighting, turns on the AV equipment, and selects the appropriate source. What BEST describes what is happening?', '[{"key":"A","text":"Multiple integrated systems are responding to a programmed control command or scene"},{"key":"B","text":"The network has failed"},{"key":"C","text":"Each device is operating independently by coincidence"},{"key":"D","text":"The lighting system is supplying power directly to all AV equipment"}]'::jsonb, '"A"'::jsonb, 'Integrated control systems can coordinate multiple subsystems so a single command initiates several predefined actions.', false, true),
(95, 'Testing & Basic Troubleshooting', 'Testing & Commissioning', 'multiple_choice', 'foundational', 'Why should installed cables and system connections be tested before the work is considered complete?', '[{"key":"A","text":"To verify that the installation performs as expected and identify problems before final completion"},{"key":"B","text":"To eliminate the need for labeling"},{"key":"C","text":"To determine the project''s selling price"},{"key":"D","text":"Testing is only required when a client reports a problem"}]'::jsonb, '"A"'::jsonb, 'Testing helps identify installation problems before they become system failures, punch-list items, or service calls.', false, true),
(96, 'Testing & Basic Troubleshooting', 'Testing & Commissioning', 'multiple_choice', 'application', 'Before connecting test equipment to a newly terminated cable, what is a useful first step?', '[{"key":"A","text":"Immediately replace the cable"},{"key":"B","text":"Visually inspect the cable and termination for obvious problems"},{"key":"C","text":"Remove the cable label"},{"key":"D","text":"Connect equipment without checking anything"}]'::jsonb, '"B"'::jsonb, 'A visual inspection can identify obvious problems before additional troubleshooting begins.', false, true),
(97, 'Testing & Basic Troubleshooting', 'Testing & Commissioning', 'scenario', 'scenario', 'A cable that was just terminated fails its required test. What should the technician do?', '[{"key":"A","text":"Mark the cable as complete because it is newly installed"},{"key":"B","text":"Inspect the termination and cable installation, identify and correct the problem, and test again"},{"key":"C","text":"Replace the connected equipment immediately"},{"key":"D","text":"Ignore the failure unless the client notices a problem"}]'::jsonb, '"B"'::jsonb, 'Failed work should be diagnosed, corrected, and retested before being considered complete.', false, true),
(98, 'Testing & Basic Troubleshooting', 'Troubleshooting', 'multiple_choice', 'application', 'Which approach BEST represents systematic troubleshooting?', '[{"key":"A","text":"Change several things simultaneously until the problem disappears"},{"key":"B","text":"Immediately replace the most expensive component"},{"key":"C","text":"Verify the symptoms, check likely causes in a logical order, isolate variables, and confirm the solution"},{"key":"D","text":"Restart equipment repeatedly without investigating"}]'::jsonb, '"C"'::jsonb, 'A structured troubleshooting process helps identify the actual cause and prevents unnecessary changes or equipment replacement.', false, true),
(99, 'Testing & Basic Troubleshooting', 'Troubleshooting', 'troubleshooting', 'scenario', 'An audio system powers on, but one room has no sound. What is the BEST initial approach?', '[{"key":"A","text":"Replace every speaker in the room"},{"key":"B","text":"Verify the expected source and system settings, then follow the signal path and check the relevant connections before replacing equipment"},{"key":"C","text":"Increase amplifier output to maximum"},{"key":"D","text":"Reprogram the entire automation system"}]'::jsonb, '"B"'::jsonb, 'Following the expected signal path and verifying fundamentals helps isolate where the problem begins.', false, true),
(100, 'Testing & Basic Troubleshooting', 'Troubleshooting', 'scenario', 'scenario', 'A Technician I has verified the cable, termination, physical connections, power, and other basic items they are trained and authorized to check. The system problem remains unresolved. What is the BEST next action?', '[{"key":"A","text":"Begin changing advanced programming and network settings"},{"key":"B","text":"Continue changing equipment until something works"},{"key":"C","text":"Document what has been checked and escalate the issue to the appropriate Technician II, Lead Technician, programmer, or supervisor"},{"key":"D","text":"Tell the client the equipment is defective without further investigation"}]'::jsonb, '"C"'::jsonb, 'Good troubleshooting includes knowing the limits of your role and documenting completed checks before escalation.', false, true);

do $$
declare
  v_industry_id uuid;
  v_role_id uuid;
  v_assessment_id uuid;
  v_competency_id uuid;
  v_question_id uuid;
  v_row record;
begin
  select id into v_industry_id
  from industries
  where lower(slug) = 'ci'
     or lower(name) = 'custom integration'
  order by case when lower(slug) = 'ci' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Custom Integration (CI) industry not found. Run 0003 first.';
  end if;

  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Technician I — Entry Level'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    raise exception 'Current Technician I — Entry Level master role template not found.';
  end if;

  select id into v_assessment_id
  from assessments
  where client_id is null
    and industry_id = v_industry_id
    and name = 'Technician I — Entry Level Pre-Assessment'
    and is_current = true
  order by version desc
  limit 1;

  if v_assessment_id is null then
    insert into assessments (
      client_id, industry_id, name, type,
      master_role_template_id, version, is_current
    )
    values (
      null, v_industry_id, 'Technician I — Entry Level Pre-Assessment',
      'initial', v_role_id, 1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_tech1_questions order by question_number
  loop
    select id into v_competency_id
    from master_competency_templates
    where industry_id = v_industry_id
      and name = v_row.competency_name
      and is_current = true
    order by version desc
    limit 1;

    if v_competency_id is null then
      raise exception 'Required competency not found for question %: %',
        v_row.question_number, v_row.competency_name;
    end if;

    select id into v_question_id
    from master_question_bank
    where industry_id = v_industry_id
      and prompt = v_row.prompt
      and is_current = true
    order by version desc
    limit 1;

    if v_question_id is null then
      insert into master_question_bank (
        industry_id, master_competency_template_id, domain, type,
        difficulty, prompt, options, points, critical_safety,
        practical_verification_required, status, version, is_current
      )
      values (
        v_industry_id, v_competency_id, v_row.domain, v_row.question_type,
        v_row.difficulty, v_row.prompt, v_row.options, 1,
        v_row.critical_safety, v_row.practical_verification_required,
        'approved', 1, true
      )
      returning id into v_question_id;
    end if;

    insert into master_question_answer_keys (
      master_question_id, correct_answer, scoring_notes, rationale
    )
    select
      v_question_id, v_row.correct_answer,
      'Seeded Technician I v1.0 answer key.', v_row.rationale
    where not exists (
      select 1 from master_question_answer_keys k
      where k.master_question_id = v_question_id
    );

    insert into master_question_role_applicability (
      master_question_id, master_role_template_id
    )
    values (v_question_id, v_role_id)
    on conflict (master_question_id, master_role_template_id) do nothing;
  end loop;
end;
$$;


insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Safety, OSHA & Job-Site Practices',
  c.id,
  15,
  4,
  6,
  5,
  1
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Safety & Job-Site Standards'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Safety, OSHA & Job-Site Practices'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Low-Voltage & Electrical Fundamentals',
  c.id,
  10,
  4,
  3,
  3,
  2
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Low-Voltage Fundamentals'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Low-Voltage & Electrical Fundamentals'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Cable, Connectors & Termination',
  c.id,
  15,
  3,
  7,
  5,
  3
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Cabling & Termination'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Cable, Connectors & Termination'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Tools & Installation Methods',
  c.id,
  8,
  1,
  3,
  4,
  4
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Tools & Installation Methods'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Tools & Installation Methods'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Drawings, Schematics & Documentation',
  c.id,
  7,
  2,
  3,
  2,
  5
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Blueprint / Drawing Reading'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Drawings, Schematics & Documentation'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Rough-In & Infrastructure',
  c.id,
  10,
  1,
  4,
  5,
  6
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Cabling & Termination'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Rough-In & Infrastructure'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Trim-Out, Device Installation & Finish',
  c.id,
  8,
  1,
  2,
  5,
  7
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Tools & Installation Methods'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Trim-Out, Device Installation & Finish'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'AV Systems Fundamentals',
  c.id,
  7,
  3,
  2,
  2,
  8
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'AV Systems'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'AV Systems Fundamentals'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Networking Fundamentals',
  c.id,
  6,
  2,
  3,
  1,
  9
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Networking'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Networking Fundamentals'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Security & Surveillance Fundamentals',
  c.id,
  4,
  1,
  1,
  2,
  10
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Security / Surveillance'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Security & Surveillance Fundamentals'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Lighting, Shades & Control Fundamentals',
  c.id,
  4,
  1,
  2,
  1,
  11
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Lighting / Control Systems'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Lighting, Shades & Control Fundamentals'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

insert into assessment_blueprint_rules (
  assessment_id, domain, master_competency_template_id,
  question_count, foundational_count, application_count,
  scenario_count, sort_order
)
select
  a.id,
  'Testing & Basic Troubleshooting',
  c.id,
  6,
  1,
  2,
  3,
  12
from assessments a
join industries i on i.id = a.industry_id
join master_competency_templates c
  on c.industry_id = a.industry_id
 and c.name = 'Testing & Commissioning'
 and c.is_current = true
where a.client_id is null
  and a.name = 'Technician I — Entry Level Pre-Assessment'
  and a.is_current = true
  and (lower(i.slug) = 'ci' or lower(i.name) = 'custom integration')
  and not exists (
    select 1
    from assessment_blueprint_rules b
    where b.assessment_id = a.id
      and b.domain = 'Testing & Basic Troubleshooting'
      and b.master_competency_template_id = c.id
  )
order by c.version desc
limit 1;

commit;

-- Verification. Expected: 100, 100, 100, 12, 100.
with ci as (
  select id
  from industries
  where lower(slug) = 'ci'
     or lower(name) = 'custom integration'
  order by case when lower(slug) = 'ci' then 0 else 1 end
  limit 1
),
tech_role as (
  select id
  from master_role_templates
  where industry_id = (select id from ci)
    and name = 'Technician I — Entry Level'
    and is_current = true
  order by version desc
  limit 1
),
tech_assessment as (
  select id
  from assessments
  where client_id is null
    and industry_id = (select id from ci)
    and name = 'Technician I — Entry Level Pre-Assessment'
    and is_current = true
  order by version desc
  limit 1
),
seeded_questions as (
  select q.id
  from master_question_bank q
  join _seed_tech1_questions s on s.prompt = q.prompt
  where q.industry_id = (select id from ci)
    and q.is_current = true
)
select
  (select count(*) from seeded_questions) as seeded_questions,
  (select count(*) from master_question_answer_keys k
    where k.master_question_id in (select id from seeded_questions)) as seeded_answer_keys,
  (select count(*) from master_question_role_applicability r
    where r.master_role_template_id = (select id from tech_role)
      and r.master_question_id in (select id from seeded_questions)) as technician_i_role_mappings,
  (select count(*) from assessment_blueprint_rules b
    where b.assessment_id = (select id from tech_assessment)) as blueprint_rules,
  (select coalesce(sum(question_count),0) from assessment_blueprint_rules b
    where b.assessment_id = (select id from tech_assessment)) as blueprint_question_total;
