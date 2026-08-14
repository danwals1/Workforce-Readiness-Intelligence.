-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0121_traffic_work_zone_safety_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Traffic & Work-Zone Safety
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

create temporary table _seed_traffic_work_zone_safety_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_traffic_work_zone_safety_l2_questions (
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
'What is the primary purpose of traffic control in a construction work zone?',
'[{"key":"A","text":"To guide road users safely through or around the work area while protecting workers"},{"key":"B","text":"To make drivers slow down as much as possible"},{"key":"C","text":"To prevent all public access to the project"},{"key":"D","text":"To reduce the number of workers needed"}]'::jsonb,
'["A"]'::jsonb,
'Work-zone traffic control is intended to provide predictable guidance for road users while protecting workers and the public.'),

(2,'multiple_choice','foundational',
'Why is high-visibility apparel important for workers exposed to vehicle traffic or mobile equipment?',
'[{"key":"A","text":"It helps drivers and equipment operators detect workers sooner"},{"key":"B","text":"It replaces the need for traffic control devices"},{"key":"C","text":"It allows workers to stand anywhere in the roadway"},{"key":"D","text":"It is needed only at night"}]'::jsonb,
'["A"]'::jsonb,
'Visibility is a key control where workers may be exposed to moving vehicles or equipment.'),

(3,'multiple_choice','foundational',
'What is the BEST reason to keep signs, cones, drums, barricades, and other traffic-control devices correctly positioned?',
'[{"key":"A","text":"Road users rely on a consistent and understandable path through the work zone"},{"key":"B","text":"They make the project look organized"},{"key":"C","text":"They eliminate the need for worker awareness"},{"key":"D","text":"They are optional once drivers have seen the work zone"}]'::jsonb,
'["A"]'::jsonb,
'Traffic-control devices must remain clear and properly placed so road users receive accurate guidance.'),

(4,'multiple_choice','foundational',
'What should a worker do before entering an area exposed to active traffic or moving equipment?',
'[{"key":"A","text":"Understand the designated access route, traffic pattern, and applicable work-zone controls"},{"key":"B","text":"Enter quickly before vehicles approach"},{"key":"C","text":"Assume equipment operators can always see pedestrians"},{"key":"D","text":"Follow the shortest path regardless of barriers"}]'::jsonb,
'["A"]'::jsonb,
'Workers should know how traffic and equipment are being controlled before entering an exposure area.'),

(5,'multiple_choice','foundational',
'What is the purpose of a flagger or other authorized traffic-control person?',
'[{"key":"A","text":"To provide clear, consistent direction to road users when the work-zone plan requires manual control"},{"key":"B","text":"To replace all signs and channelizing devices"},{"key":"C","text":"To direct construction workers only"},{"key":"D","text":"To stop traffic whenever the crew needs more room"}]'::jsonb,
'["A"]'::jsonb,
'Flaggers provide controlled, understandable directions to road users as part of the approved traffic-control operation.'),

(6,'situational_judgment','application',
'A cone line has been moved by a vehicle and now directs traffic toward the work area. What is the BEST response?',
'[{"key":"A","text":"Report and correct the traffic-control setup promptly using the approved procedure before exposure continues"},{"key":"B","text":"Leave it until the next scheduled inspection"},{"key":"C","text":"Tell workers to stay farther from the lane"},{"key":"D","text":"Add one cone near the crew and keep working"}]'::jsonb,
'["A"]'::jsonb,
'A displaced control device can misdirect road users and should be corrected promptly.'),

(7,'multiple_select','application',
'Which THREE conditions should workers monitor in an active work zone?',
'[{"key":"A","text":"Changes in traffic patterns or device placement"},{"key":"B","text":"Worker and equipment visibility"},{"key":"C","text":"Public or pedestrian movement near the work area"},{"key":"D","text":"Whether drivers appear impatient"},{"key":"E","text":"Whether barriers make the project look symmetrical"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Work-zone conditions can change, so workers must remain aware of traffic control, visibility, and public-interface conditions.'),

(8,'situational_judgment','application',
'A worker needs to cross an active lane to reach another part of the site. What is the BEST response?',
'[{"key":"A","text":"Use the designated crossing or approved access method and confirm it is safe before entering the lane"},{"key":"B","text":"Cross wherever the distance is shortest"},{"key":"C","text":"Run across between vehicles"},{"key":"D","text":"Assume drivers will yield because it is a construction zone"}]'::jsonb,
'["A"]'::jsonb,
'Workers should use controlled access routes rather than improvising crossings through active traffic.'),

(9,'multiple_choice','application',
'Why should a flagger use clear and consistent signals?',
'[{"key":"A","text":"Drivers need enough time to recognize, understand, and respond predictably to the direction"},{"key":"B","text":"Signals are mainly for coworkers"},{"key":"C","text":"Different signals keep drivers attentive"},{"key":"D","text":"Hand signals eliminate the need for positioning"}]'::jsonb,
'["A"]'::jsonb,
'Consistency reduces confusion and gives road users a predictable instruction to follow.'),

(10,'situational_judgment','application',
'A parked work vehicle blocks a warning sign from approaching traffic. What is the BEST response?',
'[{"key":"A","text":"Reposition the vehicle or restore the required sign visibility using the approved traffic-control setup"},{"key":"B","text":"Leave it because the sign is still physically present"},{"key":"C","text":"Ask workers to wave at approaching drivers"},{"key":"D","text":"Remove the sign entirely"}]'::jsonb,
'["A"]'::jsonb,
'Traffic-control information must remain visible and understandable to approaching road users.'),

(11,'multiple_choice','application',
'What is the BEST practice when construction equipment must enter or exit through a public traffic area?',
'[{"key":"A","text":"Use the approved access and traffic-control method and coordinate movement so road users and workers are protected"},{"key":"B","text":"Enter traffic whenever there is a small gap"},{"key":"C","text":"Rely only on the equipment horn"},{"key":"D","text":"Have pedestrians stop traffic without authorization"}]'::jsonb,
'["A"]'::jsonb,
'Equipment movements that interface with public traffic should be planned and coordinated rather than improvised.'),

(12,'situational_judgment','application',
'Pedestrians begin walking around a barricade and into the work area because the normal sidewalk is closed. What is the BEST response?',
'[{"key":"A","text":"Address the public-interface hazard and restore or establish the approved pedestrian route and controls"},{"key":"B","text":"Ignore them because they entered voluntarily"},{"key":"C","text":"Tell equipment operators to watch more closely"},{"key":"D","text":"Move the barricade farther into the work area without coordination"}]'::jsonb,
'["A"]'::jsonb,
'Work-zone safety includes maintaining clear and usable routes for pedestrians where required.'),

(13,'multiple_choice','application',
'Why should workers avoid standing in an escape path or restricted area near moving traffic and equipment?',
'[{"key":"A","text":"They may have limited time or space to react if a vehicle or machine moves unexpectedly"},{"key":"B","text":"Those areas are reserved for supervisors"},{"key":"C","text":"It slows production"},{"key":"D","text":"It affects radio reception"}]'::jsonb,
'["A"]'::jsonb,
'Workers need separation and a viable path away from unexpected vehicle or equipment movement.'),

(14,'situational_judgment','application',
'Night work begins and several signs and workers are difficult for approaching drivers to see. What is the BEST response?',
'[{"key":"A","text":"Correct the visibility problem using the required lighting, device visibility, and high-visibility measures before continuing exposure"},{"key":"B","text":"Continue because traffic is lighter at night"},{"key":"C","text":"Have workers use phone flashlights"},{"key":"D","text":"Move signs closer to the work area so they are easier to maintain"}]'::jsonb,
'["A"]'::jsonb,
'Reduced visibility requires deliberate controls so road users can detect the work zone and workers in time to respond.'),

(15,'scenario','scenario',
'A vehicle enters the work zone through an opening that workers had been using as an unofficial shortcut. What is the BEST response?',
'[{"key":"A","text":"Stop using the unofficial access, restore the intended traffic-control boundary, and use the designated worker route"},{"key":"B","text":"Keep using the shortcut but post a worker there"},{"key":"C","text":"Make the opening wider so vehicles can pass safely"},{"key":"D","text":"Assume the driver made a one-time mistake"}]'::jsonb,
'["A"]'::jsonb,
'Uncontrolled openings weaken the work-zone separation and should not become informal worker access points.'),

(16,'scenario','scenario',
'A flagger is positioned where approaching drivers cannot see the flagger until they are very close. What is the BEST response?',
'[{"key":"A","text":"Relocate or revise the setup so the flagger is visible with adequate approach distance under the approved plan"},{"key":"B","text":"Use larger arm movements from the same location"},{"key":"C","text":"Stand partly in the traffic lane"},{"key":"D","text":"Rely on vehicle horns to alert drivers"}]'::jsonb,
'["A"]'::jsonb,
'A flagger must be positioned so road users have adequate time to perceive and respond to instructions.'),

(17,'scenario','scenario',
'Heavy rain reduces visibility and water moves several channelizing devices out of position. What is the BEST response?',
'[{"key":"A","text":"Reevaluate the work-zone conditions and restore effective traffic control before continuing exposed work"},{"key":"B","text":"Continue because the original setup was correct"},{"key":"C","text":"Remove the displaced devices and leave gaps"},{"key":"D","text":"Ask workers to stand where the devices were"}]'::jsonb,
'["A"]'::jsonb,
'Weather can change the effectiveness of a traffic-control setup and requires reassessment when conditions deteriorate.'),

(18,'scenario','scenario',
'A delivery truck arrives at an unexpected entrance and begins backing toward an area used by pedestrians. What is the BEST response?',
'[{"key":"A","text":"Stop or control the movement and coordinate the truck through the approved access and pedestrian-protection process"},{"key":"B","text":"Let the driver continue because deliveries have priority"},{"key":"C","text":"Tell pedestrians to move when they hear the backup alarm"},{"key":"D","text":"Have a nearby worker wave the truck through without changing the area controls"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected vehicle movements at the public interface should be brought under the established traffic and pedestrian controls.'),

(19,'scenario','scenario',
'Workers notice that drivers are repeatedly missing a lane-shift cue and making sudden corrections near the crew. What is the BEST Level 2 response?',
'[{"key":"A","text":"Report the recurring behavior and have the traffic-control setup reviewed and corrected as needed before the hazard continues"},{"key":"B","text":"Assume poor driving is unavoidable"},{"key":"C","text":"Move the crew closer together"},{"key":"D","text":"Add an unofficial handwritten sign"}]'::jsonb,
'["A"]'::jsonb,
'Repeated driver confusion can indicate that the traffic-control setup is not providing clear enough guidance and should be reviewed.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Traffic & Work-Zone Safety?',
'[{"key":"A","text":"Following the original traffic-control setup even when site conditions change"},{"key":"B","text":"Consistently maintaining visibility, approved access, traffic-control devices, worker separation, public-interface controls, and clear flagging or movement coordination while reporting and correcting changing hazards"},{"key":"C","text":"Relying on drivers and equipment operators to avoid workers"},{"key":"D","text":"Moving traffic-control devices whenever they interfere with the work"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means reliably applying and maintaining foundational traffic and work-zone controls during routine construction operations.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '46546ca7-39b1-4152-bfb2-675665baf5cf';
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
      and c.name = 'Traffic & Work-Zone Safety'
      and c.is_current = true
  ) then
    raise exception 'Current Traffic & Work-Zone Safety Master Competency not found';
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
  v_assessment_name := 'Traffic & Work-Zone Safety — Level 2 Competency Assessment';

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
    select * from _seed_traffic_work_zone_safety_l2_questions
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
        'Traffic & Work-Zone Safety',
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
      'IntegrateU Traffic & Work-Zone Safety L2 production assessment v1.0.',
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
        'Traffic & Work-Zone Safety',
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
        'IntegrateU Traffic & Work-Zone Safety L2 production assessment v1.0.',
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
   '46546ca7-39b1-4152-bfb2-675665baf5cf'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '46546ca7-39b1-4152-bfb2-675665baf5cf'::uuid
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
      '46546ca7-39b1-4152-bfb2-675665baf5cf'::uuid
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
