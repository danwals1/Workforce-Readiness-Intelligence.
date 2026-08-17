"use client";

import { Suspense, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  client_id: string;
};

type Assessment = {
  id: string;
  name: string;
  type: string;
};

type PendingReassessment = {
  id: string;
  assessment_id: string;
  development_plan_id: string | null;
  started_at: string | null;
  assessment_name: string;
};

function AssessmentsPageContent() {
  const router = useRouter();
const searchParams = useSearchParams();

const requestedEmployeeId =
searchParams.get("employee");

const requestedActionKey =
searchParams.get("action");

const requestedPlanId =
searchParams.get("plan");


  const [employee, setEmployee] =
    useState<Employee | null>(null);

  const [assessment, setAssessment] =
    useState<Assessment | null>(null);

  const [message, setMessage] =
    useState("Loading assessment...");

  const [starting, setStarting] =
    useState(false);

  const [
    pendingReassessments,
    setPendingReassessments,
  ] = useState<PendingReassessment[]>([]);

  useEffect(() => {
    async function loadAssessmentPage() {
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

  let employeeData: Employee | null = null;

  if (requestedEmployeeId) {
    const {
      data: targetEmployee,
      error: targetEmployeeError,
    } = await supabase
      .from("employees")
      .select(`
        id,
        first_name,
        last_name,
        client_id
      `)
      .eq(
        "id",
        requestedEmployeeId
      )
      .maybeSingle();

    if (
      targetEmployeeError ||
      !targetEmployee
    ) {
      setMessage(
        "Employee not found or access denied."
      );
      return;
    }

    employeeData =
      targetEmployee as Employee;
  } else {
    const {
      data: selfEmployee,
      error: employeeError,
    } = await supabase
      .from("employees")
      .select(`
        id,
        first_name,
        last_name,
        client_id
      `)
      .eq(
        "auth_user_id",
        userId
      )
      .maybeSingle();

    if (employeeError) {
      setMessage(
        employeeError.message
      );
      return;
    }

    if (!selfEmployee) {
      setMessage(
        "Your login is not connected to an employee record yet."
      );
      return;
    }

    employeeData =
      selfEmployee as Employee;
  }

  setEmployee(employeeData);

  if (!requestedEmployeeId) {
    const {
      data: pendingAttemptData,
      error: pendingAttemptError,
    } = await supabase
      .from("assessment_attempts")
      .select(`
        id,
        assessment_id,
        development_plan_id,
        started_at
      `)
      .eq("employee_id", employeeData.id)
      .eq("attempt_mode", "targeted_reassessment")
      .in("status", ["not_started", "in_progress"])
      .order("created_at", { ascending: false });

    if (pendingAttemptError) {
      setMessage(pendingAttemptError.message);
      return;
    }

    const pendingAttempts = pendingAttemptData ?? [];

    if (pendingAttempts.length > 0) {
      const assessmentIds = [
        ...new Set(
          pendingAttempts.map(
            (attempt) => attempt.assessment_id
          )
        ),
      ];

      const {
        data: assessmentNamesData,
        error: assessmentNamesError,
      } = await supabase
        .from("assessments")
        .select("id, name")
        .in("id", assessmentIds);

      if (assessmentNamesError) {
        setMessage(assessmentNamesError.message);
        return;
      }

      const assessmentNames = new Map(
        (assessmentNamesData ?? []).map(
          (item) => [item.id, item.name]
        )
      );

      setPendingReassessments(
        pendingAttempts.map(
          (attempt) => ({
            id: attempt.id,
            assessment_id:
              attempt.assessment_id,
            development_plan_id:
              attempt.development_plan_id,
            started_at:
              attempt.started_at,
            assessment_name:
              assessmentNames.get(
                attempt.assessment_id
              ) ?? "Targeted Reassessment",
          })
        )
      );
    } else {
      setPendingReassessments([]);
    }
  } else {
    setPendingReassessments([]);
  }

  let assessmentData:
    Assessment | null = null;

  if (
    requestedEmployeeId &&
    requestedActionKey
  ) {
    const {
      data: actionData,
      error: actionError,
    } = await supabase
      .from("v_readiness_action_queue")
      .select(`
        action_key,
        employee_id,
        assessment_id
      `)
      .eq(
        "action_key",
        requestedActionKey
      )
      .eq(
        "employee_id",
        requestedEmployeeId
      )
      .maybeSingle();

    if (
      actionError ||
      !actionData
    ) {
      setMessage(
        "The readiness action for this reassessment is no longer available."
      );
      return;
    }

    const {
      data: requestedAssessment,
      error: assessmentError,
    } = await supabase
      .from("assessments")
      .select(`
        id,
        name,
        type
      `)
      .eq(
        "id",
        actionData.assessment_id
      )
      .maybeSingle();

    if (
      assessmentError ||
      !requestedAssessment
    ) {
      setMessage(
        "The assessment for this readiness action is not available."
      );
      return;
    }

    assessmentData =
      requestedAssessment as Assessment;
  } else {
    const {
      data: defaultAssessment,
      error: assessmentError,
    } = await supabase
      .from("assessments")
      .select(`
        id,
        name,
        type
      `)
      .is(
        "client_id",
        null
      )
      .eq(
        "name",
        "Technician I — Entry Level Pre-Assessment"
      )
      .eq(
        "is_current",
        true
      )
      .maybeSingle();

    if (assessmentError) {
      setMessage(
        assessmentError.message
      );
      return;
    }

    if (!defaultAssessment) {
      setMessage(
        "The Technician I assessment is not available."
      );
      return;
    }

    assessmentData =
      defaultAssessment as Assessment;
  }

  setAssessment(
    assessmentData
  );

      setMessage("");
    }

    loadAssessmentPage();
}, [
  router,
  requestedEmployeeId,
  requestedActionKey,
  requestedPlanId,
]);

  async function startAssessment() {
    if (
      !employee ||
      !assessment
    ) {
      return;
    }

    setStarting(true);
    setMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_start_master_assessment",
      requestedPlanId
        ? {
            p_employee_id:
              employee.id,

            p_assessment_id:
              assessment.id,

            p_development_plan_id:
              requestedPlanId,
          }
        : {
            p_employee_id:
              employee.id,

            p_assessment_id:
              assessment.id,
          }
    );

    if (error) {
      setMessage(
        error.message
      );

      setStarting(false);

      return;
    }

    if (!data) {
      setMessage(
        "The assessment attempt could not be created."
      );

      setStarting(false);

      return;
    }

    router.push(
      requestedPlanId
        ? `/assessments/attempts/${data}?plan=${encodeURIComponent(
            requestedPlanId
          )}`
        : `/assessments/attempts/${data}`
    );
  }

  return (
    <div className="mx-auto max-w-5xl">
      <header className="mb-8">
        <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
          Assessments
        </p>

        <h2 className="mt-2 text-3xl font-semibold">
          Assessment Center
        </h2>

        <p className="mt-2 max-w-3xl text-sm text-slate-400">
          Measure current knowledge and identify development opportunities.
        </p>
      </header>

        {/* Pending Reassessments */}

        {pendingReassessments.length > 0 && (
          <section className="mb-6 rounded-2xl border border-cyan-500/30 bg-cyan-500/10 p-6">
            <p className="text-xs font-semibold uppercase tracking-wide text-cyan-300">
              Development Plan Reassessment
            </p>

            <h2 className="mt-2 text-xl font-semibold">
              Reassessment Ready
            </h2>

            <p className="mt-2 text-sm leading-6 text-slate-300">
              Complete the targeted reassessment below before returning to your normal assessment work.
            </p>

            <div className="mt-5 space-y-3">
              {pendingReassessments.map(
                (pending) => (
                  <div
                    key={pending.id}
                    className="flex flex-col gap-4 rounded-xl border border-slate-700 bg-slate-950/60 p-5 sm:flex-row sm:items-center sm:justify-between"
                  >
                    <div>
                      <p className="font-semibold">
                        {pending.assessment_name}
                      </p>

                      <p className="mt-1 text-sm text-slate-400">
                        Targeted competency reassessment
                      </p>
                    </div>

                    <Link
                      href={`/assessments/attempts/${pending.id}${
                        pending.development_plan_id
                          ? `?plan=${encodeURIComponent(
                              pending.development_plan_id
                            )}`
                          : ""
                      }`}
                      className="inline-flex items-center justify-center rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                    >
                      Open Reassessment
                    </Link>
                  </div>
                )
              )}
            </div>
          </section>
        )}

        {/* Message */}

        {message && (
          <div className="mb-6 rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {/* Assessment */}

        {employee &&
          assessment &&
          pendingReassessments.length === 0 && (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">
              <div className="flex flex-col gap-8 md:flex-row md:items-start md:justify-between">

                <div className="max-w-2xl">
                  <p className="text-sm font-medium text-cyan-400">
                    Technician Assessment
                  </p>

                  <h2 className="mt-2 text-3xl font-semibold">
                    {assessment.name}
                  </h2>

                  <p className="mt-4 text-slate-400">
                    This assessment
                    measures your current
                    foundational knowledge
                    across safety,
                    low-voltage
                    fundamentals,
                    cabling,
                    installation methods,
                    documentation,
                    networking,
                    AV systems,
                    security,
                    lighting and control,
                    testing, and
                    troubleshooting.
                  </p>

                  <div className="mt-6 grid gap-4 sm:grid-cols-3">
                    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-4">
                      <p className="text-sm text-slate-400">
                        Questions
                      </p>

                      <p className="mt-1 text-2xl font-semibold">
                        100
                      </p>
                    </div>

                    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-4">
                      <p className="text-sm text-slate-400">
                        Format
                      </p>

                      <p className="mt-1 text-lg font-semibold">
                        Knowledge Assessment
                      </p>
                    </div>

                    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-4">
                      <p className="text-sm text-slate-400">
                        Progress
                      </p>

                      <p className="mt-1 text-lg font-semibold">
                        Saved Automatically
                      </p>
                    </div>
                  </div>

                  <div className="mt-6 rounded-xl border border-amber-500/20 bg-amber-500/10 p-4">
                    <p className="text-sm text-amber-200">
                      This is a knowledge
                      assessment. Some
                      competencies may
                      require practical
                      field verification
                      before they are
                      considered fully
                      demonstrated.
                    </p>
                  </div>
                </div>

                <div className="w-full md:w-64">
                  <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                    <p className="text-sm text-slate-400">
                      Taking assessment as
                    </p>

                    <p className="mt-1 text-lg font-semibold">
                      {
                        employee.first_name
                      }{" "}
                      {
                        employee.last_name
                      }
                    </p>

                    <button
                      onClick={
                        startAssessment
                      }
                      disabled={
                        starting
                      }
                      className="mt-6 w-full rounded-lg bg-cyan-400 px-4 py-3 font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
                    >
                      {starting
                        ? "Starting..."
                        : "Start / Resume Assessment"}
                    </button>
                  </div>
                </div>
              </div>
            </div>
          )}
    </div>
  );
}

export default function AssessmentsPage() {
  return (
    <Suspense
      fallback={
        <div className="mx-auto max-w-6xl">
          <div className="rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            Loading assessment...
          </div>
        </div>
      }
    >
      <AssessmentsPageContent />
    </Suspense>
  );
}

