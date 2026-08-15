-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_refrigerant_piping_line_set_installation_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Refrigerant Piping & Line-Set Installation
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Design & Sales Engineer     -> Level 2
--   HVAC Installer / Helper          -> Level 2
--   HVAC Service & Repair Technician -> Level 3
--   Senior / Lead HVAC Technician    -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_refrigerant_piping_line_set_installation_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_piping_line_set_installation_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of refrigerant piping in an HVAC system?',
  '[{"key":"A","text":"To carry refrigerant between system components through the refrigeration circuit"},{"key":"B","text":"To distribute supply air to occupied rooms"},{"key":"C","text":"To drain condensate from the evaporator"},{"key":"D","text":"To provide electrical grounding"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping connects system components and carries refrigerant through the refrigeration circuit.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should refrigerant tubing ends be kept capped or sealed during installation when practical?',
  '[{"key":"A","text":"To reduce entry of dirt, moisture, and other contamination"},{"key":"B","text":"To increase tubing pressure"},{"key":"C","text":"To soften the copper"},{"key":"D","text":"To eliminate the need for evacuation"}]'::jsonb,
  '["A"]'::jsonb,
  'Keeping tubing protected helps preserve refrigerant-circuit cleanliness and reduces contamination introduced during installation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is proper support important for refrigerant piping?',
  '[{"key":"A","text":"It helps prevent sagging, vibration, movement, and unnecessary stress at connections"},{"key":"B","text":"It increases refrigerant temperature"},{"key":"C","text":"It replaces insulation"},{"key":"D","text":"It eliminates pressure drop"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper support limits movement and stress that can damage piping or joined connections.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a common concern when refrigerant tubing is kinked or badly flattened?',
  '[{"key":"A","text":"The restriction can interfere with refrigerant flow and system performance"},{"key":"B","text":"The tubing becomes stronger"},{"key":"C","text":"The system automatically compensates"},{"key":"D","text":"The refrigerant changes type"}]'::jsonb,
  '["A"]'::jsonb,
  'Severe deformation reduces the effective flow area and can create an unwanted refrigerant restriction.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should suction-line insulation remain continuous and properly sealed where required?',
  '[{"key":"A","text":"To limit unwanted heat gain and help prevent surface condensation"},{"key":"B","text":"To increase liquid-line pressure"},{"key":"C","text":"To replace pipe supports"},{"key":"D","text":"To make brazed joints stronger"}]'::jsonb,
  '["A"]'::jsonb,
  'Proper insulation helps control heat transfer and condensation on cold refrigerant piping.'
),
(
  6,
  'multiple_choice',
  'application',
  'An installer finds an open roll of copper tubing that has been sitting in a dusty work area. What is the BEST response?',
  '[{"key":"A","text":"Inspect and clean or replace the tubing as required before using it in the refrigerant circuit"},{"key":"B","text":"Install it because evacuation will remove all debris"},{"key":"C","text":"Blow through it with refrigerant"},{"key":"D","text":"Use it only on the suction line"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible or suspected contamination should be addressed before the tubing becomes part of the sealed refrigerant circuit.'
),
(
  7,
  'multiple_choice',
  'application',
  'A line set is routed across a sharp metal edge that could rub against the tubing during operation. What should be done?',
  '[{"key":"A","text":"Reroute or protect the piping so vibration and movement cannot damage it"},{"key":"B","text":"Leave it because copper is soft"},{"key":"C","text":"Increase the refrigerant charge"},{"key":"D","text":"Remove the pipe supports"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping should be protected from abrasion and contact that could lead to wear or leakage.'
),
(
  8,
  'multiple_choice',
  'application',
  'An installer must make a bend in soft copper tubing. What is the BEST objective?',
  '[{"key":"A","text":"Create the required bend without kinking, flattening, or damaging the tubing"},{"key":"B","text":"Make the bend as sharp as possible"},{"key":"C","text":"Flatten the tubing slightly to hold its position"},{"key":"D","text":"Heat the tubing until it collapses into shape"}]'::jsonb,
  '["A"]'::jsonb,
  'A properly formed bend preserves tubing integrity and flow area.'
),
(
  9,
  'multiple_choice',
  'application',
  'A line set has excessive unsupported length and visibly moves when the equipment starts. What is the BEST correction?',
  '[{"key":"A","text":"Add or correct supports using the approved method so movement and stress are controlled"},{"key":"B","text":"Increase refrigerant pressure"},{"key":"C","text":"Wrap the tubing more tightly with insulation only"},{"key":"D","text":"Remove nearby supports"}]'::jsonb,
  '["A"]'::jsonb,
  'Unsupported piping can vibrate and transfer stress into fittings and joints, so the support condition should be corrected.'
),
(
  10,
  'multiple_choice',
  'application',
  'A suction-line insulation seam is open for several feet and condensation is forming on the copper. What is the BEST response?',
  '[{"key":"A","text":"Repair the insulation and vapor-seal condition using the approved method"},{"key":"B","text":"Increase blower speed"},{"key":"C","text":"Remove the remaining insulation"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged or open insulation can allow heat gain and condensation and should be restored.'
),
(
  11,
  'multiple_choice',
  'application',
  'A planned line-set route blocks access to an equipment service panel. What is the BEST response?',
  '[{"key":"A","text":"Reroute the piping so required service access is maintained"},{"key":"B","text":"Install it and remove the panel later"},{"key":"C","text":"Reduce tubing size until it fits"},{"key":"D","text":"Route it across the panel and label it"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping layout should preserve required access to equipment and service components.'
),
(
  12,
  'multiple_choice',
  'application',
  'An installer sees a section of liquid line badly flattened where it passes through framing. What is the BEST response?',
  '[{"key":"A","text":"Correct or replace the damaged section before the system is placed into service"},{"key":"B","text":"Leave it because liquid refrigerant can pass through any opening"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Insulate over the damage"}]'::jsonb,
  '["A"]'::jsonb,
  'A badly flattened line can become a significant restriction and should be corrected.'
),
(
  13,
  'multiple_choice',
  'application',
  'A refrigerant line passes through a wall opening with no protection from the rough edge. What is the BEST action?',
  '[{"key":"A","text":"Protect the tubing at the penetration so movement cannot cause abrasion or damage"},{"key":"B","text":"Leave the tubing touching the edge"},{"key":"C","text":"Increase pipe pressure"},{"key":"D","text":"Remove all insulation near the wall"}]'::jsonb,
  '["A"]'::jsonb,
  'Penetrations should be arranged to protect refrigerant tubing from abrasion and physical damage.'
),
(
  14,
  'multiple_choice',
  'application',
  'Before joining a replacement line-set section, what should be confirmed?',
  '[{"key":"A","text":"Correct tubing size, clean condition, proper routing, support, and suitable joint preparation"},{"key":"B","text":"Only that the tubing color matches"},{"key":"C","text":"Only that the thermostat is off"},{"key":"D","text":"Only that the outdoor unit is level"}]'::jsonb,
  '["A"]'::jsonb,
  'Successful piping work begins with correct materials, cleanliness, routing, support, and connection preparation.'
),
(
  15,
  'scenario',
  'scenario',
  'After installation, a suction line vibrates against a metal stud whenever the compressor runs. What is the BEST response?',
  '[{"key":"A","text":"Reposition, support, or isolate the piping so it no longer rubs against the structure"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Remove insulation at the contact point"},{"key":"D","text":"Ignore it if the system is cooling"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated vibration against framing can cause noise, abrasion, and eventual piping damage.'
),
(
  16,
  'scenario',
  'scenario',
  'An installer discovers that the proposed line-set path requires a severe bend that would likely kink the tubing. What is the BEST response?',
  '[{"key":"A","text":"Choose an approved alternate route or fitting arrangement that preserves tubing integrity"},{"key":"B","text":"Force the tubing through the bend"},{"key":"C","text":"Flatten the bend slightly"},{"key":"D","text":"Reduce tubing size"}]'::jsonb,
  '["A"]'::jsonb,
  'Routing conflicts should be solved without damaging or restricting the refrigerant piping.'
),
(
  17,
  'scenario',
  'scenario',
  'A newly installed line set is complete, but several open tubing ends were left exposed overnight before final assembly. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the tubing for contamination and clean or replace affected sections as required before sealing the circuit"},{"key":"B","text":"Seal the ends and assume the tubing is clean"},{"key":"C","text":"Add extra refrigerant after startup"},{"key":"D","text":"Skip evacuation"}]'::jsonb,
  '["A"]'::jsonb,
  'Open tubing can admit moisture and debris, so contamination risk should be addressed before the circuit is completed.'
),
(
  18,
  'scenario',
  'scenario',
  'A service technician finds oil staining where a line set has been rubbing against a sharp support bracket. What is the BEST response?',
  '[{"key":"A","text":"Treat the area as a possible leak, correct the physical damage and support condition, and verify system integrity"},{"key":"B","text":"Wipe the oil away and continue operation"},{"key":"C","text":"Add insulation over the bracket"},{"key":"D","text":"Increase system pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Oil staining at an abrasion point can indicate refrigerant leakage and should prompt both leak repair and correction of the damaging condition.'
),
(
  19,
  'scenario',
  'scenario',
  'A line set is tightly bundled with electrical wiring and condensate piping, making future service difficult and creating several contact points. What is the BEST response?',
  '[{"key":"A","text":"Reorganize and support the piping so the line set is protected and reasonable service access is maintained"},{"key":"B","text":"Tighten the bundle further"},{"key":"C","text":"Remove all pipe insulation"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping should be routed and supported to avoid damage and maintain reasonable serviceability.'
),
(
  20,
  'scenario',
  'scenario',
  'A final inspection finds the correct tubing sizes were used, but the suction-line insulation is incomplete and multiple penetrations leave the copper rubbing on rough edges. What is the BEST response?',
  '[{"key":"A","text":"Correct the insulation and penetration protection before final acceptance"},{"key":"B","text":"Accept the work because tubing size is correct"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Add refrigerant"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete line-set installation includes proper tubing protection and insulation, not only correct tubing size.'
);

create temporary table _seed_hvac_refrigerant_piping_line_set_installation_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_piping_line_set_installation_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Refrigerant Piping & Line-Set Installation?',
  '[{"key":"A","text":"Routing tubing mainly by shortest distance"},{"key":"B","text":"Independently evaluating piping size, routing, support, cleanliness, insulation, mechanical stress, and serviceability while correcting installation defects"},{"key":"C","text":"Using refrigerant charge to compensate for piping restrictions"},{"key":"D","text":"Treating tubing damage as cosmetic if the system still runs"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent judgment about piping integrity, contamination control, routing, support, and system impact.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why can a severe restriction in refrigerant piping affect system operation?',
  '[{"key":"A","text":"It can create abnormal pressure drop and interfere with proper refrigerant flow"},{"key":"B","text":"It improves refrigerant distribution"},{"key":"C","text":"It eliminates the need for a metering device"},{"key":"D","text":"It increases tubing wall thickness"}]'::jsonb,
  '["A"]'::jsonb,
  'Restrictions can change refrigerant flow and pressure conditions and may cause poor capacity or abnormal operating conditions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is refrigerant-circuit cleanliness important during piping repairs?',
  '[{"key":"A","text":"Moisture and debris can damage or restrict sensitive system components"},{"key":"B","text":"Contamination improves heat transfer"},{"key":"C","text":"Evacuation converts debris into vapor"},{"key":"D","text":"Filters always remove every contaminant"}]'::jsonb,
  '["A"]'::jsonb,
  'Contamination introduced during piping work can circulate through the system and damage or restrict components.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should refrigerant piping be evaluated for mechanical stress after a repair?',
  '[{"key":"A","text":"Misalignment, vibration, or poor support can contribute to future joint or tubing failure"},{"key":"B","text":"Mechanical stress increases refrigerant purity"},{"key":"C","text":"Stress always improves brazed-joint strength"},{"key":"D","text":"Piping support matters only before startup"}]'::jsonb,
  '["A"]'::jsonb,
  'A sound repair should address both the leak or defect and the conditions that may have caused it.'
),
(
  5,
  'multiple_choice',
  'application',
  'A service technician finds a suction line sharply kinked near the air handler. What is the BEST response?',
  '[{"key":"A","text":"Correct or replace the damaged section and then evaluate system performance"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Insulate over the kink"},{"key":"D","text":"Raise blower speed"}]'::jsonb,
  '["A"]'::jsonb,
  'A severe kink can restrict refrigerant flow and should be corrected rather than masked through operating adjustments.'
),
(
  6,
  'multiple_choice',
  'application',
  'A refrigerant line has oil staining where it passes through a metal penetration. What should the technician do FIRST?',
  '[{"key":"A","text":"Treat the area as a possible leak and inspect the tubing for abrasion or damage"},{"key":"B","text":"Wipe the oil away and continue operation"},{"key":"C","text":"Increase system pressure"},{"key":"D","text":"Add insulation without inspection"}]'::jsonb,
  '["A"]'::jsonb,
  'Oil staining at a physical contact point can indicate refrigerant leakage and tubing damage.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician replaces a section of refrigerant tubing after a compressor failure. What is an important piping consideration?',
  '[{"key":"A","text":"Prevent introducing debris or moisture and address contamination that may remain in the circuit"},{"key":"B","text":"Leave tubing ends open until startup"},{"key":"C","text":"Use smaller tubing to raise velocity"},{"key":"D","text":"Skip evacuation if the replacement section is short"}]'::jsonb,
  '["A"]'::jsonb,
  'Major component failure and open-circuit repair can create contamination risks that should be controlled during piping work.'
),
(
  8,
  'multiple_choice',
  'application',
  'A line set is properly sized but vibrates strongly against the building structure during compressor operation. What is the BEST response?',
  '[{"key":"A","text":"Correct the support, routing, or isolation so vibration is not transferred into the tubing or structure"},{"key":"B","text":"Increase refrigerant charge"},{"key":"C","text":"Remove the pipe insulation"},{"key":"D","text":"Leave it because tubing size is correct"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct tubing size does not make excessive vibration acceptable; mechanical conditions should also be corrected.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician finds wet and deteriorated suction-line insulation. What is the BEST response?',
  '[{"key":"A","text":"Determine why the insulation failed and restore the insulation and vapor-seal condition"},{"key":"B","text":"Remove all insulation permanently"},{"key":"C","text":"Increase condensing pressure"},{"key":"D","text":"Reduce airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Wet or damaged insulation should be restored, and the cause of the failure should be addressed.'
),
(
  10,
  'multiple_choice',
  'application',
  'A field repair would leave a new joint carrying the weight of an unsupported piping section. What should the technician do?',
  '[{"key":"A","text":"Correct the piping support so the joint is not left under unnecessary mechanical load"},{"key":"B","text":"Use extra filler material"},{"key":"C","text":"Increase test pressure"},{"key":"D","text":"Add insulation around the joint"}]'::jsonb,
  '["A"]'::jsonb,
  'Connections should not be used as structural supports for improperly supported piping.'
),
(
  11,
  'multiple_choice',
  'application',
  'A service call reveals repeated refrigerant leaks at the same wall penetration. What is the BEST approach?',
  '[{"key":"A","text":"Correct the abrasion or movement condition at the penetration as part of the leak repair"},{"key":"B","text":"Repair the leak only and leave the penetration unchanged"},{"key":"C","text":"Add refrigerant after each leak"},{"key":"D","text":"Increase tubing pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated leaks at one location suggest an underlying physical cause that should be corrected.'
),
(
  12,
  'scenario',
  'scenario',
  'A system has poor cooling and abnormal pressures. Inspection finds a liquid line pinched nearly flat behind a wall access panel. What is the BEST response?',
  '[{"key":"A","text":"Correct the damaged piping and then reassess system operation before making charge adjustments"},{"key":"B","text":"Add refrigerant immediately"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Adjust the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'A known refrigerant-line restriction should be corrected before interpreting or adjusting the refrigerant charge.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician opens a system for repair and finds moisture and construction debris inside an uncapped line-set section. What is the BEST response?',
  '[{"key":"A","text":"Address the contaminated piping and follow the approved cleanup and repair process before returning the circuit to service"},{"key":"B","text":"Seal the tubing and rely on the filter-drier alone"},{"key":"C","text":"Add extra refrigerant"},{"key":"D","text":"Skip evacuation"}]'::jsonb,
  '["A"]'::jsonb,
  'Visible contamination should be addressed directly rather than assumed to be harmless.'
),
(
  14,
  'scenario',
  'scenario',
  'A repaired suction line repeatedly cracks near a compressor connection. The pipe is rigidly supported and transmits strong compressor vibration. What is the BEST response?',
  '[{"key":"A","text":"Correct the vibration-transfer and piping-support condition in addition to repairing the damaged tubing"},{"key":"B","text":"Continue replacing the cracked section"},{"key":"C","text":"Increase filler material at the joint"},{"key":"D","text":"Reduce refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring failure near vibrating equipment points to a mechanical root cause that should be corrected.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician finds a long suction line with missing insulation in a humid space. Condensation is dripping onto ceiling materials. What is the BEST response?',
  '[{"key":"A","text":"Restore the required insulation and vapor seal and address any damaged surrounding materials"},{"key":"B","text":"Raise the thermostat setpoint only"},{"key":"C","text":"Reduce refrigerant charge"},{"key":"D","text":"Leave the copper exposed so it can dry"}]'::jsonb,
  '["A"]'::jsonb,
  'Uninsulated cold suction piping can gain heat and condense moisture, so the insulation system should be restored.'
),
(
  16,
  'scenario',
  'scenario',
  'A line set has been rerouted during a remodel and now blocks access to a service valve and control compartment. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Rework the piping route so service access is restored without compromising piping integrity"},{"key":"B","text":"Leave it and document the obstruction"},{"key":"C","text":"Remove the service valve"},{"key":"D","text":"Cut the control-panel cover smaller"}]'::jsonb,
  '["A"]'::jsonb,
  'Piping changes should preserve required serviceability and component access.'
),
(
  17,
  'scenario',
  'scenario',
  'A system slowly loses refrigerant. The only visible evidence is oil staining along a line where insulation has worn through and copper touches a hanger. What is the BEST response?',
  '[{"key":"A","text":"Inspect and leak-test the contact area, repair any tubing damage, and correct the hanger or protection condition"},{"key":"B","text":"Replace the thermostat"},{"key":"C","text":"Add refrigerant and rewrap the insulation"},{"key":"D","text":"Increase operating pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'The physical contact point is a likely failure location and both the leak and its cause should be addressed.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician is replacing a failed line-set section but discovers the proposed replacement tubing is a different size from the equipment requirement. What is the BEST response?',
  '[{"key":"A","text":"Use the correct approved tubing size or obtain an approved design change before proceeding"},{"key":"B","text":"Use the available tubing and adjust charge later"},{"key":"C","text":"Flatten the tubing to match the old line"},{"key":"D","text":"Increase blower airflow"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping size is part of the system design and should not be changed casually in the field.'
),
(
  19,
  'scenario',
  'scenario',
  'After a piping repair, the system passes a leak test but the technician notices the new tubing is rubbing against another pipe and already shows vibration marks. What is the BEST response?',
  '[{"key":"A","text":"Correct the contact and support condition before accepting the repair"},{"key":"B","text":"Accept it because the leak test passed"},{"key":"C","text":"Add thicker insulation only"},{"key":"D","text":"Increase test pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'A passed leak test does not eliminate a visible mechanical condition that could create a future failure.'
),
(
  20,
  'scenario',
  'scenario',
  'A recurring service history shows refrigerant leaks at several different joints along one poorly supported line set. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Treat the support and movement problem as a system-wide root cause while repairing the confirmed leaks"},{"key":"B","text":"Repair each leak independently without changing support"},{"key":"C","text":"Increase refrigerant charge after each repair"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple failures along the same poorly supported piping run indicate a broader mechanical problem that should be corrected.'
);

create temporary table _seed_hvac_refrigerant_piping_line_set_installation_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_refrigerant_piping_line_set_installation_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Refrigerant Piping & Line-Set Installation?',
  '[{"key":"A","text":"Evaluating only whether the tubing reaches the equipment"},{"key":"B","text":"Leading consistent piping practices for sizing, routing, cleanliness, support, insulation, serviceability, and recurring-failure prevention across installations"},{"key":"C","text":"Allowing each technician to choose tubing size based on convenience"},{"key":"D","text":"Using refrigerant charge to compensate for installation defects"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes technical leadership over installation quality, system integrity, serviceability, and root-cause prevention.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should recurring refrigerant-line failures be reviewed as a process issue?',
  '[{"key":"A","text":"Repeated failures may indicate common problems with routing, support, vibration, contamination control, sizing, or installation practices"},{"key":"B","text":"Repeated failures always mean the refrigerant is defective"},{"key":"C","text":"Each failure should be assumed unrelated"},{"key":"D","text":"Recurring leaks are normal"}]'::jsonb,
  '["A"]'::jsonb,
  'Patterns across multiple failures can reveal common workmanship or design weaknesses that should be corrected broadly.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to standardize refrigerant-piping installation practices?',
  '[{"key":"A","text":"To make sizing, cleanliness, protection, support, insulation, and verification more consistent across crews and projects"},{"key":"B","text":"To eliminate technician judgment entirely"},{"key":"C","text":"To allow smaller tubing everywhere"},{"key":"D","text":"To remove the need for commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Standardized practices help reduce variation that can lead to restrictions, contamination, leaks, and serviceability problems.'
),
(
  4,
  'multiple_choice',
  'application',
  'A senior technician reviews several line-set failures concentrated at wall penetrations. What should be investigated first?',
  '[{"key":"A","text":"Protection from abrasion, piping movement, support, and penetration details across the affected installations"},{"key":"B","text":"Thermostat programming"},{"key":"C","text":"Filter type"},{"key":"D","text":"Supply-register size"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures at penetrations strongly suggest a common physical-protection or movement problem.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project team proposes using a smaller refrigerant-line size because it is easier to route through framing. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Require the approved piping size or an engineered design change before installation"},{"key":"B","text":"Approve the smaller tubing and add more refrigerant"},{"key":"C","text":"Use the smaller tubing only on long runs"},{"key":"D","text":"Increase blower airflow to compensate"}]'::jsonb,
  '["A"]'::jsonb,
  'Refrigerant piping size is part of system design and should not be changed casually for installation convenience.'
),
(
  6,
  'multiple_choice',
  'application',
  'A quality audit finds many suction-line insulation failures at seams and terminations. What is the BEST response?',
  '[{"key":"A","text":"Standardize the insulation and vapor-seal installation method and verify field compliance"},{"key":"B","text":"Remove insulation from all suction lines"},{"key":"C","text":"Raise operating pressure"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated insulation failures point to a process or workmanship issue that should be corrected consistently.'
),
(
  7,
  'multiple_choice',
  'application',
  'Several compressors connected to long line sets show recurring vibration-related tubing cracks. What should the senior lead investigate?',
  '[{"key":"A","text":"Piping support, vibration isolation, routing, equipment movement, and joint stress"},{"key":"B","text":"Thermostat batteries"},{"key":"C","text":"Filter color"},{"key":"D","text":"Supply-air temperature only"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated vibration-related failures require review of the mechanical conditions acting on the piping.'
),
(
  8,
  'multiple_choice',
  'application',
  'A company has inconsistent practices for keeping tubing clean during storage and installation. What is the BEST response?',
  '[{"key":"A","text":"Establish and enforce a standard for protecting tubing from moisture, dirt, and debris before the circuit is sealed"},{"key":"B","text":"Rely on evacuation to remove all contamination"},{"key":"C","text":"Leave tubing open so moisture can escape"},{"key":"D","text":"Use refrigerant vapor to clean the tubing"}]'::jsonb,
  '["A"]'::jsonb,
  'Contamination prevention should be managed before dirt or moisture enters the refrigerant circuit.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician finds that crews routinely route line sets across service panels because it shortens installation time. What is the BEST response?',
  '[{"key":"A","text":"Correct the routing standard so required service access is preserved"},{"key":"B","text":"Allow it on residential equipment only"},{"key":"C","text":"Remove the service panels"},{"key":"D","text":"Document the obstruction and leave it"}]'::jsonb,
  '["A"]'::jsonb,
  'Installation efficiency should not create permanent service-access problems.'
),
(
  10,
  'multiple_choice',
  'application',
  'A branch has recurring callbacks caused by kinked soft-copper bends. What is the BEST corrective approach?',
  '[{"key":"A","text":"Improve bending methods, tooling, training, and field quality checks"},{"key":"B","text":"Increase refrigerant charge after each installation"},{"key":"C","text":"Accept small kinks as normal"},{"key":"D","text":"Use smaller tubing everywhere"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring bend-quality problem should be addressed through the installation process rather than repeated service corrections.'
),
(
  11,
  'scenario',
  'scenario',
  'A senior technician audits multiple installations and finds oil staining at line-set supports on several sites. The supports all use the same sharp-edged bracket. What is the BEST response?',
  '[{"key":"A","text":"Treat the bracket detail as a systemic abrasion risk, correct affected installations, and revise the support method"},{"key":"B","text":"Wipe the oil off and monitor"},{"key":"C","text":"Add more refrigerant"},{"key":"D","text":"Increase pipe insulation thickness only"}]'::jsonb,
  '["A"]'::jsonb,
  'The repeated pattern indicates a shared support-detail problem that should be corrected across affected work.'
),
(
  12,
  'scenario',
  'scenario',
  'A large project has multiple equipment locations using long refrigerant runs. Field crews want to change routing and tubing sizes without documentation. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Require review and approval of routing and sizing changes before installation and document the accepted configuration"},{"key":"B","text":"Allow any change that physically fits"},{"key":"C","text":"Let crews adjust charge after startup"},{"key":"D","text":"Use the smallest tubing available"}]'::jsonb,
  '["A"]'::jsonb,
  'Significant piping changes can affect performance and should be technically reviewed and documented.'
),
(
  13,
  'scenario',
  'scenario',
  'A system repeatedly loses refrigerant at different joints along one long line set. Inspection finds the entire run poorly supported and under constant mechanical tension. What is the BEST response?',
  '[{"key":"A","text":"Correct the routing, support, and mechanical stress across the run while repairing the confirmed leaks"},{"key":"B","text":"Repair each leak individually"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Use more filler material at every joint"}]'::jsonb,
  '["A"]'::jsonb,
  'Multiple failures along one stressed piping run indicate a system-level mechanical root cause.'
),
(
  14,
  'scenario',
  'scenario',
  'A quality review finds that installers routinely leave tubing ends open during multi-day construction. Several systems later show moisture-related contamination. What is the BEST response?',
  '[{"key":"A","text":"Implement a tubing-protection standard, correct field behavior, and address contamination in affected systems"},{"key":"B","text":"Increase evacuation time only"},{"key":"C","text":"Add larger filter-driers to every system and keep the same installation practice"},{"key":"D","text":"Ignore the storage practice"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring contamination linked to open tubing requires correction of the upstream installation practice.'
),
(
  15,
  'scenario',
  'scenario',
  'A senior technician finds widespread condensation damage below suction lines in a humid facility. The insulation seams were installed inconsistently. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct affected insulation, standardize vapor-seal installation, and verify the method across similar piping"},{"key":"B","text":"Raise indoor temperature permanently"},{"key":"C","text":"Remove all insulation"},{"key":"D","text":"Reduce refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Widespread condensation damage indicates the insulation and vapor-seal process needs both local correction and broader quality control.'
),
(
  16,
  'scenario',
  'scenario',
  'A remodel forces a major line-set reroute near structural steel and electrical equipment. The proposed path introduces abrasion points and blocks service access. What is the BEST response?',
  '[{"key":"A","text":"Develop an approved alternate route that protects the piping and preserves required access"},{"key":"B","text":"Install the shortest route and address problems later"},{"key":"C","text":"Remove insulation where clearance is tight"},{"key":"D","text":"Increase refrigerant charge"}]'::jsonb,
  '["A"]'::jsonb,
  'Routing changes should be evaluated for physical protection, serviceability, and system integrity.'
),
(
  17,
  'scenario',
  'scenario',
  'A branch has repeated startup problems after new installations. Investigation finds several line sets with severe kinks concealed under insulation. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct affected piping and strengthen installation inspection so concealed restrictions are caught before startup"},{"key":"B","text":"Increase refrigerant charge on all new systems"},{"key":"C","text":"Raise blower speed"},{"key":"D","text":"Stop insulating line sets"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated concealed defects call for both repair and an improved quality-control checkpoint.'
),
(
  18,
  'scenario',
  'scenario',
  'A senior lead discovers crews frequently substitute available tubing sizes when the specified size is temporarily out of stock. What is the BEST response?',
  '[{"key":"A","text":"Stop unapproved substitutions and require the specified size or documented technical approval for an alternative"},{"key":"B","text":"Allow substitutions on short runs"},{"key":"C","text":"Adjust refrigerant charge to compensate"},{"key":"D","text":"Use whichever tubing is easiest to install"}]'::jsonb,
  '["A"]'::jsonb,
  'Material availability does not justify unapproved changes to refrigerant-piping design.'
),
(
  19,
  'scenario',
  'scenario',
  'A repaired system passes pressure testing, but the senior reviewer sees the suction line resting directly against a vibrating cabinet edge. What is the BEST response?',
  '[{"key":"A","text":"Correct the contact and support condition before accepting the repair"},{"key":"B","text":"Accept it because the system passed the pressure test"},{"key":"C","text":"Add insulation around the contact point only"},{"key":"D","text":"Increase test pressure"}]'::jsonb,
  '["A"]'::jsonb,
  'A current pressure-test pass does not make an obvious future abrasion or vibration failure acceptable.'
),
(
  20,
  'scenario',
  'scenario',
  'A company audit shows recurring line-set restrictions, abrasion leaks, contamination, insulation failures, and blocked service access across multiple crews. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Implement a controlled refrigerant-piping installation program with standardized methods, training, field audits, documentation, and corrective-action tracking"},{"key":"B","text":"Increase refrigerant charge standards"},{"key":"C","text":"Let each crew develop its own practices"},{"key":"D","text":"Focus only on repairing callbacks"}]'::jsonb,
  '["A"]'::jsonb,
  'A broad pattern of installation failures requires systematic control of piping practices rather than isolated repairs.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '457e6c44-b0a7-4fcd-95c6-2200accaefdc';
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
      and c.name = 'Refrigerant Piping & Line-Set Installation'
      and c.is_current = true
  ) then
    raise exception 'Current Refrigerant Piping & Line-Set Installation Master Competency not found';
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
      and mrcr.required_level = 2
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L2 Refrigerant Piping & Line-Set Installation requirement not found';
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
    raise exception 'Current HVAC Installer / Helper L2 Refrigerant Piping & Line-Set Installation requirement not found';
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
      and mrcr.required_level = 3
  ) then
    raise exception 'Current HVAC Service & Repair Technician L3 Refrigerant Piping & Line-Set Installation requirement not found';
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
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Senior / Lead HVAC Technician L4 Refrigerant Piping & Line-Set Installation requirement not found';
  end if;

v_level := 2;
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Refrigerant Piping & Line-Set Installation — Level 2 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_piping_line_set_installation_l2_questions
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
        'Refrigerant Piping & Line-Set Installation',
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
      'IntegrateU Refrigerant Piping & Line-Set Installation L2 production assessment v1.0.',
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
      (v_master_question_id, v_installer_role_id)
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
        'Refrigerant Piping & Line-Set Installation',
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
        'IntegrateU Refrigerant Piping & Line-Set Installation L2 production assessment v1.0.',
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
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'Refrigerant Piping & Line-Set Installation — Level 3 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_piping_line_set_installation_l3_questions
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
        'Refrigerant Piping & Line-Set Installation',
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
      'IntegrateU Refrigerant Piping & Line-Set Installation L3 production assessment v1.0.',
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
        'Refrigerant Piping & Line-Set Installation',
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
        'IntegrateU Refrigerant Piping & Line-Set Installation L3 production assessment v1.0.',
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

  v_level := 4;
  v_role_template_id := v_senior_role_id;
  v_assessment_name := 'Refrigerant Piping & Line-Set Installation — Level 4 Competency Assessment';

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
    select * from _seed_hvac_refrigerant_piping_line_set_installation_l4_questions
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
        'Refrigerant Piping & Line-Set Installation',
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
      'IntegrateU Refrigerant Piping & Line-Set Installation L4 production assessment v1.0.',
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
        'Refrigerant Piping & Line-Set Installation',
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
        'IntegrateU Refrigerant Piping & Line-Set Installation L4 production assessment v1.0.',
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
   '457e6c44-b0a7-4fcd-95c6-2200accaefdc'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '457e6c44-b0a7-4fcd-95c6-2200accaefdc'::uuid
  and a.target_level in (2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   L2 HVAC Design & Sales Engineer = 20
--   L2 HVAC Installer / Helper = 20
--   L3 HVAC Service & Repair Technician = 20
--   L4 Senior / Lead HVAC Technician = 20
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
      '457e6c44-b0a7-4fcd-95c6-2200accaefdc'::uuid
    and a.target_level in (2,3,4)
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
      '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid,
      '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid
    )
  )
  or
  (
    q.target_level = 3
    and mrt.id =
      '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid
  )
  or
  (
    q.target_level = 4
    and mrt.id =
      'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid
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
  '457e6c44-b0a7-4fcd-95c6-2200accaefdc'::uuid;

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
    '457e6c44-b0a7-4fcd-95c6-2200accaefdc'::uuid
  and a.target_level in (2,3,4)
group by a.target_level
having count(*) > 1;
