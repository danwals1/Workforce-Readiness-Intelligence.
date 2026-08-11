"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type VerificationEmployee = {
  employee_id: string;
  client_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  verifier_scope: "client" | "employee";
  verifier_title: string | null;
  assignment_id: string;
};

export default function VerifyPage() {
  const router = useRouter();

  const [employees, setEmployees] =
    useState<VerificationEmployee[]>([]);

  const [message, setMessage] =
    useState("Loading verification assignments...");

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

      const {
        data,
        error,
      } = await supabase.rpc(
        "wri_list_my_verification_employees"
      );

      if (error) {
        setMessage(error.message);
        return;
      }

      const rows =
        (data ?? []) as VerificationEmployee[];

      setEmployees(rows);

      if (rows.length === 0) {
        setMessage(
          "You do not currently have any practical-verification assignments."
        );
        return;
      }

      setMessage("");
    }

    loadPage();
  }, [router]);

  const companyWideCount = useMemo(
    () =>
      employees.filter(
        (employee) =>
          employee.verifier_scope === "client"
      ).length,
    [employees]
  );

  const employeeSpecificCount = useMemo(
    () =>
      employees.filter(
        (employee) =>
          employee.verifier_scope === "employee"
      ).length,
    [employees]
  );

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">
        <div className="mb-10 flex flex-col gap-6 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">
              IntegrateU
            </p>

            <h1 className="mt-2 text-3xl font-semibold">
              Verify Employees
            </h1>

            <p className="mt-2 max-w-2xl text-slate-400">
              Review and verify practical competency performance
              only for employees within your assigned verifier scope.
            </p>
          </div>

          <div className="flex flex-wrap gap-3">
            <Link
              href="/dashboard"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
            >
              ← Dashboard
            </Link>

            <Link
              href="/assessments"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
            >
              Assessments
            </Link>
          </div>
        </div>

        {message && (
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {employees.length > 0 && (
          <>
            <section className="mb-8 grid gap-4 sm:grid-cols-3">
              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
                <p className="text-sm text-slate-400">
                  Employees Available
                </p>

                <p className="mt-2 text-3xl font-semibold">
                  {employees.length}
                </p>
              </div>

              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
                <p className="text-sm text-slate-400">
                  Company-Scope Access
                </p>

                <p className="mt-2 text-3xl font-semibold text-cyan-400">
                  {companyWideCount}
                </p>
              </div>

              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
                <p className="text-sm text-slate-400">
                  Employee-Specific Access
                </p>

                <p className="mt-2 text-3xl font-semibold text-emerald-300">
                  {employeeSpecificCount}
                </p>
              </div>
            </section>

            <section>
              <div className="mb-5">
                <h2 className="text-2xl font-semibold">
                  Employees You Can Verify
                </h2>

                <p className="mt-1 text-sm text-slate-400">
                  Your verifier assignment determines who appears
                  here.
                </p>
              </div>

              <div className="grid gap-5 md:grid-cols-2">
                {employees.map((employee) => {
                  const fullName =
                    `${employee.first_name} ${employee.last_name}`.trim();

                  const scopeLabel =
                    employee.verifier_scope === "client"
                      ? "Entire Company"
                      : "Specific Employee";

                  return (
                    <article
                      key={employee.employee_id}
                      className="rounded-2xl border border-slate-800 bg-slate-900 p-6"
                    >
                      <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
                        <div>
                          <p className="text-sm text-slate-400">
                            Employee
                          </p>

                          <h3 className="mt-1 text-2xl font-semibold">
                            {fullName}
                          </h3>

                          {employee.employee_number && (
                            <p className="mt-1 text-sm text-slate-500">
                              {employee.employee_number}
                            </p>
                          )}
                        </div>

                        <span className="w-fit rounded-full bg-cyan-500/10 px-3 py-1 text-xs font-medium text-cyan-400">
                          {scopeLabel}
                        </span>
                      </div>

                      <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/50 p-4">
                        <p className="text-xs uppercase tracking-wide text-slate-500">
                          Verifier Role
                        </p>

                        <p className="mt-1 font-medium text-slate-300">
                          {employee.verifier_title ||
                            "Practical Verifier"}
                        </p>
                      </div>

                      <div className="mt-6 flex flex-wrap gap-3">
                        <Link
                          href={`/employees/${employee.employee_id}/practical-verification`}
                          className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                        >
                          Practical Verification
                        </Link>

                        <Link
                          href={`/employees/${employee.employee_id}`}
                          className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
                        >
                          Employee Profile
                        </Link>
                      </div>
                    </article>
                  );
                })}
              </div>
            </section>
          </>
        )}
      </div>
    </main>
  );
}