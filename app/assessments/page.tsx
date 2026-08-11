"use client";

import { Suspense, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import SystemHeader from "@/components/SystemHeader";
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

  async function handleLogout() {
    await supabase.auth.signOut();

    router.push("/");
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-5xl">

        {/* Header */}

        <SystemHeader
          title="Assessments"
          subtitle="Measure your current knowledge and identify development opportunities."
          showHome={true}
          showSignOut={true}
        />

        {/* Message */}

        {message && (
          <div className="mb-6 rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {/* Assessment */}

        {employee &&
          assessment && (
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
    </main>
  );
}

export default function AssessmentsPage() {
  return (
    <Suspense
      fallback={
        <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
          <div className="mx-auto max-w-6xl">
            <div className="rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
              Loading assessment...
            </div>
          </div>
        </main>
      }
    >
      <AssessmentsPageContent />
    </Suspense>
  );
}

