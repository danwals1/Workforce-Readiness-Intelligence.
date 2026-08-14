-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0124_forklift_material_equipment_awareness_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Forklift & Material Equipment Awareness
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--
-- Roles:
--   Construction Worker -> Level 1
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_forklift_material_equipment_awareness_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_forklift_material_equipment_awareness_l1_questions (
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
'Who should operate a forklift or similar powered material-handling equipment?',
'[{"key":"A","text":"Only a worker who is trained, evaluated, and authorized as required for that equipment"},{"key":"B","text":"Any worker who has watched someone else operate it"},{"key":"C","text":"Any worker with a driver''s license"},{"key":"D","text":"Only the most senior employee on the crew"}]'::jsonb,
'["A"]'::jsonb,
'Powered material-handling equipment should be operated only by workers who meet the applicable training and authorization requirements.'),

(2,'multiple_choice','foundational',
'What is the purpose of a pre-use inspection on a forklift or similar material-handling machine?',
'[{"key":"A","text":"To identify defects or conditions that could make the equipment unsafe to operate"},{"key":"B","text":"To determine which worker can operate fastest"},{"key":"C","text":"To replace scheduled maintenance"},{"key":"D","text":"To calculate the weight of every load"}]'::jsonb,
'["A"]'::jsonb,
'Pre-use inspections help identify unsafe equipment conditions before operation begins.'),

(3,'multiple_choice','foundational',
'Why is equipment capacity important when handling a load?',
'[{"key":"A","text":"Exceeding the equipment''s rated capacity or load limits can affect stability and safe operation"},{"key":"B","text":"Capacity matters only when traveling outdoors"},{"key":"C","text":"Capacity applies only to new equipment"},{"key":"D","text":"A skilled operator can safely ignore capacity limits"}]'::jsonb,
'["A"]'::jsonb,
'Rated capacity and load limitations are fundamental operating boundaries for material-handling equipment.'),

(4,'multiple_choice','foundational',
'Why should pedestrians stay clear of operating forklifts and similar equipment?',
'[{"key":"A","text":"Operators may have limited visibility and the equipment can move, turn, or carry loads through pedestrian areas"},{"key":"B","text":"Pedestrians always have the right of way"},{"key":"C","text":"The equipment cannot stop once it starts moving"},{"key":"D","text":"Only because the equipment is noisy"}]'::jsonb,
'["A"]'::jsonb,
'Separation between pedestrians and mobile equipment reduces struck-by and caught-between exposure.'),

(5,'multiple_choice','foundational',
'What is a blind spot on material-handling equipment?',
'[{"key":"A","text":"An area the operator cannot clearly see from the normal operating position"},{"key":"B","text":"A damaged tire"},{"key":"C","text":"A location where equipment cannot be parked"},{"key":"D","text":"A warning light on the dashboard"}]'::jsonb,
'["A"]'::jsonb,
'Blind spots are areas outside the operator''s clear field of view and require additional awareness and controls.'),

(6,'multiple_choice','foundational',
'Why should workers never stand or pass beneath an elevated load or raised forks?',
'[{"key":"A","text":"The load or lifting system could move, shift, or fail and cause serious injury"},{"key":"B","text":"It blocks the operator''s radio signal"},{"key":"C","text":"It slows loading operations"},{"key":"D","text":"It is allowed only during short tasks"}]'::jsonb,
'["A"]'::jsonb,
'Workers should stay clear of suspended or elevated loads because of crushing and falling-object hazards.'),

(7,'multiple_choice','foundational',
'What is the purpose of warning devices such as horns, alarms, lights, or spotter signals?',
'[{"key":"A","text":"To improve awareness and communication around moving equipment"},{"key":"B","text":"To replace operator visibility"},{"key":"C","text":"To allow faster travel"},{"key":"D","text":"To eliminate the need for pedestrian separation"}]'::jsonb,
'["A"]'::jsonb,
'Warning devices support awareness but do not replace safe operating practices or separation controls.'),

(8,'multiple_choice','foundational',
'What should happen if a forklift or material-handling machine has a serious defect found during inspection?',
'[{"key":"A","text":"It should be removed from service or handled according to the approved defect-control process until safe to use"},{"key":"B","text":"It should be used only for light loads"},{"key":"C","text":"Only experienced operators should use it"},{"key":"D","text":"The defect can be ignored if the machine still moves"}]'::jsonb,
'["A"]'::jsonb,
'Unsafe equipment should not remain in normal service until the defect is properly resolved.'),

(9,'situational_judgment','application',
'A forklift is approaching an intersection where the operator cannot see around a stack of materials. What is the BEST safe-work principle?',
'[{"key":"A","text":"Slow down, use appropriate warning or spotter controls, and do not proceed until the path can be entered safely"},{"key":"B","text":"Accelerate through the intersection"},{"key":"C","text":"Assume pedestrians will hear the equipment"},{"key":"D","text":"Drive through without stopping if the horn works"}]'::jsonb,
'["A"]'::jsonb,
'Limited visibility requires reduced speed and additional controls before entering a blind area.'),

(10,'situational_judgment','application',
'A worker begins walking behind a forklift that is preparing to back up. What is the BEST response?',
'[{"key":"A","text":"Stay clear of the backing path and establish awareness or communication before entering the area"},{"key":"B","text":"Walk quickly behind it before it moves"},{"key":"C","text":"Assume the backup alarm guarantees safety"},{"key":"D","text":"Touch the rear of the forklift so the operator knows someone is there"}]'::jsonb,
'["A"]'::jsonb,
'Workers should not enter a backing zone without clear separation and awareness.'),

(11,'multiple_choice','application',
'A load blocks the operator''s forward view. What is the BEST general principle?',
'[{"key":"A","text":"Use the approved travel method that preserves visibility and control, such as traveling in the permitted direction or using a spotter when required"},{"key":"B","text":"Lean outside the operator compartment while driving"},{"key":"C","text":"Raise the load higher to see underneath it"},{"key":"D","text":"Travel faster so the blocked-view distance is shorter"}]'::jsonb,
'["A"]'::jsonb,
'When a load obstructs visibility, the travel method should be adjusted using approved procedures rather than sacrificing control.'),

(12,'situational_judgment','application',
'A pallet appears unstable and several items are leaning before it is lifted. What is the BEST response?',
'[{"key":"A","text":"Stop and have the load stabilized or properly secured before it is moved"},{"key":"B","text":"Lift it slowly and hope it settles"},{"key":"C","text":"Raise it higher so the load has more clearance"},{"key":"D","text":"Have a worker hold the items while the forklift moves"}]'::jsonb,
'["A"]'::jsonb,
'Unstable loads should be corrected before lifting or transport to reduce falling-object and stability hazards.'),

(13,'multiple_choice','application',
'Why should workers stay out of pinch points between moving equipment and fixed objects?',
'[{"key":"A","text":"A person can be crushed if the equipment moves or turns unexpectedly"},{"key":"B","text":"Pinch points are reserved for operators"},{"key":"C","text":"They interfere with equipment fuel use"},{"key":"D","text":"They matter only when equipment is carrying a load"}]'::jsonb,
'["A"]'::jsonb,
'Caught-between hazards can occur wherever mobile equipment can close the space between itself and another object.'),

(14,'situational_judgment','application',
'A forklift operator cannot see a worker who is signaling from the far side of a load. What is the BEST response?',
'[{"key":"A","text":"Stop or hold the movement until clear communication and visibility are restored using the approved signaling method"},{"key":"B","text":"Continue based on the last signal received"},{"key":"C","text":"Guess what the worker probably wants"},{"key":"D","text":"Move the load faster so the signaler becomes visible sooner"}]'::jsonb,
'["A"]'::jsonb,
'Equipment movement should not continue when required communication is lost or ambiguous.'),

(15,'multiple_choice','application',
'A forklift is parked and unattended. Which principle is MOST important?',
'[{"key":"A","text":"The equipment should be secured according to the approved parking procedure so it cannot create an unintended movement or access hazard"},{"key":"B","text":"Leave the forks raised so they are easy to see"},{"key":"C","text":"Leave the key available for the next worker"},{"key":"D","text":"Park wherever loading will resume"}]'::jsonb,
'["A"]'::jsonb,
'Proper parking controls help prevent unintended movement and hazards from raised components or unauthorized use.'),

(16,'situational_judgment','application',
'A worker notices a forklift traveling too fast near pedestrians and stacked materials. What is the BEST response?',
'[{"key":"A","text":"Stay clear and report or address the unsafe operating condition through the appropriate site process"},{"key":"B","text":"Step into the travel path to force the operator to stop"},{"key":"C","text":"Ignore it because only the operator is responsible"},{"key":"D","text":"Try to match the forklift''s speed while walking beside it"}]'::jsonb,
'["A"]'::jsonb,
'Unsafe mobile-equipment operation should be addressed without creating additional exposure.'),

(17,'scenario','scenario',
'A delivery requires a forklift to move through an area where several workers are performing tasks on foot. What is the BEST approach?',
'[{"key":"A","text":"Coordinate the movement, control pedestrian access, and use the required communication or spotter process before the equipment enters"},{"key":"B","text":"Let the forklift proceed and expect workers to move out of the way"},{"key":"C","text":"Sound the horn continuously while driving through"},{"key":"D","text":"Ask workers to stand close to the equipment so the operator can see them"}]'::jsonb,
'["A"]'::jsonb,
'Mobile-equipment movement through pedestrian work areas should be coordinated and controlled rather than left to individual reaction.'),

(18,'scenario','scenario',
'A forklift is carrying a load that appears to exceed the equipment''s rated capacity. What is the BEST response?',
'[{"key":"A","text":"Do not proceed with the lift until the load and equipment capacity are verified and an appropriate handling method is selected"},{"key":"B","text":"Lift the load only a few inches above the ground"},{"key":"C","text":"Add a second worker to the operator compartment"},{"key":"D","text":"Travel slowly and ignore the capacity concern"}]'::jsonb,
'["A"]'::jsonb,
'Capacity concerns must be resolved before the lift because reduced travel speed does not correct an overloaded condition.'),

(19,'scenario','scenario',
'A worker sees hydraulic fluid leaking from a forklift and the forks drift downward after being raised. What is the BEST response?',
'[{"key":"A","text":"Keep people clear and remove the equipment from service through the approved defect process"},{"key":"B","text":"Continue using it only for short lifts"},{"key":"C","text":"Place a worker beneath the forks to watch the leak"},{"key":"D","text":"Add more load so the forks remain stable"}]'::jsonb,
'["A"]'::jsonb,
'Leaking hydraulics and unintended fork movement indicate an unsafe equipment condition requiring removal from service.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 1 proficiency in Forklift & Material Equipment Awareness?',
'[{"key":"A","text":"Operating equipment whenever a supervisor is nearby"},{"key":"B","text":"Recognizing operator-authorization limits, equipment defects, capacity concerns, blind spots, pedestrian hazards, unstable loads, communication needs, and safe separation around material-handling equipment"},{"key":"C","text":"Relying on backup alarms as the primary safety control"},{"key":"D","text":"Entering equipment operating areas whenever the operator appears to see you"}]'::jsonb,
'["B"]'::jsonb,
'Level 1 proficiency means recognizing key hazards and safe-work boundaries around forklifts and other material-handling equipment without assuming authorization to operate them.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'e53cb151-504a-4ab2-87d6-af4f11fe6686';
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
      and c.name = 'Forklift & Material Equipment Awareness'
      and c.is_current = true
  ) then
    raise exception 'Current Forklift & Material Equipment Awareness Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Construction Worker L2 safety requirement not found';
  end if;



  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 1
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 8
      and s.application_count = 8
      and s.scenario_count = 4
  ) then
    raise exception 'Expected current L1 assessment standard 20 / 8 / 8 / 4 not found';
  end if;

  -- ========================================================================
  -- Seed Level 1
  v_level := 1;
  v_role_template_id := '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid;
  v_assessment_name := 'Forklift & Material Equipment Awareness — Level 1 Competency Assessment';

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
    select * from _seed_forklift_material_equipment_awareness_l1_questions
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
        'Forklift & Material Equipment Awareness',
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
      'IntegrateU Forklift & Material Equipment Awareness L1 production assessment v1.0.',
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
        'Forklift & Material Equipment Awareness',
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
        'IntegrateU Forklift & Material Equipment Awareness L1 production assessment v1.0.',
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
   'e53cb151-504a-4ab2-87d6-af4f11fe6686'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'e53cb151-504a-4ab2-87d6-af4f11fe6686'::uuid
  and a.target_level = 1
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
      'e53cb151-504a-4ab2-87d6-af4f11fe6686'::uuid
    and a.target_level = 1
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
