-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0071_financial_margin_awareness_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Financial / Margin Awareness
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
--   -> Financial / Margin Awareness competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_financial_margin_awareness_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_financial_margin_awareness_questions (
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
  'What does gross margin help a company understand?',
  '[
    {"key":"A","text":"How much project revenue remains after the direct cost of delivering the work"},
    {"key":"B","text":"How many technicians are employed"},
    {"key":"C","text":"How long a project has been open"},
    {"key":"D","text":"How many proposals were created"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Gross margin reflects the relationship between project revenue and the direct costs required to deliver that work.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Which cost is MOST directly affected when a project requires substantially more installation hours than estimated?',
  '[
    {"key":"A","text":"Labor cost"},
    {"key":"B","text":"Client revenue automatically increases"},
    {"key":"C","text":"Vendor lead time"},
    {"key":"D","text":"Warehouse square footage"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Additional labor hours increase project delivery cost unless the added work is appropriately recovered.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why does rework matter financially?',
  '[
    {"key":"A","text":"It can consume additional labor and material without creating additional planned revenue"},
    {"key":"B","text":"It always increases project selling price"},
    {"key":"C","text":"It reduces the need for quality control"},
    {"key":"D","text":"It has no effect if technicians are already employed"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Rework consumes resources that were often not included in the original cost plan and can reduce project margin.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What is scope creep?',
  '[
    {"key":"A","text":"Work expanding beyond the agreed scope without appropriate control or adjustment"},
    {"key":"B","text":"A project finishing ahead of schedule"},
    {"key":"C","text":"Equipment arriving earlier than expected"},
    {"key":"D","text":"A technician completing training"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Uncontrolled additional work can increase labor and material cost without corresponding revenue.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'Why should technicians and project leaders care about material waste?',
  '[
    {"key":"A","text":"Wasted material increases project cost and may reduce profitability"},
    {"key":"B","text":"Material waste only affects warehouse appearance"},
    {"key":"C","text":"Unused material has no financial value"},
    {"key":"D","text":"Vendors automatically credit all wasted material"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Material usage is part of direct project cost and therefore affects financial performance.'
),

-- ============================================================================
-- APPLICATION — 9
-- ============================================================================

(
  6,
  'multiple_choice',
  'application',
  'A technician discovers that completing a client-requested change will require several additional hours of work. What is the BEST action?',
  '[
    {"key":"A","text":"Complete the extra work without telling anyone"},
    {"key":"B","text":"Identify the scope change and communicate it through the appropriate project or change-order process before proceeding when possible"},
    {"key":"C","text":"Refuse all client requests"},
    {"key":"D","text":"Reduce quality elsewhere to recover the hours"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Additional scope should be visible so labor, material, schedule, and pricing impacts can be managed.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE conditions can negatively affect project margin?',
  '[
    {"key":"A","text":"Unplanned labor overruns"},
    {"key":"B","text":"Material waste or unplanned replacement"},
    {"key":"C","text":"Uncontrolled scope additions"},
    {"key":"D","text":"Accurate time tracking"},
    {"key":"E","text":"Completing work correctly the first time"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Labor overruns, unnecessary material cost, and unrecovered added scope can all reduce project profitability.'
),

(
  8,
  'multiple_choice',
  'application',
  'A project was estimated for 80 installation hours. The team is approaching 80 hours with significant work remaining. Why should this be communicated?',
  '[
    {"key":"A","text":"It may indicate a labor overrun that could affect schedule and project margin"},
    {"key":"B","text":"The estimate no longer matters once work begins"},
    {"key":"C","text":"It guarantees the client must pay more"},
    {"key":"D","text":"It only matters after project closeout"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Early visibility allows project leadership to understand the cause and manage labor, scope, schedule, or other corrective actions.'
),

(
  9,
  'situational_judgment',
  'application',
  'A technician accidentally damages an expensive device during installation. What is the BEST response?',
  '[
    {"key":"A","text":"Hide the damage and replace the device from inventory"},
    {"key":"B","text":"Report the damage promptly through the appropriate process so the replacement, project cost, and root cause can be managed"},
    {"key":"C","text":"Charge the client automatically"},
    {"key":"D","text":"Install the damaged device if it still powers on"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected material loss affects project cost and should be visible rather than absorbed without documentation.'
),

(
  10,
  'multiple_choice',
  'application',
  'Why is accurate time tracking important to financial awareness?',
  '[
    {"key":"A","text":"It helps compare actual labor usage with estimated or planned labor"},
    {"key":"B","text":"It automatically determines employee raises"},
    {"key":"C","text":"It eliminates project scheduling"},
    {"key":"D","text":"It guarantees a project is profitable"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Actual labor information helps the company understand project performance and improve future estimating.'
),

(
  11,
  'multiple_choice',
  'application',
  'A team regularly makes extra trips to the warehouse because required small materials were not prepared before installation. What is the financial impact?',
  '[
    {"key":"A","text":"The trips consume labor and vehicle time that may not have been planned"},
    {"key":"B","text":"There is no cost because the warehouse belongs to the company"},
    {"key":"C","text":"The client automatically pays for every trip"},
    {"key":"D","text":"Only the warehouse budget is affected"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Poor preparation can create indirect labor and operational costs that reduce project efficiency and margin.'
),

(
  12,
  'multiple_select',
  'application',
  'Which THREE field behaviors can help protect project financial performance?',
  '[
    {"key":"A","text":"Complete work correctly the first time"},
    {"key":"B","text":"Communicate scope changes and blockers early"},
    {"key":"C","text":"Use materials responsibly and track significant discrepancies"},
    {"key":"D","text":"Perform undocumented extra work whenever requested"},
    {"key":"E","text":"Ignore estimated labor once installation begins"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Quality execution, early communication, and responsible material use reduce avoidable project cost.'
),

(
  13,
  'situational_judgment',
  'application',
  'A client asks the technician to install two additional devices that are not shown in the current scope. What is the BEST response?',
  '[
    {"key":"A","text":"Install them because the devices are already onsite"},
    {"key":"B","text":"Clarify the request and route it through the appropriate scope or change approval process before committing additional labor and material"},
    {"key":"C","text":"Tell the client the company will never perform extra work"},
    {"key":"D","text":"Install one device as a compromise"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The financial impact of added scope should be visible and controlled before resources are committed.'
),

(
  14,
  'multiple_choice',
  'application',
  'A project is using significantly more cable than originally expected. What is the BEST financial-awareness response?',
  '[
    {"key":"A","text":"Continue using material and wait until the project ends"},
    {"key":"B","text":"Identify why usage is higher and communicate any meaningful scope, design, waste, or estimating issue"},
    {"key":"C","text":"Stop recording cable usage"},
    {"key":"D","text":"Assume all additional cable can be billed"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Unexpected material consumption can reveal scope changes, waste, design changes, or estimating gaps that affect cost.'
),

-- ============================================================================
-- SCENARIO — 6
-- ============================================================================

(
  15,
  'scenario',
  'scenario',
  'A project is nearing completion, but repeated programming and installation errors have added two extra days of labor. The client scope did not change. What is the likely financial effect?',
  '[
    {"key":"A","text":"Additional direct labor cost can reduce project margin"},
    {"key":"B","text":"Project revenue automatically increases by two days"},
    {"key":"C","text":"There is no financial effect because the employees are salaried or already scheduled"},
    {"key":"D","text":"Only the client schedule is affected"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Rework adds delivery cost without necessarily creating additional revenue.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'A technician sees that a planned installation method will require several unnecessary hours because site conditions changed. An approved alternative could achieve the same result with less labor. What is the BEST response?',
  '[
    {"key":"A","text":"Use the alternative without telling anyone"},
    {"key":"B","text":"Communicate the condition and proposed alternative through the appropriate project or technical approval path before changing execution"},
    {"key":"C","text":"Continue the inefficient method because it was originally planned"},
    {"key":"D","text":"Skip the affected work"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Financial awareness includes recognizing avoidable cost while still respecting technical, scope, and approval requirements.'
),

(
  17,
  'scenario',
  'scenario',
  'A project has strong revenue but also required substantial additional labor, replacement equipment, and multiple return visits. Why might the project still perform poorly financially?',
  '[
    {"key":"A","text":"High direct delivery costs can consume the expected margin even when revenue is strong"},
    {"key":"B","text":"Revenue is the only factor that matters"},
    {"key":"C","text":"Return visits never affect project cost"},
    {"key":"D","text":"Replacement equipment is not considered a project cost"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Profitability depends on both revenue and the cost required to deliver the project.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A team finishes a project under the estimated labor hours, but several quality issues require technicians to return the following week. How should those return visits be viewed?',
  '[
    {"key":"A","text":"As additional project cost that should be considered when evaluating true project performance"},
    {"key":"B","text":"As unrelated service work regardless of cause"},
    {"key":"C","text":"As free labor with no financial impact"},
    {"key":"D","text":"As proof that the original project was completed efficiently"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Callback and rework labor caused by project execution should be considered when evaluating actual delivery cost and quality.'
),

(
  19,
  'scenario',
  'scenario',
  'A lead technician notices that several small client requests have accumulated during the project. Individually they seem minor, but together they have added material and labor. What is the BEST response?',
  '[
    {"key":"A","text":"Ignore them because each request was small"},
    {"key":"B","text":"Make the cumulative added scope visible to project leadership so its cost and client impact can be reviewed"},
    {"key":"C","text":"Charge the client directly from the field"},
    {"key":"D","text":"Stop doing all client-requested work"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Small uncontrolled additions can accumulate into meaningful scope and margin impact.'
),

(
  20,
  'scenario',
  'scenario',
  'Which project result BEST demonstrates good financial and margin awareness from the field team?',
  '[
    {"key":"A","text":"The team completed the work without ever discussing cost or hours"},
    {"key":"B","text":"The team delivered quality work, tracked labor accurately, controlled material use, surfaced scope changes and blockers early, and minimized avoidable rework"},
    {"key":"C","text":"The team used every hour included in the estimate whether needed or not"},
    {"key":"D","text":"The team approved client changes without involving project leadership"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Field financial awareness is expressed through responsible execution decisions that protect labor, material, quality, scope, and project visibility.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '40558723-3f86-475c-b8ce-017fd6b77aa9';

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
  -- Validate current Financial / Margin Awareness competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Financial / Margin Awareness'
      and c.is_current = true

  ) then

    raise exception
      'Current Financial / Margin Awareness Master Competency not found';

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
  -- Reuse current Financial / Margin Awareness competency assessment.
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
      'Financial / Margin Awareness Competency Assessment',
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
    from _seed_financial_margin_awareness_questions
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
        'Financial / Margin Awareness',
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
      'IntegrateU Financial / Margin Awareness L3 production assessment v1.0.',
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
        'Financial / Margin Awareness',
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
        'IntegrateU Financial / Margin Awareness L3 production assessment v1.0.',
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
    '40558723-3f86-475c-b8ce-017fd6b77aa9'
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

  join _seed_financial_margin_awareness_questions s
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
