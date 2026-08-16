-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0151_ci_tools_installation_methods_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Tools & Installation Methods
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

create temporary table _seed_ci_tools_installation_methods_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_tools_installation_methods_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What should determine which tool a technician selects for a task?',
  '[{"key":"A","text":"The task, material, manufacturer instructions, and intended use of the tool"},{"key":"B","text":"Whichever tool is closest"},{"key":"C","text":"The largest tool available"},{"key":"D","text":"Whichever tool was used most recently"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct tool selection supports safety, workmanship, and protection of materials and equipment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is it important to inspect a tool before use?',
  '[{"key":"A","text":"To identify damage, wear, missing guards, or other conditions that could affect safe operation"},{"key":"B","text":"To make the tool run faster"},{"key":"C","text":"To avoid reading manufacturer instructions"},{"key":"D","text":"To change the tool warranty"}]'::jsonb,
  '["A"]'::jsonb,
  'A pre-use inspection helps identify unsafe or unreliable tool conditions before work begins.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of measuring before drilling, cutting, or mounting?',
  '[{"key":"A","text":"To confirm the intended location and reduce errors, rework, and property damage"},{"key":"B","text":"To make tools easier to carry"},{"key":"C","text":"To eliminate project drawings"},{"key":"D","text":"To determine cable color"}]'::jsonb,
  '["A"]'::jsonb,
  'Verification before permanent work reduces incorrect placement and avoidable rework.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a primary purpose of the rough-in stage?',
  '[{"key":"A","text":"Install infrastructure, pathways, cabling, and related components before finished surfaces limit access"},{"key":"B","text":"Perform final client training"},{"key":"C","text":"Complete only programming"},{"key":"D","text":"Close service tickets"}]'::jsonb,
  '["A"]'::jsonb,
  'Rough-in establishes the infrastructure needed for later trim-out, equipment installation, and system completion.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a primary purpose of the trim-out stage?',
  '[{"key":"A","text":"Complete terminations and install wall plates, connectors, devices, and related finish components"},{"key":"B","text":"Create the original proposal"},{"key":"C","text":"Perform the initial site survey"},{"key":"D","text":"Order all project equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Trim-out converts rough-in infrastructure into finished device and connection locations.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should technicians protect finished surfaces before beginning installation work?',
  '[{"key":"A","text":"To reduce the risk of damaging flooring, cabinetry, walls, furniture, and other client property"},{"key":"B","text":"To make tools easier to find"},{"key":"C","text":"To eliminate cleanup"},{"key":"D","text":"To avoid using ladders"}]'::jsonb,
  '["A"]'::jsonb,
  'Protecting the work area is part of professional installation workmanship.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What should a technician do if the correct tool for a task is unavailable?',
  '[{"key":"A","text":"Obtain the appropriate tool or an approved alternative method before proceeding"},{"key":"B","text":"Modify another tool until it works"},{"key":"C","text":"Use additional force"},{"key":"D","text":"Skip the task without telling anyone"}]'::jsonb,
  '["A"]'::jsonb,
  'Improvised tool use can create safety hazards, damage equipment, and reduce installation quality.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should tools be used according to their intended purpose?',
  '[{"key":"A","text":"Because misuse can create safety risks, damage materials, and produce poor workmanship"},{"key":"B","text":"Because every tool produces the same result"},{"key":"C","text":"Because intended use affects only appearance"},{"key":"D","text":"Because tools cannot be replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'Using tools as intended supports safer work and more consistent installation quality.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician needs to remove the outer jacket from a communications cable. What is the BEST approach?',
  '[{"key":"A","text":"Use an appropriate cable-preparation tool and avoid damaging the conductors"},{"key":"B","text":"Cut deeply with any sharp object"},{"key":"C","text":"Pull the jacket off with pliers"},{"key":"D","text":"Twist the cable until the jacket separates"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable preparation should remove only the required jacket without damaging the conductors underneath.'
),
(
  10,
  'multiple_choice',
  'application',
  'A connector requires a specific crimping tool. What should the technician do?',
  '[{"key":"A","text":"Use the specified or approved termination tool and follow the connector requirements"},{"key":"B","text":"Use standard pliers"},{"key":"C","text":"Hand-tighten the connector regardless of its design"},{"key":"D","text":"Modify the connector so another tool fits"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper tooling is part of producing a reliable termination.'
),
(
  11,
  'multiple_choice',
  'application',
  'Before mounting a device, the technician notices that the field measurement differs from the drawing. What should happen?',
  '[{"key":"A","text":"Verify the intended location and resolve the discrepancy before drilling or mounting"},{"key":"B","text":"Use the drawing without checking the field condition"},{"key":"C","text":"Use the field measurement without checking the documentation"},{"key":"D","text":"Choose a location halfway between them"}]'::jsonb,
  '["A"]'::jsonb,
  'Permanent work should not proceed until conflicting location information is resolved.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is preparing to drill through a wall. What should be considered before drilling?',
  '[{"key":"A","text":"Potential concealed wiring, plumbing, structural components, and other hazards"},{"key":"B","text":"Only the drill-bit color"},{"key":"C","text":"Only the wall paint"},{"key":"D","text":"Only how fast the hole can be made"}]'::jsonb,
  '["A"]'::jsonb,
  'Drilling should be planned with awareness of concealed building systems and structural conditions.'
),
(
  13,
  'multiple_choice',
  'application',
  'A project requires cable to be routed through conduit. What is the BEST installation approach?',
  '[{"key":"A","text":"Follow the project pathway requirements and applicable cable and conduit installation practices"},{"key":"B","text":"Fill the conduit with as much cable as will physically fit"},{"key":"C","text":"Remove cable jackets to create space"},{"key":"D","text":"Force cables through obstructions"}]'::jsonb,
  '["A"]'::jsonb,
  'Conduit installation should protect cable and follow the required pathway and installation criteria.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician is mounting equipment to a finished surface. What should be verified before fastening it?',
  '[{"key":"A","text":"Location, mounting method, substrate, hardware, alignment, and project requirements"},{"key":"B","text":"Only whether the device turns on"},{"key":"C","text":"Only the fastener color"},{"key":"D","text":"Only whether the device is lightweight"}]'::jsonb,
  '["A"]'::jsonb,
  'Mounting should account for the actual substrate, hardware, placement, and equipment requirements.'
),
(
  15,
  'multiple_choice',
  'application',
  'A tool begins operating unusually during a task. What should the technician do?',
  '[{"key":"A","text":"Stop using it and inspect or remove it from service according to company procedure"},{"key":"B","text":"Continue until the task is complete"},{"key":"C","text":"Apply more force"},{"key":"D","text":"Have another technician use it instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Abnormal tool operation can indicate a condition that should be evaluated before continued use.'
),
(
  16,
  'multiple_choice',
  'application',
  'Why should a technician keep the work area organized during installation?',
  '[{"key":"A","text":"It improves safety, protects finished surfaces and equipment, and supports efficient workmanship"},{"key":"B","text":"It eliminates the need for tools"},{"key":"C","text":"It increases cable bandwidth"},{"key":"D","text":"It changes project scope"}]'::jsonb,
  '["A"]'::jsonb,
  'An organized work area supports safe and professional execution.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician must drill through a building surface but is unsure what may be behind it. What is the BEST action?',
  '[{"key":"A","text":"Verify the drilling location and potential concealed hazards before proceeding"},{"key":"B","text":"Drill slowly and see what happens"},{"key":"C","text":"Select a longer drill bit"},{"key":"D","text":"Increase drill speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Potential concealed electrical wiring, plumbing, structural components, and other hazards should be considered before drilling.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician must install equipment in a finished room with completed flooring and cabinetry. What is the BEST approach?',
  '[{"key":"A","text":"Protect the work area and finished surfaces before beginning installation"},{"key":"B","text":"Place tools directly on the finished surfaces"},{"key":"C","text":"Assume any damage can be repaired later"},{"key":"D","text":"Treat the room like an unfinished construction area"}]'::jsonb,
  '["A"]'::jsonb,
  'Protecting client property is part of professional installation workmanship.'
),
(
  19,
  'scenario',
  'scenario',
  'A specified device does not fit the prepared opening. What is the BEST action?',
  '[{"key":"A","text":"Stop and verify the device, mounting requirements, documentation, and field condition before modifying anything"},{"key":"B","text":"Force the device into place"},{"key":"C","text":"Enlarge the opening immediately"},{"key":"D","text":"Substitute another device without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'A fit problem can indicate an incorrect device, opening, documentation issue, or field-condition problem.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician does not have the correct tool but believes another tool can probably be made to work. What is the BEST decision?',
  '[{"key":"A","text":"Obtain the correct tool or an approved alternative method before proceeding"},{"key":"B","text":"Modify the available tool"},{"key":"C","text":"Use more force"},{"key":"D","text":"Ask the least-experienced technician to try"}]'::jsonb,
  '["A"]'::jsonb,
  'Improvised tool use increases the risk of injury, equipment damage, and poor workmanship.'
);

create temporary table _seed_ci_tools_installation_methods_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_tools_installation_methods_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should a technician match a drill bit or cutting accessory to the material being worked on?',
  '[{"key":"A","text":"Different materials require appropriate cutting characteristics for safe, controlled, and effective work"},{"key":"B","text":"All accessories work the same on every material"},{"key":"C","text":"It only affects tool appearance"},{"key":"D","text":"It eliminates the need for measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Accessory selection should match the substrate and task to reduce damage, poor results, and unnecessary risk.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should determine the type and size of mounting hardware used for equipment?',
  '[{"key":"A","text":"Equipment load, substrate, mounting method, manufacturer requirements, and project conditions"},{"key":"B","text":"Whichever fastener is closest"},{"key":"C","text":"Only the color of the hardware"},{"key":"D","text":"Only the device dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'Mounting hardware must be appropriate for the equipment, substrate, and intended installation method.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is torque control important when a manufacturer specifies a fastening torque?',
  '[{"key":"A","text":"Under-tightening or over-tightening can affect reliability, retention, or damage components"},{"key":"B","text":"Torque matters only for automotive work"},{"key":"C","text":"More torque is always better"},{"key":"D","text":"Torque affects only appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Specified torque helps achieve the intended mechanical connection without leaving hardware loose or damaging components.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should ladders and access equipment be selected for the actual work condition?',
  '[{"key":"A","text":"Height, surface, load, access, and task conditions affect safe and effective use"},{"key":"B","text":"Any ladder is acceptable for any task"},{"key":"C","text":"Only ladder color matters"},{"key":"D","text":"Access equipment eliminates planning"}]'::jsonb,
  '["A"]'::jsonb,
  'Access equipment should suit the height, environment, load, and task rather than being chosen only by convenience.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of using a level, laser, or other alignment tool during installation?',
  '[{"key":"A","text":"To verify position, level, plumb, or alignment before permanent fastening"},{"key":"B","text":"To test network performance"},{"key":"C","text":"To identify cable categories"},{"key":"D","text":"To eliminate measuring"}]'::jsonb,
  '["A"]'::jsonb,
  'Alignment tools help technicians verify placement before making permanent installation decisions.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician is mounting a display to a wall and cannot confirm the wall construction. What should happen before selecting anchors?',
  '[{"key":"A","text":"Identify the substrate and verify the required mounting method and load support"},{"key":"B","text":"Use the largest anchor available"},{"key":"C","text":"Use the same anchor used on the previous project"},{"key":"D","text":"Install into drywall without checking"}]'::jsonb,
  '["A"]'::jsonb,
  'Anchor selection depends on the actual substrate, equipment load, mounting design, and manufacturer requirements.'
),
(
  7,
  'multiple_choice',
  'application',
  'A power tool repeatedly binds while drilling through a surface. What is the BEST response?',
  '[{"key":"A","text":"Stop and evaluate the material, accessory, tool setup, and possible obstruction before continuing"},{"key":"B","text":"Apply maximum force"},{"key":"C","text":"Increase speed regardless of material"},{"key":"D","text":"Continue until the accessory breaks through"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated binding can indicate the wrong accessory, poor technique, concealed obstruction, or another condition that should be investigated.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician must cut an opening in finished cabinetry. What is the BEST preparation?',
  '[{"key":"A","text":"Verify dimensions and location, protect the finish, select the proper tool and blade, and plan the cut before starting"},{"key":"B","text":"Cut quickly before the cabinet can move"},{"key":"C","text":"Use any available saw blade"},{"key":"D","text":"Make the opening oversized to save time"}]'::jsonb,
  '["A"]'::jsonb,
  'Finished work requires controlled measurement, surface protection, correct tooling, and deliberate execution.'
),
(
  9,
  'multiple_choice',
  'application',
  'A device mounting bracket has multiple approved fastener locations. What should the technician consider when choosing them?',
  '[{"key":"A","text":"The substrate, load distribution, bracket design, manufacturer requirements, and field condition"},{"key":"B","text":"Only which holes are easiest to reach"},{"key":"C","text":"Only the bracket color"},{"key":"D","text":"Only the number of spare fasteners"}]'::jsonb,
  '["A"]'::jsonb,
  'Fastener placement should support the intended load and approved mounting method.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician notices excessive vibration while using a cutting tool. What should be done?',
  '[{"key":"A","text":"Stop and inspect the tool, accessory installation, accessory condition, and material setup before continuing"},{"key":"B","text":"Hold the tool tighter and continue"},{"key":"C","text":"Increase speed automatically"},{"key":"D","text":"Have another technician finish without inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected vibration can indicate an improperly installed or damaged accessory, tool problem, or unstable workpiece.'
),
(
  11,
  'multiple_choice',
  'application',
  'A mounting location requires a fastener near the edge of a brittle material. What should the technician do?',
  '[{"key":"A","text":"Verify the approved mounting method, edge-clearance requirements, pilot-hole needs, and substrate limitations before fastening"},{"key":"B","text":"Use maximum torque immediately"},{"key":"C","text":"Move the fastener without checking the design"},{"key":"D","text":"Use a larger fastener automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Brittle materials can crack or fail if edge distance, pilot-hole, fastening, or load requirements are ignored.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is using a fish tape through a pathway and meets unexpected resistance. What is the BEST action?',
  '[{"key":"A","text":"Stop and investigate the pathway or obstruction rather than applying uncontrolled force"},{"key":"B","text":"Pull as hard as possible"},{"key":"C","text":"Bend the fish tape sharply"},{"key":"D","text":"Attach more cable and continue"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected resistance should be investigated to avoid damaging tools, pathways, cabling, or concealed building systems.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician must install several devices at identical heights across a finished room. What is the BEST method?',
  '[{"key":"A","text":"Establish and verify a consistent reference using appropriate measuring or laser tools before marking and mounting"},{"key":"B","text":"Estimate each height visually"},{"key":"C","text":"Measure only the first device"},{"key":"D","text":"Use furniture height as the only reference"}]'::jsonb,
  '["A"]'::jsonb,
  'A consistent verified reference helps produce accurate and repeatable device placement.'
),
(
  14,
  'multiple_choice',
  'application',
  'A fastener spins without tightening in the mounting substrate. What should the technician do?',
  '[{"key":"A","text":"Stop and evaluate the anchor, hole, substrate, and load requirement before using an approved corrective method"},{"key":"B","text":"Continue spinning it until it holds"},{"key":"C","text":"Add adhesive without checking requirements"},{"key":"D","text":"Leave it loose if the device appears stable"}]'::jsonb,
  '["A"]'::jsonb,
  'A fastener that does not properly engage indicates a mounting problem that should be corrected rather than hidden.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is preparing to mount a heavy device but discovers the specified wall anchor is intended for a different wall construction. What is the BEST action?',
  '[{"key":"A","text":"Stop and verify the actual substrate and approved mounting hardware before proceeding"},{"key":"B","text":"Use the anchor because it was already delivered"},{"key":"C","text":"Use more anchors of the wrong type"},{"key":"D","text":"Install the device and monitor it later"}]'::jsonb,
  '["A"]'::jsonb,
  'Mounting hardware must be compatible with the actual substrate and load requirements.'
),
(
  16,
  'scenario',
  'scenario',
  'While drilling for a device, the technician encounters an unexpected metal obstruction inside the wall. What is the BEST response?',
  '[{"key":"A","text":"Stop and identify the obstruction and potential hazard before changing tools or continuing"},{"key":"B","text":"Switch immediately to a stronger bit"},{"key":"C","text":"Apply more pressure"},{"key":"D","text":"Move the hole slightly without checking"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected concealed material could be structural, electrical, plumbing, or another building component and should be identified first.'
),
(
  17,
  'scenario',
  'scenario',
  'A newly installed wall-mounted device is slightly crooked after all fasteners are tightened. What is the BEST response?',
  '[{"key":"A","text":"Correct the alignment using the approved mounting adjustment or reinstall as needed rather than accepting poor workmanship"},{"key":"B","text":"Leave it because the device operates"},{"key":"C","text":"Hide the edge with sealant"},{"key":"D","text":"Tell the client the wall is crooked without checking"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional operation does not replace accurate and professional physical installation.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician is asked to make a mounting modification that is not shown in the documentation and may affect a finished surface. What is the BEST action?',
  '[{"key":"A","text":"Verify the required change through the approved project process before modifying the finished surface"},{"key":"B","text":"Make the change immediately"},{"key":"C","text":"Choose whichever modification is easiest"},{"key":"D","text":"Proceed without documenting it"}]'::jsonb,
  '["A"]'::jsonb,
  'Unplanned permanent modifications should be verified before work proceeds.'
),
(
  19,
  'scenario',
  'scenario',
  'A team repeatedly damages fasteners because technicians are using impact drivers at maximum setting for delicate hardware. What is the BEST response?',
  '[{"key":"A","text":"Use the correct fastening method, tool setting, or torque-controlled tool and reinforce the standard with the team"},{"key":"B","text":"Order stronger-looking fasteners"},{"key":"C","text":"Continue because damaged fasteners can be replaced"},{"key":"D","text":"Use even larger impact drivers"}]'::jsonb,
  '["A"]'::jsonb,
  'Tool settings and fastening methods should match the hardware and manufacturer requirements to avoid repeat damage.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is working from a ladder and realizes the task requires both hands extended beyond a stable working position. What is the BEST action?',
  '[{"key":"A","text":"Reposition or select appropriate access equipment so the task can be performed from a stable working position"},{"key":"B","text":"Lean farther to avoid moving the ladder"},{"key":"C","text":"Ask someone to hold the ladder while overreaching"},{"key":"D","text":"Finish quickly before balance becomes a problem"}]'::jsonb,
  '["A"]'::jsonb,
  'Access equipment should allow the work to be performed from a stable position without unsafe overreach.'
);

create temporary table _seed_ci_tools_installation_methods_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_tools_installation_methods_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should a lead technician standardize tool and installation methods across a field team?',
  '[{"key":"A","text":"To improve consistency, safety, quality, efficiency, and repeatability across technicians"},{"key":"B","text":"To prevent technicians from learning new skills"},{"key":"C","text":"To make every project use identical hardware"},{"key":"D","text":"To eliminate field judgment"}]'::jsonb,
  '["A"]'::jsonb,
  'Standardized methods create a repeatable baseline for field execution while still allowing appropriate technical judgment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of evaluating substrate conditions before approving a mounting method?',
  '[{"key":"A","text":"To verify that the selected hardware and installation method can safely and reliably support the intended load"},{"key":"B","text":"To determine cable bandwidth"},{"key":"C","text":"To avoid reviewing manufacturer requirements"},{"key":"D","text":"To eliminate measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Mounting performance depends on the actual substrate, load, fasteners, and approved installation method.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should field leaders track recurring tool-related rework?',
  '[{"key":"A","text":"Patterns can reveal issues with training, tool condition, tool selection, process, or workmanship standards"},{"key":"B","text":"Rework is always random"},{"key":"C","text":"Tool-related defects do not affect quality"},{"key":"D","text":"Only purchasing needs that information"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring rework can identify a systemic cause that should be corrected rather than repeatedly repaired.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should a quality installation method accomplish beyond simply making equipment functional?',
  '[{"key":"A","text":"It should also protect property, support serviceability, meet mounting and workmanship requirements, and produce repeatable results"},{"key":"B","text":"Function is the only requirement"},{"key":"C","text":"It should minimize documentation"},{"key":"D","text":"It should use the fewest tools possible"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional installation includes physical quality, serviceability, protection, and repeatable execution in addition to functional performance.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician repeatedly cracks finished material when mounting devices. What should the lead technician evaluate?',
  '[{"key":"A","text":"Tool selection, pilot-hole method, fastener type, torque, edge clearance, substrate characteristics, and technician technique"},{"key":"B","text":"Only the device model"},{"key":"C","text":"Only the project schedule"},{"key":"D","text":"Only the cable type"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated material damage should be addressed by reviewing the complete installation method and the technician execution.'
),
(
  6,
  'multiple_choice',
  'application',
  'A field team is using several different mounting methods for the same device and substrate. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Determine the approved method, document or reinforce the standard, and verify that the team follows it consistently"},{"key":"B","text":"Allow every technician to use a different approach permanently"},{"key":"C","text":"Choose the fastest method without review"},{"key":"D","text":"Stop inspecting mounting quality"}]'::jsonb,
  '["A"]'::jsonb,
  'Where conditions are equivalent, an approved standardized method improves consistency and quality.'
),
(
  7,
  'multiple_choice',
  'application',
  'A power tool produces inconsistent results across technicians. What should be evaluated first?',
  '[{"key":"A","text":"Tool condition, accessory condition, setup, settings, technique, and task suitability"},{"key":"B","text":"Only who used it last"},{"key":"C","text":"Only the tool brand"},{"key":"D","text":"Only the project manager"}]'::jsonb,
  '["A"]'::jsonb,
  'Inconsistent results can come from tool condition, configuration, accessories, or operator technique and should be evaluated systematically.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician proposes changing a mounting location in the field because access is difficult. What should the lead technician do?',
  '[{"key":"A","text":"Evaluate the technical and scope impact, verify the approved location requirements, and resolve the change through the project process before proceeding"},{"key":"B","text":"Approve the change automatically"},{"key":"C","text":"Move the device to the easiest location"},{"key":"D","text":"Make the change without documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Field convenience should not override documented location, system, aesthetic, or project requirements without controlled review.'
),
(
  9,
  'multiple_choice',
  'application',
  'A crew is installing multiple devices in a finished space and alignment varies from room to room. What is the BEST correction?',
  '[{"key":"A","text":"Establish a repeatable measuring and alignment process using verified reference points and appropriate tools"},{"key":"B","text":"Let each technician estimate visually"},{"key":"C","text":"Correct only the most visible devices"},{"key":"D","text":"Ignore alignment if devices operate"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeatable reference and measurement process improves consistency across multiple installers and locations.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician encounters an unfamiliar mounting surface. What should the lead technician expect before installation begins?',
  '[{"key":"A","text":"Identification of the substrate, review of load and mounting requirements, selection of approved hardware and tools, and verification of concealed hazards"},{"key":"B","text":"Immediate drilling with a general-purpose bit"},{"key":"C","text":"Use of the same anchors used on drywall"},{"key":"D","text":"Trial-and-error fastening"}]'::jsonb,
  '["A"]'::jsonb,
  'Unknown substrates require verification before selecting hardware, tools, and installation methods.'
),
(
  11,
  'multiple_choice',
  'application',
  'A team uses ladders frequently for device installation. What should the lead technician reinforce beyond simply having ladders available?',
  '[{"key":"A","text":"Proper ladder selection, inspection, placement, stable working position, and task-appropriate use"},{"key":"B","text":"Only ladder height"},{"key":"C","text":"Only ladder storage location"},{"key":"D","text":"Only how quickly the ladder can be moved"}]'::jsonb,
  '["A"]'::jsonb,
  'Access equipment must be selected and used appropriately for the actual task and environment.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician installs several displays using anchors that appear secure, but the lead technician later discovers the anchors are not approved for the wall construction. What is the BEST response?',
  '[{"key":"A","text":"Stop further use of that method, evaluate the installed devices, correct affected mounting as required, and reinforce the approved mounting standard"},{"key":"B","text":"Leave them because they have not fallen"},{"key":"C","text":"Add more of the same anchors"},{"key":"D","text":"Wait for a client complaint"}]'::jsonb,
  '["A"]'::jsonb,
  'An unapproved mounting method creates a reliability and safety concern that should be corrected systematically.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician damages finished cabinetry while cutting an opening because the wrong blade was used. Similar damage happened on the previous project. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Address the immediate repair, review tool and blade selection, cutting preparation, technique, and training, then verify the corrected process on future work"},{"key":"B","text":"Treat each incident as unrelated"},{"key":"C","text":"Tell the technician to cut faster"},{"key":"D","text":"Stop documenting the damage"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated damage indicates a process or competency gap that should be corrected at the root cause.'
),
(
  14,
  'scenario',
  'scenario',
  'A crew is behind schedule and proposes skipping layout verification before drilling dozens of device locations. What should the lead technician do?',
  '[{"key":"A","text":"Maintain the verification process because the cost of widespread placement errors and rework can exceed the time saved"},{"key":"B","text":"Approve skipping verification"},{"key":"C","text":"Measure only the first location"},{"key":"D","text":"Let each technician choose locations visually"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule pressure should not remove a control that prevents repeated permanent installation errors.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician reports that a drill bit keeps walking off the marked location on a finished surface. What is the BEST response?',
  '[{"key":"A","text":"Stop and review the material, bit type, starting method, tool control, surface protection, and any approved pilot or template method before continuing"},{"key":"B","text":"Increase drill speed immediately"},{"key":"C","text":"Push harder"},{"key":"D","text":"Make a larger hole"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor hole control should be corrected through the appropriate tool, accessory, setup, and technique rather than additional force.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician is using an impact driver for every fastening task and repeatedly strips small equipment screws. What is the BEST corrective action?',
  '[{"key":"A","text":"Match the fastening tool, clutch or torque setting, bit, and method to the hardware and train the technician on the required process"},{"key":"B","text":"Order more screws and continue"},{"key":"C","text":"Use a larger impact driver"},{"key":"D","text":"Ignore stripped screws if the equipment operates"}]'::jsonb,
  '["A"]'::jsonb,
  'Fastening tools and settings should match the hardware and required torque to prevent recurring damage.'
),
(
  17,
  'scenario',
  'scenario',
  'A device mounted by a junior technician is level but begins pulling away from the wall under load. What is the BEST diagnostic response?',
  '[{"key":"A","text":"Support the equipment safely, inspect the substrate, anchors, fastener engagement, load, bracket installation, and approved mounting requirements before correcting the installation"},{"key":"B","text":"Tighten the visible screws without inspection"},{"key":"C","text":"Add adhesive around the bracket"},{"key":"D","text":"Leave it because it is still level"}]'::jsonb,
  '["A"]'::jsonb,
  'Movement under load indicates a mounting integrity issue that requires evaluation of the complete load path.'
),
(
  18,
  'scenario',
  'scenario',
  'A crew repeatedly leaves scratches and debris in finished client spaces despite completing installations correctly. What is the BEST lead-technician response?',
  '[{"key":"A","text":"Reinforce surface protection, tool placement, housekeeping, cleanup, and final area inspection as part of the workmanship standard"},{"key":"B","text":"Accept it because the systems work"},{"key":"C","text":"Ask the client to clean afterward"},{"key":"D","text":"Remove finish-quality checks from closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Property protection and cleanliness are part of professional field execution and should be standardized and inspected.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician repeatedly needs another team member to correct mounting layouts after drilling has begun. What is the BEST development response?',
  '[{"key":"A","text":"Coach the technician on drawing review, measuring, reference points, layout verification, and pre-drill checks, then observe and verify independent execution"},{"key":"B","text":"Continue correcting every layout without coaching"},{"key":"C","text":"Stop allowing the technician to measure anything"},{"key":"D","text":"Remove layout requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring layout errors should be addressed through targeted coaching and verified competent practice.'
),
(
  20,
  'scenario',
  'scenario',
  'A project experiences recurring installation rework involving misaligned devices, damaged finishes, stripped hardware, and inconsistent mounting. What is the BEST improvement approach?',
  '[{"key":"A","text":"Review the rework data, identify recurring causes, standardize installation methods, verify tooling and hardware, train the team, and audit future execution"},{"key":"B","text":"Treat every defect as unrelated"},{"key":"C","text":"Stop recording rework"},{"key":"D","text":"Allow each technician to develop separate standards"}]'::jsonb,
  '["A"]'::jsonb,
  'A pattern across multiple installation defects calls for a structured process-improvement response rather than repeated isolated repair.'
);

create temporary table _seed_ci_tools_installation_methods_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_tools_installation_methods_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the strongest basis for defining installation-method standards across a field organization?',
  '[{"key":"A","text":"Documented methods aligned with manufacturer requirements, project standards, applicable codes, safety expectations, and proven field practices"},{"key":"B","text":"Each technician choosing a preferred method"},{"key":"C","text":"Whatever method is fastest"},{"key":"D","text":"Only the appearance of the finished installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Strong installation standards align technical, safety, project, and manufacturer requirements into a repeatable field process.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a technical leader separate isolated workmanship mistakes from recurring process failures?',
  '[{"key":"A","text":"Recurring patterns may indicate systemic problems with training, tools, hardware, planning, supervision, or standards"},{"key":"B","text":"All installation defects have the same cause"},{"key":"C","text":"Process failures do not affect quality"},{"key":"D","text":"The distinction matters only for purchasing"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring defects should trigger root-cause analysis at the process level rather than repeated isolated repair.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should an installation quality-control system verify before closeout?',
  '[{"key":"A","text":"That mounting, alignment, hardware, tool use, finish protection, workmanship, documentation, and serviceability meet the required standard"},{"key":"B","text":"Only that equipment powers on"},{"key":"C","text":"Only that the room looks clean"},{"key":"D","text":"Only that all delivered hardware was used"}]'::jsonb,
  '["A"]'::jsonb,
  'Closeout should confirm the physical quality and serviceability of the installation, not merely system operation.'
),
(
  4,
  'multiple_choice',
  'application',
  'A company sees repeated damage to finished surfaces across multiple crews. What should the technical leader investigate?',
  '[{"key":"A","text":"Surface-protection standards, tool staging, cutting methods, layout verification, technician training, and supervision"},{"key":"B","text":"Only the project schedule"},{"key":"C","text":"Only the equipment brand"},{"key":"D","text":"Only the client expectations"}]'::jsonb,
  '["A"]'::jsonb,
  'A cross-crew damage pattern suggests a process or standards issue that should be investigated systematically.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project includes unusual substrates and heavy equipment. What should the technical lead establish before field installation begins?',
  '[{"key":"A","text":"Approved mounting methods, hardware, load requirements, tool needs, concealed-hazard considerations, and verification steps"},{"key":"B","text":"Only which crew arrives first"},{"key":"C","text":"Only the equipment model numbers"},{"key":"D","text":"Only the room sequence"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex mounting conditions should be resolved in planning rather than improvised repeatedly in the field.'
),
(
  6,
  'multiple_choice',
  'application',
  'A team repeatedly strips hardware even though the correct fasteners are being used. What should be evaluated?',
  '[{"key":"A","text":"Tool selection, bit engagement, clutch or torque settings, fastening sequence, technician technique, and hardware requirements"},{"key":"B","text":"Only the fastener supplier"},{"key":"C","text":"Only the device weight"},{"key":"D","text":"Only the room temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated fastening damage can originate from tools, settings, technique, or process rather than the fastener itself.'
),
(
  7,
  'multiple_choice',
  'application',
  'A late design change requires modifying finished millwork. What should the technical leader do before authorizing the work?',
  '[{"key":"A","text":"Verify scope and approval, assess the technical and finish impact, define the method and tools, and document the change"},{"key":"B","text":"Authorize the quickest field modification"},{"key":"C","text":"Let the installer decide independently"},{"key":"D","text":"Make the change without documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Permanent modifications to finished work should be controlled, reviewed, and documented.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician consistently produces strong technical results but weak finish quality. What is the BEST leadership response?',
  '[{"key":"A","text":"Coach finish-protection, layout, tool control, cleanliness, and workmanship expectations, then verify sustained improvement"},{"key":"B","text":"Ignore the issue because the systems work"},{"key":"C","text":"Assign only hidden work permanently"},{"key":"D","text":"Stop inspecting finish quality"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical competence includes professional physical execution and protection of the client environment.'
),
(
  9,
  'multiple_choice',
  'application',
  'A company wants to reduce installation rework across projects. Which data is most useful?',
  '[{"key":"A","text":"Recurring defect types, affected tasks, tools and methods used, technician patterns, material conditions, and corrective actions"},{"key":"B","text":"Only total project revenue"},{"key":"C","text":"Only technician headcount"},{"key":"D","text":"Only equipment model numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful rework data should help identify patterns and root causes that can be addressed through process improvement.'
),
(
  10,
  'multiple_choice',
  'application',
  'When deciding whether to standardize a new field tool across the company, what should the technical leader consider?',
  '[{"key":"A","text":"Safety, task suitability, quality, repeatability, training needs, maintenance, compatibility, efficiency, and total field impact"},{"key":"B","text":"Only purchase price"},{"key":"C","text":"Only technician preference"},{"key":"D","text":"Only the tool brand"}]'::jsonb,
  '["A"]'::jsonb,
  'Tool standardization should consider quality, safety, usability, lifecycle, and process impact rather than cost alone.'
),
(
  11,
  'scenario',
  'scenario',
  'Multiple crews are producing misaligned wall devices even though drawings are accurate. Each crew uses a different layout method. What is the BEST leadership action?',
  '[{"key":"A","text":"Establish a standardized layout and verification method, train the crews, and audit execution until results are consistent"},{"key":"B","text":"Correct only the most visible devices"},{"key":"C","text":"Let each crew continue using its own method"},{"key":"D","text":"Stop checking alignment"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated cross-crew issue tied to inconsistent methods should be corrected through standardization and verification.'
),
(
  12,
  'scenario',
  'scenario',
  'A heavy device is mounted successfully, but the technical lead later learns that the installation method was never verified for the substrate. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the actual substrate, load path, hardware, and mounting method, correct the installation if required, and update the field standard"},{"key":"B","text":"Leave it because it has not failed"},{"key":"C","text":"Add random fasteners"},{"key":"D","text":"Wait for the client to report movement"}]'::jsonb,
  '["A"]'::jsonb,
  'A mounting method should be technically validated, not assumed acceptable simply because failure has not yet occurred.'
),
(
  13,
  'scenario',
  'scenario',
  'A project manager asks the field team to skip protective floor covering to save setup time. What should the technical lead do?',
  '[{"key":"A","text":"Maintain the required protection standard and communicate the schedule or workflow impact rather than accepting unnecessary property risk"},{"key":"B","text":"Skip protection on low-traffic areas"},{"key":"C","text":"Proceed if the client is not onsite"},{"key":"D","text":"Protect only after damage occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'Property protection is part of the installation standard and should not be removed merely for short-term schedule savings.'
),
(
  14,
  'scenario',
  'scenario',
  'A company has several expensive power tools that are producing inconsistent results and frequent rework. What is the BEST technical-lead approach?',
  '[{"key":"A","text":"Audit tool condition, maintenance, accessories, settings, calibration where applicable, task suitability, and technician training before replacing tools or blaming installers"},{"key":"B","text":"Replace every tool immediately"},{"key":"C","text":"Stop tracking rework"},{"key":"D","text":"Require technicians to use more force"}]'::jsonb,
  '["A"]'::jsonb,
  'Tool-related quality problems should be diagnosed through condition, setup, use, maintenance, and training.'
),
(
  15,
  'scenario',
  'scenario',
  'A junior technician repeatedly damages hardware during mounting even after being told verbally to be more careful. What is the BEST development response?',
  '[{"key":"A","text":"Demonstrate the correct method, observe the technician performing it, identify the specific skill gap, coach it, and verify repeatable success"},{"key":"B","text":"Repeat the same verbal instruction"},{"key":"C","text":"Stop inspecting the work"},{"key":"D","text":"Accept the damage as part of training"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective technical coaching requires demonstration, observed practice, feedback, and verification.'
),
(
  16,
  'scenario',
  'scenario',
  'A project has repeated device-fit problems because openings are being cut before final equipment dimensions are verified. What is the BEST improvement?',
  '[{"key":"A","text":"Add a required pre-cut verification step for device, dimensions, documentation, and field condition before permanent openings are made"},{"key":"B","text":"Make every opening oversized"},{"key":"C","text":"Stop measuring openings"},{"key":"D","text":"Let each technician estimate"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring defect should be addressed by adding or strengthening a process control that prevents the error.'
),
(
  17,
  'scenario',
  'scenario',
  'A field team reports that one installation method is fast but produces higher rework, while another is slightly slower but consistently passes inspection. What is the BEST decision?',
  '[{"key":"A","text":"Evaluate total labor, quality, rework, safety, and repeatability and standardize the method that produces the stronger overall outcome"},{"key":"B","text":"Always choose the fastest first-pass method"},{"key":"C","text":"Ignore rework cost"},{"key":"D","text":"Allow unlimited variation"}]'::jsonb,
  '["A"]'::jsonb,
  'Method selection should consider total production performance, not just initial speed.'
),
(
  18,
  'scenario',
  'scenario',
  'Several crews improvise different methods for mounting the same product because the manufacturer instructions are unclear. What is the BEST technical-lead response?',
  '[{"key":"A","text":"Resolve the requirement with the manufacturer or approved technical source, define the company method, document it, and communicate it to the field"},{"key":"B","text":"Let each crew continue independently"},{"key":"C","text":"Choose whichever method looks strongest"},{"key":"D","text":"Stop documenting mounting methods"}]'::jsonb,
  '["A"]'::jsonb,
  'Ambiguous technical guidance should be resolved centrally so field teams can execute a consistent approved method.'
),
(
  19,
  'scenario',
  'scenario',
  'Closeout reviews show that systems function correctly but mounting quality and finish protection vary significantly between technicians. What is the BEST response?',
  '[{"key":"A","text":"Expand quality-control expectations to include physical workmanship, alignment, mounting integrity, protection, cleanup, and serviceability, then coach and audit to the standard"},{"key":"B","text":"Remove physical-quality checks"},{"key":"C","text":"Focus only on system operation"},{"key":"D","text":"Accept variation as unavoidable"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete installation standard includes both functional and physical workmanship criteria.'
),
(
  20,
  'scenario',
  'scenario',
  'Post-project analysis shows recurring rework from wrong tools, poor mounting methods, damaged finishes, and inconsistent technician practices. What is the BEST improvement plan?',
  '[{"key":"A","text":"Use the defect data to identify root causes, standardize approved tools and methods, improve training, verify tool condition and hardware, and audit future work against measurable expectations"},{"key":"B","text":"Treat each defect as unrelated"},{"key":"C","text":"Stop measuring rework"},{"key":"D","text":"Allow every technician to create an individual standard"}]'::jsonb,
  '["A"]'::jsonb,
  'Systemic field-quality improvement requires using evidence to improve standards, tools, training, and verification.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '538fe0f0-65dc-4b1b-ae3f-ee4711abf791';
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
      and c.name = 'Tools & Installation Methods'
      and c.is_current = true
  ) then
    raise exception 'Current Tools & Installation Methods Master Competency not found';
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
    raise exception 'Current Logistics Manager L1 Tools & Installation Methods requirement not found';
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
    raise exception 'Current Technician I — Entry Level L2 Tools & Installation Methods requirement not found';
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
    raise exception 'Current Technician II — Experienced L3 Tools & Installation Methods requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Tools & Installation Methods requirement not found';
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
  v_assessment_name := 'Tools & Installation Methods — Level 1 Competency Assessment';

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
    select * from _seed_ci_tools_installation_methods_l1_questions
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
        'Tools & Installation Methods',
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
      'IntegrateU Tools & Installation Methods L1 production assessment v1.0.',
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
        'Tools & Installation Methods',
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
        'IntegrateU Tools & Installation Methods L1 production assessment v1.0.',
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
  v_assessment_name := 'Tools & Installation Methods — Level 2 Competency Assessment';

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
    select * from _seed_ci_tools_installation_methods_l2_questions
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
        'Tools & Installation Methods',
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
      'IntegrateU Tools & Installation Methods L2 production assessment v1.0.',
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
        'Tools & Installation Methods',
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
        'IntegrateU Tools & Installation Methods L2 production assessment v1.0.',
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
  v_assessment_name := 'Tools & Installation Methods — Level 3 Competency Assessment';

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
    select * from _seed_ci_tools_installation_methods_l3_questions
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
        'Tools & Installation Methods',
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
      'IntegrateU Tools & Installation Methods L3 production assessment v1.0.',
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
        'Tools & Installation Methods',
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
        'IntegrateU Tools & Installation Methods L3 production assessment v1.0.',
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
  v_assessment_name := 'Tools & Installation Methods — Level 4 Competency Assessment';

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
    select * from _seed_ci_tools_installation_methods_l4_questions
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
        'Tools & Installation Methods',
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
      'IntegrateU Tools & Installation Methods L4 production assessment v1.0.',
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
        'Tools & Installation Methods',
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
        'IntegrateU Tools & Installation Methods L4 production assessment v1.0.',
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
