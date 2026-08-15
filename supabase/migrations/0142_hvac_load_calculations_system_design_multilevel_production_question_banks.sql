-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0142_hvac_load_calculations_system_design_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Load Calculations & HVAC System Design
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Service & Repair Technician -> Level 1
--   Senior / Lead HVAC Technician    -> Level 3
--   HVAC Design & Sales Engineer     -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_load_calculations_system_design_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_load_calculations_system_design_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an HVAC load calculation?',
  '[{"key":"A","text":"To estimate the heating and cooling demand the HVAC system must serve"},{"key":"B","text":"To determine refrigerant type"},{"key":"C","text":"To select thermostat color"},{"key":"D","text":"To determine electrical wire color"}]'::jsonb,
  '["A"]'::jsonb,
  'A load calculation estimates the heating and cooling demand created by the building, its use, and the applicable design conditions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are outdoor design conditions important in an HVAC load calculation?',
  '[{"key":"A","text":"They establish representative outdoor conditions used to evaluate heating and cooling demand"},{"key":"B","text":"They determine the equipment brand"},{"key":"C","text":"They eliminate the need to evaluate the building envelope"},{"key":"D","text":"They determine thermostat programming"}]'::jsonb,
  '["A"]'::jsonb,
  'Heating and cooling loads depend partly on the difference between indoor design conditions and representative outdoor design conditions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Which building feature can significantly affect heating and cooling load?',
  '[{"key":"A","text":"Insulation levels, windows, doors, and other envelope characteristics"},{"key":"B","text":"The color of the thermostat display"},{"key":"C","text":"The brand name printed on the condenser"},{"key":"D","text":"The shape of the service wrench"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat gain and heat loss through the building envelope are important parts of determining HVAC load.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does sensible cooling load primarily represent?',
  '[{"key":"A","text":"Heat that changes the dry-bulb temperature of the space"},{"key":"B","text":"Moisture removal only"},{"key":"C","text":"Moisture content removed from the air"},{"key":"D","text":"Refrigerant pressure drop only"}]'::jsonb,
  '["A"]'::jsonb,
  'Sensible load is associated with changing the temperature of the air and building materials rather than removing moisture.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What does latent cooling load primarily represent?',
  '[{"key":"A","text":"The moisture-removal requirement of the conditioned space"},{"key":"B","text":"The temperature rise across an electric heater"},{"key":"C","text":"The resistance of ductwork"},{"key":"D","text":"The voltage supplied to the blower"}]'::jsonb,
  '["A"]'::jsonb,
  'Latent load is associated with moisture that the cooling system must remove from the indoor air.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'How can outdoor air entering a building through infiltration affect HVAC load?',
  '[{"key":"A","text":"It can add heating, cooling, and moisture loads that the system must handle"},{"key":"B","text":"It always reduces equipment capacity requirements"},{"key":"C","text":"It affects only thermostat wiring"},{"key":"D","text":"It has no effect on load calculations"}]'::jsonb,
  '["A"]'::jsonb,
  'Uncontrolled outdoor-air infiltration can add sensible and latent loads depending on outdoor and indoor conditions.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why can window orientation matter when calculating cooling load?',
  '[{"key":"A","text":"Solar heat gain can vary with the direction the window faces and its exposure"},{"key":"B","text":"North-facing windows always require larger equipment"},{"key":"C","text":"Orientation changes the electrical service voltage"},{"key":"D","text":"Orientation determines refrigerant type"}]'::jsonb,
  '["A"]'::jsonb,
  'Solar exposure varies by orientation and can affect the amount and timing of heat entering a space through windows.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why are room-by-room loads useful when designing an HVAC system?',
  '[{"key":"A","text":"They help determine how much heating, cooling, and airflow individual spaces require"},{"key":"B","text":"They eliminate the need to select equipment"},{"key":"C","text":"They determine breaker size automatically"},{"key":"D","text":"They are used only to calculate refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Room-by-room loads help distribute system capacity and airflow according to the needs of individual spaces.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician is gathering information for a load calculation. Which information is MOST useful?',
  '[{"key":"A","text":"Actual dimensions, insulation, windows, doors, orientation, and construction characteristics"},{"key":"B","text":"Only the existing equipment model number"},{"key":"C","text":"Only the floor-area estimate from memory"},{"key":"D","text":"Only the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable load calculation depends on accurate information about the building and its thermal characteristics.'
),
(
  10,
  'multiple_choice',
  'application',
  'A home received major insulation and window upgrades after the existing HVAC system was installed. What should be recognized before recommending the same equipment size?',
  '[{"key":"A","text":"The building load may have changed and should be reevaluated"},{"key":"B","text":"The old equipment size must always be reused"},{"key":"C","text":"The new windows determine refrigerant type"},{"key":"D","text":"Insulation changes do not affect HVAC load"}]'::jsonb,
  '["A"]'::jsonb,
  'Envelope improvements can reduce heating and cooling loads, so previous equipment size is not automatically the correct basis for replacement.'
),
(
  11,
  'multiple_choice',
  'application',
  'Supply ducts run through a very hot unconditioned attic. Why can that matter to system design?',
  '[{"key":"A","text":"Duct heat gain or loss can affect the load the system must serve and the air delivered to the rooms"},{"key":"B","text":"Attic ducts eliminate the need for room loads"},{"key":"C","text":"Duct location determines compressor voltage"},{"key":"D","text":"Duct location has no effect on system performance"}]'::jsonb,
  '["A"]'::jsonb,
  'Ducts outside conditioned space can experience thermal gains or losses that should be considered in system design.'
),
(
  12,
  'multiple_choice',
  'application',
  'A conditioned addition is built onto a house. What is the BEST approach before deciding whether the existing HVAC system can serve it?',
  '[{"key":"A","text":"Evaluate the added heating and cooling load and the capability of the existing system"},{"key":"B","text":"Add a supply register without reviewing load"},{"key":"C","text":"Increase blower speed automatically"},{"key":"D","text":"Assume the existing system has enough unused capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Added conditioned space changes the building load and should be evaluated before existing system capacity is assumed to be adequate.'
),
(
  13,
  'multiple_choice',
  'application',
  'Two rooms are the same size, but one has large west-facing glass and the other has little exterior glass. Should their cooling loads automatically be assumed equal?',
  '[{"key":"A","text":"No, differences in solar exposure and envelope characteristics can create different room loads"},{"key":"B","text":"Yes, room area is the only factor that matters"},{"key":"C","text":"Yes, if both rooms use the same thermostat"},{"key":"D","text":"No, because the rooms require different refrigerants"}]'::jsonb,
  '["A"]'::jsonb,
  'Room area alone does not determine load; exposure, fenestration, construction, and other factors can produce substantially different requirements.'
),
(
  14,
  'multiple_choice',
  'application',
  'Why should a technician avoid estimating equipment size from square footage alone?',
  '[{"key":"A","text":"Buildings with the same floor area can have very different loads because of construction, climate, orientation, infiltration, and other factors"},{"key":"B","text":"Square footage is used only for electrical calculations"},{"key":"C","text":"Equipment size is determined only by thermostat type"},{"key":"D","text":"Every building of the same size has the same load"}]'::jsonb,
  '["A"]'::jsonb,
  'Floor area is only one input; actual heating and cooling demand depends on many building and operating characteristics.'
),
(
  15,
  'multiple_choice',
  'application',
  'A load-calculation worksheet lists incorrect window dimensions for several rooms. What is the BEST response?',
  '[{"key":"A","text":"Correct the building information before relying on the calculated loads"},{"key":"B","text":"Ignore the dimensions if the total floor area is correct"},{"key":"C","text":"Increase equipment size to compensate"},{"key":"D","text":"Change the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect building inputs can produce incorrect load results and should be corrected before design decisions are made.'
),
(
  16,
  'multiple_choice',
  'application',
  'A room has a calculated cooling load that is much higher than another room of similar size. What should the technician do before assuming the calculation is wrong?',
  '[{"key":"A","text":"Review the room inputs such as glass area, orientation, envelope, exposure, and other load factors"},{"key":"B","text":"Make both room loads equal"},{"key":"C","text":"Ignore the calculated difference"},{"key":"D","text":"Increase the whole-building equipment size immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Different room characteristics can legitimately create different loads, so the inputs should be reviewed before changing the result.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is replacing a 20-year-old air conditioner. Since the original installation, the home has received new windows, added insulation, and air-sealing improvements. The owner asks for the same tonnage. What is the BEST response?',
  '[{"key":"A","text":"Use a current load evaluation rather than assuming the original equipment size is still appropriate"},{"key":"B","text":"Install the same tonnage because replacement equipment must always match the old unit"},{"key":"C","text":"Install a larger unit because newer homes require more capacity"},{"key":"D","text":"Select equipment from square footage only"}]'::jsonb,
  '["A"]'::jsonb,
  'Significant changes to the building envelope can change heating and cooling demand, so the old equipment size should not automatically control the replacement decision.'
),
(
  18,
  'scenario',
  'scenario',
  'A system keeps the overall house near setpoint, but one west-facing bedroom becomes uncomfortable every afternoon. What is the BEST design-related next step?',
  '[{"key":"A","text":"Review that room load, solar exposure, required airflow, and air-distribution conditions"},{"key":"B","text":"Immediately replace the entire system with a larger unit"},{"key":"C","text":"Lower the thermostat for the entire house"},{"key":"D","text":"Increase refrigerant charge without testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A room-specific comfort problem should be evaluated using the room load and air-distribution conditions before increasing total system capacity.'
),
(
  19,
  'scenario',
  'scenario',
  'A contractor plans to condition a newly finished attic by connecting two new supply branches to the existing system. No load calculation has been updated. What is the BEST response?',
  '[{"key":"A","text":"Determine the attic load and verify that the existing equipment and distribution system can support the added demand"},{"key":"B","text":"Add the branches because any existing system can serve additional space"},{"key":"C","text":"Increase blower speed to maximum"},{"key":"D","text":"Reduce return-air capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding conditioned space changes both capacity and air-distribution requirements and should be evaluated before modifying the system.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer says the safest replacement choice is the largest unit that will fit because it will handle any weather. What is the BEST Level 1 response?',
  '[{"key":"A","text":"Equipment should be selected from the calculated building load and appropriate design information rather than simply choosing the largest unit"},{"key":"B","text":"The largest available unit is always best"},{"key":"C","text":"Equipment size does not affect comfort or operation"},{"key":"D","text":"Square footage alone should determine the largest acceptable unit"}]'::jsonb,
  '["A"]'::jsonb,
  'System capacity should be matched to the calculated load and application; unnecessary oversizing is not a substitute for proper load calculation and system design.'
);

create temporary table _seed_hvac_load_calculations_system_design_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_load_calculations_system_design_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Load Calculations & HVAC System Design?',
  '[{"key":"A","text":"Using square footage alone to estimate system size"},{"key":"B","text":"Reviewing load inputs, recognizing design impacts, validating field conditions, and identifying when load or distribution assumptions need correction"},{"key":"C","text":"Selecting equipment only by matching the existing nameplate"},{"key":"D","text":"Increasing capacity whenever a comfort complaint occurs"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance includes independent review of load and design information, field validation, and sound judgment about when assumptions or system design need correction.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is a room-by-room load calculation important when evaluating air distribution?',
  '[{"key":"A","text":"It provides the basis for determining the heating, cooling, and airflow needs of individual spaces"},{"key":"B","text":"It determines refrigerant charge automatically"},{"key":"C","text":"It eliminates the need to inspect ductwork"},{"key":"D","text":"It is used only to determine total equipment voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Room-by-room loads provide the design basis for assigning airflow and capacity to individual spaces rather than treating the building as one uniform load.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should latent load be considered separately from sensible load in cooling design?',
  '[{"key":"A","text":"Because moisture-removal demand and temperature-reduction demand are different parts of the total cooling requirement"},{"key":"B","text":"Because latent load determines electrical phase"},{"key":"C","text":"Because sensible load applies only to heating"},{"key":"D","text":"Because latent load does not affect comfort"}]'::jsonb,
  '["A"]'::jsonb,
  'Cooling design must account for both temperature control and moisture removal because each affects comfort and system performance.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should equipment capacity be evaluated at the project design conditions rather than from nominal capacity alone?',
  '[{"key":"A","text":"Actual equipment performance can vary with indoor and outdoor operating conditions"},{"key":"B","text":"Nominal capacity always equals delivered capacity"},{"key":"C","text":"Design conditions are used only for duct sizing"},{"key":"D","text":"Equipment performance is unaffected by operating conditions"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment performance changes with operating conditions, so system selection should be checked against the conditions the equipment is expected to serve.'
),
(
  5,
  'multiple_choice',
  'application',
  'A load calculation shows a much higher cooling load than expected. Which review should happen before accepting the result?',
  '[{"key":"A","text":"Verify design conditions, dimensions, envelope values, window data, infiltration assumptions, internal gains, and duct conditions"},{"key":"B","text":"Increase equipment size immediately"},{"key":"C","text":"Use the existing equipment size instead"},{"key":"D","text":"Delete the room-by-room calculation"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected load results should be validated by reviewing the underlying inputs before they are used for equipment or distribution decisions.'
),
(
  6,
  'multiple_choice',
  'application',
  'A bedroom has a calculated airflow requirement that is much greater than the existing supply branch can deliver. What is the BEST design response?',
  '[{"key":"A","text":"Evaluate the branch duct, available static pressure, register selection, and overall distribution design against the room load"},{"key":"B","text":"Ignore the room load"},{"key":"C","text":"Increase total equipment tonnage only"},{"key":"D","text":"Close registers in other rooms permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'A room airflow mismatch should be addressed through the distribution design and available system performance rather than by ignoring the calculated requirement.'
),
(
  7,
  'multiple_choice',
  'application',
  'A replacement system has the correct total nominal capacity, but manufacturer data shows reduced cooling capacity at the project design condition. What should be done?',
  '[{"key":"A","text":"Use the manufacturer performance data to verify that delivered capacity still satisfies the design load"},{"key":"B","text":"Ignore the performance data because nominal size matches"},{"key":"C","text":"Select equipment by cabinet dimensions only"},{"key":"D","text":"Increase thermostat differential"}]'::jsonb,
  '["A"]'::jsonb,
  'Nominal equipment size does not guarantee adequate capacity at actual design conditions, so performance data should be checked.'
),
(
  8,
  'multiple_choice',
  'application',
  'A home has significant duct leakage outside the conditioned space. How should that affect design review?',
  '[{"key":"A","text":"The duct losses and their impact on delivered capacity and room airflow should be evaluated rather than ignored"},{"key":"B","text":"Duct leakage has no relationship to load or comfort"},{"key":"C","text":"The system should automatically be upsized"},{"key":"D","text":"Only the thermostat needs adjustment"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct losses outside conditioned space can affect the load seen by the system and the amount of conditioned air that actually reaches the rooms.'
),
(
  9,
  'multiple_choice',
  'application',
  'A room load is correct, but the room still cannot receive its required airflow because total external static pressure is excessive. What should the technician recognize?',
  '[{"key":"A","text":"The distribution system must be corrected or redesigned so required airflow can be delivered within equipment capability"},{"key":"B","text":"The room load should be reduced on paper"},{"key":"C","text":"The equipment should always be replaced with a larger unit"},{"key":"D","text":"Static pressure does not affect airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'A correct load calculation still requires a distribution system capable of delivering the needed airflow within the blower performance envelope.'
),
(
  10,
  'multiple_choice',
  'application',
  'A calculated heating load is far below the output of the existing furnace. What is the BEST replacement-design approach?',
  '[{"key":"A","text":"Select replacement equipment based on the current load and appropriate equipment performance rather than automatically matching the old input or output rating"},{"key":"B","text":"Match the old furnace size exactly"},{"key":"C","text":"Select the largest furnace that fits"},{"key":"D","text":"Ignore the heating load"}]'::jsonb,
  '["A"]'::jsonb,
  'Existing equipment size is not proof of current design need; replacement selection should follow the calculated load and equipment performance.'
),
(
  11,
  'multiple_choice',
  'application',
  'A load calculation assumes all ducts are inside conditioned space, but field inspection shows most supply ductwork is in a vented attic. What should happen?',
  '[{"key":"A","text":"Correct the duct-location assumptions and reevaluate the load and distribution design"},{"key":"B","text":"Leave the calculation unchanged"},{"key":"C","text":"Increase thermostat setpoint"},{"key":"D","text":"Reduce return-air size"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct location can materially affect thermal losses and gains, so incorrect duct assumptions should be corrected before relying on the calculation.'
),
(
  12,
  'scenario',
  'scenario',
  'A home has a 3-ton air conditioner, and the new load calculation shows a 2-ton design cooling load. The homeowner insists the existing size must be correct because it has been there for years. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Validate the load inputs and equipment performance, then explain that existing equipment size is not a substitute for a current load-based selection"},{"key":"B","text":"Install another 3-ton unit automatically"},{"key":"C","text":"Select a 4-ton unit for extra reserve"},{"key":"D","text":"Discard the load calculation"}]'::jsonb,
  '["A"]'::jsonb,
  'A senior technician should validate the calculation and base the recommendation on current load and application requirements rather than historical equipment size alone.'
),
(
  13,
  'scenario',
  'scenario',
  'A second-floor bedroom overheats every afternoon. The room-by-room load shows a high solar gain, but the installed supply airflow is well below the design requirement. What is the BEST response?',
  '[{"key":"A","text":"Address the airflow and distribution deficiency for that room before increasing total system capacity"},{"key":"B","text":"Replace the entire system with a larger unit"},{"key":"C","text":"Lower the whole-house thermostat permanently"},{"key":"D","text":"Ignore the room load because the total load is acceptable"}]'::jsonb,
  '["A"]'::jsonb,
  'The problem is consistent with inadequate delivery to a high-load room, so distribution should be corrected before total capacity is increased.'
),
(
  14,
  'scenario',
  'scenario',
  'A load calculation was completed using default window values, but field verification shows large areas of high-performance low-e glass instead. What is the BEST response?',
  '[{"key":"A","text":"Update the fenestration inputs and rerun the calculation before final equipment selection"},{"key":"B","text":"Keep the original load because window details are minor"},{"key":"C","text":"Increase equipment capacity as a safety factor"},{"key":"D","text":"Use square footage only"}]'::jsonb,
  '["A"]'::jsonb,
  'Window area and performance affect heat gain and heat loss, so inaccurate fenestration inputs should be corrected.'
),
(
  15,
  'scenario',
  'scenario',
  'A new addition will be served by the existing system. The load analysis shows enough total equipment capacity, but the existing trunk and branch system cannot deliver the required airflow to the new rooms. What is the BEST conclusion?',
  '[{"key":"A","text":"Available equipment capacity alone does not make the design acceptable; the distribution system must also be capable of delivering the required airflow"},{"key":"B","text":"The addition can be connected without changes"},{"key":"C","text":"The room loads should be reduced until they match available airflow"},{"key":"D","text":"Only thermostat programming needs to change"}]'::jsonb,
  '["A"]'::jsonb,
  'System design must satisfy both capacity and distribution requirements; adequate equipment output does not correct an undersized or constrained duct system.'
),
(
  16,
  'scenario',
  'scenario',
  'A house has high indoor humidity even though the cooling system maintains temperature. Review shows the equipment is substantially oversized relative to the calculated sensible and latent loads. What is the BEST design interpretation?',
  '[{"key":"A","text":"Oversizing may contribute to short cycling and inadequate moisture removal, so equipment selection and system operation should be reevaluated"},{"key":"B","text":"Humidity proves the equipment is undersized"},{"key":"C","text":"The only solution is a larger blower"},{"key":"D","text":"Latent load is unrelated to humidity"}]'::jsonb,
  '["A"]'::jsonb,
  'An oversized cooling system can satisfy sensible demand quickly while providing insufficient run time for moisture removal.'
),
(
  17,
  'scenario',
  'scenario',
  'A load report shows unusually high infiltration load. During site review, the building is found to have been recently air sealed and tested. What is the BEST response?',
  '[{"key":"A","text":"Verify and update the infiltration assumptions using the best available project information before relying on the load result"},{"key":"B","text":"Keep the higher infiltration value as extra safety factor"},{"key":"C","text":"Increase equipment capacity automatically"},{"key":"D","text":"Remove infiltration from the calculation entirely"}]'::jsonb,
  '["A"]'::jsonb,
  'Load inputs should reflect the actual building condition rather than outdated assumptions or arbitrary safety factors.'
),
(
  18,
  'scenario',
  'scenario',
  'A senior technician reviews a replacement proposal and sees that the selected heat pump satisfies the cooling load but does not provide adequate heating capacity at the project winter design condition. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate equipment selection and any required supplemental heat strategy before approving the design"},{"key":"B","text":"Approve it because cooling capacity is adequate"},{"key":"C","text":"Use the nominal heating rating only"},{"key":"D","text":"Reduce the calculated heating load"}]'::jsonb,
  '["A"]'::jsonb,
  'A heat-pump application should be evaluated against both cooling and heating requirements at the relevant design conditions.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds that several room airflow targets were created by dividing total system airflow equally among rooms rather than using room loads. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Reestablish airflow targets from the room-by-room design requirements and evaluate whether the duct system can deliver them"},{"key":"B","text":"Keep equal airflow because all rooms should receive the same amount"},{"key":"C","text":"Increase total airflow without reviewing room needs"},{"key":"D","text":"Delete the room load data"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow distribution should reflect the load of each space rather than an equal split that ignores differences in exposure and construction.'
),
(
  20,
  'scenario',
  'scenario',
  'A comfort complaint leads a technician to recommend larger equipment, but the load calculation shows adequate system capacity. Field testing reveals high static pressure and low delivered airflow. What is the BEST response?',
  '[{"key":"A","text":"Correct the airflow and distribution problem before recommending additional equipment capacity"},{"key":"B","text":"Install larger equipment immediately"},{"key":"C","text":"Increase the load calculation until it matches the existing problem"},{"key":"D","text":"Ignore the static-pressure finding"}]'::jsonb,
  '["A"]'::jsonb,
  'When calculated capacity is adequate but delivered airflow is deficient, the design and distribution problem should be corrected rather than masking it with additional capacity.'
);

create temporary table _seed_hvac_load_calculations_system_design_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_load_calculations_system_design_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 4 performance in Load Calculations & HVAC System Design?',
  '[{"key":"A","text":"Selecting equipment primarily from square footage"},{"key":"B","text":"Developing and validating load-based system designs, integrating equipment performance and air distribution, and resolving complex design constraints"},{"key":"C","text":"Matching existing equipment size without recalculation"},{"key":"D","text":"Adding capacity whenever uncertainty exists"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance requires system-level design judgment that connects calculated loads, equipment performance, distribution requirements, field conditions, and project constraints.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why must equipment selection be coordinated with both sensible and latent cooling loads?',
  '[{"key":"A","text":"Because the selected system must satisfy temperature-control and moisture-removal requirements at the design condition"},{"key":"B","text":"Because sensible and latent loads determine electrical service size only"},{"key":"C","text":"Because latent load can always be ignored in dry-bulb design"},{"key":"D","text":"Because nominal tonnage guarantees both requirements are met"}]'::jsonb,
  '["A"]'::jsonb,
  'A cooling design must address both sensible and latent demand so the selected equipment can provide appropriate temperature and humidity control.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the primary relationship between room-by-room loads and duct-system design?',
  '[{"key":"A","text":"Room loads establish the required capacity and airflow distribution that the duct system must be designed to deliver"},{"key":"B","text":"Room loads are unrelated to air distribution"},{"key":"C","text":"Duct sizes determine the room loads"},{"key":"D","text":"All rooms should receive equal airflow regardless of load"}]'::jsonb,
  '["A"]'::jsonb,
  'Room-by-room loads establish how heating and cooling capacity should be distributed, which directly informs airflow targets and duct-system design.'
),
(
  4,
  'multiple_choice',
  'application',
  'A calculated cooling load is 31,000 Btu/h. Candidate equipment has a nominal rating near that value, but published performance at the project design condition is lower. What should drive the selection?',
  '[{"key":"A","text":"The equipment performance at the applicable design condition compared with the calculated sensible and latent requirements"},{"key":"B","text":"Nominal tonnage alone"},{"key":"C","text":"The size of the existing unit"},{"key":"D","text":"The largest cabinet that fits"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should be evaluated using its actual performance at the expected operating conditions rather than nominal capacity alone.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project load calculation contains large safety factors added to window area, infiltration, occupancy, and design temperature. What is the BEST design response?',
  '[{"key":"A","text":"Replace arbitrary safety factors with defensible project inputs so equipment selection is based on the calculated design load"},{"key":"B","text":"Keep every safety factor because larger loads always improve design"},{"key":"C","text":"Add another equipment-sizing safety factor"},{"key":"D","text":"Use square footage instead of the calculation"}]'::jsonb,
  '["A"]'::jsonb,
  'Stacked arbitrary safety factors can inflate calculated loads and lead to oversizing; design inputs should reflect defensible project conditions.'
),
(
  6,
  'multiple_choice',
  'application',
  'A room requires substantially more cooling airflow than neighboring rooms because of glazing and exposure. What should the designer do?',
  '[{"key":"A","text":"Use the room load to establish its airflow requirement and design the branch, terminal, and balancing strategy to deliver it"},{"key":"B","text":"Assign equal airflow to every room"},{"key":"C","text":"Increase whole-building equipment size only"},{"key":"D","text":"Reduce the room load to match the existing branch"}]'::jsonb,
  '["A"]'::jsonb,
  'Air distribution should follow room-specific design requirements rather than forcing room loads to fit an arbitrary airflow allocation.'
),
(
  7,
  'multiple_choice',
  'application',
  'A heat-pump selection meets the cooling requirement but has insufficient heating capacity at winter design conditions. What is the BEST design response?',
  '[{"key":"A","text":"Evaluate a different equipment selection or an appropriately designed supplemental heat strategy using the heating-load requirement"},{"key":"B","text":"Approve the selection because cooling is adequate"},{"key":"C","text":"Reduce the calculated heating load"},{"key":"D","text":"Use nominal cooling tonnage as the heating-capacity value"}]'::jsonb,
  '["A"]'::jsonb,
  'Heating performance must be checked against the heating load at the applicable outdoor condition, with supplemental heat incorporated when required by the design.'
),
(
  8,
  'multiple_choice',
  'application',
  'A proposed duct design can deliver the required total airflow only at a static pressure above the selected air handler performance range. What should happen?',
  '[{"key":"A","text":"Revise the distribution system or equipment selection so required airflow can be delivered within the available blower performance"},{"key":"B","text":"Keep the design because total airflow is only theoretical"},{"key":"C","text":"Reduce the calculated room airflow targets"},{"key":"D","text":"Increase equipment tonnage without changing the duct system"}]'::jsonb,
  '["A"]'::jsonb,
  'The equipment and distribution system must work together; a design that requires airflow outside the blower capability is not a viable system design.'
),
(
  9,
  'multiple_choice',
  'application',
  'A building has a significant ventilation requirement. How should that be treated in load and system design?',
  '[{"key":"A","text":"Account for the sensible and latent effects of the required outdoor air and ensure the system strategy can condition it"},{"key":"B","text":"Ignore ventilation because it is separate from HVAC load"},{"key":"C","text":"Count ventilation only during heating"},{"key":"D","text":"Increase nominal tonnage without calculating the ventilation effect"}]'::jsonb,
  '["A"]'::jsonb,
  'Outdoor ventilation air can add sensible and latent load and must be incorporated into the overall system design where applicable.'
),
(
  10,
  'multiple_choice',
  'application',
  'A design shows acceptable whole-building capacity but several rooms have inadequate design airflow. What is the BEST conclusion?',
  '[{"key":"A","text":"Whole-building capacity alone does not validate the design; room-level distribution must also satisfy the calculated requirements"},{"key":"B","text":"The design is acceptable because total capacity is sufficient"},{"key":"C","text":"The room loads should be deleted"},{"key":"D","text":"All room airflow values should be averaged"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete system design must satisfy both total building demand and room-by-room delivery requirements.'
),
(
  11,
  'scenario',
  'scenario',
  'A designer receives plans for a high-performance home with upgraded insulation, low-e glazing, tight construction, and dedicated ventilation. The builder wants to size the system using the tonnage from a similar older home. What is the BEST response?',
  '[{"key":"A","text":"Perform a project-specific load calculation using the actual enclosure, infiltration, ventilation, orientation, and design-condition inputs before selecting equipment"},{"key":"B","text":"Use the older home tonnage because the floor plans are similar"},{"key":"C","text":"Add one ton for the tighter construction"},{"key":"D","text":"Use floor area alone"}]'::jsonb,
  '["A"]'::jsonb,
  'High-performance envelope and ventilation characteristics can materially change sensible and latent loads, so the project requires its own load-based design.'
),
(
  12,
  'scenario',
  'scenario',
  'A cooling load is dominated by latent demand in a humid climate. A candidate system easily exceeds the sensible requirement but has limited moisture-removal capability at the selected operating condition. What is the BEST design decision?',
  '[{"key":"A","text":"Select or configure equipment that satisfies both sensible and latent requirements rather than relying on total capacity alone"},{"key":"B","text":"Select it because total capacity is adequate"},{"key":"C","text":"Ignore latent load because the thermostat controls temperature"},{"key":"D","text":"Increase supply airflow as much as possible without review"}]'::jsonb,
  '["A"]'::jsonb,
  'A system that satisfies total or sensible capacity but cannot address the project latent requirement may fail to provide acceptable humidity control.'
),
(
  13,
  'scenario',
  'scenario',
  'A designer discovers that a load calculation assumed all ductwork was inside conditioned space, but the final architectural layout places the ducts in a hot vented attic. What is the BEST response?',
  '[{"key":"A","text":"Revise the load and distribution design using the actual duct location and associated thermal effects before final equipment selection"},{"key":"B","text":"Leave the load unchanged because duct location affects installation only"},{"key":"C","text":"Increase equipment one nominal size automatically"},{"key":"D","text":"Reduce room airflow targets"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct location can affect thermal gains, losses, and delivered capacity, so the design should reflect the actual installation conditions.'
),
(
  14,
  'scenario',
  'scenario',
  'A large west-facing living area has a sharp afternoon cooling peak, while most of the house has substantially lower loads at that time. What is the BEST system-design response?',
  '[{"key":"A","text":"Evaluate the room peak, airflow requirement, zoning or distribution strategy, glazing characteristics, and system diversity before increasing total equipment capacity"},{"key":"B","text":"Size the entire system solely from the living-area peak"},{"key":"C","text":"Give every room the same airflow"},{"key":"D","text":"Ignore solar orientation"}]'::jsonb,
  '["A"]'::jsonb,
  'A localized peak should be addressed through room-level load and distribution analysis rather than automatically driving unnecessary whole-building capacity.'
),
(
  15,
  'scenario',
  'scenario',
  'A replacement project has a calculated cooling load significantly below the existing equipment size. Runtime history also shows frequent short cycles during normal summer weather. What is the BEST design approach?',
  '[{"key":"A","text":"Validate the current load and use appropriate equipment performance data to select capacity near the actual design requirement rather than matching the oversized existing system"},{"key":"B","text":"Match the existing size because it already operates"},{"key":"C","text":"Increase capacity to reduce cycling"},{"key":"D","text":"Ignore runtime history"}]'::jsonb,
  '["A"]'::jsonb,
  'The combination of a validated lower load and frequent short cycling supports reevaluating equipment size rather than perpetuating historical oversizing.'
),
(
  16,
  'scenario',
  'scenario',
  'A renovation changes several bedrooms into a high-occupancy entertainment area with additional lighting and equipment. The envelope remains unchanged. What is the BEST load-design response?',
  '[{"key":"A","text":"Update the affected space loads for the new occupancy and internal gains and reevaluate system and airflow requirements"},{"key":"B","text":"Keep the previous room loads because the exterior walls did not change"},{"key":"C","text":"Increase the whole-building system one ton automatically"},{"key":"D","text":"Ignore internal gains in occupied spaces"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes in occupancy, lighting, and equipment can alter internal gains even when the building envelope is unchanged.'
),
(
  17,
  'scenario',
  'scenario',
  'A project uses a variable-capacity heat pump. At design review, the team compares only the unit maximum nominal capacity with the building load. What should the design engineer add to the review?',
  '[{"key":"A","text":"Verify manufacturer performance across the relevant heating and cooling design conditions and confirm the selected system can meet the required sensible, latent, and heating demands"},{"key":"B","text":"Nothing; maximum nominal capacity is sufficient"},{"key":"C","text":"Use cabinet size as the final selection criterion"},{"key":"D","text":"Ignore part-load and design-condition performance"}]'::jsonb,
  '["A"]'::jsonb,
  'Variable-capacity equipment still requires verification against project loads and manufacturer performance at the conditions where the system must operate.'
),
(
  18,
  'scenario',
  'scenario',
  'A completed load calculation appears reasonable, but field review finds several major discrepancies between the plans and actual construction, including window area, ceiling height, and insulation levels. What is the BEST response?',
  '[{"key":"A","text":"Correct the load inputs to match verified field conditions and rerun the design before finalizing equipment and distribution"},{"key":"B","text":"Use the original calculation because it is already complete"},{"key":"C","text":"Add a general safety factor instead of correcting inputs"},{"key":"D","text":"Select equipment from the existing unit"}]'::jsonb,
  '["A"]'::jsonb,
  'A design is only as reliable as its inputs, so material discrepancies between assumed and actual construction should be corrected before final selection.'
),
(
  19,
  'scenario',
  'scenario',
  'A zoning proposal serves three areas with very different load profiles. Under a low-load condition, only the smallest zone may call. What is the BEST Level 4 design consideration?',
  '[{"key":"A","text":"Evaluate minimum equipment capacity, minimum airflow, zone control behavior, bypass or pressure-management strategy if applicable, and the smallest active-zone load"},{"key":"B","text":"Size equipment from the sum of all zone peaks and ignore minimum operation"},{"key":"C","text":"Assume all zones will always call together"},{"key":"D","text":"Give each zone identical airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Zoned systems must be evaluated at both peak and minimum operating conditions so equipment and airflow remain compatible when only a small portion of the building is calling.'
),
(
  20,
  'scenario',
  'scenario',
  'A sales proposal promises a larger replacement system to solve comfort complaints. The load calculation shows adequate existing capacity, while field information shows poor room airflow, excessive static pressure, and significant duct leakage. What is the BEST Level 4 recommendation?',
  '[{"key":"A","text":"Base the proposal on correcting the distribution deficiencies and selecting equipment from the validated load rather than selling additional capacity as the primary solution"},{"key":"B","text":"Install the larger system because more capacity will overcome any duct problem"},{"key":"C","text":"Ignore static pressure because it is an installation issue"},{"key":"D","text":"Increase the calculated load until it supports the proposed equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'A design-and-sales recommendation should address the verified root causes of poor performance and use the validated load as the basis for equipment selection.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'f00a835b-015b-4088-834a-3e0a2b451c45';
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
      and c.name = 'Load Calculations & HVAC System Design'
      and c.is_current = true
  ) then
    raise exception 'Current Load Calculations & HVAC System Design Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current HVAC Service & Repair Technician L1 Load Calculations & HVAC System Design requirement not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Senior / Lead HVAC Technician L3 Load Calculations & HVAC System Design requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L4 Load Calculations & HVAC System Design requirement not found';
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
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'Load Calculations & HVAC System Design — Level 1 Competency Assessment';

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
    select * from _seed_hvac_load_calculations_system_design_l1_questions
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
        'Load Calculations & HVAC System Design',
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
      'IntegrateU Load Calculations & HVAC System Design L1 production assessment v1.0.',
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
      v_service_role_id
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
        'Load Calculations & HVAC System Design',
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
        'IntegrateU Load Calculations & HVAC System Design L1 production assessment v1.0.',
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
  v_role_template_id := v_senior_role_id;
  v_assessment_name := 'Load Calculations & HVAC System Design — Level 3 Competency Assessment';

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
    select * from _seed_hvac_load_calculations_system_design_l3_questions
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
        'Load Calculations & HVAC System Design',
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
      'IntegrateU Load Calculations & HVAC System Design L3 production assessment v1.0.',
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
        'Load Calculations & HVAC System Design',
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
        'IntegrateU Load Calculations & HVAC System Design L3 production assessment v1.0.',
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
  v_assessment_name := 'Load Calculations & HVAC System Design — Level 4 Competency Assessment';

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
    select * from _seed_hvac_load_calculations_system_design_l4_questions
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
        'Load Calculations & HVAC System Design',
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
      'IntegrateU Load Calculations & HVAC System Design L4 production assessment v1.0.',
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
        'Load Calculations & HVAC System Design',
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
        'IntegrateU Load Calculations & HVAC System Design L4 production assessment v1.0.',
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
   'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 HVAC Service & Repair Technician -> 20
--   Level 3 Senior / Lead HVAC Technician    -> 20
--   Level 4 HVAC Design & Sales Engineer     -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid
    and a.target_level in (1,3,4)
    and aq.master_competency_template_id =
      'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid
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
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid;

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
    'f00a835b-015b-4088-834a-3e0a2b451c45'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
