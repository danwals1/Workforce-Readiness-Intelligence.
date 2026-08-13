-- ============================================================================
-- 0085_construction_worker_role_matrix.sql
--
-- Adds the Construction Worker Master Role and maps it to the
-- 16 Construction Master Competencies.
--
-- Proficiency scale:
--   1 = Awareness
--   2 = Working Knowledge
--   3 = Proficient / Independent
--   4 = Advanced / Can Lead or Coach
--
-- This role is intentionally a field-worker role, not a supervisory role.
-- ============================================================================


do $$
declare
  v_industry_id uuid;
  v_role_id uuid;
  v_competency_id uuid;
  v_count integer;
  r record;
begin

  -- ==========================================================================
  -- 1. RESOLVE CONSTRUCTION INDUSTRY
  -- ==========================================================================

  select id
  into v_industry_id
  from public.industries
  where slug = 'construction'
    and is_active = true;

  if v_industry_id is null then
    raise exception 'Active Construction industry not found';
  end if;


  -- ==========================================================================
  -- 2. VALIDATE CONSTRUCTION COMPETENCY LIBRARY
  -- ==========================================================================

  select count(*)
  into v_count
  from public.master_competency_templates
  where industry_id = v_industry_id
    and is_current = true
    and status = 'active';

  if v_count <> 16 then
    raise exception
      'Expected 16 current Construction competencies, found %',
      v_count;
  end if;


  -- ==========================================================================
  -- 3. CONSTRUCTION WORKER ROLE
  -- ==========================================================================

  select id
  into v_role_id
  from public.master_role_templates
  where industry_id = v_industry_id
    and is_current = true
    and lower(trim(name)) = lower(trim('Construction Worker'))
  order by version desc
  limit 1;


  if v_role_id is null then

    v_role_id := gen_random_uuid();

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
      v_role_id,
      v_role_id,
      1,
      true,
      v_industry_id,
      'Construction Worker',
      'Construction Field Operations',
      'Performs general construction field work safely and effectively while supporting material handling, tools, site preparation, installation, and project execution.',
      E'• Perform general construction field tasks under established supervision and project direction\n'
      '• Follow OSHA-aligned job-site safety requirements and company safety procedures\n'
      '• Use common hand tools and power tools safely and appropriately\n'
      '• Read basic construction drawings, dimensions, symbols, and project information\n'
      '• Perform construction math and measurement used in everyday field work\n'
      '• Move, stage, store, and protect materials safely\n'
      '• Apply foundational rigging and load-handling practices where assigned\n'
      '• Follow fall-protection, work-zone, and emergency-response requirements\n'
      '• Communicate clearly with supervisors, coworkers, and other trades\n'
      '• Maintain professional work habits, housekeeping, quality, and productivity expectations',
      4,
      'active'
    );

  end if;


  -- ==========================================================================
  -- 4. ROLE COMPETENCY REQUIREMENTS
  --
  -- Level 3 is reserved for safety-critical behaviors and routine field
  -- capabilities that should be performed reliably without constant prompting.
  -- ==========================================================================

  for r in

    select *
    from (
      values

        ('Construction Safety & OSHA Awareness', 3),
        ('Construction Math', 2),
        ('Construction Drawings', 2),
        ('Hand Tools', 2),
        ('Power Tools', 2),
        ('Material Handling', 3),
        ('Basic Rigging', 2),
        ('Fall Protection', 3),
        ('Job-Site Communication', 2),
        ('Professional & Employability Skills', 2),
        ('Construction Work Practices', 2),
        ('First Aid / CPR / AED Awareness', 1),
        ('Powered & Specialty Tool Safety', 2),
        ('Forklift & Material Equipment Awareness', 1),
        ('Traffic & Work-Zone Safety', 2),
        ('Financial Literacy', 1)

    ) as x(
      competency_name,
      required_level
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
        'Construction competency not found: %',
        r.competency_name;
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
      values (
        v_role_id,
        v_competency_id,
        r.required_level
      );

    end if;

  end loop;


  -- ==========================================================================
  -- 5. FINAL VALIDATION
  -- ==========================================================================

  select count(*)
  into v_count
  from public.master_role_competency_requirements
  where master_role_template_id = v_role_id;

  if v_count <> 16 then
    raise exception
      'Construction Worker expected 16 competency requirements, found %',
      v_count;
  end if;

end;
$$;


-- ============================================================================
-- 6. VERIFICATION — ROLE SUMMARY
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
  and i.slug = 'construction'
  and mrt.name = 'Construction Worker'
group by
  mrt.id,
  mrt.name,
  mrt.department,
  mrt.purpose,
  mrt.level_scale_max;


-- ============================================================================
-- 7. VERIFICATION — LEVEL DISTRIBUTION
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
  and i.slug = 'construction'
  and mrt.name = 'Construction Worker'
group by
  mrt.name,
  mrcr.required_level
order by
  mrcr.required_level;


-- ============================================================================
-- 8. VERIFICATION — FULL MATRIX
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
  and i.slug = 'construction'
  and mrt.name = 'Construction Worker'
order by
  mct.category,
  mct.name;
