"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
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

export default function AssessmentsPage() {
  const router = useRouter();

  const [employee, setEmployee] = useState<Employee | null>(null);
  const [assessment, setAssessment] = useState<Assessment | null>(null);

  const [message, setMessage] = useState("Loading assessment...");
  const [starting, setStarting] = useState(false);

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

      const userId = sessionData.session.user.id;

      const {
        data: employeeData,
        error: employeeError,
      } = await supabase
        .from("employees")
        .select(`
          id,
          first_name,
          last_name,
          client_id
        `)
        .eq("auth_user_id", userId)
        .maybeSingle();

      if (employeeError) {
        setMessage(employeeError.message);
        return;
      }

      if (!employeeData) {
        setMessage(
          "Your login is not connected to an employee record yet."
        );
        return;
      }

      setEmployee(employeeData);

      const {
        data: assessmentData,
        error: assessmentError,
      } = await supabase
        .from("assessments")
        .select(`
          id,
          name,
          type
        `)
        .is("client_id", null)
        .eq(
          "name",
          "Technician I — Entry Level Pre-Assessment"
        )
        .eq("is_current", true)
        .maybeSingle();

      if (assessmentError) {
        setMessage(assessmentError.message);
        return;
      }

      if (!assessmentData) {
        setMessage(
          "The Technician I assessment is not available."
        );
        return;
      }

      setAssessment(assessmentData);
      setMessage("");
    }

    loadAssessmentPage();
  }, [router]);

  async function startAssessment() {
    if (!employee || !assessment) {
      return;
    }

    setStarting(true);
    setMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_start_master_assessment",
      {
        p_employee_id: employee.id,
        p_assessment_id: assessment.id,
      }
    );

    if (error) {
      setMessage(error.message);
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

    router.push(`/assessments/attempts/${data}`);
  }

  async function handleLogout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-5xl">
        <div className="mb-10 flex flex-col gap-6 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">
              IntegrateU
            </p>

            <h1 className="mt-2 text-3xl font-semibold">
              Assessments
            </h1>

            <p className="mt-2 text-slate-400">
              Measure your current knowledge and identify
              development opportunities.
            </p>
          </div>

          <button
            onClick={handleLogout}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800"
          >
            Sign Out
          </button>
        </div>

        {message && (
          <div className="mb-6 rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        {employee && assessment && (
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
                  This assessment measures your current
                  foundational knowledge across safety,
                  low-voltage fundamentals, cabling,
                  installation methods, documentation,
                  networking, AV systems, security,
                  lighting and control, testing, and
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
                    This is a knowledge assessment. Some
                    competencies may still require practical
                    field verification before they are considered
                    fully demonstrated.
                  </p>
                </div>
              </div>

              <div className="w-full md:w-64">
                <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                  <p className="text-sm text-slate-400">
                    Taking assessment as
                  </p>

                  <p className="mt-1 text-lg font-semibold">
                    {employee.first_name} {employee.last_name}
                  </p>

                  <button
                    onClick={startAssessment}
                    disabled={starting}
                    className="mt-6 w-full rounded-lg bg-cyan-400 px-4 py-3 font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
                  >
                    {starting
                      ? "Starting..."
                      : "Start Assessment"}
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