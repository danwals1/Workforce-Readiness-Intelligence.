-- ============================================================================
-- 0125_hvac_industry_roles_competencies.sql
-- HVAC master industry, competency, role, requirement, and assessment-standard bootstrap
-- ============================================================================

begin;

-- ============================================================================
-- 1. HVAC INDUSTRY
-- ============================================================================

insert into public.industries (name, slug, description, is_active)
select
  'HVAC',
  'hvac',
  'Heating, ventilation, air conditioning, refrigeration, installation, service, design, and related workforce roles.',
  true
where not exists (
  select 1 from public.industries where slug = 'hvac'
);

-- ============================================================================
-- 2. HVAC-SPECIFIC CROSS-INDUSTRY CONCEPTS
-- ============================================================================

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Safety and Regulatory Compliance', 'Safety', 'Applies HVAC-specific safety, regulatory, environmental, and safe-work requirements.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Safety and Regulatory Compliance'
);

insert into public.master_competency_concepts (name, category, description)
select 'Refrigerant Safety and Environmental Practices', 'Safety', 'Handles refrigerants using appropriate safety, environmental, recovery, and compliance practices.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Refrigerant Safety and Environmental Practices'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Tools and Test Instruments', 'Tools', 'Selects, inspects, uses, and maintains HVAC tools and test instruments appropriately.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Tools and Test Instruments'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Equipment Installation', 'Installation', 'Applies equipment-placement, installation, support, access, and installation-quality requirements.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Equipment Installation'
);

insert into public.master_competency_concepts (name, category, description)
select 'Ductwork and Air Distribution', 'Installation', 'Applies principles for ductwork, fittings, air distribution, sealing, support, and installation.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Ductwork and Air Distribution'
);

insert into public.master_competency_concepts (name, category, description)
select 'Refrigerant Piping', 'Refrigeration', 'Applies principles for refrigerant piping, line sets, routing, support, protection, and installation.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Refrigerant Piping'
);

insert into public.master_competency_concepts (name, category, description)
select 'Brazing and Joining', 'Refrigeration', 'Applies safe and effective brazing, joining, preparation, and leak-prevention practices.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Brazing and Joining'
);

insert into public.master_competency_concepts (name, category, description)
select 'Refrigeration Cycle', 'Refrigeration', 'Understands and applies refrigeration-cycle principles and system relationships.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Refrigeration Cycle'
);

insert into public.master_competency_concepts (name, category, description)
select 'Airflow and Ventilation', 'Airflow', 'Understands and applies airflow, static pressure, ventilation, distribution, and air-side system principles.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Airflow and Ventilation'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Controls', 'Controls', 'Understands and applies HVAC controls, thermostats, control circuits, sequences, and related devices.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Controls'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Startup and Commissioning', 'Quality', 'Performs or supports HVAC startup, commissioning, functional verification, and system-quality checks.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Startup and Commissioning'
);

insert into public.master_competency_concepts (name, category, description)
select 'Preventive Maintenance', 'Service', 'Performs planned inspection, cleaning, testing, adjustment, and maintenance activities to support reliable operation.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Preventive Maintenance'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Equipment Application', 'Design', 'Selects and applies HVAC equipment based on system requirements, conditions, capabilities, and application constraints.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Equipment Application'
);

insert into public.master_competency_concepts (name, category, description)
select 'HVAC Load Calculations and System Design', 'Design', 'Applies load, sizing, design, layout, and system-selection principles to HVAC solutions.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'HVAC Load Calculations and System Design'
);

insert into public.master_competency_concepts (name, category, description)
select 'Estimating and Technical Sales', 'Commercial', 'Develops estimates, proposals, scopes, and technically appropriate customer solutions.'
where not exists (
  select 1
  from public.master_competency_concepts
  where name = 'Estimating and Technical Sales'
);

-- ============================================================================
-- 3. HVAC MASTER COMPETENCIES
-- ============================================================================

create temporary table _seed_hvac_competencies (
  name text primary key,
  category text not null,
  concept_name text not null,
  is_critical boolean not null,
  description text not null
);

insert into _seed_hvac_competencies (
  name, category, concept_name, is_critical, description
)
values
  ('HVAC Safety & Regulatory Awareness', 'Safety', 'HVAC Safety and Regulatory Compliance', true, 'Recognizes and applies HVAC-specific safety, regulatory, environmental, and safe-work requirements.'),
  ('Electrical Safety & LOTO Awareness', 'Safety', 'Electrical Safety', true, 'Recognizes electrical hazards and applies appropriate electrical-safety and lockout/tagout awareness principles in HVAC work.'),
  ('Refrigerant Safety & Environmental Practices', 'Safety', 'Refrigerant Safety and Environmental Practices', true, 'Applies foundational refrigerant safety, handling, environmental, recovery, and compliance practices.'),
  ('Personal Protective Equipment & Work-Site Safety', 'Safety', 'Job-Site Safety', true, 'Selects and applies appropriate PPE and safe-work practices for HVAC field, installation, and service environments.'),
  ('HVAC Tools & Test Instruments', 'Tools', 'HVAC Tools and Test Instruments', true, 'Selects, inspects, uses, and maintains common HVAC tools and test instruments safely and appropriately.'),
  ('Construction Math & Measurement', 'Construction', 'Construction Math', false, 'Applies arithmetic, measurement, fractions, geometry, ratios, and related math used in HVAC installation and service work.'),
  ('HVAC Drawings, Schematics & Documentation', 'Documentation', 'Construction Drawing Interpretation', false, 'Reads and interprets HVAC drawings, schematics, plans, symbols, schedules, specifications, and related documentation.'),
  ('Equipment Installation & Placement', 'Installation', 'HVAC Equipment Installation', true, 'Applies equipment-placement, support, access, clearance, installation, and workmanship requirements.'),
  ('Ductwork & Air Distribution Installation', 'Installation', 'Ductwork and Air Distribution', true, 'Installs and evaluates ductwork and air-distribution components using appropriate layout, sealing, support, and workmanship practices.'),
  ('Refrigerant Piping & Line-Set Installation', 'Refrigeration', 'Refrigerant Piping', true, 'Installs, routes, supports, protects, and prepares refrigerant piping and line sets using appropriate practices.'),
  ('Brazing, Joining & Leak Prevention', 'Refrigeration', 'Brazing and Joining', true, 'Applies safe preparation, brazing, joining, purging, inspection, and leak-prevention practices.'),
  ('Refrigeration Cycle Fundamentals', 'Refrigeration', 'Refrigeration Cycle', false, 'Understands refrigeration-cycle components, states, heat transfer, pressures, temperatures, and system relationships.'),
  ('Airflow, Static Pressure & Ventilation', 'Airflow', 'Airflow and Ventilation', false, 'Applies airflow, static-pressure, ventilation, distribution, balancing, and air-side system principles.'),
  ('HVAC Electrical Fundamentals', 'Electrical', 'Electrical Theory', true, 'Applies foundational electrical principles to HVAC power, motors, circuits, loads, components, and service work.'),
  ('HVAC Controls & Thermostats', 'Controls', 'HVAC Controls', true, 'Understands and works with HVAC thermostats, control circuits, sequences, relays, sensors, and related control components.'),
  ('System Startup & Commissioning', 'Quality', 'HVAC Startup and Commissioning', true, 'Performs or supports system startup, commissioning, operational checks, adjustments, and functional verification.'),
  ('Preventive Maintenance', 'Service', 'Preventive Maintenance', false, 'Performs planned HVAC inspection, cleaning, testing, adjustment, documentation, and maintenance activities.'),
  ('HVAC Diagnostics & Troubleshooting', 'Technical', 'Troubleshooting and Diagnostics', true, 'Uses systematic observation, measurement, testing, and reasoning to diagnose HVAC system problems and determine corrective action.'),
  ('Equipment Selection & System Application', 'Design', 'HVAC Equipment Application', false, 'Selects and applies HVAC equipment based on system requirements, loads, operating conditions, capabilities, and application constraints.'),
  ('Load Calculations & HVAC System Design', 'Design', 'HVAC Load Calculations and System Design', false, 'Applies load calculations, sizing, layout, system design, and related engineering principles to HVAC solutions.'),
  ('HVAC Customer & Service Communication', 'Communication', 'Professional Communication', false, 'Communicates clearly and professionally with HVAC customers, coworkers, supervisors, trade partners, and other stakeholders.'),
  ('Estimating, Proposals & Technical Sales', 'Commercial', 'Estimating and Technical Sales', false, 'Develops estimates, scopes, proposals, and technically appropriate HVAC solutions while supporting customer decision-making.');

do $$
declare
  v_industry_id uuid;
  v_concept_id uuid;
  v_id uuid;
  v_count integer;
  r record;
begin
  select id
  into v_industry_id
  from public.industries
  where slug = 'hvac'
    and is_active = true
  limit 1;

  if v_industry_id is null then
    raise exception 'Active HVAC industry not found';
  end if;

  for r in
    select * from _seed_hvac_competencies order by name
  loop
    select id
    into v_concept_id
    from public.master_competency_concepts
    where name = r.concept_name
    limit 1;

    if v_concept_id is null then
      raise exception 'HVAC competency concept not found: %', r.concept_name;
    end if;

    if not exists (
      select 1
      from public.master_competency_templates m
      where m.industry_id = v_industry_id
        and m.is_current = true
        and lower(trim(m.name)) = lower(trim(r.name))
    ) then
      v_id := gen_random_uuid();

      insert into public.master_competency_templates (
        id, family_id, version, is_current, industry_id, concept_id,
        name, category, is_critical, description, status
      )
      values (
        v_id, v_id, 1, true, v_industry_id, v_concept_id,
        r.name, r.category, r.is_critical, r.description, 'active'
      );
    end if;
  end loop;

  select count(*)
  into v_count
  from public.master_competency_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_count <> 22 then
    raise exception 'Expected 22 current HVAC competencies, found %', v_count;
  end if;
end;
$$;

-- ============================================================================
-- 4. HVAC MASTER ROLES
-- ============================================================================

create temporary table _seed_hvac_roles (
  name text primary key,
  department text not null,
  purpose text not null,
  description text not null
);

insert into _seed_hvac_roles (name, department, purpose, description)
values
  ('HVAC Installer / Helper', 'HVAC Field Operations', 'Supports and performs routine HVAC installation work while developing foundational technical, safety, and system knowledge.', '• Support and perform routine HVAC equipment installation under established direction
• Follow HVAC, electrical, refrigerant, PPE, and job-site safety requirements
• Use common HVAC tools and test instruments appropriately
• Read basic HVAC drawings, schematics, plans, and installation documentation
• Perform construction math, measurement, equipment placement, ductwork, and line-set installation
• Support brazing, joining, leak-prevention, startup, and commissioning activities within assigned qualifications
• Develop foundational knowledge of refrigeration, airflow, electrical systems, controls, maintenance, and diagnostics
• Communicate clearly with supervisors, coworkers, customers, and other trades
• Identify unsafe conditions, installation conflicts, defects, and conditions requiring escalation
• Build the knowledge and practical proficiency required for independent HVAC service and installation work'),
  ('HVAC Service & Repair Technician', 'HVAC Service Operations', 'Performs HVAC service, maintenance, diagnosis, repair, startup, and customer-facing field work independently.', '• Perform routine HVAC service, preventive maintenance, diagnosis, and repair independently
• Apply HVAC, electrical, refrigerant, and job-site safety requirements
• Use electrical, refrigeration, airflow, and HVAC test instruments to evaluate system operation
• Read and apply HVAC drawings, wiring diagrams, schematics, sequences, and service documentation
• Diagnose refrigeration, airflow, electrical, controls, and equipment-performance problems systematically
• Perform refrigerant piping, brazing, startup, commissioning, adjustment, and corrective work
• Apply equipment-selection and system-application principles to service recommendations
• Communicate findings, repair options, system conditions, and completed work clearly to customers and stakeholders
• Document service activity, measurements, deficiencies, recommendations, and corrective actions
• Escalate complex, unusual, unsafe, or design-level conditions appropriately'),
  ('Senior / Lead HVAC Technician', 'HVAC Field Operations', 'Leads complex HVAC technical work, advanced diagnosis, commissioning, quality verification, escalation, and field development.', '• Lead advanced HVAC installation, service, diagnosis, repair, and commissioning activities
• Apply high-level judgment to electrical, refrigeration, airflow, controls, and system-performance issues
• Troubleshoot complex and intermittent HVAC problems using systematic measurement and technical reasoning
• Verify installation quality, startup conditions, operating performance, safety, and corrective work
• Interpret advanced drawings, schematics, sequences, technical data, and project documentation
• Support equipment application, load/design considerations, estimates, scopes, and technical recommendations
• Coordinate field work, technical escalation, customers, trade partners, and project stakeholders
• Mentor installers, helpers, and service technicians while reinforcing safe and consistent work practices
• Identify recurring deficiencies, process problems, design conflicts, and opportunities for corrective action
• Serve as a trusted field escalation point for complex HVAC technical and quality issues'),
  ('HVAC Design & Sales Engineer', 'HVAC Design & Sales', 'Develops technically appropriate HVAC system designs, applications, estimates, proposals, and customer solutions.', '• Evaluate customer, building, comfort, performance, and project requirements
• Interpret plans, floor plans, drawings, specifications, schedules, and existing-system information
• Apply HVAC load, sizing, airflow, ventilation, electrical, controls, and system-design concepts
• Select and apply equipment appropriate to loads, conditions, constraints, and customer objectives
• Develop system layouts, scopes, estimates, proposals, options, and technical recommendations
• Coordinate design intent with installers, service teams, project stakeholders, and other trades
• Communicate system concepts, tradeoffs, capabilities, limitations, and value clearly to customers
• Recognize safety, regulatory, refrigerant, installation, serviceability, and commissioning considerations
• Support technically accurate handoff from sales/design into installation and field execution
• Maintain clear design, proposal, project, and customer documentation throughout the solution process');

do $$
declare
  v_industry_id uuid;
  v_role_id uuid;
  v_count integer;
  r record;
begin
  select id into v_industry_id
  from public.industries
  where slug = 'hvac'
    and is_active = true
  limit 1;

  if v_industry_id is null then
    raise exception 'Active HVAC industry not found';
  end if;

  for r in select * from _seed_hvac_roles order by name
  loop
    select id into v_role_id
    from public.master_role_templates
    where industry_id = v_industry_id
      and is_current = true
      and lower(trim(name)) = lower(trim(r.name))
    order by version desc
    limit 1;

    if v_role_id is null then
      v_role_id := gen_random_uuid();

      insert into public.master_role_templates (
        id, family_id, version, is_current, industry_id,
        name, department, purpose, description, level_scale_max, status
      )
      values (
        v_role_id, v_role_id, 1, true, v_industry_id,
        r.name, r.department, r.purpose, r.description, 4, 'active'
      );
    end if;
  end loop;

  select count(*) into v_count
  from public.master_role_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_count <> 4 then
    raise exception 'Expected 4 current HVAC roles, found %', v_count;
  end if;
end;
$$;

-- ============================================================================
-- 5. HVAC ROLE COMPETENCY REQUIREMENTS
-- ============================================================================

create temporary table _seed_hvac_role_requirements (
  role_name text not null,
  competency_name text not null,
  required_level integer not null check (required_level between 1 and 4),
  primary key (role_name, competency_name)
);

insert into _seed_hvac_role_requirements (
  role_name, competency_name, required_level
)
values
  ('HVAC Installer / Helper', 'HVAC Safety & Regulatory Awareness', 2),
  ('HVAC Installer / Helper', 'Electrical Safety & LOTO Awareness', 1),
  ('HVAC Installer / Helper', 'Refrigerant Safety & Environmental Practices', 1),
  ('HVAC Installer / Helper', 'Personal Protective Equipment & Work-Site Safety', 2),
  ('HVAC Installer / Helper', 'HVAC Tools & Test Instruments', 2),
  ('HVAC Installer / Helper', 'Construction Math & Measurement', 2),
  ('HVAC Installer / Helper', 'HVAC Drawings, Schematics & Documentation', 1),
  ('HVAC Installer / Helper', 'Equipment Installation & Placement', 2),
  ('HVAC Installer / Helper', 'Ductwork & Air Distribution Installation', 2),
  ('HVAC Installer / Helper', 'Refrigerant Piping & Line-Set Installation', 2),
  ('HVAC Installer / Helper', 'Brazing, Joining & Leak Prevention', 1),
  ('HVAC Installer / Helper', 'Refrigeration Cycle Fundamentals', 1),
  ('HVAC Installer / Helper', 'Airflow, Static Pressure & Ventilation', 1),
  ('HVAC Installer / Helper', 'HVAC Electrical Fundamentals', 1),
  ('HVAC Installer / Helper', 'HVAC Controls & Thermostats', 1),
  ('HVAC Installer / Helper', 'System Startup & Commissioning', 1),
  ('HVAC Installer / Helper', 'Preventive Maintenance', 1),
  ('HVAC Installer / Helper', 'HVAC Diagnostics & Troubleshooting', 1),
  ('HVAC Installer / Helper', 'HVAC Customer & Service Communication', 1),
  ('HVAC Service & Repair Technician', 'HVAC Safety & Regulatory Awareness', 3),
  ('HVAC Service & Repair Technician', 'Electrical Safety & LOTO Awareness', 3),
  ('HVAC Service & Repair Technician', 'Refrigerant Safety & Environmental Practices', 3),
  ('HVAC Service & Repair Technician', 'Personal Protective Equipment & Work-Site Safety', 3),
  ('HVAC Service & Repair Technician', 'HVAC Tools & Test Instruments', 3),
  ('HVAC Service & Repair Technician', 'Construction Math & Measurement', 2),
  ('HVAC Service & Repair Technician', 'HVAC Drawings, Schematics & Documentation', 3),
  ('HVAC Service & Repair Technician', 'Equipment Installation & Placement', 3),
  ('HVAC Service & Repair Technician', 'Ductwork & Air Distribution Installation', 2),
  ('HVAC Service & Repair Technician', 'Refrigerant Piping & Line-Set Installation', 3),
  ('HVAC Service & Repair Technician', 'Brazing, Joining & Leak Prevention', 3),
  ('HVAC Service & Repair Technician', 'Refrigeration Cycle Fundamentals', 3),
  ('HVAC Service & Repair Technician', 'Airflow, Static Pressure & Ventilation', 3),
  ('HVAC Service & Repair Technician', 'HVAC Electrical Fundamentals', 3),
  ('HVAC Service & Repair Technician', 'HVAC Controls & Thermostats', 3),
  ('HVAC Service & Repair Technician', 'System Startup & Commissioning', 3),
  ('HVAC Service & Repair Technician', 'Preventive Maintenance', 3),
  ('HVAC Service & Repair Technician', 'HVAC Diagnostics & Troubleshooting', 3),
  ('HVAC Service & Repair Technician', 'Equipment Selection & System Application', 2),
  ('HVAC Service & Repair Technician', 'Load Calculations & HVAC System Design', 1),
  ('HVAC Service & Repair Technician', 'HVAC Customer & Service Communication', 3),
  ('HVAC Service & Repair Technician', 'Estimating, Proposals & Technical Sales', 1),
  ('Senior / Lead HVAC Technician', 'HVAC Safety & Regulatory Awareness', 4),
  ('Senior / Lead HVAC Technician', 'Electrical Safety & LOTO Awareness', 4),
  ('Senior / Lead HVAC Technician', 'Refrigerant Safety & Environmental Practices', 4),
  ('Senior / Lead HVAC Technician', 'Personal Protective Equipment & Work-Site Safety', 4),
  ('Senior / Lead HVAC Technician', 'HVAC Tools & Test Instruments', 4),
  ('Senior / Lead HVAC Technician', 'Construction Math & Measurement', 3),
  ('Senior / Lead HVAC Technician', 'HVAC Drawings, Schematics & Documentation', 4),
  ('Senior / Lead HVAC Technician', 'Equipment Installation & Placement', 4),
  ('Senior / Lead HVAC Technician', 'Ductwork & Air Distribution Installation', 3),
  ('Senior / Lead HVAC Technician', 'Refrigerant Piping & Line-Set Installation', 4),
  ('Senior / Lead HVAC Technician', 'Brazing, Joining & Leak Prevention', 4),
  ('Senior / Lead HVAC Technician', 'Refrigeration Cycle Fundamentals', 4),
  ('Senior / Lead HVAC Technician', 'Airflow, Static Pressure & Ventilation', 4),
  ('Senior / Lead HVAC Technician', 'HVAC Electrical Fundamentals', 4),
  ('Senior / Lead HVAC Technician', 'HVAC Controls & Thermostats', 4),
  ('Senior / Lead HVAC Technician', 'System Startup & Commissioning', 4),
  ('Senior / Lead HVAC Technician', 'Preventive Maintenance', 4),
  ('Senior / Lead HVAC Technician', 'HVAC Diagnostics & Troubleshooting', 4),
  ('Senior / Lead HVAC Technician', 'Equipment Selection & System Application', 4),
  ('Senior / Lead HVAC Technician', 'Load Calculations & HVAC System Design', 3),
  ('Senior / Lead HVAC Technician', 'HVAC Customer & Service Communication', 4),
  ('Senior / Lead HVAC Technician', 'Estimating, Proposals & Technical Sales', 2),
  ('HVAC Design & Sales Engineer', 'HVAC Safety & Regulatory Awareness', 2),
  ('HVAC Design & Sales Engineer', 'Electrical Safety & LOTO Awareness', 2),
  ('HVAC Design & Sales Engineer', 'Refrigerant Safety & Environmental Practices', 2),
  ('HVAC Design & Sales Engineer', 'Personal Protective Equipment & Work-Site Safety', 1),
  ('HVAC Design & Sales Engineer', 'HVAC Tools & Test Instruments', 1),
  ('HVAC Design & Sales Engineer', 'Construction Math & Measurement', 3),
  ('HVAC Design & Sales Engineer', 'HVAC Drawings, Schematics & Documentation', 4),
  ('HVAC Design & Sales Engineer', 'Equipment Installation & Placement', 2),
  ('HVAC Design & Sales Engineer', 'Ductwork & Air Distribution Installation', 3),
  ('HVAC Design & Sales Engineer', 'Refrigerant Piping & Line-Set Installation', 2),
  ('HVAC Design & Sales Engineer', 'Refrigeration Cycle Fundamentals', 3),
  ('HVAC Design & Sales Engineer', 'Airflow, Static Pressure & Ventilation', 4),
  ('HVAC Design & Sales Engineer', 'HVAC Electrical Fundamentals', 2),
  ('HVAC Design & Sales Engineer', 'HVAC Controls & Thermostats', 3),
  ('HVAC Design & Sales Engineer', 'System Startup & Commissioning', 2),
  ('HVAC Design & Sales Engineer', 'HVAC Diagnostics & Troubleshooting', 2),
  ('HVAC Design & Sales Engineer', 'Equipment Selection & System Application', 4),
  ('HVAC Design & Sales Engineer', 'Load Calculations & HVAC System Design', 4),
  ('HVAC Design & Sales Engineer', 'HVAC Customer & Service Communication', 4),
  ('HVAC Design & Sales Engineer', 'Estimating, Proposals & Technical Sales', 4);

do $$
declare
  v_industry_id uuid;
  v_role_id uuid;
  v_competency_id uuid;
  v_count integer;
  r record;
begin
  select id into v_industry_id
  from public.industries
  where slug = 'hvac'
    and is_active = true
  limit 1;

  for r in
    select *
    from _seed_hvac_role_requirements
    order by role_name, competency_name
  loop
    select id into v_role_id
    from public.master_role_templates
    where industry_id = v_industry_id
      and is_current = true
      and lower(trim(name)) = lower(trim(r.role_name))
    order by version desc
    limit 1;

    if v_role_id is null then
      raise exception 'HVAC role not found: %', r.role_name;
    end if;

    select id into v_competency_id
    from public.master_competency_templates
    where industry_id = v_industry_id
      and is_current = true
      and lower(trim(name)) = lower(trim(r.competency_name))
    order by version desc
    limit 1;

    if v_competency_id is null then
      raise exception 'HVAC competency not found: %', r.competency_name;
    end if;

    if not exists (
      select 1
      from public.master_role_competency_requirements
      where master_role_template_id = v_role_id
        and master_competency_template_id = v_competency_id
    ) then
      insert into public.master_role_competency_requirements (
        master_role_template_id,
        master_competency_template_id,
        required_level
      )
      values (v_role_id, v_competency_id, r.required_level);
    end if;

    if not exists (
      select 1
      from public.master_role_competency_requirements
      where master_role_template_id = v_role_id
        and master_competency_template_id = v_competency_id
        and required_level = r.required_level
    ) then
      raise exception
        'HVAC requirement level conflict: role %, competency %, expected L%',
        r.role_name, r.competency_name, r.required_level;
    end if;
  end loop;

  select count(*) into v_count
  from public.master_role_competency_requirements mrcr
  join public.master_role_templates mrt
    on mrt.id = mrcr.master_role_template_id
  where mrt.industry_id = v_industry_id
    and mrt.is_current = true;

  if v_count <> 83 then
    raise exception 'Expected 83 HVAC role competency requirements, found %', v_count;
  end if;
end;
$$;

-- ============================================================================
-- 6. CURRENT ASSESSMENT STANDARDS FOR EVERY HVAC ROLE-REQUIRED LEVEL
--
-- L1 = 20 / 8 foundational / 8 application / 4 scenario
-- L2 = 20 / 5 foundational / 9 application / 6 scenario
-- L3 = 20 / 4 foundational / 7 application / 9 scenario
-- L4 = 20 / 3 foundational / 7 application / 10 scenario
-- ============================================================================

with required_levels as (
  select distinct
    mct.id as master_competency_template_id,
    sr.required_level as target_level
  from _seed_hvac_role_requirements sr
  join public.industries i
    on i.slug = 'hvac'
   and i.is_active = true
  join public.master_competency_templates mct
    on mct.industry_id = i.id
   and mct.is_current = true
   and lower(trim(mct.name)) = lower(trim(sr.competency_name))
),
standard_values as (
  select
    master_competency_template_id,
    target_level,
    20::integer as required_question_count,
    case target_level
      when 1 then 8
      when 2 then 5
      when 3 then 4
      when 4 then 3
    end::integer as foundational_count,
    case target_level
      when 1 then 8
      when 2 then 9
      when 3 then 7
      when 4 then 7
    end::integer as application_count,
    case target_level
      when 1 then 4
      when 2 then 6
      when 3 then 9
      when 4 then 10
    end::integer as scenario_count
  from required_levels
  where target_level between 1 and 4
)
insert into public.master_competency_assessment_standards (
  master_competency_template_id,
  target_level,
  required_question_count,
  foundational_count,
  application_count,
  scenario_count,
  is_current
)
select
  sv.master_competency_template_id,
  sv.target_level,
  sv.required_question_count,
  sv.foundational_count,
  sv.application_count,
  sv.scenario_count,
  true
from standard_values sv
where not exists (
  select 1
  from public.master_competency_assessment_standards existing
  where existing.master_competency_template_id = sv.master_competency_template_id
    and existing.target_level = sv.target_level
    and existing.is_current = true
);

-- ============================================================================
-- 7. HARD VALIDATION
-- ============================================================================

do $$
declare
  v_industry_id uuid;
  v_competency_count integer;
  v_role_count integer;
  v_requirement_count integer;
  v_bad_standard_count integer;
  v_expected integer;
  v_actual integer;
  r record;
begin
  select id into v_industry_id
  from public.industries
  where slug = 'hvac'
    and is_active = true
  limit 1;

  select count(*) into v_competency_count
  from public.master_competency_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_competency_count <> 22 then
    raise exception 'Expected 22 HVAC competencies, found %', v_competency_count;
  end if;

  select count(*) into v_role_count
  from public.master_role_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_role_count <> 4 then
    raise exception 'Expected 4 HVAC roles, found %', v_role_count;
  end if;

  select count(*) into v_requirement_count
  from public.master_role_competency_requirements mrcr
  join public.master_role_templates mrt
    on mrt.id = mrcr.master_role_template_id
  where mrt.industry_id = v_industry_id
    and mrt.is_current = true;

  if v_requirement_count <> 83 then
    raise exception 'Expected 83 HVAC role requirements, found %', v_requirement_count;
  end if;

  for r in
    select
      sr.role_name,
      count(*)::integer as expected_count
    from _seed_hvac_role_requirements sr
    group by sr.role_name
  loop
    v_expected := r.expected_count;

    select count(*)::integer into v_actual
    from public.master_role_competency_requirements mrcr
    join public.master_role_templates mrt
      on mrt.id = mrcr.master_role_template_id
    where mrt.industry_id = v_industry_id
      and mrt.is_current = true
      and mrt.name = r.role_name;

    if v_actual <> v_expected then
      raise exception
        'HVAC role % expected % requirements, found %',
        r.role_name, v_expected, v_actual;
    end if;
  end loop;

  with required_levels as (
    select distinct
      mct.id as competency_id,
      sr.required_level as target_level
    from _seed_hvac_role_requirements sr
    join public.master_competency_templates mct
      on mct.industry_id = v_industry_id
     and mct.is_current = true
     and lower(trim(mct.name)) = lower(trim(sr.competency_name))
  )
  select count(*) into v_bad_standard_count
  from required_levels rl
  left join public.master_competency_assessment_standards s
    on s.master_competency_template_id = rl.competency_id
   and s.target_level = rl.target_level
   and s.is_current = true
  where s.id is null
     or s.required_question_count <> 20
     or s.foundational_count <> case rl.target_level
          when 1 then 8 when 2 then 5 when 3 then 4 when 4 then 3 end
     or s.application_count <> case rl.target_level
          when 1 then 8 when 2 then 9 when 3 then 7 when 4 then 7 end
     or s.scenario_count <> case rl.target_level
          when 1 then 4 when 2 then 6 when 3 then 9 when 4 then 10 end;

  if v_bad_standard_count <> 0 then
    raise exception
      'Found % missing or conflicting current HVAC assessment standards',
      v_bad_standard_count;
  end if;
end;
$$;

commit;

-- ============================================================================
-- 8. VERIFICATION — HVAC ROLE SUMMARY
-- ============================================================================

select
  mrt.id as role_id,
  mrt.name as role_name,
  mrt.department,
  mrt.level_scale_max,
  count(mrcr.id)::integer as competency_count
from public.master_role_templates mrt
join public.industries i
  on i.id = mrt.industry_id
left join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = mrt.id
where i.slug = 'hvac'
  and mrt.is_current = true
group by
  mrt.id, mrt.name, mrt.department, mrt.level_scale_max
order by mrt.name;

-- ============================================================================
-- 9. VERIFICATION — HVAC ROLE LEVEL DISTRIBUTION
-- ============================================================================

select
  mrt.name as role_name,
  mrcr.required_level,
  count(*)::integer as competency_count
from public.master_role_templates mrt
join public.industries i
  on i.id = mrt.industry_id
join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = mrt.id
where i.slug = 'hvac'
  and mrt.is_current = true
group by mrt.name, mrcr.required_level
order by mrt.name, mrcr.required_level;

-- ============================================================================
-- 10. VERIFICATION — HVAC STANDARD COVERAGE
-- ============================================================================

with required_levels as (
  select distinct
    mct.id as competency_id,
    mct.name as competency_name,
    mrcr.required_level
  from public.master_role_templates mrt
  join public.industries i
    on i.id = mrt.industry_id
  join public.master_role_competency_requirements mrcr
    on mrcr.master_role_template_id = mrt.id
  join public.master_competency_templates mct
    on mct.id = mrcr.master_competency_template_id
   and mct.is_current = true
  where i.slug = 'hvac'
    and mrt.is_current = true
)
select
  rl.competency_name,
  rl.required_level,
  s.required_question_count,
  s.foundational_count,
  s.application_count,
  s.scenario_count
from required_levels rl
left join public.master_competency_assessment_standards s
  on s.master_competency_template_id = rl.competency_id
 and s.target_level = rl.required_level
 and s.is_current = true
order by rl.competency_name, rl.required_level;
