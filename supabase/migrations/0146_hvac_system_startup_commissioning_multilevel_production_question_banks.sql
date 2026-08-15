-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0146_hvac_system_startup_commissioning_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: System Startup & Commissioning
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

create temporary table _seed_hvac_system_startup_commissioning_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_system_startup_commissioning_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of HVAC system startup?',
  '[{"key":"A","text":"To verify the installed system is ready to operate and begins operating as intended"},{"key":"B","text":"To replace the installation process"},{"key":"C","text":"To guarantee the system will never require service"},{"key":"D","text":"To skip manufacturer instructions"}]'::jsonb,
  '["A"]'::jsonb,
  'Startup is the initial process of placing the installed system into operation while checking that basic installation and operating conditions are acceptable.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is commissioning intended to confirm?',
  '[{"key":"A","text":"That the HVAC system and its major functions operate according to the intended requirements"},{"key":"B","text":"That every component is the same brand"},{"key":"C","text":"That the system has the largest possible capacity"},{"key":"D","text":"That no documentation is needed"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning verifies that system operation, controls, airflow, temperatures, and related functions are performing as intended.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should startup procedures follow manufacturer instructions?',
  '[{"key":"A","text":"Because equipment may require specific checks, sequences, settings, and limits for proper startup"},{"key":"B","text":"Because manufacturer instructions replace all job-site safety requirements"},{"key":"C","text":"Because every HVAC system starts exactly the same way"},{"key":"D","text":"Because field measurements are unnecessary"}]'::jsonb,
  '["A"]'::jsonb,
  'Manufacturer startup requirements help ensure equipment is operated and verified within intended conditions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is a pre-start inspection important?',
  '[{"key":"A","text":"It helps identify incomplete installation, loose connections, blocked airflow, missing components, or other problems before operation"},{"key":"B","text":"It guarantees the refrigerant charge is correct without testing"},{"key":"C","text":"It replaces functional testing"},{"key":"D","text":"It eliminates the need for documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A pre-start inspection can catch obvious installation and readiness issues before equipment is energized or operated.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What should be confirmed before energizing newly installed HVAC equipment?',
  '[{"key":"A","text":"The installation is complete enough for safe startup and required power, controls, and basic connections are ready"},{"key":"B","text":"The thermostat is set to the lowest possible temperature"},{"key":"C","text":"All panels are removed"},{"key":"D","text":"The system has already passed every commissioning test"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should not be energized until basic installation readiness and required connections have been confirmed.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why are startup measurements documented?',
  '[{"key":"A","text":"They provide a record of initial operating conditions for verification, troubleshooting, and future reference"},{"key":"B","text":"They eliminate the need for future maintenance"},{"key":"C","text":"They guarantee the equipment warranty"},{"key":"D","text":"They are only needed if the system fails"}]'::jsonb,
  '["A"]'::jsonb,
  'Documented startup data creates a useful baseline of how the system operated when placed into service.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is a functional check?',
  '[{"key":"A","text":"A test that confirms a system component or sequence responds and operates as intended"},{"key":"B","text":"A visual inspection of equipment color"},{"key":"C","text":"A replacement for all measurements"},{"key":"D","text":"A method of increasing system capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional checks verify that equipment, controls, safeties, and sequences respond correctly during operation.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should obvious installation problems be corrected before startup continues?',
  '[{"key":"A","text":"Because operating equipment with known installation defects can cause poor performance, damage, or unsafe conditions"},{"key":"B","text":"Because startup should always be completed before any correction"},{"key":"C","text":"Because documentation is more important than equipment condition"},{"key":"D","text":"Because all installation problems disappear once equipment runs"}]'::jsonb,
  '["A"]'::jsonb,
  'Known installation defects should be addressed before continued operation so the system is not tested under improper conditions.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer is preparing to start a new air handler. A shipping brace is still installed on a moving component. What is the BEST action?',
  '[{"key":"A","text":"Remove the shipping restraint as required before startup"},{"key":"B","text":"Start the unit and remove it later"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Ignore it if the unit has power"}]'::jsonb,
  '["A"]'::jsonb,
  'Shipping restraints and temporary installation items that interfere with operation should be removed according to the equipment requirements before startup.'
),
(
  10,
  'multiple_choice',
  'application',
  'A newly installed system is ready for startup, but the return-air filter has not been installed. What should happen?',
  '[{"key":"A","text":"Install the required filter before normal startup and operation"},{"key":"B","text":"Run the system without a filter for the first week"},{"key":"C","text":"Close the return opening"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Required air-side components should be in place so startup occurs under intended operating conditions.'
),
(
  11,
  'multiple_choice',
  'application',
  'A new condensing unit has been installed, but the service valves are not in the required operating position. What is the BEST response?',
  '[{"key":"A","text":"Follow the approved startup procedure and place the valves in the required position before normal operation"},{"key":"B","text":"Start the compressor anyway"},{"key":"C","text":"Increase thermostat demand"},{"key":"D","text":"Remove the disconnect"}]'::jsonb,
  '["A"]'::jsonb,
  'Startup should confirm required valve and system configuration before the equipment operates.'
),
(
  12,
  'multiple_choice',
  'application',
  'During startup, an installer notices the blower wheel is rotating in the wrong direction. What should happen?',
  '[{"key":"A","text":"Stop operation and correct the cause before continuing commissioning"},{"key":"B","text":"Continue because airflow direction does not matter"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Close supply registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect rotation can significantly affect airflow and equipment performance and should be corrected before further testing.'
),
(
  13,
  'multiple_choice',
  'application',
  'A thermostat calls for cooling, but the outdoor unit does not start during initial commissioning. What is the BEST first response?',
  '[{"key":"A","text":"Verify the required power and control conditions before assuming the outdoor equipment is defective"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Startup troubleshooting should begin by confirming the expected power and control conditions for the equipment.'
),
(
  14,
  'multiple_choice',
  'application',
  'Why should supply and return air temperatures be checked during startup?',
  '[{"key":"A","text":"They help confirm that the system is producing an expected heating or cooling response under the current conditions"},{"key":"B","text":"They determine the equipment voltage"},{"key":"C","text":"They replace airflow verification"},{"key":"D","text":"They determine duct material"}]'::jsonb,
  '["A"]'::jsonb,
  'Air-temperature measurements provide useful evidence that the system is transferring heat and operating in the commanded mode.'
),
(
  15,
  'multiple_choice',
  'application',
  'An installer hears unusual vibration immediately after startup. What is the BEST action?',
  '[{"key":"A","text":"Stop or pause operation as appropriate and identify the cause before continuing normal commissioning"},{"key":"B","text":"Ignore it until the customer complains"},{"key":"C","text":"Increase fan speed"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Unusual vibration can indicate installation, balance, mounting, or equipment problems that should be addressed before continued operation.'
),
(
  16,
  'multiple_choice',
  'application',
  'A startup checklist requires verification that condensate drains properly. What should the installer do?',
  '[{"key":"A","text":"Confirm the drain path is complete and that condensate can flow as intended"},{"key":"B","text":"Assume the drain works if piping is visible"},{"key":"C","text":"Seal the drain closed during startup"},{"key":"D","text":"Ignore condensate until the first maintenance visit"}]'::jsonb,
  '["A"]'::jsonb,
  'Drainage should be functionally verified so condensate does not back up or create water problems after the system is placed into service.'
),
(
  17,
  'scenario',
  'scenario',
  'A new split system is being started for the first time. The indoor blower runs, but airflow is very low because several supply dampers are still closed from construction. What is the BEST response?',
  '[{"key":"A","text":"Correct the air-distribution condition before continuing performance checks"},{"key":"B","text":"Adjust refrigerant charge immediately"},{"key":"C","text":"Replace the blower motor"},{"key":"D","text":"Ignore airflow until project closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning measurements should be taken with the system configured for intended airflow rather than under obvious installation restrictions.'
),
(
  18,
  'scenario',
  'scenario',
  'During startup of a new rooftop unit, the installer notices one access panel is not secured and internal wiring is close to a moving fan assembly. What is the BEST action?',
  '[{"key":"A","text":"Stop and correct the installation condition before continuing operation"},{"key":"B","text":"Run the unit briefly to see whether the wire moves"},{"key":"C","text":"Increase fan speed"},{"key":"D","text":"Close the panel after commissioning is complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Known conditions that can create damage or unsafe operation should be corrected before startup continues.'
),
(
  19,
  'scenario',
  'scenario',
  'A helper records startup readings but notices one value is far outside the manufacturer expected range. What is the BEST response?',
  '[{"key":"A","text":"Report the abnormal reading and have the condition evaluated before treating startup as complete"},{"key":"B","text":"Change the recorded number to match the expected range"},{"key":"C","text":"Leave the value undocumented"},{"key":"D","text":"Complete commissioning without mentioning it"}]'::jsonb,
  '["A"]'::jsonb,
  'Abnormal startup data should be investigated or escalated rather than ignored or altered.'
),
(
  20,
  'scenario',
  'scenario',
  'A new system appears to heat and cool, but the installer has not tested thermostat mode changes, fan operation, or basic control responses. What is the BEST conclusion?',
  '[{"key":"A","text":"Startup is not complete until the required functional checks are performed and documented"},{"key":"B","text":"Startup is complete because the equipment turned on once"},{"key":"C","text":"Controls do not need commissioning"},{"key":"D","text":"Documentation is optional"}]'::jsonb,
  '["A"]'::jsonb,
  'Successful startup requires more than initial operation; required controls and functional sequences should also be verified.'
);

create temporary table _seed_hvac_system_startup_commissioning_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_system_startup_commissioning_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should startup and commissioning requirements be considered during HVAC system design?',
  '[{"key":"A","text":"The design must support required testing, adjustment, access, controls verification, and performance confirmation"},{"key":"B","text":"Commissioning begins only after warranty expiration"},{"key":"C","text":"Startup requirements do not affect design decisions"},{"key":"D","text":"Commissioning replaces equipment selection"}]'::jsonb,
  '["A"]'::jsonb,
  'Design decisions can directly affect whether equipment and systems can be properly started, tested, adjusted, and verified.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a commissioning requirement?',
  '[{"key":"A","text":"A defined condition, test, measurement, or functional result that should be verified before system acceptance"},{"key":"B","text":"A sales discount applied after installation"},{"key":"C","text":"A substitute for construction documents"},{"key":"D","text":"An optional equipment color selection"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning requirements define what must be checked or demonstrated to confirm intended system operation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should design documents identify intended operating sequences?',
  '[{"key":"A","text":"They provide a basis for control programming, functional testing, and commissioning verification"},{"key":"B","text":"They eliminate the need for controls"},{"key":"C","text":"They determine refrigerant type automatically"},{"key":"D","text":"They replace equipment submittals"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning relies on a defined sequence of operation so actual system behavior can be compared with intended behavior.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is equipment access important to commissioning?',
  '[{"key":"A","text":"Required components, sensors, test points, filters, panels, and adjustment locations must be accessible for verification and service"},{"key":"B","text":"Access matters only after equipment failure"},{"key":"C","text":"Commissioning requires no physical access"},{"key":"D","text":"Access affects aesthetics only"}]'::jsonb,
  '["A"]'::jsonb,
  'A design that prevents access to important test or service points can make proper startup and commissioning difficult or impossible.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should commissioning documentation requirements be established before project completion?',
  '[{"key":"A","text":"So required startup data, test results, deficiencies, and acceptance information can be captured consistently"},{"key":"B","text":"So field measurements can be avoided"},{"key":"C","text":"So the contractor can skip functional testing"},{"key":"D","text":"So equipment warranties are automatically extended"}]'::jsonb,
  '["A"]'::jsonb,
  'Defining documentation requirements early helps ensure the information needed for turnover and verification is actually collected.'
),
(
  6,
  'multiple_choice',
  'application',
  'A design engineer specifies a variable-air-volume system but does not define the intended control sequence. What commissioning problem can result?',
  '[{"key":"A","text":"The field team may have no clear basis for verifying whether the system responds correctly under changing load conditions"},{"key":"B","text":"The ductwork will automatically become undersized"},{"key":"C","text":"The equipment voltage will change"},{"key":"D","text":"The refrigerant charge will be impossible to measure"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional testing requires a documented expected sequence so observed control behavior can be evaluated against design intent.'
),
(
  7,
  'multiple_choice',
  'application',
  'A rooftop unit design places a critical sensor where it cannot be safely accessed after installation. What is the BEST response during design review?',
  '[{"key":"A","text":"Revise the location or access provisions so the sensor can be verified, calibrated, and serviced as required"},{"key":"B","text":"Leave the design unchanged and assume the sensor will never require attention"},{"key":"C","text":"Remove the sensor from commissioning requirements"},{"key":"D","text":"Increase equipment capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning and lifecycle service requirements should influence component placement and access decisions.'
),
(
  8,
  'multiple_choice',
  'application',
  'A design includes several operating modes for a heat-pump system. What should be available to support commissioning?',
  '[{"key":"A","text":"A clear sequence describing how the system should respond in each intended operating mode"},{"key":"B","text":"Only the equipment model number"},{"key":"C","text":"Only the thermostat color"},{"key":"D","text":"Only the estimated project cost"}]'::jsonb,
  '["A"]'::jsonb,
  'Mode-specific sequences give the commissioning team a basis for testing cooling, heating, auxiliary heat, defrost, and other required functions.'
),
(
  9,
  'multiple_choice',
  'application',
  'A project requires measured airflow verification at several major air-handling units. What design feature supports that requirement?',
  '[{"key":"A","text":"Appropriate access, test locations, balancing provisions, and system configuration that allow airflow to be measured and adjusted"},{"key":"B","text":"Sealed access panels with no test points"},{"key":"C","text":"Eliminating balancing dampers"},{"key":"D","text":"Using larger thermostats"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning requirements should be supported by practical means to measure and adjust system performance.'
),
(
  10,
  'multiple_choice',
  'application',
  'A controls design includes safeties and alarms but does not specify what should happen when each safety activates. What should be added?',
  '[{"key":"A","text":"Expected equipment response, alarm behavior, reset logic, and related sequence requirements"},{"key":"B","text":"A larger equipment breaker"},{"key":"C","text":"Additional refrigerant charge"},{"key":"D","text":"A lower thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Safeties and alarms should have defined expected responses so commissioning can verify they operate as intended.'
),
(
  11,
  'multiple_choice',
  'application',
  'A design engineer learns that specified equipment requires a manufacturer startup procedure by an authorized technician. What should happen?',
  '[{"key":"A","text":"Include that requirement in the project scope, schedule, coordination, and commissioning plan"},{"key":"B","text":"Ignore it until after installation"},{"key":"C","text":"Have any worker sign the startup form"},{"key":"D","text":"Remove startup from the project"}]'::jsonb,
  '["A"]'::jsonb,
  'Manufacturer-specific startup requirements should be coordinated before installation completion so they do not become late project obstacles.'
),
(
  12,
  'multiple_choice',
  'application',
  'A building automation system must trend space temperature and equipment operation during commissioning. What should the design team verify?',
  '[{"key":"A","text":"That the required points, sensors, trend capabilities, and control-system access are included in the design"},{"key":"B","text":"That only local thermostats are installed"},{"key":"C","text":"That trend data is deleted after each hour"},{"key":"D","text":"That no commissioning access is provided"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning data requirements must be supported by the specified controls architecture and available points.'
),
(
  13,
  'multiple_choice',
  'application',
  'A project calls for testing both normal and setback operating modes. What should the commissioning plan include?',
  '[{"key":"A","text":"Functional tests that intentionally place the system into each required mode and verify expected responses"},{"key":"B","text":"Testing normal mode only"},{"key":"C","text":"Skipping controls testing if temperatures appear comfortable"},{"key":"D","text":"Changing the design after project turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'Required operating modes should be exercised during commissioning rather than assumed to work because one mode is functional.'
),
(
  14,
  'multiple_choice',
  'application',
  'A design specifies outdoor-air ventilation control based on a sensor. What should be verified during commissioning planning?',
  '[{"key":"A","text":"The sensor location, control sequence, minimum ventilation requirements, and method for confirming actual operation"},{"key":"B","text":"Only the sensor brand"},{"key":"C","text":"Only the equipment paint color"},{"key":"D","text":"Only thermostat scheduling"}]'::jsonb,
  '["A"]'::jsonb,
  'Sensor-based ventilation must be testable against a defined sequence and intended airflow requirement.'
),
(
  15,
  'scenario',
  'scenario',
  'A design-and-sales engineer reviews a project where the customer expects detailed system commissioning, but the proposal includes only basic equipment startup. What is the BEST response?',
  '[{"key":"A","text":"Clarify the difference and revise the scope so the required functional testing, measurements, documentation, and responsibilities are defined"},{"key":"B","text":"Leave the proposal unchanged and call basic startup full commissioning"},{"key":"C","text":"Remove all startup documentation"},{"key":"D","text":"Assume the installer will provide commissioning at no cost"}]'::jsonb,
  '["A"]'::jsonb,
  'Startup and commissioning can involve different levels of verification, so proposal scope should accurately reflect the customer and project requirements.'
),
(
  16,
  'scenario',
  'scenario',
  'A project sequence requires the supply fan to prove airflow before heating stages can energize, but this interlock is missing from the controls drawings. What is the BEST Level 2 response?',
  '[{"key":"A","text":"Correct the controls design so the required interlock can be programmed and functionally tested"},{"key":"B","text":"Leave the interlock for the startup technician to invent"},{"key":"C","text":"Remove the heating-stage test"},{"key":"D","text":"Increase fan speed instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Required system safeties and operating interlocks should be represented in the design so they can be implemented and commissioned.'
),
(
  17,
  'scenario',
  'scenario',
  'A specification requires balancing of a multi-zone air system, but the design omits balancing dampers at several branches. What is the BEST response?',
  '[{"key":"A","text":"Revise the design to provide a practical means of balancing the required airflows before commissioning"},{"key":"B","text":"Keep the design and estimate airflow by room temperature"},{"key":"C","text":"Increase total system airflow"},{"key":"D","text":"Eliminate the balancing requirement"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning requirements must be supported by system features that permit required adjustment and verification.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer requires trend verification of occupied and unoccupied operation for several days after startup. The proposed controls package has no trending capability. What is the BEST response?',
  '[{"key":"A","text":"Revise the controls solution or commissioning method so the specified trend verification can actually be performed"},{"key":"B","text":"Promise trending anyway"},{"key":"C","text":"Remove the requirement without informing the customer"},{"key":"D","text":"Use equipment nameplate data as trend history"}]'::jsonb,
  '["A"]'::jsonb,
  'The selected controls solution must support the commissioning evidence required by the project.'
),
(
  19,
  'scenario',
  'scenario',
  'A replacement project will reuse existing ductwork, but the customer expects documented airflow performance after installation. Existing test access is very limited. What is the BEST design response?',
  '[{"key":"A","text":"Identify the required testing approach and add access or measurement provisions needed to verify airflow performance"},{"key":"B","text":"Guarantee airflow without measurement"},{"key":"C","text":"Remove airflow from commissioning"},{"key":"D","text":"Assume existing ductwork performs correctly because it is already installed"}]'::jsonb,
  '["A"]'::jsonb,
  'If airflow verification is part of acceptance, the design must provide a practical way to obtain the required measurements.'
),
(
  20,
  'scenario',
  'scenario',
  'A project includes equipment from several manufacturers, a third-party controls system, and multiple subcontractors. What should the design-and-sales engineer establish before finalizing commissioning scope?',
  '[{"key":"A","text":"Clear responsibilities, interfaces, required startup procedures, functional tests, documentation, and acceptance criteria across all parties"},{"key":"B","text":"Only the equipment purchase prices"},{"key":"C","text":"That every subcontractor uses the same tools"},{"key":"D","text":"That commissioning begins after final payment"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex systems require clear coordination of who starts, tests, documents, corrects, and verifies each part of the commissioned system.'
);

create temporary table _seed_hvac_system_startup_commissioning_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_system_startup_commissioning_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in System Startup & Commissioning?',
  '[{"key":"A","text":"Starting equipment whenever power is available without documenting results"},{"key":"B","text":"Independently performing startup, interpreting operating data, verifying system functions, and identifying abnormal conditions"},{"key":"C","text":"Completing only visual inspections"},{"key":"D","text":"Treating startup as complete once the equipment turns on"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent startup and commissioning work using measurements, functional verification, manufacturer information, and technical judgment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a technician allow an HVAC system to stabilize before evaluating many operating measurements?',
  '[{"key":"A","text":"Because pressures, temperatures, airflow, and control responses may change as the system reaches a steady operating condition"},{"key":"B","text":"Because startup measurements are never useful during the first day"},{"key":"C","text":"Because stabilization automatically corrects installation defects"},{"key":"D","text":"Because all systems require exactly one hour before testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Meaningful commissioning measurements should be interpreted under suitable and reasonably stable operating conditions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of comparing commissioning measurements with manufacturer specifications or approved design criteria?',
  '[{"key":"A","text":"To determine whether actual system operation is within the expected range"},{"key":"B","text":"To eliminate the need for technician judgment"},{"key":"C","text":"To determine equipment color"},{"key":"D","text":"To replace all functional testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Measured values become useful when they are compared with appropriate expected values, limits, and operating conditions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should commissioning include verification of safeties and operating controls?',
  '[{"key":"A","text":"Because normal operation alone does not prove that required control responses and protective functions work as intended"},{"key":"B","text":"Because safeties are only checked after a failure"},{"key":"C","text":"Because control verification replaces airflow testing"},{"key":"D","text":"Because commissioning requires disabling protective devices"}]'::jsonb,
  '["A"]'::jsonb,
  'Functional commissioning confirms that control sequences, interlocks, and protective responses operate as intended.'
),
(
  5,
  'multiple_choice',
  'application',
  'During cooling startup, suction and discharge pressures appear abnormal. What should the technician do before making a refrigerant-charge adjustment?',
  '[{"key":"A","text":"Verify airflow, operating conditions, system configuration, temperatures, and other relevant startup data before concluding the charge is incorrect"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Increase thermostat demand"}]'::jsonb,
  '["A"]'::jsonb,
  'Pressure readings should be interpreted with airflow, load, temperature, and other system conditions rather than used alone to justify charge changes.'
),
(
  6,
  'multiple_choice',
  'application',
  'A newly started heat pump operates in cooling but will not change properly into heating mode. What is the BEST commissioning approach?',
  '[{"key":"A","text":"Verify the control sequence and required components for mode change and determine where the expected transition fails"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the indoor blower"},{"key":"D","text":"Ignore heating mode until winter"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning should exercise required operating modes and trace any failed sequence systematically.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician measures substantially less airflow than required during system startup. What should happen before final performance verification?',
  '[{"key":"A","text":"Identify and correct air-side causes such as blower setup, filters, dampers, restrictions, duct conditions, or configuration"},{"key":"B","text":"Adjust refrigerant charge first"},{"key":"C","text":"Accept the low airflow if space temperature changes"},{"key":"D","text":"Increase thermostat differential"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow is a core operating condition and should be corrected before other performance conclusions are finalized.'
),
(
  8,
  'multiple_choice',
  'application',
  'During startup, compressor current is higher than expected. What should the technician evaluate?',
  '[{"key":"A","text":"Supply conditions, refrigerant-system operating conditions, equipment loading, airflow, and manufacturer operating information"},{"key":"B","text":"Thermostat color only"},{"key":"C","text":"Duct insulation only"},{"key":"D","text":"Condensate pipe color"}]'::jsonb,
  '["A"]'::jsonb,
  'Abnormal current should be evaluated in context because electrical and mechanical system conditions can affect compressor loading.'
),
(
  9,
  'multiple_choice',
  'application',
  'A system reaches the thermostat setpoint, but measured temperature rise across a furnace is outside the manufacturer specified range. What is the BEST response?',
  '[{"key":"A","text":"Investigate airflow, firing conditions, setup, and related causes before accepting commissioning"},{"key":"B","text":"Accept the system because the thermostat is satisfied"},{"key":"C","text":"Increase the thermostat setpoint"},{"key":"D","text":"Ignore the measurement"}]'::jsonb,
  '["A"]'::jsonb,
  'Meeting space temperature alone does not prove that equipment is operating within required manufacturer limits.'
),
(
  10,
  'multiple_choice',
  'application',
  'A rooftop unit has an economizer. What should the technician verify during commissioning?',
  '[{"key":"A","text":"That dampers, sensors, controls, and changeover logic respond correctly under the required test conditions"},{"key":"B","text":"Only that the mechanical cooling compressor starts"},{"key":"C","text":"Only that the thermostat display is powered"},{"key":"D","text":"That outdoor-air dampers remain closed in every mode"}]'::jsonb,
  '["A"]'::jsonb,
  'Economizer commissioning requires functional verification of its sensors, dampers, controls, and intended operating sequence.'
),
(
  11,
  'multiple_choice',
  'application',
  'Commissioning data shows correct supply voltage but one three-phase motor has a significant phase-to-phase current imbalance. What should the technician do?',
  '[{"key":"A","text":"Investigate the motor, phase conditions, connections, loading, and related causes before accepting operation"},{"key":"B","text":"Average the currents and ignore the imbalance"},{"key":"C","text":"Increase the breaker size"},{"key":"D","text":"Adjust refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Current imbalance can indicate an electrical or loading problem even when supply voltage appears acceptable.'
),
(
  12,
  'scenario',
  'scenario',
  'A newly installed split system has low suction pressure, high superheat, and poor cooling during startup. Airflow is also substantially below design because the blower is set incorrectly. What is the BEST next step?',
  '[{"key":"A","text":"Correct and verify airflow before making a refrigerant-charge conclusion"},{"key":"B","text":"Add refrigerant immediately based on suction pressure"},{"key":"C","text":"Replace the metering device immediately"},{"key":"D","text":"Increase the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Low airflow can distort refrigeration measurements, so the air side should be brought into proper operating condition before charge is evaluated.'
),
(
  13,
  'scenario',
  'scenario',
  'During commissioning, a furnace starts and heats normally, but the technician discovers that opening a required safety circuit does not shut the burner down as intended. What is the BEST response?',
  '[{"key":"A","text":"Stop acceptance and correct the safety-control problem before placing the equipment into normal service"},{"key":"B","text":"Accept the furnace because it heats normally"},{"key":"C","text":"Document the issue for the next maintenance visit only"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A failed protective function is a commissioning deficiency that must be corrected before the system is treated as ready for normal operation.'
),
(
  14,
  'scenario',
  'scenario',
  'A heat pump runs in both heating and cooling, but auxiliary heat energizes at the wrong stage and remains on longer than the sequence requires. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Verify thermostat configuration, control logic, staging inputs, and sequence settings and correct the cause"},{"key":"B","text":"Accept the system because both modes operate"},{"key":"C","text":"Disconnect auxiliary heat permanently"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning must verify staging and control sequence, not simply confirm that major equipment components can run.'
),
(
  15,
  'scenario',
  'scenario',
  'A packaged unit is commissioned on a mild day. The technician cannot establish the operating conditions required for a reliable refrigerant-charge check. What is the BEST response?',
  '[{"key":"A","text":"Follow the manufacturer approved method for the available conditions and document any verification that must be completed later under suitable conditions"},{"key":"B","text":"Guess the final charge from suction pressure"},{"key":"C","text":"Add refrigerant until the suction line feels cold"},{"key":"D","text":"Record estimated readings as measured values"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning conclusions should be based on valid procedures and operating conditions, with limitations documented when final verification cannot yet be completed.'
),
(
  16,
  'scenario',
  'scenario',
  'A new air handler has correct total airflow, but two zones receive far less airflow than their design values while other zones receive too much. What is the BEST commissioning response?',
  '[{"key":"A","text":"Continue air-distribution balancing and investigate branch restrictions or damper conditions before accepting the system"},{"key":"B","text":"Increase total blower speed until the low zones improve"},{"key":"C","text":"Adjust refrigerant charge"},{"key":"D","text":"Accept the system because total airflow is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'Total airflow alone does not confirm proper distribution; zone and branch performance may still require balancing and correction.'
),
(
  17,
  'scenario',
  'scenario',
  'During startup, a condensing unit repeatedly trips on high pressure. The condenser coil is clean, but the condenser fan is cycling off unexpectedly while the compressor continues to run. What is the BEST next step?',
  '[{"key":"A","text":"Diagnose and correct the condenser-fan control or operating problem before evaluating refrigerant charge"},{"key":"B","text":"Recover refrigerant immediately"},{"key":"C","text":"Increase the high-pressure limit"},{"key":"D","text":"Bypass the fan control"}]'::jsonb,
  '["A"]'::jsonb,
  'Loss of condenser airflow can cause high head pressure and should be corrected before refrigerant-charge conclusions are made.'
),
(
  18,
  'scenario',
  'scenario',
  'A commissioning report shows all required measurements within range, but several values were copied from the previous day instead of being taken during the final test. What is the BEST response?',
  '[{"key":"A","text":"Repeat the required measurements under the final operating conditions and document the actual results"},{"key":"B","text":"Accept the copied values because they were previously correct"},{"key":"C","text":"Delete the commissioning report"},{"key":"D","text":"Estimate new readings from the old values"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning records should represent actual verified conditions at the time of the required test.'
),
(
  19,
  'scenario',
  'scenario',
  'A newly commissioned system performs correctly in occupied mode, but the scheduled unoccupied mode has never been tested. The customer expects automatic setback operation. What is the BEST response?',
  '[{"key":"A","text":"Functionally test the unoccupied sequence and verify the expected control responses before commissioning is complete"},{"key":"B","text":"Assume the schedule will work because occupied mode works"},{"key":"C","text":"Disable scheduling"},{"key":"D","text":"Tell the customer to test it after turnover"}]'::jsonb,
  '["A"]'::jsonb,
  'Each required operating mode should be functionally verified rather than inferred from successful operation in another mode.'
),
(
  20,
  'scenario',
  'scenario',
  'After startup adjustments, a technician obtains acceptable temperatures and pressures, but does not record the final blower setting, control configuration, or measured values. What is the BEST conclusion?',
  '[{"key":"A","text":"Commissioning is incomplete until the final settings and verification data are documented"},{"key":"B","text":"Documentation is unnecessary once operation appears normal"},{"key":"C","text":"Only the thermostat setpoint needs to be recorded"},{"key":"D","text":"The technician should reset all settings to factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'Final commissioning documentation establishes the verified configuration and operating baseline for future service and system ownership.'
);

create temporary table _seed_hvac_system_startup_commissioning_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_system_startup_commissioning_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in System Startup & Commissioning?',
  '[{"key":"A","text":"Leading complex commissioning, interpreting interacting system data, resolving deficiencies, and validating final performance"},{"key":"B","text":"Confirming only that equipment turns on"},{"key":"C","text":"Delegating all measurements without review"},{"key":"D","text":"Treating commissioning as a paperwork exercise"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 performance includes advanced system-level verification, technical leadership, interpretation of interacting operating conditions, and resolution of commissioning deficiencies.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is trend data useful during advanced HVAC commissioning?',
  '[{"key":"A","text":"It can reveal operating patterns, staging behavior, control instability, and conditions that may not appear during a brief functional test"},{"key":"B","text":"It replaces all field measurements"},{"key":"C","text":"It proves equipment sizing automatically"},{"key":"D","text":"It eliminates the need for sequence verification"}]'::jsonb,
  '["A"]'::jsonb,
  'Trend data allows a senior technician to evaluate system behavior over time and under changing loads rather than relying only on a single snapshot.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of an integrated functional performance test?',
  '[{"key":"A","text":"To verify that multiple components, controls, safeties, and sequences work together correctly under defined operating conditions"},{"key":"B","text":"To test each component only while disconnected from the system"},{"key":"C","text":"To replace equipment startup procedures"},{"key":"D","text":"To determine project pricing"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated testing confirms that the complete system behaves correctly as components and controls interact.'
),
(
  4,
  'multiple_choice',
  'application',
  'A large air-handling system meets total airflow requirements but has unstable static pressure as terminal boxes open and close. What should a senior technician evaluate?',
  '[{"key":"A","text":"Static-pressure sensing, control-loop response, fan-speed control, terminal behavior, and the intended sequence"},{"key":"B","text":"Refrigerant charge only"},{"key":"C","text":"Thermostat color"},{"key":"D","text":"Filter brand only"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced commissioning should evaluate dynamic system interaction when total airflow appears acceptable but control behavior is unstable.'
),
(
  5,
  'multiple_choice',
  'application',
  'A chilled-water air handler meets discharge-air temperature requirements, but the control valve remains nearly fully open under light load. What should be investigated?',
  '[{"key":"A","text":"Valve authority, water flow, coil performance, sensor accuracy, control tuning, and system operating conditions"},{"key":"B","text":"Thermostat appearance"},{"key":"C","text":"Duct insulation color"},{"key":"D","text":"Compressor breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'A control output near its limit under light load can indicate flow, sensor, valve, coil, or control issues that deserve system-level evaluation.'
),
(
  6,
  'multiple_choice',
  'application',
  'During commissioning of a multi-stage rooftop unit, stages are cycling rapidly even though space load is relatively stable. What is the BEST advanced approach?',
  '[{"key":"A","text":"Review staging thresholds, sensor stability, time delays, control logic, equipment capacity, and actual load conditions"},{"key":"B","text":"Increase thermostat demand"},{"key":"C","text":"Disable one stage permanently"},{"key":"D","text":"Add refrigerant automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Rapid staging can result from control logic, sensing, oversized capacity, or unstable load signals and should be evaluated systematically.'
),
(
  7,
  'multiple_choice',
  'application',
  'A senior technician sees acceptable individual component operation but poor overall system efficiency. What should happen next?',
  '[{"key":"A","text":"Evaluate how airflow, refrigerant operation, controls, staging, setpoints, ventilation, and load conditions interact at the system level"},{"key":"B","text":"Accept the system because each component runs"},{"key":"C","text":"Replace the thermostat"},{"key":"D","text":"Increase every equipment setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'System commissioning requires evaluating interactions between components rather than judging each piece in isolation.'
),
(
  8,
  'multiple_choice',
  'application',
  'A building automation trend shows a supply-air temperature repeatedly overshooting and undershooting its setpoint. What should a Level 4 technician investigate?',
  '[{"key":"A","text":"Sensor accuracy, control-loop tuning, actuator response, equipment staging, load changes, and sequence logic"},{"key":"B","text":"Only filter condition"},{"key":"C","text":"Only refrigerant type"},{"key":"D","text":"Only thermostat scheduling"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated oscillation can indicate a control-loop or system-response problem that requires analysis of sensing, actuation, tuning, and equipment behavior.'
),
(
  9,
  'multiple_choice',
  'application',
  'Commissioning reveals that several installed sensors are consistently offset from calibrated reference instruments. What is the BEST response?',
  '[{"key":"A","text":"Correct or calibrate the sensing problem and repeat affected functional tests using reliable measurements"},{"key":"B","text":"Average the incorrect readings"},{"key":"C","text":"Ignore the offsets if equipment still runs"},{"key":"D","text":"Change setpoints to compensate permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning decisions depend on trustworthy measurements, so inaccurate sensors should be corrected before final verification.'
),
(
  10,
  'multiple_choice',
  'application',
  'A senior technician is reviewing commissioning results from several technicians. What is the BEST quality-control practice?',
  '[{"key":"A","text":"Check that required tests were completed under valid conditions, results are internally consistent, deficiencies are resolved, and final values are documented"},{"key":"B","text":"Approve all reports if every field contains a number"},{"key":"C","text":"Accept estimated values when measurements are missing"},{"key":"D","text":"Review only thermostat setpoints"}]'::jsonb,
  '["A"]'::jsonb,
  'Senior-level commissioning includes validating the quality and technical credibility of test results, not merely confirming that forms were completed.'
),
(
  11,
  'scenario',
  'scenario',
  'A variable-air-volume system passes individual box tests, but during simultaneous operation several zones become unstable and the supply fan repeatedly hunts. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Test the integrated system under representative load, evaluate static-pressure reset, box minimums, sensor location, fan control, and interaction among zones"},{"key":"B","text":"Replace every VAV controller"},{"key":"C","text":"Increase fan speed permanently"},{"key":"D","text":"Accept the system because each box passed individually"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated system problems may not appear in individual component tests and require coordinated functional testing under realistic conditions.'
),
(
  12,
  'scenario',
  'scenario',
  'A heat-pump system meets capacity expectations, but auxiliary heat frequently operates during mild weather. Trend data shows the auxiliary stage is being enabled shortly after each heating call begins. What is the BEST response?',
  '[{"key":"A","text":"Evaluate staging logic, thermostat configuration, lockout settings, sensor inputs, and sequence timing before accepting commissioning"},{"key":"B","text":"Accept the system because comfort is maintained"},{"key":"C","text":"Disconnect auxiliary heat permanently"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Excessive auxiliary heat can indicate improper control staging even when space temperature is maintained.'
),
(
  13,
  'scenario',
  'scenario',
  'A newly commissioned rooftop unit has normal refrigerant pressures at moderate load but repeatedly trips on high pressure during peak afternoon conditions. What is the BEST advanced commissioning plan?',
  '[{"key":"A","text":"Capture condenser airflow, outdoor conditions, fan operation, pressures, temperatures, control states, and equipment loading during the actual peak condition"},{"key":"B","text":"Remove refrigerant based only on the peak trip"},{"key":"C","text":"Increase the high-pressure limit"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent faults tied to peak conditions should be diagnosed using measurements taken when the problem actually occurs.'
),
(
  14,
  'scenario',
  'scenario',
  'A multi-zone system maintains average building temperature, but several zones consistently overheat while others overcool. Total supply airflow is within design range. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Evaluate zone airflow, balancing, terminal control, sensor accuracy, load assumptions, control sequence, and distribution rather than relying on total airflow alone"},{"key":"B","text":"Increase total fan speed"},{"key":"C","text":"Change the central thermostat setpoint"},{"key":"D","text":"Accept the system because average temperature is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'Acceptable aggregate performance can hide significant distribution and control deficiencies at the zone level.'
),
(
  15,
  'scenario',
  'scenario',
  'A commissioning team repeatedly adjusts refrigerant charge because pressures vary from visit to visit. The senior technician discovers airflow, outdoor temperature, and indoor load were different on each visit. What is the BEST response?',
  '[{"key":"A","text":"Establish valid and documented operating conditions, verify airflow, then evaluate charge using the manufacturer approved method"},{"key":"B","text":"Average all previous refrigerant adjustments"},{"key":"C","text":"Continue adjusting charge whenever pressure changes"},{"key":"D","text":"Ignore airflow because pressures are more important"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable refrigerant commissioning requires stable, appropriate operating conditions and verified airflow before charge conclusions are made.'
),
(
  16,
  'scenario',
  'scenario',
  'A building automation system shows frequent simultaneous heating and cooling in adjacent zones. What is the BEST senior-level commissioning response?',
  '[{"key":"A","text":"Review zone setpoints, deadbands, sensor accuracy, terminal sequences, reheat logic, central supply conditions, and scheduling to identify the cause"},{"key":"B","text":"Increase both heating and cooling capacity"},{"key":"C","text":"Disable alarms"},{"key":"D","text":"Accept the operation because all zones reach setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Simultaneous heating and cooling can indicate coordination or control problems that increase energy use while still maintaining comfort.'
),
(
  17,
  'scenario',
  'scenario',
  'A critical ventilation system passes airflow testing when manually commanded, but during normal automatic operation the outdoor-air damper sometimes remains closed. What is the BEST response?',
  '[{"key":"A","text":"Reproduce the automatic sequence and evaluate sensors, enable conditions, actuator response, control logic, interlocks, and alarms before acceptance"},{"key":"B","text":"Accept the system because manual operation works"},{"key":"C","text":"Leave the damper permanently open"},{"key":"D","text":"Increase supply fan speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Manual operation does not prove that the required automatic ventilation sequence functions correctly.'
),
(
  18,
  'scenario',
  'scenario',
  'A senior technician reviews a commissioning report showing excellent performance, but the final equipment settings do not match the settings documented during the tests. What is the BEST response?',
  '[{"key":"A","text":"Verify the current configuration and repeat any affected tests so the final report reflects the actual turnover condition"},{"key":"B","text":"Use the older test results anyway"},{"key":"C","text":"Change the report without retesting"},{"key":"D","text":"Reset every setting to factory default"}]'::jsonb,
  '["A"]'::jsonb,
  'Commissioning results should represent the actual final configuration delivered to the customer.'
),
(
  19,
  'scenario',
  'scenario',
  'A system passes startup but begins short cycling after occupancy increases. Trend data shows rapidly changing zone demands and aggressive equipment staging. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Analyze load behavior, staging logic, control deadbands, minimum run times, equipment capacity, and system response before changing hardware"},{"key":"B","text":"Replace the compressor immediately"},{"key":"C","text":"Increase breaker size"},{"key":"D","text":"Disable staging controls"}]'::jsonb,
  '["A"]'::jsonb,
  'Post-startup instability may reflect interaction between actual building load and control strategy and should be diagnosed with system-level evidence.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex project has passed individual equipment startup, balancing, and controls checks, but no one has tested how the HVAC system responds to loss of a key sensor, alarm conditions, mode transitions, and restoration of normal operation. What is the BEST conclusion?',
  '[{"key":"A","text":"Integrated commissioning is incomplete until required failure responses, transitions, safeties, alarms, and recovery sequences are functionally verified"},{"key":"B","text":"Commissioning is complete because normal operation passed"},{"key":"C","text":"Failure-mode testing is never part of commissioning"},{"key":"D","text":"Only equipment manufacturers should test controls"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced commissioning verifies not only normal operation but also required transitions, safeties, abnormal responses, and recovery behavior.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '46f0bd92-b947-4eda-812d-90791614822e';
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
      and c.name = 'System Startup & Commissioning'
      and c.is_current = true
  ) then
    raise exception 'Current System Startup & Commissioning Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L1 System Startup & Commissioning requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L2 System Startup & Commissioning requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 System Startup & Commissioning requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 System Startup & Commissioning requirement not found';
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
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'System Startup & Commissioning — Level 1 Competency Assessment';

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
    select * from _seed_hvac_system_startup_commissioning_l1_questions
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
        'System Startup & Commissioning',
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
      'IntegrateU System Startup & Commissioning L1 production assessment v1.0.',
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
        'System Startup & Commissioning',
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
        'IntegrateU System Startup & Commissioning L1 production assessment v1.0.',
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
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'System Startup & Commissioning — Level 2 Competency Assessment';

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
    select * from _seed_hvac_system_startup_commissioning_l2_questions
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
        'System Startup & Commissioning',
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
      'IntegrateU System Startup & Commissioning L2 production assessment v1.0.',
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
        'System Startup & Commissioning',
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
        'IntegrateU System Startup & Commissioning L2 production assessment v1.0.',
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
  v_assessment_name := 'System Startup & Commissioning — Level 3 Competency Assessment';

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
    select * from _seed_hvac_system_startup_commissioning_l3_questions
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
        'System Startup & Commissioning',
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
      'IntegrateU System Startup & Commissioning L3 production assessment v1.0.',
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
        'System Startup & Commissioning',
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
        'IntegrateU System Startup & Commissioning L3 production assessment v1.0.',
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
  v_assessment_name := 'System Startup & Commissioning — Level 4 Competency Assessment';

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
    select * from _seed_hvac_system_startup_commissioning_l4_questions
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
        'System Startup & Commissioning',
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
      'IntegrateU System Startup & Commissioning L4 production assessment v1.0.',
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
        'System Startup & Commissioning',
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
        'IntegrateU System Startup & Commissioning L4 production assessment v1.0.',
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
   '46f0bd92-b947-4eda-812d-90791614822e'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '46f0bd92-b947-4eda-812d-90791614822e'::uuid
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
      '46f0bd92-b947-4eda-812d-90791614822e'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '46f0bd92-b947-4eda-812d-90791614822e'::uuid
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
  '46f0bd92-b947-4eda-812d-90791614822e'::uuid;

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
    '46f0bd92-b947-4eda-812d-90791614822e'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
