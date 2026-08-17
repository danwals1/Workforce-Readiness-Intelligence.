"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

type Option = {
  key: string;
  text: string;
};

type Question = {
  id: string;
  question_order: number;
  type: string;
  prompt: string;
  scenario: string | null;
  options: Option[];
  domain: string | null;
  difficulty: string | null;
};

type SavedAnswer = {
  question_id: string;
  response: unknown;
};

export default function AssessmentAttemptPage() {
  const params = useParams();
  const router = useRouter();

  const attemptId = params.attemptId as string;

  const [questions, setQuestions] = useState<Question[]>([]);
  const [answers, setAnswers] = useState<Record<string, string[]>>({});
  const [currentIndex, setCurrentIndex] = useState(0);

  const [message, setMessage] = useState("Loading assessment...");
  const [saving, setSaving] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  const currentQuestion = questions[currentIndex] ?? null;

  const answeredCount = useMemo(() => {
    return questions.filter((question) => {
      const answer = answers[question.id];
      return Array.isArray(answer) && answer.length > 0;
    }).length;
  }, [questions, answers]);

  const progressPercent =
    questions.length > 0
      ? Math.round((answeredCount / questions.length) * 100)
      : 0;

  useEffect(() => {
    async function loadAttempt() {
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
          assessment_id
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

      if (attemptData.status === "completed") {
        router.push(
          `/assessments/attempts/${attemptId}/results`
        );
        return;
      }

      const {
        data: selectionData,
        error: selectionError,
      } = await supabase
        .from("attempt_question_selections")
        .select(`
          question_order,
          question_id,
          assessment_questions (
            id,
            type,
            prompt,
            scenario,
            options,
            domain,
            difficulty
          )
        `)
        .eq("attempt_id", attemptId)
        .order("question_order", { ascending: true });

      if (selectionError) {
        setMessage(selectionError.message);
        return;
      }

      const normalizedQuestions: Question[] =
        (selectionData ?? [])
          .map((row) => {
            const rawQuestion = Array.isArray(
              row.assessment_questions
            )
              ? row.assessment_questions[0]
              : row.assessment_questions;

            if (!rawQuestion) {
              return null;
            }

            const rawOptions = Array.isArray(
              rawQuestion.options
            )
              ? rawQuestion.options
              : [];

            const normalizedOptions: Option[] =
              rawOptions
                .map((option) => {
                  if (
                    typeof option === "object" &&
                    option !== null
                  ) {
                    const raw =
                      option as Record<string, unknown>;

                    const key =
                      raw.id ??
                      raw.key ??
                      raw.value;

                    const text =
                      raw.label ??
                      raw.text ??
                      raw.name;

                    if (
                      key !== undefined &&
                      text !== undefined
                    ) {
                      return {
                        key: String(key),
                        text: String(text),
                      };
                    }
                  }

                  if (typeof option === "string") {
                    return {
                      key: option,
                      text: option,
                    };
                  }

                  return null;
                })
                .filter(
                  (option): option is Option =>
                    option !== null
                );

            return {
              id: rawQuestion.id,
              question_order: row.question_order,
              type: rawQuestion.type,
              prompt: rawQuestion.prompt,
              scenario: rawQuestion.scenario,
              options: normalizedOptions,
              domain: rawQuestion.domain,
              difficulty: rawQuestion.difficulty,
            };
          })
          .filter(
            (question): question is Question =>
              question !== null
          );

      if (normalizedQuestions.length === 0) {
        setMessage(
          "This assessment attempt does not contain any questions."
        );
        return;
      }

      setQuestions(normalizedQuestions);

      const {
        data: answerData,
        error: answerError,
      } = await supabase
        .from("attempt_answers")
        .select(`
          question_id,
          response
        `)
        .eq("attempt_id", attemptId);

      if (answerError) {
        setMessage(answerError.message);
        return;
      }

      const existingAnswers: Record<string, string[]> = {};

      (answerData as SavedAnswer[] | null)?.forEach(
        (answer) => {
          if (Array.isArray(answer.response)) {
            existingAnswers[answer.question_id] =
              answer.response.map(String);
          } else if (
            typeof answer.response === "string"
          ) {
            existingAnswers[answer.question_id] = [
              answer.response,
            ];
          }
        }
      );

      setAnswers(existingAnswers);

      const firstUnansweredIndex =
        normalizedQuestions.findIndex(
          (question) =>
            !existingAnswers[question.id] ||
            existingAnswers[question.id].length === 0
        );

      if (firstUnansweredIndex >= 0) {
        setCurrentIndex(firstUnansweredIndex);
      }

      setMessage("");
    }

    loadAttempt();
  }, [attemptId, router]);

  async function saveAnswer(
    questionId: string,
    nextAnswer: string[]
  ) {
    setAnswers((current) => ({
      ...current,
      [questionId]: nextAnswer,
    }));

    setSaving(true);
    setMessage("");

    const {
      data: attemptData,
      error: attemptError,
    } = await supabase
      .from("assessment_attempts")
      .select("client_id")
      .eq("id", attemptId)
      .maybeSingle();

    if (attemptError || !attemptData) {
      setMessage(
        attemptError?.message ??
          "Unable to load assessment attempt."
      );
      setSaving(false);
      return;
    }

    const { error } = await supabase
      .from("attempt_answers")
      .upsert(
        {
          client_id: attemptData.client_id,
          attempt_id: attemptId,
          question_id: questionId,
          response: nextAnswer,
          answered_at: new Date().toISOString(),
        },
        {
          onConflict: "attempt_id,question_id",
        }
      );

    if (error) {
      setMessage(error.message);
    }

    setSaving(false);
  }

  function handleSingleAnswer(
    questionId: string,
    value: string
  ) {
    void saveAnswer(questionId, [value]);
  }

  function handleMultipleAnswer(
    questionId: string,
    value: string
  ) {
    const current = answers[questionId] ?? [];

    const next = current.includes(value)
      ? current.filter((item) => item !== value)
      : [...current, value];

    void saveAnswer(questionId, next);
  }

  function goBack() {
    setCurrentIndex((current) =>
      Math.max(0, current - 1)
    );
  }

  function goNext() {
    setCurrentIndex((current) =>
      Math.min(
        questions.length - 1,
        current + 1
      )
    );
  }

  async function submitAssessment() {
    if (questions.length === 0) {
      return;
    }

    const unanswered = questions.filter(
      (question) =>
        !answers[question.id] ||
        answers[question.id].length === 0
    );

    if (unanswered.length > 0) {
      setMessage(
        `Please answer all questions before submitting. ${unanswered.length} question${
          unanswered.length === 1 ? "" : "s"
        } remaining.`
      );

      const firstUnansweredIndex =
        questions.findIndex(
          (question) =>
            !answers[question.id] ||
            answers[question.id].length === 0
        );

      if (firstUnansweredIndex >= 0) {
        setCurrentIndex(firstUnansweredIndex);
      }

      return;
    }

    setSubmitting(true);
    setMessage("");

    const {
      error,
    } = await supabase.rpc(
      "wri_score_attempt",
      {
        p_attempt_id: attemptId,
      }
    );

    if (error) {
      setMessage(error.message);
      setSubmitting(false);
      return;
    }

    router.push(
      `/assessments/attempts/${attemptId}/results`
    );
  }

  if (!currentQuestion) {
    return (
      <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
        <div className="mx-auto max-w-4xl">
          <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8 text-slate-300">
            {message || "Loading assessment..."}
          </div>
        </div>
      </main>
    );
  }

  const selectedAnswers =
    answers[currentQuestion.id] ?? [];

  const isMultipleSelect =
    currentQuestion.type === "multiple_select";

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-8 text-white">
      <div className="mx-auto max-w-4xl">
        <div className="mb-8">
  <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
    <button
      type="button"
      onClick={() =>
        router.push("/assessments")
      }
      className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900"
    >
      ← Assessments
    </button>

    <button
      type="button"
      onClick={() =>
        router.push("/dashboard")
      }
      className="text-sm text-slate-400 transition hover:text-white"
    >
      RISE Home
    </button>
  </div>

  <div className="flex flex-col gap-5 sm:flex-row sm:items-end sm:justify-between">
            <div>
              <p className="text-sm font-medium text-cyan-400">
                RISE
              </p>

              <h1 className="mt-2 text-2xl font-semibold">
                Technician I — Entry Level
              </h1>

              <p className="mt-2 text-sm text-slate-400">
                Question {currentIndex + 1} of{" "}
                {questions.length}
              </p>
            </div>

            <div className="text-left sm:text-right">
              <p className="text-sm text-slate-400">
                Completed
              </p>

              <p className="text-xl font-semibold">
                {answeredCount}/{questions.length}
              </p>
            </div>
          </div>

          <div className="mt-5 h-2 overflow-hidden rounded-full bg-slate-800">
            <div
              className="h-full rounded-full bg-cyan-400 transition-all"
              style={{
                width: `${progressPercent}%`,
              }}
            />
          </div>
        </div>

        {message && (
          <div className="mb-6 rounded-xl border border-amber-500/30 bg-amber-500/10 p-4 text-sm text-amber-200">
            {message}
          </div>
        )}

        <section className="rounded-2xl border border-slate-800 bg-slate-900 p-6 sm:p-8">
          <div className="mb-6 flex flex-wrap gap-2">
            {currentQuestion.domain && (
              <span className="rounded-full bg-cyan-500/10 px-3 py-1 text-xs font-medium text-cyan-300">
                {currentQuestion.domain}
              </span>
            )}

            {currentQuestion.difficulty && (
              <span className="rounded-full bg-slate-800 px-3 py-1 text-xs capitalize text-slate-300">
                {currentQuestion.difficulty}
              </span>
            )}

            {isMultipleSelect && (
              <span className="rounded-full bg-violet-500/10 px-3 py-1 text-xs text-violet-300">
                Select all that apply
              </span>
            )}
          </div>

          {currentQuestion.scenario && (
            <div className="mb-6 rounded-xl border border-slate-700 bg-slate-950/60 p-5 text-slate-300">
              {currentQuestion.scenario}
            </div>
          )}

          <h2 className="text-xl font-semibold leading-relaxed sm:text-2xl">
            {currentQuestion.prompt}
          </h2>

          <div className="mt-8 space-y-3">
            {currentQuestion.options.map((option) => {
              const selected =
                selectedAnswers.includes(option.key);

              return (
                <button
                  key={option.key}
                  type="button"
                  onClick={() => {
                    if (isMultipleSelect) {
                      handleMultipleAnswer(
                        currentQuestion.id,
                        option.key
                      );
                    } else {
                      handleSingleAnswer(
                        currentQuestion.id,
                        option.key
                      );
                    }
                  }}
                  className={`flex w-full items-start gap-4 rounded-xl border p-4 text-left transition ${
                    selected
                      ? "border-cyan-400 bg-cyan-400/10"
                      : "border-slate-700 bg-slate-950/40 hover:border-slate-500"
                  }`}
                >
                  <span
                    className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full border text-sm font-semibold ${
                      selected
                        ? "border-cyan-400 bg-cyan-400 text-slate-950"
                        : "border-slate-600 text-slate-300"
                    }`}
                  >
                    {option.key}
                  </span>

                  <span className="pt-1 text-slate-200">
                    {option.text}
                  </span>
                </button>
              );
            })}
          </div>

          <div className="mt-8 border-t border-slate-800 pt-6">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
              <button
                type="button"
                onClick={goBack}
                disabled={currentIndex === 0}
                className="rounded-lg border border-slate-700 px-5 py-3 text-sm font-medium text-slate-300 transition hover:bg-slate-100 hover:text-slate-900 disabled:cursor-not-allowed disabled:opacity-40"
              >
                ← Back
              </button>

              <div className="text-center text-xs text-slate-500">
                {saving
                  ? "Saving..."
                  : "Progress saved automatically"}
              </div>

              {currentIndex <
              questions.length - 1 ? (
                <button
                  type="button"
                  onClick={goNext}
                  className="rounded-lg bg-cyan-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                >
                  Next →
                </button>
              ) : (
                <button
                  type="button"
                  onClick={submitAssessment}
                  disabled={submitting || saving}
                  className="rounded-lg bg-emerald-400 px-5 py-3 text-sm font-semibold text-slate-950 transition hover:bg-emerald-300 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {submitting
                    ? "Submitting..."
                    : "Submit Assessment"}
                </button>
              )}
            </div>
          </div>
        </section>
      </div>
    </main>
  );
}