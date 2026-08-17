"use client";

import {
  useCallback,
  useEffect,
  useMemo,
  useState,
} from "react";
import Link from "next/link";
import {
  useParams,
  useRouter,
} from "next/navigation";
import { supabase } from "@/lib/supabase";

type UserClientRole = {
  role: string;
  client_id: string | null;
  status: string;
};

type CandidateInvitation = {
  candidate_id: string;
  invitation_id: string;

  client_id: string;
  client_name: string;

  industry_id: string;
  industry_name: string;

  candidate_first_name: string;
  candidate_last_name: string;
  candidate_email: string;
  candidate_status: string;

  master_role_template_id: string;
  role_name: string;

  invitation_status: string;
  expires_at: string;
  sent_at: string | null;
  opened_at: string | null;
  started_at: string | null;
  completed_at: string | null;
  revoked_at: string | null;

  partial_coverage_approved: boolean;

  assigned_assessment_count: number;
  completed_assessment_count: number;
  missing_requirement_count: number;

  converted_employee_id: string | null;
  converted_at: string | null;

  candidate_created_at: string;
  invitation_created_at: string;
};

type ReviewRow = {
  candidate_id: string;
  candidate_first_name: string;
  candidate_last_name: string;
  candidate_email: string;

  master_role_template_id: string;
  role_name: string;

  master_competency_template_id: string;
  competency_name: string;
  competency_category: string | null;
  is_critical: boolean;

  required_level: number;

  invitation_assessment_id: string | null;
  assessment_id: string | null;
  assessment_name: string | null;

  attempt_id: string | null;
  attempt_status: string;

  score_percent: number | null;
  estimated_level: number | null;

  meets_required_level: boolean | null;
  coverage_status: string;
};

function humanizeStatus(value: string) {
  return value
    .replaceAll("_", " ")
    .replace(/\b\w/g, (letter) =>
      letter.toUpperCase()
    );
}

function formatDate(
  value: string | null,
  includeTime = false
) {
  if (!value) {
    return "—";
  }

  const date = new Date(value);

  return includeTime
    ? date.toLocaleString()
    : date.toLocaleDateString();
}

function statusClasses(status: string) {
  switch (status) {
    case "completed":
    case "hired":
      return "border-emerald-500/30 bg-emerald-500/10 text-emerald-300";

    case "in_progress":
    case "assessment_in_progress":
    case "under_review":
      return "border-amber-500/30 bg-amber-500/10 text-amber-300";

    case "revoked":
    case "abandoned":
    case "not_hired":
    case "withdrawn":
      return "border-rose-500/30 bg-rose-500/10 text-rose-300";

    default:
      return "border-slate-700 bg-slate-800 text-slate-300";
  }
}

export default function CandidateDetailPage() {
  const params = useParams();
  const router = useRouter();

  const invitationId =
    params.invitationId as string;

  const [invitation, setInvitation] =
    useState<CandidateInvitation | null>(
      null
    );

  const [reviewRows, setReviewRows] =
    useState<ReviewRow[]>([]);

  const [message, setMessage] =
    useState("Loading candidate...");

  const [successMessage, setSuccessMessage] =
    useState("");

  const [authorized, setAuthorized] =
    useState(false);

  const [loading, setLoading] =
    useState(true);

  const [actionLoading, setActionLoading] =
    useState<string | null>(null);

  const [employeeNumber, setEmployeeNumber] =
    useState("");

  const [hireDate, setHireDate] =
    useState(
      new Date()
        .toISOString()
        .slice(0, 10)
    );

  const loadCandidate =
    useCallback(async () => {
      const {
        data: invitationData,
        error: invitationError,
      } = await supabase.rpc(
        "wri_list_prehire_candidate_invitations",
        {
          p_client_id: null,
          p_candidate_status: null,
          p_invitation_status: null,
        }
      );

      if (invitationError) {
        setMessage(
          invitationError.message
        );
        setLoading(false);
        return;
      }

      const invitationRow = (
        (invitationData ??
          []) as CandidateInvitation[]
      ).find(
        (row) =>
          row.invitation_id ===
          invitationId
      );

      if (!invitationRow) {
        setInvitation(null);
        setReviewRows([]);
        setMessage(
          "Candidate invitation not found or you are not authorized to view it."
        );
        setLoading(false);
        return;
      }

      const {
        data: reviewData,
        error: reviewError,
      } = await supabase.rpc(
        "wri_get_prehire_assessment_review",
        {
          p_invitation_id:
            invitationId,
        }
      );

      if (reviewError) {
        setInvitation(invitationRow);
        setReviewRows([]);
        setMessage(reviewError.message);
        setLoading(false);
        return;
      }

      setInvitation(invitationRow);

      setReviewRows(
        (reviewData ??
          []) as ReviewRow[]
      );

      setMessage("");
      setLoading(false);
    }, [invitationId]);

  useEffect(() => {
    queueMicrotask(() => {
      void (async () => {
        const {
          data: sessionData,
          error: sessionError,
        } =
          await supabase.auth.getSession();

        if (
          sessionError ||
          !sessionData.session
        ) {
          router.push("/");
          return;
        }

        const userId =
          sessionData.session.user.id;

        const {
          data: roleData,
          error: roleError,
        } = await supabase
          .from("user_client_roles")
          .select(
            "role, client_id, status"
          )
          .eq("user_id", userId);

        if (roleError) {
          setMessage(roleError.message);
          setLoading(false);
          return;
        }

        const activeRoles = (
          (roleData ??
            []) as UserClientRole[]
        ).filter(
          (role) =>
            role.status.toLowerCase() ===
            "active"
        );

        const integrateAdmin =
          activeRoles.some(
            (role) =>
              (
                role.role ===
                  "INTEGRATEU_ADMIN" ||
                role.role ===
                  "INTEGRATEU_SUPER_ADMIN"
              ) &&
              role.client_id === null
          );

        const clientAdmin =
          activeRoles.some(
            (role) =>
              role.role ===
                "CLIENT_ADMIN" &&
              Boolean(role.client_id)
          );

        if (
          !integrateAdmin &&
          !clientAdmin
        ) {
          setMessage(
            "You are not authorized to manage candidates."
          );
          setLoading(false);
          return;
        }

        setAuthorized(true);

        await loadCandidate();
      })();
    });
  }, [loadCandidate, router]);

  const completedCount = useMemo(
    () =>
      reviewRows.filter(
        (row) =>
          row.coverage_status ===
          "completed"
      ).length,
    [reviewRows]
  );

  const metCount = useMemo(
    () =>
      reviewRows.filter(
        (row) =>
          row.meets_required_level ===
          true
      ).length,
    [reviewRows]
  );

  const belowCount = useMemo(
    () =>
      reviewRows.filter(
        (row) =>
          row.meets_required_level ===
          false
      ).length,
    [reviewRows]
  );

  const missingCount = useMemo(
    () =>
      reviewRows.filter(
        (row) =>
          row.coverage_status ===
          "missing_assessment"
      ).length,
    [reviewRows]
  );

  const progressPercent =
    invitation &&
    invitation.assigned_assessment_count >
      0
      ? Math.round(
          (invitation.completed_assessment_count /
            invitation.assigned_assessment_count) *
            100
        )
      : 0;

  const canBeginReview =
    invitation?.invitation_status ===
      "completed" &&
    invitation.candidate_status ===
      "assessment_completed";

  const canConvert =
    invitation?.invitation_status ===
      "completed" &&
    invitation.candidate_status ===
      "under_review" &&
    !invitation.converted_employee_id;

  const canRevoke =
    Boolean(invitation) &&
    ![
      "completed",
      "revoked",
    ].includes(
      invitation?.invitation_status ??
        ""
    );

  const canDisposition =
    Boolean(invitation) &&
    ![
      "hired",
      "not_hired",
      "withdrawn",
    ].includes(
      invitation?.candidate_status ??
        ""
    );

  async function refreshAfterAction(
    success: string
  ) {
    await loadCandidate();
    setSuccessMessage(success);
    setActionLoading(null);
  }

  async function beginReview() {
    if (!invitation) {
      return;
    }

    setActionLoading("review");
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_begin_prehire_candidate_review",
      {
        p_invitation_id:
          invitation.invitation_id,
      }
    );

    if (error) {
      setMessage(error.message);
      setActionLoading(null);
      return;
    }

    await refreshAfterAction(
      "Candidate moved to Under Review."
    );
  }

  async function revokeInvitation() {
    if (!invitation) {
      return;
    }

    const confirmed =
      window.confirm(
        "Revoke this invitation? Any unfinished assessment attempt for this invitation will be abandoned."
      );

    if (!confirmed) {
      return;
    }

    setActionLoading("revoke");
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_revoke_prehire_invitation",
      {
        p_invitation_id:
          invitation.invitation_id,
      }
    );

    if (error) {
      setMessage(error.message);
      setActionLoading(null);
      return;
    }

    await refreshAfterAction(
      "Invitation revoked."
    );
  }

  async function setDisposition(
    disposition:
      | "not_hired"
      | "withdrawn"
  ) {
    if (!invitation) {
      return;
    }

    const label =
      disposition === "not_hired"
        ? "Not Hired"
        : "Withdrawn";

    const confirmed =
      window.confirm(
        `Mark this candidate as ${label}? This is a terminal candidate disposition and unfinished invitations will be revoked.`
      );

    if (!confirmed) {
      return;
    }

    setActionLoading(disposition);
    setMessage("");
    setSuccessMessage("");

    const { error } = await supabase.rpc(
      "wri_set_prehire_candidate_disposition",
      {
        p_candidate_id:
          invitation.candidate_id,
        p_disposition: disposition,
      }
    );

    if (error) {
      setMessage(error.message);
      setActionLoading(null);
      return;
    }

    await refreshAfterAction(
      `Candidate marked ${label}.`
    );
  }

  async function convertToEmployee() {
    if (!invitation) {
      return;
    }

    const confirmed =
      window.confirm(
        "Convert this candidate to an employee? This creates the employee record and primary company role assignment. Pre-hire assessment results remain separate from employee readiness."
      );

    if (!confirmed) {
      return;
    }

    setActionLoading("convert");
    setMessage("");
    setSuccessMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_convert_prehire_candidate_to_employee",
      {
        p_invitation_id:
          invitation.invitation_id,
        p_employee_number:
          employeeNumber.trim() || null,
        p_hire_date: hireDate || null,
      }
    );

    if (error) {
      setMessage(error.message);
      setActionLoading(null);
      return;
    }

    const result = (
      data as
        | {
            employee_id: string;
            role_assignment_id: string;
          }[]
        | null
    )?.[0];

    await loadCandidate();

    setSuccessMessage(
      result?.employee_id
        ? "Candidate converted to employee successfully."
        : "Candidate converted to employee."
    );

    setActionLoading(null);
  }

  if (loading) {
    return (
      <div className="mx-auto max-w-7xl">
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-sm text-slate-400">
          Loading candidate...
        </div>
      </div>
    );
  }

  if (
    !authorized ||
    !invitation
  ) {
    return (
      <div className="mx-auto max-w-7xl">
        <Link
          href="/candidates"
          className="text-sm font-medium text-cyan-400"
        >
          ← Candidates
        </Link>

        <div className="mt-6 rounded-2xl border border-rose-500/30 bg-rose-500/10 p-6 text-sm text-rose-200">
          {message ||
            "Candidate invitation unavailable."}
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl">
      <div className="mb-6">
        <Link
          href="/candidates"
          className="text-sm font-medium text-cyan-400 transition hover:text-cyan-300"
        >
          ← Candidates
        </Link>
      </div>

      <header className="mb-8 flex flex-col gap-5 lg:flex-row lg:items-start lg:justify-between">
        <div>
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Candidate Review
          </p>

          <h2 className="mt-2 text-3xl font-semibold">
            {invitation.candidate_first_name}{" "}
            {invitation.candidate_last_name}
          </h2>

          <p className="mt-2 text-sm text-slate-400">
            {invitation.candidate_email}
          </p>

          <div className="mt-4 flex flex-wrap gap-2">
            <span
              className={`rounded-full border px-3 py-1 text-xs font-semibold ${statusClasses(
                invitation.candidate_status
              )}`}
            >
              Candidate:{" "}
              {humanizeStatus(
                invitation.candidate_status
              )}
            </span>

            <span
              className={`rounded-full border px-3 py-1 text-xs font-semibold ${statusClasses(
                invitation.invitation_status
              )}`}
            >
              Invitation:{" "}
              {humanizeStatus(
                invitation.invitation_status
              )}
            </span>

            {invitation.partial_coverage_approved && (
              <span className="rounded-full border border-amber-500/30 bg-amber-500/10 px-3 py-1 text-xs font-semibold text-amber-300">
                Partial Coverage Approved
              </span>
            )}
          </div>
        </div>

        <div className="flex flex-wrap gap-3">
          {canRevoke && (
            <button
              type="button"
              onClick={() =>
                void revokeInvitation()
              }
              disabled={
                actionLoading !== null
              }
              className="rounded-lg border border-rose-500/40 px-4 py-2 text-sm font-semibold text-rose-300 transition hover:bg-rose-500/10 disabled:opacity-50"
            >
              {actionLoading === "revoke"
                ? "Revoking..."
                : "Revoke Invitation"}
            </button>
          )}

          {canBeginReview && (
            <button
              type="button"
              onClick={() =>
                void beginReview()
              }
              disabled={
                actionLoading !== null
              }
              className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:opacity-50"
            >
              {actionLoading === "review"
                ? "Starting Review..."
                : "Begin Review"}
            </button>
          )}

          {invitation.converted_employee_id && (
            <Link
              href={`/employees/${invitation.converted_employee_id}`}
              className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
            >
              Open Employee
            </Link>
          )}
        </div>
      </header>

      {message && (
        <div className="mb-6 rounded-xl border border-rose-500/30 bg-rose-500/10 p-5 text-sm text-rose-200">
          {message}
        </div>
      )}

      {successMessage && (
        <div className="mb-6 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-5 text-sm text-emerald-200">
          {successMessage}
        </div>
      )}

      <section className="mb-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Company
          </p>

          <p className="mt-2 font-semibold">
            {invitation.client_name}
          </p>

          <p className="mt-1 text-sm text-slate-400">
            {invitation.industry_name}
          </p>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Target Role
          </p>

          <p className="mt-2 font-semibold">
            {invitation.role_name}
          </p>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Assessment Progress
          </p>

          <p className="mt-2 text-2xl font-semibold">
            {
              invitation.completed_assessment_count
            }
            /
            {
              invitation.assigned_assessment_count
            }
          </p>

          <p className="mt-1 text-sm text-slate-400">
            {progressPercent}% complete
          </p>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Coverage Gaps
          </p>

          <p className="mt-2 text-2xl font-semibold">
            {
              invitation.missing_requirement_count
            }
          </p>

          <p className="mt-1 text-sm text-slate-400">
            Role requirements without a current assessment
          </p>
        </div>
      </section>

      <section className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
          <div>
            <p className="text-xs uppercase tracking-wide text-slate-500">
              Created
            </p>

            <p className="mt-1 text-sm font-medium">
              {formatDate(
                invitation.invitation_created_at,
                true
              )}
            </p>
          </div>

          <div>
            <p className="text-xs uppercase tracking-wide text-slate-500">
              Opened
            </p>

            <p className="mt-1 text-sm font-medium">
              {formatDate(
                invitation.opened_at,
                true
              )}
            </p>
          </div>

          <div>
            <p className="text-xs uppercase tracking-wide text-slate-500">
              Started
            </p>

            <p className="mt-1 text-sm font-medium">
              {formatDate(
                invitation.started_at,
                true
              )}
            </p>
          </div>

          <div>
            <p className="text-xs uppercase tracking-wide text-slate-500">
              Expires
            </p>

            <p className="mt-1 text-sm font-medium">
              {formatDate(
                invitation.expires_at,
                true
              )}
            </p>
          </div>
        </div>
      </section>

      <section className="mb-8">
        <div className="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
              Assessment Review
            </p>

            <h3 className="mt-2 text-2xl font-semibold">
              Role Requirement Results
            </h3>

            <p className="mt-2 text-sm text-slate-400">
              Candidate scores and estimated levels are visible only to authorized administrators.
            </p>
          </div>

          <div className="flex flex-wrap gap-2 text-xs font-semibold">
            <span className="rounded-full border border-slate-700 bg-slate-800 px-3 py-1 text-slate-300">
              {completedCount} Completed
            </span>

            <span className="rounded-full border border-emerald-500/30 bg-emerald-500/10 px-3 py-1 text-emerald-300">
              {metCount} Meets
            </span>

            <span className="rounded-full border border-rose-500/30 bg-rose-500/10 px-3 py-1 text-rose-300">
              {belowCount} Below
            </span>

            <span className="rounded-full border border-amber-500/30 bg-amber-500/10 px-3 py-1 text-amber-300">
              {missingCount} Missing
            </span>
          </div>
        </div>

        <div className="overflow-hidden rounded-2xl border border-slate-800 bg-slate-900">
          <div className="overflow-x-auto">
            <table className="min-w-full text-left text-sm">
              <thead className="border-b border-slate-800 bg-slate-950/40 text-xs uppercase tracking-wide text-slate-500">
                <tr>
                  <th className="px-5 py-4">
                    Competency
                  </th>

                  <th className="px-5 py-4">
                    Required
                  </th>

                  <th className="px-5 py-4">
                    Assessment
                  </th>

                  <th className="px-5 py-4">
                    Status
                  </th>

                  <th className="px-5 py-4">
                    Score
                  </th>

                  <th className="px-5 py-4">
                    Est. Level
                  </th>

                  <th className="px-5 py-4">
                    Requirement
                  </th>
                </tr>
              </thead>

              <tbody className="divide-y divide-slate-800">
                {reviewRows.map(
                  (row) => (
                    <tr
                      key={`${row.master_competency_template_id}-${row.required_level}`}
                    >
                      <td className="px-5 py-4">
                        <p className="font-medium">
                          {
                            row.competency_name
                          }
                        </p>

                        <div className="mt-1 flex flex-wrap gap-2">
                          {row.competency_category && (
                            <span className="text-xs text-slate-500">
                              {
                                row.competency_category
                              }
                            </span>
                          )}

                          {row.is_critical && (
                            <span className="text-xs font-semibold text-rose-300">
                              Critical
                            </span>
                          )}
                        </div>
                      </td>

                      <td className="px-5 py-4">
                        Level{" "}
                        {row.required_level}
                      </td>

                      <td className="px-5 py-4">
                        {row.assessment_name ??
                          "No current assessment"}
                      </td>

                      <td className="px-5 py-4">
                        <span
                          className={`inline-flex rounded-full border px-2.5 py-1 text-xs font-semibold ${statusClasses(
                            row.coverage_status
                          )}`}
                        >
                          {humanizeStatus(
                            row.coverage_status
                          )}
                        </span>
                      </td>

                      <td className="px-5 py-4">
                        {row.score_percent !==
                        null
                          ? `${row.score_percent}%`
                          : "—"}
                      </td>

                      <td className="px-5 py-4">
                        {row.estimated_level !==
                        null
                          ? `Level ${row.estimated_level}`
                          : "—"}
                      </td>

                      <td className="px-5 py-4">
                        {row.meets_required_level ===
                        true ? (
                          <span className="font-semibold text-emerald-300">
                            Meets
                          </span>
                        ) : row.meets_required_level ===
                          false ? (
                          <span className="font-semibold text-rose-300">
                            Below
                          </span>
                        ) : (
                          <span className="text-slate-500">
                            Pending
                          </span>
                        )}
                      </td>
                    </tr>
                  )
                )}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      {canConvert && (
        <section className="mb-8 rounded-2xl border border-cyan-500/30 bg-cyan-500/10 p-6">
          <p className="text-xs font-semibold uppercase tracking-wide text-cyan-300">
            Hiring Action
          </p>

          <h3 className="mt-2 text-xl font-semibold">
            Convert to Employee
          </h3>

          <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-300">
            Conversion creates the employee and primary company role assignment. Pre-hire assessment results remain separate from employee readiness evidence.
          </p>

          <div className="mt-5 grid gap-4 md:grid-cols-2">
            <label>
              <span className="mb-2 block text-sm text-slate-300">
                Employee Number
              </span>

              <input
                value={employeeNumber}
                onChange={(event) =>
                  setEmployeeNumber(
                    event.target.value
                  )
                }
                placeholder="Optional"
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>

            <label>
              <span className="mb-2 block text-sm text-slate-300">
                Hire Date
              </span>

              <input
                type="date"
                value={hireDate}
                onChange={(event) =>
                  setHireDate(
                    event.target.value
                  )
                }
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>
          </div>

          <button
            type="button"
            onClick={() =>
              void convertToEmployee()
            }
            disabled={
              actionLoading !== null
            }
            className="mt-5 rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:opacity-50"
          >
            {actionLoading === "convert"
              ? "Converting..."
              : "Convert to Employee"}
          </button>
        </section>
      )}

      {canDisposition && (
        <section className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Candidate Disposition
          </p>

          <h3 className="mt-2 text-xl font-semibold">
            Close Candidate
          </h3>

          <p className="mt-2 text-sm leading-6 text-slate-400">
            These actions are terminal. Any unfinished invitation or assessment attempt will be closed.
          </p>

          <div className="mt-5 flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() =>
                void setDisposition(
                  "not_hired"
                )
              }
              disabled={
                actionLoading !== null
              }
              className="rounded-lg border border-rose-500/40 px-4 py-2 text-sm font-semibold text-rose-300 transition hover:bg-rose-500/10 disabled:opacity-50"
            >
              {actionLoading ===
              "not_hired"
                ? "Updating..."
                : "Mark Not Hired"}
            </button>

            <button
              type="button"
              onClick={() =>
                void setDisposition(
                  "withdrawn"
                )
              }
              disabled={
                actionLoading !== null
              }
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-semibold text-slate-300 transition hover:bg-slate-800 disabled:opacity-50"
            >
              {actionLoading ===
              "withdrawn"
                ? "Updating..."
                : "Mark Withdrawn"}
            </button>
          </div>
        </section>
      )}
    </div>
  );
}
