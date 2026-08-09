"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import {
  createCompetencyTemplate,
  listCurrentCompetencyTemplates,
  listIndustries,
  type Industry,
  type MasterCompetencyTemplate,
} from "@/lib/masterLibrary";

export default function CompetencyTemplatesPage() {
  const [competencies, setCompetencies] = useState<MasterCompetencyTemplate[]>([]);
  const [industries, setIndustries] = useState<Industry[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);

  const [industryId, setIndustryId] = useState("");
  const [name, setName] = useState("");
  const [category, setCategory] = useState("");
  const [isCritical, setIsCritical] = useState(false);
  const [verifierType, setVerifierType] = useState("");
  const [evidenceRequirements, setEvidenceRequirements] = useState("");
  const [reverificationMonths, setReverificationMonths] = useState<number | "">("");
  const [description, setDescription] = useState("");

  async function load() {
    setLoading(true);
    try {
      const [c, i] = await Promise.all([listCurrentCompetencyTemplates(), listIndustries()]);
      setCompetencies(c);
      setIndustries(i);
      if (!industryId && i.length > 0) setIndustryId(i[0].id);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load competency templates.");
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

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError("");
    try {
      await createCompetencyTemplate({
        industry_id: industryId,
        name,
        category: category || undefined,
        is_critical: isCritical,
        verifier_type: verifierType || undefined,
        evidence_requirements: evidenceRequirements || undefined,
        reverification_period_months: reverificationMonths === "" ? undefined : Number(reverificationMonths),
        description: description || undefined,
      });
      setName("");
      setCategory("");
      setIsCritical(false);
      setVerifierType("");
      setEvidenceRequirements("");
      setReverificationMonths("");
      setDescription("");
      setShowForm(false);
      await load();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create competency template.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold">Competency Templates</h2>
        <button
          onClick={() => setShowForm((s) => !s)}
          className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400"
        >
          {showForm ? "Cancel" : "New Competency Template"}
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
                required
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
                placeholder="Networking"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Category</label>
              <input
                value={category}
                onChange={(e) => setCategory(e.target.value)}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Verifier type</label>
              <input
                value={verifierType}
                onChange={(e) => setVerifierType(e.target.value)}
                placeholder="manager / peer / assessment"
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Reverification period (months)</label>
              <input
                type="number"
                min={0}
                value={reverificationMonths}
                onChange={(e) => setReverificationMonths(e.target.value === "" ? "" : Number(e.target.value))}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              />
            </div>
            <div className="flex items-center gap-2 pt-8">
              <input
                id="is_critical"
                type="checkbox"
                checked={isCritical}
                onChange={(e) => setIsCritical(e.target.checked)}
                className="h-4 w-4"
              />
              <label htmlFor="is_critical" className="text-sm text-slate-300">
                Critical competency
              </label>
            </div>
          </div>
          <div>
            <label className="mb-2 block text-sm text-slate-300">Evidence requirements</label>
            <textarea
              value={evidenceRequirements}
              onChange={(e) => setEvidenceRequirements(e.target.value)}
              rows={2}
              className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <div>
            <label className="mb-2 block text-sm text-slate-300">Description</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              rows={2}
              className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <button
            type="submit"
            disabled={saving || !industryId}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
          >
            {saving ? "Saving…" : "Create Competency Template"}
          </button>
        </form>
      )}

      {loading ? (
        <p className="text-slate-400">Loading…</p>
      ) : (
        <div className="grid gap-4 md:grid-cols-2">
          {competencies.map((c) => (
            <Link
              key={c.id}
              href={`/admin/library/competencies/${c.family_id}`}
              className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
            >
              <p className="text-sm text-slate-400">{industryName(c.industry_id)}</p>
              <h3 className="mt-1 text-xl font-semibold">{c.name}</h3>
              <p className="mt-2 text-sm text-slate-400">{c.category || "No category set"}</p>
              <div className="mt-4 flex gap-2">
                <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">v{c.version}</span>
                {c.is_critical && (
                  <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs text-rose-300">Critical</span>
                )}
              </div>
            </Link>
          ))}
          {competencies.length === 0 && <p className="text-slate-500">No competency templates yet.</p>}
        </div>
      )}
    </div>
  );
}
