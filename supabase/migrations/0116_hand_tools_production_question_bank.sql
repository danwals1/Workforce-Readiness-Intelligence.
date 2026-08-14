-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0116_hand_tools_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Hand Tools
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

create temporary table _seed_hand_tools_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hand_tools_l2_questions (
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
'What is the BEST first step before using a construction hand tool?',
'[{"key":"A","text":"Confirm the tool is appropriate for the task and inspect it for condition and defects"},{"key":"B","text":"Use it briefly to see whether it works"},{"key":"C","text":"Modify it if it does not fit the task"},{"key":"D","text":"Choose whichever tool is closest"}]'::jsonb,
'["A"]'::jsonb,
'Proper hand-tool use begins with selecting the correct tool and checking that it is in serviceable condition.'),

(2,'multiple_choice','foundational',
'Why should the correct size wrench be used on a fastener?',
'[{"key":"A","text":"It improves control and reduces the chance of slipping or damaging the fastener"},{"key":"B","text":"It makes every fastener tighter"},{"key":"C","text":"It eliminates the need to inspect the wrench"},{"key":"D","text":"It prevents the need for other tools"}]'::jsonb,
'["A"]'::jsonb,
'Using the correct size improves fit, control, and the likelihood of applying force without damaging the fastener.'),

(3,'multiple_choice','foundational',
'What is the purpose of keeping cutting tools sharp and properly maintained?',
'[{"key":"A","text":"To improve control, cutting performance, and consistency"},{"key":"B","text":"To make the tool heavier"},{"key":"C","text":"To allow the tool to be used for unrelated tasks"},{"key":"D","text":"To eliminate the need for workpiece support"}]'::jsonb,
'["A"]'::jsonb,
'Well-maintained cutting edges generally require less uncontrolled force and produce more predictable results.'),

(4,'multiple_choice','foundational',
'Why should striking tools be checked for damaged handles or mushroomed striking surfaces?',
'[{"key":"A","text":"Damage can reduce control or cause pieces to break, slip, or separate during use"},{"key":"B","text":"Only because damaged tools look unprofessional"},{"key":"C","text":"Because every damaged tool can be repaired in the field"},{"key":"D","text":"Only to determine the tool age"}]'::jsonb,
'["A"]'::jsonb,
'Visible tool damage can affect safe control and tool integrity during use.'),

(5,'multiple_choice','foundational',
'What is the BEST general practice for storing hand tools after use?',
'[{"key":"A","text":"Clean and return them to an organized location that protects the tools and work area"},{"key":"B","text":"Leave them where the task was completed"},{"key":"C","text":"Place sharp tools loose in a pocket"},{"key":"D","text":"Store damaged and serviceable tools together"}]'::jsonb,
'["A"]'::jsonb,
'Organized storage protects tools, reduces loss, and supports orderly work areas.'),

(6,'situational_judgment','application',
'A screwdriver tip is badly worn and slips repeatedly from the screw head. What is the BEST response?',
'[{"key":"A","text":"Use a serviceable screwdriver of the correct type and size"},{"key":"B","text":"Apply more force to the worn screwdriver"},{"key":"C","text":"Strike the handle with a hammer"},{"key":"D","text":"Continue if the screw is almost installed"}]'::jsonb,
'["A"]'::jsonb,
'A worn or incorrect screwdriver reduces control and can damage both the tool and fastener.'),

(7,'multiple_select','application',
'Which THREE factors support appropriate hand-tool selection?',
'[{"key":"A","text":"The task being performed"},{"key":"B","text":"The material or fastener involved"},{"key":"C","text":"The tool size, type, and condition"},{"key":"D","text":"Which tool is the newest"},{"key":"E","text":"Which tool is easiest to carry"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Tool selection should match the task, material, and required size or type while ensuring the tool is serviceable.'),

(8,'situational_judgment','application',
'A hammer has a loose head. What should the worker do?',
'[{"key":"A","text":"Remove the hammer from use until it is properly repaired or replaced"},{"key":"B","text":"Use it only for light blows"},{"key":"C","text":"Hold the head in place while swinging"},{"key":"D","text":"Wrap tape around the head and continue"}]'::jsonb,
'["A"]'::jsonb,
'A loose striking head can separate during use and should be corrected before the tool returns to service.'),

(9,'multiple_choice','application',
'What is the BEST practice when using a utility knife to cut material?',
'[{"key":"A","text":"Support the material and maintain a controlled cutting path away from body exposure where practical"},{"key":"B","text":"Cut toward the supporting hand"},{"key":"C","text":"Extend the blade farther than needed"},{"key":"D","text":"Use a dull blade so it cuts more slowly"}]'::jsonb,
'["A"]'::jsonb,
'Controlled cutting includes stable work support and a deliberate cutting path.'),

(10,'situational_judgment','application',
'A worker needs additional leverage on a wrench and wants to slide a pipe over the handle. What is the BEST response?',
'[{"key":"A","text":"Use a tool or method designed for the required torque or leverage rather than improvising an extension"},{"key":"B","text":"Use the pipe if it fits tightly"},{"key":"C","text":"Use a longer pipe for better control"},{"key":"D","text":"Strike the pipe with a hammer"}]'::jsonb,
'["A"]'::jsonb,
'Improvised extensions can overload or damage tools and reduce predictable control.'),

(11,'multiple_choice','application',
'Why should a workpiece be secured when appropriate before filing, sawing, chiseling, or similar hand-tool work?',
'[{"key":"A","text":"A stable workpiece improves control and reduces unintended movement"},{"key":"B","text":"It guarantees the task will be completed faster"},{"key":"C","text":"It removes the need to select the correct tool"},{"key":"D","text":"It allows more force to be used regardless of the material"}]'::jsonb,
'["A"]'::jsonb,
'Stable work support helps the worker maintain tool control and consistent results.'),

(12,'situational_judgment','application',
'A chisel has a heavily mushroomed striking end. What is the BEST response?',
'[{"key":"A","text":"Remove it from service until the condition is properly corrected or the tool is replaced"},{"key":"B","text":"Continue using it with lighter hammer blows"},{"key":"C","text":"Use the mushroomed end as a larger striking surface"},{"key":"D","text":"Grip the striking end with pliers"}]'::jsonb,
'["A"]'::jsonb,
'A mushroomed striking end can chip or spall and should be corrected before continued use.'),

(13,'multiple_choice','application',
'A worker needs to pull a nail from finished material with minimal surface damage. What is the BEST approach?',
'[{"key":"A","text":"Use an appropriate pulling tool and protect the finished surface as needed"},{"key":"B","text":"Use the largest pry bar available regardless of access"},{"key":"C","text":"Strike the nail sideways"},{"key":"D","text":"Twist the material until the nail releases"}]'::jsonb,
'["A"]'::jsonb,
'Correct tool selection and surface protection support controlled removal and workmanship.'),

(14,'situational_judgment','application',
'A tape measure blade is cracked and sharply bent near the end. What is the BEST response?',
'[{"key":"A","text":"Replace or remove the damaged tape from service rather than continuing to handle the damaged blade"},{"key":"B","text":"Straighten it repeatedly by hand"},{"key":"C","text":"Keep using it for short measurements"},{"key":"D","text":"Cover only the visible crack with marker"}]'::jsonb,
'["A"]'::jsonb,
'Damaged measuring tools can cause handling issues and may also compromise reliable measurement.'),

(15,'scenario','scenario',
'A worker repeatedly damages fastener heads because the same driver is being used for several different screw types. What is the BEST improvement?',
'[{"key":"A","text":"Match the driver type and size to each fastener before applying force"},{"key":"B","text":"Increase pressure on the same driver"},{"key":"C","text":"Use pliers on every screw head"},{"key":"D","text":"Strike the driver to force engagement"}]'::jsonb,
'["A"]'::jsonb,
'Correct driver selection improves engagement, control, and workmanship.'),

(16,'scenario','scenario',
'A worker is cutting a small piece of material while holding it in one hand because a vise is several steps away. What is the BEST response?',
'[{"key":"A","text":"Secure the workpiece appropriately before making the cut"},{"key":"B","text":"Continue as long as the cut is short"},{"key":"C","text":"Hold the material closer to the cutting line"},{"key":"D","text":"Use more cutting force so the task finishes faster"}]'::jsonb,
'["A"]'::jsonb,
'Workpiece stability is a basic part of controlled hand-tool use.'),

(17,'scenario','scenario',
'A crew''s tool box contains several damaged tools mixed with serviceable tools, and workers keep picking them up by mistake. What is the BEST response?',
'[{"key":"A","text":"Separate damaged tools from serviceable inventory and route them for repair, replacement, or disposition"},{"key":"B","text":"Mark the damaged tools only if someone complains"},{"key":"C","text":"Keep all tools together so workers can choose"},{"key":"D","text":"Place damaged tools at the bottom of the box"}]'::jsonb,
'["A"]'::jsonb,
'Controlling damaged tools prevents them from being unintentionally returned to use.'),

(18,'scenario','scenario',
'A worker needs to remove a component but only has tools that do not fit the fastener correctly. What is the BEST response?',
'[{"key":"A","text":"Obtain the correct tool before proceeding rather than forcing the available tools"},{"key":"B","text":"Use the closest size and apply more force"},{"key":"C","text":"Round the fastener deliberately so pliers can grip it"},{"key":"D","text":"Modify the available tool in the field"}]'::jsonb,
'["A"]'::jsonb,
'Using the correct tool reduces damage and improves predictable control of the task.'),

(19,'scenario','scenario',
'A worker completes a task and leaves sharp cutting tools hidden under scrap material on a bench. What is the BEST correction?',
'[{"key":"A","text":"Remove the tools, store them appropriately, and restore the work area before leaving"},{"key":"B","text":"Leave them because the task is complete"},{"key":"C","text":"Cover them with more scrap so they are not visible"},{"key":"D","text":"Move them to the floor"}]'::jsonb,
'["A"]'::jsonb,
'Proper tool storage and housekeeping are part of completing hand-tool work responsibly.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Hand Tools?',
'[{"key":"A","text":"Using familiar tools for any task and replacing them only after failure"},{"key":"B","text":"Reliably selecting the correct common hand tool, inspecting its condition, using it with good control and workpiece support, maintaining it appropriately, and removing damaged tools from service"},{"key":"C","text":"Using maximum force whenever a tool slips"},{"key":"D","text":"Keeping damaged tools available for lighter work"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means consistently selecting, inspecting, using, maintaining, and storing common hand tools appropriately in routine construction work.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'e6486ea7-683d-4e98-b654-df8862a84ef2';
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
      and c.name = 'Hand Tools'
      and c.is_current = true
  ) then
    raise exception 'Current Hand Tools Master Competency not found';
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
  v_assessment_name := 'Hand Tools — Level 2 Competency Assessment';

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
    select * from _seed_hand_tools_l2_questions
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
        'Hand Tools',
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
      'IntegrateU Hand Tools L2 production assessment v1.0.',
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
        'Hand Tools',
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
        'IntegrateU Hand Tools L2 production assessment v1.0.',
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
   'e6486ea7-683d-4e98-b654-df8862a84ef2'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'e6486ea7-683d-4e98-b654-df8862a84ef2'::uuid
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
      'e6486ea7-683d-4e98-b654-df8862a84ef2'::uuid
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
