"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type Attempt = {
  id: string;
  status: string;
  employee_id: string;
  assessment_id: string;
  completed_at: string | null;
};

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
};

type Assessment = {
  id: string;
  name: string;
};

type CompetencyScoreRow = {
  id: string;
  score_percent: number;
  estimated_level: number;
  required_level: number | null;
  gap: number | null;
  status: string;
  master_competency_template_id: string | null;
};

type MasterCompetency = {
  id: string;
  name: string;
  category: string | null;
};

type Question = {
  id: string;
  domain: string | null;
  critical_safety: boolean;
};

type Answer = {
  question_id: string;
  is_correct: boolean | null;
};

type CompetencyResult = {
  id: string;
  name: string;
  category: string | null;
  score_percent: number;
  estimated_level: number;
  required_level: number | null;
  gap: number | null;
  status: string;
};

type DomainResult = {
  domain: string;
  correct: number;
  total: number;
  score_percent: number;
};

export default function AssessmentResultsPage() {
  const params = useParams();
  const router = useRouter();

  const attemptId = params.attemptId as string;

  const [attempt, setAttempt] = useState<Attempt | null>(null);
  const [employee, setEmployee] = useState<Employee | null>(null);
  const [assessment, setAssessment] = useState<Assessment | null>(null);

  const [competencies, setCompetencies] = useState<CompetencyResult[]>([]);
  const [domainResults, setDomainResults] = useState<DomainResult[]>([]);

  const [overallScore, setOverallScore] = useState(0);
  const [safetyScore, setSafetyScore] = useState<number | null>(null);

  const [message, setMessage] = useState("Loading results...");

  useEffect(() => {
    async function loadResults() {
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

      const {
        data: attemptData,
        error: attemptError,
      } = await supabase
        .from("assessment_attempts")
        .select(`
          id,
          status,
          employee_id,
          assessment_id,
          completed_at
        `)
        .eq("id", attemptId)
        .maybeSingle();

      if (attemptError) {
        setMessage(attemptError.message);
        return;
      }

      if (!attemptData) {
        setMessage("Assessment attempt not found.");
        return;
      }

      if (attemptData.status !== "completed") {
        router.push(`/assessments/attempts/${attemptId}`);
        return;
      }

      setAttempt(attemptData);

      const [
        employeeResponse,
        assessmentResponse,
        scoreResponse,
        selectionResponse,
        answerResponse,
      ] = await Promise.all([
        supabase
          .from("employees")
          .select(`
            id,
            first_name,
            last_name
          `)
          .eq("id", attemptData.employee_id)
          .maybeSingle(),

        supabase
          .from("assessments")
          .select(`
            id,
            name
          `)
          .eq("id", attemptData.assessment_id)
          .maybeSingle(),

        supabase
          .from("competency_scores")
          .select(`
            id,
            score_percent,
            estimated_level,
            required_level,
            gap,
            status,
            master_competency_template_id
          `)
          .eq("attempt_id", attemptId),

        supabase
          .from("attempt_question_selections")
          .select(`
            question_id,
            assessment_questions (
              id,
              domain,
              critical_safety
            )
          `)
          .eq("attempt_id", attemptId),

        supabase
          .from("attempt_answers")
          .select(`
            question_id,
            is_correct
          `)
          .eq("attempt_id", attemptId),
      ]);

      if (employeeResponse.error) {
        setMessage(employeeResponse.error.message);
        return;
      }

      if (assessmentResponse.error) {
        setMessage(assessmentResponse.error.message);
        return;
      }

      if (scoreResponse.error) {
        setMessage(scoreResponse.error.message);
        return;
      }

      if (selectionResponse.error) {
        setMessage(selectionResponse.error.message);
        return;
      }

      if (answerResponse.error) {
        setMessage(answerResponse.error.message);
        return;
      }

      setEmployee(employeeResponse.data);
      setAssessment(assessmentResponse.data);

      const scoreRows =
        (scoreResponse.data ?? []) as CompetencyScoreRow[];

      const masterIds = scoreRows
        .map((row) => row.master_competency_template_id)
        .filter(
          (value): value is string => Boolean(value)
        );

      let masterCompetencyMap =
        new Map<string, MasterCompetency>();

      if (masterIds.length > 0) {
        const {
          data: masterCompetencyData,
          error: masterCompetencyError,
        } = await supabase
          .from("master_competency_templates")
          .select(`
            id,
            name,
            category
          `)
          .in("id", masterIds);

        if (masterCompetencyError) {
          setMessage(masterCompetencyError.message);
          return;
        }

        masterCompetencyMap = new Map(
          (masterCompetencyData ?? []).map(
            (item: MasterCompetency) => [
              item.id,
              item,
            ]
          )
        );
      }

      const normalizedCompetencies: CompetencyResult[] =
        scoreRows
          .map((row) => {
            if (!row.master_competency_template_id) {
              return null;
            }

            const competency =
              masterCompetencyMap.get(
                row.master_competency_template_id
              );

            if (!competency) {
              return null;
            }

            return {
              id: row.id,
              name: competency.name,
              category: competency.category,
              score_percent: Number(row.score_percent),
              estimated_level: row.estimated_level,
              required_level: row.required_level,
              gap: row.gap,
              status: row.status,
            };
          })
          .filter(
            (
              item
            ): item is CompetencyResult =>
              item !== null
          )
          .sort(
            (a, b) =>
              a.score_percent - b.score_percent
          );

      setCompetencies(normalizedCompetencies);

      const answerMap = new Map<string, boolean>();

      ((answerResponse.data ?? []) as Answer[]).forEach(
        (answer) => {
          answerMap.set(
            answer.question_id,
            answer.is_correct === true
          );
        }
      );

      const domainMap = new Map<
        string,
        {
          correct: number;
          total: number;
        }
      >();

      let totalCorrect = 0;
      let totalQuestions = 0;

      let criticalSafetyCorrect = 0;
      let criticalSafetyTotal = 0;

      (selectionResponse.data ?? []).forEach(
        (row) => {
          const rawQuestion = Array.isArray(
            row.assessment_questions
          )
            ? row.assessment_questions[0]
            : row.assessment_questions;

          if (!rawQuestion) {
            return;
          }

          const question = rawQuestion as Question;

          const domain =
            question.domain ?? "Other";

          const correct =
            answerMap.get(question.id) === true;

          const current =
            domainMap.get(domain) ?? {
              correct: 0,
              total: 0,
            };

          current.total += 1;

          if (correct) {
            current.correct += 1;
            totalCorrect += 1;
          }

          totalQuestions += 1;

          if (question.critical_safety) {
            criticalSafetyTotal += 1;

            if (correct) {
              criticalSafetyCorrect += 1;
            }
          }

          domainMap.set(domain, current);
        }
      );

      const normalizedDomains: DomainResult[] =
        Array.from(domainMap.entries())
          .map(([domain, values]) => ({
            domain,
            correct: values.correct,
            total: values.total,
            score_percent:
              values.total > 0
                ? Math.round(
                    (values.correct / values.total) *
                      100
                  )
                : 0,
          }))
          .sort(
            (a, b) =>
              a.score_percent - b.score_percent
          );

      setDomainResults(normalizedDomains);

      setOverallScore(
        totalQuestions > 0
          ? Math.round(
              (totalCorrect / totalQuestions) *
                100
            )
          : 0
      );

      setSafetyScore(
        criticalSafetyTotal > 0
          ? Math.round(
              (criticalSafetyCorrect /
                criticalSafetyTotal) *
                100
            )
          : null
      );

      setMessage("");
    }

    loadResults();
  }, [attemptId, router]);

  const criticalGapCount = useMemo(
    () =>
      competencies.filter(
        (competency) =>
          competency.status === "critical_gap"
      ).length,
    [competencies]
  );

  const developingCount = useMemo(
    () =>
      competencies.filter(
        (competency) =>
          competency.status === "developing"
      ).length,
    [competencies]
  );

  const readinessLabel = useMemo(() => {
    if (
      safetyScore !== null &&
      safetyScore < 80
    ) {
      return "Critical Development Required — Safety";
    }

    if (overallScore >= 90) {
      return "Advanced Foundational Knowledge";
    }

    if (overallScore >= 80) {
      return "Strong Foundational Knowledge";
    }

    if (overallScore >= 70) {
      return "Developing";
    }

    return "Significant Development Needed";
  }, [overallScore, safetyScore]);

  function statusClasses(status: string) {
    if (status === "ready") {
      return "bg-emerald-500/15 text-emerald-300";
    }

    if (status === "developing") {
      return "bg-amber-500/15 text-amber-300";
    }

    if (status === "critical_gap") {
      return "bg-rose-500/15 text-rose-300";
    }

    return "bg-slate-800 text-slate-300";
  }

  function statusLabel(status: string) {
    if (status === "ready") {
      return "Ready";
    }

    if (status === "developing") {
      return "Developing";
    }

    if (status === "critical_gap") {
      return "Critical Gap";
    }

    return "Not Assessed";
  }

  if (!attempt || !employee || !assessment) {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-5xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            {message || "Loading results..."}
          </div>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-6xl">
        <div className="mb-10">
          <p className="text-sm font-medium text-cyan-400">
            IntegrateU Assessment Results
          </p>

          <h1 className="mt-2 text-3xl font-semibold">
            {assessment.name}
          </h1>

          <p className="mt-2 text-slate-400">
            {employee.first_name}{" "}
            {employee.last_name}
          </p>
        </div>

        {message && (
          <div className="mb-6 rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        <section className="grid gap-6 lg:grid-cols-3">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 lg:col-span-2">
            <p className="text-sm text-slate-400">
              Overall Knowledge Score
            </p>

            <div className="mt-3 flex flex-wrap items-end gap-5">
              <p className="text-6xl font-bold">
                {overallScore}%
              </p>

              <div>
                <p className="text-lg font-semibold">
                  {readinessLabel}
                </p>

                <p className="mt-1 text-sm text-slate-400">
                  Knowledge assessment result
                </p>
              </div>
            </div>

            <div className="mt-6 h-3 overflow-hidden rounded-full bg-slate-800">
              <div
                className="h-full rounded-full bg-cyan-400"
                style={{
                  width: `${Math.min(
                    100,
                    Math.max(0, overallScore)
                  )}%`,
                }}
              />
            </div>

            <div className="mt-8 grid gap-4 sm:grid-cols-3">
              <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                <p className="text-sm text-slate-400">
                  Safety
                </p>

                <p className="mt-1 text-2xl font-semibold">
                  {safetyScore !== null
                    ? `${safetyScore}%`
                    : "—"}
                </p>
              </div>

              <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                <p className="text-sm text-slate-400">
                  Developing
                </p>

                <p className="mt-1 text-2xl font-semibold text-amber-300">
                  {developingCount}
                </p>
              </div>

              <div className="rounded-xl border border-slate-800 bg-slate-950/60 p-5">
                <p className="text-sm text-slate-400">
                  Critical Gaps
                </p>

                <p className="mt-1 text-2xl font-semibold text-rose-300">
                  {criticalGapCount}
                </p>
              </div>
            </div>

            {safetyScore !== null &&
              safetyScore < 80 && (
                <div className="mt-6 rounded-xl border border-rose-500/30 bg-rose-500/10 p-5">
                  <p className="font-semibold text-rose-200">
                    Critical Safety Development Required
                  </p>

                  <p className="mt-2 text-sm text-rose-100/80">
                    The safety result is below the
                    required 80% knowledge threshold.
                    Overall assessment performance does
                    not override a critical safety gap.
                  </p>
                </div>
              )}
          </div>

          <aside className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
            <p className="text-sm font-medium text-slate-300">
              Proficiency Scale
            </p>

            <div className="mt-5 space-y-4 text-sm">
              <div>
                <p className="font-semibold">
                  Level 1
                </p>
                <p className="text-slate-400">
                  Awareness
                </p>
              </div>

              <div>
                <p className="font-semibold">
                  Level 2
                </p>
                <p className="text-slate-400">
                  Working Knowledge
                </p>
              </div>

              <div>
                <p className="font-semibold">
                  Level 3
                </p>
                <p className="text-slate-400">
                  Proficient / Independent
                </p>
              </div>

              <div>
                <p className="font-semibold">
                  Level 4
                </p>
                <p className="text-slate-400">
                  Advanced / Can Lead or Coach
                </p>
              </div>
            </div>

            <div className="mt-6 rounded-xl border border-amber-500/20 bg-amber-500/10 p-4">
              <p className="text-sm text-amber-200">
                Knowledge results do not replace
                practical field verification where
                practical demonstration is required.
              </p>
            </div>
          </aside>
        </section>

        <section className="mt-8">
          <div className="mb-5">
            <h2 className="text-2xl font-semibold">
              Domain Performance
            </h2>

            <p className="mt-1 text-sm text-slate-400">
              Your performance across the major
              assessment areas.
            </p>
          </div>

          <div className="grid gap-4 md:grid-cols-2">
            {domainResults.map((domain) => (
              <div
                key={domain.domain}
                className="rounded-xl border border-slate-800 bg-slate-900 p-5"
              >
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <p className="font-medium">
                      {domain.domain}
                    </p>

                    <p className="mt-1 text-sm text-slate-400">
                      {domain.correct}/{domain.total} correct
                    </p>
                  </div>

                  <p className="text-2xl font-semibold">
                    {domain.score_percent}%
                  </p>
                </div>

                <div className="mt-4 h-2 overflow-hidden rounded-full bg-slate-800">
                  <div
                    className="h-full rounded-full bg-cyan-400"
                    style={{
                      width: `${Math.min(
                        100,
                        Math.max(
                          0,
                          domain.score_percent
                        )
                      )}%`,
                    }}
                  />
                </div>
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10">
          <div className="mb-5">
            <h2 className="text-2xl font-semibold">
              Competency Results
            </h2>

            <p className="mt-1 text-sm text-slate-400">
              Results mapped to the IntegrateU master
              competency standard.
            </p>
          </div>

          <div className="space-y-4">
            {competencies.map((competency) => (
              <div
                key={competency.id}
                className="rounded-xl border border-slate-800 bg-slate-900 p-6"
              >
                <div className="flex flex-col gap-5 md:flex-row md:items-center md:justify-between">
                  <div>
                    <p className="text-lg font-semibold">
                      {competency.name}
                    </p>

                    {competency.category && (
                      <p className="mt-1 text-sm text-slate-400">
                        {competency.category}
                      </p>
                    )}
                  </div>

                  <div className="flex flex-wrap items-center gap-3">
                    <span
                      className={`rounded-full px-3 py-1 text-sm ${statusClasses(
                        competency.status
                      )}`}
                    >
                      {statusLabel(
                        competency.status
                      )}
                    </span>

                    <span className="text-2xl font-semibold">
                      {competency.score_percent}%
                    </span>
                  </div>
                </div>

                <div className="mt-5 grid gap-4 sm:grid-cols-3">
                  <div className="rounded-lg bg-slate-950/60 p-4">
                    <p className="text-xs uppercase tracking-wide text-slate-500">
                      Estimated Level
                    </p>

                    <p className="mt-1 text-xl font-semibold">
                      {competency.estimated_level}
                    </p>
                  </div>

                  <div className="rounded-lg bg-slate-950/60 p-4">
                    <p className="text-xs uppercase tracking-wide text-slate-500">
                      Required Level
                    </p>

                    <p className="mt-1 text-xl font-semibold">
                      {competency.required_level ??
                        "—"}
                    </p>
                  </div>

                  <div className="rounded-lg bg-slate-950/60 p-4">
                    <p className="text-xs uppercase tracking-wide text-slate-500">
                      Gap
                    </p>

                    <p className="mt-1 text-xl font-semibold">
                      {competency.gap ?? "—"}
                    </p>
                  </div>
                </div>
              </div>
            ))}

            {competencies.length === 0 && (
              <div className="rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-400">
                No competency results were generated for
                this attempt.
              </div>
            )}
          </div>
        </section>

        <div className="mt-10 flex flex-wrap gap-3">
          <button
            type="button"
            onClick={() =>
              router.push("/assessments")
            }
            className="rounded-lg bg-cyan-400 px-5 py-3 font-semibold text-slate-950 transition hover:bg-cyan-300"
          >
            Back to Assessments
          </button>

          <button
            type="button"
            onClick={() =>
              router.push("/dashboard")
            }
            className="rounded-lg border border-slate-700 px-5 py-3 font-medium text-slate-300 transition hover:bg-slate-800"
          >
            Dashboard
          </button>
        </div>
      </div>
    </main>
  );
}