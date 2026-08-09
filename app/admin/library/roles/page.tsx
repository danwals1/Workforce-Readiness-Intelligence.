"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import {
  createRoleTemplate,
  listCurrentRoleTemplates,
  listIndustries,
  type Industry,
  type MasterRoleTemplate,
} from "@/lib/masterLibrary";

export default function RoleTemplatesPage() {
  const [roles, setRoles] = useState<MasterRoleTemplate[]>([]);
  const [industries, setIndustries] = useState<Industry[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);

  const [industryId, setIndustryId] = useState("");
  const [name, setName] = useState("");
  const [department, setDepartment] = useState("");
  const [purpose, setPurpose] = useState("");
  const [description, setDescription] = useState("");
  const [levelScaleMax, setLevelScaleMax] = useState(5);

  async function load() {
    setLoading(true);
    try {
      const [r, i] = await Promise.all([listCurrentRoleTemplates(), listIndustries()]);
      setRoles(r);
      setIndustries(i);
      if (!industryId && i.length > 0) setIndustryId(i[0].id);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load role templates.");
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
      await createRoleTemplate({
        industry_id: industryId,
        name,
        department: department || undefined,
        purpose: purpose || undefined,
        description: description || undefined,
        level_scale_max: levelScaleMax,
      });
      setName("");
      setDepartment("");
      setPurpose("");
      setDescription("");
      setShowForm(false);
      await load();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create role template.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold">Role Templates</h2>
        <button
          onClick={() => setShowForm((s) => !s)}
          className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400"
        >
          {showForm ? "Cancel" : "New Role Template"}
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
                placeholder="Technician II"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Department</label>
              <input
                value={department}
                onChange={(e) => setDepartment(e.target.value)}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Level scale max</label>
              <input
                type="number"
                min={1}
                max={10}
                value={levelScaleMax}
                onChange={(e) => setLevelScaleMax(Number(e.target.value))}
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
              />
            </div>
          </div>
          <div>
            <label className="mb-2 block text-sm text-slate-300">Purpose</label>
            <textarea
              value={purpose}
              onChange={(e) => setPurpose(e.target.value)}
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
            {saving ? "Saving…" : "Create Role Template"}
          </button>
        </form>
      )}

      {loading ? (
        <p className="text-slate-400">Loading…</p>
      ) : (
        <div className="grid gap-4 md:grid-cols-2">
          {roles.map((r) => (
            <Link
              key={r.id}
              href={`/admin/library/roles/${r.family_id}`}
              className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
            >
              <p className="text-sm text-slate-400">{industryName(r.industry_id)}</p>
              <h3 className="mt-1 text-xl font-semibold">{r.name}</h3>
              <p className="mt-2 text-sm text-slate-400">{r.department || "No department set"}</p>
              <span className="mt-4 inline-block rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                v{r.version}
              </span>
            </Link>
          ))}
          {roles.length === 0 && <p className="text-slate-500">No role templates yet.</p>}
        </div>
      )}
    </div>
  );
}
