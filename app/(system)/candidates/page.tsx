"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  listCurrentRoleTemplates,
  listIndustries,
  type Industry,
  type MasterRoleTemplate,
} from "@/lib/masterLibrary";
import { supabase } from "@/lib/supabase";

type Client = {
  id: string;
  name: string;
};

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

type CoverageRow = {
  master_role_template_id: string;
  role_name: string;
  industry_id: string;
  master_competency_template_id: string;
  competency_name: string;
  required_level: number;
  assessment_id: string | null;
  assessment_name: string | null;
  assessment_available: boolean;
};

type CreatedInvitation = {
  candidate_id: string;
  invitation_id: string;
  raw_token: string;
  assigned_assessment_count: number;
  missing_requirement_count: number;
};

type CandidateDraft = {
  clientId: string;
  industryId: string;
  roleId: string;
  firstName: string;
  lastName: string;
  email: string;
  expiresAt: string;
};

type StatusFilter =
  | "all"
  | "active"
  | "completed"
  | "under_review"
  | "hired"
  | "not_hired"
  | "withdrawn";

function defaultExpiration() {
  const date = new Date();
  date.setDate(date.getDate() + 7);

  const local = new Date(
    date.getTime() -
      date.getTimezoneOffset() * 60_000
  );

  return local
    .toISOString()
    .slice(0, 16);
}

function humanizeStatus(value: string) {
  return value
    .replaceAll("_", " ")
    .replace(/\b\w/g, (letter) =>
      letter.toUpperCase()
    );
}

function formatDate(value: string | null) {
  if (!value) {
    return "—";
  }

  return new Date(value).toLocaleDateString();
}

export default function CandidatesPage() {
  const router = useRouter();

  const [clients, setClients] =
    useState<Client[]>([]);

  const [industries, setIndustries] =
    useState<Industry[]>([]);

  const [roles, setRoles] =
    useState<MasterRoleTemplate[]>([]);

  const [invitations, setInvitations] =
    useState<CandidateInvitation[]>([]);

  const [coverage, setCoverage] =
    useState<CoverageRow[]>([]);

  const [message, setMessage] =
    useState("Loading candidates...");

  const [successMessage, setSuccessMessage] =
    useState("");

  const [showCreate, setShowCreate] =
    useState(false);

  const [loadingCoverage, setLoadingCoverage] =
    useState(false);

  const [creating, setCreating] =
    useState(false);

  const [allowPartialCoverage, setAllowPartialCoverage] =
    useState(false);

  const [createdInvitation, setCreatedInvitation] =
    useState<CreatedInvitation | null>(
      null
    );

  const [search, setSearch] =
    useState("");

  const [statusFilter, setStatusFilter] =
    useState<StatusFilter>("all");

  const [draft, setDraft] =
    useState<CandidateDraft>({
      clientId: "",
      industryId: "",
      roleId: "",
      firstName: "",
      lastName: "",
      email: "",
      expiresAt: defaultExpiration(),
    });

  async function loadInvitations() {
    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_list_prehire_candidate_invitations",
      {
        p_client_id: null,
        p_candidate_status: null,
        p_invitation_status: null,
      }
    );

    if (error) {
      setMessage(error.message);
      return;
    }

    setInvitations(
      (data ?? []) as CandidateInvitation[]
    );
  }

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
          return;
        }

        const activeRoles = (
          (roleData ?? []) as UserClientRole[]
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

        const clientIds =
          activeRoles
            .filter(
              (role) =>
                role.role ===
                  "CLIENT_ADMIN" &&
                Boolean(role.client_id)
            )
            .map(
              (role) =>
                role.client_id as string
            );

        if (
          !integrateAdmin &&
          clientIds.length === 0
        ) {
          setMessage(
            "You are not authorized to manage candidates."
          );
          return;
        }

        let clientQuery = supabase
          .from("clients")
          .select("id, name")
          .order("name", {
            ascending: true,
          });

        if (!integrateAdmin) {
          clientQuery =
            clientQuery.in(
              "id",
              clientIds
            );
        }

        const [
          clientResult,
          industryResult,
          roleResult,
        ] = await Promise.all([
          clientQuery,
          listIndustries(),
          listCurrentRoleTemplates(),
        ]);

        if (clientResult.error) {
          setMessage(
            clientResult.error.message
          );
          return;
        }

        const nextClients =
          (clientResult.data ??
            []) as Client[];

        const nextIndustries =
          industryResult.filter(
            (industry) =>
              industry.is_active
          );

        const nextRoles =
          roleResult.filter(
            (role) =>
              role.status === "active"
          );

        setClients(nextClients);
        setIndustries(nextIndustries);
        setRoles(nextRoles);

        setDraft((current) => ({
          ...current,
          clientId:
            current.clientId ||
            nextClients[0]?.id ||
            "",
          industryId:
            current.industryId ||
            nextIndustries[0]?.id ||
            "",
        }));

        await loadInvitations();

        setMessage("");
      })();
    });
  }, [router]);

  const availableRoles = useMemo(
    () =>
      roles.filter(
        (role) =>
          role.industry_id ===
          draft.industryId
      ),
    [roles, draft.industryId]
  );

  useEffect(() => {
    queueMicrotask(() => {
      setDraft((current) => {
        const roleStillAvailable =
          availableRoles.some(
            (role) =>
              role.id === current.roleId
          );

        return {
          ...current,
          roleId: roleStillAvailable
            ? current.roleId
            : availableRoles[0]?.id ||
              "",
        };
      });

      setCoverage([]);
      setAllowPartialCoverage(false);
    });
  }, [availableRoles]);

  const coverageSummary = useMemo(() => {
    const total = coverage.length;

    const available =
      coverage.filter(
        (row) =>
          row.assessment_available
      ).length;

    return {
      total,
      available,
      missing: total - available,
    };
  }, [coverage]);

  const filteredInvitations =
    useMemo(() => {
      const normalizedSearch =
        search.trim().toLowerCase();

      return invitations.filter(
        (invitation) => {
          const matchesSearch =
            !normalizedSearch ||
            [
              invitation.candidate_first_name,
              invitation.candidate_last_name,
              invitation.candidate_email,
              invitation.client_name,
              invitation.industry_name,
              invitation.role_name,
            ]
              .join(" ")
              .toLowerCase()
              .includes(
                normalizedSearch
              );

          if (!matchesSearch) {
            return false;
          }

          if (
            statusFilter === "all"
          ) {
            return true;
          }

          if (
            statusFilter === "active"
          ) {
            return ![
              "hired",
              "not_hired",
              "withdrawn",
            ].includes(
              invitation.candidate_status
            );
          }

          if (
            statusFilter ===
            "completed"
          ) {
            return (
              invitation.invitation_status ===
                "completed" ||
              invitation.candidate_status ===
                "assessment_completed"
            );
          }

          return (
            invitation.candidate_status ===
            statusFilter
          );
        }
      );
    }, [
      invitations,
      search,
      statusFilter,
    ]);

  const activeCount =
    invitations.filter(
      (invitation) =>
        ![
          "hired",
          "not_hired",
          "withdrawn",
        ].includes(
          invitation.candidate_status
        )
    ).length;

  const completedCount =
    invitations.filter(
      (invitation) =>
        invitation.invitation_status ===
        "completed"
    ).length;

  const reviewCount =
    invitations.filter(
      (invitation) =>
        invitation.candidate_status ===
          "assessment_completed" ||
        invitation.candidate_status ===
          "under_review"
    ).length;

  async function previewCoverage() {
    if (
      !draft.clientId ||
      !draft.roleId
    ) {
      setMessage(
        "Select a company, industry, and target role first."
      );
      return;
    }

    setLoadingCoverage(true);
    setMessage("");
    setSuccessMessage("");

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_get_prehire_role_assessment_coverage",
      {
        p_client_id: draft.clientId,
        p_master_role_template_id:
          draft.roleId,
      }
    );

    if (error) {
      setMessage(error.message);
      setCoverage([]);
      setLoadingCoverage(false);
      return;
    }

    setCoverage(
      (data ?? []) as CoverageRow[]
    );

    setAllowPartialCoverage(false);
    setLoadingCoverage(false);
  }

  async function createInvitation(
    event: React.FormEvent
  ) {
    event.preventDefault();

    if (
      !draft.clientId ||
      !draft.industryId ||
      !draft.roleId
    ) {
      setMessage(
        "Company, industry, and target role are required."
      );
      return;
    }

    if (
      coverageSummary.missing > 0 &&
      !allowPartialCoverage
    ) {
      setMessage(
        "Review the missing assessment coverage and approve partial coverage before creating this invitation."
      );
      return;
    }

    setCreating(true);
    setMessage("");
    setSuccessMessage("");
    setCreatedInvitation(null);

    const expiresAt =
      new Date(
        draft.expiresAt
      ).toISOString();

    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_create_prehire_invitation",
      {
        p_client_id: draft.clientId,
        p_industry_id:
          draft.industryId,
        p_first_name:
          draft.firstName.trim(),
        p_last_name:
          draft.lastName.trim(),
        p_email:
          draft.email.trim(),
        p_master_role_template_id:
          draft.roleId,
        p_expires_at: expiresAt,
        p_allow_partial_coverage:
          allowPartialCoverage,
      }
    );

    if (error) {
      setMessage(error.message);
      setCreating(false);
      return;
    }

    const created =
      (
        (data ?? []) as
          CreatedInvitation[]
      )[0];

    if (!created) {
      setMessage(
        "The invitation was created but no invitation details were returned."
      );
      setCreating(false);
      return;
    }

    setCreatedInvitation(created);

    setSuccessMessage(
      "Candidate invitation created. Copy the secure link below now—the raw invitation token is only returned once."
    );

    setDraft((current) => ({
      ...current,
      firstName: "",
      lastName: "",
      email: "",
      expiresAt:
        defaultExpiration(),
    }));

    setCoverage([]);
    setAllowPartialCoverage(false);

    await loadInvitations();

    setCreating(false);
  }

  const invitationUrl =
    createdInvitation &&
    typeof window !== "undefined"
      ? `${
          window.location.origin
        }/candidate?token=${encodeURIComponent(
          createdInvitation.raw_token
        )}`
      : "";

  async function copyInvitationLink() {
    if (!invitationUrl) {
      return;
    }

    await navigator.clipboard.writeText(
      invitationUrl
    );

    setSuccessMessage(
      "Secure candidate invitation link copied."
    );
  }

  return (
    <div className="mx-auto max-w-7xl">
      <header className="mb-8 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Candidates
          </p>

          <h2 className="mt-2 text-3xl font-semibold">
            Pre-Hire Readiness
          </h2>

          <p className="mt-2 max-w-3xl text-sm text-slate-400">
            Invite candidates to role-based assessments,
            monitor assessment progress, and review readiness
            before converting a hired candidate into the
            employee development workflow.
          </p>
        </div>

        <button
          type="button"
          onClick={() => {
            setShowCreate(
              (current) => !current
            );
            setMessage("");
            setSuccessMessage("");
          }}
          className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
        >
          {showCreate
            ? "Cancel"
            : "Add Candidate"}
        </button>
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

      {createdInvitation &&
        invitationUrl && (
          <section className="mb-8 rounded-2xl border border-cyan-500/30 bg-cyan-500/10 p-6">
            <p className="text-xs font-semibold uppercase tracking-wide text-cyan-300">
              Secure Invitation Link
            </p>

            <h3 className="mt-2 text-xl font-semibold">
              Save this link now
            </h3>

            <p className="mt-2 text-sm leading-6 text-slate-300">
              The raw invitation token is only returned when
              the invitation is created. It is not stored in
              readable form.
            </p>

            <div className="mt-4 flex flex-col gap-3 sm:flex-row">
              <input
                readOnly
                value={invitationUrl}
                className="min-w-0 flex-1 rounded-lg border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-slate-300"
              />

              <button
                type="button"
                onClick={() =>
                  void copyInvitationLink()
                }
                className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
              >
                Copy Link
              </button>
            </div>

            <p className="mt-4 text-sm text-slate-400">
              {
                createdInvitation.assigned_assessment_count
              }{" "}
              assessment
              {createdInvitation.assigned_assessment_count ===
              1
                ? ""
                : "s"}{" "}
              assigned
              {createdInvitation.missing_requirement_count >
              0
                ? ` · ${createdInvitation.missing_requirement_count} requirement(s) without current assessment coverage`
                : " · Full assessment coverage"}
            </p>
          </section>
        )}

      {showCreate && (
        <form
          onSubmit={createInvitation}
          className="mb-10 rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8"
        >
          <div className="mb-6">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
              New Candidate
            </p>

            <h3 className="mt-2 text-2xl font-semibold">
              Create Pre-Hire Invitation
            </h3>

            <p className="mt-2 text-sm text-slate-400">
              Select the company, industry, and target role
              before reviewing assessment coverage.
            </p>
          </div>

          <div className="grid gap-5 md:grid-cols-2">
            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                Company
              </span>

              <select
                value={draft.clientId}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      clientId:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              >
                {clients.map(
                  (client) => (
                    <option
                      key={client.id}
                      value={client.id}
                    >
                      {client.name}
                    </option>
                  )
                )}
              </select>
            </label>

            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                Industry
              </span>

              <select
                value={draft.industryId}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      industryId:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              >
                {industries.map(
                  (industry) => (
                    <option
                      key={industry.id}
                      value={
                        industry.id
                      }
                    >
                      {industry.name}
                    </option>
                  )
                )}
              </select>
            </label>

            <label className="block md:col-span-2">
              <span className="mb-2 block text-sm text-slate-300">
                Target Role
              </span>

              <select
                value={draft.roleId}
                onChange={(event) => {
                  setDraft(
                    (current) => ({
                      ...current,
                      roleId:
                        event.target
                          .value,
                    })
                  );
                  setCoverage([]);
                  setAllowPartialCoverage(
                    false
                  );
                }}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              >
                {availableRoles.map(
                  (role) => (
                    <option
                      key={role.id}
                      value={role.id}
                    >
                      {role.name}
                      {role.department
                        ? ` · ${role.department}`
                        : ""}
                    </option>
                  )
                )}
              </select>

              {availableRoles.length ===
                0 && (
                <p className="mt-2 text-sm text-amber-300">
                  No active current roles
                  are available for this
                  industry.
                </p>
              )}
            </label>

            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                First Name
              </span>

              <input
                value={draft.firstName}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      firstName:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>

            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                Last Name
              </span>

              <input
                value={draft.lastName}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      lastName:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>

            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                Email
              </span>

              <input
                type="email"
                value={draft.email}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      email:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>

            <label className="block">
              <span className="mb-2 block text-sm text-slate-300">
                Invitation Expires
              </span>

              <input
                type="datetime-local"
                value={draft.expiresAt}
                onChange={(event) =>
                  setDraft(
                    (current) => ({
                      ...current,
                      expiresAt:
                        event.target
                          .value,
                    })
                  )
                }
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
              />
            </label>
          </div>

          <div className="mt-6 flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() =>
                void previewCoverage()
              }
              disabled={
                loadingCoverage ||
                !draft.clientId ||
                !draft.roleId
              }
              className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20 disabled:opacity-50"
            >
              {loadingCoverage
                ? "Checking..."
                : "Check Assessment Coverage"}
            </button>

            {coverage.length > 0 && (
              <span className="inline-flex items-center rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300">
                {
                  coverageSummary.available
                }
                /
                {coverageSummary.total}{" "}
                requirements covered
              </span>
            )}
          </div>

          {coverage.length > 0 && (
            <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/50 p-5">
              <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                <div>
                  <p className="font-semibold">
                    Assessment Coverage
                  </p>

                  <p className="mt-1 text-sm text-slate-400">
                    Coverage is matched
                    against the competency
                    level required by the
                    selected role.
                  </p>
                </div>

                <span
                  className={`rounded-full px-3 py-1 text-xs font-semibold ${
                    coverageSummary.missing ===
                    0
                      ? "bg-emerald-500/15 text-emerald-300"
                      : "bg-amber-500/15 text-amber-300"
                  }`}
                >
                  {coverageSummary.missing ===
                  0
                    ? "Full Coverage"
                    : `${coverageSummary.missing} Missing`}
                </span>
              </div>

              <div className="mt-5 space-y-2">
                {coverage.map(
                  (row) => (
                    <div
                      key={`${row.master_competency_template_id}-${row.required_level}`}
                      className="flex flex-col gap-2 rounded-lg border border-slate-800 p-4 sm:flex-row sm:items-center sm:justify-between"
                    >
                      <div>
                        <p className="text-sm font-medium">
                          {
                            row.competency_name
                          }
                        </p>

                        <p className="mt-1 text-xs text-slate-500">
                          Required level{" "}
                          {
                            row.required_level
                          }
                        </p>
                      </div>

                      <p
                        className={`text-sm ${
                          row.assessment_available
                            ? "text-emerald-300"
                            : "text-amber-300"
                        }`}
                      >
                        {row.assessment_available
                          ? row.assessment_name ??
                            "Assessment available"
                          : "No current assessment"}
                      </p>
                    </div>
                  )
                )}
              </div>

              {coverageSummary.missing >
                0 && (
                <label className="mt-5 flex items-start gap-3 rounded-lg border border-amber-500/30 bg-amber-500/10 p-4">
                  <input
                    type="checkbox"
                    checked={
                      allowPartialCoverage
                    }
                    onChange={(
                      event
                    ) =>
                      setAllowPartialCoverage(
                        event.target
                          .checked
                      )
                    }
                    className="mt-1"
                  />

                  <span className="text-sm leading-6 text-amber-200">
                    I understand this role
                    does not currently have
                    complete assessment
                    coverage and approve
                    creating this invitation
                    with partial coverage.
                  </span>
                </label>
              )}
            </div>
          )}

          <div className="mt-6">
            <button
              type="submit"
              disabled={
                creating ||
                !draft.clientId ||
                !draft.industryId ||
                !draft.roleId ||
                coverage.length === 0 ||
                (coverageSummary.missing >
                  0 &&
                  !allowPartialCoverage)
              }
              className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
            >
              {creating
                ? "Creating..."
                : "Create Invitation"}
            </button>
          </div>
        </form>
      )}

      <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
        <MetricCard
          label="Invitation Cycles"
          value={invitations.length}
        />

        <MetricCard
          label="Active"
          value={activeCount}
        />

        <MetricCard
          label="Assessments Complete"
          value={completedCount}
        />

        <MetricCard
          label="Ready for Review"
          value={reviewCount}
        />
      </section>

      <section className="mt-8">
        <div className="mb-5 flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
          <div>
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
              Hiring Pipeline
            </p>

            <h3 className="mt-2 text-2xl font-semibold">
              Candidate Invitations
            </h3>

            <p className="mt-2 text-sm text-slate-400">
              One row represents one
              assessment invitation and
              hiring cycle.
            </p>
          </div>

          <div className="flex flex-col gap-3 sm:flex-row">
            <input
              value={search}
              onChange={(event) =>
                setSearch(
                  event.target.value
                )
              }
              placeholder="Search candidates..."
              className="rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 text-sm"
            />

            <select
              value={statusFilter}
              onChange={(event) =>
                setStatusFilter(
                  event.target
                    .value as StatusFilter
                )
              }
              className="rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 text-sm"
            >
              <option value="all">
                All Statuses
              </option>
              <option value="active">
                Active
              </option>
              <option value="completed">
                Assessment Complete
              </option>
              <option value="under_review">
                Under Review
              </option>
              <option value="hired">
                Hired
              </option>
              <option value="not_hired">
                Not Hired
              </option>
              <option value="withdrawn">
                Withdrawn
              </option>
            </select>
          </div>
        </div>

        {filteredInvitations.length ===
        0 ? (
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-400">
            No candidate invitations match
            the current filters.
          </div>
        ) : (
          <div className="space-y-4">
            {filteredInvitations.map(
              (invitation) => {
                const complete =
                  Number(
                    invitation.completed_assessment_count
                  );

                const assigned =
                  Number(
                    invitation.assigned_assessment_count
                  );

                const progress =
                  assigned > 0
                    ? Math.round(
                        (complete /
                          assigned) *
                          100
                      )
                    : 0;

                return (
                  <article
                    key={
                      invitation.invitation_id
                    }
                    className="rounded-2xl border border-slate-800 bg-slate-900 p-6"
                  >
                    <div className="flex flex-col gap-5 xl:flex-row xl:items-start xl:justify-between">
                      <div className="min-w-0">
                        <div className="flex flex-wrap items-center gap-2">
                          <h4 className="text-xl font-semibold">
                            {
                              invitation.candidate_first_name
                            }{" "}
                            {
                              invitation.candidate_last_name
                            }
                          </h4>

                          <StatusBadge
                            value={
                              invitation.candidate_status
                            }
                          />

                          <StatusBadge
                            value={
                              invitation.invitation_status
                            }
                            secondary
                          />
                        </div>

                        <p className="mt-2 text-sm text-slate-400">
                          {
                            invitation.candidate_email
                          }
                        </p>

                        <div className="mt-4 flex flex-wrap gap-x-6 gap-y-2 text-sm text-slate-400">
                          <span>
                            {
                              invitation.client_name
                            }
                          </span>

                          <span>
                            {
                              invitation.industry_name
                            }
                          </span>

                          <span className="text-slate-200">
                            {
                              invitation.role_name
                            }
                          </span>
                        </div>
                      </div>

                      <div className="flex flex-wrap gap-3">
                        <Link
                          href={`/candidates/${invitation.invitation_id}`}
                          className="rounded-lg border border-cyan-500/50 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-300 transition hover:bg-cyan-500/20"
                        >
                          Open Candidate
                        </Link>
                      </div>
                    </div>

                    <div className="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
                      <SmallMetric
                        label="Assessments"
                        value={`${complete}/${assigned}`}
                      />

                      <SmallMetric
                        label="Progress"
                        value={`${progress}%`}
                      />

                      <SmallMetric
                        label="Coverage Gaps"
                        value={Number(
                          invitation.missing_requirement_count
                        )}
                      />

                      <SmallMetric
                        label="Expires"
                        value={formatDate(
                          invitation.expires_at
                        )}
                      />

                      <SmallMetric
                        label="Created"
                        value={formatDate(
                          invitation.invitation_created_at
                        )}
                      />
                    </div>
                  </article>
                );
              }
            )}
          </div>
        )}
      </section>
    </div>
  );
}

function MetricCard({
  label,
  value,
}: {
  label: string;
  value: number;
}) {
  return (
    <div className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
        {label}
      </p>

      <p className="mt-2 text-3xl font-semibold">
        {value}
      </p>
    </div>
  );
}

function SmallMetric({
  label,
  value,
}: {
  label: string;
  value: string | number;
}) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-4">
      <p className="text-xs text-slate-500">
        {label}
      </p>

      <p className="mt-1 font-semibold">
        {value}
      </p>
    </div>
  );
}

function StatusBadge({
  value,
  secondary = false,
}: {
  value: string;
  secondary?: boolean;
}) {
  return (
    <span
      className={`rounded-full px-3 py-1 text-xs font-medium ${
        secondary
          ? "bg-slate-800 text-slate-300"
          : "bg-cyan-500/15 text-cyan-300"
      }`}
    >
      {humanizeStatus(value)}
    </span>
  );
}
