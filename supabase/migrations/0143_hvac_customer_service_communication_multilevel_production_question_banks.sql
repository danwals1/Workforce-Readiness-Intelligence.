-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0143_hvac_customer_service_communication_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: HVAC Customer & Service Communication
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Roles:
--   HVAC Installer / Helper          -> Level 1
--   HVAC Service & Repair Technician -> Level 3
--   Senior / Lead HVAC Technician    -> Level 4
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

create temporary table _seed_hvac_customer_service_communication_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_customer_service_communication_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the BEST reason for an HVAC installer to communicate clearly with a customer?',
  '[{"key":"A","text":"To help the customer understand what work is happening and what to expect"},{"key":"B","text":"To avoid documenting the job"},{"key":"C","text":"To replace technical training"},{"key":"D","text":"To make the visit take longer"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear communication helps customers understand the work, expectations, and next steps while supporting a professional service experience.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does professional communication with a customer include?',
  '[{"key":"A","text":"Speaking respectfully, listening carefully, and giving accurate information"},{"key":"B","text":"Using as much technical jargon as possible"},{"key":"C","text":"Arguing when the customer asks questions"},{"key":"D","text":"Making promises that have not been approved"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional communication is respectful, clear, accurate, and focused on understanding and responding appropriately.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is active listening important during an HVAC service or installation visit?',
  '[{"key":"A","text":"It helps the technician understand the customer concern, instructions, and expectations"},{"key":"B","text":"It allows the technician to avoid asking questions"},{"key":"C","text":"It guarantees the customer will approve every recommendation"},{"key":"D","text":"It replaces job documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Active listening helps reduce misunderstandings and gives the technician better information about the customer concern or job expectations.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should an installer do if a customer asks a technical question the installer cannot answer confidently?',
  '[{"key":"A","text":"Say that the question needs to be confirmed with the appropriate technician, supervisor, or project lead"},{"key":"B","text":"Guess so the customer receives an immediate answer"},{"key":"C","text":"Change the subject"},{"key":"D","text":"Tell the customer the question is not important"}]'::jsonb,
  '["A"]'::jsonb,
  'It is better to acknowledge uncertainty and get an accurate answer than to give incorrect technical information.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should customer concerns be communicated to the appropriate team member?',
  '[{"key":"A","text":"So the concern can be addressed, documented, and followed through by the right person"},{"key":"B","text":"So the installer does not have to finish the assigned work"},{"key":"C","text":"So the customer has to repeat the concern several times"},{"key":"D","text":"So the concern can be ignored until project closeout"}]'::jsonb,
  '["A"]'::jsonb,
  'Escalating relevant customer concerns helps the team respond consistently and prevents important information from being lost.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the BEST way to explain a simple HVAC task to a customer?',
  '[{"key":"A","text":"Use clear everyday language and explain what is being done without unnecessary jargon"},{"key":"B","text":"Use technical abbreviations only"},{"key":"C","text":"Give as little information as possible"},{"key":"D","text":"Assume the customer already understands the work"}]'::jsonb,
  '["A"]'::jsonb,
  'Simple, plain-language explanations make it easier for customers to understand the work without oversimplifying or confusing the message.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is it important to avoid making commitments about price, schedule, or scope unless authorized?',
  '[{"key":"A","text":"Because unauthorized commitments can create incorrect expectations and project problems"},{"key":"B","text":"Because customers should never receive schedule information"},{"key":"C","text":"Because installers should not speak to customers"},{"key":"D","text":"Because pricing never changes"}]'::jsonb,
  '["A"]'::jsonb,
  'Installers should communicate within their authority and refer pricing, scope, and schedule commitments to the appropriate person when needed.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What should an installer do before leaving a customer site if the customer has raised a concern that is still unresolved?',
  '[{"key":"A","text":"Make sure the concern is communicated or documented for the appropriate follow-up"},{"key":"B","text":"Assume someone else already knows about it"},{"key":"C","text":"Tell the customer to call another contractor"},{"key":"D","text":"Delete the concern from the job notes"}]'::jsonb,
  '["A"]'::jsonb,
  'Unresolved concerns should be handed off clearly so the customer and internal team know that follow-up is still required.'
),
(
  9,
  'multiple_choice',
  'application',
  'A customer asks why the installation crew needs access to a particular room. What is the BEST response?',
  '[{"key":"A","text":"Briefly explain the work that must be completed in that area and any access needed"},{"key":"B","text":"Say that the customer does not need to know"},{"key":"C","text":"Ignore the question"},{"key":"D","text":"Give an unrelated technical explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'A clear explanation of the work and access requirement helps the customer understand what the crew needs and reduces confusion.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer says a technician promised the job would be finished today, but the installer has not been given that information. What is the BEST response?',
  '[{"key":"A","text":"Acknowledge the concern and confirm the schedule with the project lead or supervisor before making a promise"},{"key":"B","text":"Promise completion today anyway"},{"key":"C","text":"Tell the customer the other technician was wrong"},{"key":"D","text":"Avoid responding"}]'::jsonb,
  '["A"]'::jsonb,
  'The installer should avoid contradicting coworkers or making unsupported commitments and should confirm the actual schedule with the responsible person.'
),
(
  11,
  'multiple_choice',
  'application',
  'A customer is explaining a comfort problem, but the description is unclear. What should the installer do?',
  '[{"key":"A","text":"Ask simple clarifying questions and repeat back the concern to confirm understanding"},{"key":"B","text":"Guess what the customer means"},{"key":"C","text":"Tell the customer to use technical HVAC terms"},{"key":"D","text":"Ignore the concern because the installer is not diagnosing the system"}]'::jsonb,
  '["A"]'::jsonb,
  'Clarifying and confirming the concern helps ensure the correct information is passed to the technician or project lead.'
),
(
  12,
  'multiple_choice',
  'application',
  'A customer becomes frustrated because the work area is taking longer to finish than expected. What is the BEST installer response?',
  '[{"key":"A","text":"Stay respectful, acknowledge the concern, and involve the project lead or supervisor if schedule clarification is needed"},{"key":"B","text":"Argue that the customer is being unreasonable"},{"key":"C","text":"Promise an exact completion time without checking"},{"key":"D","text":"Leave the site without telling anyone"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional communication means remaining calm, acknowledging the concern, and bringing in the appropriate person when the installer does not control the schedule.'
),
(
  13,
  'multiple_choice',
  'application',
  'A customer asks whether an additional thermostat can be added while the crew is onsite. What is the BEST response from an installer who cannot approve scope changes?',
  '[{"key":"A","text":"Explain that the request needs to be reviewed by the project lead or appropriate team member before work is added"},{"key":"B","text":"Install it immediately without telling anyone"},{"key":"C","text":"Quote a price from memory"},{"key":"D","text":"Tell the customer the request is impossible without checking"}]'::jsonb,
  '["A"]'::jsonb,
  'Potential scope changes should be routed through the proper approval process rather than accepted or rejected without authority.'
),
(
  14,
  'multiple_choice',
  'application',
  'A homeowner asks what the crew completed today. What is the BEST response?',
  '[{"key":"A","text":"Give a brief accurate summary of the completed work and note any known next steps within the installer role"},{"key":"B","text":"Say nothing until the entire project is complete"},{"key":"C","text":"Describe work that has not been completed yet"},{"key":"D","text":"Use only internal trade abbreviations"}]'::jsonb,
  '["A"]'::jsonb,
  'A concise and accurate progress update helps keep the customer informed without making commitments outside the installer role.'
),
(
  15,
  'multiple_choice',
  'application',
  'A customer asks the installer to explain why the system is not cooling correctly, but diagnosis has not been completed. What is the BEST response?',
  '[{"key":"A","text":"Explain that the cause has not been confirmed yet and that the appropriate technician will need to complete the diagnosis"},{"key":"B","text":"Choose the most likely cause and present it as certain"},{"key":"C","text":"Tell the customer to replace the system"},{"key":"D","text":"State that nothing is wrong"}]'::jsonb,
  '["A"]'::jsonb,
  'Technicians and installers should distinguish confirmed facts from assumptions and avoid presenting an unverified diagnosis as fact.'
),
(
  16,
  'multiple_choice',
  'application',
  'A customer gives the installer an important access instruction for the next visit. What should the installer do?',
  '[{"key":"A","text":"Document or communicate the instruction through the company process so the next team receives it"},{"key":"B","text":"Rely on memory only"},{"key":"C","text":"Keep the information private from the rest of the team"},{"key":"D","text":"Ask the customer to explain it again on the next visit"}]'::jsonb,
  '["A"]'::jsonb,
  'Important site and customer information should be passed through the company communication process so it reaches the people who need it.'
),
(
  17,
  'scenario',
  'scenario',
  'An installer arrives at a home and the customer is upset because no one told them the crew would need to shut the HVAC system down for part of the day. What is the BEST response?',
  '[{"key":"A","text":"Acknowledge the concern, explain the shutdown need as clearly as possible, and involve the project lead if the timing or plan must be adjusted"},{"key":"B","text":"Tell the customer the shutdown will happen whether they like it or not"},{"key":"C","text":"Pretend the shutdown is not necessary"},{"key":"D","text":"Blame the office staff"}]'::jsonb,
  '["A"]'::jsonb,
  'The installer should remain professional, explain the work requirement, and involve the appropriate person when customer expectations and the work plan are not aligned.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer asks an installer whether a repair recommendation from another technician is really necessary. The installer does not have enough information to evaluate it. What is the BEST response?',
  '[{"key":"A","text":"Avoid contradicting or endorsing the recommendation without facts and refer the question to the technician or supervisor who can explain it"},{"key":"B","text":"Tell the customer the repair is unnecessary"},{"key":"C","text":"Tell the customer every recommendation is mandatory"},{"key":"D","text":"Guess based on similar jobs"}]'::jsonb,
  '["A"]'::jsonb,
  'When the installer lacks the information or authority to evaluate a recommendation, the professional response is to route the question to the person who can explain it accurately.'
),
(
  19,
  'scenario',
  'scenario',
  'During an installation, a customer points out a small area of wall damage near the work zone and says it was not there before the crew arrived. What is the BEST response?',
  '[{"key":"A","text":"Listen, avoid arguing about responsibility, document or report the concern, and notify the appropriate supervisor or project lead"},{"key":"B","text":"Tell the customer they are wrong"},{"key":"C","text":"Repair the wall without telling anyone"},{"key":"D","text":"Ignore the concern unless the customer complains again"}]'::jsonb,
  '["A"]'::jsonb,
  'Potential property concerns should be handled calmly and documented or escalated rather than argued about or hidden.'
),
(
  20,
  'scenario',
  'scenario',
  'An installer finishes assigned work, but the customer asks several detailed questions about system operation that the installer is not trained to answer. What is the BEST response?',
  '[{"key":"A","text":"Answer what can be explained accurately, clearly identify what needs confirmation, and connect the customer with the appropriate technician or project lead"},{"key":"B","text":"Make up answers so the customer feels confident"},{"key":"C","text":"Tell the customer not to ask technical questions"},{"key":"D","text":"Leave without acknowledging the questions"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional communication includes being helpful within the limits of the installer role and getting accurate answers for questions that require additional expertise.'
);

create temporary table _seed_hvac_customer_service_communication_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_customer_service_communication_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in HVAC Customer & Service Communication?',
  '[{"key":"A","text":"Communicating independently with customers, explaining findings clearly, documenting service information, and managing routine concerns professionally"},{"key":"B","text":"Avoiding customer questions whenever possible"},{"key":"C","text":"Making pricing and warranty commitments without authorization"},{"key":"D","text":"Using technical terminology without checking customer understanding"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 3 communication includes independently managing normal customer interactions, explaining service findings, documenting information, and maintaining professional expectations.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should an HVAC service technician separate confirmed findings from possible causes when speaking with a customer?',
  '[{"key":"A","text":"To avoid presenting an unverified diagnosis as fact"},{"key":"B","text":"To make the explanation sound more technical"},{"key":"C","text":"To prevent the customer from asking questions"},{"key":"D","text":"To avoid documenting test results"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear communication distinguishes measured or confirmed findings from possibilities that still require diagnosis or verification.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST purpose of documenting customer concerns and service findings?',
  '[{"key":"A","text":"To create a clear record that supports follow-up, continuity, and accurate communication"},{"key":"B","text":"To replace direct communication with the customer"},{"key":"C","text":"To make the invoice longer"},{"key":"D","text":"To avoid explaining completed work"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate documentation helps the next technician, office staff, supervisors, and customer understand what was reported, found, and completed.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the BEST approach when explaining a technical HVAC issue to a customer?',
  '[{"key":"A","text":"Translate the technical finding into clear language while keeping the explanation accurate"},{"key":"B","text":"Use only manufacturer terminology"},{"key":"C","text":"Avoid explaining the issue until the customer signs an estimate"},{"key":"D","text":"Simplify the explanation even if that makes it inaccurate"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective service communication makes technical information understandable without changing or overstating the facts.'
),
(
  5,
  'multiple_choice',
  'application',
  'A technician confirms that a failed capacitor is preventing the outdoor unit from operating. What is the BEST way to explain the finding?',
  '[{"key":"A","text":"Explain what failed, how it affects operation, and what corrective action is recommended in clear language"},{"key":"B","text":"Tell the customer only that the system is broken"},{"key":"C","text":"Use technical measurements without explaining what they mean"},{"key":"D","text":"Promise that no other issue can exist"}]'::jsonb,
  '["A"]'::jsonb,
  'A useful service explanation connects the confirmed finding to the system symptom and the recommended corrective action without making unsupported guarantees.'
),
(
  6,
  'multiple_choice',
  'application',
  'A customer says the system has been making a noise for several weeks, but the technician cannot reproduce it during the visit. What is the BEST response?',
  '[{"key":"A","text":"Document the customer description, ask clarifying questions about when it occurs, and explain what was and was not observed during the visit"},{"key":"B","text":"Tell the customer the noise does not exist"},{"key":"C","text":"Replace a likely component without evidence"},{"key":"D","text":"Leave the concern out of the service notes"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent concerns should be documented accurately, including the customer description and the technician observation, without dismissing or overstating the issue.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician identifies a repair that is outside the original service-call scope. What is the BEST communication step before performing additional work?',
  '[{"key":"A","text":"Explain the finding and follow the company process for customer authorization before expanding the work"},{"key":"B","text":"Complete the additional work automatically"},{"key":"C","text":"Ignore the finding"},{"key":"D","text":"Tell the customer the repair is mandatory without discussing approval"}]'::jsonb,
  '["A"]'::jsonb,
  'Additional work should be communicated clearly and handled through the approved authorization process before scope is expanded.'
),
(
  8,
  'multiple_choice',
  'application',
  'A customer asks whether repairing the system guarantees that it will never fail again. What is the BEST response?',
  '[{"key":"A","text":"Explain what the repair is expected to correct without guaranteeing unrelated future performance"},{"key":"B","text":"Guarantee that the system will have no future problems"},{"key":"C","text":"Avoid answering the question"},{"key":"D","text":"Tell the customer all future failures will be covered"}]'::jsonb,
  '["A"]'::jsonb,
  'Technicians should accurately explain the expected result of the repair without making unsupported promises about future system performance.'
),
(
  9,
  'multiple_choice',
  'application',
  'A customer becomes upset after hearing the cost of a recommended repair. What is the BEST technician response?',
  '[{"key":"A","text":"Remain calm, explain the technical basis for the recommendation, and use the company process for pricing or escalation questions"},{"key":"B","text":"Argue that the customer should have maintained the system better"},{"key":"C","text":"Reduce the price without authorization"},{"key":"D","text":"Stop explaining the repair"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should stay professional, explain the technical finding, and route pricing decisions through the appropriate company process.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician discovers that a previously quoted repair will not fully address the actual problem. What is the BEST communication approach?',
  '[{"key":"A","text":"Explain the new verified information and involve the appropriate person before changing the approved scope or price"},{"key":"B","text":"Perform the additional work without telling the customer"},{"key":"C","text":"Hide the new finding to avoid confusion"},{"key":"D","text":"Tell the customer the original technician made a mistake before reviewing the facts"}]'::jsonb,
  '["A"]'::jsonb,
  'When new diagnostic information changes the repair path, the customer should receive an accurate update and any scope or pricing change should follow the proper approval process.'
),
(
  11,
  'multiple_choice',
  'application',
  'A customer asks whether replacement is better than repair, but the technician is only authorized to discuss the current service findings. What is the BEST response?',
  '[{"key":"A","text":"Explain the current system condition and connect the customer with the appropriate person for replacement options if needed"},{"key":"B","text":"Recommend the most expensive replacement"},{"key":"C","text":"Tell the customer repair is always better"},{"key":"D","text":"Give a replacement price from memory"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should communicate the verified service information and stay within the company process for replacement recommendations and pricing.'
),
(
  12,
  'scenario',
  'scenario',
  'A homeowner says another company told them the compressor is bad. Your testing does not confirm compressor failure and identifies a separate electrical component failure instead. What is the BEST Level 3 response?',
  '[{"key":"A","text":"Explain the tests you performed, the condition you confirmed, and why your current finding differs without criticizing the other company"},{"key":"B","text":"Tell the customer the other company was dishonest"},{"key":"C","text":"Agree that the compressor is bad to avoid disagreement"},{"key":"D","text":"Replace both components"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional communication focuses on current evidence and avoids attacking another provider when explaining a different diagnosis.'
),
(
  13,
  'scenario',
  'scenario',
  'A customer insists that the system was working before yesterday’s maintenance visit and says your company caused today’s failure. What is the BEST response?',
  '[{"key":"A","text":"Listen to the concern, avoid arguing about responsibility, document the timeline, perform the appropriate diagnosis, and escalate if needed"},{"key":"B","text":"Immediately deny that the company could be responsible"},{"key":"C","text":"Promise a free repair before diagnosis"},{"key":"D","text":"Tell the customer the timing is only a coincidence"}]'::jsonb,
  '["A"]'::jsonb,
  'A service technician should acknowledge the concern, gather facts, document the situation, and avoid assigning responsibility before the cause is understood.'
),
(
  14,
  'scenario',
  'scenario',
  'A technician determines that the system is operating today, but the customer reports repeated intermittent shutdowns. What is the BEST communication approach?',
  '[{"key":"A","text":"Explain that the system is operating during the visit, document the reported intermittent condition, and describe the next diagnostic or monitoring step"},{"key":"B","text":"Tell the customer there is no problem because the system is currently running"},{"key":"C","text":"Replace the system immediately"},{"key":"D","text":"Delete the intermittent complaint from the work order"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should clearly distinguish present operating conditions from the customer-reported intermittent problem and document both.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer becomes angry and raises their voice because the repair cannot be completed today. What is the BEST response?',
  '[{"key":"A","text":"Remain calm, acknowledge the frustration, explain the confirmed reason for the delay, and involve a supervisor if additional resolution is needed"},{"key":"B","text":"Raise your voice so the customer listens"},{"key":"C","text":"Promise the repair will be completed today regardless of parts availability"},{"key":"D","text":"Leave without communicating the delay"}]'::jsonb,
  '["A"]'::jsonb,
  'Professional service communication remains calm and factual while acknowledging the customer concern and escalating when needed.'
),
(
  16,
  'scenario',
  'scenario',
  'A customer authorizes one repair. During the work, the technician finds a second failed component that requires additional cost. What is the BEST response?',
  '[{"key":"A","text":"Stop before expanding the authorized scope, explain the new finding, and obtain the required approval through the company process"},{"key":"B","text":"Complete both repairs and explain the extra charge afterward"},{"key":"C","text":"Ignore the second failure"},{"key":"D","text":"Replace the second component without documenting it"}]'::jsonb,
  '["A"]'::jsonb,
  'New findings that change cost or scope should be communicated and authorized before additional work is performed.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician completes a repair and the system is operating normally, but notices another condition that may need attention in the future. What is the BEST customer communication?',
  '[{"key":"A","text":"Clearly separate the completed repair from the additional observation, explain its current significance, and document any recommended follow-up"},{"key":"B","text":"Present the additional observation as an immediate failure"},{"key":"C","text":"Do not mention anything that is not part of today’s repair"},{"key":"D","text":"Tell the customer the entire system should be replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician should distinguish completed work, current confirmed conditions, and future recommendations so the customer understands the priority of each item.'
),
(
  18,
  'scenario',
  'scenario',
  'A customer says they do not understand the technician’s explanation and asks for it again. What is the BEST response?',
  '[{"key":"A","text":"Rephrase the explanation using simpler language or an appropriate visual example and confirm understanding"},{"key":"B","text":"Repeat the same technical explanation louder"},{"key":"C","text":"Tell the customer the details are too technical"},{"key":"D","text":"Skip the explanation and ask for payment"}]'::jsonb,
  '["A"]'::jsonb,
  'Effective communication adapts to the listener and checks understanding rather than simply repeating the same wording.'
),
(
  19,
  'scenario',
  'scenario',
  'A customer asks why a repair estimate includes a component that appears inexpensive online. What is the BEST technician response?',
  '[{"key":"A","text":"Explain the technical purpose of the repair and refer detailed pricing questions to the appropriate company process without criticizing the customer’s comparison"},{"key":"B","text":"Tell the customer online prices are irrelevant"},{"key":"C","text":"Change the company price without approval"},{"key":"D","text":"Refuse to discuss the repair"}]'::jsonb,
  '["A"]'::jsonb,
  'The technician can explain the technical need for the repair while leaving company pricing policy and authorization to the appropriate process.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician finishes a difficult service call involving multiple findings, a temporary repair, and a part that must be ordered. What is the BEST closeout communication?',
  '[{"key":"A","text":"Summarize what was reported, what was found, what was completed, the current system status, what remains, and the expected next step without making unsupported promises"},{"key":"B","text":"Tell the customer only that the job is not finished"},{"key":"C","text":"Leave all follow-up communication to the office without documenting anything"},{"key":"D","text":"Promise an exact return date before confirming part availability"}]'::jsonb,
  '["A"]'::jsonb,
  'A strong service closeout gives the customer and internal team a clear picture of the findings, completed work, current condition, open items, and next steps.'
);

create temporary table _seed_hvac_customer_service_communication_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_hvac_customer_service_communication_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 4 performance in HVAC Customer & Service Communication?',
  '[{"key":"A","text":"Leading complex customer and stakeholder communication, translating technical information clearly, managing difficult situations, and aligning expectations across teams"},{"key":"B","text":"Avoiding customer conversations whenever possible"},{"key":"C","text":"Making commitments without confirming scope, price, or schedule"},{"key":"D","text":"Using technical language without considering the audience"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 communication combines technical credibility, customer leadership, expectation management, conflict handling, and coordination across multiple stakeholders.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is it important for a senior technician or design professional to distinguish facts, assumptions, recommendations, and commitments during customer communication?',
  '[{"key":"A","text":"Because each carries a different level of certainty and responsibility and should be communicated accurately"},{"key":"B","text":"Because customers should hear only technical facts"},{"key":"C","text":"Because recommendations do not need explanation"},{"key":"D","text":"Because commitments can always be changed later"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear separation of facts, assumptions, recommendations, and commitments reduces confusion and prevents unsupported expectations.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST communication principle when explaining a complex HVAC solution to a nontechnical customer?',
  '[{"key":"A","text":"Match the explanation to the customer’s level of understanding while preserving technical accuracy"},{"key":"B","text":"Use as much industry terminology as possible"},{"key":"C","text":"Avoid explaining tradeoffs"},{"key":"D","text":"Assume the customer wants only the final price"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced communication translates technical information into understandable language without removing important limitations or tradeoffs.'
),
(
  4,
  'multiple_choice',
  'application',
  'A customer asks why a more expensive HVAC option is being recommended over a lower-cost alternative. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Explain the technical and application differences, expected benefits, limitations, and decision factors without overstating outcomes"},{"key":"B","text":"Say the more expensive option is always better"},{"key":"C","text":"Avoid discussing the differences"},{"key":"D","text":"Criticize the lower-cost manufacturer"}]'::jsonb,
  '["A"]'::jsonb,
  'A strong recommendation explains why one solution better fits the project while clearly presenting relevant tradeoffs and limitations.'
),
(
  5,
  'multiple_choice',
  'application',
  'A senior technician discovers that the original customer explanation of a system problem was incomplete. What is the BEST communication approach?',
  '[{"key":"A","text":"Provide an updated explanation based on the verified findings and clearly identify what changed from the earlier understanding"},{"key":"B","text":"Avoid mentioning the new information"},{"key":"C","text":"Blame the earlier technician"},{"key":"D","text":"Continue using the original explanation"}]'::jsonb,
  '["A"]'::jsonb,
  'When new information changes the technical understanding, the customer should receive a clear update focused on the evidence rather than blame.'
),
(
  6,
  'multiple_choice',
  'application',
  'A design professional is presenting two HVAC system options with different first cost, comfort features, and operating characteristics. What is the BEST approach?',
  '[{"key":"A","text":"Present the differences in a consistent way so the customer can compare benefits, limitations, cost, and application fit"},{"key":"B","text":"Present only the option with the highest price"},{"key":"C","text":"Hide the limitations of the preferred option"},{"key":"D","text":"Use only equipment model numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'Customers make better decisions when options are explained using consistent comparison criteria and realistic tradeoffs.'
),
(
  7,
  'multiple_choice',
  'application',
  'A technician must explain that a requested comfort outcome may not be achievable without additional system or building changes. What is the BEST response?',
  '[{"key":"A","text":"Explain the technical limitation, what would be required to improve the outcome, and avoid promising performance the system cannot reliably deliver"},{"key":"B","text":"Promise the requested result anyway"},{"key":"C","text":"Tell the customer the request is unreasonable"},{"key":"D","text":"Avoid discussing the limitation"}]'::jsonb,
  '["A"]'::jsonb,
  'Advanced customer communication sets realistic expectations by connecting requested outcomes to actual system and building constraints.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project has a schedule delay caused by equipment availability. What is the BEST communication approach?',
  '[{"key":"A","text":"Communicate the confirmed delay, explain its impact, identify available options, and avoid promising a revised date until it is supportable"},{"key":"B","text":"Wait until the customer asks"},{"key":"C","text":"Give the customer the most optimistic date possible"},{"key":"D","text":"Blame the supplier without discussing next steps"}]'::jsonb,
  '["A"]'::jsonb,
  'Proactive communication should clearly state what is known, what is affected, what options exist, and what remains uncertain.'
),
(
  9,
  'multiple_choice',
  'application',
  'A customer questions why the proposed system differs from what another contractor recommended. What is the BEST response?',
  '[{"key":"A","text":"Explain the design assumptions, load or application criteria, and reasoning behind the proposed solution without attacking the competitor"},{"key":"B","text":"Say the other contractor does not know HVAC"},{"key":"C","text":"Change the design to match the competitor"},{"key":"D","text":"Refuse to discuss the difference"}]'::jsonb,
  '["A"]'::jsonb,
  'A professional comparison focuses on the technical basis for the recommendation rather than criticizing another contractor.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer agrees verbally to a significant scope change during a site meeting. What is the BEST next step?',
  '[{"key":"A","text":"Document the requested change and complete the required approval or change-order process before relying on the verbal agreement"},{"key":"B","text":"Begin the added work immediately without documentation"},{"key":"C","text":"Assume the change is included at no cost"},{"key":"D","text":"Wait until project closeout to mention it"}]'::jsonb,
  '["A"]'::jsonb,
  'Significant scope changes should be documented and formally approved so expectations, cost, and responsibility remain clear.'
),
(
  11,
  'scenario',
  'scenario',
  'A homeowner is angry because a recently installed system does not cool one bedroom as expected. Testing shows the equipment capacity is adequate, but the room has an air-distribution problem. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Acknowledge the comfort concern, explain the verified cause in clear terms, outline the corrective options, and avoid framing the issue as simply needing larger equipment"},{"key":"B","text":"Tell the homeowner the system is technically working and end the discussion"},{"key":"C","text":"Recommend a larger system immediately"},{"key":"D","text":"Blame the homeowner for expecting too much"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 communication connects the customer experience to the verified system condition and provides a technically appropriate path forward.'
),
(
  12,
  'scenario',
  'scenario',
  'A sales presentation includes a high-efficiency system. The customer asks exactly how much money it will save each year, but no energy analysis has been completed. What is the BEST response?',
  '[{"key":"A","text":"Explain the efficiency benefit without promising a specific savings amount that has not been calculated or supported"},{"key":"B","text":"Give the customer a large savings estimate to support the sale"},{"key":"C","text":"Guarantee that utility bills will decrease by a fixed percentage"},{"key":"D","text":"Avoid discussing efficiency at all"}]'::jsonb,
  '["A"]'::jsonb,
  'Technical sales communication should explain expected benefits while avoiding unsupported financial or performance guarantees.'
),
(
  13,
  'scenario',
  'scenario',
  'A senior technician is called to a site after several unsuccessful repairs. The customer has lost confidence in the company. What is the BEST communication strategy?',
  '[{"key":"A","text":"Acknowledge the history, summarize what is known, explain the structured diagnostic plan, and provide clear updates as evidence is gathered"},{"key":"B","text":"Defend every earlier repair before beginning diagnosis"},{"key":"C","text":"Promise that the next repair will definitely solve everything"},{"key":"D","text":"Avoid discussing the previous visits"}]'::jsonb,
  '["A"]'::jsonb,
  'Restoring confidence requires transparency, a clear technical process, and disciplined updates rather than defensiveness or unsupported guarantees.'
),
(
  14,
  'scenario',
  'scenario',
  'A project requires a design change that will increase cost and extend the schedule. The change is technically necessary because of field conditions discovered after work began. What is the BEST response?',
  '[{"key":"A","text":"Explain the verified field condition, why the design must change, the cost and schedule impacts, and the approval required before proceeding"},{"key":"B","text":"Make the change and explain the added cost afterward"},{"key":"C","text":"Hide the field condition to avoid delaying the project"},{"key":"D","text":"Continue with the original design even though it is no longer appropriate"}]'::jsonb,
  '["A"]'::jsonb,
  'A material design change should be communicated with its technical basis, project impact, and approval requirements before additional work proceeds.'
),
(
  15,
  'scenario',
  'scenario',
  'A customer believes a warranty should cover a failed component, but the technician is not authorized to make warranty determinations. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Explain the verified equipment condition, avoid promising coverage, and route the warranty determination through the authorized company process"},{"key":"B","text":"Guarantee that the repair will be free"},{"key":"C","text":"Tell the customer warranties never apply"},{"key":"D","text":"Avoid documenting the customer question"}]'::jsonb,
  '["A"]'::jsonb,
  'The customer should receive accurate technical information while warranty commitments remain with the authorized process.'
),
(
  16,
  'scenario',
  'scenario',
  'A builder, homeowner, and HVAC contractor disagree about responsibility for a comfort issue involving both building-envelope and HVAC factors. What is the BEST communication approach?',
  '[{"key":"A","text":"Separate verified observations from responsibility claims, explain how the building and HVAC conditions interact, and coordinate next steps based on evidence"},{"key":"B","text":"Immediately assign blame to the builder"},{"key":"C","text":"Say the HVAC system cannot contribute to the issue"},{"key":"D","text":"Avoid discussing findings until someone accepts responsibility"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex stakeholder situations should be managed through factual findings, system-level explanation, and coordinated next steps rather than premature blame.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer wants to eliminate all temperature variation between rooms, but the building design and existing distribution system make that outcome unrealistic without significant changes. What is the BEST response?',
  '[{"key":"A","text":"Explain the existing limitations, describe what improvement is realistically achievable, and present the changes required for a higher level of performance"},{"key":"B","text":"Guarantee identical temperatures throughout the building"},{"key":"C","text":"Tell the customer nothing can be improved"},{"key":"D","text":"Recommend larger equipment without discussing distribution"}]'::jsonb,
  '["A"]'::jsonb,
  'Expectation management requires defining what the current system can reasonably achieve and what additional work would be needed for a different outcome.'
),
(
  18,
  'scenario',
  'scenario',
  'A design and sales engineer realizes that a proposal contains an incorrect assumption that materially affects equipment selection. The customer has already reviewed the proposal but has not signed it. What is the BEST response?',
  '[{"key":"A","text":"Correct the technical assumption, revise the proposal, and clearly explain the change before requesting approval"},{"key":"B","text":"Leave the proposal unchanged unless the customer notices"},{"key":"C","text":"Wait until installation to correct the design"},{"key":"D","text":"Have the customer sign first and revise it later"}]'::jsonb,
  '["A"]'::jsonb,
  'Material technical errors should be corrected transparently before the customer approves a proposal or the project proceeds.'
),
(
  19,
  'scenario',
  'scenario',
  'A difficult service call involves a customer who repeatedly interrupts and disputes the technician’s findings. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Stay calm, listen for the underlying concern, summarize the verified evidence clearly, set respectful boundaries, and involve management if the interaction cannot remain productive"},{"key":"B","text":"Interrupt the customer more forcefully"},{"key":"C","text":"Stop explaining the evidence"},{"key":"D","text":"Make concessions that are not authorized just to end the conversation"}]'::jsonb,
  '["A"]'::jsonb,
  'Senior-level communication manages conflict without becoming defensive while maintaining clarity, professionalism, and appropriate escalation.'
),
(
  20,
  'scenario',
  'scenario',
  'A project closeout includes several completed repairs, one deferred recommendation, a customer training item, and a follow-up visit that still needs scheduling. What is the BEST closeout communication?',
  '[{"key":"A","text":"Provide a clear summary of completed work, current system status, deferred items, customer responsibilities, and confirmed or pending next steps"},{"key":"B","text":"Tell the customer only that the system is running"},{"key":"C","text":"Leave all remaining information for the invoice"},{"key":"D","text":"Promise a follow-up date before scheduling confirms it"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete closeout aligns the customer and internal team on what is finished, what remains open, and what happens next.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '7857d279-97b4-4b3a-8c13-2d076f2d2153';
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
      and c.name = 'HVAC Customer & Service Communication'
      and c.is_current = true
  ) then
    raise exception 'Current HVAC Customer & Service Communication Master Competency not found';
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
      and mrcr.required_level = 1
  ) then
    raise exception 'Current HVAC Installer / Helper L1 HVAC Customer & Service Communication requirement not found';
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
    raise exception 'Current HVAC Service & Repair Technician L3 HVAC Customer & Service Communication requirement not found';
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
    raise exception 'Current Senior / Lead HVAC Technician L4 HVAC Customer & Service Communication requirement not found';
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
    raise exception 'Current HVAC Design & Sales Engineer L4 HVAC Customer & Service Communication requirement not found';
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
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
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
  v_role_template_id := v_installer_role_id;
  v_assessment_name := 'HVAC Customer & Service Communication — Level 1 Competency Assessment';

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
    select * from _seed_hvac_customer_service_communication_l1_questions
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
        'HVAC Customer & Service Communication',
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
      'IntegrateU HVAC Customer & Service Communication L1 production assessment v1.0.',
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
      v_installer_role_id
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
        'HVAC Customer & Service Communication',
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
        'IntegrateU HVAC Customer & Service Communication L1 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Customer & Service Communication — Level 3 Competency Assessment';

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
    select * from _seed_hvac_customer_service_communication_l3_questions
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
        'HVAC Customer & Service Communication',
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
      'IntegrateU HVAC Customer & Service Communication L3 production assessment v1.0.',
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
        'HVAC Customer & Service Communication',
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
        'IntegrateU HVAC Customer & Service Communication L3 production assessment v1.0.',
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
  v_assessment_name := 'HVAC Customer & Service Communication — Level 4 Competency Assessment';

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
    select * from _seed_hvac_customer_service_communication_l4_questions
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
        'HVAC Customer & Service Communication',
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
      'IntegrateU HVAC Customer & Service Communication L4 production assessment v1.0.',
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

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_design_sales_role_id
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
        'HVAC Customer & Service Communication',
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
        'IntegrateU HVAC Customer & Service Communication L4 production assessment v1.0.',
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
   '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid
  and a.target_level in (1,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 HVAC Installer / Helper          -> 20
--   Level 3 HVAC Service & Repair Technician -> 20
--   Level 4 Senior / Lead HVAC Technician    -> 20
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
      '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid
    and a.target_level in (1,3,4)
    and aq.master_competency_template_id =
      '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid
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
    '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id in (
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid,
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid
  ))
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid;

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
    '7857d279-97b4-4b3a-8c13-2d076f2d2153'::uuid
  and a.target_level in (1,3,4)
group by a.target_level
having count(*) > 1;
