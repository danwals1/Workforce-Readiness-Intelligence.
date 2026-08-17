"use client";

import {
  useCallback,
  useEffect,
  useMemo,
  useState,
} from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type WorkforceRow = {
  employee_id: string;
  client_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;

  assessment_id: string | null;
  assessment_name: string | null;
  master_role_template_id: string | null;
  role_name: string | null;

  average_knowledge_score: number | null;
  critical_safety_score_percent: number | null;

  competencies_ready: number | null;
  competencies_total: number | null;
  readiness_percent: number | null;

  developing_count: number | null;
  critical_gap_count: number | null;
  practical_gap_count: number | null;

  reverification_due_count: number | null;
  reverification_required_count: number | null;

  readiness_status: string | null;

  knowledge_ready_count: number;
  knowledge_total_count: number;

  practical_ready_count: number;
  practical_total_count: number;

  current_gap_count: number;

  open_plan_count: number;
  awaiting_evidence_count: number;
};

type RoleOption = {
  master_role_template_id: string;
  role_name: string;
  department: string | null;
  competency_count: number;
};

type RoleComparisonRow = {
  employee_id: string;
  employee_first_name: string;
  employee_last_name: string;

  current_role_template_id: string | null;
  current_role_name: string | null;
  current_readiness_percent: number | null;

  target_role_template_id: string;
  target_role_name: string;
  target_role_department: string | null;

  master_competency_template_id: string;
  competency_name: string;
  competency_category: string | null;
  competency_is_critical: boolean;

  current_knowledge_level: number | null;
  current_practical_level: number | null;
  practical_verification_required: boolean;

  target_required_level: number;

  knowledge_target_ready: boolean;
  practical_target_ready: boolean;
  target_competency_ready: boolean;

  reverification_due: boolean;
  verification_expired: boolean;

  target_status: string;

  target_competencies_ready: number;
  target_competencies_total: number;
  target_readiness_percent: number;

  knowledge_gap_count: number;
  practical_gap_count: number;
  not_assessed_count: number;
  reverification_due_count: number;
  reverification_required_count: number;
};

type StatusFilter =
  | "all"
  | "ready"
  | "action_needed"
  | "not_assessed";

export default function WorkforceReadinessPage() {
  const router = useRouter();

  const [rows, setRows] =
    useState<WorkforceRow[]>([]);

  const [roleOptions, setRoleOptions] =
    useState<RoleOption[]>([]);

  const [roleOptionsError, setRoleOptionsError] =
    useState("");

  const [loading, setLoading] =
    useState(true);

  const [message, setMessage] =
    useState(
      "Loading workforce readiness..."
    );

  const [search, setSearch] =
    useState("");

  const [statusFilter, setStatusFilter] =
    useState<StatusFilter>("all");

  const [
    comparisonEmployee,
    setComparisonEmployee,
  ] = useState<WorkforceRow | null>(
    null
  );

  const [
    selectedRoleId,
    setSelectedRoleId,
  ] = useState("");

  const [
    comparisonRows,
    setComparisonRows,
  ] = useState<RoleComparisonRow[]>([]);

  const [
    comparisonLoading,
    setComparisonLoading,
  ] = useState(false);

  const [
    comparisonMessage,
    setComparisonMessage,
  ] = useState("");

  const [
    creatingRolePlan,
    setCreatingRolePlan,
  ] = useState(false);

  const loadPage =
    useCallback(async () => {
      const {
        data: sessionData,
        error: sessionError,
      } =
        await supabase.auth.getSession();

      if (sessionError) {
        setMessage(
          sessionError.message
        );
        setLoading(false);
        return;
      }

      if (!sessionData.session) {
        router.push("/");
        return;
      }

      const [
        workforceResult,
        roleOptionsResult,
      ] = await Promise.all([
        supabase.rpc(
          "wri_list_workforce_readiness"
        ),
        supabase.rpc(
          "wri_list_role_comparison_options"
        ),
      ]);

      if (workforceResult.error) {
        setMessage(
          workforceResult.error.message
        );
        setLoading(false);
        return;
      }

      setRows(
        (workforceResult.data ??
          []) as WorkforceRow[]
      );

      if (roleOptionsResult.error) {
        console.error(
          "Role comparison options failed:",
          roleOptionsResult.error
        );

        setRoleOptions([]);
        setRoleOptionsError(
          roleOptionsResult.error.message
        );
      } else {
        setRoleOptions(
          (roleOptionsResult.data ??
            []) as RoleOption[]
        );
        setRoleOptionsError("");
      }

      setMessage("");
      setLoading(false);
    }, [router]);

  useEffect(() => {
    queueMicrotask(() => {
      void loadPage();
    });
  }, [loadPage]);

  async function handleRefresh() {
    setLoading(true);
    setMessage(
      "Loading workforce readiness..."
    );

    await loadPage();
  }

  const filteredRows =
    useMemo(() => {
      const normalizedSearch =
        search
          .trim()
          .toLowerCase();

      return rows.filter(
        (row) => {
          const fullName =
            `${row.first_name} ${row.last_name}`.toLowerCase();

          const matchesSearch =
            !normalizedSearch ||
            fullName.includes(
              normalizedSearch
            ) ||
            row.employee_number
              ?.toLowerCase()
              .includes(
                normalizedSearch
              ) ||
            row.role_name
              ?.toLowerCase()
              .includes(
                normalizedSearch
              );

          if (!matchesSearch) {
            return false;
          }

          if (
            statusFilter ===
            "not_assessed"
          ) {
            return (
              row.assessment_id === null
            );
          }

          if (
            statusFilter ===
            "ready"
          ) {
            return (
              row.readiness_status ===
              "ready"
            );
          }

          if (
            statusFilter ===
            "action_needed"
          ) {
            return (
              row.assessment_id !== null &&
              row.readiness_status !==
                "ready"
            );
          }

          return true;
        }
      );
    }, [
      rows,
      search,
      statusFilter,
    ]);

  const assessedRows =
    useMemo(
      () =>
        rows.filter(
          (row) =>
            row.assessment_id !== null
        ),
      [rows]
    );

  const readyCount =
    useMemo(
      () =>
        assessedRows.filter(
          (row) =>
            row.readiness_status ===
            "ready"
        ).length,
      [assessedRows]
    );

  const averageReadiness =
    useMemo(() => {
      if (
        assessedRows.length === 0
      ) {
        return null;
      }

      return Math.round(
        assessedRows.reduce(
          (sum, row) =>
            sum +
            Number(
              row.readiness_percent ??
                0
            ),
          0
        ) / assessedRows.length
      );
    }, [assessedRows]);

  const totalCurrentGaps =
    useMemo(
      () =>
        rows.reduce(
          (sum, row) =>
            sum +
            Number(
              row.current_gap_count ??
                0
            ),
          0
        ),
      [rows]
    );

  const totalOpenPlans =
    useMemo(
      () =>
        rows.reduce(
          (sum, row) =>
            sum +
            Number(
              row.open_plan_count ??
                0
            ),
          0
        ),
      [rows]
    );

  const awaitingEvidence =
    useMemo(
      () =>
        rows.reduce(
          (sum, row) =>
            sum +
            Number(
              row.awaiting_evidence_count ??
                0
            ),
          0
        ),
      [rows]
    );

  const availableRoleOptions =
    useMemo(() => {
      if (!comparisonEmployee) {
        return roleOptions;
      }

      return roleOptions.filter(
        (role) =>
          role.master_role_template_id !==
          comparisonEmployee.master_role_template_id
      );
    }, [
      roleOptions,
      comparisonEmployee,
    ]);

  const comparisonSummary =
    comparisonRows.length > 0
      ? comparisonRows[0]
      : null;

  const knowledgeDemonstratedCount =
    useMemo(
      () =>
        comparisonRows.filter(
          (row) =>
            row.knowledge_target_ready
        ).length,
      [comparisonRows]
    );

  function openComparison(
    row: WorkforceRow
  ) {
    setComparisonEmployee(row);
    setSelectedRoleId("");
    setComparisonRows([]);
    setComparisonMessage("");
    setCreatingRolePlan(false);

    window.setTimeout(() => {
      document
        .getElementById(
          "role-comparison"
        )
        ?.scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
    }, 0);
  }

  function closeComparison() {
    setComparisonEmployee(null);
    setSelectedRoleId("");
    setComparisonRows([]);
    setComparisonMessage("");
    setCreatingRolePlan(false);
  }

  async function createRoleDevelopmentPlan() {
    if (
      !comparisonEmployee ||
      !selectedRoleId ||
      !comparisonSummary
    ) {
      return;
    }

    setCreatingRolePlan(true);
    setComparisonMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_create_role_comparison_development_plan",
      {
        p_employee_id:
          comparisonEmployee.employee_id,
        p_target_role_template_id:
          selectedRoleId,
        p_due_date: null,
      }
    );

    if (error) {
      setComparisonMessage(
        error.message
      );
      setCreatingRolePlan(false);
      return;
    }

    if (!data) {
      setComparisonMessage(
        "Role Development Plan could not be created."
      );
      setCreatingRolePlan(false);
      return;
    }

    router.push(
      `/development-plans/${data}`
    );
  }

  async function loadRoleComparison(
    roleId: string
  ) {
    setSelectedRoleId(roleId);
    setComparisonRows([]);
    setComparisonMessage("");
    setCreatingRolePlan(false);

    if (
      !comparisonEmployee ||
      !roleId
    ) {
      return;
    }

    setComparisonLoading(true);

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_compare_employee_role_readiness",
      {
        p_employee_id:
          comparisonEmployee.employee_id,
        p_target_role_template_id:
          roleId,
      }
    );

    if (error) {
      setComparisonMessage(
        error.message
      );
      setComparisonLoading(false);
      return;
    }

    const result =
      (data ??
        []) as RoleComparisonRow[];

    setComparisonRows(result);

    if (result.length === 0) {
      setComparisonMessage(
        "No role requirements were available for this comparison."
      );
    }

    setComparisonLoading(false);
  }

  return (
    <div className="mx-auto max-w-[1500px]">
      <header className="mb-8">
        <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
          Employees
        </p>

        <h2 className="mt-2 text-3xl font-semibold">
          Workforce Readiness
        </h2>

        <p className="mt-2 max-w-3xl text-sm text-slate-400">
          Company-wide visibility into current role readiness,
          competency gaps, and active development work.
        </p>
      </header>

        {message && (
          <div className="mb-6 rounded-xl border border-slate-800 bg-slate-900 p-5 text-sm text-slate-300">
            {message}
          </div>
        )}

        {!loading && (
          <>
            <section className="mb-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
              <Metric
                label="Employees"
                value={rows.length}
                detail={`${assessedRows.length} assessed`}
              />

              <Metric
                label="Ready"
                value={readyCount}
                detail={
                  assessedRows.length >
                  0
                    ? `${readyCount}/${assessedRows.length} assessed employees`
                    : "No assessments"
                }
                valueClass="text-emerald-300"
              />

              <Metric
                label="Avg. Readiness"
                value={
                  averageReadiness ===
                  null
                    ? "—"
                    : `${averageReadiness}%`
                }
                detail="Current assessed roles"
                valueClass="text-cyan-300"
              />

              <Metric
                label="Current Gaps"
                value={
                  totalCurrentGaps
                }
                detail="Competencies not ready"
                valueClass={
                  totalCurrentGaps > 0
                    ? "text-amber-300"
                    : "text-emerald-300"
                }
              />

              <Metric
                label="Open Plans"
                value={totalOpenPlans}
                detail="Unresolved development"
                valueClass={
                  totalOpenPlans > 0
                    ? "text-cyan-300"
                    : ""
                }
              />

              <Metric
                label="Awaiting Evidence"
                value={
                  awaitingEvidence
                }
                detail="Reassess or verify"
                valueClass={
                  awaitingEvidence > 0
                    ? "text-amber-300"
                    : ""
                }
              />
            </section>

            <section className="rounded-2xl border border-slate-800 bg-slate-900">
              <div className="border-b border-slate-800 p-6">
                <div className="flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
                  <div>
                    <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                      Current Role
                      Readiness
                    </p>

                    <h2 className="mt-2 text-2xl font-semibold">
                      Workforce
                      Readiness Matrix
                    </h2>

                    <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
                      Role readiness
                      reflects current
                      competency evidence.
                      Development Plans
                      are shown separately
                      so historical work
                      does not distort
                      current capability.
                    </p>
                  </div>

                  <div className="flex flex-col gap-3 sm:flex-row">
                    <input
                      value={search}
                      onChange={(
                        event
                      ) =>
                        setSearch(
                          event.target
                            .value
                        )
                      }
                      placeholder="Search employee or role..."
                      className="min-w-[250px] rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none placeholder:text-slate-600 focus:border-cyan-400"
                    />

                    <select
                      value={
                        statusFilter
                      }
                      onChange={(
                        event
                      ) =>
                        setStatusFilter(
                          event.target
                            .value as StatusFilter
                        )
                      }
                      className="rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400"
                    >
                      <option value="all">
                        All Employees
                      </option>

                      <option value="ready">
                        Ready
                      </option>

                      <option value="action_needed">
                        Action Needed
                      </option>

                      <option value="not_assessed">
                        Not Assessed
                      </option>
                    </select>
                  </div>
                </div>
              </div>

              {filteredRows.length ===
              0 ? (
                <div className="p-10 text-center">
                  <p className="font-medium">
                    No employees match
                    this view.
                  </p>

                  <p className="mt-2 text-sm text-slate-400">
                    Adjust the search
                    or status filter.
                  </p>
                </div>
              ) : (
                <div className="overflow-x-auto">
                  <table className="w-full min-w-[1320px]">
                    <thead>
                      <tr className="border-b border-slate-800 text-left text-xs uppercase tracking-wide text-slate-500">
                        <th className="px-6 py-4">
                          Employee
                        </th>

                        <th className="px-5 py-4">
                          Current Role
                        </th>

                        <th className="px-5 py-4">
                          Overall
                        </th>

                        <th className="px-5 py-4">
                          Knowledge
                        </th>

                        <th className="px-5 py-4">
                          Practical
                        </th>

                        <th className="px-5 py-4">
                          Gaps
                        </th>

                        <th className="px-5 py-4">
                          Plans
                        </th>

                        <th className="px-5 py-4">
                          Evidence
                        </th>

                        <th className="px-5 py-4">
                          Status
                        </th>

                        <th className="px-5 py-4">
                          Compare
                        </th>
                      </tr>
                    </thead>

                    <tbody>
                      {filteredRows.map(
                        (row) => {
                          const knowledgePercent =
                            row.knowledge_total_count >
                            0
                              ? Math.round(
                                  (Number(
                                    row.knowledge_ready_count
                                  ) /
                                    Number(
                                      row.knowledge_total_count
                                    )) *
                                    100
                                )
                              : null;

                          const practicalPercent =
                            row.practical_total_count >
                            0
                              ? Math.round(
                                  (Number(
                                    row.practical_ready_count
                                  ) /
                                    Number(
                                      row.practical_total_count
                                    )) *
                                    100
                                )
                              : null;

                          return (
                            <tr
                              key={
                                row.employee_id
                              }
                              className="border-b border-slate-800/70"
                            >
                              <td className="px-6 py-5">
                                <Link
                                  href={`/employees/${row.employee_id}`}
                                  className="font-semibold text-white transition hover:text-cyan-300"
                                >
                                  {
                                    row.first_name
                                  }{" "}
                                  {
                                    row.last_name
                                  }
                                </Link>

                                {row.employee_number && (
                                  <p className="mt-1 text-xs text-slate-500">
                                    {
                                      row.employee_number
                                    }
                                  </p>
                                )}
                              </td>

                              <td className="px-5 py-5 text-sm text-slate-300">
                                {row.role_name ??
                                  "Not Assessed"}
                              </td>

                              <td className="px-5 py-5">
                                {row.readiness_percent !==
                                null ? (
                                  <ReadinessValue
                                    value={Number(
                                      row.readiness_percent
                                    )}
                                  />
                                ) : (
                                  <span className="text-slate-600">
                                    —
                                  </span>
                                )}
                              </td>

                              <td className="px-5 py-5">
                                <RateValue
                                  percent={
                                    knowledgePercent
                                  }
                                  ready={Number(
                                    row.knowledge_ready_count
                                  )}
                                  total={Number(
                                    row.knowledge_total_count
                                  )}
                                />
                              </td>

                              <td className="px-5 py-5">
                                <RateValue
                                  percent={
                                    practicalPercent
                                  }
                                  ready={Number(
                                    row.practical_ready_count
                                  )}
                                  total={Number(
                                    row.practical_total_count
                                  )}
                                />
                              </td>

                              <td className="px-5 py-5">
                                <CountBadge
                                  value={Number(
                                    row.current_gap_count
                                  )}
                                  goodWhenZero
                                />
                              </td>

                              <td className="px-5 py-5">
                                <CountBadge
                                  value={Number(
                                    row.open_plan_count
                                  )}
                                />
                              </td>

                              <td className="px-5 py-5">
                                <CountBadge
                                  value={Number(
                                    row.awaiting_evidence_count
                                  )}
                                  attention
                                />
                              </td>

                              <td className="px-5 py-5">
                                <StatusBadge
                                  row={row}
                                />
                              </td>

                              <td className="px-5 py-5">
                                <button
                                  type="button"
                                  onClick={() =>
                                    openComparison(
                                      row
                                    )
                                  }
                                  className="whitespace-nowrap rounded-lg border border-cyan-500/40 bg-cyan-500/10 px-3 py-2 text-xs font-semibold text-cyan-300 transition hover:bg-cyan-500/20"
                                >
                                  Compare Role
                                </button>
                              </td>
                            </tr>
                          );
                        }
                      )}
                    </tbody>
                  </table>
                </div>
              )}
            </section>

            {comparisonEmployee && (
              <section
                id="role-comparison"
                className="mt-8 scroll-mt-8 rounded-2xl border border-cyan-500/20 bg-slate-900"
              >
                <div className="border-b border-slate-800 p-6 sm:p-8">
                  <div className="flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
                    <div>
                      <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
                        Role Readiness
                        Comparison
                      </p>

                      <h2 className="mt-2 text-2xl font-semibold">
                        {
                          comparisonEmployee.first_name
                        }{" "}
                        {
                          comparisonEmployee.last_name
                        }
                      </h2>

                      <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
                        Compare current
                        employee evidence
                        against another role.
                        This analysis does
                        not change the
                        employee&apos;s
                        assigned or target
                        role.
                      </p>
                    </div>

                    <button
                      type="button"
                      onClick={
                        closeComparison
                      }
                      className="self-start rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 transition hover:bg-slate-800"
                    >
                      Close
                    </button>
                  </div>

                  <div className="mt-6 grid gap-4 lg:grid-cols-2">
                    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                        Current Role
                      </p>

                      <p className="mt-2 text-lg font-semibold">
                        {
                          comparisonEmployee.role_name ??
                          "Not Assessed"
                        }
                      </p>

                      <p className="mt-3 text-3xl font-bold text-emerald-300">
                        {comparisonEmployee.readiness_percent !==
                        null
                          ? `${Math.round(
                              Number(
                                comparisonEmployee.readiness_percent
                              )
                            )}%`
                          : "—"}
                      </p>

                      <p className="mt-1 text-xs text-slate-500">
                        Current assessed
                        role readiness
                      </p>
                    </div>

                    <div className="rounded-xl border border-cyan-500/20 bg-cyan-500/5 p-5">
                      <label
                        htmlFor="compare-role-select"
                        className="text-xs font-medium uppercase tracking-wide text-cyan-400"
                      >
                        Compare Role
                      </label>

                      <select
                        id="compare-role-select"
                        value={
                          selectedRoleId
                        }
                        onChange={(
                          event
                        ) =>
                          loadRoleComparison(
                            event.target
                              .value
                          )
                        }
                        disabled={
                          comparisonLoading
                        }
                        className="mt-3 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-cyan-400 disabled:opacity-60"
                      >
                        <option value="">
                          Select a role...
                        </option>

                        {availableRoleOptions.map(
                          (role) => (
                            <option
                              key={
                                role.master_role_template_id
                              }
                              value={
                                role.master_role_template_id
                              }
                            >
                              {
                                role.role_name
                              }
                              {" · "}
                              {
                                role.competency_count
                              }{" "}
                              competencies
                            </option>
                          )
                        )}
                      </select>

                      {roleOptionsError && (
                        <p className="mt-3 text-xs text-amber-300">
                          Role options
                          could not be
                          loaded:{" "}
                          {
                            roleOptionsError
                          }
                        </p>
                      )}

                      {!roleOptionsError &&
                        availableRoleOptions.length ===
                          0 && (
                          <p className="mt-3 text-xs text-slate-500">
                            No additional
                            roles are
                            available for
                            comparison.
                          </p>
                        )}
                    </div>
                  </div>
                </div>

                <div className="p-6 sm:p-8">
                  {comparisonLoading && (
                    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-6 text-sm text-slate-300">
                      Calculating role
                      readiness...
                    </div>
                  )}

                  {!comparisonLoading &&
                    comparisonMessage && (
                      <div className="rounded-xl border border-amber-500/30 bg-amber-500/10 p-5 text-sm text-amber-200">
                        {
                          comparisonMessage
                        }
                      </div>
                    )}

                  {!comparisonLoading &&
                    comparisonSummary && (
                      <>
                        <div className="flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
                          <div>
                            <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
                              Comparing
                              Against
                            </p>

                            <h3 className="mt-2 text-2xl font-semibold">
                              {
                                comparisonSummary.target_role_name
                              }
                            </h3>

                            {comparisonSummary.target_role_department && (
                              <p className="mt-1 text-sm text-slate-400">
                                {
                                  comparisonSummary.target_role_department
                                }
                              </p>
                            )}
                          </div>

                          <div className="flex flex-col gap-3 lg:items-end">
                            <div className="rounded-xl border border-slate-800 bg-slate-950/60 px-5 py-4 lg:text-right">
                              <p className="text-xs uppercase tracking-wide text-slate-500">
                                Fully Qualified
                              </p>

                              <p className="mt-1 text-2xl font-bold text-white">
                                {
                                  comparisonSummary.target_competencies_ready
                                }
                                /
                                {
                                  comparisonSummary.target_competencies_total
                                }
                              </p>

                              <p className="mt-1 text-sm text-slate-400">
                                {
                                  Number(
                                    comparisonSummary.target_readiness_percent
                                  )
                                }
                                % of target
                                competencies
                                fully ready
                              </p>
                            </div>

                            {Number(
                              comparisonSummary.target_competencies_ready
                            ) <
                              Number(
                                comparisonSummary.target_competencies_total
                              ) && (
                              <button
                                type="button"
                                onClick={
                                  createRoleDevelopmentPlan
                                }
                                disabled={
                                  creatingRolePlan
                                }
                                className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
                              >
                                {creatingRolePlan
                                  ? "Creating Development Plan..."
                                  : "Create Role Development Plan"}
                              </button>
                            )}
                          </div>
                        </div>

                        <div className="mt-6 rounded-xl border border-cyan-500/20 bg-cyan-500/5 p-5">
                          <p className="text-sm leading-6 text-slate-300">
                            <span className="font-semibold text-cyan-300">
                              Target
                              readiness is a
                              strict
                              qualification
                              measure.
                            </span>{" "}
                            A competency
                            counts as fully
                            ready only when
                            all required
                            knowledge and
                            practical
                            evidence meets
                            the selected
                            role&apos;s
                            level. A low
                            fully-qualified
                            percentage does
                            not mean the
                            employee lacks
                            capability;
                            existing
                            knowledge is
                            shown separately
                            below.
                          </p>
                        </div>

                        <div className="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
                          <ComparisonMetric
                            label="Fully Ready"
                            value={`${comparisonSummary.target_competencies_ready}/${comparisonSummary.target_competencies_total}`}
                            detail={`${Number(
                              comparisonSummary.target_readiness_percent
                            )}% fully qualified`}
                            valueClass={
                              Number(
                                comparisonSummary.target_competencies_ready
                              ) ===
                              Number(
                                comparisonSummary.target_competencies_total
                              )
                                ? "text-emerald-300"
                                : "text-white"
                            }
                          />

                          <ComparisonMetric
                            label="Knowledge Demonstrated"
                            value={`${knowledgeDemonstratedCount}/${comparisonSummary.target_competencies_total}`}
                            detail="Meets target knowledge level"
                            valueClass="text-cyan-300"
                          />

                          <ComparisonMetric
                            label="Practical Development"
                            value={
                              comparisonSummary.practical_gap_count
                            }
                            detail="Needs higher practical evidence"
                            valueClass={
                              Number(
                                comparisonSummary.practical_gap_count
                              ) > 0
                                ? "text-amber-300"
                                : "text-emerald-300"
                            }
                          />

                          <ComparisonMetric
                            label="Not Assessed"
                            value={
                              comparisonSummary.not_assessed_count
                            }
                            detail="No knowledge evidence yet"
                            valueClass="text-slate-300"
                          />
                        </div>

                        {(Number(
                          comparisonSummary.knowledge_gap_count
                        ) > 0 ||
                          Number(
                            comparisonSummary.reverification_due_count
                          ) > 0 ||
                          Number(
                            comparisonSummary.reverification_required_count
                          ) > 0) && (
                          <div className="mt-4 flex flex-wrap gap-3">
                            {Number(
                              comparisonSummary.knowledge_gap_count
                            ) > 0 && (
                              <MiniMetric
                                label="Knowledge Gaps"
                                value={
                                  comparisonSummary.knowledge_gap_count
                                }
                                classes="border-rose-500/30 bg-rose-500/10 text-rose-200"
                              />
                            )}

                            {Number(
                              comparisonSummary.reverification_due_count
                            ) > 0 && (
                              <MiniMetric
                                label="Reverification Due"
                                value={
                                  comparisonSummary.reverification_due_count
                                }
                                classes="border-cyan-500/30 bg-cyan-500/10 text-cyan-200"
                              />
                            )}

                            {Number(
                              comparisonSummary.reverification_required_count
                            ) > 0 && (
                              <MiniMetric
                                label="Reverification Required"
                                value={
                                  comparisonSummary.reverification_required_count
                                }
                                classes="border-orange-500/30 bg-orange-500/10 text-orange-200"
                              />
                            )}
                          </div>
                        )}

                        <div className="mt-8 overflow-hidden rounded-xl border border-slate-800">
                          <div className="border-b border-slate-800 bg-slate-950/60 px-5 py-4">
                            <h4 className="font-semibold">
                              Competency
                              Comparison
                            </h4>

                            <p className="mt-1 text-sm text-slate-500">
                              Employee
                              evidence
                              compared with
                              the selected
                              role&apos;s
                              required level.
                            </p>
                          </div>

                          <div className="overflow-x-auto">
                            <table className="w-full min-w-[900px]">
                              <thead>
                                <tr className="border-b border-slate-800 text-left text-xs uppercase tracking-wide text-slate-500">
                                  <th className="px-5 py-4">
                                    Competency
                                  </th>

                                  <th className="px-5 py-4">
                                    Knowledge
                                  </th>

                                  <th className="px-5 py-4">
                                    Practical
                                  </th>

                                  <th className="px-5 py-4">
                                    Target
                                  </th>

                                  <th className="px-5 py-4">
                                    Status
                                  </th>
                                </tr>
                              </thead>

                              <tbody>
                                {comparisonRows.map(
                                  (row) => (
                                    <tr
                                      key={
                                        row.master_competency_template_id
                                      }
                                      className="border-b border-slate-800/70"
                                    >
                                      <td className="px-5 py-4">
                                        <p className="font-medium text-white">
                                          {
                                            row.competency_name
                                          }
                                        </p>

                                        <div className="mt-1 flex flex-wrap gap-2 text-xs text-slate-500">
                                          {row.competency_category && (
                                            <span>
                                              {
                                                row.competency_category
                                              }
                                            </span>
                                          )}

                                          {row.competency_is_critical && (
                                            <span className="text-rose-300">
                                              Critical
                                            </span>
                                          )}
                                        </div>
                                      </td>

                                      <td className="px-5 py-4">
                                        <LevelValue
                                          level={
                                            row.current_knowledge_level
                                          }
                                          ready={
                                            row.knowledge_target_ready
                                          }
                                        />
                                      </td>

                                      <td className="px-5 py-4">
                                        {row.practical_verification_required ? (
                                          <LevelValue
                                            level={
                                              row.current_practical_level
                                            }
                                            ready={
                                              row.practical_target_ready
                                            }
                                          />
                                        ) : (
                                          <span className="text-sm text-slate-500">
                                            Not
                                            required
                                          </span>
                                        )}
                                      </td>

                                      <td className="px-5 py-4">
                                        <span className="font-semibold text-white">
                                          Level{" "}
                                          {
                                            row.target_required_level
                                          }
                                        </span>
                                      </td>

                                      <td className="px-5 py-4">
                                        <ComparisonStatusBadge
                                          status={
                                            row.target_status
                                          }
                                        />
                                      </td>
                                    </tr>
                                  )
                                )}
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </>
                    )}

                  {!comparisonLoading &&
                    !comparisonSummary &&
                    !comparisonMessage && (
                      <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-8 text-center">
                        <p className="font-medium">
                          Select a role
                          above to compare
                          readiness.
                        </p>

                        <p className="mt-2 text-sm text-slate-500">
                          This will use the
                          employee&apos;s
                          reusable
                          knowledge and
                          practical
                          evidence against
                          the selected
                          master role.
                        </p>
                      </div>
                    )}
                </div>
              </section>
            )}

            <div className="mt-6 flex flex-wrap gap-3">
              <Link
                href="/readiness-actions"
                className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
              >
                Readiness Action Center
              </Link>

              <Link
                href="/development-plans"
                className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
              >
                Development Plans
              </Link>

              <button
                type="button"
                onClick={handleRefresh}
                className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
              >
                Refresh Matrix
              </button>
            </div>
          </>
        )}
    </div>
  );
}

function Metric({
  label,
  value,
  detail,
  valueClass = "",
}: {
  label: string;
  value: string | number;
  detail: string;
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

      <p className="mt-2 text-xs text-slate-500">
        {detail}
      </p>
    </div>
  );
}

function ComparisonMetric({
  label,
  value,
  detail,
  valueClass = "",
}: {
  label: string;
  value: string | number;
  detail: string;
  valueClass?: string;
}) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
      <p className="text-sm text-slate-400">
        {label}
      </p>

      <p
        className={`mt-2 text-3xl font-bold ${valueClass}`}
      >
        {value}
      </p>

      <p className="mt-2 text-xs leading-5 text-slate-500">
        {detail}
      </p>
    </div>
  );
}

function MiniMetric({
  label,
  value,
  classes,
}: {
  label: string;
  value: string | number;
  classes: string;
}) {
  return (
    <div
      className={`rounded-lg border px-4 py-2 text-sm ${classes}`}
    >
      <span className="font-semibold">
        {value}
      </span>{" "}
      {label}
    </div>
  );
}

function ReadinessValue({
  value,
}: {
  value: number;
}) {
  const valueClass =
    value >= 100
      ? "text-emerald-300"
      : value >= 80
        ? "text-cyan-300"
        : "text-amber-300";

  return (
    <div>
      <p
        className={`text-lg font-semibold ${valueClass}`}
      >
        {Math.round(value)}%
      </p>

      <div className="mt-2 h-1.5 w-20 overflow-hidden rounded-full bg-slate-800">
        <div
          className="h-full rounded-full bg-cyan-400"
          style={{
            width: `${Math.min(
              100,
              Math.max(
                0,
                value
              )
            )}%`,
          }}
        />
      </div>
    </div>
  );
}

function RateValue({
  percent,
  ready,
  total,
}: {
  percent: number | null;
  ready: number;
  total: number;
}) {
  if (percent === null) {
    return (
      <span className="text-sm text-slate-600">
        —
      </span>
    );
  }

  return (
    <div>
      <p
        className={`font-semibold ${
          percent === 100
            ? "text-emerald-300"
            : "text-amber-300"
        }`}
      >
        {percent}%
      </p>

      <p className="mt-1 text-xs text-slate-500">
        {ready}/{total}
      </p>
    </div>
  );
}

function LevelValue({
  level,
  ready,
}: {
  level: number | null;
  ready: boolean;
}) {
  if (level === null) {
    return (
      <span className="text-sm text-slate-600">
        —
      </span>
    );
  }

  return (
    <span
      className={`font-semibold ${
        ready
          ? "text-emerald-300"
          : "text-amber-300"
      }`}
    >
      Level {level}
    </span>
  );
}

function CountBadge({
  value,
  goodWhenZero = false,
  attention = false,
}: {
  value: number;
  goodWhenZero?: boolean;
  attention?: boolean;
}) {
  let classes =
    "bg-slate-800 text-slate-300";

  if (
    goodWhenZero &&
    value === 0
  ) {
    classes =
      "bg-emerald-500/15 text-emerald-300";
  } else if (
    value > 0 &&
    attention
  ) {
    classes =
      "bg-amber-500/15 text-amber-300";
  } else if (value > 0) {
    classes =
      "bg-cyan-500/15 text-cyan-300";
  }

  return (
    <span
      className={`inline-flex min-w-8 justify-center rounded-full px-3 py-1 text-xs font-semibold ${classes}`}
    >
      {value}
    </span>
  );
}

function StatusBadge({
  row,
}: {
  row: WorkforceRow;
}) {
  if (row.assessment_id === null) {
    return (
      <span className="rounded-full bg-slate-800 px-3 py-1 text-xs font-medium text-slate-400">
        Not Assessed
      </span>
    );
  }

  if (
    row.readiness_status ===
    "ready"
  ) {
    return (
      <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-xs font-medium text-emerald-300">
        Ready
      </span>
    );
  }

  return (
    <span className="rounded-full bg-amber-500/15 px-3 py-1 text-xs font-medium text-amber-300">
      Action Needed
    </span>
  );
}

function ComparisonStatusBadge({
  status,
}: {
  status: string;
}) {
  let label = status;
  let classes =
    "bg-slate-800 text-slate-300";

  switch (status) {
    case "ready":
      label = "Ready";
      classes =
        "bg-emerald-500/15 text-emerald-300";
      break;

    case "knowledge_gap":
      label = "Knowledge Gap";
      classes =
        "bg-rose-500/15 text-rose-300";
      break;

    case "practical_gap":
      label = "Practical Gap";
      classes =
        "bg-amber-500/15 text-amber-300";
      break;

    case "not_assessed":
      label = "Not Assessed";
      classes =
        "bg-slate-800 text-slate-400";
      break;

    case "reverification_due":
      label = "Reverification Due";
      classes =
        "bg-cyan-500/15 text-cyan-300";
      break;

    case "reverification_required":
      label =
        "Reverification Required";
      classes =
        "bg-orange-500/15 text-orange-300";
      break;
  }

  return (
    <span
      className={`inline-flex rounded-full px-3 py-1 text-xs font-medium ${classes}`}
    >
      {label}
    </span>
  );
}
