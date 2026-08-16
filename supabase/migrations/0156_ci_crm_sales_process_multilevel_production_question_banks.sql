-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0156_ci_crm_sales_process_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: CRM / Sales Process
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Service Technician                 -> Level 1
--   Project Manager                    -> Level 2
--   Operations Manager                 -> Level 3
--   Sales Specialist                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess CRM use, opportunity management,
-- activity tracking, follow-up discipline, sales-stage accuracy, forecasting,
-- and progressively higher levels of sales-process ownership and judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_crm_sales_process_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_crm_sales_process_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a CRM in the sales process?',
  '[{"key":"A","text":"To maintain accurate opportunity, activity, follow-up, and customer information in one shared system"},{"key":"B","text":"To replace all client communication"},{"key":"C","text":"To store only closed projects"},{"key":"D","text":"To track only accounting transactions"}]'::jsonb,
  '["A"]'::jsonb,
  'A CRM creates shared visibility into customers, opportunities, activities, and next steps.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should sales and customer activity be entered into the CRM?',
  '[{"key":"A","text":"So the organization has a current record of interactions, commitments, and follow-up"},{"key":"B","text":"Only so management can count emails"},{"key":"C","text":"Because personal notes are always prohibited"},{"key":"D","text":"Only after a sale closes"}]'::jsonb,
  '["A"]'::jsonb,
  'Activity records help teams understand what has happened and what should happen next.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does an opportunity stage represent in a CRM?',
  '[{"key":"A","text":"The current position of an opportunity within the defined sales process"},{"key":"B","text":"The technician assigned to the project"},{"key":"C","text":"The final invoice status"},{"key":"D","text":"The warehouse location of equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Stages communicate where an opportunity currently sits in the defined sales workflow.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is a next follow-up date important on an active opportunity?',
  '[{"key":"A","text":"It creates a clear commitment for the next sales action and reduces the chance the opportunity is forgotten"},{"key":"B","text":"It guarantees the customer will buy"},{"key":"C","text":"It replaces opportunity notes"},{"key":"D","text":"It is only useful after a proposal is accepted"}]'::jsonb,
  '["A"]'::jsonb,
  'Defined follow-up dates support disciplined opportunity management.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of keeping contact information current in the CRM?',
  '[{"key":"A","text":"To ensure the team can communicate with the correct people using reliable information"},{"key":"B","text":"To increase the number of CRM records"},{"key":"C","text":"To replace project documentation"},{"key":"D","text":"Only to support marketing campaigns"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate contact records support reliable communication and handoff.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What should happen when an opportunity is no longer active or viable?',
  '[{"key":"A","text":"Its status should be updated accurately according to the defined sales process"},{"key":"B","text":"It should remain open indefinitely"},{"key":"C","text":"It should be deleted without explanation"},{"key":"D","text":"It should automatically be marked won"}]'::jsonb,
  '["A"]'::jsonb,
  'Opportunity status should reflect reality so pipeline information remains useful.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'Why is consistent CRM use important across a team?',
  '[{"key":"A","text":"It creates shared visibility and makes pipeline information more reliable"},{"key":"B","text":"It allows each person to define different sales stages"},{"key":"C","text":"It eliminates the need for communication"},{"key":"D","text":"It guarantees every opportunity will close"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent use improves the reliability of shared sales information.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'What is a sales-process activity?',
  '[{"key":"A","text":"A defined action such as a call, meeting, site visit, proposal follow-up, or other step used to advance an opportunity"},{"key":"B","text":"Only a signed contract"},{"key":"C","text":"Any internal company meeting"},{"key":"D","text":"Only an invoice payment"}]'::jsonb,
  '["A"]'::jsonb,
  'Sales activities are actions used to manage and advance opportunities.'
),
(
  9,
  'multiple_choice',
  'application',
  'A client calls a service technician and mentions interest in upgrading the system. What is the BEST CRM-related action?',
  '[{"key":"A","text":"Capture or route the opportunity according to the company process so the sales team can follow up"},{"key":"B","text":"Keep the information in personal memory"},{"key":"C","text":"Wait until the client calls again"},{"key":"D","text":"Create an invoice immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Potential opportunities identified outside sales should still enter the defined opportunity-management process.'
),
(
  10,
  'multiple_choice',
  'application',
  'A customer says they are not ready to proceed for three months. What is the BEST CRM action?',
  '[{"key":"A","text":"Update the opportunity notes and set an appropriate future follow-up date"},{"key":"B","text":"Delete the opportunity"},{"key":"C","text":"Mark it closed won"},{"key":"D","text":"Leave the record unchanged"}]'::jsonb,
  '["A"]'::jsonb,
  'The CRM should reflect both the current situation and the next planned action.'
),
(
  11,
  'multiple_choice',
  'application',
  'A contact changes companies and provides new information. What should happen?',
  '[{"key":"A","text":"Update the CRM record according to company data practices so future communication uses accurate information"},{"key":"B","text":"Keep using the old information"},{"key":"C","text":"Create unrelated duplicate records every time information changes"},{"key":"D","text":"Remove the contact from all records"}]'::jsonb,
  '["A"]'::jsonb,
  'Current contact data improves communication accuracy and record quality.'
),
(
  12,
  'multiple_choice',
  'application',
  'A systems designer completes a site visit that supports an active sales opportunity. What should happen to the important findings?',
  '[{"key":"A","text":"They should be documented or communicated through the defined process so the opportunity record and sales team have the needed information"},{"key":"B","text":"They should remain only in the designer personal notes"},{"key":"C","text":"They should be shared only after the project closes"},{"key":"D","text":"They should be deleted after the visit"}]'::jsonb,
  '["A"]'::jsonb,
  'Information gathered during opportunity development should be visible to the people managing the sales process.'
),
(
  13,
  'multiple_choice',
  'application',
  'An opportunity shows no recent activity and no future follow-up date. What is the BEST action?',
  '[{"key":"A","text":"Review the opportunity, update its status, and establish the appropriate next action or disposition"},{"key":"B","text":"Assume someone else is handling it"},{"key":"C","text":"Leave it untouched indefinitely"},{"key":"D","text":"Mark it won"}]'::jsonb,
  '["A"]'::jsonb,
  'Active opportunities should have an accurate status and a clear next step.'
),
(
  14,
  'multiple_choice',
  'application',
  'A customer meeting occurs, but the CRM still shows the previous activity as the most recent interaction. What should happen?',
  '[{"key":"A","text":"Record the meeting and relevant outcomes so the CRM reflects the current opportunity history"},{"key":"B","text":"Leave the old activity because the meeting already happened"},{"key":"C","text":"Delete the entire opportunity"},{"key":"D","text":"Wait until the proposal is signed"}]'::jsonb,
  '["A"]'::jsonb,
  'CRM activity history should reflect meaningful customer interactions.'
),
(
  15,
  'multiple_choice',
  'application',
  'A sales opportunity is marked as proposal sent, but no proposal was actually delivered. What should happen?',
  '[{"key":"A","text":"Correct the stage or complete the missing process step so the CRM reflects reality"},{"key":"B","text":"Leave the stage because it looks better in the pipeline"},{"key":"C","text":"Move it directly to closed won"},{"key":"D","text":"Delete the activity history"}]'::jsonb,
  '["A"]'::jsonb,
  'Sales stages should reflect actual completed milestones rather than intended activity.'
),
(
  16,
  'multiple_choice',
  'application',
  'A client asks a project manager about an opportunity that was discussed before project completion. What is the BEST way to support the sales team?',
  '[{"key":"A","text":"Record or communicate the relevant information through the defined CRM or sales handoff process"},{"key":"B","text":"Keep the request outside the CRM because the project manager is not in sales"},{"key":"C","text":"Tell the client to call again later"},{"key":"D","text":"Mark the existing project as a new opportunity without context"}]'::jsonb,
  '["A"]'::jsonb,
  'Customer opportunity information should be transferred into the shared sales process regardless of where it originates.'
),
(
  17,
  'scenario',
  'scenario',
  'A service technician learns during a service visit that the client wants pricing for a major system expansion. What is the BEST response?',
  '[{"key":"A","text":"Capture the opportunity details and route them through the defined CRM and sales process with a clear next step"},{"key":"B","text":"Promise pricing without involving sales"},{"key":"C","text":"Wait for the client to submit another request"},{"key":"D","text":"Record the request only on the service invoice"}]'::jsonb,
  '["A"]'::jsonb,
  'Expansion interest should become a visible, actionable opportunity in the defined sales workflow.'
),
(
  18,
  'scenario',
  'scenario',
  'A systems designer discovers during a site assessment that the customer has additional needs not included in the original opportunity. What is the BEST action?',
  '[{"key":"A","text":"Document and communicate the additional needs so the opportunity can be updated and managed through the sales process"},{"key":"B","text":"Add the work to the future project without informing sales"},{"key":"C","text":"Ignore the new needs because they were not in the original request"},{"key":"D","text":"Tell the client the company cannot discuss additional work"}]'::jsonb,
  '["A"]'::jsonb,
  'New customer needs should be incorporated into the shared opportunity-management process.'
),
(
  19,
  'scenario',
  'scenario',
  'A CRM shows an opportunity as active, but the customer told someone two weeks ago that the project was canceled. What is the BEST response?',
  '[{"key":"A","text":"Update the opportunity to the appropriate status and record the relevant reason or context according to company process"},{"key":"B","text":"Leave it active to preserve pipeline value"},{"key":"C","text":"Delete all customer history"},{"key":"D","text":"Move it to proposal sent"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline records should reflect the true status of opportunities.'
),
(
  20,
  'scenario',
  'scenario',
  'A customer calls asking about a proposal, but the employee answering cannot find any notes, recent activity, or follow-up information in the CRM. What is the BEST lesson from this situation?',
  '[{"key":"A","text":"Important opportunity interactions and next steps should be consistently recorded so other team members have reliable visibility"},{"key":"B","text":"Only the salesperson should ever know opportunity status"},{"key":"C","text":"CRM activity history is unnecessary when employees remember conversations"},{"key":"D","text":"Customer follow-up should occur only by email"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared CRM discipline supports continuity when more than one employee interacts with the customer.'
);

create temporary table _seed_ci_crm_sales_process_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_crm_sales_process_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of defining clear sales stages in a CRM?',
  '[{"key":"A","text":"To create consistent criteria for where opportunities are in the sales process and what should happen next"},{"key":"B","text":"To allow each salesperson to invent different stage meanings"},{"key":"C","text":"To replace opportunity notes"},{"key":"D","text":"To track only closed deals"}]'::jsonb,
  '["A"]'::jsonb,
  'Defined stages create shared expectations for opportunity status and progression.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is an accurate expected close date important on an active opportunity?',
  '[{"key":"A","text":"It supports planning and forecasting based on the best current information"},{"key":"B","text":"It guarantees the sale will close on that date"},{"key":"C","text":"It replaces follow-up activity"},{"key":"D","text":"It is useful only after the contract is signed"}]'::jsonb,
  '["A"]'::jsonb,
  'Close dates help forecast timing when they reflect realistic current expectations.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is pipeline hygiene?',
  '[{"key":"A","text":"Keeping opportunity stages, values, dates, contacts, notes, and next steps current and accurate"},{"key":"B","text":"Deleting all old customer records"},{"key":"C","text":"Moving every opportunity forward each week"},{"key":"D","text":"Keeping only won opportunities in the CRM"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline hygiene means maintaining reliable opportunity data so the CRM reflects reality.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What should a sales stage change normally represent?',
  '[{"key":"A","text":"A meaningful completed milestone or verified change in the opportunity"},{"key":"B","text":"A salesperson desire to make the pipeline look stronger"},{"key":"C","text":"The amount of time the opportunity has been open"},{"key":"D","text":"Any internal meeting about the account"}]'::jsonb,
  '["A"]'::jsonb,
  'Stage movement should be based on defined sales-process criteria rather than optimism.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why should lost opportunities include an accurate loss reason when the process requires it?',
  '[{"key":"A","text":"To improve reporting and help the organization understand why business is not closing"},{"key":"B","text":"To assign blame to the salesperson"},{"key":"C","text":"To reopen every lost opportunity later"},{"key":"D","text":"To eliminate the need for sales meetings"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent loss reasons provide useful information for sales analysis and improvement.'
),
(
  6,
  'multiple_choice',
  'application',
  'A project manager learns that a client wants a second project quoted while the current project is still active. What is the BEST CRM action?',
  '[{"key":"A","text":"Create or route the new opportunity through the defined sales process with the appropriate client and project context"},{"key":"B","text":"Add the request only to the current project punch list"},{"key":"C","text":"Wait until the current project closes"},{"key":"D","text":"Treat the new request as automatically approved"}]'::jsonb,
  '["A"]'::jsonb,
  'New revenue opportunities should be visible and managed separately through the defined sales process.'
),
(
  7,
  'multiple_choice',
  'application',
  'An opportunity is marked proposal sent, but the proposal was revised and has not yet been delivered to the client. What should happen?',
  '[{"key":"A","text":"Update the stage or status to reflect the actual current milestone until the revised proposal is delivered"},{"key":"B","text":"Leave the opportunity at proposal sent because a previous version existed"},{"key":"C","text":"Move it to closed won"},{"key":"D","text":"Delete the revision history"}]'::jsonb,
  '["A"]'::jsonb,
  'CRM stages should reflect the current state of the opportunity, not an outdated milestone.'
),
(
  8,
  'multiple_choice',
  'application',
  'A salesperson has completed a follow-up call and agreed to send revised pricing by Friday. What should be recorded?',
  '[{"key":"A","text":"The call outcome, relevant notes, and a clear next activity or commitment for the revised pricing"},{"key":"B","text":"Only that a call occurred"},{"key":"C","text":"Nothing until the client accepts the proposal"},{"key":"D","text":"Only the new opportunity value"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful CRM activity records capture both what happened and what happens next.'
),
(
  9,
  'multiple_choice',
  'application',
  'An opportunity has been open for six months with repeated missed follow-up dates and no meaningful customer engagement. What is the BEST action?',
  '[{"key":"A","text":"Review the opportunity objectively, confirm its viability, and update its stage, next step, or disposition accordingly"},{"key":"B","text":"Keep it open indefinitely because it might close someday"},{"key":"C","text":"Increase its probability automatically"},{"key":"D","text":"Move it to closed won for forecasting"}]'::jsonb,
  '["A"]'::jsonb,
  'Aging opportunities should be reviewed so inactive or unrealistic pipeline does not distort visibility.'
),
(
  10,
  'multiple_choice',
  'application',
  'A client verbally approves moving forward, but the company sales process requires a signed agreement before closed won. What should the CRM show?',
  '[{"key":"A","text":"The opportunity should remain at the appropriate pre-close stage until the required close criterion is met"},{"key":"B","text":"Closed won immediately because the client sounded committed"},{"key":"C","text":"Closed lost until the agreement arrives"},{"key":"D","text":"No stage at all"}]'::jsonb,
  '["A"]'::jsonb,
  'Opportunity stages should follow defined exit criteria consistently.'
),
(
  11,
  'multiple_choice',
  'application',
  'A project manager notices the CRM opportunity value does not match the latest approved proposal amount. What should happen?',
  '[{"key":"A","text":"Verify the correct amount and update or route the correction through the defined CRM process"},{"key":"B","text":"Leave the old value because the opportunity already exists"},{"key":"C","text":"Use whichever number produces the better forecast"},{"key":"D","text":"Delete the opportunity"}]'::jsonb,
  '["A"]'::jsonb,
  'Opportunity value should remain aligned with the current commercial reality.'
),
(
  12,
  'multiple_choice',
  'application',
  'A client meeting identifies a new decision-maker who must approve the project. What is the BEST CRM action?',
  '[{"key":"A","text":"Add or update the contact information and document the decision role and relevant next steps"},{"key":"B","text":"Keep communicating only with the original contact"},{"key":"C","text":"Remove the original contact"},{"key":"D","text":"Move the opportunity to closed lost"}]'::jsonb,
  '["A"]'::jsonb,
  'Decision-maker information is important to accurate opportunity management and follow-up.'
),
(
  13,
  'multiple_choice',
  'application',
  'A sales rep has ten active opportunities but only four have a documented next step. What is the BEST corrective action?',
  '[{"key":"A","text":"Review the active pipeline and establish a clear next action or disposition for each viable opportunity"},{"key":"B","text":"Leave the other six unchanged until clients reach out"},{"key":"C","text":"Move all ten forward one stage"},{"key":"D","text":"Close the six without next steps as won"}]'::jsonb,
  '["A"]'::jsonb,
  'Active opportunities should have clear ownership and next-step discipline.'
),
(
  14,
  'multiple_choice',
  'application',
  'A previously lost opportunity becomes active again after the client contacts the company with a revised budget. What is the BEST CRM response?',
  '[{"key":"A","text":"Reopen or create the opportunity according to company process and document the new context and next step"},{"key":"B","text":"Ignore it because the prior opportunity was lost"},{"key":"C","text":"Change the old loss reason without documenting the new activity"},{"key":"D","text":"Mark it closed won immediately"}]'::jsonb,
  '["A"]'::jsonb,
  'Renewed customer interest should enter the active pipeline with accurate current context.'
),
(
  15,
  'scenario',
  'scenario',
  'A project manager is preparing for a client meeting and finds the CRM shows proposal sent, but the salesperson notes privately that the client requested major revisions last week. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the CRM with the actual opportunity status, document the revision request, and establish the correct next step before relying on the record"},{"key":"B","text":"Ignore the private note because the CRM stage is official"},{"key":"C","text":"Move the opportunity to closed won"},{"key":"D","text":"Delete the opportunity and start over"}]'::jsonb,
  '["A"]'::jsonb,
  'The CRM should reflect the best current shared understanding of the opportunity.'
),
(
  16,
  'scenario',
  'scenario',
  'A salesperson has several opportunities forecast to close this month, but none has recent activity and most have overdue next steps. What is the BEST response?',
  '[{"key":"A","text":"Review each opportunity, update activity and realistic close timing, and remove unsupported assumptions from the forecast"},{"key":"B","text":"Leave the forecast unchanged to preserve the monthly target"},{"key":"C","text":"Increase the values to compensate for uncertainty"},{"key":"D","text":"Move all opportunities to closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecast quality depends on current activity, realistic timing, and evidence-based opportunity status.'
),
(
  17,
  'scenario',
  'scenario',
  'A customer asks for a follow-up next Tuesday, but the salesperson enters only a note saying follow up later. What is the BEST correction?',
  '[{"key":"A","text":"Create the specific next activity for Tuesday and retain the relevant customer context in the record"},{"key":"B","text":"Leave the vague note because the salesperson will remember"},{"key":"C","text":"Move the opportunity forward one stage"},{"key":"D","text":"Close the opportunity until Tuesday"}]'::jsonb,
  '["A"]'::jsonb,
  'Specific dated next actions reduce missed commitments and improve pipeline discipline.'
),
(
  18,
  'scenario',
  'scenario',
  'An opportunity is marked closed lost with reason price, but notes show the client selected another provider because the company missed multiple follow-ups. What is the BEST action?',
  '[{"key":"A","text":"Correct the loss reason to reflect the most accurate cause according to company definitions so reporting remains useful"},{"key":"B","text":"Leave price because it is easier to report"},{"key":"C","text":"Delete the notes"},{"key":"D","text":"Change the opportunity to closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Loss data should reflect the actual reason whenever reasonably known.'
),
(
  19,
  'scenario',
  'scenario',
  'A project manager discovers that a major client opportunity is being managed through texts and personal notes with almost nothing entered in the CRM. What is the BEST response?',
  '[{"key":"A","text":"Bring the important opportunity history, current status, contacts, and next steps into the CRM so the organization has shared visibility"},{"key":"B","text":"Continue using personal notes because the project manager knows the details"},{"key":"C","text":"Wait until the opportunity closes"},{"key":"D","text":"Create only a closed-won record later"}]'::jsonb,
  '["A"]'::jsonb,
  'Material opportunity information should not depend on one person memory or private records.'
),
(
  20,
  'scenario',
  'scenario',
  'A weekly pipeline review finds multiple opportunities in advanced stages even though required milestones have not been completed. What is the BEST response?',
  '[{"key":"A","text":"Reconcile each opportunity against the defined stage criteria, correct inaccurate stages, and reinforce the expected process"},{"key":"B","text":"Keep the advanced stages because they improve the pipeline report"},{"key":"C","text":"Remove stage criteria entirely"},{"key":"D","text":"Mark every opportunity closed lost"}]'::jsonb,
  '["A"]'::jsonb,
  'Stage integrity requires opportunities to meet the defined criteria for the stage shown.'
);

create temporary table _seed_ci_crm_sales_process_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_crm_sales_process_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of pipeline governance?',
  '[{"key":"A","text":"To maintain consistent opportunity standards, ownership, stage discipline, data quality, and reliable visibility across the sales process"},{"key":"B","text":"To maximize the number of open opportunities regardless of quality"},{"key":"C","text":"To allow every salesperson to define stages differently"},{"key":"D","text":"To replace sales leadership judgment"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline governance creates repeatable rules for how opportunities are managed and reported.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should forecast accuracy be evaluated over time?',
  '[{"key":"A","text":"To determine whether opportunity assumptions, close timing, and sales-process discipline are producing reliable predictions"},{"key":"B","text":"To guarantee every forecast becomes actual revenue"},{"key":"C","text":"To eliminate the need for pipeline reviews"},{"key":"D","text":"To measure only salesperson activity volume"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecast accuracy reveals whether the pipeline is being managed with realistic and consistent assumptions.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of stage exit criteria?',
  '[{"key":"A","text":"To define the evidence or milestone required before an opportunity advances to the next stage"},{"key":"B","text":"To move opportunities forward automatically after a set number of days"},{"key":"C","text":"To replace follow-up tasks"},{"key":"D","text":"To make every opportunity follow the same close date"}]'::jsonb,
  '["A"]'::jsonb,
  'Exit criteria improve stage integrity by requiring evidence before progression.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should leaders distinguish pipeline volume from pipeline quality?',
  '[{"key":"A","text":"A large pipeline may still be unreliable if opportunities are stale, poorly qualified, inaccurately staged, or missing next steps"},{"key":"B","text":"Pipeline quality matters only after the quarter ends"},{"key":"C","text":"More opportunities always means more reliable revenue"},{"key":"D","text":"Pipeline quality is determined only by total dollar value"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline value is useful only when the underlying opportunities are credible and actively managed.'
),
(
  5,
  'multiple_choice',
  'application',
  'An operations manager sees that many opportunities remain in proposal stage for months with no recent activity. What is the BEST response?',
  '[{"key":"A","text":"Review aging opportunities against stage criteria, recent activity, next steps, and viability, then correct the pipeline accordingly"},{"key":"B","text":"Leave them untouched because they may close eventually"},{"key":"C","text":"Increase their probability to encourage follow-up"},{"key":"D","text":"Move all of them to closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Aging opportunities should be actively evaluated so stale pipeline does not distort reporting.'
),
(
  6,
  'multiple_choice',
  'application',
  'A sales team frequently moves opportunities to advanced stages before required customer milestones occur. What is the BEST corrective action?',
  '[{"key":"A","text":"Reinforce stage definitions and exit criteria, correct inaccurate records, and review adherence during pipeline management"},{"key":"B","text":"Remove stage definitions"},{"key":"C","text":"Allow each salesperson to decide what advanced means"},{"key":"D","text":"Stop using opportunity stages"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent stage criteria are necessary for reliable pipeline and forecast information.'
),
(
  7,
  'multiple_choice',
  'application',
  'Forecast reports show repeated month-end slippage from one month to the next. What should leadership examine first?',
  '[{"key":"A","text":"Whether close dates, customer commitments, next steps, and stage evidence are being updated realistically"},{"key":"B","text":"Only whether CRM users logged in"},{"key":"C","text":"Only the total number of contacts"},{"key":"D","text":"Whether opportunities can be hidden from the report"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated slippage often indicates weak qualification, unrealistic timing, or poor CRM discipline.'
),
(
  8,
  'multiple_choice',
  'application',
  'Several departments identify potential customer opportunities, but many never reach sales. What is the BEST process improvement?',
  '[{"key":"A","text":"Define a clear opportunity-capture and handoff process with ownership, required information, and follow-up expectations"},{"key":"B","text":"Require only salespeople to recognize opportunities"},{"key":"C","text":"Tell employees to email opportunities informally"},{"key":"D","text":"Wait for customers to contact sales directly"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-functional opportunity capture should be structured so potential business is not lost during handoff.'
),
(
  9,
  'multiple_choice',
  'application',
  'A manager finds duplicate opportunities for the same customer and project, each with different values and stages. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the records according to CRM data standards and correct the process that allowed duplication"},{"key":"B","text":"Keep all records because more opportunities improve pipeline value"},{"key":"C","text":"Average the values and leave the duplicates"},{"key":"D","text":"Mark every duplicate closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Duplicate records reduce data quality and can distort pipeline reporting.'
),
(
  10,
  'multiple_choice',
  'application',
  'A team consistently enters follow-up activities but rarely records outcomes. What should leadership reinforce?',
  '[{"key":"A","text":"Activity records should capture meaningful results, decisions, and next steps rather than only proving that contact occurred"},{"key":"B","text":"Only the number of activities matters"},{"key":"C","text":"Outcomes should be kept in private notes"},{"key":"D","text":"The CRM should contain only future tasks"}]'::jsonb,
  '["A"]'::jsonb,
  'Useful activity history explains both what happened and what should happen next.'
),
(
  11,
  'multiple_choice',
  'application',
  'The CRM forecast includes several high-value opportunities with no identified decision-maker or documented next meeting. What is the BEST response?',
  '[{"key":"A","text":"Review qualification and forecast confidence before relying on those opportunities in the expected revenue outlook"},{"key":"B","text":"Keep them because their dollar value is high"},{"key":"C","text":"Increase their probability automatically"},{"key":"D","text":"Mark them closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecast confidence should reflect the quality of opportunity evidence, not just value.'
),
(
  12,
  'scenario',
  'scenario',
  'Leadership expects $1 million to close this quarter, but a pipeline review shows that half of the amount comes from stale opportunities with overdue activities and unsupported close dates. What is the BEST response?',
  '[{"key":"A","text":"Revalidate the opportunities, correct stages and close dates, establish real next steps, and rebuild the forecast from credible pipeline evidence"},{"key":"B","text":"Keep the forecast unchanged to protect the target"},{"key":"C","text":"Increase opportunity values to offset weak deals"},{"key":"D","text":"Move stale opportunities to closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'A reliable forecast must be based on current, evidence-supported opportunities.'
),
(
  13,
  'scenario',
  'scenario',
  'Two salespeople use the same CRM stage differently: one advances after a proposal is delivered, while the other advances when a proposal is merely drafted. What is the BEST response?',
  '[{"key":"A","text":"Clarify the stage definition and exit criteria, correct affected opportunities, and reinforce consistent use across the team"},{"key":"B","text":"Allow both interpretations because each salesperson has a different style"},{"key":"C","text":"Remove the stage from the CRM"},{"key":"D","text":"Use whichever definition produces a larger forecast"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared stage definitions are necessary for meaningful pipeline comparison and forecasting.'
),
(
  14,
  'scenario',
  'scenario',
  'A sales manager reports strong pipeline growth, but an audit finds much of the increase came from duplicate opportunities and old records that were never closed. What is the BEST response?',
  '[{"key":"A","text":"Clean the pipeline, correct duplicate and stale records, and evaluate pipeline growth using reliable data-quality standards"},{"key":"B","text":"Keep the records because the total looks positive"},{"key":"C","text":"Stop auditing pipeline data"},{"key":"D","text":"Convert old records to new opportunities automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline growth should represent real opportunities rather than data-quality problems.'
),
(
  15,
  'scenario',
  'scenario',
  'A major opportunity is forecast to close this month, but the client has not approved scope, no decision meeting is scheduled, and the expected close date has been pushed three times. What is the BEST response?',
  '[{"key":"A","text":"Challenge the forecast assumption, update the opportunity based on current evidence, and establish the next milestone needed to advance"},{"key":"B","text":"Leave it in the current forecast because the opportunity is important"},{"key":"C","text":"Increase the probability to reflect management attention"},{"key":"D","text":"Mark it closed won"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecast timing should reflect actual customer progress and evidence.'
),
(
  16,
  'scenario',
  'scenario',
  'Service and project teams regularly uncover expansion opportunities, but sales learns about them only through informal conversations weeks later. What is the BEST operational solution?',
  '[{"key":"A","text":"Create a defined CRM handoff process with required opportunity information, ownership, timing, and follow-up accountability"},{"key":"B","text":"Tell non-sales employees to stop discussing upgrades"},{"key":"C","text":"Rely on weekly memory-based meetings"},{"key":"D","text":"Wait for clients to request formal proposals"}]'::jsonb,
  '["A"]'::jsonb,
  'A structured handoff reduces lost or delayed opportunities across departments.'
),
(
  17,
  'scenario',
  'scenario',
  'A team has excellent CRM activity volume, but conversion remains weak and many activities have no documented outcome or next step. What is the BEST management response?',
  '[{"key":"A","text":"Shift review from activity quantity alone to activity quality, outcomes, next-step discipline, and whether actions are advancing opportunities"},{"key":"B","text":"Require even more activities without changing expectations"},{"key":"C","text":"Stop recording activity outcomes"},{"key":"D","text":"Move opportunities forward after a fixed number of calls"}]'::jsonb,
  '["A"]'::jsonb,
  'Sales activity should be evaluated by its contribution to opportunity progress, not volume alone.'
),
(
  18,
  'scenario',
  'scenario',
  'A monthly forecast repeatedly misses because opportunities remain open long after customers stop responding. What is the BEST improvement?',
  '[{"key":"A","text":"Define and enforce aging, follow-up, qualification, and disposition rules so inactive opportunities are addressed consistently"},{"key":"B","text":"Keep opportunities open longer"},{"key":"C","text":"Stop using close dates"},{"key":"D","text":"Count all open opportunities as probable revenue"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear aging and disposition rules improve pipeline realism and forecast quality.'
),
(
  19,
  'scenario',
  'scenario',
  'An operations manager finds that sales reports and CRM dashboards show different totals because users frequently edit values and stages just before meetings. What is the BEST response?',
  '[{"key":"A","text":"Establish consistent data-maintenance expectations, review changes against actual opportunity evidence, and make the CRM the governed source of truth"},{"key":"B","text":"Allow separate unofficial pipeline spreadsheets"},{"key":"C","text":"Stop updating CRM values"},{"key":"D","text":"Use whichever report has the higher number"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable reporting requires disciplined maintenance of one governed opportunity record.'
),
(
  20,
  'scenario',
  'scenario',
  'Leadership sees inaccurate stages, stale opportunities, inconsistent loss reasons, weak follow-up discipline, and unreliable forecasts across the sales process. What is the BEST response?',
  '[{"key":"A","text":"Standardize CRM governance, stage criteria, required fields, activity expectations, pipeline reviews, aging rules, coaching, and forecast accountability"},{"key":"B","text":"Add more opportunities to offset the bad data"},{"key":"C","text":"Stop using forecasts"},{"key":"D","text":"Make each salesperson responsible for creating their own process"}]'::jsonb,
  '["A"]'::jsonb,
  'Broad CRM and pipeline problems require a coordinated management system rather than isolated corrections.'
);

create temporary table _seed_ci_crm_sales_process_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_crm_sales_process_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a mature sales-process operating system?',
  '[{"key":"A","text":"To create repeatable standards for opportunity management, qualification, stage discipline, forecasting, accountability, and continuous improvement"},{"key":"B","text":"To maximize CRM activity regardless of outcome"},{"key":"C","text":"To let each salesperson create a separate sales process"},{"key":"D","text":"To eliminate management review"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature sales operating system makes opportunity management consistent, measurable, and repeatable.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why should sales leaders measure both pipeline coverage and pipeline quality?',
  '[{"key":"A","text":"Sufficient pipeline value is useful only when the underlying opportunities are credible, qualified, current, and actively managed"},{"key":"B","text":"Pipeline quality matters only when total value is low"},{"key":"C","text":"Coverage alone guarantees revenue performance"},{"key":"D","text":"Quality can be determined only after opportunities close"}]'::jsonb,
  '["A"]'::jsonb,
  'Sales leaders need both enough opportunity volume and confidence that the pipeline reflects real buying potential.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest purpose of a forecast-management process?',
  '[{"key":"A","text":"To create a disciplined, evidence-based view of likely revenue timing and risk so leadership can make informed decisions"},{"key":"B","text":"To make forecast totals match the sales target"},{"key":"C","text":"To replace opportunity management"},{"key":"D","text":"To report only closed revenue"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecasting should reflect credible opportunity evidence rather than desired outcomes.'
),
(
  4,
  'multiple_choice',
  'application',
  'A sales manager sees that forecast accuracy varies dramatically by salesperson. What is the BEST first response?',
  '[{"key":"A","text":"Compare how each salesperson applies qualification, stage criteria, close dates, probability, and next-step discipline to identify the source of variation"},{"key":"B","text":"Average all forecasts together"},{"key":"C","text":"Remove individual forecasting responsibility"},{"key":"D","text":"Increase every probability to the same value"}]'::jsonb,
  '["A"]'::jsonb,
  'Forecast variation should be investigated through the behaviors and standards that produce the forecast.'
),
(
  5,
  'multiple_choice',
  'application',
  'A team has strong pipeline value but a low win rate and long sales cycles. What is the BEST leadership response?',
  '[{"key":"A","text":"Analyze qualification, stage conversion, opportunity aging, loss reasons, follow-up quality, and where deals are stalling"},{"key":"B","text":"Add more unqualified opportunities"},{"key":"C","text":"Stop measuring win rate"},{"key":"D","text":"Move opportunities through stages faster without changing behavior"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline performance should be evaluated through conversion and process quality, not value alone.'
),
(
  6,
  'multiple_choice',
  'application',
  'Different salespeople use different definitions for when an opportunity is qualified. What should the sales manager do?',
  '[{"key":"A","text":"Establish shared qualification criteria, train the team, and verify consistent application during pipeline reviews"},{"key":"B","text":"Allow each salesperson to define qualification independently"},{"key":"C","text":"Remove qualification from the sales process"},{"key":"D","text":"Use opportunity value as the only qualification measure"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared qualification standards improve pipeline quality and forecast consistency.'
),
(
  7,
  'multiple_choice',
  'application',
  'A sales team frequently misses follow-up commitments even though activities are being entered in the CRM. What should leadership examine?',
  '[{"key":"A","text":"Whether activities have clear owners, due dates, outcomes, accountability, and review when overdue"},{"key":"B","text":"Only whether enough activities were created"},{"key":"C","text":"Whether salespeople can create fewer records"},{"key":"D","text":"Whether follow-up dates should be removed"}]'::jsonb,
  '["A"]'::jsonb,
  'CRM activity is effective only when commitments are specific, owned, completed, and reviewed.'
),
(
  8,
  'multiple_choice',
  'application',
  'A sales manager wants to improve CRM adoption. Which approach is MOST effective?',
  '[{"key":"A","text":"Define required behaviors, explain how the data is used, coach against real opportunities, review compliance consistently, and remove unnecessary friction"},{"key":"B","text":"Require more fields without explaining their purpose"},{"key":"C","text":"Send one reminder email"},{"key":"D","text":"Let high performers opt out of CRM use"}]'::jsonb,
  '["A"]'::jsonb,
  'CRM adoption improves when expectations, value, coaching, and accountability are all aligned.'
),
(
  9,
  'multiple_choice',
  'application',
  'A company pipeline contains many large opportunities, but several have no confirmed budget, decision process, or next meeting. How should leadership treat them?',
  '[{"key":"A","text":"Challenge their qualification and forecast confidence until credible buying evidence is established"},{"key":"B","text":"Treat them as high-confidence because of their value"},{"key":"C","text":"Move them automatically to proposal stage"},{"key":"D","text":"Count them as committed revenue"}]'::jsonb,
  '["A"]'::jsonb,
  'Large opportunity value does not substitute for evidence of a credible buying process.'
),
(
  10,
  'multiple_choice',
  'application',
  'Leadership notices that loss reasons are often selected randomly just to close records. What is the BEST response?',
  '[{"key":"A","text":"Define meaningful loss-reason categories, coach accurate use, and review the data so it supports real sales improvement"},{"key":"B","text":"Remove loss reasons entirely"},{"key":"C","text":"Use one generic loss reason for every deal"},{"key":"D","text":"Leave the process unchanged because the opportunity is already lost"}]'::jsonb,
  '["A"]'::jsonb,
  'Loss data is valuable only when categories are understood and used accurately.'
),
(
  11,
  'scenario',
  'scenario',
  'A sales team consistently forecasts strong month-end results, but a large portion slips into the next month every reporting cycle. What is the BEST leadership response?',
  '[{"key":"A","text":"Analyze slippage by stage, salesperson, opportunity age, customer milestone, and close-date behavior, then correct the forecasting and qualification practices causing the pattern"},{"key":"B","text":"Keep rolling the same opportunities forward"},{"key":"C","text":"Stop comparing forecast to actual results"},{"key":"D","text":"Increase probabilities before month end"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring forecast slippage signals a systemic problem in opportunity timing, qualification, or forecast discipline.'
),
(
  12,
  'scenario',
  'scenario',
  'A company generates many leads but leadership cannot tell how many convert to qualified opportunities, proposals, or wins because stages are used inconsistently. What is the BEST solution?',
  '[{"key":"A","text":"Standardize stage definitions and conversion criteria, clean existing data, train the team, and manage reporting from the governed process"},{"key":"B","text":"Add more lead sources"},{"key":"C","text":"Stop measuring conversion"},{"key":"D","text":"Use salesperson estimates instead of CRM data"}]'::jsonb,
  '["A"]'::jsonb,
  'Reliable funnel metrics require consistent stage definitions and disciplined CRM use.'
),
(
  13,
  'scenario',
  'scenario',
  'A high-performing salesperson closes strong revenue but keeps most opportunity information outside the CRM. Other employees cannot cover the accounts when that salesperson is unavailable. What is the BEST leadership response?',
  '[{"key":"A","text":"Require the same CRM and opportunity-management standards while preserving effective selling behavior, because organizational visibility and continuity are part of performance"},{"key":"B","text":"Exempt the salesperson because revenue is strong"},{"key":"C","text":"Let other employees reconstruct the records later"},{"key":"D","text":"Create a separate private system for that salesperson"}]'::jsonb,
  '["A"]'::jsonb,
  'Strong individual production does not eliminate the need for shared customer and opportunity visibility.'
),
(
  14,
  'scenario',
  'scenario',
  'A sales manager finds that opportunities are routinely advanced before required milestones because reps believe advanced stages receive more management attention. What is the BEST response?',
  '[{"key":"A","text":"Correct the incentive and review behavior, reinforce stage exit criteria, and ensure management attention is not dependent on inflated stages"},{"key":"B","text":"Allow stage inflation because it motivates the team"},{"key":"C","text":"Remove opportunity reviews"},{"key":"D","text":"Move all opportunities into advanced stages"}]'::jsonb,
  '["A"]'::jsonb,
  'Management systems should not create incentives that undermine CRM accuracy.'
),
(
  15,
  'scenario',
  'scenario',
  'Pipeline value has grown 40 percent, but closed revenue has not improved. What is the BEST leadership analysis?',
  '[{"key":"A","text":"Evaluate whether the growth represents qualified opportunities and examine conversion rates, aging, stage movement, win rate, loss reasons, and sales-cycle length"},{"key":"B","text":"Assume revenue will eventually catch up"},{"key":"C","text":"Celebrate the pipeline number without further review"},{"key":"D","text":"Stop measuring closed revenue"}]'::jsonb,
  '["A"]'::jsonb,
  'Pipeline growth should translate into measurable progression and revenue outcomes if the opportunities are high quality.'
),
(
  16,
  'scenario',
  'scenario',
  'A company repeatedly loses deals because proposals and follow-ups occur later than customers expect. CRM data confirms overdue activities are common. What is the BEST systemic response?',
  '[{"key":"A","text":"Define response and follow-up expectations, establish activity ownership and escalation, coach execution, and measure overdue activity and conversion results"},{"key":"B","text":"Tell salespeople to work faster without changing the process"},{"key":"C","text":"Stop entering due dates"},{"key":"D","text":"Remove missed follow-up from loss reporting"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring follow-up failures require process standards, accountability, and measurable improvement.'
),
(
  17,
  'scenario',
  'scenario',
  'A sales manager introduces a stricter pipeline-review meeting, but CRM accuracy does not improve. What is the BEST next step?',
  '[{"key":"A","text":"Determine whether expectations are clear, whether inaccurate data is corrected during reviews, whether coaching occurs, and whether accountability follows repeated noncompliance"},{"key":"B","text":"Add another meeting"},{"key":"C","text":"Stop reviewing the pipeline"},{"key":"D","text":"Assume the CRM itself is the only problem"}]'::jsonb,
  '["A"]'::jsonb,
  'A review cadence improves behavior only when it drives correction, coaching, and accountability.'
),
(
  18,
  'scenario',
  'scenario',
  'Sales, operations, and project management regularly disagree about which opportunities are truly likely to close and when. What is the BEST cross-functional solution?',
  '[{"key":"A","text":"Use governed CRM data with shared stage criteria, qualification evidence, close-date rules, and a consistent forecast-review process"},{"key":"B","text":"Allow each department to maintain a separate forecast"},{"key":"C","text":"Use the highest forecast from any department"},{"key":"D","text":"Stop sharing opportunity information across departments"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-functional planning improves when teams rely on shared definitions and one governed source of opportunity data.'
),
(
  19,
  'scenario',
  'scenario',
  'A sales team has high activity counts but low conversion, inconsistent qualification, inaccurate stages, and many stale opportunities. What should the sales leader do first?',
  '[{"key":"A","text":"Reestablish the sales-process standards, define required behaviors and stage criteria, clean the pipeline, coach against actual opportunities, and measure conversion improvement"},{"key":"B","text":"Increase the required number of calls"},{"key":"C","text":"Add more CRM fields"},{"key":"D","text":"Stop tracking conversion"}]'::jsonb,
  '["A"]'::jsonb,
  'Broad process breakdown requires restoring disciplined opportunity management rather than increasing activity volume alone.'
),
(
  20,
  'scenario',
  'scenario',
  'Leadership sees poor CRM adoption, unreliable forecasts, inconsistent qualification, stale pipeline, weak follow-up, unclear accountability, and inconsistent sales-management practices. What is the BEST organization-wide strategy?',
  '[{"key":"A","text":"Build a shared sales operating system with CRM standards, qualification criteria, stage definitions, activity expectations, pipeline governance, forecast discipline, coaching, accountability, and measurable sales KPIs"},{"key":"B","text":"Purchase another CRM without changing the process"},{"key":"C","text":"Let each salesperson create an individual workflow"},{"key":"D","text":"Focus only on closed revenue and ignore process behavior"}]'::jsonb,
  '["A"]'::jsonb,
  'Organization-wide CRM and sales-process problems require an integrated management system rather than isolated corrections.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'bfbb442b-d953-4954-a3c4-8da46b50ee96';
  v_l1_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
  v_l2_role_id uuid := '9b66f083-ecfe-4fe7-a1e9-86010326fc7a';
  v_l3_role_id uuid := '8afaef4d-439a-468f-8998-f6abc1413b76';
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
      and c.name = 'CRM / Sales Process'
      and c.is_current = true
  ) then
    raise exception 'Current CRM / Sales Process Master Competency not found';
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
    raise exception 'Current Service Technician L1 CRM / Sales Process requirement not found';
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
    raise exception 'Current Project Manager L2 CRM / Sales Process requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Operations Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Operations Manager L3 CRM / Sales Process requirement not found';
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
    raise exception 'Current Sales Specialist L4 CRM / Sales Process requirement not found';
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
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'CRM / Sales Process — Level 1 Competency Assessment';

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
    select * from _seed_ci_crm_sales_process_l1_questions
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
        'CRM / Sales Process',
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
      'IntegrateU CRM / Sales Process L1 production assessment v1.0.',
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
        'CRM / Sales Process',
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
        'IntegrateU CRM / Sales Process L1 production assessment v1.0.',
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
  v_assessment_name := 'CRM / Sales Process — Level 2 Competency Assessment';

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
    select * from _seed_ci_crm_sales_process_l2_questions
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
        'CRM / Sales Process',
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
      'IntegrateU CRM / Sales Process L2 production assessment v1.0.',
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
        'CRM / Sales Process',
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
        'IntegrateU CRM / Sales Process L2 production assessment v1.0.',
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
  v_role_template_id := v_l3_role_id;
  v_assessment_name := 'CRM / Sales Process — Level 3 Competency Assessment';

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
    select * from _seed_ci_crm_sales_process_l3_questions
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
        'CRM / Sales Process',
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
      'IntegrateU CRM / Sales Process L3 production assessment v1.0.',
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
        'CRM / Sales Process',
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
        'IntegrateU CRM / Sales Process L3 production assessment v1.0.',
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
  v_assessment_name := 'CRM / Sales Process — Level 4 Competency Assessment';

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
    select * from _seed_ci_crm_sales_process_l4_questions
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
        'CRM / Sales Process',
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
      'IntegrateU CRM / Sales Process L4 production assessment v1.0.',
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
        'CRM / Sales Process',
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
        'IntegrateU CRM / Sales Process L4 production assessment v1.0.',
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
   '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 3 Service & Repair        -> 20
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
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
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
  (q.target_level = 2 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid;

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
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
