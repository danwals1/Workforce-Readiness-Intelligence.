-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0069_inventory_management_production_question_bank.sql
--
-- Production Master Question Bank:
--   Competency: Inventory Management
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
--   -> Inventory Management competency assessment
--   -> source-linked assessment snapshots
--   -> assessment-specific secure answer keys
--
-- Idempotent. Existing questions/snapshots are reused.
-- ============================================================================

begin;


create temporary table _seed_inventory_management_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);


insert into _seed_inventory_management_questions (
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
  'What is the primary purpose of inventory management?',
  '[
    {"key":"A","text":"Keep as much equipment in stock as possible"},
    {"key":"B","text":"Maintain accurate records and appropriate stock levels so required materials are available and controlled"},
    {"key":"C","text":"Move all inventory directly to job sites"},
    {"key":"D","text":"Eliminate the need for purchasing"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Inventory management supports availability, accuracy, accountability, and appropriate stock levels.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What is an inventory count?',
  '[
    {"key":"A","text":"A physical verification of the quantity of items actually on hand"},
    {"key":"B","text":"The quantity originally ordered from a supplier"},
    {"key":"C","text":"The number of projects scheduled this month"},
    {"key":"D","text":"The estimated value of future purchases"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'An inventory count compares the physical quantity on hand with inventory records.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'Why are accurate inventory records important?',
  '[
    {"key":"A","text":"They help prevent shortages, excess purchases, project delays, and unexplained material loss"},
    {"key":"B","text":"They eliminate the need to verify physical stock"},
    {"key":"C","text":"They guarantee that suppliers always have stock"},
    {"key":"D","text":"They allow technicians to remove materials without recording them"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Accurate records support purchasing, project readiness, cost control, and accountability.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'What does a stock level represent?',
  '[
    {"key":"A","text":"The quantity of an inventory item available or recorded as available"},
    {"key":"B","text":"The maximum number of technicians assigned to a project"},
    {"key":"C","text":"The selling price of equipment"},
    {"key":"D","text":"The number of suppliers used by the company"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Stock level refers to the quantity of an item available within inventory.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'When inventory is removed for a project, what should normally happen?',
  '[
    {"key":"A","text":"The inventory record should be updated according to the company process"},
    {"key":"B","text":"Nothing until the project is finished"},
    {"key":"C","text":"The item should remain listed as available"},
    {"key":"D","text":"The warehouse should order a replacement immediately in every case"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Inventory transactions should be recorded so system quantities continue to reflect actual material movement.'
),

-- ============================================================================
-- APPLICATION — 9
-- ============================================================================

(
  6,
  'multiple_choice',
  'application',
  'The inventory system shows eight devices in stock, but you physically count only six. What is the BEST first action?',
  '[
    {"key":"A","text":"Change the system quantity immediately without investigating"},
    {"key":"B","text":"Recount and review recent inventory activity or documentation to confirm the discrepancy"},
    {"key":"C","text":"Assume two devices were stolen"},
    {"key":"D","text":"Order eight more devices"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A discrepancy should first be verified and investigated before records are adjusted.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE activities help maintain accurate inventory?',
  '[
    {"key":"A","text":"Recording items received"},
    {"key":"B","text":"Recording items issued or transferred"},
    {"key":"C","text":"Performing periodic physical counts"},
    {"key":"D","text":"Allowing unrecorded material removal"},
    {"key":"E","text":"Estimating quantities instead of checking"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Receiving, issuing, transfers, and physical verification are core controls that keep inventory records accurate.'
),

(
  8,
  'multiple_choice',
  'application',
  'A commonly used connector is repeatedly running out before replacement stock arrives. What should be reviewed?',
  '[
    {"key":"A","text":"The reorder point, usage rate, lead time, and purchasing process"},
    {"key":"B","text":"The color of the inventory bins"},
    {"key":"C","text":"Only the most recent project schedule"},
    {"key":"D","text":"Whether technicians prefer a different connector"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Recurring shortages can indicate that stock thresholds or replenishment timing do not reflect actual usage and supplier lead time.'
),

(
  9,
  'situational_judgment',
  'application',
  'A technician takes several inventory items for a service call but does not know which ones will actually be used. What is the BEST process?',
  '[
    {"key":"A","text":"Remove the items without recording anything"},
    {"key":"B","text":"Track the items issued and reconcile used and returned quantities according to company procedure"},
    {"key":"C","text":"Charge every item permanently to the service call"},
    {"key":"D","text":"Tell the technician to purchase materials independently"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Temporary material movement still needs controlled tracking and reconciliation.'
),

(
  10,
  'multiple_choice',
  'application',
  'Why should project inventory and general stock be distinguished when appropriate?',
  '[
    {"key":"A","text":"To prevent equipment allocated to a project from appearing freely available for other work"},
    {"key":"B","text":"To make the inventory system more complicated"},
    {"key":"C","text":"To prevent project managers from viewing material"},
    {"key":"D","text":"To eliminate physical counts"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Allocated project material should not be treated as unrestricted available inventory.'
),

(
  11,
  'multiple_choice',
  'application',
  'A shipment arrives from a supplier. Which action BEST supports inventory accuracy?',
  '[
    {"key":"A","text":"Put all boxes into storage immediately"},
    {"key":"B","text":"Verify received items and quantities against the appropriate receiving documentation before updating inventory"},
    {"key":"C","text":"Update inventory based only on what was ordered"},
    {"key":"D","text":"Wait until a technician needs the material"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Receiving should reflect what actually arrived, not simply what was expected.'
),

(
  12,
  'multiple_select',
  'application',
  'Which THREE situations should normally trigger investigation or correction of inventory records?',
  '[
    {"key":"A","text":"Physical quantity does not match the recorded quantity"},
    {"key":"B","text":"Items are located in the wrong inventory location"},
    {"key":"C","text":"A material transfer was completed but not recorded"},
    {"key":"D","text":"Physical count exactly matches the system"},
    {"key":"E","text":"An item is correctly labeled and stored"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Quantity discrepancies, location errors, and missing transactions all reduce inventory accuracy.'
),

(
  13,
  'situational_judgment',
  'application',
  'A project is cancelled after equipment has already been allocated from inventory. What is the BEST inventory action?',
  '[
    {"key":"A","text":"Leave all items assigned to the cancelled project indefinitely"},
    {"key":"B","text":"Verify the condition and disposition of the equipment and return eligible items to available stock through the proper process"},
    {"key":"C","text":"Delete the equipment from inventory"},
    {"key":"D","text":"Send the equipment to another project without recording the transfer"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Cancelled-project material should be reconciled so usable items can become accurately available again.'
),

(
  14,
  'multiple_choice',
  'application',
  'What is the BEST reason to maintain consistent inventory locations and labeling?',
  '[
    {"key":"A","text":"It helps employees find, count, issue, and return material accurately"},
    {"key":"B","text":"It guarantees that inventory never runs out"},
    {"key":"C","text":"It eliminates the need for purchasing approvals"},
    {"key":"D","text":"It allows any item to be stored anywhere"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Consistent locations and labels improve visibility and reduce counting and picking errors.'
),

-- ============================================================================
-- SCENARIO — 6
-- ============================================================================

(
  15,
  'scenario',
  'scenario',
  'During a monthly inventory count, several high-use cable types consistently show less physical stock than the inventory system. What is the BEST response?',
  '[
    {"key":"A","text":"Increase the recorded quantities"},
    {"key":"B","text":"Investigate how cable is being issued, consumed, returned, and recorded, then correct the process and verified records"},
    {"key":"C","text":"Stop counting cable"},
    {"key":"D","text":"Order more cable without reviewing the discrepancy"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Repeated discrepancies usually point to a process-control issue that should be identified rather than repeatedly corrected without investigation.'
),

(
  16,
  'situational_judgment',
  'scenario',
  'The system shows one network switch available. A technician needs it for today''s service call, but you discover it is already allocated to an installation scheduled tomorrow. What is the BEST response?',
  '[
    {"key":"A","text":"Give it to the service technician because today comes first"},
    {"key":"B","text":"Treat the allocated unit as committed inventory and coordinate an approved solution for the service need"},
    {"key":"C","text":"Remove the project allocation from the system"},
    {"key":"D","text":"Let the two technicians decide who gets it"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Inventory availability must account for committed project material, not just physical presence in the warehouse.'
),

(
  17,
  'scenario',
  'scenario',
  'A technician returns unused project materials but places them on a warehouse shelf without telling anyone. What problem can this create?',
  '[
    {"key":"A","text":"The physical inventory may increase while the inventory system still shows the items issued, creating inaccurate availability"},
    {"key":"B","text":"There is no problem if the items are physically in the warehouse"},
    {"key":"C","text":"The project will automatically receive a credit"},
    {"key":"D","text":"The supplier will automatically update the inventory record"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Returns must be recorded and reconciled so physical stock and system records agree.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A supplier sends ten devices, but the packing documentation shows twelve. What should happen?',
  '[
    {"key":"A","text":"Record twelve because that is what the paperwork says"},
    {"key":"B","text":"Verify the physical count, document the shortage, receive only the confirmed quantity according to process, and communicate the discrepancy"},
    {"key":"C","text":"Record ten and throw away the documentation"},
    {"key":"D","text":"Wait until a project needs the missing devices"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Inventory receiving should be based on verified physical receipt and discrepancies should be documented for resolution.'
),

(
  19,
  'scenario',
  'scenario',
  'A commonly stocked item has accumulated far more inventory than the company is likely to use in the near term. What should be reviewed?',
  '[
    {"key":"A","text":"Usage history, current demand, reorder settings, purchasing quantities, and whether excess stock can be returned or reallocated"},
    {"key":"B","text":"Whether the storage shelf can hold even more"},
    {"key":"C","text":"Only the item''s manufacturer"},
    {"key":"D","text":"Whether technicians like the packaging"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Inventory management includes avoiding unnecessary excess as well as preventing shortages.'
),

(
  20,
  'scenario',
  'scenario',
  'You are reviewing whether an inventory process is working effectively. Which result BEST indicates healthy inventory control?',
  '[
    {"key":"A","text":"Employees can usually find what they need even though records are frequently wrong"},
    {"key":"B","text":"Physical counts generally agree with records, material movement is documented, project allocations are visible, and recurring shortages or excess are actively managed"},
    {"key":"C","text":"The warehouse contains a very large amount of equipment"},
    {"key":"D","text":"Only one employee is allowed to know inventory quantities"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Effective inventory control combines record accuracy, transaction discipline, allocation visibility, and appropriate stock management.'
);

do $$
declare

  v_industry_id uuid;

  v_competency_id uuid :=
    'aa817f4d-721f-46bc-9ecc-706270767be0';

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
  -- Validate current Inventory Management competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from public.master_competency_templates c

    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Inventory Management'
      and c.is_current = true

  ) then

    raise exception
      'Current Inventory Management Master Competency not found';

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
  -- Reuse current Inventory Management competency assessment.
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
      'Inventory Management Competency Assessment',
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
    from _seed_inventory_management_questions
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
        'Inventory Management',
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
      'IntegrateU Inventory Management L3 production assessment v1.0.',
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
        'Inventory Management',
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
        'IntegrateU Inventory Management L3 production assessment v1.0.',
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
    'aa817f4d-721f-46bc-9ecc-706270767be0'
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

  join _seed_inventory_management_questions s
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
