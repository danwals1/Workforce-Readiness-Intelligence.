-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0110_fall_protection_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Fall Protection
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Construction Worker -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_fall_protection_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_fall_protection_l3_questions (
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
'What is the primary purpose of a fall-protection system?',
'[{"key":"A","text":"To prevent a worker from falling or to safely arrest a fall when exposure cannot otherwise be eliminated"},{"key":"B","text":"To make elevated work faster"},{"key":"C","text":"To replace planning for elevated work"},{"key":"D","text":"To allow workers to work closer to unprotected edges"}]'::jsonb,
'["A"]'::jsonb,
'Fall protection is intended to prevent falls where feasible or safely arrest them when prevention is not possible.'),

(2,'multiple_choice','foundational',
'What is the main difference between fall restraint and fall arrest?',
'[{"key":"A","text":"Fall restraint prevents the worker from reaching a fall hazard, while fall arrest stops a fall after it begins"},{"key":"B","text":"Fall restraint is used only indoors"},{"key":"C","text":"Fall arrest prevents access to edges"},{"key":"D","text":"There is no functional difference"}]'::jsonb,
'["A"]'::jsonb,
'Restraint limits access to the fall exposure; arrest manages the forces and distance after a fall has begun.'),

(3,'multiple_choice','foundational',
'Why is anchorage selection important in a personal fall-arrest system?',
'[{"key":"A","text":"The anchorage must be suitable for the intended system and positioned to support safe fall-arrest performance"},{"key":"B","text":"Any nearby pipe or conduit can serve as an anchorage"},{"key":"C","text":"Anchorage location affects comfort only"},{"key":"D","text":"Anchorage strength matters only after an incident"}]'::jsonb,
'["A"]'::jsonb,
'Anchorage strength, suitability, and location are essential to system performance.'),

(4,'multiple_choice','foundational',
'Why must fall-protection equipment be inspected before use?',
'[{"key":"A","text":"To identify damage, deterioration, alteration, or other conditions that could make the equipment unsafe"},{"key":"B","text":"Only to verify the equipment color"},{"key":"C","text":"To eliminate the need for periodic inspections"},{"key":"D","text":"Only because new equipment is likely to fail"}]'::jsonb,
'["A"]'::jsonb,
'Pre-use inspection helps identify defects that could compromise fall-protection performance.'),

(5,'situational_judgment','application',
'A worker discovers a cut in the webbing of a harness during the pre-use inspection. What is the BEST response?',
'[{"key":"A","text":"Remove the harness from service and follow the approved process for evaluation or replacement"},{"key":"B","text":"Use the harness for low-height work only"},{"key":"C","text":"Cover the cut with tape"},{"key":"D","text":"Use it if the cut is not near a buckle"}]'::jsonb,
'["A"]'::jsonb,
'Damaged fall-protection equipment should not remain in service unless it has been evaluated and approved through the proper process.'),

(6,'multiple_select','application',
'Which THREE factors should be considered when planning a personal fall-arrest setup?',
'[{"key":"A","text":"Available fall clearance"},{"key":"B","text":"Anchorage location and suitability"},{"key":"C","text":"Potential swing-fall exposure"},{"key":"D","text":"Whether the worker prefers a longer free fall"},{"key":"E","text":"How quickly the task can be completed"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Clearance, anchorage, and swing-fall exposure are key system-planning considerations.'),

(7,'situational_judgment','application',
'A worker using a self-retracting device moves far to the side of the anchorage, creating a large lateral angle. What hazard should be evaluated?',
'[{"key":"A","text":"Swing fall and contact with nearby structures"},{"key":"B","text":"Only sun exposure"},{"key":"C","text":"Reduced tool productivity"},{"key":"D","text":"Noise from the device"}]'::jsonb,
'["A"]'::jsonb,
'Working laterally from an anchorage can create swing-fall hazards and dangerous impact paths.'),

(8,'multiple_choice','application',
'What is the BEST reason to keep a work area below elevated operations controlled when falling-object exposure exists?',
'[{"key":"A","text":"To prevent people from entering an area where tools or materials could strike them"},{"key":"B","text":"To reserve the area for supervisors"},{"key":"C","text":"To make material storage easier"},{"key":"D","text":"To reduce paperwork"}]'::jsonb,
'["A"]'::jsonb,
'Fall protection planning also includes controlling hazards created for people below elevated work.'),

(9,'situational_judgment','application',
'A guardrail section has been temporarily removed to move materials. What should happen before workers continue normal activity near the opening?',
'[{"key":"A","text":"Restore the guardrail or establish another approved fall-protection control before exposure resumes"},{"key":"B","text":"Place a tool box near the opening as a reminder"},{"key":"C","text":"Allow experienced workers to work nearby without protection"},{"key":"D","text":"Continue if the opening is visible"}]'::jsonb,
'["A"]'::jsonb,
'Removal of a fall-prevention control requires another effective control until the original protection is restored.'),

(10,'multiple_choice','application',
'Why must a worker account for total fall clearance rather than only lanyard length?',
'[{"key":"A","text":"Because the system may include free-fall distance, deceleration, connector length, worker geometry, and a safety margin"},{"key":"B","text":"Because lanyard length never matters"},{"key":"C","text":"Because clearance is determined only by worker height"},{"key":"D","text":"Because fall-arrest systems stop instantly with no additional travel"}]'::jsonb,
'["A"]'::jsonb,
'Safe clearance requires considering the full system movement and worker position, not just one component.'),

(11,'situational_judgment','application',
'A worker has connected a lanyard to an anchorage at foot level even though the equipment instructions limit that configuration. What is the BEST response?',
'[{"key":"A","text":"Stop and use a configuration permitted by the equipment and site fall-protection plan"},{"key":"B","text":"Continue because any connection is better than none"},{"key":"C","text":"Shorten the lanyard with a knot"},{"key":"D","text":"Use the configuration only when no supervisor is present"}]'::jsonb,
'["A"]'::jsonb,
'Fall-protection components must be used within their approved configuration and limitations.'),

(12,'scenario','scenario',
'A crew is preparing to work near an unprotected roof edge. The proposed anchorage would require workers to cross the exposed area before they could connect. What is the BEST plan?',
'[{"key":"A","text":"Establish a method that protects workers before they enter the fall-exposure zone"},{"key":"B","text":"Have workers move quickly to the anchorage"},{"key":"C","text":"Allow the first worker to cross without protection and connect a line for everyone else"},{"key":"D","text":"Proceed only during daylight"}]'::jsonb,
'["A"]'::jsonb,
'The protection plan must address access to the work area, not just the worker''s condition after reaching the anchorage.'),

(13,'scenario','scenario',
'A worker using a fall-arrest system could strike structural steel below before the system fully arrests a fall. What should be done?',
'[{"key":"A","text":"Change the system, anchorage, work position, or other controls so adequate clearance exists before work begins"},{"key":"B","text":"Proceed because the worker is tied off"},{"key":"C","text":"Add a second identical lanyard without evaluating the system"},{"key":"D","text":"Tell the worker to avoid falling"}]'::jsonb,
'["A"]'::jsonb,
'Being connected is not enough; the complete system must provide sufficient clearance to prevent impact.'),

(14,'scenario','scenario',
'A worker falls and is suspended in a personal fall-arrest system without obvious injury. What should the crew do?',
'[{"key":"A","text":"Initiate the site rescue procedure promptly and obtain appropriate medical evaluation"},{"key":"B","text":"Leave the worker suspended until the shift ends"},{"key":"C","text":"Tell the worker to disconnect and climb down without assistance"},{"key":"D","text":"Wait to see if the worker feels uncomfortable"}]'::jsonb,
'["A"]'::jsonb,
'A fall event requires prompt rescue response; prolonged suspension can create additional hazards.'),

(15,'scenario','scenario',
'After a fall-arrest event, the harness and connecting equipment appear visually undamaged. What is the BEST action?',
'[{"key":"A","text":"Remove equipment involved in the fall from service and handle it according to the manufacturer and site procedure before any reuse"},{"key":"B","text":"Return everything immediately to service because no damage is visible"},{"key":"C","text":"Reuse it only for workers under a certain weight"},{"key":"D","text":"Wash the equipment and return it to storage"}]'::jsonb,
'["A"]'::jsonb,
'Equipment subjected to a fall event requires controlled evaluation and disposition even when obvious damage is absent.'),

(16,'scenario','scenario',
'A worker must perform a short task from a platform where one section of edge protection is missing. The task is expected to take less than two minutes. What is the BEST response?',
'[{"key":"A","text":"Establish the required fall protection before performing the task regardless of its short duration"},{"key":"B","text":"Perform the task quickly without protection"},{"key":"C","text":"Have another worker watch from below"},{"key":"D","text":"Use caution tape as the only protection"}]'::jsonb,
'["A"]'::jsonb,
'Short task duration does not eliminate a fall hazard.'),

(17,'scenario','scenario',
'During a pre-task review, the crew determines that the selected anchorage will create severe swing-fall exposure if a worker falls. What is the BEST response?',
'[{"key":"A","text":"Select a better anchorage or change the work method to reduce the swing-fall hazard before exposure begins"},{"key":"B","text":"Use the original anchorage because it is structurally strong"},{"key":"C","text":"Add more slack to the connecting device"},{"key":"D","text":"Proceed if the worker understands the risk"}]'::jsonb,
'["A"]'::jsonb,
'Anchorage planning must account for both strength and the worker''s possible fall path.'),

(18,'scenario','scenario',
'Several workers repeatedly disconnect from their fall-protection systems to move around an obstruction. What is the BEST supervisory response?',
'[{"key":"A","text":"Stop the unsafe practice and redesign the access, anchorage, lifeline, or work method so continuous required protection can be maintained"},{"key":"B","text":"Allow brief disconnections if workers announce them"},{"key":"C","text":"Ignore the issue because the workers reconnect afterward"},{"key":"D","text":"Tell workers to move faster while disconnected"}]'::jsonb,
'["A"]'::jsonb,
'Repeated disconnection usually indicates that the planned protection system does not fit the work and should be corrected.'),

(19,'scenario','scenario',
'A project has compliant fall-protection equipment available, but workers frequently use different combinations of connectors and devices without checking compatibility. What is the BEST response?',
'[{"key":"A","text":"Verify that components are compatible and used as an approved system before allowing continued use"},{"key":"B","text":"Assume all fall-protection components are interchangeable"},{"key":"C","text":"Allow any combination if it can physically connect"},{"key":"D","text":"Evaluate compatibility only after an incident"}]'::jsonb,
'["A"]'::jsonb,
'Fall-protection components must function together as an appropriate system; physical connection alone does not establish compatibility.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Fall Protection?',
'[{"key":"A","text":"Wearing a harness whenever working anywhere on a job site"},{"key":"B","text":"Independently recognizing fall exposures, selecting and inspecting appropriate protection, evaluating anchorage, clearance and swing hazards, maintaining protection through the task, and responding correctly to deficiencies or a fall event"},{"key":"C","text":"Using whatever tie-off point is closest"},{"key":"D","text":"Relying on experience instead of pre-task planning"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 proficiency means applying fall-protection principles reliably to changing field conditions, not merely possessing or wearing equipment.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '6a30e43d-52ed-4403-bfcf-5c575cbfeb83';
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
      and c.name = 'Fall Protection'
      and c.is_current = true
  ) then
    raise exception 'Current Fall Protection Master Competency not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Construction Worker L3 safety requirement not found';
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
  -- Seed Level 3
  v_level := 3;
  v_role_template_id := '0f5d7696-f36f-4413-b617-ee20f8c15a9f'::uuid;
  v_assessment_name := 'Fall Protection — Level 3 Competency Assessment';

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
    select * from _seed_fall_protection_l3_questions
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
        'Fall Protection',
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
      'IntegrateU Fall Protection L3 production assessment v1.0.',
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
        'Fall Protection',
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
        'IntegrateU Fall Protection L3 production assessment v1.0.',
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
   '6a30e43d-52ed-4403-bfcf-5c575cbfeb83'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '6a30e43d-52ed-4403-bfcf-5c575cbfeb83'::uuid
  and a.target_level = 3
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
      '6a30e43d-52ed-4403-bfcf-5c575cbfeb83'::uuid
    and a.target_level = 3
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
