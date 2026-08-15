-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0130_hvac_equipment_installation_placement_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Equipment Installation & Placement
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

create temporary table _seed_hvac_equipment_installation_placement_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_equipment_installation_placement_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is manufacturer-required service clearance important when locating HVAC equipment?',
  '[{"key":"A","text":"It provides necessary access for inspection, maintenance, and service"},{"key":"B","text":"It determines the equipment color"},{"key":"C","text":"It replaces the need for structural support"},{"key":"D","text":"It determines the thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Required service clearances help ensure the equipment can be safely accessed for inspection, maintenance, and repair.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the main purpose of a level equipment base?',
  '[{"key":"A","text":"To provide proper support and help the equipment operate and drain as intended"},{"key":"B","text":"To increase refrigerant pressure"},{"key":"C","text":"To eliminate all vibration"},{"key":"D","text":"To replace equipment anchoring"}]'::jsonb,
  '["A"]'::jsonb,
  'A level, properly supported base helps maintain equipment alignment, drainage, and reliable operation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should equipment weight be considered before placement?',
  '[{"key":"A","text":"The supporting structure must be able to safely carry the equipment load"},{"key":"B","text":"Weight determines thermostat wiring"},{"key":"C","text":"Weight sets airflow automatically"},{"key":"D","text":"Weight eliminates the need for clearances"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment weight must be compatible with the capacity and design of the supporting structure.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should an installer verify before setting a rooftop unit onto a curb?',
  '[{"key":"A","text":"That the curb, opening, orientation, and unit are compatible with the approved installation"},{"key":"B","text":"Only that the unit color matches the roof"},{"key":"C","text":"Only the thermostat model"},{"key":"D","text":"That all panels have been removed"}]'::jsonb,
  '["A"]'::jsonb,
  'Rooftop equipment should be checked for correct curb compatibility, orientation, opening alignment, and approved placement before final setting.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is equipment orientation important during installation?',
  '[{"key":"A","text":"It affects connections, airflow, service access, drainage, and alignment with the design"},{"key":"B","text":"It only affects the equipment label"},{"key":"C","text":"Orientation matters only after startup"},{"key":"D","text":"Orientation is optional if the unit fits"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct orientation supports proper connections, service access, airflow paths, drainage, and coordination with the approved layout.'
),
(
  6,
  'multiple_choice',
  'application',
  'An air handler is shown against a wall, but the access panel on that side requires 30 inches of service clearance. What is the BEST response?',
  '[{"key":"A","text":"Reposition or coordinate the equipment so the required access is maintained"},{"key":"B","text":"Install it against the wall because the drawing location is approximate"},{"key":"C","text":"Remove the access panel permanently"},{"key":"D","text":"Reduce the clearance without approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment placement should preserve required service access rather than create a condition that prevents normal maintenance.'
),
(
  7,
  'multiple_choice',
  'application',
  'A condensing unit is planned for a pad that slopes noticeably to one side. What should be done before final placement?',
  '[{"key":"A","text":"Correct or provide an approved level support condition for the equipment"},{"key":"B","text":"Set the unit and bend the refrigerant lines to compensate"},{"key":"C","text":"Ignore the slope if the unit does not rock"},{"key":"D","text":"Place loose blocks under one corner"}]'::jsonb,
  '["A"]'::jsonb,
  'The equipment should be installed on an appropriate stable, level support condition rather than improvised shimming.'
),
(
  8,
  'multiple_choice',
  'application',
  'A rooftop unit is delivered with the return opening on the opposite side from the curb opening. What is the BEST action?',
  '[{"key":"A","text":"Stop and verify unit orientation, curb configuration, and approved installation before setting the unit"},{"key":"B","text":"Rotate internal components after setting the unit"},{"key":"C","text":"Cut a second roof opening immediately"},{"key":"D","text":"Set the unit and modify the curb later"}]'::jsonb,
  '["A"]'::jsonb,
  'A mismatch between unit openings and curb configuration should be resolved before the equipment is set in place.'
),
(
  9,
  'multiple_choice',
  'application',
  'A design calls for a furnace in a closet, but the proposed location leaves no access to remove the blower assembly. What should happen?',
  '[{"key":"A","text":"The placement should be revised so required service access is available"},{"key":"B","text":"Install it because the furnace fits dimensionally"},{"key":"C","text":"Assume the blower will never need service"},{"key":"D","text":"Block the access opening after startup"}]'::jsonb,
  '["A"]'::jsonb,
  'Dimensional fit alone is not enough; service and component-removal access must also be considered.'
),
(
  10,
  'multiple_choice',
  'application',
  'A condensing unit is being placed where roof drainage regularly accumulates water. What is the BEST response?',
  '[{"key":"A","text":"Select or prepare an approved location/support condition that keeps the equipment properly supported and protected from the drainage issue"},{"key":"B","text":"Place the unit directly in the low spot"},{"key":"C","text":"Drill holes in the cabinet for drainage"},{"key":"D","text":"Ignore standing water if the disconnect is nearby"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment should be placed on a suitable support and location that accounts for environmental and drainage conditions.'
),
(
  11,
  'multiple_choice',
  'application',
  'A unit weighs substantially more than the equipment originally shown in a design. What should happen before placement?',
  '[{"key":"A","text":"Verify that the supporting structure, curb, pad, or mounting system is suitable for the revised load"},{"key":"B","text":"Set the unit because HVAC equipment is always interchangeable"},{"key":"C","text":"Remove internal components permanently to reduce weight"},{"key":"D","text":"Add more fasteners without reviewing the support"}]'::jsonb,
  '["A"]'::jsonb,
  'A significant weight change should be coordinated with the supporting structure or mounting system before installation.'
),
(
  12,
  'multiple_choice',
  'application',
  'An installer is placing a unit near a building opening used for outdoor-air intake. What should be reviewed?',
  '[{"key":"A","text":"The approved placement requirements for separation, airflow, exhaust, and intake interactions"},{"key":"B","text":"Only the equipment paint color"},{"key":"C","text":"Only the refrigerant line diameter"},{"key":"D","text":"Nothing, because outdoor units can be placed anywhere"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment location should account for interactions with building air intakes, exhausts, and other site conditions.'
),
(
  13,
  'multiple_choice',
  'application',
  'A floor-mounted air handler is located so close to a doorway that the door strikes the unit cabinet. What is the BEST response?',
  '[{"key":"A","text":"Coordinate the equipment location or door condition so normal access and operation are maintained"},{"key":"B","text":"Allow the door to hit the cabinet"},{"key":"C","text":"Remove the cabinet panel"},{"key":"D","text":"Disable the doorway"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment placement should be coordinated with surrounding building access so neither the equipment nor building function is impaired.'
),
(
  14,
  'multiple_choice',
  'application',
  'A vibration-isolation detail is specified for a piece of mechanical equipment. What should the installer do?',
  '[{"key":"A","text":"Install the equipment using the specified or approved isolation arrangement"},{"key":"B","text":"Bolt the equipment directly to the structure regardless of the detail"},{"key":"C","text":"Use wood scraps as isolators"},{"key":"D","text":"Ignore the detail if the equipment starts normally"}]'::jsonb,
  '["A"]'::jsonb,
  'Specified vibration-isolation provisions should be incorporated into the installation unless an approved alternative is provided.'
),
(
  15,
  'scenario',
  'scenario',
  'A packaged unit is delivered to a site and will physically fit on the pad, but the access panel would face a permanent fence only 8 inches away. What is the BEST response?',
  '[{"key":"A","text":"Do not finalize placement until service clearance is resolved through an approved layout change"},{"key":"B","text":"Install it because the footprint fits"},{"key":"C","text":"Remove the access panel before installation"},{"key":"D","text":"Assume service can be performed from another side"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical fit is not sufficient when the placement prevents required service access.'
),
(
  16,
  'scenario',
  'scenario',
  'A rooftop unit is being lifted into place when the crew notices that the curb is visibly out of square and the unit will not seat evenly. What is the BEST response?',
  '[{"key":"A","text":"Stop the set and correct or verify the curb condition before placing the unit"},{"key":"B","text":"Force the unit onto the curb with rigging tension"},{"key":"C","text":"Set the unit and fill the gaps with sealant"},{"key":"D","text":"Remove cabinet panels until it fits"}]'::jsonb,
  '["A"]'::jsonb,
  'An improperly aligned curb should be corrected before the unit is set to avoid support, sealing, and alignment problems.'
),
(
  17,
  'scenario',
  'scenario',
  'A design engineer selects a replacement unit that meets capacity requirements but is 10 inches taller than the available mechanical-room clearance. What is the BEST conclusion?',
  '[{"key":"A","text":"The equipment selection or placement must be revised because the unit cannot be installed in the available space"},{"key":"B","text":"The unit should be installed anyway because capacity is correct"},{"key":"C","text":"The ceiling should be cut without coordination"},{"key":"D","text":"The height difference can be ignored"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment selection must account for physical installation constraints as well as performance requirements.'
),
(
  18,
  'scenario',
  'scenario',
  'A condensing unit pad is correctly sized, but the planned refrigerant piping path would block the only service side of the unit. What is the BEST response?',
  '[{"key":"A","text":"Coordinate piping and equipment placement so required service access remains clear"},{"key":"B","text":"Route the piping across the service panel"},{"key":"C","text":"Remove the service panel permanently"},{"key":"D","text":"Ignore the conflict until a repair is needed"}]'::jsonb,
  '["A"]'::jsonb,
  'Connected piping should be routed so it does not defeat required access to serviceable components.'
),
(
  19,
  'scenario',
  'scenario',
  'A field condition forces a unit several feet away from its approved location. The new position affects duct connections, electrical routing, and maintenance access. What is the BEST response?',
  '[{"key":"A","text":"Coordinate and approve the revised placement before proceeding with dependent work"},{"key":"B","text":"Move the unit and let each trade adjust independently"},{"key":"C","text":"Ignore the impact on other systems"},{"key":"D","text":"Use flexible materials for every connection without review"}]'::jsonb,
  '["A"]'::jsonb,
  'A significant equipment relocation affects multiple trades and should be formally coordinated before installation continues.'
),
(
  20,
  'scenario',
  'scenario',
  'A heavy air handler has been placed on a platform, but the installer cannot verify whether the platform was designed for the equipment load. What is the BEST action?',
  '[{"key":"A","text":"Do not proceed with final installation until the support capacity is verified"},{"key":"B","text":"Proceed because the platform has not failed yet"},{"key":"C","text":"Add random blocking beneath the platform"},{"key":"D","text":"Remove equipment panels to reduce weight"}]'::jsonb,
  '["A"]'::jsonb,
  'Support capacity should be verified before a heavy equipment installation is finalized.'
);

create temporary table _seed_hvac_equipment_installation_placement_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_equipment_installation_placement_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Equipment Installation & Placement?',
  '[{"key":"A","text":"Installing equipment wherever it physically fits"},{"key":"B","text":"Independently evaluating support, orientation, access, connections, drainage, and field conditions before finalizing placement"},{"key":"C","text":"Relying only on the original equipment location"},{"key":"D","text":"Ignoring placement issues after startup"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent judgment about installation conditions, serviceability, support, and coordination before equipment placement is finalized.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should replacement equipment dimensions be checked against the existing installation before removal begins?',
  '[{"key":"A","text":"To verify fit, access, connection locations, and removal or installation paths"},{"key":"B","text":"To determine refrigerant type automatically"},{"key":"C","text":"To eliminate the need for startup checks"},{"key":"D","text":"To avoid reviewing manufacturer documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement-equipment dimensions can affect access, connections, service clearances, and the path used to remove and install equipment.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What should a technician consider when replacing equipment on an existing support or curb?',
  '[{"key":"A","text":"Whether the support is compatible with the new equipment load, dimensions, orientation, and connection requirements"},{"key":"B","text":"Only whether the old equipment was previously operating"},{"key":"C","text":"Only the new unit color"},{"key":"D","text":"Whether the thermostat is programmable"}]'::jsonb,
  '["A"]'::jsonb,
  'An existing support should be evaluated for suitability with the replacement equipment rather than assumed acceptable.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should condensate drainage be considered during equipment placement?',
  '[{"key":"A","text":"Placement and elevation can affect proper drain routing and reliable removal of condensate"},{"key":"B","text":"Drainage only matters after several years of operation"},{"key":"C","text":"Condensate always drains regardless of equipment position"},{"key":"D","text":"Drainage determines electrical voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment elevation and orientation can directly affect condensate drainage and drain connection routing.'
),
(
  5,
  'multiple_choice',
  'application',
  'A replacement air handler fits the existing platform, but the drain connection is now lower than the available drain route. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate the equipment elevation or approved drain arrangement before completing installation"},{"key":"B","text":"Install it and rely on standing water in the pan"},{"key":"C","text":"Cap the drain connection"},{"key":"D","text":"Ignore the elevation difference"}]'::jsonb,
  '["A"]'::jsonb,
  'The installed position must support a functional condensate drainage arrangement.'
),
(
  6,
  'multiple_choice',
  'application',
  'A technician discovers that a replacement blower section requires more front clearance than the original unit. What should happen?',
  '[{"key":"A","text":"Confirm that the new service clearance can be maintained before final placement"},{"key":"B","text":"Install it because the old unit fit"},{"key":"C","text":"Remove the access door permanently"},{"key":"D","text":"Reduce the clearance without review"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement equipment may have different service requirements that should be checked before installation is finalized.'
),
(
  7,
  'multiple_choice',
  'application',
  'A condensing unit has noticeable vibration after installation, and one corner is not fully supported on the pad. What is the BEST response?',
  '[{"key":"A","text":"Correct the support and level condition before treating the vibration as an internal equipment fault"},{"key":"B","text":"Replace the compressor immediately"},{"key":"C","text":"Increase refrigerant charge"},{"key":"D","text":"Ignore the unsupported corner"}]'::jsonb,
  '["A"]'::jsonb,
  'Improper support can create vibration and should be corrected before diagnosing internal equipment problems.'
),
(
  8,
  'multiple_choice',
  'application',
  'A replacement rooftop unit is heavier than the original and uses a different curb adapter. What should the technician verify?',
  '[{"key":"A","text":"That the support, adapter, curb, sealing, orientation, and load conditions are suitable for the replacement"},{"key":"B","text":"Only that the unit starts"},{"key":"C","text":"Only the thermostat wiring"},{"key":"D","text":"That the old curb remains unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'A different replacement configuration can affect support, sealing, structural load, and alignment and should be reviewed before final setting.'
),
(
  9,
  'multiple_choice',
  'application',
  'A service technician needs to replace an indoor unit, but the existing piping and electrical connections would cross the new access panel. What is the BEST response?',
  '[{"key":"A","text":"Coordinate connection routing so service access remains clear"},{"key":"B","text":"Route connections across the panel because they can be moved later"},{"key":"C","text":"Remove the panel"},{"key":"D","text":"Block access permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Connections should be arranged so they do not prevent required access to serviceable components.'
),
(
  10,
  'multiple_choice',
  'application',
  'A replacement furnace is shorter than the original, leaving a gap between the cabinet and existing duct transition. What is the BEST approach?',
  '[{"key":"A","text":"Provide an approved transition or support arrangement that maintains alignment and system integrity"},{"key":"B","text":"Stretch the existing duct until it reaches"},{"key":"C","text":"Leave the gap open"},{"key":"D","text":"Raise the furnace on loose scrap material"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement installations should use suitable transitions and supports rather than improvised arrangements.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician finds corrosion and deterioration on an existing outdoor equipment stand during replacement work. What should happen?',
  '[{"key":"A","text":"Evaluate and correct or replace the support before placing the new equipment"},{"key":"B","text":"Reuse it because it held the old unit"},{"key":"C","text":"Paint over the corrosion and proceed automatically"},{"key":"D","text":"Use the new equipment to hold the stand in place"}]'::jsonb,
  '["A"]'::jsonb,
  'An existing support should not be reused without evaluating deterioration that could affect its ability to safely support new equipment.'
),
(
  12,
  'scenario',
  'scenario',
  'A replacement air handler is installed in the original location, but the new cabinet is deeper and now blocks the electrical disconnect. What is the BEST response?',
  '[{"key":"A","text":"Correct the equipment or disconnect arrangement so required access is maintained before closing out the installation"},{"key":"B","text":"Leave the disconnect blocked because the unit operates"},{"key":"C","text":"Remove the disconnect cover"},{"key":"D","text":"Mark the disconnect location on the cabinet"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment replacement should not create unsafe or inaccessible service and electrical conditions.'
),
(
  13,
  'scenario',
  'scenario',
  'A technician replaces a rooftop unit and later finds water entering around the curb during rain. The unit is not seated evenly on one side. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate the unit seating, curb condition, gasket or sealing arrangement, and support alignment before making cosmetic repairs"},{"key":"B","text":"Apply sealant only to the roof surface"},{"key":"C","text":"Ignore the uneven seating"},{"key":"D","text":"Replace the thermostat"}]'::jsonb,
  '["A"]'::jsonb,
  'Water intrusion after replacement can result from seating, curb, gasket, or alignment problems and should be investigated at the installation interface.'
),
(
  14,
  'scenario',
  'scenario',
  'A replacement condensing unit is significantly taller and discharges air directly beneath a low overhang. What is the BEST response?',
  '[{"key":"A","text":"Evaluate whether the new placement provides acceptable airflow and clearances before operating the unit"},{"key":"B","text":"Operate it because the pad location is unchanged"},{"key":"C","text":"Remove the fan guard"},{"key":"D","text":"Reduce fan speed without analysis"}]'::jsonb,
  '["A"]'::jsonb,
  'Replacement dimensions can change airflow interactions and required clearances even when the equipment footprint is similar.'
),
(
  15,
  'scenario',
  'scenario',
  'A technician is replacing a furnace in a tight closet. The new unit fits, but the filter can no longer be removed without disconnecting piping. What is the BEST response?',
  '[{"key":"A","text":"Revise the placement or connection arrangement so routine filter service can be performed as intended"},{"key":"B","text":"Install it and tell the customer to skip filter changes"},{"key":"C","text":"Cut the filter into smaller pieces"},{"key":"D","text":"Remove the filter rack permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Placement should support routine maintenance and should not make normal service dependent on disconnecting unrelated systems.'
),
(
  16,
  'scenario',
  'scenario',
  'A replacement unit is mounted on an existing platform that flexes noticeably when the equipment starts. What is the BEST response?',
  '[{"key":"A","text":"Evaluate and correct the support condition rather than treating the movement as normal"},{"key":"B","text":"Increase blower speed"},{"key":"C","text":"Add refrigerant"},{"key":"D","text":"Ignore the movement if no noise complaint has been made"}]'::jsonb,
  '["A"]'::jsonb,
  'A support that flexes noticeably may be inadequate or poorly configured and should be evaluated before the installation is accepted.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician finds that an outdoor unit has been placed so close to another unit that both discharge into each other’s airflow path. What is the BEST response?',
  '[{"key":"A","text":"Evaluate and correct the placement so required airflow and separation conditions are maintained"},{"key":"B","text":"Leave both units because they fit on the pad"},{"key":"C","text":"Remove both fan guards"},{"key":"D","text":"Operate only one unit at a time permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment placement should avoid airflow interactions that can impair performance or reliability.'
),
(
  18,
  'scenario',
  'scenario',
  'A newly replaced air handler drains poorly. The technician finds the cabinet is pitched away from the drain connection because the support is uneven. What is the BEST response?',
  '[{"key":"A","text":"Correct the support and equipment position so drainage is consistent with the approved installation"},{"key":"B","text":"Drill another hole in the drain pan"},{"key":"C","text":"Increase blower speed"},{"key":"D","text":"Ignore the standing condensate"}]'::jsonb,
  '["A"]'::jsonb,
  'Improper equipment position can interfere with drainage and should be corrected at the support or installation level.'
),
(
  19,
  'scenario',
  'scenario',
  'A replacement unit requires a different line-set entry point. The easiest route would pass directly through a removable service panel. What is the BEST response?',
  '[{"key":"A","text":"Choose or coordinate a route that preserves service-panel access and equipment integrity"},{"key":"B","text":"Drill through the removable panel"},{"key":"C","text":"Permanently fasten the service panel closed"},{"key":"D","text":"Route the line set across the cabinet door"}]'::jsonb,
  '["A"]'::jsonb,
  'Field routing should not compromise removable service panels or normal equipment access.'
),
(
  20,
  'scenario',
  'scenario',
  'A service technician completes a replacement and startup is normal, but the equipment is visibly not level and one mounting fastener cannot engage because the base is misaligned. What is the BEST closeout decision?',
  '[{"key":"A","text":"Do not accept the installation until the support, alignment, and mounting condition are corrected"},{"key":"B","text":"Accept it because startup readings are normal"},{"key":"C","text":"Remove the unused fastener"},{"key":"D","text":"Document the condition but take no action"}]'::jsonb,
  '["A"]'::jsonb,
  'Normal startup does not make an improperly supported or incompletely secured installation acceptable.'
);

create temporary table _seed_hvac_equipment_installation_placement_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_equipment_installation_placement_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which behavior BEST demonstrates Level 4 performance in Equipment Installation & Placement?',
  '[{"key":"A","text":"Accepting equipment placement whenever it physically fits"},{"key":"B","text":"Leading placement reviews that account for support, access, safety, coordination, serviceability, and approved field conditions"},{"key":"C","text":"Allowing each trade to adjust around the equipment independently"},{"key":"D","text":"Deferring all placement decisions until startup"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes leadership and validation of equipment placement across structural, access, service, coordination, and installation-quality requirements.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a senior technician treat repeated equipment-placement conflicts as a process problem rather than isolated field issues?',
  '[{"key":"A","text":"Recurring conflicts can indicate weaknesses in design review, coordination, field verification, or installation planning"},{"key":"B","text":"Placement conflicts are always caused by installers"},{"key":"C","text":"Only structural problems matter"},{"key":"D","text":"Repeated conflicts do not affect project quality"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring placement problems often point to systemic coordination or planning weaknesses that should be corrected upstream.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to document approved equipment relocations during construction?',
  '[{"key":"A","text":"So final records and downstream trades reflect the installed condition and related coordination changes"},{"key":"B","text":"Only to update the equipment price"},{"key":"C","text":"To avoid all future inspections"},{"key":"D","text":"To replace manufacturer documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Approved relocations can affect multiple systems and should be captured so record documents and future service information reflect the actual installation.'
),
(
  4,
  'multiple_choice',
  'application',
  'A proposed rooftop equipment layout meets mechanical spacing but places two heavy units over an area with limited structural capacity. What is the BEST response?',
  '[{"key":"A","text":"Coordinate structural support requirements before approving final placement"},{"key":"B","text":"Set the units because mechanical spacing is correct"},{"key":"C","text":"Add more roof fasteners without review"},{"key":"D","text":"Move the units after startup if the roof deflects"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment placement must be compatible with the supporting structure, not just the mechanical layout.'
),
(
  5,
  'multiple_choice',
  'application',
  'A senior technician reviews a replacement installation and finds service access technically present but obstructed by permanent piping and conduit. What is the BEST response?',
  '[{"key":"A","text":"Require coordination so the access path is actually usable for service and component removal"},{"key":"B","text":"Accept it because the clearance dimension exists on paper"},{"key":"C","text":"Remove service panels permanently"},{"key":"D","text":"Document the obstruction and close the job"}]'::jsonb,
  '["A"]'::jsonb,
  'Service clearance must be practically usable, not merely dimensionally indicated.'
),
(
  6,
  'multiple_choice',
  'application',
  'A project team proposes shifting several rooftop units to simplify duct routing. What should the senior reviewer evaluate before approval?',
  '[{"key":"A","text":"Structural loads, access, clearances, electrical and piping routes, airflow interactions, roof drainage, and coordination impacts"},{"key":"B","text":"Only the revised duct length"},{"key":"C","text":"Only the equipment footprint"},{"key":"D","text":"Only whether the crane can reach the new location"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment relocation can affect multiple disciplines and site conditions, so approval should consider the full installation impact.'
),
(
  7,
  'multiple_choice',
  'application',
  'A lead technician finds that a branch routinely installs condensing units too close to walls, causing repeated service-access complaints. What is the BEST response?',
  '[{"key":"A","text":"Correct the placement standard, planning process, and field verification practice so the issue does not recur"},{"key":"B","text":"Handle each complaint separately"},{"key":"C","text":"Require smaller tools"},{"key":"D","text":"Tell technicians to remove panels from another side"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring placement defect should be corrected through planning, standards, and field quality-control rather than treated as isolated service inconvenience.'
),
(
  8,
  'multiple_choice',
  'application',
  'A large air handler is being installed in a mechanical room with limited rigging access. What is the BEST planning approach?',
  '[{"key":"A","text":"Verify the installation path, lifting method, final orientation, clearances, and sequence before movement begins"},{"key":"B","text":"Move the equipment first and determine orientation later"},{"key":"C","text":"Remove structural elements if needed"},{"key":"D","text":"Assume the delivery crew will resolve access issues"}]'::jsonb,
  '["A"]'::jsonb,
  'Large-equipment placement should be planned around the full movement and setting sequence, not just the final location.'
),
(
  9,
  'multiple_choice',
  'application',
  'A replacement unit uses a curb adapter that raises the equipment several inches. What should be reviewed?',
  '[{"key":"A","text":"The effect on connections, service access, wind exposure, roof clearances, structural loading, and overall installation"},{"key":"B","text":"Only the curb paint finish"},{"key":"C","text":"Only the thermostat wiring"},{"key":"D","text":"Nothing if the unit bolts to the adapter"}]'::jsonb,
  '["A"]'::jsonb,
  'Changing equipment elevation can affect multiple installation conditions and should be reviewed beyond simple mechanical fit.'
),
(
  10,
  'multiple_choice',
  'application',
  'A senior technician is asked to approve a field-built equipment support that differs from the approved detail. What is the BEST response?',
  '[{"key":"A","text":"Verify or obtain approval that the revised support meets the applicable load, stability, anchorage, and installation requirements"},{"key":"B","text":"Approve it because it looks strong"},{"key":"C","text":"Accept it if the equipment is level"},{"key":"D","text":"Ignore support details after equipment startup"}]'::jsonb,
  '["A"]'::jsonb,
  'A field-built support that differs from approved documentation should be validated rather than accepted by appearance alone.'
),
(
  11,
  'scenario',
  'scenario',
  'A major rooftop replacement project has repeated curb mismatches because equipment selections changed after curbs were ordered. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Correct the coordination and submittal-release process so curb and equipment compatibility is verified before fabrication and installation"},{"key":"B","text":"Modify every curb in the field"},{"key":"C","text":"Tell installers to make each unit fit"},{"key":"D","text":"Ignore the pattern because each job is different"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated compatibility problems indicate a coordination-process failure that should be corrected before more mismatches occur.'
),
(
  12,
  'scenario',
  'scenario',
  'A rooftop unit is already set when a senior technician discovers that the unit blocks access to a smoke-control damper that requires periodic inspection. What is the BEST response?',
  '[{"key":"A","text":"Escalate and correct the placement or access condition before accepting the installation"},{"key":"B","text":"Leave the unit because the rooftop unit itself is serviceable"},{"key":"C","text":"Document the blocked damper and take no action"},{"key":"D","text":"Remove the damper access requirement"}]'::jsonb,
  '["A"]'::jsonb,
  'Equipment placement should not prevent required access to adjacent systems or life-safety components.'
),
(
  13,
  'scenario',
  'scenario',
  'A new air handler location appears workable, but the shifted equipment creates a long unsupported duct transition and places the disconnect behind the unit. What is the BEST response?',
  '[{"key":"A","text":"Reject or revise the placement until duct support and electrical access are properly coordinated"},{"key":"B","text":"Approve the location because the air handler fits"},{"key":"C","text":"Add temporary duct straps and proceed"},{"key":"D","text":"Move the disconnect after project closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Placement must be evaluated in the context of all connected systems and required access.'
),
(
  14,
  'scenario',
  'scenario',
  'A replacement rooftop unit is much heavier than the original, but the project team wants to use the existing curb and roof framing to avoid delay. What is the BEST response?',
  '[{"key":"A","text":"Require verification of structural and curb suitability before setting the replacement unit"},{"key":"B","text":"Proceed because the footprint is similar"},{"key":"C","text":"Remove internal components to reduce weight"},{"key":"D","text":"Set the unit and monitor the roof later"}]'::jsonb,
  '["A"]'::jsonb,
  'A heavier replacement should not be placed until the support system is verified for the revised load.'
),
(
  15,
  'scenario',
  'scenario',
  'A field supervisor proposes installing several outdoor units closer together than the approved layout because the pad was poured too small. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Do not compress the layout without verifying required clearances, airflow, service access, and an approved corrective plan"},{"key":"B","text":"Move the units closer because the pad controls placement"},{"key":"C","text":"Remove service panels to create space"},{"key":"D","text":"Operate the units alternately"}]'::jsonb,
  '["A"]'::jsonb,
  'A pad-size mistake should not drive placement that violates equipment or system requirements.'
),
(
  16,
  'scenario',
  'scenario',
  'A senior technician audits several installations and finds that equipment is consistently level and anchored, but service panels are routinely blocked by piping. What is the BEST corrective action?',
  '[{"key":"A","text":"Revise installation planning and field quality checks to include service-access coordination for connected piping"},{"key":"B","text":"Accept the installations because anchorage is correct"},{"key":"C","text":"Train service technicians to remove piping first"},{"key":"D","text":"Require smaller access panels"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated serviceability defect indicates a planning and quality-control gap that should be built into the installation process.'
),
(
  17,
  'scenario',
  'scenario',
  'A crane set is scheduled, but the senior technician learns that the approved equipment orientation conflicts with the rigging plan and would require rotating the unit after it is placed in a tight area. What is the BEST response?',
  '[{"key":"A","text":"Resolve the lifting and final-orientation sequence before the set begins"},{"key":"B","text":"Proceed and rotate the unit later by hand"},{"key":"C","text":"Set the unit backward and reconnect around it"},{"key":"D","text":"Ignore orientation until startup"}]'::jsonb,
  '["A"]'::jsonb,
  'Heavy-equipment setting should be planned so the lift sequence produces the correct final orientation without unsafe or impractical repositioning.'
),
(
  18,
  'scenario',
  'scenario',
  'A field modification relocates a condensing unit to avoid a structural conflict, but the new location is adjacent to a generator exhaust discharge. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the new location for exhaust, air-intake, clearance, and operating impacts before approving the relocation"},{"key":"B","text":"Approve it because the structural conflict is solved"},{"key":"C","text":"Add a taller unit base automatically"},{"key":"D","text":"Ignore exhaust effects on outdoor equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Resolving one placement conflict should not create another environmental or operational problem.'
),
(
  19,
  'scenario',
  'scenario',
  'A senior technician finds a rooftop unit installed correctly on the curb, but the surrounding roof layout leaves no safe path for technicians to reach the service side. What is the BEST closeout decision?',
  '[{"key":"A","text":"Do not accept the placement until safe practical service access is addressed"},{"key":"B","text":"Accept it because the unit itself is correctly mounted"},{"key":"C","text":"Require technicians to climb over nearby equipment"},{"key":"D","text":"Document the issue for future service only"}]'::jsonb,
  '["A"]'::jsonb,
  'Serviceability includes safe access to the equipment, not merely correct mounting on its support.'
),
(
  20,
  'scenario',
  'scenario',
  'A project quality review shows recurring late-stage equipment relocations caused by unverified field dimensions. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Strengthen pre-install field verification, coordination, and release controls so location constraints are identified before equipment placement"},{"key":"B","text":"Increase contingency labor only"},{"key":"C","text":"Plan to relocate equipment after delivery"},{"key":"D","text":"Stop documenting dimensions"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring late relocations indicate an upstream verification and coordination problem that should be corrected before installation.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '2bef0561-a92c-43e0-89ce-f8970fa1a4dd';
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
      and c.name = 'Equipment Installation & Placement'
      and c.is_current = true
  ) then
    raise exception 'Current Equipment Installation & Placement Master Competency not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L2 Equipment Installation & Placement requirement not found';
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
    raise exception 'Current HVAC Installer / Helper L2 Equipment Installation & Placement requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 Equipment Installation & Placement requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 Equipment Installation & Placement requirement not found';
  end if;

v_level := 2;
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Equipment Installation & Placement — Level 2 Competency Assessment';

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
    select * from _seed_hvac_equipment_installation_placement_l2_questions
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
        'Equipment Installation & Placement',
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
      'IntegrateU Equipment Installation & Placement L2 production assessment v1.0.',
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
        'Equipment Installation & Placement',
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
        'IntegrateU Equipment Installation & Placement L2 production assessment v1.0.',
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
  v_assessment_name := 'Equipment Installation & Placement — Level 3 Competency Assessment';

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
    select * from _seed_hvac_equipment_installation_placement_l3_questions
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
        'Equipment Installation & Placement',
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
      'IntegrateU Equipment Installation & Placement L3 production assessment v1.0.',
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
        'Equipment Installation & Placement',
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
        'IntegrateU Equipment Installation & Placement L3 production assessment v1.0.',
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
  v_assessment_name := 'Equipment Installation & Placement — Level 4 Competency Assessment';

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
    select * from _seed_hvac_equipment_installation_placement_l4_questions
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
        'Equipment Installation & Placement',
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
      'IntegrateU Equipment Installation & Placement L4 production assessment v1.0.',
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
        'Equipment Installation & Placement',
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
        'IntegrateU Equipment Installation & Placement L4 production assessment v1.0.',
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
   '2bef0561-a92c-43e0-89ce-f8970fa1a4dd'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '2bef0561-a92c-43e0-89ce-f8970fa1a4dd'::uuid
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
      '2bef0561-a92c-43e0-89ce-f8970fa1a4dd'::uuid
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
  '2bef0561-a92c-43e0-89ce-f8970fa1a4dd'::uuid;

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
    '2bef0561-a92c-43e0-89ce-f8970fa1a4dd'::uuid
  and a.target_level in (2,3,4)
group by a.target_level
having count(*) > 1;
