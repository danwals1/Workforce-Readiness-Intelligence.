-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0119_powered_specialty_tool_safety_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Powered & Specialty Tool Safety
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

create temporary table _seed_powered_specialty_tool_safety_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_powered_specialty_tool_safety_l2_questions (
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
'What is the BEST first step before using a powered or specialty construction tool?',
'[{"key":"A","text":"Confirm you are trained or authorized for the tool, verify it is appropriate for the task, and inspect its condition and safeguards"},{"key":"B","text":"Operate it briefly to learn how it responds"},{"key":"C","text":"Remove unfamiliar guards before starting"},{"key":"D","text":"Use whichever tool another worker recommends"}]'::jsonb,
'["A"]'::jsonb,
'Higher-risk and specialty tools require deliberate verification of authorization, suitability, condition, and protective features before use.'),

(2,'multiple_choice','foundational',
'Why are controlled-use procedures important for certain specialty tools?',
'[{"key":"A","text":"They help ensure only properly prepared workers use the equipment under defined conditions and methods"},{"key":"B","text":"They exist mainly to slow production"},{"key":"C","text":"They eliminate the need for tool inspection"},{"key":"D","text":"They allow guards to be removed when necessary"}]'::jsonb,
'["A"]'::jsonb,
'Controlled-use procedures help manage higher-risk equipment through authorization, setup, operating, and supervision requirements.'),

(3,'multiple_choice','foundational',
'What should a worker understand before using a specialty tool with stored, pneumatic, hydraulic, explosive, or other significant energy?',
'[{"key":"A","text":"The tool''s energy source, hazards, operating limits, controls, and safe shutdown or isolation method"},{"key":"B","text":"Only where the trigger is located"},{"key":"C","text":"Only how quickly the tool completes the task"},{"key":"D","text":"That all energy sources behave the same way"}]'::jsonb,
'["A"]'::jsonb,
'Safety depends on understanding how the tool is energized, controlled, stopped, and isolated.'),

(4,'multiple_choice','foundational',
'Why should manufacturer instructions and site-specific requirements be followed for specialty tools?',
'[{"key":"A","text":"These tools may have operating limitations, setup requirements, and hazards that are not obvious from appearance alone"},{"key":"B","text":"Instructions apply only to new operators"},{"key":"C","text":"Site requirements replace manufacturer limitations"},{"key":"D","text":"Experienced workers may ignore both"}]'::jsonb,
'["A"]'::jsonb,
'Specialty equipment often has tool-specific requirements that must be understood before operation.'),

(5,'multiple_choice','foundational',
'What should happen when a required safeguard, interlock, shield, restraint, or control is missing or not functioning?',
'[{"key":"A","text":"Remove the equipment from use until the required protective feature is restored or the condition is otherwise properly resolved"},{"key":"B","text":"Operate it only at reduced speed"},{"key":"C","text":"Use it if a supervisor is watching"},{"key":"D","text":"Post a warning and continue"}]'::jsonb,
'["A"]'::jsonb,
'A defective or bypassed protective feature is a reason to stop using the equipment.'),

(6,'situational_judgment','application',
'A worker is asked to use a powder-actuated tool but has not received the required training or authorization. What is the BEST response?',
'[{"key":"A","text":"Do not operate the tool until the required training or authorization is completed"},{"key":"B","text":"Have another worker demonstrate one fastener and then proceed"},{"key":"C","text":"Use the tool only on soft material"},{"key":"D","text":"Operate it if the supervisor remains nearby"}]'::jsonb,
'["A"]'::jsonb,
'Controlled-use equipment should not be operated without the required preparation and authorization.'),

(7,'multiple_select','application',
'Which THREE items should be verified before using higher-risk powered or specialty equipment?',
'[{"key":"A","text":"Operator qualification or authorization where required"},{"key":"B","text":"Tool condition and protective systems"},{"key":"C","text":"Work area, material, accessory, and operating setup"},{"key":"D","text":"Whether safeguards can be removed to improve access"},{"key":"E","text":"Whether the task can be completed before anyone notices"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Safe specialty-tool use depends on qualified operation, functional protective systems, and a suitable work setup.'),

(8,'situational_judgment','application',
'A pneumatic tool hose has a damaged fitting that leaks and occasionally separates under pressure. What is the BEST response?',
'[{"key":"A","text":"Remove the tool and hose setup from service until the connection is properly repaired or replaced"},{"key":"B","text":"Hold the fitting together during use"},{"key":"C","text":"Reduce pressure slightly and continue"},{"key":"D","text":"Wrap the fitting with tape"}]'::jsonb,
'["A"]'::jsonb,
'Pressurized connections that leak or separate are uncontrolled-energy hazards and should be corrected before use.'),

(9,'multiple_choice','application',
'Why should a worker verify that an accessory is specifically compatible with a specialty tool?',
'[{"key":"A","text":"Incorrect accessories can fail, detach, overload the tool, or create an uncontrolled operating condition"},{"key":"B","text":"Accessories affect only productivity"},{"key":"C","text":"Any accessory that fits the connection is acceptable"},{"key":"D","text":"Compatibility matters only after the first use"}]'::jsonb,
'["A"]'::jsonb,
'Physical fit alone does not establish that an accessory is rated or designed for the equipment.'),

(10,'situational_judgment','application',
'A specialty saw or cutter requires a specific guard position for the intended operation, but the guard prevents the planned cut. What is the BEST response?',
'[{"key":"A","text":"Use a different approved setup, tool, or method rather than defeating the required guard"},{"key":"B","text":"Remove the guard for the difficult portion of the cut"},{"key":"C","text":"Hold the guard open manually"},{"key":"D","text":"Proceed if the worker has extensive experience"}]'::jsonb,
'["A"]'::jsonb,
'If a required safeguard makes the planned method impractical, the work method should change rather than the safeguard being defeated.'),

(11,'multiple_choice','application',
'Why should bystanders and unrelated workers be controlled around some specialty-tool operations?',
'[{"key":"A","text":"The operation may create projectiles, noise, debris, pressure release, sparks, or other hazards beyond the immediate operator position"},{"key":"B","text":"Only to give the operator more room"},{"key":"C","text":"Because specialty tools always require an empty building"},{"key":"D","text":"To prevent workers from learning how the tool works"}]'::jsonb,
'["A"]'::jsonb,
'Higher-risk equipment can create an exposure zone that extends beyond the operator.'),

(12,'situational_judgment','application',
'A tool with a trigger lock or interlock operates even when the protective condition is not satisfied. What is the BEST response?',
'[{"key":"A","text":"Stop using the tool and remove it from service until the safety-control defect is resolved"},{"key":"B","text":"Continue because the tool still performs its main function"},{"key":"C","text":"Label the defect and let experienced workers use it"},{"key":"D","text":"Use it only for low-risk material"}]'::jsonb,
'["A"]'::jsonb,
'A failed interlock or safety control indicates that the equipment is not functioning as intended.'),

(13,'multiple_choice','application',
'What is the BEST practice before clearing a jam or servicing the operating area of a powered specialty tool?',
'[{"key":"A","text":"Control or isolate the tool''s energy according to the required procedure before placing hands near the hazard area"},{"key":"B","text":"Keep the trigger depressed so the tool does not restart unexpectedly"},{"key":"C","text":"Ask another worker to hold the tool"},{"key":"D","text":"Clear the jam while the tool is still energized if the task is quick"}]'::jsonb,
'["A"]'::jsonb,
'Energy must be controlled before hands enter areas that could move, cycle, discharge, or release stored energy.'),

(14,'situational_judgment','application',
'A worker notices that a specialty tool is cycling inconsistently and occasionally activates later than expected. What is the BEST response?',
'[{"key":"A","text":"Stop using the tool and have the abnormal behavior evaluated before further operation"},{"key":"B","text":"Continue while keeping a tighter grip"},{"key":"C","text":"Cycle the tool repeatedly until it becomes consistent"},{"key":"D","text":"Use it only when no one else is nearby"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected activation timing indicates a control or equipment problem that can create serious hazards.'),

(15,'scenario','scenario',
'A worker is preparing a powder-actuated tool operation near the opposite side of a wall where other workers may be present. What is the BEST response?',
'[{"key":"A","text":"Evaluate the material and penetration hazard, control the affected area, and follow the tool-specific safe-use requirements before firing"},{"key":"B","text":"Proceed because the fastener is intended to remain in the wall"},{"key":"C","text":"Ask nearby workers to listen for the shot"},{"key":"D","text":"Use a higher power level so the fastener seats properly"}]'::jsonb,
'["A"]'::jsonb,
'Some specialty-tool operations can create hazards through or beyond the work surface, so the full exposure area must be controlled.'),

(16,'scenario','scenario',
'A pressurized tool is disconnected, but stored pressure remains in part of the system. A worker begins opening the mechanism to clear a blockage. What is the BEST response?',
'[{"key":"A","text":"Verify that stored energy has been safely relieved or controlled before opening the mechanism"},{"key":"B","text":"Proceed because the supply line is disconnected"},{"key":"C","text":"Open the mechanism slowly and listen for pressure"},{"key":"D","text":"Have another worker hold the mechanism closed"}]'::jsonb,
'["A"]'::jsonb,
'Disconnecting the primary source does not necessarily eliminate stored energy.'),

(17,'scenario','scenario',
'A crew is using a specialty tool in a confined work area where exhaust, dust, noise, and nearby workers create additional exposure concerns. What is the BEST response?',
'[{"key":"A","text":"Reevaluate the setup and apply the required ventilation, access control, PPE, or alternative work method before continuing"},{"key":"B","text":"Continue because the tool itself is approved"},{"key":"C","text":"Work faster to reduce exposure time"},{"key":"D","text":"Have workers take turns standing in the same area"}]'::jsonb,
'["A"]'::jsonb,
'Tool approval does not eliminate hazards created by the surrounding environment and work configuration.'),

(18,'scenario','scenario',
'A supervisor asks an authorized worker to modify a specialty tool so it can perform an operation outside its normal configuration. What is the BEST response?',
'[{"key":"A","text":"Do not make an unauthorized modification; use an approved tool, attachment, or work method"},{"key":"B","text":"Modify it if the supervisor accepts responsibility"},{"key":"C","text":"Make the change temporarily and restore it later"},{"key":"D","text":"Modify only the nonmoving parts"}]'::jsonb,
'["A"]'::jsonb,
'Unauthorized modification can defeat engineered controls and place the equipment outside its intended operating limits.'),

(19,'scenario','scenario',
'Several higher-risk tools are stored together, and workers cannot tell which ones require special authorization or inspection. What is the BEST Level 2 response?',
'[{"key":"A","text":"Organize and control the equipment so required authorization, condition, inspection status, and operating restrictions are clear before use"},{"key":"B","text":"Allow workers to decide based on appearance"},{"key":"C","text":"Store the highest-risk tools at the bottom of the box"},{"key":"D","text":"Assume anyone assigned to the crew can use all tools"}]'::jsonb,
'["A"]'::jsonb,
'Controlled-use equipment should be managed so workers can readily determine whether it is suitable and authorized for use.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Powered & Specialty Tool Safety?',
'[{"key":"A","text":"Using higher-risk equipment whenever a supervisor is nearby"},{"key":"B","text":"Reliably verifying authorization, tool condition, safeguards, accessories, energy controls, exposure zones, and operating requirements while stopping use when equipment or conditions are outside approved limits"},{"key":"C","text":"Learning specialty tools through trial and error"},{"key":"D","text":"Bypassing controls when the normal setup slows production"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means consistently applying controlled-use and higher-risk tool safety requirements within established construction procedures.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'c4849887-bc2e-488c-b591-aea03a34024a';
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
      and c.name = 'Powered & Specialty Tool Safety'
      and c.is_current = true
  ) then
    raise exception 'Current Powered & Specialty Tool Safety Master Competency not found';
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
  v_assessment_name := 'Powered & Specialty Tool Safety — Level 2 Competency Assessment';

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
    select * from _seed_powered_specialty_tool_safety_l2_questions
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
        'Powered & Specialty Tool Safety',
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
      'IntegrateU Powered & Specialty Tool Safety L2 production assessment v1.0.',
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
        'Powered & Specialty Tool Safety',
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
        'IntegrateU Powered & Specialty Tool Safety L2 production assessment v1.0.',
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
   'c4849887-bc2e-488c-b591-aea03a34024a'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'c4849887-bc2e-488c-b591-aea03a34024a'::uuid
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
      'c4849887-bc2e-488c-b591-aea03a34024a'::uuid
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
