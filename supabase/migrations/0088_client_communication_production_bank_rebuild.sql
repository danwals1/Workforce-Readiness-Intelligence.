-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0075_project_planning_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Client Communication
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
--   -> Client Communication competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_client_communication_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_client_communication_questions (
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
  'What is the best first step when a client asks for a change that may affect the project scope?',
  '[
    {"id":"a","label":"Agree to the change immediately"},
    {"id":"b","label":"Explain that the request needs to be reviewed for scope, cost, and schedule impact"},
    {"id":"c","label":"Tell the client to contact the technician directly"},
    {"id":"d","label":"Ignore the request until the end of the project"}
  ]'::jsonb,
  '"b"'::jsonb,
  'A potential scope change should be acknowledged professionally and reviewed for its effect on scope, cost, schedule, and authorization before a commitment is made.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What makes a client status update most useful?',
  '[
    {"key":"A","text":"A long explanation of everything the team worked on"},
    {"key":"B","text":"A clear summary of current status, important issues, expected next steps, and anything the client needs to know or decide"},
    {"key":"C","text":"Only positive information so the client does not become concerned"},
    {"key":"D","text":"Technical details without explaining their impact"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Useful client communication is concise, accurate, and focused on status, impact, next steps, and decisions.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'When should a significant project issue be communicated to the client?',
  '[
    {"key":"A","text":"Only after the project is complete"},
    {"key":"B","text":"As soon as the issue and its likely impact are understood well enough to provide an accurate and useful update"},
    {"key":"C","text":"Only if the client asks about it"},
    {"key":"D","text":"Immediately, even if the information is unverified"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Timely communication matters, but the information should be sufficiently verified so the client receives an accurate update rather than speculation.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'Why is confirming client understanding important after discussing a technical issue or next step?',
  '[
    {"key":"A","text":"It helps verify that expectations, responsibilities, and next actions are understood consistently"},
    {"key":"B","text":"It allows the technician to avoid documenting the conversation"},
    {"key":"C","text":"It guarantees the client will agree with every recommendation"},
    {"key":"D","text":"It replaces the need for project documentation"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Confirming understanding reduces misalignment and helps ensure both parties leave the conversation with the same expectations.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  5,
  'situational_judgment',
  'application',
  'A project task is taking longer than expected and may delay completion by one day. What is the BEST client communication?',
  '[
    {"key":"A","text":"Wait until the original completion date has passed before mentioning the delay"},
    {"key":"B","text":"Explain the current status, the reason for the likely delay, the expected impact, and the team''s next steps using only confirmed information"},
    {"key":"C","text":"Tell the client the project is delayed without providing context"},
    {"key":"D","text":"Promise that the original date will still be met even though the team cannot support that commitment"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A proactive update should explain confirmed status, likely impact, and next steps without overpromising.'
),

(
  6,
  'multiple_select',
  'application',
  'Which THREE elements belong in a strong client update about a project issue?',
  '[
    {"key":"A","text":"What happened or what condition was found"},
    {"key":"B","text":"What is affected and the likely impact"},
    {"key":"C","text":"The recommended next step or decision needed"},
    {"key":"D","text":"Blame for the person or department responsible"},
    {"key":"E","text":"Unverified assumptions presented as facts"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Strong issue communication explains the condition, its effect, and what should happen next without blame or speculation.'
),

(
  7,
  'situational_judgment',
  'application',
  'A client asks a technical question and you are not certain of the correct answer. What is the BEST response?',
  '[
    {"key":"A","text":"Give the answer that seems most likely so the client does not have to wait"},
    {"key":"B","text":"Say that you want to verify the information, identify who can confirm it, and provide the client with a clear follow-up expectation"},
    {"key":"C","text":"Avoid answering and change the subject"},
    {"key":"D","text":"Tell the client technical questions are not their concern"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Professional communication includes acknowledging uncertainty, verifying facts, and setting a dependable follow-up expectation.'
),

(
  8,
  'situational_judgment',
  'application',
  'A client is frustrated because an installed device is not working as expected. What is the BEST first response?',
  '[
    {"key":"A","text":"Explain that the device manufacturer is probably responsible"},
    {"key":"B","text":"Acknowledge the concern, clarify the symptoms and impact, explain what will be checked next, and avoid assigning blame before the cause is known"},
    {"key":"C","text":"Tell the client to submit a service request and end the conversation"},
    {"key":"D","text":"Promise an immediate replacement before troubleshooting"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The first response should show ownership of the communication, clarify the problem, and establish the next diagnostic step without premature conclusions.'
),

(
  9,
  'multiple_choice',
  'application',
  'When presenting a recommendation to a client, which approach is MOST effective?',
  '[
    {"key":"A","text":"Recommend the most expensive option without discussing alternatives"},
    {"key":"B","text":"Explain the recommendation, why it addresses the client''s need, important tradeoffs, and any decision the client needs to make"},
    {"key":"C","text":"List technical specifications without connecting them to the client''s goals"},
    {"key":"D","text":"Avoid discussing limitations because they may make the recommendation less appealing"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A useful recommendation connects the proposed solution to the client need and clearly explains relevant tradeoffs and decisions.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE items are especially important when communicating project closeout to a client?',
  '[
    {"key":"A","text":"What has been completed"},
    {"key":"B","text":"Any remaining punch-list or follow-up items"},
    {"key":"C","text":"What the client should expect next for documentation, training, service, or support"},
    {"key":"D","text":"Internal disagreements that occurred during the project"},
    {"key":"E","text":"Unrelated details from earlier jobs"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Closeout communication should make completion status, remaining obligations, and next-step expectations clear to the client.'
),

(
  11,
  'situational_judgment',
  'application',
  'A client asks you to promise a completion date that has not been approved by the project manager. What is the BEST response?',
  '[
    {"key":"A","text":"Agree to the date because the client asked directly"},
    {"key":"B","text":"Explain the current known status, avoid making an unauthorized commitment, and confirm the date through the responsible project owner"},
    {"key":"C","text":"Tell the client scheduling is not your responsibility and provide no additional help"},
    {"key":"D","text":"Give the client the date you personally think is achievable"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Client communication should be helpful and transparent while respecting decision authority and avoiding unsupported commitments.'
),

-- ============================================================================
-- SCENARIO — 9
-- ============================================================================

(
  12,
  'scenario',
  'scenario',
  'A key device is delayed by the manufacturer and the project cannot be fully completed on the planned date. You have confirmed that most other work can still be finished. What is the BEST client update?',
  '[
    {"key":"A","text":"Say nothing until the delayed device arrives"},
    {"key":"B","text":"Explain the confirmed delay, identify what work can still be completed, describe what remains dependent on the device, and give the best verified next-update timing"},
    {"key":"C","text":"Tell the client the manufacturer ruined the schedule"},
    {"key":"D","text":"Promise a substitute device without project approval"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The client should receive a factual explanation of impact, productive work that can continue, remaining dependency, and the next communication point.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'A client requests an onsite change that appears simple but may affect labor, materials, programming, and project cost. What should you do?',
  '[
    {"key":"A","text":"Make the change immediately to keep the client happy"},
    {"key":"B","text":"Clarify the requested outcome, explain that the impact must be reviewed, document the request, and route it through the appropriate project or change process"},
    {"key":"C","text":"Reject the request because the original scope can never change"},
    {"key":"D","text":"Tell the client to ask another technician"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A professional response acknowledges the request while protecting scope, authorization, cost, schedule, and technical coordination.'
),

(
  14,
  'scenario',
  'scenario',
  'A client reports an intermittent system problem that your team cannot reproduce during the first visit. What is the BEST communication approach?',
  '[
    {"key":"A","text":"Tell the client there is no problem because it did not occur during the visit"},
    {"key":"B","text":"Explain what was checked, acknowledge that the intermittent issue is still unresolved, identify useful information to capture if it happens again, and define the next troubleshooting step"},
    {"key":"C","text":"Replace several components immediately without explaining why"},
    {"key":"D","text":"Tell the client to call only if the system completely fails"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'An unresolved intermittent issue should be communicated transparently with the work performed, remaining uncertainty, evidence needed, and next diagnostic action.'
),

(
  15,
  'situational_judgment',
  'scenario',
  'A client says a completed room does not match what they expected, but the installed work appears to match the approved documentation. What is the BEST response?',
  '[
    {"key":"A","text":"Tell the client the drawings prove they are wrong"},
    {"key":"B","text":"Listen to the concern, clarify the expected outcome, review the approved documentation with the appropriate project owner, and explain the next step for resolving any expectation or scope gap"},
    {"key":"C","text":"Change the installation immediately without review"},
    {"key":"D","text":"Avoid discussing the issue because the installation is technically complete"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The response should separate the client''s expectation from documented scope without becoming defensive, then move the issue into an appropriate resolution path.'
),

(
  16,
  'scenario',
  'scenario',
  'A project is transitioning from installation to service support. The client asks who they should contact if an issue occurs after closeout. What is the BEST response?',
  '[
    {"key":"A","text":"Tell them to contact whichever technician they remember from the project"},
    {"key":"B","text":"Explain the approved support process, provide the correct contact path, describe any relevant response expectations, and confirm what documentation or information the client should keep available"},
    {"key":"C","text":"Tell them future support is outside the project team''s responsibility"},
    {"key":"D","text":"Give the personal phone number of the lead technician"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A clear support handoff gives the client a dependable process rather than relying on informal personal contacts.'
),

(
  17,
  'scenario',
  'scenario',
  'During client training, the client appears confused about an important system function but says they understand so the session can move on. What should you do?',
  '[
    {"key":"A","text":"Continue because the client said they understand"},
    {"key":"B","text":"Rephrase or demonstrate the function, ask the client to explain or perform the key step, and address any remaining confusion before moving on"},
    {"key":"C","text":"Tell the client to read the manual later"},
    {"key":"D","text":"Repeat the same explanation more quickly"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective client communication checks actual understanding rather than relying only on a verbal acknowledgment.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A discovered site condition will require additional labor and may increase project cost. The exact cost has not yet been calculated. What is the BEST client communication?',
  '[
    {"key":"A","text":"Quote an estimated cost immediately so the client has a number"},
    {"key":"B","text":"Explain the verified site condition and likely impact, state clearly that final cost and schedule effects are still being reviewed, and provide the next decision or update point"},
    {"key":"C","text":"Wait until the invoice is issued to discuss the condition"},
    {"key":"D","text":"Tell the client the added work will be free"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The client should understand the known condition and possible impact while unconfirmed financial or schedule information is clearly identified as pending.'
),

(
  19,
  'scenario',
  'scenario',
  'A client asks why you are recommending a more complex solution than the one originally discussed. What is the BEST response?',
  '[
    {"key":"A","text":"Tell the client the newer solution is better and they should trust the technical team"},
    {"key":"B","text":"Explain the requirement or condition that changed the recommendation, connect the proposed solution to the client''s goals, and clearly discuss meaningful benefits, limitations, and alternatives"},
    {"key":"C","text":"Avoid discussing alternatives because it may slow the decision"},
    {"key":"D","text":"Use as much technical jargon as possible to demonstrate expertise"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A recommendation should be understandable, traceable to the client need, and transparent about relevant alternatives and tradeoffs.'
),

(
  20,
  'multiple_choice',
  'scenario',
  'At final project closeout, which client conversation BEST demonstrates strong Level 3 client communication?',
  '[
    {"key":"A","text":"Tell the client the project is finished and leave the remaining details to the office"},
    {"key":"B","text":"Confirm completed scope, explain any remaining items and ownership, review important operating or support expectations, answer questions accurately, and confirm the client understands the next steps"},
    {"key":"C","text":"Focus only on the technical features that were installed"},
    {"key":"D","text":"Avoid mentioning minor outstanding items because the project is nearly complete"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Strong closeout communication gives the client an accurate picture of completion, remaining commitments, operation/support expectations, and next steps.'
);
do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    '442b0afc-48ee-44ef-a46c-f9bfbbd6ec9b';

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
  -- Validate current Client Communication competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Client Communication'
      and c.is_current = true

  ) then

    raise exception
      'Current Client Communication Master Competency not found';

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
  -- Reuse current Client Communication competency assessment.
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
      'Client Communication Competency Assessment',
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
    from _seed_client_communication_questions
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
        'Client Communication',
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
      'IntegrateU Client Communication L3 production assessment v1.0.',
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
        'Client Communication',
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
        'IntegrateU Client Communication L3 production assessment v1.0.',
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
    '442b0afc-48ee-44ef-a46c-f9bfbbd6ec9b'
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

  join _seed_client_communication_questions s
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
