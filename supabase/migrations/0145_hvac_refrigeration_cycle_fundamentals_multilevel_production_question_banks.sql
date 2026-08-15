-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0145_hvac_refrigeration_cycle_fundamentals_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Refrigeration Cycle Fundamentals
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Service & Repair Technician -> Level 3
--   HVAC Design & Sales Engineer     -> Level 3
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

create temporary table _seed_hvac_refrigeration_cycle_fundamentals_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigeration_cycle_fundamentals_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of the refrigeration cycle in an HVAC system?',
  '[{"key":"A","text":"To move heat from one location to another"},{"key":"B","text":"To create electrical power"},{"key":"C","text":"To increase duct static pressure"},{"key":"D","text":"To remove all moisture from the building"}]'::jsonb,
  '["A"]'::jsonb,
  'The refrigeration cycle transfers heat by circulating refrigerant through changes in pressure, temperature, and physical state.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Which four major components are commonly part of a basic vapor-compression refrigeration cycle?',
  '[{"key":"A","text":"Compressor, condenser, metering device, and evaporator"},{"key":"B","text":"Thermostat, blower, filter, and drain"},{"key":"C","text":"Disconnect, transformer, relay, and fuse"},{"key":"D","text":"Damper, diffuser, grille, and register"}]'::jsonb,
  '["A"]'::jsonb,
  'A basic vapor-compression refrigeration cycle uses the compressor, condenser, metering device, and evaporator as its four primary components.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does the compressor do in the refrigeration cycle?',
  '[{"key":"A","text":"It raises refrigerant vapor pressure and moves refrigerant through the system"},{"key":"B","text":"It meters liquid refrigerant into the evaporator"},{"key":"C","text":"It removes heat from condenser air"},{"key":"D","text":"It drains condensate from the coil"}]'::jsonb,
  '["A"]'::jsonb,
  'The compressor draws in lower-pressure vapor and delivers higher-pressure vapor to continue refrigerant circulation.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the main function of the condenser?',
  '[{"key":"A","text":"To reject heat from the refrigerant to another medium"},{"key":"B","text":"To lower refrigerant pressure before the evaporator"},{"key":"C","text":"To increase indoor airflow"},{"key":"D","text":"To control thermostat temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'The condenser rejects heat and allows high-pressure refrigerant vapor to condense into liquid under normal operation.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the main function of the evaporator?',
  '[{"key":"A","text":"To absorb heat into the refrigerant"},{"key":"B","text":"To raise refrigerant pressure"},{"key":"C","text":"To reject heat outdoors"},{"key":"D","text":"To increase electrical voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'The evaporator absorbs heat from the air or other medium being cooled as refrigerant evaporates.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the basic function of a refrigerant metering device?',
  '[{"key":"A","text":"To control refrigerant flow into the evaporator and create a pressure reduction"},{"key":"B","text":"To compress refrigerant vapor"},{"key":"C","text":"To reject heat from the condenser"},{"key":"D","text":"To move supply air through ductwork"}]'::jsonb,
  '["A"]'::jsonb,
  'The metering device regulates refrigerant flow and creates the pressure difference needed for low-side evaporation.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'In a typical cooling cycle, what form of refrigerant normally enters the compressor?',
  '[{"key":"A","text":"Low-pressure vapor"},{"key":"B","text":"High-pressure liquid"},{"key":"C","text":"Low-pressure liquid only"},{"key":"D","text":"Condensed water"}]'::jsonb,
  '["A"]'::jsonb,
  'The compressor is designed to receive refrigerant vapor from the evaporator side of the system.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What happens to refrigerant as it absorbs heat in the evaporator?',
  '[{"key":"A","text":"It changes from liquid toward vapor as heat is absorbed"},{"key":"B","text":"It becomes higher-pressure liquid because of the evaporator"},{"key":"C","text":"It becomes electrical energy"},{"key":"D","text":"It stops moving through the system"}]'::jsonb,
  '["A"]'::jsonb,
  'As refrigerant absorbs heat in the evaporator, the liquid portion boils and changes toward vapor.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is tracing refrigerant flow on a cooling system. Which component should normally come directly after the compressor?',
  '[{"key":"A","text":"Condenser"},{"key":"B","text":"Evaporator"},{"key":"C","text":"Metering device"},{"key":"D","text":"Thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'In the normal cooling-cycle flow path, high-pressure vapor leaves the compressor and enters the condenser.'
),
(
  10,
  'multiple_choice',
  'application',
  'Which sequence correctly represents the basic refrigerant flow path in a standard cooling cycle?',
  '[{"key":"A","text":"Compressor → condenser → metering device → evaporator → compressor"},{"key":"B","text":"Compressor → evaporator → condenser → thermostat → compressor"},{"key":"C","text":"Condenser → compressor → evaporator → blower → condenser"},{"key":"D","text":"Evaporator → thermostat → compressor → filter → evaporator"}]'::jsonb,
  '["A"]'::jsonb,
  'The standard vapor-compression cooling cycle flows from compressor to condenser, through the metering device, through the evaporator, and back to the compressor.'
),
(
  11,
  'multiple_choice',
  'application',
  'An installer identifies a refrigerant line carrying hot high-pressure vapor away from the compressor. Which line is this?',
  '[{"key":"A","text":"Discharge line"},{"key":"B","text":"Suction line"},{"key":"C","text":"Condensate line"},{"key":"D","text":"Thermostat line"}]'::jsonb,
  '["A"]'::jsonb,
  'The discharge line carries high-pressure, high-temperature refrigerant vapor from the compressor toward the condenser.'
),
(
  12,
  'multiple_choice',
  'application',
  'In a typical split-system cooling application, which refrigerant line normally returns vapor from the evaporator to the compressor?',
  '[{"key":"A","text":"Suction line"},{"key":"B","text":"Liquid line"},{"key":"C","text":"Condensate drain"},{"key":"D","text":"Discharge line"}]'::jsonb,
  '["A"]'::jsonb,
  'The suction line returns lower-pressure refrigerant vapor from the evaporator to the compressor.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer is asked why the outdoor condenser coil becomes warm during cooling operation. What is the BEST explanation?',
  '[{"key":"A","text":"The refrigerant is rejecting heat through the condenser"},{"key":"B","text":"The condenser is absorbing all indoor moisture"},{"key":"C","text":"The metering device is adding heat"},{"key":"D","text":"The thermostat is heating the coil"}]'::jsonb,
  '["A"]'::jsonb,
  'The condenser releases heat that was absorbed indoors along with heat added by the compression process.'
),
(
  14,
  'multiple_choice',
  'application',
  'An installer observes that the indoor evaporator coil becomes cold during normal cooling operation. Why?',
  '[{"key":"A","text":"Low-pressure refrigerant in the evaporator absorbs heat from the indoor air"},{"key":"B","text":"The compressor sends cold liquid directly into the evaporator"},{"key":"C","text":"The condenser removes all heat before refrigerant enters the evaporator"},{"key":"D","text":"The blower lowers refrigerant pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'The evaporator operates at a lower pressure and temperature so refrigerant can absorb heat from the indoor air.'
),
(
  15,
  'multiple_choice',
  'application',
  'What happens to refrigerant pressure as it passes through the metering device?',
  '[{"key":"A","text":"It drops substantially before entering the evaporator"},{"key":"B","text":"It rises to compressor-discharge pressure"},{"key":"C","text":"It remains exactly the same"},{"key":"D","text":"It becomes unrelated to temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'The metering device separates the high-pressure side from the low-pressure side and produces a substantial pressure drop.'
),
(
  16,
  'multiple_choice',
  'application',
  'A helper asks why both pressure and temperature matter when discussing refrigerant conditions. What is the BEST explanation?',
  '[{"key":"A","text":"Refrigerant saturation temperature changes with pressure, so the two conditions are related"},{"key":"B","text":"Pressure and temperature are never related in refrigerants"},{"key":"C","text":"Temperature only matters on electrical components"},{"key":"D","text":"Pressure determines blower speed directly"}]'::jsonb,
  '["A"]'::jsonb,
  'For a refrigerant at saturation, pressure corresponds to a specific saturation temperature, making the relationship fundamental to refrigeration-cycle understanding.'
),
(
  17,
  'scenario',
  'scenario',
  'A helper is labeling the four major refrigeration components on a training diagram. The component after the condenser must reduce refrigerant pressure before the evaporator. Which component belongs there?',
  '[{"key":"A","text":"Metering device"},{"key":"B","text":"Compressor"},{"key":"C","text":"Blower motor"},{"key":"D","text":"Thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'The metering device is located between the condenser and evaporator and controls flow while reducing refrigerant pressure.'
),
(
  18,
  'scenario',
  'scenario',
  'During a basic system walkthrough, an installer explains that refrigerant leaving the evaporator should travel back toward the compressor. What state should that refrigerant normally be in?',
  '[{"key":"A","text":"Vapor"},{"key":"B","text":"Solid"},{"key":"C","text":"Condensate water"},{"key":"D","text":"High-pressure liquid"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant normally leaves the evaporator as vapor before returning through the suction line to the compressor.'
),
(
  19,
  'scenario',
  'scenario',
  'A new helper incorrectly says the evaporator removes heat from the refrigerant and the condenser adds heat to it. What is the BEST correction?',
  '[{"key":"A","text":"The evaporator absorbs heat into the refrigerant, while the condenser rejects heat from the refrigerant"},{"key":"B","text":"Both coils only increase refrigerant pressure"},{"key":"C","text":"Both coils perform the same heat-transfer function"},{"key":"D","text":"Neither coil is involved in heat transfer"}]'::jsonb,
  '["A"]'::jsonb,
  'The evaporator absorbs heat and the condenser rejects heat, which are opposite heat-transfer functions within the cycle.'
),
(
  20,
  'scenario',
  'scenario',
  'An installer is tracing a basic cooling cycle and finds high-pressure liquid leaving the condenser. What should happen next in the normal refrigerant path?',
  '[{"key":"A","text":"The refrigerant should pass through the metering device before entering the evaporator"},{"key":"B","text":"The refrigerant should return directly to the compressor suction"},{"key":"C","text":"The refrigerant should enter the condensate drain"},{"key":"D","text":"The refrigerant should flow through the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'High-pressure liquid leaving the condenser normally travels to the metering device, where its pressure is reduced before the evaporator.'
);

create temporary table _seed_hvac_refrigeration_cycle_fundamentals_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigeration_cycle_fundamentals_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes superheat in a refrigeration system?',
  '[{"key":"A","text":"The amount a refrigerant vapor temperature is above its saturation temperature at the measured pressure"},{"key":"B","text":"The amount a liquid temperature is below freezing"},{"key":"C","text":"The difference between indoor and outdoor air temperature"},{"key":"D","text":"The pressure difference across a filter"}]'::jsonb,
  '["A"]'::jsonb,
  'Superheat is the temperature of refrigerant vapor above its saturation temperature at the same pressure.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes subcooling in a refrigeration system?',
  '[{"key":"A","text":"The amount a liquid refrigerant temperature is below its saturation temperature at the measured pressure"},{"key":"B","text":"The amount vapor temperature is above room temperature"},{"key":"C","text":"The difference between suction and discharge pressure"},{"key":"D","text":"The temperature rise across the compressor motor"}]'::jsonb,
  '["A"]'::jsonb,
  'Subcooling is the temperature of liquid refrigerant below its saturation temperature at the same pressure.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is the pressure-temperature relationship important when evaluating a refrigeration cycle?',
  '[{"key":"A","text":"Because refrigerant saturation temperature corresponds to pressure and helps interpret phase-change conditions"},{"key":"B","text":"Because pressure alone identifies every system fault"},{"key":"C","text":"Because temperature does not affect refrigerant state"},{"key":"D","text":"Because airflow can be calculated directly from refrigerant pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant pressure and saturation temperature are directly related and are fundamental to understanding evaporating and condensing conditions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST description of compression in a vapor-compression refrigeration cycle?',
  '[{"key":"A","text":"The compressor raises the pressure and temperature of refrigerant vapor while moving it through the system"},{"key":"B","text":"The compressor turns high-pressure liquid into low-pressure liquid"},{"key":"C","text":"The compressor removes heat from indoor air directly"},{"key":"D","text":"The compressor meters refrigerant into the evaporator"}]'::jsonb,
  '["A"]'::jsonb,
  'The compressor takes in lower-pressure vapor and delivers higher-pressure, higher-temperature vapor to the condenser.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician measures suction pressure and converts it to saturation temperature. What additional measurement is needed to calculate evaporator outlet superheat?',
  '[{"key":"A","text":"Actual suction-line temperature near the measurement point"},{"key":"B","text":"Outdoor dry-bulb temperature only"},{"key":"C","text":"Discharge-line pressure only"},{"key":"D","text":"Supply-air temperature only"}]'::jsonb,
  '["A"]'::jsonb,
  'Superheat is determined by comparing actual vapor temperature with the saturation temperature corresponding to the measured suction pressure.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician measures liquid-line pressure and converts it to saturation temperature. What additional measurement is needed to calculate liquid-line subcooling?',
  '[{"key":"A","text":"Actual liquid-line temperature near the pressure reference point"},{"key":"B","text":"Return-air temperature only"},{"key":"C","text":"Suction-line temperature only"},{"key":"D","text":"Compressor amperage only"}]'::jsonb,
  '["A"]'::jsonb,
  'Subcooling is calculated by comparing condensing saturation temperature with the actual liquid-line temperature.'
),
(
  7,
  'multiple_choice',
  'application',
  'A system has low evaporator pressure and very high superheat. What does this combination generally indicate?',
  '[{"key":"A","text":"The evaporator may be starved of refrigerant and further diagnosis is required to determine why"},{"key":"B","text":"The evaporator is definitely flooded"},{"key":"C","text":"The compressor is definitely oversized"},{"key":"D","text":"The condenser is definitely clean"}]'::jsonb,
  '["A"]'::jsonb,
  'Low evaporating pressure combined with high superheat is consistent with insufficient refrigerant feeding through the evaporator, but the cause must still be diagnosed.'
),
(
  8,
  'multiple_choice',
  'application',
  'A system has very low superheat at the evaporator outlet. What condition should be considered?',
  '[{"key":"A","text":"The evaporator may be receiving more refrigerant than it can fully vaporize under the current load"},{"key":"B","text":"The evaporator is definitely starved"},{"key":"C","text":"The condenser fan must be oversized"},{"key":"D","text":"The thermostat is necessarily defective"}]'::jsonb,
  '["A"]'::jsonb,
  'Low superheat can indicate that refrigerant is not gaining enough sensible heat after evaporation and may suggest an overfed or low-load evaporator condition.'
),
(
  9,
  'multiple_choice',
  'application',
  'A condenser is rejecting heat poorly because airflow across the coil is restricted. What refrigeration-cycle effect is likely?',
  '[{"key":"A","text":"Condensing pressure and temperature may increase"},{"key":"B","text":"Evaporating pressure must always increase"},{"key":"C","text":"Superheat must become zero"},{"key":"D","text":"The metering device stops creating a pressure drop"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor condenser heat rejection tends to raise condensing temperature and pressure because the refrigerant must operate at a higher temperature to reject heat.'
),
(
  10,
  'multiple_choice',
  'application',
  'Indoor airflow across the evaporator is substantially reduced. What refrigeration-cycle effect may occur?',
  '[{"key":"A","text":"Evaporating temperature and pressure may decrease because the evaporator is receiving less heat load"},{"key":"B","text":"Condensing pressure must always increase"},{"key":"C","text":"Liquid-line subcooling always becomes zero"},{"key":"D","text":"Discharge pressure becomes unrelated to heat transfer"}]'::jsonb,
  '["A"]'::jsonb,
  'Reduced evaporator airflow lowers the heat available to boil refrigerant and can reduce evaporating temperature and pressure.'
),
(
  11,
  'multiple_choice',
  'application',
  'Why should a technician evaluate both refrigeration measurements and airflow conditions before deciding a system is improperly charged?',
  '[{"key":"A","text":"Airflow problems can change refrigeration pressures, temperatures, superheat, and other operating indicators"},{"key":"B","text":"Airflow has no effect on the refrigeration cycle"},{"key":"C","text":"Refrigerant charge can be determined from pressure alone under all conditions"},{"key":"D","text":"Only outdoor temperature affects refrigerant measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'Air-side load and heat transfer directly influence evaporator and condenser conditions, so charge-related measurements must be interpreted in context.'
),
(
  12,
  'scenario',
  'scenario',
  'A cooling system has low suction pressure, high superheat, and normal indoor airflow. The liquid line also shows evidence of insufficient liquid refrigerant reaching the metering device. What is the BEST next step?',
  '[{"key":"A","text":"Continue diagnosis for causes of a starved evaporator, including refrigerant quantity, liquid-line condition, and metering-device feeding"},{"key":"B","text":"Replace the compressor immediately"},{"key":"C","text":"Increase blower speed without further testing"},{"key":"D","text":"Assume the system is overcharged"}]'::jsonb,
  '["A"]'::jsonb,
  'The measured pattern is consistent with a starved evaporator, but multiple causes are possible and should be isolated with additional evidence.'
),
(
  13,
  'scenario',
  'scenario',
  'A system has high head pressure on a hot day. The outdoor condenser coil is heavily blocked with debris and condenser airflow is poor. What is the BEST interpretation?',
  '[{"key":"A","text":"Restricted heat rejection is likely contributing to elevated condensing pressure and should be corrected before making charge conclusions"},{"key":"B","text":"The system is definitely undercharged"},{"key":"C","text":"The evaporator metering device must be fully closed"},{"key":"D","text":"The compressor must be replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'A dirty condenser can elevate condensing pressure, so the heat-rejection problem should be addressed before interpreting charge-related measurements.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician sees frost forming on an evaporator coil. Suction pressure is low and airflow is well below design because the filter is severely restricted. What is the BEST conclusion?',
  '[{"key":"A","text":"The reduced heat load from poor airflow can lower evaporating temperature enough to contribute to coil icing"},{"key":"B","text":"The system is definitely overcharged"},{"key":"C","text":"The compressor is definitely failed"},{"key":"D","text":"The condenser must be oversized"}]'::jsonb,
  '["A"]'::jsonb,
  'Low airflow reduces heat transfer into the evaporator, which can drive coil temperature below freezing and contribute to icing.'
),
(
  15,
  'scenario',
  'scenario',
  'A system shows unusually high superheat. The technician confirms good airflow and finds a significant temperature drop across a liquid-line restriction before the metering device. What is the BEST interpretation?',
  '[{"key":"A","text":"The restriction may be reducing refrigerant flow to the evaporator and contributing to the high superheat"},{"key":"B","text":"The evaporator is necessarily flooded"},{"key":"C","text":"The compressor is definitely overcharged with oil"},{"key":"D","text":"The condenser fan is operating too fast"}]'::jsonb,
  '["A"]'::jsonb,
  'A restriction in the liquid path can limit refrigerant flow and starve the evaporator, producing elevated superheat.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician measures low superheat at the compressor inlet and is concerned about liquid refrigerant returning toward the compressor. What is the BEST response?',
  '[{"key":"A","text":"Evaluate evaporator feeding, load, airflow, and system operating conditions to determine whether refrigerant is fully vaporizing before reaching the compressor"},{"key":"B","text":"Increase refrigerant charge automatically"},{"key":"C","text":"Ignore the measurement because superheat is unrelated to compressor protection"},{"key":"D","text":"Increase condenser airflow until superheat rises"}]'::jsonb,
  '["A"]'::jsonb,
  'Adequate vapor superheat at the compressor inlet helps indicate that liquid refrigerant has vaporized before entering the compressor.'
),
(
  17,
  'scenario',
  'scenario',
  'A design engineer is reviewing a system expected to operate at a lower evaporating temperature than a comfort-cooling system. What refrigeration-cycle effect should be expected?',
  '[{"key":"A","text":"The evaporator-side saturation pressure will also be lower for the same refrigerant"},{"key":"B","text":"Evaporator pressure will be unchanged because temperature and pressure are unrelated"},{"key":"C","text":"Condensing pressure must become zero"},{"key":"D","text":"The compressor no longer affects refrigerant pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'For a given refrigerant, lower saturation temperature corresponds to lower saturation pressure.'
),
(
  18,
  'scenario',
  'scenario',
  'A design engineer compares two applications using the same refrigerant but different required condensing temperatures. Which statement is correct?',
  '[{"key":"A","text":"The application with the higher condensing temperature will also operate at a higher corresponding condensing pressure"},{"key":"B","text":"Both applications must have identical condensing pressure"},{"key":"C","text":"Condensing pressure depends only on evaporator airflow"},{"key":"D","text":"Condensing temperature does not affect pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'For the same refrigerant, saturation pressure rises as saturation temperature rises.'
),
(
  19,
  'scenario',
  'scenario',
  'A service technician sees high discharge pressure and initially suspects overcharge. Before adding or removing refrigerant, the technician finds condenser airflow is significantly restricted. What is the BEST response?',
  '[{"key":"A","text":"Correct the condenser airflow problem and then reevaluate refrigeration measurements before changing the charge"},{"key":"B","text":"Recover refrigerant immediately based only on discharge pressure"},{"key":"C","text":"Add refrigerant because airflow is unrelated to pressure"},{"key":"D","text":"Replace the metering device first"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat-transfer problems can imitate charge-related symptoms, so known airflow defects should be corrected before charge decisions are made.'
),
(
  20,
  'scenario',
  'scenario',
  'A system has normal refrigerant pressures at one moment but poor cooling capacity. The technician notices the evaporator airflow changes significantly during operation. What is the BEST Level 3 approach?',
  '[{"key":"A","text":"Evaluate refrigeration measurements under stable, verified airflow and load conditions before drawing conclusions about the cycle"},{"key":"B","text":"Judge the system from the single pressure reading only"},{"key":"C","text":"Replace the compressor because capacity is low"},{"key":"D","text":"Adjust refrigerant charge every time airflow changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigeration-cycle measurements are meaningful only when operating conditions such as airflow and load are understood and reasonably stable.'
);

create temporary table _seed_hvac_refrigeration_cycle_fundamentals_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigeration_cycle_fundamentals_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Refrigeration Cycle Fundamentals?',
  '[{"key":"A","text":"Interpreting refrigeration pressures, temperatures, superheat, subcooling, heat-transfer conditions, and system interactions to guide diagnosis and others"},{"key":"B","text":"Judging system operation from suction pressure alone"},{"key":"C","text":"Adding refrigerant whenever cooling capacity is low"},{"key":"D","text":"Treating every refrigeration fault as an isolated component failure"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 performance requires system-level interpretation of refrigeration-cycle measurements, heat transfer, operating conditions, and interacting faults.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is compressor compression ratio based on?',
  '[{"key":"A","text":"Absolute discharge pressure divided by absolute suction pressure"},{"key":"B","text":"Gauge suction pressure divided by gauge discharge pressure"},{"key":"C","text":"Liquid-line temperature divided by suction-line temperature"},{"key":"D","text":"Indoor airflow divided by outdoor airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Compression ratio compares absolute discharge pressure with absolute suction pressure and helps describe compressor operating severity.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is refrigerant mass flow important to system capacity?',
  '[{"key":"A","text":"System heat-transfer capacity depends in part on how much refrigerant circulates and how much energy each unit of refrigerant absorbs or rejects"},{"key":"B","text":"Mass flow determines thermostat setpoint"},{"key":"C","text":"Mass flow is unrelated to compressor operation"},{"key":"D","text":"Mass flow affects only condensate drainage"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigeration capacity depends on refrigerant circulation and the enthalpy change that occurs through the evaporator and other cycle processes.'
),
(
  4,
  'multiple_choice',
  'application',
  'A system operates with abnormally low suction pressure and high discharge pressure. What does this do to compressor compression ratio?',
  '[{"key":"A","text":"It increases compression ratio and can increase compressor stress and discharge temperature"},{"key":"B","text":"It decreases compression ratio to nearly zero"},{"key":"C","text":"It has no effect on compressor operating conditions"},{"key":"D","text":"It guarantees low compressor current"}]'::jsonb,
  '["A"]'::jsonb,
  'Lower suction pressure combined with higher discharge pressure increases the pressure ratio the compressor must work across.'
),
(
  5,
  'multiple_choice',
  'application',
  'A system has elevated condensing pressure because the condenser is dirty and also has low evaporating pressure because indoor airflow is poor. What is the BEST Level 4 interpretation?',
  '[{"key":"A","text":"Both heat exchangers are operating under unfavorable conditions that can increase compression ratio and reduce system performance"},{"key":"B","text":"The symptoms prove refrigerant overcharge"},{"key":"C","text":"The compressor must be mechanically failed"},{"key":"D","text":"The metering device must be fully open"}]'::jsonb,
  '["A"]'::jsonb,
  'Simultaneous poor evaporator and condenser heat transfer can widen the pressure difference across the compressor and degrade capacity and efficiency.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician finds high superheat and low subcooling on a system after confirming proper airflow and clean heat exchangers. What condition should be considered?',
  '[{"key":"A","text":"Insufficient refrigerant quantity may be contributing, although the complete operating evidence should still be evaluated"},{"key":"B","text":"The system is definitely overcharged"},{"key":"C","text":"The evaporator is definitely flooded"},{"key":"D","text":"The condenser is necessarily undersized"}]'::jsonb,
  '["A"]'::jsonb,
  'High superheat with low subcooling can be consistent with insufficient refrigerant charge when other operating conditions have been verified.'
),
(
  7,
  'multiple_choice',
  'application',
  'A system has low superheat and high subcooling with verified airflow and no obvious heat-exchanger restrictions. What condition should be considered?',
  '[{"key":"A","text":"Excess refrigerant or an overfeeding condition may be contributing and should be evaluated with the full system data"},{"key":"B","text":"The system is definitely undercharged"},{"key":"C","text":"The compressor is definitely worn"},{"key":"D","text":"The condenser fan must be running backward"}]'::jsonb,
  '["A"]'::jsonb,
  'Low superheat with high subcooling can be associated with excessive refrigerant inventory or overfeeding, depending on system type and controls.'
),
(
  8,
  'multiple_choice',
  'application',
  'A system uses a thermostatic expansion valve. Superheat is high and subcooling is normal to high. Which possibility should be investigated?',
  '[{"key":"A","text":"A restriction, insufficient valve feeding, sensing problem, or other condition limiting refrigerant flow into the evaporator"},{"key":"B","text":"The system must be undercharged"},{"key":"C","text":"The condenser must be dirty"},{"key":"D","text":"The compressor must be oversized"}]'::jsonb,
  '["A"]'::jsonb,
  'High superheat with adequate liquid refrigerant available can indicate that the evaporator is being underfed because of a metering or liquid-path issue.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician is comparing compressor discharge temperatures on two otherwise similar systems. One operates at a much higher compression ratio. What should be expected?',
  '[{"key":"A","text":"The higher-ratio system may operate with a higher discharge temperature and greater compressor stress"},{"key":"B","text":"The higher-ratio system must have lower discharge temperature"},{"key":"C","text":"Compression ratio does not affect compression work"},{"key":"D","text":"Both systems must have identical discharge temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Higher compression ratios generally increase compression work and can contribute to higher discharge temperatures.'
),
(
  10,
  'multiple_choice',
  'application',
  'Why should refrigeration-cycle measurements be taken after the system has operated long enough to stabilize when possible?',
  '[{"key":"A","text":"Transient startup conditions can produce pressures and temperatures that do not represent steady operating performance"},{"key":"B","text":"Pressure and temperature never change after startup"},{"key":"C","text":"Only electrical measurements require stabilization"},{"key":"D","text":"Stabilization eliminates the need to verify airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Stable operating conditions improve the value of refrigeration measurements and reduce the chance of drawing conclusions from transient behavior.'
),
(
  11,
  'scenario',
  'scenario',
  'A system has high head pressure, high subcooling, and normal evaporator airflow. The condenser coil is clean, but the condenser fan is moving substantially less air than expected. What is the BEST interpretation?',
  '[{"key":"A","text":"Poor condenser heat rejection can elevate condensing pressure and subcooling, so the airflow problem should be corrected before changing refrigerant charge"},{"key":"B","text":"The system is definitely undercharged"},{"key":"C","text":"The metering device must be replaced immediately"},{"key":"D","text":"The evaporator must be frozen"}]'::jsonb,
  '["A"]'::jsonb,
  'Reduced condenser airflow can cause refrigerant to condense at a higher temperature and pressure and can alter liquid inventory in the condenser.'
),
(
  12,
  'scenario',
  'scenario',
  'A system has low suction pressure and high superheat. Liquid-line subcooling is also high, and a significant temperature drop is measured across a liquid-line filter-drier. What is the BEST diagnosis direction?',
  '[{"key":"A","text":"Investigate the filter-drier or liquid-line restriction because liquid is available but refrigerant flow to the evaporator appears restricted"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the compressor because suction pressure is low"},{"key":"D","text":"Increase indoor airflow regardless of the measured restriction"}]'::jsonb,
  '["A"]'::jsonb,
  'High subcooling upstream with a measurable temperature drop across a liquid-line component can support diagnosis of a restriction that starves the evaporator.'
),
(
  13,
  'scenario',
  'scenario',
  'A system has low suction pressure, high superheat, and low subcooling after airflow and heat exchangers are verified. No significant liquid-line restriction is found. What is the BEST Level 4 conclusion?',
  '[{"key":"A","text":"The overall pattern is consistent with insufficient refrigerant quantity, subject to confirming system-specific charging requirements"},{"key":"B","text":"The pattern proves the system is overcharged"},{"key":"C","text":"The evaporator is definitely flooded"},{"key":"D","text":"The compressor must have bad valves"}]'::jsonb,
  '["A"]'::jsonb,
  'When heat transfer and liquid-path restrictions are ruled out, high superheat with low subcooling supports an undercharge diagnosis on many systems.'
),
(
  14,
  'scenario',
  'scenario',
  'A fixed-orifice system has very low superheat and the suction line remains unusually cold toward the compressor. Indoor airflow is confirmed normal. What is the BEST response?',
  '[{"key":"A","text":"Evaluate charge, load, metering conditions, and the possibility of excessive refrigerant feeding or liquid return before allowing continued operation"},{"key":"B","text":"Add refrigerant to raise suction pressure"},{"key":"C","text":"Ignore the condition because low superheat protects the compressor"},{"key":"D","text":"Increase condenser pressure intentionally"}]'::jsonb,
  '["A"]'::jsonb,
  'Very low superheat can indicate incomplete vaporization and potential liquid refrigerant return, which can threaten compressor reliability.'
),
(
  15,
  'scenario',
  'scenario',
  'A heat-pump system performs normally in cooling but shows abnormal refrigeration pressures in heating. What is the BEST senior-level approach?',
  '[{"key":"A","text":"Evaluate refrigerant flow path, reversing-valve operation, mode-specific metering devices, heat-exchanger conditions, and measurements appropriate to heating mode"},{"key":"B","text":"Apply cooling-mode pressure expectations without adjustment"},{"key":"C","text":"Replace the compressor because the pressures differ by mode"},{"key":"D","text":"Ignore outdoor-coil conditions"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat pumps change the roles of the indoor and outdoor heat exchangers, so diagnosis must account for the active refrigerant path and mode-specific components.'
),
(
  16,
  'scenario',
  'scenario',
  'A compressor has repeated high discharge-temperature trips. Suction pressure is low, superheat is excessive, and the evaporator is clearly starved. What relationship should the senior technician recognize?',
  '[{"key":"A","text":"A starved evaporator can reduce suction pressure and increase compression ratio and superheat, contributing to elevated discharge temperature"},{"key":"B","text":"Low suction pressure always lowers compressor discharge temperature"},{"key":"C","text":"Superheat is unrelated to compressor operating temperature"},{"key":"D","text":"The condenser cannot affect discharge temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Low suction pressure and high superheat can increase compressor operating severity and discharge temperature, especially when compression ratio rises.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician reports that a system is overcharged based only on high discharge pressure. The senior technician finds outdoor temperature is extreme and the condenser coil is partially blocked. What is the BEST response?',
  '[{"key":"A","text":"Correct or account for heat-rejection conditions and then evaluate superheat, subcooling, pressures, temperatures, and manufacturer charging information before changing charge"},{"key":"B","text":"Recover refrigerant immediately because discharge pressure alone proves overcharge"},{"key":"C","text":"Add refrigerant to reduce discharge pressure"},{"key":"D","text":"Replace the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'High discharge pressure has multiple possible causes, so charge decisions should use a complete set of refrigeration and heat-transfer evidence.'
),
(
  18,
  'scenario',
  'scenario',
  'A system operates with normal superheat but unexpectedly low capacity. The evaporating and condensing temperatures are both reasonable. What is the BEST Level 4 next direction?',
  '[{"key":"A","text":"Expand the evaluation to refrigerant mass flow, compressor performance, airflow, temperature split, metering behavior, and actual load rather than assuming the cycle is healthy from superheat alone"},{"key":"B","text":"Declare the system normal because superheat is normal"},{"key":"C","text":"Add refrigerant until capacity increases"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'One normal refrigeration indicator does not prove full system capacity; advanced diagnosis considers the entire heat-transfer and compression process.'
),
(
  19,
  'scenario',
  'scenario',
  'A senior technician evaluates a system with low suction pressure and low discharge pressure. Superheat is high and subcooling is low. Airflow is normal. What pattern does this MOST strongly support?',
  '[{"key":"A","text":"A low refrigerant-feed or low refrigerant-inventory condition that requires further confirmation"},{"key":"B","text":"A severe condenser airflow restriction"},{"key":"C","text":"A definite overcharge"},{"key":"D","text":"A flooded evaporator"}]'::jsonb,
  '["A"]'::jsonb,
  'Low system pressures combined with high superheat and low subcooling are commonly associated with insufficient refrigerant feed or inventory when load and airflow are normal.'
),
(
  20,
  'scenario',
  'scenario',
  'Several technicians have adjusted refrigerant charge on a system over multiple visits, but comfort complaints continue and measurements vary widely. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Establish stable operating conditions, verify airflow and load, confirm equipment and metering configuration, collect complete pressure and temperature data, and reconstruct the refrigeration-cycle behavior before making further charge changes"},{"key":"B","text":"Continue adding or removing refrigerant until one pressure looks normal"},{"key":"C","text":"Replace the compressor without additional testing"},{"key":"D","text":"Judge the system from suction pressure alone"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced refrigeration diagnosis requires controlled operating conditions and a complete evidence set rather than repeated charge adjustments based on isolated readings.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '91e4d617-1606-4d41-be71-5287f7b9fd1d';
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
      and c.name = 'Refrigeration Cycle Fundamentals'
      and c.is_current = true
  ) then
    raise exception 'Current Refrigeration Cycle Fundamentals Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 Refrigeration Cycle Fundamentals requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 Refrigeration Cycle Fundamentals requirement not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L3 Refrigeration Cycle Fundamentals requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Refrigeration Cycle Fundamentals requirement not found';
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
  v_assessment_name := 'Refrigeration Cycle Fundamentals — Level 1 Competency Assessment';

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
    select * from _seed_hvac_refrigeration_cycle_fundamentals_l1_questions
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
        'Refrigeration Cycle Fundamentals',
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
      'IntegrateU Refrigeration Cycle Fundamentals L1 production assessment v1.0.',
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
        'Refrigeration Cycle Fundamentals',
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
        'IntegrateU Refrigeration Cycle Fundamentals L1 production assessment v1.0.',
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
  v_assessment_name := 'Refrigeration Cycle Fundamentals — Level 3 Competency Assessment';

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
    select * from _seed_hvac_refrigeration_cycle_fundamentals_l3_questions
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
        'Refrigeration Cycle Fundamentals',
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
      'IntegrateU Refrigeration Cycle Fundamentals L3 production assessment v1.0.',
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
        'Refrigeration Cycle Fundamentals',
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
        'IntegrateU Refrigeration Cycle Fundamentals L3 production assessment v1.0.',
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
  v_assessment_name := 'Refrigeration Cycle Fundamentals — Level 4 Competency Assessment';

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
    select * from _seed_hvac_refrigeration_cycle_fundamentals_l4_questions
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
        'Refrigeration Cycle Fundamentals',
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
      'IntegrateU Refrigeration Cycle Fundamentals L4 production assessment v1.0.',
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
        'Refrigeration Cycle Fundamentals',
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
        'IntegrateU Refrigeration Cycle Fundamentals L4 production assessment v1.0.',
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
   '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 HVAC Installer / Helper          -> 20
--   Level 3 HVAC Service & Repair Technician -> 20
--   Level 3 HVAC Design & Sales Engineer     -> 20
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
      '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid
    and a.target_level in (1,3,4)
    and aq.master_competency_template_id =
      '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid
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
  (q.target_level = 3 and ra.master_role_template_id in (
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid,
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid
  ))
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
  '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid;

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
    '91e4d617-1606-4d41-be71-5287f7b9fd1d'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
