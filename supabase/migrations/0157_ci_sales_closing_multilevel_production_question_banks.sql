-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0157_ci_sales_closing_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Sales / Closing
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Service Technician                 -> Level 1
--   Project Manager                    -> Level 2
--   Sales Specialist                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess advancing opportunities, presenting
-- value, responding to objections, negotiation judgment, buying signals,
-- commitment, and progressively higher levels of closing responsibility.
-- ============================================================================

begin;

create temporary table _seed_ci_sales_closing_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_sales_closing_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of presenting value during a sales conversation?',
  '[{"key":"A","text":"To connect the proposed solution to the customer needs, priorities, and desired outcomes"},{"key":"B","text":"To list as many product features as possible"},{"key":"C","text":"To avoid discussing the customer situation"},{"key":"D","text":"To guarantee the customer accepts the proposal"}]'::jsonb,
  '["A"]'::jsonb,
  'Value is created when the customer can clearly see how the proposed solution addresses what matters to them.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a buying signal?',
  '[{"key":"A","text":"A statement or behavior suggesting the customer is considering moving forward"},{"key":"B","text":"Any question about technical specifications"},{"key":"C","text":"A complaint about a completed project"},{"key":"D","text":"A request for a service appointment"}]'::jsonb,
  '["A"]'::jsonb,
  'Buying signals indicate increased interest or readiness to discuss commitment and next steps.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST response when a customer raises an objection?',
  '[{"key":"A","text":"Understand the concern, respond to it clearly, and confirm whether the concern has been addressed"},{"key":"B","text":"Ignore the concern and continue the presentation"},{"key":"C","text":"Immediately lower the price"},{"key":"D","text":"Tell the customer the concern is incorrect"}]'::jsonb,
  '["A"]'::jsonb,
  'Objections should be understood before they are answered so the response addresses the customer actual concern.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does it mean to close a sale?',
  '[{"key":"A","text":"Gain the customer commitment to move forward according to the defined next step"},{"key":"B","text":"Finish explaining the proposal"},{"key":"C","text":"Send an email after the meeting"},{"key":"D","text":"End the conversation as quickly as possible"}]'::jsonb,
  '["A"]'::jsonb,
  'Closing means securing a clear commitment rather than simply completing a presentation.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is asking questions important before presenting a solution?',
  '[{"key":"A","text":"It helps uncover the customer needs, priorities, concerns, and decision factors"},{"key":"B","text":"It delays the proposal conversation"},{"key":"C","text":"It eliminates the need to explain value"},{"key":"D","text":"It guarantees the customer budget"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective sales conversations begin with understanding the customer before recommending or positioning a solution.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is a customer objection?',
  '[{"key":"A","text":"A concern, hesitation, question, or barrier that may prevent the customer from moving forward"},{"key":"B","text":"A signed agreement"},{"key":"C","text":"A completed installation"},{"key":"D","text":"A routine project update"}]'::jsonb,
  '["A"]'::jsonb,
  'Objections are barriers or concerns that should be understood and addressed during the sales process.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why should a salesperson confirm the customer next step before ending a sales conversation?',
  '[{"key":"A","text":"To create a clear commitment and avoid uncertainty about what happens next"},{"key":"B","text":"To make the meeting longer"},{"key":"C","text":"To avoid answering questions"},{"key":"D","text":"To eliminate future follow-up"}]'::jsonb,
  '["A"]'::jsonb,
  'A clearly agreed next step keeps the opportunity moving and reduces ambiguity.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What is the purpose of asking for the business when the customer appears ready?',
  '[{"key":"A","text":"To convert interest into a clear decision or commitment"},{"key":"B","text":"To pressure the customer regardless of readiness"},{"key":"C","text":"To avoid discussing remaining concerns"},{"key":"D","text":"To replace the proposal process"}]'::jsonb,
  '["A"]'::jsonb,
  'When readiness is present, asking for commitment is a natural part of advancing the opportunity.'
),
(
  9,
  'multiple_choice',
  'application',
  'A customer says, "I like the solution, but I need to think about it." What is the BEST response?',
  '[{"key":"A","text":"Ask what specifically they would like to think through so the concern or decision factor can be understood"},{"key":"B","text":"Immediately offer a discount"},{"key":"C","text":"End the conversation without a next step"},{"key":"D","text":"Tell them there is nothing to think about"}]'::jsonb,
  '["A"]'::jsonb,
  'A vague hesitation should be explored respectfully so the real concern can be identified.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer says the proposal seems expensive. What is the BEST first response?',
  '[{"key":"A","text":"Clarify what they are comparing the price to and which part of the investment concerns them"},{"key":"B","text":"Reduce the price immediately"},{"key":"C","text":"Tell them quality is always expensive"},{"key":"D","text":"Remove major scope without discussion"}]'::jsonb,
  '["A"]'::jsonb,
  'Price objections should be clarified before deciding how to respond.'
),
(
  11,
  'multiple_choice',
  'application',
  'During a site visit, a client asks whether an additional feature could be included. What is the BEST sales-oriented response?',
  '[{"key":"A","text":"Explore why the feature matters and connect it to the customer broader goals before discussing the next step"},{"key":"B","text":"Say yes immediately without understanding the need"},{"key":"C","text":"Ignore the request because it was not in the original scope"},{"key":"D","text":"Tell the client only salespeople may discuss value"}]'::jsonb,
  '["A"]'::jsonb,
  'Understanding the reason behind a request helps position the value of the expanded solution.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer asks, "Why should I choose your company instead of another integrator?" What is the BEST response?',
  '[{"key":"A","text":"Explain the company relevant value and differentiation in terms of the customer priorities and expected outcome"},{"key":"B","text":"Criticize the competitor"},{"key":"C","text":"Say the company is simply better"},{"key":"D","text":"Avoid answering the question"}]'::jsonb,
  '["A"]'::jsonb,
  'Differentiation is strongest when it is tied directly to what the customer values.'
),
(
  13,
  'multiple_choice',
  'application',
  'A customer agrees that the proposed solution meets their needs and asks when installation could begin. What is the BEST interpretation?',
  '[{"key":"A","text":"This may be a buying signal and an appropriate time to confirm commitment and next steps"},{"key":"B","text":"The customer has rejected the proposal"},{"key":"C","text":"The conversation should return to basic discovery"},{"key":"D","text":"The proposal should automatically be discounted"}]'::jsonb,
  '["A"]'::jsonb,
  'Questions about implementation timing often indicate the customer is considering moving forward.'
),
(
  14,
  'multiple_choice',
  'application',
  'A customer says they need approval from another decision-maker before proceeding. What is the BEST next step?',
  '[{"key":"A","text":"Clarify the approval process and agree on how the necessary decision-maker will be engaged"},{"key":"B","text":"Treat the opportunity as lost"},{"key":"C","text":"Ask the customer to approve it anyway"},{"key":"D","text":"Skip the decision-maker and schedule installation"}]'::jsonb,
  '["A"]'::jsonb,
  'Understanding who must approve the purchase is necessary to advance the sale appropriately.'
),
(
  15,
  'multiple_choice',
  'application',
  'A customer asks whether a lower-cost option is available. What is the BEST response?',
  '[{"key":"A","text":"Clarify the customer priorities and discuss tradeoffs so any alternative still addresses the most important needs"},{"key":"B","text":"Remove features randomly until the price drops"},{"key":"C","text":"Refuse to discuss alternatives"},{"key":"D","text":"Offer the lowest possible price regardless of scope"}]'::jsonb,
  '["A"]'::jsonb,
  'Lower-cost alternatives should be discussed in terms of customer priorities and the value or scope tradeoffs involved.'
),
(
  16,
  'multiple_choice',
  'application',
  'A customer indicates they are satisfied with the proposal and have no remaining questions. What is the BEST action?',
  '[{"key":"A","text":"Ask for the appropriate commitment or confirm the specific next step to move forward"},{"key":"B","text":"Continue presenting features indefinitely"},{"key":"C","text":"End the meeting without discussing next steps"},{"key":"D","text":"Assume the sale is closed without confirmation"}]'::jsonb,
  '["A"]'::jsonb,
  'When concerns are resolved and value is understood, the salesperson should seek a clear commitment.'
),
(
  17,
  'scenario',
  'scenario',
  'A service technician completes a repair and the customer says, "We are thinking about upgrading the whole system, but I am not sure it is worth it." What is the BEST response?',
  '[{"key":"A","text":"Ask what they want to improve and what concerns them about upgrading, then connect the opportunity to an appropriate sales follow-up"},{"key":"B","text":"Tell them upgrades are always worth the money"},{"key":"C","text":"Quote a full system on the spot without discovery"},{"key":"D","text":"Ignore the comment because the visit was for service"}]'::jsonb,
  '["A"]'::jsonb,
  'The strongest response is to understand the customer motivation and concern before positioning value or advancing the opportunity.'
),
(
  18,
  'scenario',
  'scenario',
  'A systems designer presents two solution options. The client says the preferred option solves everything they discussed but costs more than expected. What is the BEST response?',
  '[{"key":"A","text":"Reconfirm the value of the preferred outcome, understand the budget concern, and discuss appropriate tradeoffs or next steps"},{"key":"B","text":"Immediately remove major features without discussion"},{"key":"C","text":"Tell the customer the price cannot be questioned"},{"key":"D","text":"Switch to the lowest-cost option without asking"}]'::jsonb,
  '["A"]'::jsonb,
  'A price concern should be balanced against the value of the desired outcome and any tradeoffs the customer is willing to make.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer says, "Your proposal looks good. If you can start next month, I think we are ready." What is the BEST response?',
  '[{"key":"A","text":"Confirm the timing requirement, verify any remaining conditions, and ask for the commitment needed to move forward"},{"key":"B","text":"Continue selling without acknowledging the buying signal"},{"key":"C","text":"Offer a discount before discussing commitment"},{"key":"D","text":"End the meeting and wait for the customer to call"}]'::jsonb,
  '["A"]'::jsonb,
  'The customer is signaling readiness, so the next step is to clarify conditions and seek commitment.'
),
(
  20,
  'scenario',
  'scenario',
  'A client says they like the solution but another company quoted less. What is the BEST response?',
  '[{"key":"A","text":"Understand the comparison, revisit the customer priorities and value differences, and address the concern before discussing commitment"},{"key":"B","text":"Immediately match the competitor price"},{"key":"C","text":"Criticize the competitor"},{"key":"D","text":"Tell the client price should not matter"}]'::jsonb,
  '["A"]'::jsonb,
  'Competitive objections should be explored and answered through relevant value rather than reacting automatically on price.'
);

create temporary table _seed_ci_sales_closing_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_sales_closing_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is it important to understand the customer decision criteria before asking for commitment?',
  '[{"key":"A","text":"It helps ensure the proposed value and closing approach address what the customer will actually use to decide"},{"key":"B","text":"It guarantees the customer will accept the first proposal"},{"key":"C","text":"It eliminates the need to discuss objections"},{"key":"D","text":"It allows the salesperson to avoid asking questions"}]'::jsonb,
  '["A"]'::jsonb,
  'Decision criteria help the salesperson align the conversation and closing approach with what matters most to the customer.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of confirming an objection has been resolved?',
  '[{"key":"A","text":"To verify the concern no longer blocks the customer from moving forward"},{"key":"B","text":"To prove the salesperson was correct"},{"key":"C","text":"To avoid discussing any new concerns"},{"key":"D","text":"To automatically close the sale"}]'::jsonb,
  '["A"]'::jsonb,
  'A response is not complete until the salesperson confirms whether the customer concern has actually been addressed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest reason to summarize agreed value before asking for the sale?',
  '[{"key":"A","text":"To reinforce the connection between the customer needs, the proposed solution, and the reason to move forward"},{"key":"B","text":"To repeat every product feature"},{"key":"C","text":"To avoid asking for commitment directly"},{"key":"D","text":"To increase the proposal length"}]'::jsonb,
  '["A"]'::jsonb,
  'A concise value summary helps the customer connect the solution to the outcomes they said matter.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is negotiation in a professional sales process?',
  '[{"key":"A","text":"Working through terms, scope, timing, price, or other conditions while protecting value and reaching an acceptable agreement"},{"key":"B","text":"Automatically reducing price whenever the customer hesitates"},{"key":"C","text":"Arguing until the customer accepts the proposal"},{"key":"D","text":"Avoiding all tradeoffs"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional negotiation balances customer concerns with business value and acceptable terms.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should concessions be exchanged rather than given away automatically?',
  '[{"key":"A","text":"To protect value and ensure changes in price, scope, timing, or terms are tied to a meaningful customer commitment or tradeoff"},{"key":"B","text":"To make the customer work harder"},{"key":"C","text":"To delay the sale"},{"key":"D","text":"To avoid discussing price"}]'::jsonb,
  '["A"]'::jsonb,
  'Concessions should support an agreement rather than simply reduce value without a corresponding benefit.'
),
(
  6,
  'multiple_choice',
  'application',
  'A customer says the proposal is strong but asks for a discount before they will sign. What is the BEST response?',
  '[{"key":"A","text":"Clarify the reason for the request and explore whether scope, timing, terms, or another tradeoff can address the concern before reducing price"},{"key":"B","text":"Give the discount immediately"},{"key":"C","text":"Refuse to discuss the request"},{"key":"D","text":"Remove random scope items without explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'A discount request should be understood and negotiated rather than accepted automatically.'
),
(
  7,
  'multiple_choice',
  'application',
  'A client says, "I need to talk with my spouse before deciding." What is the BEST next step?',
  '[{"key":"A","text":"Clarify what information or concerns need to be discussed and agree on how and when the decision conversation will continue"},{"key":"B","text":"Ask the client to decide without the spouse"},{"key":"C","text":"Treat the opportunity as lost"},{"key":"D","text":"Offer a discount immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'When another decision-maker is involved, the salesperson should understand the remaining decision process and establish a clear next step.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer says a competing proposal is less expensive but includes less scope. What is the BEST response?',
  '[{"key":"A","text":"Compare the proposals based on the customer priorities, scope differences, outcomes, and total value rather than price alone"},{"key":"B","text":"Match the competitor price without reviewing scope"},{"key":"C","text":"Criticize the competitor"},{"key":"D","text":"Ignore the comparison"}]'::jsonb,
  '["A"]'::jsonb,
  'Competitive comparisons should focus on meaningful differences in scope and value.'
),
(
  9,
  'multiple_choice',
  'application',
  'A customer likes the solution but says the project timing feels too aggressive. What is the BEST response?',
  '[{"key":"A","text":"Clarify the timing concern and determine whether adjusting schedule or phasing could preserve the desired outcome"},{"key":"B","text":"Reduce the price"},{"key":"C","text":"Tell the customer timing cannot be discussed"},{"key":"D","text":"Assume they are not interested"}]'::jsonb,
  '["A"]'::jsonb,
  'Not every objection is about value or price; timing concerns should be addressed directly.'
),
(
  10,
  'multiple_choice',
  'application',
  'The customer has agreed on scope and value but asks for payment terms outside company policy. What is the BEST response?',
  '[{"key":"A","text":"Discuss the requested terms, explain the available boundaries, and seek an acceptable agreement within authorized policy"},{"key":"B","text":"Agree to any terms to save the sale"},{"key":"C","text":"End the opportunity immediately"},{"key":"D","text":"Ignore the request and send the contract unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'Negotiation should remain within authorized business boundaries while still seeking a workable agreement.'
),
(
  11,
  'multiple_choice',
  'application',
  'A customer keeps asking detailed implementation questions after saying they like the proposal. What is the BEST interpretation?',
  '[{"key":"A","text":"They may be testing how the decision will work in practice, so the salesperson should answer the concerns and then check readiness to move forward"},{"key":"B","text":"They have definitely rejected the solution"},{"key":"C","text":"They are only interested in technical trivia"},{"key":"D","text":"The salesperson should stop answering questions"}]'::jsonb,
  '["A"]'::jsonb,
  'Implementation questions can indicate buying interest when the customer is picturing ownership or execution.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer says, "Everything looks good, but I am worried the system will be too complicated for my family." What is the BEST response?',
  '[{"key":"A","text":"Acknowledge the concern, explain how the solution addresses ease of use, and confirm whether that resolves the hesitation"},{"key":"B","text":"Tell them the concern is unreasonable"},{"key":"C","text":"Offer a discount"},{"key":"D","text":"Skip directly to contract signing"}]'::jsonb,
  '["A"]'::jsonb,
  'The response should connect the customer concern to the value and usability of the proposed solution.'
),
(
  13,
  'multiple_choice',
  'application',
  'A customer asks, "Is that your best price?" What is the BEST first response?',
  '[{"key":"A","text":"Explore what is driving the question and whether price is the actual remaining barrier before changing the offer"},{"key":"B","text":"Immediately lower the price"},{"key":"C","text":"Say yes and end the conversation"},{"key":"D","text":"Remove warranty coverage"}]'::jsonb,
  '["A"]'::jsonb,
  'A pricing question should be explored before a concession is made.'
),
(
  14,
  'multiple_choice',
  'application',
  'A project manager is present when the client says they would move forward if one scope concern is resolved. What is the BEST sales-support action?',
  '[{"key":"A","text":"Clarify the concern, help confirm a viable solution, and support a clear commitment or next step"},{"key":"B","text":"Ignore it because the project manager is not the salesperson"},{"key":"C","text":"Promise any scope change the customer requests"},{"key":"D","text":"End the discussion until another meeting"}]'::jsonb,
  '["A"]'::jsonb,
  'When the remaining barrier is clear, the team should help resolve it and advance the decision appropriately.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer says the solution is exactly what they want but the investment is 15 percent above their budget. What is the BEST response?',
  '[{"key":"A","text":"Reconfirm the desired outcome, understand the budget limit, and explore scope, phasing, terms, or other tradeoffs before deciding whether a concession is appropriate"},{"key":"B","text":"Immediately reduce the price by 15 percent"},{"key":"C","text":"Tell the customer their budget is unrealistic"},{"key":"D","text":"Remove major functionality without discussing consequences"}]'::jsonb,
  '["A"]'::jsonb,
  'A budget gap should be negotiated through value and tradeoffs rather than automatic discounting.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer appears ready to proceed but says, "Send me the proposal again and I will get back to you." What is the BEST response?',
  '[{"key":"A","text":"Ask whether any concern remains and agree on a specific decision or follow-up step instead of leaving the next action undefined"},{"key":"B","text":"Send the proposal and wait indefinitely"},{"key":"C","text":"Mark the sale closed won"},{"key":"D","text":"Offer a discount without asking questions"}]'::jsonb,
  '["A"]'::jsonb,
  'A vague next step should be converted into a clear commitment or scheduled decision point.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer says a competitor can complete the project sooner. Your team can meet the date only by changing the project sequence. What is the BEST response?',
  '[{"key":"A","text":"Clarify how important the date is, confirm whether the revised sequence is operationally viable, and negotiate timing based on what the customer values most"},{"key":"B","text":"Promise the date without checking feasibility"},{"key":"C","text":"Lower the price instead"},{"key":"D","text":"Tell the customer the competitor is wrong"}]'::jsonb,
  '["A"]'::jsonb,
  'The salesperson should negotiate around the real decision factor while protecting execution credibility.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer says, "If you can include the additional room at no charge, we have a deal." What is the BEST response?',
  '[{"key":"A","text":"Evaluate the requested concession, understand its value and cost, and negotiate an exchange or scope adjustment before agreeing"},{"key":"B","text":"Agree immediately because the customer said they would buy"},{"key":"C","text":"Refuse without discussion"},{"key":"D","text":"Add the room and hide the cost elsewhere"}]'::jsonb,
  '["A"]'::jsonb,
  'Closing pressure should not cause the salesperson to give away value without understanding the business impact.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer says the proposal solves the problem but wants to wait six months because of another financial priority. What is the BEST response?',
  '[{"key":"A","text":"Clarify whether timing is the true barrier, explore feasible phasing or timing options, and establish the most appropriate commitment or future decision point"},{"key":"B","text":"Pressure the customer to buy today"},{"key":"C","text":"Immediately cut price"},{"key":"D","text":"Assume the opportunity is permanently lost"}]'::jsonb,
  '["A"]'::jsonb,
  'A timing objection should be understood and addressed without confusing it with a value objection.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer has agreed on solution, price, timing, and terms but continues discussing minor details without making a decision. What is the BEST response?',
  '[{"key":"A","text":"Summarize what has been agreed, confirm no material concerns remain, and directly ask for the commitment to move forward"},{"key":"B","text":"Continue presenting indefinitely"},{"key":"C","text":"Introduce a discount even though none was requested"},{"key":"D","text":"End the meeting without asking for a decision"}]'::jsonb,
  '["A"]'::jsonb,
  'When the major decision factors are resolved, the salesperson should confidently seek a clear commitment.'
);

create temporary table _seed_ci_sales_closing_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_sales_closing_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the strongest purpose of a structured closing strategy on a complex opportunity?',
  '[{"key":"A","text":"To align value, decision criteria, stakeholders, objections, commercial terms, and commitment into a deliberate path to agreement"},{"key":"B","text":"To pressure the customer into deciding quickly"},{"key":"C","text":"To rely on discounting as the primary closing tool"},{"key":"D","text":"To avoid involving additional decision-makers"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex opportunities close more reliably when the decision path is deliberately managed across value, stakeholders, concerns, and commitment.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should a sales leader distinguish between an objection and a true deal blocker?',
  '[{"key":"A","text":"Because some concerns can be resolved through clarification or value, while a true blocker may require a material change in scope, terms, timing, or decision conditions"},{"key":"B","text":"Because objections should always be ignored"},{"key":"C","text":"Because every concern should trigger a discount"},{"key":"D","text":"Because blockers only occur after contracts are signed"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate diagnosis matters because different barriers require different responses.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest principle for protecting value during negotiation?',
  '[{"key":"A","text":"Trade rather than give, and connect concessions to reciprocal commitments, reduced scope, changed terms, or other meaningful value"},{"key":"B","text":"Never make any concession under any circumstances"},{"key":"C","text":"Lower price before the customer asks"},{"key":"D","text":"Use the same concession on every opportunity"}]'::jsonb,
  '["A"]'::jsonb,
  'Disciplined negotiation protects value by ensuring concessions support a balanced agreement.'
),
(
  4,
  'multiple_choice',
  'application',
  'A strategic customer requests a substantial discount but has not offered any change in scope, timing, volume, or terms. What is the BEST response?',
  '[{"key":"A","text":"Clarify the business reason for the request and negotiate a reciprocal trade before making a concession"},{"key":"B","text":"Approve the discount immediately to preserve the relationship"},{"key":"C","text":"Reject the request without discussion"},{"key":"D","text":"Remove margin without telling the customer"}]'::jsonb,
  '["A"]'::jsonb,
  'A major concession should be connected to a meaningful exchange rather than granted automatically.'
),
(
  5,
  'multiple_choice',
  'application',
  'A salesperson keeps losing late-stage deals after strong presentations. What should the sales manager examine first?',
  '[{"key":"A","text":"Whether decision criteria, stakeholders, objections, competition, commercial terms, and commitment were fully understood before the close"},{"key":"B","text":"Only whether the presentations were long enough"},{"key":"C","text":"Whether more features could be added"},{"key":"D","text":"Only the number of follow-up emails"}]'::jsonb,
  '["A"]'::jsonb,
  'Late-stage losses often expose gaps in decision management rather than presentation quality alone.'
),
(
  6,
  'multiple_choice',
  'application',
  'A salesperson routinely offers discounts before confirming whether price is the actual objection. What is the BEST coaching response?',
  '[{"key":"A","text":"Require the salesperson to diagnose the concern, restate value, and negotiate only after the real barrier is understood"},{"key":"B","text":"Allow the behavior because discounts can accelerate closing"},{"key":"C","text":"Remove all pricing flexibility"},{"key":"D","text":"Increase list prices so discounts appear larger"}]'::jsonb,
  '["A"]'::jsonb,
  'Premature discounting can destroy value without resolving the customer actual concern.'
),
(
  7,
  'multiple_choice',
  'application',
  'A customer requests a faster project schedule as a condition of signing. What should the salesperson do before agreeing?',
  '[{"key":"A","text":"Validate operational feasibility and understand the value of the requested timing before committing or negotiating around it"},{"key":"B","text":"Promise the schedule to close the deal"},{"key":"C","text":"Reduce price instead"},{"key":"D","text":"Ignore operations until after signature"}]'::jsonb,
  '["A"]'::jsonb,
  'Closing commitments should remain executable and should not create downstream delivery risk.'
),
(
  8,
  'multiple_choice',
  'application',
  'A deal has stalled because two decision-makers value different outcomes. What is the BEST sales approach?',
  '[{"key":"A","text":"Clarify each stakeholder priority and build an agreement path that addresses the decision criteria of both parties"},{"key":"B","text":"Focus only on the easier stakeholder"},{"key":"C","text":"Ask one stakeholder to overrule the other"},{"key":"D","text":"Lower price to avoid the disagreement"}]'::jsonb,
  '["A"]'::jsonb,
  'Multi-stakeholder deals require alignment across differing decision criteria.'
),
(
  9,
  'multiple_choice',
  'application',
  'A salesperson says an opportunity is likely to close because the customer likes the proposal, but no one has directly asked for commitment. What should the manager coach?',
  '[{"key":"A","text":"Resolve remaining concerns and directly confirm the customer decision or specific commitment required to move forward"},{"key":"B","text":"Assume positive feedback is equivalent to a signed agreement"},{"key":"C","text":"Continue presenting indefinitely"},{"key":"D","text":"Offer a discount before asking"}]'::jsonb,
  '["A"]'::jsonb,
  'Positive sentiment is not the same as commitment; closing requires a clear decision.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer asks for several concessions at once near the end of negotiation. What is the BEST response?',
  '[{"key":"A","text":"Evaluate the requests together, identify which matter most, protect business priorities, and negotiate the package as a whole"},{"key":"B","text":"Agree to each request separately"},{"key":"C","text":"Reject every request immediately"},{"key":"D","text":"Make concessions without documenting them"}]'::jsonb,
  '["A"]'::jsonb,
  'Bundled negotiation reduces the risk of giving away value one concession at a time.'
),
(
  11,
  'scenario',
  'scenario',
  'A high-value customer says they will sign today if you reduce the project price by 10 percent. Your current margin cannot absorb the full reduction. What is the BEST response?',
  '[{"key":"A","text":"Reconfirm the desired outcome, identify what is driving the price request, and negotiate scope, terms, timing, payment, or another reciprocal trade before changing price"},{"key":"B","text":"Accept the 10 percent reduction because the signature is immediate"},{"key":"C","text":"Refuse and end the opportunity"},{"key":"D","text":"Hide the margin impact elsewhere"}]'::jsonb,
  '["A"]'::jsonb,
  'A closing deadline should not override disciplined negotiation or margin protection.'
),
(
  12,
  'scenario',
  'scenario',
  'A client says they want to proceed, but the CFO has not reviewed the investment and has authority to stop the purchase. What is the BEST response?',
  '[{"key":"A","text":"Treat the CFO review as part of the real decision process, clarify the CFO criteria, and establish a path to gain that approval before considering the deal closed"},{"key":"B","text":"Ask the current contact to sign before the CFO sees it"},{"key":"C","text":"Ignore the CFO because the client verbally agreed"},{"key":"D","text":"Offer a discount to avoid the review"}]'::jsonb,
  '["A"]'::jsonb,
  'An opportunity is not truly closed until the required decision authority has been satisfied.'
),
(
  13,
  'scenario',
  'scenario',
  'A customer says your solution is preferred but wants a competitor feature included at no additional cost. What is the BEST response?',
  '[{"key":"A","text":"Understand why the feature matters, determine the cost and impact, and negotiate an appropriate scope or commercial trade if it is added"},{"key":"B","text":"Add the feature for free because the customer prefers your solution"},{"key":"C","text":"Tell the customer the competitor feature has no value"},{"key":"D","text":"Remove another feature without discussing it"}]'::jsonb,
  '["A"]'::jsonb,
  'Competitive pressure should be addressed through value and disciplined tradeoffs rather than automatic giveaways.'
),
(
  14,
  'scenario',
  'scenario',
  'A salesperson repeatedly closes deals by promising custom exceptions that operations later struggles to deliver. What is the BEST leadership response?',
  '[{"key":"A","text":"Establish clear commercial and operational guardrails, require approval for exceptions, and coach the salesperson to negotiate within deliverable boundaries"},{"key":"B","text":"Accept the behavior because revenue is being closed"},{"key":"C","text":"Tell operations to absorb every exception"},{"key":"D","text":"Remove the salesperson from all negotiations"}]'::jsonb,
  '["A"]'::jsonb,
  'A good close protects both revenue and the company ability to deliver what was promised.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer uses a competitor quote to push for a lower price, but the competitor proposal excludes several outcomes the customer previously said were critical. What is the BEST response?',
  '[{"key":"A","text":"Reframe the comparison around the required outcomes, clarify scope differences, and negotiate only after the customer understands the value gap"},{"key":"B","text":"Match the competitor price immediately"},{"key":"C","text":"Criticize the competitor company"},{"key":"D","text":"Ignore the quote"}]'::jsonb,
  '["A"]'::jsonb,
  'The salesperson should compare like-for-like value before reacting to price pressure.'
),
(
  16,
  'scenario',
  'scenario',
  'A major deal is ready to close, but the customer asks for payment terms that create unacceptable financial exposure. What is the BEST response?',
  '[{"key":"A","text":"Acknowledge the request, explain the acceptable boundaries, and negotiate alternative terms that protect both the relationship and the business"},{"key":"B","text":"Accept any terms to preserve the revenue"},{"key":"C","text":"End the relationship immediately"},{"key":"D","text":"Agree verbally and change the terms later"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional closing balances customer needs with financial and operational risk.'
),
(
  17,
  'scenario',
  'scenario',
  'A sales manager observes that one salesperson handles objections by talking longer instead of asking questions. The rep often leaves meetings without knowing why customers hesitate. What is the BEST coaching approach?',
  '[{"key":"A","text":"Coach the salesperson to pause, clarify the objection, identify the underlying concern, respond specifically, and confirm resolution before advancing"},{"key":"B","text":"Teach the salesperson to present even more features"},{"key":"C","text":"Tell the salesperson to avoid objections"},{"key":"D","text":"Require an immediate discount whenever hesitation appears"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective objection handling depends on diagnosis, not simply more explanation.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer wants a lower price, faster delivery, and additional scope while offering no change in commitment or terms. What is the BEST negotiation approach?',
  '[{"key":"A","text":"Prioritize the requests, quantify their impact, identify what the customer values most, and negotiate reciprocal tradeoffs rather than granting all three"},{"key":"B","text":"Accept everything to close the deal"},{"key":"C","text":"Reject all requests without discussion"},{"key":"D","text":"Agree verbally and resolve the details later"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex negotiation should protect value by treating concessions as an integrated package.'
),
(
  19,
  'scenario',
  'scenario',
  'A salesperson has a strong relationship with a prospect and believes the deal is won, but the prospect has never stated a final decision and still has an active competitor meeting scheduled. What is the BEST response?',
  '[{"key":"A","text":"Test the assumption directly, clarify remaining decision criteria and competitive risk, and seek an explicit commitment rather than relying on relationship strength"},{"key":"B","text":"Treat the opportunity as closed won"},{"key":"C","text":"Cancel further follow-up"},{"key":"D","text":"Offer a discount before the competitor meeting"}]'::jsonb,
  '["A"]'::jsonb,
  'Relationship strength does not replace direct confirmation of the customer decision.'
),
(
  20,
  'scenario',
  'scenario',
  'A sales organization has strong proposal volume but inconsistent objection handling, uncontrolled discounts, weak negotiation discipline, unclear decision authority, and poor close rates. What is the BEST leadership strategy?',
  '[{"key":"A","text":"Build a shared closing system with discovery-to-close standards, stakeholder and decision mapping, objection handling, value reinforcement, negotiation guardrails, concession rules, approval boundaries, coaching, and close-rate measurement"},{"key":"B","text":"Increase proposal volume"},{"key":"C","text":"Give salespeople broader discount authority without standards"},{"key":"D","text":"Focus only on CRM activity counts"}]'::jsonb,
  '["A"]'::jsonb,
  'Systemic closing problems require a consistent sales-closing operating discipline rather than isolated tactics.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'e3163a1f-aee8-4d55-b2a4-186a9c13b303';
  v_l1_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
  v_l2_role_id uuid := '9b66f083-ecfe-4fe7-a1e9-86010326fc7a';
  v_l4_role_id uuid := '89d6e66a-d996-4006-801a-ac2993b70341';
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
  where lower(i.slug) = 'custom-integration'
     or lower(i.name) = 'custom integration'
  order by case when lower(i.slug) = 'custom-integration' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Custom Integration industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Sales / Closing'
      and c.is_current = true
  ) then
    raise exception 'Current Sales / Closing Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Service Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Service Technician L1 Sales / Closing requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Project Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Project Manager L2 Sales / Closing requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Sales Specialist'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Sales Specialist L4 Sales / Closing requirement not found';
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
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'Sales / Closing — Level 1 Competency Assessment';

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
    select * from _seed_ci_sales_closing_l1_questions
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
        'Sales / Closing',
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
      'IntegrateU Sales / Closing L1 production assessment v1.0.',
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
      v_l1_role_id
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
        'Sales / Closing',
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
        'IntegrateU Sales / Closing L1 production assessment v1.0.',
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
  v_role_template_id := v_l2_role_id;
  v_assessment_name := 'Sales / Closing — Level 2 Competency Assessment';

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
    select * from _seed_ci_sales_closing_l2_questions
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
        'Sales / Closing',
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
      'IntegrateU Sales / Closing L2 production assessment v1.0.',
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
      v_l2_role_id
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
        'Sales / Closing',
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
        'IntegrateU Sales / Closing L2 production assessment v1.0.',
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
  v_role_template_id := v_l4_role_id;
  v_assessment_name := 'Sales / Closing — Level 4 Competency Assessment';

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
    select * from _seed_ci_sales_closing_l4_questions
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
        'Sales / Closing',
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
      'IntegrateU Sales / Closing L4 production assessment v1.0.',
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
        'Sales / Closing',
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
        'IntegrateU Sales / Closing L4 production assessment v1.0.',
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
   'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid
  and a.target_level in (1,2,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 4 Senior / Lead           -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid
    and a.target_level in (1,2,4)
    and aq.master_competency_template_id =
      'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid
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
    '34509f61-b041-4323-b927-cc8639bac9b4'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '9b66f083-ecfe-4fe7-a1e9-86010326fc7a'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    '89d6e66a-d996-4006-801a-ac2993b70341'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid;

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
    'e3163a1f-aee8-4d55-b2a4-186a9c13b303'::uuid
  and a.target_level in (1,2,4)
group by a.target_level
having count(*) > 1;
