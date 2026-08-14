-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0097_conduit_preparation_bending_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Conduit Preparation & Bending
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

create temporary table _seed_conduit_preparation_bending_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_conduit_preparation_bending_l2_questions (
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
'What is the main purpose of accurately measuring conduit before making a bend?',
'[{"key":"A","text":"To place the bend so the conduit fits the intended route"},{"key":"B","text":"To increase conduit wall thickness"},{"key":"C","text":"To reduce conductor ampacity"},{"key":"D","text":"To identify circuit voltage"}]'::jsonb,
'["A"]'::jsonb,
'Accurate measurement helps place bends and offsets so conduit fits the planned installation.'),

(2,'multiple_choice','foundational',
'What does an offset bend allow conduit to do?',
'[{"key":"A","text":"Shift from one parallel path to another while continuing in the same general direction"},{"key":"B","text":"Reverse direction completely"},{"key":"C","text":"Increase conduit trade size"},{"key":"D","text":"Join conductors without a box"}]'::jsonb,
'["A"]'::jsonb,
'An offset moves conduit around an obstruction or between different planes while maintaining the general route.'),

(3,'multiple_choice','foundational',
'Why should cut conduit be reamed or deburred before conductors are installed?',
'[{"key":"A","text":"To remove sharp edges that could damage conductor insulation"},{"key":"B","text":"To increase conduit length"},{"key":"C","text":"To change the conduit type"},{"key":"D","text":"To reduce fitting size"}]'::jsonb,
'["A"]'::jsonb,
'Reaming removes sharp edges and burrs that can damage conductors during pulling or installation.'),

(4,'multiple_choice','foundational',
'What is the purpose of using the correct bender size for the conduit being bent?',
'[{"key":"A","text":"To support the conduit properly and produce the intended bend without excessive distortion"},{"key":"B","text":"To increase conductor capacity"},{"key":"C","text":"To replace all measuring steps"},{"key":"D","text":"To eliminate the need for fittings"}]'::jsonb,
'["A"]'::jsonb,
'A properly matched bender supports the conduit and helps produce a controlled bend.'),

(5,'multiple_choice','foundational',
'Why should conduit routing be planned before multiple bends are made?',
'[{"key":"A","text":"To coordinate bend locations, obstructions, supports, and termination points"},{"key":"B","text":"To avoid measuring"},{"key":"C","text":"To eliminate all couplings"},{"key":"D","text":"To make every bend 90 degrees"}]'::jsonb,
'["A"]'::jsonb,
'Planning reduces unnecessary bends and helps coordinate the route with field conditions.'),

-- APPLICATION — 9

(6,'situational_judgment','application',
'You need to route conduit around a shallow obstruction while keeping the conduit parallel to its original path. Which bend is generally appropriate?',
'[{"key":"A","text":"An offset"},{"key":"B","text":"A full circle"},{"key":"C","text":"A random compound bend"},{"key":"D","text":"No bend at all"}]'::jsonb,
'["A"]'::jsonb,
'Offsets are commonly used to move conduit around shallow obstructions while maintaining the general direction of travel.'),

(7,'multiple_choice','application',
'After cutting EMT, what should be done before attaching the fitting?',
'[{"key":"A","text":"Remove burrs and verify the cut end is suitable for assembly"},{"key":"B","text":"Flatten the end"},{"key":"C","text":"Heat the conduit"},{"key":"D","text":"Reduce the trade size"}]'::jsonb,
'["A"]'::jsonb,
'A clean, deburred end supports proper fitting installation and protects conductors.'),

(8,'situational_judgment','application',
'A conduit stub-up lands several inches short of the intended box location. What is the BEST response?',
'[{"key":"A","text":"Reevaluate the measurement and bend layout and correct the conduit properly"},{"key":"B","text":"Pull the box toward the conduit"},{"key":"C","text":"Stretch the conduit"},{"key":"D","text":"Leave the fitting partially engaged"}]'::jsonb,
'["A"]'::jsonb,
'A dimensional miss should be corrected through proper layout or replacement rather than forcing connected components out of position.'),

(9,'multiple_select','application',
'Which THREE practices support good conduit workmanship?',
'[{"key":"A","text":"Accurate layout and measurement"},{"key":"B","text":"Smooth bends without visible kinking"},{"key":"C","text":"Properly aligned and supported runs"},{"key":"D","text":"Using fittings to correct every measurement error"},{"key":"E","text":"Leaving sharp cut edges"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Good conduit workmanship depends on accurate layout, controlled bends, alignment, and proper support.'),

(10,'multiple_choice','application',
'What does a visible kink in a conduit bend usually indicate?',
'[{"key":"A","text":"The bend was improperly formed or the conduit was overstressed"},{"key":"B","text":"The bend is automatically stronger"},{"key":"C","text":"The conduit trade size increased"},{"key":"D","text":"The conductor fill was reduced"}]'::jsonb,
'["A"]'::jsonb,
'A kink or severe flattening is evidence of an improperly formed bend and may compromise the installation.'),

(11,'situational_judgment','application',
'A conduit run will pass several structural obstructions. What is the BEST approach before bending?',
'[{"key":"A","text":"Lay out the route and sequence of bends using actual field dimensions"},{"key":"B","text":"Make bends first and measure afterward"},{"key":"C","text":"Use the maximum possible number of bends"},{"key":"D","text":"Ignore final termination locations"}]'::jsonb,
'["A"]'::jsonb,
'Field dimensions and bend sequence should be established before fabrication to reduce rework.'),

(12,'multiple_choice','application',
'Why should conduit bends be kept as smooth as practical?',
'[{"key":"A","text":"To support conductor pulling and avoid damaging or excessively distorting the raceway"},{"key":"B","text":"To increase voltage"},{"key":"C","text":"To eliminate conductor insulation"},{"key":"D","text":"To avoid all supports"}]'::jsonb,
'["A"]'::jsonb,
'Smooth, properly formed bends improve conductor installation and preserve raceway integrity.'),

(13,'situational_judgment','application',
'Two parallel conduits must make the same change in direction and remain visually aligned. What should the installer do?',
'[{"key":"A","text":"Use consistent layout references and bend geometry for both runs"},{"key":"B","text":"Bend each conduit by eye with no measurements"},{"key":"C","text":"Use different bend angles"},{"key":"D","text":"Terminate the conduits at different elevations"}]'::jsonb,
'["A"]'::jsonb,
'Consistent reference points and bend geometry help maintain alignment in parallel conduit runs.'),

(14,'multiple_choice','application',
'What is the BEST reason to verify conduit support locations while planning bends?',
'[{"key":"A","text":"The finished route must be both geometrically correct and properly supported"},{"key":"B","text":"Supports determine circuit voltage"},{"key":"C","text":"Supports replace fittings"},{"key":"D","text":"Support locations change conductor insulation type"}]'::jsonb,
'["A"]'::jsonb,
'Routing and support requirements must be coordinated together for a complete installation.'),

-- SCENARIO — 6

(15,'scenario','scenario',
'A conduit offset clears an obstruction but leaves the conduit noticeably out of parallel with the wall. What is the BEST response?',
'[{"key":"A","text":"Correct the bend layout so the conduit clears the obstruction and returns to the intended alignment"},{"key":"B","text":"Accept it because the obstruction is cleared"},{"key":"C","text":"Twist the fitting to compensate"},{"key":"D","text":"Add another random bend"}]'::jsonb,
'["A"]'::jsonb,
'Good workmanship requires both functional clearance and proper alignment.'),

(16,'scenario','scenario',
'A 90-degree bend lands at the correct height but points several degrees away from the intended box. What should the installer do?',
'[{"key":"A","text":"Correct or remake the bend rather than forcing the conduit into alignment at the fitting"},{"key":"B","text":"Pull the box sideways"},{"key":"C","text":"Leave the connection under stress"},{"key":"D","text":"Use the locknut to twist the conduit"}]'::jsonb,
'["A"]'::jsonb,
'Misalignment should be corrected in the conduit layout rather than transferred as stress to the box or fitting.'),

(17,'situational_judgment','scenario',
'A conduit run has accumulated several bends and the planned route now appears difficult for conductor pulling. What is the BEST next step?',
'[{"key":"A","text":"Reevaluate the route and bend sequence before completing the run"},{"key":"B","text":"Add more bends to improve appearance"},{"key":"C","text":"Use smaller conductors regardless of design"},{"key":"D","text":"Ignore pulling difficulty until conductors arrive"}]'::jsonb,
'["A"]'::jsonb,
'Conduit routing should be evaluated for both installation geometry and practical conductor pulling.'),

(18,'scenario','scenario',
'A bent conduit shows flattening on the outside of the bend and is visibly deformed. What should happen?',
'[{"key":"A","text":"Evaluate and replace or remake the bend if it is not suitable for installation"},{"key":"B","text":"Hide the deformation behind the wall"},{"key":"C","text":"Hammer it flat"},{"key":"D","text":"Install conductors to reshape it"}]'::jsonb,
'["A"]'::jsonb,
'Visible deformation indicates a poor bend and should be corrected before the raceway is completed.'),

(19,'scenario','scenario',
'A field measurement was taken from the wrong reference point, causing several prefabricated conduits to miss their intended entries. What is the BEST response?',
'[{"key":"A","text":"Reestablish the correct reference, verify the layout, and remake or correct affected pieces appropriately"},{"key":"B","text":"Move all equipment to match the conduits"},{"key":"C","text":"Use flexible material for every miss"},{"key":"D","text":"Ignore the dimensional difference"}]'::jsonb,
'["A"]'::jsonb,
'Layout errors should be corrected from the controlling reference rather than propagated through the installation.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 working knowledge of Conduit Preparation & Bending?',
'[{"key":"A","text":"Bending conduit by eye without checking layout"},{"key":"B","text":"Measuring accurately, preparing conduit properly, making routine bends, aligning runs, and recognizing workmanship problems"},{"key":"C","text":"Using fittings to compensate for poor bends"},{"key":"D","text":"Ignoring support and routing constraints"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 performance means reliably laying out and fabricating routine conduit runs with acceptable workmanship.');

create temporary table _seed_conduit_preparation_bending_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_conduit_preparation_bending_l3_questions (
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
'Why is bend sequencing important in a complex conduit run?',
'[{"key":"A","text":"Earlier bends can change the reference geometry and physical ability to make later bends"},{"key":"B","text":"Bend sequence affects only appearance"},{"key":"C","text":"Every bend can be made independently"},{"key":"D","text":"Sequence changes conductor ampacity"}]'::jsonb,
'["A"]'::jsonb,
'Complex bending requires planning because each bend affects later measurements, orientation, and tool access.'),

(2,'multiple_choice','foundational',
'What is the BEST reason to establish fixed layout references before fabricating multiple parallel conduits?',
'[{"key":"A","text":"To keep offsets, elevations, spacing, and termination points consistent across the rack"},{"key":"B","text":"To eliminate measurement"},{"key":"C","text":"To avoid all couplings"},{"key":"D","text":"To make every conduit the same length"}]'::jsonb,
'["A"]'::jsonb,
'Fixed references create repeatable geometry across parallel conduit runs.'),

(3,'multiple_choice','foundational',
'Why can a conduit route that fits physically still be a poor installation?',
'[{"key":"A","text":"It may create excessive bends, poor pullability, weak support, bad alignment, or maintenance problems"},{"key":"B","text":"Physical fit always proves suitability"},{"key":"C","text":"Only conduit color matters after installation"},{"key":"D","text":"Routing has no effect on future work"}]'::jsonb,
'["A"]'::jsonb,
'A good route must work mechanically, support conductor installation, and maintain acceptable workmanship and access.'),

(4,'multiple_choice','foundational',
'What is the purpose of checking bend orientation as well as bend angle?',
'[{"key":"A","text":"A correct angle in the wrong plane will still miss the intended route"},{"key":"B","text":"Orientation only affects conduit color"},{"key":"C","text":"Orientation matters only for straight runs"},{"key":"D","text":"Angle and orientation are always identical"}]'::jsonb,
'["A"]'::jsonb,
'Three-dimensional conduit layout requires control of both angle and rotational orientation.'),

-- APPLICATION — 7

(5,'situational_judgment','application',
'A rack of four conduits must offset around an obstruction while maintaining uniform spacing. What is the BEST approach?',
'[{"key":"A","text":"Plan the bend geometry and reference points for the entire rack before fabricating individual conduits"},{"key":"B","text":"Bend each conduit independently by eye"},{"key":"C","text":"Use different offsets for visual variety"},{"key":"D","text":"Install the first conduit and force the others to match"}]'::jsonb,
'["A"]'::jsonb,
'Parallel conduit work benefits from coordinated geometry rather than isolated bending decisions.'),

(6,'multiple_select','application',
'Which THREE conditions should a journeyman commonly evaluate when planning a conduit route?',
'[{"key":"A","text":"Field obstructions and termination points"},{"key":"B","text":"Bend sequence and conductor pullability"},{"key":"C","text":"Support and coordination with other trades"},{"key":"D","text":"Only the shortest geometric distance"},{"key":"E","text":"Only material color"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Route planning considers geometry, pullability, support, field conditions, and multidisciplinary coordination.'),

(7,'situational_judgment','application',
'A conduit rack rises vertically, offsets around ductwork, then turns into equipment. What should be established before fabrication?',
'[{"key":"A","text":"Controlling dimensions, bend sequence, planes of bend, spacing, and final entry locations"},{"key":"B","text":"Only the first bend"},{"key":"C","text":"Only total conduit length"},{"key":"D","text":"Only fitting type"}]'::jsonb,
'["A"]'::jsonb,
'Complex runs should be laid out as a complete geometric sequence before fabrication begins.'),

(8,'multiple_choice','application',
'What is the BEST response when a planned bend cannot be made because nearby installed work blocks bender access?',
'[{"key":"A","text":"Revise the fabrication sequence or route before continuing"},{"key":"B","text":"Force the bender into the space"},{"key":"C","text":"Make an uncontrolled partial bend"},{"key":"D","text":"Remove nearby work without coordination"}]'::jsonb,
'["A"]'::jsonb,
'Tool access is part of bend sequencing and should be considered before the run is fixed in place.'),

(9,'situational_judgment','application',
'A conduit run is visually straight, but one section places significant side load on the equipment fitting. What should the journeyman do?',
'[{"key":"A","text":"Correct the geometry or support so the termination is not carrying unintended stress"},{"key":"B","text":"Accept it because the run looks straight"},{"key":"C","text":"Tighten the fitting further"},{"key":"D","text":"Add conductor tension to hold alignment"}]'::jsonb,
'["A"]'::jsonb,
'Conduit should enter equipment in proper alignment rather than using fittings to absorb layout error.'),

(10,'multiple_choice','application',
'Why should a journeyman consider conductor installation while choosing between two possible conduit routes?',
'[{"key":"A","text":"The route with fewer or better-distributed bends may be significantly easier to pull and maintain"},{"key":"B","text":"Conduit routing never affects conductor pulling"},{"key":"C","text":"Conductors reshape bad bends"},{"key":"D","text":"Only total raceway length affects installation"}]'::jsonb,
'["A"]'::jsonb,
'Bend quantity, distribution, and geometry directly affect conductor pulling and future serviceability.'),

(11,'situational_judgment','application',
'An offset dimension changes after another trade moves equipment. What is the BEST response?',
'[{"key":"A","text":"Recalculate and verify the affected layout before fabricating additional conduit"},{"key":"B","text":"Continue using the old dimensions"},{"key":"C","text":"Guess a revised offset"},{"key":"D","text":"Force the equipment back into the original position"}]'::jsonb,
'["A"]'::jsonb,
'Changed field conditions require updated measurements and layout before fabrication continues.'),

-- SCENARIO — 9

(12,'scenario','scenario',
'A journeyman is coordinating six parallel conduits entering a large panel. The first two fit, but the remaining entries begin drifting out of alignment. What is the BEST response?',
'[{"key":"A","text":"Stop and reestablish the controlling references and bend geometry before fabricating more conduits"},{"key":"B","text":"Continue and correct each conduit at the panel"},{"key":"C","text":"Loosen the panel"},{"key":"D","text":"Reduce spacing randomly"}]'::jsonb,
'["A"]'::jsonb,
'Progressive drift indicates the layout reference or repeated geometry is not being controlled consistently.'),

(13,'scenario','scenario',
'A complex conduit has the correct offsets and elevations but arrives rotated 90 degrees from the intended equipment entry. What most likely went wrong?',
'[{"key":"A","text":"The bend-plane orientation was not controlled through the sequence"},{"key":"B","text":"The conduit trade size changed"},{"key":"C","text":"The support spacing was too close"},{"key":"D","text":"The conductor fill was too low"}]'::jsonb,
'["A"]'::jsonb,
'Correct angles alone are not enough; rotational orientation between bends must also be maintained.'),

(14,'scenario','scenario',
'A planned route requires several tight directional changes in a short distance. What is the BEST journeyman response?',
'[{"key":"A","text":"Evaluate a different route or enclosure strategy that improves bend geometry and conductor pullability"},{"key":"B","text":"Add every bend as drawn without review"},{"key":"C","text":"Make sharper bends than the tool is designed for"},{"key":"D","text":"Use smaller conductors automatically"}]'::jsonb,
'["A"]'::jsonb,
'Routing should be reconsidered when geometry creates poor bend quality or difficult conductor installation.'),

(15,'situational_judgment','scenario',
'A prefabricated conduit assembly was built from drawings, but field framing differs from the documented dimensions. What should the journeyman do?',
'[{"key":"A","text":"Verify the actual field condition, document the discrepancy as needed, and revise the layout before forcing the assembly into place"},{"key":"B","text":"Force the framing to match"},{"key":"C","text":"Cut random sections from the conduit"},{"key":"D","text":"Ignore the discrepancy"}]'::jsonb,
'["A"]'::jsonb,
'Prefabrication must be reconciled with actual field conditions rather than forcing misaligned work.'),

(16,'scenario','scenario',
'A completed conduit rack looks clean, but inspection shows several runs are unsupported near directional changes and equipment entries. What should happen?',
'[{"key":"A","text":"Correct the support arrangement while preserving the intended alignment and route"},{"key":"B","text":"Approve it because appearance is good"},{"key":"C","text":"Use conductor tension as support"},{"key":"D","text":"Add supports only after energization"}]'::jsonb,
'["A"]'::jsonb,
'Workmanship includes both geometry and proper support of the raceway system.'),

(17,'scenario','scenario',
'A conduit was bent correctly but cut too short before the final coupling. The proposed fix would leave a poorly aligned short segment. What is the BEST response?',
'[{"key":"A","text":"Remake or properly revise the affected section rather than creating a weak alignment compromise"},{"key":"B","text":"Use the misaligned segment"},{"key":"C","text":"Pull the connected equipment toward it"},{"key":"D","text":"Leave the coupling partially engaged"}]'::jsonb,
'["A"]'::jsonb,
'A fabrication error should be corrected in a way that preserves proper alignment and mechanical integrity.'),

(18,'scenario','scenario',
'A conduit route crosses a future access zone for mechanical equipment. The raceway can physically fit there today. What should the journeyman do?',
'[{"key":"A","text":"Coordinate a route that preserves required future access instead of evaluating only current physical clearance"},{"key":"B","text":"Install it because the space is currently open"},{"key":"C","text":"Block the mechanical access"},{"key":"D","text":"Move the mechanical equipment without approval"}]'::jsonb,
'["A"]'::jsonb,
'Good routing considers future access and coordination with other systems, not just immediate fit.'),

(19,'situational_judgment','scenario',
'Several conduits in a finished exposed area have inconsistent bend radii and spacing even though they function electrically. What is the BEST journeyman assessment?',
'[{"key":"A","text":"The installation should be evaluated and corrected as needed because workmanship and consistent routing are part of acceptable conduit installation"},{"key":"B","text":"Function alone makes workmanship irrelevant"},{"key":"C","text":"Only concealed work requires consistency"},{"key":"D","text":"Paint will correct the problem"}]'::jsonb,
'["A"]'::jsonb,
'Professional conduit work includes consistent geometry, alignment, spacing, and support as well as electrical function.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Conduit Preparation & Bending?',
'[{"key":"A","text":"Making individual bends without planning the complete route"},{"key":"B","text":"Independently planning complex routes, controlling bend geometry and orientation, coordinating parallel runs, supports, pullability, and field conflicts"},{"key":"C","text":"Using fittings to absorb layout errors"},{"key":"D","text":"Ignoring coordination with other trades"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means independently planning and executing coordinated conduit systems rather than only making isolated routine bends.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '550c2189-ba88-4527-b596-ddb5accca4b4';
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
      and c.name = 'Conduit Preparation & Bending'
      and c.is_current = true
  ) then
    raise exception 'Current Conduit Preparation & Bending Master Competency not found';
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
  v_assessment_name := 'Conduit Preparation & Bending — Level 2 Competency Assessment';

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
    select * from _seed_conduit_preparation_bending_l2_questions
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
        'Conduit Preparation & Bending',
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
      'IntegrateU Conduit Preparation & Bending L2 production assessment v1.0.',
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
        'Conduit Preparation & Bending',
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
        'IntegrateU Conduit Preparation & Bending L2 production assessment v1.0.',
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
  v_assessment_name := 'Conduit Preparation & Bending — Level 3 Competency Assessment';

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
    select * from _seed_conduit_preparation_bending_l3_questions
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
        'Conduit Preparation & Bending',
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
      'IntegrateU Conduit Preparation & Bending L3 production assessment v1.0.',
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
        'Conduit Preparation & Bending',
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
        'IntegrateU Conduit Preparation & Bending L3 production assessment v1.0.',
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
   '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid
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
      '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid
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
  '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid;

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
    '550c2189-ba88-4527-b596-ddb5accca4b4'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
