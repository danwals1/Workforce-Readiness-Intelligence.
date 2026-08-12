"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import SystemHeader from "@/components/SystemHeader";
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

type PlanOwner = {
  user_id: string;
  employee_id: string | null;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  role: string;
  client_id: string | null;
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

type PracticalEvidence = {
  development_plan_id: string;
  competency_name_snapshot: string | null;
  required_level: number | null;
  verification_id: string | null;
  verified_level: number | null;
  verification_status: string | null;
  verified_by: string | null;
  verified_at: string | null;
  notes: string | null;
  verification_satisfied: boolean;
  resolution_status: string;
  resolved_at: string | null;
};

type EditPlanDraft = {
  title: string;
  description: string;
  developmentType: string;
  priority: string;
  dueDate: string;
  ownerUserId: string;
  managerNotes: string;
};

export default function DevelopmentPlanPage() {
  const params = useParams();
  const router = useRouter();
  const planId = params.id as string;

  const [plan, setPlan] = useState<DevelopmentPlan | null>(null);
  const [planOwner, setPlanOwner] =
    useState<PlanOwner | null>(null);
  const [activities, setActivities] = useState<DevelopmentActivity[]>([]);
const [resolutionEvidence, setResolutionEvidence] =
  useState<ResolutionEvidence | null>(null);
const [practicalEvidence, setPracticalEvidence] =
  useState<PracticalEvidence | null>(null);
  const [message, setMessage] = useState("Loading development plan...");
  const [successMessage, setSuccessMessage] = useState("");
  const [savingActivityId, setSavingActivityId] = useState<string | null>(null);

  const [completingActivityId, setCompletingActivityId] =
    useState<string | null>(null);

  const [completionNotes, setCompletionNotes] =
    useState("");

  const [completionEvidenceUrl, setCompletionEvidenceUrl] =
    useState("");
  const [showAddActivity, setShowAddActivity] = useState(false);
  const [addingActivity, setAddingActivity] = useState(false);

  const [showEditPlan, setShowEditPlan] =
    useState(false);

  const [savingPlan, setSavingPlan] =
    useState(false);

  const [showCancelPlan, setShowCancelPlan] =
    useState(false);

  const [cancellingPlan, setCancellingPlan] =
    useState(false);

  const [editOwners, setEditOwners] =
    useState<PlanOwner[]>([]);

  const [editDraft, setEditDraft] =
    useState<EditPlanDraft>({
      title: "",
      description: "",
      developmentType: "training",
      priority: "medium",
      dueDate: "",
      ownerUserId: "",
      managerNotes: "",
    });

const [startingReassessment, setStartingReassessment] =
useState(false);
  const [draft, setDraft] = useState<NewActivityDraft>({
    title: "",
    description: "",
    activityType: "training",
    dueDate: "",
  });

  async function loadPlanOwner(
    employeeId: string,
    ownerUserId: string | null
  ) {
    if (!ownerUserId) {
      setPlanOwner(null);
      return;
    }

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_list_development_plan_owners",
      {
        p_employee_id: employeeId,
      }
    );

    if (error) {
      console.error(
        "Unable to load development plan owner:",
        error
      );
      setPlanOwner(null);
      return;
    }

    const owners =
      (data ?? []) as PlanOwner[];

    const owner =
      owners.find(
        (row) =>
          row.user_id === ownerUserId
      ) ?? null;

    setPlanOwner(owner);
  }

  async function openEditPlan() {
    if (!plan) {
      return;
    }

    if (
      plan.resolution_status === "resolved" ||
      plan.resolution_status === "cancelled" ||
      plan.status === "cancelled"
    ) {
      setMessage(
        "Resolved or cancelled development plans are read-only."
      );
      return;
    }

    setMessage("");
    setSuccessMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_list_development_plan_owners",
      {
        p_employee_id: plan.employee_id,
      }
    );

    if (error) {
      setMessage(error.message);
      return;
    }

    setEditOwners(
      (data ?? []) as PlanOwner[]
    );

    setEditDraft({
      title: plan.title ?? "",
      description: plan.description ?? "",
      developmentType:
        plan.development_type ?? "training",
      priority: plan.priority ?? "medium",
      dueDate: plan.due_date ?? "",
      ownerUserId: plan.owner_user_id ?? "",
      managerNotes: plan.manager_notes ?? "",
    });

    setShowEditPlan(true);
  }

  function cancelEditPlan() {
    setShowEditPlan(false);
    setMessage("");
  }

  function openCancelPlan() {
    if (!plan) {
      return;
    }

    if (
      plan.resolution_status === "resolved" ||
      plan.resolution_status === "cancelled" ||
      plan.status === "cancelled"
    ) {
      setMessage(
        "Resolved or cancelled development plans cannot be cancelled."
      );
      return;
    }

    setMessage("");
    setSuccessMessage("");
    setShowEditPlan(false);
    setShowCancelPlan(true);
  }

  function closeCancelPlan() {
    if (cancellingPlan) {
      return;
    }

    setShowCancelPlan(false);
  }

  async function cancelDevelopmentPlan() {
    if (!plan) {
      return;
    }

    setCancellingPlan(true);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_cancel_development_plan",
      {
        p_development_plan_id:
          plan.development_plan_id,
      }
    );

    if (error) {
      setMessage(error.message);
      setCancellingPlan(false);
      return;
    }

    try {
      await refreshWorkspace();

      setShowCancelPlan(false);

      setSuccessMessage(
        "Development plan cancelled."
      );
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "Plan cancelled, but the page could not be refreshed."
      );
    } finally {
      setCancellingPlan(false);
    }
  }

  async function savePlanChanges() {
    if (!plan) {
      return;
    }

    if (!editDraft.title.trim()) {
      setMessage(
        "Development plan title is required."
      );
      return;
    }

    setSavingPlan(true);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_update_development_plan",
      {
        p_development_plan_id:
          plan.development_plan_id,

        p_title:
          editDraft.title.trim(),

        p_description:
          editDraft.description.trim()
            ? editDraft.description.trim()
            : null,

        p_development_type:
          editDraft.developmentType,

        p_priority:
          editDraft.priority,

        p_due_date:
          editDraft.dueDate || null,

        p_owner_user_id:
          editDraft.ownerUserId || null,

        p_manager_notes:
          editDraft.managerNotes.trim()
            ? editDraft.managerNotes.trim()
            : null,
      }
    );

    if (error) {
      setMessage(error.message);
      setSavingPlan(false);
      return;
    }

    try {
      await refreshWorkspace();

      setShowEditPlan(false);

      setSuccessMessage(
        "Development plan updated."
      );
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "Plan updated, but the page could not be refreshed."
      );
    } finally {
      setSavingPlan(false);
    }
  }

  async function loadPlan() {
    const { data, error } = await supabase
      .from("v_development_plan_resolution")
      .select("*")
      .eq("development_plan_id", planId)
      .maybeSingle();

    if (error) throw error;
    if (!data) throw new Error("Development plan not found or access denied.");
    const loadedPlan =
      data as DevelopmentPlan;

    setPlan(loadedPlan);

    await loadPlanOwner(
      loadedPlan.employee_id,
      loadedPlan.owner_user_id
    );
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

async function loadPracticalEvidence() {
  const { data, error } = await supabase
    .from("v_development_plan_practical_evidence")
    .select(`
      development_plan_id,
      competency_name_snapshot,
      required_level,
      verification_id,
      verified_level,
      verification_status,
      verified_by,
      verified_at,
      notes,
      verification_satisfied,
      resolution_status,
      resolved_at
    `)
    .eq("development_plan_id", planId)
    .maybeSingle();

  if (error) throw error;

  setPracticalEvidence(
    data ? (data as PracticalEvidence) : null
  );
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
    loadPracticalEvidence(),
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
  "wri_start_targeted_reassessment",
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
    if (
      plan?.resolution_status === "resolved"
    ) {
      setMessage(
        "Resolved development plans are read-only."
      );
      return;
    }

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

  async function updateActivityStatus(
    activityId: string,
    status: string,
    notes: string | null = null,
    evidenceUrl: string | null = null
  ) {
    if (
      plan?.resolution_status === "resolved" ||
      plan?.resolution_status === "cancelled" ||
      plan?.status === "cancelled"
    ) {
      setMessage(
        "Resolved or cancelled development plans are read-only."
      );
      return;
    }

    if (status === "completed" && notes === null) {
      const activity = activities.find(
        (item) => item.id === activityId
      );

      setCompletingActivityId(activityId);
      setCompletionNotes(
        activity?.completion_notes ?? ""
      );

      setCompletionEvidenceUrl(
        activity?.evidence_url ?? ""
      );

      setMessage("");
      setSuccessMessage("");
      return;
    }

    setSavingActivityId(activityId);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_update_development_activity_status",
      {
        p_activity_id: activityId,
        p_status: status,
        p_completion_notes:
          status === "completed" &&
          notes?.trim()
            ? notes.trim()
            : null,

        p_evidence_url:
          status === "completed" &&
          evidenceUrl?.trim()
            ? evidenceUrl.trim()
            : null,
      }
    );

    if (error) {
      setMessage(error.message);
      setSavingActivityId(null);
      return;
    }

    try {
      await refreshWorkspace();

      setCompletingActivityId(null);
      setCompletionNotes("");
      setCompletionEvidenceUrl("");

      setSuccessMessage(
        status === "completed"
          ? "Development activity completed."
          : "Activity status updated."
      );
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "Status was updated, but the workspace could not refresh."
      );
    }

    setSavingActivityId(null);
  }

  function cancelActivityCompletion() {
    setCompletingActivityId(null);
    setCompletionNotes("");
    setCompletionEvidenceUrl("");
  }

  async function confirmActivityCompletion(
    activityId: string
  ) {
    if (!completionNotes.trim()) {
      setMessage(
        "Add completion notes before completing this activity."
      );
      return;
    }

    await updateActivityStatus(
      activityId,
      "completed",
      completionNotes,
      completionEvidenceUrl
    );
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
      return "bg-slate-200 text-slate-700";
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
            href="/dashboard"
            className="mt-6 inline-block text-cyan-400 hover:text-cyan-300"
          >
            ← Training System Home
          </Link>
        </div>
      </main>
    );
  }

 const displayedProgressPercent =
  plan.resolution_status === "resolved"
    ? 100
    : Number(plan.completion_percent);

return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <SystemHeader
          title="Development Plan"
          subtitle={`${plan.first_name} ${plan.last_name}${
            plan.employee_number
              ? ` · ${plan.employee_number}`
              : ""
          }`}
          backHref="/readiness-actions"
          backLabel="Readiness Actions"
          showHome={true}
          showSignOut={true}
        >
          <Link
            href={`/employees/${plan.employee_id}`}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
          >
            Employee Profile
          </Link>

          {plan.resolution_status !== "resolved" &&
            plan.resolution_status !== "cancelled" &&
            plan.status !== "cancelled" && (
              <>
                <button
                  type="button"
                  onClick={openEditPlan}
                  className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                >
                  Edit Plan
                </button>

                <button
                  type="button"
                  onClick={openCancelPlan}
                  className="rounded-lg border border-rose-500/50 bg-rose-500/10 px-4 py-2 text-sm font-medium text-rose-300 transition hover:bg-rose-500/20"
                >
                  Cancel Plan
                </button>
              </>
            )}
        </SystemHeader>

        {message && (
          <div className="mb-6 rounded-xl border border-rose-500/30 bg-rose-500/10 p-5 text-sm text-rose-200">{message}</div>
        )}
        {successMessage && (
          <div className="mb-6 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-5 text-sm text-emerald-200">{successMessage}</div>
        )}

        {showCancelPlan && (
          <section className="mb-6 rounded-2xl border border-rose-500/30 bg-rose-500/10 p-6 sm:p-8">
            <div className="flex flex-col gap-5 lg:flex-row lg:items-start lg:justify-between">
              <div className="max-w-3xl">
                <p className="text-xs font-medium uppercase tracking-wide text-rose-300">
                  Plan Lifecycle
                </p>

                <h2 className="mt-2 text-2xl font-semibold">
                  Cancel Development Plan?
                </h2>

                <p className="mt-3 text-sm leading-6 text-slate-300">
                  Cancelling this plan ends the development workflow and makes
                  the plan read-only. Existing activities and plan history will
                  remain available for reference.
                </p>

                <p className="mt-3 text-sm font-medium text-rose-300">
                  This action cannot currently be reversed in the Training System.
                </p>
              </div>

              <div className="flex flex-wrap gap-3">
                <button
                  type="button"
                  onClick={closeCancelPlan}
                  disabled={cancellingPlan}
                  className="rounded-lg border border-slate-700 px-5 py-3 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900 disabled:opacity-50"
                >
                  Keep Plan
                </button>

                <button
                  type="button"
                  onClick={cancelDevelopmentPlan}
                  disabled={cancellingPlan}
                  className="rounded-lg bg-rose-500 px-5 py-3 text-sm font-semibold text-white transition hover:bg-rose-400 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {cancellingPlan
                    ? "Cancelling..."
                    : "Confirm Cancellation"}
                </button>
              </div>
            </div>
          </section>
        )}

        {showEditPlan && (
          <section className="mb-6 rounded-2xl border border-cyan-500/30 bg-slate-900 p-6 sm:p-8">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <p className="text-xs font-medium uppercase tracking-wide text-cyan-300">
                  Plan Management
                </p>

                <h2 className="mt-2 text-2xl font-semibold">
                  Edit Development Plan
                </h2>

                <p className="mt-2 text-sm text-slate-400">
                  Update ownership, timing, priority, and development instructions.
                </p>
              </div>

              <button
                type="button"
                onClick={cancelEditPlan}
                disabled={savingPlan}
                className="w-fit rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-100 hover:text-slate-900 disabled:opacity-50"
              >
                Cancel
              </button>
            </div>

            <div className="mt-7 grid gap-5 lg:grid-cols-2">
              <label className="text-sm text-slate-300 lg:col-span-2">
                Plan Title

                <input
                  value={editDraft.title}
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      title: event.target.value,
                    }))
                  }
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                />
              </label>

              <label className="text-sm text-slate-300 lg:col-span-2">
                Description

                <textarea
                  value={editDraft.description}
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      description:
                        event.target.value,
                    }))
                  }
                  rows={4}
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                />
              </label>

              <label className="text-sm text-slate-300">
                Development Type

                <select
                  value={
                    editDraft.developmentType
                  }
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      developmentType:
                        event.target.value,
                    }))
                  }
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                >
                  <option value="training">
                    Training
                  </option>
                  <option value="coaching">
                    Coaching
                  </option>
                  <option value="field_practice">
                    Field Practice
                  </option>
                  <option value="practical_verification">
                    Practical Verification
                  </option>
                  <option value="reassessment">
                    Reassessment
                  </option>
                  <option value="mentoring">
                    Mentoring
                  </option>
                  <option value="observation">
                    Observation
                  </option>
                  <option value="other">
                    Other
                  </option>
                </select>
              </label>

              <label className="text-sm text-slate-300">
                Priority

                <select
                  value={editDraft.priority}
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      priority:
                        event.target.value,
                    }))
                  }
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                >
                  <option value="critical">
                    Critical
                  </option>
                  <option value="high">
                    High
                  </option>
                  <option value="medium">
                    Medium
                  </option>
                  <option value="low">
                    Low
                  </option>
                </select>
              </label>

              <label className="text-sm text-slate-300">
                Due Date

                <input
                  type="date"
                  value={editDraft.dueDate}
                  min={plan.start_date ?? undefined}
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      dueDate:
                        event.target.value,
                    }))
                  }
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                />
              </label>

              <label className="text-sm text-slate-300">
                Plan Owner

                <select
                  value={
                    editDraft.ownerUserId
                  }
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      ownerUserId:
                        event.target.value,
                    }))
                  }
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                >
                  <option value="">
                    Unassigned
                  </option>

                  {editOwners.map((owner) => (
                    <option
                      key={owner.user_id}
                      value={owner.user_id}
                    >
                      {owner.first_name}{" "}
                      {owner.last_name}
                      {" · "}
                      {owner.role ===
                      "CLIENT_ADMIN"
                        ? "Client Admin"
                        : owner.role ===
                            "INTEGRATEU_ADMIN"
                          ? "IntegrateU Admin"
                          : owner.role}
                    </option>
                  ))}
                </select>
              </label>

              <label className="text-sm text-slate-300 lg:col-span-2">
                Manager Notes

                <textarea
                  value={
                    editDraft.managerNotes
                  }
                  onChange={(event) =>
                    setEditDraft((current) => ({
                      ...current,
                      managerNotes:
                        event.target.value,
                    }))
                  }
                  rows={4}
                  className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                />
              </label>
            </div>

            <div className="mt-6 flex flex-wrap justify-end gap-3">
              <button
                type="button"
                onClick={cancelEditPlan}
                disabled={savingPlan}
                className="rounded-lg border border-slate-700 px-5 py-3 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900 disabled:opacity-50"
              >
                Cancel
              </button>

              <button
                type="button"
                onClick={savePlanChanges}
                disabled={
                  savingPlan ||
                  !editDraft.title.trim()
                }
                className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
              >
                {savingPlan
                  ? "Saving..."
                  : "Save Changes"}
              </button>
            </div>
          </section>
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
                  <div><p className="text-sm text-slate-400">Progress</p><p className="mt-1 text-4xl font-bold">{plan.resolution_status === "awaiting_verification" &&
plan.activities_total === 0
  ? "Awaiting Verification"
  : `${displayedProgressPercent}%`}</p></div>
                 <p className="text-sm text-slate-400">
  {plan.resolution_status === "resolved" &&
plan.activities_total === 0
  ? "Resolved by verification"
  : plan.resolution_status === "awaiting_verification" &&
    plan.activities_total === 0
    ? "Development requirements complete"
    : `${plan.activities_completed}/${plan.activities_total} complete`}
</p>
                </div>
                <div className="mt-4 h-3 overflow-hidden rounded-full bg-slate-800">
                  <div className="h-full rounded-full bg-cyan-400" style={{ width: `${Math.min(100, Math.max(0, Number(displayedProgressPercent)))}%` }} />
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

{practicalEvidence && (
  <section className="mt-6 rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
    <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
      <div>
        <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
          Resolution Evidence
        </p>

        <h2 className="mt-2 text-xl font-semibold">
          Practical Verification
        </h2>

        <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
          This evidence shows the practical verification used to determine
          whether the competency requirement has been satisfied.
        </p>
      </div>

      {practicalEvidence.verification_satisfied && (
        <span className="w-fit rounded-full bg-emerald-500/15 px-3 py-1 text-xs font-medium text-emerald-300">
          Requirement Satisfied
        </span>
      )}
    </div>

    <div className="mt-7 grid gap-4 md:grid-cols-3">
      <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
        <p className="text-sm text-slate-500">
          Required Level
        </p>

        <p className="mt-2 text-4xl font-bold">
          {practicalEvidence.required_level ?? "—"}
        </p>

        <p className="mt-2 text-xs text-slate-500">
          Minimum practical level required for this competency
        </p>
      </div>

      <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
        <p className="text-sm text-slate-500">
          Verified Level
        </p>

        <p
          className={`mt-2 text-4xl font-bold ${
            practicalEvidence.verification_satisfied
              ? "text-emerald-300"
              : "text-white"
          }`}
        >
          {practicalEvidence.verified_level ?? "Pending"}
        </p>

        <p className="mt-2 text-xs text-slate-500">
          Recorded practical competency rating
        </p>
      </div>

      <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
        <p className="text-sm text-slate-500">
          Verification Status
        </p>

        <p className="mt-2 text-2xl font-bold capitalize">
          {practicalEvidence.verification_status
            ? practicalEvidence.verification_status.replaceAll("_", " ")
            : "Pending"}
        </p>

        <p className="mt-2 text-xs text-slate-500">
          {practicalEvidence.competency_name_snapshot || "Practical competency"}
        </p>
      </div>
    </div>

    {practicalEvidence.verification_satisfied && (
      <div className="mt-5 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-5">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p className="font-semibold text-emerald-300">
              ✓ Practical requirement satisfied
            </p>

            <p className="mt-1 text-sm text-emerald-200/70">
              The verified practical level meets or exceeds the required level.
            </p>
          </div>

          <div className="text-sm text-slate-400 sm:text-right">
            {practicalEvidence.verified_at && (
              <p>
                Verified {formatDateTime(practicalEvidence.verified_at)}
              </p>
            )}

            {practicalEvidence.resolved_at && (
              <p className="mt-1 text-xs text-slate-500">
                Plan resolved {formatDateTime(practicalEvidence.resolved_at)}
              </p>
            )}
          </div>
        </div>
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
              {plan.resolution_status === "development_in_progress" &&
                plan.status !== "cancelled" && (
                <button
                  type="button"
                  onClick={() =>
                    setShowAddActivity(
                      (current) => !current
                    )
                  }
                  className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                >
                  {showAddActivity
                    ? "Cancel"
                    : "Add Activity"}
                </button>
              )}
            </div>

            {showAddActivity &&
              plan.resolution_status === "development_in_progress" &&
              plan.status !== "cancelled" && (
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
                        {activity.completion_notes && (
                          <div className="mt-4 rounded-xl border border-emerald-500/20 bg-emerald-500/10 p-4">
                            <p className="text-xs font-medium uppercase tracking-wide text-emerald-300">
                              Completion Notes
                            </p>

                            <p className="mt-2 text-sm leading-6 text-slate-300">
                              {activity.completion_notes}
                            </p>

                            {activity.completed_at && (
                              <p className="mt-2 text-xs text-slate-500">
                                Completed {formatDateTime(activity.completed_at)}
                              </p>
                            )}

                            {activity.evidence_url && (
                              <a
                                href={activity.evidence_url}
                                target="_blank"
                                rel="noreferrer"
                                className="mt-3 inline-block text-sm font-medium text-cyan-400 transition hover:text-cyan-300"
                              >
                                View Evidence →
                              </a>
                            )}
                          </div>
                        )}

                        {completingActivityId === activity.id && (
                          <div className="mt-4 rounded-xl border border-cyan-500/30 bg-cyan-500/10 p-4">
                            <p className="text-sm font-semibold text-cyan-300">
                              Complete Activity
                            </p>

                            <p className="mt-1 text-xs leading-5 text-slate-400">
                              Record what was completed, observed, or demonstrated.
                            </p>

                            <textarea
                              value={completionNotes}
                              onChange={(event) =>
                                setCompletionNotes(
                                  event.target.value
                                )
                              }
                              rows={4}
                              placeholder="Example: Completed manufacturer training and demonstrated proper configuration during supervised field work."
                              className="mt-4 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none placeholder:text-slate-600 focus:border-cyan-400"
                            />

                            <label className="mt-4 block text-sm text-slate-300">
                              Evidence Link
                              <span className="ml-2 text-xs text-slate-500">
                                Optional
                              </span>

                              <input
                                type="url"
                                value={completionEvidenceUrl}
                                onChange={(event) =>
                                  setCompletionEvidenceUrl(
                                    event.target.value
                                  )
                                }
                                placeholder="https://..."
                                className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none placeholder:text-slate-600 focus:border-cyan-400"
                              />

                              <span className="mt-2 block text-xs leading-5 text-slate-500">
                                Add a link to a certificate, LMS record, photo folder,
                                video, manufacturer credential, or other supporting evidence.
                              </span>
                            </label>

                            <div className="mt-4 flex flex-wrap justify-end gap-3">
                              <button
                                type="button"
                                onClick={cancelActivityCompletion}
                                disabled={
                                  savingActivityId ===
                                  activity.id
                                }
                                className="rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 transition hover:bg-slate-100 hover:text-slate-900 disabled:opacity-50"
                              >
                                Cancel
                              </button>

                              <button
                                type="button"
                                onClick={() =>
                                  confirmActivityCompletion(
                                    activity.id
                                  )
                                }
                                disabled={
                                  savingActivityId ===
                                    activity.id ||
                                  !completionNotes.trim()
                                }
                                className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
                              >
                                {savingActivityId ===
                                activity.id
                                  ? "Completing..."
                                  : "Confirm Complete"}
                              </button>
                            </div>
                          </div>
                        )}
                      </div>
                      <select value={activity.status} disabled={
                          savingActivityId === activity.id ||
                          completingActivityId === activity.id ||
                          plan.resolution_status === "resolved" ||
                          plan.resolution_status === "cancelled" ||
                          plan.status === "cancelled"
                        } onChange={(event) => updateActivityStatus(activity.id, event.target.value)} className="rounded-lg border border-slate-700 bg-slate-950 px-3 py-2 text-sm outline-none focus:border-cyan-400 disabled:opacity-50">
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
              <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                Plan Owner
              </p>

              {plan.owner_user_id ? (
                planOwner ? (
                  <>
                    <p className="mt-3 font-semibold">
                      {planOwner.first_name}{" "}
                      {planOwner.last_name}
                    </p>

                    <p className="mt-2 text-sm text-slate-400">
                      {planOwner.role === "CLIENT_ADMIN"
                        ? "Client Admin"
                        : planOwner.role ===
                            "INTEGRATEU_ADMIN"
                          ? "IntegrateU Admin"
                          : planOwner.role}
                    </p>
                  </>
                ) : (
                  <p className="mt-3 text-sm text-slate-400">
                    Assigned owner
                  </p>
                )
              ) : (
                <p className="mt-3 text-sm text-slate-400">
                  No owner assigned
                </p>
              )}
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
