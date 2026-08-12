"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import SystemHeader from "@/components/SystemHeader";
import { supabase } from "@/lib/supabase";

type TestEmployee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  auth_user_id: string | null;
};

export default function SystemTestingPage() {
  const router = useRouter();

  const [employees, setEmployees] =
    useState<TestEmployee[]>([]);

  const [message, setMessage] =
    useState("Loading testing workspace...");

  useEffect(() => {
    async function loadPage() {
      const {
        data: sessionData,
        error: sessionError,
      } = await supabase.auth.getSession();

      if (sessionError) {
        setMessage(sessionError.message);
        return;
      }

      if (!sessionData.session) {
        router.push("/");
        return;
      }

      const userId =
        sessionData.session.user.id;

      const {
        data: roles,
        error: rolesError,
      } = await supabase
        .from("user_client_roles")
        .select("role, status")
        .eq("user_id", userId)
        .eq("status", "active");

      if (rolesError) {
        setMessage(rolesError.message);
        return;
      }

      const isIntegrateAdmin =
        roles?.some(
          (row) =>
            row.role === "INTEGRATEU_ADMIN"
        ) ?? false;

      if (!isIntegrateAdmin) {
        router.push("/dashboard");
        return;
      }

      const {
        data,
        error,
      } = await supabase
        .from("employees")
        .select(`
          id,
          first_name,
          last_name,
          employee_number,
          auth_user_id
        `)
        .ilike(
          "employee_number",
          "%TEST%"
        )
        .order("last_name", {
          ascending: true,
        });

      if (error) {
        setMessage(error.message);
        return;
      }

      setEmployees(
        (data ?? []) as TestEmployee[]
      );

      setMessage("");
    }

    loadPage();
  }, [router]);

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <SystemHeader
          title="System Testing"
          subtitle="IntegrateU Admin workspace for testing workforce-readiness workflows."
          backHref="/dashboard"
          backLabel="Dashboard"
          showHome={true}
          showSignOut={true}
        />

        {message && (
          <div className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        <section>
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
              Admin Only
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Workflow Testing
            </h2>

            <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
              Jump directly into each part of the readiness lifecycle.
            </p>
          </div>

          <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
            <TestingCard
              href="/assessments"
              eyebrow="Assessments"
              title="Assessment Center"
              description="Test assessment attempts and results."
            />

            <TestingCard
              href="/readiness-actions"
              eyebrow="Readiness"
              title="Readiness Actions"
              description="Review generated readiness actions."
            />

            <TestingCard
              href="/development-plans"
              eyebrow="Development"
              title="Development Plans"
              description="Test plan creation, ownership, activities, completion, editing, and cancellation."
            />

            <TestingCard
              href="/verify"
              eyebrow="Verification"
              title="Verify Employees"
              description="Test practical verification workflows."
            />

            <TestingCard
              href="/admin/verifiers"
              eyebrow="Administration"
              title="Verifier Management"
              description="Manage verifier assignments."
            />

            <TestingCard
              href="/admin/library"
              eyebrow="Configuration"
              title="Master Library"
              description="Review roles, competencies, industries, and assessments."
            />
          </div>
        </section>

        <section className="mt-12">
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
              Test Accounts
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Test Employees
            </h2>

            <p className="mt-2 text-sm text-slate-400">
              Employees with TEST in their employee number appear here automatically.
            </p>
          </div>

          {employees.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">
              <p className="font-medium">
                No test employees found.
              </p>
            </div>
          ) : (
            <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
              {employees.map(
                (employee) => (
                  <article
                    key={employee.id}
                    className="rounded-2xl border border-slate-800 bg-slate-900 p-6"
                  >
                    <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
                      Test Employee
                    </p>

                    <h3 className="mt-2 text-xl font-semibold">
                      {employee.first_name}{" "}
                      {employee.last_name}
                    </h3>

                    <p className="mt-2 text-sm text-slate-400">
                      {employee.employee_number ??
                        "No employee number"}
                    </p>

                    <p className="mt-1 text-xs text-slate-500">
                      {employee.auth_user_id
                        ? "Login linked"
                        : "No login linked"}
                    </p>

                    <div className="mt-5 flex flex-wrap gap-3">
                      <Link
                        href={`/employees/${employee.id}`}
                        className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                      >
                        Employee Profile
                      </Link>

                      <Link
                        href={`/employees/${employee.id}/practical-verification`}
                        className="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 transition hover:bg-slate-100 hover:text-slate-900"
                      >
                        Practical Verification
                      </Link>
                    </div>
                  </article>
                )
              )}
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

function TestingCard({
  href,
  eyebrow,
  title,
  description,
}: {
  href: string;
  eyebrow: string;
  title: string;
  description: string;
}) {
  return (
    <Link
      href={href}
      className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
    >
      <p className="text-sm font-medium text-cyan-400">
        {eyebrow}
      </p>

      <h3 className="mt-2 text-xl font-semibold">
        {title}
      </h3>

      <p className="mt-2 text-sm leading-6 text-slate-400">
        {description}
      </p>

      <p className="mt-5 text-sm font-medium text-cyan-400">
        Open →
      </p>
    </Link>
  );
}
