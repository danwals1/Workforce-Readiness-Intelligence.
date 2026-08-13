-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0067_cross_department_coordination_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Cross-Department Coordination
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
--   -> Cross-Department Coordination competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_cross_department_coordination_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_cross_department_coordination_questions (
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
  'What is the primary purpose of cross-department coordination?',
  '[
    {"key":"A","text":"Allow each department to work independently without sharing information"},
    {"key":"B","text":"Ensure information, priorities, handoffs, and dependencies are aligned across teams"},
    {"key":"C","text":"Move all project decisions to one department"},
    {"key":"D","text":"Reduce the amount of documentation used on projects"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Cross-department coordination keeps work aligned across functions so dependencies, ownership, and project flow remain clear.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What is a handoff between departments?',
  '[
    {"key":"A","text":"A transfer of responsibility, information, or work from one function to another"},
    {"key":"B","text":"A request to stop project work"},
    {"key":"C","text":"A replacement for project documentation"},
    {"key":"D","text":"A financial approval process only"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A handoff occurs when work, ownership, or information moves from one department or function to another.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why are clear handoff expectations important?',
  '[
    {"key":"A","text":"They help prevent missing information, duplicated effort, delays, and ownership confusion"},
    {"key":"B","text":"They eliminate the need for communication"},
    {"key":"C","text":"They allow departments to ignore downstream needs"},
    {"key":"D","text":"They ensure every department uses the same job title"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Clear handoffs reduce ambiguity and help the receiving team start work with the information and conditions required for execution.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'When a project issue affects another department, what should happen?',
  '[
    {"key":"A","text":"The issue should be communicated through the appropriate process with enough information for the affected team to respond"},
    {"key":"B","text":"The issue should remain within the department that discovered it"},
    {"key":"C","text":"The team should wait until project closeout to mention it"},
    {"key":"D","text":"The issue should only be discussed verbally and never documented"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Coordination requires timely communication when another team''s work, decision, or schedule may be affected.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  5,
  'multiple_choice',
  'application',
  'The field team discovers that equipment needed for tomorrow''s installation has not arrived. What is the BEST first coordination action?',
  '[
    {"key":"A","text":"Wait until tomorrow morning to see whether the equipment arrives"},
    {"key":"B","text":"Notify the appropriate project or logistics owner, confirm the missing items and impact, and coordinate the next action"},
    {"key":"C","text":"Order replacement equipment without checking project ownership"},
    {"key":"D","text":"Tell the client the project will definitely be delayed"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The field team should communicate the specific issue and likely impact to the function responsible for procurement, logistics, or project coordination.'
),

(
  6,
  'multiple_select',
  'application',
  'Which THREE items are especially important in a strong departmental handoff?',
  '[
    {"key":"A","text":"Current status"},
    {"key":"B","text":"Outstanding actions or risks"},
    {"key":"C","text":"Clear ownership of the next step"},
    {"key":"D","text":"Unrelated historical project details"},
    {"key":"E","text":"Personal opinions about another department"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'A useful handoff gives the receiving team the current state, unresolved items, and ownership needed to continue execution.'
),

(
  7,
  'situational_judgment',
  'application',
  'Sales promised a client feature that the field team believes is not included in the documented scope. What is the BEST response?',
  '[
    {"key":"A","text":"Tell the client Sales made a mistake"},
    {"key":"B","text":"Verify the documented scope and coordinate with the appropriate sales or project owner before changing the work"},
    {"key":"C","text":"Add the feature immediately without documentation"},
    {"key":"D","text":"Ignore the client request"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The field team should avoid blame or unauthorized scope changes and coordinate the discrepancy through the responsible functions.'
),

(
  8,
  'multiple_choice',
  'application',
  'A project manager asks the field team for an updated completion estimate. What information is MOST useful?',
  '[
    {"key":"A","text":"Only how hard the team has been working"},
    {"key":"B","text":"Completed work, remaining work, blockers, resource needs, and a realistic estimate based on current conditions"},
    {"key":"C","text":"A guess that matches the original schedule"},
    {"key":"D","text":"The names of every technician who has worked on the project"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Cross-department decisions improve when status updates contain factual progress, remaining scope, blockers, and realistic timing.'
),

(
  9,
  'situational_judgment',
  'application',
  'The warehouse stages equipment for a project, but the field lead notices that several devices do not match the latest project documentation. What should happen?',
  '[
    {"key":"A","text":"Install the staged devices because they are already onsite"},
    {"key":"B","text":"Stop the affected work, verify the current documentation, and coordinate the discrepancy with the project and logistics owners"},
    {"key":"C","text":"Return all equipment without notifying anyone"},
    {"key":"D","text":"Change the project documentation to match the staged equipment"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The discrepancy should be resolved using current documentation and the responsible project/logistics functions before installation continues.'
),

(
  10,
  'multiple_choice',
  'application',
  'When communicating a blocker to another department, which approach is MOST effective?',
  '[
    {"key":"A","text":"State that there is a problem and wait for them to investigate"},
    {"key":"B","text":"Describe the specific issue, what is affected, what has already been checked, the likely impact, and what decision or action is needed"},
    {"key":"C","text":"Send only a photo without explanation"},
    {"key":"D","text":"Copy as many people as possible without identifying ownership"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Actionable communication gives the receiving team enough context to make a decision or take the next step efficiently.'
),

(
  11,
  'multiple_select',
  'application',
  'Which THREE situations commonly require cross-department coordination from a lead technician?',
  '[
    {"key":"A","text":"A scope discrepancy affecting installation"},
    {"key":"B","text":"Missing or incorrect project equipment"},
    {"key":"C","text":"A schedule or site-condition change affecting project sequencing"},
    {"key":"D","text":"A technician choosing where to eat lunch"},
    {"key":"E","text":"A personal preference about tool brands"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Scope, materials, schedule, and site changes commonly affect multiple functions and require coordinated action.'
),

-- ============================================================================
-- SCENARIO — 9
-- ============================================================================

(
  12,
  'scenario',
  'scenario',
  'The field team is ready to begin installation, but the programming team says they do not have the latest device configuration information. What is the BEST response?',
  '[
    {"key":"A","text":"Tell programming to figure it out from the equipment onsite"},
    {"key":"B","text":"Identify what information is missing, determine who owns it, coordinate delivery of the current information, and confirm whether field sequencing needs to change"},
    {"key":"C","text":"Continue all work and assume programming will catch up later"},
    {"key":"D","text":"Create new configuration information without checking the design"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The lead should help close the information gap and understand the impact on both field and programming workflow.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'A client requests an installation change onsite that will affect equipment, labor, and programming. What is the BEST coordination response?',
  '[
    {"key":"A","text":"Approve the change if it seems technically possible"},
    {"key":"B","text":"Clarify the request, document it, and coordinate with the appropriate project or sales owner before changing scope"},
    {"key":"C","text":"Tell the client to contact each department separately"},
    {"key":"D","text":"Make the change and notify the office after completion"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Changes with scope, labor, material, or programming impact require coordinated review before execution.'
),

(
  14,
  'scenario',
  'scenario',
  'A shipment arrives with a backordered device that affects only one room. The rest of the project can continue. What is the BEST coordination approach?',
  '[
    {"key":"A","text":"Stop the entire project until the device arrives"},
    {"key":"B","text":"Communicate the affected scope, coordinate the expected delivery and return plan, and resequence unaffected work where possible"},
    {"key":"C","text":"Mark the missing device complete"},
    {"key":"D","text":"Install a different device without approval"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Good coordination isolates the affected dependency while protecting productive work elsewhere on the project.'
),

(
  15,
  'situational_judgment',
  'scenario',
  'The project manager believes a room is complete, but the lead technician knows testing and documentation are still outstanding. What should the lead do?',
  '[
    {"key":"A","text":"Allow the status to remain complete because installation is physically finished"},
    {"key":"B","text":"Correct the status, explain the remaining completion requirements, and coordinate the outstanding work before final sign-off"},
    {"key":"C","text":"Complete the documentation later without changing status"},
    {"key":"D","text":"Tell the technicians not to discuss the issue"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Accurate project status is essential for downstream planning, client communication, invoicing, and closeout.'
),

(
  16,
  'scenario',
  'scenario',
  'The service department receives a client issue shortly after project completion, but the service technician does not have the final programming notes or device documentation. What would have BEST prevented this problem?',
  '[
    {"key":"A","text":"The service technician should have been part of every installation day"},
    {"key":"B","text":"A complete project-to-service handoff containing current documentation, configuration information, known issues, and support expectations"},
    {"key":"C","text":"The client should remember how the system was installed"},
    {"key":"D","text":"The project manager should personally handle all future service"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A structured closeout handoff gives service the information required to support the installed system efficiently.'
),

(
  17,
  'situational_judgment',
  'scenario',
  'A field lead learns that a major schedule change was discussed in an office meeting but never communicated to the installation team. What is the BEST next step?',
  '[
    {"key":"A","text":"Continue using the old schedule until someone officially complains"},
    {"key":"B","text":"Confirm the current approved schedule, assess the impact on field work, communicate the updated priorities to the team, and clarify how future changes should be handed off"},
    {"key":"C","text":"Tell the technicians that the office cannot be trusted"},
    {"key":"D","text":"Create an independent field schedule without coordination"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The immediate problem should be corrected while also improving the communication path that allowed the handoff failure.'
),

(
  18,
  'scenario',
  'scenario',
  'A project requires coordination between installation and an electrician. The electrician needs device-location confirmation before completing their work. What should the lead technician do?',
  '[
    {"key":"A","text":"Assume the electrician already has the correct information"},
    {"key":"B","text":"Verify the approved location information, communicate it through the established project channel, and confirm any dependencies that affect sequencing"},
    {"key":"C","text":"Tell the electrician to choose the locations"},
    {"key":"D","text":"Wait until installation begins to discuss locations"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Coordination with external trades follows the same principles of verified information, clear ownership, and dependency management.'
),

(
  19,
  'situational_judgment',
  'scenario',
  'A technician identifies a recurring installation issue that appears to originate in the design documentation. What is the BEST response from the lead?',
  '[
    {"key":"A","text":"Teach the technicians to work around the issue on every project"},
    {"key":"B","text":"Document specific examples, communicate the pattern to the design or project team, and collaborate on a correction that prevents recurrence"},
    {"key":"C","text":"Change the drawings independently"},
    {"key":"D","text":"Ignore the pattern because the field team can fix it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Cross-department coordination should not only resolve current issues but also feed recurring problems back to the function that can eliminate the root cause.'
),

(
  20,
  'scenario',
  'scenario',
  'You are handing a nearly completed project from installation to project management for final closeout. Which handoff is BEST?',
  '[
    {"key":"A","text":"Tell the project manager that the job is basically done"},
    {"key":"B","text":"Provide confirmed completion status, remaining punch items, testing results, documentation status, client issues, dependencies, and clear ownership of each outstanding action"},
    {"key":"C","text":"Send only the technician time sheets"},
    {"key":"D","text":"Wait for the project manager to discover outstanding items during the final walkthrough"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A strong closeout handoff gives the next function a complete and accurate picture of status, risk, and ownership.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '53386515-b536-4c8e-8a89-d1ff275e6121';

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
  -- Validate current Cross-Department Coordination competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Cross-Department Coordination'
      and c.is_current = true

  ) then

    raise exception
      'Current Cross-Department Coordination Master Competency not found';

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
  -- Reuse current Cross-Department Coordination competency assessment.
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
      'Cross-Department Coordination Competency Assessment',
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
    from _seed_cross_department_coordination_questions
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
        'Cross-Department Coordination',
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
      'IntegrateU Cross-Department Coordination L3 production assessment v1.0.',
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
        'Cross-Department Coordination',
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
        'IntegrateU Cross-Department Coordination L3 production assessment v1.0.',
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
    '53386515-b536-4c8e-8a89-d1ff275e6121'
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

  join _seed_cross_department_coordination_questions s
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
