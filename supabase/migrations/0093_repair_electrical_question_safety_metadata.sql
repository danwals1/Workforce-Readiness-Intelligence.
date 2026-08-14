-- 0093_repair_electrical_question_safety_metadata.sql
--
-- Correct inherited question metadata for non-critical Electrical competencies.
--
-- Electrical Theory & Circuits and Electrical Testing & Measurement were
-- seeded from the Electrical Safety production-bank structure and inherited
-- critical_safety = true. Both competency templates are non-critical.
--
-- This migration repairs both the canonical Master Question Bank rows and
-- their current production assessment snapshots.

begin;

do $$
declare
  v_theory_competency_id uuid :=
    '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid;

  v_testing_competency_id uuid :=
    'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid;

  v_master_question_count integer;
  v_assessment_question_count integer;
begin
  -- Guard against changing the semantics of a competency that has since
  -- intentionally been designated critical.
  if not exists (
    select 1
    from public.master_competency_templates mct
    where mct.id = v_theory_competency_id
      and mct.is_current = true
      and mct.name = 'Electrical Theory & Circuits'
      and coalesce(mct.is_critical, false) = false
  ) then
    raise exception
      'Current non-critical Electrical Theory & Circuits competency not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates mct
    where mct.id = v_testing_competency_id
      and mct.is_current = true
      and mct.name = 'Electrical Testing & Measurement'
      and coalesce(mct.is_critical, false) = false
  ) then
    raise exception
      'Current non-critical Electrical Testing & Measurement competency not found';
  end if;

  -- Repair canonical Master Question Bank metadata.
  update public.master_question_bank q
  set
    critical_safety = false,
    practical_verification_required = false
  where q.is_current = true
    and q.master_competency_template_id in (
      v_theory_competency_id,
      v_testing_competency_id
    );

  get diagnostics v_master_question_count = row_count;

  if v_master_question_count <> 80 then
    raise exception
      'Expected to repair 80 current Master Questions; repaired %',
      v_master_question_count;
  end if;

  -- Repair current global production assessment snapshots for the same
  -- source-linked Master Questions.
  update public.assessment_questions aq
  set
    critical_safety = false,
    practical_verification_required = false
  from public.assessments a
  where a.id = aq.assessment_id
    and a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id in (
      v_theory_competency_id,
      v_testing_competency_id
    )
    and a.target_level in (2, 3)
    and aq.master_competency_template_id =
      a.master_competency_template_id
    and aq.source_master_question_id is not null;

  get diagnostics v_assessment_question_count = row_count;

  if v_assessment_question_count <> 80 then
    raise exception
      'Expected to repair 80 current assessment question snapshots; repaired %',
      v_assessment_question_count;
  end if;
end
$$;

commit;


-- Verification: Master Question Bank.
select
  mct.name as competency_name,
  count(*) as master_question_count,
  count(*) filter (
    where q.critical_safety
  ) as critical_safety_count,
  count(*) filter (
    where q.practical_verification_required
  ) as practical_verification_required_count
from public.master_question_bank q
join public.master_competency_templates mct
  on mct.id = q.master_competency_template_id
where q.is_current = true
  and q.master_competency_template_id in (
    '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid,
    'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
  )
group by mct.name
order by mct.name;


-- Verification: current production assessment snapshots.
select
  mct.name as competency_name,
  a.target_level,
  count(*) as question_count,
  count(*) filter (
    where aq.critical_safety
  ) as critical_safety_count,
  count(*) filter (
    where aq.practical_verification_required
  ) as practical_verification_required_count
from public.assessments a
join public.assessment_questions aq
  on aq.assessment_id = a.id
join public.master_competency_templates mct
  on mct.id = a.master_competency_template_id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id in (
    '931db240-5673-4c25-adb9-911b1c7b39ea'::uuid,
    'a4e8adcb-107f-4280-a770-2f80966f0b1b'::uuid
  )
  and a.target_level in (2, 3)
group by mct.name, a.target_level
order by mct.name, a.target_level;
