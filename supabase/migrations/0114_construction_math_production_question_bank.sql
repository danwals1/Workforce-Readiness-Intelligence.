-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0114_construction_math_production_question_bank.sql
--
-- Production Master Question Banks:
--   Competency: Construction Math
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

create temporary table _seed_construction_math_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_construction_math_l2_questions (
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
'What is 3/4 expressed as a decimal?',
'[{"key":"A","text":"0.75"},{"key":"B","text":"0.34"},{"key":"C","text":"0.80"},{"key":"D","text":"1.25"}]'::jsonb,
'["A"]'::jsonb,
'Three divided by four equals 0.75.'),

(2,'multiple_choice','foundational',
'What is 2.5 feet in inches?',
'[{"key":"A","text":"30 inches"},{"key":"B","text":"24 inches"},{"key":"C","text":"25 inches"},{"key":"D","text":"36 inches"}]'::jsonb,
'["A"]'::jsonb,
'There are 12 inches in a foot, so 2.5 × 12 = 30 inches.'),

(3,'multiple_choice','foundational',
'What is the area of a rectangle that is 12 feet long and 8 feet wide?',
'[{"key":"A","text":"96 square feet"},{"key":"B","text":"40 square feet"},{"key":"C","text":"20 square feet"},{"key":"D","text":"192 square feet"}]'::jsonb,
'["A"]'::jsonb,
'Rectangle area equals length multiplied by width: 12 × 8 = 96 square feet.'),

(4,'multiple_choice','foundational',
'What is the perimeter of a rectangle that measures 10 feet by 6 feet?',
'[{"key":"A","text":"32 feet"},{"key":"B","text":"60 feet"},{"key":"C","text":"16 feet"},{"key":"D","text":"26 feet"}]'::jsonb,
'["A"]'::jsonb,
'Perimeter equals twice the length plus twice the width: 20 + 12 = 32 feet.'),

(5,'multiple_choice','foundational',
'Which fraction is equivalent to 1/2?',
'[{"key":"A","text":"4/8"},{"key":"B","text":"3/8"},{"key":"C","text":"5/8"},{"key":"D","text":"2/8"}]'::jsonb,
'["A"]'::jsonb,
'Four eighths reduces to one half.'),

(6,'multiple_choice','application',
'A worker needs four pieces that are each 2 feet 6 inches long. What total length is required before allowing for waste?',
'[{"key":"A","text":"10 feet"},{"key":"B","text":"8 feet 6 inches"},{"key":"C","text":"9 feet"},{"key":"D","text":"12 feet"}]'::jsonb,
'["A"]'::jsonb,
'Two feet six inches is 2.5 feet. Four pieces require 4 × 2.5 = 10 feet.'),

(7,'multiple_choice','application',
'A 16-foot board is cut into four equal pieces. How long is each piece?',
'[{"key":"A","text":"4 feet"},{"key":"B","text":"3 feet"},{"key":"C","text":"5 feet"},{"key":"D","text":"6 feet"}]'::jsonb,
'["A"]'::jsonb,
'16 divided by 4 equals 4 feet per piece.'),

(8,'multiple_choice','application',
'A floor measures 15 feet by 20 feet. What is its area?',
'[{"key":"A","text":"300 square feet"},{"key":"B","text":"70 square feet"},{"key":"C","text":"150 square feet"},{"key":"D","text":"600 square feet"}]'::jsonb,
'["A"]'::jsonb,
'Area equals 15 × 20 = 300 square feet.'),

(9,'multiple_choice','application',
'A material costs $4.25 per unit. What is the cost of 8 units before tax?',
'[{"key":"A","text":"$34.00"},{"key":"B","text":"$32.00"},{"key":"C","text":"$36.25"},{"key":"D","text":"$42.50"}]'::jsonb,
'["A"]'::jsonb,
'4.25 × 8 = 34.00.'),

(10,'multiple_choice','application',
'A measurement is 7 feet 9 inches. How many total inches is that?',
'[{"key":"A","text":"93 inches"},{"key":"B","text":"84 inches"},{"key":"C","text":"79 inches"},{"key":"D","text":"97 inches"}]'::jsonb,
'["A"]'::jsonb,
'Seven feet is 84 inches; 84 + 9 = 93 inches.'),

(11,'multiple_choice','application',
'A worker measures 5 1/2 inches and needs to subtract 1 3/4 inches. What is the result?',
'[{"key":"A","text":"3 3/4 inches"},{"key":"B","text":"4 1/4 inches"},{"key":"C","text":"3 1/2 inches"},{"key":"D","text":"4 inches"}]'::jsonb,
'["A"]'::jsonb,
'5 1/2 minus 1 3/4 equals 3 3/4.'),

(12,'multiple_choice','application',
'A square opening has sides that are 4 feet long. What is its area?',
'[{"key":"A","text":"16 square feet"},{"key":"B","text":"8 square feet"},{"key":"C","text":"12 square feet"},{"key":"D","text":"20 square feet"}]'::jsonb,
'["A"]'::jsonb,
'Area of a square equals side × side: 4 × 4 = 16 square feet.'),

(13,'multiple_choice','application',
'A crew needs 120 feet of material and wants to include 10% extra for waste. How much should be ordered?',
'[{"key":"A","text":"132 feet"},{"key":"B","text":"130 feet"},{"key":"C","text":"122 feet"},{"key":"D","text":"144 feet"}]'::jsonb,
'["A"]'::jsonb,
'Ten percent of 120 is 12, so 120 + 12 = 132 feet.'),

(14,'multiple_choice','application',
'A rise is 6 inches over a horizontal run of 12 inches. What is the ratio of rise to run?',
'[{"key":"A","text":"1:2"},{"key":"B","text":"2:1"},{"key":"C","text":"1:6"},{"key":"D","text":"6:1"}]'::jsonb,
'["A"]'::jsonb,
'The ratio 6:12 simplifies to 1:2.'),

(15,'scenario','scenario',
'A rectangular room is 18 feet long and 12 feet wide. Flooring is sold by the square foot. Before adding waste, how many square feet are needed?',
'[{"key":"A","text":"216 square feet"},{"key":"B","text":"60 square feet"},{"key":"C","text":"180 square feet"},{"key":"D","text":"240 square feet"}]'::jsonb,
'["A"]'::jsonb,
'18 × 12 = 216 square feet.'),

(16,'scenario','scenario',
'A worker needs to divide a 10-foot length into three equal sections. What is the BEST mathematical approach?',
'[{"key":"A","text":"Convert to a consistent unit, divide by three, and mark each section from the same reference"},{"key":"B","text":"Estimate each section visually"},{"key":"C","text":"Mark two sections first and use the remainder as the third"},{"key":"D","text":"Round each section to 4 feet"}]'::jsonb,
'["A"]'::jsonb,
'Using consistent units and a single reference reduces cumulative layout error.'),

(17,'scenario','scenario',
'A material list requires 14 pieces at 2 feet 3 inches each. What is the total required length before waste?',
'[{"key":"A","text":"31 feet 6 inches"},{"key":"B","text":"28 feet 3 inches"},{"key":"C","text":"32 feet"},{"key":"D","text":"30 feet 6 inches"}]'::jsonb,
'["A"]'::jsonb,
'Two feet three inches is 2.25 feet; 14 × 2.25 = 31.5 feet, or 31 feet 6 inches.'),

(18,'scenario','scenario',
'A wall is 24 feet long. Stud spacing is planned at 16 inches on center. What is the BEST first step when estimating layout positions?',
'[{"key":"A","text":"Convert the wall length to inches so the spacing and total length use the same unit"},{"key":"B","text":"Divide 24 directly by 16 without converting units"},{"key":"C","text":"Estimate positions by eye"},{"key":"D","text":"Convert 16 inches to 16 feet"}]'::jsonb,
'["A"]'::jsonb,
'Calculations should use consistent units before division or layout.'),

(19,'scenario','scenario',
'A drawing dimension is 9 feet 7 1/2 inches, but a worker records it as 9.75 feet. What is the problem?',
'[{"key":"A","text":"Seven and one-half inches is 0.625 foot, so the decimal conversion is incorrect"},{"key":"B","text":"There is no problem; 7 1/2 inches always equals 0.75 foot"},{"key":"C","text":"Feet and inches cannot be converted to decimals"},{"key":"D","text":"The dimension should be rounded to 10 feet"}]'::jsonb,
'["A"]'::jsonb,
'7.5 ÷ 12 = 0.625, so the correct decimal measurement is 9.625 feet.'),

(20,'multiple_choice','scenario',
'Which behavior BEST demonstrates Level 2 proficiency in Construction Math?',
'[{"key":"A","text":"Estimating most measurements mentally and correcting mistakes later"},{"key":"B","text":"Reliably applying arithmetic, fractions, decimals, unit conversions, measurement, area, ratios, and basic geometry to routine construction tasks while checking units and reasonableness"},{"key":"C","text":"Using a calculator without understanding units"},{"key":"D","text":"Avoiding fractions by rounding every measurement"}]'::jsonb,
'["B"]'::jsonb,
'Level 2 proficiency means applying common construction math accurately and consistently in routine field situations.');


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '26c9abf8-adb0-417a-982d-15f1f65275cf';
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
      and c.name = 'Construction Math'
      and c.is_current = true
  ) then
    raise exception 'Current Construction Math Master Competency not found';
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
  v_assessment_name := 'Construction Math — Level 2 Competency Assessment';

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
    select * from _seed_construction_math_l2_questions
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
        'Construction Math',
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
      'IntegrateU Construction Math L2 production assessment v1.0.',
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
        'Construction Math',
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
        'IntegrateU Construction Math L2 production assessment v1.0.',
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
   '26c9abf8-adb0-417a-982d-15f1f65275cf'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '26c9abf8-adb0-417a-982d-15f1f65275cf'::uuid
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
      '26c9abf8-adb0-417a-982d-15f1f65275cf'::uuid
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
