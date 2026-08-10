"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type DevelopmentPlan = {
  development_plan_id: string;
  client_id: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  action_key: string | null;
  action_type: string | null;
  action_label: string | null;
  master_competency_template_id: string | null;
  competency_name_snapshot: string | null;
  role_name_snapshot: string | null;
  title: string;
  description: string | null;
  development_type: string;
  status: string;
  priority: string;
  start_date: string | null;
  due_date: string | null;
  completed_at: string | null;
  owner_user_id: string | null;
  manager_notes: string | null;
  employee_notes: string | null;
  created_by_user_id: string;
  created_at: string;
  updated_at: string;
  activities_total: number;
  activities_completed: number;
  activities_blocked: number;
  completion_percent: number;
  overdue: boolean;
  resolution_status: string;
  resolution_label: string;
  readiness_action_still_open: boolean | null;
  development_completed_at: string | null;
  awaiting_evidence_since: string | null;
  resolved_at: string | null;
  resolution_notes: string | null;
};

type DevelopmentActivity = {
  id: string;
  development_plan_id: string;
  client_id: string;
  employee_id: string;
  title: string;
  description: string | null;
  activity_type: string;
  status: string;
  sequence_number: number;
  due_date: string | null;
  completed_at: string | null;
  completion_notes: string | null;
  evidence_url: string | null;
  created_by_user_id: string;
  created_at: string;
  updated_at: string;
};

type NewActivityDraft = {
  title: string;
  description: string;
  activityType: string;
  dueDate: string;
};

type ResolutionEvidence = {
  development_plan_id: string;
  resolution_status: string;
  initial_attempt_id: string | null;
  initial_safety_questions: number;
  initial_safety_correct: number;
  initial_safety_score_percent: number | null;
  reassessment_attempt_id: string | null;
  reassessment_completed_at: string | null;
  reassessment_safety_questions: number;
  reassessment_safety_correct: number;
  reassessment_safety_score_percent: number | null;
  required_safety_threshold_percent: number;
  reassessment_passed: boolean | null;
  resolved_at: string | null;
};

export default function DevelopmentPlanPage() {
  const params = useParams();
  const router = useRouter();
  const planId = params.id as string;

  const [plan, setPlan] = useState<DevelopmentPlan | null>(null);
  const [activities, setActivities] = useState<DevelopmentActivity[]>([]);
const [resolutionEvidence, setResolutionEvidence] =
  useState<ResolutionEvidence | null>(null);
  const [message, setMessage] = useState("Loading development plan...");
  const [successMessage, setSuccessMessage] = useState("");
  const [savingActivityId, setSavingActivityId] = useState<string | null>(null);
  const [showAddActivity, setShowAddActivity] = useState(false);
  const [addingActivity, setAddingActivity] = useState(false);

const [startingReassessment, setStartingReassessment] =
useState(false);
  const [draft, setDraft] = useState<NewActivityDraft>({
    title: "",
    description: "",
    activityType: "training",
    dueDate: "",
  });

  async function loadPlan() {
    const { data, error } = await supabase
      .from("v_development_plan_resolution")
      .select("*")
      .eq("development_plan_id", planId)
      .maybeSingle();

    if (error) throw error;
    if (!data) throw new Error("Development plan not found or access denied.");
    setPlan(data as DevelopmentPlan);
  }

  async function loadActivities() {
    const { data, error } = await supabase
      .from("development_plan_activities")
      .select("*")
      .eq("development_plan_id", planId)
      .order("sequence_number", { ascending: true });

    if (error) throw error;
    setActivities((data ?? []) as DevelopmentActivity[]);
  }

async function loadResolutionEvidence() {
  const { data, error } = await supabase
    .from("v_development_plan_resolution_evidence")
    .select(`
      development_plan_id,
      resolution_status,
      initial_attempt_id,
      initial_safety_questions,
      initial_safety_correct,
      initial_safety_score_percent,
      reassessment_attempt_id,
      reassessment_completed_at,
      reassessment_safety_questions,
      reassessment_safety_correct,
      reassessment_safety_score_percent,
      required_safety_threshold_percent,
      reassessment_passed,
      resolved_at
    `)
    .eq("development_plan_id", planId)
    .maybeSingle();

  if (error) throw error;

  setResolutionEvidence(
    data ? (data as ResolutionEvidence) : null
  );
}

  async function refreshWorkspace() {
  await Promise.all([
    loadPlan(),
    loadActivities(),
    loadResolutionEvidence(),
  ]);
}

async function startTargetedReassessment() {
if (!plan) {
return;
}

setStartingReassessment(true);
setMessage("");
setSuccessMessage("");

const {
  data,
  error,
} = await supabase.rpc(
  "wri_start_targeted_safety_reassessment",
  {
    p_development_plan_id:
      plan.development_plan_id,
  }
);

if (error) {
  setMessage(error.message);
  setStartingReassessment(false);
  return;
}

if (!data) {
  setMessage(
    "The targeted reassessment could not be created."
  );
  setStartingReassessment(false);
  return;
}

router.push(
  `/assessments/attempts/${data}?plan=${encodeURIComponent(
    plan.development_plan_id
  )}`
);
}

  useEffect(() => {
    async function loadPage() {
      try {
        const { data: sessionData, error: sessionError } =
          await supabase.auth.getSession();

        if (sessionError) {
          setMessage(sessionError.message);
          return;
        }

        if (!sessionData.session) {
          router.push("/");
          return;
        }

        await refreshWorkspace();
        setMessage("");
      } catch (error) {
        setMessage(
          error instanceof Error
            ? error.message
            : "Unable to load development plan."
        );
      }
    }

    loadPage();
  }, [planId, router]);

  async function logout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  async function addActivity() {
    if (!draft.title.trim()) {
      setMessage("Activity title is required.");
      return;
    }

    setAddingActivity(true);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc("wri_add_development_activity", {
      p_development_plan_id: planId,
      p_title: draft.title.trim(),
      p_description: draft.description.trim() ? draft.description.trim() : null,
      p_activity_type: draft.activityType,
      p_due_date: draft.dueDate || null,
    });

    if (error) {
      setMessage(error.message);
      setAddingActivity(false);
      return;
    }

    setDraft({ title: "", description: "", activityType: "training", dueDate: "" });
    setShowAddActivity(false);

    try {
      await refreshWorkspace();
      setSuccessMessage("Development activity added.");
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "Activity was added, but the workspace could not refresh."
      );
    }

    setAddingActivity(false);
  }

  async function updateActivityStatus(activityId: string, status: string) {
    setSavingActivityId(activityId);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_update_development_activity_status",
      {
        p_activity_id: activityId,
        p_status: status,
        p_completion_notes: null,
      }
    );

    if (error) {
      setMessage(error.message);
      setSavingActivityId(null);
      return;
    }

    try {
      await refreshWorkspace();
      setSuccessMessage("Activity status updated.");
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "Status was updated, but the workspace could not refresh."
      );
    }

    setSavingActivityId(null);
  }

  const remainingActivities = useMemo(
    () =>
      activities.filter(
        (activity) =>
          activity.status !== "completed" && activity.status !== "cancelled"
      ).length,
    [activities]
  );

  function statusLabel(status: string) {
    return status
      .split("_")
      .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
      .join(" ");
  }

  function resolutionClasses(status: string) {
    if (status === "resolved") {
      return "bg-emerald-500/15 text-emerald-300";
    }

    if (
      status === "awaiting_reassessment" ||
      status === "awaiting_verification" ||
      status === "awaiting_reverification"
    ) {
      return "bg-amber-500/15 text-amber-300";
    }

    if (status === "cancelled") {
      return "bg-slate-700 text-slate-300";
    }

    return "bg-cyan-500/15 text-cyan-300";
  }

  function resolutionDescription(status: string) {
    if (status === "awaiting_reassessment") {
      return "Development work is complete. The employee must now complete a reassessment before this readiness gap can be resolved.";
    }

    if (status === "awaiting_verification") {
      return "Development work is complete. Practical competency must now be verified before this readiness gap can be resolved.";
    }

    if (status === "awaiting_reverification") {
      return "Development work is complete. A new practical verification is required before this readiness gap can be resolved.";
    }

    if (status === "resolved") {
      return "The underlying readiness requirement has been satisfied. No additional action is currently required.";
    }

    if (status === "cancelled") {
      return "This development plan has been cancelled.";
    }

    return "Complete the development activities below before moving to reassessment or verification.";
  }

  function statusClasses(status: string) {
    switch (status) {
      case "completed":
        return "bg-emerald-500/15 text-emerald-300";
      case "in_progress":
        return "bg-cyan-500/15 text-cyan-300";
      case "blocked":
        return "bg-rose-500/15 text-rose-300";
      case "cancelled":
        return "bg-slate-800 text-slate-400";
      default:
        return "bg-amber-500/15 text-amber-300";
    }
  }

  function priorityClasses(priority: string) {
    switch (priority) {
      case "critical":
        return "bg-rose-500/15 text-rose-300";
      case "high":
        return "bg-amber-500/15 text-amber-300";
      case "medium":
        return "bg-cyan-500/15 text-cyan-300";
      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function typeLabel(value: string) {
    return value
      .split("_")
      .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
      .join(" ");
  }

  function formatDate(value: string | null) {
    if (!value) return "—";
    return new Date(`${value}T12:00:00`).toLocaleDateString();
  }

function formatDateTime(value: string | null) {
  if (!value) return "—";

  return new Date(value).toLocaleString([], {
    month: "short",
    day: "numeric",
    year: "numeric",
    hour: "numeric",
    minute: "2-digit",
  });
}

  if (!plan) {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-7xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            {message}
          </div>
          <Link
            href="/readiness-actions"
            className="mt-6 inline-block text-cyan-400 hover:text-cyan-300"
          >
            ← Readiness Actions
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <div className="mb-10 flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">IntegrateU</p>
            <h1 className="mt-2 text-3xl font-semibold">Development Plan</h1>
            <p className="mt-2 text-slate-400">
              {plan.first_name} {plan.last_name}
              {plan.employee_number ? ` · ${plan.employee_number}` : ""}
            </p>
          </div>

          <div className="flex flex-wrap gap-3">
            <Link href="/readiness-actions" className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800">
              ← Readiness Actions
            </Link>
            <Link href={`/employees/${plan.employee_id}`} className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800">
              Employee Profile
            </Link>
            <button onClick={logout} className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800">
              Sign Out
            </button>
          </div>
        </div>

        {message && (
          <div className="mb-6 rounded-xl border border-rose-500/30 bg-rose-500/10 p-5 text-sm text-rose-200">{message}</div>
        )}
        {successMessage && (
          <div className="mb-6 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-5 text-sm text-emerald-200">{successMessage}</div>
        )}

        <section className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
          <div className="flex flex-col gap-6 xl:flex-row xl:items-start xl:justify-between">
            <div className="max-w-3xl">
              <div className="flex flex-wrap gap-2">
                <span className={`rounded-full px-3 py-1 text-xs font-medium ${statusClasses(plan.status)}`}>{statusLabel(plan.status)}</span>
                <span className={`rounded-full px-3 py-1 text-xs font-medium ${resolutionClasses(plan.resolution_status)}`}>
                  {plan.resolution_label}
                </span>
                <span className={`rounded-full px-3 py-1 text-xs font-medium ${priorityClasses(plan.priority)}`}>{typeLabel(plan.priority)} Priority</span>
                {plan.overdue && <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">Overdue</span>}
              </div>

              <h2 className="mt-4 text-3xl font-semibold">{plan.title}</h2>
              {plan.description && <p className="mt-4 leading-7 text-slate-400">{plan.description}</p>}

              <div className="mt-6 flex flex-wrap gap-x-8 gap-y-3 text-sm">
                <div><span className="text-slate-500">Role:</span> <span className="text-slate-300">{plan.role_name_snapshot || "—"}</span></div>
                <div><span className="text-slate-500">Type:</span> <span className="text-slate-300">{typeLabel(plan.development_type)}</span></div>
                <div><span className="text-slate-500">Start:</span> <span className="text-slate-300">{formatDate(plan.start_date)}</span></div>
                <div><span className="text-slate-500">Due:</span> <span className={plan.overdue ? "font-medium text-rose-300" : "text-slate-300"}>{formatDate(plan.due_date)}</span></div>
              </div>
            </div>

            <div className="w-full xl:max-w-sm">
              <div className="rounded-xl bg-slate-950/60 p-5">
                <div className="flex items-end justify-between">
                  <div><p className="text-sm text-slate-400">Progress</p><p className="mt-1 text-4xl font-bold">{plan.completion_percent}%</p></div>
                  <p className="text-sm text-slate-400">{plan.activities_completed}/{plan.activities_total} complete</p>
                </div>
                <div className="mt-4 h-3 overflow-hidden rounded-full bg-slate-800">
                  <div className="h-full rounded-full bg-cyan-400" style={{ width: `${Math.min(100, Math.max(0, Number(plan.completion_percent)))}%` }} />
                </div>
                <div className="mt-4 grid grid-cols-2 gap-3">
                  <div className="rounded-lg bg-slate-900 p-3"><p className="text-xs text-slate-500">Remaining</p><p className="mt-1 text-xl font-semibold">{remainingActivities}</p></div>
                  <div className="rounded-lg bg-slate-900 p-3"><p className="text-xs text-slate-500">Blocked</p><p className="mt-1 text-xl font-semibold text-rose-300">{plan.activities_blocked}</p></div>
                </div>
              </div>
            </div>
          </div>
        </section>

{resolutionEvidence &&
  resolutionEvidence.initial_safety_score_percent !== null && (
    <section className="mt-6 rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
        <div>
          <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
            Resolution Evidence
          </p>

          <h2 className="mt-2 text-xl font-semibold">
            Safety Readiness Improvement
          </h2>

          <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
            This development plan was created from a critical safety
            readiness gap. The scores below show the original assessment
            result and the targeted reassessment used to determine
            resolution.
          </p>
        </div>

        {resolutionEvidence.reassessment_passed === true && (
          <span className="w-fit rounded-full bg-emerald-500/15 px-3 py-1 text-xs font-medium text-emerald-300">
            Requirement Satisfied
          </span>
        )}
      </div>

      <div className="mt-7 grid gap-4 md:grid-cols-3">
        <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
          <p className="text-sm text-slate-500">
            Initial Safety Score
          </p>

          <p className="mt-2 text-4xl font-bold">
            {resolutionEvidence.initial_safety_score_percent}%
          </p>

          <p className="mt-2 text-xs text-slate-500">
            {resolutionEvidence.initial_safety_correct} of{" "}
            {resolutionEvidence.initial_safety_questions} critical
            safety questions correct
          </p>
        </div>

        <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
          <p className="text-sm text-slate-500">
            Targeted Reassessment
          </p>

          <p
            className={`mt-2 text-4xl font-bold ${
              resolutionEvidence.reassessment_passed
                ? "text-emerald-300"
                : "text-white"
            }`}
          >
            {resolutionEvidence.reassessment_safety_score_percent !== null
              ? `${resolutionEvidence.reassessment_safety_score_percent}%`
              : "Pending"}
          </p>

          {resolutionEvidence.reassessment_attempt_id && (
            <p className="mt-2 text-xs text-slate-500">
              {resolutionEvidence.reassessment_safety_correct} of{" "}
              {resolutionEvidence.reassessment_safety_questions} targeted
              safety questions correct
            </p>
          )}
        </div>

        <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
          <p className="text-sm text-slate-500">
            Required Threshold
          </p>

          <p className="mt-2 text-4xl font-bold">
            {resolutionEvidence.required_safety_threshold_percent}%
          </p>

          <p className="mt-2 text-xs text-slate-500">
            Minimum score required to close the safety gap
          </p>
        </div>
      </div>

      {resolutionEvidence.reassessment_passed === true &&
        resolutionEvidence.reassessment_safety_score_percent !== null &&
        resolutionEvidence.initial_safety_score_percent !== null && (
          <div className="mt-5 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-5">
            <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
              <div>
                <p className="font-semibold text-emerald-300">
                  ✓ Safety requirement satisfied
                </p>

                <p className="mt-1 text-sm text-emerald-200/70">
                  Improved{" "}
                  {(
                    resolutionEvidence.reassessment_safety_score_percent -
                    resolutionEvidence.initial_safety_score_percent
                  ).toFixed(1)}{" "}
                  percentage points from the initial assessment.
                </p>
              </div>

              <div className="text-sm text-slate-400 sm:text-right">
                {resolutionEvidence.resolved_at && (
                  <p>
                    Resolved{" "}
                    {formatDateTime(resolutionEvidence.resolved_at)}
                  </p>
                )}

                {resolutionEvidence.reassessment_completed_at && (
                  <p className="mt-1 text-xs text-slate-500">
                    Reassessment completed{" "}
                    {formatDateTime(
                      resolutionEvidence.reassessment_completed_at
                    )}
                  </p>
                )}
              </div>
            </div>
          </div>
        )}

      {resolutionEvidence.reassessment_attempt_id && (
        <div className="mt-5">
          <Link
            href={`/assessments/attempts/${resolutionEvidence.reassessment_attempt_id}/results`}
            className="text-sm font-medium text-cyan-400 transition hover:text-cyan-300"
          >
            View Reassessment Results →
          </Link>
        </div>
      )}
    </section>
  )}                

        <section className="mt-6 rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <div className="flex flex-col gap-5 lg:flex-row lg:items-center lg:justify-between">
            <div className="max-w-3xl">
              <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
Next Required Action
              </p>

              <div className="mt-2 flex flex-wrap items-center gap-3">
                <h2 className="text-xl font-semibold">
                  {plan.resolution_label}
                </h2>

                <span
                  className={`rounded-full px-3 py-1 text-xs font-medium ${resolutionClasses(
                    plan.resolution_status
                  )}`}
                >
                  {plan.readiness_action_still_open === false
                    ? "Readiness Gap Closed"
                    : plan.readiness_action_still_open === true
                      ? "Readiness Gap Open"
                      : "Readiness Status Unavailable"}
                </span>
              </div>

              <p className="mt-3 text-sm leading-6 text-slate-400">
                {resolutionDescription(plan.resolution_status)}
              </p>
            </div>

            <div className="flex flex-wrap gap-3">
          {plan.resolution_status === "awaiting_reassessment" && (
            <button
              type="button"
              onClick={startTargetedReassessment}
              disabled={startingReassessment}
              className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
            >
              {startingReassessment
                ? "Starting..."
                : "Reassess Employee"}
            </button>
          )}

              {(plan.resolution_status === "awaiting_verification" ||
                plan.resolution_status === "awaiting_reverification") && (
                <Link
                  href={`/employees/${plan.employee_id}/practical-verification`}
                  className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                >
                  {plan.resolution_status === "awaiting_reverification"
                    ? "Reverify Employee"
                    : "Open Practical Verification"}
                </Link>
              )}

              {plan.resolution_status === "resolved" && (
                <Link
                  href={`/employees/${plan.employee_id}`}
                  className="rounded-lg border border-emerald-500/50 bg-emerald-500/10 px-5 py-3 text-sm font-medium text-emerald-300 transition hover:bg-emerald-500/20"
                >
                  View Readiness Profile
                </Link>
              )}
            </div>
          </div>
        </section>

        <div className="mt-8 grid gap-8 xl:grid-cols-[1fr_340px]">
          <section>
            <div className="mb-5 flex flex-wrap items-end justify-between gap-4">
              <div>
                <h2 className="text-2xl font-semibold">Development Activities</h2>
                <p className="mt-1 text-sm text-slate-400">Track the work required to close this readiness gap.</p>
              </div>
              <button type="button" onClick={() => setShowAddActivity((current) => !current)} className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300">
                {showAddActivity ? "Cancel" : "Add Activity"}
              </button>
            </div>

            {showAddActivity && (
              <div className="mb-5 rounded-2xl border border-cyan-500/30 bg-cyan-500/5 p-5">
                <h3 className="font-semibold">New Development Activity</h3>
                <div className="mt-5 grid gap-4">
                  <div>
                    <label className="text-sm text-slate-300">Activity Title</label>
                    <input value={draft.title} onChange={(event) => setDraft((current) => ({ ...current, title: event.target.value }))} placeholder="Example: Complete supervised network installation" className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm outline-none focus:border-cyan-400" />
                  </div>
                  <div>
                    <label className="text-sm text-slate-300">Description</label>
                    <textarea value={draft.description} onChange={(event) => setDraft((current) => ({ ...current, description: event.target.value }))} rows={3} className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm outline-none focus:border-cyan-400" />
                  </div>
                  <div className="grid gap-4 sm:grid-cols-2">
                    <div>
                      <label className="text-sm text-slate-300">Activity Type</label>
                      <select value={draft.activityType} onChange={(event) => setDraft((current) => ({ ...current, activityType: event.target.value }))} className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm outline-none focus:border-cyan-400">
                        <option value="training">Training</option><option value="coaching">Coaching</option><option value="field_practice">Field Practice</option><option value="practical_verification">Practical Verification</option><option value="reassessment">Reassessment</option><option value="mentoring">Mentoring</option><option value="observation">Observation</option><option value="documentation">Documentation</option><option value="other">Other</option>
                      </select>
                    </div>
                    <div>
                      <label className="text-sm text-slate-300">Due Date</label>
                      <input type="date" value={draft.dueDate} onChange={(event) => setDraft((current) => ({ ...current, dueDate: event.target.value }))} className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm outline-none focus:border-cyan-400" />
                    </div>
                  </div>
                  <div className="flex justify-end"><button type="button" disabled={addingActivity} onClick={addActivity} className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:opacity-50">{addingActivity ? "Adding..." : "Add Activity"}</button></div>
                </div>
              </div>
            )}

            {activities.length === 0 ? (
              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-center">
                <p className="font-medium">No development activities yet.</p>
                <p className="mt-2 text-sm text-slate-400">Add the specific training, coaching, field practice, or verification work needed to close this readiness gap.</p>
              </div>
            ) : (
              <div className="space-y-4">
                {activities.map((activity) => (
                  <article key={activity.id} className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
                    <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
                      <div>
                        <div className="flex flex-wrap items-center gap-2"><span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">{typeLabel(activity.activity_type)}</span><span className={`rounded-full px-3 py-1 text-xs font-medium ${statusClasses(activity.status)}`}>{statusLabel(activity.status)}</span></div>
                        <h3 className="mt-3 text-lg font-semibold">{activity.sequence_number}. {activity.title}</h3>
                        {activity.description && <p className="mt-2 text-sm leading-6 text-slate-400">{activity.description}</p>}
                        {activity.due_date && <p className="mt-3 text-xs text-slate-500">Due {formatDate(activity.due_date)}</p>}
                      </div>
                      <select value={activity.status} disabled={savingActivityId === activity.id} onChange={(event) => updateActivityStatus(activity.id, event.target.value)} className="rounded-lg border border-slate-700 bg-slate-950 px-3 py-2 text-sm outline-none focus:border-cyan-400 disabled:opacity-50">
                        <option value="not_started">Not Started</option><option value="in_progress">In Progress</option><option value="blocked">Blocked</option><option value="completed">Completed</option><option value="cancelled">Cancelled</option>
                      </select>
                    </div>
                  </article>
                ))}
              </div>
            )}
          </section>

          <aside className="space-y-5">
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
              <p className="text-xs font-medium uppercase tracking-wide text-slate-500">Created From</p>
              <p className="mt-3 font-semibold">{plan.action_label || "Development Plan"}</p>
              {plan.competency_name_snapshot && <p className="mt-2 text-sm text-slate-400">{plan.competency_name_snapshot}</p>}
              <p className="mt-4 text-xs text-slate-500">Readiness Action Queue</p>
            </div>
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
              <p className="text-xs font-medium uppercase tracking-wide text-slate-500">Development Type</p>
              <p className="mt-2 font-semibold">{typeLabel(plan.development_type)}</p>
            </div>
            {plan.manager_notes && (
              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
                <p className="text-xs font-medium uppercase tracking-wide text-slate-500">Manager Notes</p>
                <p className="mt-3 whitespace-pre-wrap text-sm leading-6 text-slate-300">{plan.manager_notes}</p>
              </div>
            )}
          </aside>
        </div>
      </div>
    </main>
  );
}
