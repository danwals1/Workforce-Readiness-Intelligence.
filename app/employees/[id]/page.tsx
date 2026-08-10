"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
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

type AssessmentSummary = {
  attempt_id: string;
  assessment_id: string;
  assessment_name: string;
  role_name: string;
  average_knowledge_score: number;
  critical_safety_score_percent: number | null;
  competencies_ready: number;
  competencies_total: number;
  readiness_percent: number;
  developing_count: number;
  critical_gap_count: number;
  practical_gap_count: number;
  readiness_status: string;
  completed_at: string;
};

type VerificationHistory = {
  verification_id: string;
  employee_id: string;
  client_id: string;

  employee_first_name: string;
  employee_last_name: string;
  employee_number: string | null;

  master_competency_template_id: string;
  competency_name: string;
  competency_category: string | null;
  competency_is_critical: boolean;

  rating_level: number;
  status: string;

  verifier_user_id: string | null;
  verifier_email: string | null;
  verifier_employee_id: string | null;
  verifier_first_name: string | null;
  verifier_last_name: string | null;

  verified_at: string | null;
  created_at: string;

  notes: string | null;
};

type DevelopmentPlanSummary = {
  development_plan_id: string;
  employee_id: string;
  action_label: string | null;
  competency_name_snapshot: string | null;
  title: string;
  status: string;
  priority: string;
  due_date: string | null;
  activities_total: number;
  activities_completed: number;
  completion_percent: number;
  overdue: boolean;
};

export default function EmployeePage() {
  const params = useParams();
  const router = useRouter();

  const employeeId =
    params.id as string;

  const [employee, setEmployee] =
    useState<Employee | null>(null);

  const [summary, setSummary] =
    useState<AssessmentSummary | null>(
      null
    );

  const [history, setHistory] =
    useState<VerificationHistory[]>([]);

  const [developmentPlans, setDevelopmentPlans] =
    useState<DevelopmentPlanSummary[]>([]);

  const [message, setMessage] =
    useState("Loading employee profile...");

  const [canVerify, setCanVerify] =
    useState(false);

  const [isOwnProfile, setIsOwnProfile] =
    useState(false);

  useEffect(() => {
    async function loadEmployee() {
      setMessage(
        "Loading employee profile..."
      );

      const {
        data: sessionData,
        error: sessionError,
      } = await supabase.auth.getSession();

      if (sessionError) {
        setMessage(
          sessionError.message
        );
        return;
      }

      if (!sessionData.session) {
        router.push("/");
        return;
      }

      const userId =
        sessionData.session.user.id;

      // --------------------------------------------------
      // Employee
      // --------------------------------------------------

      const {
        data: employeeData,
        error: employeeError,
      } = await supabase
        .from("employees")
        .select(`
          id,
          first_name,
          last_name,
          employee_number,
          client_id,
          auth_user_id
        `)
        .eq("id", employeeId)
        .maybeSingle();

      if (
        employeeError ||
        !employeeData
      ) {
        setMessage(
          "Employee not found or access denied."
        );
        return;
      }

      const ownProfile =
        employeeData.auth_user_id ===
        userId;

      setIsOwnProfile(
        ownProfile
      );

      // --------------------------------------------------
      // Admin permissions
      // --------------------------------------------------

      const {
        data: roles,
        error: rolesError,
      } = await supabase
        .from("user_client_roles")
        .select(`
          role,
          client_id
        `)
        .eq(
          "user_id",
          userId
        );

      if (rolesError) {
        setMessage(
          rolesError.message
        );
        return;
      }

      const isIntegrateAdmin =
        roles?.some(
          (role) =>
            role.role ===
            "INTEGRATEU_ADMIN"
        ) ?? false;

      const allowedClients =
        roles
          ?.filter(
            (role) =>
              role.role ===
              "CLIENT_ADMIN"
          )
          .map(
            (role) =>
              role.client_id
          )
          .filter(
            (
              clientId
            ): clientId is string =>
              Boolean(clientId)
          ) ?? [];

      const isClientAdmin =
        allowedClients.includes(
          employeeData.client_id
        );

      // --------------------------------------------------
      // Practical-verifier permission
      //
      // Self-verification correctly returns false.
      // --------------------------------------------------

      const {
        data: verifyPermission,
        error: verifyPermissionError,
      } = await supabase.rpc(
        "wri_can_verify_master_practical",
        {
          p_employee_id:
            employeeId,
        }
      );

      if (
        verifyPermissionError
      ) {
        console.error(
          "Verifier permission check failed:",
          verifyPermissionError
        );
      }

      const verifierPermission =
        verifyPermission === true;

      setCanVerify(
        verifierPermission
      );

      // --------------------------------------------------
      // Profile authorization
      //
      // Employee may see self.
      // Admin may see allowed employees.
      // Assigned verifier may see employee.
      // --------------------------------------------------

      const canView =
        ownProfile ||
        isIntegrateAdmin ||
        isClientAdmin ||
        verifierPermission;

      if (!canView) {
        setMessage(
          "Employee not found or access denied."
        );
        return;
      }

      setEmployee(
        employeeData as Employee
      );

      // --------------------------------------------------
      // Latest assessment-readiness summary
      // --------------------------------------------------

      const {
        data: summaryData,
        error: summaryError,
      } = await supabase
        .from(
          "v_employee_assessment_summary"
        )
        .select(`
          attempt_id,
          assessment_id,
          assessment_name,
          role_name,
          average_knowledge_score,
          critical_safety_score_percent,
          competencies_ready,
          competencies_total,
          readiness_percent,
          developing_count,
          critical_gap_count,
          practical_gap_count,
          readiness_status,
          completed_at
        `)
        .eq(
          "employee_id",
          employeeId
        )
        .order(
          "completed_at",
          {
            ascending: false,
          }
        )
        .limit(1)
        .maybeSingle();

      if (summaryError) {
        console.error(
          "Assessment summary failed:",
          summaryError
        );
      }

      setSummary(
        summaryData as
          | AssessmentSummary
          | null
      );

      // --------------------------------------------------
      // Practical verification audit history
      // --------------------------------------------------

      const {
        data: historyData,
        error: historyError,
      } = await supabase.rpc(
        "wri_list_practical_verification_history",
        {
          p_employee_id:
            employeeId,
        }
      );

      if (historyError) {
        console.error(
          "Verification history failed:",
          historyError
        );
      } else {
        setHistory(
          (historyData ??
            []) as VerificationHistory[]
        );
      }


    // Development plans
    const {
      data: developmentPlanData,
      error: developmentPlanError,
    } = await supabase.rpc(
      "wri_list_development_plans",
      {
        p_employee_id: employeeId,
        p_status: null,
      }
    );

    if (developmentPlanError) {
      console.error(
        "Development plans failed:",
        developmentPlanError
      );
    } else {
      setDevelopmentPlans(
        (developmentPlanData ?? []) as DevelopmentPlanSummary[]
      );
    }

      setMessage("");
    }

    loadEmployee();
  }, [employeeId, router]);

  async function logout() {
    await supabase.auth.signOut();

    router.push("/");
  }

  function statusLabel(
    status: string
  ) {
    switch (status) {
      case "ready":
        return "Ready";

      case "safety_gap":
        return "Safety Gap";

      case "critical_gap":
        return "Critical Gap";

      case "developing":
        return "Developing";

      case "practical_verification_needed":
        return "Practical Verification Needed";

      case "practical_development_needed":
        return "Practical Development Needed";

      default:
        return status;
    }
  }

  function statusClasses(
    status: string
  ) {
    switch (status) {
      case "ready":
        return "bg-emerald-500/15 text-emerald-300";

      case "safety_gap":
      case "critical_gap":
        return "bg-rose-500/15 text-rose-300";

      case "developing":
      case "practical_verification_needed":
      case "practical_development_needed":
        return "bg-amber-500/15 text-amber-300";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function verificationStatusClasses(
    status: string
  ) {
    switch (status) {
      case "verified":
        return "bg-emerald-500/15 text-emerald-300";

      case "rejected":
        return "bg-rose-500/15 text-rose-300";

      case "pending":
        return "bg-amber-500/15 text-amber-300";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function proficiencyLabel(
    level: number
  ) {
    switch (level) {
      case 1:
        return "Awareness";

      case 2:
        return "Working Knowledge";

      case 3:
        return "Proficient / Independent";

      case 4:
        return "Advanced / Can Lead or Coach";

      default:
        return "";
    }
  }

  function verifierName(
    item: VerificationHistory
  ) {
    const fullName = [
      item.verifier_first_name,
      item.verifier_last_name,
    ]
      .filter(Boolean)
      .join(" ");

    return (
      fullName ||
      item.verifier_email ||
      "Unknown verifier"
    );
  }

  function formatDate(
    value: string | null
  ) {
    if (!value) {
      return "—";
    }

    return new Date(
      value
    ).toLocaleString();
  }

  const uniqueVerifiedCompetencies =
    useMemo(
      () =>
        new Set(
          history
            .filter(
              (item) =>
                item.status ===
                "verified"
            )
            .map(
              (item) =>
                item.master_competency_template_id
            )
        ).size,
      [history]
    );

  if (!employee) {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-6xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            {message}
          </div>

          <Link
            href="/dashboard"
            className="mt-6 inline-block text-cyan-400 hover:text-cyan-300"
          >
            ← Back to Dashboard
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">

        {/* Header */}

        <div className="mb-10 flex flex-col gap-6 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">
              IntegrateU
            </p>

            <h1 className="mt-2 text-3xl font-semibold">
              Employee Readiness Profile
            </h1>

            <p className="mt-2 text-slate-400">
              Assessment performance,
              competency readiness, and
              practical verification
              history.
            </p>
          </div>

          <div className="flex flex-wrap gap-3">
            <Link
              href="/dashboard"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
            >
              ← Dashboard
            </Link>

            {!isOwnProfile &&
              canVerify && (
                <Link
                  href={`/employees/${employee.id}/practical-verification`}
                  className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                >
                  Practical Verification
                </Link>
              )}

            <button
              onClick={logout}
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800"
            >
              Sign Out
            </button>
          </div>
        </div>

        {/* Employee */}

        <section className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
          <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-sm text-slate-400">
                Employee
              </p>

              <h2 className="mt-1 text-3xl font-semibold">
                {employee.first_name}{" "}
                {employee.last_name}
              </h2>

              {employee.employee_number && (
                <p className="mt-1 text-sm text-slate-500">
                  {
                    employee.employee_number
                  }
                </p>
              )}
            </div>

            {summary && (
              <span
                className={`w-fit rounded-full px-3 py-1 text-sm font-medium ${statusClasses(
                  summary.readiness_status
                )}`}
              >
                {statusLabel(
                  summary.readiness_status
                )}
              </span>
            )}
          </div>

          {!summary ? (
            <div className="mt-8 rounded-xl border border-slate-800 bg-slate-950/50 p-5">
              <p className="font-medium">
                No completed assessment
                yet
              </p>

              <p className="mt-2 text-sm text-slate-400">
                Assessment and readiness
                information will appear
                here after completion.
              </p>
            </div>
          ) : (
            <>
              <div className="mt-8">
                <p className="text-sm text-slate-400">
                  {
                    summary.assessment_name
                  }
                </p>

                <p className="mt-1 text-lg font-medium">
                  {summary.role_name}
                </p>
              </div>

              <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/50 p-5">
                <div className="flex items-end justify-between gap-4">
                  <div>
                    <p className="text-sm text-slate-400">
                      Role Readiness
                    </p>

                    <p className="mt-1 text-4xl font-bold">
                      {
                        summary.readiness_percent
                      }
                      %
                    </p>
                  </div>

                  <div className="text-right">
                    <p className="text-sm text-slate-400">
                      Competencies Ready
                    </p>

                    <p className="mt-1 text-xl font-semibold">
                      {
                        summary.competencies_ready
                      }
                      /
                      {
                        summary.competencies_total
                      }
                    </p>
                  </div>
                </div>

                <div className="mt-4 h-3 overflow-hidden rounded-full bg-slate-800">
                  <div
                    className="h-full rounded-full bg-cyan-400"
                    style={{
                      width: `${Math.min(
                        100,
                        Math.max(
                          0,
                          Number(
                            summary.readiness_percent
                          )
                        )
                      )}%`,
                    }}
                  />
                </div>
              </div>

              <div className="mt-4 grid gap-4 sm:grid-cols-2">
                <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
                  <p className="text-sm text-slate-400">
                    Knowledge
                  </p>

                  <p className="mt-1 text-2xl font-semibold">
                    {
                      summary.average_knowledge_score
                    }
                    %
                  </p>
                </div>

                <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
                  <p className="text-sm text-slate-400">
                    Critical Safety
                  </p>

                  <p
                    className={`mt-1 text-2xl font-semibold ${
                      summary.critical_safety_score_percent !==
                        null &&
                      summary.critical_safety_score_percent <
                        80
                        ? "text-rose-300"
                        : ""
                    }`}
                  >
                    {summary.critical_safety_score_percent !==
                    null
                      ? `${summary.critical_safety_score_percent}%`
                      : "—"}
                  </p>
                </div>
              </div>

              <div className="mt-4 grid grid-cols-3 gap-3">
                <div className="rounded-xl bg-slate-950/50 p-4">
                  <p className="text-xs text-slate-500">
                    Developing
                  </p>

                  <p className="mt-1 text-xl font-semibold text-amber-300">
                    {
                      summary.developing_count
                    }
                  </p>
                </div>

                <div className="rounded-xl bg-slate-950/50 p-4">
                  <p className="text-xs text-slate-500">
                    Critical Gaps
                  </p>

                  <p className="mt-1 text-xl font-semibold text-rose-300">
                    {
                      summary.critical_gap_count
                    }
                  </p>
                </div>

                <div className="rounded-xl bg-slate-950/50 p-4">
                  <p className="text-xs text-slate-500">
                    Practical Gaps
                  </p>

                  <p className="mt-1 text-xl font-semibold text-amber-300">
                    {
                      summary.practical_gap_count
                    }
                  </p>
                </div>
              </div>

              <div className="mt-6">
                <Link
                  href={`/assessments/attempts/${summary.attempt_id}/results`}
                  className="inline-block rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
                >
                  View Assessment Results
                </Link>
              </div>
            </>
          )}
        </section>


    {/* Development Plans */}

    <section className="mt-8">
      <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h2 className="text-2xl font-semibold">
            Development Plans
          </h2>

          <p className="mt-1 text-sm text-slate-400">
            Development work tied to this employee&apos;s readiness gaps.
          </p>
        </div>

        <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
          <p className="text-xs text-slate-500">
            Total Plans
          </p>

          <p className="mt-1 text-xl font-semibold">
            {developmentPlans.length}
          </p>
        </div>
      </div>

      {developmentPlans.length === 0 ? (
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
          No development plans have been created for this employee yet.
        </div>
      ) : (
        <div className="space-y-4">
          {developmentPlans.map((plan) => (
            <article
              key={plan.development_plan_id}
              className="rounded-2xl border border-slate-800 bg-slate-900 p-5 sm:p-6"
            >
              <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
                <div>
                  <div className="flex flex-wrap gap-2">
                    <span className="rounded-full bg-cyan-500/15 px-3 py-1 text-xs font-medium text-cyan-300">
                      {plan.status
                        .split("_")
                        .map(
                          (word) =>
                            word.charAt(0).toUpperCase() +
                            word.slice(1)
                        )
                        .join(" ")}
                    </span>

                    <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                      {plan.priority.charAt(0).toUpperCase() +
                        plan.priority.slice(1)}{" "}
                      Priority
                    </span>

                    {plan.overdue && (
                      <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                        Overdue
                      </span>
                    )}
                  </div>

                  <h3 className="mt-3 text-xl font-semibold">
                    {plan.title}
                  </h3>

                  {plan.competency_name_snapshot && (
                    <p className="mt-2 text-sm text-slate-400">
                      {plan.competency_name_snapshot}
                    </p>
                  )}

                  {plan.action_label && (
                    <p className="mt-1 text-xs text-slate-500">
                      Created from: {plan.action_label}
                    </p>
                  )}
                </div>

                <div className="w-full sm:max-w-xs">
                  <div className="rounded-xl bg-slate-950/50 p-4">
                    <div className="flex justify-between">
                      <span className="text-sm text-slate-400">
                        Progress
                      </span>

                      <span className="font-semibold">
                        {plan.completion_percent}%
                      </span>
                    </div>

                    <div className="mt-3 h-2 overflow-hidden rounded-full bg-slate-800">
                      <div
                        className="h-full rounded-full bg-cyan-400"
                        style={{
                          width: `${Math.min(
                            100,
                            Math.max(
                              0,
                              Number(plan.completion_percent)
                            )
                          )}%`,
                        }}
                      />
                    </div>

                    <p className="mt-2 text-xs text-slate-500">
                      {plan.activities_completed}/
                      {plan.activities_total} activities complete
                    </p>
                  </div>
                </div>
              </div>

              <div className="mt-5 flex flex-wrap items-center justify-between gap-3 border-t border-slate-800 pt-4">
                <p className="text-sm text-slate-400">
                  {plan.due_date
                    ? `Due ${new Date(
                        `${plan.due_date}T12:00:00`
                      ).toLocaleDateString()}`
                    : "No due date"}
                </p>

                <Link
                  href={`/development-plans/${plan.development_plan_id}`}
                  className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20"
                >
                  Open Plan
                </Link>
              </div>
            </article>
          ))}
        </div>
      )}
    </section>

        {/* Verification History */}

        <section className="mt-8">
          <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
            <div>
              <h2 className="text-2xl font-semibold">
                Practical Verification
                History
              </h2>

              <p className="mt-1 text-sm text-slate-400">
                Complete audit trail of
                practical competency
                verification activity.
              </p>
            </div>

            <div className="flex gap-3">
              <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
                <p className="text-xs text-slate-500">
                  History Events
                </p>

                <p className="mt-1 text-xl font-semibold">
                  {history.length}
                </p>
              </div>

              <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
                <p className="text-xs text-slate-500">
                  Competencies Verified
                </p>

                <p className="mt-1 text-xl font-semibold text-emerald-300">
                  {
                    uniqueVerifiedCompetencies
                  }
                </p>
              </div>
            </div>
          </div>

          {history.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
              No practical verification
              history has been recorded yet.
            </div>
          ) : (
            <div className="space-y-4">
              {history.map(
                (item) => (
                  <article
                    key={
                      item.verification_id
                    }
                    className="rounded-2xl border border-slate-800 bg-slate-900 p-5 sm:p-6"
                  >
                    <div className="flex flex-col gap-5 lg:flex-row lg:items-start lg:justify-between">
                      <div className="max-w-3xl">
                        <div className="flex flex-wrap items-center gap-2">
                          {item.competency_category && (
                            <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                              {
                                item.competency_category
                              }
                            </span>
                          )}

                          {item.competency_is_critical && (
                            <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                              Critical
                            </span>
                          )}

                          <span
                            className={`rounded-full px-3 py-1 text-xs font-medium ${verificationStatusClasses(
                              item.status
                            )}`}
                          >
                            {item.status}
                          </span>
                        </div>

                        <h3 className="mt-3 text-xl font-semibold">
                          {
                            item.competency_name
                          }
                        </h3>

                        <p className="mt-3 text-sm text-slate-400">
                          Verified by{" "}
                          <span className="font-medium text-slate-300">
                            {verifierName(
                              item
                            )}
                          </span>
                        </p>

                        {item.verifier_email && (
                          <p className="mt-1 text-xs text-slate-500">
                            {
                              item.verifier_email
                            }
                          </p>
                        )}

                        {item.notes && (
                          <div className="mt-4 rounded-xl border border-slate-800 bg-slate-950/50 p-4">
                            <p className="text-xs uppercase tracking-wide text-slate-500">
                              Verification
                              Notes
                            </p>

                            <p className="mt-2 whitespace-pre-wrap text-sm leading-6 text-slate-300">
                              {item.notes}
                            </p>
                          </div>
                        )}
                      </div>

                      <div className="grid min-w-[250px] grid-cols-2 gap-3">
                        <div className="rounded-xl bg-slate-950/50 p-4">
                          <p className="text-xs text-slate-500">
                            Rating
                          </p>

                          <p className="mt-1 text-2xl font-semibold">
                            Level{" "}
                            {
                              item.rating_level
                            }
                          </p>

                          <p className="mt-1 text-xs text-slate-400">
                            {proficiencyLabel(
                              item.rating_level
                            )}
                          </p>
                        </div>

                        <div className="rounded-xl bg-slate-950/50 p-4">
                          <p className="text-xs text-slate-500">
                            Verified
                          </p>

                          <p className="mt-1 text-sm font-medium">
                            {formatDate(
                              item.verified_at ??
                                item.created_at
                            )}
                          </p>
                        </div>
                      </div>
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
