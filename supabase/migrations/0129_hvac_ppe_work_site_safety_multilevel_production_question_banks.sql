-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0129_hvac_ppe_work_site_safety_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Personal Protective Equipment & Work-Site Safety
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

create temporary table _seed_hvac_ppe_work_site_safety_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ppe_work_site_safety_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of personal protective equipment at an HVAC work site?',
  '[{"key":"A","text":"To reduce worker exposure to hazards that have not been fully eliminated or controlled"},{"key":"B","text":"To replace all engineering controls"},{"key":"C","text":"To make employees easier to identify"},{"key":"D","text":"To eliminate the need for safe work procedures"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE helps protect workers from remaining hazards and does not replace effective engineering or work-practice controls.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should determine which PPE is required for a task?',
  '[{"key":"A","text":"The hazards present or likely to be present during the work"},{"key":"B","text":"The employee''s preferred brand"},{"key":"C","text":"The time of day"},{"key":"D","text":"The color of the equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should be selected based on the hazards identified for the work activity and environment.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is proper PPE fit important?',
  '[{"key":"A","text":"Poorly fitting PPE can reduce protection or create additional hazards"},{"key":"B","text":"Fit matters only for appearance"},{"key":"C","text":"Oversized PPE always provides more protection"},{"key":"D","text":"Fit matters only for respiratory protection"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must fit properly so it can provide its intended protection without interfering with safe movement or work.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'When is eye or face protection generally needed?',
  '[{"key":"A","text":"When work can expose the worker to flying particles, chemicals, vapors, or other eye or face hazards"},{"key":"B","text":"Only when working outdoors"},{"key":"C","text":"Only when a customer requests it"},{"key":"D","text":"Only when using a ladder"}]'::jsonb,
  '["A"]'::jsonb,
  'Appropriate eye or face protection is required where the task creates hazards such as flying particles or chemical exposure.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'When should protective headgear be considered?',
  '[{"key":"A","text":"Where there is a possibility of head injury from impact, falling or flying objects, or applicable electrical hazards"},{"key":"B","text":"Only during rain"},{"key":"C","text":"Only when carrying tools"},{"key":"D","text":"Only on commercial projects"}]'::jsonb,
  '["A"]'::jsonb,
  'Head protection is selected where the work environment presents recognized head-impact, falling-object, or applicable electrical hazards.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the BEST approach to damaged PPE?',
  '[{"key":"A","text":"Remove it from use when damage could affect its protective function"},{"key":"B","text":"Continue using it until it completely fails"},{"key":"C","text":"Use it only for shorter tasks"},{"key":"D","text":"Share it with another employee"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must remain in reliable condition; damage that compromises protection requires correction or replacement.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes gloves as PPE?',
  '[{"key":"A","text":"The glove type should match the specific hand hazard and task"},{"key":"B","text":"Any glove protects against every hazard"},{"key":"C","text":"Thicker gloves are always safer"},{"key":"D","text":"Gloves eliminate the need to control sharp or hot surfaces"}]'::jsonb,
  '["A"]'::jsonb,
  'Different glove materials and designs protect against different hazards, so selection must match the task.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should a worker do before using unfamiliar PPE?',
  '[{"key":"A","text":"Understand how to use it correctly and verify that it is suitable for the identified hazard"},{"key":"B","text":"Assume all PPE is used the same way"},{"key":"C","text":"Modify it until it feels comfortable"},{"key":"D","text":"Use it only if another employee is wearing the same type"}]'::jsonb,
  '["A"]'::jsonb,
  'Workers should understand the proper use, limitations, and fit of PPE before relying on it for protection.'
),
(
  9,
  'multiple_choice',
  'application',
  'A design engineer visits an active equipment room where overhead work is occurring. What is the BEST response before entering?',
  '[{"key":"A","text":"Identify the site hazards and comply with the required head, eye, foot, and other PPE controls"},{"key":"B","text":"Enter without PPE because the engineer is not performing installation work"},{"key":"C","text":"Wear only a company badge"},{"key":"D","text":"Ask the workers to stop all work"}]'::jsonb,
  '["A"]'::jsonb,
  'Visitors and design personnel can be exposed to the same work-site hazards and should follow the applicable protective requirements.'
),
(
  10,
  'multiple_choice',
  'application',
  'A worker''s safety glasses repeatedly slide down and leave gaps because they are too large. What is the BEST action?',
  '[{"key":"A","text":"Provide properly fitting eye protection suitable for the hazard"},{"key":"B","text":"Tell the worker to tighten them with tape"},{"key":"C","text":"Allow the worker to remove them when inconvenient"},{"key":"D","text":"Use the oversized glasses only for drilling"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must properly fit the affected employee and remain suitable for the hazard.'
),
(
  11,
  'multiple_choice',
  'application',
  'A site walk will pass near workers drilling overhead into concrete. What PPE concern should be addressed?',
  '[{"key":"A","text":"Potential eye, face, and head exposure from falling or flying debris"},{"key":"B","text":"Only hearing protection because drilling cannot create debris"},{"key":"C","text":"Only gloves"},{"key":"D","text":"No PPE is needed for someone who is only observing"}]'::jsonb,
  '["A"]'::jsonb,
  'Overhead drilling can expose nearby personnel to flying or falling material, requiring appropriate protection or exclusion from the hazard area.'
),
(
  12,
  'multiple_choice',
  'application',
  'A pair of protective gloves has a torn palm before a site inspection requiring contact with rough sheet metal. What is the BEST response?',
  '[{"key":"A","text":"Replace the damaged gloves with suitable gloves before the task"},{"key":"B","text":"Wear the gloves backward"},{"key":"C","text":"Cover the tear with paper tape"},{"key":"D","text":"Use bare hands for a brief inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged PPE should not be relied on when the damage can compromise protection against the identified hazard.'
),
(
  13,
  'multiple_choice',
  'application',
  'A mechanical-room survey requires walking through an area with wet floors and construction debris. What is the BEST preparation?',
  '[{"key":"A","text":"Use suitable footwear and follow site controls for slip, trip, and puncture hazards"},{"key":"B","text":"Wear smooth-soled office shoes"},{"key":"C","text":"Walk faster through the area"},{"key":"D","text":"Rely on a hard hat to prevent slips"}]'::jsonb,
  '["A"]'::jsonb,
  'Footwear and work-site controls should be appropriate for identified walking-surface and material hazards.'
),
(
  14,
  'multiple_choice',
  'application',
  'A worker is about to grind a metal bracket and has ordinary prescription glasses. What should happen?',
  '[{"key":"A","text":"Use appropriate eye or face protection that works with the prescription lenses and protects against the grinding hazard"},{"key":"B","text":"Prescription glasses automatically provide adequate grinding protection"},{"key":"C","text":"Remove the prescription glasses and grind without eye protection"},{"key":"D","text":"Stand farther away from the grinder"}]'::jsonb,
  '["A"]'::jsonb,
  'Prescription lenses do not automatically satisfy impact-protection needs; appropriate protective eyewear must accommodate the prescription safely.'
),
(
  15,
  'multiple_choice',
  'application',
  'A site has a recurring overhead falling-object hazard. Which response is BEST?',
  '[{"key":"A","text":"Use appropriate head protection and also address the hazard through work-zone, engineering, or procedural controls"},{"key":"B","text":"Use hard hats as the only control and ignore the source of falling objects"},{"key":"C","text":"Allow workers to decide whether head protection is comfortable"},{"key":"D","text":"Use safety glasses instead of head protection"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should be combined with appropriate controls rather than used as a substitute for correcting the underlying hazard.'
),
(
  16,
  'multiple_choice',
  'application',
  'A design employee arrives at a construction site wearing footwear that does not meet the site''s required protection. What is the BEST response?',
  '[{"key":"A","text":"Do not enter the affected work area until suitable footwear or another approved control is provided"},{"key":"B","text":"Enter because the employee is not using tools"},{"key":"C","text":"Stay close to the wall and continue"},{"key":"D","text":"Borrow footwear that does not fit"}]'::jsonb,
  '["A"]'::jsonb,
  'Required PPE applies based on exposure to the hazard, and improperly fitting borrowed PPE may not provide adequate protection.'
),
(
  17,
  'scenario',
  'scenario',
  'During a site survey, a designer notices workers cutting sheet metal nearby and small metal fragments are reaching the walkway. The designer has no eye protection. What is the BEST response?',
  '[{"key":"A","text":"Avoid entering the exposure area until appropriate eye protection or another effective control is in place"},{"key":"B","text":"Walk through quickly"},{"key":"C","text":"Cover the eyes with one hand"},{"key":"D","text":"Turn the head away while walking"}]'::jsonb,
  '["A"]'::jsonb,
  'A person exposed to flying-particle hazards should not enter without appropriate protection or effective isolation from the hazard.'
),
(
  18,
  'scenario',
  'scenario',
  'A worker says the only available hard hat is much too large and will not stay securely positioned. What is the BEST response?',
  '[{"key":"A","text":"Provide properly fitting protective headgear before exposing the worker to the head hazard"},{"key":"B","text":"Tell the worker to hold it in place"},{"key":"C","text":"Add loose packing material inside the shell"},{"key":"D","text":"Allow work without it because PPE was technically provided"}]'::jsonb,
  '["A"]'::jsonb,
  'Providing PPE is not enough when it does not properly fit the worker and cannot function as intended.'
),
(
  19,
  'scenario',
  'scenario',
  'An employee wears required PPE but repeatedly enters a barricaded area where overhead material is being lifted. What is the BEST response?',
  '[{"key":"A","text":"Keep the employee out of the controlled hazard area; PPE does not replace work-zone restrictions"},{"key":"B","text":"Allow entry because the employee is wearing PPE"},{"key":"C","text":"Require a second hard hat"},{"key":"D","text":"Allow entry if it takes less than one minute"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE is only one layer of protection and does not authorize workers to bypass established hazard controls.'
),
(
  20,
  'scenario',
  'scenario',
  'A site inspection reveals that several employees have modified their protective eyewear because the original equipment does not fit comfortably. What is the BEST response?',
  '[{"key":"A","text":"Stop relying on modified PPE and provide properly fitting, approved protection appropriate for the hazard"},{"key":"B","text":"Allow modifications if employees prefer them"},{"key":"C","text":"Remove the eye-protection requirement"},{"key":"D","text":"Use the modified eyewear only for short tasks"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should be suitable, reliable, and properly fitting; improvised modifications can compromise its protective performance.'
);

create temporary table _seed_hvac_ppe_work_site_safety_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ppe_work_site_safety_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What should an HVAC installer do before beginning a task with potential eye, hand, head, foot, or hearing hazards?',
  '[{"key":"A","text":"Identify the task hazards and use the required PPE and work-site controls"},{"key":"B","text":"Start work and add PPE only if an injury almost occurs"},{"key":"C","text":"Use the same PPE for every task regardless of hazard"},{"key":"D","text":"Rely only on experience"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE selection should follow recognition of the hazards present or likely to be present during the task.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why must PPE fit the worker properly?',
  '[{"key":"A","text":"Poor fit can reduce protection, interfere with movement, or create another hazard"},{"key":"B","text":"Fit matters only for appearance"},{"key":"C","text":"Loose PPE always provides more protection"},{"key":"D","text":"Fit is optional for short-duration work"}]'::jsonb,
  '["A"]'::jsonb,
  'Properly fitting PPE is necessary for reliable protection and safe task performance.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Which statement about damaged PPE is correct?',
  '[{"key":"A","text":"PPE that can no longer provide reliable protection should be removed from service"},{"key":"B","text":"Damaged PPE is acceptable for tasks under five minutes"},{"key":"C","text":"Tape repairs are always acceptable"},{"key":"D","text":"Damage matters only if the PPE is company-owned"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should be maintained in a reliable condition and replaced or corrected when damage compromises protection.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'When selecting gloves for HVAC installation work, what is MOST important?',
  '[{"key":"A","text":"Matching the glove to the specific hazard and task"},{"key":"B","text":"Choosing the thickest glove available"},{"key":"C","text":"Using one glove type for all tasks"},{"key":"D","text":"Choosing the lowest-cost glove"}]'::jsonb,
  '["A"]'::jsonb,
  'Different hand hazards require different glove materials and designs.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the BEST relationship between PPE and other hazard controls?',
  '[{"key":"A","text":"PPE is one layer of protection and does not replace effective engineering, administrative, or work-practice controls"},{"key":"B","text":"PPE eliminates the need for barricades"},{"key":"C","text":"PPE eliminates the need to correct unsafe conditions"},{"key":"D","text":"PPE is only needed when no other controls exist"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should be used as part of an overall hazard-control approach rather than as a substitute for correcting hazards.'
),
(
  6,
  'multiple_choice',
  'application',
  'An installer is drilling overhead and metal debris may fall toward the face. What is the BEST protection approach?',
  '[{"key":"A","text":"Use suitable eye and face protection and control the work area below"},{"key":"B","text":"Wear gloves only"},{"key":"C","text":"Look away while drilling"},{"key":"D","text":"Increase drill speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Overhead drilling can expose the worker and nearby personnel to falling and flying debris.'
),
(
  7,
  'multiple_choice',
  'application',
  'An installer must handle sharp sheet-metal edges. What is the BEST action?',
  '[{"key":"A","text":"Use appropriate hand protection and handling methods for the cut hazard"},{"key":"B","text":"Use bare hands for better grip"},{"key":"C","text":"Wear cotton gloves regardless of hazard"},{"key":"D","text":"Handle the metal faster"}]'::jsonb,
  '["A"]'::jsonb,
  'Sharp sheet metal presents a cut hazard that should be addressed with suitable gloves and safe handling practices.'
),
(
  8,
  'multiple_choice',
  'application',
  'An installer''s safety glasses are badly scratched and distort vision. What should happen?',
  '[{"key":"A","text":"Replace them with suitable eye protection before continuing the task"},{"key":"B","text":"Continue because scratched lenses still cover the eyes"},{"key":"C","text":"Remove them for precision work"},{"key":"D","text":"Wear them only outdoors"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE that interferes with safe vision or no longer provides reliable protection should be replaced.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is working beneath another trade that is moving materials overhead. What is the BEST response?',
  '[{"key":"A","text":"Use required head protection and remain outside uncontrolled overhead-load or falling-object zones"},{"key":"B","text":"Wear a hard hat and stand directly under the load"},{"key":"C","text":"Continue without head protection if the work is brief"},{"key":"D","text":"Use safety glasses instead of head protection"}]'::jsonb,
  '["A"]'::jsonb,
  'Head protection does not authorize workers to enter areas where overhead loads or falling-object hazards are not properly controlled.'
),
(
  10,
  'multiple_choice',
  'application',
  'An installer needs to enter an area with wet floors, loose fasteners, and construction debris. What should be addressed?',
  '[{"key":"A","text":"Suitable footwear plus housekeeping and walking-surface controls"},{"key":"B","text":"Hard hats only"},{"key":"C","text":"Gloves only"},{"key":"D","text":"No controls if the installer walks slowly"}]'::jsonb,
  '["A"]'::jsonb,
  'Footwear should match the hazard, while the underlying slip, trip, and puncture conditions should also be controlled.'
),
(
  11,
  'multiple_choice',
  'application',
  'An installer is using a noisy power tool and must raise their voice to communicate with someone nearby. What is the BEST next step?',
  '[{"key":"A","text":"Follow the site hearing-protection and noise-control requirements for the task"},{"key":"B","text":"Continue because the noise is temporary"},{"key":"C","text":"Use eye protection as a substitute"},{"key":"D","text":"Remove all PPE to hear better"}]'::jsonb,
  '["A"]'::jsonb,
  'High noise can require hearing protection and other controls based on the workplace noise evaluation and task requirements.'
),
(
  12,
  'multiple_choice',
  'application',
  'An installer has prescription glasses and needs to grind a bracket. What is the BEST approach?',
  '[{"key":"A","text":"Use suitable impact-rated eye or face protection that safely accommodates the prescription lenses"},{"key":"B","text":"Prescription glasses alone are always sufficient"},{"key":"C","text":"Remove the prescription glasses"},{"key":"D","text":"Close one eye while grinding"}]'::jsonb,
  '["A"]'::jsonb,
  'Ordinary prescription glasses do not automatically provide the protection required for grinding hazards.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer notices a coworker wearing loose gloves near rotating equipment. What is the BEST response?',
  '[{"key":"A","text":"Stop and reassess the hand protection because loose gloves can create an entanglement hazard"},{"key":"B","text":"Add a second pair of gloves"},{"key":"C","text":"Continue if the gloves are cut resistant"},{"key":"D","text":"Tuck the gloves farther into the machine area"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must match the entire task; hand protection can create risk where entanglement with rotating equipment is possible.'
),
(
  14,
  'multiple_choice',
  'application',
  'A helper is given a hard hat that is so loose it falls off when bending over. What is the BEST action?',
  '[{"key":"A","text":"Provide properly fitting head protection before exposing the helper to the hazard"},{"key":"B","text":"Tell the helper to hold it in place"},{"key":"C","text":"Use tape to attach it to the worker"},{"key":"D","text":"Allow work without it because a hard hat was issued"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must properly fit the affected employee so it can function as intended.'
),
(
  15,
  'scenario',
  'scenario',
  'An installer begins cutting sheet metal while a helper stands in the path of flying fragments without eye protection. What is the BEST response?',
  '[{"key":"A","text":"Stop the task and correct the helper''s exposure with appropriate PPE or separation from the hazard area"},{"key":"B","text":"Tell the helper to look away"},{"key":"C","text":"Continue because only the installer is using the tool"},{"key":"D","text":"Have the helper cover their face with a sleeve"}]'::jsonb,
  '["A"]'::jsonb,
  'Nearby workers exposed to flying particles need appropriate protection or effective separation from the hazard.'
),
(
  16,
  'scenario',
  'scenario',
  'A worker says required gloves are too small and restrict hand movement, but no other size is immediately available. What is the BEST response?',
  '[{"key":"A","text":"Do not proceed with the hazardous task until properly fitting, suitable hand protection is available"},{"key":"B","text":"Use the undersized gloves because PPE has technically been provided"},{"key":"C","text":"Cut the fingertips off the gloves"},{"key":"D","text":"Work barehanded"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must properly fit and remain appropriate for the task; unsuitable fit should be corrected before exposure.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer is wearing a hard hat but walks under a suspended piece of equipment being lifted into place. What is the BEST response?',
  '[{"key":"A","text":"Keep the installer out of the suspended-load hazard zone; the hard hat is not a substitute for controlling the lift area"},{"key":"B","text":"Allow entry because the installer has head protection"},{"key":"C","text":"Require two hard hats"},{"key":"D","text":"Allow entry if the installer moves quickly"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE does not replace exclusion zones or safe lifting practices around suspended loads.'
),
(
  18,
  'scenario',
  'scenario',
  'A helper reports that the face shield used for grinding is cracked near the mounting point. The crew is behind schedule. What is the BEST response?',
  '[{"key":"A","text":"Remove the damaged face shield from service and replace it before grinding continues"},{"key":"B","text":"Use it for one more shift"},{"key":"C","text":"Tape the crack and continue"},{"key":"D","text":"Grind without the shield"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule pressure does not justify relying on PPE whose protective performance may be compromised.'
),
(
  19,
  'scenario',
  'scenario',
  'An installer has all required PPE but repeatedly climbs over a barricade into an area where another crew is performing overhead demolition. What is the BEST response?',
  '[{"key":"A","text":"Stop the behavior and enforce the controlled-area restriction; PPE does not override barricades"},{"key":"B","text":"Allow entry because all PPE is being worn"},{"key":"C","text":"Add hearing protection"},{"key":"D","text":"Move the barricade closer to the demolition"}]'::jsonb,
  '["A"]'::jsonb,
  'Work-zone controls remain mandatory even when appropriate PPE is worn.'
),
(
  20,
  'scenario',
  'scenario',
  'A crew has begun sharing one pair of chemical-resistant gloves between workers even though the gloves do not fit everyone properly and the task involves chemical exposure. What is the BEST response?',
  '[{"key":"A","text":"Provide suitable, properly fitting protection for each exposed worker and follow the applicable handling and hygiene requirements"},{"key":"B","text":"Continue sharing because the glove material is correct"},{"key":"C","text":"Use the gloves only for the worker with the largest hands"},{"key":"D","text":"Skip gloves for short contact"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct glove material alone is insufficient when PPE does not properly fit the individual worker or cannot be used hygienically and reliably.'
);

create temporary table _seed_hvac_ppe_work_site_safety_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ppe_work_site_safety_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Personal Protective Equipment & Work-Site Safety?',
  '[{"key":"A","text":"Using PPE only when a supervisor is present"},{"key":"B","text":"Independently recognizing hazards, selecting suitable PPE, enforcing work-site controls, and stopping work when protection is inadequate"},{"key":"C","text":"Using the same PPE for every HVAC task"},{"key":"D","text":"Treating PPE as a substitute for correcting hazards"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent hazard recognition, correct PPE use, and sound judgment about when work should not proceed.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a service technician reassess PPE when the task changes?',
  '[{"key":"A","text":"A change in task can introduce different hazards requiring different protection"},{"key":"B","text":"PPE requirements never change during a service call"},{"key":"C","text":"Only supervisors can recognize new hazards"},{"key":"D","text":"PPE depends only on the customer site"}]'::jsonb,
  '["A"]'::jsonb,
  'Hazards can change as troubleshooting progresses, so PPE and other controls should be reassessed when the work changes.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should a technician do when PPE interferes with the ability to perform a task safely?',
  '[{"key":"A","text":"Remove the PPE and continue"},{"key":"B","text":"Stop and identify suitable protection or another safe method before continuing"},{"key":"C","text":"Modify the PPE without authorization"},{"key":"D","text":"Work faster to reduce exposure time"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE should protect without creating a new hazard; unsuitable protection requires reassessment before work continues.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST principle when a hazard can be controlled by both work practices and PPE?',
  '[{"key":"A","text":"Use the appropriate work-practice controls and PPE together when required"},{"key":"B","text":"Use PPE only"},{"key":"C","text":"Use work practices only and ignore PPE requirements"},{"key":"D","text":"Let each technician choose one control"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE is part of a layered safety approach and should work with other effective controls.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician begins cutting into sheet metal and realizes the face shield available is cracked. What is the BEST action?',
  '[{"key":"A","text":"Stop and replace the damaged protection before continuing"},{"key":"B","text":"Use it because safety glasses are also being worn"},{"key":"C","text":"Tape the crack and finish the cut"},{"key":"D","text":"Turn the face shield sideways"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged PPE should not be relied upon where the damage may compromise its protective function.'
),
(
  6,
  'multiple_choice',
  'application',
  'A service technician must enter a mechanical room where another contractor is creating heavy airborne dust. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the airborne hazard and follow the required respiratory, eye, and work-area controls before entry"},{"key":"B","text":"Cover the mouth with a shirt"},{"key":"C","text":"Enter briefly without protection"},{"key":"D","text":"Use hearing protection as a substitute"}]'::jsonb,
  '["A"]'::jsonb,
  'Airborne hazards require proper evaluation and controls rather than improvised protection.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician is grinding near another worker who is not wearing eye protection. What should the technician do?',
  '[{"key":"A","text":"Control the nearby exposure before grinding begins"},{"key":"B","text":"Continue because the other worker is not using the grinder"},{"key":"C","text":"Ask the worker to close their eyes"},{"key":"D","text":"Stand between the grinder and the worker"}]'::jsonb,
  '["A"]'::jsonb,
  'Workers exposed to flying particles require suitable protection or effective separation from the hazard.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician needs chemical-resistant gloves, but the only available pair is too loose to maintain a secure grip. What is the BEST action?',
  '[{"key":"A","text":"Obtain suitable, properly fitting gloves before performing the task"},{"key":"B","text":"Use the loose gloves because the material is correct"},{"key":"C","text":"Wear two loose pairs"},{"key":"D","text":"Work barehanded"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE must be both appropriate for the hazard and properly fitting for safe use.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician notices a recurring trip hazard from service hoses crossing a walkway. What is the BEST response?',
  '[{"key":"A","text":"Correct or control the hose routing and maintain suitable footwear rather than relying on PPE alone"},{"key":"B","text":"Wear heavier boots and leave the hoses in place"},{"key":"C","text":"Place a tool bag over the hoses"},{"key":"D","text":"Tell people to step higher"}]'::jsonb,
  '["A"]'::jsonb,
  'Underlying work-site hazards should be controlled rather than left in place simply because workers have PPE.'
),
(
  10,
  'multiple_choice',
  'application',
  'A service task changes from inspection to drilling overhead into masonry. What should the technician do?',
  '[{"key":"A","text":"Reassess the hazards and add the appropriate eye, face, head, hearing, or other protection required for the drilling task"},{"key":"B","text":"Keep the original PPE because the job location did not change"},{"key":"C","text":"Use gloves only"},{"key":"D","text":"Ask the customer to stand nearby"}]'::jsonb,
  '["A"]'::jsonb,
  'Task changes can create new hazards and should trigger a reassessment of protection.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician sees a coworker wearing loose clothing and loose gloves near rotating equipment. What is the BEST response?',
  '[{"key":"A","text":"Stop and correct the entanglement hazard before the equipment is operated"},{"key":"B","text":"Allow the work because the gloves are protective"},{"key":"C","text":"Increase machine speed"},{"key":"D","text":"Add a face shield only"}]'::jsonb,
  '["A"]'::jsonb,
  'Protective equipment or clothing must not introduce an entanglement hazard around rotating machinery.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician arrives at a rooftop unit during high winds. Loose debris is blowing across the roof and the technician has only basic eye protection. What is the BEST response?',
  '[{"key":"A","text":"Reassess the weather and flying-debris hazards and delay or modify the work until appropriate controls are in place"},{"key":"B","text":"Continue because the unit is already shut down"},{"key":"C","text":"Work faster"},{"key":"D","text":"Remove the eye protection because it may fog"}]'::jsonb,
  '["A"]'::jsonb,
  'Changing environmental conditions can create hazards that exceed the protection available and justify delaying or modifying work.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician enters a construction area wearing all required PPE but ignores a barricade around overhead lifting operations. What is the BEST response?',
  '[{"key":"A","text":"Keep the technician outside the controlled area; PPE does not override barricades or suspended-load controls"},{"key":"B","text":"Allow entry because all PPE is present"},{"key":"C","text":"Require an additional hard hat"},{"key":"D","text":"Allow entry for troubleshooting only"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE is not a substitute for work-zone controls around serious hazards such as suspended loads.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician discovers that the only available safety glasses are so scratched that they make it difficult to see wiring and components clearly. What is the BEST action?',
  '[{"key":"A","text":"Replace the damaged eye protection before continuing"},{"key":"B","text":"Remove the glasses for close work"},{"key":"C","text":"Continue if the task lasts less than ten minutes"},{"key":"D","text":"Use a flashlight to compensate"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE should remain in reliable condition and should not impair safe task performance.'
),
(
  15,
  'scenario',
  'scenario',
  'A service technician is exposed to unusually loud compressor noise and notices ringing in the ears afterward. The same condition has occurred on several calls. What is the BEST response?',
  '[{"key":"A","text":"Report and evaluate the recurring noise exposure and apply the required noise controls and hearing protection"},{"key":"B","text":"Ignore it because compressor noise is normal"},{"key":"C","text":"Use earphones playing music"},{"key":"D","text":"Shorten each service call by five minutes"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring symptoms and high noise warrant evaluation and proper controls rather than informal workarounds.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician is about to use a chemical cleaner but cannot confirm whether the gloves on the truck are compatible with the product. What is the BEST response?',
  '[{"key":"A","text":"Stop and verify the required hand protection before handling the chemical"},{"key":"B","text":"Use the gloves because any glove is better than none"},{"key":"C","text":"Double the gloves"},{"key":"D","text":"Handle the cleaner quickly"}]'::jsonb,
  '["A"]'::jsonb,
  'Chemical-resistant glove selection should be based on compatibility with the actual chemical hazard.'
),
(
  17,
  'scenario',
  'scenario',
  'A coworker repeatedly modifies safety glasses by removing side protection because it feels uncomfortable. What is the BEST technician response?',
  '[{"key":"A","text":"Stop relying on the modified PPE and obtain properly fitting approved protection"},{"key":"B","text":"Allow the modification if the coworker accepts the risk"},{"key":"C","text":"Use the glasses only indoors"},{"key":"D","text":"Remove eye protection requirements for that worker"}]'::jsonb,
  '["A"]'::jsonb,
  'Unauthorized PPE modifications can compromise protection and should be corrected with suitable properly fitting equipment.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician is asked to work beneath overhead piping installation because the service call is urgent. The area is actively controlled for falling-object hazards. What is the BEST response?',
  '[{"key":"A","text":"Wait until the overhead hazard is controlled or the work area is released for safe entry"},{"key":"B","text":"Enter with a hard hat because the service call is urgent"},{"key":"C","text":"Enter if another worker watches overhead"},{"key":"D","text":"Enter for no more than five minutes"}]'::jsonb,
  '["A"]'::jsonb,
  'Urgency does not justify entering an active falling-object hazard zone.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician sees that a helper has been issued PPE that does not fit properly but is continuing to work because replacement equipment has not arrived. What is the BEST response?',
  '[{"key":"A","text":"Stop the affected work until suitable, properly fitting protection is available"},{"key":"B","text":"Allow work because PPE was issued"},{"key":"C","text":"Tell the helper to adjust it with tape"},{"key":"D","text":"Have the helper avoid looking at the hazard"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE that does not properly fit should not be treated as adequate protection for hazardous work.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician notices that several workers on a job consistently wear PPE correctly but leave sharp scrap metal and loose fasteners throughout the work area. What is the BEST response?',
  '[{"key":"A","text":"Correct the housekeeping hazard as well as maintaining the required PPE"},{"key":"B","text":"Leave the debris because footwear protects workers"},{"key":"C","text":"Require thicker gloves only"},{"key":"D","text":"Move the debris into the main walkway"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE does not replace basic work-site controls such as effective housekeeping.'
);

create temporary table _seed_hvac_ppe_work_site_safety_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ppe_work_site_safety_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Personal Protective Equipment & Work-Site Safety?',
  '[{"key":"A","text":"Personally wearing PPE correctly while allowing crews to choose their own practices"},{"key":"B","text":"Leading hazard assessment, validating PPE selection and fit, coaching technicians, and correcting recurring work-site safety weaknesses"},{"key":"C","text":"Using PPE as the primary response to every hazard"},{"key":"D","text":"Allowing experienced employees to bypass PPE requirements"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership, validation, coaching, and correction of systemic PPE and work-site safety weaknesses.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the BEST senior-level response when PPE technically meets the hazard category but repeatedly does not fit some employees correctly?',
  '[{"key":"A","text":"Continue using it because the PPE type is correct"},{"key":"B","text":"Correct the selection process so suitable PPE properly fits each affected employee"},{"key":"C","text":"Tell employees to modify the PPE themselves"},{"key":"D","text":"Limit poorly fitting PPE to short-duration tasks"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE must be selected not only for the hazard but also so it properly fits the affected employee.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a senior technician investigate repeated PPE failures or unsafe work-zone behavior instead of correcting only the individual event?',
  '[{"key":"A","text":"Repeated events can indicate a systemic problem in hazard assessment, equipment selection, training, supervision, or work planning"},{"key":"B","text":"Individual events never matter"},{"key":"C","text":"PPE failures are always caused by employees"},{"key":"D","text":"Only written injuries require investigation"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring unsafe conditions often signal a broader weakness that should be corrected at the process or program level.'
),
(
  4,
  'multiple_choice',
  'application',
  'A lead technician finds that smaller employees are routinely issued oversized gloves and eye protection because the branch stocks only one size. What is the BEST response?',
  '[{"key":"A","text":"Tell employees to make the PPE work"},{"key":"B","text":"Correct the inventory and selection process so properly fitting, hazard-appropriate PPE is available"},{"key":"C","text":"Allow employees to work without PPE when fit is poor"},{"key":"D","text":"Use tape to resize all PPE"}]'::jsonb,
  '["B"]'::jsonb,
  'A recurring fit problem should be addressed through proper PPE selection and availability rather than informal modification.'
),
(
  5,
  'multiple_choice',
  'application',
  'A branch has frequent eye-protection damage because technicians throw safety glasses loose into tool bags. What is the BEST senior response?',
  '[{"key":"A","text":"Replace each pair without changing anything else"},{"key":"B","text":"Correct storage, inspection, care, and replacement practices so PPE remains reliable"},{"key":"C","text":"Buy cheaper glasses"},{"key":"D","text":"Allow scratched glasses for short tasks"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE reliability depends on proper care, storage, inspection, and replacement, not merely initial issuance.'
),
(
  6,
  'multiple_choice',
  'application',
  'A lead technician notices crews relying on hard hats while routinely entering uncontrolled overhead-work zones. What is the BEST response?',
  '[{"key":"A","text":"Continue because hard hats address the hazard"},{"key":"B","text":"Enforce work-zone and overhead-hazard controls in addition to required head protection"},{"key":"C","text":"Require heavier hard hats only"},{"key":"D","text":"Allow entry for experienced employees"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE does not replace exclusion zones, barricades, or other controls for overhead hazards.'
),
(
  7,
  'multiple_choice',
  'application',
  'A new cleaning chemical is introduced for HVAC service work. What should the senior technical lead do before broad use?',
  '[{"key":"A","text":"Issue the same gloves already used for every chemical"},{"key":"B","text":"Review the chemical hazard information and verify appropriate PPE, handling, training, and work practices"},{"key":"C","text":"Allow technicians to choose gloves by thickness"},{"key":"D","text":"Require double gloves regardless of material"}]'::jsonb,
  '["B"]'::jsonb,
  'Chemical PPE selection should be based on the actual hazard and compatible protective equipment.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician reports that required face protection fogs so badly that precise work cannot be performed safely. What is the BEST senior response?',
  '[{"key":"A","text":"Tell the technician to remove it when visibility is poor"},{"key":"B","text":"Evaluate suitable compliant alternatives or controls that preserve both required protection and safe visibility"},{"key":"C","text":"Ignore the complaint because PPE is required"},{"key":"D","text":"Have the technician work faster"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE should protect the worker without creating an unacceptable secondary hazard such as loss of safe visibility.'
),
(
  9,
  'multiple_choice',
  'application',
  'A supervisor wants to standardize one glove type for every HVAC task to simplify purchasing. What is the BEST technical response?',
  '[{"key":"A","text":"Approve it because standardization improves compliance"},{"key":"B","text":"Reject a one-size-fits-all hazard assumption and select glove types based on the actual hand hazards and tasks"},{"key":"C","text":"Choose the thickest glove available"},{"key":"D","text":"Use cotton gloves for all work"}]'::jsonb,
  '["B"]'::jsonb,
  'Hand protection should match the specific hazard; one glove type is not automatically appropriate for every task.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician reviews a recurring housekeeping problem that causes trips despite all employees wearing suitable safety footwear. What is the BEST response?',
  '[{"key":"A","text":"Require heavier footwear"},{"key":"B","text":"Correct the housekeeping and material-control problem while maintaining required footwear"},{"key":"C","text":"Leave the condition because PPE is being worn"},{"key":"D","text":"Require employees to walk more slowly"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE should not be used as a substitute for controlling the underlying work-site hazard.'
),
(
  11,
  'scenario',
  'scenario',
  'A near miss occurs when an oversized glove catches near rotating equipment. The employee is not injured, and several coworkers report having similar fit problems. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Tell the employee to be more careful"},{"key":"B","text":"Control the immediate hazard and investigate PPE fit, task suitability, inventory, and training across the affected crew"},{"key":"C","text":"Ban all gloves from every HVAC task"},{"key":"D","text":"Document the near miss but make no changes because no injury occurred"}]'::jsonb,
  '["B"]'::jsonb,
  'A recurring near miss involving PPE fit warrants both immediate correction and review of the broader selection and work-practice system.'
),
(
  12,
  'scenario',
  'scenario',
  'A branch audit finds cracked face shields, scratched safety glasses, and worn protective footwear still in active use. What is the BEST senior response?',
  '[{"key":"A","text":"Replace only the worst item"},{"key":"B","text":"Remove unreliable PPE from service and correct the inspection, replacement, storage, and accountability process"},{"key":"C","text":"Allow damaged PPE for low-risk work"},{"key":"D","text":"Require employees to purchase replacements themselves"}]'::jsonb,
  '["B"]'::jsonb,
  'Widespread defective PPE indicates both an equipment problem and a program-control weakness.'
),
(
  13,
  'scenario',
  'scenario',
  'A project manager pressures the HVAC crew to work inside an overhead-lift exclusion zone because shutdown time is limited. Everyone has hard hats. What is the BEST response?',
  '[{"key":"A","text":"Enter because the crew has head protection"},{"key":"B","text":"Do not allow entry until the lifting hazard and controlled area permit safe access"},{"key":"C","text":"Require two people to enter together"},{"key":"D","text":"Allow entry for no more than five minutes"}]'::jsonb,
  '["B"]'::jsonb,
  'Schedule pressure does not justify bypassing an established high-hazard work-zone control.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician modifies a face shield so it fits over another piece of PPE, but the modification weakens the mounting system. Several employees have copied the change. What is the BEST response?',
  '[{"key":"A","text":"Allow the modification because it improves comfort"},{"key":"B","text":"Stop using the modified equipment and provide a compatible, properly fitting approved configuration"},{"key":"C","text":"Use additional tape on the mounts"},{"key":"D","text":"Allow experienced technicians to decide individually"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE modifications that compromise protective performance should be replaced with a suitable compatible solution.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician develops recurring ringing in the ears after servicing a class of loud rooftop equipment. Other technicians report the same issue. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Tell technicians to spend less time near the equipment"},{"key":"B","text":"Evaluate the recurring noise exposure and implement the required engineering, administrative, hearing-protection, and training controls"},{"key":"C","text":"Issue thicker gloves"},{"key":"D","text":"Accept the condition because rooftop units are noisy"}]'::jsonb,
  '["B"]'::jsonb,
  'Repeated signs of excessive noise exposure should trigger evaluation and effective noise-control measures.'
),
(
  16,
  'scenario',
  'scenario',
  'A company acquires a service contractor whose technicians use different PPE rules at each branch. Some rules are based on habit rather than documented hazard evaluation. What is the BEST senior response?',
  '[{"key":"A","text":"Allow each branch to keep its existing practice"},{"key":"B","text":"Standardize hazard-based PPE requirements, fit expectations, training, inspection, and justified site-specific controls"},{"key":"C","text":"Select the strictest branch rule for every task without review"},{"key":"D","text":"Eliminate branch PPE requirements"}]'::jsonb,
  '["B"]'::jsonb,
  'A mature PPE program should be hazard-based and consistent in its core controls while allowing justified task or site differences.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician reports that a required respirator is being shared between employees without an established sanitation, fit, or use process. What is the BEST senior response?',
  '[{"key":"A","text":"Continue sharing if the respirator looks clean"},{"key":"B","text":"Stop the uncontrolled practice and address the applicable respiratory-protection, fit, sanitation, training, and program requirements before use continues"},{"key":"C","text":"Wipe it with a dry cloth between users"},{"key":"D","text":"Use the respirator only for short exposures"}]'::jsonb,
  '["B"]'::jsonb,
  'Respiratory protection requires controls beyond simple equipment availability and should not be treated as generic shared PPE.'
),
(
  18,
  'scenario',
  'scenario',
  'A serious cut occurs while handling sheet metal. Investigation shows the worker wore gloves, but the glove type was chosen only because it was inexpensive and had never been evaluated for the cut hazard. What is the BEST response?',
  '[{"key":"A","text":"Discipline the worker for getting injured"},{"key":"B","text":"Address the injury and reassess glove selection, hazard evaluation, purchasing criteria, and training for the task"},{"key":"C","text":"Require two pairs of the same gloves"},{"key":"D","text":"Stop using gloves for sheet-metal work"}]'::jsonb,
  '["B"]'::jsonb,
  'An injury involving unsuitable PPE should trigger review of the selection process and the controls supporting the task.'
),
(
  19,
  'scenario',
  'scenario',
  'A crew consistently wears required PPE, but technicians repeatedly step over open floor penetrations because barricades are moved for equipment access and not restored. What is the BEST senior response?',
  '[{"key":"A","text":"Require better footwear"},{"key":"B","text":"Correct the floor-opening control, access-planning, and barricade-restoration process while maintaining required PPE"},{"key":"C","text":"Allow the practice if technicians are experienced"},{"key":"D","text":"Add eye protection"}]'::jsonb,
  '["B"]'::jsonb,
  'PPE cannot compensate for an uncontrolled fall or floor-opening hazard created by poor work planning.'
),
(
  20,
  'scenario',
  'scenario',
  'A safety review shows employees know which PPE to wear, but several cannot correctly adjust, inspect, or explain the limitations of the equipment they use. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Keep assigning work because employees know the PPE names"},{"key":"B","text":"Provide or repeat effective training and verify employees can correctly use, adjust, inspect, and understand the limitations of the PPE before relying on it"},{"key":"C","text":"Post a PPE list and take no further action"},{"key":"D","text":"Have employees sign a form stating they understand"}]'::jsonb,
  '["B"]'::jsonb,
  'Effective PPE training includes the ability to use the equipment properly and understand its limitations, not merely recognize its name.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '2a4987eb-4ab6-4358-8b11-3fa4dde70043';
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
      and c.name = 'Personal Protective Equipment & Work-Site Safety'
      and c.is_current = true
  ) then
    raise exception 'Current Personal Protective Equipment & Work-Site Safety Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L1 PPE work-site safety requirement not found';
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
    raise exception 'Current HVAC Installer / Helper L2 PPE work-site safety requirement not found';
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
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Personal Protective Equipment & Work-Site Safety — Level 1 Competency Assessment';

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
    select * from _seed_hvac_ppe_work_site_safety_l1_questions
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
        'Personal Protective Equipment & Work-Site Safety',
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
      'IntegrateU Personal Protective Equipment & Work-Site Safety L1 production assessment v1.0.',
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
        'Personal Protective Equipment & Work-Site Safety',
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
        'IntegrateU Personal Protective Equipment & Work-Site Safety L1 production assessment v1.0.',
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
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'Personal Protective Equipment & Work-Site Safety — Level 2 Competency Assessment';

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
    select * from _seed_hvac_ppe_work_site_safety_l2_questions
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
        'Personal Protective Equipment & Work-Site Safety',
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
      'IntegrateU Personal Protective Equipment & Work-Site Safety L2 production assessment v1.0.',
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
        'Personal Protective Equipment & Work-Site Safety',
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
        'IntegrateU Personal Protective Equipment & Work-Site Safety L2 production assessment v1.0.',
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
  v_assessment_name := 'Personal Protective Equipment & Work-Site Safety — Level 3 Competency Assessment';

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
    select * from _seed_hvac_ppe_work_site_safety_l3_questions
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
        'Personal Protective Equipment & Work-Site Safety',
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
      'IntegrateU Personal Protective Equipment & Work-Site Safety L3 production assessment v1.0.',
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
        'Personal Protective Equipment & Work-Site Safety',
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
        'IntegrateU Personal Protective Equipment & Work-Site Safety L3 production assessment v1.0.',
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
  v_assessment_name := 'Personal Protective Equipment & Work-Site Safety — Level 4 Competency Assessment';

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
    select * from _seed_hvac_ppe_work_site_safety_l4_questions
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
        'Personal Protective Equipment & Work-Site Safety',
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
      'IntegrateU Personal Protective Equipment & Work-Site Safety L4 production assessment v1.0.',
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
        'Personal Protective Equipment & Work-Site Safety',
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
        'IntegrateU Personal Protective Equipment & Work-Site Safety L4 production assessment v1.0.',
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
   '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid
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
      '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid
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
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid)
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
  '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid;

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
    '2a4987eb-4ab6-4358-8b11-3fa4dde70043'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
