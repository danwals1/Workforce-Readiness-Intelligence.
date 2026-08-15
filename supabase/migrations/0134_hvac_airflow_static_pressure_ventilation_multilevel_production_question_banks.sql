-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_airflow_static_pressure_ventilation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Airflow, Static Pressure & Ventilation
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Service & Repair Technician -> Level 3
--   HVAC Design & Sales Engineer     -> Level 4
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

create temporary table _seed_hvac_airflow_static_pressure_ventilation_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_airflow_static_pressure_ventilation_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is airflow in an HVAC system?',
  '[{"key":"A","text":"The movement of air through equipment, ducts, grilles, and spaces"},{"key":"B","text":"The electrical current supplied to the blower motor"},{"key":"C","text":"The amount of refrigerant in the system"},{"key":"D","text":"The water pressure in a condensate drain"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow describes the movement of air through the HVAC system and conditioned spaces.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does CFM commonly represent in HVAC work?',
  '[{"key":"A","text":"Cubic feet of air moved per minute"},{"key":"B","text":"Cooling force measurement"},{"key":"C","text":"Circuit frequency maximum"},{"key":"D","text":"Condensate flow margin"}]'::jsonb,
  '["A"]'::jsonb,
  'CFM means cubic feet per minute and is a common unit for airflow.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is static pressure in an air-distribution system?',
  '[{"key":"A","text":"The pressure air exerts within the duct system relative to its surroundings"},{"key":"B","text":"The refrigerant pressure measured at the compressor"},{"key":"C","text":"The electrical resistance of the blower motor"},{"key":"D","text":"The weight of the ductwork"}]'::jsonb,
  '["A"]'::jsonb,
  'Static pressure represents pressure within the air-distribution system and helps describe resistance to airflow.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a return-air path?',
  '[{"key":"A","text":"To allow air from the conditioned space to return to the HVAC equipment"},{"key":"B","text":"To discharge combustion gases outdoors"},{"key":"C","text":"To drain condensate"},{"key":"D","text":"To carry refrigerant back to the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'Return-air paths bring air from occupied spaces back to the HVAC equipment for continued circulation and conditioning.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should supply registers and return grilles remain unobstructed?',
  '[{"key":"A","text":"Obstructions can restrict airflow and interfere with system performance"},{"key":"B","text":"Obstructions increase refrigerant charge"},{"key":"C","text":"Obstructions improve blower efficiency"},{"key":"D","text":"Obstructions reduce electrical voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Blocked registers or grilles can restrict airflow and negatively affect comfort and equipment operation.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the purpose of ventilation in a building?',
  '[{"key":"A","text":"To provide and manage outdoor air as required for indoor environmental conditions"},{"key":"B","text":"To increase refrigerant pressure"},{"key":"C","text":"To eliminate the need for filtration"},{"key":"D","text":"To replace all return air with outdoor air"}]'::jsonb,
  '["A"]'::jsonb,
  'Ventilation introduces and manages outdoor air to support indoor air quality and building requirements.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What can a dirty air filter do to system airflow?',
  '[{"key":"A","text":"Increase resistance and reduce airflow through the system"},{"key":"B","text":"Increase duct size"},{"key":"C","text":"Eliminate static pressure"},{"key":"D","text":"Increase blower wheel diameter"}]'::jsonb,
  '["A"]'::jsonb,
  'A dirty filter creates additional resistance that can reduce airflow.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is duct sealing important?',
  '[{"key":"A","text":"It helps limit unintended air leakage from or into the duct system"},{"key":"B","text":"It increases compressor displacement"},{"key":"C","text":"It replaces duct insulation"},{"key":"D","text":"It eliminates the need for airflow balancing"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper sealing helps keep conditioned air in the intended air-distribution path and limits unwanted leakage.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer finds a return grille covered by boxes after the system has been started. What is the BEST action?',
  '[{"key":"A","text":"Clear the obstruction so the return-air path is open"},{"key":"B","text":"Increase blower speed immediately"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close nearby supply registers"}]'::jsonb,
  '["A"]'::jsonb,
  'A blocked return path can restrict airflow and should be cleared before making other system changes.'
),
(
  10,
  'multiple_choice',
  'application',
  'A flexible duct run has a sharp kink that reduces its open area. What should the installer do?',
  '[{"key":"A","text":"Correct the duct routing so the airflow path is not unnecessarily restricted"},{"key":"B","text":"Leave the kink because flexible duct is designed to collapse"},{"key":"C","text":"Increase the thermostat setting"},{"key":"D","text":"Add another filter"}]'::jsonb,
  '["A"]'::jsonb,
  'Kinks and excessive compression in flexible duct can create unnecessary resistance and reduce airflow.'
),
(
  11,
  'multiple_choice',
  'application',
  'An installer notices that a supply boot is not sealed to the duct and air is leaking into an unconditioned space. What is the BEST response?',
  '[{"key":"A","text":"Seal the connection using the approved duct-sealing method"},{"key":"B","text":"Increase blower speed to compensate"},{"key":"C","text":"Ignore it if some air still reaches the register"},{"key":"D","text":"Close the register halfway"}]'::jsonb,
  '["A"]'::jsonb,
  'Unintended duct leakage should be corrected at the connection rather than compensated for elsewhere.'
),
(
  12,
  'multiple_choice',
  'application',
  'A newly installed filter is visibly bowed inward while the blower operates. What should the installer check?',
  '[{"key":"A","text":"Whether the filter is correctly sized, installed, and excessively restrictive for the application"},{"key":"B","text":"Whether the refrigerant charge is high"},{"key":"C","text":"Whether the condensate drain is trapped"},{"key":"D","text":"Whether the thermostat batteries are new"}]'::jsonb,
  '["A"]'::jsonb,
  'A filter that deforms under operation may indicate installation or airflow-resistance problems that should be investigated.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer is connecting a return duct to an air handler. Why should the connection be properly sized and unobstructed?',
  '[{"key":"A","text":"An undersized or restricted return can increase resistance and reduce airflow"},{"key":"B","text":"A smaller return always improves cooling"},{"key":"C","text":"Return size affects only sound"},{"key":"D","text":"Return-air restrictions have no effect on the blower"}]'::jsonb,
  '["A"]'::jsonb,
  'Return-air restrictions can increase system resistance and reduce the amount of air the blower can move.'
),
(
  14,
  'multiple_choice',
  'application',
  'An outdoor-air intake hood is installed but its opening is blocked by construction wrap. What should happen before system operation?',
  '[{"key":"A","text":"Remove the obstruction and verify the intake is open as intended"},{"key":"B","text":"Run the system and let the fan pull the wrap loose"},{"key":"C","text":"Close all return grilles"},{"key":"D","text":"Increase supply airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'A blocked outdoor-air intake prevents the ventilation path from functioning as intended.'
),
(
  15,
  'multiple_choice',
  'application',
  'A supply register receives very little airflow and the branch duct is visibly crushed above the ceiling. What is the BEST first action?',
  '[{"key":"A","text":"Correct the damaged or restricted duct before changing system settings"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Close other registers permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'A visible physical restriction should be corrected before attempting to compensate through unrelated adjustments.'
),
(
  16,
  'multiple_choice',
  'application',
  'Why should an installer avoid excessive sag in flexible duct?',
  '[{"key":"A","text":"Excessive sag can increase airflow resistance and reduce delivered airflow"},{"key":"B","text":"Sag increases compressor pressure"},{"key":"C","text":"Sag improves ventilation"},{"key":"D","text":"Sag eliminates the need for supports"}]'::jsonb,
  '["A"]'::jsonb,
  'Poorly supported flexible duct can create added resistance and reduce airflow performance.'
),
(
  17,
  'scenario',
  'scenario',
  'A newly installed system runs, but several rooms receive very little supply air. Inspection shows multiple flexible duct runs sharply bent and compressed behind framing. What is the BEST response?',
  '[{"key":"A","text":"Correct the restrictive duct routing and support before making blower or refrigerant adjustments"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Close the strongest supply registers completely"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible duct restrictions should be corrected first because they directly interfere with air delivery.'
),
(
  18,
  'scenario',
  'scenario',
  'After startup, an installer hears loud air noise at a return grille and finds the filter heavily bowed toward the blower. What is the BEST next step?',
  '[{"key":"A","text":"Check the return path, filter selection, filter installation, and other obvious restrictions before changing blower settings"},{"key":"B","text":"Increase blower speed"},{"key":"C","text":"Add a second filter in front of the first"},{"key":"D","text":"Block part of the return grille"}]'::jsonb,
  '["A"]'::jsonb,
  'Noise and filter deformation can indicate excessive resistance in the return path and should trigger inspection for restrictions.'
),
(
  19,
  'scenario',
  'scenario',
  'A ventilation intake is installed near completion of a project, but the balancing damper is left fully closed. What is the BEST response before turnover?',
  '[{"key":"A","text":"Set or verify the ventilation path according to the approved startup or balancing requirements"},{"key":"B","text":"Leave it closed to improve cooling efficiency"},{"key":"C","text":"Remove the intake hood"},{"key":"D","text":"Open all supply registers instead"}]'::jsonb,
  '["A"]'::jsonb,
  'The ventilation path must be configured as intended before the system is turned over.'
),
(
  20,
  'scenario',
  'scenario',
  'An installer finishes a duct connection and notices significant air leaking from an unsealed joint during startup. What is the BEST action?',
  '[{"key":"A","text":"Correct and seal the joint using the approved method, then verify the connection"},{"key":"B","text":"Increase blower speed to make up for the loss"},{"key":"C","text":"Ignore the leakage if the room feels comfortable"},{"key":"D","text":"Reduce outdoor air"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible unintended leakage should be corrected at the source rather than compensated for through system adjustments.'
);

create temporary table _seed_hvac_airflow_static_pressure_ventilation_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_airflow_static_pressure_ventilation_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Airflow, Static Pressure & Ventilation?',
  '[{"key":"A","text":"Judging airflow mainly by sound and feel"},{"key":"B","text":"Independently measuring and interpreting airflow and pressure conditions while recognizing restrictions, ventilation problems, and interacting system effects"},{"key":"C","text":"Adjusting blower speed before taking measurements"},{"key":"D","text":"Treating every comfort complaint as a refrigerant problem"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent air-side measurement, interpretation, and diagnostic judgment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does total external static pressure help a technician evaluate?',
  '[{"key":"A","text":"The resistance the blower is working against across the external air-distribution system"},{"key":"B","text":"The refrigerant pressure ratio"},{"key":"C","text":"The thermostat voltage drop"},{"key":"D","text":"The condensate drain slope"}]'::jsonb,
  '["A"]'::jsonb,
  'Total external static pressure is used to evaluate the resistance imposed on the blower by the connected air-distribution system.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should static-pressure readings include the measurement locations?',
  '[{"key":"A","text":"Pressure values are meaningful only when the test points and reference locations are known"},{"key":"B","text":"Static pressure is identical everywhere in the system"},{"key":"C","text":"Location matters only for temperature measurements"},{"key":"D","text":"Measurement location determines refrigerant type"}]'::jsonb,
  '["A"]'::jsonb,
  'Static-pressure values depend on where they are measured and cannot be interpreted correctly without location context.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a likely effect of excessive air-side resistance on a constant-speed blower system?',
  '[{"key":"A","text":"Reduced airflow compared with what the blower could deliver at lower resistance"},{"key":"B","text":"Higher refrigerant charge"},{"key":"C","text":"Zero static pressure"},{"key":"D","text":"Automatic duct enlargement"}]'::jsonb,
  '["A"]'::jsonb,
  'As resistance increases, many blower systems deliver less airflow unless operating conditions or blower capability compensate.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician measures unusually high return-side static pressure and finds a heavily loaded filter. What is the BEST next step?',
  '[{"key":"A","text":"Correct the filter condition and reassess airflow and pressure before making other changes"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Increase blower speed immediately"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'A heavily restricted filter can increase return-side resistance and should be corrected before unrelated adjustments are made.'
),
(
  6,
  'multiple_choice',
  'application',
  'A system has low airflow and a large pressure drop across the evaporator coil. What should the technician investigate?',
  '[{"key":"A","text":"Whether the coil is dirty, blocked, iced, or otherwise creating excessive restriction"},{"key":"B","text":"Whether the thermostat display is bright enough"},{"key":"C","text":"Whether the refrigerant lines are painted"},{"key":"D","text":"Whether the condensate drain is oversized"}]'::jsonb,
  '["A"]'::jsonb,
  'An excessive pressure drop across the coil can indicate a restriction at the coil that is limiting airflow.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician measures total external static pressure above the equipment manufacturer’s stated range. What is the BEST response?',
  '[{"key":"A","text":"Investigate air-side restrictions and system configuration before assuming blower performance is normal"},{"key":"B","text":"Ignore the reading if temperatures look acceptable"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close more registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive total external static pressure indicates that the air-distribution system may be imposing too much resistance on the blower.'
),
(
  8,
  'multiple_choice',
  'application',
  'A return duct is undersized and produces high negative pressure near the blower inlet. What is the BEST interpretation?',
  '[{"key":"A","text":"The return path may be restricting airflow and increasing blower inlet resistance"},{"key":"B","text":"The refrigerant charge is definitely low"},{"key":"C","text":"The supply duct is automatically oversized"},{"key":"D","text":"Negative return pressure proves the blower is defective"}]'::jsonb,
  '["A"]'::jsonb,
  'An undersized return can create excessive resistance and high negative pressure at the blower inlet.'
),
(
  9,
  'multiple_choice',
  'application',
  'A ventilation system is intended to introduce outdoor air, but measured outdoor airflow is near zero even though the fan is running. What should the technician check?',
  '[{"key":"A","text":"Dampers, intake obstructions, duct restrictions, fan operation, and the intended control sequence"},{"key":"B","text":"Only refrigerant pressure"},{"key":"C","text":"Only thermostat batteries"},{"key":"D","text":"Only compressor current"}]'::jsonb,
  '["A"]'::jsonb,
  'Low ventilation airflow can result from closed dampers, blocked intakes, duct restrictions, fan issues, or control problems.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician finds normal total external static pressure but one room has very low airflow. What is the BEST next step?',
  '[{"key":"A","text":"Investigate the branch duct, balancing device, register, and local restrictions serving that room"},{"key":"B","text":"Increase blower speed for the entire system immediately"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Replace the compressor"}]'::jsonb,
  '["A"]'::jsonb,
  'A local airflow problem with otherwise normal overall system pressure suggests a branch-specific restriction or distribution issue.'
),
(
  11,
  'multiple_choice',
  'application',
  'A blower speed change increases airflow but pushes total external static pressure above the acceptable range. What is the BEST interpretation?',
  '[{"key":"A","text":"The speed increase may be masking an air-distribution restriction rather than correcting the underlying problem"},{"key":"B","text":"Higher static pressure always means better airflow"},{"key":"C","text":"The refrigerant charge must be increased"},{"key":"D","text":"The duct system is automatically acceptable"}]'::jsonb,
  '["A"]'::jsonb,
  'Increasing blower effort can raise pressure without correcting restrictive duct, filter, coil, or register conditions.'
),
(
  12,
  'scenario',
  'scenario',
  'A cooling system has poor capacity. The suction pressure is low, but airflow measurement shows the evaporator is receiving far less air than expected. What is the BEST diagnostic response?',
  '[{"key":"A","text":"Correct or account for the airflow problem before diagnosing the system as undercharged"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Ignore the airflow measurement"}]'::jsonb,
  '["A"]'::jsonb,
  'Low airflow can alter refrigerant-side operating conditions and should be addressed before concluding that charge is the primary problem.'
),
(
  13,
  'scenario',
  'scenario',
  'A system has high total external static pressure. The filter is clean, but pressure measurements show most of the drop occurs across the return duct before the filter. What is the BEST conclusion?',
  '[{"key":"A","text":"The return duct or return-air path is likely a major source of restriction"},{"key":"B","text":"The evaporator coil is confirmed dirty"},{"key":"C","text":"The blower motor must be replaced"},{"key":"D","text":"The refrigerant charge is high"}]'::jsonb,
  '["A"]'::jsonb,
  'Pressure measurements can localize where resistance is occurring; a large drop before the filter points toward the return path.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician measures low airflow and finds a clean filter, clean coil, and normal blower operation. Several supply dampers are nearly closed. What is the BEST response?',
  '[{"key":"A","text":"Correct or verify the supply damper positions and reassess airflow and static pressure"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Replace the blower motor"},{"key":"D","text":"Close the remaining dampers"}]'::jsonb,
  '["A"]'::jsonb,
  'Closed supply dampers can restrict airflow and increase distribution-system resistance.'
),
(
  15,
  'scenario',
  'scenario',
  'A ventilation complaint occurs only when the building exhaust fans are running. Outdoor-air airflow drops and doors become difficult to open. What should the technician investigate?',
  '[{"key":"A","text":"Building pressure balance, exhaust airflow, outdoor-air delivery, and the ventilation control strategy"},{"key":"B","text":"Only compressor superheat"},{"key":"C","text":"Only supply-air temperature"},{"key":"D","text":"Only filter age"}]'::jsonb,
  '["A"]'::jsonb,
  'Exhaust systems can depressurize a building if makeup or outdoor air is inadequate, affecting ventilation performance and door operation.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician measures acceptable airflow at the air handler, but several distant rooms are under-supplied. What is the BEST next diagnostic approach?',
  '[{"key":"A","text":"Evaluate branch distribution, balancing, leakage, restrictions, and terminal conditions serving the affected rooms"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Replace the blower automatically"},{"key":"D","text":"Reduce return-air opening size"}]'::jsonb,
  '["A"]'::jsonb,
  'Adequate total airflow with poor room delivery points toward distribution and balancing issues rather than overall blower output.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician checks a system after a filter upgrade and finds airflow has fallen significantly while total external static pressure has increased. What is the BEST interpretation?',
  '[{"key":"A","text":"The new filter or filter arrangement may be adding more resistance than the system can tolerate"},{"key":"B","text":"The blower is automatically defective"},{"key":"C","text":"The refrigerant charge must be low"},{"key":"D","text":"Higher static pressure proves the filter is better"}]'::jsonb,
  '["A"]'::jsonb,
  'A more restrictive filter can increase system resistance and reduce airflow if the system is not designed for the added pressure drop.'
),
(
  18,
  'scenario',
  'scenario',
  'A ventilation damper is commanded open, but measured outdoor airflow remains low. The damper blade is physically open. What is the BEST next step?',
  '[{"key":"A","text":"Check intake obstruction, duct resistance, fan operation, pressure relationships, and actual airflow path"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Assume the airflow measurement is wrong"},{"key":"D","text":"Close the damper"}]'::jsonb,
  '["A"]'::jsonb,
  'A physically open damper does not guarantee adequate airflow if other restrictions or pressure conditions limit the ventilation path.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds high static pressure on both the supply and return sides, with a blower operating at high speed. What is the BEST approach?',
  '[{"key":"A","text":"Systematically identify restrictions on both sides rather than increasing blower speed further"},{"key":"B","text":"Set the blower to maximum speed"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Close more registers"}]'::jsonb,
  '["A"]'::jsonb,
  'High pressure on both sides suggests substantial air-side resistance that should be localized and corrected rather than overcome by more blower effort.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician replaces a blower motor, but airflow remains low. Static-pressure testing shows the blower is operating against excessive external resistance. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Diagnose and correct the external air-distribution restrictions instead of replacing more blower components"},{"key":"B","text":"Replace the blower motor again"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Disable the filter"}]'::jsonb,
  '["A"]'::jsonb,
  'When the blower is operating against excessive external resistance, the air-distribution system should be evaluated rather than repeatedly replacing blower components.'
);

create temporary table _seed_hvac_airflow_static_pressure_ventilation_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_airflow_static_pressure_ventilation_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Airflow, Static Pressure & Ventilation?',
  '[{"key":"A","text":"Adjusting blower speed whenever comfort complaints occur"},{"key":"B","text":"Leading system-level evaluation of airflow, pressure, ventilation, balancing, and measurement quality while correcting recurring root causes"},{"key":"C","text":"Relying on room temperature alone"},{"key":"D","text":"Treating static pressure as a service-only concern"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes system-level interpretation, leadership, validation of measurements, and corrective action across airflow and ventilation performance.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is a pressure budget useful in HVAC system design and review?',
  '[{"key":"A","text":"It helps allocate available fan pressure across filters, coils, ducts, fittings, terminals, and other system components"},{"key":"B","text":"It determines refrigerant charge"},{"key":"C","text":"It replaces fan performance data"},{"key":"D","text":"It eliminates the need for balancing"}]'::jsonb,
  '["A"]'::jsonb,
  'A pressure budget helps confirm that the fan can overcome the expected resistance of the full air-distribution path.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to validate field airflow measurements before making major design or equipment changes?',
  '[{"key":"A","text":"Poor test methods or locations can produce misleading data and drive incorrect corrective action"},{"key":"B","text":"Field measurements are always less accurate than design values"},{"key":"C","text":"Only laboratory airflow data should be used"},{"key":"D","text":"Validation is needed only for ventilation systems"}]'::jsonb,
  '["A"]'::jsonb,
  'Major decisions should rely on measurements whose method, instrument, location, and context are trustworthy.'
),
(
  4,
  'multiple_choice',
  'application',
  'A design review shows that the selected fan can deliver the required airflow only at a lower external static pressure than the proposed system is expected to impose. What is the BEST response?',
  '[{"key":"A","text":"Revise the fan selection or reduce system resistance before finalizing the design"},{"key":"B","text":"Assume the fan will deliver the airflow anyway"},{"key":"C","text":"Increase refrigerant capacity"},{"key":"D","text":"Reduce outdoor air automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Fan selection must be matched to the airflow requirement at the actual expected system resistance.'
),
(
  5,
  'multiple_choice',
  'application',
  'A building has repeated complaints of weak airflow in distant zones. Testing shows adequate total airflow at the air handler but poor branch delivery. What should a senior reviewer focus on?',
  '[{"key":"A","text":"Distribution, balancing, branch resistance, leakage, and terminal performance"},{"key":"B","text":"Refrigerant charge only"},{"key":"C","text":"Blower replacement automatically"},{"key":"D","text":"Thermostat location only"}]'::jsonb,
  '["A"]'::jsonb,
  'Adequate total airflow with poor zone delivery points toward distribution and balancing problems rather than overall fan capacity alone.'
),
(
  6,
  'multiple_choice',
  'application',
  'A project increases filtration efficiency and the new filter has a significantly higher pressure drop. What should be evaluated before approval?',
  '[{"key":"A","text":"Whether the fan and air-distribution system can maintain required airflow at the added resistance"},{"key":"B","text":"Only whether the filter fits physically"},{"key":"C","text":"Only filter replacement cost"},{"key":"D","text":"Whether the thermostat can display filter reminders"}]'::jsonb,
  '["A"]'::jsonb,
  'Higher filter resistance can reduce airflow unless the fan and system are capable of operating at the increased pressure drop.'
),
(
  7,
  'multiple_choice',
  'application',
  'A ventilation design adds substantial exhaust airflow without increasing makeup or outdoor air. What should the reviewer consider?',
  '[{"key":"A","text":"The effect on building pressure, infiltration, door operation, and ventilation balance"},{"key":"B","text":"Only exhaust fan motor size"},{"key":"C","text":"Only refrigerant pressure"},{"key":"D","text":"Nothing if the exhaust fans are code-listed"}]'::jsonb,
  '["A"]'::jsonb,
  'Exhaust and outdoor-air quantities interact with building pressure and should be reviewed as a balanced system.'
),
(
  8,
  'multiple_choice',
  'application',
  'A test-and-balance report shows required airflow at terminals, but total external static pressure is far above the equipment limit. What is the BEST response?',
  '[{"key":"A","text":"Investigate whether the system is being forced to meet airflow through excessive fan effort or restrictive distribution conditions"},{"key":"B","text":"Accept the report because airflow is correct"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Ignore static pressure after balancing"}]'::jsonb,
  '["A"]'::jsonb,
  'Meeting airflow while exceeding acceptable external static pressure can indicate an unsustainable or overly restrictive system condition.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician finds that different crews use different static-pressure test locations for the same equipment type. What is the BEST response?',
  '[{"key":"A","text":"Standardize the approved test locations and method so results are comparable"},{"key":"B","text":"Average all readings across crews"},{"key":"C","text":"Use the highest value only"},{"key":"D","text":"Stop measuring static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparable system data requires consistent measurement definitions, locations, and procedures.'
),
(
  10,
  'multiple_choice',
  'application',
  'A design engineer is considering reducing duct size to save space. What should be evaluated before doing so?',
  '[{"key":"A","text":"Air velocity, pressure loss, noise, fan capability, and downstream distribution effects"},{"key":"B","text":"Only material cost"},{"key":"C","text":"Only duct appearance"},{"key":"D","text":"Only refrigerant line length"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct size affects velocity, resistance, noise, and fan operating requirements and should be evaluated as part of the full system.'
),
(
  11,
  'scenario',
  'scenario',
  'A facility has recurring comfort complaints after a high-efficiency filter upgrade. Technicians repeatedly increase blower speed, but motors run harder and total external static pressure remains high. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Evaluate the filter pressure drop and the full air-distribution system, then correct the resistance or equipment-selection mismatch instead of repeatedly increasing fan effort"},{"key":"B","text":"Continue increasing blower speed"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Remove all filtration permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated fan-speed increases can mask a system-resistance problem and may move the blower outside an appropriate operating condition.'
),
(
  12,
  'scenario',
  'scenario',
  'A new ventilation system meets design airflow when tested alone, but outdoor-air delivery falls sharply whenever building exhaust fans operate. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the combined pressure balance, exhaust airflow, makeup-air path, intake resistance, and controls under actual operating conditions"},{"key":"B","text":"Increase cooling capacity"},{"key":"C","text":"Ignore the issue because the ventilation fan meets airflow alone"},{"key":"D","text":"Close the outdoor-air damper"}]'::jsonb,
  '["A"]'::jsonb,
  'Ventilation performance should be verified under interacting building conditions, not only with individual fans operating independently.'
),
(
  13,
  'scenario',
  'scenario',
  'A test-and-balance contractor reports acceptable airflow, but the measurement locations and hood setup are not documented and the values conflict with static-pressure data. What is the BEST response?',
  '[{"key":"A","text":"Require measurement-method verification and reconciliation of the conflicting data before accepting the results"},{"key":"B","text":"Accept the report because the totals match design"},{"key":"C","text":"Ignore static-pressure data"},{"key":"D","text":"Average the airflow and pressure readings"}]'::jsonb,
  '["A"]'::jsonb,
  'Untraceable or internally inconsistent measurements should be validated before they are used for acceptance or design decisions.'
),
(
  14,
  'scenario',
  'scenario',
  'A large system has adequate total airflow but persistent hot and cold zones. Branch measurements show significant imbalance. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Address distribution and balancing while preserving required total airflow and acceptable system pressure"},{"key":"B","text":"Increase total airflow until every zone feels better"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Replace the central fan automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Zone imbalance should be corrected at the distribution level rather than by indiscriminately increasing total system airflow.'
),
(
  15,
  'scenario',
  'scenario',
  'A project requires more outdoor air than the existing air handler can accept without exceeding fan pressure capability. What is the BEST design response?',
  '[{"key":"A","text":"Revise the ventilation strategy, fan selection, duct system, or equipment configuration so required outdoor air can be delivered within acceptable operating limits"},{"key":"B","text":"Open the outdoor-air damper fully and assume the fan will adapt"},{"key":"C","text":"Reduce return air until pressure falls"},{"key":"D","text":"Ignore fan capability because outdoor air is mandatory"}]'::jsonb,
  '["A"]'::jsonb,
  'Ventilation requirements and fan capability must be coordinated so the system can actually deliver the required airflow.'
),
(
  16,
  'scenario',
  'scenario',
  'A senior technician reviews multiple service calls where low suction pressure was treated as low refrigerant charge. Later testing shows all affected units had severe airflow restrictions. What is the BEST corrective action?',
  '[{"key":"A","text":"Strengthen diagnostic procedures and technician training so airflow is verified before charge-related conclusions are made"},{"key":"B","text":"Ban refrigerant gauges"},{"key":"C","text":"Add refrigerant to all similar systems proactively"},{"key":"D","text":"Ignore airflow unless the coil freezes"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring diagnostic error should be corrected through better measurement expectations, workflow, and training.'
),
(
  17,
  'scenario',
  'scenario',
  'A building experiences negative pressure, frequent door complaints, and outdoor odors entering through cracks. Exhaust airflow is much higher than measured outdoor-air intake. What is the BEST conclusion?',
  '[{"key":"A","text":"The building air balance is likely deficient and the exhaust, makeup, and ventilation strategy should be corrected"},{"key":"B","text":"The refrigerant charge is low"},{"key":"C","text":"Supply duct leakage is the only possible cause"},{"key":"D","text":"Negative pressure proves the exhaust fans are working correctly"}]'::jsonb,
  '["A"]'::jsonb,
  'Excess exhaust relative to makeup or outdoor air can depressurize the building and cause unwanted infiltration.'
),
(
  18,
  'scenario',
  'scenario',
  'A design engineer proposes smaller ducts and a higher fan speed to preserve the same airflow in a constrained ceiling. What is the BEST review approach?',
  '[{"key":"A","text":"Evaluate the resulting pressure loss, fan operating point, sound, energy, and distribution effects before accepting the change"},{"key":"B","text":"Approve it because airflow is theoretically unchanged"},{"key":"C","text":"Ignore pressure loss if the fan has multiple speeds"},{"key":"D","text":"Reduce filter size to compensate"}]'::jsonb,
  '["A"]'::jsonb,
  'Maintaining nominal airflow with smaller ducts can substantially increase pressure, noise, and fan energy and should be evaluated comprehensively.'
),
(
  19,
  'scenario',
  'scenario',
  'A commissioning review finds that the ventilation sequence opens the outdoor-air damper, but fan tracking causes building pressure to swing sharply positive and negative throughout the day. What is the BEST response?',
  '[{"key":"A","text":"Review and tune the ventilation, exhaust, and fan-control strategy using measured airflow and building-pressure behavior"},{"key":"B","text":"Disable building-pressure measurements"},{"key":"C","text":"Lock the outdoor-air damper at one position"},{"key":"D","text":"Increase cooling setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Dynamic building-pressure problems require coordinated control of ventilation, exhaust, and supply airflow based on measured operation.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit shows recurring airflow complaints, inconsistent static-pressure measurements, and repeated blower-speed changes without documented root-cause analysis. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement a standardized airflow and pressure diagnostic process with defined test locations, documentation, training, and corrective-action review"},{"key":"B","text":"Buy larger blowers"},{"key":"C","text":"Stop recording static pressure"},{"key":"D","text":"Allow each technician to use personal diagnostic methods"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring airflow problems and inconsistent measurement practices call for a standardized diagnostic and quality-control process.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080';
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
      and c.name = 'Airflow, Static Pressure & Ventilation'
      and c.is_current = true
  ) then
    raise exception 'Current Airflow, Static Pressure & Ventilation Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 Airflow, Static Pressure & Ventilation requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 Airflow, Static Pressure & Ventilation requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L4 Airflow, Static Pressure & Ventilation requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Airflow, Static Pressure & Ventilation requirement not found';
  end if;

v_level := 1;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'Airflow, Static Pressure & Ventilation — Level 1 Competency Assessment';

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
    select * from _seed_hvac_airflow_static_pressure_ventilation_l1_questions
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
        'Airflow, Static Pressure & Ventilation',
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
      'IntegrateU Airflow, Static Pressure & Ventilation L1 production assessment v1.0.',
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
      (v_master_question_id, v_installer_role_id)
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
        'Airflow, Static Pressure & Ventilation',
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
        'IntegrateU Airflow, Static Pressure & Ventilation L1 production assessment v1.0.',
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

  v_level := 3;
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'Airflow, Static Pressure & Ventilation — Level 3 Competency Assessment';

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
    select * from _seed_hvac_airflow_static_pressure_ventilation_l3_questions
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
        'Airflow, Static Pressure & Ventilation',
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
      'IntegrateU Airflow, Static Pressure & Ventilation L3 production assessment v1.0.',
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
      (v_master_question_id, v_service_role_id)
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
        'Airflow, Static Pressure & Ventilation',
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
        'IntegrateU Airflow, Static Pressure & Ventilation L3 production assessment v1.0.',
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
  v_assessment_name := 'Airflow, Static Pressure & Ventilation — Level 4 Competency Assessment';

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
    select * from _seed_hvac_airflow_static_pressure_ventilation_l4_questions
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
        'Airflow, Static Pressure & Ventilation',
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
      'IntegrateU Airflow, Static Pressure & Ventilation L4 production assessment v1.0.',
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
      (v_master_question_id, v_design_sales_role_id),
      (v_master_question_id, v_senior_role_id)
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
        'Airflow, Static Pressure & Ventilation',
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
        'IntegrateU Airflow, Static Pressure & Ventilation L4 production assessment v1.0.',
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
   'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L1 HVAC Installer / Helper = 20
--   L3 HVAC Service & Repair Technician = 20
--   L4 HVAC Design & Sales Engineer = 20
--   L4 Senior / Lead HVAC Technician = 20
-- ============================================================================

with q as (
  select
    aq.source_master_question_id,
    a.target_level
  from public.assessments a
  join public.assessment_questions aq
    on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080'::uuid
    and a.target_level in (1,3,4)
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  mrt.name as role_name,
  count(distinct ra.master_question_id)::integer
    as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
join public.master_role_templates mrt
  on mrt.id = ra.master_role_template_id
where
  (
    q.target_level = 1
    and mrt.id =
      '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid
  )
  or
  (
    q.target_level = 3
    and mrt.id =
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
  )
  or
  (
    q.target_level = 4
    and mrt.id in (
      '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid,
      'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
    )
  )
group by
  q.target_level,
  mrt.id,
  mrt.name
order by
  q.target_level,
  mrt.name;

-- ============================================================================

-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080'::uuid;

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
    'b19c1271-4ff7-4dd6-b3b6-e879cfa2d080'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
