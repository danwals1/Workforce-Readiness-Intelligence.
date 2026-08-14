-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0113_construction_drawings_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Construction Drawings
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

create temporary table _seed_construction_drawings_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_construction_drawings_l2_questions (
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
'What is the primary purpose of construction drawings?',
'[{"key":"A","text":"To communicate the intended design, dimensions, locations, assemblies, and project requirements"},{"key":"B","text":"To replace all written specifications and notes"},{"key":"C","text":"To show only the project schedule"},{"key":"D","text":"To document only completed work"}]'::jsonb,
'["A"]'::jsonb,
'Construction drawings communicate how the work is intended to be laid out, assembled, and coordinated.'),

(2,'multiple_choice','foundational',
'What does a drawing scale indicate?',
'[{"key":"A","text":"The relationship between a measured distance on the drawing and the corresponding real-world distance"},{"key":"B","text":"The weight of the drawing set"},{"key":"C","text":"The order in which trades must work"},{"key":"D","text":"The drawing approval status"}]'::jsonb,
'["A"]'::jsonb,
'Scale allows dimensions or distances to be interpreted proportionally when appropriate.'),

(3,'multiple_choice','foundational',
'What is the purpose of a drawing legend or symbol key?',
'[{"key":"A","text":"To explain the meaning of symbols, abbreviations, and graphic conventions used on the drawings"},{"key":"B","text":"To list employee names"},{"key":"C","text":"To show material prices"},{"key":"D","text":"To replace dimensions"}]'::jsonb,
'["A"]'::jsonb,
'Legends help readers interpret the symbols and abbreviations used throughout a drawing set.'),

(4,'multiple_choice','foundational',
'What is the purpose of a detail view?',
'[{"key":"A","text":"To show a specific area or assembly at greater clarity or scale"},{"key":"B","text":"To show the entire project site only"},{"key":"C","text":"To list daily production goals"},{"key":"D","text":"To identify employee assignments"}]'::jsonb,
'["A"]'::jsonb,
'Details enlarge or clarify specific assemblies, interfaces, or installation conditions.'),

(5,'multiple_choice','foundational',
'What is the purpose of a section view on a construction drawing?',
'[{"key":"A","text":"To show what the building or assembly looks like as if cut through at a designated location"},{"key":"B","text":"To identify only exterior finishes"},{"key":"C","text":"To show the project budget"},{"key":"D","text":"To replace all plan views"}]'::jsonb,
'["A"]'::jsonb,
'Sections reveal vertical and concealed relationships that may not be clear in plan or elevation views.'),

(6,'situational_judgment','application',
'A drawing note conflicts with what appears to be shown graphically in the same area. What is the BEST response?',
'[{"key":"A","text":"Recognize the discrepancy and seek clarification through the established project process before proceeding"},{"key":"B","text":"Ignore the note and follow the graphic"},{"key":"C","text":"Ignore the graphic and follow the note without question"},{"key":"D","text":"Choose whichever option is easier to install"}]'::jsonb,
'["A"]'::jsonb,
'Conflicting project information should be identified and clarified rather than guessed.'),

(7,'multiple_select','application',
'Which THREE items should a worker check when locating work from a drawing?',
'[{"key":"A","text":"Dimensions"},{"key":"B","text":"Reference lines, grids, or established control points"},{"key":"C","text":"Relevant notes and detail references"},{"key":"D","text":"Which location looks easiest to access"},{"key":"E","text":"Whether nearby work was installed without drawings"}]'::jsonb,
'["A","B","C"]'::jsonb,
'Accurate layout depends on dimensions, established references, and applicable notes or details.'),

(8,'multiple_choice','application',
'A plan contains a callout that references another sheet and detail number. What should the worker do?',
'[{"key":"A","text":"Review the referenced detail because it may contain additional installation information"},{"key":"B","text":"Ignore the callout if the plan view looks complete"},{"key":"C","text":"Use the sheet number as a field dimension"},{"key":"D","text":"Assume the detail applies only to another trade"}]'::jsonb,
'["A"]'::jsonb,
'Cross-references connect plan views to supporting details and should be followed when interpreting the work.'),

(9,'situational_judgment','application',
'A field measurement does not match the dimension shown on the current drawing. What is the BEST response?',
'[{"key":"A","text":"Verify the measurement, confirm the current drawing revision, and resolve the discrepancy before installing affected work"},{"key":"B","text":"Change the drawing dimension in the field"},{"key":"C","text":"Force the installation to match the drawing"},{"key":"D","text":"Ignore the difference if it appears small"}]'::jsonb,
'["A"]'::jsonb,
'Field conditions and contract documents should be reconciled through the proper process before affected work proceeds.'),

(10,'multiple_choice','application',
'Why should the drawing revision or issue status be checked before using a sheet for installation?',
'[{"key":"A","text":"To reduce the risk of building from superseded project information"},{"key":"B","text":"Because older drawings are always more accurate"},{"key":"C","text":"To determine who printed the sheet"},{"key":"D","text":"Only to confirm the sheet size"}]'::jsonb,
'["A"]'::jsonb,
'Using the current approved project information helps avoid rework caused by superseded drawings.'),

(11,'situational_judgment','application',
'A worker sees a symbol on a drawing that they do not recognize. What is the BEST response?',
'[{"key":"A","text":"Check the legend, abbreviations, notes, or related detail and ask for clarification if still unresolved"},{"key":"B","text":"Guess based on nearby symbols"},{"key":"C","text":"Ignore the symbol"},{"key":"D","text":"Assume it represents material storage"}]'::jsonb,
'["A"]'::jsonb,
'Unknown symbols should be resolved using the drawing set and established clarification process.'),

(12,'multiple_choice','application',
'What is the BEST use of a drawing schedule, such as a door, finish, or equipment schedule?',
'[{"key":"A","text":"To obtain organized item-specific information that supplements the graphic views"},{"key":"B","text":"To determine employee work hours"},{"key":"C","text":"To replace all plan and detail views"},{"key":"D","text":"To record only completed inspections"}]'::jsonb,
'["A"]'::jsonb,
'Schedules provide structured information that works together with plans, sections, elevations, and details.'),

(13,'situational_judgment','application',
'A plan view shows the location of an assembly, but its height is not clear. What is the BEST next step?',
'[{"key":"A","text":"Check related elevations, sections, details, notes, and schedules for the vertical information"},{"key":"B","text":"Choose a convenient height"},{"key":"C","text":"Match the height of the nearest unrelated item"},{"key":"D","text":"Install at floor level"}]'::jsonb,
'["A"]'::jsonb,
'Construction information is often distributed across multiple coordinated views.'),

(14,'multiple_choice','application',
'Why is it important to distinguish between a written dimension and a distance measured from a scaled drawing?',
'[{"key":"A","text":"Written dimensions generally provide the intended controlling measurement and should not be casually replaced by scaling"},{"key":"B","text":"Scaled measurements are always more accurate than written dimensions"},{"key":"C","text":"Written dimensions apply only to architectural drawings"},{"key":"D","text":"There is never any difference"}]'::jsonb,
'["A"]'::jsonb,
'Workers should rely on the project''s stated dimensional information rather than assuming a scaled measurement overrides it.'),

(15,'scenario','scenario',
'A worker is laying out several openings. The plan shows dimensions from a structural grid line, but the worker instead measures from a nearby finished wall that may not be in its exact intended location. What is the BEST approach?',
'[{"key":"A","text":"Use the designated project control or grid reference shown by the drawings rather than substituting an unreliable field reference"},{"key":"B","text":"Use the finished wall because it is closer"},{"key":"C","text":"Split the difference between both references"},{"key":"D","text":"Lay out the openings visually"}]'::jsonb,
'["A"]'::jsonb,
'Layout should be based on the intended control references so small field deviations do not compound.'),

(16,'scenario','scenario',
'A drawing detail appears to show an assembly differently from a plan view, and both seem applicable to the same location. What should happen?',
'[{"key":"A","text":"Identify the apparent conflict and obtain project clarification before installing the affected assembly"},{"key":"B","text":"Automatically follow whichever drawing has the larger scale"},{"key":"C","text":"Automatically follow the plan view"},{"key":"D","text":"Combine portions of both details without approval"}]'::jsonb,
'["A"]'::jsonb,
'An apparent document conflict should be resolved through the established project process rather than by assumption.'),

(17,'scenario','scenario',
'A worker is using a printed sheet when another crew member says a newer revision was issued digitally. What is the BEST response?',
'[{"key":"A","text":"Confirm the current approved revision before continuing work based on the printed sheet"},{"key":"B","text":"Keep using the printed sheet until someone removes it"},{"key":"C","text":"Use both revisions and choose whichever is easier"},{"key":"D","text":"Ignore revisions once field work has started"}]'::jsonb,
'["A"]'::jsonb,
'Revision control is essential because changes may alter dimensions, locations, materials, or other project requirements.'),

(18,'scenario','scenario',
'A plan shows a piece of equipment in one location, but a schedule identifies a different model with dimensions that would not fit there. What is the BEST response?',
'[{"key":"A","text":"Flag the coordination issue and obtain clarification before installation"},{"key":"B","text":"Install the equipment shown in the plan regardless of fit"},{"key":"C","text":"Modify the equipment in the field"},{"key":"D","text":"Ignore the schedule"}]'::jsonb,
'["A"]'::jsonb,
'Drawings and schedules should be coordinated; incompatible information requires clarification.'),

(19,'scenario','scenario',
'A worker completes layout from one sheet but later discovers a related detail changed the required offset. What is the BEST lesson for future work?',
'[{"key":"A","text":"Review applicable plans, notes, sections, schedules, and detail references together before finalizing layout"},{"key":"B","text":"Use only plan views because details are optional"},{"key":"C","text":"Avoid reading notes because they slow down layout"},{"key":"D","text":"Rely on memory from previous projects"}]'::jsonb,
'["A"]'::jsonb,
'Construction drawings function as a coordinated set; relevant references should be reviewed together.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Construction Drawings?',
'[{"key":"A","text":"Reading only the main plan sheet and improvising missing information"},{"key":"B","text":"Reliably interpreting common plans, dimensions, symbols, notes, schedules, sections, details, and revisions while recognizing discrepancies that require clarification"},{"key":"C","text":"Memorizing symbols without using the rest of the drawing set"},{"key":"D","text":"Scaling every measurement instead of using written dimensions"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means using common construction documents accurately within established work processes and recognizing when the information is incomplete or conflicting.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '5b2403d2-f1ae-4537-bb65-7e64f7685513';
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
      and c.name = 'Construction Drawings'
      and c.is_current = true
  ) then
    raise exception 'Current Construction Drawings Master Competency not found';
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
  v_assessment_name := 'Construction Drawings — Level 2 Competency Assessment';

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
    select * from _seed_construction_drawings_l2_questions
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
        'Construction Drawings',
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
      'IntegrateU Construction Drawings L2 production assessment v1.0.',
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
        'Construction Drawings',
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
        'IntegrateU Construction Drawings L2 production assessment v1.0.',
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
   '5b2403d2-f1ae-4537-bb65-7e64f7685513'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '5b2403d2-f1ae-4537-bb65-7e64f7685513'::uuid
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
      '5b2403d2-f1ae-4537-bb65-7e64f7685513'::uuid
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
