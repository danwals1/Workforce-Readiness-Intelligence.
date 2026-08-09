-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0008_assessment_readiness_integration.sql
--
-- PURPOSE
-- Adds the readiness layer for direct IntegrateU master assessments.
--
-- IMPORTANT
-- This migration DOES NOT modify or replace the legacy role_readiness table.
--
-- NEW MODEL
--
--   Knowledge readiness
--     = assessment estimated_level >= required_level
--
--   Practical readiness
--     = when practical verification is required, employee must also have
--       a verified practical rating >= required_level
--
--   Competency readiness
--     = knowledge_ready AND practical_ready
--
--   Role readiness %
--     = fully ready competencies / total required competencies
--
--   Safety gate
--     = critical-safety question performance remains a separate requirement
--
-- This migration is additive.
-- ============================================================================


-- ============================================================================
-- PART 1 — MASTER-COMPETENCY PRACTICAL VERIFICATION
--
-- Existing practical_skill_ratings is company-competency based.
-- Direct IntegrateU master assessments need a master-template equivalent.
-- ============================================================================

create table if not exists master_practical_verifications (

  id uuid primary key default gen_random_uuid(),

  client_id uuid not null
    references clients(id),

  employee_id uuid not null
    references employees(id)
    on delete cascade,

  master_competency_template_id uuid not null
    references master_competency_templates(id),

  rating_level int not null
    check (rating_level between 1 and 4),

  status text not null default 'verified'
    check (
      status in (
        'pending',
        'verified',
        'rejected'
      )
    ),

  verified_by uuid,

  verified_at timestamptz,

  notes text,

  created_at timestamptz not null default now(),

  updated_at timestamptz not null default now()

);


drop trigger if exists trg_master_practical_sync_client
on master_practical_verifications;


create trigger trg_master_practical_sync_client

before insert or update
on master_practical_verifications

for each row

execute function wri_sync_client_from_employee();


drop trigger if exists trg_master_practical_updated_at
on master_practical_verifications;


create trigger trg_master_practical_updated_at

before update
on master_practical_verifications

for each row

execute function wri_set_updated_at();


create index if not exists ix_master_practical_employee
on master_practical_verifications(employee_id);


create index if not exists ix_master_practical_competency
on master_practical_verifications(
  master_competency_template_id
);


create index if not exists ix_master_practical_employee_competency
on master_practical_verifications(
  employee_id,
  master_competency_template_id
);


alter table master_practical_verifications
enable row level security;



-- --------------------------------------------------------------------------
-- Employees may read their own verification records.
-- Client admins and IntegrateU admins may read permitted records.
-- --------------------------------------------------------------------------

drop policy if exists master_practical_select
on master_practical_verifications;


create policy master_practical_select

on master_practical_verifications

for select

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

  or exists (

    select 1

    from employees e

    where e.id =
      master_practical_verifications.employee_id

      and e.auth_user_id = auth.uid()

  )

);



-- --------------------------------------------------------------------------
-- Only admins may create/update practical verification.
-- Employees cannot self-verify.
-- --------------------------------------------------------------------------

drop policy if exists master_practical_write
on master_practical_verifications;


create policy master_practical_write

on master_practical_verifications

for all

using (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

)

with check (

  wri_is_integrateu_admin()

  or client_id in (
    select wri_allowed_client_ids()
  )

);



-- ============================================================================
-- PART 2 — RPC TO RECORD PRACTICAL VERIFICATION
-- ============================================================================

create or replace function wri_record_master_practical_verification(

  p_employee_id uuid,

  p_master_competency_template_id uuid,

  p_rating_level int,

  p_status text default 'verified',

  p_notes text default null

)

returns uuid

language plpgsql

security definer

set search_path = public

as $$

declare

  v_employee employees;

  v_id uuid;

begin


  -- --------------------------------------------------------------------------
  -- Validate employee
  -- --------------------------------------------------------------------------

  select *
  into v_employee

  from employees

  where id = p_employee_id;


  if v_employee is null then

    raise exception
      'employee % not found',
      p_employee_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Authorization
  -- --------------------------------------------------------------------------

  if not (

    wri_is_integrateu_admin()

    or v_employee.client_id in (
      select wri_allowed_client_ids()
    )

  ) then

    raise exception
      'not authorized to verify practical competency for employee %',
      p_employee_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Validate rating
  -- --------------------------------------------------------------------------

  if p_rating_level < 1
     or p_rating_level > 4 then

    raise exception
      'rating level must be between 1 and 4';

  end if;



  if p_status not in (
    'pending',
    'verified',
    'rejected'
  ) then

    raise exception
      'invalid practical verification status: %',
      p_status;

  end if;



  -- --------------------------------------------------------------------------
  -- Validate master competency
  -- --------------------------------------------------------------------------

  if not exists (

    select 1

    from master_competency_templates

    where id =
      p_master_competency_template_id

  ) then

    raise exception
      'master competency template % not found',
      p_master_competency_template_id;

  end if;



  -- --------------------------------------------------------------------------
  -- Insert verification history record.
  --
  -- History is intentional. The readiness view always uses the newest
  -- verification record for each employee + competency.
  -- --------------------------------------------------------------------------

  insert into master_practical_verifications (

    client_id,

    employee_id,

    master_competency_template_id,

    rating_level,

    status,

    verified_by,

    verified_at,

    notes

  )

  values (

    v_employee.client_id,

    p_employee_id,

    p_master_competency_template_id,

    p_rating_level,

    p_status,

    auth.uid(),

    case
      when p_status = 'verified'
      then now()
      else null
    end,

    p_notes

  )

  returning id
  into v_id;


  return v_id;


end;
$$;


revoke all
on function wri_record_master_practical_verification(
  uuid,
  uuid,
  int,
  text,
  text
)
from public, anon;


grant execute
on function wri_record_master_practical_verification(
  uuid,
  uuid,
  int,
  text,
  text
)
to authenticated;



-- ============================================================================
-- PART 3 — LATEST COMPLETED MASTER-ASSESSMENT ATTEMPT
--
-- One row per employee + assessment.
-- ============================================================================

create or replace view v_latest_master_assessment_attempt

with (
  security_invoker = true
)

as

select distinct on (

  aa.employee_id,
  aa.assessment_id

)

  aa.id as attempt_id,

  aa.client_id,

  aa.employee_id,

  aa.assessment_id,

  aa.started_at,

  aa.completed_at,

  a.name as assessment_name,

  a.master_role_template_id,

  a.master_target_role_template_id,

  coalesce(

    a.master_target_role_template_id,

    a.master_role_template_id

  ) as effective_master_role_template_id


from assessment_attempts aa


join assessments a
  on a.id = aa.assessment_id


where aa.status = 'completed'

  and a.client_id is null


order by

  aa.employee_id,

  aa.assessment_id,

  aa.completed_at desc nulls last,

  aa.created_at desc;



-- ============================================================================
-- PART 4 — LATEST PRACTICAL VERIFICATION PER EMPLOYEE + COMPETENCY
-- ============================================================================

create or replace view v_latest_master_practical_verification

with (
  security_invoker = true
)

as

select distinct on (

  employee_id,

  master_competency_template_id

)

  id,

  client_id,

  employee_id,

  master_competency_template_id,

  rating_level,

  status,

  verified_by,

  verified_at,

  notes,

  created_at


from master_practical_verifications


order by

  employee_id,

  master_competency_template_id,

  coalesce(
    verified_at,
    created_at
  ) desc,

  created_at desc;



-- ============================================================================
-- PART 5 — ASSESSMENT COMPETENCY READINESS
--
-- One row per competency scored on the employee's latest completed
-- master assessment.
-- ============================================================================

create or replace view v_assessment_competency_readiness

with (
  security_invoker = true
)

as

with latest_attempts as (

  select *

  from v_latest_master_assessment_attempt

),

practical_requirements as (

  select

    aq.assessment_id,

    aq.master_competency_template_id,

    bool_or(
      aq.practical_verification_required
    ) as practical_verification_required


  from assessment_questions aq


  where aq.master_competency_template_id
    is not null


  group by

    aq.assessment_id,

    aq.master_competency_template_id

)

select

  la.attempt_id,

  la.client_id,

  la.employee_id,

  la.assessment_id,

  la.assessment_name,

  la.effective_master_role_template_id
    as master_role_template_id,


  cs.master_competency_template_id,


  mct.name as competency_name,

  mct.category as competency_category,

  mct.is_critical as competency_is_critical,


  cs.score_percent as knowledge_score_percent,

  cs.estimated_level as knowledge_level,

  cs.required_level,


  case

    when cs.required_level is null
      then false

    when cs.estimated_level >=
         cs.required_level
      then true

    else false

  end as knowledge_ready,


  coalesce(
    pr.practical_verification_required,
    false
  ) as practical_verification_required,


  pv.rating_level
    as practical_rating_level,

  pv.status
    as practical_verification_status,

  pv.verified_at
    as practical_verified_at,


  case

    when coalesce(
      pr.practical_verification_required,
      false
    ) = false

      then true


    when pv.status = 'verified'

      and pv.rating_level >=
          cs.required_level

      then true


    else false

  end as practical_ready,


  case

    when cs.required_level is null
      then false


    when cs.estimated_level <
         cs.required_level
      then false


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and not (

        pv.status = 'verified'

        and pv.rating_level >=
            cs.required_level

      )

      then false


    else true

  end as competency_ready,


  case

    when cs.required_level is null
      then 'not_required'


    when cs.estimated_level <
         cs.required_level - 1
      then 'critical_gap'


    when cs.estimated_level <
         cs.required_level
      then 'developing'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and pv.status is null
      then 'practical_verification_needed'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and pv.status <> 'verified'
      then 'practical_verification_needed'


    when coalesce(
      pr.practical_verification_required,
      false
    ) = true

      and pv.rating_level <
          cs.required_level
      then 'practical_development_needed'


    else 'ready'

  end as readiness_status


from latest_attempts la


join competency_scores cs

  on cs.attempt_id =
     la.attempt_id

 and cs.master_competency_template_id
     is not null


join master_competency_templates mct

  on mct.id =
     cs.master_competency_template_id


left join practical_requirements pr

  on pr.assessment_id =
     la.assessment_id

 and pr.master_competency_template_id =
     cs.master_competency_template_id


left join v_latest_master_practical_verification pv

  on pv.employee_id =
     la.employee_id

 and pv.master_competency_template_id =
     cs.master_competency_template_id;



-- ============================================================================
-- PART 6 — CRITICAL SAFETY PERFORMANCE
--
-- Calculates safety performance directly from the questions actually
-- selected for the employee's latest assessment attempt.
-- ============================================================================

create or replace view v_assessment_safety_readiness

with (
  security_invoker = true
)

as

select

  la.attempt_id,

  la.client_id,

  la.employee_id,

  la.assessment_id,


  count(*)
    filter (
      where aq.critical_safety = true
    ) as critical_safety_questions,


  count(*)
    filter (
      where aq.critical_safety = true
        and aa.is_correct = true
    ) as critical_safety_correct,


  case

    when count(*)
      filter (
        where aq.critical_safety = true
      ) = 0

      then null


    else round(

      100.0

      * count(*)
          filter (
            where aq.critical_safety = true
              and aa.is_correct = true
          )

      / count(*)
          filter (
            where aq.critical_safety = true
          ),

      1

    )

  end as critical_safety_score_percent


from v_latest_master_assessment_attempt la


join attempt_question_selections aqs

  on aqs.attempt_id =
     la.attempt_id


join assessment_questions aq

  on aq.id =
     aqs.question_id


join attempt_answers aa

  on aa.attempt_id =
     la.attempt_id

 and aa.question_id =
     aq.id


group by

  la.attempt_id,

  la.client_id,

  la.employee_id,

  la.assessment_id;



-- ============================================================================
-- PART 7 — ROLE / ASSESSMENT READINESS SUMMARY
--
-- This is the NEW source for the assessment-focused dashboard.
--
-- It does NOT use the legacy role_readiness table.
-- ============================================================================

create or replace view v_assessment_role_readiness

with (
  security_invoker = true
)

as

with competency_summary as (

  select

    attempt_id,

    client_id,

    employee_id,

    assessment_id,

    assessment_name,

    master_role_template_id,


    count(*)
      filter (
        where required_level is not null
      ) as competencies_total,


    count(*)
      filter (
        where required_level is not null
          and competency_ready = true
      ) as competencies_ready,


    count(*)
      filter (
        where readiness_status =
          'developing'
      ) as developing_count,


    count(*)
      filter (
        where readiness_status =
          'critical_gap'
      ) as critical_gap_count,


    count(*)
      filter (
        where readiness_status in (
          'practical_verification_needed',
          'practical_development_needed'
        )
      ) as practical_gap_count,


    round(

      avg(knowledge_score_percent),

      1

    ) as average_knowledge_score


  from v_assessment_competency_readiness


  group by

    attempt_id,

    client_id,

    employee_id,

    assessment_id,

    assessment_name,

    master_role_template_id

)

select

  cs.attempt_id,

  cs.client_id,

  cs.employee_id,

  cs.assessment_id,

  cs.assessment_name,

  cs.master_role_template_id,


  mrt.name as role_name,


  cs.average_knowledge_score,


  sr.critical_safety_score_percent,


  cs.competencies_ready,

  cs.competencies_total,


  case

    when cs.competencies_total = 0
      then 0


    else round(

      100.0

      * cs.competencies_ready

      / cs.competencies_total,

      1

    )

  end as readiness_percent,


  cs.developing_count,

  cs.critical_gap_count,

  cs.practical_gap_count,


  case

    when sr.critical_safety_score_percent
         is not null

      and sr.critical_safety_score_percent
          < 80

      then 'safety_gap'


    when cs.competencies_total > 0

      and cs.competencies_ready =
          cs.competencies_total

      then 'ready'


    when cs.critical_gap_count > 0
      then 'critical_gap'


    when cs.practical_gap_count > 0
      then 'practical_verification_needed'


    else 'developing'

  end as readiness_status


from competency_summary cs


join master_role_templates mrt

  on mrt.id =
     cs.master_role_template_id


left join v_assessment_safety_readiness sr

  on sr.attempt_id =
     cs.attempt_id;



-- ============================================================================
-- PART 8 — EMPLOYEE ASSESSMENT SUMMARY
--
-- Convenient dashboard-facing view.
-- ============================================================================

create or replace view v_employee_assessment_summary

with (
  security_invoker = true
)

as

select

  arr.attempt_id,

  arr.client_id,

  arr.employee_id,

  e.first_name,

  e.last_name,

  e.employee_number,

  arr.assessment_id,

  arr.assessment_name,

  arr.master_role_template_id,

  arr.role_name,

  arr.average_knowledge_score,

  arr.critical_safety_score_percent,

  arr.competencies_ready,

  arr.competencies_total,

  arr.readiness_percent,

  arr.developing_count,

  arr.critical_gap_count,

  arr.practical_gap_count,

  arr.readiness_status,


  aa.completed_at


from v_assessment_role_readiness arr


join employees e

  on e.id =
     arr.employee_id


join assessment_attempts aa

  on aa.id =
     arr.attempt_id;



-- ============================================================================
-- PART 9 — VERIFICATION
--
-- After installation, Alex's completed Technician I assessment should appear.
-- The readiness result may be lower than the knowledge score because many
-- Technician I competencies require practical verification.
-- ============================================================================

select

  employee_id,

  first_name,

  last_name,

  assessment_name,

  role_name,

  average_knowledge_score,

  critical_safety_score_percent,

  competencies_ready,

  competencies_total,

  readiness_percent,

  developing_count,

  critical_gap_count,

  practical_gap_count,

  readiness_status

from v_employee_assessment_summary

order by completed_at desc;