"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import SystemHeader from "@/components/SystemHeader";
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

type VerificationReadinessRow = {
  employee_id: string;
  master_competency_template_id: string;
  practical_verification_required: boolean;
  practical_ready: boolean;
  reverification_due: boolean;
  verification_expired: boolean;
};

type VerificationPlanRow = {
  development_plan_id: string;
  employee_id: string;
  master_competency_template_id: string | null;
  resolution_status: string;
};

type EmployeeVerificationWork = {
  needsVerification: number;
  reverification: number;
  planEvidence: number;
  totalOpenWork: number;
};

export default function VerifyPage() {
  const router = useRouter();

  const [employees, setEmployees] =
    useState<VerificationEmployee[]>([]);

  const [workByEmployee, setWorkByEmployee] =
    useState<Record<string, EmployeeVerificationWork>>({});

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

      if (rows.length > 0) {
        const employeeIds = rows.map(
          (employee) => employee.employee_id
        );

        const [readinessResult, planResult] =
          await Promise.all([
            supabase
              .from(
                "v_assessment_competency_readiness_current"
              )
              .select(`
                employee_id,
                master_competency_template_id,
                practical_verification_required,
                practical_ready,
                reverification_due,
                verification_expired
              `)
              .in("employee_id", employeeIds),

            supabase.rpc(
              "wri_list_development_plan_resolutions",
              {
                p_employee_id: null,
                p_resolution_status: null,
              }
            ),
          ]);

        if (readinessResult.error) {
          console.error(
            "Unable to load practical verification work:",
            readinessResult.error
          );
        }

        if (planResult.error) {
          console.error(
            "Unable to load Development Plan evidence work:",
            planResult.error
          );
        }

        const readinessRows =
          (readinessResult.data ?? []) as VerificationReadinessRow[];

        const planRows =
          (planResult.data ?? []) as VerificationPlanRow[];

        const nextWork: Record<
          string,
          EmployeeVerificationWork
        > = {};

        rows.forEach((employee) => {
          nextWork[employee.employee_id] = {
            needsVerification: 0,
            reverification: 0,
            planEvidence: 0,
            totalOpenWork: 0,
          };
        });

        readinessRows.forEach((row) => {
          if (!row.practical_verification_required) {
            return;
          }

          const summary = nextWork[row.employee_id];

          if (!summary) {
            return;
          }

          if (!row.practical_ready) {
            summary.needsVerification += 1;
          }

          if (
            row.reverification_due ||
            row.verification_expired
          ) {
            summary.reverification += 1;
          }
        });

        planRows.forEach((plan) => {
          if (
            ![
              "awaiting_verification",
              "awaiting_reverification",
            ].includes(plan.resolution_status)
          ) {
            return;
          }

          const summary =
            nextWork[plan.employee_id];

          if (!summary) {
            return;
          }

          summary.planEvidence += 1;
        });

        Object.values(nextWork).forEach(
          (summary) => {
            summary.totalOpenWork =
              summary.needsVerification +
              summary.reverification +
              summary.planEvidence;
          }
        );

        setWorkByEmployee(nextWork);
      } else {
        setWorkByEmployee({});
      }

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

  const employeesWithOpenWork = useMemo(
    () =>
      employees.filter(
        (employee) =>
          (workByEmployee[
            employee.employee_id
          ]?.totalOpenWork ?? 0) > 0
      ).length,
    [employees, workByEmployee]
  );

  const totalPlanEvidence = useMemo(
    () =>
      Object.values(workByEmployee).reduce(
        (sum, work) =>
          sum + work.planEvidence,
        0
      ),
    [workByEmployee]
  );

  const sortedEmployees = useMemo(
    () =>
      [...employees].sort((a, b) => {
        const aWork =
          workByEmployee[
            a.employee_id
          ]?.totalOpenWork ?? 0;

        const bWork =
          workByEmployee[
            b.employee_id
          ]?.totalOpenWork ?? 0;

        if (bWork !== aWork) {
          return bWork - aWork;
        }

        return `${a.last_name} ${a.first_name}`.localeCompare(
          `${b.last_name} ${b.first_name}`
        );
      }),
    [employees, workByEmployee]
  );

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">
        <SystemHeader
          title="Verify Employees"
          subtitle="Review and verify practical competency performance only for employees within your assigned verifier scope."
          showHome={true}
          showSignOut={true}
        >
          <Link
            href="/assessments"
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
          >
            Assessments
          </Link>
        </SystemHeader>

        {message && (
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {employees.length > 0 && (
          <>
            <section className="mb-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
              <VerifyMetric
                label="Employees Available"
                value={employees.length}
              />

              <VerifyMetric
                label="Employees With Work"
                value={employeesWithOpenWork}
                valueClass="text-amber-300"
              />

              <VerifyMetric
                label="Plan Evidence"
                value={totalPlanEvidence}
                valueClass="text-amber-300"
              />

              <VerifyMetric
                label="Company Scope"
                value={companyWideCount}
                valueClass="text-cyan-300"
              />

              <VerifyMetric
                label="Employee Scope"
                value={employeeSpecificCount}
                valueClass="text-emerald-300"
              />
            </section>

            <section>
              <div className="mb-5">
                <h2 className="text-2xl font-semibold">
                  Verification Work Queue
                </h2>

                <p className="mt-1 text-sm text-slate-400">
                  Employees with active verification work appear first. Your verifier assignment still controls access.
                </p>
              </div>

              <div className="grid gap-5 md:grid-cols-2">
                {sortedEmployees.map((employee) => {
                  const fullName =
                    `${employee.first_name} ${employee.last_name}`.trim();

                  const scopeLabel =
                    employee.verifier_scope === "client"
                      ? "Entire Company"
                      : "Specific Employee";

                  const work =
                    workByEmployee[
                      employee.employee_id
                    ] ?? {
                      needsVerification: 0,
                      reverification: 0,
                      planEvidence: 0,
                      totalOpenWork: 0,
                    };

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

                      <div
                        className={`mt-6 rounded-xl border p-4 ${
                          work.totalOpenWork > 0
                            ? "border-amber-500/30 bg-amber-500/10"
                            : "border-emerald-500/20 bg-emerald-500/5"
                        }`}
                      >
                        <div className="flex items-center justify-between gap-4">
                          <div>
                            <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                              Verification Work
                            </p>

                            <p
                              className={`mt-1 text-lg font-semibold ${
                                work.totalOpenWork > 0
                                  ? "text-amber-300"
                                  : "text-emerald-300"
                              }`}
                            >
                              {work.totalOpenWork > 0
                                ? `${work.totalOpenWork} Open ${
                                    work.totalOpenWork === 1
                                      ? "Item"
                                      : "Items"
                                  }`
                                : "No Open Work"}
                            </p>
                          </div>

                          {work.planEvidence > 0 && (
                            <span className="rounded-full bg-amber-500/15 px-3 py-1 text-xs font-medium text-amber-300">
                              {work.planEvidence} Plan Evidence
                            </span>
                          )}
                        </div>

                        <div className="mt-4 grid grid-cols-3 gap-3">
                          <div>
                            <p className="text-xs text-slate-500">
                              Verify
                            </p>
                            <p className="mt-1 font-semibold text-slate-200">
                              {work.needsVerification}
                            </p>
                          </div>

                          <div>
                            <p className="text-xs text-slate-500">
                              Reverify
                            </p>
                            <p className="mt-1 font-semibold text-slate-200">
                              {work.reverification}
                            </p>
                          </div>

                          <div>
                            <p className="text-xs text-slate-500">
                              Plan Evidence
                            </p>
                            <p className="mt-1 font-semibold text-slate-200">
                              {work.planEvidence}
                            </p>
                          </div>
                        </div>
                      </div>

                      <div className="mt-4 rounded-xl border border-slate-800 bg-slate-950/50 p-4">
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
                          {work.totalOpenWork > 0
                            ? "Open Verification Work"
                            : "Practical Verification"}
                        </Link>

                        <Link
                          href={`/employees/${employee.employee_id}`}
                          className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
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

function VerifyMetric({
  label,
  value,
  valueClass = "",
}: {
  label: string;
  value: number;
  valueClass?: string;
}) {
  return (
    <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
      <p className="text-sm text-slate-400">
        {label}
      </p>

      <p
        className={`mt-2 text-3xl font-semibold ${valueClass}`}
      >
        {value}
      </p>
    </div>
  );
}

