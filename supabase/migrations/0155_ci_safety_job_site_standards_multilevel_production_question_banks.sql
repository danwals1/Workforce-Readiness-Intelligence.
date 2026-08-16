-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0155_ci_safety_job_site_standards_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Safety & Job-Site Standards
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Sales Specialist                  -> Level 1
--   Technician I — Entry Level       -> Level 2
--   Technician II — Experienced      -> Level 3
--   Technician III — Lead Technician -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess safe work practices, job-site standards,
-- tool safety, cleanliness, hazard recognition, corrective action, and
-- progressively higher levels of safety leadership and operational judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_safety_job_site_standards_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_safety_job_site_standards_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of job-site safety standards?',
  '[{"key":"A","text":"To reduce risk of injury, property damage, and unsafe working conditions"},{"key":"B","text":"To make every task take longer"},{"key":"C","text":"To eliminate the need for supervision"},{"key":"D","text":"To apply only when a client is present"}]'::jsonb,
  '["A"]'::jsonb,
  'Job-site safety standards help protect people, property, equipment, and the work environment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should a worker do when they identify an unsafe condition on a job site?',
  '[{"key":"A","text":"Address or report it according to company and job-site procedures before continuing affected work"},{"key":"B","text":"Ignore it unless someone gets hurt"},{"key":"C","text":"Wait until the project is complete"},{"key":"D","text":"Assume another trade will handle it"}]'::jsonb,
  '["A"]'::jsonb,
  'Unsafe conditions should be recognized, communicated, and resolved before they create additional risk.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is proper tool use part of job-site safety?',
  '[{"key":"A","text":"Using tools correctly reduces the chance of injury, equipment damage, and poor workmanship"},{"key":"B","text":"Tool safety matters only for power tools"},{"key":"C","text":"Experienced workers do not need tool-safety practices"},{"key":"D","text":"Tool safety applies only in a warehouse"}]'::jsonb,
  '["A"]'::jsonb,
  'Tools should be used for their intended purpose and according to safe operating practices.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should walkways and work areas be kept clear?',
  '[{"key":"A","text":"To reduce trip hazards and maintain safe access through the job site"},{"key":"B","text":"Only to improve photographs"},{"key":"C","text":"Because tools may never be placed on a job site"},{"key":"D","text":"Only when the client requests it"}]'::jsonb,
  '["A"]'::jsonb,
  'Housekeeping is a basic safety practice because clutter can create trip, access, and damage hazards.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is personal protective equipment intended to do?',
  '[{"key":"A","text":"Reduce exposure to specific hazards when required for the task or environment"},{"key":"B","text":"Replace safe work practices"},{"key":"C","text":"Guarantee that an accident cannot happen"},{"key":"D","text":"Apply only to construction managers"}]'::jsonb,
  '["A"]'::jsonb,
  'PPE is one part of hazard control and should be used when required for the work being performed.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is a job-site hazard?',
  '[{"key":"A","text":"A condition or activity with the potential to cause injury, damage, or other harm"},{"key":"B","text":"Any task that takes longer than planned"},{"key":"C","text":"Only a condition that has already caused an accident"},{"key":"D","text":"Any client change request"}]'::jsonb,
  '["A"]'::jsonb,
  'A hazard is a source or condition that can create harm even if an incident has not yet occurred.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why should finished surfaces be protected while work is being performed?',
  '[{"key":"A","text":"To prevent avoidable damage and maintain a safe, professional work environment"},{"key":"B","text":"Protection is needed only after installation is complete"},{"key":"C","text":"Finished surfaces are always the responsibility of another trade"},{"key":"D","text":"Surface protection has no relationship to job-site standards"}]'::jsonb,
  '["A"]'::jsonb,
  'Protecting the work environment reduces damage and supports professional job-site practices.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Who is responsible for following established safety expectations on a job site?',
  '[{"key":"A","text":"Everyone performing or supporting work on the site"},{"key":"B","text":"Only the project manager"},{"key":"C","text":"Only the most senior technician"},{"key":"D","text":"Only the general contractor"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety is a shared responsibility, and each person must follow applicable rules and procedures.'
),
(
  9,
  'multiple_choice',
  'application',
  'You enter a work area and find extension cords stretched across a main walking path. What is the BEST response?',
  '[{"key":"A","text":"Route, secure, or otherwise address the cords so the trip hazard is removed before continuing work"},{"key":"B","text":"Step over them and leave them for the next crew"},{"key":"C","text":"Place more tools around them so people notice them"},{"key":"D","text":"Ignore them because they belong to another worker"}]'::jsonb,
  '["A"]'::jsonb,
  'Trip hazards should be corrected or properly controlled rather than simply worked around.'
),
(
  10,
  'multiple_choice',
  'application',
  'A worker notices that a power tool has a damaged cord before use. What should happen?',
  '[{"key":"A","text":"Remove the tool from use and follow the appropriate reporting or replacement process"},{"key":"B","text":"Use it carefully for one more task"},{"key":"C","text":"Cover the damage temporarily and continue"},{"key":"D","text":"Use it only when nobody else is nearby"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged tools should not be used when their condition creates a safety risk.'
),
(
  11,
  'multiple_choice',
  'application',
  'Materials and boxes are beginning to block access to an electrical panel. What is the BEST action?',
  '[{"key":"A","text":"Relocate the materials so required access remains clear"},{"key":"B","text":"Leave them because they will be used later"},{"key":"C","text":"Stack additional materials in front of the panel"},{"key":"D","text":"Wait until project closeout to move them"}]'::jsonb,
  '["A"]'::jsonb,
  'Required access areas should remain clear rather than being used for temporary storage.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is about to drill into a wall but is unsure what may be behind the drilling location. What should happen first?',
  '[{"key":"A","text":"Stop and verify the drilling area and applicable site information before proceeding"},{"key":"B","text":"Drill slowly and see what happens"},{"key":"C","text":"Assume the wall cavity is empty"},{"key":"D","text":"Use a larger drill bit so the task finishes faster"}]'::jsonb,
  '["A"]'::jsonb,
  'Uncertainty about concealed conditions should be resolved before performing work that could create injury or damage.'
),
(
  13,
  'multiple_choice',
  'application',
  'A work area has scraps, packaging, and loose hardware accumulating on the floor. What should the worker do?',
  '[{"key":"A","text":"Clean and organize the area as work progresses"},{"key":"B","text":"Leave everything until the end of the week"},{"key":"C","text":"Push the debris into a hallway"},{"key":"D","text":"Assume the client will clean it"}]'::jsonb,
  '["A"]'::jsonb,
  'Routine housekeeping reduces hazards and protects the work area.'
),
(
  14,
  'multiple_choice',
  'application',
  'A task requires safety equipment that is not currently available. What is the BEST action?',
  '[{"key":"A","text":"Do not perform the task until the required protection or an approved safe alternative is available"},{"key":"B","text":"Perform the task quickly without it"},{"key":"C","text":"Ask someone else to take the same risk"},{"key":"D","text":"Skip only the final safety check"}]'::jsonb,
  '["A"]'::jsonb,
  'Required safety controls should be in place before the task begins.'
),
(
  15,
  'multiple_choice',
  'application',
  'A ladder is positioned on an unstable surface. What should happen before it is used?',
  '[{"key":"A","text":"Reposition or stabilize it according to safe ladder-use practices"},{"key":"B","text":"Have another person hold it while the user works normally"},{"key":"C","text":"Use it only for a short task"},{"key":"D","text":"Climb slowly and avoid looking down"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should be positioned and used safely before work begins.'
),
(
  16,
  'multiple_choice',
  'application',
  'A salesperson or project team member notices a site condition that could create a safety concern for the installation crew. What should they do?',
  '[{"key":"A","text":"Document and communicate the concern through the appropriate project process before field work is affected"},{"key":"B","text":"Ignore it because only technicians are responsible for safety"},{"key":"C","text":"Wait for the crew to discover it themselves"},{"key":"D","text":"Remove the concern from the project notes"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety information should be communicated across roles so field teams can plan and work appropriately.'
),
(
  17,
  'scenario',
  'scenario',
  'You arrive at a job site and notice water on the floor near powered equipment and extension cords. What is the BEST response?',
  '[{"key":"A","text":"Keep people away from the affected area, stop unsafe activity, and have the hazard addressed through the proper site process"},{"key":"B","text":"Walk around the water and begin work"},{"key":"C","text":"Move the cords by hand while everything remains energized"},{"key":"D","text":"Place a cardboard box over the water"}]'::jsonb,
  '["A"]'::jsonb,
  'A condition involving water and energized equipment should be treated as a hazard and controlled before work continues.'
),
(
  18,
  'scenario',
  'scenario',
  'A worker is under schedule pressure and says they can save time by using a damaged ladder for one quick task. What is the BEST response?',
  '[{"key":"A","text":"Do not use the damaged ladder; obtain safe equipment before performing the task"},{"key":"B","text":"Use it because the task will take only a minute"},{"key":"C","text":"Use it only if another worker watches"},{"key":"D","text":"Use it as long as the client is not present"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule pressure does not justify using unsafe equipment.'
),
(
  19,
  'scenario',
  'scenario',
  'During a client walkthrough, you notice an open equipment box and loose tools creating a trip hazard in the path ahead. What should you do?',
  '[{"key":"A","text":"Stop and clear or secure the hazard before continuing the walkthrough"},{"key":"B","text":"Guide the client around it and leave it in place"},{"key":"C","text":"Assume everyone will see the hazard"},{"key":"D","text":"Finish the walkthrough and address it later"}]'::jsonb,
  '["A"]'::jsonb,
  'Known hazards should be corrected promptly rather than knowingly exposing others to them.'
),
(
  20,
  'scenario',
  'scenario',
  'A team member is asked to perform a task they do not know how to complete safely. What is the BEST response?',
  '[{"key":"A","text":"Stop and get appropriate instruction, supervision, or clarification before performing the task"},{"key":"B","text":"Try the task and learn through trial and error"},{"key":"C","text":"Copy another worker without asking questions"},{"key":"D","text":"Perform only the most dangerous part first"}]'::jsonb,
  '["A"]'::jsonb,
  'Workers should not proceed with work when they do not understand how to perform it safely.'
);

create temporary table _seed_ci_safety_job_site_standards_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_safety_job_site_standards_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should a worker perform a basic hazard check before starting a task?',
  '[{"key":"A","text":"To identify conditions that may require controls, clarification, or a change in how the work is performed"},{"key":"B","text":"To replace all project planning"},{"key":"C","text":"To delay the start of work"},{"key":"D","text":"To document only completed tasks"}]'::jsonb,
  '["A"]'::jsonb,
  'A pre-task hazard check helps workers identify and control foreseeable risks before beginning work.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does it mean to control a hazard?',
  '[{"key":"A","text":"Take appropriate action to eliminate or reduce the risk before exposure continues"},{"key":"B","text":"Write down the hazard and continue working"},{"key":"C","text":"Move the hazard where fewer people can see it"},{"key":"D","text":"Wait until an incident occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'Hazard control means reducing or removing the risk rather than merely recognizing it.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why are manufacturer instructions and approved procedures important when using tools or equipment?',
  '[{"key":"A","text":"They define intended use, limitations, and safe operating practices"},{"key":"B","text":"They matter only when equipment is new"},{"key":"C","text":"Experienced workers may ignore them"},{"key":"D","text":"They are only for warranty claims"}]'::jsonb,
  '["A"]'::jsonb,
  'Safe tool and equipment use depends on understanding intended operation and limitations.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should safety concerns be communicated clearly during project handoff?',
  '[{"key":"A","text":"So the team can plan for known hazards, site rules, access restrictions, and required controls"},{"key":"B","text":"Only to make the handoff longer"},{"key":"C","text":"Because safety is handled only before the project starts"},{"key":"D","text":"To replace field judgment"}]'::jsonb,
  '["A"]'::jsonb,
  'Known safety information should travel with the project so downstream teams can prepare appropriately.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of maintaining job-site housekeeping throughout the day?',
  '[{"key":"A","text":"To reduce hazards, protect property, maintain access, and support professional work practices"},{"key":"B","text":"Only to make the site look better in photos"},{"key":"C","text":"To avoid using storage areas"},{"key":"D","text":"Only to prepare for final inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Ongoing housekeeping helps prevent trips, damage, blocked access, and unsafe working conditions.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician is preparing to work above a ceiling and finds the access area cluttered with materials from multiple trades. What is the BEST first action?',
  '[{"key":"A","text":"Clear or coordinate safe access before beginning overhead work"},{"key":"B","text":"Climb over the materials"},{"key":"C","text":"Move only the items belonging to the technician"},{"key":"D","text":"Begin work and address access later"}]'::jsonb,
  '["A"]'::jsonb,
  'Safe access should be established before work begins.'
),
(
  7,
  'multiple_choice',
  'application',
  'A worker is using a cutting tool and the required guard has been removed. What should happen?',
  '[{"key":"A","text":"Stop using the tool until it is restored to a safe, approved condition"},{"key":"B","text":"Use it carefully without the guard"},{"key":"C","text":"Use it only for short cuts"},{"key":"D","text":"Have another person watch while it is used"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety devices should not be bypassed or removed when required for proper tool operation.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician notices another worker repeatedly leaving tools and cable scraps in a hallway. What is the BEST response?',
  '[{"key":"A","text":"Address the condition and reinforce the expectation to keep the access path clear"},{"key":"B","text":"Ignore it because the materials belong to someone else"},{"key":"C","text":"Move the debris to another hallway"},{"key":"D","text":"Wait until someone trips"}]'::jsonb,
  '["A"]'::jsonb,
  'Unsafe housekeeping should be corrected and expectations reinforced before an incident occurs.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project has a site-specific rule requiring eye protection in an active work area. A worker says the current task does not create much debris. What is the BEST action?',
  '[{"key":"A","text":"Follow the site requirement and use the required protection"},{"key":"B","text":"Ignore the rule for low-risk tasks"},{"key":"C","text":"Follow the rule only when a supervisor is present"},{"key":"D","text":"Use protection only if debris becomes visible"}]'::jsonb,
  '["A"]'::jsonb,
  'Site-specific safety requirements apply even when an individual worker believes the immediate task is low risk.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician finds an unlabeled circuit condition that creates uncertainty about whether nearby equipment is energized. What is the BEST action?',
  '[{"key":"A","text":"Stop affected work and verify the electrical condition through the appropriate safe process before proceeding"},{"key":"B","text":"Assume the circuit is off"},{"key":"C","text":"Touch the equipment to see if it is energized"},{"key":"D","text":"Proceed if the schedule is behind"}]'::jsonb,
  '["A"]'::jsonb,
  'Uncertainty about energized conditions should be resolved before exposure to the hazard.'
),
(
  11,
  'multiple_choice',
  'application',
  'A warehouse associate finds a heavy item stored high on an unstable stack. What is the BEST action?',
  '[{"key":"A","text":"Restack or relocate the item using an appropriate safe handling method"},{"key":"B","text":"Leave it until someone needs it"},{"key":"C","text":"Add more weight to stabilize the stack"},{"key":"D","text":"Place a warning note on it and do nothing else"}]'::jsonb,
  '["A"]'::jsonb,
  'Unsafe material storage should be corrected before it creates a falling-object or handling hazard.'
),
(
  12,
  'multiple_choice',
  'application',
  'A salesperson learns during a site visit that installation access will require work near an active construction zone. What should they do?',
  '[{"key":"A","text":"Capture and communicate the condition so field planning can account for site rules, access, and hazards"},{"key":"B","text":"Leave it out because it is not part of the sales role"},{"key":"C","text":"Tell the technician only after arrival"},{"key":"D","text":"Assume the general contractor will handle everything"}]'::jsonb,
  '["A"]'::jsonb,
  'Upstream project roles should communicate known site conditions that affect safe execution.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician needs to lift a bulky piece of equipment that is difficult to control alone. What is the BEST action?',
  '[{"key":"A","text":"Use appropriate assistance, equipment, or a safer handling method before lifting"},{"key":"B","text":"Lift it quickly before fatigue sets in"},{"key":"C","text":"Drag it across the finished floor"},{"key":"D","text":"Attempt the lift once and ask for help only after losing control"}]'::jsonb,
  '["A"]'::jsonb,
  'Workers should choose a handling method appropriate to the size, weight, and control demands of the load.'
),
(
  14,
  'multiple_choice',
  'application',
  'A worker completes drilling and leaves sharp debris and fasteners on the floor around the work area. What should happen before moving on?',
  '[{"key":"A","text":"Clean the area and remove the debris so it does not create a hazard or damage risk"},{"key":"B","text":"Leave it for the final cleanup crew"},{"key":"C","text":"Sweep it under nearby equipment"},{"key":"D","text":"Mark the task complete because drilling is finished"}]'::jsonb,
  '["A"]'::jsonb,
  'Task completion includes leaving the immediate work area in a safe condition.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician arrives at a site where the planned ladder location is directly in front of a frequently used doorway. What is the BEST response?',
  '[{"key":"A","text":"Reconfigure the work area or coordinate access so the ladder can be used without creating an uncontrolled traffic hazard"},{"key":"B","text":"Set up the ladder and ask people to squeeze around it"},{"key":"C","text":"Use the doorway only when no one appears nearby"},{"key":"D","text":"Block the doorway without telling anyone"}]'::jsonb,
  '["A"]'::jsonb,
  'Work positioning should account for surrounding traffic and access conditions before the task begins.'
),
(
  16,
  'scenario',
  'scenario',
  'A crew is running behind schedule and a technician proposes bypassing the normal pre-task safety check for the next room because it looks identical to the previous one. What is the BEST response?',
  '[{"key":"A","text":"Perform the required check because conditions can vary and schedule pressure does not remove safety expectations"},{"key":"B","text":"Skip it because the rooms look similar"},{"key":"C","text":"Skip it only if the lead technician agrees"},{"key":"D","text":"Perform the check after the work is complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Required safety checks should not be skipped simply because conditions appear familiar.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician sees a coworker using a ladder incorrectly but no incident has occurred. What is the BEST action?',
  '[{"key":"A","text":"Intervene appropriately and reinforce correct ladder-use expectations before the unsafe behavior continues"},{"key":"B","text":"Say nothing because no one has been injured"},{"key":"C","text":"Wait until the next team meeting"},{"key":"D","text":"Take a picture but allow the work to continue"}]'::jsonb,
  '["A"]'::jsonb,
  'Unsafe behavior should be addressed before it results in an incident.'
),
(
  18,
  'scenario',
  'scenario',
  'A site supervisor tells the integration crew that a work area is temporarily restricted because another trade is performing hazardous work nearby. A technician believes they can finish quickly before anyone notices. What is the BEST response?',
  '[{"key":"A","text":"Respect the restriction and wait until the area is released or an approved safe plan is established"},{"key":"B","text":"Enter because the task is short"},{"key":"C","text":"Enter if two technicians go together"},{"key":"D","text":"Enter only to stage tools"}]'::jsonb,
  '["A"]'::jsonb,
  'Site access restrictions should be followed when they exist to control hazards.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician discovers that the only available power tool for a task is damaged, but replacement will delay the job. What is the BEST response?',
  '[{"key":"A","text":"Remove the damaged tool from service and obtain a safe alternative before continuing the task"},{"key":"B","text":"Use it carefully to avoid the delay"},{"key":"C","text":"Use it only for the easiest part of the task"},{"key":"D","text":"Have another technician accept responsibility for using it"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule impact does not justify knowingly using unsafe equipment.'
),
(
  20,
  'scenario',
  'scenario',
  'A crew finishes work in a room but leaves packaging, scrap cable, tools, and an unsecured ladder behind because they plan to return the next morning. What is the BEST response?',
  '[{"key":"A","text":"Secure tools and equipment and leave the area clean and safe before departing"},{"key":"B","text":"Leave everything in place because the crew is returning"},{"key":"C","text":"Move only the ladder"},{"key":"D","text":"Ask the client not to enter the room"}]'::jsonb,
  '["A"]'::jsonb,
  'End-of-day conditions should not leave avoidable hazards for occupants, other trades, or the returning crew.'
);

create temporary table _seed_ci_safety_job_site_standards_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_safety_job_site_standards_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of a job hazard analysis or structured pre-task safety review?',
  '[{"key":"A","text":"To identify task-specific hazards, determine controls, and communicate how the work will be performed safely"},{"key":"B","text":"To replace project scheduling"},{"key":"C","text":"To document only incidents that already occurred"},{"key":"D","text":"To assign blame before work begins"}]'::jsonb,
  '["A"]'::jsonb,
  'A structured pre-task review helps teams identify foreseeable hazards and establish controls before exposure.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should near misses be reviewed even when no injury or damage occurred?',
  '[{"key":"A","text":"They can reveal hazards, behaviors, or process weaknesses before a more serious incident occurs"},{"key":"B","text":"They should not be reviewed unless someone is injured"},{"key":"C","text":"They only matter for insurance reporting"},{"key":"D","text":"They prove the existing process is working perfectly"}]'::jsonb,
  '["A"]'::jsonb,
  'Near misses provide useful evidence about risk that may otherwise remain hidden until an incident occurs.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of reinforcing safety expectations with less-experienced team members?',
  '[{"key":"A","text":"To build consistent safe habits, clarify standards, and reduce variation in how work is performed"},{"key":"B","text":"To eliminate the need for supervision immediately"},{"key":"C","text":"To make every technician use identical tools"},{"key":"D","text":"To avoid discussing job-site hazards"}]'::jsonb,
  '["A"]'::jsonb,
  'Experienced workers help reinforce safe practices and expectations through coaching, observation, and correction.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should changing site conditions trigger a new safety evaluation?',
  '[{"key":"A","text":"Because new trades, access conditions, equipment, weather, or work activities may create hazards that were not present earlier"},{"key":"B","text":"Because the original safety plan automatically becomes invalid every hour"},{"key":"C","text":"Only because documentation requires more pages"},{"key":"D","text":"Changing conditions never affect risk"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety planning should respond to meaningful changes in the work environment.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician notices that a new trade has begun overhead work directly above the integration crew. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate the work area, coordinate with the site team, and establish appropriate controls before continuing below"},{"key":"B","text":"Continue because the original plan was already approved"},{"key":"C","text":"Work faster to finish before debris falls"},{"key":"D","text":"Ignore the other trade unless something drops"}]'::jsonb,
  '["A"]'::jsonb,
  'New overhead activity changes the hazard profile and should trigger coordination and reassessment.'
),
(
  6,
  'multiple_choice',
  'application',
  'A lead technician sees a newer technician repeatedly using poor lifting technique with heavy equipment. What is the BEST response?',
  '[{"key":"A","text":"Stop the unsafe practice, coach the technician on an appropriate handling method, and verify the corrected behavior"},{"key":"B","text":"Wait until the technician reports pain"},{"key":"C","text":"Move the equipment for them without explanation"},{"key":"D","text":"Ignore it because no incident has occurred"}]'::jsonb,
  '["A"]'::jsonb,
  'Experienced personnel should correct unsafe behaviors before they become normalized or result in injury.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project manager learns that a scheduled installation will now occur while other trades are occupying the same tight work area. What should happen?',
  '[{"key":"A","text":"Coordinate access, sequencing, and safety expectations before the crews begin competing for the same space"},{"key":"B","text":"Send the crew as planned and let them work it out on site"},{"key":"C","text":"Tell technicians to work around the other trades"},{"key":"D","text":"Ignore the change because the scope is unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared work areas can introduce congestion, access, and interaction hazards that require coordination.'
),
(
  8,
  'multiple_choice',
  'application',
  'A service technician arrives at a client site and finds that equipment access requires entering an area with an unfamiliar hazard warning. What is the BEST action?',
  '[{"key":"A","text":"Stop and obtain clarification about the hazard and access requirements before entering the area"},{"key":"B","text":"Enter quickly to avoid delaying the service call"},{"key":"C","text":"Ignore the warning because the original installer worked there"},{"key":"D","text":"Ask the client to enter first"}]'::jsonb,
  '["A"]'::jsonb,
  'Unknown hazard information should be clarified before exposure.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician reports that a required safety control is difficult to use and crews have started bypassing it. What is the BEST response?',
  '[{"key":"A","text":"Stop the bypass practice, investigate why the control is failing in practice, and establish an effective approved solution"},{"key":"B","text":"Allow the bypass if experienced technicians agree"},{"key":"C","text":"Remove the requirement without review"},{"key":"D","text":"Ignore it until an incident occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'A control that is routinely bypassed should trigger both immediate correction and evaluation of the underlying process.'
),
(
  10,
  'multiple_choice',
  'application',
  'A warehouse associate reports repeated strain while moving the same type of heavy equipment. What is the BEST next step for an experienced team member or supervisor?',
  '[{"key":"A","text":"Evaluate the handling process and introduce appropriate assistance, equipment, or workflow changes to reduce the risk"},{"key":"B","text":"Tell the associate to work faster"},{"key":"C","text":"Rotate workers without changing the process"},{"key":"D","text":"Ignore the issue because no injury has been reported"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated strain signals that the handling method should be reviewed rather than treated as normal.'
),
(
  11,
  'multiple_choice',
  'application',
  'A lead technician notices that crews interpret the same job-site cleanup expectation differently. What is the BEST response?',
  '[{"key":"A","text":"Clarify the standard, demonstrate the expected condition, and verify that crews apply it consistently"},{"key":"B","text":"Let each crew define its own standard"},{"key":"C","text":"Remove cleanup from safety expectations"},{"key":"D","text":"Wait for client complaints"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear and consistently reinforced expectations reduce variation in job-site safety practices.'
),
(
  12,
  'scenario',
  'scenario',
  'A technician reports a near miss in which a falling object narrowly missed a coworker. No one was injured. What is the BEST response?',
  '[{"key":"A","text":"Secure the immediate hazard, document and review the near miss, identify contributing causes, and implement corrective actions before similar work continues"},{"key":"B","text":"Take no action because there was no injury"},{"key":"C","text":"Tell the technician to be more careful next time"},{"key":"D","text":"Wait to see whether the event happens again"}]'::jsonb,
  '["A"]'::jsonb,
  'A near miss involving a potentially serious hazard should trigger corrective action before recurrence.'
),
(
  13,
  'scenario',
  'scenario',
  'A crew begins work under a plan created earlier in the week, but the site now has temporary barriers, new equipment, and restricted access routes. What is the BEST response?',
  '[{"key":"A","text":"Pause and reassess the changed conditions, update the work approach and controls, and communicate the revised plan to the crew"},{"key":"B","text":"Follow the old plan exactly because it was already documented"},{"key":"C","text":"Remove the barriers without permission"},{"key":"D","text":"Let each technician choose a route independently"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety planning should be updated when site conditions materially change.'
),
(
  14,
  'scenario',
  'scenario',
  'An experienced technician sees a coworker repeatedly defeat a tool safety feature because it makes the task faster. What is the BEST response?',
  '[{"key":"A","text":"Stop the unsafe practice, address the behavior directly, restore proper tool use, and escalate or coach as required by company process"},{"key":"B","text":"Ignore it because the coworker is experienced"},{"key":"C","text":"Use the same shortcut to maintain productivity"},{"key":"D","text":"Mention it only after the project is complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Experienced workers have a responsibility to reinforce standards rather than normalize unsafe shortcuts.'
),
(
  15,
  'scenario',
  'scenario',
  'A project manager is pressured to keep a crew working in an area after the general contractor announces a temporary safety shutdown. What is the BEST response?',
  '[{"key":"A","text":"Honor the shutdown, coordinate with site leadership, and resume only when the area is officially released for safe work"},{"key":"B","text":"Keep the crew working quietly"},{"key":"C","text":"Allow only senior technicians to continue"},{"key":"D","text":"Continue if the task is nearly finished"}]'::jsonb,
  '["A"]'::jsonb,
  'Production pressure does not override site safety restrictions or shutdowns.'
),
(
  16,
  'scenario',
  'scenario',
  'A service team repeatedly encounters unsafe equipment access created during installation, such as blocked service paths and unstable reaching positions. What is the BEST response?',
  '[{"key":"A","text":"Address the immediate access issue and communicate the recurring design or installation pattern so future projects can eliminate the hazard upstream"},{"key":"B","text":"Treat every service visit as an unrelated problem"},{"key":"C","text":"Accept awkward access as normal"},{"key":"D","text":"Tell technicians to bring taller ladders"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring service-access hazards should feed back into design, installation, and project standards.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is assigned a task involving equipment they have never used before, and the schedule allows little time for training. What is the BEST response from the lead?',
  '[{"key":"A","text":"Provide appropriate instruction or qualified supervision and do not allow unsupported use until the technician can perform the task safely"},{"key":"B","text":"Have the technician learn by trial and error"},{"key":"C","text":"Give only a quick verbal warning and leave"},{"key":"D","text":"Assign the task because the schedule is more important"}]'::jsonb,
  '["A"]'::jsonb,
  'Competency and supervision should match the risks of the task being assigned.'
),
(
  18,
  'scenario',
  'scenario',
  'A team has experienced several minor incidents involving poor housekeeping, but each event has been treated separately. What is the BEST next step?',
  '[{"key":"A","text":"Review the incident pattern, identify common causes, reinforce the housekeeping standard, and verify whether corrective actions reduce recurrence"},{"key":"B","text":"Continue handling each event independently"},{"key":"C","text":"Stop documenting minor incidents"},{"key":"D","text":"Reduce cleanup expectations to match current behavior"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated minor incidents may reveal a broader behavioral or process issue requiring systemic correction.'
),
(
  19,
  'scenario',
  'scenario',
  'A crew identifies a hazard that cannot be eliminated immediately, but the task is considered urgent. What is the BEST response?',
  '[{"key":"A","text":"Establish an approved method that adequately controls the risk before work proceeds, or delay the task until that can be done"},{"key":"B","text":"Proceed because the task is urgent"},{"key":"C","text":"Assign the work to the most experienced technician without additional controls"},{"key":"D","text":"Ask the client to accept the risk"}]'::jsonb,
  '["A"]'::jsonb,
  'Urgency does not remove the requirement to control hazards before exposure.'
),
(
  20,
  'scenario',
  'scenario',
  'A project team follows documented safety procedures, yet the same unsafe condition keeps appearing on multiple jobs. What is the BEST response?',
  '[{"key":"A","text":"Investigate why the procedure is not preventing the condition, identify the underlying process or behavior gap, improve the control, and verify the result"},{"key":"B","text":"Keep the procedure unchanged because it is documented"},{"key":"C","text":"Stop tracking the repeated condition"},{"key":"D","text":"Assume workers simply need to be more careful"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring hazards despite documented procedures indicate that the control system itself should be evaluated for effectiveness.'
);

create temporary table _seed_ci_safety_job_site_standards_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_safety_job_site_standards_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an organization-wide safety management system?',
  '[{"key":"A","text":"To define responsibilities, standards, controls, reporting, corrective action, training, and continuous improvement so safe practices are repeatable"},{"key":"B","text":"To make safety the responsibility of one manager"},{"key":"C","text":"To document incidents without preventing them"},{"key":"D","text":"To eliminate field-level judgment"}]'::jsonb,
  '["A"]'::jsonb,
  'A safety management system creates repeatable expectations and controls across teams, projects, and departments.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are leading safety indicators valuable to operations leadership?',
  '[{"key":"A","text":"They can reveal risk conditions and weak controls before injuries or serious incidents occur"},{"key":"B","text":"They measure only workers compensation cost"},{"key":"C","text":"They eliminate the need to review incidents"},{"key":"D","text":"They are useful only after project closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Leading indicators provide early evidence that preventive action may be needed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest purpose of root-cause corrective action after a safety incident or repeated hazard?',
  '[{"key":"A","text":"To address the underlying conditions that allowed the risk to occur or recur"},{"key":"B","text":"To identify one person to blame"},{"key":"C","text":"To close the incident record quickly"},{"key":"D","text":"To reduce the amount of safety documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective corrective action addresses systemic causes rather than only the immediate symptom.'
),
(
  4,
  'multiple_choice',
  'application',
  'An operations manager sees an increase in near misses across several projects. What is the BEST first response?',
  '[{"key":"A","text":"Trend the events by task, location, hazard type, crew, and contributing conditions before selecting corrective actions"},{"key":"B","text":"Stop tracking near misses because no injuries occurred"},{"key":"C","text":"Assume workers simply need to be more careful"},{"key":"D","text":"Wait until a recordable injury occurs"}]'::jsonb,
  '["A"]'::jsonb,
  'Pattern analysis helps leadership understand where risk is recurring and what controls may be failing.'
),
(
  5,
  'multiple_choice',
  'application',
  'Leadership wants to reduce recurring job-site housekeeping hazards. Which approach is MOST effective?',
  '[{"key":"A","text":"Define the expected condition, assign ownership, inspect at appropriate checkpoints, coach deviations, and measure recurrence"},{"key":"B","text":"Send one reminder email"},{"key":"C","text":"Clean only before client walkthroughs"},{"key":"D","text":"Make housekeeping optional on busy projects"}]'::jsonb,
  '["A"]'::jsonb,
  'Sustained improvement requires clear standards, ownership, verification, and follow-up.'
),
(
  6,
  'multiple_choice',
  'application',
  'A lead technician reports that different crews interpret ladder-safety expectations differently. What is the BEST leadership response?',
  '[{"key":"A","text":"Clarify the standard, train and demonstrate correct practice, and verify consistent application across crews"},{"key":"B","text":"Allow each crew to decide what is safe"},{"key":"C","text":"Remove ladder guidance from company standards"},{"key":"D","text":"Inspect only crews with less experience"}]'::jsonb,
  '["A"]'::jsonb,
  'Safety expectations should be clearly understood and applied consistently.'
),
(
  7,
  'multiple_choice',
  'application',
  'A company has documented safety procedures but repeated incidents still involve the same task. What should leadership review?',
  '[{"key":"A","text":"Whether the procedure addresses the actual hazard, is understood, is practical, and is consistently followed and verified"},{"key":"B","text":"Only whether the procedure exists in writing"},{"key":"C","text":"Only employee attendance records"},{"key":"D","text":"Whether incident reporting can be reduced"}]'::jsonb,
  '["A"]'::jsonb,
  'A documented procedure is effective only when it controls the real risk and is executed correctly.'
),
(
  8,
  'multiple_choice',
  'application',
  'A manager wants to know whether a new safety intervention is working. What should be measured?',
  '[{"key":"A","text":"Whether the targeted unsafe condition, near miss, incident, or exposure rate decreases after implementation"},{"key":"B","text":"Only how many meetings discussed the intervention"},{"key":"C","text":"Only how many copies of the procedure were distributed"},{"key":"D","text":"Only whether employees signed an acknowledgement"}]'::jsonb,
  '["A"]'::jsonb,
  'Corrective actions should be evaluated by measurable improvement in the risk they were intended to reduce.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project manager is under schedule pressure and asks a crew to skip a required safety control. What is the BEST leadership response?',
  '[{"key":"A","text":"Address the schedule issue without bypassing the established safety requirement; any change must follow an approved safe process"},{"key":"B","text":"Skip the control whenever the project is behind"},{"key":"C","text":"Document the control as complete without performing it"},{"key":"D","text":"Allow only senior technicians to skip it"}]'::jsonb,
  '["A"]'::jsonb,
  'Schedule pressure does not justify removing required safety controls.'
),
(
  10,
  'multiple_choice',
  'application',
  'A company sees recurring safety issues caused by poor coordination between sales, project management, warehouse, and field teams. What should leadership do?',
  '[{"key":"A","text":"Define where safety-critical information must be captured, handed off, owned, and verified across the workflow"},{"key":"B","text":"Make technicians responsible for discovering every issue on site"},{"key":"C","text":"Remove safety information from sales and project documentation"},{"key":"D","text":"Wait until service identifies the problems"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-functional risks require clear information flow and ownership throughout the project lifecycle.'
),
(
  11,
  'scenario',
  'scenario',
  'Multiple crews have experienced near misses involving falling objects during overhead work. What is the BEST organization-level response?',
  '[{"key":"A","text":"Contain the immediate risk, analyze the common causes, improve overhead-work controls and training, and measure whether near misses decline"},{"key":"B","text":"Remind workers to watch where they stand"},{"key":"C","text":"Treat each near miss as unrelated"},{"key":"D","text":"Stop recording near misses"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated near misses involving the same hazard require systemic corrective action.'
),
(
  12,
  'scenario',
  'scenario',
  'Projects repeatedly lose time because crews discover hazardous access conditions only after arriving on site. What is the BEST systemic improvement?',
  '[{"key":"A","text":"Build safety and access discovery into site assessment, project handoff, and pre-install planning so risks are identified earlier"},{"key":"B","text":"Tell crews to carry more tools"},{"key":"C","text":"Add extra labor to every project"},{"key":"D","text":"Accept the delays as normal"}]'::jsonb,
  '["A"]'::jsonb,
  'Upstream identification of site hazards reduces last-minute exposure and execution disruption.'
),
(
  13,
  'scenario',
  'scenario',
  'One crew consistently finishes faster than others but has significantly more safety violations and near misses. What is the BEST leadership interpretation?',
  '[{"key":"A","text":"Speed is not effective performance when it is achieved by increasing risk or bypassing required safety practices"},{"key":"B","text":"The crew is the most productive because it finishes first"},{"key":"C","text":"Safety should be evaluated separately from performance"},{"key":"D","text":"Near misses should be ignored because no one was injured"}]'::jsonb,
  '["A"]'::jsonb,
  'Operational performance must account for both productivity and safe execution.'
),
(
  14,
  'scenario',
  'scenario',
  'A safety audit finds that project managers apply different standards for when work must stop because of an unsafe condition. What is the BEST corrective action?',
  '[{"key":"A","text":"Establish clear company-level stop-work expectations, decision criteria, escalation paths, and training for consistent application"},{"key":"B","text":"Allow each manager to use personal judgment without shared criteria"},{"key":"C","text":"Remove stop-work authority from project teams"},{"key":"D","text":"Require work to stop only after an injury"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent stop-work expectations help teams respond predictably to unacceptable risk.'
),
(
  15,
  'scenario',
  'scenario',
  'A company has many minor safety violations but few recorded injuries. Leadership is considering reducing safety inspections. What is the BEST response?',
  '[{"key":"A","text":"Use the violation pattern as an early warning, investigate why expectations are not being met, and strengthen preventive controls where needed"},{"key":"B","text":"Reduce inspections because injuries are low"},{"key":"C","text":"Stop recording minor violations"},{"key":"D","text":"Wait for a serious incident before changing anything"}]'::jsonb,
  '["A"]'::jsonb,
  'Frequent minor violations can signal elevated risk even when serious outcomes have not yet occurred.'
),
(
  16,
  'scenario',
  'scenario',
  'A new safety checklist is introduced, but hazard recurrence does not improve. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate whether the checklist addresses the real hazards, whether teams use it correctly, and whether the controls it triggers are effective"},{"key":"B","text":"Assume the checklist works because it exists"},{"key":"C","text":"Create another checklist without analysis"},{"key":"D","text":"Stop measuring hazards"}]'::jsonb,
  '["A"]'::jsonb,
  'A safety control should be tested for effectiveness rather than judged by its existence.'
),
(
  17,
  'scenario',
  'scenario',
  'An employee reports a serious safety concern that was never captured by existing inspections. What is the BEST leadership response?',
  '[{"key":"A","text":"Address the immediate concern, investigate why the inspection process missed it, and improve the control system where necessary"},{"key":"B","text":"Dismiss the concern because inspections were already completed"},{"key":"C","text":"Discourage employees from reporting issues outside inspections"},{"key":"D","text":"Remove the affected inspection requirement"}]'::jsonb,
  '["A"]'::jsonb,
  'Escaped hazards reveal gaps in existing inspection, reporting, or control processes.'
),
(
  18,
  'scenario',
  'scenario',
  'Warehouse handling practices repeatedly result in unstable loads and near misses that could affect field delivery. What is the BEST cross-functional response?',
  '[{"key":"A","text":"Analyze the handling and staging process, define safe methods and ownership, train the team, verify compliance, and measure recurrence"},{"key":"B","text":"Tell field technicians to inspect loads after delivery"},{"key":"C","text":"Add more delivery time without changing the process"},{"key":"D","text":"Stop reporting warehouse near misses"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring warehouse safety risks should be corrected at their source before they affect downstream teams.'
),
(
  19,
  'scenario',
  'scenario',
  'Supervisors repeatedly correct the same unsafe behavior, but leadership has never analyzed why it continues. What should happen?',
  '[{"key":"A","text":"Escalate the recurring pattern for root-cause analysis and address training, supervision, incentives, workflow, or control gaps that sustain the behavior"},{"key":"B","text":"Continue correcting each occurrence individually forever"},{"key":"C","text":"Stop documenting the behavior"},{"key":"D","text":"Lower the safety standard"}]'::jsonb,
  '["A"]'::jsonb,
  'Persistent unsafe behavior usually requires more than repeated one-time correction.'
),
(
  20,
  'scenario',
  'scenario',
  'Leadership sees near misses, inconsistent housekeeping, unsafe tool practices, poor hazard handoff, and different safety expectations across departments. What is the BEST organization-wide strategy?',
  '[{"key":"A","text":"Build a shared safety operating system with clear standards, role ownership, hazard identification, handoff requirements, training, stop-work expectations, inspections, corrective action, and measurable safety indicators"},{"key":"B","text":"Add one safety meeting at the end of each project"},{"key":"C","text":"Make field technicians solely responsible for safety"},{"key":"D","text":"Focus only on incidents that cause injury"}]'::jsonb,
  '["A"]'::jsonb,
  'Broad recurring safety failures require coordinated standards and controls across the organization.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '68bbbfed-1a2b-449f-a881-6f62e3d6bb89';
  v_l1_role_id uuid := '89d6e66a-d996-4006-801a-ac2993b70341';
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
      and c.name = 'Safety & Job-Site Standards'
      and c.is_current = true
  ) then
    raise exception 'Current Safety & Job-Site Standards Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Sales Specialist'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Sales Specialist L1 Safety & Job-Site Standards requirement not found';
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
    raise exception 'Current Technician I — Entry Level L2 Safety & Job-Site Standards requirement not found';
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
    raise exception 'Current Technician II — Experienced L3 Safety & Job-Site Standards requirement not found';
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
    raise exception 'Current Technician III — Lead Technician L4 Safety & Job-Site Standards requirement not found';
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
  v_assessment_name := 'Safety & Job-Site Standards — Level 1 Competency Assessment';

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
    select * from _seed_ci_safety_job_site_standards_l1_questions
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
        'Safety & Job-Site Standards',
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
      'IntegrateU Safety & Job-Site Standards L1 production assessment v1.0.',
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
        'Safety & Job-Site Standards',
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
        'IntegrateU Safety & Job-Site Standards L1 production assessment v1.0.',
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
  v_assessment_name := 'Safety & Job-Site Standards — Level 2 Competency Assessment';

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
    select * from _seed_ci_safety_job_site_standards_l2_questions
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
        'Safety & Job-Site Standards',
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
      'IntegrateU Safety & Job-Site Standards L2 production assessment v1.0.',
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
        'Safety & Job-Site Standards',
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
        'IntegrateU Safety & Job-Site Standards L2 production assessment v1.0.',
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
  v_assessment_name := 'Safety & Job-Site Standards — Level 3 Competency Assessment';

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
    select * from _seed_ci_safety_job_site_standards_l3_questions
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
        'Safety & Job-Site Standards',
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
      'IntegrateU Safety & Job-Site Standards L3 production assessment v1.0.',
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
        'Safety & Job-Site Standards',
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
        'IntegrateU Safety & Job-Site Standards L3 production assessment v1.0.',
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
  v_assessment_name := 'Safety & Job-Site Standards — Level 4 Competency Assessment';

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
    select * from _seed_ci_safety_job_site_standards_l4_questions
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
        'Safety & Job-Site Standards',
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
      'IntegrateU Safety & Job-Site Standards L4 production assessment v1.0.',
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
        'Safety & Job-Site Standards',
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
        'IntegrateU Safety & Job-Site Standards L4 production assessment v1.0.',
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
