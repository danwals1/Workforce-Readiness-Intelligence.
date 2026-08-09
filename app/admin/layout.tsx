"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useIntegrateAdminGuard } from "@/lib/adminAuth";
import { supabase } from "@/lib/supabase";

const TABS = [
  { href: "/admin/library", label: "Overview" },
  { href: "/admin/library/industries", label: "Industries" },
  { href: "/admin/library/roles", label: "Roles" },
  { href: "/admin/library/competencies", label: "Competencies" },
  { href: "/admin/library/assessments", label: "Assessments" },
];

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const status = useIntegrateAdminGuard();
  const pathname = usePathname();
  const router = useRouter();

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  if (status === "checking") {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-6xl text-slate-400">Checking access…</div>
      </main>
    );
  }

  if (status === "denied") {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-6xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            This area is restricted to IntegrateU admins.
          </div>
          <Link href="/dashboard" className="mt-6 block text-cyan-400">
            ← Back to Dashboard
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">
        <div className="mb-8 flex items-start justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">IntegrateU Admin</p>
            <h1 className="mt-2 text-3xl font-semibold">Master Library</h1>
            <p className="mt-2 text-sm text-slate-400">
              Industries, role &amp; competency templates, versioned assessments.
            </p>
          </div>
          <div className="flex gap-3">
            <Link
              href="/dashboard"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 hover:bg-slate-800"
            >
              ← Dashboard
            </Link>
            <button
              onClick={handleLogout}
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 hover:bg-slate-800"
            >
              Sign Out
            </button>
          </div>
        </div>

        <nav className="mb-8 flex gap-1 border-b border-slate-800 pb-px">
          {TABS.map((t) => {
            const active = pathname === t.href;
            return (
              <Link
                key={t.href}
                href={t.href}
                className={`rounded-t-lg px-4 py-2 text-sm ${
                  active ? "bg-slate-900 text-white border border-slate-800 border-b-slate-900 -mb-px" : "text-slate-400 hover:text-white"
                }`}
              >
                {t.label}
              </Link>
            );
          })}
        </nav>

        {children}
      </div>
    </main>
  );
}
