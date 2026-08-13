"use client";

import {
  useCallback,
  useEffect,
  useMemo,
  useState,
} from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import SystemHeader from "@/components/SystemHeader";
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

type StatusFilter =
  | "all"
  | "ready"
  | "action_needed"
  | "not_assessed";

export default function WorkforceReadinessPage() {
  const router = useRouter();

  const [rows, setRows] =
    useState<WorkforceRow[]>([]);

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

  const loadPage =
    useCallback(async () => {
      setLoading(true);
      setMessage(
        "Loading workforce readiness..."
      );

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

      const {
        data,
        error,
      } = await supabase.rpc(
        "wri_list_workforce_readiness"
      );

      if (error) {
        setMessage(error.message);
        setLoading(false);
        return;
      }

      setRows(
        (data ?? []) as WorkforceRow[]
      );

      setMessage("");
      setLoading(false);
    }, [router]);

  useEffect(() => {
    loadPage();
  }, [loadPage]);

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

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-[1500px]">
        <SystemHeader
          title="Workforce Readiness"
          subtitle="Company-wide visibility into current role readiness, competency gaps, and active development work."
          backHref="/dashboard"
          backLabel="Dashboard"
          showHome={true}
          showSignOut={true}
        />

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
                  <table className="w-full min-w-[1180px]">
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
                              className="border-b border-slate-800/70 transition hover:bg-slate-950/50"
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
                            </tr>
                          );
                        }
                      )}
                    </tbody>
                  </table>
                </div>
              )}
            </section>

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
                onClick={loadPage}
                className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
              >
                Refresh Matrix
              </button>
            </div>
          </>
        )}
      </div>
    </main>
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
