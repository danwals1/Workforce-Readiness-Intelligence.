import { supabase } from "@/lib/supabase";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export type Industry = {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  is_active: boolean;
};

export type MasterRoleTemplate = {
  id: string;
  family_id: string;
  version: number;
  is_current: boolean;
  superseded_by: string | null;
  published_at: string;
  industry_id: string;
  name: string;
  department: string | null;
  purpose: string | null;
  description: string | null;
  level_scale_max: number;
  status: string;
};

export type MasterCompetencyTemplate = {
  id: string;
  family_id: string;
  version: number;
  is_current: boolean;
  superseded_by: string | null;
  published_at: string;
  industry_id: string;
  name: string;
  category: string | null;
  is_critical: boolean;
  verifier_type: string | null;
  evidence_requirements: string | null;
  reverification_period_months: number | null;
  description: string | null;
  status: string;
};

export type MasterRoleCompetencyRequirement = {
  id: string;
  master_role_template_id: string;
  master_competency_template_id: string;
  required_level: number;
  master_competency_templates?: { name: string } | null;
};

export type AssessmentType = "initial" | "competency" | "role_qualification";

export type Assessment = {
  id: string;
  family_id: string;
  version: number;
  is_current: boolean;
  superseded_by: string | null;
  published_at: string;
  industry_id: string;
  name: string;
  type: AssessmentType;
  master_role_template_id: string | null;
  master_target_role_template_id: string | null;
  master_competency_template_id: string | null;
};

export type AssessmentQuestionType =
  | "multiple_choice"
  | "multiple_select"
  | "scenario"
  | "image_based"
  | "troubleshooting"
  | "situational_judgment";

export type AssessmentQuestion = {
  id: string;
  assessment_id: string;
  master_competency_template_id: string | null;
  competency_id: string | null;
  type: AssessmentQuestionType;
  prompt: string;
  scenario: string | null;
  image_url: string | null;
  options: { id: string; label: string }[] | null;
  points: number;
  sort_order: number;
};

export type AnswerKey = {
  id: string;
  question_id: string;
  correct_answer: string | string[];
  scoring_notes: string | null;
};

export type MasterCompetencyAssessmentCoverage = {
  master_competency_template_id: string;
  industry_id: string;
  competency_name: string;
  competency_category: string | null;

  assessment_id: string | null;
  assessment_family_id: string | null;
  assessment_name: string | null;

  question_count: number;
  answer_key_count: number;

  coverage_status:
    | "ready"
    | "needs_questions"
    | "needs_answer_keys"
    | "needs_assessment";

  assessment_ready: boolean;
};

export type AdoptionStatusRow = {
  id: string;
  client_id: string;
  entity_type: "role" | "competency" | "assessment";
  source_family_id: string;
  source_version: number;
  adopted_row_id: string;
  adopted_at: string;
  current_published_version: number | null;
  newer_version_available: boolean | null;
  clients?: { name?: string } | null;
};

// ---------------------------------------------------------------------------
// Industries
// ---------------------------------------------------------------------------

export async function listIndustries(): Promise<Industry[]> {
  const { data, error } = await supabase.from("industries").select("*").order("name");
  if (error) throw error;
  return data as Industry[];
}

export async function createIndustry(input: {
  name: string;
  slug: string;
  description?: string;
}): Promise<Industry> {
  const { data, error } = await supabase.from("industries").insert(input).select().single();
  if (error) throw error;
  return data as Industry;
}

// ---------------------------------------------------------------------------
// Master role templates
// ---------------------------------------------------------------------------

export async function listCurrentRoleTemplates(): Promise<MasterRoleTemplate[]> {
  const { data, error } = await supabase
    .from("master_role_templates")
    .select("*")
    .eq("is_current", true)
    .order("name");
  if (error) throw error;
  return data as MasterRoleTemplate[];
}

export async function getRoleTemplateFamily(familyId: string): Promise<MasterRoleTemplate[]> {
  const { data, error } = await supabase
    .from("master_role_templates")
    .select("*")
    .eq("family_id", familyId)
    .order("version", { ascending: false });
  if (error) throw error;
  return data as MasterRoleTemplate[];
}

export async function createRoleTemplate(input: {
  industry_id: string;
  name: string;
  department?: string;
  purpose?: string;
  description?: string;
  level_scale_max?: number;
}): Promise<MasterRoleTemplate> {
  const { data, error } = await supabase.from("master_role_templates").insert(input).select().single();
  if (error) throw error;
  return data as MasterRoleTemplate;
}

export async function updateRoleTemplate(
  id: string,
  patch: Partial<Pick<MasterRoleTemplate, "name" | "department" | "purpose" | "description" | "level_scale_max" | "status">>
): Promise<void> {
  const { error } = await supabase.from("master_role_templates").update(patch).eq("id", id);
  if (error) throw error;
}

/** Revision 5 RPC: atomically publishes the next version, copying its
 * competency requirements forward. Returns the new row's id/version. */
export async function publishRoleTemplateVersion(
  roleTemplateId: string
): Promise<{ new_id: string; new_version: number }> {
  const { data, error } = await supabase.rpc("wri_publish_role_template_version", {
    p_role_template_id: roleTemplateId,
  });
  if (error) throw error;
  return (Array.isArray(data) ? data[0] : data) as { new_id: string; new_version: number };
}

export async function listRoleCompetencyRequirements(
  roleTemplateId: string
): Promise<MasterRoleCompetencyRequirement[]> {
  const { data, error } = await supabase
    .from("master_role_competency_requirements")
    .select("*, master_competency_templates(name)")
    .eq("master_role_template_id", roleTemplateId);
  if (error) throw error;
  return data as unknown as MasterRoleCompetencyRequirement[];
}

export async function addRoleCompetencyRequirement(input: {
  master_role_template_id: string;
  master_competency_template_id: string;
  required_level: number;
}): Promise<void> {
  const { error } = await supabase.from("master_role_competency_requirements").insert(input);
  if (error) throw error;
}

export async function updateRequiredLevel(id: string, required_level: number): Promise<void> {
  const { error } = await supabase
    .from("master_role_competency_requirements")
    .update({ required_level })
    .eq("id", id);
  if (error) throw error;
}

export async function removeRoleCompetencyRequirement(id: string): Promise<void> {
  const { error } = await supabase.from("master_role_competency_requirements").delete().eq("id", id);
  if (error) throw error;
}

// ---------------------------------------------------------------------------
// Master competency templates
// ---------------------------------------------------------------------------

export async function listCurrentCompetencyTemplates(industryId?: string): Promise<MasterCompetencyTemplate[]> {
  let query = supabase.from("master_competency_templates").select("*").eq("is_current", true).order("name");
  if (industryId) query = query.eq("industry_id", industryId);
  const { data, error } = await query;
  if (error) throw error;
  return data as MasterCompetencyTemplate[];
}

export async function getCompetencyTemplateFamily(familyId: string): Promise<MasterCompetencyTemplate[]> {
  const { data, error } = await supabase
    .from("master_competency_templates")
    .select("*")
    .eq("family_id", familyId)
    .order("version", { ascending: false });
  if (error) throw error;
  return data as MasterCompetencyTemplate[];
}

export async function createCompetencyTemplate(input: {
  industry_id: string;
  name: string;
  category?: string;
  is_critical?: boolean;
  verifier_type?: string;
  evidence_requirements?: string;
  reverification_period_months?: number;
  description?: string;
}): Promise<MasterCompetencyTemplate> {
  const { data, error } = await supabase.from("master_competency_templates").insert(input).select().single();
  if (error) throw error;
  return data as MasterCompetencyTemplate;
}

export async function updateCompetencyTemplate(
  id: string,
  patch: Partial<
    Pick<
      MasterCompetencyTemplate,
      "name" | "category" | "is_critical" | "verifier_type" | "evidence_requirements" | "reverification_period_months" | "description" | "status"
    >
  >
): Promise<void> {
  const { error } = await supabase.from("master_competency_templates").update(patch).eq("id", id);
  if (error) throw error;
}

export async function publishCompetencyTemplateVersion(
  competencyTemplateId: string
): Promise<{ new_id: string; new_version: number }> {
  const { data, error } = await supabase.rpc("wri_publish_competency_template_version", {
    p_competency_template_id: competencyTemplateId,
  });
  if (error) throw error;
  return (Array.isArray(data) ? data[0] : data) as { new_id: string; new_version: number };
}

// ---------------------------------------------------------------------------
// Assessments (template mode: client_id null)
// ---------------------------------------------------------------------------

export async function listCurrentAssessments(): Promise<Assessment[]> {
  const { data, error } = await supabase
    .from("assessments")
    .select("*")
    .eq("is_current", true)
    .is("client_id", null)
    .order("name");
  if (error) throw error;
  return data as Assessment[];
}

export async function listMasterCompetencyAssessmentCoverage(): Promise<
  MasterCompetencyAssessmentCoverage[]
> {
  const { data, error } = await supabase.rpc(
    "wri_master_competency_assessment_coverage"
  );

  if (error) throw error;

  return (data ?? []) as MasterCompetencyAssessmentCoverage[];
}

export async function getAssessmentFamily(familyId: string): Promise<Assessment[]> {
  const { data, error } = await supabase
    .from("assessments")
    .select("*")
    .eq("family_id", familyId)
    .is("client_id", null)
    .order("version", { ascending: false });
  if (error) throw error;
  return data as Assessment[];
}

export async function createAssessment(input: {
  industry_id: string;
  name: string;
  type: AssessmentType;
  master_role_template_id?: string | null;
  master_target_role_template_id?: string | null;
  master_competency_template_id?: string | null;
}): Promise<Assessment> {
  const { data, error } = await supabase.from("assessments").insert(input).select().single();
  if (error) throw error;
  return data as Assessment;
}

export async function updateAssessment(
  id: string,
  patch: Partial<Pick<Assessment, "name" | "master_role_template_id" | "master_target_role_template_id" | "master_competency_template_id">>
): Promise<void> {
  const { error } = await supabase.from("assessments").update(patch).eq("id", id);
  if (error) throw error;
}

export async function publishAssessmentVersion(
  assessmentId: string
): Promise<{ new_id: string; new_version: number }> {
  const { data, error } = await supabase.rpc("wri_publish_assessment_version", {
    p_assessment_id: assessmentId,
  });
  if (error) throw error;
  return (Array.isArray(data) ? data[0] : data) as { new_id: string; new_version: number };
}

// ---------------------------------------------------------------------------
// Assessment questions + secure answer keys
// ---------------------------------------------------------------------------

export async function listQuestions(assessmentId: string): Promise<AssessmentQuestion[]> {
  const { data, error } = await supabase
    .from("assessment_questions")
    .select("*")
    .eq("assessment_id", assessmentId)
    .order("sort_order");
  if (error) throw error;
  return data as AssessmentQuestion[];
}

export async function createQuestion(input: {
  assessment_id: string;
  master_competency_template_id: string;
  domain: string;
  difficulty: "foundational" | "application" | "scenario";
  type: AssessmentQuestionType;
  prompt: string;
  scenario?: string;
  image_url?: string;
  options?: { id: string; label: string }[];
  correct_answer: string | string[];
  points?: number;
  sort_order?: number;
  critical_safety?: boolean;
  practical_verification_required?: boolean;
}): Promise<AssessmentQuestion> {
  const { data, error } = await supabase.rpc(
    "wri_create_master_backed_assessment_question",
    {
      p_assessment_id: input.assessment_id,
      p_master_competency_template_id:
        input.master_competency_template_id,
      p_domain: input.domain,
      p_type: input.type,
      p_difficulty: input.difficulty,
      p_prompt: input.prompt,
      p_options: input.options ?? [],
      p_correct_answer: input.correct_answer,
      p_scenario: input.scenario ?? null,
      p_image_url: input.image_url ?? null,
      p_points: input.points ?? 1,
      p_sort_order: input.sort_order ?? 0,
      p_critical_safety:
        input.critical_safety ?? false,
      p_practical_verification_required:
        input.practical_verification_required ?? false,
    }
  );

  if (error) throw error;

  const { data: question, error: questionError } =
    await supabase
      .from("assessment_questions")
      .select("*")
      .eq("id", data)
      .single();

  if (questionError) throw questionError;

  return question as AssessmentQuestion;
}

export async function updateQuestion(id: string, patch: Partial<AssessmentQuestion>): Promise<void> {
  const { error } = await supabase.from("assessment_questions").update(patch).eq("id", id);
  if (error) throw error;
}

export async function deleteQuestion(id: string): Promise<void> {
  const { error } = await supabase.from("assessment_questions").delete().eq("id", id);
  if (error) throw error;
}

/** Admin-only read of the correct answer for editing. Never call this from
 * any employee-facing / assessment-taking page — RLS also blocks it there,
 * this is a second, deliberate line of defense: the admin UI is the only
 * caller in this codebase that should ever import this function. */
export async function getAnswerKey(questionId: string): Promise<AnswerKey | null> {
  const { data, error } = await supabase
    .from("assessment_question_answer_keys")
    .select("*")
    .eq("question_id", questionId)
    .maybeSingle();
  if (error) throw error;
  return data as AnswerKey | null;
}

export async function upsertAnswerKey(input: {
  question_id: string;
  correct_answer: string | string[];
  scoring_notes?: string;
}): Promise<void> {
  const { error } = await supabase
    .from("assessment_question_answer_keys")
    .upsert(input, { onConflict: "question_id" });
  if (error) throw error;
}

// ---------------------------------------------------------------------------
// Adoption status
// ---------------------------------------------------------------------------

/** NOTE: assumes `clients` has a `name` column for display — adjust the
 * embedded select below if your clients table names it differently. */
export async function listAdoptionsForFamily(
  entityType: "role" | "competency" | "assessment",
  familyId: string
): Promise<AdoptionStatusRow[]> {
  const { data, error } = await supabase
    .from("v_template_adoption_status")
    .select("*, clients(name)")
    .eq("entity_type", entityType)
    .eq("source_family_id", familyId)
    .order("adopted_at", { ascending: false });
  if (error) throw error;
  return data as unknown as AdoptionStatusRow[];
}
