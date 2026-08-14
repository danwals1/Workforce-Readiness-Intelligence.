-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0115_construction_work_practices_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Construction Work Practices
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

create temporary table _seed_construction_work_practices_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_construction_work_practices_l2_questions (
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
'What is the main purpose of proper work sequencing on a construction project?',
'[{"key":"A","text":"To coordinate tasks in a logical order that reduces conflicts, rework, and delays"},{"key":"B","text":"To make every trade start at the same time"},{"key":"C","text":"To eliminate the need for drawings"},{"key":"D","text":"To allow workers to choose any task they prefer"}]'::jsonb,
'["A"]'::jsonb,
'Good sequencing coordinates dependent work so activities do not interfere with or undo one another.'),

(2,'multiple_choice','foundational',
'What is meant by workmanship in construction?',
'[{"key":"A","text":"The quality and care with which work is installed or completed according to project expectations"},{"key":"B","text":"How quickly the work is finished"},{"key":"C","text":"How expensive the materials are"},{"key":"D","text":"The number of workers assigned to a task"}]'::jsonb,
'["A"]'::jsonb,
'Workmanship describes the quality, accuracy, neatness, and care applied to completed work.'),

(3,'multiple_choice','foundational',
'Why is housekeeping important during construction work?',
'[{"key":"A","text":"It supports safe access, efficient work, material control, and an orderly job site"},{"key":"B","text":"It is only required at project completion"},{"key":"C","text":"It replaces daily planning"},{"key":"D","text":"It matters only in finished areas"}]'::jsonb,
'["A"]'::jsonb,
'Routine housekeeping reduces clutter and helps workers maintain safe, efficient work areas.'),

(4,'multiple_choice','foundational',
'Why should workers verify the current project information before beginning assigned work?',
'[{"key":"A","text":"To reduce the risk of performing work from outdated drawings, instructions, or requirements"},{"key":"B","text":"Because older information is always incorrect"},{"key":"C","text":"To avoid communicating with supervisors"},{"key":"D","text":"Only to determine material cost"}]'::jsonb,
'["A"]'::jsonb,
'Current project information helps ensure work aligns with the latest approved requirements.'),

(5,'multiple_choice','foundational',
'What is the purpose of documenting completed work, deficiencies, or field changes when required?',
'[{"key":"A","text":"To create a reliable record for coordination, quality control, follow-up, and project communication"},{"key":"B","text":"To replace all verbal communication"},{"key":"C","text":"To record only employee attendance"},{"key":"D","text":"To avoid inspections"}]'::jsonb,
'["A"]'::jsonb,
'Documentation supports coordination and helps ensure unresolved issues are tracked and communicated.'),

(6,'situational_judgment','application',
'A worker is ready to install material, but another trade has not completed work that must occur first. What is the BEST response?',
'[{"key":"A","text":"Confirm the required sequence and coordinate before proceeding with work that could create conflict or rework"},{"key":"B","text":"Install anyway and let the other trade work around it"},{"key":"C","text":"Remove the other trade''s materials"},{"key":"D","text":"Change the installation without telling anyone"}]'::jsonb,
'["A"]'::jsonb,
'Work should follow the intended sequence and be coordinated when predecessor activities are incomplete.'),

(7,'multiple_select','application',
'Which THREE practices support consistent construction workmanship?',
'[{"key":"A","text":"Following project requirements and approved installation methods"},{"key":"B","text":"Checking alignment, fit, finish, and completeness"},{"key":"C","text":"Correcting defects before they become concealed or create rework"},{"key":"D","text":"Ignoring small defects if production is behind"},{"key":"E","text":"Changing dimensions to make materials fit"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Good workmanship depends on following requirements, checking the work, and correcting defects promptly.'),

(8,'situational_judgment','application',
'A worker notices that an installed component is out of alignment before the next operation will conceal it. What is the BEST response?',
'[{"key":"A","text":"Correct or report the deficiency before it becomes concealed or affects later work"},{"key":"B","text":"Leave it because the next operation will hide it"},{"key":"C","text":"Ask the next trade to compensate for it"},{"key":"D","text":"Document it only after project completion"}]'::jsonb,
'["A"]'::jsonb,
'Defects are usually easier and less costly to correct before subsequent work conceals or depends on them.'),

(9,'multiple_choice','application',
'What is the BEST reason to keep tools and materials organized near the work area?',
'[{"key":"A","text":"To reduce wasted motion, prevent damage or loss, and support safe efficient production"},{"key":"B","text":"To avoid returning tools at the end of the shift"},{"key":"C","text":"To allow materials to block access routes"},{"key":"D","text":"To eliminate the need for planning"}]'::jsonb,
'["A"]'::jsonb,
'Organized work areas improve productivity while helping protect tools, materials, and access.'),

(10,'situational_judgment','application',
'A worker discovers that the material delivered for an installation does not match the project requirement. What is the BEST response?',
'[{"key":"A","text":"Stop the affected installation and verify the correct material through the established process"},{"key":"B","text":"Install it because it has already been delivered"},{"key":"C","text":"Modify the material until it looks similar"},{"key":"D","text":"Hide the difference in a concealed area"}]'::jsonb,
'["A"]'::jsonb,
'Material discrepancies should be resolved before installation to avoid quality problems and rework.'),

(11,'multiple_choice','application',
'Why should a worker inspect their own completed work before considering the task finished?',
'[{"key":"A","text":"To identify incomplete, damaged, misaligned, or nonconforming work before handoff"},{"key":"B","text":"To eliminate formal inspections"},{"key":"C","text":"Only to determine how quickly the task was completed"},{"key":"D","text":"Because supervisors should not inspect work"}]'::jsonb,
'["A"]'::jsonb,
'Self-checking catches obvious issues before they affect downstream work or formal quality review.'),

(12,'situational_judgment','application',
'A crew is creating excessive scrap because pieces are being cut before dimensions are verified. What is the BEST improvement?',
'[{"key":"A","text":"Verify dimensions and plan cuts before material is processed"},{"key":"B","text":"Order more material and keep the same process"},{"key":"C","text":"Cut faster so the scrap is produced sooner"},{"key":"D","text":"Hide scrap in another work area"}]'::jsonb,
'["A"]'::jsonb,
'Planning and verification before cutting reduces waste and rework.'),

(13,'multiple_choice','application',
'What should happen when field conditions make the planned installation method impractical?',
'[{"key":"A","text":"Raise the condition through the established coordination or clarification process before making an unauthorized change"},{"key":"B","text":"Create a new method without telling anyone"},{"key":"C","text":"Skip the installation"},{"key":"D","text":"Use whatever method is fastest"}]'::jsonb,
'["A"]'::jsonb,
'Unexpected field conditions should be coordinated rather than solved with unapproved changes.'),

(14,'situational_judgment','application',
'A worker finishes a task but leaves packaging, offcuts, and unused material scattered in the area. What is the BEST response?',
'[{"key":"A","text":"Complete the task by restoring the work area, disposing of waste properly, and staging reusable materials appropriately"},{"key":"B","text":"Leave cleanup for the next trade"},{"key":"C","text":"Push the debris into a corner"},{"key":"D","text":"Clean only if an inspection is scheduled"}]'::jsonb,
'["A"]'::jsonb,
'Housekeeping is part of completing construction work, not a separate optional activity.'),

(15,'scenario','scenario',
'A crew installs work from an older printed drawing and later discovers the location changed in a newer revision. What practice would BEST have prevented the rework?',
'[{"key":"A","text":"Verifying the current approved project information before beginning the installation"},{"key":"B","text":"Working faster from the older sheet"},{"key":"C","text":"Avoiding printed drawings entirely"},{"key":"D","text":"Waiting until inspection to compare revisions"}]'::jsonb,
'["A"]'::jsonb,
'Revision control is part of disciplined construction work practice and helps prevent avoidable rework.'),

(16,'scenario','scenario',
'A worker notices that repeated small defects are appearing in similar installations across the crew. What is the BEST Level 2 response?',
'[{"key":"A","text":"Raise the pattern, review the work method or requirements, and correct the cause before repeating more defective work"},{"key":"B","text":"Repair each defect later without changing the process"},{"key":"C","text":"Ignore the issue because each defect is small"},{"key":"D","text":"Hide the defects before inspection"}]'::jsonb,
'["A"]'::jsonb,
'A repeated defect pattern suggests a process, instruction, or workmanship issue that should be corrected at the source.'),

(17,'scenario','scenario',
'A downstream trade cannot start because materials and debris from your completed task are blocking its work area. What is the BEST response?',
'[{"key":"A","text":"Clear and organize the area so the next operation can begin as planned"},{"key":"B","text":"Tell the next trade to move the materials"},{"key":"C","text":"Leave everything until final cleanup"},{"key":"D","text":"Move the debris into an access path"}]'::jsonb,
'["A"]'::jsonb,
'Good work practices support orderly handoff and avoid creating avoidable obstacles for later activities.'),

(18,'scenario','scenario',
'A worker is unsure whether a field change was approved, but proceeding now would save time. What is the BEST response?',
'[{"key":"A","text":"Verify the change and required documentation before performing affected work"},{"key":"B","text":"Proceed and ask for approval afterward"},{"key":"C","text":"Make the change only in concealed areas"},{"key":"D","text":"Rely on another worker''s memory"}]'::jsonb,
'["A"]'::jsonb,
'Approval and documentation should be confirmed before work is performed from a field change.'),

(19,'scenario','scenario',
'A crew completes an installation that functions correctly but has loose components, inconsistent spacing, and poor finish. How should the work be evaluated?',
'[{"key":"A","text":"It is not complete to expected workmanship standards merely because it functions"},{"key":"B","text":"It is acceptable because function is the only quality criterion"},{"key":"C","text":"It is acceptable if the defects are hard to see"},{"key":"D","text":"It should be judged only by installation speed"}]'::jsonb,
'["A"]'::jsonb,
'Construction quality includes workmanship, completeness, alignment, fit, finish, and compliance with project expectations.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Construction Work Practices?',
'[{"key":"A","text":"Completing assigned work quickly and leaving coordination and quality checks to others"},{"key":"B","text":"Reliably following the proper sequence, maintaining workmanship and housekeeping, checking completed work, using current project information, documenting issues, and recognizing conditions that require coordination"},{"key":"C","text":"Changing installation methods whenever field conditions are inconvenient"},{"key":"D","text":"Treating cleanup and documentation as optional"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means consistently performing routine construction work with appropriate sequencing, workmanship, organization, documentation, and quality awareness.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '29547a8c-63fd-4853-9ab7-1a7faf16cce8';
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
      and c.name = 'Construction Work Practices'
      and c.is_current = true
  ) then
    raise exception 'Current Construction Work Practices Master Competency not found';
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
  v_assessment_name := 'Construction Work Practices — Level 2 Competency Assessment';

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
    select * from _seed_construction_work_practices_l2_questions
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
        'Construction Work Practices',
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
      'IntegrateU Construction Work Practices L2 production assessment v1.0.',
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
        'Construction Work Practices',
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
        'IntegrateU Construction Work Practices L2 production assessment v1.0.',
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
   '29547a8c-63fd-4853-9ab7-1a7faf16cce8'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '29547a8c-63fd-4853-9ab7-1a7faf16cce8'::uuid
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
      '29547a8c-63fd-4853-9ab7-1a7faf16cce8'::uuid
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
