"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";

type Counts = { industries: number; roles: number; competencies: number; assessments: number };

export default function LibraryOverviewPage() {
  const [counts, setCounts] = useState<Counts | null>(null);

  useEffect(() => {
    async function load() {
      const [industries, roles, competencies, assessments] = await Promise.all([
        supabase.from("industries").select("id", { count: "exact", head: true }),
        supabase.from("master_role_templates").select("id", { count: "exact", head: true }).eq("is_current", true),
        supabase.from("master_competency_templates").select("id", { count: "exact", head: true }).eq("is_current", true),
        supabase.from("assessments").select("id", { count: "exact", head: true }).eq("is_current", true).is("client_id", null),
      ]);

      setCounts({
        industries: industries.count ?? 0,
        roles: roles.count ?? 0,
        competencies: competencies.count ?? 0,
        assessments: assessments.count ?? 0,
      });
    }
    load();
  }, []);

  const cards = [
    { href: "/admin/library/industries", label: "Industries", count: counts?.industries },
    { href: "/admin/library/roles", label: "Role Templates", count: counts?.roles },
    { href: "/admin/library/competencies", label: "Competency Templates", count: counts?.competencies },
    { href: "/admin/library/assessments", label: "Assessment Templates", count: counts?.assessments },
  ];

  return (
    <div className="grid gap-6 md:grid-cols-2">
      {cards.map((c) => (
        <Link
          key={c.href}
          href={c.href}
          className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
        >
          <p className="text-sm text-slate-400">{c.label}</p>
          <p className="mt-2 text-4xl font-bold">{c.count ?? "…"}</p>
          <p className="mt-4 text-sm text-cyan-400">Manage →</p>
        </Link>
      ))}
    </div>
  );
}
