"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type ReadinessAction = {
  action_key: string;
  client_id: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  attempt_id: string;
  assessment_id: string;
  assessment_name: string;
  master_role_template_id: string;
  role_name: string;
  master_competency_template_id: string | null;
  competency_name: string | null;
  competency_category: string | null;
  competency_is_critical: boolean;
  action_type: string;
  action_label: string;
  priority: number;
  priority_label: string;
  action_detail: string;
  due_at: string | null;
  days_until_due: number | null;
  readiness_percent: number | null;
  critical_safety_score_percent: number | null;
  knowledge_score_percent: number | null;
  knowledge_level: number | null;
  required_level: number | null;
  practical_rating_level: number | null;
  practical_verification_status: string | null;
  practical_verified_at: string | null;
  reverification_period_months: number | null;
  verification_currency_status: string | null;
};

type PriorityFilter = "all" | "critical" | "high" | "medium";
type ActionFilter = "all" | "safety" | "practical" | "reverification" | "knowledge";

export default function ReadinessActionsPage() {
  const router = useRouter();

  const [actions, setActions] = useState<ReadinessAction[]>([]);
  const [message, setMessage] = useState("Loading readiness actions...");

  const [creatingPlanKey, setCreatingPlanKey] =
    useState<string | null>(null);

  const [existingPlanByAction, setExistingPlanByAction] =
    useState<Record<string, string>>({});
  const [priorityFilter, setPriorityFilter] = useState<PriorityFilter>("all");
  const [actionFilter, setActionFilter] = useState<ActionFilter>("all");
  const [search, setSearch] = useState("");

  useEffect(() => {
    async function loadActions() {
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

      const { data, error } = await supabase.rpc(
        "wri_list_readiness_actions",
        {
          p_client_id: null,
          p_employee_id: null,
          p_action_type: null,
          p_priority: null,
        }
      );

      if (error) {
        setMessage(error.message);
        return;
      }

  const readinessActions =
    (data ?? []) as ReadinessAction[];

  setActions(readinessActions);

  const actionKeys =
    readinessActions
      .map((item) => item.action_key)
      .filter(Boolean);

  if (actionKeys.length > 0) {
    const {
      data: planData,
      error: planError,
    } = await supabase
      .from("development_plans")
      .select("id, action_key, status")
      .in("action_key", actionKeys)
      .not(
        "status",
        "in",
        '("completed","cancelled")'
      );

    if (planError) {
      console.error(
        "Existing development plans failed:",
        planError
      );
    } else {
      const planMap:
        Record<string, string> = {};

      (
        (planData ?? []) as {
          id: string;
          action_key: string | null;
          status: string;
        }[]
      ).forEach((plan) => {
        if (
          plan.action_key &&
          !planMap[plan.action_key]
        ) {
          planMap[plan.action_key] =
            plan.id;
        }
      });

      setExistingPlanByAction(
        planMap
      );
    }
  } else {
    setExistingPlanByAction({});
  }
      setMessage("");
    }

    loadActions();
  }, [router]);

  async function logout() {
    await supabase.auth.signOut();
    router.push("/");
  }

  const criticalCount = useMemo(
    () => actions.filter((item) => item.priority === 1).length,
    [actions]
  );

  const highCount = useMemo(
    () => actions.filter((item) => item.priority === 2).length,
    [actions]
  );

  const mediumCount = useMemo(
    () => actions.filter((item) => item.priority === 3).length,
    [actions]
  );

  const employeeCount = useMemo(
    () => new Set(actions.map((item) => item.employee_id)).size,
    [actions]
  );

  const filteredActions = useMemo(() => {
    const normalizedSearch = search.trim().toLowerCase();

    return actions.filter((item) => {
      const priorityMatch =
        priorityFilter === "all" || item.priority_label === priorityFilter;

      let actionMatch = true;

      if (actionFilter === "safety") {
        actionMatch = item.action_type === "SAFETY_GAP";
      }

      if (actionFilter === "practical") {
        actionMatch =
          item.action_type === "PRACTICAL_VERIFICATION_NEEDED" ||
          item.action_type === "PRACTICAL_DEVELOPMENT_NEEDED";
      }

      if (actionFilter === "reverification") {
        actionMatch =
          item.action_type === "REVERIFICATION_DUE_SOON" ||
          item.action_type === "REVERIFICATION_REQUIRED";
      }

      if (actionFilter === "knowledge") {
        actionMatch =
          item.action_type === "CRITICAL_KNOWLEDGE_GAP" ||
          item.action_type === "KNOWLEDGE_DEVELOPMENT";
      }

      const searchMatch =
        normalizedSearch.length === 0 ||
        [
          item.first_name,
          item.last_name,
          item.employee_number ?? "",
          item.role_name,
          item.competency_name ?? "",
          item.action_label,
        ]
          .join(" ")
          .toLowerCase()
          .includes(normalizedSearch);

      return priorityMatch && actionMatch && searchMatch;
    });
  }, [actions, priorityFilter, actionFilter, search]);

  function priorityClasses(priority: number) {
    switch (priority) {
      case 1:
        return "border-rose-500/30 bg-rose-500/10 text-rose-200";
      case 2:
        return "border-amber-500/30 bg-amber-500/10 text-amber-200";
      case 3:
        return "border-cyan-500/30 bg-cyan-500/10 text-cyan-200";
      default:
        return "border-slate-700 bg-slate-900 text-slate-300";
    }
  }

  function priorityLabel(priority: number) {
    switch (priority) {
      case 1:
        return "Critical";
      case 2:
        return "High";
      case 3:
        return "Medium";
      default:
        return "Normal";
    }
  }

  function actionTypeClasses(actionType: string) {
    switch (actionType) {
      case "SAFETY_GAP":
      case "CRITICAL_KNOWLEDGE_GAP":
      case "REVERIFICATION_REQUIRED":
        return "bg-rose-500/15 text-rose-300";

      case "PRACTICAL_VERIFICATION_NEEDED":
      case "PRACTICAL_DEVELOPMENT_NEEDED":
      case "REVERIFICATION_DUE_SOON":
        return "bg-amber-500/15 text-amber-300";

      case "KNOWLEDGE_DEVELOPMENT":
        return "bg-cyan-500/15 text-cyan-300";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function formatDate(value: string | null) {
    if (!value) return "—";
    return new Date(value).toLocaleDateString();
  }

  function actionHref(item: ReadinessAction) {
    if (
      item.action_type === "PRACTICAL_VERIFICATION_NEEDED" ||
      item.action_type === "PRACTICAL_DEVELOPMENT_NEEDED" ||
      item.action_type === "REVERIFICATION_DUE_SOON" ||
      item.action_type === "REVERIFICATION_REQUIRED"
    ) {
      return `/employees/${item.employee_id}/practical-verification`;
    }

    return `/employees/${item.employee_id}`;
  }

  async function createDevelopmentPlan(
    item: ReadinessAction
  ) {
    setCreatingPlanKey(item.action_key);
    setMessage("");

    let developmentType = "other";

    if (
      item.action_type === "PRACTICAL_VERIFICATION_NEEDED" ||
      item.action_type === "PRACTICAL_DEVELOPMENT_NEEDED"
    ) {
      developmentType = "field_practice";
    } else if (
      item.action_type === "REVERIFICATION_DUE_SOON" ||
      item.action_type === "REVERIFICATION_REQUIRED"
    ) {
      developmentType = "practical_verification";
    } else if (
      item.action_type === "SAFETY_GAP" ||
      item.action_type === "CRITICAL_KNOWLEDGE_GAP" ||
      item.action_type === "KNOWLEDGE_DEVELOPMENT"
    ) {
      developmentType = "training";
    }

    const { data, error } = await supabase.rpc(
      "wri_create_development_plan_from_action",
      {
        p_action_key: item.action_key,
        p_title: null,
        p_description: null,
        p_development_type: developmentType,
        p_priority: null,
        p_due_date: null,
      }
    );

    if (error) {
      setMessage(error.message);
      setCreatingPlanKey(null);
      return;
    }

    if (!data) {
      setMessage("Development plan was not created.");
      setCreatingPlanKey(null);
      return;
    }

    setExistingPlanByAction(
      (current) => ({
        ...current,
        [item.action_key]: data as string,
      })
    );

    router.push(`/development-plans/${data}`);
  }

  function actionButtonLabel(item: ReadinessAction) {
    if (item.action_type === "REVERIFICATION_REQUIRED") {
      return "Complete Reverification";
    }

    if (item.action_type === "REVERIFICATION_DUE_SOON") {
      return "Schedule Reverification";
    }

    if (
      item.action_type === "PRACTICAL_VERIFICATION_NEEDED" ||
      item.action_type === "PRACTICAL_DEVELOPMENT_NEEDED"
    ) {
      return "Open Verification";
    }

    return "View Employee";
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <div className="mb-10 flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-400">IntegrateU</p>
            <h1 className="mt-2 text-3xl font-semibold">
              Readiness Action Center
            </h1>
            <p className="mt-2 max-w-2xl text-slate-400">
              Prioritized workforce readiness issues that need management,
              development, verification, or reverification action.
            </p>
          </div>

          <div className="flex flex-wrap gap-3">
            <Link
              href="/dashboard"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
            >
              ← Dashboard
            </Link>

            <Link
              href="/verify"
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-800"
            >
              Verify Employees
            </Link>

            <button
              onClick={logout}
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800"
            >
              Sign Out
            </button>
          </div>
        </div>

        {message && (
          <div className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
          <MetricCard label="Open Actions" value={actions.length} />
          <MetricCard label="Employees" value={employeeCount} />
          <MetricCard
            label="Critical"
            value={criticalCount}
            valueClass="text-rose-300"
          />
          <MetricCard
            label="High"
            value={highCount}
            valueClass="text-amber-300"
          />
          <MetricCard
            label="Medium"
            value={mediumCount}
            valueClass="text-cyan-300"
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
                onChange={(event) => setSearch(event.target.value)}
                placeholder="Employee, role, competency, or action..."
                className="mt-2 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none transition placeholder:text-slate-600 focus:border-cyan-400"
              />
            </div>

            <p className="text-sm text-slate-400">
              Showing{" "}
              <span className="font-semibold text-white">
                {filteredActions.length}
              </span>{" "}
              actions
            </p>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Priority
            </p>

            <div className="flex flex-wrap gap-2">
              <FilterButton
                active={priorityFilter === "all"}
                onClick={() => setPriorityFilter("all")}
              >
                All
              </FilterButton>

              <FilterButton
                active={priorityFilter === "critical"}
                onClick={() => setPriorityFilter("critical")}
              >
                Critical
              </FilterButton>

              <FilterButton
                active={priorityFilter === "high"}
                onClick={() => setPriorityFilter("high")}
              >
                High
              </FilterButton>

              <FilterButton
                active={priorityFilter === "medium"}
                onClick={() => setPriorityFilter("medium")}
              >
                Medium
              </FilterButton>
            </div>
          </div>

          <div className="mt-5">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-slate-500">
              Action Type
            </p>

            <div className="flex flex-wrap gap-2">
              <FilterButton
                active={actionFilter === "all"}
                onClick={() => setActionFilter("all")}
              >
                All
              </FilterButton>

              <FilterButton
                active={actionFilter === "safety"}
                onClick={() => setActionFilter("safety")}
              >
                Safety
              </FilterButton>

              <FilterButton
                active={actionFilter === "practical"}
                onClick={() => setActionFilter("practical")}
              >
                Practical
              </FilterButton>

              <FilterButton
                active={actionFilter === "reverification"}
                onClick={() => setActionFilter("reverification")}
              >
                Reverification
              </FilterButton>

              <FilterButton
                active={actionFilter === "knowledge"}
                onClick={() => setActionFilter("knowledge")}
              >
                Knowledge
              </FilterButton>
            </div>
          </div>
        </section>

        <section className="mt-8">
          {filteredActions.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-10 text-center">
              <p className="text-lg font-medium">
                No readiness actions match these filters.
              </p>
              <p className="mt-2 text-sm text-slate-400">
                Adjust the filters or search term to see additional actions.
              </p>
            </div>
          ) : (
            <div className="space-y-4">
              {filteredActions.map((item) => (
                <article
                  key={item.action_key}
                  className="rounded-2xl border border-slate-800 bg-slate-900 p-5 sm:p-6"
                >
                  <div className="flex flex-col gap-6 xl:flex-row xl:items-start xl:justify-between">
                    <div className="min-w-0 flex-1">
                      <div className="flex flex-wrap items-center gap-2">
                        <span
                          className={`rounded-full border px-3 py-1 text-xs font-semibold ${priorityClasses(
                            item.priority
                          )}`}
                        >
                          {priorityLabel(item.priority)}
                        </span>

                        <span
                          className={`rounded-full px-3 py-1 text-xs font-medium ${actionTypeClasses(
                            item.action_type
                          )}`}
                        >
                          {item.action_label}
                        </span>

                        {item.competency_is_critical && (
                          <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                            Critical Competency
                          </span>
                        )}
                      </div>

                      <div className="mt-4">
                        <Link
                          href={`/employees/${item.employee_id}`}
                          className="text-xl font-semibold transition hover:text-cyan-300"
                        >
                          {item.first_name} {item.last_name}
                        </Link>

                        <p className="mt-1 text-sm text-slate-400">
                          {item.role_name}
                          {item.employee_number
                            ? ` · ${item.employee_number}`
                            : ""}
                        </p>
                      </div>

                      {item.competency_name && (
                        <div className="mt-4">
                          <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                            Competency
                          </p>
                          <p className="mt-1 font-medium text-slate-200">
                            {item.competency_name}
                          </p>
                        </div>
                      )}

                      <p className="mt-4 max-w-3xl text-sm leading-6 text-slate-300">
                        {item.action_detail}
                      </p>

                      {item.due_at && (
                        <div className="mt-4 flex flex-wrap gap-4 text-sm">
                          <div>
                            <span className="text-slate-500">Due:</span>{" "}
                            <span className="font-medium text-slate-200">
                              {formatDate(item.due_at)}
                            </span>
                          </div>

                          {item.days_until_due !== null && (
                            <div>
                              <span className="text-slate-500">Days:</span>{" "}
                              <span
                                className={
                                  item.days_until_due < 0
                                    ? "font-medium text-rose-300"
                                    : item.days_until_due <= 30
                                    ? "font-medium text-amber-300"
                                    : "font-medium text-slate-200"
                                }
                              >
                                {item.days_until_due}
                              </span>
                            </div>
                          )}
                        </div>
                      )}
                    </div>

                    <div className="grid gap-3 sm:grid-cols-2 xl:w-[360px]">
                      {item.critical_safety_score_percent !== null && (
                        <SmallMetric
                          label="Safety Score"
                          value={`${item.critical_safety_score_percent}%`}
                          valueClass={
                            item.critical_safety_score_percent < 80
                              ? "text-rose-300"
                              : ""
                          }
                        />
                      )}

                      {item.knowledge_score_percent !== null && (
                        <SmallMetric
                          label="Knowledge"
                          value={`${item.knowledge_score_percent}%`}
                        />
                      )}

                      {item.knowledge_level !== null && (
                        <SmallMetric
                          label="Knowledge Level"
                          value={`Level ${item.knowledge_level}`}
                        />
                      )}

                      {item.required_level !== null && (
                        <SmallMetric
                          label="Required"
                          value={`Level ${item.required_level}`}
                        />
                      )}

                      {item.practical_rating_level !== null && (
                        <SmallMetric
                          label="Practical"
                          value={`Level ${item.practical_rating_level}`}
                        />
                      )}

                      {item.reverification_period_months !== null && (
                        <SmallMetric
                          label="Reverify"
                          value={`${item.reverification_period_months} months`}
                        />
                      )}
                    </div>
                  </div>

                  <div className="mt-6 flex flex-wrap items-center justify-between gap-3 border-t border-slate-800 pt-5">
                    <Link
                      href={`/employees/${item.employee_id}`}
                      className="text-sm font-medium text-slate-400 transition hover:text-white"
                    >
                      View Employee Profile
                    </Link>

                    {existingPlanByAction[item.action_key] ? (
                      <Link
                        href={`/development-plans/${existingPlanByAction[item.action_key]}`}
                        className="rounded-lg border border-emerald-500/50 bg-emerald-500/10 px-4 py-2 text-sm font-medium text-emerald-300 transition hover:bg-emerald-500/20"
                      >
                        Open Development Plan
                      </Link>
                    ) : (
                      <button
                        type="button"
                        onClick={() =>
                          createDevelopmentPlan(item)
                        }
                        disabled={
                          creatingPlanKey ===
                          item.action_key
                        }
                        className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20 disabled:opacity-50"
                      >
                        {creatingPlanKey ===
                        item.action_key
                          ? "Creating..."
                          : "Create Development Plan"}
                      </button>
                    )}

                    <Link
                      href={actionHref(item)}
                      className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                    >
                      {actionButtonLabel(item)}
                    </Link>
                  </div>
                </article>
              ))}
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
      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
        {label}
      </p>
      <p className={`mt-2 text-3xl font-semibold ${valueClass}`}>{value}</p>
    </div>
  );
}

function SmallMetric({
  label,
  value,
  valueClass = "",
}: {
  label: string;
  value: string;
  valueClass?: string;
}) {
  return (
    <div className="rounded-xl bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">{label}</p>
      <p className={`mt-1 font-semibold ${valueClass}`}>{value}</p>
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
          : "border border-slate-700 text-slate-300 hover:bg-slate-800"
      }`}
    >
      {children}
    </button>
  );
}
