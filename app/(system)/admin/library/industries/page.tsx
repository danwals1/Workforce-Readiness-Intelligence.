"use client";

import { useEffect, useState } from "react";
import { createIndustry, listIndustries, type Industry } from "@/lib/masterLibrary";

export default function IndustriesPage() {
  const [industries, setIndustries] = useState<Industry[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [name, setName] = useState("");
  const [slug, setSlug] = useState("");
  const [description, setDescription] = useState("");
  const [saving, setSaving] = useState(false);

  async function load() {
    setLoading(true);
    try {
      setIndustries(await listIndustries());
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load industries.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load();
  }, []);

  async function handleCreate(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError("");
    try {
      await createIndustry({ name, slug, description: description || undefined });
      setName("");
      setSlug("");
      setDescription("");
      setShowForm(false);
      await load();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create industry.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold">Industries</h2>
        <button
          onClick={() => setShowForm((s) => !s)}
          className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400"
        >
          {showForm ? "Cancel" : "New Industry"}
        </button>
      </div>

      {error && <div className="rounded-xl border border-slate-800 bg-slate-900 p-4 text-sm text-rose-300">{error}</div>}

      {showForm && (
        <form onSubmit={handleCreate} className="space-y-4 rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <div className="grid gap-4 md:grid-cols-2">
            <div>
              <label className="mb-2 block text-sm text-slate-300">Name</label>
              <input
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                placeholder="Custom Integration / Smart Home"
              />
            </div>
            <div>
              <label className="mb-2 block text-sm text-slate-300">Slug</label>
              <input
                value={slug}
                onChange={(e) => setSlug(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
                placeholder="custom-integration-smart-home"
              />
            </div>
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
            disabled={saving}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
          >
            {saving ? "Saving…" : "Create Industry"}
          </button>
        </form>
      )}

      {loading ? (
        <p className="text-slate-400">Loading…</p>
      ) : (
        <div className="divide-y divide-slate-800 rounded-2xl border border-slate-800 bg-slate-900">
          {industries.map((ind) => (
            <div key={ind.id} className="flex items-center justify-between p-5">
              <div>
                <p className="font-semibold">{ind.name}</p>
                <p className="text-sm text-slate-400">{ind.slug}</p>
                {ind.description && <p className="mt-1 text-sm text-slate-500">{ind.description}</p>}
              </div>
              <span
                className={`rounded-full px-3 py-1 text-xs ${
                  ind.is_active ? "bg-emerald-500/15 text-emerald-300" : "bg-slate-800 text-slate-400"
                }`}
              >
                {ind.is_active ? "Active" : "Inactive"}
              </span>
            </div>
          ))}
          {industries.length === 0 && <p className="p-5 text-slate-500">No industries yet.</p>}
        </div>
      )}
    </div>
  );
}
