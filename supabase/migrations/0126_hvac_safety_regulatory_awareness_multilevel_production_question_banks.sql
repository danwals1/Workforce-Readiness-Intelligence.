-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0126_hvac_safety_regulatory_awareness_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Safety & Regulatory Awareness
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 2
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

create temporary table _seed_hvac_safety_regulatory_awareness_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_safety_regulatory_awareness_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the main purpose of a pre-task safety review before beginning HVAC work?',
  '[{"key":"A","text":"To estimate how long the job will take"},{"key":"B","text":"To identify hazards, required controls, and changes in site conditions before work starts"},{"key":"C","text":"To determine which technician should complete the invoice"},{"key":"D","text":"To avoid reading equipment documentation"}]'::jsonb,
  '["B"]'::jsonb,
  'A pre-task review helps workers identify hazards and establish appropriate controls before exposure occurs.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why must an HVAC worker consider stored energy even after equipment has been switched off?',
  '[{"key":"A","text":"Stored electrical, mechanical, pressure, or thermal energy may still cause injury"},{"key":"B","text":"Stored energy only affects equipment efficiency"},{"key":"C","text":"Stored energy disappears immediately whenever a disconnect is opened"},{"key":"D","text":"Stored energy matters only on refrigeration equipment over ten years old"}]'::jsonb,
  '["A"]'::jsonb,
  'Shutting equipment off does not necessarily eliminate stored electrical, mechanical, pressure, or thermal energy.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes the purpose of personal protective equipment during HVAC work?',
  '[{"key":"A","text":"PPE eliminates the underlying hazard"},{"key":"B","text":"PPE reduces worker exposure when selected and used for the hazards present"},{"key":"C","text":"PPE is needed only when a customer requests it"},{"key":"D","text":"One type of PPE is suitable for every HVAC task"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE is selected to reduce exposure to identified hazards; it does not by itself remove the hazard.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Under EPA refrigerant-management requirements, which practice is generally prohibited during HVAC service?',
  '[{"key":"A","text":"Using recovery equipment as required"},{"key":"B","text":"Intentionally venting regulated refrigerant during service"},{"key":"C","text":"Recording refrigerant service information"},{"key":"D","text":"Checking the equipment nameplate before work"}]'::jsonb,
  '["B"]'::jsonb,
  'EPA refrigerant-management rules generally prohibit intentional venting of regulated refrigerants and their covered substitutes during service, repair, maintenance, or disposal.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the safest response when an HVAC technician encounters a hazard that is outside the worker''s training or authorization?',
  '[{"key":"A","text":"Continue carefully so the job stays on schedule"},{"key":"B","text":"Stop the affected work and obtain qualified direction or assistance"},{"key":"C","text":"Ask the customer to accept responsibility for the hazard"},{"key":"D","text":"Ignore the hazard if no injury has occurred yet"}]'::jsonb,
  '["B"]'::jsonb,
  'Workers should stop or avoid work they are not trained or authorized to perform and obtain appropriate qualified support.'
),
(
  6,
  'multiple_choice',
  'application',
  'An installer arrives at a rooftop unit and finds the access path wet and slippery after rain. What should the installer do FIRST?',
  '[{"key":"A","text":"Carry the equipment up quickly before conditions worsen"},{"key":"B","text":"Assess the access hazard and establish a safe method before proceeding"},{"key":"C","text":"Use the same access method because the roof was safe yesterday"},{"key":"D","text":"Ask another worker to stand below the ladder"}]'::jsonb,
  '["B"]'::jsonb,
  'Changing site conditions must be evaluated before work proceeds, and safe access must be established before exposing workers to the hazard.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician needs to service equipment that may start automatically from a thermostat or control system. What is the BEST approach before placing hands inside the equipment?',
  '[{"key":"A","text":"Turn the thermostat to OFF and begin work"},{"key":"B","text":"Apply the required hazardous-energy control procedure and verify the equipment is in a safe state"},{"key":"C","text":"Ask the customer not to touch the thermostat"},{"key":"D","text":"Work quickly between operating cycles"}]'::jsonb,
  '["B"]'::jsonb,
  'A control signal such as a thermostat is not an energy-isolating device; hazardous energy must be controlled and the safe condition verified.'
),
(
  8,
  'multiple_choice',
  'application',
  'A helper notices that the eye protection provided does not fit securely and leaves a large gap around the eyes during cutting work. What should happen?',
  '[{"key":"A","text":"Use it anyway because any eye protection is acceptable"},{"key":"B","text":"Obtain properly fitting protection suitable for the hazard before performing the task"},{"key":"C","text":"Remove the eye protection whenever it fogs"},{"key":"D","text":"Wear a baseball cap instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Protective equipment must be appropriate for the hazard and properly fit the worker so that it can provide its intended protection.'
),
(
  9,
  'multiple_choice',
  'application',
  'Before using a portable ladder to access HVAC equipment, what should the worker do?',
  '[{"key":"A","text":"Inspect it for damage and confirm it is suitable and properly positioned for the task"},{"key":"B","text":"Assume it is safe if another trade used it earlier"},{"key":"C","text":"Place it on loose material to improve height"},{"key":"D","text":"Use the top cap as a work platform regardless of ladder design"}]'::jsonb,
  '["A"]'::jsonb,
  'Safe ladder use includes recognizing hazards, using suitable equipment, and properly placing and handling the ladder.'
),
(
  10,
  'multiple_choice',
  'application',
  'An HVAC worker finds an extension cord with damaged insulation near the plug. What is the BEST action?',
  '[{"key":"A","text":"Wrap it with any available tape and keep using it"},{"key":"B","text":"Remove the damaged cord from service and follow the employer''s procedure for repair or replacement"},{"key":"C","text":"Use it only on low-load tools"},{"key":"D","text":"Position the damaged section where no one can see it"}]'::jsonb,
  '["B"]'::jsonb,
  'Damaged electrical equipment should not remain in service where it could expose workers to shock, fire, or other electrical hazards.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician is about to connect gauges and perform refrigerant service on stationary air-conditioning equipment. What regulatory issue should be confirmed before the covered work proceeds?',
  '[{"key":"A","text":"Whether the technician has the applicable EPA Section 608 certification or is working under an allowed supervised-apprentice condition"},{"key":"B","text":"Whether the customer has a building permit for the thermostat"},{"key":"C","text":"Whether the technician owns the recovery cylinder personally"},{"key":"D","text":"Whether the equipment was installed by the same company"}]'::jsonb,
  '["A"]'::jsonb,
  'EPA Section 608 requires certification for technicians performing covered refrigerant-service activities, subject to the supervised-apprentice provision and other applicable rules.'
),
(
  12,
  'multiple_choice',
  'application',
  'While preparing to work on an air handler, a technician identifies electrical energy and a spring-loaded mechanical component. What should the energy-control process address?',
  '[{"key":"A","text":"Only the electrical source"},{"key":"B","text":"Only the mechanical source"},{"key":"C","text":"All hazardous energy sources that could injure the worker"},{"key":"D","text":"Whichever source is easiest to isolate"}]'::jsonb,
  '["C"]'::jsonb,
  'Hazardous-energy control must account for all energy sources capable of causing injury, including stored or residual energy.'
),
(
  13,
  'multiple_choice',
  'application',
  'A job requires brazing near combustible building materials. What is the BEST safety approach?',
  '[{"key":"A","text":"Begin brazing and watch for smoke"},{"key":"B","text":"Evaluate the fire hazard and establish required fire-prevention controls before starting hot work"},{"key":"C","text":"Wet the torch tip before lighting it"},{"key":"D","text":"Rely on the building sprinkler system as the only control"}]'::jsonb,
  '["B"]'::jsonb,
  'Hot work introduces ignition hazards that must be evaluated and controlled before the work begins.'
),
(
  14,
  'multiple_choice',
  'application',
  'A worker discovers that an equipment panel has been removed and live electrical parts may be exposed in an area used by other workers. What should be done?',
  '[{"key":"A","text":"Leave the area unchanged until the service call is complete"},{"key":"B","text":"Control access to the hazard and follow the required electrical-safety procedure before continuing work"},{"key":"C","text":"Place a tool bag in front of the equipment"},{"key":"D","text":"Tell nearby workers to be careful but take no other action"}]'::jsonb,
  '["B"]'::jsonb,
  'Exposed electrical hazards require appropriate controls, including preventing unintended access and following applicable safe-work procedures.'
),
(
  15,
  'scenario',
  'scenario',
  'An HVAC installer is told to place a condensing unit on a roof. On arrival, the planned lifting path passes beneath an active work area where another crew is moving materials. What is the BEST response?',
  '[{"key":"A","text":"Proceed because the lift was already scheduled"},{"key":"B","text":"Stop and coordinate a controlled lifting path and work area before moving the unit"},{"key":"C","text":"Ask the rooftop crew to shout if something falls"},{"key":"D","text":"Move the unit faster to reduce exposure time"}]'::jsonb,
  '["B"]'::jsonb,
  'The changed work environment creates struck-by and dropped-object hazards that must be controlled through coordination and a safe work plan.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician isolates power to a rooftop unit but hears the blower wheel continuing to rotate. The access panel must be removed to reach the work area. What should the technician do?',
  '[{"key":"A","text":"Remove the panel because electrical power is already off"},{"key":"B","text":"Wait for and control hazardous mechanical energy, verify a safe state, and then proceed under the required procedure"},{"key":"C","text":"Stop the wheel by hand while wearing gloves"},{"key":"D","text":"Insert a screwdriver through the guard to stop the wheel"}]'::jsonb,
  '["B"]'::jsonb,
  'Energy isolation must address hazardous stored or moving mechanical energy as well as electrical energy before exposure to moving parts.'
),
(
  17,
  'scenario',
  'scenario',
  'During a service call, a helper sees a technician preparing to release recovered refrigerant to the atmosphere because the recovery cylinder is nearly full. What is the BEST action?',
  '[{"key":"A","text":"Allow it because only a small amount remains"},{"key":"B","text":"Stop the release and use compliant refrigerant recovery and handling practices"},{"key":"C","text":"Release it only if the customer approves"},{"key":"D","text":"Release it outdoors instead of indoors"}]'::jsonb,
  '["B"]'::jsonb,
  'Intentional venting is generally prohibited during covered HVAC service; refrigerant must be managed using applicable recovery and handling requirements.'
),
(
  18,
  'scenario',
  'scenario',
  'An installer is assigned to work from a portable ladder beside a doorway that people are actively using. What is the BEST response?',
  '[{"key":"A","text":"Use the ladder normally because pedestrians can walk around it"},{"key":"B","text":"Control the doorway or relocate and secure the work setup so the ladder cannot be struck or displaced"},{"key":"C","text":"Ask the installer to work from the highest possible rung"},{"key":"D","text":"Place a cardboard sign on the floor and take no other action"}]'::jsonb,
  '["B"]'::jsonb,
  'The work setup must account for traffic and conditions that could cause a ladder to be struck, shifted, or otherwise become unsafe.'
),
(
  19,
  'scenario',
  'scenario',
  'A crew begins work in a mechanical room and notices a strong unfamiliar chemical odor that was not present during the original job walk. No one knows the source. What should the crew do?',
  '[{"key":"A","text":"Continue working until someone develops symptoms"},{"key":"B","text":"Stop affected work, leave or control exposure as appropriate, and have the new hazard evaluated before continuing"},{"key":"C","text":"Turn on the HVAC equipment to dilute the odor without investigating"},{"key":"D","text":"Mask the odor with an air freshener"}]'::jsonb,
  '["B"]'::jsonb,
  'An unexpected chemical condition is a changed hazard that should be evaluated and controlled before workers continue exposure.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician has completed service under an energy-control procedure. Another worker is still inside the equipment area completing a separate task. What is the BEST action before restoring energy?',
  '[{"key":"A","text":"Restore energy because the technician''s own work is complete"},{"key":"B","text":"Follow the established restoration procedure and confirm affected personnel are clear and protected before reenergizing"},{"key":"C","text":"Warn the other worker while switching the equipment on"},{"key":"D","text":"Ask the customer to restore power"}]'::jsonb,
  '["B"]'::jsonb,
  'Energy should be restored only through the established procedure after personnel are accounted for and the equipment can be safely returned to service.'
);

create temporary table _seed_hvac_safety_regulatory_awareness_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_safety_regulatory_awareness_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes a Level 3 HVAC technician''s responsibility for job-site safety?',
  '[{"key":"A","text":"Follow instructions only when a supervisor is present"},{"key":"B","text":"Independently recognize hazards, apply required controls, verify safe conditions, and escalate when conditions exceed training or authority"},{"key":"C","text":"Rely mainly on personal experience instead of formal procedures"},{"key":"D","text":"Delegate all safety decisions to the customer"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance includes independent recognition and control of routine hazards while stopping and escalating when conditions exceed the technician''s authority or competence.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is verifying an isolated energy state important before HVAC service begins?',
  '[{"key":"A","text":"Because operating controls and disconnect positions alone may not prove all hazardous energy has been controlled"},{"key":"B","text":"Because verification is needed only when equipment is more than five years old"},{"key":"C","text":"Because verification replaces the need for isolation"},{"key":"D","text":"Because verification is primarily a documentation step"}]'::jsonb,
  '["A"]'::jsonb,
  'Verification confirms that the hazardous-energy controls actually produced the intended safe condition before exposure begins.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'When servicing equipment containing regulated refrigerant, what should a qualified HVAC technician understand?',
  '[{"key":"A","text":"Refrigerant may be intentionally vented if the service call is urgent"},{"key":"B","text":"Applicable recovery, handling, certification, and environmental requirements must be followed"},{"key":"C","text":"Refrigerant rules apply only to equipment owned by commercial customers"},{"key":"D","text":"Environmental requirements apply only during equipment disposal"}]'::jsonb,
  '["B"]'::jsonb,
  'Covered HVAC refrigerant work must follow applicable recovery, handling, certification, and environmental requirements throughout service and disposal activities.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to reassess hazards when the scope or conditions of an HVAC job change?',
  '[{"key":"A","text":"The original controls may no longer adequately address the new conditions"},{"key":"B","text":"A new hazard assessment automatically cancels the work order"},{"key":"C","text":"Changed conditions affect productivity but not safety"},{"key":"D","text":"Only supervisors may recognize changed hazards"}]'::jsonb,
  '["A"]'::jsonb,
  'Changed conditions can introduce new hazards or make planned controls inadequate, requiring reassessment before work continues.'
),
(
  5,
  'multiple_choice',
  'application',
  'A service technician arrives to diagnose a rooftop unit and discovers standing water around the electrical service area. What is the BEST first action?',
  '[{"key":"A","text":"Step over the water and begin diagnostics"},{"key":"B","text":"Stop and evaluate the electrical and access hazards before approaching or servicing the unit"},{"key":"C","text":"Place a dry towel on the water and proceed"},{"key":"D","text":"Use rubber-soled shoes as the only control"}]'::jsonb,
  '["B"]'::jsonb,
  'Standing water near electrical equipment changes the hazard profile and requires evaluation and appropriate controls before work proceeds.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician has isolated electrical power to a package unit, but the system contains pressurized refrigerant and a charged capacitor. What should happen before intrusive service?',
  '[{"key":"A","text":"Proceed because the disconnect is open"},{"key":"B","text":"Address all hazardous stored-energy sources using the required procedures before exposure"},{"key":"C","text":"Discharge the capacitor with any metal tool"},{"key":"D","text":"Ignore the refrigerant pressure unless a leak is visible"}]'::jsonb,
  '["B"]'::jsonb,
  'Safe energy control requires identifying and controlling electrical, pressure, mechanical, thermal, and other hazardous energy that could cause injury.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician must braze a line set in a finished mechanical space near combustible insulation. What should be established before hot work starts?',
  '[{"key":"A","text":"Only a faster brazing technique"},{"key":"B","text":"Appropriate fire-prevention controls, protection of combustibles, and any required fire-watch or permit measures"},{"key":"C","text":"A larger torch tip"},{"key":"D","text":"Permission from another technician only"}]'::jsonb,
  '["B"]'::jsonb,
  'Hot work should begin only after combustible hazards and required fire-prevention measures have been addressed.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician finds a rooftop access ladder with a damaged rung. The repair can be completed from the roof once access is gained. What is the BEST action?',
  '[{"key":"A","text":"Use the ladder carefully because the task is short"},{"key":"B","text":"Remove or prevent use of the unsafe access method and obtain a safe alternative before proceeding"},{"key":"C","text":"Climb past the damaged rung without carrying tools"},{"key":"D","text":"Ask another worker to hold the ladder"}]'::jsonb,
  '["B"]'::jsonb,
  'Known defective access equipment should not be used merely because the exposure is brief; a safe access method is required.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician is asked to recover refrigerant into a cylinder with an unreadable label and uncertain contents. What is the BEST response?',
  '[{"key":"A","text":"Use the cylinder if it feels empty"},{"key":"B","text":"Do not use it until the cylinder identity, suitability, and handling requirements are confirmed"},{"key":"C","text":"Mix refrigerants because they can be separated later"},{"key":"D","text":"Vent the refrigerant instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Refrigerant recovery requires suitable, identifiable equipment and proper handling; an unknown cylinder creates contamination and safety risks.'
),
(
  10,
  'multiple_choice',
  'application',
  'During troubleshooting, a technician determines that live electrical measurements are necessary. What should happen before the measurement is performed?',
  '[{"key":"A","text":"Proceed automatically because troubleshooting always permits energized work"},{"key":"B","text":"Confirm the task is justified and permitted, use the required safe-work practices, and apply appropriate protective measures"},{"key":"C","text":"Remove PPE to improve dexterity"},{"key":"D","text":"Ask an unqualified helper to hold the meter leads"}]'::jsonb,
  '["B"]'::jsonb,
  'When energized diagnostic work is necessary, the technician must use the applicable qualified-work practices and controls rather than treating live work as routine.'
),
(
  11,
  'multiple_choice',
  'application',
  'A customer asks the technician to bypass a safety interlock temporarily so the system will run until replacement parts arrive. What is the BEST response?',
  '[{"key":"A","text":"Bypass it if the customer accepts the risk"},{"key":"B","text":"Do not defeat a required safety control unless an approved procedure specifically permits the condition; follow company and manufacturer requirements"},{"key":"C","text":"Bypass it only during business hours"},{"key":"D","text":"Install a handwritten warning and leave it bypassed"}]'::jsonb,
  '["B"]'::jsonb,
  'Safety devices and interlocks should not be casually defeated; any temporary condition must follow approved procedures and applicable requirements.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician begins service on an air handler after opening the disconnect. During verification, voltage is still present because a separate control transformer feeds part of the circuit. What is the BEST response?',
  '[{"key":"A","text":"Continue because the main disconnect is already open"},{"key":"B","text":"Stop, identify and isolate the additional energy source, then reverify the safe condition"},{"key":"C","text":"Avoid touching only the transformer wires"},{"key":"D","text":"Place tape over the energized terminals and continue"}]'::jsonb,
  '["B"]'::jsonb,
  'Verification revealed an uncontrolled energy source, so the technician must stop, control that source, and verify again before continuing.'
),
(
  13,
  'scenario',
  'scenario',
  'During refrigerant recovery, a technician notices the recovery cylinder becoming unusually warm and the scale indicates it is approaching its allowed fill limit. What should the technician do?',
  '[{"key":"A","text":"Continue until the cylinder is completely full"},{"key":"B","text":"Stop the transfer and manage the cylinder according to its approved capacity and applicable recovery procedure"},{"key":"C","text":"Cool the cylinder with an open flame shield"},{"key":"D","text":"Release some refrigerant to atmosphere to create space"}]'::jsonb,
  '["B"]'::jsonb,
  'Recovery cylinders must be handled within their approved limits; overfilling creates significant pressure and handling hazards.'
),
(
  14,
  'scenario',
  'scenario',
  'A service technician enters a mechanical room and finds another contractor welding near stored combustible materials and the technician''s planned work area. What is the BEST response?',
  '[{"key":"A","text":"Begin HVAC service because the welding belongs to another contractor"},{"key":"B","text":"Coordinate the work, evaluate the shared hazards, and ensure appropriate controls are in place before proceeding"},{"key":"C","text":"Ignore the welding if sparks are not landing on HVAC equipment"},{"key":"D","text":"Move combustible materials without notifying the other contractor"}]'::jsonb,
  '["B"]'::jsonb,
  'Multi-employer work areas require coordination when one crew''s activities can create hazards for another.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is working alone on a rooftop when severe weather begins approaching rapidly. The work involves exposed electrical components and unsecured tools. What is the BEST action?',
  '[{"key":"A","text":"Finish the diagnostic sequence before leaving"},{"key":"B","text":"Stop work, secure the area as appropriate, and leave the exposure zone according to site and company procedures"},{"key":"C","text":"Continue if the roof surface is still dry"},{"key":"D","text":"Stand under the rooftop unit until the storm passes"}]'::jsonb,
  '["B"]'::jsonb,
  'Rapidly changing weather can create electrical, slip, wind, and lightning hazards that require stopping and securing work before conditions become unsafe.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician discovers a strong refrigerant odor in a confined mechanical area and begins feeling lightheaded. What is the BEST immediate response?',
  '[{"key":"A","text":"Stay and locate the leak before leaving"},{"key":"B","text":"Leave the affected area, prevent additional exposure, and initiate the appropriate emergency or leak-response procedure"},{"key":"C","text":"Open the equipment cabinet and continue troubleshooting"},{"key":"D","text":"Use a dust mask and remain in the room"}]'::jsonb,
  '["B"]'::jsonb,
  'Possible refrigerant exposure in a poorly ventilated space can create serious atmospheric hazards; personal safety and exposure control come before leak diagnosis.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is servicing a rooftop unit while a helper works nearby. The technician removes a guard exposing a moving belt and pulley, then must step away to get a tool. What is the BEST action?',
  '[{"key":"A","text":"Leave the guard off because the technician will return shortly"},{"key":"B","text":"Maintain control of the hazardous area and prevent exposure to moving parts before stepping away"},{"key":"C","text":"Tell the helper not to look at the equipment"},{"key":"D","text":"Slow the blower speed and leave it running"}]'::jsonb,
  '["B"]'::jsonb,
  'An exposed machine hazard must remain controlled even during brief interruptions in the task.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer insists that a failed furnace safety device be temporarily bypassed because the building is cold. The technician knows no approved temporary procedure exists. What is the BEST response?',
  '[{"key":"A","text":"Bypass it because loss of heat is an emergency"},{"key":"B","text":"Refuse the unsafe bypass, explain the condition, and follow escalation or out-of-service procedures"},{"key":"C","text":"Bypass it only while the technician remains nearby"},{"key":"D","text":"Have the customer sign a waiver and bypass it"}]'::jsonb,
  '["B"]'::jsonb,
  'Customer pressure does not justify defeating a safety control without an approved procedure; the technician should maintain the safe condition and escalate appropriately.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician preparing for compressor replacement notices that the lifting device available on site has no readable capacity marking. What is the BEST response?',
  '[{"key":"A","text":"Use it if the compressor does not look very heavy"},{"key":"B","text":"Do not use the lifting device until its capacity and suitability for the load can be verified"},{"key":"C","text":"Use two workers to steady the load"},{"key":"D","text":"Lift slowly and stop if the device bends"}]'::jsonb,
  '["B"]'::jsonb,
  'Lifting equipment must be suitable for the intended load; unknown capacity prevents a competent determination that the lift can be performed safely.'
),
(
  20,
  'scenario',
  'scenario',
  'After service is complete, a technician is ready to restore power. Tools are removed, but an access panel is still off and another worker is finishing documentation beside the unit. What is the BEST response?',
  '[{"key":"A","text":"Restore power because the repair itself is complete"},{"key":"B","text":"Complete the required restoration checks, ensure guards or panels and personnel are in a safe condition, then restore energy according to procedure"},{"key":"C","text":"Tell the nearby worker to step back while power is restored"},{"key":"D","text":"Restore power briefly to test whether the repair worked"}]'::jsonb,
  '["B"]'::jsonb,
  'Return to service should occur only after the equipment and affected personnel are in the required safe condition and the restoration procedure is complete.'
);

create temporary table _seed_hvac_safety_regulatory_awareness_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_safety_regulatory_awareness_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in HVAC Safety & Regulatory Awareness?',
  '[{"key":"A","text":"Following established procedures only for personal tasks"},{"key":"B","text":"Leading hazard recognition, validating controls, coordinating safe work, and changing the plan when conditions create unacceptable risk"},{"key":"C","text":"Delegating all safety decisions to the most experienced technician on site"},{"key":"D","text":"Prioritizing schedule recovery whenever controls delay the job"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes leadership, validation, coordination, and sound judgment when changing conditions or system-level risks require the work plan to be adjusted.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a senior HVAC technician''s BEST responsibility when multiple crews are working in the same mechanical area?',
  '[{"key":"A","text":"Focus only on hazards created by the HVAC crew"},{"key":"B","text":"Coordinate overlapping hazards and controls so one crew''s work does not create unacceptable risk for another"},{"key":"C","text":"Assume each contractor is responsible only for its own workers"},{"key":"D","text":"Stop all other trades until HVAC work is finished"}]'::jsonb,
  '["B"]'::jsonb,
  'Senior-level safety leadership includes recognizing and coordinating shared hazards created by simultaneous work activities.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'When a written procedure does not adequately address an unusual HVAC hazard, what is the BEST Level 4 response?',
  '[{"key":"A","text":"Proceed using personal experience without documenting the change"},{"key":"B","text":"Stop or hold the affected work, evaluate the hazard, establish an approved control strategy, and communicate the revised plan"},{"key":"C","text":"Ask the least experienced worker to test the approach first"},{"key":"D","text":"Ignore the gap if the task has been completed safely before"}]'::jsonb,
  '["B"]'::jsonb,
  'A senior technician should not improvise through an unaddressed hazard; the work plan should be formally evaluated and adjusted before exposure continues.'
),
(
  4,
  'multiple_choice',
  'application',
  'A crew is preparing to replace a large rooftop unit. The lift plan was developed yesterday, but today another contractor has staged materials inside the planned exclusion zone. What should the lead technician do?',
  '[{"key":"A","text":"Proceed because the original lift plan was already approved"},{"key":"B","text":"Reassess the lift area, coordinate removal or control of the conflict, and revalidate the plan before the lift begins"},{"key":"C","text":"Ask workers to stand farther away but leave the materials in place"},{"key":"D","text":"Move the unit faster to reduce exposure"}]'::jsonb,
  '["B"]'::jsonb,
  'A changed work environment can invalidate previously adequate controls; senior personnel should revalidate the plan before proceeding.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician reports that a disconnect repeatedly appears deenergized but voltage returns intermittently on a control circuit. What is the BEST lead-level response?',
  '[{"key":"A","text":"Tell the technician to keep testing until the voltage stays at zero"},{"key":"B","text":"Stop affected work, identify the source of unexpected energization, correct the energy-control problem, and verify a stable safe condition"},{"key":"C","text":"Use insulated gloves and continue"},{"key":"D","text":"Disconnect only the thermostat and proceed"}]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected reenergization indicates the energy-control method is inadequate and requires investigation and correction before work resumes.'
),
(
  6,
  'multiple_choice',
  'application',
  'A junior technician proposes recovering two different refrigerants into the same cylinder because both quantities are small. What is the BEST senior response?',
  '[{"key":"A","text":"Approve it if the cylinder has enough capacity"},{"key":"B","text":"Stop the plan and require proper refrigerant identification, segregation, recovery, and handling"},{"key":"C","text":"Allow it if the refrigerants will be reclaimed later"},{"key":"D","text":"Vent the smaller charge instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Senior technicians should prevent practices that create contamination, handling, and compliance problems and reinforce proper recovery procedures.'
),
(
  7,
  'multiple_choice',
  'application',
  'During a job briefing, one worker cannot explain the emergency response for a refrigerant release in the mechanical room. What should the lead do?',
  '[{"key":"A","text":"Continue because only the lead needs to understand the response"},{"key":"B","text":"Clarify the response expectations and confirm affected workers understand the plan before work begins"},{"key":"C","text":"Remove the worker from the project permanently"},{"key":"D","text":"Skip the briefing and post instructions after the job"}]'::jsonb,
  '["B"]'::jsonb,
  'A job briefing is only effective when workers understand the hazards, controls, and response expectations relevant to their work.'
),
(
  8,
  'multiple_choice',
  'application',
  'A team will perform hot work near combustible roof materials while another crew is applying a flammable product nearby. What is the BEST response?',
  '[{"key":"A","text":"Proceed if both crews work quickly"},{"key":"B","text":"Coordinate the activities and eliminate or control the incompatible conditions before hot work begins"},{"key":"C","text":"Assign one worker to watch for smoke and continue"},{"key":"D","text":"Move the torch farther from the product but make no other changes"}]'::jsonb,
  '["B"]'::jsonb,
  'Overlapping work can create hazards not present in either task alone; the lead should coordinate and control incompatible activities.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician sees repeated near misses involving unsecured access panels being left around active equipment during service. What is the BEST response?',
  '[{"key":"A","text":"Correct only the technician involved in the latest incident"},{"key":"B","text":"Address the immediate hazard and evaluate the recurring work practice so the underlying process can be corrected"},{"key":"C","text":"Wait until an injury occurs before changing the process"},{"key":"D","text":"Ban all panel removal during service"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated near misses indicate a systemic weakness that should be corrected at both the immediate and process level.'
),
(
  10,
  'multiple_choice',
  'application',
  'A crew is using a temporary work platform that meets the task needs, but the area beneath it has become a pedestrian route. What should the lead technician do?',
  '[{"key":"A","text":"Continue because the platform itself is safe"},{"key":"B","text":"Reevaluate the exposure below and establish appropriate access control or another safe work arrangement"},{"key":"C","text":"Tell pedestrians to watch for falling objects"},{"key":"D","text":"Move tools closer to the platform edge"}]'::jsonb,
  '["B"]'::jsonb,
  'Safety planning must account for people affected by the work, including changing traffic and dropped-object exposure.'
),
(
  11,
  'scenario',
  'scenario',
  'A lead technician arrives at a commercial site after a refrigerant leak alarm. Building staff want the HVAC crew to enter immediately because production has stopped. The atmospheric condition inside the mechanical room has not been evaluated. What is the BEST response?',
  '[{"key":"A","text":"Send the most experienced technician inside first"},{"key":"B","text":"Prevent entry until the atmospheric hazard is evaluated and the appropriate emergency or entry controls are established"},{"key":"C","text":"Enter with dust masks and open the doors"},{"key":"D","text":"Ask building staff to accept responsibility and enter"}]'::jsonb,
  '["B"]'::jsonb,
  'Production pressure does not justify exposing workers to an unevaluated atmospheric hazard; entry should wait until appropriate controls are established.'
),
(
  12,
  'scenario',
  'scenario',
  'A crew is replacing a rooftop unit when wind begins gusting strongly enough to move sheet metal and affect suspended loads. The crane is already positioned and the customer wants the lift completed. What should the lead do?',
  '[{"key":"A","text":"Continue because stopping will increase crane cost"},{"key":"B","text":"Suspend the lift, secure exposed materials, and resume only when conditions meet the safe lift plan"},{"key":"C","text":"Add more workers to steady the load by hand"},{"key":"D","text":"Lower the load faster"}]'::jsonb,
  '["B"]'::jsonb,
  'Wind can materially change lifting and struck-by hazards; the lead should suspend operations when conditions exceed the safe plan.'
),
(
  13,
  'scenario',
  'scenario',
  'During a compressor replacement, a technician reports that the lockout point identified in the service documentation does not isolate all incoming energy. What is the BEST lead-level response?',
  '[{"key":"A","text":"Tell the technician to continue because the documented point is official"},{"key":"B","text":"Stop work, identify all actual energy sources, correct the isolation plan, and communicate the discrepancy for future work"},{"key":"C","text":"Use the documented point plus PPE"},{"key":"D","text":"Have the customer shut off the thermostat"}]'::jsonb,
  '["B"]'::jsonb,
  'When field conditions contradict the documented energy-control plan, the plan must be corrected rather than blindly followed.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician is injured slightly when a service panel swings unexpectedly after a fastener fails. The injury is minor and work could continue. What is the BEST lead response?',
  '[{"key":"A","text":"Finish the job and discuss it later"},{"key":"B","text":"Control the immediate hazard, ensure the worker receives appropriate attention, and evaluate the incident and equipment condition before resuming affected work"},{"key":"C","text":"Replace the fastener and say nothing because the injury was minor"},{"key":"D","text":"Assign another technician to the same task immediately"}]'::jsonb,
  '["B"]'::jsonb,
  'Even a minor event can reveal an uncontrolled hazard; the lead should address both the worker and the condition before work resumes.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer asks the lead technician to authorize a temporary bypass of a combustion safety control overnight because replacement parts will not arrive until morning. No approved bypass procedure exists. What is the BEST response?',
  '[{"key":"A","text":"Approve it if the customer signs a waiver"},{"key":"B","text":"Refuse the bypass, maintain the equipment in a safe condition, and explain the available escalation or temporary-service options"},{"key":"C","text":"Approve it only if a technician checks the unit every hour"},{"key":"D","text":"Bypass it because loss of heat creates customer inconvenience"}]'::jsonb,
  '["B"]'::jsonb,
  'A senior technician should not authorize defeating a required safety control simply because operational pressure exists.'
),
(
  16,
  'scenario',
  'scenario',
  'Two technicians are performing separate tasks on the same air handler under group energy control. One finishes early and asks the lead to restore power briefly for testing while the other technician is still working inside the unit. What is the BEST response?',
  '[{"key":"A","text":"Restore power briefly if the second technician verbally agrees"},{"key":"B","text":"Do not reenergize until the established group-control and restoration requirements are satisfied for all affected workers"},{"key":"C","text":"Restore only control voltage"},{"key":"D","text":"Have the first technician test another component while energized"}]'::jsonb,
  '["B"]'::jsonb,
  'Group hazardous-energy control must protect every affected worker; one person finishing does not permit premature restoration.'
),
(
  17,
  'scenario',
  'scenario',
  'A senior technician observes that a new employee repeatedly follows procedures correctly but does not recognize changing hazards unless prompted. What is the BEST response?',
  '[{"key":"A","text":"Assume procedure compliance alone proves full readiness"},{"key":"B","text":"Provide targeted coaching and supervised exposure focused on hazard recognition before assigning greater independent responsibility"},{"key":"C","text":"Give the employee lead duties to accelerate learning"},{"key":"D","text":"Stop providing written procedures"}]'::jsonb,
  '["B"]'::jsonb,
  'Senior-level development includes distinguishing procedural compliance from independent hazard recognition and coaching accordingly.'
),
(
  18,
  'scenario',
  'scenario',
  'A near miss occurs when a mislabeled disconnect is found energized during verification. No one is injured. What is the BEST Level 4 response after the immediate hazard is controlled?',
  '[{"key":"A","text":"Correct the label and resume work without further action"},{"key":"B","text":"Correct the immediate condition and investigate whether similar labeling or energy-control failures may exist elsewhere"},{"key":"C","text":"Tell the technician to test more carefully next time"},{"key":"D","text":"Ignore it because verification prevented an injury"}]'::jsonb,
  '["B"]'::jsonb,
  'A serious near miss should trigger both immediate correction and evaluation of whether the failure indicates a broader systemic hazard.'
),
(
  19,
  'scenario',
  'scenario',
  'A project requires technicians to work on unfamiliar equipment containing a refrigerant the crew has not previously serviced. The schedule allows no formal training day. What is the BEST lead response?',
  '[{"key":"A","text":"Assign the work to the fastest technician"},{"key":"B","text":"Verify the equipment, refrigerant hazards, procedures, qualifications, and required controls before assigning and starting the work"},{"key":"C","text":"Rely only on the equipment nameplate"},{"key":"D","text":"Have the crew learn by trial and error during startup"}]'::jsonb,
  '["B"]'::jsonb,
  'Unfamiliar equipment or refrigerants require deliberate verification of hazards, competency, and controls before work begins.'
),
(
  20,
  'scenario',
  'scenario',
  'A lead technician learns that several crews have independently modified the same written startup checklist because field conditions often differ from the original procedure. What is the BEST response?',
  '[{"key":"A","text":"Allow each crew to keep its preferred version"},{"key":"B","text":"Review the recurring differences, validate the safest effective process, and route the procedure through the appropriate formal revision process"},{"key":"C","text":"Delete the checklist entirely"},{"key":"D","text":"Require crews to follow the old procedure even when it does not fit field conditions"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated field workarounds are evidence that the underlying procedure may need formal review and controlled revision rather than informal local variation.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '954efc35-c379-4f0d-8999-fd0c49688bf3';
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
      and c.name = 'HVAC Safety & Regulatory Awareness'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Safety & Regulatory Awareness Master Competency not found';
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
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Installer / Helper L2 safety requirement not found';
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
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'HVAC Safety & Regulatory Awareness — Level 2 Competency Assessment';

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
    select * from _seed_hvac_safety_regulatory_awareness_l2_questions
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
        'HVAC Safety & Regulatory Awareness',
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
      'IntegrateU HVAC Safety & Regulatory Awareness L2 production assessment v1.0.',
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
      (v_master_question_id, v_installer_role_id),
      (v_master_question_id, v_design_sales_role_id)
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
        'HVAC Safety & Regulatory Awareness',
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
        'IntegrateU HVAC Safety & Regulatory Awareness L2 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Safety & Regulatory Awareness — Level 3 Competency Assessment';

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
    select * from _seed_hvac_safety_regulatory_awareness_l3_questions
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
        'HVAC Safety & Regulatory Awareness',
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
      'IntegrateU HVAC Safety & Regulatory Awareness L3 production assessment v1.0.',
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
        'HVAC Safety & Regulatory Awareness',
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
        'IntegrateU HVAC Safety & Regulatory Awareness L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Safety & Regulatory Awareness — Level 4 Competency Assessment';

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
    select * from _seed_hvac_safety_regulatory_awareness_l4_questions
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
        'HVAC Safety & Regulatory Awareness',
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
      'IntegrateU HVAC Safety & Regulatory Awareness L4 production assessment v1.0.',
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
        'HVAC Safety & Regulatory Awareness',
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
        'IntegrateU HVAC Safety & Regulatory Awareness L4 production assessment v1.0.',
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
   '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid
  and a.target_level in (2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 2 Installer / Helper      -> 20
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
      '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid
    and a.target_level in (2,3,4)
    and aq.master_competency_template_id =
      '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 2 and ra.master_role_template_id =
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
  '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid;

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
    '954efc35-c379-4f0d-8999-fd0c49688bf3'::uuid
  and a.target_level in (2,3,4)
group by a.target_level
having count(*) > 1;
