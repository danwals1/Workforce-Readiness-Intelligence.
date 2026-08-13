-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0074_time_management_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Time Management
--   Target level: 4 — Advanced / Can Lead or Coach
--   Questions: 20
--
-- Mix:
--   3 foundational
--   7 application
--   10 scenario
--
-- Flow:
--   Master Question Bank
--   -> secure answer keys
--   -> Technician III role applicability
--   -> Time Management competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_time_management_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_time_management_questions (
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
-- FOUNDATIONAL — 3
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'What is a primary responsibility of a team leader during project execution?',
  '[
    {"key":"A","text":"Perform every important task personally"},
    {"key":"B","text":"Set clear expectations, coordinate work, support accountability, and help the team achieve the required result"},
    {"key":"C","text":"Allow each technician to establish their own project priorities"},
    {"key":"D","text":"Focus only on technical work and leave communication to others"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective team leadership creates clarity around expectations, priorities, ownership, standards, and execution.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Why is role clarity important when leading a field team?',
  '[
    {"key":"A","text":"It helps team members understand what they own, what outcome is expected, and how their work connects to the project"},
    {"key":"B","text":"It allows the leader to avoid monitoring progress"},
    {"key":"C","text":"It prevents technicians from asking questions"},
    {"key":"D","text":"It eliminates the need for project documentation"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Clear ownership reduces confusion, duplication, missed work, and uncertainty about accountability.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes accountability in effective team leadership?',
  '[
    {"key":"A","text":"Holding people responsible only after something goes wrong"},
    {"key":"B","text":"Making expectations clear, monitoring commitments, addressing gaps, and following through on agreed actions"},
    {"key":"C","text":"Giving the most difficult work to the strongest technician"},
    {"key":"D","text":"Avoiding corrective conversations to preserve morale"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Accountability begins with clarity and continues through follow-up, feedback, corrective action, and recognition of successful execution.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  4,
  'multiple_choice',
  'application',
  'At the beginning of the workday, the team has several competing installation tasks. What should the lead do first?',
  '[
    {"key":"A","text":"Allow technicians to select whichever tasks they prefer"},
    {"key":"B","text":"Clarify the day''s priorities, sequence, ownership, dependencies, and completion expectations"},
    {"key":"C","text":"Begin the most difficult task personally without speaking to the team"},
    {"key":"D","text":"Wait until a technician asks what to do"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The lead establishes execution clarity before work begins so the team understands priorities and dependencies.'
),

(
  5,
  'multiple_select',
  'application',
  'Which THREE behaviors help a lead maintain effective team execution?',
  '[
    {"key":"A","text":"Set clear priorities and expected outcomes"},
    {"key":"B","text":"Check progress at appropriate points"},
    {"key":"C","text":"Address blockers or performance gaps early"},
    {"key":"D","text":"Change priorities repeatedly without explaining why"},
    {"key":"E","text":"Wait until project closeout to discuss missed expectations"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Effective execution requires clarity, appropriate follow-up, and timely intervention when obstacles or gaps appear.'
),

(
  6,
  'situational_judgment',
  'application',
  'Two technicians both believe the other person is responsible for completing a rack-labeling task. What is the BEST leadership response?',
  '[
    {"key":"A","text":"Complete the labeling yourself"},
    {"key":"B","text":"Clarify ownership immediately, confirm the completion standard and deadline, and verify the handoff"},
    {"key":"C","text":"Wait to see which technician eventually does it"},
    {"key":"D","text":"Tell both technicians they are equally at fault without clarifying ownership"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The leader restores clear ownership and expectations rather than allowing ambiguity to continue.'
),

(
  7,
  'multiple_choice',
  'application',
  'A technician finishes an assigned task earlier than expected. What should the lead consider before assigning the next task?',
  '[
    {"key":"A","text":"Only whether the technician wants another task"},
    {"key":"B","text":"Whether the completed work meets the required standard and which remaining priority best supports project flow"},
    {"key":"C","text":"Whether another technician has a less desirable assignment"},
    {"key":"D","text":"Whether the lead can avoid updating the project plan"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Good leadership verifies completion before reallocating capacity to the next highest-value project need.'
),

(
  8,
  'multiple_choice',
  'application',
  'When delegating work to a less-experienced technician, what should the lead adjust?',
  '[
    {"key":"A","text":"The required quality standard"},
    {"key":"B","text":"The amount of direction, support, and follow-up based on the technician''s demonstrated capability"},
    {"key":"C","text":"The project scope"},
    {"key":"D","text":"The client''s expectations"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The performance standard stays consistent, while the amount of leadership support should reflect demonstrated capability.'
),

(
  9,
  'situational_judgment',
  'application',
  'A strong technician is completing their own work but is creating friction by dismissing questions from junior technicians. What should the lead do?',
  '[
    {"key":"A","text":"Ignore the behavior because the technician is productive"},
    {"key":"B","text":"Address the specific behavior, explain its effect on team execution and development, and establish the expected interaction standard"},
    {"key":"C","text":"Stop junior technicians from asking that employee questions"},
    {"key":"D","text":"Publicly criticize the technician during the next team meeting"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Team leadership includes reinforcing behaviors that support both individual performance and effective team execution.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE factors should influence how a lead assigns work?',
  '[
    {"key":"A","text":"Project priorities and dependencies"},
    {"key":"B","text":"The technician''s demonstrated capability"},
    {"key":"C","text":"Required quality, safety, and completion expectations"},
    {"key":"D","text":"Which technician is closest to the lead personally"},
    {"key":"E","text":"Avoiding all developmental assignments"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Work assignment should balance project needs, capability, risk, quality, safety, and appropriate development opportunities.'
),

-- ============================================================================
-- SCENARIO — 10
-- ============================================================================

(
  11,
  'scenario',
  'scenario',
  'The team arrives onsite and discovers that another trade has blocked access to several planned work areas. What is the BEST response from the lead technician?',
  '[
    {"key":"A","text":"Have the team wait until access becomes available"},
    {"key":"B","text":"Reassess available work, communicate the blocker through the appropriate channel, redirect the team to productive tasks, and update affected priorities"},
    {"key":"C","text":"Tell technicians to work around the other trade regardless of safety or sequencing"},
    {"key":"D","text":"Send everyone home immediately"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A leader manages changing field conditions by protecting productivity, communicating blockers, and adjusting execution without losing control of priorities.'
),

(
  12,
  'situational_judgment',
  'scenario',
  'A technician repeatedly says a task is complete, but your quality checks continue to find missing details. What is the BEST leadership response?',
  '[
    {"key":"A","text":"Continue correcting the missing details yourself"},
    {"key":"B","text":"Re-establish the definition of done, require the technician to verify their own work against it, and follow up until consistent completion is demonstrated"},
    {"key":"C","text":"Stop checking the technician''s work"},
    {"key":"D","text":"Accept partial completion to avoid conflict"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The leader should strengthen ownership of the completion standard rather than becoming the permanent final checker for preventable omissions.'
),

(
  13,
  'scenario',
  'scenario',
  'Midway through the day, the project manager changes the priority of two work areas because another trade needs access. What should the lead do?',
  '[
    {"key":"A","text":"Keep the original plan because the technicians already understand it"},
    {"key":"B","text":"Confirm the changed priority, determine its effect on sequencing and resources, clearly communicate the new plan to the team, and verify understanding"},
    {"key":"C","text":"Tell technicians only when they reach the affected area"},
    {"key":"D","text":"Allow each technician to decide whether the change applies to them"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'When priorities change, the lead translates that change into a clear execution plan for the field team.'
),

(
  14,
  'situational_judgment',
  'scenario',
  'Two technicians disagree about the correct installation method and the disagreement is starting to disrupt the team. What is the BEST leadership response?',
  '[
    {"key":"A","text":"Let them continue debating until one gives up"},
    {"key":"B","text":"Bring the discussion back to drawings, standards, manufacturer requirements, or the appropriate technical authority, decide the path forward, and reset team focus"},
    {"key":"C","text":"Choose the method proposed by the more senior employee without reviewing the issue"},
    {"key":"D","text":"Separate the technicians permanently"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The leader resolves execution disagreements through standards and evidence, then restores productive team focus.'
),

(
  15,
  'scenario',
  'scenario',
  'One technician is falling behind while another has completed their assigned work ahead of schedule. What is the BEST leadership decision?',
  '[
    {"key":"A","text":"Leave both assignments unchanged because changing work is unfair"},
    {"key":"B","text":"Verify the completed work, assess the delayed task, and reallocate support if doing so improves project flow without creating new risk"},
    {"key":"C","text":"Tell the delayed technician to work faster"},
    {"key":"D","text":"Give the available technician an unrelated low-priority task"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Resource allocation should respond to current project conditions and protect overall flow rather than rigidly preserve an outdated assignment plan.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A technician tells you privately that another team member regularly leaves unfinished work for others to complete. What is the BEST first response?',
  '[
    {"key":"A","text":"Immediately confront the accused technician in front of the team"},
    {"key":"B","text":"Gather specific facts and examples, review expectations and ownership, then address the behavior directly based on evidence"},
    {"key":"C","text":"Assume the complaint is accurate and change all assignments"},
    {"key":"D","text":"Ignore the concern because team members should solve it themselves"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Strong leaders investigate specific observable behavior before taking corrective action and then address accountability directly.'
),

(
  17,
  'scenario',
  'scenario',
  'The team is under significant schedule pressure, and a technician proposes skipping a required testing step to save time. What should the lead do?',
  '[
    {"key":"A","text":"Allow it if the technician is experienced"},
    {"key":"B","text":"Reinforce the required completion standard, keep the testing step, and look for schedule improvements that do not compromise quality or safety"},
    {"key":"C","text":"Skip testing only on devices that appear to work"},
    {"key":"D","text":"Tell the technician to make the decision independently"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Leadership under pressure means protecting required standards while finding legitimate ways to improve execution.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A junior technician asks for help while you are working on a critical task. Their issue is important but not an immediate safety or project emergency. What is the BEST response?',
  '[
    {"key":"A","text":"Drop the critical task immediately regardless of consequence"},
    {"key":"B","text":"Acknowledge the request, determine urgency, give enough direction to keep the technician productive or safe, and establish when you will follow up"},
    {"key":"C","text":"Tell the technician never to interrupt you"},
    {"key":"D","text":"Solve the technician''s entire task for them"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A lead balances competing priorities while ensuring team members have enough clarity and support to continue productive execution.'
),

(
  19,
  'scenario',
  'scenario',
  'At the end of the day, several planned tasks remain unfinished. What is the BEST leadership action before the team leaves?',
  '[
    {"key":"A","text":"Leave the remaining work undocumented and address it tomorrow"},
    {"key":"B","text":"Confirm actual completion status, identify blockers and outstanding work, secure the site, communicate necessary updates, and establish the next priorities"},
    {"key":"C","text":"Mark all planned tasks complete because the workday is over"},
    {"key":"D","text":"Ask each technician to remember their remaining tasks"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The lead closes the day with accurate status, documented outstanding work, appropriate communication, and clear continuation priorities.'
),

(
  20,
  'situational_judgment',
  'scenario',
  'You are determining whether a technician is ready to lead a small field assignment. Which evidence provides the BEST basis for that decision?',
  '[
    {"key":"A","text":"They are the most senior technician available"},
    {"key":"B","text":"They consistently demonstrate technical execution, communication, ownership, prioritization, quality control, and appropriate coordination with others"},
    {"key":"C","text":"They have asked to become a lead"},
    {"key":"D","text":"They can complete one difficult technical task faster than the rest of the team"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Leadership readiness requires more than technical skill; it requires repeatable ownership of people, priorities, communication, standards, and execution.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    'b103d386-dc2c-4961-9c91-5629bf47b899';

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
  -- Validate current Time Management competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Time Management'
      and c.is_current = true

  ) then

    raise exception
      'Current Time Management Master Competency not found';

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
  -- Reuse current Time Management competency assessment.
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
      'Time Management Competency Assessment',
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
    from _seed_time_management_questions
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
        'Time Management',
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
      'IntegrateU Time Management L4 production assessment v1.0.',
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
        'Time Management',
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
        'IntegrateU Time Management L4 production assessment v1.0.',
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
    'b103d386-dc2c-4961-9c91-5629bf47b899'
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

  join _seed_time_management_questions s
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
