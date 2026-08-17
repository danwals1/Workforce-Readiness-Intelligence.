"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type AppShellProps = {
  children: React.ReactNode;
  isIntegrateAdmin?: boolean;
  isClientAdmin?: boolean;
  canVerify?: boolean;
  displayName?: string;
  accountEmail?: string;
  accessLabel?: string;
};

type NavItem = {
  label: string;
  href: string;
  description?: string;
  adminOnly?: boolean;
  verifyOnly?: boolean;
  external?: boolean;
};

const primaryNavigation: NavItem[] = [
  {
    label: "Overview",
    href: "/dashboard",
  },
  {
    label: "Employees",
    href: "/workforce-readiness",
  },
  {
    label: "Candidates",
    href: "/candidates",
    adminOnly: true,
  },
  {
    label: "Assessments",
    href: "/assessments",
  },
  {
    label: "Readiness Actions",
    href: "/readiness-actions",
    adminOnly: true,
  },
  {
    label: "Development Plans",
    href: "/development-plans",
    adminOnly: true,
  },
  {
    label: "Training Hub",
    href:
      process.env.NEXT_PUBLIC_TRAINING_HUB_URL ??
      "",
    external: true,
  },
];

const administrationNavigation: NavItem[] = [
  {
    label: "Verifier Management",
    href: "/admin/verifiers",
    adminOnly: true,
  },
  {
    label: "Master Library",
    href: "/admin/library",
    adminOnly: true,
  },
];

export default function AppShell({
  children,
  isIntegrateAdmin = false,
  isClientAdmin = false,
  canVerify = false,
  displayName = "",
  accountEmail = "",
  accessLabel = "Employee",
}: AppShellProps) {
  const pathname = usePathname();
  const router = useRouter();

  const canManageOrganization =
    isIntegrateAdmin || isClientAdmin;

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  function isVisible(item: NavItem) {
    if (item.adminOnly && !canManageOrganization) {
      return false;
    }

    if (item.verifyOnly && !canVerify) {
      return false;
    }

    return true;
  }

  function isActive(href: string) {
    if (href === "/dashboard") {
      return pathname === "/dashboard";
    }

    return (
      pathname === href ||
      pathname.startsWith(`${href}/`)
    );
  }

  function renderNavItem(item: NavItem) {
    if (!isVisible(item)) {
      return null;
    }

    const active = isActive(item.href);

    const className = [
      "block rounded-lg px-3 py-2.5 text-sm font-medium transition",
      active
        ? "bg-[var(--integrateu-blue-light)] text-[var(--integrateu-blue-dark)]"
        : "text-slate-400 hover:bg-slate-100 hover:text-slate-900",
    ].join(" ");

    if (item.external) {
      if (!item.href) {
        return null;
      }

      return (
        <a
          key={item.label}
          href={item.href}
          target="_blank"
          rel="noopener noreferrer"
          className={className}
        >
          {item.label}
          <span
            className="ml-1.5 text-xs"
            aria-hidden="true"
          >
            ↗
          </span>
        </a>
      );
    }

    return (
      <Link
        key={item.href}
        href={item.href}
        className={className}
      >
        {item.label}
      </Link>
    );
  }

  return (
    <div className="min-h-screen bg-[var(--page-background)] text-[var(--text-primary)]">
      <header className="border-b border-[var(--border)] bg-white">
        <div className="flex min-h-20 items-center justify-between gap-4 px-5 lg:px-8">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.16em] text-[var(--integrateu-blue)]">
              RISE by IntegrateU
            </p>

            <h1 className="mt-1 text-xl font-semibold sm:text-2xl">
              RISE
            </h1>

            <p className="mt-0.5 text-xs text-[var(--text-secondary)] sm:text-sm">
              Readiness Intelligence & Skills Engine
            </p>
          </div>

          <div className="flex min-w-0 items-center gap-3">
            <div className="min-w-0 text-right">
              <p className="break-words text-sm font-semibold text-[var(--text-primary)]">
                {displayName || accountEmail || "Signed-in user"}
              </p>

              <p className="mt-0.5 text-xs font-medium text-[var(--integrateu-blue)]">
                {accessLabel}
              </p>
            </div>

            <button
              onClick={handleLogout}
              className="shrink-0 rounded-lg border border-[var(--border-dark)] bg-white px-3 py-2 text-xs font-medium text-[var(--text-secondary)] transition hover:border-[var(--integrateu-blue)] hover:text-[var(--integrateu-blue-dark)] sm:px-4 sm:text-sm"
            >
              Sign Out
            </button>
          </div>
        </div>
      </header>

      <div className="lg:grid lg:min-h-[calc(100vh-5rem)] lg:grid-cols-[240px_minmax(0,1fr)]">
        <aside className="border-b border-[var(--border)] bg-white lg:border-b-0 lg:border-r">
          <nav className="px-4 py-5">
            <p className="px-3 text-xs font-semibold uppercase tracking-wide text-[var(--text-muted)]">
              Workspace
            </p>

            <div className="mt-2 space-y-1">
              {primaryNavigation.map(renderNavItem)}
            </div>

            {canManageOrganization && (
              <>
                <div className="my-5 border-t border-[var(--border)]" />

                <p className="px-3 text-xs font-semibold uppercase tracking-wide text-[var(--text-muted)]">
                  Administration
                </p>

                <div className="mt-2 space-y-1">
                  {administrationNavigation.map(
                    renderNavItem
                  )}
                </div>
              </>
            )}
          </nav>
        </aside>

        <main className="min-w-0">
          <div className="mx-auto w-full max-w-[1600px] p-5 sm:p-6 lg:p-8">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
}
