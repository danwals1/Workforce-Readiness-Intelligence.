create or replace function public.wri_master_competency_assessment_coverage()
returns table (
  master_competency_template_id uuid,
  industry_id uuid,
  competency_name text,
  competency_category text,
  assessment_id uuid,
  assessment_family_id uuid,
  assessment_name text,
  question_count integer,
  answer_key_count integer,
  coverage_status text,
  assessment_ready boolean
)
language sql
security definer
set search_path = public
as $function$

with current_competencies as (
  select
    c.id,
    c.industry_id,
    c.name,
    c.category
  from public.master_competency_templates c
  where c.is_current = true
),

candidate_assessments as (
  select
    c.id as competency_id,
    a.id as assessment_id,
    a.family_id as assessment_family_id,
    a.name as assessment_name,
    a.version,

    row_number() over (
      partition by c.id
      order by
        a.version desc,
        a.name,
        a.id
    ) as assessment_rank

  from current_competencies c

  join public.assessments a
    on a.client_id is null
   and a.is_current = true
   and a.type = 'competency'
   and a.master_competency_template_id = c.id
   and a.industry_id = c.industry_id
),

selected_assessments as (
  select *
  from candidate_assessments
  where assessment_rank = 1
),

question_coverage as (
  select
    sa.competency_id,
    sa.assessment_id,
    count(q.id)::integer as question_count,
    count(k.question_id)::integer as answer_key_count

  from selected_assessments sa

  left join public.assessment_questions q
    on q.assessment_id = sa.assessment_id
   and q.master_competency_template_id =
       sa.competency_id
   and q.source_master_question_id is not null

  left join public.assessment_question_answer_keys k
    on k.question_id = q.id

  group by
    sa.competency_id,
    sa.assessment_id
)

select
  c.id as master_competency_template_id,
  c.industry_id,
  c.name as competency_name,
  c.category as competency_category,

  sa.assessment_id,
  sa.assessment_family_id,
  sa.assessment_name,

  coalesce(qc.question_count, 0)::integer,
  coalesce(qc.answer_key_count, 0)::integer,

  case
    when sa.assessment_id is null
      then 'needs_assessment'
    when coalesce(qc.question_count, 0) = 0
      then 'needs_questions'
    when coalesce(qc.answer_key_count, 0)
       < coalesce(qc.question_count, 0)
      then 'needs_answer_keys'
    else 'ready'
  end as coverage_status,

  (
    sa.assessment_id is not null
    and coalesce(qc.question_count, 0) > 0
    and coalesce(qc.answer_key_count, 0)
        = coalesce(qc.question_count, 0)
  ) as assessment_ready

from current_competencies c

left join selected_assessments sa
  on sa.competency_id = c.id

left join question_coverage qc
  on qc.competency_id = c.id
 and qc.assessment_id = sa.assessment_id

where
  public.wri_is_integrateu_admin()

order by
  c.category nulls last,
  c.name;
$function$;

revoke all
on function public.wri_master_competency_assessment_coverage()
from public;

grant execute
on function public.wri_master_competency_assessment_coverage()
to authenticated;
