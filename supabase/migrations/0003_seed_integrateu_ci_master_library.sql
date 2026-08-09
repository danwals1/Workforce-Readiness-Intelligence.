-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0003_seed_integrateu_ci_master_library.sql
--
-- Seeds the initial IntegrateU Custom Integration (CI) Master Library:
--   12 role templates
--   32 competency templates
--   334 non-zero role-to-competency requirement mappings
--
-- Proficiency scale:
--   0 = Not Required (not stored)
--   1 = Awareness
--   2 = Working Knowledge
--   3 = Proficient / Independent
--   4 = Advanced / Can Lead or Coach
--
-- Idempotent: existing CI industry, role templates, competency templates, and
-- mappings are reused. Existing manually-created content is not overwritten.
-- ============================================================================

do $$
declare
  v_industry_id uuid;
  v_role_id uuid;
  v_competency_id uuid;
  v_roles_inserted int := 0;
  v_competencies_inserted int := 0;
  v_mappings_inserted int := 0;
  v_last_row_count int := 0;
begin
  -- Reuse the existing CI industry by slug or name. Insert only if absent.
  select id
    into v_industry_id
  from industries
  where lower(slug) = 'ci'
     or lower(name) = 'custom integration'
  order by case when lower(slug) = 'ci' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    insert into industries (name, slug, description, is_active)
    values ('Custom Integration', 'ci', 'Systems integration / custom integration industry', true)
    returning id into v_industry_id;
  end if;

  -- --------------------------------------------------------------------------
  -- Master role templates
  -- Existing current templates with the same industry + name are preserved.
  -- --------------------------------------------------------------------------

  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Technician I — Entry Level'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Technician I — Entry Level',
       'Field Operations',
       'Develops core field-installation skills while safely completing assigned work under direction.',
       '
• Entry-level position for individuals new to the industry or with limited field experience
• Assist with low-voltage cabling, wiring, and equipment installation
• Pull, terminate, label, and test cabling under supervision
• Assist with installation of audio/video, networking, security, lighting, control, and related systems
• Follow blueprints, wiring diagrams, and project documentation
• Learn proper use of tools, equipment, and installation methods
• Follow company installation, safety, and job-site standards
• Maintain clean and organized work areas
• Complete assigned tasks under the direction of Technician II or Lead Technician
• Document completed work and communicate issues to the team',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Technician II — Experienced'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Technician II — Experienced',
       'Field Operations',
       'Performs standard installation work independently, troubleshoots common issues, and supports junior technicians.',
       '
• Experienced technician capable of completing installation tasks with limited supervision
• Install and configure system equipment and components
• Read and interpret blueprints, wiring diagrams, and system documentation
• Perform cable termination, testing, equipment installation, and basic configuration
• Install racks, displays, speakers, networking equipment, cameras, control devices, and related components
• Diagnose and troubleshoot installation, equipment, signal, and connectivity issues
• Complete assigned work independently
• Verify installation quality and system functionality
• Assist with system testing and commissioning
• Support and mentor Technician I team members
• Communicate field conditions, progress, and issues to the Lead Technician',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Technician III — Lead Technician'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Technician III — Lead Technician',
       'Field Operations',
       'Leads field execution, advanced troubleshooting, quality control, and technician development.',
       '
• Lead onsite installation activities and field teams
• Direct and support Technician I and Technician II team members
• Review project scope, drawings, documentation, and daily priorities
• Assign field tasks and coordinate installation activities
• Install, configure, test, and troubleshoot advanced integrated systems
• Resolve complex field and installation issues
• Coordinate with Project Managers, contractors, builders, electricians, designers, and other trades
• Perform quality-control inspections
• Verify systems are ready for commissioning and project closeout
• Monitor field progress and communicate project status
• Coach and develop junior technicians
• Maintain installation, safety, and quality standards',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Service Technician'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Service Technician',
       'Service',
       'Diagnoses, repairs, maintains, and supports installed residential and commercial systems.',
       '
• Diagnose and troubleshoot system, equipment, and connectivity issues
• Perform onsite and remote residential and commercial service
• Repair, replace, configure, and update system components
• Perform preventative maintenance and system health checks
• Document service calls, issues, and completed work
• Communicate repair recommendations to clients
• Coordinate replacement equipment and follow-up visits
• Escalate complex technical issues when necessary
• Provide client system education and support',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Systems Programmer'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Systems Programmer',
       'Programming / Engineering',
       'Programs, configures, commissions, and validates integrated systems and user experiences.',
       '
• Program and configure integrated systems
• Develop and configure user interfaces
• Configure control, audio/video, networking, lighting, and related systems
• Commission and test completed systems
• Troubleshoot system and network issues
• Verify system functionality and design intent
• Coordinate with designers, technicians, and Project Managers
• Provide client training and technical support',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Systems Designer'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Systems Designer',
       'Design / Engineering',
       'Translates project requirements into coordinated system designs, specifications, drawings, and technical documentation.',
       '
• Evaluate project requirements and client needs
• Develop system designs, wiring plans, and equipment specifications
• Create drawings and technical documentation
• Design residential and commercial integrated systems
• Coordinate with sales, project management, programming, and installation teams
• Provide technical support throughout project execution
• Maintain accurate system documentation',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Project Manager'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Project Manager',
       'Project Management',
       'Owns project execution from handoff through completion, coordinating scope, schedule, resources, communication, and closeout.',
       '
• Manage projects from handoff through completion
• Develop and maintain project schedules
• Coordinate technicians, resources, equipment, and materials
• Assign tasks and establish project priorities
• Monitor project scope, labor, schedule, and progress
• Coordinate with clients, contractors, builders, designers, and other trades
• Resolve project issues and field-team roadblocks
• Ensure projects meet quality and completion standards
• Manage project communication and documentation',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Warehouse Associate'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Warehouse Associate',
       'Warehouse / Logistics',
       'Maintains accurate receiving, inventory, staging, and material readiness for field operations.',
       '
• Receive, inspect, label, and organize equipment and materials
• Pick and stage equipment for upcoming projects
• Verify equipment against purchase orders and project documentation
• Maintain accurate inventory records
• Prepare materials and equipment for field teams
• Process returns and defective products
• Maintain a clean, organized, and safe warehouse
• Report shortages, damage, and inventory discrepancies',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Logistics Manager'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Logistics Manager',
       'Warehouse / Logistics',
       'Coordinates purchasing, inventory, staging, vendors, and material flow to support project schedules.',
       '
• Manage purchasing, receiving, inventory, staging, and movement of materials
• Coordinate equipment requirements with Project Managers
• Ensure materials are available according to project schedules
• Manage vendor orders, deliveries, returns, and backorders
• Oversee inventory accuracy and stock levels
• Coordinate project staging and preparation
• Track shortages and delayed products
• Supervise warehouse operations and Warehouse Associates',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Sales Specialist'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Sales Specialist',
       'Sales',
       'Develops client relationships, identifies needs, builds solutions and proposals, and manages opportunities through close.',
       '
• Develop relationships with prospective and existing clients
• Identify client needs and recommend solutions
• Develop project scopes, proposals, and pricing
• Present solutions and manage the sales process
• Coordinate with design and technical teams
• Manage client follow-up and contract negotiations
• Maintain relationships throughout the project lifecycle',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Sales Manager'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Sales Manager',
       'Sales',
       'Leads sales performance, pipeline execution, coaching, forecasting, pricing review, and sales-to-operations alignment.',
       '
• Lead and manage the sales team
• Establish sales goals and performance expectations
• Manage the sales process and pipeline
• Monitor opportunities, close rates, and revenue forecasts
• Coach and develop Sales Specialists
• Review project scopes, proposals, and pricing
• Develop key client and industry relationships
• Coordinate sales-to-operations handoffs
• Track sales KPIs and team performance
• Identify new business development opportunities',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  select id into v_role_id
  from master_role_templates
  where industry_id = v_industry_id
    and name = 'Operations Manager'
    and is_current = true
  order by version desc
  limit 1;

  if v_role_id is null then
    insert into master_role_templates
      (industry_id, name, department, purpose, description, level_scale_max, version, is_current, status)
    values
      (v_industry_id,
       'Operations Manager',
       'Operations',
       'Leads operational execution across departments, capacity, workflow, accountability, KPIs, and continuous improvement.',
       '
• Oversee daily business and operational activities
• Manage project workflow, scheduling, staffing, and resource allocation
• Coordinate sales, project management, installation, service, programming, warehouse, and logistics
• Monitor capacity, productivity, and operational performance
• Identify and resolve workflow bottlenecks
• Establish operational processes and standards
• Track KPIs and team accountability
• Support department leaders and field teams
• Ensure projects move efficiently from sale through completion
• Drive continuous operational improvement',
       4, 1, true, 'active')
    returning id into v_role_id;
    v_roles_inserted := v_roles_inserted + 1;
  end if;


  -- --------------------------------------------------------------------------
  -- Master competency templates
  -- Existing current templates with the same industry + name are preserved.
  -- --------------------------------------------------------------------------

  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Low-Voltage Fundamentals'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Low-Voltage Fundamentals',
       'Technical Fundamentals',
       false,
       'Demonstrates foundational knowledge of low-voltage systems, signal paths, wiring practices, and common integrated-system components.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Cabling & Termination'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Cabling & Termination',
       'Installation',
       false,
       'Pulls, routes, secures, labels, terminates, and tests low-voltage cabling to documented standards.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Tools & Installation Methods'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Tools & Installation Methods',
       'Installation',
       false,
       'Uses installation tools, hardware, mounting methods, and field practices safely and correctly.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Blueprint / Drawing Reading'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Blueprint / Drawing Reading',
       'Technical Fundamentals',
       false,
       'Reads and interprets blueprints, wiring diagrams, elevations, schedules, scopes, and technical documentation.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'AV Systems'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'AV Systems',
       'Systems',
       false,
       'Understands, installs, configures, tests, and supports audio/video system components and signal flow.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Networking'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Networking',
       'Systems',
       false,
       'Understands and applies networking concepts required to install, configure, diagnose, and support integrated systems.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Security / Surveillance'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Security / Surveillance',
       'Systems',
       false,
       'Understands and supports security, surveillance, camera, and related low-voltage system components and workflows.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Lighting / Control Systems'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Lighting / Control Systems',
       'Systems',
       false,
       'Understands, installs, configures, and supports lighting-control and integrated control systems.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'System Configuration'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'System Configuration',
       'Systems',
       false,
       'Configures devices and systems according to design intent, project documentation, and manufacturer requirements.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Programming'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Programming',
       'Systems',
       false,
       'Programs and configures control logic, integrations, automation behavior, and related system functionality.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Testing & Commissioning'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Testing & Commissioning',
       'Systems',
       false,
       'Tests completed work, commissions systems, validates functionality, and confirms design intent.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Troubleshooting'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Troubleshooting',
       'Service',
       false,
       'Systematically diagnoses and resolves equipment, signal, network, configuration, and integration issues.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Quality Control'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Quality Control',
       'Quality & Safety',
       false,
       'Inspects work, verifies standards, identifies defects, and confirms systems and documentation meet completion expectations.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Safety & Job-Site Standards'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Safety & Job-Site Standards',
       'Quality & Safety',
       false,
       'Follows and reinforces safe work practices, job-site expectations, tool safety, cleanliness, and company standards.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Documentation'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Documentation',
       'Communication',
       false,
       'Creates, updates, and maintains accurate project, service, installation, technical, and operational documentation.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Client Communication'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Client Communication',
       'Communication',
       false,
       'Communicates clearly and professionally with clients regarding expectations, status, issues, recommendations, and next steps.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Client Training'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Client Training',
       'Communication',
       false,
       'Explains system operation and provides effective end-user training and support.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Time Management'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Time Management',
       'Operations',
       false,
       'Plans and manages time, priorities, commitments, and assigned work to meet expectations.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Project Planning'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Project Planning',
       'Project Management',
       false,
       'Develops and maintains execution plans, priorities, milestones, sequencing, and project-readiness expectations.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Scheduling & Resource Planning'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Scheduling & Resource Planning',
       'Project Management',
       false,
       'Coordinates schedules, staffing, resources, workload, and capacity to support project execution.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Inventory Management'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Inventory Management',
       'Warehouse & Logistics',
       false,
       'Maintains accurate inventory, stock levels, material records, and inventory-control processes.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Purchasing / Procurement'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Purchasing / Procurement',
       'Warehouse & Logistics',
       false,
       'Coordinates purchasing, vendor orders, deliveries, returns, backorders, and procurement follow-up.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Equipment Staging'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Equipment Staging',
       'Warehouse & Logistics',
       false,
       'Picks, verifies, organizes, labels, and stages project equipment and materials for field execution.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Scope & Proposal Development'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Scope & Proposal Development',
       'Sales',
       false,
       'Develops clear project scopes, proposed solutions, pricing inputs, and proposal documentation.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'CRM / Sales Process'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'CRM / Sales Process',
       'Sales',
       false,
       'Uses the CRM and defined sales process to manage opportunities, activity, follow-up, stages, and forecasting.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Sales / Closing'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Sales / Closing',
       'Sales',
       false,
       'Advances opportunities, presents value, handles objections and negotiations, and closes business.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Financial / Margin Awareness'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Financial / Margin Awareness',
       'Operations',
       false,
       'Understands the financial impact of scope, labor, material, pricing, margin, rework, and operational decisions.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Team Leadership'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Team Leadership',
       'Leadership',
       false,
       'Sets expectations, directs work, supports accountability, and leads team execution.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Coaching & Development'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Coaching & Development',
       'Leadership',
       false,
       'Develops others through instruction, observation, guided practice, feedback, and evaluation.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Cross-Department Coordination'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Cross-Department Coordination',
       'Operations',
       false,
       'Coordinates information, handoffs, priorities, and execution across departments and functional teams.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'KPI Management'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'KPI Management',
       'Operations',
       false,
       'Uses key performance indicators to monitor results, identify gaps, reinforce accountability, and guide action.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  select id into v_competency_id
  from master_competency_templates
  where industry_id = v_industry_id
    and name = 'Process Improvement'
    and is_current = true
  order by version desc
  limit 1;

  if v_competency_id is null then
    insert into master_competency_templates
      (industry_id, name, category, is_critical, description, version, is_current, status)
    values
      (v_industry_id,
       'Process Improvement',
       'Operations',
       false,
       'Identifies bottlenecks, root causes, and opportunities to improve repeatability, quality, efficiency, and performance.',
       1, true, 'active')
    returning id into v_competency_id;
    v_competencies_inserted := v_competencies_inserted + 1;
  end if;


  -- --------------------------------------------------------------------------
  -- Role × Competency requirement matrix
  -- Only values 1–4 are stored; zero means Not Required.
  -- Existing mappings are preserved and are not overwritten.
  -- --------------------------------------------------------------------------

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Low-Voltage Fundamentals'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cabling & Termination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Tools & Installation Methods'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Blueprint / Drawing Reading'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'AV Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Networking'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Security / Surveillance'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Lighting / Control Systems'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'System Configuration'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Programming'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Testing & Commissioning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Troubleshooting'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Quality Control'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Safety & Job-Site Standards'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Documentation'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Communication'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Client Training'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Time Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Project Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scheduling & Resource Planning'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Inventory Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Purchasing / Procurement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician I — Entry Level'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Equipment Staging'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Scope & Proposal Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'CRM / Sales Process'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Sales / Closing'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Financial / Margin Awareness'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Team Leadership'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Coaching & Development'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Cross-Department Coordination'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'KPI Management'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician II — Experienced'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Technician III — Lead Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Service Technician'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Programmer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 2
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Systems Designer'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Project Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Warehouse Associate'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Logistics Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 1
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Specialist'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 3
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Sales Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;

  insert into master_role_competency_requirements
    (master_role_template_id, master_competency_template_id, required_level)
  select r.id, c.id, 4
  from master_role_templates r
  join master_competency_templates c
    on c.industry_id = r.industry_id
   and c.name = 'Process Improvement'
   and c.is_current = true
  where r.industry_id = v_industry_id
    and r.name = 'Operations Manager'
    and r.is_current = true
    and not exists (
      select 1
      from master_role_competency_requirements x
      where x.master_role_template_id = r.id
        and x.master_competency_template_id = c.id
    )
  order by r.version desc, c.version desc
  limit 1;

  get diagnostics v_last_row_count = row_count;
  v_mappings_inserted := v_mappings_inserted + v_last_row_count;


  raise notice 'CI Master Library seed complete: % roles inserted, % competencies inserted, % mappings inserted.',
    v_roles_inserted, v_competencies_inserted, v_mappings_inserted;
end;
$$;

-- Verification summary (returns counts after the seed runs).
with ci as (
  select id
  from industries
  where lower(slug) = 'ci'
     or lower(name) = 'custom integration'
  order by case when lower(slug) = 'ci' then 0 else 1 end
  limit 1
)
select
  (select count(*) from master_role_templates r
    where r.industry_id = (select id from ci) and r.is_current) as current_ci_roles,
  (select count(*) from master_competency_templates c
    where c.industry_id = (select id from ci) and c.is_current) as current_ci_competencies,
  (select count(*)
     from master_role_competency_requirements m
     join master_role_templates r on r.id = m.master_role_template_id
    where r.industry_id = (select id from ci) and r.is_current) as current_ci_requirement_mappings;
