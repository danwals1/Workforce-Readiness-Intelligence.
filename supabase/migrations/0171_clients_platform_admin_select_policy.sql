-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0171_clients_platform_admin_select_policy.sql
--
-- PURPOSE
-- Allows active IntegrateU platform administrators to read all clients while
-- preserving tenant-scoped client access for other authenticated users.
-- ============================================================================

drop policy if exists
  "authenticated users can read clients they belong to"
on public.clients;

drop policy if exists
  "authenticated users can read authorized clients"
on public.clients;

create policy
  "authenticated users can read authorized clients"
on public.clients
for select
to authenticated
using (
  public.wri_is_integrateu_admin()

  or exists (
    select 1
    from public.user_client_roles ucr
    where ucr.client_id = clients.id
      and ucr.user_id = auth.uid()
      and lower(ucr.status) = 'active'
  )
);
