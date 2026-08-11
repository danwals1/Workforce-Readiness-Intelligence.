"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type SystemHeaderProps = {
  title: string;
  subtitle?: string;
  backHref?: string;
  backLabel?: string;
  showHome?: boolean;
  showSignOut?: boolean;
  children?: React.ReactNode;
};

export default function SystemHeader({
  title,
  subtitle,
  backHref,
  backLabel = "Back",
  showHome = true,
  showSignOut = true,
  children,
}: SystemHeaderProps) {
  const router = useRouter();

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  return (
    <header className="mb-10 flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
      <div>
        <Link
          href="/dashboard"
          className="text-sm font-medium text-cyan-400 transition hover:text-cyan-300"
        >
          IntegrateU Training System
        </Link>

        <h1 className="mt-2 text-3xl font-semibold">
          {title}
        </h1>

        {subtitle && (
          <p className="mt-2 max-w-2xl text-slate-400">
            {subtitle}
          </p>
        )}
      </div>

      <div className="flex flex-wrap gap-3">
        {backHref && (
          <Link
            href={backHref}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
          >
            ← {backLabel}
          </Link>
        )}

        {showHome && (
          <Link
            href="/dashboard"
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
          >
            Training System Home
          </Link>
        )}

        {children}

        {showSignOut && (
          <button
            onClick={handleLogout}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800"
          >
            Sign Out
          </button>
        )}
      </div>
    </header>
  );
}
