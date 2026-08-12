"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import SystemHeader from "@/components/SystemHeader";
import { supabase } from "@/lib/supabase";

type DevelopmentPlanResolution = {
  development_plan_id: string;
  client_id: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;

  action_key: string | null;
  action_type: string | null;
  action_label: string | null;

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

  activities_total: number;
  activities_completed: number;
  activities_blocked: number;
  completion_percent: number;

  overdue: boolean;

  resolution_status:
    | "development_in_progress"
    | "awaiting_reassessment"
    | "awaiting_verification"
    | "awaiting_reverification"
    | "resolved"
    | "cancelled";

  development_completed_at: string | null;
  awaiting_evidence_since: string | null;
  resolved_at: string | null;
  resolution_notes: string | null;

  readiness_action_still_open: boolean | null;
  resolution_label: string;
};

type EmployeeOption = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
};

type PlanOwnerOption = {
  user_id: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  role: string;
  client_id: string | null;
};

type DevelopmentPlanOwnerFilterOption = {
  user_id: string;
  first_name: string;
  last_name: string;
  role: string;
};

type ResolutionFilter =
  | "all"
  | "open"
  | "development_in_progress"
  | "awaiting_verification"
  | "awaiting_reassessment"
  | "awaiting_reverification"
  | "resolved";

type AttentionFilter =
  | "all"
  | "due_soon"
  | "overdue"
  | "blocked";

type PriorityFilter =
  | "all"
  | "critical"
  | "high"
  | "medium"
  | "low";

type NewPlanDraft = {
  employeeId: string;
  ownerUserId: string;
  title: string;
  description: string;
  developmentType: string;
  priority: string;
  dueDate: string;
  managerNotes: string;
};

export default function DevelopmentPlansCenterPage() {
  const router = useRouter();

  const [plans, setPlans] =
    useState<DevelopmentPlanResolution[]>([]);

  const [employees, setEmployees] =
    useState<EmployeeOption[]>([]);

  const [owners, setOwners] =
    useState<PlanOwnerOption[]>([]);

  const [message, setMessage] =
    useState("Loading development plans...");

  const [successMessage, setSuccessMessage] =
    useState("");

  const [search, setSearch] =
    useState("");

  const [currentUserId, setCurrentUserId] =
    useState("");

  const [ownerFilter, setOwnerFilter] =
    useState("all");

  const [planOwnerOptions, setPlanOwnerOptions] =
    useState<DevelopmentPlanOwnerFilterOption[]>([]);

  const [resolutionFilter, setResolutionFilter] =
    useState<ResolutionFilter>("open");

  const [priorityFilter, setPriorityFilter] =
    useState<PriorityFilter>("all");

  const [attentionFilter, setAttentionFilter] =
    useState<AttentionFilter>("all");

  const [showCreatePlan, setShowCreatePlan] =
    useState(false);

  const [creatingPlan, setCreatingPlan] =
    useState(false);

  const [draft, setDraft] =
    useState<NewPlanDraft>({
      employeeId: "",
      ownerUserId: "",
      title: "",
      description: "",
      developmentType: "training",
      priority: "medium",
      dueDate: "",
      managerNotes: "",
    });

  async function loadPlans() {
    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_list_development_plan_resolutions",
      {
        p_employee_id: null,
        p_resolution_status: null,
      }
    );

    if (error) {
      setMessage(error.message);
      return;
    }

    const planRows =
      (data ?? []) as DevelopmentPlanResolution[];

    setPlans(planRows);

    await loadPlanOwnerOptions(planRows);
  }

  async function loadEmployees() {
    const {
      data,
      error,
    } = await supabase
      .from("employees")
      .select(`
        id,
        first_name,
        last_name,
        employee_number
      `)
      .order("last_name", { ascending: true })
      .order("first_name", { ascending: true });

    if (error) {
      setMessage(error.message);
      return;
    }

    const rows =
      (data ?? []) as EmployeeOption[];

    setEmployees(rows);

    setDraft((current) => ({
      ...current,
      employeeId:
        current.employeeId ||
        rows[0]?.id ||
        "",
    }));
  }

  async function loadPlanOwnerOptions(
    planRows: DevelopmentPlanResolution[]
  ) {
    const employeeIds = Array.from(
      new Set(
        planRows
          .filter((plan) => plan.owner_user_id)
          .map((plan) => plan.employee_id)
      )
    );

    if (employeeIds.length === 0) {
      setPlanOwnerOptions([]);
      return;
    }

    const results = await Promise.all(
      employeeIds.map(async (employeeId) => {
        const { data, error } =
          await supabase.rpc(
            "wri_list_development_plan_owners",
            {
              p_employee_id: employeeId,
            }
          );

        if (error) {
          console.error(
            "Unable to load plan owners:",
            error
          );
          return [];
        }

        return (
          (data ?? []) as PlanOwnerOption[]
        );
      })
    );

    const uniqueOwners =
      new Map<
        string,
        DevelopmentPlanOwnerFilterOption
      >();

    results.flat().forEach((owner) => {
      if (!uniqueOwners.has(owner.user_id)) {
        uniqueOwners.set(owner.user_id, {
          user_id: owner.user_id,
          first_name: owner.first_name,
          last_name: owner.last_name,
          role: owner.role,
        });
      }
    });

    setPlanOwnerOptions(
      Array.from(uniqueOwners.values()).sort(
        (a, b) =>
          `${a.last_name} ${a.first_name}`.localeCompare(
            `${b.last_name} ${b.first_name}`
          )
      )
    );
  }

  async function loadOwners(
    employeeId: string
  ) {
    if (!employeeId) {
      setOwners([]);

      setDraft((current) => ({
        ...current,
        ownerUserId: "",
      }));

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
      setMessage(error.message);
      setOwners([]);
      return;
    }

    const rows =
      (data ?? []) as PlanOwnerOption[];

    setOwners(rows);

    setDraft((current) => ({
      ...current,
      ownerUserId:
        rows.some(
          (owner) =>
            owner.user_id ===
            current.ownerUserId
        )
          ? current.ownerUserId
          : rows[0]?.user_id || "",
    }));
  }

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

      setCurrentUserId(
        sessionData.session.user.id
      );

      await Promise.all([
        loadPlans(),
        loadEmployees(),
      ]);

      setMessage("");
    }

    loadPage();
  }, [router]);

  useEffect(() => {
    if (!draft.employeeId) {
      setOwners([]);
      return;
    }

    loadOwners(draft.employeeId);
  }, [draft.employeeId]);

  async function createPlan() {
    if (!draft.employeeId) {
      setMessage("Employee is required.");
      return;
    }

    if (!draft.title.trim()) {
      setMessage("Development plan title is required.");
      return;
    }

    setCreatingPlan(true);
    setMessage("");
    setSuccessMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_create_manual_development_plan",
      {
        p_employee_id: draft.employeeId,
        p_title: draft.title.trim(),
        p_description:
          draft.description.trim() || null,
        p_development_type:
          draft.developmentType,
        p_priority:
          draft.priority,
        p_due_date:
          draft.dueDate || null,
        p_owner_user_id:
          draft.ownerUserId || null,
        p_manager_notes:
          draft.managerNotes.trim() || null,
      }
    );

    if (error) {
      setMessage(error.message);
      setCreatingPlan(false);
      return;
    }

    if (!data) {
      setMessage(
        "The development plan could not be created."
      );
      setCreatingPlan(false);
      return;
    }

    setSuccessMessage(
      "Development plan created."
    );

    setCreatingPlan(false);

    router.push(
      `/development-plans/${data}`
    );
  }

  function isOpenPlan(
    plan: DevelopmentPlanResolution
  ) {
    return ![
      "resolved",
      "cancelled",
    ].includes(plan.resolution_status);
  }

  function isDueSoon(
    plan: DevelopmentPlanResolution
  ) {
    if (
      !plan.due_date ||
      plan.overdue ||
      !isOpenPlan(plan)
    ) {
      return false;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const dueDate = new Date(
      `${plan.due_date}T12:00:00`
    );
    dueDate.setHours(0, 0, 0, 0);

    const differenceMs =
      dueDate.getTime() - today.getTime();

    const differenceDays =
      Math.round(
        differenceMs /
          (1000 * 60 * 60 * 24)
      );

    return (
      differenceDays >= 0 &&
      differenceDays <= 7
    );
  }

const counts = useMemo(() => {
    const openPlans =
      plans.filter(
        (plan) =>
          ![
            "resolved",
            "cancelled",
          ].includes(
            plan.resolution_status
          )
      ).length;

    const awaitingVerification =
      plans.filter(
        (plan) =>
          plan.resolution_status ===
          "awaiting_verification"
      ).length;

    const overdue =
      plans.filter(
        (plan) =>
          plan.overdue &&
          isOpenPlan(plan)
      ).length;

    const dueSoon =
      plans.filter(
        (plan) =>
          isDueSoon(plan)
      ).length;

    const blocked =
      plans.filter(
        (plan) =>
          Number(plan.activities_blocked) > 0 &&
          isOpenPlan(plan)
      ).length;

    const resolved =
      plans.filter(
        (plan) =>
          plan.resolution_status ===
          "resolved"
      ).length;

    return {
      openPlans,
      awaitingVerification,
      overdue,
      dueSoon,
      blocked,
      resolved,
    };
  }, [plans]);

  const filteredPlans = useMemo(() => {
    const normalizedSearch =
      search.trim().toLowerCase();

    return plans.filter((plan) => {
      const matchesSearch =
        normalizedSearch.length === 0 ||
        [
          plan.first_name,
          plan.last_name,
          plan.employee_number ?? "",
          plan.title,
          plan.competency_name_snapshot ?? "",
          plan.role_name_snapshot ?? "",
          plan.action_label ?? "",
        ]
          .join(" ")
          .toLowerCase()
          .includes(normalizedSearch);

      if (!matchesSearch) {
        return false;
      }

      if (
        priorityFilter !== "all" &&
        plan.priority !== priorityFilter
      ) {
        return false;
      }

      if (
        ownerFilter === "mine" &&
        plan.owner_user_id !== currentUserId
      ) {
        return false;
      }

      if (
        ownerFilter !== "all" &&
        ownerFilter !== "mine" &&
        plan.owner_user_id !== ownerFilter
      ) {
        return false;
      }

      if (
        attentionFilter === "due_soon" &&
        !isDueSoon(plan)
      ) {
        return false;
      }

      if (
        attentionFilter === "overdue" &&
        !(
          plan.overdue &&
          isOpenPlan(plan)
        )
      ) {
        return false;
      }

      if (
        attentionFilter === "blocked" &&
        !(
          Number(plan.activities_blocked) > 0 &&
          isOpenPlan(plan)
        )
      ) {
        return false;
      }

      if (
        resolutionFilter === "open"
      ) {
        return ![
          "resolved",
          "cancelled",
        ].includes(
          plan.resolution_status
        );
      }

      if (
        resolutionFilter !== "all" &&
        plan.resolution_status !==
          resolutionFilter
      ) {
        return false;
      }

      return true;
    });
  }, [
    plans,
    search,
    priorityFilter,
    resolutionFilter,
    ownerFilter,
    currentUserId,
    attentionFilter,
  ]);

  function formatDate(
    value: string | null
  ) {
    if (!value) {
      return "No due date";
    }

    return new Date(
      `${value}T12:00:00`
    ).toLocaleDateString();
  }

  function resolutionClass(
    status: string
  ) {
    switch (status) {
      case "resolved":
        return "bg-emerald-500/15 text-emerald-300";

      case "awaiting_verification":
      case "awaiting_reverification":
        return "bg-cyan-500/15 text-cyan-300";

      case "awaiting_reassessment":
        return "bg-amber-500/15 text-amber-300";

      case "cancelled":
        return "bg-slate-800 text-slate-400";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function priorityClass(
    priority: string
  ) {
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

  function displayedProgress(
    plan: DevelopmentPlanResolution
  ) {
    if (
      plan.resolution_status ===
      "resolved"
    ) {
      return 100;
    }

    return Number(
      plan.completion_percent
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <SystemHeader
          title="Development Plans"
          subtitle="Track employee development work from readiness gap through final resolution."
          showHome={true}
          showSignOut={true}
        >
          <Link
            href="/readiness-actions"
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
          >
            Readiness Actions
          </Link>

          <button
            type="button"
            onClick={() =>
              setShowCreatePlan(
                (current) => !current
              )
            }
            className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
          >
            {showCreatePlan
              ? "Cancel"
              : "Create Development Plan"}
          </button>
        </SystemHeader>

        {message && (
          <div className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}


        {successMessage && (
          <div className="mb-8 rounded-2xl border border-emerald-500/30 bg-emerald-500/10 p-6 text-emerald-200">
            {successMessage}
          </div>
        )}

        {showCreatePlan && (
          <section className="mb-8 rounded-2xl border border-cyan-500/30 bg-slate-900 p-6 sm:p-8">
            <div className="mb-6">
              <p className="text-sm font-medium text-cyan-400">
                New Development Plan
              </p>

              <h2 className="mt-2 text-2xl font-semibold">
                Create Development Plan
              </h2>

              <p className="mt-2 text-sm text-slate-400">
                Create manager-assigned development work that is not tied to a specific readiness action.
              </p>
            </div>

            <div className="grid gap-5 md:grid-cols-2">
              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Employee
                </label>

                <select
                  value={draft.employeeId}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      employeeId:
                        event.target.value,
                      ownerUserId: "",
                    }))
                  }
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white"
                >
                  <option value="">
                    Select employee
                  </option>

                  {employees.map((employee) => (
                    <option
                      key={employee.id}
                      value={employee.id}
                    >
                      {employee.first_name}{" "}
                      {employee.last_name}
                      {employee.employee_number
                        ? ` · ${employee.employee_number}`
                        : ""}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Plan Owner
                </label>

                <select
                  value={draft.ownerUserId}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      ownerUserId:
                        event.target.value,
                    }))
                  }
                  disabled={
                    !draft.employeeId ||
                    owners.length === 0
                  }
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {owners.length === 0 ? (
                    <option value="">
                      No eligible owner
                    </option>
                  ) : (
                    owners.map((owner) => (
                      <option
                        key={owner.user_id}
                        value={owner.user_id}
                      >
                        {owner.first_name}{" "}
                        {owner.last_name} (
                        {owner.role ===
                        "CLIENT_ADMIN"
                          ? "Client Admin"
                          : owner.role ===
                              "INTEGRATEU_ADMIN"
                            ? "IntegrateU Admin"
                            : owner.role}
                        )
                      </option>
                    ))
                  )}
                </select>
              </div>

              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Title
                </label>

                <input
                  value={draft.title}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      title: event.target.value,
                    }))
                  }
                  placeholder="Example: Networking Skill Development"
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white placeholder:text-slate-600"
                />
              </div>

              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Development Type
                </label>

                <select
                  value={draft.developmentType}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      developmentType:
                        event.target.value,
                    }))
                  }
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white"
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
                  <option value="mentoring">
                    Mentoring
                  </option>
                  <option value="observation">
                    Observation
                  </option>
                  <option value="practical_verification">
                    Practical Verification
                  </option>
                  <option value="reassessment">
                    Reassessment
                  </option>
                  <option value="other">
                    Other
                  </option>
                </select>
              </div>

              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Priority
                </label>

                <select
                  value={draft.priority}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      priority:
                        event.target.value,
                    }))
                  }
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white"
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
              </div>

              <div>
                <label className="mb-2 block text-sm text-slate-300">
                  Due Date
                </label>

                <input
                  type="date"
                  value={draft.dueDate}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      dueDate:
                        event.target.value,
                    }))
                  }
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white"
                />
              </div>

              <div className="md:col-span-2">
                <label className="mb-2 block text-sm text-slate-300">
                  Description
                </label>

                <textarea
                  rows={4}
                  value={draft.description}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      description:
                        event.target.value,
                    }))
                  }
                  placeholder="Describe the development objective and expected outcome."
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white placeholder:text-slate-600"
                />
              </div>

              <div className="md:col-span-2">
                <label className="mb-2 block text-sm text-slate-300">
                  Manager Notes
                </label>

                <textarea
                  rows={3}
                  value={draft.managerNotes}
                  onChange={(event) =>
                    setDraft((current) => ({
                      ...current,
                      managerNotes:
                        event.target.value,
                    }))
                  }
                  placeholder="Optional internal notes."
                  className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-white placeholder:text-slate-600"
                />
              </div>
            </div>

            <div className="mt-6 flex flex-wrap justify-end gap-3">
              <button
                type="button"
                onClick={() =>
                  setShowCreatePlan(false)
                }
                className="rounded-lg border border-slate-700 px-5 py-3 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
              >
                Cancel
              </button>

              <button
                type="button"
                onClick={createPlan}
                disabled={creatingPlan}
                className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
              >
                {creatingPlan
                  ? "Creating..."
                  : "Create Development Plan"}
              </button>
            </div>
          </section>
        )}

        <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          <MetricCard
            label="Open Plans"
            value={counts.openPlans}
          />

          <MetricCard
            label="Due Soon"
            value={counts.dueSoon}
            valueClass="text-amber-300"
          />

          <MetricCard
            label="Overdue"
            value={counts.overdue}
            valueClass="text-rose-300"
          />

          <MetricCard
            label="Blocked"
            value={counts.blocked}
            valueClass="text-rose-300"
          />
        </section>

        <section className="mt-8 rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <div className="grid gap-5 lg:grid-cols-[1fr_auto] lg:items-end">
            <div>
              <label className="text-xs font-medium uppercase tracking-wide text-slate-500">
                Search
              </label>

              <input
                value={search}
                onChange={(event) =>
                  setSearch(
                    event.target.value
                  )
                }
                placeholder="Employee, role, competency, or plan..."
                className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none transition placeholder:text-slate-600 focus:border-cyan-400"
              />
            </div>

            <p className="text-sm text-slate-400">
              Showing{" "}
              <span className="font-semibold text-white">
                {filteredPlans.length}
              </span>{" "}
              plans
            </p>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Attention
            </p>

            <div className="flex flex-wrap gap-2">
              <FilterButton
                active={
                  attentionFilter === "all"
                }
                onClick={() =>
                  setAttentionFilter("all")
                }
              >
                All
              </FilterButton>

              <FilterButton
                active={
                  attentionFilter ===
                  "due_soon"
                }
                onClick={() =>
                  setAttentionFilter(
                    "due_soon"
                  )
                }
              >
                Due Soon ({counts.dueSoon})
              </FilterButton>

              <FilterButton
                active={
                  attentionFilter ===
                  "overdue"
                }
                onClick={() =>
                  setAttentionFilter(
                    "overdue"
                  )
                }
              >
                Overdue ({counts.overdue})
              </FilterButton>

              <FilterButton
                active={
                  attentionFilter ===
                  "blocked"
                }
                onClick={() =>
                  setAttentionFilter(
                    "blocked"
                  )
                }
              >
                Blocked ({counts.blocked})
              </FilterButton>
            </div>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Resolution
            </p>

            <div className="flex flex-wrap gap-2">
              <FilterButton
                active={
                  resolutionFilter ===
                  "open"
                }
                onClick={() =>
                  setResolutionFilter(
                    "open"
                  )
                }
              >
                Open
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "development_in_progress"
                }
                onClick={() =>
                  setResolutionFilter(
                    "development_in_progress"
                  )
                }
              >
                Development
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "awaiting_verification"
                }
                onClick={() =>
                  setResolutionFilter(
                    "awaiting_verification"
                  )
                }
              >
                Awaiting Verification
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "awaiting_reassessment"
                }
                onClick={() =>
                  setResolutionFilter(
                    "awaiting_reassessment"
                  )
                }
              >
                Awaiting Reassessment
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "awaiting_reverification"
                }
                onClick={() =>
                  setResolutionFilter(
                    "awaiting_reverification"
                  )
                }
              >
                Awaiting Reverification
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "resolved"
                }
                onClick={() =>
                  setResolutionFilter(
                    "resolved"
                  )
                }
              >
                Resolved
              </FilterButton>

              <FilterButton
                active={
                  resolutionFilter ===
                  "all"
                }
                onClick={() =>
                  setResolutionFilter(
                    "all"
                  )
                }
              >
                All
              </FilterButton>
            </div>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Owner
            </p>

            <div className="flex flex-wrap items-center gap-3">
              <FilterButton
                active={ownerFilter === "all"}
                onClick={() =>
                  setOwnerFilter("all")
                }
              >
                All Owners
              </FilterButton>

              <FilterButton
                active={ownerFilter === "mine"}
                onClick={() =>
                  setOwnerFilter("mine")
                }
              >
                My Plans
              </FilterButton>

              <select
                value={
                  ownerFilter === "all" ||
                  ownerFilter === "mine"
                    ? ""
                    : ownerFilter
                }
                onChange={(event) =>
                  setOwnerFilter(
                    event.target.value || "all"
                  )
                }
                className="rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 text-sm text-slate-300 outline-none transition focus:border-cyan-400"
              >
                <option value="">
                  Select Owner
                </option>

                {planOwnerOptions.map((owner) => (
                  <option
                    key={owner.user_id}
                    value={owner.user_id}
                  >
                    {owner.first_name}{" "}
                    {owner.last_name}
                    {" · "}
                    {owner.role === "CLIENT_ADMIN"
                      ? "Client Admin"
                      : owner.role ===
                          "INTEGRATEU_ADMIN"
                        ? "IntegrateU Admin"
                        : owner.role}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Priority
            </p>

            <div className="flex flex-wrap gap-2">
              {[
                "all",
                "critical",
                "high",
                "medium",
                "low",
              ].map((priority) => (
                <FilterButton
                  key={priority}
                  active={
                    priorityFilter ===
                    priority
                  }
                  onClick={() =>
                    setPriorityFilter(
                      priority as PriorityFilter
                    )
                  }
                >
                  {priority === "all"
                    ? "All Priorities"
                    : priority
                        .charAt(0)
                        .toUpperCase() +
                      priority.slice(1)}
                </FilterButton>
              ))}
            </div>
          </div>
        </section>

        <section className="mt-8">
          {filteredPlans.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-center text-slate-400">
              No development plans match
              the current filters.
            </div>
          ) : (
            <div className="grid gap-5">
              {filteredPlans.map(
                (plan) => (
                  <article
                    key={
                      plan.development_plan_id
                    }
                    className="rounded-2xl border border-slate-800 bg-slate-900 p-6"
                  >
                    <div className="flex flex-col gap-6 xl:flex-row xl:items-start xl:justify-between">
                      <div className="min-w-0">
                        <div className="flex flex-wrap gap-2">
                          <span
                            className={`rounded-full px-3 py-1 text-xs font-medium ${resolutionClass(
                              plan.resolution_status
                            )}`}
                          >
                            {
                              plan.resolution_label
                            }
                          </span>

                          <span
                            className={`rounded-full px-3 py-1 text-xs font-medium ${priorityClass(
                              plan.priority
                            )}`}
                          >
                            {plan.priority
                              .charAt(0)
                              .toUpperCase() +
                              plan.priority.slice(
                                1
                              )}{" "}
                            Priority
                          </span>

                          {plan.overdue &&
                            plan.resolution_status !==
                              "resolved" && (
                              <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                                Overdue
                              </span>
                            )}

                          {Number(
                            plan.activities_blocked
                          ) > 0 &&
                            isOpenPlan(plan) && (
                              <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                                Blocked
                              </span>
                            )}

                          {isDueSoon(plan) && (
                            <span className="rounded-full bg-amber-500/15 px-3 py-1 text-xs font-medium text-amber-300">
                              Due Soon
                            </span>
                          )}
                        </div>

                        <h2 className="mt-4 text-xl font-semibold">
                          {plan.title}
                        </h2>

                        <p className="mt-2 text-sm text-slate-300">
                          {plan.first_name}{" "}
                          {plan.last_name}
                          {plan.employee_number
                            ? ` · ${plan.employee_number}`
                            : ""}
                        </p>

                        <p className="mt-1 text-sm text-slate-400">
                          Owner:{" "}
                          {(() => {
                            if (!plan.owner_user_id) {
                              return "Unassigned";
                            }

                            const owner =
                              planOwnerOptions.find(
                                (option) =>
                                  option.user_id ===
                                  plan.owner_user_id
                              );

                            if (!owner) {
                              return "Assigned";
                            }

                            return `${owner.first_name} ${owner.last_name}`;
                          })()}
                        </p>

                        {plan.role_name_snapshot && (
                          <p className="mt-1 text-sm text-slate-400">
                            Role:{" "}
                            {
                              plan.role_name_snapshot
                            }
                          </p>
                        )}

                        {plan.competency_name_snapshot && (
                          <p className="mt-1 text-sm text-slate-400">
                            Competency:{" "}
                            {
                              plan.competency_name_snapshot
                            }
                          </p>
                        )}

                        {plan.action_label && (
                          <p className="mt-2 text-xs text-slate-500">
                            Created from:{" "}
                            {plan.action_label}
                          </p>
                        )}
                      </div>

                      <div className="w-full xl:max-w-sm">
                        <div className="rounded-xl bg-slate-950/60 p-5">
                          <div className="flex items-end justify-between gap-4">
                            <div>
                              <p className="text-sm text-slate-400">
                                Progress
                              </p>

                              <p className="mt-1 text-3xl font-bold">
                                {
                                  displayedProgress(
                                    plan
                                  )
                                }
                                %
                              </p>
                            </div>

                            <div className="text-right">
                              <p className="text-xs text-slate-500">
                                Due
                              </p>

                              <p
                                className={`mt-1 text-sm ${
                                  plan.overdue &&
                                  plan.resolution_status !==
                                    "resolved"
                                    ? "font-medium text-rose-300"
                                    : "text-slate-300"
                                }`}
                              >
                                {formatDate(
                                  plan.due_date
                                )}
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
                                    displayedProgress(
                                      plan
                                    )
                                  )
                                )}%`,
                              }}
                            />
                          </div>

                          <p className="mt-3 text-xs text-slate-500">
                            {plan.resolution_status ===
                              "resolved" &&
                            plan.activities_total ===
                              0
                              ? "Resolved by verification"
                              : `${plan.activities_completed}/${plan.activities_total} activities complete`}
                          </p>
                        </div>
                      </div>
                    </div>

                    <div className="mt-5 flex flex-wrap items-center justify-between gap-3 border-t border-slate-800 pt-5">
                      <Link
                        href={`/employees/${plan.employee_id}`}
                        className="text-sm font-medium text-slate-400 transition hover:text-white"
                      >
                        Employee Profile
                      </Link>

                      <Link
                        href={`/development-plans/${plan.development_plan_id}`}
                        className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20"
                      >
                        Open Development Plan
                      </Link>
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

function MetricCard({
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

function FilterButton({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`rounded-lg px-4 py-2 text-sm transition ${
        active
          ? "bg-cyan-400 font-semibold text-slate-950"
          : "border border-slate-300 text-slate-700 hover:bg-slate-100 hover:text-slate-900"
      }`}
    >
      {children}
    </button>
  );
}
