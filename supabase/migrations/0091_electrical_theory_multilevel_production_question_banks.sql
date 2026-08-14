-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0091_electrical_theory_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Electrical Theory & Circuits
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Roles:
--   Electrician Apprentice  -> Level 2
--   Electrician Journeyman -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_electrical_theory_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_theory_l2_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- ============================================================================
-- FOUNDATIONAL — 5
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'What is electrical voltage?',
  '[
    {"key":"A","text":"The opposition to current flow"},
    {"key":"B","text":"The electrical potential difference that can drive current through a circuit"},
    {"key":"C","text":"The rate at which electrical energy is consumed"},
    {"key":"D","text":"The number of conductors in a circuit"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Voltage is electrical potential difference and provides the driving force that can cause current to flow through an electrical path.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'What does electrical resistance describe?',
  '[
    {"key":"A","text":"Opposition to current flow"},
    {"key":"B","text":"The amount of charge stored in a circuit"},
    {"key":"C","text":"The frequency of an alternating-current source"},
    {"key":"D","text":"The total number of loads connected"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Resistance describes how strongly a material or component opposes electrical current.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'According to Ohm''s law, what happens to current if voltage increases while resistance remains constant?',
  '[
    {"key":"A","text":"Current decreases"},
    {"key":"B","text":"Current remains unchanged"},
    {"key":"C","text":"Current increases"},
    {"key":"D","text":"Current becomes zero"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'Ohm''s law states I = V/R, so with resistance unchanged, increasing voltage increases current.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'Which formula represents electrical power in a basic circuit?',
  '[
    {"key":"A","text":"P = V × I"},
    {"key":"B","text":"P = V + I"},
    {"key":"C","text":"P = R ÷ I"},
    {"key":"D","text":"P = V - R"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Electrical power can be calculated as voltage multiplied by current.'
),

(
  5,
  'multiple_choice',
  'foundational',
  'In a simple series circuit, which quantity is the same through each component?',
  '[
    {"key":"A","text":"Voltage drop"},
    {"key":"B","text":"Current"},
    {"key":"C","text":"Resistance"},
    {"key":"D","text":"Power"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A series circuit has one current path, so the same current flows through each component.'
),

-- ============================================================================
-- APPLICATION — 9
-- ============================================================================

(
  6,
  'multiple_choice',
  'application',
  'A 120-volt load has a resistance of 24 ohms. Approximately how much current should it draw?',
  '[
    {"key":"A","text":"2 amperes"},
    {"key":"B","text":"5 amperes"},
    {"key":"C","text":"24 amperes"},
    {"key":"D","text":"120 amperes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Using I = V/R, 120 volts divided by 24 ohms equals 5 amperes.'
),

(
  7,
  'multiple_choice',
  'application',
  'A 120-volt device draws 10 amperes. Approximately how much power is it using?',
  '[
    {"key":"A","text":"12 watts"},
    {"key":"B","text":"120 watts"},
    {"key":"C","text":"1,200 watts"},
    {"key":"D","text":"12,000 watts"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'Using P = V × I, 120 volts multiplied by 10 amperes equals 1,200 watts.'
),

(
  8,
  'situational_judgment',
  'application',
  'Two identical lamps are connected in parallel across a 120-volt source. What voltage should be present across each lamp under normal conditions?',
  '[
    {"key":"A","text":"60 volts"},
    {"key":"B","text":"120 volts"},
    {"key":"C","text":"240 volts"},
    {"key":"D","text":"The voltage cannot be predicted"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Parallel branches are connected across the same source points, so each branch receives the source voltage.'
),

(
  9,
  'multiple_choice',
  'application',
  'A technician measures 12 volts across a 6-ohm resistor. What current should flow through the resistor?',
  '[
    {"key":"A","text":"0.5 amperes"},
    {"key":"B","text":"2 amperes"},
    {"key":"C","text":"6 amperes"},
    {"key":"D","text":"72 amperes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Using I = V/R, 12 volts divided by 6 ohms equals 2 amperes.'
),

(
  10,
  'situational_judgment',
  'application',
  'A series circuit contains two resistors. One resistor is removed and the circuit is left open. What should happen to current in the circuit?',
  '[
    {"key":"A","text":"Current increases"},
    {"key":"B","text":"Current becomes zero"},
    {"key":"C","text":"Current doubles"},
    {"key":"D","text":"Current remains unchanged"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Opening a series circuit breaks the only current path, so current stops.'
),

(
  11,
  'multiple_select',
  'application',
  'Which THREE statements are true for a basic parallel circuit?',
  '[
    {"key":"A","text":"Each branch is connected across the same source voltage"},
    {"key":"B","text":"Total current is the sum of the branch currents"},
    {"key":"C","text":"Opening one branch does not necessarily stop current in the other branches"},
    {"key":"D","text":"The same current must flow through every branch"},
    {"key":"E","text":"Total resistance always equals the largest branch resistance"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Parallel branches share the same source voltage, total current is the sum of branch currents, and one open branch does not necessarily interrupt the others.'
),

(
  12,
  'situational_judgment',
  'application',
  'A resistive load is connected to 240 volts instead of its intended 120 volts, and its resistance remains approximately constant. What happens to current?',
  '[
    {"key":"A","text":"Current is approximately cut in half"},
    {"key":"B","text":"Current remains the same"},
    {"key":"C","text":"Current approximately doubles"},
    {"key":"D","text":"Current becomes zero"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'With resistance approximately constant, doubling voltage approximately doubles current according to Ohm''s law.'
),

(
  13,
  'multiple_choice',
  'application',
  'A circuit draws 4 amperes from a 120-volt source. What is the approximate equivalent resistance?',
  '[
    {"key":"A","text":"15 ohms"},
    {"key":"B","text":"30 ohms"},
    {"key":"C","text":"120 ohms"},
    {"key":"D","text":"480 ohms"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Using R = V/I, 120 volts divided by 4 amperes equals 30 ohms.'
),

(
  14,
  'situational_judgment',
  'application',
  'A parallel circuit has three operating branches. One branch is disconnected. What is the most likely effect on total circuit current?',
  '[
    {"key":"A","text":"Total current decreases because one branch current is removed"},
    {"key":"B","text":"Total current becomes zero"},
    {"key":"C","text":"Total current must double"},
    {"key":"D","text":"Total current cannot change in a parallel circuit"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Total current in a parallel circuit is the sum of branch currents, so removing one operating branch reduces the total current.'
),

-- ============================================================================
-- SCENARIO — 6
-- ============================================================================

(
  15,
  'scenario',
  'scenario',
  'A 120-volt heater normally draws 8 amperes. During troubleshooting, it draws only 4 amperes while source voltage remains near 120 volts. What circuit change is MOST consistent with the measurement?',
  '[
    {"key":"A","text":"The effective resistance has increased"},
    {"key":"B","text":"The effective resistance has decreased"},
    {"key":"C","text":"The source voltage has doubled"},
    {"key":"D","text":"The circuit has become a short circuit"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'At approximately constant voltage, a reduction in current indicates an increase in effective resistance.'
),

(
  16,
  'scenario',
  'scenario',
  'Two identical 60-ohm resistors are connected in series to a 120-volt source. What is the approximate circuit current?',
  '[
    {"key":"A","text":"0.5 amperes"},
    {"key":"B","text":"1 ampere"},
    {"key":"C","text":"2 amperes"},
    {"key":"D","text":"120 amperes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Series resistance is 120 ohms total, so I = 120 volts / 120 ohms = 1 ampere.'
),

(
  17,
  'scenario',
  'scenario',
  'A circuit contains two 60-ohm resistors connected in parallel across 120 volts. Approximately how much total current should the source supply?',
  '[
    {"key":"A","text":"1 ampere"},
    {"key":"B","text":"2 amperes"},
    {"key":"C","text":"4 amperes"},
    {"key":"D","text":"120 amperes"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'Each 60-ohm branch draws 2 amperes at 120 volts, so the total current is approximately 4 amperes.'
),

(
  18,
  'situational_judgment',
  'scenario',
  'A technician expects 120 volts across a load but measures nearly 0 volts while the circuit source is energized. Which possibility should be investigated FIRST as a basic circuit-theory explanation?',
  '[
    {"key":"A","text":"The load may not actually be connected across the source due to an open path or incorrect connection"},
    {"key":"B","text":"The load is definitely drawing excessive current"},
    {"key":"C","text":"The load resistance must be zero"},
    {"key":"D","text":"The source frequency must have doubled"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A near-zero voltage reading across an expected load can indicate the load is not actually connected across the intended source points because of an open or incorrect circuit path.'
),

(
  19,
  'scenario',
  'scenario',
  'A branch circuit is operating normally. A low-resistance fault suddenly develops between conductors. What is the expected electrical effect before protection clears the fault?',
  '[
    {"key":"A","text":"Current tends to increase sharply"},
    {"key":"B","text":"Current tends to fall to zero"},
    {"key":"C","text":"Resistance and current both remain unchanged"},
    {"key":"D","text":"Voltage must increase to twice normal"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'A low-resistance fault creates a much lower impedance path, which can produce very high current until protective devices interrupt it.'
),

(
  20,
  'multiple_choice',
  'scenario',
  'Which behavior BEST demonstrates Level 2 working knowledge of Electrical Theory & Circuits?',
  '[
    {"key":"A","text":"Memorizing formulas without using measurements or circuit relationships"},
    {"key":"B","text":"Using voltage, current, resistance, power, and series/parallel relationships to solve routine circuit problems and interpret basic measurements"},
    {"key":"C","text":"Designing complex power systems independently"},
    {"key":"D","text":"Relying on trial and error instead of circuit principles"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Level 2 performance means applying core electrical relationships to routine calculations, measurements, and circuit behavior with reliable working knowledge.'
);



create temporary table _seed_electrical_theory_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_electrical_theory_l3_questions (
  question_number,
  question_type,
  difficulty,
  prompt,
  options,
  correct_answer,
  rationale
)
values

-- ============================================================================
-- FOUNDATIONAL — 4
-- ============================================================================

(
  1,
  'multiple_choice',
  'foundational',
  'Which relationship correctly describes Kirchhoff''s current law at a circuit node?',
  '[
    {"key":"A","text":"The sum of currents entering a node equals the sum of currents leaving the node"},
    {"key":"B","text":"Voltage is always the same across every series component"},
    {"key":"C","text":"Resistance is the same in all parallel branches"},
    {"key":"D","text":"Power is independent of current"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Kirchhoff''s current law expresses conservation of charge: current entering a node equals current leaving it.'
),

(
  2,
  'multiple_choice',
  'foundational',
  'Which relationship correctly describes Kirchhoff''s voltage law around a closed loop?',
  '[
    {"key":"A","text":"The algebraic sum of voltage rises and drops around the loop equals zero"},
    {"key":"B","text":"Current is always zero in a closed loop"},
    {"key":"C","text":"All resistances in the loop are equal"},
    {"key":"D","text":"Power must equal resistance"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Kirchhoff''s voltage law expresses conservation of energy around a closed electrical loop.'
),

(
  3,
  'multiple_choice',
  'foundational',
  'What is the main electrical difference between an open circuit and a short circuit?',
  '[
    {"key":"A","text":"An open circuit has an interrupted current path, while a short circuit creates an unintended very-low-resistance path"},
    {"key":"B","text":"An open circuit always has high current, while a short always has zero current"},
    {"key":"C","text":"There is no electrical difference"},
    {"key":"D","text":"A short circuit only occurs in direct-current systems"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'An open interrupts the intended path; a short creates an unintended low-impedance path that can allow excessive current.'
),

(
  4,
  'multiple_choice',
  'foundational',
  'For a primarily resistive AC load, what is true about voltage and current?',
  '[
    {"key":"A","text":"They are approximately in phase"},
    {"key":"B","text":"Current always leads voltage by 90 degrees"},
    {"key":"C","text":"Current always lags voltage by 90 degrees"},
    {"key":"D","text":"They are unrelated"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'In an ideal resistive AC load, voltage and current are in phase.'
),

-- ============================================================================
-- APPLICATION — 7
-- ============================================================================

(
  5,
  'multiple_choice',
  'application',
  'A 240-volt load consumes 4,800 watts at unity power factor. Approximately how much current does it draw?',
  '[
    {"key":"A","text":"10 amperes"},
    {"key":"B","text":"20 amperes"},
    {"key":"C","text":"40 amperes"},
    {"key":"D","text":"1,200 amperes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'At unity power factor, I = P/V, so 4,800 watts divided by 240 volts equals 20 amperes.'
),

(
  6,
  'situational_judgment',
  'application',
  'A 120-volt series circuit contains a 20-ohm resistor and a 40-ohm resistor. Which voltage-drop pattern is expected?',
  '[
    {"key":"A","text":"Each resistor drops 60 volts"},
    {"key":"B","text":"The 20-ohm resistor drops about 40 volts and the 40-ohm resistor drops about 80 volts"},
    {"key":"C","text":"The 20-ohm resistor drops about 80 volts and the 40-ohm resistor drops about 40 volts"},
    {"key":"D","text":"Neither resistor has a voltage drop"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'The same series current flows through both resistors, so voltage drop is proportional to resistance.'
),

(
  7,
  'multiple_select',
  'application',
  'Which THREE measurements or observations are especially useful when evaluating whether a resistive load is behaving as expected?',
  '[
    {"key":"A","text":"Applied voltage"},
    {"key":"B","text":"Load current"},
    {"key":"C","text":"Expected or measured resistance/power relationship"},
    {"key":"D","text":"Conductor insulation color alone"},
    {"key":"E","text":"The age of the building by itself"}
  ]'::jsonb,
  '["A","B","C"]'::jsonb,
  'Voltage, current, resistance, and power relationships can be compared to expected values to evaluate basic load behavior.'
),

(
  8,
  'situational_judgment',
  'application',
  'A parallel circuit has branch currents of 2 amperes, 3 amperes, and 5 amperes. What total current should be expected at the source conductor supplying the node?',
  '[
    {"key":"A","text":"3 amperes"},
    {"key":"B","text":"5 amperes"},
    {"key":"C","text":"10 amperes"},
    {"key":"D","text":"30 amperes"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'By Kirchhoff''s current law, the source current is the sum of the branch currents: 2 + 3 + 5 = 10 amperes.'
),

(
  9,
  'multiple_choice',
  'application',
  'A circuit operates at 120 volts and draws 6 amperes. If effective resistance doubles while source voltage stays the same, what current should be expected approximately?',
  '[
    {"key":"A","text":"3 amperes"},
    {"key":"B","text":"6 amperes"},
    {"key":"C","text":"12 amperes"},
    {"key":"D","text":"24 amperes"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'At constant voltage, doubling resistance halves current according to Ohm''s law.'
),

(
  10,
  'situational_judgment',
  'application',
  'A 120-volt source supplies two parallel resistive branches drawing 4 amperes and 6 amperes. Approximately how much total power is being supplied?',
  '[
    {"key":"A","text":"120 watts"},
    {"key":"B","text":"600 watts"},
    {"key":"C","text":"1,200 watts"},
    {"key":"D","text":"12,000 watts"}
  ]'::jsonb,
  '["C"]'::jsonb,
  'Total current is 10 amperes, so total power is approximately 120 volts × 10 amperes = 1,200 watts.'
),

(
  11,
  'situational_judgment',
  'application',
  'A load expected to draw 10 amperes at 120 volts is drawing only 2 amperes. Source voltage is correct. Which electrical condition is MOST consistent with the observation?',
  '[
    {"key":"A","text":"Effective load resistance is higher than expected"},
    {"key":"B","text":"Effective load resistance is lower than expected"},
    {"key":"C","text":"The source voltage must actually be 600 volts"},
    {"key":"D","text":"The circuit must be a dead short"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'With correct voltage but lower current, the effective resistance is higher than expected.'
),

-- ============================================================================
-- SCENARIO — 9
-- ============================================================================

(
  12,
  'scenario',
  'scenario',
  'A 240-volt circuit contains two equal resistive loads in series. You measure approximately 120 volts across each load. What does this indicate?',
  '[
    {"key":"A","text":"The equal resistances are dividing the source voltage approximately equally"},
    {"key":"B","text":"The circuit is necessarily shorted"},
    {"key":"C","text":"No current is flowing"},
    {"key":"D","text":"The source is actually 120 volts"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'Equal series resistances with the same current produce approximately equal voltage drops that sum to the source voltage.'
),

(
  13,
  'situational_judgment',
  'scenario',
  'A 120-volt parallel circuit has one branch that suddenly opens. The other branches continue operating normally. Which measurement change is MOST likely at the source?',
  '[
    {"key":"A","text":"Source voltage becomes zero"},
    {"key":"B","text":"Total current decreases"},
    {"key":"C","text":"Total current increases dramatically"},
    {"key":"D","text":"Frequency doubles"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Removing one parallel branch removes that branch current while the remaining branches can continue operating at the same source voltage.'
),

(
  14,
  'scenario',
  'scenario',
  'You measure full source voltage across an open switch in a simple circuit, but nearly zero voltage across the load. What is the BEST circuit-theory explanation?',
  '[
    {"key":"A","text":"The open switch is interrupting the current path, so the source voltage appears across the open point"},
    {"key":"B","text":"The load must be shorted"},
    {"key":"C","text":"The source has no voltage"},
    {"key":"D","text":"Current is at maximum through the load"}
  ]'::jsonb,
  '["A"]'::jsonb,
  'With the circuit open, current is essentially zero and the available source voltage can appear across the open point rather than the load.'
),

(
  15,
  'scenario',
  'scenario',
  'A technician measures almost zero volts across a closed switch carrying normal current. What does that usually indicate about the switch?',
  '[
    {"key":"A","text":"It has a large voltage drop and high resistance"},
    {"key":"B","text":"It has a low-resistance conducting path as expected"},
    {"key":"C","text":"It is definitely open"},
    {"key":"D","text":"The source is disconnected"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'A properly closed switch should have very low resistance and therefore very little voltage drop while current is flowing.'
),

(
  16,
  'scenario',
  'scenario',
  'A 120-volt resistive load normally draws 5 amperes. It now draws 10 amperes at the same source voltage. What change is MOST consistent with the measurement?',
  '[
    {"key":"A","text":"Effective resistance has approximately doubled"},
    {"key":"B","text":"Effective resistance has approximately been cut in half"},
    {"key":"C","text":"The circuit has opened"},
    {"key":"D","text":"Power consumption has decreased to zero"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'At constant voltage, doubling current corresponds to approximately halving the effective resistance.'
),

(
  17,
  'situational_judgment',
  'scenario',
  'A series circuit has three expected voltage drops of approximately 30 volts, 40 volts, and 50 volts. What source voltage is consistent with Kirchhoff''s voltage law?',
  '[
    {"key":"A","text":"40 volts"},
    {"key":"B","text":"50 volts"},
    {"key":"C","text":"90 volts"},
    {"key":"D","text":"120 volts"}
  ]'::jsonb,
  '["D"]'::jsonb,
  'The series voltage drops should sum to the source voltage: 30 + 40 + 50 = 120 volts.'
),

(
  18,
  'scenario',
  'scenario',
  'A parallel circuit has a stable 120-volt source. One branch develops lower resistance without becoming a direct short. What should happen to that branch current and total circuit current?',
  '[
    {"key":"A","text":"Branch current decreases and total current decreases"},
    {"key":"B","text":"Branch current increases and total current increases"},
    {"key":"C","text":"Branch current remains unchanged and total current becomes zero"},
    {"key":"D","text":"Only source voltage changes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'At constant branch voltage, lower resistance causes higher branch current, which also increases the total source current.'
),

(
  19,
  'scenario',
  'scenario',
  'A resistive appliance is rated 1,500 watts at 120 volts. Approximately what operating current should you expect?',
  '[
    {"key":"A","text":"6.25 amperes"},
    {"key":"B","text":"12.5 amperes"},
    {"key":"C","text":"15 amperes"},
    {"key":"D","text":"125 amperes"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Using I = P/V, 1,500 watts divided by 120 volts equals approximately 12.5 amperes.'
),

(
  20,
  'multiple_choice',
  'scenario',
  'Which behavior BEST demonstrates Level 3 proficiency in Electrical Theory & Circuits?',
  '[
    {"key":"A","text":"Using formulas only when someone else identifies the circuit problem"},
    {"key":"B","text":"Independently applying circuit laws, expected voltage/current relationships, and measured values to analyze routine circuit behavior and identify likely faults"},
    {"key":"C","text":"Avoiding calculations because field measurements are always sufficient"},
    {"key":"D","text":"Treating all circuits as if they were simple series circuits"}
  ]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance means independently using electrical theory and measured evidence to analyze circuit behavior and diagnose routine deviations.'
);



do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '931db240-5673-4c25-adb9-911b1c7b39ea';
  v_apprentice_role_id uuid := 'a3807562-0a94-43a3-a7b5-2389573138d2';
  v_journeyman_role_id uuid := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60';
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
  where lower(i.slug) = 'electrical'
     or lower(i.name) = 'electrical'
  order by case when lower(i.slug) = 'electrical' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Electrical industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Electrical Theory & Circuits'
      and c.is_current = true
  ) then
    raise exception 'Current Electrical Theory & Circuits Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_apprentice_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Apprentice'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Electrician Apprentice L3 safety requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_journeyman_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Electrician Journeyman'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Electrician Journeyman L3 Electrical Theory requirement not found';
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
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := 'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid;
  v_assessment_name := 'Electrical Theory & Circuits — Level 2 Competency Assessment';

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
    select * from _seed_electrical_theory_l2_questions
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
        'Electrical Theory & Circuits',
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
      'IntegrateU Electrical Theory & Circuits L2 production assessment v1.0.',
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
        'Electrical Theory & Circuits',
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
        'IntegrateU Electrical Theory & Circuits L2 production assessment v1.0.',
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
  v_role_template_id := '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid;
  v_assessment_name := 'Electrical Theory & Circuits — Level 3 Competency Assessment';

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
    select * from _seed_electrical_theory_l3_questions
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
        'Electrical Theory & Circuits',
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
      'IntegrateU Electrical Theory & Circuits L3 production assessment v1.0.',
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
        'Electrical Theory & Circuits',
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
        'IntegrateU Electrical Theory & Circuits L3 production assessment v1.0.',
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
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
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
   '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid
  and a.target_level in (2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 2 Apprentice  -> 20
--   Level 3 Journeyman -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid
    and a.target_level in (2,3)
    and aq.master_competency_template_id =
      '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 2 and ra.master_role_template_id =
    'a3807562-0a94-43a3-a7b5-2389573138d2'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '1c347f93-4e90-4faa-ac20-eb7f39ba9c60'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid;

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
    '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid
  and a.target_level in (2,3)
group by a.target_level
having count(*) > 1;
