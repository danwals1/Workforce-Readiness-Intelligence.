"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useIntegrateAdminGuard } from "@/lib/adminAuth";

const TABS = [
  { href: "/admin/library", label: "Overview" },
  { href: "/admin/library/industries", label: "Industries" },
  { href: "/admin/library/roles", label: "Roles" },
  { href: "/admin/library/competencies", label: "Competencies" },
  { href: "/admin/library/assessments", label: "Assessments" },
];

export default function AdminLibraryLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const status = useIntegrateAdminGuard();
  const pathname = usePathname();

  if (status === "checking") {
    return (
      <div className="mx-auto max-w-7xl">
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
          Checking access…
        </div>
      </div>
    );
  }

  if (status === "denied") {
    return (
      <div className="mx-auto max-w-7xl">
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">
          <p className="text-slate-300">
            This area is restricted to IntegrateU admins.
          </p>

          <Link
            href="/dashboard"
            className="mt-6 inline-block text-sm font-medium text-cyan-400 hover:text-cyan-300"
          >
            ← RISE Home
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl">
      <header className="mb-8">
        <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
          Administration
        </p>

        <h2 className="mt-2 text-3xl font-semibold">
          Master Library
        </h2>

        <p className="mt-2 max-w-3xl text-sm text-slate-400">
          Manage industries, role and competency templates, and versioned assessments.
        </p>
      </header>

      <nav className="mb-8 flex flex-wrap gap-1 border-b border-slate-800 pb-px">
          {TABS.map((tab) => {
            const active = pathname === tab.href;

            return (
              <Link
                key={tab.href}
                href={tab.href}
                className={`rounded-t-lg px-4 py-2 text-sm ${
                  active
                    ? "bg-slate-900 text-white border border-slate-800 border-b-slate-900 -mb-px"
                    : "text-slate-400 hover:text-white"
                }`}
              >
                {tab.label}
              </Link>
            );
          })}
        </nav>

      {children}
    </div>
  );
}
