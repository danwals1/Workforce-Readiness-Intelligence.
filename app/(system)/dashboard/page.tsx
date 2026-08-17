"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  client_id: string;
  auth_user_id: string | null;
};

type Readiness = {
  employee_id: string;
  status: string;
  readiness_percent: number;
  requirements_met: number;
  requirements_total: number;
  competencies_met: number;
  competencies_total: number;
  created_at: string;
};

type EmployeeWithReadiness = Employee & {
  readiness: Readiness | null;
};

type WorkforceReadinessRow = {
  employee_id: string;
  client_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  assessment_id: string | null;
  readiness_percent: number | null;
  readiness_status: string | null;
  competencies_ready: number | null;
  competencies_total: number | null;
  current_gap_count: number;
  open_plan_count: number;
  awaiting_evidence_count: number;
};

type DevelopmentPlanLifecycleSummary = {
  development_plan_id: string;
  employee_id: string;
  resolution_status:
    | "development_in_progress"
    | "awaiting_reassessment"
    | "awaiting_verification"
    | "awaiting_reverification"
    | "resolved"
    | "cancelled";
};

export default function DashboardPage() {
  const router = useRouter();

  const [employees, setEmployees] = useState<EmployeeWithReadiness[]>([]);
  const [message, setMessage] = useState("Loading...");
  const [isIntegrateAdmin, setIsIntegrateAdmin] = useState(false);
  const [isClientAdmin, setIsClientAdmin] = useState(false);
  const [workforceReadiness, setWorkforceReadiness] =
    useState<WorkforceReadinessRow[]>([]);

  const [developmentPlans, setDevelopmentPlans] =
    useState<DevelopmentPlanLifecycleSummary[]>([]);

  useEffect(() => {
    async function loadDashboard() {
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

      const userId = sessionData.session.user.id;

      const {
        data: roles,
        error: rolesError,
      } = await supabase
        .from("user_client_roles")
        .select(`
          role,
          client_id
        `)
        .eq("user_id", userId);

      if (rolesError) {
        setMessage(rolesError.message);
        return;
      }

      const integrateAdmin =
        roles?.some(
          (role) => role.role === "INTEGRATEU_ADMIN"
        ) ?? false;

      const clientIds =
        roles
          ?.filter(
            (role) => role.role === "CLIENT_ADMIN"
          )
          .map((role) => role.client_id)
          .filter(
            (clientId): clientId is string =>
              Boolean(clientId)
          ) ?? [];

      const clientAdmin = clientIds.length > 0;

      setIsIntegrateAdmin(integrateAdmin);
      setIsClientAdmin(clientAdmin);


      // ----------------------------------------------------------------------
      // Organization-level operational lifecycle
      //
      // Readiness actions = current workforce gaps.
      // Development plans = committed work that may remain unresolved even
      // after the current readiness gap disappears.
      // ----------------------------------------------------------------------

      if (integrateAdmin || clientAdmin) {
        const developmentPlanResult =
          await supabase.rpc(
            "wri_list_development_plan_resolutions",
            {
              p_employee_id: null,
              p_resolution_status: null,
            }
          );

        if (developmentPlanResult.error) {
          console.error(
            "Unable to load development plan lifecycle:",
            developmentPlanResult.error
          );

          setDevelopmentPlans([]);
        } else {
          setDevelopmentPlans(
            (developmentPlanResult.data ?? []) as
              DevelopmentPlanLifecycleSummary[]
          );
        }
      } else {
        setDevelopmentPlans([]);
      }


      if (integrateAdmin || clientAdmin) {
        const {
          data: workforceData,
          error: workforceError,
        } = await supabase.rpc(
          "wri_list_workforce_readiness"
        );

        if (workforceError) {
          console.error(
            "Unable to load workforce readiness:",
            workforceError
          );
          setWorkforceReadiness([]);
          setEmployees([]);
          setMessage(workforceError.message);
          return;
        }

        const workforceRows =
          (workforceData ?? []) as WorkforceReadinessRow[];

        setWorkforceReadiness(workforceRows);

        setEmployees(
          workforceRows.map((row) => ({
            id: row.employee_id,
            first_name: row.first_name,
            last_name: row.last_name,
            employee_number: row.employee_number,
            client_id: row.client_id,
            auth_user_id: null,
            readiness:
              row.assessment_id !== null &&
              row.readiness_percent !== null
                ? {
                    employee_id: row.employee_id,
                    status:
                      row.readiness_status ??
                      "not_assessed",
                    readiness_percent: Number(
                      row.readiness_percent
                    ),
                    requirements_met: Number(
                      row.competencies_ready ?? 0
                    ),
                    requirements_total: Number(
                      row.competencies_total ?? 0
                    ),
                    competencies_met: Number(
                      row.competencies_ready ?? 0
                    ),
                    competencies_total: Number(
                      row.competencies_total ?? 0
                    ),
                    created_at: "",
                  }
                : null,
          }))
        );

        setMessage("");
        return;
      }

      setWorkforceReadiness([]);

      let employeeQuery = supabase
        .from("employees")
        .select(`
          id,
          first_name,
          last_name,
          employee_number,
          client_id,
          auth_user_id
        `);

      if (integrateAdmin) {
        // IntegrateU admins can see all employees allowed by RLS.
      } else if (clientIds.length > 0) {
        employeeQuery = employeeQuery.in(
          "client_id",
          clientIds
        );
      } else {
        employeeQuery = employeeQuery.eq(
          "auth_user_id",
          userId
        );
      }

      const {
        data: employeeData,
        error: employeeError,
      } = await employeeQuery.order(
        "last_name",
        { ascending: true }
      );

      if (employeeError) {
        setMessage(employeeError.message);
        return;
      }

      if (
        !employeeData ||
        employeeData.length === 0
      ) {
        setEmployees([]);
        setMessage("");
        return;
      }

      const employeeIds =
        employeeData.map(
          (employee) => employee.id
        );

      const {
        data: readinessData,
        error: readinessError,
      } = await supabase
        .from("role_readiness")
        .select(`
          employee_id,
          status,
          readiness_percent,
          requirements_met,
          requirements_total,
          competencies_met,
          competencies_total,
          created_at
        `)
        .in(
          "employee_id",
          employeeIds
        )
        .order(
          "created_at",
          { ascending: false }
        );

      if (readinessError) {
        setMessage(readinessError.message);
        return;
      }

      const combined: EmployeeWithReadiness[] =
        employeeData.map(
          (employee) => ({
            id: employee.id,
            first_name: employee.first_name,
            last_name: employee.last_name,
            employee_number:
              employee.employee_number,
            client_id: employee.client_id,
            auth_user_id:
              employee.auth_user_id,
            readiness:
              readinessData?.find(
                (row) =>
                  row.employee_id ===
                  employee.id
              ) ?? null,
          })
        );

      setEmployees(combined);
      setMessage("");
    }

    loadDashboard();
  }, [router]);

  const canManageOrganization =
    isIntegrateAdmin || isClientAdmin;

  const isIndividualUser =
    !canManageOrganization;

  const primaryEmployee =
    employees.length === 1
      ? employees[0]
      : null;

  const averageReadiness = useMemo(() => {
    const readinessRows =
      employees
        .map(
          (employee) =>
            employee.readiness
        )
        .filter(
          (
            readiness
          ): readiness is Readiness =>
            readiness !== null
        );

    if (readinessRows.length === 0) {
      return null;
    }

    const total =
      readinessRows.reduce(
        (sum, readiness) =>
          sum +
          Number(
            readiness.readiness_percent
          ),
        0
      );

    return (
      total /
      readinessRows.length
    );
  }, [employees]);

  const readyEmployees =
    employees.filter(
      (employee) =>
        employee.readiness?.status
          ?.toUpperCase() === "READY"
    ).length;


  const workforceCurrentGaps =
    workforceReadiness.reduce(
      (sum, row) =>
        sum + Number(row.current_gap_count ?? 0),
      0
    );

  const workforceOpenPlans =
    workforceReadiness.reduce(
      (sum, row) =>
        sum + Number(row.open_plan_count ?? 0),
      0
    );

  const workforceAwaitingEvidence =
    workforceReadiness.reduce(
      (sum, row) =>
        sum +
        Number(row.awaiting_evidence_count ?? 0),
      0
    );

  const openDevelopmentPlans =
    developmentPlans.filter(
      (plan) =>
        plan.resolution_status !== "resolved" &&
        plan.resolution_status !== "cancelled"
    );


  const developmentInProgressCount =
    openDevelopmentPlans.filter(
      (plan) =>
        plan.resolution_status ===
        "development_in_progress"
    ).length;


  const employeesWithOpenWork =
    workforceReadiness.filter(
      (row) =>
        Number(row.current_gap_count ?? 0) > 0 ||
        Number(row.open_plan_count ?? 0) > 0
    ).length;

  return (
    <div>
        <header className="mb-8">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Overview
          </p>

          <h2 className="mt-2 text-3xl font-semibold">
            Workforce Readiness Overview
          </h2>

          <p className="mt-2 max-w-2xl text-sm text-slate-400">
            Current workforce readiness, open gaps, development activity,
            and evidence requiring attention.
          </p>
        </header>

        {message && (
          <div className="mb-8 rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {canManageOrganization && (
          <section className="mt-12">
            <div className="mb-5">
              <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                Workforce Operations
              </p>

              <h2 className="mt-2 text-2xl font-semibold">
                Workforce Action Overview
              </h2>

              <p className="mt-2 text-sm text-slate-400">
                Current readiness gaps and unresolved development work requiring management attention.
              </p>
            </div>

            <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-6">
              <DashboardMetric
                label="Employees"
                value={employees.length}
              />

              <DashboardMetric
                label="Ready"
                value={readyEmployees}
                detail={
                  employees.length > 0
                    ? `${readyEmployees}/${employees.length} employees`
                    : "No employees"
                }
              />

              <DashboardMetric
                label="Avg. Readiness"
                value={
                  averageReadiness !== null
                    ? `${averageReadiness.toFixed(1)}%`
                    : "—"
                }
              />

              <DashboardMetric
                label="Current Gaps"
                value={workforceCurrentGaps}
                valueClass={
                  workforceCurrentGaps > 0
                    ? "text-amber-300"
                    : ""
                }
              />

              <DashboardMetric
                label="Open Plans"
                value={workforceOpenPlans}
                detail={`${developmentInProgressCount} in development`}
                valueClass={
                  workforceOpenPlans > 0
                    ? "text-cyan-300"
                    : ""
                }
              />

              <DashboardMetric
                label="Awaiting Evidence"
                value={workforceAwaitingEvidence}
                detail={`${employeesWithOpenWork} employees with open work`}
                valueClass={
                  workforceAwaitingEvidence > 0
                    ? "text-amber-300"
                    : ""
                }
              />
            </div>

            <div className="mt-4 flex flex-wrap gap-3">
              <Link
                href="/workforce-readiness"
                className="rounded-lg border border-emerald-500/50 bg-emerald-500/10 px-4 py-2 text-sm font-medium text-emerald-300 transition hover:bg-emerald-500/20"
              >
                Open Workforce Readiness
              </Link>

              <Link
                href="/readiness-actions"
                className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20"
              >
                Open Readiness Action Center
              </Link>

              <Link
                href="/development-plans"
                className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
              >
                Open Development Plans
              </Link>
            </div>
          </section>
        )}


        {canManageOrganization && (
          <section
            id="team-readiness"
            className="mt-12"
          >
            <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
              <div>
                <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                  Workforce Readiness
                </p>

                <h2 className="mt-2 text-2xl font-semibold">
                  Team Readiness
                </h2>

                <p className="mt-2 text-sm text-slate-400">
                  Current readiness overview for your
                  accessible employees.
                </p>
              </div>

              <div className="flex flex-wrap gap-3">
                <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
                  <p className="text-xs text-slate-500">
                    Employees
                  </p>

                  <p className="mt-1 text-xl font-semibold">
                    {employees.length}
                  </p>
                </div>

                <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
                  <p className="text-xs text-slate-500">
                    Ready
                  </p>

                  <p className="mt-1 text-xl font-semibold">
                    {readyEmployees}
                  </p>
                </div>

                <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
                  <p className="text-xs text-slate-500">
                    Avg. Readiness
                  </p>

                  <p className="mt-1 text-xl font-semibold">
                    {averageReadiness !== null
                      ? `${averageReadiness.toFixed(1)}%`
                      : "—"}
                  </p>
                </div>
              </div>
            </div>

            {employees.length === 0 ? (
              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
                No team members are currently available.
              </div>
            ) : (
              <div className="grid gap-6 md:grid-cols-2">
                {employees.map(
                  (employee) => (
                    <Link
                      key={employee.id}
                      href={`/employees/${employee.id}`}
                      className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
                    >
                      <p className="text-sm text-slate-400">
                        Employee
                      </p>

                      <h3 className="mt-1 text-2xl font-semibold">
                        {employee.first_name}{" "}
                        {employee.last_name}
                      </h3>

                      {employee.employee_number && (
                        <p className="mt-2 text-sm text-slate-400">
                          {employee.employee_number}
                        </p>
                      )}

                      {employee.readiness ? (
                        <div className="mt-6">
                          <div className="flex items-end justify-between gap-4">
                            <div>
                              <p className="text-sm text-slate-400">
                                Readiness
                              </p>

                              <p className="mt-1 text-4xl font-bold">
                                {
                                  employee
                                    .readiness
                                    .readiness_percent
                                }
                                %
                              </p>
                            </div>

                            <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-sm text-emerald-300">
                              {
                                employee
                                  .readiness
                                  .status
                              }
                            </span>
                          </div>

                          <div className="mt-5 h-3 overflow-hidden rounded-full bg-slate-800">
                            <div
                              className="h-full rounded-full bg-cyan-400"
                              style={{
                                width: `${Math.min(
                                  100,
                                  Math.max(
                                    0,
                                    Number(
                                      employee
                                        .readiness
                                        .readiness_percent
                                    )
                                  )
                                )}%`,
                              }}
                            />
                          </div>

                          <div className="mt-6 grid grid-cols-2 gap-4">
                            <div>
                              <p className="text-sm text-slate-400">
                                Requirements
                              </p>

                              <p className="text-lg font-semibold">
                                {
                                  employee
                                    .readiness
                                    .requirements_met
                                }
                                /
                                {
                                  employee
                                    .readiness
                                    .requirements_total
                                }
                              </p>
                            </div>

                            <div>
                              <p className="text-sm text-slate-400">
                                Competencies
                              </p>

                              <p className="text-lg font-semibold">
                                {
                                  employee
                                    .readiness
                                    .competencies_met
                                }
                                /
                                {
                                  employee
                                    .readiness
                                    .competencies_total
                                }
                              </p>
                            </div>
                          </div>
                        </div>
                      ) : (
                        <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/50 p-4">
                          <p className="text-sm text-slate-400">
                            No readiness assessment available yet.
                          </p>
                        </div>
                      )}
                    </Link>
                  )
                )}
              </div>
            )}
          </section>
        )}

        {isIndividualUser &&
          primaryEmployee &&
          primaryEmployee.readiness && (
            <section className="mt-12">
              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
                <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                  My Current Readiness
                </p>

                <div className="mt-4 flex flex-col gap-5 sm:flex-row sm:items-end sm:justify-between">
                  <div>
                    <h2 className="text-2xl font-semibold">
                      {primaryEmployee.first_name}{" "}
                      {primaryEmployee.last_name}
                    </h2>

                    <p className="mt-2 text-sm text-slate-400">
                      Current role readiness
                    </p>
                  </div>

                  <p className="text-5xl font-bold">
                    {
                      primaryEmployee.readiness
                        .readiness_percent
                    }
                    %
                  </p>
                </div>

                <div className="mt-6 h-3 overflow-hidden rounded-full bg-slate-800">
                  <div
                    className="h-full rounded-full bg-cyan-400"
                    style={{
                      width: `${Math.min(
                        100,
                        Math.max(
                          0,
                          Number(
                            primaryEmployee
                              .readiness
                              .readiness_percent
                          )
                        )
                      )}%`,
                    }}
                  />
                </div>

                <Link
                  href={`/employees/${primaryEmployee.id}`}
                  className="mt-6 inline-block rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20"
                >
                  View My Readiness Profile
                </Link>
              </div>
            </section>
          )}
    </div>
  );
}

function DashboardMetric({
  label,
  value,
  detail,
  valueClass = "",
}: {
  label: string;
  value: number | string;
  detail?: string;
  valueClass?: string;
}) {
  return (
    <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
        {label}
      </p>

      <p
        className={`mt-2 text-3xl font-semibold ${valueClass}`}
      >
        {value}
      </p>

      {detail && (
        <p className="mt-2 text-xs text-slate-500">
          {detail}
        </p>
      )}
    </div>
  );
}
