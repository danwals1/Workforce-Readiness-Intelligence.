"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import {
  createAssessment,
  listCurrentAssessments,
  listCurrentCompetencyTemplates,
  listCurrentRoleTemplates,
  listIndustries,
  type Assessment,
  type AssessmentType,
  type Industry,
  type MasterCompetencyTemplate,
  type MasterRoleTemplate,
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
      const [a, i, r, c] = await Promise.all([
        listCurrentAssessments(),
        listIndustries(),
        listCurrentRoleTemplates(),
        listCurrentCompetencyTemplates(),
      ]);
      setAssessments(a);
      setIndustries(i);
      setRoles(r);
      setCompetencies(c);
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

      {loading ? (
        <p className="text-slate-400">Loading…</p>
      ) : (
        <div className="grid gap-4 md:grid-cols-2">
          {assessments.map((a) => (
            <Link
              key={a.id}
              href={`/admin/library/assessments/${a.family_id}`}
              className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
            >
              <p className="text-sm text-slate-400">{industryName(a.industry_id)}</p>
              <h3 className="mt-1 text-xl font-semibold">{a.name}</h3>
              <p className="mt-2 text-sm text-slate-400">
                {TYPE_LABELS[a.type]}
                {roleName(a.master_role_template_id) ? ` · ${roleName(a.master_role_template_id)}` : ""}
                {competencyName(a.master_competency_template_id) ? ` · ${competencyName(a.master_competency_template_id)}` : ""}
              </p>
              <span className="mt-4 inline-block rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                v{a.version}
              </span>
            </Link>
          ))}
          {assessments.length === 0 && <p className="text-slate-500">No assessment templates yet.</p>}
        </div>
      )}
    </div>
  );
}
