-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0065_coaching_development_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Coaching & Development
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
--   -> Coaching & Development competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_coaching_development_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_coaching_development_questions (
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
  'What is the primary purpose of coaching and development in a field team?',
  '[
    {"key":"A","text":"Complete difficult work for less-experienced employees"},
    {"key":"B","text":"Build capability so employees can perform required work more independently and consistently"},
    {"key":"C","text":"Reduce the need to explain performance expectations"},
    {"key":"D","text":"Keep all technical decisions with the most senior technician"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Coaching develops capability through instruction, practice, feedback, and evaluation so performance improves over time.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Which coaching sequence BEST supports skill development?',
  '[
    {"key":"A","text":"Assign the task, wait for failure, then correct the employee"},
    {"key":"B","text":"Explain the expected outcome, demonstrate as needed, provide guided practice, observe performance, and give feedback"},
    {"key":"C","text":"Explain the task once and avoid further involvement"},
    {"key":"D","text":"Have the employee watch indefinitely before allowing practice"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective coaching moves from clear expectations and modeling into guided practice, observation, feedback, and increasing independence.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What makes coaching feedback most useful?',
  '[
    {"key":"A","text":"It focuses on observable behavior and connects that behavior to the expected standard or result"},
    {"key":"B","text":"It focuses mainly on the employee''s personality"},
    {"key":"C","text":"It is delayed until the end of the project whenever possible"},
    {"key":"D","text":"It avoids specific examples so the employee does not feel singled out"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Specific, behavior-based feedback gives the employee a clear connection between what happened, the expected standard, and what to do next.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  4,
  'multiple_choice',
  'application',
  'A technician understands the correct cable-labeling standard but continues to skip labels when the team is under time pressure. What should the coach address first?',
  '[
    {"key":"A","text":"Whether the technician knows the standard and why consistent execution is still required under schedule pressure"},
    {"key":"B","text":"Whether a different labeling system should be created for that technician"},
    {"key":"C","text":"Whether the technician should stop working on projects entirely"},
    {"key":"D","text":"Whether labels can be eliminated from future projects"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'The coach should distinguish between a knowledge gap and an execution or accountability gap, then coach the specific cause.'
),

(
  5,
  'multiple_select',
  'application',
  'Which THREE actions are appropriate when coaching a technician on a new field skill?',
  '[
    {"key":"A","text":"State the expected result and quality standard"},
    {"key":"B","text":"Provide an opportunity for the technician to perform the task"},
    {"key":"C","text":"Observe the work and provide specific feedback"},
    {"key":"D","text":"Take over immediately whenever the technician works more slowly than the lead"},
    {"key":"E","text":"Avoid checking the finished work so the technician feels trusted"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Clear standards, practice, observation, and feedback are core elements of skill development.'
),

(
  6,
  'situational_judgment',
  'application',
  'A technician makes the same termination mistake twice after receiving instruction. What is the BEST coaching response?',
  '[
    {"key":"A","text":"Repeat the same explanation louder"},
    {"key":"B","text":"Observe the technician perform the task, identify where the process breaks down, correct that step, and have the technician retry"},
    {"key":"C","text":"Finish all future terminations for the technician"},
    {"key":"D","text":"Assume the technician is not capable of learning the skill"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Direct observation helps identify whether the issue is understanding, technique, sequencing, attention, or another correctable factor.'
),

(
  7,
  'multiple_choice',
  'application',
  'When should a coach increase an employee''s independence on a task?',
  '[
    {"key":"A","text":"After the employee demonstrates the task consistently at the required standard"},
    {"key":"B","text":"Immediately after the employee watches one demonstration"},
    {"key":"C","text":"Only after the employee has worked for the company for a full year"},
    {"key":"D","text":"Whenever the coach becomes busy, regardless of performance"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Independence should increase based on demonstrated competence and consistency.'
),

(
  8,
  'multiple_choice',
  'application',
  'A technician completed a task correctly but used an inefficient sequence that created unnecessary rework risk. What is the BEST feedback?',
  '[
    {"key":"A","text":"Say only that the task was correct"},
    {"key":"B","text":"Recognize the correct result, explain the more reliable sequence, and have the technician apply it on the next task"},
    {"key":"C","text":"Redo the task without explanation"},
    {"key":"D","text":"Wait until the employee''s annual review to discuss it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Good coaching reinforces what worked while identifying the specific process improvement needed for repeatability and efficiency.'
),

(
  9,
  'situational_judgment',
  'application',
  'A high-performing technician resists feedback because they believe their results prove their method is acceptable. What is the BEST coaching approach?',
  '[
    {"key":"A","text":"Avoid the conversation because the technician produces good work"},
    {"key":"B","text":"Connect the feedback to the required standard, team consistency, risk, or downstream impact and discuss the specific behavior"},
    {"key":"C","text":"Tell the technician that seniority is the only reason they must comply"},
    {"key":"D","text":"Publicly correct the technician in front of the team"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Experienced employees still need alignment to team standards. Coaching should remain focused on observable behavior and performance impact.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE pieces of information help a coach decide the next development step for an employee?',
  '[
    {"key":"A","text":"The required performance standard"},
    {"key":"B","text":"Observed current performance"},
    {"key":"C","text":"The specific gap between current and required performance"},
    {"key":"D","text":"The employee''s job title alone"},
    {"key":"E","text":"How quickly the coach personally performs the task"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Development decisions should be based on the required standard, observed capability, and the specific gap to close.'
),

-- ============================================================================
-- SCENARIO — 10
-- ============================================================================

(
  11,
  'scenario',
  'scenario',
  'A Technician I is learning to terminate category cable. They understand the steps but work slowly and repeatedly ask the lead to confirm each action. What is the BEST development approach?',
  '[
    {"key":"A","text":"Take over the work so the project stays on pace"},
    {"key":"B","text":"Set a clear quality standard, let the technician complete a defined set of terminations, inspect the results, and gradually reduce check-ins as consistency improves"},
    {"key":"C","text":"Tell the technician to stop asking questions"},
    {"key":"D","text":"Assign only cleanup work until they become faster"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The technician needs supported repetition and progressively greater independence while quality remains controlled.'
),

(
  12,
  'situational_judgment',
  'scenario',
  'A technician completes assigned work correctly when directly supervised but quality drops when the lead leaves the area. What should the lead coach?',
  '[
    {"key":"A","text":"Only the technical steps of the task"},
    {"key":"B","text":"The expectation for independent adherence to standards, then verify performance through planned follow-up checks"},
    {"key":"C","text":"That the lead will remain beside them for every future task"},
    {"key":"D","text":"That speed is more important than quality when unsupervised"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The development gap is independent execution and accountability, not merely task knowledge.'
),

(
  13,
  'scenario',
  'scenario',
  'A normally reliable technician has recently missed several completion details. During the coaching conversation, they explain that they are unclear about changing project priorities. What is the BEST next action?',
  '[
    {"key":"A","text":"Treat the issue only as poor attitude"},
    {"key":"B","text":"Clarify priorities and completion expectations, confirm understanding, and establish a check-in method until performance stabilizes"},
    {"key":"C","text":"Remove all responsibility from the technician permanently"},
    {"key":"D","text":"Ignore the explanation and issue the same instruction again"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Coaching should address the actual cause of the gap. If priorities are unclear, restore clarity and then verify execution.'
),

(
  14,
  'situational_judgment',
  'scenario',
  'Two technicians make different mistakes while installing the same type of device. One misunderstood the drawing; the other rushed and skipped the drawing. Should they receive the same coaching?',
  '[
    {"key":"A","text":"Yes, because the final mistake occurred on the same device"},
    {"key":"B","text":"No. The first needs help interpreting the documentation, while the second needs coaching on process discipline and adherence to the required workflow"},
    {"key":"C","text":"Yes, both should simply be told to work more carefully"},
    {"key":"D","text":"No. Neither should receive coaching until project closeout"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective coaching targets the cause of the performance gap rather than treating similar outcomes as identical problems.'
),

(
  15,
  'scenario',
  'scenario',
  'A technician is ready to learn a more advanced commissioning task, but the project schedule is tight. What is the BEST lead-technician decision?',
  '[
    {"key":"A","text":"Never allow development during active projects"},
    {"key":"B","text":"Select an appropriate portion of the task for supervised practice where quality and schedule risk can be controlled"},
    {"key":"C","text":"Give the technician the entire commissioning responsibility without oversight"},
    {"key":"D","text":"Wait indefinitely for a project with no schedule pressure"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Strong leaders create controlled development opportunities while managing project risk and required quality.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A technician becomes defensive after receiving corrective feedback and says, "That''s not how I was taught before." What is the BEST response?',
  '[
    {"key":"A","text":"End the conversation immediately"},
    {"key":"B","text":"Acknowledge the concern, restate the current required standard, explain why it matters, and confirm the expected behavior going forward"},
    {"key":"C","text":"Tell the technician their previous trainer was wrong"},
    {"key":"D","text":"Allow each technician to choose whichever standard they prefer"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Keep the conversation focused on the current required standard and future performance rather than arguing about past trainers.'
),

(
  17,
  'scenario',
  'scenario',
  'After several coaching sessions, a technician still cannot perform a required task independently. What should the lead do next?',
  '[
    {"key":"A","text":"Continue repeating the same coaching indefinitely without changing the approach"},
    {"key":"B","text":"Document the observed gap, determine whether more training, a different development method, additional supervision, or escalation is required, and align with the appropriate manager"},
    {"key":"C","text":"Mark the competency complete to maintain morale"},
    {"key":"D","text":"Stop documenting the issue"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'When coaching does not close a required gap, evidence should drive a changed development approach or appropriate escalation.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A skilled technician can perform advanced troubleshooting but struggles to explain their reasoning to junior technicians. What development would BEST prepare them to coach others?',
  '[
    {"key":"A","text":"Give them more troubleshooting work without any teaching responsibility"},
    {"key":"B","text":"Have them practice explaining the diagnostic sequence, ask the learner questions, observe the learner performing the process, and provide feedback on both technical and coaching effectiveness"},
    {"key":"C","text":"Tell junior technicians to watch silently"},
    {"key":"D","text":"Assume strong technical skill automatically means strong coaching skill"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Technical expertise and coaching ability are different capabilities; coaching requires explanation, questioning, observation, and feedback.'
),

(
  19,
  'scenario',
  'scenario',
  'A junior technician makes a mistake that could have been prevented by checking the drawing before installation. The error has been corrected. What is the BEST coaching follow-up?',
  '[
    {"key":"A","text":"Focus only on the cost of the mistake"},
    {"key":"B","text":"Review the decision point where the drawing should have been checked, have the technician explain the correct process, and verify that process on the next similar task"},
    {"key":"C","text":"Tell the technician to be more careful next time and end the conversation"},
    {"key":"D","text":"Prevent the technician from using drawings in the future"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The strongest follow-up reinforces the correct process and verifies transfer on the next relevant task.'
),

(
  20,
  'situational_judgment',
  'scenario',
  'You are evaluating whether a technician has completed a development milestone. Which evidence BEST supports sign-off?',
  '[
    {"key":"A","text":"The technician says they feel comfortable with the task"},
    {"key":"B","text":"The technician has independently demonstrated the task at the required quality standard across appropriate observations"},
    {"key":"C","text":"The technician attended a training session about the task"},
    {"key":"D","text":"Another employee believes the technician will probably be able to do it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Development sign-off should be based on demonstrated performance against the required standard rather than attendance, confidence, or assumptions.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '4561c874-e2d4-4893-b09b-43ad1e2be929';

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
  -- Validate current Coaching & Development competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Coaching & Development'
      and c.is_current = true

  ) then

    raise exception
      'Current Coaching & Development Master Competency not found';

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
  -- Reuse current Coaching & Development competency assessment.
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
      'Coaching & Development Competency Assessment',
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
    from _seed_coaching_development_questions
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
        'Coaching & Development',
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
      'IntegrateU Coaching & Development L4 production assessment v1.0.',
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
        'Coaching & Development',
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
        'IntegrateU Coaching & Development L4 production assessment v1.0.',
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
    '4561c874-e2d4-4893-b09b-43ad1e2be929'
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

  join _seed_coaching_development_questions s
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
