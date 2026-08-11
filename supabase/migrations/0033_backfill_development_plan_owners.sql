-- ============================================================================
-- 0033 — BACKFILL DEVELOPMENT PLAN OWNERS
-- ============================================================================
-- Historical development plans created before owner assignment was introduced
-- may have a null owner_user_id.
--
-- Use the creating user as the initial owner when one is available.
-- This migration is idempotent because it only updates unassigned plans.
-- ============================================================================

update public.development_plans
set owner_user_id = created_by_user_id
where owner_user_id is null
  and created_by_user_id is not null;
