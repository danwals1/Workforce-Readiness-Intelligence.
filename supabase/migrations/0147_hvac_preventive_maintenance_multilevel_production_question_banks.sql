-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0147_hvac_preventive_maintenance_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Preventive Maintenance
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
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

create temporary table _seed_hvac_preventive_maintenance_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_preventive_maintenance_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of preventive maintenance on HVAC equipment?',
  '[{"key":"A","text":"To help maintain reliable operation, identify developing problems, and support equipment performance"},{"key":"B","text":"To guarantee that equipment will never fail"},{"key":"C","text":"To replace all future repairs"},{"key":"D","text":"To increase equipment size"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance supports reliable operation by inspecting, cleaning, testing, adjusting, and documenting equipment before problems become larger failures.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are air filters inspected during preventive maintenance?',
  '[{"key":"A","text":"Dirty or damaged filters can restrict airflow and reduce system performance"},{"key":"B","text":"Filters control refrigerant pressure"},{"key":"C","text":"Filters determine thermostat voltage"},{"key":"D","text":"Filters increase compressor capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Filter condition affects airflow, cleanliness, and system performance and is a basic preventive-maintenance check.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should HVAC coils be kept reasonably clean?',
  '[{"key":"A","text":"Dirt and debris can reduce heat transfer and restrict airflow"},{"key":"B","text":"Coils only affect electrical voltage"},{"key":"C","text":"Clean coils eliminate the need for refrigerant"},{"key":"D","text":"Coil cleanliness changes thermostat programming"}]'::jsonb,
  '["A"]'::jsonb,
  'Clean heat-transfer surfaces help equipment exchange heat and maintain intended airflow.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of inspecting a condensate drain during preventive maintenance?',
  '[{"key":"A","text":"To help confirm that condensate can drain properly without blockage or leakage"},{"key":"B","text":"To measure compressor current"},{"key":"C","text":"To increase refrigerant pressure"},{"key":"D","text":"To control blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Blocked or damaged condensate drainage can lead to water damage, overflow, and equipment shutdowns.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why are loose electrical connections a concern during preventive maintenance?',
  '[{"key":"A","text":"They can contribute to overheating, intermittent operation, or equipment failure"},{"key":"B","text":"They improve motor efficiency"},{"key":"C","text":"They reduce refrigerant pressure"},{"key":"D","text":"They increase airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Loose or damaged electrical connections can create unreliable operation and excessive heating and should be addressed using approved procedures.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why should preventive-maintenance findings be documented?',
  '[{"key":"A","text":"Documentation creates a record of equipment condition, work performed, measurements, and items needing follow-up"},{"key":"B","text":"Documentation replaces all future inspections"},{"key":"C","text":"Documentation guarantees warranty approval"},{"key":"D","text":"Documentation is only useful when equipment fails"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintenance records help track condition over time and communicate work completed and unresolved issues.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is visual inspection an important part of preventive maintenance?',
  '[{"key":"A","text":"It can reveal dirt, damage, corrosion, leaks, loose parts, and other obvious conditions needing attention"},{"key":"B","text":"It replaces all measurements"},{"key":"C","text":"It proves refrigerant charge is correct"},{"key":"D","text":"It determines equipment capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'A structured visual inspection can identify many developing problems before more detailed testing begins.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should an installer do if preventive maintenance reveals a condition outside their assigned skill or authority?',
  '[{"key":"A","text":"Document and report the condition to the appropriate technician or supervisor"},{"key":"B","text":"Ignore the condition"},{"key":"C","text":"Make an unapproved repair"},{"key":"D","text":"Delete it from the maintenance record"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintenance findings that require higher-level diagnosis or repair should be clearly documented and escalated.'
),
(
  9,
  'multiple_choice',
  'application',
  'During preventive maintenance, an installer removes a filter and finds it heavily loaded with dirt. What is the BEST response?',
  '[{"key":"A","text":"Replace or service the filter as required and confirm the correct replacement is installed"},{"key":"B","text":"Reinstall it because the system was still running"},{"key":"C","text":"Remove the filter permanently"},{"key":"D","text":"Increase blower speed to compensate"}]'::jsonb,
  '["A"]'::jsonb,
  'A heavily loaded filter should be serviced according to the maintenance requirements because it can restrict airflow.'
),
(
  10,
  'multiple_choice',
  'application',
  'An installer notices leaves and debris blocking part of an outdoor condenser coil. What should be done?',
  '[{"key":"A","text":"Remove the obstruction and clean the coil using the approved maintenance method"},{"key":"B","text":"Leave it until cooling stops completely"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close the outdoor disconnect permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Outdoor debris can restrict condenser airflow and should be removed as part of routine maintenance.'
),
(
  11,
  'multiple_choice',
  'application',
  'A condensate drain pan contains standing water and the drain appears slow. What is the BEST maintenance response?',
  '[{"key":"A","text":"Inspect and clear the drainage path using the approved procedure and verify proper flow"},{"key":"B","text":"Ignore it because some water is normal"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Slow drainage can lead to overflow or shutdown and should be corrected and verified.'
),
(
  12,
  'multiple_choice',
  'application',
  'During a maintenance inspection, a belt is visibly cracked and frayed. What should the installer do?',
  '[{"key":"A","text":"Report and replace the belt as required before it fails in service"},{"key":"B","text":"Apply oil to the belt"},{"key":"C","text":"Increase belt tension as much as possible"},{"key":"D","text":"Ignore it until it breaks"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible cracking and fraying indicate deterioration that can lead to belt failure.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer finds dust buildup on a blower wheel during preventive maintenance. Why should this matter?',
  '[{"key":"A","text":"Buildup can affect airflow, balance, and blower performance"},{"key":"B","text":"Dust increases refrigerant pressure"},{"key":"C","text":"Dust improves motor cooling"},{"key":"D","text":"Dust changes thermostat voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Blower-wheel contamination can reduce airflow and contribute to imbalance or poor performance.'
),
(
  14,
  'multiple_choice',
  'application',
  'A maintenance checklist calls for checking accessible electrical connections. What is the BEST approach?',
  '[{"key":"A","text":"Inspect for signs of looseness, damage, overheating, or corrosion and address them using approved safe procedures"},{"key":"B","text":"Tighten every connection without regard to manufacturer requirements"},{"key":"C","text":"Ignore discoloration if equipment still runs"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical inspections should look for evidence of poor connections or damage and follow approved procedures for correction.'
),
(
  15,
  'multiple_choice',
  'application',
  'An installer notices insulation missing from part of a refrigerant suction line. What should be done?',
  '[{"key":"A","text":"Restore the required insulation and report any related damage or moisture condition"},{"key":"B","text":"Remove the remaining insulation"},{"key":"C","text":"Add refrigerant automatically"},{"key":"D","text":"Reduce thermostat temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Missing insulation can contribute to heat gain, condensation, and poor system performance.'
),
(
  16,
  'multiple_choice',
  'application',
  'A preventive-maintenance checklist includes checking equipment panels and fasteners. Why?',
  '[{"key":"A","text":"Loose or missing panels and fasteners can contribute to vibration, air leakage, equipment damage, or unsafe conditions"},{"key":"B","text":"Panels control refrigerant flow"},{"key":"C","text":"Fasteners determine thermostat setpoint"},{"key":"D","text":"Panels increase equipment capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment panels and fasteners should be properly secured to support safe and reliable operation.'
),
(
  17,
  'scenario',
  'scenario',
  'During preventive maintenance, a helper finds a filter that is so dirty it has partially collapsed into the return opening. What is the BEST response?',
  '[{"key":"A","text":"Replace the filter, inspect for related airflow or debris issues, and document the condition"},{"key":"B","text":"Push the filter back into shape and reuse it"},{"key":"C","text":"Run the system without a filter"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A collapsed filter can severely restrict airflow and may allow debris into the equipment, so it should be corrected and documented.'
),
(
  18,
  'scenario',
  'scenario',
  'An installer is cleaning an outdoor unit and notices oil staining around a refrigerant-line connection. What is the BEST response?',
  '[{"key":"A","text":"Document and report the condition for evaluation because it may indicate a refrigerant leak"},{"key":"B","text":"Wipe it off and say nothing"},{"key":"C","text":"Add refrigerant without further evaluation"},{"key":"D","text":"Paint over the stain"}]'::jsonb,
  '["A"]'::jsonb,
  'Oil staining near refrigerant connections can be evidence of leakage and should be reported for appropriate evaluation.'
),
(
  19,
  'scenario',
  'scenario',
  'During maintenance, the installer notices a motor making a new grinding sound even though it is still operating. What is the BEST response?',
  '[{"key":"A","text":"Document and report the abnormal sound and have the motor or driven equipment evaluated before failure progresses"},{"key":"B","text":"Ignore it because the motor is still running"},{"key":"C","text":"Increase motor speed"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'New abnormal noise can indicate developing mechanical problems and should not be ignored simply because equipment is still operating.'
),
(
  20,
  'scenario',
  'scenario',
  'A helper completes a maintenance visit but skips several checklist items because the equipment appears to be operating normally. What is the BEST conclusion?',
  '[{"key":"A","text":"The preventive maintenance is incomplete because required inspection and verification steps were not performed"},{"key":"B","text":"The work is complete because the system runs"},{"key":"C","text":"Only filter replacement matters"},{"key":"D","text":"Checklists are optional"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance requires completion of the defined inspection and service steps rather than relying only on whether the equipment currently runs.'
);

create temporary table _seed_hvac_preventive_maintenance_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_preventive_maintenance_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 preventive maintenance performance?',
  '[{"key":"A","text":"Independently inspecting, cleaning, testing, measuring, documenting, and identifying developing equipment problems"},{"key":"B","text":"Replacing every component during each maintenance visit"},{"key":"C","text":"Performing only visual checks"},{"key":"D","text":"Waiting for equipment failure before taking measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 3 preventive maintenance includes independent inspection, service, operating measurements, documentation, and recognition of conditions that require correction or further diagnosis.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are operating measurements valuable during preventive maintenance?',
  '[{"key":"A","text":"They provide objective evidence of current equipment condition and can reveal changes before a major failure occurs"},{"key":"B","text":"They guarantee equipment will not fail"},{"key":"C","text":"They replace all visual inspection"},{"key":"D","text":"They are only needed after a customer complaint"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurements such as temperature, current, pressure, airflow, and other operating data can reveal developing problems and establish useful trends.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to compare current maintenance readings with previous documented readings?',
  '[{"key":"A","text":"Changes over time can help identify deterioration, loading changes, fouling, or developing faults"},{"key":"B","text":"Previous readings are always more accurate than current readings"},{"key":"C","text":"The system should produce exactly identical readings every visit"},{"key":"D","text":"Trend comparison eliminates the need for manufacturer information"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintenance trending helps identify conditions that may be slowly changing even when equipment is still operating.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should preventive maintenance include verification of both equipment cleanliness and operating condition?',
  '[{"key":"A","text":"Clean equipment may still have electrical, mechanical, airflow, refrigerant, control, or other operating problems"},{"key":"B","text":"Cleaning automatically proves correct operation"},{"key":"C","text":"Operating measurements are unnecessary if coils are clean"},{"key":"D","text":"Cleanliness only matters for appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective maintenance combines physical condition checks with functional and operating verification.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician finds a condenser coil moderately dirty and head pressure higher than expected. What is the BEST maintenance approach?',
  '[{"key":"A","text":"Clean the coil using the approved method, restore airflow, and reevaluate operation before making further conclusions"},{"key":"B","text":"Recover refrigerant immediately"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase the high-pressure limit"}]'::jsonb,
  '["A"]'::jsonb,
  'A known heat-transfer restriction should be corrected before charge or component conclusions are made.'
),
(
  6,
  'multiple_choice',
  'application',
  'A blower motor current is higher than the value recorded on previous maintenance visits. What should the technician evaluate?',
  '[{"key":"A","text":"Motor condition, blower cleanliness, mechanical loading, airflow restrictions, supply conditions, and connections"},{"key":"B","text":"Thermostat color only"},{"key":"C","text":"Refrigerant type only"},{"key":"D","text":"Condensate drain material only"}]'::jsonb,
  '["A"]'::jsonb,
  'An increase in motor current can indicate greater mechanical load, airflow issues, motor deterioration, or electrical problems.'
),
(
  7,
  'multiple_choice',
  'application',
  'During maintenance, the temperature drop across a cooling coil is unusual and airflow is below expected values. What should be done first?',
  '[{"key":"A","text":"Identify and correct the airflow problem before drawing conclusions about refrigeration performance"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase thermostat demand"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow affects coil temperature performance and refrigeration measurements, so known air-side deficiencies should be addressed first.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician notices a contactor has significant discoloration and pitting during preventive maintenance. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the contactor condition and operating load and correct the deteriorated component as required"},{"key":"B","text":"Ignore it because the equipment still runs"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible contact deterioration can indicate overheating or wear and should be evaluated before it progresses to failure.'
),
(
  9,
  'multiple_choice',
  'application',
  'A system has a reusable filter that was cleaned, but airflow remains low. What should the technician do next?',
  '[{"key":"A","text":"Continue evaluating blower setup, coil cleanliness, duct restrictions, dampers, and other air-side causes"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Assume airflow is acceptable because the filter is clean"}]'::jsonb,
  '["A"]'::jsonb,
  'A clean filter does not eliminate other possible causes of low airflow.'
),
(
  10,
  'multiple_choice',
  'application',
  'A maintenance visit shows a condensate trap partially blocked with biological buildup. What is the BEST response?',
  '[{"key":"A","text":"Clean and restore the drainage system using the approved procedure and verify proper flow"},{"key":"B","text":"Ignore it until overflow occurs"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Seal the drain closed"}]'::jsonb,
  '["A"]'::jsonb,
  'A partially blocked drain can progress to overflow, water damage, or safety-switch operation and should be corrected.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician records compressor current, suction pressure, discharge pressure, and temperatures during maintenance. Why is it important to record the operating conditions too?',
  '[{"key":"A","text":"Load, airflow, indoor conditions, and outdoor conditions affect the meaning of the readings"},{"key":"B","text":"Operating conditions are unrelated to measurements"},{"key":"C","text":"Only compressor current changes with load"},{"key":"D","text":"The readings should be identical regardless of conditions"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintenance measurements are more meaningful when the conditions under which they were taken are also documented.'
),
(
  12,
  'scenario',
  'scenario',
  'During preventive maintenance, a technician finds a severely dirty evaporator coil and low airflow. The customer also reports reduced cooling. What is the BEST next step?',
  '[{"key":"A","text":"Clean the coil, restore proper airflow, and reevaluate system performance before making refrigeration-charge conclusions"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase blower speed without cleaning the coil"}]'::jsonb,
  '["A"]'::jsonb,
  'A heavily fouled evaporator can directly reduce airflow and heat transfer, so that known defect should be corrected before further diagnosis.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician compares this year maintenance data with last year and finds condenser-fan motor current has steadily increased while the motor bearings are becoming noisy. What is the BEST interpretation?',
  '[{"key":"A","text":"The motor or fan assembly may be deteriorating and should be evaluated before failure occurs"},{"key":"B","text":"The readings prove refrigerant overcharge"},{"key":"C","text":"The thermostat must be replaced"},{"key":"D","text":"The trend can be ignored because the fan still operates"}]'::jsonb,
  '["A"]'::jsonb,
  'A worsening current and noise trend can indicate increasing mechanical load or motor deterioration and is exactly the kind of developing condition preventive maintenance should catch.'
),
(
  14,
  'scenario',
  'scenario',
  'A rooftop unit has a belt that appears intact, but inspection shows it is loose and slipping under load. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Correct belt tension or replace the belt as required, inspect related sheaves and alignment, and verify operation"},{"key":"B","text":"Increase motor speed"},{"key":"C","text":"Apply lubricant to the belt"},{"key":"D","text":"Ignore it until the belt breaks"}]'::jsonb,
  '["A"]'::jsonb,
  'A slipping belt can reduce airflow and accelerate wear, so belt condition, tension, alignment, and related drive components should be checked.'
),
(
  15,
  'scenario',
  'scenario',
  'During maintenance, a technician finds a small amount of oil residue around a refrigerant connection and system performance is currently normal. What is the BEST response?',
  '[{"key":"A","text":"Investigate for possible leakage using an approved method and document the finding rather than ignoring it"},{"key":"B","text":"Add refrigerant automatically"},{"key":"C","text":"Wipe the oil away and close the work order"},{"key":"D","text":"Replace the compressor immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Oil residue can indicate a refrigerant leak even before performance noticeably declines and should be evaluated appropriately.'
),
(
  16,
  'scenario',
  'scenario',
  'A system has a history of plugged condensate drains. During the current maintenance visit the drain is flowing, but heavy buildup is visible in the pan and trap. What is the BEST response?',
  '[{"key":"A","text":"Clean the drainage system thoroughly, verify flow, and document the recurring condition for follow-up"},{"key":"B","text":"Leave it because the drain is flowing today"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Disable the condensate safety"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance should address conditions likely to cause recurrence rather than waiting for another blockage.'
),
(
  17,
  'scenario',
  'scenario',
  'During maintenance, a technician measures an unusually high temperature rise across a furnace. The filter is clean, but airflow is low. What is the BEST response?',
  '[{"key":"A","text":"Investigate blower setup, duct restrictions, coil condition, dampers, and other airflow causes before accepting operation"},{"key":"B","text":"Increase gas input immediately"},{"key":"C","text":"Ignore the reading if the space heats"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive temperature rise can indicate inadequate airflow and should be investigated before equipment is returned to normal operation.'
),
(
  18,
  'scenario',
  'scenario',
  'A maintenance checklist shows several electrical readings far different from previous visits, but the technician suspects the meter may be malfunctioning. What is the BEST response?',
  '[{"key":"A","text":"Verify the test instrument and repeat the measurements before concluding the equipment condition has changed"},{"key":"B","text":"Record the values as confirmed"},{"key":"C","text":"Replace all electrical components"},{"key":"D","text":"Delete the measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected data should be validated with a suitable instrument and proper test method before major conclusions are drawn.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds the same loose electrical connection documented on the previous two maintenance visits. It was noted but never corrected. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Escalate and correct the recurring condition using the approved procedure rather than documenting it again without resolution"},{"key":"B","text":"Copy the previous note into the new report"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Ignore it because no failure has occurred"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring unresolved maintenance findings should be addressed before they progress into failure or unsafe operation.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes all cleaning and inspection tasks, but final operating measurements are substantially different from the equipment baseline. What is the BEST conclusion?',
  '[{"key":"A","text":"Preventive maintenance should not be closed until the abnormal operating condition is evaluated and appropriately documented or corrected"},{"key":"B","text":"The visit is complete because cleaning was performed"},{"key":"C","text":"Baseline data should be deleted"},{"key":"D","text":"The readings can be changed to match prior values"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance includes evaluating equipment operation, not simply completing cleaning tasks.'
);

create temporary table _seed_hvac_preventive_maintenance_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_preventive_maintenance_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Preventive Maintenance?',
  '[{"key":"A","text":"Leading condition-based maintenance decisions using trends, system interactions, risk, and equipment history"},{"key":"B","text":"Replacing components on a fixed schedule regardless of condition"},{"key":"C","text":"Reviewing only filter condition"},{"key":"D","text":"Waiting for equipment failure before acting"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 preventive maintenance uses technical leadership, trend interpretation, equipment history, system interactions, and risk to guide maintenance decisions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary value of maintenance trend data at the senior-technician level?',
  '[{"key":"A","text":"It helps distinguish normal variation from progressive deterioration and recurring system problems"},{"key":"B","text":"It guarantees identical readings every visit"},{"key":"C","text":"It eliminates the need for inspection"},{"key":"D","text":"It replaces manufacturer requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Long-term trends can reveal developing problems that may not be obvious from a single maintenance visit.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should a senior technician evaluate recurring maintenance findings across multiple systems or visits?',
  '[{"key":"A","text":"Patterns can reveal systemic installation, operating, environmental, training, or maintenance-process issues"},{"key":"B","text":"Recurring findings should always be treated as unrelated events"},{"key":"C","text":"Only equipment age matters"},{"key":"D","text":"Patterns are useful only after equipment failure"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated findings can indicate broader root causes that require more than one isolated repair.'
),
(
  4,
  'multiple_choice',
  'application',
  'A fleet of rooftop units shows gradually increasing condenser-fan motor current over several maintenance cycles. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Review trends, operating conditions, motor and fan condition, coil cleanliness, supply conditions, and common environmental factors"},{"key":"B","text":"Replace every motor immediately"},{"key":"C","text":"Ignore the trend until a motor fails"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated current trend across equipment should be analyzed for shared mechanical, electrical, airflow, or environmental causes.'
),
(
  5,
  'multiple_choice',
  'application',
  'A senior technician sees repeated dirty-coil findings shortly after each scheduled cleaning. What should be investigated?',
  '[{"key":"A","text":"The contamination source, filtration, equipment location, operating environment, cleaning method, and maintenance interval"},{"key":"B","text":"Refrigerant charge only"},{"key":"C","text":"Thermostat color"},{"key":"D","text":"Compressor size only"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring fouling suggests the maintenance strategy or operating environment may need to be addressed rather than simply repeating the same cleaning task.'
),
(
  6,
  'multiple_choice',
  'application',
  'Maintenance records show blower belts repeatedly require adjustment between scheduled visits. What is the BEST senior-level response?',
  '[{"key":"A","text":"Evaluate belt selection, sheave alignment, tensioning method, drive condition, loading, and maintenance frequency"},{"key":"B","text":"Increase belt tension as much as possible"},{"key":"C","text":"Replace only the thermostat"},{"key":"D","text":"Ignore the pattern"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated belt issues can indicate alignment, drive, loading, selection, or process problems that require root-cause evaluation.'
),
(
  7,
  'multiple_choice',
  'application',
  'A system has recurring condensate blockages despite routine drain cleaning. What should a senior technician evaluate?',
  '[{"key":"A","text":"Drain design, slope, trap configuration, biological growth, airflow effects, maintenance method, and operating environment"},{"key":"B","text":"Only thermostat settings"},{"key":"C","text":"Refrigerant charge only"},{"key":"D","text":"Compressor voltage only"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring drainage problems should trigger investigation of the system and environment rather than repeated symptom treatment.'
),
(
  8,
  'multiple_choice',
  'application',
  'A maintenance program records many measurements but technicians rarely compare them with prior data. What is the BEST improvement?',
  '[{"key":"A","text":"Establish baseline and trend review so significant changes trigger evaluation or follow-up"},{"key":"B","text":"Stop taking measurements"},{"key":"C","text":"Record fewer equipment identifiers"},{"key":"D","text":"Replace all instruments"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurement programs create more value when data is compared over time and used to identify meaningful change.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician is deciding whether to replace a component that still operates but shows worsening vibration and current trends. What should guide the decision?',
  '[{"key":"A","text":"Condition trend, failure risk, manufacturer guidance, operating criticality, cost, and evidence of deterioration"},{"key":"B","text":"Whether the component still turns on"},{"key":"C","text":"Equipment paint condition"},{"key":"D","text":"Thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Condition-based maintenance decisions should consider technical evidence, risk, criticality, and lifecycle impact.'
),
(
  10,
  'multiple_choice',
  'application',
  'Several technicians report inconsistent maintenance readings on the same equipment type. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Review test methods, instrument suitability, measurement locations, operating conditions, and technician practices"},{"key":"B","text":"Average all readings regardless of method"},{"key":"C","text":"Assume all equipment is defective"},{"key":"D","text":"Stop documenting readings"}]'::jsonb,
  '["A"]'::jsonb,
  'Inconsistent maintenance data may reflect measurement-process differences and should be standardized before equipment conclusions are made.'
),
(
  11,
  'scenario',
  'scenario',
  'A group of identical rooftop units experiences repeated condenser-fan failures. Maintenance records show increasing current and vibration for months before each failure. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Use the trend evidence to identify root causes and establish earlier intervention criteria before additional failures occur"},{"key":"B","text":"Continue replacing motors only after failure"},{"key":"C","text":"Delete the previous readings"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'Predictable deterioration patterns should be used to improve maintenance thresholds and prevent repeat failures.'
),
(
  12,
  'scenario',
  'scenario',
  'A critical air handler repeatedly develops low airflow between scheduled maintenance visits. Filters and coils are clean each time, but belt tension continues to drift. What is the BEST response?',
  '[{"key":"A","text":"Investigate the complete drive system, alignment, sheaves, belt selection, tensioning practice, loading, and maintenance interval"},{"key":"B","text":"Increase fan speed every visit"},{"key":"C","text":"Replace filters more often"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring airflow loss tied to belt condition requires a root-cause review of the drive system and maintenance process.'
),
(
  13,
  'scenario',
  'scenario',
  'A maintenance report shows compressor current has increased steadily over a year while cooling capacity has declined. Airflow and coil cleanliness are normal. What is the BEST senior-level approach?',
  '[{"key":"A","text":"Perform a deeper evaluation of compressor performance, refrigerant-system conditions, electrical supply, operating load, and historical trends"},{"key":"B","text":"Accept the trend because the compressor still runs"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'A worsening current-and-capacity trend can indicate developing system or compressor problems that require deeper evaluation.'
),
(
  14,
  'scenario',
  'scenario',
  'Maintenance history shows repeated overheated electrical connections at the same equipment family across multiple sites. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Investigate connection method, torque requirements, conductor sizing, vibration, loading, installation practices, and common equipment factors"},{"key":"B","text":"Treat every occurrence as unrelated"},{"key":"C","text":"Install larger breakers"},{"key":"D","text":"Stop inspecting connections"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated pattern across similar equipment suggests a systemic technical or workmanship issue that should be identified and corrected.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer has repeated condensate overflows despite regular drain clearing. Inspection shows marginal drain slope and an incorrect trap configuration. What is the BEST response?',
  '[{"key":"A","text":"Correct the underlying drainage design or installation deficiency rather than relying on repeated cleaning alone"},{"key":"B","text":"Increase cleaning frequency indefinitely"},{"key":"C","text":"Disable the condensate safety"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance should lead to correction of recurring root causes when the evidence shows a persistent installation or design problem.'
),
(
  16,
  'scenario',
  'scenario',
  'A senior technician reviews two years of maintenance history and sees evaporator airflow slowly declining even though filters are replaced regularly. What is the BEST next step?',
  '[{"key":"A","text":"Inspect the full air path, blower performance, coil condition, duct restrictions, dampers, and system changes to identify the progressive cause"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Ignore the decline because filters are new"}]'::jsonb,
  '["A"]'::jsonb,
  'A long-term airflow trend indicates a developing air-side issue that requires broader system evaluation.'
),
(
  17,
  'scenario',
  'scenario',
  'A maintenance team frequently documents deficiencies but work orders are closed without confirming correction. What is the BEST Level 4 process improvement?',
  '[{"key":"A","text":"Create a clear deficiency follow-up process with ownership, priority, corrective action, and verification before closure"},{"key":"B","text":"Stop documenting deficiencies"},{"key":"C","text":"Close findings automatically after 30 days"},{"key":"D","text":"Leave follow-up entirely to the customer"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature maintenance process requires documented findings to flow into accountable corrective action and verified closure.'
),
(
  18,
  'scenario',
  'scenario',
  'A senior technician discovers that different technicians use different procedures to measure temperature rise, producing inconsistent historical data. What is the BEST response?',
  '[{"key":"A","text":"Standardize the measurement procedure, locations, operating conditions, and documentation so future trends are comparable"},{"key":"B","text":"Average all historical values"},{"key":"C","text":"Stop measuring temperature rise"},{"key":"D","text":"Use whichever method is fastest"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable trending depends on consistent methods and operating conditions.'
),
(
  19,
  'scenario',
  'scenario',
  'A critical system has shown increasing vibration for three maintenance cycles, but no alarm or shutdown has occurred. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Evaluate the vibration trend, equipment criticality, mechanical condition, failure consequences, and appropriate corrective timing before failure occurs"},{"key":"B","text":"Wait for the system to trip"},{"key":"C","text":"Reset the vibration baseline"},{"key":"D","text":"Ignore the trend because operation continues"}]'::jsonb,
  '["A"]'::jsonb,
  'Preventive maintenance aims to use condition evidence and risk to intervene before a predictable failure occurs.'
),
(
  20,
  'scenario',
  'scenario',
  'A company has strong maintenance checklists but still experiences repeat failures because technicians record abnormal conditions without analyzing trends or recurring causes. What is the BEST Level 4 improvement?',
  '[{"key":"A","text":"Add structured trend review, root-cause analysis, escalation criteria, and verified corrective-action follow-up to the maintenance program"},{"key":"B","text":"Make the checklist longer"},{"key":"C","text":"Reduce documentation"},{"key":"D","text":"Replace equipment whenever any reading changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced preventive maintenance turns inspection data into decisions by combining trends, root-cause analysis, accountability, and verified corrective action.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3';
  v_installer_role_id uuid := '7a7a4a06-45d7-4bca-af67-ede5df4fb915';
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
      and c.name = 'Preventive Maintenance'
      and c.is_current = true
  ) then
    raise exception 'Current Preventive Maintenance Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 Preventive Maintenance requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 Preventive Maintenance requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Preventive Maintenance requirement not found';
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
  v_assessment_name := 'Preventive Maintenance — Level 1 Competency Assessment';

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
    select * from _seed_hvac_preventive_maintenance_l1_questions
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
        'Preventive Maintenance',
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
      'IntegrateU Preventive Maintenance L1 production assessment v1.0.',
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
        'Preventive Maintenance',
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
        'IntegrateU Preventive Maintenance L1 production assessment v1.0.',
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
  v_assessment_name := 'Preventive Maintenance — Level 3 Competency Assessment';

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
    select * from _seed_hvac_preventive_maintenance_l3_questions
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
        'Preventive Maintenance',
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
      'IntegrateU Preventive Maintenance L3 production assessment v1.0.',
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
        'Preventive Maintenance',
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
        'IntegrateU Preventive Maintenance L3 production assessment v1.0.',
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
  v_assessment_name := 'Preventive Maintenance — Level 4 Competency Assessment';

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
    select * from _seed_hvac_preventive_maintenance_l4_questions
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
        'Preventive Maintenance',
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
      'IntegrateU Preventive Maintenance L4 production assessment v1.0.',
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
        'Preventive Maintenance',
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
        'IntegrateU Preventive Maintenance L4 production assessment v1.0.',
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
   '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 HVAC Installer / Helper          -> 20
--   Level 3 HVAC Service & Repair Technician -> 20
--   Level 4 Senior / Lead HVAC Technician    -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid
    and a.target_level in (1,3,4)
    and aq.master_competency_template_id =
      '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid
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
  '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid;

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
    '0b7a5c7a-8e4b-4142-aa8f-ddee3ffc79e3'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
