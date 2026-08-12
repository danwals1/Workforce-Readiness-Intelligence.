"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import SystemHeader from "@/components/SystemHeader";
import { supabase } from "@/lib/supabase";

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  client_id: string;
};

type CompetencyRow = {
  master_competency_template_id: string;
  competency_name: string;
  competency_category: string | null;
  competency_is_critical: boolean;

  knowledge_score_percent: number;
  knowledge_level: number;
  required_level: number | null;
  knowledge_ready: boolean;

  practical_verification_required: boolean;
  practical_rating_level: number | null;
  practical_verification_status: string | null;
  practical_verified_at: string | null;

  practical_ready: boolean;
  competency_ready: boolean;
  readiness_status: string;

  reverification_period_months: number | null;
  practical_verification_expires_at: string | null;
  days_until_expiration: number | null;
  reverification_due: boolean;
  verification_expired: boolean;
  verification_currency_status: string;
};

type MasterCompetency = {
  id: string;
  description: string | null;
  verifier_type: string | null;
  evidence_requirements: string | null;
};

type CompetencyDisplay = CompetencyRow & {
  description: string | null;
  verifier_type: string | null;
  evidence_requirements: string | null;
};

type VerificationHistory = {
  verification_id: string;
  employee_id: string;
  client_id: string;

  employee_first_name: string;
  employee_last_name: string;
  employee_number: string | null;

  master_competency_template_id: string;
  competency_name: string;
  competency_category: string | null;
  competency_is_critical: boolean;

  rating_level: number;
  status: string;

  verifier_user_id: string | null;
  verifier_email: string | null;

  verifier_employee_id: string | null;
  verifier_first_name: string | null;
  verifier_last_name: string | null;

  verified_at: string | null;
  created_at: string;

  notes: string | null;
};

type DraftVerification = {
  ratingLevel: number;
  notes: string;
};

type FilterMode =
  | "needs_verification"
  | "reverification"
  | "verified"
  | "knowledge_gap"
  | "all";

export default function PracticalVerificationPage() {
  const params = useParams();
  const router = useRouter();

  const employeeId = params.id as string;

  const [employee, setEmployee] =
    useState<Employee | null>(null);

  const [competencies, setCompetencies] =
    useState<CompetencyDisplay[]>([]);

  const [history, setHistory] =
    useState<VerificationHistory[]>([]);

  const [drafts, setDrafts] =
    useState<
      Record<string, DraftVerification>
    >({});

  const [message, setMessage] =
    useState(
      "Loading practical verification..."
    );

  const [
    successMessage,
    setSuccessMessage,
  ] = useState("");

  const [savingId, setSavingId] =
    useState<string | null>(null);

  const [authorized, setAuthorized] =
    useState(false);

  const [filterMode, setFilterMode] =
    useState<FilterMode>(
      "needs_verification"
    );

  async function loadHistory() {
    const {
      data,
      error,
    } = await supabase.rpc(
      "wri_list_practical_verification_history",
      {
        p_employee_id: employeeId,
      }
    );

    if (error) {
      console.error(
        "Verification history failed:",
        error
      );
      return;
    }

    setHistory(
      (data ??
        []) as VerificationHistory[]
    );
  }

  async function loadCompetencies() {
    const {
      data: readinessData,
      error: readinessError,
    } = await supabase
      .from(
        "v_assessment_competency_readiness_current"
      )
      .select(`
        master_competency_template_id,
        competency_name,
        competency_category,
        competency_is_critical,
        knowledge_score_percent,
        knowledge_level,
        required_level,
        knowledge_ready,
        practical_verification_required,
        practical_rating_level,
        practical_verification_status,
        practical_verified_at,
        practical_ready,
        competency_ready,
        readiness_status,
        reverification_period_months,
        practical_verification_expires_at,
        days_until_expiration,
        reverification_due,
        verification_expired,
        verification_currency_status
      `)
      .eq("employee_id", employeeId)
      .order("competency_name", {
        ascending: true,
      });

    if (readinessError) {
      throw readinessError;
    }

    const competencyRows =
      (readinessData ??
        []) as CompetencyRow[];

    if (competencyRows.length === 0) {
      setCompetencies([]);
      return;
    }

    const masterIds =
      competencyRows.map(
        (row) =>
          row.master_competency_template_id
      );

    const {
      data: masterData,
      error: masterError,
    } = await supabase
      .from(
        "master_competency_templates"
      )
      .select(`
        id,
        description,
        verifier_type,
        evidence_requirements
      `)
      .in("id", masterIds);

    if (masterError) {
      throw masterError;
    }

    const masterMap =
      new Map<
        string,
        MasterCompetency
      >();

    (
      (masterData ??
        []) as MasterCompetency[]
    ).forEach((item) => {
      masterMap.set(
        item.id,
        item
      );
    });

    const combined:
      CompetencyDisplay[] =
      competencyRows.map(
        (row) => {
          const master =
            masterMap.get(
              row.master_competency_template_id
            );

          return {
            ...row,
            description:
              master?.description ??
              null,
            verifier_type:
              master?.verifier_type ??
              null,
            evidence_requirements:
              master?.evidence_requirements ??
              null,
          };
        }
      );

    setCompetencies(combined);

    setDrafts((current) => {
      const next = {
        ...current,
      };

      combined.forEach(
        (competency) => {
          const id =
            competency.master_competency_template_id;

          if (!next[id]) {
            next[id] = {
              ratingLevel:
                competency.practical_rating_level ??
                Math.min(
                  4,
                  Math.max(
                    1,
                    competency.required_level ??
                      1
                  )
                ),
              notes: "",
            };
          }
        }
      );

      return next;
    });
  }

  useEffect(() => {
    async function loadPage() {
      try {
        const {
          data: sessionData,
          error: sessionError,
        } =
          await supabase.auth.getSession();

        if (sessionError) {
          setMessage(
            sessionError.message
          );
          return;
        }

        if (!sessionData.session) {
          router.push("/");
          return;
        }

        const {
          data: employeeData,
          error: employeeError,
        } = await supabase
          .from("employees")
          .select(`
            id,
            first_name,
            last_name,
            employee_number,
            client_id
          `)
          .eq("id", employeeId)
          .maybeSingle();

        if (
          employeeError ||
          !employeeData
        ) {
          setMessage(
            "Employee not found."
          );
          return;
        }

        const {
          data: canVerify,
          error:
            verifyPermissionError,
        } = await supabase.rpc(
          "wri_can_verify_master_practical",
          {
            p_employee_id:
              employeeId,
          }
        );

        if (
          verifyPermissionError
        ) {
          setMessage(
            verifyPermissionError.message
          );
          return;
        }

        if (!canVerify) {
          setMessage(
            "You are not authorized to verify practical competencies for this employee."
          );
          return;
        }

        setEmployee(
          employeeData as Employee
        );

        setAuthorized(true);

        await Promise.all([
          loadCompetencies(),
          loadHistory(),
        ]);

        setMessage("");
      } catch (error) {
        setMessage(
          error instanceof Error
            ? error.message
            : "Unable to load practical verification."
        );
      }
    }

    loadPage();
  }, [employeeId, router]);

  const practicalCompetencies =
    useMemo(
      () =>
        competencies.filter(
          (competency) =>
            competency.practical_verification_required
        ),
      [competencies]
    );

  const verifiedCount =
    useMemo(
      () =>
        practicalCompetencies.filter(
          (competency) =>
            competency.practical_ready
        ).length,
      [practicalCompetencies]
    );

  const stillNeededCount =
    practicalCompetencies.length -
    verifiedCount;

  const knowledgeGapCount =
    useMemo(
      () =>
        practicalCompetencies.filter(
          (competency) =>
            !competency.knowledge_ready
        ).length,
      [practicalCompetencies]
    );

  const dueSoonCount =
    useMemo(
      () =>
        practicalCompetencies.filter(
          (competency) =>
            competency.reverification_due
        ).length,
      [practicalCompetencies]
    );

  const expiredCount =
    useMemo(
      () =>
        practicalCompetencies.filter(
          (competency) =>
            competency.verification_expired
        ).length,
      [practicalCompetencies]
    );

  const latestHistoryByCompetency =
    useMemo(() => {
      const map =
        new Map<
          string,
          VerificationHistory
        >();

      history.forEach(
        (item) => {
          if (
            !map.has(
              item.master_competency_template_id
            )
          ) {
            map.set(
              item.master_competency_template_id,
              item
            );
          }
        }
      );

      return map;
    }, [history]);

  const filteredCompetencies =
    useMemo(() => {
      switch (filterMode) {
        case "verified":
          return practicalCompetencies.filter(
            (competency) =>
              competency.practical_ready &&
              !competency.reverification_due
          );

        case "reverification":
          return practicalCompetencies.filter(
            (competency) =>
              competency.reverification_due ||
              competency.verification_expired
          );

        case "knowledge_gap":
          return practicalCompetencies.filter(
            (competency) =>
              !competency.knowledge_ready
          );

        case "needs_verification":
          return practicalCompetencies.filter(
            (competency) =>
              !competency.practical_ready
          );

        default:
          return practicalCompetencies;
      }
    }, [
      filterMode,
      practicalCompetencies,
    ]);

  function updateRating(
    competencyId: string,
    ratingLevel: number
  ) {
    setDrafts(
      (current) => ({
        ...current,
        [competencyId]: {
          ratingLevel,
          notes:
            current[
              competencyId
            ]?.notes ?? "",
        },
      })
    );
  }

  function updateNotes(
    competencyId: string,
    notes: string
  ) {
    setDrafts(
      (current) => ({
        ...current,
        [competencyId]: {
          ratingLevel:
            current[
              competencyId
            ]?.ratingLevel ??
            1,
          notes,
        },
      })
    );
  }

  async function saveVerification(
    competency: CompetencyDisplay
  ) {
    const competencyId =
      competency.master_competency_template_id;

    const draft =
      drafts[competencyId];

    if (!draft) {
      return;
    }

    setSavingId(competencyId);
    setMessage("");
    setSuccessMessage("");

    const { error } =
      await supabase.rpc(
        "wri_record_master_practical_verification",
        {
          p_employee_id:
            employeeId,
          p_master_competency_template_id:
            competencyId,
          p_rating_level:
            draft.ratingLevel,
          p_status: "verified",
          p_notes:
            draft.notes.trim()
              ? draft.notes.trim()
              : null,
        }
      );

    if (error) {
      setMessage(error.message);
      setSavingId(null);
      return;
    }

    const {
      data: linkedPlans,
      error: linkedPlansError,
    } = await supabase
      .from("development_plans")
      .select("id")
      .eq("employee_id", employeeId)
      .eq(
        "master_competency_template_id",
        competencyId
      );

    if (linkedPlansError) {
      console.error(
        "Unable to locate linked Development Plans:",
        linkedPlansError
      );
    } else if (linkedPlans && linkedPlans.length > 0) {
      const refreshResults = await Promise.all(
        linkedPlans.map((linkedPlan) =>
          supabase.rpc(
            "wri_refresh_development_plan_resolution",
            {
              p_development_plan_id:
                linkedPlan.id,
            }
          )
        )
      );

      refreshResults.forEach((result) => {
        if (result.error) {
          console.error(
            "Development Plan resolution refresh failed:",
            result.error
          );
        }
      });
    }

    setDrafts(
      (current) => ({
        ...current,
        [competencyId]: {
          ...current[
            competencyId
          ],
          notes: "",
        },
      })
    );

    try {
      await Promise.all([
        loadCompetencies(),
        loadHistory(),
      ]);

      setSuccessMessage(
        `${competency.competency_name} practical verification saved.`
      );
    } catch (refreshError) {
      console.error(
        "Refresh after verification failed:",
        refreshError
      );

      setSuccessMessage(
        `${competency.competency_name} practical verification saved. Refresh the page to see updated readiness.`
      );
    }

    setSavingId(null);
  }

  function readinessLabel(
    status: string
  ) {
    switch (status) {
      case "ready":
        return "Ready";

      case "developing":
        return "Knowledge Development Needed";

      case "critical_gap":
        return "Critical Knowledge Gap";

      case "practical_verification_needed":
        return "Practical Verification Needed";

      case "practical_development_needed":
        return "Practical Development Needed";

      case "reverification_required":
        return "Reverification Required";

      default:
        return status;
    }
  }

  function readinessClasses(
    status: string
  ) {
    switch (status) {
      case "ready":
        return "bg-emerald-500/15 text-emerald-300";

      case "critical_gap":
        return "bg-rose-500/15 text-rose-300";

      case "reverification_required":
        return "bg-orange-500/15 text-orange-300";

      case "developing":
      case "practical_development_needed":
      case "practical_verification_needed":
        return "bg-amber-500/15 text-amber-300";

      default:
        return "bg-slate-800 text-slate-300";
    }
  }

  function currencyLabel(
    status: string
  ) {
    switch (status) {
      case "current":
        return "Verification Current";

      case "due_soon":
        return "Reverification Due Soon";

      case "expired":
        return "Reverification Required";

      case "never_verified":
        return "Not Yet Verified";

      case "not_verified":
        return "Not Verified";

      default:
        return status;
    }
  }

  function currencyClasses(
    status: string
  ) {
    switch (status) {
      case "current":
        return "border-emerald-500/30 bg-emerald-500/10 text-emerald-200";

      case "due_soon":
        return "border-amber-500/30 bg-amber-500/10 text-amber-200";

      case "expired":
        return "border-rose-500/30 bg-rose-500/10 text-rose-200";

      default:
        return "border-slate-700 bg-slate-950/40 text-slate-300";
    }
  }

  function proficiencyLabel(
    level: number
  ) {
    switch (level) {
      case 1:
        return "Awareness";

      case 2:
        return "Working Knowledge";

      case 3:
        return "Proficient / Independent";

      case 4:
        return "Advanced / Can Lead or Coach";

      default:
        return "";
    }
  }

  function verifierName(
    item: VerificationHistory
  ) {
    const fullName = [
      item.verifier_first_name,
      item.verifier_last_name,
    ]
      .filter(Boolean)
      .join(" ");

    return (
      fullName ||
      item.verifier_email ||
      "Unknown verifier"
    );
  }

  function hasVerifierName(
    item: VerificationHistory
  ) {
    return Boolean(
      item.verifier_first_name ||
        item.verifier_last_name
    );
  }

  function formatDate(
    value: string | null
  ) {
    if (!value) {
      return "—";
    }

    return new Date(
      value
    ).toLocaleString();
  }

  function formatDateOnly(
    value: string | null
  ) {
    if (!value) {
      return "—";
    }

    return new Date(
      value
    ).toLocaleDateString();
  }

  if (
    !authorized ||
    !employee
  ) {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-6xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            {message ||
              "Loading practical verification..."}
          </div>

          <Link
            href="/dashboard"
            className="mt-6 inline-block text-sm font-medium text-cyan-400 hover:text-cyan-300"
          >
            ← Training System Home
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">

        {/* Header */}

        <SystemHeader
          title="Practical Verification"
          subtitle={`${employee.first_name} ${employee.last_name}${
            employee.employee_number
              ? ` · ${employee.employee_number}`
              : ""
          }`}
          backHref={`/employees/${employee.id}`}
          backLabel="Employee Profile"
          showHome={true}
          showSignOut={true}
        >
          <Link
            href="/verify"
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
          >
            Verify Employees
          </Link>
        </SystemHeader>

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

        {/* Progress */}

        <section className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
            <div>
              <h2 className="text-lg font-semibold">
                Verification Progress
              </h2>

              <p className="mt-2 text-sm text-slate-400">
                Practical readiness includes
                verification currency and
                expiration requirements.
              </p>
            </div>

            <div className="grid grid-cols-2 gap-3 sm:grid-cols-5">
              <StatCard
                label="Ready"
                value={verifiedCount}
                textClass="text-emerald-300"
              />

              <StatCard
                label="Still Needed"
                value={stillNeededCount}
                textClass="text-amber-300"
              />

              <StatCard
                label="Knowledge Gaps"
                value={knowledgeGapCount}
                textClass="text-rose-300"
              />

              <StatCard
                label="Reverify Soon"
                value={dueSoonCount}
                textClass="text-amber-300"
              />

              <StatCard
                label="Expired"
                value={expiredCount}
                textClass="text-rose-300"
              />
            </div>
          </div>

          <div className="mt-6 h-3 overflow-hidden rounded-full bg-slate-800">
            <div
              className="h-full rounded-full bg-emerald-400 transition-all"
              style={{
                width:
                  practicalCompetencies.length >
                  0
                    ? `${
                        (verifiedCount /
                          practicalCompetencies.length) *
                        100
                      }%`
                    : "0%",
              }}
            />
          </div>

          <div className="mt-6 grid gap-3 sm:grid-cols-4">
            {[1, 2, 3, 4].map(
              (level) => (
                <div
                  key={level}
                  className="rounded-xl bg-slate-950/50 p-4"
                >
                  <p className="font-semibold">
                    Level {level}
                  </p>

                  <p className="mt-1 text-xs text-slate-400">
                    {proficiencyLabel(
                      level
                    )}
                  </p>
                </div>
              )
            )}
          </div>
        </section>

        {/* Filters */}

        <div className="mb-6 flex flex-wrap gap-2">
          <FilterButton
            active={
              filterMode ===
              "needs_verification"
            }
            onClick={() =>
              setFilterMode(
                "needs_verification"
              )
            }
          >
            Needs Verification
          </FilterButton>

          <FilterButton
            active={
              filterMode ===
              "reverification"
            }
            onClick={() =>
              setFilterMode(
                "reverification"
              )
            }
          >
            Reverification
            {dueSoonCount +
              expiredCount >
              0
              ? ` (${
                  dueSoonCount +
                  expiredCount
                })`
              : ""}
          </FilterButton>

          <FilterButton
            active={
              filterMode ===
              "verified"
            }
            onClick={() =>
              setFilterMode(
                "verified"
              )
            }
          >
            Verified
          </FilterButton>

          <FilterButton
            active={
              filterMode ===
              "knowledge_gap"
            }
            onClick={() =>
              setFilterMode(
                "knowledge_gap"
              )
            }
          >
            Knowledge Gaps
          </FilterButton>

          <FilterButton
            active={
              filterMode === "all"
            }
            onClick={() =>
              setFilterMode("all")
            }
          >
            All
          </FilterButton>
        </div>

        {/* Competencies */}

        <div className="space-y-6">
          {filteredCompetencies.map(
            (competency) => {
              const competencyId =
                competency.master_competency_template_id;

              const draft =
                drafts[
                  competencyId
                ];

              const latestVerification =
                latestHistoryByCompetency.get(
                  competencyId
                );

              return (
                <section
                  key={competencyId}
                  className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8"
                >
                  <div className="flex flex-col gap-5 lg:flex-row lg:items-start lg:justify-between">
                    <div className="max-w-3xl">
                      <div className="flex flex-wrap items-center gap-2">
                        {competency.competency_category && (
                          <span className="rounded-full bg-slate-800 px-3 py-1 text-xs text-slate-300">
                            {
                              competency.competency_category
                            }
                          </span>
                        )}

                        {competency.competency_is_critical && (
                          <span className="rounded-full bg-rose-500/15 px-3 py-1 text-xs font-medium text-rose-300">
                            Critical
                          </span>
                        )}

                        <span
                          className={`rounded-full px-3 py-1 text-xs font-medium ${readinessClasses(
                            competency.readiness_status
                          )}`}
                        >
                          {readinessLabel(
                            competency.readiness_status
                          )}
                        </span>
                      </div>

                      <h2 className="mt-4 text-2xl font-semibold">
                        {
                          competency.competency_name
                        }
                      </h2>

                      {competency.description && (
                        <p className="mt-3 leading-7 text-slate-400">
                          {
                            competency.description
                          }
                        </p>
                      )}
                    </div>

                    <div className="grid min-w-[260px] grid-cols-2 gap-3">
                      <div className="rounded-xl bg-slate-950/60 p-4">
                        <p className="text-xs text-slate-500">
                          Knowledge
                        </p>

                        <p className="mt-1 text-xl font-semibold">
                          {
                            competency.knowledge_score_percent
                          }
                          %
                        </p>

                        <p className="mt-1 text-xs text-slate-400">
                          Level{" "}
                          {
                            competency.knowledge_level
                          }
                        </p>
                      </div>

                      <div className="rounded-xl bg-slate-950/60 p-4">
                        <p className="text-xs text-slate-500">
                          Required
                        </p>

                        <p className="mt-1 text-xl font-semibold">
                          {competency.required_level ??
                            "—"}
                        </p>
                      </div>
                    </div>
                  </div>

                  {/* Requirements */}

                  {(competency.verifier_type ||
                    competency.evidence_requirements ||
                    competency.reverification_period_months) && (
                    <div className="mt-6 grid gap-4 md:grid-cols-3">
                      {competency.verifier_type && (
                        <InfoCard
                          label="Verifier Type"
                          value={
                            competency.verifier_type
                          }
                        />
                      )}

                      {competency.evidence_requirements && (
                        <InfoCard
                          label="Evidence"
                          value={
                            competency.evidence_requirements
                          }
                        />
                      )}

                      {competency.reverification_period_months && (
                        <InfoCard
                          label="Reverification"
                          value={`Every ${competency.reverification_period_months} months`}
                        />
                      )}
                    </div>
                  )}

                  {/* Currency */}

                  {competency.practical_verification_status ===
                    "verified" && (
                    <div
                      className={`mt-6 rounded-xl border p-5 ${currencyClasses(
                        competency.verification_currency_status
                      )}`}
                    >
                      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                        <div>
                          <p className="text-xs font-semibold uppercase tracking-wide opacity-70">
                            Verification Currency
                          </p>

                          <p className="mt-1 text-lg font-semibold">
                            {currencyLabel(
                              competency.verification_currency_status
                            )}
                          </p>
                        </div>

                        {competency.practical_verification_expires_at && (
                          <div className="grid gap-3 text-sm sm:grid-cols-2">
                            <div>
                              <p className="text-xs opacity-70">
                                Expires
                              </p>

                              <p className="mt-1 font-medium">
                                {formatDateOnly(
                                  competency.practical_verification_expires_at
                                )}
                              </p>
                            </div>

                            <div>
                              <p className="text-xs opacity-70">
                                Days Remaining
                              </p>

                              <p className="mt-1 font-medium">
                                {competency.days_until_expiration ??
                                  "—"}
                              </p>
                            </div>
                          </div>
                        )}
                      </div>

                      {competency.reverification_due && (
                        <p className="mt-3 text-sm">
                          This verification is
                          still valid, but
                          reverification should
                          be scheduled.
                        </p>
                      )}

                      {competency.verification_expired && (
                        <p className="mt-3 text-sm font-medium">
                          This competency no
                          longer counts as
                          practically ready until
                          a new verification is
                          completed.
                        </p>
                      )}
                    </div>
                  )}

                  {/* Latest history */}

                  <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/40 p-5">
                    <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                      Latest Practical Verification
                    </p>

                    {!latestVerification ? (
                      <div className="mt-3">
                        <p className="font-medium text-slate-300">
                          No previous practical
                          verification recorded.
                        </p>

                        <p className="mt-1 text-sm text-slate-400">
                          This will be the first
                          verification event for
                          this competency.
                        </p>
                      </div>
                    ) : (
                      <div className="mt-4 grid gap-4 lg:grid-cols-[180px_1fr_1fr]">
                        <div>
                          <p className="text-xs text-slate-500">
                            Rating
                          </p>

                          <p className="mt-1 text-xl font-semibold text-emerald-300">
                            Level{" "}
                            {
                              latestVerification.rating_level
                            }
                          </p>

                          <p className="mt-1 text-xs text-slate-400">
                            {proficiencyLabel(
                              latestVerification.rating_level
                            )}
                          </p>
                        </div>

                        <div>
                          <p className="text-xs text-slate-500">
                            Verified By
                          </p>

                          <p className="mt-1 font-medium text-slate-300">
                            {verifierName(
                              latestVerification
                            )}
                          </p>

                          {latestVerification.verifier_email &&
                            hasVerifierName(
                              latestVerification
                            ) && (
                              <p className="mt-1 text-xs text-slate-500">
                                {
                                  latestVerification.verifier_email
                                }
                              </p>
                            )}

                          <p className="mt-2 text-xs text-slate-400">
                            {formatDate(
                              latestVerification.verified_at ??
                                latestVerification.created_at
                            )}
                          </p>
                        </div>

                        <div>
                          <p className="text-xs text-slate-500">
                            Previous Notes
                          </p>

                          <p className="mt-1 whitespace-pre-wrap text-sm leading-6 text-slate-300">
                            {latestVerification.notes ||
                              "No notes were recorded for this verification."}
                          </p>
                        </div>
                      </div>
                    )}
                  </div>

                  {/* Rating */}

                  <div className="mt-7 border-t border-slate-800 pt-6">
                    <p className="text-sm font-medium text-slate-300">
                      Practical Rating
                    </p>

                    <div className="mt-3 grid gap-3 sm:grid-cols-4">
                      {[1, 2, 3, 4].map(
                        (level) => {
                          const selected =
                            draft?.ratingLevel ===
                            level;

                          return (
                            <button
                              key={level}
                              type="button"
                              onClick={() =>
                                updateRating(
                                  competencyId,
                                  level
                                )
                              }
                              className={`rounded-xl border p-4 text-left transition ${
                                selected
                                  ? "border-cyan-400 bg-cyan-400/10"
                                  : "border-slate-700 bg-slate-950/40 hover:border-slate-500"
                              }`}
                            >
                              <p className="font-semibold">
                                Level {level}
                              </p>

                              <p className="mt-1 text-xs text-slate-400">
                                {proficiencyLabel(
                                  level
                                )}
                              </p>
                            </button>
                          );
                        }
                      )}
                    </div>

                    <div className="mt-5">
                      <label className="mb-2 block text-sm text-slate-300">
                        Verification Notes
                      </label>

                      <textarea
                        value={
                          draft?.notes ??
                          ""
                        }
                        onChange={(
                          event
                        ) =>
                          updateNotes(
                            competencyId,
                            event.target.value
                          )
                        }
                        rows={4}
                        placeholder="Describe what was observed, demonstrated, or reviewed..."
                        className="w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none transition focus:border-cyan-400"
                      />
                    </div>

                    <div className="mt-5 flex flex-wrap items-center justify-between gap-3">
                      <p className="text-xs text-slate-500">
                        Saving creates a new
                        verification history
                        record. Existing history
                        is preserved.
                      </p>

                      <button
                        type="button"
                        onClick={() =>
                          saveVerification(
                            competency
                          )
                        }
                        disabled={
                          savingId ===
                          competencyId
                        }
                        className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
                      >
                        {savingId ===
                        competencyId
                          ? "Saving..."
                          : competency.verification_expired
                          ? "Complete Reverification"
                          : latestVerification
                          ? "Add New Verification"
                          : "Verify Competency"}
                      </button>
                    </div>
                  </div>
                </section>
              );
            }
          )}

          {filteredCompetencies.length ===
            0 && (
            <div className="rounded-xl border border-slate-800 bg-slate-900 p-8 text-center text-slate-400">
              No competencies match this
              filter.
            </div>
          )}
        </div>
      </div>
    </main>
  );
}

function StatCard({
  label,
  value,
  textClass,
}: {
  label: string;
  value: number;
  textClass: string;
}) {
  return (
    <div className="rounded-xl bg-slate-950/60 px-5 py-4">
      <p className="text-xs text-slate-500">
        {label}
      </p>

      <p
        className={`mt-1 text-2xl font-semibold ${textClass}`}
      >
        {value}
      </p>
    </div>
  );
}

function InfoCard({
  label,
  value,
}: {
  label: string;
  value: string;
}) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950/40 p-4">
      <p className="text-xs uppercase tracking-wide text-slate-500">
        {label}
      </p>

      <p className="mt-2 text-sm text-slate-300">
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
          : "border border-slate-700 text-slate-300 hover:bg-slate-100 hover:text-slate-900"
      }`}
    >
      {children}
    </button>
  );
}