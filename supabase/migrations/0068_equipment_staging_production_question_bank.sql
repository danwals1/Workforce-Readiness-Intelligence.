-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0068_equipment_staging_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Equipment Staging
--   Target level: 3 — Proficient / Independent
--   Questions: 20
--
-- Mix:
--   4 foundational
--   7 application
--   9 scenario
--
-- Flow:
--   Master Question Bank
--   -> secure answer keys
--   -> Technician III role applicability
--   -> Equipment Staging competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_equipment_staging_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_equipment_staging_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- ============================================================================
-- FOUNDATIONAL — 4
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of equipment staging before field installation?',
  '[
    {"key":"A","text":"Move equipment out of the warehouse as quickly as possible"},
    {"key":"B","text":"Confirm the correct equipment is identified, organized, prepared, and ready for the planned work"},
    {"key":"C","text":"Eliminate the need for project documentation"},
    {"key":"D","text":"Allow technicians to decide onsite what equipment they need"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective staging improves field readiness by confirming that required equipment is correct, organized, identifiable, and available before installation.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Which project information should normally be used when staging equipment?',
  '[
    {"key":"A","text":"Current approved project documentation, equipment lists, scope, and applicable drawings"},
    {"key":"B","text":"Only the technician''s memory of the project"},
    {"key":"C","text":"A previous project with similar equipment"},
    {"key":"D","text":"Only the shipping invoice"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Staging should be based on current project requirements rather than assumptions or outdated information.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why should staged equipment be clearly identified by project, phase, area, or destination when appropriate?',
  '[
    {"key":"A","text":"To make the staging area look organized"},
    {"key":"B","text":"To reduce selection errors and help the correct equipment reach the correct work area"},
    {"key":"C","text":"To eliminate equipment testing"},
    {"key":"D","text":"To avoid documenting shortages"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Clear identification reduces mix-ups and helps preserve the relationship between equipment and the work it supports.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What should happen when required equipment is missing or incorrect during staging?',
  '[
    {"key":"A","text":"The discrepancy should be identified and communicated before the affected installation work begins"},
    {"key":"B","text":"The field team should discover the problem onsite"},
    {"key":"C","text":"A similar-looking device should automatically be substituted"},
    {"key":"D","text":"The item should be marked complete anyway"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Staging is an opportunity to identify shortages and discrepancies early enough for corrective action.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  5,
  'multiple_choice',
  'application',
  'You are staging equipment for a project with prewire, trim, and finish phases. What is the BEST approach?',
  '[
    {"key":"A","text":"Send all equipment to the site during prewire"},
    {"key":"B","text":"Organize equipment according to the project phase and planned installation sequence"},
    {"key":"C","text":"Stage equipment alphabetically by manufacturer only"},
    {"key":"D","text":"Let each technician search the warehouse as needed"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Phase-based staging supports project flow and reduces unnecessary handling, loss, and field confusion.'
),

(
  6,
  'multiple_select',
  'application',
  'Which THREE checks are appropriate when staging project equipment?',
  '[
    {"key":"A","text":"Confirm model or part number against current project requirements"},
    {"key":"B","text":"Confirm quantity"},
    {"key":"C","text":"Identify visible damage or obvious discrepancies"},
    {"key":"D","text":"Assume sealed boxes contain the correct project item without checking identification"},
    {"key":"E","text":"Substitute equipment based only on physical appearance"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Model, quantity, and condition checks help detect common staging problems before equipment reaches the field.'
),

(
  7,
  'situational_judgment',
  'application',
  'The equipment list calls for six identical devices, but only five are available in staging. What is the BEST response?',
  '[
    {"key":"A","text":"Stage five and do not mention the shortage"},
    {"key":"B","text":"Document the shortage, confirm whether another unit is available or incoming, and notify the appropriate project or logistics owner"},
    {"key":"C","text":"Use a different model without approval"},
    {"key":"D","text":"Change the required quantity to five"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A shortage should become a visible project issue with ownership before it creates an avoidable field delay.'
),

(
  8,
  'multiple_choice',
  'application',
  'Two projects use the same device model and both are being staged at the same time. What BEST reduces the risk of equipment being assigned to the wrong project?',
  '[
    {"key":"A","text":"Place all identical devices together without project identification"},
    {"key":"B","text":"Maintain clear project-specific identification and physical separation or controlled allocation"},
    {"key":"C","text":"Ask the installation teams to divide the devices onsite"},
    {"key":"D","text":"Remove all manufacturer labels"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Project-specific identification and controlled allocation prevent shared inventory from creating project shortages or mix-ups.'
),

(
  9,
  'situational_judgment',
  'application',
  'A staged device has the correct manufacturer but a different model number from the approved equipment list. What should you do?',
  '[
    {"key":"A","text":"Assume the model is an acceptable replacement"},
    {"key":"B","text":"Hold the item from installation and verify the discrepancy through the appropriate project or procurement process"},
    {"key":"C","text":"Install it and test whether it works"},
    {"key":"D","text":"Change the equipment list to match the device"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Model substitutions can affect compatibility, programming, features, cost, and scope and therefore require verification.'
),

(
  10,
  'multiple_choice',
  'application',
  'Why is it useful to stage accessories, mounting hardware, power supplies, adapters, and related components with the primary device when practical?',
  '[
    {"key":"A","text":"It reduces the chance that installation is delayed by a small but required component"},
    {"key":"B","text":"It makes every equipment package heavier"},
    {"key":"C","text":"It removes the need for a bill of materials"},
    {"key":"D","text":"It guarantees the system is programmed"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Installation readiness includes the supporting components needed to actually install and connect the primary equipment.'
),

(
  11,
  'multiple_select',
  'application',
  'Which THREE conditions indicate that staged equipment may NOT yet be installation-ready?',
  '[
    {"key":"A","text":"A required accessory is missing"},
    {"key":"B","text":"The model number conflicts with current project documentation"},
    {"key":"C","text":"Equipment shows visible shipping damage"},
    {"key":"D","text":"The equipment is clearly labeled for the correct project"},
    {"key":"E","text":"Required quantities have been confirmed"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Missing components, documentation conflicts, and damaged equipment are all readiness risks that should be resolved before field use.'
),

-- ============================================================================
-- SCENARIO — 9
-- ============================================================================

(
  12,
  'scenario',
  'scenario',
  'The installation team is scheduled to start tomorrow morning. During final staging, you discover that several required mounting brackets were never ordered. What is the BEST response?',
  '[
    {"key":"A","text":"Send the devices anyway and let the technicians solve it onsite"},
    {"key":"B","text":"Identify the affected work, communicate the shortage immediately, determine whether the brackets can be sourced in time, and coordinate any necessary schedule adjustment"},
    {"key":"C","text":"Remove the devices from the project scope"},
    {"key":"D","text":"Mark the staging process complete because the primary equipment is available"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Staging should surface missing installation dependencies early and trigger coordinated corrective action.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'A box is labeled for the correct project, but the serial number inside does not match the serial number previously assigned in project documentation. What is the BEST action?',
  '[
    {"key":"A","text":"Ignore the difference because the model is correct"},
    {"key":"B","text":"Verify whether serial-number tracking is required and resolve or update the assignment through the controlled documentation process before deployment"},
    {"key":"C","text":"Remove the serial number from the documentation"},
    {"key":"D","text":"Assign the serial number to a different project without checking"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Where serialized equipment is tracked, staging should preserve accurate equipment-to-project records.'
),

(
  14,
  'scenario',
  'scenario',
  'A project has equipment for three floors, and field installation will occur one floor at a time. How should the lead prepare the equipment?',
  '[
    {"key":"A","text":"Combine all devices into one unlabeled shipment"},
    {"key":"B","text":"Stage and identify equipment by floor or work area in alignment with the installation sequence"},
    {"key":"C","text":"Send only the most expensive equipment first"},
    {"key":"D","text":"Let technicians sort all equipment at the job site"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Area-based staging reduces field sorting and supports efficient installation sequencing.'
),

(
  15,
  'situational_judgment',
  'scenario',
  'While staging a rack-based system, you discover that one component requires a different rack depth than what appears to be available. What is the BEST response?',
  '[
    {"key":"A","text":"Assume the field team can make it fit"},
    {"key":"B","text":"Verify the rack and component requirements against current design information and escalate the physical compatibility issue before installation"},
    {"key":"C","text":"Remove another component from the rack"},
    {"key":"D","text":"Modify the equipment chassis"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Staging can identify physical compatibility issues before they become expensive field problems.'
),

(
  16,
  'scenario',
  'scenario',
  'The project documentation shows ten keypads, but twelve were ordered and received. What is the BEST staging decision?',
  '[
    {"key":"A","text":"Send all twelve to the job site"},
    {"key":"B","text":"Stage the documented project quantity and verify the disposition of the two additional units before allocating them"},
    {"key":"C","text":"Install the two extras wherever space is available"},
    {"key":"D","text":"Discard the extra units"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Excess equipment should remain controlled until its intended allocation or return status is confirmed.'
),

(
  17,
  'situational_judgment',
  'scenario',
  'Several devices arrive with damaged packaging after shipment. The equipment itself appears normal from the outside. What should happen before those devices are treated as installation-ready?',
  '[
    {"key":"A","text":"Nothing; damaged packaging never matters"},
    {"key":"B","text":"Inspect and document the condition according to company process and verify whether additional testing, replacement, or shipping action is required"},
    {"key":"C","text":"Immediately throw the equipment away"},
    {"key":"D","text":"Hide the packaging damage from the project team"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Shipping damage should be evaluated and documented before potentially affected equipment is deployed.'
),

(
  18,
  'scenario',
  'scenario',
  'A technician asks you to add an unlisted spare network switch to the project shipment because it might be useful onsite. What is the BEST response?',
  '[
    {"key":"A","text":"Add any spare equipment requested by the field team"},
    {"key":"B","text":"Determine whether the switch is approved for the project or being issued as controlled spare equipment before allocating it"},
    {"key":"C","text":"Remove another listed switch to make room"},
    {"key":"D","text":"Transfer the switch without recording it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Equipment allocation should remain controlled so inventory, project cost, and equipment ownership remain accurate.'
),

(
  19,
  'situational_judgment',
  'scenario',
  'The staged equipment is complete, but the job site has informed the project manager that secure storage will not be available until next week. What is the BEST response?',
  '[
    {"key":"A","text":"Deliver everything because staging is complete"},
    {"key":"B","text":"Coordinate delivery timing and storage requirements so equipment is not unnecessarily exposed to loss, damage, or site conditions"},
    {"key":"C","text":"Leave the equipment outside the job site"},
    {"key":"D","text":"Cancel the project shipment permanently"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Staging readiness does not automatically mean immediate delivery; logistics and site readiness also affect responsible deployment.'
),

(
  20,
  'scenario',
  'scenario',
  'You are performing the final staging review for a large installation. Which result BEST indicates the project equipment is ready for release to the field?',
  '[
    {"key":"A","text":"Most major devices are present"},
    {"key":"B","text":"Required equipment and supporting components have been reconciled to current project needs, discrepancies are resolved or clearly owned, equipment is identified for deployment, and the planned shipment supports the installation sequence"},
    {"key":"C","text":"The equipment has been moved close to the loading door"},
    {"key":"D","text":"The field team has agreed to identify any missing items later"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A production-ready staging process confirms completeness, accuracy, ownership of exceptions, identification, and alignment with field execution.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '71a65c78-ae32-4dc8-9f02-8cfe2e71de49';

  v_role_template_id uuid :=
    'cefefd09-9d5b-4a67-87a9-830180b5a016';

  v_assessment_id uuid;

  v_master_question_id uuid;

  v_assessment_question_id uuid;

  v_row record;

begin

  -- --------------------------------------------------------------------------
  -- CI industry
  -- --------------------------------------------------------------------------

  select id
  into v_industry_id

  from public.industries

  where lower(slug) = 'ci'
     or lower(name) = 'custom integration'

  order by
    case
      when lower(slug) = 'ci' then 0
      else 1
    end

  limit 1;


  if v_industry_id is null then

    raise exception
      'Custom Integration industry not found';

  end if;


  -- --------------------------------------------------------------------------
  -- Validate current Equipment Staging competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Equipment Staging'
      and c.is_current = true

  ) then

    raise exception
      'Current Equipment Staging Master Competency not found';

  end if;


  -- --------------------------------------------------------------------------
  -- Validate Technician III role
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_role_templates r

    where r.id = v_role_template_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true

  ) then

    raise exception
      'Current Technician III Master Role not found';

  end if;


  -- --------------------------------------------------------------------------
  -- Reuse current Equipment Staging competency assessment.
  -- Create it automatically if one does not exist.
  -- --------------------------------------------------------------------------

  select a.id
  into v_assessment_id

  from public.assessments a

  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.is_current = true

  order by
    a.version desc,
    a.name,
    a.id

  limit 1;


  if v_assessment_id is null then

    insert into public.assessments (
      client_id,
      industry_id,
      name,
      type,
      master_competency_template_id,
      version,
      is_current
    )

    values (
      null,
      v_industry_id,
      'Equipment Staging Competency Assessment',
      'competency',
      v_competency_id,
      1,
      true
    )

    returning id
    into v_assessment_id;

  end if;


  -- --------------------------------------------------------------------------
  -- Seed reusable Master Questions and secure answer keys.
  -- --------------------------------------------------------------------------

  for v_row in

    select *
    from _seed_equipment_staging_questions
    order by question_number

  loop

    select q.id
    into v_master_question_id

    from public.master_question_bank q

    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true

    order by
      q.version desc,
      q.id

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
        'Equipment Staging',
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

      returning id
      into v_master_question_id;

    end if;


    -- ------------------------------------------------------------------------
    -- Secure Master answer key
    -- ------------------------------------------------------------------------

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )

    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Equipment Staging L3 production assessment v1.0.',
      v_row.rationale

    where not exists (

      select 1

      from public.master_question_answer_keys k

      where k.master_question_id =
        v_master_question_id

    );


    -- ------------------------------------------------------------------------
    -- Technician III role applicability
    -- ------------------------------------------------------------------------

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


    -- ------------------------------------------------------------------------
    -- Stable assessment snapshot
    -- ------------------------------------------------------------------------

    select aq.id
    into v_assessment_question_id

    from public.assessment_questions aq

    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id =
        v_master_question_id

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
        'Equipment Staging',
        v_row.difficulty,
        false,
        false
      )

      returning id
      into v_assessment_question_id;

    end if;


    -- ------------------------------------------------------------------------
    -- Assessment-specific secure answer key
    -- ------------------------------------------------------------------------

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )

    select
      v_assessment_question_id,
      v_row.correct_answer,

      concat_ws(
        E'\n\n',
        'IntegrateU Equipment Staging L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )

    where not exists (

      select 1

      from public.assessment_question_answer_keys existing_key

      where existing_key.question_id =
        v_assessment_question_id

    );

  end loop;

end;
$$;


commit;


-- ============================================================================
-- VERIFICATION
--
-- Expected:
--   production_master_questions = 20
--   master_answer_keys          = 20
--   technician_iii_mappings     = 20
--   assessment_questions        = 20
--   assessment_answer_keys      = 20
-- ============================================================================

with competency as (

  select id, industry_id

  from public.master_competency_templates

  where id =
    '71a65c78-ae32-4dc8-9f02-8cfe2e71de49'
    and is_current = true

),

assessment as (

  select a.id

  from public.assessments a

  where a.client_id is null
    and a.master_competency_template_id =
      (select id from competency)
    and a.type = 'competency'
    and a.is_current = true

  order by
    a.version desc,
    a.name,
    a.id

  limit 1

),

production_questions as (

  select q.id

  from public.master_question_bank q

  join _seed_equipment_staging_questions s
    on s.prompt = q.prompt

  where q.industry_id =
      (select industry_id from competency)

    and q.master_competency_template_id =
      (select id from competency)

    and q.is_current = true

)

select

  (
    select count(*)
    from production_questions
  ) as production_master_questions,

  (
    select count(*)

    from public.master_question_answer_keys k

    where k.master_question_id in (
      select id
      from production_questions
    )
  ) as master_answer_keys,

  (
    select count(*)

    from public.master_question_role_applicability ra

    where ra.master_question_id in (
      select id
      from production_questions
    )

      and ra.master_role_template_id =
        'cefefd09-9d5b-4a67-87a9-830180b5a016'

  ) as technician_iii_mappings,

  (
    select count(*)

    from public.assessment_questions aq

    where aq.assessment_id =
      (select id from assessment)

      and aq.source_master_question_id in (
        select id
        from production_questions
      )

  ) as assessment_questions,

  (
    select count(*)

    from public.assessment_question_answer_keys ak

    join public.assessment_questions aq
      on aq.id = ak.question_id

    where aq.assessment_id =
      (select id from assessment)

      and aq.source_master_question_id in (
        select id
        from production_questions
      )


) as assessment_answer_keys;
