-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0131_hvac_ductwork_air_distribution_installation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Ductwork & Air Distribution Installation
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 2
--   HVAC Service & Repair Technician -> Level 2
--   HVAC Design & Sales Engineer     -> Level 3
--   Senior / Lead HVAC Technician    -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_ductwork_air_distribution_installation_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ductwork_air_distribution_installation_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an HVAC duct system?',
  '[{"key":"A","text":"To distribute supply and return air between HVAC equipment and occupied spaces"},{"key":"B","text":"To carry refrigerant between indoor and outdoor units"},{"key":"C","text":"To provide electrical grounding for HVAC equipment"},{"key":"D","text":"To drain condensate from cooling coils"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct systems move conditioned and return air through the building so HVAC equipment can serve the intended spaces.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should duct joints and seams be sealed using the approved method?',
  '[{"key":"A","text":"To reduce unintended air leakage and help maintain designed airflow"},{"key":"B","text":"To increase refrigerant pressure"},{"key":"C","text":"To eliminate the need for duct supports"},{"key":"D","text":"To make the duct electrically conductive"}]'::jsonb,
  '["A"]'::jsonb,
  'Properly sealed joints and seams help prevent air loss and support expected system performance.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the main purpose of supporting ductwork correctly?',
  '[{"key":"A","text":"To maintain alignment and prevent excessive sagging, movement, or stress"},{"key":"B","text":"To increase blower speed"},{"key":"C","text":"To replace duct sealing"},{"key":"D","text":"To eliminate static pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper supports help ductwork remain aligned and prevent deformation or joint stress that can contribute to leakage and poor airflow.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is the inside of ductwork kept free of construction debris during installation?',
  '[{"key":"A","text":"Debris can restrict airflow, contaminate the system, and damage equipment or components"},{"key":"B","text":"Debris improves filtration"},{"key":"C","text":"Debris reduces duct noise"},{"key":"D","text":"Debris strengthens sheet metal"}]'::jsonb,
  '["A"]'::jsonb,
  'Clean duct interiors help protect airflow, equipment, and indoor-air distribution quality.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is a likely effect of a badly crushed or kinked section of flexible duct?',
  '[{"key":"A","text":"Reduced airflow and increased resistance through that duct run"},{"key":"B","text":"Improved airflow velocity with no downside"},{"key":"C","text":"Lower blower energy in every system"},{"key":"D","text":"Automatic balancing of the branch"}]'::jsonb,
  '["A"]'::jsonb,
  'Crushed, compressed, or sharply kinked flexible duct restricts the flow path and increases resistance.'
),
(
  6,
  'multiple_choice',
  'application',
  'An installer notices a rectangular duct section is sagging between supports. What is the BEST response?',
  '[{"key":"A","text":"Correct the support spacing or support method so the duct remains properly aligned"},{"key":"B","text":"Seal the sagging area with tape only"},{"key":"C","text":"Increase blower speed to compensate"},{"key":"D","text":"Leave it if air still moves"}]'::jsonb,
  '["A"]'::jsonb,
  'Sagging ductwork should be corrected mechanically rather than compensated for through airflow adjustments.'
),
(
  7,
  'multiple_choice',
  'application',
  'A branch duct connection has visible gaps around the fitting. What should the installer do?',
  '[{"key":"A","text":"Secure and seal the connection using the approved duct-joining method"},{"key":"B","text":"Leave the gaps because insulation will cover them"},{"key":"C","text":"Increase supply-air temperature"},{"key":"D","text":"Reduce return-air opening size"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible gaps can create substantial leakage and should be corrected using the specified mechanical connection and sealing method.'
),
(
  8,
  'multiple_choice',
  'application',
  'A flexible duct run is much longer than necessary and contains several sharp bends. What is the BEST correction?',
  '[{"key":"A","text":"Shorten and route the duct as directly as practical while maintaining proper bend radius and support"},{"key":"B","text":"Compress the extra duct into a tighter space"},{"key":"C","text":"Add more bends to reduce noise"},{"key":"D","text":"Remove all supports"}]'::jsonb,
  '["A"]'::jsonb,
  'Excess length, compression, and sharp bends increase airflow resistance and should be minimized.'
),
(
  9,
  'multiple_choice',
  'application',
  'An installer finds sheet-metal scraps inside a newly assembled trunk duct. What is the BEST action?',
  '[{"key":"A","text":"Remove the debris before closing and placing the duct system into service"},{"key":"B","text":"Leave it because the filter will catch it"},{"key":"C","text":"Push the debris farther downstream"},{"key":"D","text":"Increase blower speed to clear it"}]'::jsonb,
  '["A"]'::jsonb,
  'Construction debris should be removed before the duct system is completed and operated.'
),
(
  10,
  'multiple_choice',
  'application',
  'A duct section is installed so tightly against another building component that vibration transfers directly into the structure. What is the BEST response?',
  '[{"key":"A","text":"Correct the installation so the duct has the intended clearance, support, or isolation"},{"key":"B","text":"Increase fan speed"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Seal the contact point with duct sealant only"}]'::jsonb,
  '["A"]'::jsonb,
  'Unintended structural contact can transmit vibration and noise and may also place stress on the duct system.'
),
(
  11,
  'multiple_choice',
  'application',
  'An installer is connecting a takeoff to a supply trunk. What should be verified before final sealing?',
  '[{"key":"A","text":"The fitting is correctly positioned, mechanically secured, and provides the intended airflow path"},{"key":"B","text":"The thermostat batteries are new"},{"key":"C","text":"The refrigerant charge is complete"},{"key":"D","text":"The condenser disconnect is labeled"}]'::jsonb,
  '["A"]'::jsonb,
  'A duct fitting should be properly located and secured before the final sealing step.'
),
(
  12,
  'multiple_choice',
  'application',
  'A return-air duct has an open seam that is pulling air from an unconditioned service space. What is the BEST response?',
  '[{"key":"A","text":"Properly secure and seal the seam to prevent unintended return-air leakage"},{"key":"B","text":"Increase supply airflow"},{"key":"C","text":"Leave it because return ducts do not need sealing"},{"key":"D","text":"Close several supply registers"}]'::jsonb,
  '["A"]'::jsonb,
  'Return-side leakage can draw unwanted air and contaminants into the HVAC system and should be corrected.'
),
(
  13,
  'multiple_choice',
  'application',
  'A newly installed branch duct interferes with access to an HVAC service panel. What is the BEST response?',
  '[{"key":"A","text":"Reroute or reposition the duct so required equipment access is maintained"},{"key":"B","text":"Leave the duct and remove the service panel permanently"},{"key":"C","text":"Cut an opening in the duct for service access"},{"key":"D","text":"Reduce duct size until the panel opens"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct installation should preserve required access for inspection, maintenance, and service.'
),
(
  14,
  'multiple_choice',
  'application',
  'A flexible duct collar connection is mechanically attached but the outer jacket is torn and insulation is exposed. What should be done?',
  '[{"key":"A","text":"Repair or replace the damaged insulation and jacket using the approved method"},{"key":"B","text":"Leave it because the inner liner is attached"},{"key":"C","text":"Remove all insulation from the branch"},{"key":"D","text":"Increase airflow through the duct"}]'::jsonb,
  '["A"]'::jsonb,
  'The duct assembly should maintain its intended insulation and vapor-barrier condition in addition to being mechanically connected.'
),
(
  15,
  'scenario',
  'scenario',
  'After startup, one room receives noticeably less supply air than similar rooms. Inspection finds its flexible duct is compressed tightly around a framing member. What is the BEST response?',
  '[{"key":"A","text":"Correct the duct routing and compression, then recheck airflow performance"},{"key":"B","text":"Close neighboring registers to force more air into the room"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Replace the room thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'The obvious airflow restriction should be corrected before using balancing adjustments to compensate for an installation defect.'
),
(
  16,
  'scenario',
  'scenario',
  'During a duct inspection, several joints appear mechanically attached but were never sealed. The system is already operating. What is the BEST action?',
  '[{"key":"A","text":"Correct the unsealed joints using the approved sealing method and verify the affected installation"},{"key":"B","text":"Leave them because the system has already started"},{"key":"C","text":"Increase fan speed"},{"key":"D","text":"Add more insulation over the joints without sealing"}]'::jsonb,
  '["A"]'::jsonb,
  'Operating status does not make unsealed duct joints acceptable; the leakage paths should be corrected.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician investigating airflow complaints finds a newly installed supply trunk partially collapsed where another trade placed material on top of it. What is the BEST response?',
  '[{"key":"A","text":"Restore or replace the damaged duct, correct the obstruction, and verify the airflow path"},{"key":"B","text":"Increase blower speed to overcome the restriction"},{"key":"C","text":"Leave the damage if the duct does not leak"},{"key":"D","text":"Reduce return-air volume"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical duct deformation can restrict airflow and should be corrected rather than masked through equipment adjustments.'
),
(
  18,
  'scenario',
  'scenario',
  'An installer discovers that a planned duct route conflicts with structural framing and would require sharply flattening the duct to fit. What is the BEST response?',
  '[{"key":"A","text":"Stop and obtain an approved routing or duct-layout solution rather than deforming the duct"},{"key":"B","text":"Flatten the duct until it fits"},{"key":"C","text":"Remove the duct supports"},{"key":"D","text":"Increase the blower setting after startup"}]'::jsonb,
  '["A"]'::jsonb,
  'Field conflicts should be resolved through an appropriate installation change rather than creating a severe airflow restriction.'
),
(
  19,
  'scenario',
  'scenario',
  'A return duct installed above a dusty construction area has several open joints, and the equipment filter is becoming dirty unusually quickly. What is the BEST response?',
  '[{"key":"A","text":"Seal the return-duct leakage and address the contamination source before relying on repeated filter changes"},{"key":"B","text":"Install a larger supply register"},{"key":"C","text":"Increase cooling setpoint"},{"key":"D","text":"Remove the return filter"}]'::jsonb,
  '["A"]'::jsonb,
  'Return leakage can pull construction dust into the HVAC system, so the leakage path and contamination exposure should be corrected.'
),
(
  20,
  'scenario',
  'scenario',
  'A final inspection finds a new duct system has clean interiors and sealed joints, but several sections block access to dampers and service components. What is the BEST response?',
  '[{"key":"A","text":"Correct the duct installation so required service and balancing access is preserved before final acceptance"},{"key":"B","text":"Accept the work because airflow is available"},{"key":"C","text":"Remove the dampers"},{"key":"D","text":"Document the blocked access and leave it unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete duct installation should provide airflow while also preserving required access to components that must be serviced or adjusted.'
);

create temporary table _seed_hvac_ductwork_air_distribution_installation_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_ductwork_air_distribution_installation_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Ductwork & Air Distribution Installation?',
  '[{"key":"A","text":"Installing duct only from field dimensions without checking system intent"},{"key":"B","text":"Evaluating duct layout, airflow path, leakage, support, access, and installation quality while resolving field conditions that affect system performance"},{"key":"C","text":"Balancing airflow only by closing registers"},{"key":"D","text":"Treating duct installation as independent of equipment and ventilation requirements"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance includes understanding how duct layout, installation quality, resistance, leakage, and access affect overall system performance.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why can excessive duct-system resistance reduce delivered airflow?',
  '[{"key":"A","text":"The blower must operate against greater pressure loss through the air-distribution path"},{"key":"B","text":"Resistance increases refrigerant flow"},{"key":"C","text":"Resistance eliminates return-air requirements"},{"key":"D","text":"Resistance always increases delivered air volume"}]'::jsonb,
  '["A"]'::jsonb,
  'Restrictions, poor transitions, excessive bends, and undersized paths increase resistance that can reduce airflow at the available blower capability.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should supply and return duct design be considered together?',
  '[{"key":"A","text":"Both sides of the air path affect airflow, pressure relationships, equipment performance, and room delivery"},{"key":"B","text":"Only return ducts determine cooling capacity"},{"key":"C","text":"Supply ducts do not affect static pressure"},{"key":"D","text":"Return ducts are unnecessary in forced-air systems"}]'::jsonb,
  '["A"]'::jsonb,
  'The supply and return systems form one connected airflow path and both can create performance problems.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to preserve access to balancing dampers, filters, coils, and service panels when planning duct layout?',
  '[{"key":"A","text":"The HVAC system must remain serviceable, adjustable, and inspectable after installation"},{"key":"B","text":"Access reduces refrigerant pressure"},{"key":"C","text":"Access eliminates duct leakage"},{"key":"D","text":"Access increases insulation R-value"}]'::jsonb,
  '["A"]'::jsonb,
  'A technically acceptable duct layout must support future balancing, maintenance, inspection, and equipment service.'
),
(
  5,
  'multiple_choice',
  'application',
  'A proposed duct route requires several abrupt transitions and tight elbows immediately downstream of the air handler. What is the BEST response?',
  '[{"key":"A","text":"Revise the layout to reduce unnecessary turbulence and resistance while meeting space constraints"},{"key":"B","text":"Keep the layout and increase blower speed later"},{"key":"C","text":"Reduce return duct size"},{"key":"D","text":"Close nearby supply dampers"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor fittings and abrupt direction changes near the equipment can create avoidable pressure loss and uneven airflow.'
),
(
  6,
  'multiple_choice',
  'application',
  'A design shows a large supply trunk crossing directly in front of several service panels. What should be done?',
  '[{"key":"A","text":"Revise the routing so required service clearances and access are maintained"},{"key":"B","text":"Install the duct and remove the panels"},{"key":"C","text":"Reduce duct height until it barely clears"},{"key":"D","text":"Leave the conflict for the service technician"}]'::jsonb,
  '["A"]'::jsonb,
  'Duct routing should be coordinated with equipment access rather than creating a permanent service obstruction.'
),
(
  7,
  'multiple_choice',
  'application',
  'A system has adequate total blower airflow, but several distant branches receive too little air because the trunk layout favors nearby outlets. What is the BEST approach?',
  '[{"key":"A","text":"Evaluate branch sizing, fitting losses, damper settings, and distribution layout before making corrective changes"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Close all nearby registers completely"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Uneven branch delivery can result from distribution-system resistance and balancing issues that should be evaluated systematically.'
),
(
  8,
  'multiple_choice',
  'application',
  'A return-air path is undersized compared with the equipment airflow requirement. What is a likely concern?',
  '[{"key":"A","text":"High return-side resistance can limit airflow and increase blower loading or system pressure"},{"key":"B","text":"Cooling capacity will always increase"},{"key":"C","text":"Supply leakage will disappear"},{"key":"D","text":"The thermostat will automatically correct the duct size"}]'::jsonb,
  '["A"]'::jsonb,
  'An undersized return path can become a major restriction in the total air-distribution system.'
),
(
  9,
  'multiple_choice',
  'application',
  'A field crew proposes flattening a round duct significantly to pass beneath a beam. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Develop an approved reroute or properly designed transition rather than creating an uncontrolled restriction"},{"key":"B","text":"Flatten the duct as much as necessary"},{"key":"C","text":"Increase fan speed afterward"},{"key":"D","text":"Remove nearby return duct"}]'::jsonb,
  '["A"]'::jsonb,
  'Major field deformation changes effective duct area and resistance and should be resolved through an engineered or approved installation solution.'
),
(
  10,
  'multiple_choice',
  'application',
  'A completed duct system has widespread leakage at transverse joints. What is the BEST corrective approach?',
  '[{"key":"A","text":"Identify and correct the joint-sealing deficiency systematically, then verify the affected ductwork"},{"key":"B","text":"Increase fan speed to offset leakage"},{"key":"C","text":"Add insulation without sealing"},{"key":"D","text":"Reduce outdoor-air intake"}]'::jsonb,
  '["A"]'::jsonb,
  'Widespread leakage indicates a quality issue that should be corrected across the affected installation rather than masked through equipment adjustments.'
),
(
  11,
  'multiple_choice',
  'application',
  'A designer is laying out branch ducts for rooms with different airflow requirements. What should guide branch selection and layout?',
  '[{"key":"A","text":"Required airflow, allowable pressure loss, fitting effects, routing constraints, and balancing needs"},{"key":"B","text":"Using the same branch size for every room"},{"key":"C","text":"Distance alone"},{"key":"D","text":"Register color"}]'::jsonb,
  '["A"]'::jsonb,
  'Branch layout should reflect the airflow requirement and the resistance created by the complete path.'
),
(
  12,
  'scenario',
  'scenario',
  'After startup, the air handler is noisy and measured airflow is low. Inspection finds a restrictive return transition and a heavily compressed flexible return connection. What is the BEST response?',
  '[{"key":"A","text":"Correct the return-side restrictions and then reassess airflow and system performance"},{"key":"B","text":"Increase blower speed immediately without correcting the duct"},{"key":"C","text":"Close supply registers"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Known return-side restrictions should be corrected before using equipment adjustments to compensate for an installation defect.'
),
(
  13,
  'scenario',
  'scenario',
  'A multi-zone installation shows good airflow near the equipment but poor airflow at the farthest outlets. Several long branches have sharp elbows and no balancing dampers. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Evaluate branch pressure losses, routing, sizing, and balancing provisions and correct the distribution design as needed"},{"key":"B","text":"Increase cooling setpoint"},{"key":"C","text":"Add refrigerant to the system"},{"key":"D","text":"Block nearby returns"}]'::jsonb,
  '["A"]'::jsonb,
  'Long restrictive branches and missing balancing provisions can create systematic distribution problems.'
),
(
  14,
  'scenario',
  'scenario',
  'A project change relocates a major piece of equipment, making the original duct route impractical. The field crew wants to add several offsets without review. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate the duct route and fitting impacts before approving the revised installation"},{"key":"B","text":"Allow any offsets that physically fit"},{"key":"C","text":"Increase blower speed after construction"},{"key":"D","text":"Reduce all branch sizes"}]'::jsonb,
  '["A"]'::jsonb,
  'Significant routing changes can alter pressure loss and airflow distribution and should be reviewed before installation.'
),
(
  15,
  'scenario',
  'scenario',
  'A new office area has persistent odors when the air handler runs. Inspection finds return-air leakage from a dusty mechanical chase. What is the BEST response?',
  '[{"key":"A","text":"Correct the return leakage and evaluate the affected return path for contamination"},{"key":"B","text":"Increase supply-air temperature"},{"key":"C","text":"Close outdoor-air intake"},{"key":"D","text":"Add a larger supply diffuser"}]'::jsonb,
  '["A"]'::jsonb,
  'Return leakage can draw contaminants from surrounding spaces into the air-distribution system.'
),
(
  16,
  'scenario',
  'scenario',
  'A duct installation meets the drawing dimensions, but several branches are visibly distorted by hangers that are too tight. What is the BEST response?',
  '[{"key":"A","text":"Correct the support method so the duct maintains its intended shape and airflow area"},{"key":"B","text":"Accept the work because hanger locations match the drawing"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Add more duct sealant"}]'::jsonb,
  '["A"]'::jsonb,
  'Supports must hold the duct without deforming the air path or creating installation damage.'
),
(
  17,
  'scenario',
  'scenario',
  'A design includes a branch takeoff immediately after a sharp trunk elbow, and field testing shows unstable airflow to that branch. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the fitting arrangement and relocate or redesign the takeoff if needed to improve airflow distribution"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Remove the branch damper"},{"key":"D","text":"Close the nearest return grille"}]'::jsonb,
  '["A"]'::jsonb,
  'Poor fitting placement can create turbulence and uneven velocity conditions that affect branch performance.'
),
(
  18,
  'scenario',
  'scenario',
  'A tenant improvement adds partitions that change room loads and airflow needs, but the existing branch duct layout is left unchanged. Several rooms now overheat. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Reassess room airflow requirements and modify distribution and balancing as necessary"},{"key":"B","text":"Lower the thermostat setpoint for the whole building"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Close all return grilles in cooler rooms"}]'::jsonb,
  '["A"]'::jsonb,
  'Changes to space use and load can require corresponding changes to air distribution rather than only thermostat adjustments.'
),
(
  19,
  'scenario',
  'scenario',
  'A project has repeated complaints of duct noise at one transition. Inspection shows an abrupt reduction and high air velocity through the fitting. What is the BEST response?',
  '[{"key":"A","text":"Evaluate and revise the transition geometry or duct sizing to reduce excessive velocity and turbulence"},{"key":"B","text":"Add refrigerant"},{"key":"C","text":"Remove insulation"},{"key":"D","text":"Increase fan speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Abrupt transitions and high velocity can create turbulence and noise and should be addressed through the air-distribution design.'
),
(
  20,
  'scenario',
  'scenario',
  'A final quality audit finds the duct system is sealed and generally well supported, but several balancing dampers are inaccessible above permanent construction. What is the BEST response?',
  '[{"key":"A","text":"Correct the access problem before final acceptance so the system can be properly balanced and serviced"},{"key":"B","text":"Accept it because the duct is sealed"},{"key":"C","text":"Remove the dampers"},{"key":"D","text":"Document the locations and leave them inaccessible"}]'::jsonb,
  '["A"]'::jsonb,
  'Balancing and service components must remain accessible for the system to be commissioned and maintained properly.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '9e726989-2260-46ac-b771-fc053fd81a93';
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
      and c.name = 'Ductwork & Air Distribution Installation'
      and c.is_current = true
  ) then
    raise exception 'Current Ductwork & Air Distribution Installation Master Competency not found';
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
    raise exception 'Current HVAC Installer / Helper L2 Ductwork & Air Distribution Installation requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L2 Ductwork & Air Distribution Installation requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L3 Ductwork & Air Distribution Installation requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L3 Ductwork & Air Distribution Installation requirement not found';
  end if;

v_level := 2;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'Ductwork & Air Distribution Installation — Level 2 Competency Assessment';

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
    select * from _seed_hvac_ductwork_air_distribution_installation_l2_questions
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
        'Ductwork & Air Distribution Installation',
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
      'IntegrateU Ductwork & Air Distribution Installation L2 production assessment v1.0.',
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
        'Ductwork & Air Distribution Installation',
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
        'IntegrateU Ductwork & Air Distribution Installation L2 production assessment v1.0.',
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
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Ductwork & Air Distribution Installation — Level 3 Competency Assessment';

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
    select * from _seed_hvac_ductwork_air_distribution_installation_l3_questions
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
        'Ductwork & Air Distribution Installation',
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
      'IntegrateU Ductwork & Air Distribution Installation L3 production assessment v1.0.',
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
        'Ductwork & Air Distribution Installation',
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
        'IntegrateU Ductwork & Air Distribution Installation L3 production assessment v1.0.',
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
   '9e726989-2260-46ac-b771-fc053fd81a93'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9e726989-2260-46ac-b771-fc053fd81a93'::uuid
  and a.target_level in (2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L2 HVAC Installer / Helper = 20
--   L2 HVAC Service & Repair Technician = 20
--   L3 HVAC Design & Sales Engineer = 20
--   L3 Senior / Lead HVAC Technician = 20
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
      '9e726989-2260-46ac-b771-fc053fd81a93'::uuid
    and a.target_level in (2,3)
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
    q.target_level = 2
    and mrt.id in (
      '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid,
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
    )
  )
  or
  (
    q.target_level = 3
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
  '9e726989-2260-46ac-b771-fc053fd81a93'::uuid;

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
    '9e726989-2260-46ac-b771-fc053fd81a93'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
