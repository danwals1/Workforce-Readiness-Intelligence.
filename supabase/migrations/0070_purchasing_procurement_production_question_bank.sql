-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0070_purchasing_procurement_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Purchasing / Procurement
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
--   -> Purchasing / Procurement competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_purchasing_procurement_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_purchasing_procurement_questions (
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
  'What is the primary purpose of purchasing and procurement?',
  '[
    {"key":"A","text":"Buy equipment whenever someone asks for it"},
    {"key":"B","text":"Obtain required goods and materials through an approved process while managing cost, timing, vendors, and order accuracy"},
    {"key":"C","text":"Keep every possible product in inventory"},
    {"key":"D","text":"Eliminate the need for project planning"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Purchasing and procurement help ensure required goods are acquired through controlled processes with attention to cost, timing, accuracy, and vendor coordination.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What is a purchase order commonly used for?',
  '[
    {"key":"A","text":"Document and authorize a purchase from a vendor"},
    {"key":"B","text":"Record employee time"},
    {"key":"C","text":"Create a client service ticket"},
    {"key":"D","text":"Track technician certifications"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A purchase order documents an approved purchase and communicates items, quantities, pricing, and other purchasing details to a vendor.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why is vendor lead time important?',
  '[
    {"key":"A","text":"It indicates how long it may take for ordered material to become available or arrive"},
    {"key":"B","text":"It determines the number of technicians required"},
    {"key":"C","text":"It establishes the client selling price"},
    {"key":"D","text":"It replaces the project schedule"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Lead time affects when materials can realistically support project schedules.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What is a backorder?',
  '[
    {"key":"A","text":"An ordered item that is not currently available for normal shipment"},
    {"key":"B","text":"An item returned by a client"},
    {"key":"C","text":"An item stored at the back of the warehouse"},
    {"key":"D","text":"A duplicate project invoice"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A backorder occurs when an ordered item cannot currently be fulfilled as expected.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'Why should ordered quantities and part numbers be verified before placing an order?',
  '[
    {"key":"A","text":"To reduce purchasing errors, returns, shortages, and project delays"},
    {"key":"B","text":"To eliminate the need to receive the shipment"},
    {"key":"C","text":"To ensure every order uses the same vendor"},
    {"key":"D","text":"To avoid documenting the purchase"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Order accuracy begins before the purchase is submitted.'
),

(
  6,
  'multiple_choice',
  'foundational',
  'What is the purpose of procurement follow-up?',
  '[
    {"key":"A","text":"Confirm order status, expected delivery, backorders, changes, or other issues that may affect the project"},
    {"key":"B","text":"Ask vendors for marketing materials"},
    {"key":"C","text":"Replace project scheduling"},
    {"key":"D","text":"Avoid recording vendor communication"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Procurement follow-up keeps order status visible and helps identify risks before they affect field execution.'
),

(
  7,
  'multiple_choice',
  'foundational',
  'Why should returns to vendors be documented?',
  '[
    {"key":"A","text":"To maintain accurate records of equipment disposition, credits, replacements, and outstanding vendor actions"},
    {"key":"B","text":"Because every returned item must be reordered"},
    {"key":"C","text":"To avoid checking inventory"},
    {"key":"D","text":"Because vendors cannot process returns without a project manager onsite"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Return documentation helps preserve financial, inventory, and purchasing accuracy.'
),

(
  8,
  'multiple_choice',
  'foundational',
  'When should a purchasing issue be communicated to the project team?',
  '[
    {"key":"A","text":"When the issue may affect cost, equipment availability, delivery timing, or project execution"},
    {"key":"B","text":"Only after installation has been delayed"},
    {"key":"C","text":"Only when the vendor cancels the entire order"},
    {"key":"D","text":"Purchasing issues should remain within the warehouse"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Timely communication gives the project team an opportunity to manage schedule, scope, cost, or sequencing impacts.'
),

-- ============================================================================
-- APPLICATION — 8
-- ============================================================================

(
  9,
  'multiple_choice',
  'application',
  'A project requires a specific device model. Before ordering, what should be verified?',
  '[
    {"key":"A","text":"Current approved part number, required quantity, and project need"},
    {"key":"B","text":"Only the manufacturer name"},
    {"key":"C","text":"Which device has the best packaging"},
    {"key":"D","text":"Whether another project used something similar"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Purchasing should be based on current approved project requirements.'
),

(
  10,
  'multiple_select',
  'application',
  'Which THREE pieces of information are useful when following up on an open vendor order?',
  '[
    {"key":"A","text":"Current order status"},
    {"key":"B","text":"Expected ship or delivery date"},
    {"key":"C","text":"Any backordered or changed items"},
    {"key":"D","text":"The technician lunch schedule"},
    {"key":"E","text":"The client''s preferred music"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Order status, delivery timing, and exceptions are core procurement follow-up information.'
),

(
  11,
  'situational_judgment',
  'application',
  'A vendor confirms that one required item will arrive two weeks later than expected. What is the BEST action?',
  '[
    {"key":"A","text":"Wait until the original delivery date passes"},
    {"key":"B","text":"Communicate the updated lead time and likely project impact to the appropriate project owner and coordinate next steps"},
    {"key":"C","text":"Cancel the entire project"},
    {"key":"D","text":"Substitute a different item without approval"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A meaningful delivery change should be surfaced early so the team can evaluate alternatives or schedule impact.'
),

(
  12,
  'multiple_choice',
  'application',
  'The vendor order confirmation shows a different quantity than the approved purchase request. What should happen?',
  '[
    {"key":"A","text":"Verify and correct the discrepancy before relying on the order"},
    {"key":"B","text":"Assume the vendor quantity is correct"},
    {"key":"C","text":"Change the project requirement to match the vendor"},
    {"key":"D","text":"Ignore the confirmation"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Vendor confirmations should be reviewed for discrepancies before they create receiving or project problems.'
),

(
  13,
  'multiple_choice',
  'application',
  'Why might a company compare vendor pricing or terms before purchasing?',
  '[
    {"key":"A","text":"To make an informed purchasing decision considering cost, availability, service, and project requirements"},
    {"key":"B","text":"To always choose the lowest price regardless of fit"},
    {"key":"C","text":"To eliminate vendor relationships"},
    {"key":"D","text":"To avoid using purchase orders"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Procurement decisions may involve more than unit price, including availability, reliability, terms, and project needs.'
),

(
  14,
  'situational_judgment',
  'application',
  'A technician asks you to order a different model because the requested device is out of stock. What is the BEST response?',
  '[
    {"key":"A","text":"Order the substitute immediately"},
    {"key":"B","text":"Verify whether the substitute is technically and commercially approved before changing the purchase"},
    {"key":"C","text":"Tell the technician to buy it personally"},
    {"key":"D","text":"Remove the device from the project"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Substitutions can affect compatibility, programming, scope, cost, and client expectations and should be approved before purchase.'
),

(
  15,
  'multiple_select',
  'application',
  'Which THREE situations may require procurement follow-up?',
  '[
    {"key":"A","text":"A shipment is overdue"},
    {"key":"B","text":"A required item is backordered"},
    {"key":"C","text":"A vendor changed an expected ship date"},
    {"key":"D","text":"A project meeting ended early"},
    {"key":"E","text":"A technician changed tool bags"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Overdue shipments, backorders, and changed delivery dates can all affect project readiness.'
),

(
  16,
  'multiple_choice',
  'application',
  'A vendor sends a replacement for a returned defective unit. What should be confirmed?',
  '[
    {"key":"A","text":"That the replacement is correct and the return/replacement transaction is properly documented"},
    {"key":"B","text":"Only that the box arrived"},
    {"key":"C","text":"That the original item remains listed as available inventory"},
    {"key":"D","text":"That no one updates the purchase record"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Replacement transactions should maintain accurate purchasing and inventory records.'
),

-- ============================================================================
-- SCENARIO — 4
-- ============================================================================

(
  17,
  'scenario',
  'scenario',
  'A large project is scheduled to begin in three weeks. A key piece of equipment has a manufacturer lead time of five weeks. What is the BEST response?',
  '[
    {"key":"A","text":"Place the order and say nothing because delivery dates sometimes improve"},
    {"key":"B","text":"Communicate the lead-time conflict, confirm available alternatives or schedule options, and coordinate the approved path forward"},
    {"key":"C","text":"Order a different product without approval"},
    {"key":"D","text":"Wait until the project starts to address the issue"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Procurement awareness includes recognizing when material lead times conflict with project requirements and surfacing the risk early.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A shipment arrives with eight devices, but the purchase order and vendor confirmation both show ten. What should happen?',
  '[
    {"key":"A","text":"Receive all ten in the system because that is what was ordered"},
    {"key":"B","text":"Verify the physical count, document the shortage, record the actual receipt according to process, and follow up with the vendor"},
    {"key":"C","text":"Cancel the remaining two without telling anyone"},
    {"key":"D","text":"Change the purchase order to eight"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Receiving discrepancies should be documented and coordinated back through procurement rather than hidden by inaccurate records.'
),

(
  19,
  'scenario',
  'scenario',
  'A vendor offers a lower-cost substitute for a backordered item. The substitute appears similar but has not been reviewed by the design or programming team. What is the BEST response?',
  '[
    {"key":"A","text":"Approve it because it costs less"},
    {"key":"B","text":"Obtain the required technical and project approval before changing the purchased item"},
    {"key":"C","text":"Order both items and decide onsite"},
    {"key":"D","text":"Tell the vendor to choose"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Procurement should not independently make substitutions that may change technical or project requirements.'
),

(
  20,
  'scenario',
  'scenario',
  'You are reviewing an open project order. Which result BEST indicates the purchasing process is under control?',
  '[
    {"key":"A","text":"The order was submitted, but no one knows the current delivery status"},
    {"key":"B","text":"Approved items and quantities were ordered, vendor status is known, exceptions are documented, and delivery risks have been communicated"},
    {"key":"C","text":"Most of the equipment will probably arrive before installation"},
    {"key":"D","text":"The vendor has worked with the company before"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Controlled procurement provides visibility into what was ordered, its current status, known exceptions, and project impact.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    'ffc3b20f-7743-4f97-a9fb-7ea1631ff56e';

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
  -- Validate current Purchasing / Procurement competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Purchasing / Procurement'
      and c.is_current = true

  ) then

    raise exception
      'Current Purchasing / Procurement Master Competency not found';

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
  -- Reuse current Purchasing / Procurement competency assessment.
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
      'Purchasing / Procurement Competency Assessment',
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
    from _seed_purchasing_procurement_questions
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
        'Purchasing / Procurement',
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
      'IntegrateU Purchasing / Procurement L3 production assessment v1.0.',
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
        'Purchasing / Procurement',
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
        'IntegrateU Purchasing / Procurement L3 production assessment v1.0.',
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
    'ffc3b20f-7743-4f97-a9fb-7ea1631ff56e'
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

  join _seed_purchasing_procurement_questions s
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
