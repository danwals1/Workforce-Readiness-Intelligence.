-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0077_scope_proposal_development_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Scope & Proposal Development
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
--   -> Scope & Proposal Development competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_scope_proposal_development_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_scope_proposal_development_questions (
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
  'What is the primary purpose of a project scope?',
  '[
    {"key":"A","text":"Clearly define what work, systems, deliverables, and responsibilities are included in the project"},
    {"key":"B","text":"List only the equipment manufacturer"},
    {"key":"C","text":"Replace all project drawings"},
    {"key":"D","text":"Describe only the project price"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A clear scope establishes what the company has agreed to deliver and provides a basis for planning, pricing, execution, and change control.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Why is scope clarity important before project execution?',
  '[
    {"key":"A","text":"It reduces uncertainty about what is included, expected, and required"},
    {"key":"B","text":"It guarantees the project will never change"},
    {"key":"C","text":"It eliminates the need for client communication"},
    {"key":"D","text":"It allows technicians to select any solution"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Scope clarity helps sales, project management, design, purchasing, and field teams work from the same expectations.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What is an exclusion in a project proposal?',
  '[
    {"key":"A","text":"Work, material, or responsibility specifically identified as not included"},
    {"key":"B","text":"An item automatically added after the sale"},
    {"key":"C","text":"A project milestone"},
    {"key":"D","text":"A warranty claim"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Exclusions clarify boundaries and reduce assumptions about work the proposal does not include.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'Why are assumptions sometimes documented in a proposal?',
  '[
    {"key":"A","text":"They identify conditions or information the proposed solution and pricing depend on"},
    {"key":"B","text":"They allow the company to avoid defining scope"},
    {"key":"C","text":"They replace site surveys"},
    {"key":"D","text":"They guarantee the assumptions are correct"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Documented assumptions help make the basis of the proposed work visible.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'What is a proposal intended to communicate?',
  '[
    {"key":"A","text":"The proposed solution, scope, relevant pricing, terms, and other information needed to understand the offer"},
    {"key":"B","text":"Only the company logo and project total"},
    {"key":"C","text":"Only internal labor estimates"},
    {"key":"D","text":"Only manufacturer specifications"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A proposal communicates the company''s offer in a form the client and internal teams can understand.'
),

(
  6,
  'multiple_choice',
  'foundational',
  'Why should quantities in a proposal be accurate?',
  '[
    {"key":"A","text":"Incorrect quantities can affect scope, pricing, purchasing, and project execution"},
    {"key":"B","text":"Quantities only matter after installation"},
    {"key":"C","text":"The field team can always correct them without impact"},
    {"key":"D","text":"Vendors automatically correct proposal quantities"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Proposal quantities influence both the commercial offer and downstream project requirements.'
),

(
  7,
  'multiple_choice',
  'foundational',
  'What is scope creep?',
  '[
    {"key":"A","text":"Work expanding beyond the agreed project scope without appropriate review or control"},
    {"key":"B","text":"A project finishing early"},
    {"key":"C","text":"A proposal containing multiple systems"},
    {"key":"D","text":"Equipment pricing increasing before the sale"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Uncontrolled scope expansion can create labor, material, schedule, and margin problems.'
),

(
  8,
  'multiple_choice',
  'foundational',
  'Why is it important for field teams to understand the approved project scope?',
  '[
    {"key":"A","text":"They need to know what has been sold and what work is authorized before making execution decisions"},
    {"key":"B","text":"They should independently renegotiate pricing onsite"},
    {"key":"C","text":"They can change the solution whenever they prefer"},
    {"key":"D","text":"Scope is only relevant to sales"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Field execution should align with the approved project commitment rather than assumptions or undocumented additions.'
),

-- ============================================================================
-- APPLICATION — 8
-- ============================================================================

(
  9,
  'multiple_choice',
  'application',
  'A client asks whether an additional room is included in the project. What is the BEST first step?',
  '[
    {"key":"A","text":"Review the approved scope and proposal before confirming whether the room is included"},
    {"key":"B","text":"Tell the client it is included to maintain goodwill"},
    {"key":"C","text":"Ask the installer to decide"},
    {"key":"D","text":"Add the room automatically"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Questions about project commitments should be answered from approved scope documentation rather than memory or assumption.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE details can materially affect a project proposal?',
  '[
    {"key":"A","text":"Required equipment and quantities"},
    {"key":"B","text":"Expected labor or installation complexity"},
    {"key":"C","text":"Scope requirements and site conditions"},
    {"key":"D","text":"The salesperson''s favorite product color"},
    {"key":"E","text":"Unrelated projects scheduled that month"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Equipment, labor, scope, and project conditions are important inputs to a complete proposal.'
),

(
  11,
  'situational_judgment',
  'application',
  'A technician notices that the proposal shows four devices, but the approved drawing shows six. What is the BEST response?',
  '[
    {"key":"A","text":"Install six because the drawing is newer"},
    {"key":"B","text":"Identify and communicate the discrepancy so the approved scope, design, quantity, and commercial impact can be reconciled before proceeding"},
    {"key":"C","text":"Install four and ignore the drawing"},
    {"key":"D","text":"Ask the client which quantity they want"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Conflicting project documents should be reconciled rather than resolved through field assumptions.'
),

(
  12,
  'multiple_choice',
  'application',
  'A proposal says that electrical work is by others. What does this communicate?',
  '[
    {"key":"A","text":"Electrical work is outside the integrator''s included responsibility unless otherwise changed"},
    {"key":"B","text":"The integrator must perform the electrical work"},
    {"key":"C","text":"Electrical work is optional"},
    {"key":"D","text":"The proposal does not need electrical coordination"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A clearly stated exclusion or responsibility boundary helps teams understand who owns related work.'
),

(
  13,
  'multiple_choice',
  'application',
  'A requested product is no longer available before the proposal is finalized. What should happen?',
  '[
    {"key":"A","text":"Evaluate an appropriate alternative and update the proposed solution, scope, and pricing inputs as needed before approval"},
    {"key":"B","text":"Leave the unavailable product in the proposal"},
    {"key":"C","text":"Let the field team choose a substitute after the sale"},
    {"key":"D","text":"Remove the entire system from the proposal"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'The proposal should reflect a solution that can realistically be delivered.'
),

(
  14,
  'multiple_select',
  'application',
  'Which THREE conditions should be clarified when they are uncertain before a proposal is finalized?',
  '[
    {"key":"A","text":"What the client expects the system to do"},
    {"key":"B","text":"Who owns related work that may affect the installation"},
    {"key":"C","text":"Important site or scope conditions affecting the proposed solution"},
    {"key":"D","text":"Which technician will eventually be assigned"},
    {"key":"E","text":"Which employee will attend the company holiday party"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Unclear requirements, responsibilities, and project conditions can create proposal and execution risk.'
),

(
  15,
  'situational_judgment',
  'application',
  'A client requests a feature during the sales process, but the feature is not reflected anywhere in the draft proposal. What is the BEST response?',
  '[
    {"key":"A","text":"Assume the field team will remember it"},
    {"key":"B","text":"Ensure the requirement is intentionally addressed in the scope and proposed solution before the proposal is finalized"},
    {"key":"C","text":"Tell the client verbally that it is included"},
    {"key":"D","text":"Wait until project kickoff to document it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Client requirements should be translated into clear proposal documentation rather than relying on undocumented conversations.'
),

(
  16,
  'multiple_choice',
  'application',
  'Why should a proposal be reviewed for internal consistency before it is presented?',
  '[
    {"key":"A","text":"Conflicting scope, quantities, descriptions, and pricing inputs can create client confusion and execution errors"},
    {"key":"B","text":"Every proposal must have the same number of pages"},
    {"key":"C","text":"It guarantees the client will approve it"},
    {"key":"D","text":"Only formatting matters in proposal review"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A consistent proposal reduces ambiguity between what is described, priced, and expected to be delivered.'
),

-- ============================================================================
-- SCENARIO — 4
-- ============================================================================

(
  17,
  'scenario',
  'scenario',
  'A client says they expected motorized shades in three rooms, but the approved proposal only includes shades in one room. What is the BEST response?',
  '[
    {"key":"A","text":"Install all three rooms because the client expected them"},
    {"key":"B","text":"Review the approved documentation and prior requirements, clarify the discrepancy with the client and project owner, and use the appropriate scope-change process if additional work is requested"},
    {"key":"C","text":"Tell the client they are wrong and end the conversation"},
    {"key":"D","text":"Ask the technician to install any spare shades available"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Scope disputes should be resolved using approved documentation and a controlled process for any requested additions.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A proposal includes a television installation but does not identify whether the television itself is supplied by the company or the client. Why is this a problem?',
  '[
    {"key":"A","text":"The unclear responsibility can create purchasing, scheduling, pricing, and client-expectation problems"},
    {"key":"B","text":"It only affects the proposal formatting"},
    {"key":"C","text":"The technician can decide who supplies it onsite"},
    {"key":"D","text":"Televisions never need to be included in scope"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Responsibility for supplied equipment should be explicit when it affects the company''s deliverable or project readiness.'
),

(
  19,
  'scenario',
  'scenario',
  'During project handoff, the project manager discovers that a critical client expectation was discussed during sales but never included in the proposal. What is the BEST lesson?',
  '[
    {"key":"A","text":"Important client requirements should be translated into documented scope before the project is sold and handed off"},
    {"key":"B","text":"Project managers should attend every sales conversation"},
    {"key":"C","text":"Verbal commitments are sufficient if the salesperson remembers them"},
    {"key":"D","text":"Field teams should determine client expectations after installation begins"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'The proposal and scope should become the reliable handoff of what the company has committed to deliver.'
),

(
  20,
  'scenario',
  'scenario',
  'Which result BEST demonstrates Level 1 Scope & Proposal Development awareness for a Technician III?',
  '[
    {"key":"A","text":"The technician independently prices and sells complete projects"},
    {"key":"B","text":"The technician understands how scope, quantities, assumptions, exclusions, responsibilities, and client requirements affect the proposal and knows when field conditions or requests should be escalated rather than assumed"},
    {"key":"C","text":"The technician can approve all change orders"},
    {"key":"D","text":"The technician only needs to know the final project price"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Awareness means understanding the purpose and key components of scope and proposal development well enough to recognize execution risks and route discrepancies correctly.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '66e84548-47f9-4906-abe9-6e4565085910';

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
  -- Validate current Scope & Proposal Development competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Scope & Proposal Development'
      and c.is_current = true

  ) then

    raise exception
      'Current Scope & Proposal Development Master Competency not found';

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
  -- Reuse current Scope & Proposal Development competency assessment.
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
      'Scope & Proposal Development Competency Assessment',
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
    from _seed_scope_proposal_development_questions
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
        'Scope & Proposal Development',
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
      'IntegrateU Scope & Proposal Development L3 production assessment v1.0.',
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
        'Scope & Proposal Development',
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
        'IntegrateU Scope & Proposal Development L3 production assessment v1.0.',
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
    '66e84548-47f9-4906-abe9-6e4565085910'
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

  join _seed_scope_proposal_development_questions s
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
