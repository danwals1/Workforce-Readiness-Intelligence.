-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0076_scheduling_resource_planning_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Scheduling & Resource Planning
--   Target level: 2 — Working Knowledge
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
--   -> Scheduling & Resource Planning competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_scheduling_resource_planning_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_scheduling_resource_planning_questions (
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
-- FOUNDATIONAL — 5
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of scheduling and resource planning?',
  '[
    {"key":"A","text":"Coordinate work, people, timing, workload, and capacity so project commitments can be executed effectively"},
    {"key":"B","text":"Keep every employee busy at all times"},
    {"key":"C","text":"Schedule projects only after materials arrive"},
    {"key":"D","text":"Assign the same number of technicians to every project"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Scheduling and resource planning align project demand with available people, time, capacity, and execution requirements.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What does resource capacity refer to?',
  '[
    {"key":"A","text":"The amount of work available people and resources can realistically support during a period"},
    {"key":"B","text":"The maximum number of projects the company has ever completed"},
    {"key":"C","text":"The size of the warehouse"},
    {"key":"D","text":"The number of clients in the CRM"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Capacity reflects the realistic amount of work that available resources can perform.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why should technician capability be considered when assigning work?',
  '[
    {"key":"A","text":"Different work may require different levels of skill, experience, or supervision"},
    {"key":"B","text":"Every technician should only perform one type of task"},
    {"key":"C","text":"Capability determines employee availability"},
    {"key":"D","text":"It eliminates the need for project planning"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Resource planning should consider whether assigned people can perform the required work at the needed level.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What is a scheduling conflict?',
  '[
    {"key":"A","text":"Two or more commitments compete for the same time, people, equipment, or other limited resource"},
    {"key":"B","text":"A project has more than one milestone"},
    {"key":"C","text":"Two technicians work on the same project"},
    {"key":"D","text":"A technician finishes early"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A scheduling conflict occurs when commitments exceed available capacity or require the same constrained resource.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'Why is workload visibility important?',
  '[
    {"key":"A","text":"It helps identify overload, unused capacity, conflicts, and upcoming resource needs"},
    {"key":"B","text":"It guarantees every project will finish early"},
    {"key":"C","text":"It eliminates schedule changes"},
    {"key":"D","text":"It replaces communication with the field team"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Visible workload allows leaders to make more informed staffing and scheduling decisions.'
),

-- ============================================================================
-- APPLICATION — 9
-- ============================================================================

(
  6,
  'multiple_choice',
  'application',
  'Two projects require the same lead technician on the same day. What is the BEST first response?',
  '[
    {"key":"A","text":"Schedule the technician on both and let the teams work it out"},
    {"key":"B","text":"Review project priorities, required capability, timing, alternatives, and impact before resolving the conflict"},
    {"key":"C","text":"Cancel the smaller project"},
    {"key":"D","text":"Assign any available technician regardless of capability"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Scheduling conflicts should be resolved using project need, capability, impact, and available alternatives.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE factors should be considered when assigning technicians to a project?',
  '[
    {"key":"A","text":"Required skills and competency"},
    {"key":"B","text":"Available capacity and existing commitments"},
    {"key":"C","text":"Project priorities and timing"},
    {"key":"D","text":"Which technician lives closest to the office regardless of need"},
    {"key":"E","text":"Which assignment is most popular"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Effective resource assignments balance capability, capacity, and project requirements.'
),

(
  8,
  'situational_judgment',
  'application',
  'A technician calls out sick on the morning of an important installation. What is the BEST response?',
  '[
    {"key":"A","text":"Keep the original plan unchanged"},
    {"key":"B","text":"Reassess required work, available resources, capability, priorities, and schedule impact, then adjust assignments or expectations"},
    {"key":"C","text":"Automatically move the entire project one week"},
    {"key":"D","text":"Ask the client to perform part of the work"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource changes should trigger deliberate replanning rather than automatic or unexamined decisions.'
),

(
  9,
  'multiple_choice',
  'application',
  'A project requires advanced programming, but the programmer is already committed to another project. What should be identified?',
  '[
    {"key":"A","text":"When the programming work is actually required, whether sequencing can change, and whether another qualified resource is available"},
    {"key":"B","text":"Only which client complained first"},
    {"key":"C","text":"Whether a technician can attempt the programming without qualification"},
    {"key":"D","text":"Whether the project can skip programming"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Resource planning considers both timing and capability so constrained expertise is used where and when it is needed.'
),

(
  10,
  'multiple_choice',
  'application',
  'Why should travel time between job sites be considered in a schedule?',
  '[
    {"key":"A","text":"Travel consumes available work capacity and affects realistic arrival and completion times"},
    {"key":"B","text":"Travel only matters for payroll"},
    {"key":"C","text":"Technicians should always be scheduled back-to-back regardless of location"},
    {"key":"D","text":"Travel is not part of operational planning"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A realistic schedule accounts for non-installation time that consumes available capacity.'
),

(
  11,
  'multiple_select',
  'application',
  'Which THREE conditions can indicate that a schedule is over capacity?',
  '[
    {"key":"A","text":"The same people are assigned to overlapping commitments"},
    {"key":"B","text":"Planned work requires more labor hours than are available"},
    {"key":"C","text":"Required skill coverage is unavailable for scheduled work"},
    {"key":"D","text":"Some employees have open time"},
    {"key":"E","text":"Projects have clearly defined ownership"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Overcapacity can appear through conflicting assignments, insufficient labor hours, or unavailable required capability.'
),

(
  12,
  'situational_judgment',
  'application',
  'A project finishes a day earlier than expected, freeing two technicians. What is the BEST response?',
  '[
    {"key":"A","text":"Send them home automatically"},
    {"key":"B","text":"Review upcoming priorities and determine whether their newly available capacity can support another productive need"},
    {"key":"C","text":"Leave the schedule unchanged"},
    {"key":"D","text":"Assign them to the next project regardless of readiness"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource plans should adapt when capacity changes, while still considering project readiness and priority.'
),

(
  13,
  'multiple_choice',
  'application',
  'A project is scheduled for three technicians, but current workload shows only two are realistically available. What should happen?',
  '[
    {"key":"A","text":"Assume the two technicians can absorb the work"},
    {"key":"B","text":"Review expected effort and project requirements, then adjust resources, timing, or commitments before execution"},
    {"key":"C","text":"Keep the schedule and avoid discussing it"},
    {"key":"D","text":"Remove quality checks to save time"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource plans should match realistic capacity rather than rely on unsupported assumptions.'
),

(
  14,
  'multiple_choice',
  'application',
  'Why should upcoming project demand be reviewed before the week begins?',
  '[
    {"key":"A","text":"It provides time to identify capacity gaps, skill needs, conflicts, and readiness issues before they become same-day emergencies"},
    {"key":"B","text":"Schedules should never change after the week begins"},
    {"key":"C","text":"It guarantees no one will call out sick"},
    {"key":"D","text":"It replaces daily project communication"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Forward-looking workload review gives leaders time to solve resource problems before work is disrupted.'
),

-- ============================================================================
-- SCENARIO — 6
-- ============================================================================

(
  15,
  'scenario',
  'scenario',
  'Three projects are scheduled for the same week. Available technician hours appear sufficient overall, but two projects require the same advanced networking technician. What is the MOST important scheduling issue?',
  '[
    {"key":"A","text":"Total labor capacity is the only factor that matters"},
    {"key":"B","text":"The required skill is a constrained resource even though total technician hours appear sufficient"},
    {"key":"C","text":"Both projects should proceed and share the technician simultaneously"},
    {"key":"D","text":"The networking work should be assigned to any available employee"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource capacity includes capability constraints, not just total available hours.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A project is behind schedule and the project manager requests two additional technicians tomorrow. Those technicians are already committed to another project. What is the BEST response?',
  '[
    {"key":"A","text":"Move them immediately to the late project"},
    {"key":"B","text":"Compare both projects'' priorities, impacts, readiness, resource needs, and alternatives before changing commitments"},
    {"key":"C","text":"Reject the request without review"},
    {"key":"D","text":"Schedule the technicians on both projects"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource changes should account for the system-wide effect rather than solving one project by unintentionally damaging another.'
),

(
  17,
  'scenario',
  'scenario',
  'The field schedule shows technicians fully booked for the next two weeks. Service requests are also arriving daily and require unpredictable response time. What is the BEST planning approach?',
  '[
    {"key":"A","text":"Book all available hours with installation projects and handle service after hours"},
    {"key":"B","text":"Recognize service demand as a capacity requirement and reserve or plan appropriate response capacity based on expected workload"},
    {"key":"C","text":"Stop scheduling installation projects"},
    {"key":"D","text":"Ignore service until someone cancels"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource planning should account for predictable categories of unplanned or variable demand rather than consuming all available capacity.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A technician is scheduled for a complex task because they are available, but they have not demonstrated the required competency. What is the BEST response?',
  '[
    {"key":"A","text":"Keep the assignment because availability is the priority"},
    {"key":"B","text":"Assign an appropriately qualified resource or provide suitable supervision and development while protecting project quality and risk"},
    {"key":"C","text":"Let the technician decide whether they feel ready"},
    {"key":"D","text":"Remove the task from the project"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Availability alone does not make a resource appropriate; capability and required support matter.'
),

(
  19,
  'scenario',
  'scenario',
  'Weekly planning shows one technician consistently overloaded while another qualified technician has unused capacity. What is the BEST action?',
  '[
    {"key":"A","text":"Leave assignments unchanged because the original schedule was already published"},
    {"key":"B","text":"Review whether appropriate work can be redistributed to balance capacity without creating new project or skill risks"},
    {"key":"C","text":"Ask the overloaded technician to work longer every week"},
    {"key":"D","text":"Give the available technician unrelated work"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource planning should use qualified available capacity where doing so improves workload balance and execution.'
),

(
  20,
  'scenario',
  'scenario',
  'Which result BEST demonstrates Level 2 Scheduling & Resource Planning?',
  '[
    {"key":"A","text":"The employee can view the schedule"},
    {"key":"B","text":"The employee understands how workload, capacity, timing, skills, and conflicts affect resource assignments and can support practical scheduling decisions"},
    {"key":"C","text":"The employee independently manages the entire company resource plan"},
    {"key":"D","text":"The employee assigns whoever is available first"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Working knowledge means understanding the key inputs and tradeoffs involved in practical schedule and resource decisions.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '4da8ddc1-2081-425e-85bc-b89c83a8c81e';

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
  -- Validate current Scheduling & Resource Planning competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Scheduling & Resource Planning'
      and c.is_current = true

  ) then

    raise exception
      'Current Scheduling & Resource Planning Master Competency not found';

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
  -- Reuse current Scheduling & Resource Planning competency assessment.
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
      'Scheduling & Resource Planning Competency Assessment',
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
    from _seed_scheduling_resource_planning_questions
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
        'Scheduling & Resource Planning',
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
      'IntegrateU Scheduling & Resource Planning L3 production assessment v1.0.',
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
        'Scheduling & Resource Planning',
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
        'IntegrateU Scheduling & Resource Planning L3 production assessment v1.0.',
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
    '4da8ddc1-2081-425e-85bc-b89c83a8c81e'
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

  join _seed_scheduling_resource_planning_questions s
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
