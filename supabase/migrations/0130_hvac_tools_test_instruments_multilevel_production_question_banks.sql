-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_tools_test_instruments_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Tools & Test Instruments
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

create temporary table _seed_hvac_tools_test_instruments_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_tools_test_instruments_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an HVAC manifold gauge set?',
  '[{"key":"A","text":"To measure and access refrigerant-system pressures during appropriate service procedures"},{"key":"B","text":"To measure duct dimensions"},{"key":"C","text":"To determine motor rotation without electrical testing"},{"key":"D","text":"To measure indoor humidity only"}]'::jsonb,
  '["A"]'::jsonb,
  'A manifold gauge set provides service access and pressure information used during appropriate refrigerant-system testing and service.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does a digital multimeter commonly measure in HVAC work?',
  '[{"key":"A","text":"Electrical quantities such as voltage, resistance, and current when the meter and procedure are suitable"},{"key":"B","text":"Refrigerant type automatically"},{"key":"C","text":"Duct airflow without probes"},{"key":"D","text":"Combustion gases without sensors"}]'::jsonb,
  '["A"]'::jsonb,
  'A digital multimeter is commonly used for electrical measurements when configured and applied correctly.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is a clamp meter especially useful for measuring?',
  '[{"key":"A","text":"Electrical current without opening the conductor for a conventional series-current connection"},{"key":"B","text":"Refrigerant pressure"},{"key":"C","text":"Air velocity through a grille"},{"key":"D","text":"Copper tubing diameter"}]'::jsonb,
  '["A"]'::jsonb,
  'A clamp meter allows current measurement by sensing the magnetic field around an appropriate conductor.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the main purpose of a vacuum pump during HVAC installation or service?',
  '[{"key":"A","text":"To evacuate air and moisture from a refrigerant circuit before appropriate charging or commissioning"},{"key":"B","text":"To pressurize the system with refrigerant"},{"key":"C","text":"To test thermostat batteries"},{"key":"D","text":"To measure supply-air temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'A vacuum pump is used during evacuation to remove air and moisture from the refrigerant circuit.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a micron gauge used to evaluate?',
  '[{"key":"A","text":"The depth and behavior of a system vacuum during evacuation"},{"key":"B","text":"Motor amperage"},{"key":"C","text":"Room sound level"},{"key":"D","text":"Sheet-metal thickness"}]'::jsonb,
  '["A"]'::jsonb,
  'A micron gauge measures deep vacuum and helps evaluate evacuation progress and system behavior.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What instrument is commonly used to measure air temperature at HVAC equipment or duct locations?',
  '[{"key":"A","text":"A suitable thermometer or temperature probe"},{"key":"B","text":"A tubing cutter"},{"key":"C","text":"A recovery cylinder"},{"key":"D","text":"A torque wrench"}]'::jsonb,
  '["A"]'::jsonb,
  'Temperature probes and thermometers provide temperature measurements used in system evaluation.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is instrument accuracy important when evaluating HVAC system performance?',
  '[{"key":"A","text":"Bad measurements can lead to incorrect design, startup, diagnostic, or service conclusions"},{"key":"B","text":"Accuracy matters only when preparing invoices"},{"key":"C","text":"Approximate readings are always sufficient"},{"key":"D","text":"Instrument accuracy affects only tool warranty"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical decisions depend on trustworthy measurements, so instrument condition and accuracy matter.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should happen when a test instrument is visibly damaged or produces unreliable readings?',
  '[{"key":"A","text":"Remove it from use until its suitability, repair, or replacement is resolved"},{"key":"B","text":"Average several questionable readings"},{"key":"C","text":"Use it only on smaller systems"},{"key":"D","text":"Continue using it if the display still turns on"}]'::jsonb,
  '["A"]'::jsonb,
  'An instrument that cannot provide reliable or safe measurements should not be used as the basis for technical decisions.'
),
(
  9,
  'multiple_choice',
  'application',
  'A design engineer wants to confirm whether an existing fan is delivering approximately the expected airflow. Which approach is BEST?',
  '[{"key":"A","text":"Use appropriate airflow or pressure measurements and the applicable equipment or system data"},{"key":"B","text":"Judge airflow only by sound"},{"key":"C","text":"Measure refrigerant pressure instead"},{"key":"D","text":"Check thermostat color"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow conclusions should be based on suitable measurements and the relevant equipment or system information.'
),
(
  10,
  'multiple_choice',
  'application',
  'A project requires field verification of existing electrical service before replacement equipment is selected. What is the BEST approach?',
  '[{"key":"A","text":"Have qualified personnel use suitable electrical test instruments and procedures to verify the needed electrical conditions"},{"key":"B","text":"Assume the old equipment nameplate describes the building service"},{"key":"C","text":"Estimate voltage from wire color alone"},{"key":"D","text":"Select equipment first and test after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection should use reliable field information obtained with appropriate instruments and qualified procedures.'
),
(
  11,
  'multiple_choice',
  'application',
  'A field survey reports a temperature reading that conflicts sharply with other operating data. What should the design engineer do?',
  '[{"key":"A","text":"Question the measurement and verify probe placement, instrument condition, and reading before relying on it"},{"key":"B","text":"Use the reading because all instrument values are automatically correct"},{"key":"C","text":"Delete the other operating data"},{"key":"D","text":"Average the value with outdoor temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected measurements should be validated before they drive design or equipment-selection decisions.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician provides a single static-pressure reading but does not identify where the pressure was measured. What is the BEST design-review response?',
  '[{"key":"A","text":"Request the measurement locations and test method before interpreting the result"},{"key":"B","text":"Assume it is total external static pressure"},{"key":"C","text":"Treat every static-pressure reading as interchangeable"},{"key":"D","text":"Convert it directly to refrigerant pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Pressure readings require measurement-location and method context to be interpreted correctly.'
),
(
  13,
  'multiple_choice',
  'application',
  'A proposal depends on confirming whether an existing duct system can support increased airflow. Which field information is MOST useful?',
  '[{"key":"A","text":"Appropriate airflow and static-pressure measurements combined with duct and equipment information"},{"key":"B","text":"Refrigerant cylinder weight"},{"key":"C","text":"Compressor winding resistance only"},{"key":"D","text":"Thermostat model number only"}]'::jsonb,
  '["A"]'::jsonb,
  'Air-distribution capability should be evaluated using relevant airflow, pressure, equipment, and duct information.'
),
(
  14,
  'multiple_choice',
  'application',
  'A field technician reports that two temperature probes placed together differ significantly. What is the BEST response before using the readings in a design decision?',
  '[{"key":"A","text":"Resolve the measurement discrepancy through instrument verification or comparison with a trusted reference"},{"key":"B","text":"Always use the higher reading"},{"key":"C","text":"Always use the newer probe"},{"key":"D","text":"Add the readings together"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting instruments should be checked before their values are used for technical conclusions.'
),
(
  15,
  'multiple_choice',
  'application',
  'A project team needs to determine whether a system is reaching an adequate evacuation level before startup. Which instrument provides the most relevant direct measurement?',
  '[{"key":"A","text":"A suitable micron gauge"},{"key":"B","text":"A tape measure"},{"key":"C","text":"A clamp meter"},{"key":"D","text":"A sound-level meter"}]'::jsonb,
  '["A"]'::jsonb,
  'A micron gauge directly measures deep vacuum and is used to evaluate evacuation.'
),
(
  16,
  'multiple_choice',
  'application',
  'A design engineer receives field data but the technician cannot identify which instruments were used or whether they were functioning correctly. What is the BEST response?',
  '[{"key":"A","text":"Treat critical measurements as unverified until the method and instrument reliability can be established"},{"key":"B","text":"Accept every value because it came from the field"},{"key":"C","text":"Round all measurements to whole numbers"},{"key":"D","text":"Replace measurements with manufacturer catalog values"}]'::jsonb,
  '["A"]'::jsonb,
  'Critical field data should be traceable to a suitable measurement method and reliable instrument.'
),
(
  17,
  'scenario',
  'scenario',
  'A replacement project depends on an existing unit''s airflow. One technician estimates airflow by feel while another records measured static pressure and airflow data. What is the BEST basis for design?',
  '[{"key":"A","text":"Use properly obtained and validated measurements rather than the subjective estimate"},{"key":"B","text":"Use the estimate because it is faster"},{"key":"C","text":"Average the estimate and measurement"},{"key":"D","text":"Ignore both and use the existing equipment age"}]'::jsonb,
  '["A"]'::jsonb,
  'Design decisions should rely on relevant validated measurements rather than subjective impressions.'
),
(
  18,
  'scenario',
  'scenario',
  'A field report shows a surprising electrical reading that would force a major equipment-selection change. The meter had recently been dropped and has not been checked since. What is the BEST response?',
  '[{"key":"A","text":"Verify the reading with a known-suitable instrument and proper procedure before changing the design"},{"key":"B","text":"Immediately redesign the system around the reported value"},{"key":"C","text":"Use the damaged meter again several times and average the result"},{"key":"D","text":"Ignore all electrical requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'A suspect instrument should not drive a major technical decision without verification.'
),
(
  19,
  'scenario',
  'scenario',
  'A project has recurring comfort complaints, and the only field information available is supply-air temperature. What is the BEST next step?',
  '[{"key":"A","text":"Gather the additional relevant measurements needed to evaluate airflow, temperatures, pressures, and system operation before drawing conclusions"},{"key":"B","text":"Replace the equipment based only on supply-air temperature"},{"key":"C","text":"Increase equipment capacity automatically"},{"key":"D","text":"Assume the thermostat is defective"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex HVAC performance problems usually require multiple relevant measurements rather than one isolated value.'
),
(
  20,
  'scenario',
  'scenario',
  'A contractor submits commissioning data with several values that appear physically inconsistent with one another. What is the BEST design-engineer response?',
  '[{"key":"A","text":"Request verification of the test setup, instrument use, measurement locations, and questionable readings before accepting the data"},{"key":"B","text":"Accept the report because it is signed"},{"key":"C","text":"Delete the inconsistent values"},{"key":"D","text":"Use only the readings that support the design"}]'::jsonb,
  '["A"]'::jsonb,
  'Internally inconsistent test data should be investigated and validated rather than selectively accepted.'
);

create temporary table _seed_hvac_tools_test_instruments_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_tools_test_instruments_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to inspect HVAC hand tools before use?',
  '[{"key":"A","text":"To identify damage or defects that could make the tool unsafe or unreliable"},{"key":"B","text":"To make the tool look newer"},{"key":"C","text":"To determine the customer''s warranty"},{"key":"D","text":"To avoid reading the manufacturer instructions"}]'::jsonb,
  '["A"]'::jsonb,
  'Tool inspection helps identify defects that could create safety hazards or poor-quality work.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a tubing cutter?',
  '[{"key":"A","text":"To make a controlled square cut in tubing when used correctly"},{"key":"B","text":"To flare tubing automatically"},{"key":"C","text":"To measure refrigerant pressure"},{"key":"D","text":"To test electrical continuity"}]'::jsonb,
  '["A"]'::jsonb,
  'A tubing cutter is designed to produce a controlled cut in tubing without using a saw-type cutting action.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is a torque wrench used for?',
  '[{"key":"A","text":"To tighten a fastener or fitting to a specified torque when required"},{"key":"B","text":"To measure airflow"},{"key":"C","text":"To evacuate a refrigerant system"},{"key":"D","text":"To identify refrigerant type"}]'::jsonb,
  '["A"]'::jsonb,
  'A torque wrench helps apply a specified tightening torque where the procedure requires it.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should test leads on an electrical meter be inspected before use?',
  '[{"key":"A","text":"Damaged insulation or probes can create an electrical hazard or unreliable measurement"},{"key":"B","text":"Test leads affect refrigerant pressure"},{"key":"C","text":"Only the meter display matters"},{"key":"D","text":"Inspection is needed only once per year"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged leads can expose the user to electrical hazards and compromise measurement reliability.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What should an installer do if a tool is not designed for the task being performed?',
  '[{"key":"A","text":"Use the correct tool rather than improvising with an unsuitable one"},{"key":"B","text":"Use more force"},{"key":"C","text":"Modify the tool until it works"},{"key":"D","text":"Ask a helper to hold it differently"}]'::jsonb,
  '["A"]'::jsonb,
  'Using the correct tool reduces the chance of injury, equipment damage, and poor workmanship.'
),
(
  6,
  'multiple_choice',
  'application',
  'An installer needs to cut copper tubing. The tubing cutter wheel is chipped and binds during rotation. What is the BEST action?',
  '[{"key":"A","text":"Replace or repair the cutter before making the cut"},{"key":"B","text":"Force the cutter through the tubing"},{"key":"C","text":"Use the cutter only on smaller tubing"},{"key":"D","text":"Strike the cutter with a hammer"}]'::jsonb,
  '["A"]'::jsonb,
  'A damaged cutting tool can produce poor cuts and create additional hazards.'
),
(
  7,
  'multiple_choice',
  'application',
  'A manufacturer requires a flare fitting to be tightened to a specified torque. What is the BEST approach?',
  '[{"key":"A","text":"Use a suitable torque wrench and follow the specified procedure"},{"key":"B","text":"Tighten until the fitting feels very tight"},{"key":"C","text":"Use locking pliers"},{"key":"D","text":"Apply sealant instead of torque"}]'::jsonb,
  '["A"]'::jsonb,
  'Specified torque should be applied with suitable calibrated or verified equipment according to the procedure.'
),
(
  8,
  'multiple_choice',
  'application',
  'An installer is preparing to measure voltage and notices a cut in one meter lead. What is the BEST response?',
  '[{"key":"A","text":"Do not use the damaged lead; replace it with suitable test equipment before measuring"},{"key":"B","text":"Wrap the cut with paper tape"},{"key":"C","text":"Hold the damaged section away from the panel"},{"key":"D","text":"Measure only low voltage with it"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged electrical test leads should not be used where their protective integrity is compromised.'
),
(
  9,
  'multiple_choice',
  'application',
  'A helper is using an adjustable wrench on a fastener, but the jaws are loose and slipping. What is the BEST action?',
  '[{"key":"A","text":"Stop and use a suitable wrench in good condition"},{"key":"B","text":"Pull harder"},{"key":"C","text":"Strike the wrench with another tool"},{"key":"D","text":"Continue if wearing gloves"}]'::jsonb,
  '["A"]'::jsonb,
  'A slipping or defective wrench can damage the fastener and create an injury hazard.'
),
(
  10,
  'multiple_choice',
  'application',
  'An installer is using a cordless drill and the bit repeatedly slips in the chuck. What is the BEST response?',
  '[{"key":"A","text":"Stop and correct the bit, chuck, or tool setup before continuing"},{"key":"B","text":"Increase speed"},{"key":"C","text":"Hold the bit by hand"},{"key":"D","text":"Use more side pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'A slipping bit indicates an unsafe or unreliable setup that should be corrected before drilling continues.'
),
(
  11,
  'multiple_choice',
  'application',
  'An installer needs to verify that a system has been evacuated to a deep vacuum. Which instrument is MOST appropriate?',
  '[{"key":"A","text":"A suitable micron gauge"},{"key":"B","text":"A tape measure"},{"key":"C","text":"A clamp meter"},{"key":"D","text":"A tubing bender"}]'::jsonb,
  '["A"]'::jsonb,
  'A micron gauge is used to measure deep vacuum during evacuation.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician asks a helper to use a clamp meter, but the helper does not understand which conductor to clamp around or how to set the meter. What is the BEST action?',
  '[{"key":"A","text":"Stop and obtain instruction or qualified assistance before taking the measurement"},{"key":"B","text":"Clamp around the entire cable and guess the reading"},{"key":"C","text":"Set the meter to any available range"},{"key":"D","text":"Use the meter only because it is digital"}]'::jsonb,
  '["A"]'::jsonb,
  'Test instruments should be used only when the worker understands the proper configuration and measurement method.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer must bend tubing without flattening or kinking it. What is the BEST approach?',
  '[{"key":"A","text":"Use a suitable tubing bender sized for the tubing and make the bend correctly"},{"key":"B","text":"Bend it sharply by hand"},{"key":"C","text":"Heat it with an open flame and pull"},{"key":"D","text":"Strike the bend with a hammer"}]'::jsonb,
  '["A"]'::jsonb,
  'Using the correct tubing-bending tool helps maintain tubing shape and system integrity.'
),
(
  14,
  'multiple_choice',
  'application',
  'A vacuum pump oil appears heavily contaminated before evacuation. What is the BEST response?',
  '[{"key":"A","text":"Service the pump according to the manufacturer or company procedure before relying on it for evacuation"},{"key":"B","text":"Continue because oil condition does not affect pump performance"},{"key":"C","text":"Add refrigerant to the oil"},{"key":"D","text":"Use the pump only for five minutes"}]'::jsonb,
  '["A"]'::jsonb,
  'Vacuum-pump condition, including oil condition where applicable, can affect evacuation performance.'
),
(
  15,
  'scenario',
  'scenario',
  'An installer is rushing and uses pliers instead of the specified wrench on a refrigerant fitting, damaging the flats. What is the BEST response?',
  '[{"key":"A","text":"Stop, assess the damaged fitting, and use the correct tool and procedure before continuing"},{"key":"B","text":"Tighten harder with the pliers"},{"key":"C","text":"Cover the damage with tape"},{"key":"D","text":"Continue if the fitting does not leak immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Improper tools can damage fittings and compromise reliability; the condition should be corrected before work proceeds.'
),
(
  16,
  'scenario',
  'scenario',
  'A helper is asked to drill through sheet metal but selects a damaged bit that wobbles badly at speed. What is the BEST action?',
  '[{"key":"A","text":"Stop and replace the damaged bit before drilling"},{"key":"B","text":"Hold the drill with one hand"},{"key":"C","text":"Increase speed to stabilize the bit"},{"key":"D","text":"Continue if eye protection is worn"}]'::jsonb,
  '["A"]'::jsonb,
  'A damaged or unstable drill bit should not be used because it can break, slip, or produce poor work.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer obtains an electrical reading that is very different from what the equipment documentation suggests. The meter was recently dropped. What is the BEST response?',
  '[{"key":"A","text":"Verify the reading with known-suitable test equipment and proper procedure before acting on it"},{"key":"B","text":"Assume the equipment documentation is wrong"},{"key":"C","text":"Replace the equipment immediately"},{"key":"D","text":"Average the meter reading with the nameplate value"}]'::jsonb,
  '["A"]'::jsonb,
  'A questionable instrument should not be trusted for a critical decision without verification.'
),
(
  18,
  'scenario',
  'scenario',
  'A crew is evacuating a newly installed system but is watching only the manifold gauges and has no deep-vacuum measurement instrument connected. What is the BEST response?',
  '[{"key":"A","text":"Use an appropriate micron gauge and follow the required evacuation procedure"},{"key":"B","text":"Assume the system is evacuated when the manifold needle looks low"},{"key":"C","text":"Run the vacuum pump for a fixed five minutes"},{"key":"D","text":"Charge the system immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Deep evacuation should be evaluated with a suitable instrument rather than inferred from a standard pressure gauge alone.'
),
(
  19,
  'scenario',
  'scenario',
  'An installer finds that the only available torque wrench has no known service history and produces inconsistent results. What is the BEST action?',
  '[{"key":"A","text":"Use a known-suitable tool before performing torque-critical work"},{"key":"B","text":"Use the wrench and tighten twice"},{"key":"C","text":"Estimate torque by hand"},{"key":"D","text":"Use locking pliers instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Torque-critical work requires a tool that can be relied upon to produce the specified result.'
),
(
  20,
  'scenario',
  'scenario',
  'A helper repeatedly uses tools as makeshift hammers and pry bars because the correct tools are stored on another truck. What is the BEST response?',
  '[{"key":"A","text":"Stop the improper practice and obtain the correct tools before the work continues"},{"key":"B","text":"Allow it for experienced helpers"},{"key":"C","text":"Use more force"},{"key":"D","text":"Continue if no damage has occurred yet"}]'::jsonb,
  '["A"]'::jsonb,
  'Using tools for unintended purposes can damage the tool, equipment, and worker; the correct tool should be used.'
);

create temporary table _seed_hvac_tools_test_instruments_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_tools_test_instruments_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in HVAC Tools & Test Instruments?',
  '[{"key":"A","text":"Using tools only when a supervisor selects them"},{"key":"B","text":"Independently selecting suitable tools and instruments, validating measurements, and recognizing when equipment or test methods are unreliable"},{"key":"C","text":"Using the same test instrument for every diagnostic task"},{"key":"D","text":"Replacing measurement with experience whenever possible"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent tool selection, correct instrument use, reliable measurement, and sound diagnostic judgment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a service technician verify an unexpected measurement before making a major diagnostic decision?',
  '[{"key":"A","text":"The reading may be affected by instrument condition, setup, range, connection, or measurement location"},{"key":"B","text":"Unexpected readings are always wrong"},{"key":"C","text":"Manufacturer data should always replace field measurements"},{"key":"D","text":"Verification is required only for temperature readings"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected values should be validated because measurement errors can result from the instrument, setup, or test method.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to use more than one type of test instrument during HVAC troubleshooting?',
  '[{"key":"A","text":"Different system conditions require different measurements to isolate the actual fault"},{"key":"B","text":"Using more tools always makes the diagnosis correct"},{"key":"C","text":"Every instrument measures the same quantity differently"},{"key":"D","text":"Technicians should avoid comparing measurements"}]'::jsonb,
  '["A"]'::jsonb,
  'HVAC diagnosis often depends on correlating electrical, temperature, pressure, airflow, and other relevant measurements.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should a technician do when a test instrument gives unstable or physically impossible readings?',
  '[{"key":"A","text":"Question the instrument, setup, and test method before relying on the result"},{"key":"B","text":"Average the readings and continue"},{"key":"C","text":"Use the highest value"},{"key":"D","text":"Replace the system component immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Unstable or impossible readings should trigger verification of the instrument and measurement method.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician measures compressor current and gets a value far above the equipment data, but the clamp meter is around the entire multi-conductor cable. What is the BEST action?',
  '[{"key":"A","text":"Correct the clamp-meter setup and measure the appropriate individual conductor before diagnosing the compressor"},{"key":"B","text":"Replace the compressor immediately"},{"key":"C","text":"Average the reading with the nameplate value"},{"key":"D","text":"Increase the meter range and keep the same setup"}]'::jsonb,
  '["A"]'::jsonb,
  'Clamp-current measurements depend on correct conductor placement and should be taken with the proper setup.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician is checking a temperature split and one probe is attached loosely to a pipe while the other is properly secured and insulated from ambient air. What is the BEST response?',
  '[{"key":"A","text":"Correct the probe installation before comparing the temperatures"},{"key":"B","text":"Use the loose probe reading because both probes are digital"},{"key":"C","text":"Add five degrees to the loose reading"},{"key":"D","text":"Ignore both readings"}]'::jsonb,
  '["A"]'::jsonb,
  'Temperature measurements should be taken with appropriate sensor contact and placement so the readings are comparable and reliable.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician suspects poor airflow through an air handler. Which approach is BEST?',
  '[{"key":"A","text":"Use appropriate static-pressure or airflow measurements together with equipment and duct information"},{"key":"B","text":"Judge airflow only by placing a hand over a grille"},{"key":"C","text":"Measure compressor resistance only"},{"key":"D","text":"Increase blower speed before measuring anything"}]'::jsonb,
  '["A"]'::jsonb,
  'Airflow problems should be evaluated with relevant pressure or airflow measurements rather than subjective impressions alone.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician connects a micron gauge close to the vacuum pump and obtains a very low reading even though the system has a long hose run. What should the technician consider?',
  '[{"key":"A","text":"Gauge location may not represent the vacuum condition at the system, so the measurement setup should be evaluated"},{"key":"B","text":"The system is automatically fully evacuated"},{"key":"C","text":"Micron gauges should always be mounted on the pump"},{"key":"D","text":"Vacuum hose length never affects evacuation"}]'::jsonb,
  '["A"]'::jsonb,
  'Deep-vacuum measurements should be taken and interpreted with attention to gauge location and the evacuation setup.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician measures zero volts across a component that should be energized. What is the BEST next step?',
  '[{"key":"A","text":"Verify meter setup, reference points, circuit conditions, and the expected voltage before concluding the component has no power"},{"key":"B","text":"Replace the component"},{"key":"C","text":"Assume the disconnect is open"},{"key":"D","text":"Switch immediately to resistance mode on the energized circuit"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical diagnosis requires confirmation that the meter, test points, circuit state, and expected reading are appropriate.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician is comparing two pressure readings taken with different instruments that disagree significantly. What is the BEST response?',
  '[{"key":"A","text":"Verify instrument condition, zeroing, connection, and suitability before deciding which reading to trust"},{"key":"B","text":"Always trust the digital instrument"},{"key":"C","text":"Always trust the higher pressure"},{"key":"D","text":"Average the two readings"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting measurements should be resolved through instrument and test-method verification rather than arbitrary selection.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician suspects a temperature sensor is inaccurate. What is the BEST test approach?',
  '[{"key":"A","text":"Compare its reading under known or controlled conditions with a trusted reference or approved diagnostic method"},{"key":"B","text":"Replace it without testing"},{"key":"C","text":"Compare it only with outdoor temperature"},{"key":"D","text":"Measure its wire length"}]'::jsonb,
  '["A"]'::jsonb,
  'Suspected sensor error should be evaluated using a reliable reference or appropriate manufacturer diagnostic procedure.'
),
(
  12,
  'scenario',
  'scenario',
  'A rooftop unit intermittently trips on a high-pressure condition. The technician replaces the pressure switch based only on the fault code without measuring operating pressures. The fault returns. What is the BEST next approach?',
  '[{"key":"A","text":"Use appropriate pressure, temperature, airflow, and electrical measurements to determine the actual operating condition before replacing more parts"},{"key":"B","text":"Replace the pressure switch again"},{"key":"C","text":"Bypass the pressure control"},{"key":"D","text":"Increase the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring fault should be diagnosed using relevant measurements instead of repeated parts replacement based only on a code.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician records unusually high current on a blower motor, but the clamp meter reads differently each time and has recently been dropped. What is the BEST response?',
  '[{"key":"A","text":"Verify the current with known-suitable test equipment before condemning the motor"},{"key":"B","text":"Replace the motor immediately"},{"key":"C","text":"Use the highest reading"},{"key":"D","text":"Reduce blower speed until the reading looks normal"}]'::jsonb,
  '["A"]'::jsonb,
  'A suspect instrument should not be used as the sole basis for a major diagnostic conclusion.'
),
(
  14,
  'scenario',
  'scenario',
  'A system has poor cooling performance. Refrigerant pressures appear normal, but measured airflow is very low. What is the BEST diagnostic response?',
  '[{"key":"A","text":"Continue evaluating the air side rather than adding refrigerant based only on poor cooling symptoms"},{"key":"B","text":"Add refrigerant until suction pressure rises"},{"key":"C","text":"Replace the compressor"},{"key":"D","text":"Ignore the airflow reading"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable airflow measurements can redirect diagnosis away from unnecessary refrigerant adjustments.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician pulls a system into vacuum and the micron reading rises rapidly after isolation. What is the BEST interpretation?',
  '[{"key":"A","text":"The technician should evaluate the evacuation setup and system for moisture, leakage, or another cause rather than assuming evacuation is complete"},{"key":"B","text":"The system is automatically ready to charge"},{"key":"C","text":"The micron gauge should be ignored after isolation"},{"key":"D","text":"The vacuum pump should remain connected during charging"}]'::jsonb,
  '["A"]'::jsonb,
  'Vacuum rise after isolation can indicate remaining moisture, leakage, or test-setup issues and should be investigated.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician measures supply and return temperatures but places both probes directly in sunlight near rooftop duct openings. The readings suggest an abnormal temperature split. What is the BEST response?',
  '[{"key":"A","text":"Repeat the measurements using appropriate locations and probe placement before diagnosing the system"},{"key":"B","text":"Replace the compressor"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Average the readings with outdoor temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor measurement location can distort temperature data and lead to false diagnostic conclusions.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician sees zero resistance across a component while the circuit is still energized. What is the BEST response?',
  '[{"key":"A","text":"Stop and use the correct safe procedure and meter mode for the electrical test before relying on the reading"},{"key":"B","text":"Accept the reading because zero resistance means the component is good"},{"key":"C","text":"Change meter leads while energized"},{"key":"D","text":"Replace the component"}]'::jsonb,
  '["A"]'::jsonb,
  'Resistance measurements require an appropriate de-energized test condition and correct meter setup.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician diagnoses low refrigerant charge from pressure readings alone, but the outdoor coil is visibly blocked and airflow is poor. What is the BEST response?',
  '[{"key":"A","text":"Correct or account for the airflow problem and reassess system measurements before changing refrigerant charge"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Replace the metering device"},{"key":"D","text":"Ignore coil condition because gauges are connected"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant measurements must be interpreted in the context of system operating conditions such as airflow and heat transfer.'
),
(
  19,
  'scenario',
  'scenario',
  'A service technician gets conflicting static-pressure readings before and after changing the same test hose. What is the BEST response?',
  '[{"key":"A","text":"Inspect the hose, connections, instrument zero, and measurement ports before drawing conclusions about system pressure"},{"key":"B","text":"Use whichever reading is higher"},{"key":"C","text":"Replace the blower motor"},{"key":"D","text":"Ignore static pressure entirely"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes caused by test equipment or setup should be resolved before the readings are attributed to the HVAC system.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician has replaced multiple components on an intermittent system but has no recorded measurements from the failures. What is the BEST Level 3 response on the next occurrence?',
  '[{"key":"A","text":"Capture relevant electrical, temperature, pressure, airflow, and control measurements systematically before replacing another component"},{"key":"B","text":"Replace the most expensive remaining component"},{"key":"C","text":"Reset the system repeatedly"},{"key":"D","text":"Wait until the failure becomes permanent"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent faults are best approached with a disciplined measurement plan that preserves evidence before the condition changes.'
);

create temporary table _seed_hvac_tools_test_instruments_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_tools_test_instruments_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in HVAC Tools & Test Instruments?',
  '[{"key":"A","text":"Using personal experience instead of documenting measurements"},{"key":"B","text":"Leading proper instrument selection, validating test methods, coaching technicians, and correcting recurring measurement-quality problems"},{"key":"C","text":"Requiring every technician to use the same instrument for every task"},{"key":"D","text":"Replacing questionable measurements with manufacturer values"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership over measurement quality, tool selection, test methods, technician capability, and systemic corrective action.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a senior HVAC technician care about measurement traceability on complex diagnostic work?',
  '[{"key":"A","text":"It helps establish what was measured, where, how, and with which instrument so conclusions can be reviewed or reproduced"},{"key":"B","text":"Traceability matters only for billing"},{"key":"C","text":"Experienced technicians do not need measurement context"},{"key":"D","text":"Traceability replaces calibration"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurement traceability supports repeatable diagnosis, technical review, and confidence in the data used for decisions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST senior-level response to recurring disagreement between technicians using the same test procedure?',
  '[{"key":"A","text":"Accept whichever technician has more experience"},{"key":"B","text":"Review instrument condition, setup, measurement locations, procedure clarity, and technician technique to identify the source of variation"},{"key":"C","text":"Average all readings permanently"},{"key":"D","text":"Stop taking the measurement"}]'::jsonb,
  '["B"]'::jsonb,
  'Recurring disagreement in measurements should trigger evaluation of the instruments, methods, locations, and technician execution.'
),
(
  4,
  'multiple_choice',
  'application',
  'A service department is purchasing new electrical test meters. What should the senior technical lead evaluate besides price?',
  '[{"key":"A","text":"Measurement capability, safety suitability, ranges, accuracy, durability, accessories, and technician use requirements"},{"key":"B","text":"Display color only"},{"key":"C","text":"Battery size only"},{"key":"D","text":"Whether every meter has the same brand name"}]'::jsonb,
  '["A"]'::jsonb,
  'Test-equipment selection should account for the actual measurements, hazards, environments, and service tasks technicians will perform.'
),
(
  5,
  'multiple_choice',
  'application',
  'A branch has several torque wrenches but no process for confirming whether they remain reliable. What is the BEST response?',
  '[{"key":"A","text":"Create an appropriate inspection, verification, service, or calibration process for torque-critical tools"},{"key":"B","text":"Tell technicians to compare torque by feel"},{"key":"C","text":"Replace every torque wrench monthly"},{"key":"D","text":"Use adjustable wrenches instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Torque-critical work depends on tools whose reliability is appropriately controlled.'
),
(
  6,
  'multiple_choice',
  'application',
  'A lead technician sees different crews placing micron gauges in different locations and obtaining inconsistent evacuation results. What is the BEST response?',
  '[{"key":"A","text":"Standardize or clarify the approved evacuation test setup and gauge-location practice"},{"key":"B","text":"Allow every technician to choose any location"},{"key":"C","text":"Stop using micron gauges"},{"key":"D","text":"Use manifold pressure alone"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent measurement setup is important when readings depend strongly on instrument location and test configuration.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician repeatedly condemns motors using clamp-current readings without checking supply voltage or mechanical load. What should the senior technician do?',
  '[{"key":"A","text":"Coach the technician to use a complete diagnostic measurement plan instead of relying on one isolated reading"},{"key":"B","text":"Accept the diagnosis because current is enough"},{"key":"C","text":"Require a larger clamp meter"},{"key":"D","text":"Replace motors preemptively"}]'::jsonb,
  '["A"]'::jsonb,
  'Electrical diagnosis should interpret current in the context of voltage, load, equipment data, and other relevant conditions.'
),
(
  8,
  'multiple_choice',
  'application',
  'A service organization receives frequent reports of conflicting temperature measurements between technicians. What is the BEST first technical response?',
  '[{"key":"A","text":"Review probe condition, placement, attachment method, instrument verification, and the measurement procedure"},{"key":"B","text":"Tell technicians to use the warmest reading"},{"key":"C","text":"Replace every temperature probe immediately"},{"key":"D","text":"Stop recording temperatures"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurement variation should first be investigated through the instruments and the way measurements are being taken.'
),
(
  9,
  'multiple_choice',
  'application',
  'A new refrigerant platform requires service pressures outside the normal range of some existing gauges. What is the BEST senior response?',
  '[{"key":"A","text":"Verify that field instruments and hoses are suitable for the new application before assigning service work"},{"key":"B","text":"Use the old gauges carefully"},{"key":"C","text":"Estimate pressures from temperature only"},{"key":"D","text":"Increase gauge range markings manually"}]'::jsonb,
  '["A"]'::jsonb,
  'Tools and instruments should be suitable for the operating range and service requirements of the equipment being serviced.'
),
(
  10,
  'multiple_choice',
  'application',
  'A branch keeps losing diagnostic data because technicians write readings on scrap paper that is discarded after calls. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Create a practical measurement-recording process for critical diagnostic and commissioning data"},{"key":"B","text":"Rely on technician memory"},{"key":"C","text":"Stop taking measurements unless a failure occurs"},{"key":"D","text":"Photograph the equipment only"}]'::jsonb,
  '["A"]'::jsonb,
  'Important measurements should be retained in a form that supports diagnosis, review, trend analysis, and future service.'
),
(
  11,
  'scenario',
  'scenario',
  'A major customer reports repeated compressor replacements across several sites. Technicians say high current caused each failure, but service records show no consistent voltage, pressure, temperature, or load measurements. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Develop and enforce a structured diagnostic measurement process before authorizing additional compressor replacements"},{"key":"B","text":"Continue replacing compressors because current was high"},{"key":"C","text":"Replace every clamp meter"},{"key":"D","text":"Remove current measurement from the diagnostic process"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated high-cost failures without supporting diagnostic data indicate a need for a disciplined measurement and verification process.'
),
(
  12,
  'scenario',
  'scenario',
  'A commissioning team reports excellent evacuation readings, but the micron gauge is always mounted directly at the vacuum pump while field systems later show moisture-related problems. What is the BEST response?',
  '[{"key":"A","text":"Review and correct the evacuation measurement setup so the readings meaningfully represent system vacuum conditions"},{"key":"B","text":"Continue because the micron number was low"},{"key":"C","text":"Stop documenting evacuation"},{"key":"D","text":"Run the pump for a fixed time instead"}]'::jsonb,
  '["A"]'::jsonb,
  'A low reading at a poorly chosen measurement point may not accurately represent the condition of the entire refrigerant circuit.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician reports unsafe voltage on equipment and shuts the site down. A second technician later finds normal voltage with another meter. The first meter has damaged leads and an unknown service history. What is the BEST senior response?',
  '[{"key":"A","text":"Keep the site safe, verify the electrical condition with known-suitable equipment, remove questionable test equipment from service, and review the original test method"},{"key":"B","text":"Ignore the first technician because the second reading was normal"},{"key":"C","text":"Average the two readings"},{"key":"D","text":"Return the damaged meter to service after replacing the battery"}]'::jsonb,
  '["A"]'::jsonb,
  'Conflicting safety-critical electrical readings require confirmation with reliable equipment and control of defective test instruments.'
),
(
  14,
  'scenario',
  'scenario',
  'A service branch has three different methods for measuring total external static pressure, producing values that cannot be compared across technicians. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Establish a technically sound standard measurement method, define test locations, and train technicians to use it consistently"},{"key":"B","text":"Allow each method and average the results"},{"key":"C","text":"Use only airflow estimates"},{"key":"D","text":"Stop measuring static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Comparable diagnostic data requires consistent measurement definitions, locations, and procedures.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician repeatedly replaces sensors after comparing them with a single reference probe. An audit finds that the reference probe itself is inaccurate. What is the BEST response?',
  '[{"key":"A","text":"Address affected prior diagnoses as appropriate and correct the process for verifying reference instruments before they are used to judge other sensors"},{"key":"B","text":"Continue using the reference probe because it is familiar"},{"key":"C","text":"Replace all sensors regardless of test results"},{"key":"D","text":"Stop testing sensors"}]'::jsonb,
  '["A"]'::jsonb,
  'A faulty reference can propagate systematic diagnostic errors, so reference-instrument control is essential.'
),
(
  16,
  'scenario',
  'scenario',
  'A senior technician reviews an intermittent controls problem. Several technicians have replaced boards, relays, and sensors, but none captured voltage or control-state measurements during the failure. What is the BEST next step?',
  '[{"key":"A","text":"Create a targeted test plan to capture the relevant electrical and control measurements while the fault is present before replacing more components"},{"key":"B","text":"Replace the control board again"},{"key":"C","text":"Disable the affected safety circuit"},{"key":"D","text":"Wait for complete equipment failure"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent faults require a deliberate strategy for capturing evidence while the failure condition exists.'
),
(
  17,
  'scenario',
  'scenario',
  'A company deploys new wireless pressure and temperature probes. Technicians trust the displayed values automatically, but several devices later show large offsets. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement an appropriate verification and maintenance process and train technicians to question readings that conflict with system behavior"},{"key":"B","text":"Ban all wireless tools permanently"},{"key":"C","text":"Assume software will correct every offset"},{"key":"D","text":"Use only the highest reading from each device"}]'::jsonb,
  '["A"]'::jsonb,
  'Digital instruments still require verification, maintenance, proper setup, and technical judgment.'
),
(
  18,
  'scenario',
  'scenario',
  'A new technician records static pressure in psi while the company procedure and equipment tables use inches of water column. The value is entered into the service report without units and leads to a bad conclusion. What is the BEST response?',
  '[{"key":"A","text":"Correct the immediate report and reinforce measurement units, instrument setup, documentation, and review practices"},{"key":"B","text":"Tell technicians that units are optional"},{"key":"C","text":"Use whichever unit the instrument defaults to"},{"key":"D","text":"Stop recording static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurements without correct units or context can be misinterpreted and should be controlled through clear procedures and documentation.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician measures low airflow and recommends a larger blower. The senior technician finds that the airflow hood was used incorrectly and its setup was unsuitable for the grille. What is the BEST response?',
  '[{"key":"A","text":"Repeat the measurement with an appropriate method before approving equipment changes and coach the technician on correct instrument use"},{"key":"B","text":"Install the larger blower anyway"},{"key":"C","text":"Use the original airflow value because it was documented"},{"key":"D","text":"Estimate airflow from sound"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment changes should not be based on invalid measurements, and recurring technique gaps should be corrected through coaching and procedure.'
),
(
  20,
  'scenario',
  'scenario',
  'A quality review shows that technicians own good tools and instruments but frequently skip pre-use inspection, proper setup, measurement documentation, and verification of unusual readings. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Strengthen the complete measurement-quality process through expectations, training, field coaching, audits, and corrective action rather than simply buying more tools"},{"key":"B","text":"Purchase newer instruments only"},{"key":"C","text":"Stop requiring recorded measurements"},{"key":"D","text":"Allow experienced technicians to ignore the process"}]'::jsonb,
  '["A"]'::jsonb,
  'Measurement quality depends on technician practice, equipment condition, procedures, documentation, and leadership, not merely tool ownership.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '72f24c21-3165-4fd8-9d25-f01d8af7ac06';
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
      and c.name = 'HVAC Tools & Test Instruments'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Tools & Test Instruments Master Competency not found';
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
  v_assessment_name := 'HVAC Tools & Test Instruments — Level 1 Competency Assessment';

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
    select * from _seed_hvac_tools_test_instruments_l1_questions
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
        'HVAC Tools & Test Instruments',
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
      'IntegrateU HVAC Tools & Test Instruments L1 production assessment v1.0.',
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
        'HVAC Tools & Test Instruments',
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
        'IntegrateU HVAC Tools & Test Instruments L1 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Tools & Test Instruments — Level 2 Competency Assessment';

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
    select * from _seed_hvac_tools_test_instruments_l2_questions
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
        'HVAC Tools & Test Instruments',
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
      'IntegrateU HVAC Tools & Test Instruments L2 production assessment v1.0.',
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
        'HVAC Tools & Test Instruments',
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
        'IntegrateU HVAC Tools & Test Instruments L2 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Tools & Test Instruments — Level 3 Competency Assessment';

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
    select * from _seed_hvac_tools_test_instruments_l3_questions
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
        'HVAC Tools & Test Instruments',
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
      'IntegrateU HVAC Tools & Test Instruments L3 production assessment v1.0.',
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
        'HVAC Tools & Test Instruments',
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
        'IntegrateU HVAC Tools & Test Instruments L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Tools & Test Instruments — Level 4 Competency Assessment';

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
    select * from _seed_hvac_tools_test_instruments_l4_questions
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
        'HVAC Tools & Test Instruments',
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
      'IntegrateU HVAC Tools & Test Instruments L4 production assessment v1.0.',
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
        'HVAC Tools & Test Instruments',
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
        'IntegrateU HVAC Tools & Test Instruments L4 production assessment v1.0.',
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
   '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid
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
      '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid
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
  '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid;

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
    '72f24c21-3165-4fd8-9d25-f01d8af7ac06'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
