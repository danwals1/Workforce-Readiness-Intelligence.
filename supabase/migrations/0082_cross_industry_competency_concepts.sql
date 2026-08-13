-- ============================================================================
-- 0082_cross_industry_competency_concepts.sql
--
-- Adds a cross-industry competency concept layer.
--
-- IMPORTANT:
--   master_competency_templates.family_id remains version lineage.
--   It is NOT reused for cross-industry equivalency.
--
-- A concept represents a broad transferable capability such as:
--   - Job-Site Safety
--   - Construction Drawing Interpretation
--   - Professional Communication
--   - Material Handling
--
-- Industry-specific Master Competencies remain distinct and retain their own:
--   - industry ownership
--   - descriptions
--   - evidence requirements
--   - practical-verification policies
--   - assessments
--   - role requirements
--
-- concept_id expresses conceptual relationship only.
-- It does NOT automatically grant readiness or competency equivalency.
-- ============================================================================


-- ============================================================================
-- 1. MASTER COMPETENCY CONCEPTS
-- ============================================================================

create table if not exists public.master_competency_concepts (

  id uuid
    primary key
    default gen_random_uuid(),

  name text
    not null,

  category text,

  description text,

  is_active boolean
    not null
    default true,

  created_at timestamptz
    not null
    default now(),

  updated_at timestamptz
    not null
    default now(),

  constraint master_competency_concepts_name_check
    check (length(trim(name)) > 0)

);


create unique index if not exists
  master_competency_concepts_name_unique

on public.master_competency_concepts (
  lower(trim(name))
);


-- ============================================================================
-- 2. LINK INDUSTRY-SPECIFIC MASTER COMPETENCIES TO CONCEPTS
-- ============================================================================

alter table public.master_competency_templates

add column if not exists concept_id uuid;


do $$
begin

  if not exists (

    select 1
    from pg_constraint
    where conname =
      'master_competency_templates_concept_id_fkey'

      and conrelid =
        'public.master_competency_templates'::regclass

  ) then

    alter table public.master_competency_templates

    add constraint
      master_competency_templates_concept_id_fkey

    foreign key (concept_id)

    references public.master_competency_concepts(id)

    on delete restrict;

  end if;

end;
$$;


create index if not exists
  master_competency_templates_concept_id_idx

on public.master_competency_templates (
  concept_id
)

where concept_id is not null;


-- ============================================================================
-- 3. RLS
-- ============================================================================

alter table public.master_competency_concepts
enable row level security;


drop policy if exists
  master_competency_concepts_select
on public.master_competency_concepts;


create policy
  master_competency_concepts_select

on public.master_competency_concepts

for select

to public

using (true);


drop policy if exists
  master_competency_concepts_write_admin
on public.master_competency_concepts;


create policy
  master_competency_concepts_write_admin

on public.master_competency_concepts

for all

to public

using (
  public.wri_is_integrateu_admin()
)

with check (
  public.wri_is_integrateu_admin()
);


-- ============================================================================
-- 4. UPDATED_AT
--
-- Reuse an existing generic updated_at trigger if the project has one.
-- If not, create a table-specific trigger function.
-- ============================================================================

create or replace function
public.wri_touch_master_competency_concept_updated_at()
returns trigger
language plpgsql
set search_path = public
as $function$
begin

  new.updated_at := now();

  return new;

end;
$function$;


drop trigger if exists
  trg_wri_touch_master_competency_concept_updated_at
on public.master_competency_concepts;


create trigger
  trg_wri_touch_master_competency_concept_updated_at

before update
on public.master_competency_concepts

for each row

execute function
  public.wri_touch_master_competency_concept_updated_at();


-- ============================================================================
-- 5. COMMENTARY / SEMANTICS
-- ============================================================================

comment on table public.master_competency_concepts is
'Cross-industry conceptual grouping for related Master Competencies. Concepts do not by themselves grant readiness, evidence equivalency, or transfer credit.';


comment on column
public.master_competency_templates.concept_id is
'Optional cross-industry concept association. family_id remains competency version lineage. concept_id does not imply automatic equivalency between industry-specific competencies.';


-- ============================================================================
-- 6. VERIFICATION
-- ============================================================================

select
  column_name,
  data_type,
  is_nullable
from information_schema.columns
where table_schema = 'public'
  and table_name = 'master_competency_templates'
  and column_name = 'concept_id';


select
  c.relname as table_name,
  c.relrowsecurity as rls_enabled,
  c.relforcerowsecurity as rls_forced
from pg_class c
join pg_namespace n
  on n.oid = c.relnamespace
where n.nspname = 'public'
  and c.relname = 'master_competency_concepts';


select
  policyname,
  cmd
from pg_policies
where schemaname = 'public'
  and tablename = 'master_competency_concepts'
order by policyname;
