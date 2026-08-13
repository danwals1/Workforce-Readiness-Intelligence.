-- ============================================================================
-- 0083_electrical_construction_master_competency_library.sql
--
-- Establishes the first multi-industry Master Competency Library expansion.
--
-- Adds:
--   - Electrical industry
--   - Construction industry
--   - cross-industry competency concepts
--   - selected concept mappings for existing Custom Integration competencies
--   - Electrical Master Competencies
--   - Construction Master Competencies
--
-- Does NOT:
--   - create roles
--   - create role competency requirements
--   - create assessments
--   - grant cross-industry readiness/equivalency
--
-- Cross-industry concepts express conceptual relationship only.
-- ============================================================================


-- ============================================================================
-- 1. INDUSTRIES
-- ============================================================================

insert into public.industries (
  name,
  slug,
  description,
  is_active
)
select
  'Electrical',
  'electrical',
  'Electrical construction, installation, service, maintenance, and related workforce roles.',
  true
where not exists (
  select 1
  from public.industries
  where slug = 'electrical'
);


insert into public.industries (
  name,
  slug,
  description,
  is_active
)
select
  'Construction',
  'construction',
  'General construction, field operations, craft support, and related workforce roles.',
  true
where not exists (
  select 1
  from public.industries
  where slug = 'construction'
);


-- ============================================================================
-- 2. CROSS-INDUSTRY COMPETENCY CONCEPTS
-- ============================================================================

insert into public.master_competency_concepts (
  name,
  category,
  description
)
select
  v.name,
  v.category,
  v.description
from (
  values

    (
      'Job-Site Safety',
      'Safety',
      'Recognizes, prevents, and responds appropriately to job-site hazards while following applicable safety practices.'
    ),

    (
      'Construction Drawing Interpretation',
      'Documentation',
      'Reads and interprets drawings, plans, symbols, schedules, and related construction documentation.'
    ),

    (
      'Hand and Power Tool Use',
      'Tools',
      'Selects, inspects, operates, and maintains hand and power tools safely and appropriately.'
    ),

    (
      'Professional Communication',
      'Communication',
      'Communicates clearly and professionally with coworkers, supervisors, clients, and other project stakeholders.'
    ),

    (
      'Material Handling',
      'Operations',
      'Moves, stages, protects, stores, and handles materials safely and efficiently.'
    ),

    (
      'Troubleshooting and Diagnostics',
      'Technical',
      'Uses systematic observation, testing, and reasoning to identify causes of problems and determine corrective action.'
    ),

    (
      'Quality Control',
      'Quality',
      'Evaluates completed work against requirements, documentation, workmanship expectations, and acceptance criteria.'
    ),

    (
      'Electrical Safety',
      'Electrical',
      'Applies safety practices specific to electrical work, energized systems, electrical hazards, and electrical job sites.'
    ),

    (
      'Electrical Theory',
      'Electrical',
      'Applies foundational electrical principles involving voltage, current, resistance, power, circuits, and electrical behavior.'
    ),

    (
      'Electrical Testing and Measurement',
      'Electrical',
      'Uses electrical test equipment and measurement methods to verify conditions, diagnose problems, and validate work.'
    ),

    (
      'Electrical Code Application',
      'Electrical',
      'Locates, interprets, and applies relevant electrical-code requirements to installation and service work.'
    ),

    (
      'Raceways and Conduit',
      'Electrical',
      'Selects, prepares, installs, bends, supports, and terminates raceway and conduit systems.'
    ),

    (
      'Conductors and Cables',
      'Electrical',
      'Selects, identifies, installs, routes, protects, and terminates conductors and cables.'
    ),

    (
      'Electrical Distribution',
      'Electrical',
      'Understands and works with distribution equipment and systems used to safely deliver electrical power.'
    ),

    (
      'Transformers',
      'Electrical',
      'Understands transformer operation, application, installation considerations, and related electrical relationships.'
    ),

    (
      'Electrical Load Calculations',
      'Electrical',
      'Performs and interprets electrical load calculations used for circuits, feeders, services, and equipment.'
    ),

    (
      'Feeders and Services',
      'Electrical',
      'Understands and applies requirements associated with electrical feeders, service equipment, and service conductors.'
    ),

    (
      'Standby and Emergency Power',
      'Electrical',
      'Understands installation and operational requirements for standby, emergency, and backup power systems.'
    ),

    (
      'Lighting Systems',
      'Systems',
      'Understands, installs, services, and verifies lighting-system components and associated controls.'
    ),

    (
      'Fire and Alarm Systems',
      'Systems',
      'Understands foundational installation, wiring, device, documentation, and verification concepts for fire and alarm systems.'
    ),

    (
      'Construction Math',
      'Construction',
      'Applies arithmetic, measurement, geometry, fractions, ratios, and related math used in construction work.'
    ),

    (
      'Basic Rigging',
      'Construction',
      'Applies foundational rigging concepts for safely handling, securing, and moving loads.'
    ),

    (
      'Fall Protection',
      'Safety',
      'Recognizes fall hazards and applies appropriate fall-prevention and fall-protection practices.'
    ),

    (
      'First Aid and Emergency Response',
      'Safety',
      'Understands basic first aid, CPR, AED, emergency-response, and incident-response principles appropriate to the role.'
    ),

    (
      'Traffic and Work-Zone Safety',
      'Safety',
      'Applies safe practices when working around traffic, temporary work zones, flagging operations, and public access.'
    ),

    (
      'Professional and Employability Skills',
      'Professional',
      'Demonstrates reliability, accountability, teamwork, professionalism, adaptability, and workplace conduct.'
    ),

    (
      'Financial Literacy',
      'Professional',
      'Understands foundational personal and workplace financial concepts relevant to employment and career development.'
    )

) as v(name, category, description)

where not exists (
  select 1
  from public.master_competency_concepts c
  where lower(trim(c.name)) = lower(trim(v.name))
);


-- ============================================================================
-- 3. MAP SELECTED EXISTING CUSTOM INTEGRATION COMPETENCIES
--
-- This is conceptual mapping only.
-- It does not establish readiness equivalency or transfer credit.
-- ============================================================================

update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Safety & Job-Site Standards'
  and c.name = 'Job-Site Safety'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Blueprint / Drawing Reading'
  and c.name = 'Construction Drawing Interpretation'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Tools & Installation Methods'
  and c.name = 'Hand and Power Tool Use'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Client Communication'
  and c.name = 'Professional Communication'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Equipment Staging'
  and c.name = 'Material Handling'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Troubleshooting'
  and c.name = 'Troubleshooting and Diagnostics'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Quality Control'
  and c.name = 'Quality Control'
  and mct.concept_id is distinct from c.id;


update public.master_competency_templates mct
set concept_id = c.id
from public.master_competency_concepts c
where mct.is_current = true
  and mct.industry_id =
    '58f0a680-9e6a-4071-a4e4-aa1eb6835bd7'::uuid
  and mct.name = 'Lighting / Control Systems'
  and c.name = 'Lighting Systems'
  and mct.concept_id is distinct from c.id;


-- ============================================================================
-- 4. ELECTRICAL MASTER COMPETENCIES
-- ============================================================================

do $$
declare
  v_industry_id uuid;

  r record;

  v_id uuid;
  v_concept_id uuid;

begin

  select id
  into v_industry_id
  from public.industries
  where slug = 'electrical';

  if v_industry_id is null then
    raise exception 'Electrical industry not found';
  end if;


  for r in

    select *
    from (
      values

        (
          'Electrical Safety & Job-Site Standards',
          'Safety',
          'Electrical Safety',
          true,
          'Applies electrical and job-site safety practices, recognizes electrical hazards, uses appropriate protective measures, and follows safe work procedures.'
        ),

        (
          'Electrical Theory & Circuits',
          'Electrical Fundamentals',
          'Electrical Theory',
          false,
          'Applies electrical theory and circuit principles including voltage, current, resistance, power, circuit relationships, and basic circuit behavior.'
        ),

        (
          'Electrical Testing & Measurement',
          'Testing',
          'Electrical Testing and Measurement',
          false,
          'Selects and uses electrical test equipment to measure, verify, troubleshoot, and document electrical conditions safely.'
        ),

        (
          'Electrical Drawings & Construction Documents',
          'Documentation',
          'Construction Drawing Interpretation',
          false,
          'Reads and interprets electrical plans, symbols, schedules, diagrams, specifications, and related construction documentation.'
        ),

        (
          'Electrical Code Application',
          'Codes & Standards',
          'Electrical Code Application',
          true,
          'Locates, interprets, and applies relevant National Electrical Code requirements and related project requirements to electrical work.'
        ),

        (
          'Boxes, Wireways & Fittings',
          'Installation',
          'Raceways and Conduit',
          false,
          'Selects and installs outlet, device, pull, and junction boxes, wireways, fittings, supports, and associated components.'
        ),

        (
          'Conduit Preparation & Bending',
          'Installation',
          'Raceways and Conduit',
          false,
          'Measures, prepares, bends, routes, supports, and installs conduit using appropriate tools, methods, and workmanship standards.'
        ),

        (
          'Conductors & Cables',
          'Installation',
          'Conductors and Cables',
          false,
          'Selects, identifies, routes, protects, installs, and terminates electrical conductors and cables according to project and code requirements.'
        ),

        (
          'Dwelling Wiring',
          'Installation',
          'Electrical Distribution',
          false,
          'Installs and verifies common dwelling branch circuits, receptacles, switches, devices, lighting, and associated wiring methods.'
        ),

        (
          'Electrical Distribution Systems',
          'Power Distribution',
          'Electrical Distribution',
          true,
          'Understands and works with panels, overcurrent protection, distribution equipment, grounding concepts, and electrical distribution systems.'
        ),

        (
          'Transformers',
          'Power Distribution',
          'Transformers',
          false,
          'Applies transformer principles and installation considerations including voltage relationships, connections, loading, and system application.'
        ),

        (
          'Electrical Load Calculations',
          'Design & Calculation',
          'Electrical Load Calculations',
          false,
          'Performs and interprets electrical load calculations used for circuits, equipment, feeders, services, and distribution planning.'
        ),

        (
          'Feeders & Services',
          'Power Distribution',
          'Feeders and Services',
          true,
          'Applies requirements associated with feeders, service conductors, service equipment, sizing, protection, grounding, and installation.'
        ),

        (
          'Standby & Emergency Systems',
          'Power Systems',
          'Standby and Emergency Power',
          true,
          'Understands and applies foundational requirements for standby, emergency, generator, transfer, and backup electrical systems.'
        ),

        (
          'Lighting Systems',
          'Systems',
          'Lighting Systems',
          false,
          'Installs, services, and verifies lighting components, fixtures, drivers, ballasts, controls, and associated circuits.'
        ),

        (
          'Fire & Alarm Systems',
          'Systems',
          'Fire and Alarm Systems',
          true,
          'Applies foundational wiring, device, documentation, installation, and verification principles for fire and alarm systems.'
        ),

        (
          'Electrical Troubleshooting',
          'Troubleshooting',
          'Troubleshooting and Diagnostics',
          true,
          'Uses systematic testing, measurement, documentation, and electrical reasoning to locate faults and determine appropriate corrective action.'
        ),

        (
          'Electrical Installation Quality & Verification',
          'Quality',
          'Quality Control',
          true,
          'Inspects and verifies electrical work for workmanship, documentation alignment, code requirements, functionality, and project acceptance.'
        )

    ) as x(
      name,
      category,
      concept_name,
      is_critical,
      description
    )

  loop

    select id
    into v_concept_id
    from public.master_competency_concepts
    where name = r.concept_name;


    if not exists (
      select 1
      from public.master_competency_templates m
      where m.industry_id = v_industry_id
        and m.is_current = true
        and lower(trim(m.name)) = lower(trim(r.name))
    ) then

      v_id := gen_random_uuid();

      insert into public.master_competency_templates (
        id,
        family_id,
        version,
        is_current,
        industry_id,
        concept_id,
        name,
        category,
        is_critical,
        description,
        status
      )
      values (
        v_id,
        v_id,
        1,
        true,
        v_industry_id,
        v_concept_id,
        r.name,
        r.category,
        r.is_critical,
        r.description,
        'active'
      );

    end if;

  end loop;

end;
$$;


-- ============================================================================
-- 5. CONSTRUCTION MASTER COMPETENCIES
-- ============================================================================

do $$
declare
  v_industry_id uuid;

  r record;

  v_id uuid;
  v_concept_id uuid;

begin

  select id
  into v_industry_id
  from public.industries
  where slug = 'construction';

  if v_industry_id is null then
    raise exception 'Construction industry not found';
  end if;


  for r in

    select *
    from (
      values

        (
          'Construction Safety & OSHA Awareness',
          'Safety',
          'Job-Site Safety',
          true,
          'Recognizes common construction hazards, follows safe work practices, understands worker rights and responsibilities, and applies foundational OSHA-aligned safety principles.'
        ),

        (
          'Construction Math',
          'Fundamentals',
          'Construction Math',
          false,
          'Applies arithmetic, fractions, decimals, measurement, geometry, ratios, and other math commonly used in construction work.'
        ),

        (
          'Construction Drawings',
          'Documentation',
          'Construction Drawing Interpretation',
          false,
          'Reads and interprets construction drawings, symbols, dimensions, schedules, notes, and related project documentation.'
        ),

        (
          'Hand Tools',
          'Tools',
          'Hand and Power Tool Use',
          false,
          'Selects, inspects, uses, stores, and maintains common construction hand tools safely and appropriately.'
        ),

        (
          'Power Tools',
          'Tools',
          'Hand and Power Tool Use',
          true,
          'Selects, inspects, operates, and maintains common construction power tools using appropriate safety practices.'
        ),

        (
          'Material Handling',
          'Operations',
          'Material Handling',
          true,
          'Moves, stages, stores, protects, lifts, and handles construction materials using safe and efficient work practices.'
        ),

        (
          'Basic Rigging',
          'Operations',
          'Basic Rigging',
          true,
          'Applies foundational rigging concepts including load awareness, basic hardware, inspection, communication, and safe load handling.'
        ),

        (
          'Fall Protection',
          'Safety',
          'Fall Protection',
          true,
          'Recognizes fall hazards and correctly applies foundational fall-prevention, fall-restraint, and fall-protection practices.'
        ),

        (
          'Job-Site Communication',
          'Communication',
          'Professional Communication',
          false,
          'Communicates clearly with supervisors, coworkers, trade partners, and other job-site stakeholders regarding work, hazards, status, and coordination.'
        ),

        (
          'Professional & Employability Skills',
          'Professional',
          'Professional and Employability Skills',
          false,
          'Demonstrates reliability, punctuality, accountability, teamwork, professionalism, adaptability, and appropriate workplace conduct.'
        ),

        (
          'Construction Work Practices',
          'Operations',
          'Quality Control',
          false,
          'Performs assigned construction work using appropriate sequencing, workmanship, housekeeping, documentation, and quality expectations.'
        ),

        (
          'First Aid / CPR / AED Awareness',
          'Safety',
          'First Aid and Emergency Response',
          true,
          'Understands foundational first-aid, CPR, AED, emergency-response, and incident-notification principles appropriate to construction work.'
        ),

        (
          'Powered & Specialty Tool Safety',
          'Tools',
          'Hand and Power Tool Use',
          true,
          'Applies safety requirements for powered and specialty construction tools, including controlled-use and higher-risk equipment.'
        ),

        (
          'Forklift & Material Equipment Awareness',
          'Equipment',
          'Material Handling',
          true,
          'Recognizes hazards, operating boundaries, communication requirements, and safe-work principles associated with forklifts and material-handling equipment.'
        ),

        (
          'Traffic & Work-Zone Safety',
          'Safety',
          'Traffic and Work-Zone Safety',
          true,
          'Applies foundational traffic-control, work-zone, visibility, public-interface, and flagging safety principles.'
        ),

        (
          'Financial Literacy',
          'Professional',
          'Financial Literacy',
          false,
          'Understands foundational financial concepts relevant to employment, compensation, budgeting, benefits, and career development.'
        )

    ) as x(
      name,
      category,
      concept_name,
      is_critical,
      description
    )

  loop

    select id
    into v_concept_id
    from public.master_competency_concepts
    where name = r.concept_name;


    if not exists (
      select 1
      from public.master_competency_templates m
      where m.industry_id = v_industry_id
        and m.is_current = true
        and lower(trim(m.name)) = lower(trim(r.name))
    ) then

      v_id := gen_random_uuid();

      insert into public.master_competency_templates (
        id,
        family_id,
        version,
        is_current,
        industry_id,
        concept_id,
        name,
        category,
        is_critical,
        description,
        status
      )
      values (
        v_id,
        v_id,
        1,
        true,
        v_industry_id,
        v_concept_id,
        r.name,
        r.category,
        r.is_critical,
        r.description,
        'active'
      );

    end if;

  end loop;

end;
$$;


-- ============================================================================
-- 6. VERIFICATION
-- ============================================================================

select
  i.name as industry_name,
  count(*) filter (where m.is_current = true) as current_master_competencies,
  count(*) filter (
    where m.is_current = true
      and m.concept_id is not null
  ) as concept_linked_competencies
from public.industries i
left join public.master_competency_templates m
  on m.industry_id = i.id
where i.slug in (
  'ci',
  'electrical',
  'construction'
)
group by
  i.id,
  i.name
order by
  i.name;


select
  i.name as industry_name,
  m.name as competency_name,
  m.category,
  c.name as concept_name,
  m.is_critical
from public.master_competency_templates m
join public.industries i
  on i.id = m.industry_id
left join public.master_competency_concepts c
  on c.id = m.concept_id
where m.is_current = true
  and i.slug in (
    'electrical',
    'construction'
  )
order by
  i.name,
  m.category,
  m.name;
