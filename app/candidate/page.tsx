"use client";

import {
  Suspense,
  useCallback,
  useEffect,
  useMemo,
  useState,
} from "react";
import { useSearchParams } from "next/navigation";
import { supabase } from "@/lib/supabase";

type CandidateInvitation = {
  candidate_first_name: string;
  candidate_last_name: string;
  role_name: string;
  industry_name: string;
  invitation_status: string;
  expires_at: string;
  assessment_count: number;
  completed_assessment_count: number;
};

type CandidateAssessment = {
  invitation_assessment_id: string;
  assessment_name: string;
  assessment_order: number;
  attempt_status: string;
};

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
  image_url: string | null;
  options: Option[];
};

type CandidateQuestionRow = {
  question_id: string;
  question_order: number;
  question_type: string;
  prompt: string;
  scenario: string | null;
  image_url: string | null;
  options: unknown;
  response: unknown;
};

function normalizeOptions(value: unknown): Option[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .map((option) => {
      if (
        typeof option === "object" &&
        option !== null
      ) {
        const raw = option as Record<string, unknown>;

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
}

function stableShuffle<T>(
  items: T[],
  seedText: string
): T[] {
  let seed = 2166136261;

  for (let index = 0; index < seedText.length; index += 1) {
    seed ^= seedText.charCodeAt(index);
    seed = Math.imul(seed, 16777619);
  }

  let state = seed >>> 0;

  function random() {
    state += 0x6d2b79f5;

    let value = state;

    value = Math.imul(
      value ^ (value >>> 15),
      value | 1
    );

    value ^=
      value +
      Math.imul(
        value ^ (value >>> 7),
        value | 61
      );

    return (
      ((value ^ (value >>> 14)) >>> 0) /
      4294967296
    );
  }

  const shuffled = [...items];

  for (
    let index = shuffled.length - 1;
    index > 0;
    index -= 1
  ) {
    const swapIndex =
      Math.floor(random() * (index + 1));

    [
      shuffled[index],
      shuffled[swapIndex],
    ] = [
      shuffled[swapIndex],
      shuffled[index],
    ];
  }

  return shuffled;
}

function normalizeResponse(
  value: unknown
): string[] {
  if (Array.isArray(value)) {
    return value.map(String);
  }

  if (
    typeof value === "string" ||
    typeof value === "number" ||
    typeof value === "boolean"
  ) {
    return [String(value)];
  }

  return [];
}

function CandidatePageFrame({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <main className="min-h-screen bg-slate-50 px-4 py-8 text-[var(--text-primary)] sm:px-6 sm:py-12">
      <div className="mx-auto max-w-4xl">
        <div className="mb-6">
          <p className="text-lg font-bold text-[var(--text-primary)]">
            RISE
          </p>

          <p className="text-xs text-slate-500">
            Readiness Intelligence &amp; Skills Engine
          </p>
        </div>

        {children}
      </div>
    </main>
  );
}

function CandidateAssessmentExperience() {
  const searchParams = useSearchParams();
  const token =
    searchParams.get("token")?.trim() ?? "";

  const [invitation, setInvitation] =
    useState<CandidateInvitation | null>(null);

  const [assessments, setAssessments] =
    useState<CandidateAssessment[]>([]);

  const [activeAssessment, setActiveAssessment] =
    useState<CandidateAssessment | null>(null);

  const [attemptId, setAttemptId] =
    useState<string | null>(null);

  const [questions, setQuestions] =
    useState<Question[]>([]);

  const [answers, setAnswers] =
    useState<Record<string, string[]>>({});

  const [currentIndex, setCurrentIndex] =
    useState(0);

  const [loading, setLoading] =
    useState(true);

  const [starting, setStarting] =
    useState(false);

  const [saving, setSaving] =
    useState(false);

  const [submitting, setSubmitting] =
    useState(false);

  const [message, setMessage] =
    useState("");

  const [completionMessage, setCompletionMessage] =
    useState("");

  const currentQuestion =
    questions[currentIndex] ?? null;

  const answeredCount = useMemo(() => {
    return questions.filter((question) => {
      const answer = answers[question.id];

      return (
        Array.isArray(answer) &&
        answer.length > 0
      );
    }).length;
  }, [questions, answers]);

  const assessmentProgressPercent =
    questions.length > 0
      ? Math.round(
          (answeredCount / questions.length) * 100
        )
      : 0;

  const invitationProgressPercent =
    invitation &&
    invitation.assessment_count > 0
      ? Math.round(
          (invitation.completed_assessment_count /
            invitation.assessment_count) *
            100
        )
      : 0;

  const loadCandidateHome =
    useCallback(async () => {
      if (!token) {
        setInvitation(null);
        setAssessments([]);
        setMessage(
          "This assessment link is missing its secure invitation token."
        );
        setLoading(false);
        return false;
      }

      setMessage("");

      const {
        data: invitationData,
        error: invitationError,
      } = await supabase.rpc(
        "wri_get_prehire_candidate_invitation",
        {
          p_token: token,
        }
      );

      if (invitationError) {
        setInvitation(null);
        setAssessments([]);
        setMessage(invitationError.message);
        setLoading(false);
        return false;
      }

      const invitationRow = (
        invitationData as CandidateInvitation[] | null
      )?.[0];

      if (!invitationRow) {
        setInvitation(null);
        setAssessments([]);
        setMessage(
          "This candidate assessment invitation is unavailable."
        );
        setLoading(false);
        return false;
      }

      const {
        data: assessmentData,
        error: assessmentError,
      } = await supabase.rpc(
        "wri_get_prehire_candidate_assessments",
        {
          p_token: token,
        }
      );

      if (assessmentError) {
        setInvitation(invitationRow);
        setAssessments([]);
        setMessage(assessmentError.message);
        setLoading(false);
        return false;
      }

      setInvitation(invitationRow);

      setAssessments(
        (assessmentData as CandidateAssessment[] | null) ??
          []
      );

      setLoading(false);
      return true;
    }, [token]);

  useEffect(() => {
    queueMicrotask(() => {
      void loadCandidateHome();
    });
  }, [loadCandidateHome]);

  async function startAssessment(
    assessment: CandidateAssessment
  ) {
    if (
      assessment.attempt_status === "completed"
    ) {
      return;
    }

    setStarting(true);
    setMessage("");
    setCompletionMessage("");

    const {
      data: startData,
      error: startError,
    } = await supabase.rpc(
      "wri_start_prehire_assessment",
      {
        p_token: token,
        p_invitation_assessment_id:
          assessment.invitation_assessment_id,
      }
    );

    if (startError) {
      setMessage(startError.message);
      setStarting(false);
      return;
    }

    const newAttemptId =
      typeof startData === "string"
        ? startData
        : null;

    if (!newAttemptId) {
      setMessage(
        "Unable to start this assessment."
      );
      setStarting(false);
      return;
    }

    const {
      data: questionData,
      error: questionError,
    } = await supabase.rpc(
      "wri_get_prehire_assessment_questions",
      {
        p_token: token,
        p_attempt_id: newAttemptId,
      }
    );

    if (questionError) {
      setMessage(questionError.message);
      setStarting(false);
      return;
    }

    const rows =
      (questionData as CandidateQuestionRow[] | null) ??
      [];

    const normalizedQuestions: Question[] =
      rows.map((row) => ({
        id: row.question_id,
        question_order: row.question_order,
        type: row.question_type,
        prompt: row.prompt,
        scenario: row.scenario,
        image_url: row.image_url,
        options: stableShuffle(
          normalizeOptions(row.options),
          `${newAttemptId}:${row.question_id}`
        ),
      }));

    if (normalizedQuestions.length === 0) {
      setMessage(
        "This assessment does not contain any available questions."
      );
      setStarting(false);
      return;
    }

    const existingAnswers: Record<
      string,
      string[]
    > = {};

    rows.forEach((row) => {
      const response =
        normalizeResponse(row.response);

      if (response.length > 0) {
        existingAnswers[row.question_id] =
          response;
      }
    });

    const firstUnansweredIndex =
      normalizedQuestions.findIndex(
        (question) =>
          !existingAnswers[question.id] ||
          existingAnswers[question.id].length === 0
      );

    setActiveAssessment(assessment);
    setAttemptId(newAttemptId);
    setQuestions(normalizedQuestions);
    setAnswers(existingAnswers);

    setCurrentIndex(
      firstUnansweredIndex >= 0
        ? firstUnansweredIndex
        : 0
    );

    setStarting(false);
  }

  async function saveAnswer(
    questionId: string,
    nextAnswer: string[]
  ) {
    if (!attemptId) {
      return;
    }

    setAnswers((current) => ({
      ...current,
      [questionId]: nextAnswer,
    }));

    setSaving(true);
    setMessage("");

    const { error } = await supabase.rpc(
      "wri_save_prehire_answer",
      {
        p_token: token,
        p_attempt_id: attemptId,
        p_question_id: questionId,
        p_response: nextAnswer,
      }
    );

    if (error) {
      setMessage(error.message);
    }

    setSaving(false);
  }

  function returnToAssessmentList() {
    setActiveAssessment(null);
    setAttemptId(null);
    setQuestions([]);
    setAnswers({});
    setCurrentIndex(0);
    setMessage("");
  }

  async function submitAssessment() {
    if (
      !attemptId ||
      questions.length === 0
    ) {
      return;
    }

    const unanswered =
      questions.filter(
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

      const firstUnanswered =
        questions.findIndex(
          (question) =>
            !answers[question.id] ||
            answers[question.id].length === 0
        );

      if (firstUnanswered >= 0) {
        setCurrentIndex(firstUnanswered);
      }

      return;
    }

    setSubmitting(true);
    setMessage("");

    const { error } = await supabase.rpc(
      "wri_submit_prehire_assessment",
      {
        p_token: token,
        p_attempt_id: attemptId,
      }
    );

    if (error) {
      setMessage(error.message);
      setSubmitting(false);
      return;
    }

    setActiveAssessment(null);
    setAttemptId(null);
    setQuestions([]);
    setAnswers({});
    setCurrentIndex(0);

    const refreshed =
      await loadCandidateHome();

    if (refreshed) {
      setCompletionMessage(
        "Assessment submitted successfully. Your responses have been recorded."
      );
    }

    setSubmitting(false);
  }

  if (loading) {
    return (
      <CandidatePageFrame>
        <div className="rounded-2xl border border-slate-200 bg-white p-8 text-sm text-slate-600">
          Loading your assessment invitation...
        </div>
      </CandidatePageFrame>
    );
  }

  if (!invitation) {
    return (
      <CandidatePageFrame>
        <div className="rounded-2xl border border-red-200 bg-white p-8">
          <p className="text-xs font-semibold uppercase tracking-wide text-red-600">
            Invitation Unavailable
          </p>

          <h1 className="mt-2 text-2xl font-semibold">
            We could not open this assessment.
          </h1>

          <p className="mt-3 text-sm text-slate-600">
            {message ||
              "The invitation may be invalid, expired, or no longer available."}
          </p>
        </div>
      </CandidatePageFrame>
    );
  }

  if (
    activeAssessment &&
    currentQuestion
  ) {
    const selectedAnswers =
      answers[currentQuestion.id] ?? [];

    const isMultipleSelect =
      currentQuestion.type ===
      "multiple_select";

    const isLastQuestion =
      currentIndex ===
      questions.length - 1;

    return (
      <CandidatePageFrame>
        <div className="mb-5 flex items-center justify-between gap-3">
          <button
            type="button"
            onClick={returnToAssessmentList}
            disabled={saving || submitting}
            className="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-medium"
          >
            ← Assessment List
          </button>

          <p className="text-sm text-slate-500">
            {saving
              ? "Saving response..."
              : "Responses save automatically"}
          </p>
        </div>

        <div className="rounded-2xl border border-slate-200 bg-white">
          <div className="border-b border-slate-200 px-6 py-5 sm:px-8">
            <p className="text-xs font-semibold uppercase tracking-wide text-cyan-700">
              RISE Candidate Assessment
            </p>

            <h1 className="mt-2 text-2xl font-semibold">
              {activeAssessment.assessment_name}
            </h1>

            <div className="mt-2 flex justify-between text-sm text-slate-500">
              <span>
                Question {currentIndex + 1} of{" "}
                {questions.length}
              </span>

              <span>
                {answeredCount}/{questions.length} answered
              </span>
            </div>

            <div className="mt-4 h-2 overflow-hidden rounded-full bg-slate-100">
              <div
                className="h-full bg-cyan-600"
                style={{
                  width: `${assessmentProgressPercent}%`,
                }}
              />
            </div>
          </div>

          <div className="px-6 py-7 sm:px-8">
            {currentQuestion.scenario && (
              <div className="mb-6 rounded-xl bg-slate-50 p-4">
                <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                  Scenario
                </p>

                <p className="mt-2 text-sm leading-6 text-slate-700">
                  {currentQuestion.scenario}
                </p>
              </div>
            )}

            {currentQuestion.image_url && (
              <div className="mb-6 overflow-hidden rounded-xl border border-slate-200">
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img
                  src={currentQuestion.image_url}
                  alt="Assessment question reference"
                  className="h-auto w-full object-contain"
                />
              </div>
            )}

            <h2 className="text-xl font-semibold leading-7">
              {currentQuestion.prompt}
            </h2>

            {isMultipleSelect && (
              <p className="mt-2 text-sm text-slate-500">
                Select all that apply.
              </p>
            )}

            <div className="mt-6 space-y-3">
              {currentQuestion.options.map(
                (option) => {
                  const selected =
                    selectedAnswers.includes(option.key);

                  return (
                    <button
                      key={option.key}
                      type="button"
                      disabled={saving || submitting}
                      onClick={() => {
                        if (isMultipleSelect) {
                          const next =
                            selectedAnswers.includes(
                              option.key
                            )
                              ? selectedAnswers.filter(
                                  (item) =>
                                    item !== option.key
                                )
                              : [
                                  ...selectedAnswers,
                                  option.key,
                                ];

                          void saveAnswer(
                            currentQuestion.id,
                            next
                          );
                        } else {
                          void saveAnswer(
                            currentQuestion.id,
                            [option.key]
                          );
                        }
                      }}
                      className={`flex w-full items-start gap-3 rounded-xl border px-4 py-4 text-left text-sm ${
                        selected
                          ? "border-cyan-600 bg-cyan-50"
                          : "border-slate-200 bg-white hover:bg-slate-50"
                      }`}
                    >
                      <span
                        className={`mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center border ${
                          isMultipleSelect
                            ? "rounded"
                            : "rounded-full"
                        } ${
                          selected
                            ? "border-cyan-600 bg-cyan-600 text-white"
                            : "border-slate-300"
                        }`}
                      >
                        {selected ? "✓" : ""}
                      </span>

                      <span>{option.text}</span>
                    </button>
                  );
                }
              )}
            </div>

            {message && (
              <div className="mt-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                {message}
              </div>
            )}

            <div className="mt-8 flex justify-between border-t border-slate-200 pt-6">
              <button
                type="button"
                onClick={() =>
                  setCurrentIndex((current) =>
                    Math.max(0, current - 1)
                  )
                }
                disabled={
                  currentIndex === 0 ||
                  saving ||
                  submitting
                }
                className="rounded-lg border border-slate-300 px-5 py-2.5 text-sm font-medium disabled:opacity-40"
              >
                Back
              </button>

              {!isLastQuestion ? (
                <button
                  type="button"
                  onClick={() =>
                    setCurrentIndex((current) =>
                      Math.min(
                        questions.length - 1,
                        current + 1
                      )
                    )
                  }
                  disabled={saving || submitting}
                  className="rounded-lg bg-slate-950 px-5 py-2.5 text-sm font-semibold text-white"
                >
                  Next Question
                </button>
              ) : (
                <button
                  type="button"
                  onClick={() =>
                    void submitAssessment()
                  }
                  disabled={saving || submitting}
                  className="rounded-lg bg-cyan-700 px-5 py-2.5 text-sm font-semibold text-white"
                >
                  {submitting
                    ? "Submitting..."
                    : "Submit Assessment"}
                </button>
              )}
            </div>
          </div>
        </div>
      </CandidatePageFrame>
    );
  }

  const allCompleted =
    invitation.assessment_count > 0 &&
    invitation.completed_assessment_count ===
      invitation.assessment_count;

  return (
    <CandidatePageFrame>
      <div className="rounded-2xl border border-slate-200 bg-white">
        <div className="border-b border-slate-200 px-6 py-7 sm:px-8">
          <p className="text-xs font-semibold uppercase tracking-wide text-cyan-700">
            RISE by IntegrateU
          </p>

          <h1 className="mt-2 text-3xl font-semibold">
            Candidate Assessment
          </h1>

          <p className="mt-3 text-sm leading-6 text-slate-600">
            Welcome,{" "}
            {invitation.candidate_first_name}.
            Complete the assessments below to
            support the organization&apos;s
            pre-hire readiness review.
          </p>
        </div>

        <div className="grid gap-5 border-b border-slate-200 bg-slate-50 px-6 py-5 sm:grid-cols-3 sm:px-8">
          <div>
            <p className="text-xs uppercase text-slate-500">
              Target Role
            </p>

            <p className="mt-1 text-sm font-semibold">
              {invitation.role_name}
            </p>
          </div>

          <div>
            <p className="text-xs uppercase text-slate-500">
              Industry
            </p>

            <p className="mt-1 text-sm font-semibold">
              {invitation.industry_name}
            </p>
          </div>

          <div>
            <p className="text-xs uppercase text-slate-500">
              Due
            </p>

            <p className="mt-1 text-sm font-semibold">
              {new Date(
                invitation.expires_at
              ).toLocaleString()}
            </p>
          </div>
        </div>

        <div className="px-6 py-7 sm:px-8">
          {completionMessage && (
            <div className="mb-6 rounded-xl border border-emerald-200 bg-emerald-50 p-4 text-sm text-emerald-900">
              {completionMessage}
            </div>
          )}

          {message && (
            <div className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-800">
              {message}
            </div>
          )}

          <div className="flex items-end justify-between gap-4">
            <div>
              <h2 className="text-lg font-semibold">
                Your Assessments
              </h2>

              <p className="mt-1 text-sm text-slate-500">
                {invitation.completed_assessment_count}{" "}
                of {invitation.assessment_count}{" "}
                completed
              </p>
            </div>

            <p className="text-sm font-semibold">
              {invitationProgressPercent}% complete
            </p>
          </div>

          <div className="mt-4 h-2 overflow-hidden rounded-full bg-slate-100">
            <div
              className="h-full bg-cyan-600"
              style={{
                width: `${invitationProgressPercent}%`,
              }}
            />
          </div>

          {allCompleted ? (
            <div className="mt-7 rounded-xl border border-emerald-200 bg-emerald-50 p-6">
              <h3 className="font-semibold">
                Assessment process complete
              </h3>

              <p className="mt-2 text-sm">
                Thank you. Your responses have
                been submitted for review. No
                additional action is required at
                this time.
              </p>
            </div>
          ) : (
            <div className="mt-7 space-y-3">
              {assessments.map(
                (assessment) => {
                  const completed =
                    assessment.attempt_status ===
                    "completed";

                  const inProgress =
                    assessment.attempt_status ===
                    "in_progress";

                  return (
                    <div
                      key={
                        assessment.invitation_assessment_id
                      }
                      className="flex items-center justify-between gap-4 rounded-xl border border-slate-200 p-4"
                    >
                      <div>
                        <p className="font-medium">
                          {assessment.assessment_name}
                        </p>

                        <p className="mt-1 text-xs text-slate-500">
                          Assessment{" "}
                          {assessment.assessment_order}{" "}
                          of{" "}
                          {invitation.assessment_count}
                          {" · "}
                          {completed
                            ? "Completed"
                            : inProgress
                              ? "In Progress"
                              : "Not Started"}
                        </p>
                      </div>

                      <button
                        type="button"
                        disabled={
                          completed ||
                          starting
                        }
                        onClick={() =>
                          void startAssessment(
                            assessment
                          )
                        }
                        className={`shrink-0 rounded-lg px-4 py-2 text-sm font-semibold ${
                          completed
                            ? "bg-slate-100 text-slate-400"
                            : "bg-slate-950 text-white"
                        }`}
                      >
                        {completed
                          ? "Completed"
                          : starting
                            ? "Opening..."
                            : inProgress
                              ? "Resume"
                              : "Start"}
                      </button>
                    </div>
                  );
                }
              )}
            </div>
          )}

          <p className="mt-8 border-t border-slate-200 pt-5 text-xs leading-5 text-slate-500">
            Assessment results are reviewed by
            the hiring organization and are not
            displayed during this experience.
          </p>
        </div>
      </div>
    </CandidatePageFrame>
  );
}

export default function CandidatePage() {
  return (
    <Suspense
      fallback={
        <CandidatePageFrame>
          <div className="rounded-2xl border border-slate-200 bg-white p-8 text-sm text-slate-600">
            Loading your assessment invitation...
          </div>
        </CandidatePageFrame>
      }
    >
      <CandidateAssessmentExperience />
    </Suspense>
  );
}
