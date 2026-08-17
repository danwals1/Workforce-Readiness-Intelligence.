"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import SystemHeader from "@/components/SystemHeader";
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
  action_type: string | null;
  action_label: string | null;
  competency_name_snapshot: string | null;
  title: string;
  status: string;
  resolution_status: string | null;
  development_completed_at: string | null;
  awaiting_evidence_since: string | null;
  resolved_at: string | null;
  resolution_notes: string | null;
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

  function resolutionStatusLabel(
    status: string | null
  ) {
    switch (status) {
      case "development_in_progress":
        return "Development In Progress";

      case "awaiting_reassessment":
        return "Awaiting Reassessment";

      case "awaiting_verification":
        return "Awaiting Verification";

      case "awaiting_reverification":
        return "Awaiting Reverification";

      case "resolved":
        return "Resolved";

      case "cancelled":
        return "Cancelled";

      default:
        return status ?? "Development In Progress";
    }
  }


  function resolutionStatusClasses(
    status: string | null
  ) {
    switch (status) {
      case "development_in_progress":
        return "bg-cyan-500/15 text-cyan-300";

      case "awaiting_reassessment":
        return "bg-violet-500/15 text-violet-300";

      case "awaiting_verification":
        return "bg-amber-500/15 text-amber-300";

      case "awaiting_reverification":
        return "bg-orange-500/15 text-orange-300";

      case "resolved":
        return "bg-emerald-500/15 text-emerald-300";

      case "cancelled":
        return "bg-slate-800 text-slate-400";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }


  function planProgressDetail(
    plan: DevelopmentPlanSummary
  ) {
    switch (plan.resolution_status) {
      case "awaiting_reassessment":
        return "Development complete · reassessment required";

      case "awaiting_verification":
        return "Development complete · practical verification required";

      case "awaiting_reverification":
        return "Development complete · practical reverification required";

      case "resolved":
        return "Development and required evidence complete";

      case "cancelled":
        return "Plan cancelled";

      default:
        return `${plan.activities_completed}/${plan.activities_total} activities complete`;
    }
  }


  function resolutionActionLabel(
    status: string | null
  ) {
    switch (status) {
      case "development_in_progress":
        return "Complete Development Activities";

      case "awaiting_reassessment":
        return "Complete Reassessment";

      case "awaiting_verification":
        return "Complete Practical Verification";

      case "awaiting_reverification":
        return "Complete Practical Reverification";

      case "resolved":
        return "Resolved";

      case "cancelled":
        return "Cancelled";

      default:
        return "Review Development Plan";
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

function displayedPlanProgress(
  plan: DevelopmentPlanSummary
) {
  return plan.status === "completed"
    ? 100
    : Number(plan.completion_percent);
}

  const openDevelopmentPlans = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status !== "resolved" &&
          plan.resolution_status !== "cancelled"
      ),
    [developmentPlans]
  );

  const resolvedDevelopmentPlans = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status === "resolved"
      ),
    [developmentPlans]
  );


  const developmentPlansInProgress = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status ===
          "development_in_progress"
      ),
    [developmentPlans]
  );


  const awaitingReassessmentPlans = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status ===
          "awaiting_reassessment"
      ),
    [developmentPlans]
  );


  const awaitingVerificationPlans = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status ===
          "awaiting_verification"
      ),
    [developmentPlans]
  );


  const awaitingReverificationPlans = useMemo(
    () =>
      developmentPlans.filter(
        (plan) =>
          plan.resolution_status ===
          "awaiting_reverification"
      ),
    [developmentPlans]
  );


  const nextRequiredPlan =
    openDevelopmentPlans[0] ?? null;


  const knowledgeGapCount =
    summary
      ? Number(summary.developing_count) +
        Number(summary.critical_gap_count)
      : 0;

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


  const latestVerificationByCompetency =
    useMemo(() => {
      const latest =
        new Map<string, VerificationHistory>();

      for (const item of history) {
        const existing =
          latest.get(
            item.master_competency_template_id
          );

        if (!existing) {
          latest.set(
            item.master_competency_template_id,
            item
          );
          continue;
        }

        const itemTime =
          new Date(
            item.verified_at ??
              item.created_at
          ).getTime();

        const existingTime =
          new Date(
            existing.verified_at ??
              existing.created_at
          ).getTime();

        if (itemTime > existingTime) {
          latest.set(
            item.master_competency_template_id,
            item
          );
        }
      }

      return Array.from(
        latest.values()
      ).sort(
        (a, b) =>
          new Date(
            b.verified_at ??
              b.created_at
          ).getTime() -
          new Date(
            a.verified_at ??
              a.created_at
          ).getTime()
      );
    }, [history]);

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
            ← RISE Home
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">

        {/* Header */}

        <SystemHeader
          title="Employee Readiness Profile"
          subtitle="Assessment performance, competency readiness, and practical verification history."
          showHome={true}
          showSignOut={true}
        >
          {!isOwnProfile && canVerify && (
            <Link
              href={`/employees/${employee.id}/practical-verification`}
              className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
            >
              Practical Verification
            </Link>
          )}
        </SystemHeader>

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
            <div className="mt-6 flex flex-wrap gap-3">
              <div className="rounded-xl border border-slate-800 bg-slate-950/50 px-4 py-3">
                <p className="text-xs text-slate-500">
                  Open Plans
                </p>

                <p className="mt-1 text-xl font-semibold">
                  {openDevelopmentPlans.length}
                </p>
              </div>

              <div className="rounded-xl border border-slate-800 bg-slate-950/50 px-4 py-3">
                <p className="text-xs text-slate-500">
                  Resolved
                </p>

                <p className="mt-1 text-xl font-semibold">
                  {resolvedDevelopmentPlans.length}
                </p>
              </div>
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
      Number(summary.readiness_percent)
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
                  className="inline-block rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
                >
                  View Assessment Results
                </Link>
              </div>
            </>
          )}
        </section>


    {/* Readiness Overview */}

<section className="mt-8 rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
  <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
    <div>
      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
        Workforce Readiness
      </p>

      <h2 className="mt-2 text-2xl font-semibold">
        Readiness Overview
      </h2>

      <p className="mt-1 max-w-3xl text-sm text-slate-400">
        Current role readiness, active development work, and the next evidence or development action required.
      </p>
    </div>

    {summary && (
      <span
        className={`w-fit rounded-full px-3 py-1 text-sm font-medium ${statusClasses(
          summary.readiness_status
        )}`}
      >
        {statusLabel(summary.readiness_status)}
      </span>
    )}
  </div>


  <div className="mt-7 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">

    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-5">
      <p className="text-sm text-slate-500">
        Overall Readiness
      </p>

      <p className="mt-2 text-3xl font-bold">
        {summary
          ? `${summary.readiness_percent}%`
          : "—"}
      </p>

      <p className="mt-2 text-xs text-slate-500">
        {summary
          ? `${summary.competencies_ready} of ${summary.competencies_total} competencies ready`
          : "No completed assessment"}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-5">
      <p className="text-sm text-slate-500">
        Current Role
      </p>

      <p className="mt-2 text-xl font-semibold">
        {summary?.role_name ?? "—"}
      </p>

      <p className="mt-2 text-xs text-slate-500">
        {summary?.assessment_name ??
          "No role assessment available"}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-5">
      <p className="text-sm text-slate-500">
        Knowledge Gaps
      </p>

      <p
        className={`mt-2 text-3xl font-bold ${
          knowledgeGapCount > 0
            ? "text-amber-300"
            : "text-emerald-300"
        }`}
      >
        {summary ? knowledgeGapCount : "—"}
      </p>

      <p className="mt-2 text-xs text-slate-500">
        {summary
          ? `${summary.critical_gap_count} critical · ${summary.developing_count} developing`
          : "No assessment data"}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-5">
      <p className="text-sm text-slate-500">
        Practical Gaps
      </p>

      <p
        className={`mt-2 text-3xl font-bold ${
          summary &&
          Number(summary.practical_gap_count) > 0
            ? "text-amber-300"
            : "text-emerald-300"
        }`}
      >
        {summary
          ? summary.practical_gap_count
          : "—"}
      </p>

      <p className="mt-2 text-xs text-slate-500">
        Current competency practical requirements
      </p>
    </div>
  </div>


  <div className="mt-4 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">

    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">
        Development In Progress
      </p>

      <p className="mt-1 text-2xl font-semibold">
        {developmentPlansInProgress.length}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">
        Awaiting Reassessment
      </p>

      <p className="mt-1 text-2xl font-semibold">
        {awaitingReassessmentPlans.length}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">
        Awaiting Verification
      </p>

      <p className="mt-1 text-2xl font-semibold">
        {awaitingVerificationPlans.length}
      </p>
    </div>


    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">
        Awaiting Reverification
      </p>

      <p className="mt-1 text-2xl font-semibold">
        {awaitingReverificationPlans.length}
      </p>
    </div>
  </div>


  <div className="mt-6 rounded-xl border border-cyan-500/20 bg-cyan-500/10 p-5">
    <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
      <div>
        <p className="text-xs font-medium uppercase tracking-wide text-cyan-300/70">
          Next Required Action
        </p>

        {nextRequiredPlan ? (
          <>
            <p className="mt-2 text-lg font-semibold text-cyan-100">
              {resolutionActionLabel(
                nextRequiredPlan.resolution_status
              )}
            </p>

            <p className="mt-1 text-sm text-slate-300">
              {nextRequiredPlan.competency_name_snapshot ??
                nextRequiredPlan.title}
            </p>

            <p className="mt-1 text-xs text-slate-500">
              {resolutionStatusLabel(
                nextRequiredPlan.resolution_status
              )}
              {" · "}
              {nextRequiredPlan.priority
                .charAt(0)
                .toUpperCase() +
                nextRequiredPlan.priority.slice(1)}
              {" priority"}
            </p>
          </>
        ) : (
          <>
            <p className="mt-2 text-lg font-semibold text-emerald-300">
              No Open Development Actions
            </p>

            <p className="mt-1 text-sm text-slate-400">
              There are no unresolved Development Plans for this employee.
            </p>
          </>
        )}
      </div>

      {nextRequiredPlan && (
        <Link
          href={`/development-plans/${nextRequiredPlan.development_plan_id}`}
          className="w-fit rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
        >
          Open Development Plan
        </Link>
      )}
    </div>
  </div>
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

    <div className="flex gap-3">
      <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
        <p className="text-xs text-slate-500">
          Open Plans
        </p>

        <p className="mt-1 text-xl font-semibold">
          {openDevelopmentPlans.length}
        </p>
      </div>

      <div className="rounded-xl border border-slate-800 bg-slate-900 px-4 py-3">
        <p className="text-xs text-slate-500">
          Resolved
        </p>

        <p className="mt-1 text-xl font-semibold">
          {resolvedDevelopmentPlans.length}
        </p>
      </div>
    </div>
  </div>

  {developmentPlans.length === 0 ? (
    <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
      No development plans have been created for this employee yet.
    </div>
  ) : (
    <>
      <div>
        <h3 className="text-lg font-semibold">
          Open Plans
        </h3>

        <p className="mt-1 text-sm text-slate-400">
          Readiness work that still requires action.
        </p>
      </div>

      {openDevelopmentPlans.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
          No open development plans.
        </div>
      ) : (
        <div className="mt-4 space-y-4">
          {openDevelopmentPlans.map((plan) => (
            <article
              key={plan.development_plan_id}
              className="rounded-2xl border border-slate-800 bg-slate-900 p-5 sm:p-6"
            >
              <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
                <div>
                  <div className="flex flex-wrap gap-2">
                    <span
                      className={`rounded-full px-3 py-1 text-xs font-medium ${resolutionStatusClasses(
                        plan.resolution_status
                      )}`}
                    >
                      {resolutionStatusLabel(
                        plan.resolution_status
                      )}
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

                  <div className="mt-4 rounded-lg border border-slate-800 bg-slate-950/40 px-4 py-3">
                    <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                      Next Action
                    </p>

                    <p className="mt-1 text-sm font-medium text-slate-200">
                      {resolutionActionLabel(
                        plan.resolution_status
                      )}
                    </p>
                  </div>
                </div>

                <div className="w-full sm:max-w-xs">
                  <div className="rounded-xl bg-slate-950/50 p-4">
                    <div className="flex justify-between">
                      <span className="text-sm text-slate-400">
                        Development Progress
                      </span>

                      <span className="font-semibold">
                        {displayedPlanProgress(plan)}%
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
                              displayedPlanProgress(plan)
                            )
                          )}%`,
                        }}
                      />
                    </div>

                    <p className="mt-2 text-xs text-slate-500">
                      {planProgressDetail(plan)}
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

      {resolvedDevelopmentPlans.length > 0 && (
        <div className="mt-8">
          <h3 className="text-lg font-semibold">
            Resolved Plans
          </h3>

          <p className="mt-1 text-sm text-slate-400">
            Completed readiness work and closed development plans.
          </p>

          <div className="mt-4 space-y-3">
            {resolvedDevelopmentPlans.map((plan) => (
              <article
                key={plan.development_plan_id}
                className="rounded-xl border border-slate-800 bg-slate-900/60 p-5"
              >
                <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                  <div>
                    <div className="flex flex-wrap gap-2">
                      <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-xs font-medium text-emerald-300">
                        Resolved
                      </span>

                      <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                        {plan.priority.charAt(0).toUpperCase() +
                          plan.priority.slice(1)}{" "}
                        Priority
                      </span>
                    </div>

                    <h4 className="mt-3 text-lg font-semibold">
                      {plan.title}
                    </h4>

                    {plan.competency_name_snapshot && (
                      <p className="mt-1 text-sm text-slate-400">
                        {plan.competency_name_snapshot}
                      </p>
                    )}

                    {plan.action_label && (
                      <p className="mt-1 text-xs text-slate-500">
                        Created from: {plan.action_label}
                      </p>
                    )}
                  </div>

                  <div className="flex items-center gap-4">
                    <div className="text-right">
                      <p className="text-xs text-slate-500">
                        Progress
                      </p>

                      <p className="text-xl font-semibold text-emerald-300">
                        100%
                      </p>
                    </div>

                    <Link
                      href={`/development-plans/${plan.development_plan_id}`}
                      className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
                    >
                      View Plan
                    </Link>
                  </div>
                </div>
              </article>
            ))}
          </div>
        </div>
      )}
    </>
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
              No practical verification history has been recorded yet.
            </div>
          ) : (
            <div className="space-y-8">

              {/* Latest Verification by Competency */}

              <div>
                <div className="mb-4">
                  <h3 className="text-lg font-semibold">
                    Latest Verification by Competency
                  </h3>

                  <p className="mt-1 text-sm text-slate-400">
                    Most recent practical verification recorded for each competency.
                  </p>
                </div>

                <div className="grid gap-4 lg:grid-cols-2">
                  {latestVerificationByCompetency.map(
                    (item) => (
                      <article
                        key={
                          item.master_competency_template_id
                        }
                        className="rounded-2xl border border-slate-800 bg-slate-900 p-5"
                      >
                        <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
                          <div className="min-w-0">
                            <div className="flex flex-wrap items-center gap-2">
                              <span
                                className={`rounded-full px-3 py-1 text-xs font-medium ${verificationStatusClasses(
                                  item.status
                                )}`}
                              >
                                {item.status}
                              </span>

                              {item.competency_is_critical && (
                                <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                                  Critical
                                </span>
                              )}

                              <span className="rounded-full bg-cyan-500/15 px-3 py-1 text-xs font-medium text-cyan-300">
                                Latest
                              </span>
                            </div>

                            <h4 className="mt-3 text-lg font-semibold">
                              {item.competency_name}
                            </h4>

                            {item.competency_category && (
                              <p className="mt-1 text-sm text-slate-500">
                                {item.competency_category}
                              </p>
                            )}

                            <p className="mt-3 text-sm text-slate-400">
                              Verified by{" "}
                              <span className="font-medium text-slate-300">
                                {verifierName(item)}
                              </span>
                            </p>

                            {item.notes && (
                              <p className="mt-3 line-clamp-2 text-sm leading-6 text-slate-500">
                                {item.notes}
                              </p>
                            )}
                          </div>

                          <div className="shrink-0 sm:text-right">
                            <p className="text-xs uppercase tracking-wide text-slate-500">
                              Current Level
                            </p>

                            <p className="mt-1 text-2xl font-semibold">
                              Level {item.rating_level}
                            </p>

                            <p className="mt-1 max-w-[180px] text-xs text-slate-400">
                              {proficiencyLabel(
                                item.rating_level
                              )}
                            </p>

                            <p className="mt-3 text-xs text-slate-500">
                              {formatDate(
                                item.verified_at ??
                                  item.created_at
                              )}
                            </p>
                          </div>
                        </div>
                      </article>
                    )
                  )}
                </div>
              </div>


              {/* Full immutable audit trail */}

              <details className="rounded-2xl border border-slate-800 bg-slate-900">
                <summary className="cursor-pointer list-none p-5 sm:p-6">
                  <div className="flex items-center justify-between gap-4">
                    <div>
                      <h3 className="text-lg font-semibold">
                        Full Verification Audit History
                      </h3>

                      <p className="mt-1 text-sm text-slate-400">
                        All {history.length} immutable verification events, including prior and superseded records.
                      </p>
                    </div>

                    <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                      {history.length} Events
                    </span>
                  </div>
                </summary>

                <div className="border-t border-slate-800 p-5 sm:p-6">
                  <div className="space-y-3">
                    {history.map((item) => {
                      const latestItem =
                        latestVerificationByCompetency.find(
                          (latest) =>
                            latest.verification_id ===
                            item.verification_id
                        );

                      return (
                        <article
                          key={item.verification_id}
                          className={`rounded-xl border p-4 ${
                            latestItem
                              ? "border-slate-700 bg-slate-950/60"
                              : "border-slate-800 bg-slate-950/30"
                          }`}
                        >
                          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
                            <div className="min-w-0">
                              <div className="flex flex-wrap items-center gap-2">
                                <span
                                  className={`rounded-full px-2.5 py-1 text-xs font-medium ${verificationStatusClasses(
                                    item.status
                                  )}`}
                                >
                                  {item.status}
                                </span>

                                {latestItem ? (
                                  <span className="rounded-full bg-cyan-500/15 px-2.5 py-1 text-xs font-medium text-cyan-300">
                                    Current
                                  </span>
                                ) : (
                                  <span className="rounded-full bg-slate-800 px-2.5 py-1 text-xs text-slate-400">
                                    Historical
                                  </span>
                                )}
                              </div>

                              <h4 className="mt-2 font-semibold">
                                {item.competency_name}
                              </h4>

                              <p className="mt-1 text-sm text-slate-400">
                                Level {item.rating_level}
                                {" · "}
                                {proficiencyLabel(
                                  item.rating_level
                                )}
                              </p>

                              <p className="mt-2 text-xs text-slate-500">
                                Verified by {verifierName(item)}
                                {" · "}
                                {formatDate(
                                  item.verified_at ??
                                    item.created_at
                                )}
                              </p>

                              {item.notes && (
                                <p className="mt-3 whitespace-pre-wrap text-sm leading-6 text-slate-500">
                                  {item.notes}
                                </p>
                              )}
                            </div>
                          </div>
                        </article>
                      );
                    })}
                  </div>
                </div>
              </details>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}
