-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0112_basic_rigging_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Basic Rigging
--   Level 2: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Construction Worker -> Level 2
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_basic_rigging_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_basic_rigging_l2_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values
(1,'multiple_choice','foundational',
'What is the primary purpose of basic rigging planning before a load is moved?',
'[{"key":"A","text":"To understand the load, select suitable equipment, identify hazards, and plan how the load will be controlled"},{"key":"B","text":"To determine which worker can move the load fastest"},{"key":"C","text":"To eliminate the need for equipment inspection"},{"key":"D","text":"To allow workers to stand wherever they prefer"}]'::jsonb,
'["A"]'::jsonb,
'Basic rigging planning connects the load, equipment, movement path, and hazards before the lift or move begins.'),

(2,'multiple_choice','foundational',
'Why is the weight of a load important when selecting rigging equipment?',
'[{"key":"A","text":"The rigging system must be suitable for the load it is expected to support"},{"key":"B","text":"Load weight matters only when using wire rope"},{"key":"C","text":"The weight determines the number of workers who should stand under the load"},{"key":"D","text":"Load weight can be ignored when the lift distance is short"}]'::jsonb,
'["A"]'::jsonb,
'The load and its expected forces must remain within the appropriate capacity of the selected rigging system.'),

(3,'multiple_choice','foundational',
'What is the center of gravity of a load?',
'[{"key":"A","text":"The point around which the load''s weight is balanced"},{"key":"B","text":"The highest point on the load"},{"key":"C","text":"The location of the heaviest rigging hardware"},{"key":"D","text":"The point closest to the lifting equipment"}]'::jsonb,
'["A"]'::jsonb,
'Understanding the approximate center of gravity helps predict how a load will balance and move when lifted.'),

(4,'multiple_choice','foundational',
'Why should slings, hooks, shackles, and other rigging components be inspected before use?',
'[{"key":"A","text":"To identify damage, deformation, wear, missing identification, or other conditions that could make the component unsuitable"},{"key":"B","text":"Only to confirm that every component is the same color"},{"key":"C","text":"To eliminate the need to know the load weight"},{"key":"D","text":"Only because new rigging is more likely to fail"}]'::jsonb,
'["A"]'::jsonb,
'Pre-use inspection helps prevent damaged or unsuitable rigging components from being placed into service.'),

(5,'multiple_choice','foundational',
'What is the main purpose of clear communication during a rigging operation?',
'[{"key":"A","text":"To coordinate movement and ensure the operator and workers understand when and how the load should move"},{"key":"B","text":"To let every worker give commands at the same time"},{"key":"C","text":"To reduce the need for a lift plan"},{"key":"D","text":"To make the lift move faster regardless of conditions"}]'::jsonb,
'["A"]'::jsonb,
'Clear communication helps prevent conflicting instructions and unexpected load movement.'),

(6,'situational_judgment','application',
'A sling has visible cuts and damaged fibers during the pre-use inspection. What is the BEST response?',
'[{"key":"A","text":"Remove the sling from service and follow the approved process for evaluation or replacement"},{"key":"B","text":"Use it only for a lighter load"},{"key":"C","text":"Cover the damage with tape"},{"key":"D","text":"Use it if two slings are attached instead of one"}]'::jsonb,
'["A"]'::jsonb,
'Damaged rigging should not be used merely because the planned load seems light.'),

(7,'multiple_select','application',
'Which THREE factors should be evaluated before attaching rigging to a load?',
'[{"key":"A","text":"Load weight"},{"key":"B","text":"Load balance and center of gravity"},{"key":"C","text":"Suitable attachment points"},{"key":"D","text":"Which worker wants to stand closest to the load"},{"key":"E","text":"Whether the load can be moved without communication"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Load weight, balance, and attachment points are basic factors in selecting and arranging rigging.'),

(8,'situational_judgment','application',
'A hook is noticeably twisted compared with its normal shape. What should be done?',
'[{"key":"A","text":"Remove the hook from service and have it handled through the appropriate inspection or replacement process"},{"key":"B","text":"Straighten it with a hammer and continue"},{"key":"C","text":"Use it only for vertical lifts"},{"key":"D","text":"Use it if the load is moved slowly"}]'::jsonb,
'["A"]'::jsonb,
'Visible deformation is a warning that rigging hardware may no longer be suitable for service.'),

(9,'multiple_choice','application',
'Why can sling angle affect a rigging operation?',
'[{"key":"A","text":"Changing the sling angle can change the force carried by the sling legs and affect load control"},{"key":"B","text":"Sling angle affects appearance only"},{"key":"C","text":"A flatter sling angle always reduces sling forces"},{"key":"D","text":"Sling angle matters only when the load is on the ground"}]'::jsonb,
'["A"]'::jsonb,
'As rigging geometry changes, the forces in the rigging can change substantially.'),

(10,'situational_judgment','application',
'A load begins to tilt as tension is slowly applied. What is the BEST response?',
'[{"key":"A","text":"Stop, lower or keep the load supported as appropriate, and reevaluate the balance and rigging arrangement before continuing"},{"key":"B","text":"Increase lifting speed so the load straightens itself"},{"key":"C","text":"Have a worker push the load upright from underneath"},{"key":"D","text":"Continue because loads normally level out after leaving the ground"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected tilting indicates that load balance or rigging arrangement needs to be reevaluated before the lift proceeds.'),

(11,'multiple_choice','application',
'What is the BEST reason to keep workers out from under a suspended load?',
'[{"key":"A","text":"A failure, shift, or unexpected movement could expose them to severe struck-by or crush hazards"},{"key":"B","text":"Suspended loads always damage hearing"},{"key":"C","text":"Workers underneath make communication impossible"},{"key":"D","text":"Only the equipment operator may look at the load"}]'::jsonb,
'["A"]'::jsonb,
'A suspended load creates serious line-of-fire hazards if the load or rigging shifts or fails.'),

(12,'situational_judgment','application',
'A tag line is being considered for controlling a load. What is the main goal of using it?',
'[{"key":"A","text":"To help control rotation or movement while allowing the worker to remain in a safer position"},{"key":"B","text":"To increase the rated capacity of the rigging"},{"key":"C","text":"To allow workers to stand beneath the load"},{"key":"D","text":"To replace proper attachment points"}]'::jsonb,
'["A"]'::jsonb,
'Tag lines may help workers control load movement while reducing the need to place hands or bodies near the load.'),

(13,'multiple_choice','application',
'What should a worker do if the identification or capacity information on a rigging component cannot be verified?',
'[{"key":"A","text":"Do not assume its capacity; use a component whose suitability can be established through the approved process"},{"key":"B","text":"Estimate the capacity based on component size"},{"key":"C","text":"Use it only once"},{"key":"D","text":"Compare its color to another component"}]'::jsonb,
'["A"]'::jsonb,
'Rigging suitability should be established rather than guessed from appearance.'),

(14,'situational_judgment','application',
'A worker wants to attach rigging to a convenient part of the load that was not intended as a lifting point. What is the BEST response?',
'[{"key":"A","text":"Verify that the attachment location is suitable before using it, or select an approved lifting point or method"},{"key":"B","text":"Use it if the component looks strong"},{"key":"C","text":"Use it if the load will only be lifted a few inches"},{"key":"D","text":"Attach additional rigging without evaluating the point"}]'::jsonb,
'["A"]'::jsonb,
'Convenient attachment locations are not automatically suitable lifting points.'),

(15,'scenario','scenario',
'A crew is preparing to lift a bundle whose weight is uncertain and whose contents may have changed since it was last moved. What is the BEST course of action?',
'[{"key":"A","text":"Verify the load information before selecting the rigging and proceeding with the lift"},{"key":"B","text":"Use the same rigging that was used previously"},{"key":"C","text":"Lift slowly until the actual weight becomes obvious"},{"key":"D","text":"Add one extra sling and assume the system is sufficient"}]'::jsonb,
'["A"]'::jsonb,
'When load information is uncertain, the uncertainty should be resolved before the rigging system is selected.'),

(16,'scenario','scenario',
'A suspended load starts rotating toward nearby workers. What is the BEST response?',
'[{"key":"A","text":"Stop the movement as conditions allow, keep workers clear, and regain control using the planned safe method before continuing"},{"key":"B","text":"Have workers grab the load directly"},{"key":"C","text":"Increase travel speed to pass the workers quickly"},{"key":"D","text":"Allow the load to rotate until it settles"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected load rotation should be controlled without placing workers into the load''s path.'),

(17,'scenario','scenario',
'A shackle pin does not thread or seat normally during setup. What is the BEST response?',
'[{"key":"A","text":"Stop and inspect the hardware; use properly functioning, compatible rigging components before continuing"},{"key":"B","text":"Force the pin into place with a tool"},{"key":"C","text":"Leave the pin partially engaged"},{"key":"D","text":"Replace the pin with any available bolt"}]'::jsonb,
'["A"]'::jsonb,
'Rigging hardware that does not assemble normally may be damaged, mismatched, or otherwise unsuitable.'),

(18,'scenario','scenario',
'A load must move through a congested area where several workers are performing unrelated tasks. What should happen before the move?',
'[{"key":"A","text":"Coordinate the load path, clear or control the affected area, establish communication, and then perform the move"},{"key":"B","text":"Move the load without warning so workers do not gather around"},{"key":"C","text":"Rely on the suspended load itself to make workers move"},{"key":"D","text":"Move faster to reduce the time spent in the area"}]'::jsonb,
'["A"]'::jsonb,
'Load movement through a shared work area requires coordination and control of struck-by and line-of-fire exposure.'),

(19,'scenario','scenario',
'A crew has selected rigging that appears adequate, but the load contains loose pieces that could shift or fall during movement. What is the BEST response?',
'[{"key":"A","text":"Secure or otherwise control the loose material before lifting the load"},{"key":"B","text":"Proceed because the rigging itself is strong enough"},{"key":"C","text":"Have workers walk beside the load and hold the loose pieces"},{"key":"D","text":"Lift higher so the pieces have more room to settle"}]'::jsonb,
'["A"]'::jsonb,
'Rigging capacity alone does not address loose or shifting material within the load.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Basic Rigging?',
'[{"key":"A","text":"Attaching whatever rigging is closest and relying on the operator to correct problems"},{"key":"B","text":"Correctly inspecting basic rigging, recognizing load and balance concerns, selecting suitable hardware under established procedures, maintaining clear communication, and staying out of line-of-fire hazards"},{"key":"C","text":"Performing every rigging task without assistance"},{"key":"D","text":"Estimating load weight and capacity from experience alone"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means applying foundational rigging knowledge reliably within established work methods and recognizing when conditions require additional evaluation or assistance.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '0021b025-2daf-4cb6-82ba-3353f372ff52';
  v_construction_worker_role_id uuid := '0f5d7696-f36f-4413-b617-ee20f8c15a9f';
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
  where lower(i.slug) = 'construction'
     or lower(i.name) = 'construction'
  order by case when lower(i.slug) = 'construction' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Construction industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Basic Rigging'
      and c.is_current = true
  ) then
    raise exception 'Current Basic Rigging Master Competency not found';
  end if;



  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_construction_worker_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Construction Worker'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Construction Worker L2 safety requirement not found';
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

  -- ========================================================================
  -- Seed Level 2
  v_level := 2;
  v_role_template_id := '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid;
  v_assessment_name := 'Basic Rigging — Level 2 Competency Assessment';

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
    select * from _seed_basic_rigging_l2_questions
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
        'Basic Rigging',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU Basic Rigging L2 production assessment v1.0.',
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
        'Basic Rigging',
        v_row.difficulty,
        true,
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
        'IntegrateU Basic Rigging L2 production assessment v1.0.',
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
-- VERIFICATION 1 — ASSESSMENT CONTENT
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'foundational'
  )::integer as foundational_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'application'
  )::integer as application_count,
  count(distinct aq.id) filter (
    where aq.difficulty = 'scenario'
  )::integer as scenario_count,
  count(distinct aq.id) filter (
    where aq.critical_safety
  )::integer as critical_safety_count,
  count(distinct aq.id) filter (
    where aq.practical_verification_required
  )::integer as practical_verification_required_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   '0021b025-2daf-4cb6-82ba-3353f372ff52'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '0021b025-2daf-4cb6-82ba-3353f372ff52'::uuid
  and a.target_level = 2
group by a.id, a.target_level, a.name;


-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY
-- ============================================================================

with q as (
  select
    a.target_level,
    aq.source_master_question_id
  from public.assessments a
  join public.assessment_questions aq
    on aq.assessment_id = a.id
   and aq.source_master_question_id is not null
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '0021b025-2daf-4cb6-82ba-3353f372ff52'::uuid
    and a.target_level = 2
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer
    as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where ra.master_role_template_id =
  '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid
group by q.target_level;
