-- ============================================================================
-- 0054_role_comparison_options.sql
--
-- Provides the authorized role list used by Workforce Readiness
-- for on-demand role comparison.
--
-- This does NOT assign an employee to a target role.
-- It only exposes current active master roles as comparison options.
-- ============================================================================

create or replace function public.wri_list_role_comparison_options()
returns table (
  master_role_template_id uuid,
  role_name text,
  department text,
  competency_count bigint
)
language sql
stable
security definer
set search_path = public
as $function$

  select
    mrt.id
      as master_role_template_id,

    mrt.name
      as role_name,

    mrt.department,

    count(
      mrcr.master_competency_template_id
    )
      as competency_count

  from public.master_role_templates mrt

  left join
    public.master_role_competency_requirements mrcr

    on mrcr.master_role_template_id =
       mrt.id

  where
    mrt.is_current = true

    and mrt.status = 'active'

    and (
      public.wri_is_integrateu_admin()

      or exists (
        select 1
        from public.wri_allowed_client_ids()
      )
    )

  group by
    mrt.id,
    mrt.name,
    mrt.department

  order by
    mrt.department nulls last,
    mrt.name;

$function$;


revoke all
on function public.wri_list_role_comparison_options()
from public, anon;


grant execute
on function public.wri_list_role_comparison_options()
to authenticated;


comment on function
  public.wri_list_role_comparison_options()
is
'Lists current active master roles available for readiness comparison. Does not create or modify employee target-role assignments.';
