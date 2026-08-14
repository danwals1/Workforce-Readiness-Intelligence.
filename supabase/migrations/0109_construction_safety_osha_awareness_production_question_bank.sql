-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0109_construction_safety_osha_awareness_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Construction Safety & OSHA Awareness
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

create temporary table _seed_construction_safety_osha_awareness_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_construction_safety_osha_awareness_l3_questions (
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
'What is the primary purpose of a job hazard analysis or similar pre-task safety review?',
'[{"key":"A","text":"To identify hazards associated with the planned work and establish controls before exposure occurs"},{"key":"B","text":"To replace employee training"},{"key":"C","text":"To document only injuries that already happened"},{"key":"D","text":"To determine which worker can finish fastest"}]'::jsonb,
'["A"]'::jsonb,
'A pre-task hazard review identifies foreseeable hazards and controls before workers are exposed.'),

(2,'multiple_choice','foundational',
'What is generally the preferred approach when a construction hazard can be eliminated rather than controlled with personal protective equipment?',
'[{"key":"A","text":"Eliminate the hazard when feasible instead of relying only on PPE"},{"key":"B","text":"Keep the hazard and add warning signs only"},{"key":"C","text":"Use PPE even if the hazard can easily be removed"},{"key":"D","text":"Allow workers to decide individually whether the hazard matters"}]'::jsonb,
'["A"]'::jsonb,
'Eliminating or controlling hazards at their source is generally more reliable than relying only on worker-worn protection.'),

(3,'multiple_choice','foundational',
'Why is a competent or otherwise qualified designated person important for certain construction hazards?',
'[{"key":"A","text":"Some hazards require a person with defined knowledge and authority to identify conditions and take corrective action"},{"key":"B","text":"Every worker automatically has the same authority for every specialized hazard"},{"key":"C","text":"The designation eliminates the need for inspections"},{"key":"D","text":"The designation is only an administrative title"}]'::jsonb,
'["A"]'::jsonb,
'Certain construction activities require designated persons who can recognize hazards and act within the responsibilities assigned to them.'),

(4,'multiple_choice','foundational',
'What should a worker understand about reporting a recognized job-site hazard?',
'[{"key":"A","text":"Hazards should be communicated promptly through the established reporting and correction process"},{"key":"B","text":"Hazards should be reported only after someone is injured"},{"key":"C","text":"Only supervisors may mention hazards"},{"key":"D","text":"A hazard can be ignored if the task is almost finished"}]'::jsonb,
'["A"]'::jsonb,
'Prompt hazard reporting supports correction before an incident occurs.'),

(5,'situational_judgment','application',
'A crew is about to begin work, but field conditions have changed significantly since the morning safety plan was completed. What is the BEST response?',
'[{"key":"A","text":"Reevaluate the work and hazards before proceeding and update controls as needed"},{"key":"B","text":"Continue because the original plan was already signed"},{"key":"C","text":"Wait until the end of the shift to document the changes"},{"key":"D","text":"Proceed if the most experienced worker is comfortable"}]'::jsonb,
'["A"]'::jsonb,
'Safety planning should reflect actual conditions; material changes require reevaluation before exposure continues.'),

(6,'multiple_select','application',
'Which THREE items belong in a sound construction pre-task safety review?',
'[{"key":"A","text":"The work steps and changing site conditions"},{"key":"B","text":"Hazards that workers may encounter"},{"key":"C","text":"Controls, responsibilities, and required protective measures"},{"key":"D","text":"Which worker is willing to take the most risk"},{"key":"E","text":"Whether safety documentation can be skipped to save time"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Effective pre-task planning connects the work sequence to identified hazards and the controls needed to perform it safely.'),

(7,'situational_judgment','application',
'A worker is assigned a task involving equipment they have not been trained to operate. What is the BEST response?',
'[{"key":"A","text":"Stop and obtain the required instruction, authorization, or qualified assistance before operating the equipment"},{"key":"B","text":"Try the equipment slowly until familiar with it"},{"key":"C","text":"Watch another worker briefly and begin"},{"key":"D","text":"Operate it if the production schedule is behind"}]'::jsonb,
'["A"]'::jsonb,
'Workers should not perform tasks requiring knowledge or authorization they do not possess.'),

(8,'situational_judgment','application',
'A required machine guard has been removed because it makes the task slower. What should happen?',
'[{"key":"A","text":"Do not operate the equipment in that condition; restore the required guarding or use an approved safe method"},{"key":"B","text":"Continue if the operator is experienced"},{"key":"C","text":"Operate at half speed"},{"key":"D","text":"Post a warning sign in place of the guard"}]'::jsonb,
'["A"]'::jsonb,
'Production convenience does not justify defeating a required machine safeguard.'),

(9,'multiple_choice','application',
'During a site inspection, you identify a hazard that cannot be corrected immediately. What is the BEST interim approach?',
'[{"key":"A","text":"Prevent or control exposure using an appropriate interim measure and ensure the hazard remains tracked for correction"},{"key":"B","text":"Leave it unchanged because permanent correction is not immediately available"},{"key":"C","text":"Tell workers to be careful without changing conditions"},{"key":"D","text":"Remove the hazard from the inspection report"}]'::jsonb,
'["A"]'::jsonb,
'When immediate permanent correction is not possible, exposure should still be controlled and the deficiency tracked.'),

(10,'situational_judgment','application',
'A worker removes required PPE because it is uncomfortable in hot conditions. What is the BEST response?',
'[{"key":"A","text":"Address the heat or fit concern while maintaining the required protection or establishing another approved control"},{"key":"B","text":"Allow the PPE to remain off for experienced workers"},{"key":"C","text":"Use the PPE only when management is present"},{"key":"D","text":"Ignore the issue if no incident has occurred"}]'::jsonb,
'["A"]'::jsonb,
'PPE concerns should be corrected without simply abandoning required protection.'),

(11,'multiple_choice','application',
'Why should near misses be reported and reviewed even when no one is injured?',
'[{"key":"A","text":"They can reveal uncontrolled hazards and system weaknesses before a more serious event occurs"},{"key":"B","text":"Near misses have no safety value without an injury"},{"key":"C","text":"They should be kept informal so no record exists"},{"key":"D","text":"They prove the work method is safe"}]'::jsonb,
'["A"]'::jsonb,
'Near misses provide useful evidence about hazards and controls that may need improvement.'),

(12,'scenario','scenario',
'A crew discovers an unprotected floor opening in its work area that was not present during the earlier walkthrough. Workers need to pass nearby to continue the task. What is the BEST course of action?',
'[{"key":"A","text":"Control access to the hazard and establish the required protection before allowing workers to continue nearby"},{"key":"B","text":"Tell workers to step around it carefully"},{"key":"C","text":"Mark it with spray paint and continue"},{"key":"D","text":"Continue if daylight makes the opening easy to see"}]'::jsonb,
'["A"]'::jsonb,
'An unexpected fall hazard should be controlled before workers are exposed to it.'),

(13,'scenario','scenario',
'A subcontractor begins work that creates a hazard affecting your crew, but the hazard was not discussed during coordination. What should the person leading your crew do?',
'[{"key":"A","text":"Stop or redirect affected work as needed and coordinate the hazard and controls with the responsible parties before exposure continues"},{"key":"B","text":"Ignore hazards created by other employers"},{"key":"C","text":"Tell your workers to work faster through the area"},{"key":"D","text":"Wait until the next scheduled safety meeting"}]'::jsonb,
'["A"]'::jsonb,
'Multi-employer job sites require active coordination when one operation creates hazards for another crew.'),

(14,'scenario','scenario',
'A worker reports feeling dizzy while performing physically demanding work in high heat. What is the BEST response?',
'[{"key":"A","text":"Stop the worker''s exposure, move them to an appropriate recovery area, follow the site heat-illness response procedure, and obtain medical assistance when indicated"},{"key":"B","text":"Tell the worker to finish the task before resting"},{"key":"C","text":"Give the worker an energy drink and immediately return them to work"},{"key":"D","text":"Ignore the symptom unless the worker collapses"}]'::jsonb,
'["A"]'::jsonb,
'Potential heat illness requires prompt action rather than continued exposure.'),

(15,'scenario','scenario',
'A supervisor directs the crew to enter an area where a serious hazard has been identified, but the required control has not yet been installed. What is the BEST response?',
'[{"key":"A","text":"Do not proceed into the uncontrolled hazardous condition; elevate the issue through the established safety process"},{"key":"B","text":"Proceed because a supervisor gave the instruction"},{"key":"C","text":"Enter only for a short period"},{"key":"D","text":"Allow the least experienced worker to enter first"}]'::jsonb,
'["A"]'::jsonb,
'Production or supervisory pressure does not make an uncontrolled serious hazard acceptable.'),

(16,'scenario','scenario',
'During an inspection, several damaged extension cords are found in active use. What is the BEST response?',
'[{"key":"A","text":"Remove damaged cords from service and replace or repair them through the approved process before reuse"},{"key":"B","text":"Wrap all damage with any available tape and continue"},{"key":"C","text":"Use them only for low-power tools"},{"key":"D","text":"Keep them in use until the end of the project"}]'::jsonb,
'["A"]'::jsonb,
'Damaged electrical equipment should be removed from service until properly corrected.'),

(17,'scenario','scenario',
'Workers have begun routinely bypassing a safety control because the normal process causes delays. No incident has occurred yet. What should the person responsible for the work do?',
'[{"key":"A","text":"Stop the unsafe practice, restore the control, determine why bypassing became routine, and correct the underlying work-process problem"},{"key":"B","text":"Allow the practice because it has not caused an incident"},{"key":"C","text":"Keep the practice but require workers to sign a waiver"},{"key":"D","text":"Address it only if an inspector visits"}]'::jsonb,
'["A"]'::jsonb,
'Repeated bypassing indicates both an immediate unsafe condition and a broader process or supervision problem.'),

(18,'scenario','scenario',
'An incident investigation finds that the injured worker made an error, but also shows that the task had unclear instructions and inconsistent controls. What is the BEST conclusion?',
'[{"key":"A","text":"Correct both the immediate behavior and the underlying training, planning, supervision, or control weaknesses that contributed to the event"},{"key":"B","text":"Discipline the worker and make no other changes"},{"key":"C","text":"Close the investigation because a worker error was identified"},{"key":"D","text":"Remove the incident from the record"}]'::jsonb,
'["A"]'::jsonb,
'Effective incident review looks beyond the immediate act to the system conditions that allowed the event to occur.'),

(19,'scenario','scenario',
'A worker raises a good-faith safety concern about a task and asks for the hazard to be evaluated before continuing. What is the BEST supervisory response?',
'[{"key":"A","text":"Evaluate the concern promptly, address the hazard through the established process, and avoid retaliatory treatment for raising the concern"},{"key":"B","text":"Remove the worker from future overtime opportunities"},{"key":"C","text":"Require the worker to continue without evaluation"},{"key":"D","text":"Tell the crew that safety concerns may only be raised after the shift"}]'::jsonb,
'["A"]'::jsonb,
'A healthy construction safety process supports prompt evaluation of reported hazards and good-faith worker concerns.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 3 proficiency in Construction Safety & OSHA Awareness?',
'[{"key":"A","text":"Following safety rules only when a supervisor is watching"},{"key":"B","text":"Independently recognizing changing hazards, applying appropriate controls, coordinating safe work, stopping uncontrolled exposure, reporting deficiencies and near misses, and supporting worker safety responsibilities"},{"key":"C","text":"Accepting familiar hazards because the crew has worked around them before"},{"key":"D","text":"Relying on PPE as the only control for every hazard"}]'::jsonb,
'["B"]'::jsonb,
'Level 3 performance means consistently applying safety principles to real construction conditions and helping ensure hazards are recognized, controlled, communicated, and corrected.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '85c85a72-d39b-415f-84aa-57f1ebf5aac0';
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
      and c.name = 'Construction Safety & OSHA Awareness'
      and c.is_current = true
  ) then
    raise exception 'Current Construction Safety & OSHA Awareness Master Competency not found';
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
  v_assessment_name := 'Construction Safety & OSHA Awareness — Level 3 Competency Assessment';

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
    select * from _seed_construction_safety_osha_awareness_l3_questions
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
        'Construction Safety & OSHA Awareness',
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
      'IntegrateU Construction Safety & OSHA Awareness L3 production assessment v1.0.',
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
        'Construction Safety & OSHA Awareness',
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
        'IntegrateU Construction Safety & OSHA Awareness L3 production assessment v1.0.',
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
   '85c85a72-d39b-415f-84aa-57f1ebf5aac0'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '85c85a72-d39b-415f-84aa-57f1ebf5aac0'::uuid
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
      '85c85a72-d39b-415f-84aa-57f1ebf5aac0'::uuid
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
