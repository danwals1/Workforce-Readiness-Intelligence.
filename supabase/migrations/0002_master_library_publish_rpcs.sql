-- ============================================================================
-- Index fix: Revision 4 created ix_mrt_current / ix_mct_current /
-- ix_assessments_current as plain (non-unique) partial indexes — they
-- helped query performance but enforced nothing. Replacing them with
-- unique partial indexes so at most one row per family can ever have
-- is_current = true, at the database level, independent of the FOR UPDATE
-- locking in the RPCs below (belt-and-suspenders: the lock prevents two
-- concurrent publishes from racing; this index prevents any code path —
-- RPC, manual fix, future admin tool — from ever leaving two rows in the
-- same family both marked current).
-- ============================================================================

drop index if exists ix_mrt_current;
create unique index ix_mrt_current on master_role_templates (family_id) where is_current;

drop index if exists ix_mct_current;
create unique index ix_mct_current on master_competency_templates (family_id) where is_current;

drop index if exists ix_assessments_current;
create unique index ix_assessments_current on assessments (family_id) where is_current;


-- ============================================================================
-- Workforce Readiness Intelligence — Revision 5
-- Transactional "publish new version" RPCs for the Master Library.
-- Builds on Revision 4 (already live). Creates NO new tables — only three
-- functions. Does not alter any existing table, row, or app behavior.
--
-- Each function:
--   - enforces INTEGRATEU_ADMIN authorization internally (SECURITY DEFINER,
--     so the check inside the function is the real gate, same pattern as
--     wri_score_attempt() from Revision 3/4 — not just the grant).
--   - locks the source row with SELECT ... FOR UPDATE before checking
--     is_current or inserting the new version, so two simultaneous publish
--     calls on the same family can't both read the same "current" row and
--     both try to create the same next version — the second call blocks
--     until the first commits (moving is_current to false), then re-reads
--     and correctly rejects itself as "not the current version."
--   - only accepts the CURRENT version's id (is_current = true); publishing
--     from a superseded row is rejected, since "publish a new version" only
--     makes sense from the tip of a family.
--   - runs as one atomic function body: a plpgsql function already runs in
--     an implicit transaction, so any `raise exception` anywhere inside —
--     including a failed insert/update partway through — rolls back
--     everything the function did, leaving no partial version behind.
--   - flips the old row's is_current to false FIRST, then inserts the new
--     row, then (once the new id exists) sets the old row's superseded_by
--     — this order never collides with the unique (family_id) where
--     is_current index. If any step fails — the insert, a requirement/
--     question copy, anything — the whole function is one transaction, so
--     even that first is_current flip rolls back with it.
--   - inserts a brand-new row (same family_id, version + 1, is_current =
--     true) and otherwise never touches the old row's content columns —
--     only is_current/superseded_by/updated_at — so anything a company has
--     already adopted is untouched.
--   - returns the new row's id and version.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Publish a new master_role_template version.
--    Duplicates master_role_competency_requirements onto the new version —
--    those rows key off the role_template_id that just changed, so they
--    must move forward with it. (Publishing a COMPETENCY template alone
--    does NOT retroactively touch any role's requirement rows — see the
--    competency function below — a role's requirements only pick up a new
--    competency version if an admin explicitly updates that role.)
-- ----------------------------------------------------------------------------
create or replace function wri_publish_role_template_version(p_role_template_id uuid)
returns table(new_id uuid, new_version int)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_old master_role_templates;
  v_new_id uuid;
  v_new_version int;
begin
  if not wri_is_integrateu_admin() then
    raise exception 'not authorized to publish a role template version';
  end if;

  select * into v_old from master_role_templates where id = p_role_template_id for update;
  if v_old is null then
    raise exception 'master_role_template % not found', p_role_template_id;
  end if;
  if not v_old.is_current then
    raise exception 'master_role_template % is not the current version; publish from the current version only', p_role_template_id;
  end if;

  v_new_version := v_old.version + 1;

  -- Flip the old row's is_current FIRST (superseded_by comes after we have
  -- the new id) so the insert below never collides with it under the
  -- unique (family_id) where is_current index. If anything from here on
  -- fails, this update rolls back with it — the function is one transaction.
  update master_role_templates
  set is_current = false, updated_at = now()
  where id = p_role_template_id;

  insert into master_role_templates (
    family_id, version, is_current, published_by,
    industry_id, name, department, purpose, description, level_scale_max, status
  ) values (
    v_old.family_id, v_new_version, true, auth.uid(),
    v_old.industry_id, v_old.name, v_old.department, v_old.purpose, v_old.description, v_old.level_scale_max, v_old.status
  )
  returning id into v_new_id;

  insert into master_role_competency_requirements (master_role_template_id, master_competency_template_id, required_level)
  select v_new_id, master_competency_template_id, required_level
  from master_role_competency_requirements
  where master_role_template_id = p_role_template_id;

  update master_role_templates
  set superseded_by = v_new_id, updated_at = now()
  where id = p_role_template_id;

  return query select v_new_id, v_new_version;
end;
$$;
revoke all on function wri_publish_role_template_version(uuid) from public, anon;
grant execute on function wri_publish_role_template_version(uuid) to authenticated;


-- ----------------------------------------------------------------------------
-- 2. Publish a new master_competency_template version.
--    No requirement-row duplication: role requirement rows are keyed to a
--    specific competency template VERSION on purpose — a role doesn't
--    silently inherit a newer competency definition just because IntegrateU
--    published one. An admin updates a role's requirements explicitly (via
--    master_role_competency_requirements) if/when they want it to.
-- ----------------------------------------------------------------------------
create or replace function wri_publish_competency_template_version(p_competency_template_id uuid)
returns table(new_id uuid, new_version int)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_old master_competency_templates;
  v_new_id uuid;
  v_new_version int;
begin
  if not wri_is_integrateu_admin() then
    raise exception 'not authorized to publish a competency template version';
  end if;

  select * into v_old from master_competency_templates where id = p_competency_template_id for update;
  if v_old is null then
    raise exception 'master_competency_template % not found', p_competency_template_id;
  end if;
  if not v_old.is_current then
    raise exception 'master_competency_template % is not the current version; publish from the current version only', p_competency_template_id;
  end if;

  v_new_version := v_old.version + 1;

  update master_competency_templates
  set is_current = false, updated_at = now()
  where id = p_competency_template_id;

  insert into master_competency_templates (
    family_id, version, is_current, published_by,
    industry_id, name, category, is_critical, verifier_type,
    evidence_requirements, reverification_period_months, description, status
  ) values (
    v_old.family_id, v_new_version, true, auth.uid(),
    v_old.industry_id, v_old.name, v_old.category, v_old.is_critical, v_old.verifier_type,
    v_old.evidence_requirements, v_old.reverification_period_months, v_old.description, v_old.status
  )
  returning id into v_new_id;

  update master_competency_templates
  set superseded_by = v_new_id, updated_at = now()
  where id = p_competency_template_id;

  return query select v_new_id, v_new_version;
end;
$$;
revoke all on function wri_publish_competency_template_version(uuid) from public, anon;
grant execute on function wri_publish_competency_template_version(uuid) to authenticated;


-- ----------------------------------------------------------------------------
-- 3. Publish a new assessment version (template-mode assessments only —
--    client_id must be null; a company's own adopted assessment is never
--    published this way). Duplicates every assessment_question onto the
--    new assessment, and each question's answer key onto its new question
--    row, so the new version is a fully independent, immediately usable
--    copy — never a live reference to the old version's questions.
-- ----------------------------------------------------------------------------
create or replace function wri_publish_assessment_version(p_assessment_id uuid)
returns table(new_id uuid, new_version int)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_old assessments;
  v_new_id uuid;
  v_new_version int;
  v_old_question record;
  v_new_question_id uuid;
begin
  if not wri_is_integrateu_admin() then
    raise exception 'not authorized to publish an assessment version';
  end if;

  select * into v_old from assessments where id = p_assessment_id for update;
  if v_old is null then
    raise exception 'assessment % not found', p_assessment_id;
  end if;
  if v_old.client_id is not null then
    raise exception 'assessment % is a company-adopted assessment, not a template; publish the template it came from instead', p_assessment_id;
  end if;
  if not v_old.is_current then
    raise exception 'assessment % is not the current version; publish from the current version only', p_assessment_id;
  end if;

  v_new_version := v_old.version + 1;

  update assessments
  set is_current = false, updated_at = now()
  where id = p_assessment_id;

  insert into assessments (
    family_id, version, is_current, published_by,
    industry_id, name, type,
    master_role_template_id, master_target_role_template_id, master_competency_template_id
  ) values (
    v_old.family_id, v_new_version, true, auth.uid(),
    v_old.industry_id, v_old.name, v_old.type,
    v_old.master_role_template_id, v_old.master_target_role_template_id, v_old.master_competency_template_id
  )
  returning id into v_new_id;

  for v_old_question in
    select * from assessment_questions where assessment_id = p_assessment_id
  loop
    insert into assessment_questions (
      assessment_id, master_competency_template_id, competency_id,
      type, prompt, scenario, image_url, options, points, sort_order
    ) values (
      v_new_id, v_old_question.master_competency_template_id, v_old_question.competency_id,
      v_old_question.type, v_old_question.prompt, v_old_question.scenario, v_old_question.image_url,
      v_old_question.options, v_old_question.points, v_old_question.sort_order
    )
    returning id into v_new_question_id;

    insert into assessment_question_answer_keys (question_id, correct_answer, scoring_notes)
    select v_new_question_id, k.correct_answer, k.scoring_notes
    from assessment_question_answer_keys k
    where k.question_id = v_old_question.id;
  end loop;

  update assessments
  set superseded_by = v_new_id, updated_at = now()
  where id = p_assessment_id;

  return query select v_new_id, v_new_version;
end;
$$;
revoke all on function wri_publish_assessment_version(uuid) from public, anon;
grant execute on function wri_publish_assessment_version(uuid) to authenticated;

-- ============================================================================
-- End of Revision 5. No tables created, altered, or dropped.
-- ============================================================================
