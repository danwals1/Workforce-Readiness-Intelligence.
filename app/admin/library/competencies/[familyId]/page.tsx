"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import {
  getCompetencyTemplateFamily,
  listAdoptionsForFamily,
  publishCompetencyTemplateVersion,
  updateCompetencyTemplate,
  type AdoptionStatusRow,
  type MasterCompetencyTemplate,
} from "@/lib/masterLibrary";

export default function CompetencyTemplateDetailPage() {
  const params = useParams();
  const familyId = params.familyId as string;

  const [versions, setVersions] = useState<MasterCompetencyTemplate[]>([]);
  const [adoptions, setAdoptions] = useState<AdoptionStatusRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);
  const [publishing, setPublishing] = useState(false);

  const current = versions.find((v) => v.is_current);

  const [name, setName] = useState("");
  const [category, setCategory] = useState("");
  const [isCritical, setIsCritical] = useState(false);
  const [verifierType, setVerifierType] = useState("");
  const [evidenceRequirements, setEvidenceRequirements] = useState("");
  const [reverificationMonths, setReverificationMonths] = useState<number | "">("");
  const [description, setDescription] = useState("");

  async function load() {
    setLoading(true);
    setError("");
    try {
      const v = await getCompetencyTemplateFamily(familyId);
      setVersions(v);
      const cur = v.find((x) => x.is_current);
      if (cur) {
        setName(cur.name);
        setCategory(cur.category ?? "");
        setIsCritical(cur.is_critical);
        setVerifierType(cur.verifier_type ?? "");
        setEvidenceRequirements(cur.evidence_requirements ?? "");
        setReverificationMonths(cur.reverification_period_months ?? "");
        setDescription(cur.description ?? "");
        setAdoptions(await listAdoptionsForFamily("competency", familyId));
      }
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load competency template.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [familyId]);

  async function handleSave() {
    if (!current) return;
    setSaving(true);
    setError("");
    try {
      await updateCompetencyTemplate(current.id, {
        name,
        category,
        is_critical: isCritical,
        verifier_type: verifierType,
        evidence_requirements: evidenceRequirements,
        reverification_period_months: reverificationMonths === "" ? undefined : Number(reverificationMonths),
        description,
      });
      await load();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to save changes.");
    } finally {
      setSaving(false);
    }
  }

  async function handlePublish() {
    if (!current) return;
    setPublishing(true);
    setError("");
    try {
      await publishCompetencyTemplateVersion(current.id);
      await load();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to publish new version.");
    } finally {
      setPublishing(false);
    }
  }

  if (loading) return <p className="text-slate-400">Loading…</p>;
  if (!current) return <p className="text-slate-400">Competency template not found.</p>;

  return (
    <div className="space-y-8">
      <Link href="/admin/library/competencies" className="text-sm text-cyan-400">
        ← Competency Templates
      </Link>

      {error && <div className="rounded-xl border border-slate-800 bg-slate-900 p-4 text-sm text-rose-300">{error}</div>}

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="text-xl font-semibold">Competency Template — v{current.version}</h2>
          <button
            onClick={handlePublish}
            disabled={publishing}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
          >
            {publishing ? "Publishing…" : "Publish New Version"}
          </button>
        </div>
        <div className="grid gap-4 md:grid-cols-2">
          <div>
            <label className="mb-2 block text-sm text-slate-300">Name</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
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
          <div className="flex items-center gap-2">
            <input
              id="is_critical_edit"
              type="checkbox"
              checked={isCritical}
              onChange={(e) => setIsCritical(e.target.checked)}
              className="h-4 w-4"
            />
            <label htmlFor="is_critical_edit" className="text-sm text-slate-300">
              Critical competency
            </label>
          </div>
        </div>
        <div className="mt-4">
          <label className="mb-2 block text-sm text-slate-300">Evidence requirements</label>
          <textarea
            value={evidenceRequirements}
            onChange={(e) => setEvidenceRequirements(e.target.value)}
            rows={2}
            className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
          />
        </div>
        <div className="mt-4">
          <label className="mb-2 block text-sm text-slate-300">Description</label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={2}
            className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
          />
        </div>
        <button
          onClick={handleSave}
          disabled={saving}
          className="mt-4 rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 hover:bg-slate-800 disabled:opacity-50"
        >
          {saving ? "Saving…" : "Save changes to this version"}
        </button>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <h3 className="mb-4 text-lg font-semibold">Version history</h3>
        <div className="divide-y divide-slate-800">
          {versions.map((v) => (
            <div key={v.id} className="flex items-center justify-between py-3 text-sm">
              <span>v{v.version}</span>
              <span className="text-slate-400">{new Date(v.published_at).toLocaleDateString()}</span>
              <span
                className={`rounded-full px-3 py-1 text-xs ${
                  v.is_current ? "bg-emerald-500/15 text-emerald-300" : "bg-slate-800 text-slate-400"
                }`}
              >
                {v.is_current ? "Current" : "Superseded"}
              </span>
            </div>
          ))}
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <h3 className="mb-4 text-lg font-semibold">Companies that adopted this competency</h3>
        <div className="divide-y divide-slate-800">
          {adoptions.map((a) => (
            <div key={a.id} className="flex items-center justify-between py-3 text-sm">
              <span>{a.clients?.name ?? a.client_id}</span>
              <span className="text-slate-400">Adopted v{a.source_version}</span>
              {a.newer_version_available ? (
                <span className="rounded-full bg-amber-500/15 px-3 py-1 text-xs text-amber-300">
                  Newer version available
                </span>
              ) : (
                <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-xs text-emerald-300">Up to date</span>
              )}
            </div>
          ))}
          {adoptions.length === 0 && (
            <p className="py-3 text-slate-500">No companies have adopted this competency yet.</p>
          )}
        </div>
      </div>
    </div>
  );
}
