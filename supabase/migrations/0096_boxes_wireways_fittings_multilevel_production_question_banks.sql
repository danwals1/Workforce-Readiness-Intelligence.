-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0096_boxes_wireways_fittings_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Boxes, Wireways & Fittings
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Electrician Apprentice  -> Level 2
--   Electrician Journeyman -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_boxes_wireways_fittings_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_boxes_wireways_fittings_l2_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 5

(1,'multiple_choice','foundational',
'What is the primary purpose of an electrical junction box?',
'[{"key":"A","text":"To provide an enclosure for conductor splices or connections"},{"key":"B","text":"To increase circuit voltage"},{"key":"C","text":"To replace overcurrent protection"},{"key":"D","text":"To identify conductor insulation type"}]'::jsonb,
'["A"]'::jsonb,
'Junction boxes provide an enclosure for splices, taps, and related conductor connections.'),

(2,'multiple_choice','foundational',
'Why must a fitting be compatible with the raceway or cable type being installed?',
'[{"key":"A","text":"To provide the intended mechanical connection and protection for that wiring method"},{"key":"B","text":"Only to make the installation look uniform"},{"key":"C","text":"Because all fittings are electrically identical"},{"key":"D","text":"To change conductor ampacity"}]'::jsonb,
'["A"]'::jsonb,
'Fittings are selected for the wiring method so the connection performs as intended mechanically and electrically.'),

(3,'multiple_choice','foundational',
'What is the purpose of a box cover?',
'[{"key":"A","text":"To close and protect the enclosure while maintaining required access"},{"key":"B","text":"To support the entire branch circuit"},{"key":"C","text":"To increase box volume"},{"key":"D","text":"To replace conductor insulation"}]'::jsonb,
'["A"]'::jsonb,
'A suitable cover closes the box and protects enclosed wiring while preserving access where required.'),

(4,'multiple_choice','foundational',
'Why are conductors entering a box through an opening normally provided with an appropriate connector, fitting, or other approved means?',
'[{"key":"A","text":"To secure and protect the wiring method at the enclosure entry"},{"key":"B","text":"To increase available circuit current"},{"key":"C","text":"To identify circuit voltage"},{"key":"D","text":"To make conductor stripping unnecessary"}]'::jsonb,
'["A"]'::jsonb,
'Proper fittings or connectors secure the wiring method and protect conductors at enclosure entries.'),

(5,'multiple_choice','foundational',
'What is box fill intended to address?',
'[{"key":"A","text":"Whether the conductors, devices, and fittings placed in a box exceed its permitted capacity"},{"key":"B","text":"Whether a box is completely filled with insulation"},{"key":"C","text":"Whether the box is painted"},{"key":"D","text":"Whether the raceway is straight"}]'::jsonb,
'["A"]'::jsonb,
'Box-fill requirements limit the amount of conductor and device occupancy within an enclosure.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'A metal device box is loose in the wall before devices are installed. What is the BEST action?',
'[{"key":"A","text":"Secure the box using an appropriate support method before completing the installation"},{"key":"B","text":"Rely on the device screws to hold the box"},{"key":"C","text":"Pack material around the box"},{"key":"D","text":"Ignore it if the cover plate will hide the movement"}]'::jsonb,
'["A"]'::jsonb,
'Boxes should be independently supported by an appropriate installation method rather than relying on devices or finish materials.'),

(7,'multiple_choice','application',
'A cable connector is visibly damaged and no longer grips the cable properly. What should happen?',
'[{"key":"A","text":"Replace it with a suitable undamaged fitting"},{"key":"B","text":"Tighten it until it deforms the cable"},{"key":"C","text":"Tape over the fitting"},{"key":"D","text":"Leave it if continuity is present"}]'::jsonb,
'["A"]'::jsonb,
'Damaged fittings should not be relied upon to provide the intended securing or protection of the wiring method.'),

(8,'situational_judgment','application',
'Several conductors and a device must be installed in a small box. What should be verified before proceeding?',
'[{"key":"A","text":"That the box has sufficient permitted capacity for the conductors, device, and applicable fittings"},{"key":"B","text":"That every conductor can be physically forced inside"},{"key":"C","text":"Only that the cover fits"},{"key":"D","text":"Only the conductor colors"}]'::jsonb,
'["A"]'::jsonb,
'Physical fit alone does not establish compliance; the enclosure must have adequate permitted capacity.'),

(9,'multiple_select','application',
'Which THREE factors commonly matter when selecting a box or enclosure for an installation?',
'[{"key":"A","text":"Wiring method and entry requirements"},{"key":"B","text":"Environmental or location conditions"},{"key":"C","text":"Required capacity and physical space"},{"key":"D","text":"Installer preference only"},{"key":"E","text":"The color of nearby equipment"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Selection depends on wiring method, environment, size or capacity, equipment, and installation conditions.'),

(10,'multiple_choice','application',
'Why should unused openings in a box or enclosure be properly closed?',
'[{"key":"A","text":"To maintain the intended enclosure protection and prevent unintended openings"},{"key":"B","text":"To increase circuit resistance"},{"key":"C","text":"To reduce conductor ampacity"},{"key":"D","text":"To identify spare circuits"}]'::jsonb,
'["A"]'::jsonb,
'Unused openings should be closed using appropriate means so the enclosure retains its intended protection.'),

(11,'situational_judgment','application',
'A raceway enters a box at an angle that places obvious stress on the fitting. What is the BEST response?',
'[{"key":"A","text":"Correct the alignment or support so the fitting is not used to absorb unintended mechanical stress"},{"key":"B","text":"Tighten the fitting harder"},{"key":"C","text":"Bend the box"},{"key":"D","text":"Ignore it once conductors are pulled"}]'::jsonb,
'["A"]'::jsonb,
'Raceways and enclosures should be aligned and supported so fittings are not subjected to unintended mechanical loading.'),

(12,'multiple_choice','application',
'When installing a box intended to remain accessible after construction, what should the installer consider?',
'[{"key":"A","text":"Whether the final building finish will preserve the required access"},{"key":"B","text":"Only whether the box is visible during rough-in"},{"key":"C","text":"Whether the cover can be painted"},{"key":"D","text":"Whether the box is near a receptacle"}]'::jsonb,
'["A"]'::jsonb,
'The completed construction condition must preserve required access to boxes and enclosures.'),

(13,'situational_judgment','application',
'A fitting is listed for one raceway size but is being considered for a different size using improvised shims. What should you do?',
'[{"key":"A","text":"Use a fitting suitable for the actual raceway and enclosure configuration"},{"key":"B","text":"Use the shims if the fitting feels tight"},{"key":"C","text":"Add tape around the raceway"},{"key":"D","text":"Proceed if the conductors fit"}]'::jsonb,
'["A"]'::jsonb,
'Fittings should be used within their intended and approved configuration rather than adapted informally.'),

(14,'multiple_choice','application',
'What is the BEST reason to plan box and wireway locations before installing raceways?',
'[{"key":"A","text":"To coordinate access, support, routing, entry space, and future conductor installation"},{"key":"B","text":"To eliminate the need for drawings"},{"key":"C","text":"To avoid using fittings"},{"key":"D","text":"To increase source voltage"}]'::jsonb,
'["A"]'::jsonb,
'Planning enclosure locations helps coordinate routing, support, accessibility, and usable conductor space.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'During rough-in, you find that the selected box is too shallow for the device and conductor arrangement without severe crowding. What is the BEST action?',
'[{"key":"A","text":"Select an appropriately sized box or approved configuration before completing the work"},{"key":"B","text":"Force the conductors behind the device"},{"key":"C","text":"Remove conductor insulation to create space"},{"key":"D","text":"Leave the device partially installed"}]'::jsonb,
'["A"]'::jsonb,
'Enclosure selection should provide adequate permitted capacity and usable space for the intended installation.'),

(16,'scenario','scenario',
'A junction box above a finished ceiling will be completely covered by permanent construction. What concern should be raised?',
'[{"key":"A","text":"Whether required access to the box will be lost"},{"key":"B","text":"Whether the box is the same color as the ceiling"},{"key":"C","text":"Whether the conductors are labeled"},{"key":"D","text":"Whether the cover screws are visible"}]'::jsonb,
'["A"]'::jsonb,
'Boxes containing wiring connections may need to remain accessible after construction.'),

(17,'situational_judgment','scenario',
'After conductors are pulled, a raceway connector at a metal box becomes visibly loose. What is the BEST response?',
'[{"key":"A","text":"Correct the fitting and verify the connection and enclosure condition before completing the installation"},{"key":"B","text":"Leave it because the conductors hold the raceway"},{"key":"C","text":"Cover it with tape"},{"key":"D","text":"Add more conductors to stabilize it"}]'::jsonb,
'["A"]'::jsonb,
'A loose fitting can compromise mechanical integrity and should be corrected before completion.'),

(18,'scenario','scenario',
'Multiple raceways are planned to enter one side of a pull box, but the layout leaves inadequate room to make the intended conductor pulls and bends. What should happen?',
'[{"key":"A","text":"Reevaluate the box size, entry locations, and routing before installation"},{"key":"B","text":"Install the raceways anyway and solve it during the pull"},{"key":"C","text":"Reduce conductor insulation thickness"},{"key":"D","text":"Remove the box cover permanently"}]'::jsonb,
'["A"]'::jsonb,
'Pull-box layout should account for conductor routing, entry locations, and usable bending or pulling space before installation.'),

(19,'scenario','scenario',
'A box installed outdoors is suitable for dry indoor use only. What is the BEST response?',
'[{"key":"A","text":"Replace or redesign the installation using equipment suitable for the actual environment"},{"key":"B","text":"Paint the box"},{"key":"C","text":"Drill extra drain holes without review"},{"key":"D","text":"Use it if the cover closes"}]'::jsonb,
'["A"]'::jsonb,
'Enclosures and associated fittings must be suitable for the conditions in which they are installed.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Boxes, Wireways & Fittings?',
'[{"key":"A","text":"Selecting enclosures by appearance alone"},{"key":"B","text":"Selecting suitable boxes and fittings, checking capacity and access, securing components correctly, and identifying routine installation conflicts"},{"key":"C","text":"Ignoring support once conductors are installed"},{"key":"D","text":"Using improvised fittings whenever standard parts are unavailable"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably selecting and installing routine boxes, fittings, and enclosures while recognizing capacity, support, and access issues.');

create temporary table _seed_boxes_wireways_fittings_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_boxes_wireways_fittings_l3_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- FOUNDATIONAL — 4

(1,'multiple_choice','foundational',
'What is the BEST reason to evaluate box or wireway layout before raceway installation begins?',
'[{"key":"A","text":"Entry geometry, conductor space, support, access, and future maintenance are easier to coordinate before the system is fixed in place"},{"key":"B","text":"It eliminates all field changes"},{"key":"C","text":"It makes conductor identification unnecessary"},{"key":"D","text":"It replaces project drawings"}]'::jsonb,
'["A"]'::jsonb,
'Advanced enclosure layout coordinates physical space, routing, access, support, and conductor installation before conflicts become rework.'),

(2,'multiple_choice','foundational',
'Why can enclosure dimensions matter even when basic conductor volume appears adequate?',
'[{"key":"A","text":"Pulling, bending, termination, device, and entry geometry may require usable space beyond simple volume"},{"key":"B","text":"Only exterior dimensions ever matter"},{"key":"C","text":"Volume automatically guarantees every conductor arrangement will work"},{"key":"D","text":"Dimensions affect only enclosure color"}]'::jsonb,
'["A"]'::jsonb,
'Usable installation space depends on geometry and conductor routing as well as nominal enclosure volume.'),

(3,'multiple_choice','foundational',
'What is the purpose of coordinating bonding continuity through metal boxes, raceways, and fittings where applicable?',
'[{"key":"A","text":"To maintain the intended effective conductive path across connected metal components"},{"key":"B","text":"To increase load current"},{"key":"C","text":"To replace overcurrent protection"},{"key":"D","text":"To reduce box fill"}]'::jsonb,
'["A"]'::jsonb,
'Metallic wiring components may form part of the intended bonding path and must be connected accordingly.'),

(4,'multiple_choice','foundational',
'Why should a journeyman distinguish between an enclosure used only as a pull point and one containing splices or equipment?',
'[{"key":"A","text":"The contents and function can affect sizing, accessibility, layout, and installation requirements"},{"key":"B","text":"Pull boxes never require covers"},{"key":"C","text":"Splice boxes never require support"},{"key":"D","text":"The distinction affects only labeling"}]'::jsonb,
'["A"]'::jsonb,
'Enclosure function and contents influence the requirements that must be evaluated.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A large pull box has adequate overall dimensions, but the raceway entries are arranged so conductors would have to make impractical bends immediately after entry. What should the journeyman do?',
'[{"key":"A","text":"Rework the entry layout or enclosure arrangement before conductor installation"},{"key":"B","text":"Proceed because overall box size is sufficient"},{"key":"C","text":"Force the bends during pulling"},{"key":"D","text":"Remove the cover during operation"}]'::jsonb,
'["A"]'::jsonb,
'Enclosure layout must provide usable conductor routing space, not merely adequate nominal dimensions.'),

(6,'multiple_select','application',
'Which THREE conditions should a journeyman commonly evaluate when selecting an enclosure system?',
'[{"key":"A","text":"Environmental suitability"},{"key":"B","text":"Conductor and equipment space"},{"key":"C","text":"Support, access, and entry arrangement"},{"key":"D","text":"Only the installer preferred brand"},{"key":"E","text":"Only the exterior finish color"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Environmental suitability, usable space, support, accessibility, and entry geometry are core enclosure-selection considerations.'),

(7,'situational_judgment','application',
'A wireway installation is being modified to add several circuits. What should be reviewed before adding conductors?',
'[{"key":"A","text":"Available permitted conductor occupancy, routing, terminations, and the suitability of the modified arrangement"},{"key":"B","text":"Only whether the cover will still close"},{"key":"C","text":"Only the new conductor colors"},{"key":"D","text":"Whether the wireway can be painted afterward"}]'::jsonb,
'["A"]'::jsonb,
'Adding conductors can affect occupancy, routing, termination space, and the suitability of the entire wireway installation.'),

(8,'multiple_choice','application',
'A metal raceway system relies on its fittings and boxes as part of the bonding path. What should be verified during inspection?',
'[{"key":"A","text":"That connections are properly assembled and provide the intended bonding continuity"},{"key":"B","text":"Only that each fitting is hand-tight"},{"key":"C","text":"Only that the raceway is painted"},{"key":"D","text":"That every box is plastic"}]'::jsonb,
'["A"]'::jsonb,
'Where metallic raceway components form part of the conductive path, their connections must provide the intended continuity.'),

(9,'situational_judgment','application',
'A pull box shown on the drawings conflicts with structural framing in the field. What is the BEST response?',
'[{"key":"A","text":"Coordinate a suitable revised location or arrangement before changing the installation"},{"key":"B","text":"Cut the framing"},{"key":"C","text":"Omit the pull box"},{"key":"D","text":"Install the box partially behind the framing"}]'::jsonb,
'["A"]'::jsonb,
'Field conflicts involving enclosure location should be coordinated rather than resolved by unauthorized structural or electrical changes.'),

(10,'multiple_choice','application',
'Why can simply choosing a larger box fail to solve a difficult conductor-layout problem?',
'[{"key":"A","text":"Entry locations and conductor routing geometry may still prevent practical bends, pulls, or terminations"},{"key":"B","text":"Larger boxes always reduce conductor space"},{"key":"C","text":"Large boxes cannot contain splices"},{"key":"D","text":"Box size matters only aesthetically"}]'::jsonb,
'["A"]'::jsonb,
'Layout quality depends on both size and geometry, including where raceways enter and where conductors must travel.'),

(11,'situational_judgment','application',
'An enclosure has multiple unused openings after a field change. What should the journeyman verify?',
'[{"key":"A","text":"That the openings are properly closed in a manner suitable for the enclosure and environment"},{"key":"B","text":"That they are hidden from view"},{"key":"C","text":"That conductors are routed near them"},{"key":"D","text":"That the enclosure is repainted"}]'::jsonb,
'["A"]'::jsonb,
'Field changes should not leave openings that compromise the intended enclosure protection.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A pull box was sized for the original raceway layout, but a field change moves one large raceway to an adjacent wall of the box. What should happen before installation?',
'[{"key":"A","text":"Reevaluate the box dimensions, raceway-entry geometry, and conductor routing for the revised configuration"},{"key":"B","text":"Assume the original box remains suitable"},{"key":"C","text":"Install the raceway and trim conductors shorter"},{"key":"D","text":"Remove other raceways"}]'::jsonb,
'["A"]'::jsonb,
'Changing entry geometry can change the required and usable conductor space even when the enclosure itself is unchanged.'),

(13,'scenario','scenario',
'Several devices are installed in a multi-gang box, and the completed assembly is extremely crowded even though every component physically fits. What is the BEST journeyman response?',
'[{"key":"A","text":"Verify permitted capacity and installation requirements rather than treating physical fit as proof of suitability"},{"key":"B","text":"Approve it because the cover closes"},{"key":"C","text":"Remove grounding connections to create space"},{"key":"D","text":"Compress the conductors more tightly"}]'::jsonb,
'["A"]'::jsonb,
'Physical fit does not by itself establish adequate enclosure capacity or a suitable installation.'),

(14,'situational_judgment','scenario',
'A wet-location enclosure is installed with fittings that are not suitable for the same environmental condition. What is the BEST conclusion?',
'[{"key":"A","text":"The enclosure system is not fully suitable until all applicable components are appropriate for the environment"},{"key":"B","text":"The enclosure rating automatically protects unsuitable fittings"},{"key":"C","text":"Only the box itself matters"},{"key":"D","text":"Paint can correct the fitting suitability"}]'::jsonb,
'["A"]'::jsonb,
'An enclosure system depends on the suitability of the box, cover, fittings, entries, and related components.'),

(15,'scenario','scenario',
'A crew proposes burying a junction box behind permanent wall finishes because the splice is already complete. What should the journeyman do?',
'[{"key":"A","text":"Prevent the box from becoming inaccessible and coordinate an acceptable accessible arrangement"},{"key":"B","text":"Approve it because the splice is finished"},{"key":"C","text":"Photograph it and cover it"},{"key":"D","text":"Remove the box cover before closing the wall"}]'::jsonb,
'["A"]'::jsonb,
'Completion of a splice does not eliminate applicable accessibility requirements for the enclosure.'),

(16,'scenario','scenario',
'A metal box and raceway are mechanically connected, but inspection reveals the fitting was assembled incorrectly and the conductive connection is questionable. What should happen?',
'[{"key":"A","text":"Correct the fitting and verify the intended mechanical and bonding continuity before acceptance"},{"key":"B","text":"Accept it if conductors have continuity"},{"key":"C","text":"Add paint to the connection"},{"key":"D","text":"Ignore it if the box is grounded elsewhere"}]'::jsonb,
'["A"]'::jsonb,
'Improperly assembled fittings can compromise both mechanical integrity and the intended conductive path.'),

(17,'scenario','scenario',
'A large wireway has been used as a convenient route for additional conductors from several later project changes. What is the BEST next step before adding another circuit?',
'[{"key":"A","text":"Evaluate the current wireway contents, occupancy, routing, and applicable installation requirements before approving more conductors"},{"key":"B","text":"Add the circuit if there is visible empty space"},{"key":"C","text":"Remove the wireway cover permanently"},{"key":"D","text":"Bundle all conductors tightly to create room"}]'::jsonb,
'["A"]'::jsonb,
'Incremental additions must be evaluated against the actual current condition of the wireway, not the original design alone.'),

(18,'situational_judgment','scenario',
'A pull box location meets the electrical layout but blocks required access to nearby mechanical equipment. What should the journeyman do?',
'[{"key":"A","text":"Coordinate a revised arrangement that preserves both electrical and mechanical access requirements"},{"key":"B","text":"Install the box because electrical drawings control"},{"key":"C","text":"Remove the mechanical equipment access panel"},{"key":"D","text":"Move the box without documenting the change"}]'::jsonb,
'["A"]'::jsonb,
'Enclosure layout should be coordinated with other building systems rather than evaluated in isolation.'),

(19,'scenario','scenario',
'A field-installed box extension creates a workable device depth but changes how the completed assembly interfaces with the finished surface. What should the journeyman verify?',
'[{"key":"A","text":"That the complete box-and-extension assembly remains suitable, secure, properly positioned, and coordinated with the finish condition"},{"key":"B","text":"Only that the device screws reach"},{"key":"C","text":"Only that the cover plate is large enough"},{"key":"D","text":"Nothing further if the extension fits"}]'::jsonb,
'["A"]'::jsonb,
'Field modifications must be evaluated as a complete assembly, including support, suitability, position, and finished construction.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Boxes, Wireways & Fittings?',
'[{"key":"A","text":"Selecting boxes only from standard stock sizes"},{"key":"B","text":"Independently coordinating enclosure capacity, entry geometry, environmental suitability, bonding, support, access, and field changes while resolving routine installation conflicts"},{"key":"C","text":"Treating physical fit as the only sizing requirement"},{"key":"D","text":"Delegating all enclosure-layout decisions"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently planning and evaluating enclosure systems as coordinated installations rather than isolated components.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'dcffe752-6161-4c38-9faf-f2c097b8686d';
  v_apprentice_role_id uuid := 'a3807562-0a94-43a3-a7b5-2389573138d2';
  v_journeyman_role_id uuid := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60';
  v_assessment_id uuid;
  v_master_question_id uuid;
  v_assessment_question_id uuid;
  v_row record;
  v_level integer;
  v_role_template_id uuid;
  v_assessment_name text;
begin
  select i.id into v_industry_id
  from public.industries i
  where lower(i.slug) = 'electrical'
     or lower(i.name) = 'electrical'
  order by case when lower(i.slug) = 'electrical' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Electrical industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Boxes, Wireways & Fittings'
      and c.is_current = true
  ) then
    raise exception 'Current Boxes, Wireways & Fittings Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_apprentice_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Apprentice'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Electrician Apprentice L3 safety requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_journeyman_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Journeyman'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Electrician Journeyman L3 Electrical Testing requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 2
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 5
      and s.application_count = 9
      and s.scenario_count = 6
  ) then
    raise exception 'Expected current L2 assessment standard 20 / 5 / 9 / 6 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
  end if;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Boxes, Wireways & Fittings — Level 2 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_boxes_wireways_fittings_l2_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
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
        'Boxes, Wireways & Fittings',
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
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Boxes, Wireways & Fittings L2 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

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

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
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
        'Boxes, Wireways & Fittings',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Boxes, Wireways & Fittings L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 3;
  v_role_template_id := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid;
  v_assessment_name := 'Boxes, Wireways & Fittings — Level 3 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_boxes_wireways_fittings_l3_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
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
        'Boxes, Wireways & Fittings',
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
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Boxes, Wireways & Fittings L3 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

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

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
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
        'Boxes, Wireways & Fittings',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Boxes, Wireways & Fittings L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (where aq.difficulty = 'foundational')::integer as foundational_count,
  count(distinct aq.id) filter (where aq.difficulty = 'application')::integer as application_count,
  count(distinct aq.id) filter (where aq.difficulty = 'scenario')::integer as scenario_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid
  and a.target_level in (2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 2 Apprentice  -> 20
--   Level 3 Journeyman -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 2 and ra.master_role_template_id =
    'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid;

-- ============================================================================
-- VERIFICATION 4 — NO DUPLICATE CURRENT ASSESSMENTS PER TARGET LEVEL
-- Expected: zero rows
-- ============================================================================

select
  a.target_level,
  count(*) as current_assessment_count
from public.assessments a
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'dcffe752-6161-4c38-9faf-f2c097b8686d'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
