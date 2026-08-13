-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0064_client_training_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Client Training
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
--   -> Client Training competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_client_training_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_client_training_questions (
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
  'What is the primary goal of effective client system training?',
  '[
    {"key":"A","text":"Demonstrate every advanced feature available in the system"},
    {"key":"B","text":"Enable the client to confidently perform the tasks they need in normal use"},
    {"key":"C","text":"Show the client how technically complex the installation is"},
    {"key":"D","text":"Reduce the amount of project documentation required"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective client training focuses on the user being able to operate the system confidently for their real-world needs.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Before beginning client training, what should the trainer understand first?',
  '[
    {"key":"A","text":"The client''s expected system use, priorities, and level of familiarity"},
    {"key":"B","text":"Which technician installed the most equipment"},
    {"key":"C","text":"The total project labor hours"},
    {"key":"D","text":"Which manufacturer has the largest product catalog"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Training should be adapted to how the client will actually use the system and what they already understand.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Which approach BEST supports client understanding during system training?',
  '[
    {"key":"A","text":"Use as much technical terminology as possible"},
    {"key":"B","text":"Explain functions in clear language and connect them to how the client will use the system"},
    {"key":"C","text":"Move quickly through every menu regardless of client questions"},
    {"key":"D","text":"Avoid allowing the client to operate the system during training"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Clear language and practical context make technical information easier for an end user to understand and remember.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'Why should the client operate the system during training instead of only watching a demonstration?',
  '[
    {"key":"A","text":"It gives the trainer time to complete other project tasks"},
    {"key":"B","text":"Hands-on practice helps confirm that the client can perform the required actions independently"},
    {"key":"C","text":"It eliminates the need for system documentation"},
    {"key":"D","text":"It guarantees the client will never need support"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Client demonstration provides evidence of understanding rather than assuming understanding from observation alone.'
),


-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  5,
  'multiple_choice',
  'application',
  'A client appears comfortable using basic room controls but has difficulty changing audio sources. What is the BEST training response?',
  '[
    {"key":"A","text":"Restart the entire training session from the beginning"},
    {"key":"B","text":"Focus additional instruction and hands-on practice on source selection"},
    {"key":"C","text":"Tell the client to read the equipment manuals later"},
    {"key":"D","text":"Remove source-selection controls from the system"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective training responds to the specific area where the client needs additional understanding or practice.'
),

(
  6,
  'multiple_choice',
  'application',
  'When explaining a system feature, which sequence is generally MOST effective?',
  '[
    {"key":"A","text":"Explain the purpose, demonstrate the task, then have the client perform it"},
    {"key":"B","text":"Have the client guess how the feature works before providing any information"},
    {"key":"C","text":"Explain every engineering detail before showing the control"},
    {"key":"D","text":"Demonstrate the feature once and immediately move on"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A clear explanation followed by demonstration and client practice supports understanding and skill transfer.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE behaviors support effective client training?',
  '[
    {"key":"A","text":"Ask questions to confirm understanding"},
    {"key":"B","text":"Allow the client to practice common tasks"},
    {"key":"C","text":"Adapt explanations when the client appears confused"},
    {"key":"D","text":"Use unexplained technical jargon to demonstrate expertise"},
    {"key":"E","text":"Avoid questions until the entire presentation is finished"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Checking understanding, providing practice, and adjusting instruction are core behaviors in effective end-user training.'
),

(
  8,
  'multiple_choice',
  'application',
  'A client asks how to perform a task that can be completed through several different interfaces. What should the trainer emphasize?',
  '[
    {"key":"A","text":"Every possible method regardless of relevance"},
    {"key":"B","text":"The method that best matches the client''s normal workflow, while noting meaningful alternatives when useful"},
    {"key":"C","text":"Only the most technically complex method"},
    {"key":"D","text":"The method preferred by the installer even if the client will not use it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Training should prioritize repeatable workflows that fit how the client will actually interact with the system.'
),

(
  9,
  'situational_judgment',
  'application',
  'During training, a client repeatedly says they understand but cannot complete the demonstrated task without assistance. What is the BEST response?',
  '[
    {"key":"A","text":"Mark the training complete because the client said they understood"},
    {"key":"B","text":"Re-explain the task differently, demonstrate it again if necessary, and have the client retry"},
    {"key":"C","text":"Tell the client the system is too advanced for them"},
    {"key":"D","text":"Complete the task for the client and move on"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Observed performance is a stronger confirmation of understanding than verbal agreement alone.'
),

(
  10,
  'multiple_choice',
  'application',
  'Why should client training prioritize common everyday tasks before rarely used advanced functions?',
  '[
    {"key":"A","text":"Common tasks are most important for immediate independent use and confidence"},
    {"key":"B","text":"Advanced features should never be taught"},
    {"key":"C","text":"Every system contains too many features to document"},
    {"key":"D","text":"Clients are not permitted to use advanced functions"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Training should first build confidence around the functions the client is most likely to use regularly.'
),

(
  11,
  'multiple_select',
  'application',
  'Before concluding a client training session, which THREE items should generally be confirmed?',
  '[
    {"key":"A","text":"The client can perform key everyday functions"},
    {"key":"B","text":"Important questions or unclear items have been addressed"},
    {"key":"C","text":"The client knows how to obtain support or reference information when needed"},
    {"key":"D","text":"The client has memorized every technical specification"},
    {"key":"E","text":"The client has learned every installer-level configuration function"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Completion should confirm operational confidence, resolve important questions, and establish a clear support path.'
),


-- ============================================================================
-- SCENARIO — 9
-- ============================================================================

(
  12,
  'scenario',
  'scenario',
  'You are training a homeowner on a newly completed integrated system. After several minutes, the client looks overwhelmed and stops asking questions. What is the BEST response?',
  '[
    {"key":"A","text":"Continue at the same pace so the session stays on schedule"},
    {"key":"B","text":"Pause, check understanding, simplify the explanation, and return to the functions most important to the client"},
    {"key":"C","text":"Skip the rest of the training and send manuals"},
    {"key":"D","text":"Begin explaining the system architecture in greater technical detail"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'An effective trainer monitors the learner and adjusts pace, language, and scope when signs of overload appear.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'During training, one family member understands the system quickly while another is struggling with the controls. What should the trainer do?',
  '[
    {"key":"A","text":"Continue based only on the fastest learner"},
    {"key":"B","text":"Adapt the pace and provide additional practice so each primary user can perform the essential functions"},
    {"key":"C","text":"Ask the faster learner to conduct all future training"},
    {"key":"D","text":"Remove features until both users perform at the same speed"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Training effectiveness is based on the intended users being able to operate the system, not simply finishing the presentation.'
),

(
  14,
  'scenario',
  'scenario',
  'A client asks a technical question during training and you are not certain of the correct answer. What is the BEST response?',
  '[
    {"key":"A","text":"Give the most likely answer so the training is not interrupted"},
    {"key":"B","text":"Acknowledge that you need to verify the information, document the question, and provide an accurate follow-up"},
    {"key":"C","text":"Tell the client the question is not relevant"},
    {"key":"D","text":"Change the subject and continue training"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Professional client training requires accurate information and appropriate follow-up rather than guessing.'
),

(
  15,
  'situational_judgment',
  'scenario',
  'While training a client, you discover that a programmed scene does not behave as described in the project documentation. What should you do?',
  '[
    {"key":"A","text":"Teach the client the incorrect behavior and finish the session"},
    {"key":"B","text":"Stop presenting that function as complete, document the discrepancy, and coordinate correction before confirming the final workflow"},
    {"key":"C","text":"Tell the client the documentation is probably wrong"},
    {"key":"D","text":"Delete the scene without notifying the project team"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Client training can expose completion issues. The trainer should protect accuracy and coordinate correction rather than normalize incorrect operation.'
),

(
  16,
  'scenario',
  'scenario',
  'A commercial client has several employees who will use the system differently. The receptionist needs basic controls, while the facility manager needs additional operational functions. What is the BEST training plan?',
  '[
    {"key":"A","text":"Give everyone the exact same detailed technical training"},
    {"key":"B","text":"Train each user group on the functions relevant to its responsibilities while maintaining consistent core operating standards"},
    {"key":"C","text":"Train only the facility manager"},
    {"key":"D","text":"Give all users administrator-level access so training is simpler"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Training should be aligned with user responsibilities and expected system interaction.'
),

(
  17,
  'situational_judgment',
  'scenario',
  'Near the end of training, the client successfully completes most normal tasks but cannot remember how to recover when the wrong source is selected. What is the BEST action?',
  '[
    {"key":"A","text":"End the session because most tasks were completed"},
    {"key":"B","text":"Practice the recovery workflow until the client can return the system to normal operation"},
    {"key":"C","text":"Tell the client to call service whenever the wrong source is selected"},
    {"key":"D","text":"Remove source-selection capability from the client interface"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Client confidence includes recovering from common operating mistakes without unnecessary service intervention.'
),

(
  18,
  'scenario',
  'scenario',
  'During a client handoff, the client asks for a new automation behavior that is not part of the documented completed scope. What should the trainer do?',
  '[
    {"key":"A","text":"Promise the change immediately"},
    {"key":"B","text":"Clarify the request, explain that it needs to be reviewed for scope and system impact, and route it through the appropriate project process"},
    {"key":"C","text":"Make the programming change during training without documentation"},
    {"key":"D","text":"Tell the client changes are never permitted"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A trainer should communicate professionally while protecting scope control and the project change process.'
),

(
  19,
  'situational_judgment',
  'scenario',
  'A client can repeat the steps you demonstrated but does not understand when to use one lighting scene instead of another. What is the BEST way to improve the training?',
  '[
    {"key":"A","text":"Repeat the button names several more times"},
    {"key":"B","text":"Explain the intended use of each scene with real situations, then have the client select the appropriate scene for examples"},
    {"key":"C","text":"Explain the underlying programming code"},
    {"key":"D","text":"Remove the scene names"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Context-based practice helps a client understand not just how a feature works but when it should be used.'
),

(
  20,
  'scenario',
  'scenario',
  'You have completed system training and want to determine whether the client is ready for independent use. Which approach provides the BEST evidence?',
  '[
    {"key":"A","text":"Ask whether everything makes sense and accept yes as completion"},
    {"key":"B","text":"Have the client independently perform several key real-world tasks and address any remaining gaps"},
    {"key":"C","text":"Review the equipment list one final time"},
    {"key":"D","text":"Explain the system architecture again"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Independent demonstration of relevant tasks provides observable evidence that training has translated into usable capability.'
);


do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    'd560aef6-3b56-4af0-a936-9b36ee457113';

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
  -- Validate current Client Training competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Client Training'
      and c.is_current = true

  ) then

    raise exception
      'Current Client Training Master Competency not found';

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
  -- Reuse current Client Training competency assessment.
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
      'Client Training Competency Assessment',
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
    from _seed_client_training_questions
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
        'Client Training',
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
      'IntegrateU Client Training L3 production assessment v1.0.',
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
        'Client Training',
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
        'IntegrateU Client Training L3 production assessment v1.0.',
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
    'd560aef6-3b56-4af0-a936-9b36ee457113'
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

  join _seed_client_training_questions s
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
