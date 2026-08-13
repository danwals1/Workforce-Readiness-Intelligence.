-- ============================================================================
-- 0084_electrician_role_progression.sql
--
-- Adds Electrical Master Roles:
--   - Electrician Apprentice
--   - Electrician Journeyman
--
-- Maps both roles to the 18 Electrical Master Competencies using the
-- Workforce Readiness Intelligence 1-4 proficiency scale:
--
--   1 = Awareness
--   2 = Working Knowledge
--   3 = Proficient / Independent
--   4 = Advanced / Can Lead or Coach
--
-- This migration creates role templates and competency requirements only.
-- It does not create assessments, training, certifications, or company roles.
-- ============================================================================


do $$
declare
  v_industry_id uuid;

  v_apprentice_role_id uuid;
  v_journeyman_role_id uuid;

  v_competency_id uuid;

  r record;

  v_count integer;

begin

  -- ==========================================================================
  -- 1. RESOLVE ELECTRICAL INDUSTRY
  -- ==========================================================================

  select id
  into v_industry_id
  from public.industries
  where slug = 'electrical'
    and is_active = true;

  if v_industry_id is null then
    raise exception 'Active Electrical industry not found';
  end if;


  -- ==========================================================================
  -- 2. VALIDATE ELECTRICAL COMPETENCY LIBRARY
  -- ==========================================================================

  select count(*)
  into v_count
  from public.master_competency_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_count <> 18 then
    raise exception
      'Expected 18 current Electrical competencies, found %',
      v_count;
  end if;


  -- ==========================================================================
  -- 3. ELECTRICIAN APPRENTICE
  -- ==========================================================================

  select id
  into v_apprentice_role_id
  from public.master_role_templates
  where industry_id = v_industry_id
    and is_current = true
    and lower(trim(name)) = lower(trim('Electrician Apprentice'))
  order by version desc
  limit 1;


  if v_apprentice_role_id is null then

    v_apprentice_role_id := gen_random_uuid();

    insert into public.master_role_templates (
      id,
      family_id,
      version,
      is_current,
      industry_id,
      name,
      department,
      purpose,
      description,
      level_scale_max,
      status
    )
    values (
      v_apprentice_role_id,
      v_apprentice_role_id,
      1,
      true,
      v_industry_id,
      'Electrician Apprentice',
      'Electrical Field Operations',
      'Develops foundational electrical knowledge and installation skills while performing work under the direction of qualified electrical personnel.',
      E'• Entry-level electrical position developing trade knowledge and field capability\n'
      '• Follow electrical and job-site safety requirements\n'
      '• Assist with installation of boxes, raceways, conduit, conductors, devices, and equipment\n'
      '• Read basic electrical drawings, symbols, schedules, and project documentation\n'
      '• Use electrical hand tools, power tools, and test equipment appropriately\n'
      '• Develop working knowledge of electrical theory, circuits, code requirements, and wiring methods\n'
      '• Perform basic conduit preparation, bending, conductor installation, and device work under direction\n'
      '• Assist with lighting, distribution, dwelling wiring, fire/alarm, and related electrical systems\n'
      '• Verify workmanship and report unsafe conditions, discrepancies, and installation issues\n'
      '• Build the knowledge and practical proficiency required for independent journeyman-level work',
      4,
      'active'
    );

  end if;


  -- ==========================================================================
  -- 4. ELECTRICIAN JOURNEYMAN
  -- ==========================================================================

  select id
  into v_journeyman_role_id
  from public.master_role_templates
  where industry_id = v_industry_id
    and is_current = true
    and lower(trim(name)) = lower(trim('Electrician Journeyman'))
  order by version desc
  limit 1;


  if v_journeyman_role_id is null then

    v_journeyman_role_id := gen_random_uuid();

    insert into public.master_role_templates (
      id,
      family_id,
      version,
      is_current,
      industry_id,
      name,
      department,
      purpose,
      description,
      level_scale_max,
      status
    )
    values (
      v_journeyman_role_id,
      v_journeyman_role_id,
      1,
      true,
      v_industry_id,
      'Electrician Journeyman',
      'Electrical Field Operations',
      'Performs electrical installation, testing, troubleshooting, and verification independently while applying code, safety, quality, and project requirements.',
      E'• Perform electrical installation and service work independently\n'
      '• Apply electrical theory, drawings, specifications, and code requirements to field conditions\n'
      '• Install and verify raceways, conduit, boxes, conductors, cables, devices, and electrical equipment\n'
      '• Perform electrical testing, measurement, troubleshooting, and corrective work\n'
      '• Work with dwelling wiring, distribution systems, transformers, feeders, services, lighting, and related systems\n'
      '• Perform and interpret electrical load calculations appropriate to assigned work\n'
      '• Apply requirements for standby, emergency, fire, alarm, and other specialized systems\n'
      '• Maintain electrical safety, workmanship, documentation, and quality standards\n'
      '• Identify installation conflicts, code concerns, unsafe conditions, and system deficiencies\n'
      '• Support the development and safe work practices of apprentices and less-experienced personnel',
      4,
      'active'
    );

  end if;


  -- ==========================================================================
  -- 5. ROLE COMPETENCY REQUIREMENTS
  --
  -- Apprentice:
  --   L1 = exposure / awareness
  --   L2 = working knowledge and supervised application
  --   L3 = independently reliable safety behavior
  --
  -- Journeyman:
  --   Primarily L3 = proficient / independent
  --   L4 reserved for critical trade capabilities where advanced judgment,
  --   safety, code application, troubleshooting, or verification is expected.
  -- ==========================================================================

  for r in

    select *
    from (
      values

        (
          'Electrical Safety & Job-Site Standards',
          3,
          4
        ),

        (
          'Electrical Theory & Circuits',
          2,
          3
        ),

        (
          'Electrical Testing & Measurement',
          2,
          3
        ),

        (
          'Electrical Drawings & Construction Documents',
          2,
          3
        ),

        (
          'Electrical Code Application',
          2,
          4
        ),

        (
          'Boxes, Wireways & Fittings',
          2,
          3
        ),

        (
          'Conduit Preparation & Bending',
          2,
          3
        ),

        (
          'Conductors & Cables',
          2,
          4
        ),

        (
          'Dwelling Wiring',
          2,
          3
        ),

        (
          'Electrical Distribution Systems',
          1,
          3
        ),

        (
          'Transformers',
          1,
          3
        ),

        (
          'Electrical Load Calculations',
          1,
          3
        ),

        (
          'Feeders & Services',
          1,
          4
        ),

        (
          'Standby & Emergency Systems',
          1,
          3
        ),

        (
          'Lighting Systems',
          2,
          3
        ),

        (
          'Fire & Alarm Systems',
          1,
          3
        ),

        (
          'Electrical Troubleshooting',
          1,
          4
        ),

        (
          'Electrical Installation Quality & Verification',
          2,
          4
        )

    ) as x(
      competency_name,
      apprentice_level,
      journeyman_level
    )

  loop

    select id
    into v_competency_id
    from public.master_competency_templates
    where industry_id = v_industry_id
      and is_current = true
      and lower(trim(name)) = lower(trim(r.competency_name))
    order by version desc
    limit 1;


    if v_competency_id is null then
      raise exception
        'Electrical competency not found: %',
        r.competency_name;
    end if;


    -- ------------------------------------------------------------------------
    -- Apprentice requirement
    -- ------------------------------------------------------------------------

    if not exists (
      select 1
      from public.master_role_competency_requirements
      where master_role_template_id = v_apprentice_role_id
        and master_competency_template_id = v_competency_id
    ) then

      insert into public.master_role_competency_requirements (
        master_role_template_id,
        master_competency_template_id,
        required_level
      )
      values (
        v_apprentice_role_id,
        v_competency_id,
        r.apprentice_level
      );

    end if;


    -- ------------------------------------------------------------------------
    -- Journeyman requirement
    -- ------------------------------------------------------------------------

    if not exists (
      select 1
      from public.master_role_competency_requirements
      where master_role_template_id = v_journeyman_role_id
        and master_competency_template_id = v_competency_id
    ) then

      insert into public.master_role_competency_requirements (
        master_role_template_id,
        master_competency_template_id,
        required_level
      )
      values (
        v_journeyman_role_id,
        v_competency_id,
        r.journeyman_level
      );

    end if;

  end loop;


  -- ==========================================================================
  -- 6. FINAL VALIDATION
  -- ==========================================================================

  select count(*)
  into v_count
  from public.master_role_competency_requirements
  where master_role_template_id = v_apprentice_role_id;

  if v_count <> 18 then
    raise exception
      'Electrician Apprentice expected 18 competency requirements, found %',
      v_count;
  end if;


  select count(*)
  into v_count
  from public.master_role_competency_requirements
  where master_role_template_id = v_journeyman_role_id;

  if v_count <> 18 then
    raise exception
      'Electrician Journeyman expected 18 competency requirements, found %',
      v_count;
  end if;

end;
$$;


-- ============================================================================
-- 7. VERIFICATION — ROLE SUMMARY
-- ============================================================================

select
  mrt.id,
  mrt.name,
  mrt.department,
  mrt.purpose,
  mrt.level_scale_max,
  count(mrcr.id) as competency_count
from public.master_role_templates mrt
left join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = mrt.id
join public.industries i
  on i.id = mrt.industry_id
where mrt.is_current = true
  and i.slug = 'electrical'
  and mrt.name in (
    'Electrician Apprentice',
    'Electrician Journeyman'
  )
group by
  mrt.id,
  mrt.name,
  mrt.department,
  mrt.purpose,
  mrt.level_scale_max
order by mrt.name;


-- ============================================================================
-- 8. VERIFICATION — LEVEL DISTRIBUTION
-- ============================================================================

select
  mrt.name as role_name,
  mrcr.required_level,
  count(*) as competency_count
from public.master_role_templates mrt
join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = mrt.id
join public.industries i
  on i.id = mrt.industry_id
where mrt.is_current = true
  and i.slug = 'electrical'
  and mrt.name in (
    'Electrician Apprentice',
    'Electrician Journeyman'
  )
group by
  mrt.name,
  mrcr.required_level
order by
  mrt.name,
  mrcr.required_level;


-- ============================================================================
-- 9. VERIFICATION — FULL MATRIX
-- ============================================================================

select
  mrt.name as role_name,
  mct.name as competency_name,
  mrcr.required_level,
  mct.is_critical
from public.master_role_templates mrt
join public.master_role_competency_requirements mrcr
  on mrcr.master_role_template_id = mrt.id
join public.master_competency_templates mct
  on mct.id = mrcr.master_competency_template_id
join public.industries i
  on i.id = mrt.industry_id
where mrt.is_current = true
  and mct.is_current = true
  and i.slug = 'electrical'
  and mrt.name in (
    'Electrician Apprentice',
    'Electrician Journeyman'
  )
order by
  mrt.name,
  mct.category,
  mct.name;
