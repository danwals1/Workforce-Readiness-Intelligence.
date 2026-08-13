-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0073_kpi_management_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: KPI Management
--   Target level: 1 — Awareness
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
--   -> KPI Management competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_kpi_management_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_kpi_management_questions (
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
-- FOUNDATIONAL — 8
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'What is a KPI?',
  '[
    {"key":"A","text":"A key performance indicator used to measure progress or results"},
    {"key":"B","text":"A project installation drawing"},
    {"key":"C","text":"A vendor purchase order"},
    {"key":"D","text":"A technician certification"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A KPI is a measurable indicator used to monitor performance against an expected result or objective.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Why are KPIs useful?',
  '[
    {"key":"A","text":"They make performance visible and help identify whether results are on track"},
    {"key":"B","text":"They eliminate the need for leadership decisions"},
    {"key":"C","text":"They guarantee every project will be profitable"},
    {"key":"D","text":"They replace all employee communication"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'KPIs create visibility into performance and help teams identify strengths, gaps, and trends.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What makes a KPI more useful?',
  '[
    {"key":"A","text":"It is clearly defined and connected to a meaningful business or operational result"},
    {"key":"B","text":"It changes every week"},
    {"key":"C","text":"Only senior leaders understand how it is calculated"},
    {"key":"D","text":"It is based primarily on opinion"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Useful KPIs are clearly defined, measurable, and connected to outcomes the organization wants to manage.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What is a performance target?',
  '[
    {"key":"A","text":"The expected level or result used to compare actual performance"},
    {"key":"B","text":"The employee assigned to collect data"},
    {"key":"C","text":"The largest project currently active"},
    {"key":"D","text":"A list of future equipment purchases"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A target establishes the expected performance level against which actual results can be evaluated.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'If a KPI is below target, what does that usually indicate?',
  '[
    {"key":"A","text":"A performance gap that may require investigation or action"},
    {"key":"B","text":"The KPI should automatically be deleted"},
    {"key":"C","text":"The employee responsible should automatically be disciplined"},
    {"key":"D","text":"The target must be wrong"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A KPI gap is a signal to understand what is driving the result before deciding what action is appropriate.'
),

(
  6,
  'multiple_choice',
  'foundational',
  'Why should KPI definitions remain consistent over time?',
  '[
    {"key":"A","text":"Consistent definitions make comparisons and trends more meaningful"},
    {"key":"B","text":"KPIs should never be updated under any circumstances"},
    {"key":"C","text":"Consistency eliminates the need to verify data"},
    {"key":"D","text":"It ensures every KPI has the same target"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Changing definitions can make historical comparisons misleading unless the change is intentionally managed.'
),

(
  7,
  'multiple_choice',
  'foundational',
  'What is a KPI trend?',
  '[
    {"key":"A","text":"The direction or pattern of performance over multiple measurement periods"},
    {"key":"B","text":"A single employee opinion"},
    {"key":"C","text":"The most recent project result only"},
    {"key":"D","text":"A list of company policies"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Trends help teams understand whether performance is improving, declining, or remaining stable over time.'
),

(
  8,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes the relationship between KPIs and accountability?',
  '[
    {"key":"A","text":"KPIs create visibility that helps teams discuss performance, ownership, and needed actions"},
    {"key":"B","text":"KPIs replace coaching and communication"},
    {"key":"C","text":"KPIs should only be used to identify poor performers"},
    {"key":"D","text":"KPIs are unrelated to accountability"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'KPIs support accountability by making expected and actual performance more visible.'
),

-- ============================================================================
-- APPLICATION — 8
-- ============================================================================

(
  9,
  'multiple_choice',
  'application',
  'A team has an on-time project completion KPI of 90%, but the current result is 76%. What is the BEST first response?',
  '[
    {"key":"A","text":"Investigate what is driving the gap before selecting corrective action"},
    {"key":"B","text":"Immediately change the target to 75%"},
    {"key":"C","text":"Stop measuring on-time completion"},
    {"key":"D","text":"Assume the field team is the cause"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'The KPI identifies a performance gap, but the underlying causes should be understood before action is chosen.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE characteristics make KPI data more reliable?',
  '[
    {"key":"A","text":"A consistent definition"},
    {"key":"B","text":"Accurate source data"},
    {"key":"C","text":"A consistent measurement method"},
    {"key":"D","text":"Changing the calculation when results look poor"},
    {"key":"E","text":"Using estimates when actual data is available"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Reliable KPI reporting depends on consistent definitions, valid data, and repeatable measurement.'
),

(
  11,
  'situational_judgment',
  'application',
  'A callback KPI increased significantly this month. What is the BEST next step?',
  '[
    {"key":"A","text":"Review the underlying callback data to identify patterns, causes, or concentration before deciding on action"},
    {"key":"B","text":"Assume all technicians need retraining"},
    {"key":"C","text":"Stop reporting callbacks"},
    {"key":"D","text":"Change the KPI to exclude difficult projects"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A KPI change should trigger investigation of the underlying work rather than immediate assumptions.'
),

(
  12,
  'multiple_choice',
  'application',
  'A KPI remains at target for six consecutive months. What is a reasonable conclusion?',
  '[
    {"key":"A","text":"Performance appears stable against the current target, although the team should continue monitoring it"},
    {"key":"B","text":"The KPI should never be reviewed again"},
    {"key":"C","text":"The target must be too easy"},
    {"key":"D","text":"The underlying process cannot fail"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Stable performance is useful evidence, but ongoing monitoring helps confirm that performance remains controlled.'
),

(
  13,
  'multiple_choice',
  'application',
  'Two managers report different values for the same KPI because they use different calculation rules. What should happen?',
  '[
    {"key":"A","text":"Agree on and document one approved KPI definition and calculation method"},
    {"key":"B","text":"Average the two results"},
    {"key":"C","text":"Allow each manager to keep their own definition"},
    {"key":"D","text":"Use whichever result looks better"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A KPI cannot reliably support decisions if different people calculate it differently.'
),

(
  14,
  'multiple_select',
  'application',
  'Which THREE questions are useful when reviewing a KPI that is below target?',
  '[
    {"key":"A","text":"What specifically is contributing to the gap?"},
    {"key":"B","text":"Is the data accurate and consistently measured?"},
    {"key":"C","text":"What action could influence the result?"},
    {"key":"D","text":"Who can be blamed immediately?"},
    {"key":"E","text":"How can the result be hidden from the team?"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Good KPI review combines data validation, cause analysis, and action planning.'
),

(
  15,
  'situational_judgment',
  'application',
  'A technician completion KPI improves, but quality callbacks also increase. What is the BEST interpretation?',
  '[
    {"key":"A","text":"The faster completion result should be reviewed together with quality because one improvement may be creating a negative downstream effect"},
    {"key":"B","text":"The completion KPI proves performance improved"},
    {"key":"C","text":"Quality callbacks should be ignored"},
    {"key":"D","text":"The two KPIs cannot be related"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'KPIs should be interpreted in context because optimizing one measure can sometimes damage another important outcome.'
),

(
  16,
  'multiple_choice',
  'application',
  'A team wants to improve schedule accuracy. Which KPI approach is MOST useful?',
  '[
    {"key":"A","text":"Define how schedule accuracy is measured, establish a target, track actual results consistently, and review gaps"},
    {"key":"B","text":"Ask whether the team feels schedules are improving"},
    {"key":"C","text":"Track only the best projects"},
    {"key":"D","text":"Change the target every month"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A useful KPI turns an important performance area into a consistent, measurable result that can be managed.'
),

-- ============================================================================
-- SCENARIO — 4
-- ============================================================================

(
  17,
  'scenario',
  'scenario',
  'A company tracks labor-versus-estimate performance. Results have declined for three consecutive months. What is the BEST KPI-management response?',
  '[
    {"key":"A","text":"Review the trend, validate the data, identify where overruns are occurring, and determine what actions could influence the result"},
    {"key":"B","text":"Stop reporting the KPI until performance improves"},
    {"key":"C","text":"Reduce all future labor estimates"},
    {"key":"D","text":"Assume technicians are working too slowly"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A declining trend provides a signal for structured investigation and corrective action rather than assumption or concealment.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A manager celebrates that projects on time improved from 78% to 91%, but the target is 95%. What is the BEST interpretation?',
  '[
    {"key":"A","text":"Performance improved significantly but a gap still remains against the target"},
    {"key":"B","text":"The KPI should be marked complete because it improved"},
    {"key":"C","text":"The target should automatically be reduced to 91%"},
    {"key":"D","text":"The prior 78% result should be deleted"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'KPIs help teams recognize improvement while still maintaining visibility into remaining performance gaps.'
),

(
  19,
  'scenario',
  'scenario',
  'A KPI dashboard shows excellent project completion numbers, but employees frequently mark tasks complete before all required quality checks are finished. What is the BEST response?',
  '[
    {"key":"A","text":"Review the KPI definition and source process because the metric may not be measuring true completion"},
    {"key":"B","text":"Keep using the KPI because the numbers are strong"},
    {"key":"C","text":"Raise the target"},
    {"key":"D","text":"Stop performing quality checks"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A KPI is only useful when its definition and data reflect the actual outcome the organization intends to manage.'
),

(
  20,
  'scenario',
  'scenario',
  'Which result BEST demonstrates effective KPI management?',
  '[
    {"key":"A","text":"The company collects many metrics but rarely discusses them"},
    {"key":"B","text":"Important results are clearly defined, measured consistently, compared with targets, reviewed for trends and gaps, and connected to specific actions"},
    {"key":"C","text":"Only positive KPIs are shown to employees"},
    {"key":"D","text":"Targets are adjusted whenever the team misses them"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective KPI management connects reliable measurement with targets, analysis, accountability, and action.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '7df19683-fffd-4918-80a3-333efb1b95dd';

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
  -- Validate current KPI Management competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'KPI Management'
      and c.is_current = true

  ) then

    raise exception
      'Current KPI Management Master Competency not found';

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
  -- Reuse current KPI Management competency assessment.
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
      'KPI Management Competency Assessment',
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
    from _seed_kpi_management_questions
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
        'KPI Management',
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
      'IntegrateU KPI Management L3 production assessment v1.0.',
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
        'KPI Management',
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
        'IntegrateU KPI Management L3 production assessment v1.0.',
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
    '7df19683-fffd-4918-80a3-333efb1b95dd'
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

  join _seed_kpi_management_questions s
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
