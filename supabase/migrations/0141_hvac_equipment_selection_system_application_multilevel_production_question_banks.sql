-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0141_hvac_equipment_selection_system_application_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Equipment Selection & System Application
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Service & Repair Technician -> Level 2
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

create temporary table _seed_hvac_equipment_selection_system_application_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_equipment_selection_system_application_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of matching HVAC equipment capacity to the actual building load?',
  '[{"key":"A","text":"To help the system satisfy heating and cooling demand without unnecessary oversizing or undersizing"},{"key":"B","text":"To maximize equipment size regardless of load"},{"key":"C","text":"To eliminate the need for airflow verification"},{"key":"D","text":"To avoid checking electrical requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment capacity should be appropriate for the application so the system can meet demand and operate as intended.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is equipment compatibility important when replacing an HVAC component or unit?',
  '[{"key":"A","text":"The replacement must work with the existing system, controls, electrical supply, airflow requirements, and application"},{"key":"B","text":"Any equipment with similar dimensions is automatically compatible"},{"key":"C","text":"Only cabinet color matters"},{"key":"D","text":"Compatibility is needed only for new construction"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement equipment must be compatible with the broader system and installation conditions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is one important reason to review manufacturer application data before selecting replacement HVAC equipment?',
  '[{"key":"A","text":"It provides operating limits, required conditions, capacities, and installation constraints for the equipment"},{"key":"B","text":"It replaces all field measurements"},{"key":"C","text":"It determines the customer budget automatically"},{"key":"D","text":"It eliminates the need for system commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Manufacturer data helps confirm whether equipment is suitable for the intended application.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should airflow requirements be considered when selecting HVAC equipment?',
  '[{"key":"A","text":"Equipment performance depends on receiving appropriate airflow through the system"},{"key":"B","text":"Airflow affects only filter appearance"},{"key":"C","text":"Airflow is unrelated to equipment capacity"},{"key":"D","text":"Airflow matters only after the warranty expires"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper airflow is necessary for expected capacity, temperature control, equipment protection, and efficient operation.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the BEST definition of a system application constraint?',
  '[{"key":"A","text":"A site or system condition that limits which equipment or configuration is appropriate"},{"key":"B","text":"A cosmetic preference only"},{"key":"C","text":"A thermostat setting"},{"key":"D","text":"A refrigerant gauge reading taken after startup"}]'::jsonb,
  '["A"]'::jsonb,
  'Application constraints can include space, electrical service, airflow, venting, refrigerant piping, climate, controls, and other site conditions.'
),
(
  6,
  'multiple_choice',
  'application',
  'A failed condensing unit is being replaced. The proposed replacement has the same nominal capacity but different electrical requirements. What should be done?',
  '[{"key":"A","text":"Verify the electrical supply and circuit compatibility before approving the replacement"},{"key":"B","text":"Install it because capacity matches"},{"key":"C","text":"Change the thermostat only"},{"key":"D","text":"Increase breaker size automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Nominal capacity alone does not establish full compatibility.'
),
(
  7,
  'multiple_choice',
  'application',
  'An existing furnace has a blower that cannot deliver the airflow required by a proposed larger cooling coil. What is the BEST equipment-selection response?',
  '[{"key":"A","text":"Reevaluate the proposed equipment combination rather than assuming the larger coil will perform correctly"},{"key":"B","text":"Install the coil and ignore airflow"},{"key":"C","text":"Reduce filter size"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment components must be matched so the system can provide the airflow required for intended performance.'
),
(
  8,
  'multiple_choice',
  'application',
  'A service technician is considering replacing a failed compressor with a model that has different refrigerant and electrical requirements. What is the BEST approach?',
  '[{"key":"A","text":"Confirm approved compatibility with the equipment, refrigerant circuit, electrical requirements, and manufacturer guidance before selection"},{"key":"B","text":"Use it if the physical dimensions fit"},{"key":"C","text":"Install it and adjust charge until it runs"},{"key":"D","text":"Use a larger breaker"}]'::jsonb,
  '["A"]'::jsonb,
  'Major replacement components should be approved and compatible with the equipment and system design.'
),
(
  9,
  'multiple_choice',
  'application',
  'A replacement heat pump is rated for conditions different from the local winter design conditions. What should be considered?',
  '[{"key":"A","text":"Whether the selected equipment can provide the required heating performance under expected outdoor conditions"},{"key":"B","text":"Only the cabinet dimensions"},{"key":"C","text":"Only the thermostat brand"},{"key":"D","text":"Only the refrigerant line color"}]'::jsonb,
  '["A"]'::jsonb,
  'Climate and design conditions affect equipment capacity and application suitability.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer wants to replace a standard-efficiency furnace with a condensing furnace. What application issue must be reviewed?',
  '[{"key":"A","text":"Venting, combustion air, condensate disposal, space, and other installation requirements for the new equipment"},{"key":"B","text":"Only filter color"},{"key":"C","text":"Only thermostat batteries"},{"key":"D","text":"Only refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Different equipment types can introduce new venting, drainage, combustion-air, and installation requirements.'
),
(
  11,
  'multiple_choice',
  'application',
  'A replacement air conditioner is larger than the existing duct system was designed to support. What is the BEST response?',
  '[{"key":"A","text":"Evaluate whether the duct system can support the required airflow before selecting the larger unit"},{"key":"B","text":"Install it because larger equipment always performs better"},{"key":"C","text":"Reduce return-air openings"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment and air-distribution capacity must be compatible.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer asks to install a heat pump using an existing thermostat and control wiring. What should be verified?',
  '[{"key":"A","text":"That the thermostat and control wiring support the functions and staging required by the proposed system"},{"key":"B","text":"Only that the thermostat display works"},{"key":"C","text":"That the thermostat is the same color"},{"key":"D","text":"Nothing; all thermostats are interchangeable"}]'::jsonb,
  '["A"]'::jsonb,
  'Control compatibility is part of proper system application.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician finds that a proposed indoor coil is not listed as an approved match with the outdoor unit. What is the BEST response?',
  '[{"key":"A","text":"Select an approved matched combination or verify an authorized application before proceeding"},{"key":"B","text":"Use it because the refrigerant connections fit"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Change the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Matched equipment combinations help ensure intended performance, ratings, and operating compatibility.'
),
(
  14,
  'multiple_choice',
  'application',
  'A replacement rooftop unit has the correct capacity but a much higher external static pressure requirement than the existing duct system can support. What is the BEST conclusion?',
  '[{"key":"A","text":"The application needs to be reevaluated because correct capacity does not guarantee airflow-system compatibility"},{"key":"B","text":"Capacity alone makes the unit suitable"},{"key":"C","text":"The thermostat will compensate"},{"key":"D","text":"Refrigerant charge will correct the mismatch"}]'::jsonb,
  '["A"]'::jsonb,
  'System application includes both equipment capacity and the ability of connected systems to support required operation.'
),
(
  15,
  'scenario',
  'scenario',
  'A service technician is asked to replace an aging package unit. The replacement has the same nominal tonnage, but the existing curb, electrical service, duct connection, and control system differ from the new model. What is the BEST response?',
  '[{"key":"A","text":"Evaluate all mechanical, electrical, airflow, control, and installation compatibility issues before finalizing the replacement"},{"key":"B","text":"Order it because tonnage matches"},{"key":"C","text":"Change the thermostat only"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'A sound replacement decision considers the full system and installation, not just nominal capacity.'
),
(
  16,
  'scenario',
  'scenario',
  'A home has persistent humidity complaints. A proposed replacement system is significantly larger than the calculated cooling load because the customer wants faster cooling. What is the BEST application response?',
  '[{"key":"A","text":"Avoid intentional oversizing and select equipment appropriate to the load and humidity-control needs"},{"key":"B","text":"Install the largest available unit"},{"key":"C","text":"Reduce return airflow"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Oversizing can create short cycling and poor latent performance, so equipment should be matched to the application.'
),
(
  17,
  'scenario',
  'scenario',
  'A replacement heat pump is selected for a cold-climate application, but available capacity at low outdoor temperature was not reviewed. What is the BEST next step?',
  '[{"key":"A","text":"Check low-temperature performance and determine whether supplemental heat or a different equipment selection is required"},{"key":"B","text":"Install it because nominal capacity is enough"},{"key":"C","text":"Increase thermostat voltage"},{"key":"D","text":"Reduce duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'Heat-pump capacity changes with outdoor conditions and should be evaluated for the actual application.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer wants a high-efficiency condensing furnace in a location where an approved condensate route and vent termination cannot be provided as currently configured. What is the BEST response?',
  '[{"key":"A","text":"Resolve the installation constraints or select a system appropriate for the available site conditions"},{"key":"B","text":"Install it and leave condensate unresolved"},{"key":"C","text":"Use the existing vent regardless of requirements"},{"key":"D","text":"Increase blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should not be selected without considering whether its required installation conditions can actually be met.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician discovers that a failed outdoor unit was previously replaced with equipment not properly matched to the indoor coil. The system has had repeated performance problems. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the entire matched-system configuration and correct the equipment application rather than treating only the current failed component"},{"key":"B","text":"Replace the outdoor unit with any unit of the same tonnage"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Change the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated issues can result from a poor equipment match and should be corrected at the system-application level.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer requests a larger HVAC unit because one room is uncomfortable, but the rest of the building reaches setpoint and airflow to that room is poor. What is the BEST equipment-selection response?',
  '[{"key":"A","text":"Investigate the distribution or room-specific issue before recommending larger central equipment"},{"key":"B","text":"Replace the entire system with a larger unit"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Install a larger breaker"}]'::jsonb,
  '["A"]'::jsonb,
  'A localized comfort problem does not by itself prove that the central equipment is undersized.'
);

create temporary table _seed_hvac_equipment_selection_system_application_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_equipment_selection_system_application_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Equipment Selection & System Application?',
  '[{"key":"A","text":"Selecting equipment by nominal tonnage only"},{"key":"B","text":"Integrating load, climate, airflow, electrical, controls, piping, installation constraints, operating range, and lifecycle considerations into equipment decisions"},{"key":"C","text":"Choosing the largest available equipment"},{"key":"D","text":"Relying on prior equipment size without review"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 application requires system-level selection using multiple technical constraints rather than a single sizing factor.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should part-load performance be considered during advanced HVAC equipment selection?',
  '[{"key":"A","text":"Many systems operate below peak load for significant portions of the year, so part-load behavior affects comfort, efficiency, and control"},{"key":"B","text":"Only full-load operation matters"},{"key":"C","text":"Part-load performance affects cabinet dimensions only"},{"key":"D","text":"It is relevant only after equipment failure"}]'::jsonb,
  '["A"]'::jsonb,
  'HVAC systems commonly operate at partial load, making modulation and part-load performance important application considerations.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to review equipment operating envelopes during system application?',
  '[{"key":"A","text":"To confirm the equipment can operate within expected temperature, pressure, airflow, and other application limits"},{"key":"B","text":"To determine paint color"},{"key":"C","text":"To eliminate commissioning"},{"key":"D","text":"To avoid reviewing manufacturer data"}]'::jsonb,
  '["A"]'::jsonb,
  'Operating-envelope limits help determine whether equipment is suitable for actual site and system conditions.'
),
(
  4,
  'multiple_choice',
  'application',
  'A proposed heat pump meets the design heating load at moderate outdoor temperature but loses significant capacity at the winter design condition. What should be evaluated?',
  '[{"key":"A","text":"Low-temperature capacity, supplemental heat strategy, balance point, controls, and whether a different equipment selection is more appropriate"},{"key":"B","text":"Only nominal tonnage"},{"key":"C","text":"Thermostat color"},{"key":"D","text":"Filter brand"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced heat-pump application requires evaluating performance at actual design conditions rather than nominal ratings alone.'
),
(
  5,
  'multiple_choice',
  'application',
  'A variable-capacity system is being proposed for a building with long periods of low load and strict humidity requirements. What is the BEST application consideration?',
  '[{"key":"A","text":"Evaluate minimum capacity, turndown, airflow modulation, latent performance, and control strategy at part load"},{"key":"B","text":"Select only by maximum capacity"},{"key":"C","text":"Disable modulation"},{"key":"D","text":"Increase equipment size"}]'::jsonb,
  '["A"]'::jsonb,
  'Minimum capacity and control behavior can be as important as peak capacity in low-load and humidity-sensitive applications.'
),
(
  6,
  'multiple_choice',
  'application',
  'A replacement rooftop unit has adequate nominal capacity but substantially different fan performance from the existing unit. What should be verified?',
  '[{"key":"A","text":"That the selected unit can deliver required airflow against the actual external static pressure of the connected system"},{"key":"B","text":"Only cabinet dimensions"},{"key":"C","text":"Only refrigerant type"},{"key":"D","text":"Only thermostat compatibility"}]'::jsonb,
  '["A"]'::jsonb,
  'Fan capability must be matched to the actual air-distribution resistance.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project includes a high-efficiency furnace in a tight mechanical room with difficult vent routing. What should drive final selection?',
  '[{"key":"A","text":"A coordinated review of venting, combustion air, condensate, clearances, service access, code requirements, and manufacturer limits"},{"key":"B","text":"Efficiency rating alone"},{"key":"C","text":"Cabinet color"},{"key":"D","text":"Largest available input"}]'::jsonb,
  '["A"]'::jsonb,
  'High-efficiency equipment must be selected with all required installation and service conditions in mind.'
),
(
  8,
  'multiple_choice',
  'application',
  'A large building has highly variable occupancy and diverse zone loads. What equipment feature may be especially valuable?',
  '[{"key":"A","text":"Capacity modulation or staging that can respond to changing loads while maintaining control"},{"key":"B","text":"Fixed maximum output at all times"},{"key":"C","text":"Eliminating zoning"},{"key":"D","text":"Reducing sensor count regardless of design"}]'::jsonb,
  '["A"]'::jsonb,
  'Variable-load buildings often benefit from equipment and controls that can modulate output.'
),
(
  9,
  'multiple_choice',
  'application',
  'A proposed replacement chiller has better full-load efficiency but worse performance at the building''s typical operating load. What is the BEST selection approach?',
  '[{"key":"A","text":"Compare annualized operating performance across the expected load profile rather than relying only on full-load efficiency"},{"key":"B","text":"Choose the unit with the best full-load value automatically"},{"key":"C","text":"Ignore load profile"},{"key":"D","text":"Select by footprint only"}]'::jsonb,
  '["A"]'::jsonb,
  'Lifecycle operating performance depends on how equipment performs across the actual load distribution.'
),
(
  10,
  'multiple_choice',
  'application',
  'A project has limited electrical capacity and several technically feasible HVAC options. What is the BEST application response?',
  '[{"key":"A","text":"Compare electrical demand and infrastructure impacts along with thermal performance, cost, and operational requirements"},{"key":"B","text":"Ignore electrical capacity"},{"key":"C","text":"Select the highest current equipment"},{"key":"D","text":"Increase breaker size without analysis"}]'::jsonb,
  '["A"]'::jsonb,
  'Available electrical infrastructure can materially affect which HVAC solution is practical and economical.'
),
(
  11,
  'scenario',
  'scenario',
  'A senior technician is reviewing repeated compressor failures on a replacement system. The installed outdoor unit and indoor coil are technically operable together but are not an approved matched combination. What is the BEST response?',
  '[{"key":"A","text":"Evaluate whether the equipment mismatch is contributing to abnormal operation and correct the system application rather than continuing component replacement"},{"key":"B","text":"Replace the compressor again"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Install a larger breaker"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures can stem from an improper system match and should trigger application-level review.'
),
(
  12,
  'scenario',
  'scenario',
  'A design engineer is comparing two heat pumps. One has higher rated efficiency, while the other maintains substantially more capacity at the project''s cold design temperature. What is the BEST approach?',
  '[{"key":"A","text":"Evaluate both seasonal efficiency and low-temperature capacity against the actual load and supplemental-heat strategy"},{"key":"B","text":"Choose the highest published efficiency rating automatically"},{"key":"C","text":"Choose the physically larger unit"},{"key":"D","text":"Ignore winter design conditions"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection should balance efficiency and capacity under the conditions the system will actually experience.'
),
(
  13,
  'scenario',
  'scenario',
  'A replacement air handler fits the mechanical room, but its fan cannot deliver required airflow at the measured external static pressure. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Reevaluate the equipment or distribution system so required airflow can be delivered within acceptable fan operating limits"},{"key":"B","text":"Install it because it physically fits"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Reduce thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical fit does not establish system compatibility if the fan cannot operate at the required airflow and pressure.'
),
(
  14,
  'scenario',
  'scenario',
  'A commercial client wants the lowest first-cost HVAC replacement. The cheapest option would require frequent electric resistance backup during normal winter conditions. What is the BEST response?',
  '[{"key":"A","text":"Present lifecycle energy, demand, comfort, infrastructure, and operating-cost impacts along with first cost before final selection"},{"key":"B","text":"Select the cheapest equipment without further analysis"},{"key":"C","text":"Ignore backup heat use"},{"key":"D","text":"Disable auxiliary heat"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 system application considers lifecycle performance and operating consequences, not merely purchase price.'
),
(
  15,
  'scenario',
  'scenario',
  'A building expansion increases cooling load, but the existing electrical service, roof structure, and duct shafts have limited spare capacity. What is the BEST design approach?',
  '[{"key":"A","text":"Compare feasible HVAC strategies against the thermal load and all infrastructure constraints before selecting equipment"},{"key":"B","text":"Select the largest rooftop unit"},{"key":"C","text":"Ignore structural and electrical limitations"},{"key":"D","text":"Use the existing unit size"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection must account for interacting building constraints as well as heating and cooling demand.'
),
(
  16,
  'scenario',
  'scenario',
  'A high-humidity facility has a low sensible load for much of the year. A conventional unit meets peak sensible capacity but cycles frequently at normal conditions. What is the BEST response?',
  '[{"key":"A","text":"Evaluate equipment with suitable minimum capacity, latent control, reheat or dehumidification capability, and an appropriate control sequence"},{"key":"B","text":"Increase nominal tonnage"},{"key":"C","text":"Reduce airflow without analysis"},{"key":"D","text":"Ignore humidity"}]'::jsonb,
  '["A"]'::jsonb,
  'Humidity-sensitive applications require equipment and control strategies that perform effectively at low sensible loads.'
),
(
  17,
  'scenario',
  'scenario',
  'A project specifies a variable-refrigerant system, but the piping geometry and elevation differences approach the manufacturer''s limits. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Verify all piping, elevation, capacity-correction, refrigerant-charge, and application limits before finalizing the system"},{"key":"B","text":"Ignore the limits if nominal capacity is sufficient"},{"key":"C","text":"Increase pipe size without design review"},{"key":"D","text":"Add extra refrigerant by rule of thumb"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex refrigerant systems must be applied within manufacturer piping and operating limits.'
),
(
  18,
  'scenario',
  'scenario',
  'A hospital replacement project requires tight temperature control, redundancy, and minimal downtime. A single large unit is the lowest-cost option. What is the BEST application response?',
  '[{"key":"A","text":"Evaluate redundancy, turndown, serviceability, failure impact, controls, and operational continuity before choosing the equipment configuration"},{"key":"B","text":"Choose the single unit because first cost is lowest"},{"key":"C","text":"Ignore failure consequences"},{"key":"D","text":"Eliminate backup capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Critical facilities require equipment selection that accounts for reliability and operational continuity.'
),
(
  19,
  'scenario',
  'scenario',
  'A senior technician finds that a newly installed high-efficiency system performs poorly because the existing ductwork produces excessive static pressure. The equipment itself tests normally. What is the BEST response?',
  '[{"key":"A","text":"Treat the issue as a system-application problem and correct the air-distribution mismatch rather than replacing functioning equipment"},{"key":"B","text":"Replace the equipment with the same model"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Increase breaker size"}]'::jsonb,
  '["A"]'::jsonb,
  'System performance depends on how equipment interacts with the connected distribution system.'
),
(
  20,
  'scenario',
  'scenario',
  'A company has repeated callbacks because replacement equipment is being selected by matching the old nameplate size without checking load, airflow, electrical capacity, controls, or application limits. What is the BEST Level 4 corrective action?',
  '[{"key":"A","text":"Implement a standardized equipment-selection process requiring load and application review, compatibility checks, documented assumptions, manufacturer data, and technical approval for exceptions"},{"key":"B","text":"Continue matching old nameplates"},{"key":"C","text":"Increase replacement equipment size"},{"key":"D","text":"Let each technician use personal preference"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring selection-quality problem requires a controlled system-level process rather than isolated field corrections.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '539da880-9379-468e-857e-16483421f7ec';
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
      and c.name = 'Equipment Selection & System Application'
      and c.is_current = true
  ) then
    raise exception 'Current Equipment Selection & System Application Master Competency not found';
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
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Service & Repair Technician L2 Equipment Selection & System Application requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L4 Equipment Selection & System Application requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Equipment Selection & System Application requirement not found';
  end if;

v_level := 2;
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'Equipment Selection & System Application — Level 2 Competency Assessment';

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
    select * from _seed_hvac_equipment_selection_system_application_l2_questions
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
        'Equipment Selection & System Application',
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
      'IntegrateU Equipment Selection & System Application L2 production assessment v1.0.',
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
        'Equipment Selection & System Application',
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
        'IntegrateU Equipment Selection & System Application L2 production assessment v1.0.',
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

  v_level := 4;
  v_role_template_id := v_senior_role_id;
  v_assessment_name := 'Equipment Selection & System Application — Level 4 Competency Assessment';

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
    select * from _seed_hvac_equipment_selection_system_application_l4_questions
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
        'Equipment Selection & System Application',
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
      'IntegrateU Equipment Selection & System Application L4 production assessment v1.0.',
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
        'Equipment Selection & System Application',
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
        'IntegrateU Equipment Selection & System Application L4 production assessment v1.0.',
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



end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
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
   '539da880-9379-468e-857e-16483421f7ec'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '539da880-9379-468e-857e-16483421f7ec'::uuid
  and a.target_level in (2,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L2 HVAC Service & Repair Technician = 20
--   L4 HVAC Design & Sales Engineer = 20
--   L4 Senior / Lead HVAC Technician = 20
-- ============================================================================

select
  mrcr.required_level as target_level,
  r.name as role_name,
  count(distinct mqra.master_question_id)::integer
    as role_applicability_count
from public.master_role_templates r
join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = r.id
join public.master_question_role_applicability mqra
  on mqra.master_role_template_id = r.id
join public.master_question_bank mqb
  on mqb.id = mqra.master_question_id
where r.is_current = true
  and mrcr.master_competency_template_id =
    '539da880-9379-468e-857e-16483421f7ec'::uuid
  and mqb.master_competency_template_id =
    '539da880-9379-468e-857e-16483421f7ec'::uuid
  and mqb.is_current = true
  and mqb.status = 'approved'
  and (
    (
      mrcr.required_level = 2
      and r.id =
        '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
    )
    or
    (
      mrcr.required_level = 4
      and r.id in (
        '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid,
        'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
      )
    )
  )
group by
  mrcr.required_level,
  r.id,
  r.name
order by
  mrcr.required_level,
  r.name;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '539da880-9379-468e-857e-16483421f7ec'::uuid;

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
    '539da880-9379-468e-857e-16483421f7ec'::uuid
  and a.target_level in (2,4)
group by a.target_level
having count(*) > 1;
