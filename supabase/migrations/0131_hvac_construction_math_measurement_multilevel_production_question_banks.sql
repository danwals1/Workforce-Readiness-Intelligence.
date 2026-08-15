-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0131_hvac_construction_math_measurement_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Construction Math & Measurement
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 2
--   HVAC Service & Repair Technician -> Level 2
--   HVAC Design & Sales Engineer     -> Level 3
--   Senior / Lead HVAC Technician    -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_construction_math_measurement_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_construction_math_measurement_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'How many inches are in 8 feet?',
  '[{"key":"A","text":"64 inches"},{"key":"B","text":"72 inches"},{"key":"C","text":"96 inches"},{"key":"D","text":"108 inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Eight feet multiplied by 12 inches per foot equals 96 inches.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What decimal is equivalent to 3/4 inch?',
  '[{"key":"A","text":"0.25 inch"},{"key":"B","text":"0.50 inch"},{"key":"C","text":"0.75 inch"},{"key":"D","text":"1.25 inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Three divided by four equals 0.75.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the area of a rectangular equipment pad that is 6 feet long and 4 feet wide?',
  '[{"key":"A","text":"10 square feet"},{"key":"B","text":"20 square feet"},{"key":"C","text":"24 square feet"},{"key":"D","text":"48 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Rectangle area equals length multiplied by width: 6 times 4 equals 24 square feet.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the perimeter of a rectangular opening that is 3 feet wide and 2 feet high?',
  '[{"key":"A","text":"5 feet"},{"key":"B","text":"6 feet"},{"key":"C","text":"10 feet"},{"key":"D","text":"12 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Perimeter equals two times width plus two times height: 6 plus 4 equals 10 feet.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Which measurement is equal to 1 foot 6 inches?',
  '[{"key":"A","text":"12 inches"},{"key":"B","text":"16 inches"},{"key":"C","text":"18 inches"},{"key":"D","text":"24 inches"}]'::jsonb,
  '["C"]'::jsonb,
  'One foot is 12 inches; adding 6 inches gives 18 inches.'
),
(
  6,
  'multiple_choice',
  'application',
  'A line set must run 14 feet horizontally and then 6 feet vertically. Ignoring fittings and allowances, what is the minimum measured run?',
  '[{"key":"A","text":"8 feet"},{"key":"B","text":"20 feet"},{"key":"C","text":"28 feet"},{"key":"D","text":"84 feet"}]'::jsonb,
  '["B"]'::jsonb,
  'The measured path is 14 plus 6, which equals 20 feet.'
),
(
  7,
  'multiple_choice',
  'application',
  'A rectangular return-air opening measures 24 inches by 18 inches. What is its area?',
  '[{"key":"A","text":"42 square inches"},{"key":"B","text":"216 square inches"},{"key":"C","text":"432 square inches"},{"key":"D","text":"864 square inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Rectangle area equals 24 multiplied by 18, which equals 432 square inches.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician measures a duct section as 7 feet 8 inches long. What is the total length in inches?',
  '[{"key":"A","text":"84 inches"},{"key":"B","text":"88 inches"},{"key":"C","text":"92 inches"},{"key":"D","text":"96 inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Seven feet equals 84 inches; adding 8 inches gives 92 inches.'
),
(
  9,
  'multiple_choice',
  'application',
  'A 10-foot piece of tubing has 2 feet 9 inches cut from it. How much tubing remains?',
  '[{"key":"A","text":"7 feet 3 inches"},{"key":"B","text":"7 feet 9 inches"},{"key":"C","text":"8 feet 1 inch"},{"key":"D","text":"8 feet 3 inches"}]'::jsonb,
  '["A"]'::jsonb,
  'Ten feet is 120 inches. Subtracting 33 inches leaves 87 inches, or 7 feet 3 inches.'
),
(
  10,
  'multiple_choice',
  'application',
  'A piece of equipment is 36 inches wide. The installation requires 6 inches of clearance on each side. What minimum total width is needed?',
  '[{"key":"A","text":"42 inches"},{"key":"B","text":"48 inches"},{"key":"C","text":"54 inches"},{"key":"D","text":"72 inches"}]'::jsonb,
  '["B"]'::jsonb,
  'Six inches on each side adds 12 inches to the 36-inch equipment width, for 48 inches total.'
),
(
  11,
  'multiple_choice',
  'application',
  'A rectangular mechanical-room floor measures 12 feet by 15 feet. What is the floor area?',
  '[{"key":"A","text":"27 square feet"},{"key":"B","text":"54 square feet"},{"key":"C","text":"180 square feet"},{"key":"D","text":"360 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Area equals 12 multiplied by 15, which equals 180 square feet.'
),
(
  12,
  'multiple_choice',
  'application',
  'A drawing uses a scale of 1/4 inch = 1 foot. A duct run measures 3 inches on the drawing. What actual length does that represent?',
  '[{"key":"A","text":"3 feet"},{"key":"B","text":"6 feet"},{"key":"C","text":"12 feet"},{"key":"D","text":"16 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Each quarter inch represents 1 foot. Three inches contains twelve quarter-inch units, representing 12 feet.'
),
(
  13,
  'multiple_choice',
  'application',
  'An installer needs four equal support sections from a 12-foot length of material. Ignoring cut loss, how long is each section?',
  '[{"key":"A","text":"2 feet"},{"key":"B","text":"3 feet"},{"key":"C","text":"4 feet"},{"key":"D","text":"6 feet"}]'::jsonb,
  '["B"]'::jsonb,
  'Twelve feet divided equally into four sections gives 3 feet per section.'
),
(
  14,
  'multiple_choice',
  'application',
  'A condensate drain drops 3 inches over a horizontal distance of 12 feet. What is the average drop per foot?',
  '[{"key":"A","text":"1/8 inch per foot"},{"key":"B","text":"1/4 inch per foot"},{"key":"C","text":"1/2 inch per foot"},{"key":"D","text":"1 inch per foot"}]'::jsonb,
  '["B"]'::jsonb,
  'Three inches divided by 12 feet equals 0.25 inch, or 1/4 inch, per foot.'
),
(
  15,
  'scenario',
  'scenario',
  'An installer measures a replacement unit at 32 inches wide. The doorway is 2 feet 6 inches wide. What should the installer conclude?',
  '[{"key":"A","text":"The unit fits with 2 inches to spare"},{"key":"B","text":"The unit fits exactly"},{"key":"C","text":"The unit is 2 inches wider than the doorway and the access plan must be reconsidered"},{"key":"D","text":"The doorway is 6 inches wider than the unit"}]'::jsonb,
  '["C"]'::jsonb,
  'Two feet 6 inches equals 30 inches, so a 32-inch unit is 2 inches wider than the opening.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician needs 27 feet of tubing. The truck has one 12-foot piece, one 9-foot piece, and one 8-foot piece. Ignoring fittings and waste, is there enough total tubing?',
  '[{"key":"A","text":"No; only 25 feet is available"},{"key":"B","text":"No; only 26 feet is available"},{"key":"C","text":"Yes; exactly 27 feet is available"},{"key":"D","text":"Yes; 29 feet is available"}]'::jsonb,
  '["D"]'::jsonb,
  'Twelve plus 9 plus 8 equals 29 feet, which exceeds the required 27 feet.'
),
(
  17,
  'scenario',
  'scenario',
  'A rectangular filter rack opening is 20 inches by 25 inches. A technician records its area as 45 square inches. What is the BEST response?',
  '[{"key":"A","text":"Accept the value because 20 plus 25 equals 45"},{"key":"B","text":"Correct the calculation; the area is 500 square inches"},{"key":"C","text":"Correct the calculation; the area is 250 square inches"},{"key":"D","text":"Measure only the perimeter instead"}]'::jsonb,
  '["B"]'::jsonb,
  'Area requires multiplication, not addition: 20 multiplied by 25 equals 500 square inches.'
),
(
  18,
  'scenario',
  'scenario',
  'A drawing scale is 1/8 inch = 1 foot. A measured route is 2 1/2 inches long on the drawing. What actual distance does it represent?',
  '[{"key":"A","text":"10 feet"},{"key":"B","text":"16 feet"},{"key":"C","text":"20 feet"},{"key":"D","text":"24 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Two and one-half inches contains twenty 1/8-inch increments, so the actual distance is 20 feet.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician calculates that a 15-foot condensate run with a required average slope of 1/4 inch per foot needs only 2 inches of total drop. What is the BEST response?',
  '[{"key":"A","text":"The calculation is correct"},{"key":"B","text":"The required drop is 3 3/4 inches, so the calculation should be corrected"},{"key":"C","text":"The required drop is 7 1/2 inches"},{"key":"D","text":"Slope cannot be calculated from run length"}]'::jsonb,
  '["B"]'::jsonb,
  'Fifteen feet multiplied by 1/4 inch per foot equals 3.75 inches, or 3 3/4 inches.'
),
(
  20,
  'scenario',
  'scenario',
  'A replacement air handler requires a 30-inch by 24-inch service area directly in front of the cabinet. The available clear floor space is 2 feet by 3 feet. Does the available area meet the stated dimensions?',
  '[{"key":"A","text":"No; both available dimensions are too small"},{"key":"B","text":"No; the 2-foot dimension is only 24 inches, which is less than the required 30 inches"},{"key":"C","text":"Yes; 2 feet by 3 feet equals 24 inches by 36 inches, so the space can satisfy a 30-inch by 24-inch rectangle when oriented appropriately"},{"key":"D","text":"Yes; any 6-square-foot space meets the requirement regardless of shape"}]'::jsonb,
  '["C"]'::jsonb,
  'The available space is 24 by 36 inches. Rotating the required 30-by-24-inch service rectangle allows the 30-inch side within 36 inches and the 24-inch side within 24 inches.'
);

create temporary table _seed_hvac_construction_math_measurement_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_construction_math_measurement_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'A rectangular mechanical room measures 18 feet by 22 feet. What is its floor area?',
  '[{"key":"A","text":"40 square feet"},{"key":"B","text":"198 square feet"},{"key":"C","text":"396 square feet"},{"key":"D","text":"792 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Rectangle area equals length multiplied by width: 18 times 22 equals 396 square feet.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is 2.5 feet expressed in inches?',
  '[{"key":"A","text":"24 inches"},{"key":"B","text":"30 inches"},{"key":"C","text":"32 inches"},{"key":"D","text":"36 inches"}]'::jsonb,
  '["B"]'::jsonb,
  'Two and one-half feet multiplied by 12 inches per foot equals 30 inches.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the volume of a rectangular space that is 8 feet long, 6 feet wide, and 10 feet high?',
  '[{"key":"A","text":"48 cubic feet"},{"key":"B","text":"80 cubic feet"},{"key":"C","text":"240 cubic feet"},{"key":"D","text":"480 cubic feet"}]'::jsonb,
  '["D"]'::jsonb,
  'Volume equals length times width times height: 8 times 6 times 10 equals 480 cubic feet.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'A drawing scale is 1/4 inch = 1 foot. What actual length is represented by 5 1/2 inches on the drawing?',
  '[{"key":"A","text":"11 feet"},{"key":"B","text":"18 feet"},{"key":"C","text":"22 feet"},{"key":"D","text":"24 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Five and one-half inches contains twenty-two quarter-inch increments, so the actual length is 22 feet.'
),
(
  5,
  'multiple_choice',
  'application',
  'A duct section is 30 inches wide by 18 inches high. What is the cross-sectional area?',
  '[{"key":"A","text":"48 square inches"},{"key":"B","text":"270 square inches"},{"key":"C","text":"540 square inches"},{"key":"D","text":"960 square inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Cross-sectional area equals 30 multiplied by 18, or 540 square inches.'
),
(
  6,
  'multiple_choice',
  'application',
  'A rectangular equipment pad measures 7 feet 6 inches by 4 feet. What is its area?',
  '[{"key":"A","text":"22 square feet"},{"key":"B","text":"28 square feet"},{"key":"C","text":"30 square feet"},{"key":"D","text":"36 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Seven feet 6 inches is 7.5 feet. Multiplying 7.5 by 4 gives 30 square feet.'
),
(
  7,
  'multiple_choice',
  'application',
  'A condensate line must drop at an average rate of 1/4 inch per foot over a 28-foot run. What total drop is required?',
  '[{"key":"A","text":"4 inches"},{"key":"B","text":"7 inches"},{"key":"C","text":"14 inches"},{"key":"D","text":"28 inches"}]'::jsonb,
  '["B"]'::jsonb,
  'Twenty-eight feet multiplied by 1/4 inch per foot equals 7 inches.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project requires 12 identical equipment pads, each measuring 4 feet by 6 feet. What total pad area is required?',
  '[{"key":"A","text":"120 square feet"},{"key":"B","text":"144 square feet"},{"key":"C","text":"288 square feet"},{"key":"D","text":"576 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Each pad is 24 square feet. Twelve pads require 288 square feet total.'
),
(
  9,
  'multiple_choice',
  'application',
  'A rectangular opening measures 36 inches by 24 inches. What is the area in square feet?',
  '[{"key":"A","text":"4 square feet"},{"key":"B","text":"6 square feet"},{"key":"C","text":"8 square feet"},{"key":"D","text":"12 square feet"}]'::jsonb,
  '["B"]'::jsonb,
  'Thirty-six inches is 3 feet and 24 inches is 2 feet. The area is 3 times 2, or 6 square feet.'
),
(
  10,
  'multiple_choice',
  'application',
  'A design calls for three equal duct sections along a 27-foot straight run. Ignoring fitting lengths, how long is each section?',
  '[{"key":"A","text":"6 feet"},{"key":"B","text":"8 feet"},{"key":"C","text":"9 feet"},{"key":"D","text":"12 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Twenty-seven feet divided by three equal sections is 9 feet per section.'
),
(
  11,
  'multiple_choice',
  'application',
  'A rooftop curb is shown on a drawing as 2 3/4 inches long at a scale of 1/8 inch = 1 foot. What actual length does that represent?',
  '[{"key":"A","text":"11 feet"},{"key":"B","text":"16 feet"},{"key":"C","text":"20 feet"},{"key":"D","text":"22 feet"}]'::jsonb,
  '["D"]'::jsonb,
  'Two and three-quarter inches equals twenty-two eighth-inch increments, so the actual length is 22 feet.'
),
(
  12,
  'scenario',
  'scenario',
  'A senior technician reviews an equipment replacement plan showing a 34-inch-wide unit passing through a 2-foot 8-inch doorway. What is the BEST conclusion?',
  '[{"key":"A","text":"The unit fits with 2 inches to spare"},{"key":"B","text":"The unit fits exactly"},{"key":"C","text":"The doorway is 32 inches wide, so the 34-inch unit will not pass without another access plan"},{"key":"D","text":"The doorway is 40 inches wide"}]'::jsonb,
  '["C"]'::jsonb,
  'Two feet 8 inches equals 32 inches, which is 2 inches narrower than the 34-inch equipment.'
),
(
  13,
  'scenario',
  'scenario',
  'A design engineer calculates the area of a 30-inch by 20-inch duct as 50 square inches by adding the dimensions. What is the BEST correction?',
  '[{"key":"A","text":"The area is 300 square inches"},{"key":"B","text":"The area is 500 square inches"},{"key":"C","text":"The area is 600 square inches"},{"key":"D","text":"The area is 1,000 square inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Area requires multiplication: 30 times 20 equals 600 square inches.'
),
(
  14,
  'scenario',
  'scenario',
  'A project has four line-set runs measuring 18 feet, 24 feet, 31 feet, and 27 feet. Ignoring allowances, what total tubing length is required?',
  '[{"key":"A","text":"90 feet"},{"key":"B","text":"96 feet"},{"key":"C","text":"100 feet"},{"key":"D","text":"110 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Eighteen plus 24 plus 31 plus 27 equals 100 feet.'
),
(
  15,
  'scenario',
  'scenario',
  'A service platform must be at least 30 inches deep and 36 inches wide. The available area is 2 feet 8 inches deep by 3 feet wide. Does it meet the stated minimum?',
  '[{"key":"A","text":"No; both dimensions are too small"},{"key":"B","text":"No; the depth is only 28 inches"},{"key":"C","text":"Yes; the area is 32 inches deep by 36 inches wide"},{"key":"D","text":"Yes; any area over 6 square feet is acceptable"}]'::jsonb,
  '["C"]'::jsonb,
  'Two feet 8 inches equals 32 inches and 3 feet equals 36 inches, so both stated minimum dimensions are met.'
),
(
  16,
  'scenario',
  'scenario',
  'A condensate run is 42 feet long and is intended to slope 1/8 inch per foot. A technician provides only 4 inches of total drop. What is the BEST assessment?',
  '[{"key":"A","text":"The drop is correct"},{"key":"B","text":"The required drop is 5 1/4 inches, so 4 inches is insufficient"},{"key":"C","text":"The required drop is 10 1/2 inches"},{"key":"D","text":"The run length does not affect required drop"}]'::jsonb,
  '["B"]'::jsonb,
  'Forty-two multiplied by 1/8 inch equals 5.25 inches, or 5 1/4 inches.'
),
(
  17,
  'scenario',
  'scenario',
  'A mechanical room is 14 feet by 18 feet. Equipment and required clearances occupy 190 square feet. How much floor area remains, ignoring shape constraints?',
  '[{"key":"A","text":"42 square feet"},{"key":"B","text":"52 square feet"},{"key":"C","text":"62 square feet"},{"key":"D","text":"72 square feet"}]'::jsonb,
  '["C"]'::jsonb,
  'The room area is 14 times 18, or 252 square feet. Subtracting 190 leaves 62 square feet.'
),
(
  18,
  'scenario',
  'scenario',
  'A drawing uses a scale of 1/4 inch = 1 foot. A technician measures a route as 7 3/4 inches on the drawing but records the actual route as 28 feet. What is the BEST response?',
  '[{"key":"A","text":"Accept 28 feet"},{"key":"B","text":"Correct it to 29 feet"},{"key":"C","text":"Correct it to 31 feet"},{"key":"D","text":"Correct it to 34 feet"}]'::jsonb,
  '["C"]'::jsonb,
  'Seven and three-quarter inches equals thirty-one quarter-inch increments, representing 31 feet.'
),
(
  19,
  'scenario',
  'scenario',
  'A rectangular duct must have a cross-sectional area of at least 720 square inches. A proposed size is 30 inches by 22 inches. Does it meet the stated minimum area?',
  '[{"key":"A","text":"Yes; the area is 720 square inches"},{"key":"B","text":"Yes; the area is 660 square inches"},{"key":"C","text":"No; the area is 660 square inches, which is 60 square inches short"},{"key":"D","text":"No; the area is 520 square inches"}]'::jsonb,
  '["C"]'::jsonb,
  'Thirty times 22 equals 660 square inches, which is 60 square inches below the stated minimum.'
),
(
  20,
  'scenario',
  'scenario',
  'A project requires ten 8-foot pieces of material. The supplier sells 20-foot stock lengths. Ignoring saw kerf and waste, what is the minimum number of stock lengths needed?',
  '[{"key":"A","text":"3"},{"key":"B","text":"4"},{"key":"C","text":"5"},{"key":"D","text":"8"}]'::jsonb,
  '["C"]'::jsonb,
  'Each 20-foot stock length can provide two complete 8-foot pieces, so ten pieces require five stock lengths.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '63b4d92f-7475-46cc-9bce-b8f27187886c';
  v_installer_role_id uuid := '7a7a4a06-45d7-4bca-af67-ede5df4fb915';
  v_design_sales_role_id uuid := '0264d850-dbb5-4c65-b968-78e49e46e186';
  v_service_role_id uuid := '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52';
  v_senior_role_id uuid := 'df49a251-f3d9-44f1-84a2-dd62858bffb0';
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
  where lower(i.slug) = 'hvac'
     or lower(i.name) = 'hvac'
  order by case when lower(i.slug) = 'hvac' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'HVAC industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Construction Math & Measurement'
      and c.is_current = true
  ) then
    raise exception 'Current Construction Math & Measurement Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_installer_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Installer / Helper'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Installer / Helper L2 Construction Math & Measurement requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_service_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Service & Repair Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Service & Repair Technician L2 Construction Math & Measurement requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_design_sales_role_id
      and r.industry_id = v_industry_id
      and r.name = 'HVAC Design & Sales Engineer'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L3 Construction Math & Measurement requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_senior_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Senior / Lead HVAC Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Senior / Lead HVAC Technician L3 Construction Math & Measurement requirement not found';
  end if;

v_level := 2;
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'Construction Math & Measurement — Level 2 Competency Assessment';

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
    select * from _seed_hvac_construction_math_measurement_l2_questions
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
        'Construction Math & Measurement',
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
      'IntegrateU Construction Math & Measurement L2 production assessment v1.0.',
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
    values
      (v_master_question_id, v_installer_role_id),
      (v_master_question_id, v_service_role_id)
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
        'Construction Math & Measurement',
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
        'IntegrateU Construction Math & Measurement L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 3;
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Construction Math & Measurement — Level 3 Competency Assessment';

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
    select * from _seed_hvac_construction_math_measurement_l3_questions
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
        'Construction Math & Measurement',
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
      'IntegrateU Construction Math & Measurement L3 production assessment v1.0.',
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
    values
      (v_master_question_id, v_design_sales_role_id),
      (v_master_question_id, v_senior_role_id)
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
        'Construction Math & Measurement',
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
        'IntegrateU Construction Math & Measurement L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 4
  -- ========================================================================

  

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
--   Level 4 -> 20 / 20 / 3 / 7 / 10
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (where aq.difficulty = 'foundational')::integer as foundational_count,
  count(distinct aq.id) filter (where aq.difficulty = 'application')::integer as application_count,
  count(distinct aq.id) filter (where aq.difficulty = 'scenario')::integer as scenario_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   '63b4d92f-7475-46cc-9bce-b8f27187886c'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '63b4d92f-7475-46cc-9bce-b8f27187886c'::uuid
  and a.target_level in (2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L2 HVAC Installer / Helper = 20
--   L2 HVAC Service & Repair Technician = 20
--   L3 HVAC Design & Sales Engineer = 20
--   L3 Senior / Lead HVAC Technician = 20
-- ============================================================================

with q as (
  select
    aq.source_master_question_id,
    a.target_level
  from public.assessments a
  join public.assessment_questions aq
    on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '63b4d92f-7475-46cc-9bce-b8f27187886c'::uuid
    and a.target_level in (2,3)
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  mrt.name as role_name,
  count(distinct ra.master_question_id)::integer
    as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
join public.master_role_templates mrt
  on mrt.id = ra.master_role_template_id
where
  (
    q.target_level = 2
    and mrt.id in (
      '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid,
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
    )
  )
  or
  (
    q.target_level = 3
    and mrt.id in (
      '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid,
      'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
    )
  )
group by
  q.target_level,
  mrt.id,
  mrt.name
order by
  q.target_level,
  mrt.name;

-- ============================================================================

-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '63b4d92f-7475-46cc-9bce-b8f27187886c'::uuid;

-- ============================================================================
-- VERIFICATION 4 — NO DUPLICATE CURRENT ASSESSMENTS PER TARGET LEVEL
-- Expected: zero rows
-- ============================================================================

select
  a.target_level,
  count(*) as current_assessment_count
from public.assessments a
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '63b4d92f-7475-46cc-9bce-b8f27187886c'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
