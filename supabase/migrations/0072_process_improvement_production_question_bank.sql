-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0072_process_improvement_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Process Improvement
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
--   -> Process Improvement competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_process_improvement_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_process_improvement_questions (
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
  'What is the primary goal of process improvement?',
  '[
    {"key":"A","text":"Make work more repeatable, efficient, reliable, and effective"},
    {"key":"B","text":"Change procedures as often as possible"},
    {"key":"C","text":"Reduce documentation regardless of impact"},
    {"key":"D","text":"Make every employee perform work differently"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Process improvement focuses on creating better, more consistent outcomes through stronger workflows and operating practices.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What is a bottleneck in a workflow?',
  '[
    {"key":"A","text":"A point that limits flow or causes work to wait, slow down, or accumulate"},
    {"key":"B","text":"The final completed step in a process"},
    {"key":"C","text":"Any task performed by more than one person"},
    {"key":"D","text":"A project with a high selling price"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A bottleneck constrains overall workflow performance and can create delays or work buildup.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What is a root cause?',
  '[
    {"key":"A","text":"An underlying reason a problem occurs rather than only the visible symptom"},
    {"key":"B","text":"The first person who reports a problem"},
    {"key":"C","text":"The most expensive part of a project"},
    {"key":"D","text":"Any issue that happens more than once"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Root-cause thinking looks beyond the symptom to identify what is actually creating the recurring problem.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'Why is standardization useful in a repeatable process?',
  '[
    {"key":"A","text":"It creates a consistent expected method or outcome that can be taught, measured, and improved"},
    {"key":"B","text":"It prevents all future problems"},
    {"key":"C","text":"It eliminates employee judgment in every situation"},
    {"key":"D","text":"It allows teams to ignore quality differences"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Standardization creates a stable baseline from which quality, efficiency, and performance can be evaluated.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'Why should recurring problems be documented?',
  '[
    {"key":"A","text":"Patterns are easier to identify and improve when specific examples and impacts are visible"},
    {"key":"B","text":"Documentation automatically fixes the problem"},
    {"key":"C","text":"Every small issue requires a new company policy"},
    {"key":"D","text":"It prevents employees from suggesting solutions"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Specific evidence helps teams distinguish isolated events from recurring process problems.'
),

-- ============================================================================
-- APPLICATION — 9
-- ============================================================================

(
  6,
  'multiple_choice',
  'application',
  'Technicians repeatedly arrive onsite without one small but necessary installation item. What is the BEST process-improvement response?',
  '[
    {"key":"A","text":"Tell technicians to remember better"},
    {"key":"B","text":"Identify where the readiness process is failing and improve the checklist, staging, or verification step that should prevent the omission"},
    {"key":"C","text":"Keep extra materials in every technician vehicle regardless of need"},
    {"key":"D","text":"Accept the extra warehouse trips as normal"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A recurring problem is better addressed by strengthening the process that should prevent it rather than repeatedly correcting the symptom.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE signals can indicate a process may need improvement?',
  '[
    {"key":"A","text":"Recurring errors or rework"},
    {"key":"B","text":"Frequent waiting or handoff delays"},
    {"key":"C","text":"Repeated confusion about ownership or next steps"},
    {"key":"D","text":"A process consistently producing the required result"},
    {"key":"E","text":"A task being completed correctly and on time"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Recurring defects, delays, and ownership confusion are common signs of a process problem.'
),

(
  8,
  'multiple_choice',
  'application',
  'A project handoff regularly takes too long because the receiving team must ask several follow-up questions. What should be examined?',
  '[
    {"key":"A","text":"Whether the handoff standard contains the information the receiving team actually needs"},
    {"key":"B","text":"Whether the receiving team should stop asking questions"},
    {"key":"C","text":"Whether fewer people should know project details"},
    {"key":"D","text":"Whether the project should skip the handoff entirely"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Repeated follow-up questions can indicate that the handoff process does not consistently provide required information.'
),

(
  9,
  'situational_judgment',
  'application',
  'A technician suggests changing a checklist because one step seems unnecessary. What is the BEST response?',
  '[
    {"key":"A","text":"Delete the step immediately"},
    {"key":"B","text":"Understand why the step exists, review evidence and impact, and change the process only if the revised approach still protects the required outcome"},
    {"key":"C","text":"Never change established processes"},
    {"key":"D","text":"Allow each technician to decide whether to use the step"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Process changes should be deliberate and preserve the purpose, quality, safety, or control the original step was intended to provide.'
),

(
  10,
  'multiple_choice',
  'application',
  'A recurring issue is being discussed, but everyone has a different explanation for why it happens. What is the BEST next step?',
  '[
    {"key":"A","text":"Choose the explanation from the most senior person"},
    {"key":"B","text":"Gather specific examples and evidence from the actual workflow before deciding on the cause"},
    {"key":"C","text":"Create a new policy immediately"},
    {"key":"D","text":"Stop discussing the issue"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Evidence should guide root-cause analysis rather than assumptions or hierarchy.'
),

(
  11,
  'multiple_select',
  'application',
  'Which THREE questions help identify the root cause of a recurring workflow problem?',
  '[
    {"key":"A","text":"Where in the process does the problem first appear?"},
    {"key":"B","text":"What conditions are consistently present when it occurs?"},
    {"key":"C","text":"What process step should have prevented or detected it?"},
    {"key":"D","text":"Who should be blamed for the problem?"},
    {"key":"E","text":"How can we avoid measuring the issue?"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Root-cause analysis focuses on where, when, why, and how the process allows the problem to occur.'
),

(
  12,
  'multiple_choice',
  'application',
  'A new process change reduces installation time but creates more callbacks. Is the change successful?',
  '[
    {"key":"A","text":"Yes, because installation is faster"},
    {"key":"B","text":"Not necessarily; process improvement should consider quality and downstream impact as well as speed"},
    {"key":"C","text":"Yes, if technicians prefer it"},
    {"key":"D","text":"Only the installation manager can decide"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A process is not truly improved if gains in one area create larger problems elsewhere.'
),

(
  13,
  'situational_judgment',
  'application',
  'The team frequently waits for project decisions before continuing work. What is the BEST improvement approach?',
  '[
    {"key":"A","text":"Tell the field team to make every decision independently"},
    {"key":"B","text":"Identify which decisions commonly cause delays and clarify decision ownership, required information, and escalation paths"},
    {"key":"C","text":"Increase the amount of work started before decisions are made"},
    {"key":"D","text":"Remove project leadership from the workflow"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Clear decision rights and escalation paths can reduce avoidable waiting without creating uncontrolled decision-making.'
),

(
  14,
  'multiple_choice',
  'application',
  'A process change has been implemented. What should happen next?',
  '[
    {"key":"A","text":"Assume it worked because the team agreed to it"},
    {"key":"B","text":"Observe results and compare performance to the problem the change was intended to improve"},
    {"key":"C","text":"Immediately create another change"},
    {"key":"D","text":"Stop tracking the original issue"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Process improvement includes validating whether the change actually produced the intended result.'
),

-- ============================================================================
-- SCENARIO — 6
-- ============================================================================

(
  15,
  'scenario',
  'scenario',
  'Three recent projects reached final testing with the same type of missing device configuration. Each project required extra field and programming time to correct it. What is the BEST response?',
  '[
    {"key":"A","text":"Remind programmers to pay more attention"},
    {"key":"B","text":"Trace where configuration requirements should be captured, transferred, verified, and completed, then improve the weak point in that workflow"},
    {"key":"C","text":"Add more testing time to every project"},
    {"key":"D","text":"Treat each occurrence as unrelated"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Repeated failures at the same point suggest a process weakness that should be addressed upstream rather than absorbed as recurring rework.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A team introduces a new staging checklist and missing-material incidents drop sharply, but the checklist adds ten minutes to preparation. How should the result be evaluated?',
  '[
    {"key":"A","text":"The checklist is worse because it takes longer"},
    {"key":"B","text":"Compare the small preparation cost with the reduction in field delays, extra trips, and rework before deciding"},
    {"key":"C","text":"Remove the checklist after one successful project"},
    {"key":"D","text":"Use the checklist only when someone remembers"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Process improvement should evaluate total system impact rather than optimizing a single step in isolation.'
),

(
  17,
  'scenario',
  'scenario',
  'The same project information is entered manually into three different systems, and mismatched versions regularly cause confusion. What is the BEST process-improvement opportunity?',
  '[
    {"key":"A","text":"Have employees enter the information more carefully"},
    {"key":"B","text":"Review whether the duplicate entry can be reduced, integrated, standardized, or controlled through a single source of truth"},
    {"key":"C","text":"Add a fourth system for verification"},
    {"key":"D","text":"Stop updating one of the systems without telling anyone"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Duplicate data entry can create waste and version-control problems and is a strong candidate for process redesign.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'One technician consistently completes a recurring task faster than the rest of the team while maintaining quality. What is the BEST process-improvement response?',
  '[
    {"key":"A","text":"Require everyone to work faster"},
    {"key":"B","text":"Understand the technician''s method and determine whether useful practices can be standardized or taught to others"},
    {"key":"C","text":"Give that technician all of the work permanently"},
    {"key":"D","text":"Ignore the difference because the work is getting done"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Strong individual practices can reveal improvements that may benefit the broader team when they are understood and validated.'
),

(
  19,
  'scenario',
  'scenario',
  'A workflow problem is corrected by adding another approval step. Errors decline, but projects now wait several days for approval even when the issue is routine. What should the team do?',
  '[
    {"key":"A","text":"Keep the process unchanged because errors decreased"},
    {"key":"B","text":"Review whether the control can be redesigned to preserve accuracy while reducing unnecessary waiting"},
    {"key":"C","text":"Remove all approvals"},
    {"key":"D","text":"Tell project teams to start work before approval"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Improvements should balance control, quality, speed, and workflow efficiency rather than creating a new bottleneck.'
),

(
  20,
  'scenario',
  'scenario',
  'Which result BEST demonstrates effective process improvement?',
  '[
    {"key":"A","text":"The team changed several procedures, but no one measured the outcome"},
    {"key":"B","text":"A recurring problem was defined with evidence, its underlying cause was identified, a targeted change was implemented, and results showed better repeatability or performance"},
    {"key":"C","text":"A manager created a longer checklist"},
    {"key":"D","text":"Employees were told to work harder"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective process improvement connects evidence, root cause, targeted change, and measurable improvement.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    'a8c0be18-7725-4ecc-b9ae-86e26afd4d2a';

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
  -- Validate current Process Improvement competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Process Improvement'
      and c.is_current = true

  ) then

    raise exception
      'Current Process Improvement Master Competency not found';

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
  -- Reuse current Process Improvement competency assessment.
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
      'Process Improvement Competency Assessment',
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
    from _seed_process_improvement_questions
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
        'Process Improvement',
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
      'IntegrateU Process Improvement L3 production assessment v1.0.',
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
        'Process Improvement',
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
        'IntegrateU Process Improvement L3 production assessment v1.0.',
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
    'a8c0be18-7725-4ecc-b9ae-86e26afd4d2a'
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

  join _seed_process_improvement_questions s
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
