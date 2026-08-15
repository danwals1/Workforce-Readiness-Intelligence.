-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0144_hvac_estimating_proposals_technical_sales_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Estimating, Proposals & Technical Sales
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Service & Repair Technician -> Level 1
--   Senior / Lead HVAC Technician    -> Level 2
--   HVAC Design & Sales Engineer     -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Safety note: these questions assess safe-work judgment and hazard recognition.
-- They do not replace employer-specific procedures, qualified-person training,
-- site-specific hazard assessment, or applicable safety requirements.
-- ============================================================================

begin;

create temporary table _seed_hvac_estimating_proposals_technical_sales_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_estimating_proposals_technical_sales_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of an HVAC estimate?',
  '[{"key":"A","text":"To identify the expected scope, labor, materials, and cost associated with proposed work"},{"key":"B","text":"To guarantee that no project condition will change"},{"key":"C","text":"To replace technical diagnosis"},{"key":"D","text":"To eliminate the need for customer approval"}]'::jsonb,
  '["A"]'::jsonb,
  'An estimate provides a structured expectation of the work and associated resources or cost before the work is authorized.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What should an HVAC proposal clearly describe?',
  '[{"key":"A","text":"The work being offered, important inclusions, and relevant limitations or exclusions"},{"key":"B","text":"Only the equipment brand"},{"key":"C","text":"Only the final price"},{"key":"D","text":"Every possible future repair"}]'::jsonb,
  '["A"]'::jsonb,
  'A useful proposal communicates what is included in the offer and helps prevent misunderstanding about the intended scope.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is an accurate description of the customer concern important when developing a service estimate?',
  '[{"key":"A","text":"It helps connect the proposed work to the condition the customer wants addressed"},{"key":"B","text":"It determines the manufacturer warranty automatically"},{"key":"C","text":"It replaces equipment testing"},{"key":"D","text":"It guarantees the repair cost will never change"}]'::jsonb,
  '["A"]'::jsonb,
  'A clear customer concern helps establish why work is being proposed and supports an understandable scope.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is a scope of work?',
  '[{"key":"A","text":"A description of the work that is included in the proposed job or repair"},{"key":"B","text":"A list of every employee in the company"},{"key":"C","text":"A record of thermostat settings"},{"key":"D","text":"A substitute for equipment specifications"}]'::jsonb,
  '["A"]'::jsonb,
  'The scope of work defines the work the company is proposing to perform.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should a technician avoid quoting a price from memory when the company requires an approved estimating process?',
  '[{"key":"A","text":"Because unverified pricing can create inaccurate customer expectations and margin problems"},{"key":"B","text":"Because customers should never receive prices"},{"key":"C","text":"Because repair costs never change"},{"key":"D","text":"Because only equipment manufacturers can provide prices"}]'::jsonb,
  '["A"]'::jsonb,
  'Pricing should follow the company estimating process so the customer receives an accurate and authorized amount.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to identify exclusions in a proposal?',
  '[{"key":"A","text":"To make clear which work or conditions are not included in the quoted scope"},{"key":"B","text":"To make the proposal appear longer"},{"key":"C","text":"To avoid explaining the proposed work"},{"key":"D","text":"To guarantee that additional work will never be needed"}]'::jsonb,
  '["A"]'::jsonb,
  'Clearly stated exclusions help prevent the customer and contractor from having different assumptions about what the proposal covers.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What does technical sales mean in an HVAC service context?',
  '[{"key":"A","text":"Helping the customer understand technically appropriate solutions so they can make an informed decision"},{"key":"B","text":"Selling the highest-priced option on every call"},{"key":"C","text":"Avoiding discussion of system condition"},{"key":"D","text":"Replacing diagnosis with a sales presentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales connects verified system needs with appropriate solution options and clear customer communication.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should a technician distinguish required corrective work from optional improvement recommendations?',
  '[{"key":"A","text":"So the customer understands the priority and purpose of each recommendation"},{"key":"B","text":"So every recommendation sounds mandatory"},{"key":"C","text":"So optional improvements are never discussed"},{"key":"D","text":"So the technician can avoid documenting findings"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear prioritization helps customers distinguish what addresses a current problem from what may improve performance, reliability, or comfort.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician confirms a failed component and the company estimating system requires part, labor, and applicable service items. What is the BEST next step?',
  '[{"key":"A","text":"Build the estimate from the confirmed repair scope using the approved company pricing process"},{"key":"B","text":"Choose a price based on what seems reasonable"},{"key":"C","text":"Start the repair before discussing cost"},{"key":"D","text":"Quote only the component price"}]'::jsonb,
  '["A"]'::jsonb,
  'A service estimate should be built from the verified repair scope using the company process for labor, materials, and other required items.'
),
(
  10,
  'multiple_choice',
  'application',
  'During diagnosis, a technician finds two separate repairs that are both needed to restore proper system operation. What should the estimate do?',
  '[{"key":"A","text":"Clearly include both confirmed repair needs and explain how they relate to the system problem"},{"key":"B","text":"Include only the least expensive repair"},{"key":"C","text":"Hide the second repair until the first is completed"},{"key":"D","text":"Combine them into one vague line item with no explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'When multiple confirmed conditions must be corrected, the proposed scope should communicate them clearly rather than leaving the customer with an incomplete repair expectation.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician identifies a repair and also notices an aging component that is still operating. What is the BEST proposal approach?',
  '[{"key":"A","text":"Separate the required repair from the additional recommendation and explain the reason for each"},{"key":"B","text":"Present both as immediate failures"},{"key":"C","text":"Replace the operating component without approval"},{"key":"D","text":"Do not mention the additional condition"}]'::jsonb,
  '["A"]'::jsonb,
  'Required work and preventive or optional recommendations should be distinguished so the customer can make an informed decision.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer asks for a lower-cost repair option than the technician originally discussed. What is the BEST response?',
  '[{"key":"A","text":"Explain any technically appropriate alternatives and their limitations rather than recommending an option that will not address the verified problem"},{"key":"B","text":"Offer any cheaper option even if it will not work"},{"key":"C","text":"Tell the customer there are never alternatives"},{"key":"D","text":"Reduce the price without changing the scope"}]'::jsonb,
  '["A"]'::jsonb,
  'Alternative options should remain technically appropriate and their limitations should be explained clearly.'
),
(
  13,
  'multiple_choice',
  'application',
  'A repair estimate includes equipment that must be ordered. What should be communicated if availability has not yet been confirmed?',
  '[{"key":"A","text":"Identify that availability or timing still needs confirmation rather than promising an unsupported completion date"},{"key":"B","text":"Promise next-day completion"},{"key":"C","text":"Leave the equipment out of the estimate"},{"key":"D","text":"Tell the customer availability never affects the schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Proposal communication should distinguish confirmed information from items that remain dependent on availability or scheduling.'
),
(
  14,
  'multiple_choice',
  'application',
  'A customer asks why the repair estimate includes labor in addition to the replacement part. What is the BEST technician response?',
  '[{"key":"A","text":"Explain that the proposal covers the complete repair scope, which may include diagnosis, removal, installation, setup, testing, and related work"},{"key":"B","text":"Tell the customer labor should not be questioned"},{"key":"C","text":"Remove labor from the estimate"},{"key":"D","text":"Say the part price includes all labor regardless of company pricing"}]'::jsonb,
  '["A"]'::jsonb,
  'A repair proposal can include more than the component itself because successful corrective work includes the labor and tasks required to complete and verify the repair.'
),
(
  15,
  'multiple_choice',
  'application',
  'A service technician realizes the approved estimate does not include work now found to be necessary. What is the BEST next step?',
  '[{"key":"A","text":"Pause before expanding the scope and follow the company process to revise the estimate or obtain approval"},{"key":"B","text":"Complete the extra work and bill for it later"},{"key":"C","text":"Ignore the additional requirement"},{"key":"D","text":"Change the invoice after the job without explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'When verified conditions change the required scope, the estimate or authorization should be updated before additional work proceeds.'
),
(
  16,
  'multiple_choice',
  'application',
  'A customer is choosing between repairing an older system and discussing replacement options. What information can a service technician appropriately contribute?',
  '[{"key":"A","text":"Verified system condition, repair needs, known limitations, and relevant service history within the technician role"},{"key":"B","text":"Guaranteed future operating cost"},{"key":"C","text":"A replacement price that has not been developed"},{"key":"D","text":"A promise that either option will prevent all future failures"}]'::jsonb,
  '["A"]'::jsonb,
  'The service technician can support the decision with accurate technical information while replacement design and pricing follow the appropriate company process.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician diagnoses a failed blower motor. The customer asks for the cheapest possible fix, but the technician also finds that the existing motor type requires the correct approved replacement to maintain proper system operation. What is the BEST response?',
  '[{"key":"A","text":"Explain the confirmed failure, the requirements of an appropriate replacement, and provide or request an estimate for a technically suitable repair"},{"key":"B","text":"Install any lower-cost motor that physically fits"},{"key":"C","text":"Tell the customer price is the only selection factor"},{"key":"D","text":"Replace the motor before discussing the estimate"}]'::jsonb,
  '["A"]'::jsonb,
  'The proposed repair should remain technically appropriate while explaining why the recommended component and work are needed.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer approves a repair estimate. After disassembly, the technician discovers additional damage that could not reasonably have been confirmed earlier. What is the BEST response?',
  '[{"key":"A","text":"Document the new finding, explain how it changes the repair scope, and obtain the required approval before performing the additional work"},{"key":"B","text":"Complete all additional work without discussion"},{"key":"C","text":"Ignore the new damage and finish the original repair"},{"key":"D","text":"Increase the invoice after completion without explaining why"}]'::jsonb,
  '["A"]'::jsonb,
  'New verified conditions that materially change scope or cost should be communicated and authorized before the expanded work is completed.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician presents a repair estimate and the customer says another contractor quoted much less. What is the BEST response?',
  '[{"key":"A","text":"Explain the specific scope and technical basis of the company proposal and avoid criticizing a quote whose scope is not known"},{"key":"B","text":"Immediately match the other price"},{"key":"C","text":"Say the other contractor must be dishonest"},{"key":"D","text":"Remove important work from the proposal without explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'Price comparisons are meaningful only when the scope and technical solution are understood, so the technician should explain the current proposal rather than attack another provider.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer asks whether paying for the recommended repair guarantees the system will operate for several more years without another failure. What is the BEST response?',
  '[{"key":"A","text":"Explain what the proposed repair is intended to correct and avoid guaranteeing unrelated future system performance"},{"key":"B","text":"Guarantee several years of trouble-free operation"},{"key":"C","text":"Tell the customer the system will definitely fail again"},{"key":"D","text":"Remove the repair recommendation"}]'::jsonb,
  '["A"]'::jsonb,
  'A proposal should accurately describe the expected result of the proposed work without making unsupported guarantees about future equipment life or unrelated failures.'
);

create temporary table _seed_hvac_estimating_proposals_technical_sales_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_estimating_proposals_technical_sales_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of validating scope before a proposal is finalized?',
  '[{"key":"A","text":"To confirm the proposed work addresses the identified need and includes the required labor, materials, and coordination"},{"key":"B","text":"To guarantee there will never be a change order"},{"key":"C","text":"To remove all exclusions from the proposal"},{"key":"D","text":"To avoid discussing project assumptions"}]'::jsonb,
  '["A"]'::jsonb,
  'Scope validation helps ensure the proposal is technically complete and aligned with the actual work required.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are proposal assumptions important?',
  '[{"key":"A","text":"They identify conditions the estimate depends on when those conditions are not fully confirmed"},{"key":"B","text":"They replace the scope of work"},{"key":"C","text":"They guarantee project conditions"},{"key":"D","text":"They eliminate the need for customer communication"}]'::jsonb,
  '["A"]'::jsonb,
  'Assumptions make clear which estimate inputs depend on conditions that may still require confirmation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to separate base scope from optional upgrades in a proposal?',
  '[{"key":"A","text":"It helps the customer distinguish the core solution from additional improvements or enhancements"},{"key":"B","text":"It makes all options appear mandatory"},{"key":"C","text":"It prevents the customer from comparing alternatives"},{"key":"D","text":"It removes the need to explain value"}]'::jsonb,
  '["A"]'::jsonb,
  'Separating required scope from options improves clarity and supports informed customer decisions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should labor assumptions be reviewed when preparing an HVAC estimate?',
  '[{"key":"A","text":"Because access, complexity, staffing, and site conditions can materially affect required labor"},{"key":"B","text":"Because labor never changes from one project to another"},{"key":"C","text":"Because equipment price automatically includes all labor"},{"key":"D","text":"Because labor should not be included in proposals"}]'::jsonb,
  '["A"]'::jsonb,
  'Labor requirements vary with the actual work conditions and should be estimated from the expected execution needs.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the role of a Senior or Lead HVAC Technician in technical sales support?',
  '[{"key":"A","text":"To provide accurate field and technical input that helps shape appropriate scope, options, and expectations"},{"key":"B","text":"To recommend the most expensive option regardless of need"},{"key":"C","text":"To replace all estimating and approval processes"},{"key":"D","text":"To promise outcomes that have not been verified"}]'::jsonb,
  '["A"]'::jsonb,
  'A senior technician adds field experience and technical judgment to help ensure proposed solutions are realistic and appropriate.'
),
(
  6,
  'multiple_choice',
  'application',
  'A proposal assumes easy equipment access, but the senior technician knows the unit will require a difficult roof lift. What is the BEST action?',
  '[{"key":"A","text":"Update the estimating team so access, lifting, labor, and coordination requirements can be included"},{"key":"B","text":"Leave the proposal unchanged and solve it during installation"},{"key":"C","text":"Tell the crew to absorb the extra work"},{"key":"D","text":"Remove equipment installation from the scope"}]'::jsonb,
  '["A"]'::jsonb,
  'Known access and logistics requirements should be reflected before the proposal is finalized.'
),
(
  7,
  'multiple_choice',
  'application',
  'A replacement estimate includes the main equipment but omits known transition work needed to connect it to the existing duct system. What should the senior technician do?',
  '[{"key":"A","text":"Flag the missing transition work so the scope and estimate can be corrected"},{"key":"B","text":"Assume the field crew will fabricate it for free"},{"key":"C","text":"Ignore it because the equipment itself is included"},{"key":"D","text":"Wait until project closeout to mention it"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete proposal should account for known work required to install and connect the selected equipment.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer wants a premium indoor air quality accessory added to a system replacement. What is the BEST proposal approach?',
  '[{"key":"A","text":"Verify compatibility, define the added scope, and present it clearly as an option if it is not part of the base solution"},{"key":"B","text":"Include it without explaining the added cost"},{"key":"C","text":"Promise health outcomes from the accessory"},{"key":"D","text":"Add it even if it is technically incompatible"}]'::jsonb,
  '["A"]'::jsonb,
  'Optional enhancements should be technically appropriate, scoped clearly, and separated from the base work when applicable.'
),
(
  9,
  'multiple_choice',
  'application',
  'A proposal uses a labor allowance based on open access, but the site is fully finished with limited working space. What is the BEST response?',
  '[{"key":"A","text":"Reevaluate the labor assumption to reflect the actual site conditions"},{"key":"B","text":"Keep the original allowance because labor estimates should never change"},{"key":"C","text":"Remove labor entirely"},{"key":"D","text":"Increase equipment capacity instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Actual access conditions can significantly affect labor and should be reflected in the estimate.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer asks whether an equipment upgrade will definitely eliminate a long-standing comfort complaint. The senior technician knows duct distribution may also be involved. What is the BEST response?',
  '[{"key":"A","text":"Explain that the equipment change may help but the comfort issue also requires evaluation of the distribution conditions before guaranteeing an outcome"},{"key":"B","text":"Guarantee that the new equipment will solve the problem"},{"key":"C","text":"Ignore the duct concern"},{"key":"D","text":"Recommend the largest available system"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales should connect recommendations to verified conditions and avoid unsupported promises.'
),
(
  11,
  'multiple_choice',
  'application',
  'A senior technician reviewing a proposal sees that condensate disposal work required by the installation is not included. What should happen?',
  '[{"key":"A","text":"The missing work should be added or clearly addressed before the proposal is finalized"},{"key":"B","text":"The installer should be expected to handle it without scope or pricing"},{"key":"C","text":"The customer should discover it during installation"},{"key":"D","text":"The condensate requirement should be ignored"}]'::jsonb,
  '["A"]'::jsonb,
  'Known installation requirements should be accounted for in the proposed scope rather than deferred to the field.'
),
(
  12,
  'multiple_choice',
  'application',
  'A project estimate includes reuse of an existing line set. What should a senior technician confirm before supporting that assumption?',
  '[{"key":"A","text":"That the existing line set is suitable for the proposed equipment and intended application"},{"key":"B","text":"That it is the same color as the new equipment"},{"key":"C","text":"That the customer prefers reuse"},{"key":"D","text":"That replacement would cost more"}]'::jsonb,
  '["A"]'::jsonb,
  'Reuse assumptions should be technically validated so the proposal is based on a viable installation plan.'
),
(
  13,
  'multiple_choice',
  'application',
  'A proposal includes a system option that costs more but better addresses the documented application requirements. How should the senior technician support the discussion?',
  '[{"key":"A","text":"Explain the technical differences and practical tradeoffs so the customer understands why the option may better fit the application"},{"key":"B","text":"Say the higher price automatically makes it better"},{"key":"C","text":"Avoid discussing the technical differences"},{"key":"D","text":"Tell the customer the lower-cost option will definitely fail"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales should explain meaningful differences and tradeoffs rather than relying on price alone.'
),
(
  14,
  'multiple_choice',
  'application',
  'A senior technician identifies work that could become necessary only if concealed conditions are discovered after demolition. How should this be handled in the proposal?',
  '[{"key":"A","text":"Document the uncertainty as an assumption, allowance, exclusion, or potential change condition according to company practice"},{"key":"B","text":"Pretend the condition cannot occur"},{"key":"C","text":"Include unlimited work at no cost"},{"key":"D","text":"Do not mention the possibility"}]'::jsonb,
  '["A"]'::jsonb,
  'Known uncertainty should be communicated so the customer and project team understand how concealed conditions may affect scope.'
),
(
  15,
  'scenario',
  'scenario',
  'A proposal for a rooftop replacement includes equipment, crane cost, and basic installation labor. During review, the senior technician notices that curb adaptation and significant duct transitions will also be required. What is the BEST response?',
  '[{"key":"A","text":"Flag the missing adaptation and duct work so the proposal can be revised before customer approval"},{"key":"B","text":"Approve the proposal and let the installation crew absorb the work"},{"key":"C","text":"Remove the crane cost to offset the missing work"},{"key":"D","text":"Wait until installation day to discuss the changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Senior technical review should identify known scope gaps before the proposal becomes a project commitment.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer is comparing two replacement options. One has lower initial cost, while the other better matches the application and includes additional comfort-control capability. What is the BEST senior-technician approach?',
  '[{"key":"A","text":"Explain the technical differences, limitations, and expected benefits of each option without forcing the customer toward one choice"},{"key":"B","text":"Tell the customer the higher-priced option is always the correct choice"},{"key":"C","text":"Recommend the cheapest option regardless of application"},{"key":"D","text":"Avoid discussing differences because the customer should decide from price alone"}]'::jsonb,
  '["A"]'::jsonb,
  'A technical sales conversation should help the customer understand the tradeoffs between legitimate options.'
),
(
  17,
  'scenario',
  'scenario',
  'A replacement proposal assumes the existing electrical supply can be reused. During field review, the senior technician finds that the proposed equipment has materially different electrical requirements. What is the BEST response?',
  '[{"key":"A","text":"Stop the assumption from carrying forward and coordinate the required scope or equipment change before finalizing the proposal"},{"key":"B","text":"Ignore the mismatch and let the installer solve it"},{"key":"C","text":"Install a larger breaker without further review"},{"key":"D","text":"Remove electrical work from all project documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Known technical conflicts should be resolved during estimating and proposal development, not transferred to the field.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer asks the senior technician to guarantee a specific percentage reduction in utility cost from a proposed HVAC replacement. The project has no validated energy model supporting that number. What is the BEST response?',
  '[{"key":"A","text":"Explain the factors that can affect energy use and avoid guaranteeing a specific savings percentage without supporting analysis"},{"key":"B","text":"Promise the requested percentage to help close the sale"},{"key":"C","text":"Estimate a savings number from memory"},{"key":"D","text":"Tell the customer energy use is unrelated to HVAC equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales claims should remain supported by available analysis and should not create guarantees that cannot be substantiated.'
),
(
  19,
  'scenario',
  'scenario',
  'A project has already been quoted when the senior technician discovers that the selected equipment will not physically fit through the available access path. What is the BEST response?',
  '[{"key":"A","text":"Document the conflict and coordinate a revised equipment or logistics solution before the project proceeds"},{"key":"B","text":"Deliver the equipment anyway and let the field crew decide what to do"},{"key":"C","text":"Ignore the access issue because the equipment capacity is correct"},{"key":"D","text":"Remove installation labor from the proposal"}]'::jsonb,
  '["A"]'::jsonb,
  'A technically valid proposal must account for practical installation constraints, including equipment access.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer requests a scope reduction to meet budget, but the requested deletion would leave the proposed system unable to perform as intended. What is the BEST response?',
  '[{"key":"A","text":"Explain why the deleted work is technically necessary and develop a different viable option rather than knowingly proposing an incomplete solution"},{"key":"B","text":"Remove the work and say nothing about the effect"},{"key":"C","text":"Promise the system will still perform the same"},{"key":"D","text":"Accept the reduced scope even if it cannot meet the intended application"}]'::jsonb,
  '["A"]'::jsonb,
  'Budget alternatives should remain technically viable; required work should not be removed without explaining the consequences.'
);

create temporary table _seed_hvac_estimating_proposals_technical_sales_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_estimating_proposals_technical_sales_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which practice BEST reflects Level 4 performance in HVAC estimating and technical sales?',
  '[{"key":"A","text":"Developing technically complete solutions that integrate scope, application requirements, cost drivers, assumptions, risks, and customer priorities"},{"key":"B","text":"Selecting equipment primarily by lowest first cost"},{"key":"C","text":"Using standard proposal language without reviewing project conditions"},{"key":"D","text":"Leaving installation details for the field team to determine"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 performance requires integrating technical design, commercial scope, project constraints, and customer needs into a viable proposed solution.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is lifecycle value different from initial purchase price?',
  '[{"key":"A","text":"Lifecycle value can include acquisition cost, operating cost, maintenance, reliability, expected service life, and other long-term impacts"},{"key":"B","text":"Lifecycle value considers equipment color only"},{"key":"C","text":"Initial price always determines the best technical solution"},{"key":"D","text":"Lifecycle value excludes operating cost"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales may require comparing more than first cost when meaningful long-term operating and ownership differences exist.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of identifying proposal risk before contract execution?',
  '[{"key":"A","text":"To recognize technical, commercial, scheduling, access, coordination, and scope uncertainties before they become project problems"},{"key":"B","text":"To eliminate all project uncertainty"},{"key":"C","text":"To avoid documenting assumptions"},{"key":"D","text":"To guarantee that change orders will never occur"}]'::jsonb,
  '["A"]'::jsonb,
  'Risk review allows assumptions, exclusions, allowances, and mitigation steps to be addressed before the company makes a project commitment.'
),
(
  4,
  'multiple_choice',
  'application',
  'A replacement-system proposal is being developed from an existing building plan, but field conditions have not been verified. What is the BEST Level 4 approach?',
  '[{"key":"A","text":"Identify which design and pricing assumptions require field verification and make those dependencies explicit in the proposal process"},{"key":"B","text":"Treat every drawing condition as verified"},{"key":"C","text":"Ignore discrepancies until installation"},{"key":"D","text":"Guarantee the quoted scope regardless of actual site conditions"}]'::jsonb,
  '["A"]'::jsonb,
  'Proposal development should distinguish verified conditions from assumptions that can materially affect design, scope, or cost.'
),
(
  5,
  'multiple_choice',
  'application',
  'Two HVAC options both meet the calculated load, but one has better part-load performance and controls capability at a higher first cost. What is the BEST technical-sales approach?',
  '[{"key":"A","text":"Explain the relevant performance, controls, operating, and cost tradeoffs so the customer can compare the options against project priorities"},{"key":"B","text":"Recommend the more expensive option because higher price proves higher quality"},{"key":"C","text":"Recommend the cheaper option because first cost is the only meaningful factor"},{"key":"D","text":"Avoid discussing differences because both meet the design load"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced technical sales connects meaningful system differences to the customer requirements rather than relying on price alone.'
),
(
  6,
  'multiple_choice',
  'application',
  'A proposed system depends on modifications by another trade that are not included in the HVAC contractor scope. What should the proposal do?',
  '[{"key":"A","text":"Clearly identify the dependency, responsible party, and any associated assumption or exclusion"},{"key":"B","text":"Assume the other trade will complete the work without documentation"},{"key":"C","text":"Include the work as completed even though it is outside the scope"},{"key":"D","text":"Do not mention the dependency to the customer"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-trade dependencies should be documented so project responsibilities and scope boundaries are understood.'
),
(
  7,
  'multiple_choice',
  'application',
  'A design-and-sales engineer discovers that a requested equipment option will not meet the required operating condition at the project location. What is the BEST response?',
  '[{"key":"A","text":"Explain the application limitation and develop a technically appropriate alternative"},{"key":"B","text":"Quote the requested option anyway because the customer selected it"},{"key":"C","text":"Increase the stated capacity in the proposal"},{"key":"D","text":"Remove the operating condition from the project documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales should not advance an option known to be unsuitable for the intended application.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project budget is below the cost of the originally designed HVAC solution. What is the BEST Level 4 value-engineering approach?',
  '[{"key":"A","text":"Identify alternate solutions or scope changes that reduce cost while clearly communicating the technical and performance tradeoffs"},{"key":"B","text":"Delete required components without explaining the effect"},{"key":"C","text":"Reduce equipment capacity without revisiting design requirements"},{"key":"D","text":"Promise the original performance with any lower-cost configuration"}]'::jsonb,
  '["A"]'::jsonb,
  'Value engineering should preserve a technically viable solution while making the consequences of changes visible.'
),
(
  9,
  'multiple_choice',
  'application',
  'A proposal includes projected energy savings. What should support a specific savings claim?',
  '[{"key":"A","text":"Appropriate analysis, assumptions, baseline information, and clearly stated limitations"},{"key":"B","text":"A generic manufacturer marketing percentage"},{"key":"C","text":"The salesperson memory of a similar job"},{"key":"D","text":"The equipment efficiency rating by itself in every application"}]'::jsonb,
  '["A"]'::jsonb,
  'Specific savings claims should be supported by relevant analysis and transparent assumptions rather than unsupported generalizations.'
),
(
  10,
  'multiple_choice',
  'application',
  'A complex proposal has several alternates, allowances, and exclusions. What is the BEST way to improve customer decision-making?',
  '[{"key":"A","text":"Organize the proposal so the base scope, options, pricing impacts, assumptions, and exclusions are easy to distinguish"},{"key":"B","text":"Combine all items into one total with no explanation"},{"key":"C","text":"Remove exclusions from the customer copy"},{"key":"D","text":"Use technical terminology without explaining differences"}]'::jsonb,
  '["A"]'::jsonb,
  'Proposal clarity is especially important when several commercial and technical choices are being presented.'
),
(
  11,
  'scenario',
  'scenario',
  'A client requests a replacement system based on the capacity of the existing equipment. A new load calculation indicates the existing system is significantly oversized. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Explain the load-calculation result, evaluate the application requirements, and propose equipment based on validated design needs rather than copying the existing capacity"},{"key":"B","text":"Match the existing capacity because that is what the customer requested"},{"key":"C","text":"Increase capacity further to provide additional safety margin"},{"key":"D","text":"Ignore the load calculation in the proposal"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced estimating and technical sales should be grounded in validated system requirements rather than simply reproducing an existing design.'
),
(
  12,
  'scenario',
  'scenario',
  'A proposal for a commercial renovation depends on using existing ductwork. Field investigation shows several sections are inaccessible, so their condition cannot be verified before pricing. What is the BEST approach?',
  '[{"key":"A","text":"Document the reuse assumption and inaccessible conditions and define how required corrective work will be handled if deficiencies are discovered"},{"key":"B","text":"Guarantee all existing ductwork is reusable"},{"key":"C","text":"Exclude all duct-related responsibility without explanation"},{"key":"D","text":"Assume any discovered repairs will be performed at no additional cost"}]'::jsonb,
  '["A"]'::jsonb,
  'When existing concealed conditions cannot be fully verified, the proposal should establish a clear commercial treatment for that uncertainty.'
),
(
  13,
  'scenario',
  'scenario',
  'A customer asks for three replacement options: minimum first cost, balanced performance, and premium efficiency. What is the BEST proposal strategy?',
  '[{"key":"A","text":"Develop technically viable options with clear differences in scope, performance, controls, cost, and limitations tied to the customer priorities"},{"key":"B","text":"Make the cheapest option intentionally inadequate so the customer chooses the premium option"},{"key":"C","text":"Use the same system for all three options and change only the price"},{"key":"D","text":"Present the premium option as guaranteed to have the lowest lifetime cost without analysis"}]'::jsonb,
  '["A"]'::jsonb,
  'Option-based technical selling should present legitimate solutions and explain meaningful differences without manipulating the comparison.'
),
(
  14,
  'scenario',
  'scenario',
  'A project is quoted with a specific equipment model. Before contract execution, the manufacturer announces an extended lead time that would jeopardize the required completion date. What is the BEST response?',
  '[{"key":"A","text":"Communicate the schedule risk promptly and evaluate approved alternate equipment or schedule revisions before final commitment"},{"key":"B","text":"Keep the lead-time information from the customer"},{"key":"C","text":"Promise the original completion date anyway"},{"key":"D","text":"Substitute any available equipment without reviewing application requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Known procurement risks should be addressed before they become unsupported schedule commitments.'
),
(
  15,
  'scenario',
  'scenario',
  'A sales engineer proposes a high-efficiency system, but the existing duct system cannot support the required airflow without significant modification. The customer wants the efficiency upgrade but not the duct work. What is the BEST response?',
  '[{"key":"A","text":"Explain the system interaction and either include the required distribution improvements or develop another technically viable option"},{"key":"B","text":"Sell the equipment alone and guarantee rated performance"},{"key":"C","text":"Remove the airflow requirement from the proposal"},{"key":"D","text":"Increase equipment capacity to compensate for the duct limitation"}]'::jsonb,
  '["A"]'::jsonb,
  'A proposed equipment solution must be compatible with the supporting system if performance expectations are to be credible.'
),
(
  16,
  'scenario',
  'scenario',
  'A competitor proposal is substantially cheaper, but the customer provides only a one-page summary with limited scope detail. What is the BEST technical-sales response?',
  '[{"key":"A","text":"Compare known scope and solution differences, explain the basis of your proposal, and avoid making unsupported claims about the competitor"},{"key":"B","text":"Say the competitor must be using inferior equipment"},{"key":"C","text":"Match the price immediately without reviewing scope"},{"key":"D","text":"Remove technical requirements until the price matches"}]'::jsonb,
  '["A"]'::jsonb,
  'A professional comparison focuses on documented differences and the technical basis of the proposed solution.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer requests a guaranteed indoor temperature throughout a facility, but several rooms have large variable process loads and envelope conditions outside the HVAC contractor control. What is the BEST proposal approach?',
  '[{"key":"A","text":"Define realistic design conditions, identify variables and dependencies, and avoid guaranteeing performance beyond conditions the proposed system can reasonably control"},{"key":"B","text":"Guarantee the requested temperature everywhere under all conditions"},{"key":"C","text":"Ignore the process and envelope loads"},{"key":"D","text":"Increase every unit one size without analysis"}]'::jsonb,
  '["A"]'::jsonb,
  'Performance commitments should reflect defined design conditions and known external variables.'
),
(
  18,
  'scenario',
  'scenario',
  'During final proposal review, the design engineer discovers that an estimating spreadsheet omitted a major equipment accessory required for the specified sequence of operation. What is the BEST response?',
  '[{"key":"A","text":"Correct the technical scope and pricing before presenting or executing the proposal, even if the revision increases the quoted amount"},{"key":"B","text":"Leave the error in place to preserve the original price"},{"key":"C","text":"Expect the installation team to provide the accessory from job margin"},{"key":"D","text":"Delete the sequence requirement without discussing it"}]'::jsonb,
  '["A"]'::jsonb,
  'Known estimating errors should be corrected before they become contractual scope gaps or project losses.'
),
(
  19,
  'scenario',
  'scenario',
  'A client asks the design-and-sales engineer to reduce project cost by removing controls integration that is required for the proposed equipment to operate as designed with the building automation system. What is the BEST response?',
  '[{"key":"A","text":"Explain the functional consequence and offer another viable controls strategy or system option rather than knowingly removing required integration"},{"key":"B","text":"Remove the controls integration and promise full functionality"},{"key":"C","text":"Leave the requirement undocumented"},{"key":"D","text":"Tell the field team to create a workaround after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Commercial pressure should not produce a proposal that is knowingly incapable of meeting the intended operating requirements.'
),
(
  20,
  'scenario',
  'scenario',
  'A multi-phase HVAC project includes design, equipment procurement, installation, controls, commissioning, and work by several subcontractors. Before issuing the final proposal, what is the BEST Level 4 review?',
  '[{"key":"A","text":"Confirm technical solution, quantities, labor, trade responsibilities, interfaces, allowances, exclusions, schedule assumptions, commissioning scope, pricing, and major project risks are aligned"},{"key":"B","text":"Review only the equipment purchase price"},{"key":"C","text":"Assume subcontractor scopes will align after award"},{"key":"D","text":"Leave commissioning and controls responsibilities undefined"}]'::jsonb,
  '["A"]'::jsonb,
  'A complex proposal requires integrated technical and commercial review so the final commitment reflects the complete intended project.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'd9e61524-7d1d-415b-8793-96965779bad9';
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
      and c.name = 'Estimating, Proposals & Technical Sales'
      and c.is_current = true
  ) then
    raise exception 'Current Estimating, Proposals & Technical Sales Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current HVAC Service & Repair Technician L1 Estimating, Proposals & Technical Sales requirement not found';
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
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Senior / Lead HVAC Technician L2 Estimating, Proposals & Technical Sales requirement not found';
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
      and mrcr.required_level = 4
  ) then
    raise exception 'Current HVAC Design & Sales Engineer L4 Estimating, Proposals & Technical Sales requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 1
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 8
      and s.application_count = 8
      and s.scenario_count = 4
  ) then
    raise exception 'Expected current L1 assessment standard 20 / 8 / 8 / 4 not found';
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
      and s.target_level = 4
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 3
      and s.application_count = 7
      and s.scenario_count = 10
  ) then
    raise exception 'Expected current L4 assessment standard 20 / 3 / 7 / 10 not found';
  end if;

  -- ========================================================================
  -- Seed Level 1
  -- ========================================================================

  v_level := 1;
  v_role_template_id := v_service_role_id;
  v_assessment_name := 'Estimating, Proposals & Technical Sales — Level 1 Competency Assessment';

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
    select * from _seed_hvac_estimating_proposals_technical_sales_l1_questions
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
        'Estimating, Proposals & Technical Sales',
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
      'IntegrateU Estimating, Proposals & Technical Sales L1 production assessment v1.0.',
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
      v_service_role_id
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
        'Estimating, Proposals & Technical Sales',
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
        'IntegrateU Estimating, Proposals & Technical Sales L1 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := v_senior_role_id;
  v_assessment_name := 'Estimating, Proposals & Technical Sales — Level 2 Competency Assessment';

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
    select * from _seed_hvac_estimating_proposals_technical_sales_l2_questions
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
        'Estimating, Proposals & Technical Sales',
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
      'IntegrateU Estimating, Proposals & Technical Sales L2 production assessment v1.0.',
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
      v_senior_role_id
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
        'Estimating, Proposals & Technical Sales',
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
        'IntegrateU Estimating, Proposals & Technical Sales L2 production assessment v1.0.',
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
  v_role_template_id := v_design_sales_role_id;
  v_assessment_name := 'Estimating, Proposals & Technical Sales — Level 4 Competency Assessment';

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
    select * from _seed_hvac_estimating_proposals_technical_sales_l4_questions
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
        'Estimating, Proposals & Technical Sales',
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
      'IntegrateU Estimating, Proposals & Technical Sales L4 production assessment v1.0.',
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
        'Estimating, Proposals & Technical Sales',
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
        'IntegrateU Estimating, Proposals & Technical Sales L4 production assessment v1.0.',
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
   'd9e61524-7d1d-415b-8793-96965779bad9'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'd9e61524-7d1d-415b-8793-96965779bad9'::uuid
  and a.target_level in (1,2,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 HVAC Service & Repair Technician -> 20
--   Level 2 Senior / Lead HVAC Technician    -> 20
--   Level 4 HVAC Design & Sales Engineer     -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'd9e61524-7d1d-415b-8793-96965779bad9'::uuid
    and a.target_level in (1,2,4)
    and aq.master_competency_template_id =
      'd9e61524-7d1d-415b-8793-96965779bad9'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 1 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'd9e61524-7d1d-415b-8793-96965779bad9'::uuid;

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
    'd9e61524-7d1d-415b-8793-96965779bad9'::uuid
  and a.target_level in (1,2,4)
group by a.target_level
having count(*) > 1;
