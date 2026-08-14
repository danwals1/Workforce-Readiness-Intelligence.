-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0118_power_tools_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Power Tools
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

create temporary table _seed_power_tools_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_power_tools_l2_questions (
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
'What is the BEST first step before operating a construction power tool?',
'[{"key":"A","text":"Confirm the tool is appropriate for the task and inspect the tool, guard, cord or battery, and accessories"},{"key":"B","text":"Start the tool briefly to see whether it sounds normal"},{"key":"C","text":"Remove the guard if it limits visibility"},{"key":"D","text":"Choose whichever tool is already plugged in"}]'::jsonb,
'["A"]'::jsonb,
'Power-tool use should begin with proper selection and inspection of the complete tool system.'),

(2,'multiple_choice','foundational',
'Why are manufacturer guards and protective devices important on power tools?',
'[{"key":"A","text":"They help control exposure to moving parts, debris, and other tool-specific hazards"},{"key":"B","text":"They are mainly cosmetic"},{"key":"C","text":"They are needed only for inexperienced workers"},{"key":"D","text":"They can be removed whenever production is slowed"}]'::jsonb,
'["A"]'::jsonb,
'Guards and protective devices are part of the tool''s intended safety system and should remain correctly installed and functional.'),

(3,'multiple_choice','foundational',
'Why should the accessory on a power tool be matched to the tool and task?',
'[{"key":"A","text":"The accessory must be suitable for the material, tool speed, attachment method, and intended operation"},{"key":"B","text":"Any accessory that physically fits is acceptable"},{"key":"C","text":"Accessory selection affects appearance only"},{"key":"D","text":"Accessories are interchangeable across all power tools"}]'::jsonb,
'["A"]'::jsonb,
'Correct accessory selection is essential to predictable tool performance and safe operation.'),

(4,'multiple_choice','foundational',
'What should happen to a power tool with a damaged cord, cracked housing, defective switch, or missing guard?',
'[{"key":"A","text":"Remove it from service until it is properly repaired or replaced"},{"key":"B","text":"Use it only for short tasks"},{"key":"C","text":"Let the most experienced worker use it"},{"key":"D","text":"Mark the damage and continue using it"}]'::jsonb,
'["A"]'::jsonb,
'Defective power tools should not remain available for normal use.'),

(5,'multiple_choice','foundational',
'Why should a workpiece be secured when appropriate before drilling, cutting, grinding, or similar power-tool work?',
'[{"key":"A","text":"A stable workpiece improves control and reduces unintended movement during the operation"},{"key":"B","text":"It allows every tool to be used one-handed"},{"key":"C","text":"It eliminates the need for correct accessories"},{"key":"D","text":"It guarantees the material will not be damaged"}]'::jsonb,
'["A"]'::jsonb,
'Stable work support helps maintain control of both the workpiece and the tool.'),

(6,'situational_judgment','application',
'A circular saw guard does not return freely after a cut. What is the BEST response?',
'[{"key":"A","text":"Remove the saw from service until the guard operates correctly"},{"key":"B","text":"Hold the guard open manually during the next cut"},{"key":"C","text":"Use the saw only for shallow cuts"},{"key":"D","text":"Lubricate it quickly and continue without checking"}]'::jsonb,
'["A"]'::jsonb,
'A malfunctioning guard compromises a critical protective feature and should be corrected before reuse.'),

(7,'multiple_select','application',
'Which THREE conditions should be checked before using a power tool?',
'[{"key":"A","text":"Tool and guard condition"},{"key":"B","text":"Correct accessory and attachment"},{"key":"C","text":"Work area and workpiece setup"},{"key":"D","text":"Whether the task can be completed faster without PPE"},{"key":"E","text":"Whether another worker already used the tool today"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Safe setup includes the tool, accessory, workpiece, and surrounding work conditions.'),

(8,'situational_judgment','application',
'A grinder wheel is damaged and has a visible chip. What is the BEST response?',
'[{"key":"A","text":"Do not use the wheel; replace it with a suitable undamaged wheel"},{"key":"B","text":"Use the undamaged side only"},{"key":"C","text":"Run the grinder at lower speed"},{"key":"D","text":"Use the wheel only on soft material"}]'::jsonb,
'["A"]'::jsonb,
'Damaged abrasive accessories can fail unpredictably and should be removed from service.'),

(9,'multiple_choice','application',
'Why should a power tool be disconnected from its energy source before changing many blades, bits, wheels, or accessories?',
'[{"key":"A","text":"To reduce the chance of unintended activation during the change"},{"key":"B","text":"Only to preserve battery charge"},{"key":"C","text":"Because accessories cannot be changed while a tool is warm"},{"key":"D","text":"To reset the tool speed"}]'::jsonb,
'["A"]'::jsonb,
'Controlling the tool''s energy source prevents accidental startup while hands are near the operating components.'),

(10,'situational_judgment','application',
'A worker is using a drill and the bit repeatedly binds in the material. What is the BEST response?',
'[{"key":"A","text":"Stop and evaluate the bit, tool setting, material, workpiece support, and drilling method before continuing"},{"key":"B","text":"Increase force until the bit breaks through"},{"key":"C","text":"Hold the drill loosely so it can rotate in the hands"},{"key":"D","text":"Switch to a damaged bit with fewer cutting edges"}]'::jsonb,
'["A"]'::jsonb,
'Repeated binding suggests a setup or technique issue that should be corrected rather than overcome with more force.'),

(11,'multiple_choice','application',
'What is the BEST practice when using an extension cord with a power tool?',
'[{"key":"A","text":"Use a cord suitable for the tool and work environment and inspect it for damage before use"},{"key":"B","text":"Use any cord that reaches the work area"},{"key":"C","text":"Connect multiple damaged cords if the tool runs normally"},{"key":"D","text":"Route the cord through standing water if it saves time"}]'::jsonb,
'["A"]'::jsonb,
'Extension cords should be suitable for the load and conditions and kept in serviceable condition.'),

(12,'situational_judgment','application',
'A worker removes a tool guard because it interferes with an awkward cut. What is the BEST response?',
'[{"key":"A","text":"Stop the operation and use an approved tool, setup, or method that allows the required protection to remain in place"},{"key":"B","text":"Continue if the worker has used the tool for many years"},{"key":"C","text":"Allow the cut if another worker watches"},{"key":"D","text":"Remove the guard only for the first half of the cut"}]'::jsonb,
'["A"]'::jsonb,
'An inconvenient setup does not justify bypassing required guarding.'),

(13,'multiple_choice','application',
'Why should loose clothing, jewelry, and long hair be controlled around rotating power tools?',
'[{"key":"A","text":"They can become caught in moving components"},{"key":"B","text":"They reduce battery life"},{"key":"C","text":"They interfere only with measuring accuracy"},{"key":"D","text":"They matter only when working outdoors"}]'::jsonb,
'["A"]'::jsonb,
'Rotating components can catch loose items and pull them toward the tool.'),

(14,'situational_judgment','application',
'A power tool begins making an unusual noise and vibrating more than normal. What is the BEST response?',
'[{"key":"A","text":"Stop using the tool and inspect or remove it from service until the cause is resolved"},{"key":"B","text":"Continue until the task is finished"},{"key":"C","text":"Hold the tool more tightly and increase speed"},{"key":"D","text":"Use it only on smaller workpieces"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected noise or vibration can indicate damage, a loose accessory, or another unsafe condition.'),

(15,'scenario','scenario',
'A worker needs to make a cut but the material is poorly supported and begins shifting when the saw contacts it. What is the BEST response?',
'[{"key":"A","text":"Stop and properly support or secure the material before continuing"},{"key":"B","text":"Use more cutting pressure"},{"key":"C","text":"Have another worker hold the material close to the blade"},{"key":"D","text":"Increase blade speed"}]'::jsonb,
'["A"]'::jsonb,
'Unstable workpieces can cause loss of tool control and should be secured before the operation continues.'),

(16,'scenario','scenario',
'A battery-powered tool has a cracked battery housing and the battery becomes unusually hot during use. What is the BEST response?',
'[{"key":"A","text":"Stop using the battery and tool combination and remove the damaged battery from service according to the approved process"},{"key":"B","text":"Cool the battery with water and continue"},{"key":"C","text":"Use the battery only for low-power tasks"},{"key":"D","text":"Tape the crack and recharge it"}]'::jsonb,
'["A"]'::jsonb,
'Physical damage and abnormal heating are signs that a battery should be removed from normal service.'),

(17,'scenario','scenario',
'A crew repeatedly trips over power cords crossing an active walkway. What is the BEST correction?',
'[{"key":"A","text":"Reroute, protect, suspend, or otherwise manage the cords so the walkway remains usable and the cords are protected"},{"key":"B","text":"Tell workers to step over the cords"},{"key":"C","text":"Add more cords so each tool has its own path"},{"key":"D","text":"Leave the cords because the tools are still operating"}]'::jsonb,
'["A"]'::jsonb,
'Cord management should protect both the electrical equipment and people using the work area.'),

(18,'scenario','scenario',
'A worker is unsure whether a blade is rated for the speed of the tool being used. What is the BEST response?',
'[{"key":"A","text":"Verify the blade and tool compatibility before operation"},{"key":"B","text":"Use the blade at the lowest available speed"},{"key":"C","text":"Install it and listen for unusual noise"},{"key":"D","text":"Use it only for a short cut"}]'::jsonb,
'["A"]'::jsonb,
'Accessory compatibility should be established before operation rather than tested under load.'),

(19,'scenario','scenario',
'A worker notices that several tools are being returned to storage with missing guards and damaged accessories. What is the BEST Level 2 response?',
'[{"key":"A","text":"Separate defective tools from serviceable equipment and report or route them for proper repair, replacement, or disposition"},{"key":"B","text":"Leave them in storage and let the next worker decide"},{"key":"C","text":"Use the defective tools only for simple tasks"},{"key":"D","text":"Mark the storage bin rather than the tools"}]'::jsonb,
'["A"]'::jsonb,
'Defective tools should be controlled so they are not unintentionally returned to use.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Power Tools?',
'[{"key":"A","text":"Using familiar power tools for any task as long as the tool turns on"},{"key":"B","text":"Reliably selecting, inspecting, setting up, and operating common power tools with correct guards and accessories, stable work support, appropriate energy control, and prompt removal of defective equipment"},{"key":"C","text":"Removing guards whenever access is difficult"},{"key":"D","text":"Continuing to use a tool until it fails completely"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means applying consistent tool-selection, inspection, setup, operating, and defect-control practices in routine construction work.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'f8787597-a9c2-4a86-b152-1287e296b87d';
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
      and c.name = 'Power Tools'
      and c.is_current = true
  ) then
    raise exception 'Current Power Tools Master Competency not found';
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
  v_assessment_name := 'Power Tools — Level 2 Competency Assessment';

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
    select * from _seed_power_tools_l2_questions
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
        'Power Tools',
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
      'IntegrateU Power Tools L2 production assessment v1.0.',
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
        'Power Tools',
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
        'IntegrateU Power Tools L2 production assessment v1.0.',
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
   'f8787597-a9c2-4a86-b152-1287e296b87d'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'f8787597-a9c2-4a86-b152-1287e296b87d'::uuid
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
      'f8787597-a9c2-4a86-b152-1287e296b87d'::uuid
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
