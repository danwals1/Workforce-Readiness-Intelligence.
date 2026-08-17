"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type Candidate = {
  auth_user_id: string;
  email: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  client_id: string;
};

type Assignment = {
  assignment_id: string;
  client_id: string;
  verifier_user_id: string;
  verifier_email: string | null;
  verifier_employee_id: string | null;
  verifier_first_name: string | null;
  verifier_last_name: string | null;
  verifier_title: string | null;
  scope: "client" | "employee";
  employee_id: string | null;
  employee_first_name: string | null;
  employee_last_name: string | null;
  is_active: boolean;
  assigned_at: string;
  expires_at: string | null;
  notes: string | null;
};

type Client = {
  id: string;
  name: string;
};

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  client_id: string;
};

export default function ManageVerifiersPage() {
  const router = useRouter();

  const [clients, setClients] = useState<Client[]>([]);
  const [employees, setEmployees] = useState<Employee[]>([]);
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [assignments, setAssignments] = useState<Assignment[]>([]);

  const [selectedClientId, setSelectedClientId] = useState("");
  const [selectedVerifierUserId, setSelectedVerifierUserId] = useState("");
  const [scope, setScope] = useState<"client" | "employee">("client");
  const [selectedEmployeeId, setSelectedEmployeeId] = useState("");
  const [verifierTitle, setVerifierTitle] = useState("");
  const [expiresAt, setExpiresAt] = useState("");
  const [notes, setNotes] = useState("");

  const [message, setMessage] = useState("Loading verifier management...");
  const [successMessage, setSuccessMessage] = useState("");
  const [saving, setSaving] = useState(false);
  const [isIntegrateAdmin, setIsIntegrateAdmin] = useState(false);

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

      const userId = sessionData.session.user.id;

      const {
        data: roles,
        error: rolesError,
      } = await supabase
        .from("user_client_roles")
        .select("role, client_id")
        .eq("user_id", userId);

      if (rolesError) {
        setMessage(rolesError.message);
        return;
      }

      const integrateAdmin =
        roles?.some((role) => role.role === "INTEGRATEU_ADMIN") ?? false;

      setIsIntegrateAdmin(integrateAdmin);

      const clientIds =
        roles
          ?.filter((role) => role.role === "CLIENT_ADMIN")
          .map((role) => role.client_id)
          .filter((id): id is string => Boolean(id)) ?? [];

      let clientQuery = supabase
        .from("clients")
        .select("id, name")
        .order("name", { ascending: true });

      if (!integrateAdmin) {
        if (clientIds.length === 0) {
          setMessage("You are not authorized to manage practical verifiers.");
          return;
        }

        clientQuery = clientQuery.in("id", clientIds);
      }

      const {
        data: clientData,
        error: clientError,
      } = await clientQuery;

      if (clientError) {
        setMessage(clientError.message);
        return;
      }

      const normalizedClients = (clientData ?? []) as Client[];

      setClients(normalizedClients);

      if (normalizedClients.length > 0) {
        setSelectedClientId(normalizedClients[0].id);
      }

      setMessage("");
    }

    loadPage();
  }, [router]);

  useEffect(() => {
    if (!selectedClientId) {
      return;
    }

    void loadClientData(selectedClientId);
  }, [selectedClientId]);

  async function loadClientData(clientId: string) {
    setMessage("Loading verifier data...");
    setSuccessMessage("");

    const [
      candidateResponse,
      assignmentResponse,
      employeeResponse,
    ] = await Promise.all([
      supabase.rpc("wri_list_verifier_candidates", {
        p_client_id: clientId,
      }),

      supabase.rpc("wri_list_practical_verifiers", {
        p_client_id: clientId,
      }),

      supabase
        .from("employees")
        .select(`
          id,
          first_name,
          last_name,
          client_id
        `)
        .eq("client_id", clientId)
        .order("last_name", { ascending: true }),
    ]);

    if (candidateResponse.error) {
      setMessage(candidateResponse.error.message);
      return;
    }

    if (assignmentResponse.error) {
      setMessage(assignmentResponse.error.message);
      return;
    }

    if (employeeResponse.error) {
      setMessage(employeeResponse.error.message);
      return;
    }

    const nextCandidates =
      (candidateResponse.data ?? []) as Candidate[];

    const nextAssignments =
      (assignmentResponse.data ?? []) as Assignment[];

    const nextEmployees =
      (employeeResponse.data ?? []) as Employee[];

    setCandidates(nextCandidates);
    setAssignments(nextAssignments);
    setEmployees(nextEmployees);

    setSelectedVerifierUserId(
      nextCandidates[0]?.auth_user_id ?? ""
    );

    setSelectedEmployeeId(
      nextEmployees[0]?.id ?? ""
    );

    setMessage("");
  }

  const activeAssignments = useMemo(
    () =>
      assignments.filter(
        (assignment) => assignment.is_active
      ),
    [assignments]
  );

  const inactiveAssignments = useMemo(
    () =>
      assignments.filter(
        (assignment) => !assignment.is_active
      ),
    [assignments]
  );

  async function assignVerifier() {
    if (!selectedClientId || !selectedVerifierUserId) {
      setMessage("Select a client and verifier.");
      return;
    }

    if (scope === "employee" && !selectedEmployeeId) {
      setMessage("Select an employee for employee-specific access.");
      return;
    }

    setSaving(true);
    setMessage("");
    setSuccessMessage("");

    const {
      error,
    } = await supabase.rpc(
      "wri_assign_practical_verifier",
      {
        p_client_id: selectedClientId,
        p_verifier_user_id: selectedVerifierUserId,
        p_scope: scope,
        p_employee_id:
          scope === "employee"
            ? selectedEmployeeId
            : null,
        p_verifier_title:
          verifierTitle.trim() || null,
        p_expires_at:
          expiresAt
            ? new Date(expiresAt).toISOString()
            : null,
        p_notes:
          notes.trim() || null,
      }
    );

    if (error) {
      setMessage(error.message);
      setSaving(false);
      return;
    }

    setVerifierTitle("");
    setExpiresAt("");
    setNotes("");

    setSuccessMessage(
      "Practical verifier assignment saved."
    );

    await loadClientData(selectedClientId);

    setSaving(false);
  }

  async function deactivateAssignment(
    assignmentId: string
  ) {
    setMessage("");
    setSuccessMessage("");

    const {
      error,
    } = await supabase.rpc(
      "wri_deactivate_practical_verifier",
      {
        p_assignment_id: assignmentId,
      }
    );

    if (error) {
      setMessage(error.message);
      return;
    }

    setSuccessMessage(
      "Verifier assignment deactivated."
    );

    await loadClientData(selectedClientId);
  }

  async function reactivateAssignment(
    assignmentId: string
  ) {
    setMessage("");
    setSuccessMessage("");

    const {
      error,
    } = await supabase.rpc(
      "wri_reactivate_practical_verifier",
      {
        p_assignment_id: assignmentId,
      }
    );

    if (error) {
      setMessage(error.message);
      return;
    }

    setSuccessMessage(
      "Verifier assignment reactivated."
    );

    await loadClientData(selectedClientId);
  }

  function assignmentName(
    assignment: Assignment
  ) {
    const fullName = [
      assignment.verifier_first_name,
      assignment.verifier_last_name,
    ]
      .filter(Boolean)
      .join(" ");

    return fullName || assignment.verifier_email || "Unknown user";
  }

  function scopeLabel(
    assignment: Assignment
  ) {
    if (assignment.scope === "client") {
      return "Entire Company";
    }

    const employeeName = [
      assignment.employee_first_name,
      assignment.employee_last_name,
    ]
      .filter(Boolean)
      .join(" ");

    return employeeName || "Specific Employee";
  }

  return (
    <div className="mx-auto max-w-6xl">
      <header className="mb-8 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
            Verifier Management
          </p>

          <h2 className="mt-2 text-3xl font-semibold">
            Manage Practical Verifiers
          </h2>

          <p className="mt-2 max-w-3xl text-sm text-slate-400">
            Give supervisors, trainers, lead technicians, or instructors practical-verification authority without granting full company-admin access.
          </p>
        </div>

        {isIntegrateAdmin && (
          <Link
            href="/admin/library"
            className="inline-flex items-center justify-center rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
          >
            Master Library
          </Link>
        )}
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

        <section className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
          <div className="grid gap-6 lg:grid-cols-2">
            <div>
              <h2 className="text-xl font-semibold">
                Add Verifier
              </h2>

              <p className="mt-2 text-sm text-slate-400">
                Assign permission for an entire company or one
                employee.
              </p>

              <div className="mt-6 space-y-5">
                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Company
                  </label>

                  <select
                    value={selectedClientId}
                    onChange={(event) =>
                      setSelectedClientId(
                        event.target.value
                      )
                    }
                    className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                  >
                    {clients.map((client) => (
                      <option
                        key={client.id}
                        value={client.id}
                      >
                        {client.name}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Verifier
                  </label>

                  <select
                    value={selectedVerifierUserId}
                    onChange={(event) =>
                      setSelectedVerifierUserId(
                        event.target.value
                      )
                    }
                    className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                  >
                    {candidates.map((candidate) => (
                      <option
                        key={candidate.auth_user_id}
                        value={candidate.auth_user_id}
                      >
                        {candidate.first_name}{" "}
                        {candidate.last_name} —{" "}
                        {candidate.email}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Scope
                  </label>

                  <div className="grid grid-cols-2 gap-3">
                    <button
                      type="button"
                      onClick={() =>
                        setScope("client")
                      }
                      className={`rounded-xl border p-4 text-left ${
                        scope === "client"
                          ? "border-cyan-400 bg-cyan-400/10"
                          : "border-slate-700"
                      }`}
                    >
                      <p className="font-semibold">
                        Entire Company
                      </p>

                      <p className="mt-1 text-xs text-slate-400">
                        May verify any employee in this company.
                      </p>
                    </button>

                    <button
                      type="button"
                      onClick={() =>
                        setScope("employee")
                      }
                      className={`rounded-xl border p-4 text-left ${
                        scope === "employee"
                          ? "border-cyan-400 bg-cyan-400/10"
                          : "border-slate-700"
                      }`}
                    >
                      <p className="font-semibold">
                        Specific Employee
                      </p>

                      <p className="mt-1 text-xs text-slate-400">
                        May verify only one selected employee.
                      </p>
                    </button>
                  </div>
                </div>

                {scope === "employee" && (
                  <div>
                    <label className="mb-2 block text-sm text-slate-300">
                      Employee
                    </label>

                    <select
                      value={selectedEmployeeId}
                      onChange={(event) =>
                        setSelectedEmployeeId(
                          event.target.value
                        )
                      }
                      className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                    >
                      {employees.map((employee) => (
                        <option
                          key={employee.id}
                          value={employee.id}
                        >
                          {employee.first_name}{" "}
                          {employee.last_name}
                        </option>
                      ))}
                    </select>
                  </div>
                )}

                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Verifier Title
                  </label>

                  <input
                    value={verifierTitle}
                    onChange={(event) =>
                      setVerifierTitle(
                        event.target.value
                      )
                    }
                    placeholder="Supervisor, Trainer, Lead Technician..."
                    className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                  />
                </div>

                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Expiration
                  </label>

                  <input
                    type="datetime-local"
                    value={expiresAt}
                    onChange={(event) =>
                      setExpiresAt(
                        event.target.value
                      )
                    }
                    className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                  />
                </div>

                <div>
                  <label className="mb-2 block text-sm text-slate-300">
                    Notes
                  </label>

                  <textarea
                    value={notes}
                    onChange={(event) =>
                      setNotes(
                        event.target.value
                      )
                    }
                    rows={3}
                    placeholder="Optional reason or context for this assignment..."
                    className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-3"
                  />
                </div>

                <button
                  type="button"
                  onClick={assignVerifier}
                  disabled={saving}
                  className="w-full rounded-lg bg-cyan-400 px-5 py-3 font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:opacity-50"
                >
                  {saving
                    ? "Saving..."
                    : "Assign Verifier"}
                </button>
              </div>
            </div>

            <div className="rounded-xl border border-slate-800 bg-slate-950/50 p-5">
              <h3 className="font-semibold">
                Permission Model
              </h3>

              <div className="mt-4 space-y-4 text-sm text-slate-400">
                <p>
                  <strong className="text-slate-300">
                    IntegrateU Admin
                  </strong>{" "}
                  may verify and manage verifier access across
                  clients.
                </p>

                <p>
                  <strong className="text-slate-300">
                    Client Admin
                  </strong>{" "}
                  may manage verifiers for their company.
                </p>

                <p>
                  <strong className="text-slate-300">
                    Dedicated Verifier
                  </strong>{" "}
                  may verify only within the scope assigned here.
                </p>

                <p>
                  Verifier assignments can be deactivated without
                  deleting permission history.
                </p>
              </div>
            </div>
          </div>
        </section>

        <section className="mt-8">
          <div className="mb-5">
            <h2 className="text-2xl font-semibold">
              Active Verifiers
            </h2>

            <p className="mt-1 text-sm text-slate-400">
              Current practical-verification permissions.
            </p>
          </div>

          <div className="space-y-4">
            {activeAssignments.map((assignment) => (
              <div
                key={assignment.assignment_id}
                className="rounded-xl border border-slate-800 bg-slate-900 p-5"
              >
                <div className="flex flex-col gap-5 md:flex-row md:items-center md:justify-between">
                  <div>
                    <div className="flex flex-wrap items-center gap-2">
                      <p className="text-lg font-semibold">
                        {assignmentName(
                          assignment
                        )}
                      </p>

                      <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-xs text-emerald-300">
                        Active
                      </span>
                    </div>

                    <p className="mt-1 text-sm text-slate-400">
                      {assignment.verifier_title ||
                        "Practical Verifier"}
                    </p>

                    <p className="mt-2 text-sm text-slate-300">
                      Scope:{" "}
                      <strong>
                        {scopeLabel(
                          assignment
                        )}
                      </strong>
                    </p>

                    {assignment.expires_at && (
                      <p className="mt-1 text-xs text-slate-500">
                        Expires{" "}
                        {new Date(
                          assignment.expires_at
                        ).toLocaleString()}
                      </p>
                    )}
                  </div>

                  <button
                    type="button"
                    onClick={() =>
                      deactivateAssignment(
                        assignment.assignment_id
                      )
                    }
                    className="rounded-lg border border-rose-500/30 bg-rose-500/10 px-4 py-2 text-sm font-medium text-rose-300"
                  >
                    Deactivate
                  </button>
                </div>
              </div>
            ))}

            {activeAssignments.length === 0 && (
              <div className="rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
                No active verifier assignments for this company.
              </div>
            )}
          </div>
        </section>

        {inactiveAssignments.length > 0 && (
          <section className="mt-10">
            <div className="mb-5">
              <h2 className="text-xl font-semibold">
                Inactive History
              </h2>

              <p className="mt-1 text-sm text-slate-400">
                Previous verifier assignments are retained for
                audit history.
              </p>
            </div>

            <div className="space-y-3">
              {inactiveAssignments.map((assignment) => (
                <div
                  key={assignment.assignment_id}
                  className="rounded-xl border border-slate-800 bg-slate-900 p-5"
                >
                  <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                    <div>
                      <p className="font-semibold">
                        {assignmentName(
                          assignment
                        )}
                      </p>

                      <p className="mt-1 text-sm text-slate-400">
                        {assignment.verifier_title ||
                          "Practical Verifier"}{" "}
                        · {scopeLabel(assignment)}
                      </p>
                    </div>

                    <button
                      type="button"
                      onClick={() =>
                        reactivateAssignment(
                          assignment.assignment_id
                        )
                      }
                      className="rounded-lg border border-cyan-400 px-4 py-2 text-sm font-medium text-cyan-400"
                    >
                      Reactivate
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </section>
        )}
    </div>
  );
}