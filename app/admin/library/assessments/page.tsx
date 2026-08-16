"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import {
  createAssessment,
  listCurrentAssessments,
  listCurrentCompetencyTemplates,
  listCurrentRoleTemplates,
  listIndustries,
  listMasterCompetencyAssessmentCoverage,
  listMasterCompetencyAssessmentLevelCoverage,
  type Assessment,
  type AssessmentType,
  type Industry,
  type MasterCompetencyTemplate,
  type MasterRoleTemplate,
  type MasterCompetencyAssessmentCoverage,
  type MasterCompetencyAssessmentLevelCoverage,
} from "@/lib/masterLibrary";

const TYPE_LABELS: Record<AssessmentType, string> = {
  initial: "Initial Readiness",
  competency: "Competency",
  role_qualification: "Role Qualification",
};

export default function AssessmentsPage() {
  const [assessments, setAssessments] = useState<Assessment[]>([]);
  const [industries, setIndustries] = useState<Industry[]>([]);
  const [roles, setRoles] = useState<MasterRoleTemplate[]>([]);
  const [competencies, setCompetencies] = useState<MasterCompetencyTemplate[]>([]);
  const [coverage, setCoverage] =
    useState<MasterCompetencyAssessmentCoverage[]>([]);
  const [levelCoverage, setLevelCoverage] =
    useState<MasterCompetencyAssessmentLevelCoverage[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);

  const [industryId, setIndustryId] = useState("");
  const [name, setName] = useState("");
  const [type, setType] = useState<AssessmentType>("initial");
  const [roleTemplateId, setRoleTemplateId] = useState("");
  const [targetRoleTemplateId, setTargetRoleTemplateId] = useState("");
  const [competencyTemplateId, setCompetencyTemplateId] = useState("");

  async function load() {
    setLoading(true);
    try {
      const [a, i, r, c, coverageRows, levelCoverageRows] = await Promise.all([
        listCurrentAssessments(),
        listIndustries(),
        listCurrentRoleTemplates(),
        listCurrentCompetencyTemplates(),
        listMasterCompetencyAssessmentCoverage(),
        listMasterCompetencyAssessmentLevelCoverage(),
      ]);
      setAssessments(a);
      setIndustries(i);
      setRoles(r);
      setCompetencies(c);
      setCoverage(coverageRows);
      setLevelCoverage(levelCoverageRows);
      if (!industryId && i.length > 0) setIndustryId(i[0].id);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load assessments.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  function industryName(id: string) {
    return industries.find((i) => i.id === id)?.name ?? "—";
  }
  function roleName(id: string | null) {
    return roles.find((r) => r.id === id)?.name ?? null;
  }
  function competencyName(id: string | null) {
    return competencies.find((c) => c.id === id)?.name ?? null;
  }

  function coverageLabel(
    status: MasterCompetencyAssessmentCoverage["coverage_status"]
  ) {
    switch (status) {
      case "ready":
        return "Ready";
      case "needs_questions":
        return "Needs Questions";
      case "needs_answer_keys":
        return "Needs Answer Keys";
      case "needs_assessment":
        return "Needs Assessment";
    }
  }

  function coverageClasses(
    status: MasterCompetencyAssessmentCoverage["coverage_status"]
  ) {
    switch (status) {
      case "ready":
        return "border-emerald-500/30 bg-emerald-500/10 text-emerald-300";
      case "needs_questions":
        return "border-amber-500/30 bg-amber-500/10 text-amber-300";
      case "needs_answer_keys":
        return "border-orange-500/30 bg-orange-500/10 text-orange-300";
      case "needs_assessment":
        return "border-slate-700 bg-slate-800 text-slate-300";
    }
  }

  function beginCompetencyAssessment(
    row: MasterCompetencyAssessmentCoverage
  ) {
    setIndustryId(row.industry_id);
    setType("competency");
    setCompetencyTemplateId(
      row.master_competency_template_id
    );
    setRoleTemplateId("");
    setTargetRoleTemplateId("");
    setName(
      `${row.competency_name} Competency Assessment`
    );
    setShowForm(true);

    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  }

  const levelCoverageByCompetency = levelCoverage.reduce<
    Record<string, MasterCompetencyAssessmentLevelCoverage[]>
  >((groups, row) => {
    const competencyId = row.master_competency_template_id;

    if (!groups[competencyId]) {
      groups[competencyId] = [];
    }

    groups[competencyId].push(row);

    return groups;
  }, {});

  const coverageByIndustryAndCategory = coverage.reduce<
    Record<string, Record<string, MasterCompetencyAssessmentCoverage[]>>
  >((industryGroups, row) => {
    const industry = industryName(row.industry_id);
    const category = row.competency_category ?? "Uncategorized";

    if (!industryGroups[industry]) {
      industryGroups[industry] = {};
    }

    if (!industryGroups[industry][category]) {
      industryGroups[industry][category] = [];
    }

    industryGroups[industry][category].push(row);

    return industryGroups;
  }, {});

  const readyCount = coverage.filter(
    (row) => row.coverage_status === "ready"
  ).length;

  const needsQuestionsCount = coverage.filter(
    (row) => row.coverage_status === "needs_questions"
  ).length;

  const needsAnswerKeysCount = coverage.filter(
    (row) => row.coverage_status === "needs_answer_keys"
  ).length;

  const needsAssessmentCount = coverage.filter(
    (row) => row.coverage_status === "needs_assessment"
  ).length;

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError("");
    try {
      await createAssessment({
        industry_id: industryId,
        name,
        type,
        master_role_template_id: type !== "competency" ? roleTemplateId || null : null,
        master_target_role_template_id: type === "role_qualification" ? targetRoleTemplateId || null : null,
        master_competency_template_id: type === "competency" ? competencyTemplateId || null : null,
      });
      setName("");
      setShowForm(false);
      await load();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create assessment.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold">Assessment Templates</h2>
        <button
          onClick={() => setShowForm((s) => !s)}
          className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400"
        >
          {showForm ? "Cancel" : "New Assessment"}
        </button>
      </div>

      {error && <div className="rounded-xl border border-slate-800 bg-slate-900 p-4 text-sm text-rose-300">{error}</div>}

      {showForm && (
        <form onSubmit={handleCreate} className="space-y-4 rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <div className="grid gap-4 md:grid-cols-2">
            <div>
              <label className="mb-2 block text-sm text-slate-300">Industry</label>
              <select
                value={industryId}
                onChange={(e) => setIndustryId(e.target.value)}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              >
                {industries.map((i) => (
                  <option key={i.id} value={i.id}>
                    {i.name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Name</label>
              <input
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                placeholder="Technician II — Initial Readiness Assessment"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Type</label>
              <select
                value={type}
                onChange={(e) => setType(e.target.value as AssessmentType)}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              >
                <option value="initial">Initial Readiness</option>
                <option value="competency">Competency</option>
                <option value="role_qualification">Role Qualification</option>
              </select>
            </div>

            {type !== "competency" && (
              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  {type === "role_qualification" ? "Current role" : "Role"}
                </label>
                <select
                  value={roleTemplateId}
                  onChange={(e) => setRoleTemplateId(e.target.value)}
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                >
                  <option value="">Select a role…</option>
                  {roles.map((r) => (
                    <option key={r.id} value={r.id}>
                      {r.name}
                    </option>
                  ))}
                </select>
              </div>
            )}

            {type === "role_qualification" && (
              <div>
                <label className="mb-2 block text-sm text-slate-300">Target role</label>
                <select
                  value={targetRoleTemplateId}
                  onChange={(e) => setTargetRoleTemplateId(e.target.value)}
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                >
                  <option value="">Select a target role…</option>
                  {roles.map((r) => (
                    <option key={r.id} value={r.id}>
                      {r.name}
                    </option>
                  ))}
                </select>
              </div>
            )}

            {type === "competency" && (
              <div>
                <label className="mb-2 block text-sm text-slate-300">Competency</label>
                <select
                  value={competencyTemplateId}
                  onChange={(e) => setCompetencyTemplateId(e.target.value)}
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                >
                  <option value="">Select a competency…</option>
                  {competencies.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.name}
                    </option>
                  ))}
                </select>
              </div>
            )}
          </div>
          <button
            type="submit"
            disabled={saving}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
          >
            {saving ? "Saving…" : "Create Assessment"}
          </button>
        </form>
      )}

      {!loading && (
        <section className="space-y-5 rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <div>
            <h3 className="text-lg font-semibold">
              Assessment Coverage
            </h3>

            <p className="mt-1 text-sm text-slate-400">
              Current Master Library competency assessment readiness.
              Coverage requires a current competency assessment,
              Master-backed questions, and complete secure answer keys.
            </p>
          </div>

          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <div className="rounded-xl border border-emerald-500/20 bg-emerald-500/10 p-4">
              <p className="text-xs font-medium uppercase tracking-wide text-emerald-300">
                Ready
              </p>
              <p className="mt-2 text-3xl font-semibold">
                {readyCount}
              </p>
            </div>

            <div className="rounded-xl border border-amber-500/20 bg-amber-500/10 p-4">
              <p className="text-xs font-medium uppercase tracking-wide text-amber-300">
                Needs Questions
              </p>
              <p className="mt-2 text-3xl font-semibold">
                {needsQuestionsCount}
              </p>
            </div>

            <div className="rounded-xl border border-orange-500/20 bg-orange-500/10 p-4">
              <p className="text-xs font-medium uppercase tracking-wide text-orange-300">
                Needs Answer Keys
              </p>
              <p className="mt-2 text-3xl font-semibold">
                {needsAnswerKeysCount}
              </p>
            </div>

            <div className="rounded-xl border border-slate-700 bg-slate-950/50 p-4">
              <p className="text-xs font-medium uppercase tracking-wide text-slate-400">
                Needs Assessment
              </p>
              <p className="mt-2 text-3xl font-semibold">
                {needsAssessmentCount}
              </p>
            </div>
          </div>

          <div className="space-y-6">
            {Object.entries(coverageByIndustryAndCategory)
              .sort(([industryA], [industryB]) =>
                industryA.localeCompare(industryB)
              )
              .map(([industry, categoryGroups]) => (
                <details
                  key={industry}
                  className="overflow-hidden rounded-xl border border-slate-800"
                >
                  <summary className="flex cursor-pointer list-none items-center justify-between border-b-2 border-slate-400 bg-slate-200 px-5 py-4">
                    <h4 className="text-lg font-bold uppercase tracking-wide !text-slate-950">
                      {industry}
                    </h4>

                    <span className="text-sm font-semibold !text-slate-700">
                      Open / Close
                    </span>
                  </summary>

                  <div className="divide-y divide-slate-800">
                    {Object.entries(categoryGroups)
                      .sort(([categoryA], [categoryB]) =>
                        categoryA.localeCompare(categoryB)
                      )
                      .map(([category, rows]) => (
                        <div key={category}>
                          <div className="border-y border-slate-300 bg-slate-100 px-5 py-3">
                            <p className="text-sm font-semibold uppercase tracking-wide !text-slate-900">
                              {category}
                            </p>
                          </div>

                          <div className="divide-y divide-slate-800">
                            {[...rows]
                              .sort((rowA, rowB) =>
                                rowA.competency_name.localeCompare(
                                  rowB.competency_name
                                )
                              )
                              .map((row) => (
                              <div
                                key={row.master_competency_template_id}
                                className="flex flex-col gap-4 bg-slate-950/40 p-4 lg:flex-row lg:items-center lg:justify-between"
                              >
                                <div className="min-w-0">
                                  <div className="flex flex-wrap items-center gap-2">
                                    <p className="font-medium">
                                      {row.competency_name}
                                    </p>

                                    <span
                                      className={`rounded-full border px-2.5 py-1 text-xs font-medium ${coverageClasses(
                                        row.coverage_status
                                      )}`}
                                    >
                                      {coverageLabel(
                                        row.coverage_status
                                      )}
                                    </span>
                                  </div>

                                  <p className="mt-1 text-sm text-slate-500">
                                    {row.question_count} Master-backed question
                                    {row.question_count === 1 ? "" : "s"}
                                    {" · "}
                                    {row.answer_key_count} answer key
                                    {row.answer_key_count === 1 ? "" : "s"}
                                  </p>

                                  {levelCoverageByCompetency[
                                    row.master_competency_template_id
                                  ]?.length > 0 && (
                                    <div className="mt-3 space-y-2">
                                      {levelCoverageByCompetency[
                                        row.master_competency_template_id
                                      ].map((levelRow) => (
                                        <div
                                          key={levelRow.assessment_id}
                                          className="flex flex-wrap items-center gap-2 text-sm"
                                        >
                                          <span className="rounded-full border border-slate-700 bg-slate-950 px-2.5 py-1 text-xs font-semibold text-slate-300">
                                            {levelRow.target_level
                                              ? `L${levelRow.target_level}`
                                              : "No Level"}
                                          </span>

                                          <Link
                                            href={`/admin/library/assessments/${levelRow.assessment_family_id}`}
                                            className="text-cyan-300 hover:text-cyan-200"
                                          >
                                            {levelRow.assessment_name}
                                          </Link>

                                          <span className="text-slate-500">
                                            {levelRow.question_count} questions
                                            {" · "}
                                            {levelRow.answer_key_count} answer keys
                                          </span>

                                          <span
                                            className={`rounded-full border px-2 py-0.5 text-xs font-medium ${
                                              levelRow.assessment_ready
                                                ? "border-emerald-500/30 bg-emerald-500/10 text-emerald-300"
                                                : "border-amber-500/30 bg-amber-500/10 text-amber-300"
                                            }`}
                                          >
                                            {levelRow.assessment_ready
                                              ? "Ready"
                                              : levelRow.coverage_status
                                                  .replaceAll("_", " ")
                                                  .replace(/\b\w/g, (char) =>
                                                    char.toUpperCase()
                                                  )}
                                          </span>
                                        </div>
                                      ))}
                                    </div>
                                  )}
                                </div>

                                <div className="shrink-0">
                                  {!row.assessment_family_id && (
                                    <button
                                      type="button"
                                      onClick={() =>
                                        beginCompetencyAssessment(row)
                                      }
                                      className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-400"
                                    >
                                      Create Assessment
                                    </button>
                                  )}
                                </div>
                              </div>
                            ))}
                          </div>
                        </div>
                      )
                    )}
                  </div>
                </details>
              )
            )}

            {coverage.length === 0 && (
              <div className="rounded-xl border border-slate-800 p-5 text-sm text-slate-500">
                No competency coverage data is available.
              </div>
            )}
          </div>
        </section>
      )}

      {loading && (
        <p className="text-slate-400">Loading…</p>
      )}
    </div>
  );
}
