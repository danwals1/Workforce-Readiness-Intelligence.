"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import {
  createQuestion,
  deleteQuestion,
  getAnswerKey,
  getAssessmentFamily,
  listAdoptionsForFamily,
  listCurrentCompetencyTemplates,
  listQuestions,
  publishAssessmentVersion,
  updateAssessment,
  updateQuestion,
  upsertAnswerKey,
  type AdoptionStatusRow,
  type Assessment,
  type AssessmentQuestion,
  type AssessmentQuestionType,
  type MasterCompetencyTemplate,
} from "@/lib/masterLibrary";

const TYPE_LABELS: Record<AssessmentQuestionType, string> = {
  multiple_choice: "Multiple Choice",
  multiple_select: "Multiple Select",
  scenario: "Scenario-Based",
  image_based: "Image-Based",
  troubleshooting: "Troubleshooting Scenario",
  situational_judgment: "Situational Judgment",
};

export default function AssessmentDetailPage() {
  const params = useParams();
  const familyId = params.familyId as string;

  const [versions, setVersions] = useState<Assessment[]>([]);
  const [questions, setQuestions] = useState<AssessmentQuestion[]>([]);
  const [competencies, setCompetencies] = useState<MasterCompetencyTemplate[]>([]);
  const [adoptions, setAdoptions] = useState<AdoptionStatusRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [publishing, setPublishing] = useState(false);

  const current = versions.find((v) => v.is_current);

  const [name, setName] = useState("");
  const [savingName, setSavingName] = useState(false);

  const [showNewQuestion, setShowNewQuestion] = useState(false);

  async function load() {
    setLoading(true);
    setError("");
    try {
      const v = await getAssessmentFamily(familyId);
      setVersions(v);
      const cur = v.find((x) => x.is_current);
      if (cur) {
        setName(cur.name);
        const [qs, comps, ad] = await Promise.all([
          listQuestions(cur.id),
          listCurrentCompetencyTemplates(cur.industry_id),
          listAdoptionsForFamily("assessment", familyId),
        ]);
        setQuestions(qs);
        setCompetencies(comps);
        setAdoptions(ad);
      }
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load assessment.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [familyId]);

  async function handleSaveName() {
    if (!current) return;
    setSavingName(true);
    try {
      await updateAssessment(current.id, { name });
      await load();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to save name.");
    } finally {
      setSavingName(false);
    }
  }

  async function handlePublish() {
    if (!current) return;
    setPublishing(true);
    setError("");
    try {
      await publishAssessmentVersion(current.id);
      await load();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to publish new version.");
    } finally {
      setPublishing(false);
    }
  }

  if (loading) return <p className="text-slate-400">Loading…</p>;
  if (!current) return <p className="text-slate-400">Assessment not found.</p>;

  return (
    <div className="space-y-8">
      <Link href="/admin/library/assessments" className="text-sm text-cyan-400">
        ← Assessment Templates
      </Link>

      {error && <div className="rounded-xl border border-slate-800 bg-slate-900 p-4 text-sm text-rose-300">{error}</div>}

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="text-xl font-semibold">Assessment — v{current.version}</h2>
          <button
            onClick={handlePublish}
            disabled={publishing}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
          >
            {publishing ? "Publishing…" : "Publish New Version"}
          </button>
        </div>
        <p className="mb-4 text-xs text-slate-500">
          Publishing duplicates every question below, and each question&apos;s answer key, onto the new version — it
          never shares rows with this one.
        </p>
        <div className="flex items-end gap-3">
          <div className="flex-1">
            <label className="mb-2 block text-sm text-slate-300">Name</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full rounded-lg border border-slate-700 bg-slate-950 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <button
            onClick={handleSaveName}
            disabled={savingName}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 hover:bg-slate-800 disabled:opacity-50"
          >
            {savingName ? "Saving…" : "Save"}
          </button>
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <div className="mb-4 flex items-center justify-between">
          <h3 className="text-lg font-semibold">Questions</h3>
          <button
            onClick={() => setShowNewQuestion((s) => !s)}
            className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400"
          >
            {showNewQuestion ? "Cancel" : "New Question"}
          </button>
        </div>

        {showNewQuestion && (
          <NewQuestionForm
            assessmentId={current.id}
            competencies={competencies}
            nextSortOrder={questions.length}
            onCreated={() => {
              setShowNewQuestion(false);
              load();
            }}
          />
        )}

        <div className="mt-4 space-y-3">
          {questions.map((q) => (
            <QuestionRow key={q.id} question={q} competencies={competencies} onChanged={load} />
          ))}
          {questions.length === 0 && <p className="text-slate-500">No questions yet.</p>}
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <h3 className="mb-4 text-lg font-semibold">Version history</h3>
        <div className="divide-y divide-slate-800">
          {versions.map((v) => (
            <div key={v.id} className="flex items-center justify-between py-3 text-sm">
              <span>v{v.version}</span>
              <span className="text-slate-400">{new Date(v.published_at).toLocaleDateString()}</span>
              <span
                className={`rounded-full px-3 py-1 text-xs ${
                  v.is_current ? "bg-emerald-500/15 text-emerald-300" : "bg-slate-800 text-slate-400"
                }`}
              >
                {v.is_current ? "Current" : "Superseded"}
              </span>
            </div>
          ))}
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
        <h3 className="mb-4 text-lg font-semibold">Companies that adopted this assessment</h3>
        <div className="divide-y divide-slate-800">
          {adoptions.map((a) => (
            <div key={a.id} className="flex items-center justify-between py-3 text-sm">
              <span>{a.clients?.name ?? a.client_id}</span>
              <span className="text-slate-400">Adopted v{a.source_version}</span>
              {a.newer_version_available ? (
                <span className="rounded-full bg-amber-500/15 px-3 py-1 text-xs text-amber-300">
                  Newer version available
                </span>
              ) : (
                <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-xs text-emerald-300">Up to date</span>
              )}
            </div>
          ))}
          {adoptions.length === 0 && (
            <p className="py-3 text-slate-500">No companies have adopted this assessment yet.</p>
          )}
        </div>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------

function NewQuestionForm({
  assessmentId,
  competencies,
  nextSortOrder,
  onCreated,
}: {
  assessmentId: string;
  competencies: MasterCompetencyTemplate[];
  nextSortOrder: number;
  onCreated: () => void;
}) {
  const [competencyId, setCompetencyId] = useState(competencies[0]?.id ?? "");
  const [type, setType] = useState<AssessmentQuestionType>("multiple_choice");
  const [prompt, setPrompt] = useState("");
  const [scenario, setScenario] = useState("");
  const [optionsText, setOptionsText] = useState("");
  const [correctAnswer, setCorrectAnswer] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError("");
    try {
      const options = optionsText
        .split("\n")
        .map((line) => line.trim())
        .filter(Boolean)
        .map((label, idx) => ({ id: String.fromCharCode(97 + idx), label }));

      const q = await createQuestion({
        assessment_id: assessmentId,
        master_competency_template_id: competencyId,
        type,
        prompt,
        scenario: scenario || undefined,
        options,
        sort_order: nextSortOrder,
      });

      if (correctAnswer.trim()) {
        const isMulti = type === "multiple_select";
        await upsertAnswerKey({
          question_id: q.id,
          correct_answer: isMulti
            ? correctAnswer.split(",").map((s) => s.trim())
            : correctAnswer.trim(),
        });
      }

      setPrompt("");
      setScenario("");
      setOptionsText("");
      setCorrectAnswer("");
      onCreated();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create question.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="mb-4 space-y-4 rounded-xl border border-slate-800 bg-slate-950 p-5">
      {error && <p className="text-sm text-rose-300">{error}</p>}
      <div className="grid gap-4 md:grid-cols-2">
        <div>
          <label className="mb-2 block text-sm text-slate-300">Competency</label>
          <select
            value={competencyId}
            onChange={(e) => setCompetencyId(e.target.value)}
            className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
          >
            {competencies.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="mb-2 block text-sm text-slate-300">Type</label>
          <select
            value={type}
            onChange={(e) => setType(e.target.value as AssessmentQuestionType)}
            className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
          >
            {Object.entries(TYPE_LABELS).map(([val, label]) => (
              <option key={val} value={val}>
                {label}
              </option>
            ))}
          </select>
        </div>
      </div>
      <div>
        <label className="mb-2 block text-sm text-slate-300">Prompt</label>
        <textarea
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          required
          rows={2}
          className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
        />
      </div>
      <div>
        <label className="mb-2 block text-sm text-slate-300">Scenario (optional)</label>
        <textarea
          value={scenario}
          onChange={(e) => setScenario(e.target.value)}
          rows={2}
          className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
        />
      </div>
      <div>
        <label className="mb-2 block text-sm text-slate-300">Options (one per line)</label>
        <textarea
          value={optionsText}
          onChange={(e) => setOptionsText(e.target.value)}
          rows={4}
          className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
          placeholder={"CL3-rated speaker cable\nStandard lamp cord\nCat3 telephone cable"}
        />
      </div>
      <div className="rounded-lg border border-amber-700/40 bg-amber-950/20 p-4">
        <label className="mb-2 block text-sm text-amber-300">
          Answer key — option letter (a, b, c…), or comma-separated for Multiple Select. Stored separately; never
          shown to employees taking the assessment.
        </label>
        <input
          value={correctAnswer}
          onChange={(e) => setCorrectAnswer(e.target.value)}
          className="w-full rounded-lg border border-amber-700/40 bg-slate-900 px-4 py-2 outline-none focus:border-amber-500"
          placeholder="a"
        />
      </div>
      <button
        type="submit"
        disabled={saving || !competencyId}
        className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
      >
        {saving ? "Saving…" : "Create Question"}
      </button>
    </form>
  );
}

function QuestionRow({
  question,
  competencies,
  onChanged,
}: {
  question: AssessmentQuestion;
  competencies: MasterCompetencyTemplate[];
  onChanged: () => void;
}) {
  const [expanded, setExpanded] = useState(false);
  const [prompt, setPrompt] = useState(question.prompt);
  const [scenario, setScenario] = useState(question.scenario ?? "");
  const [optionsText, setOptionsText] = useState((question.options ?? []).map((o) => o.label).join("\n"));
  const [correctAnswer, setCorrectAnswer] = useState<string>("");
  const [keyLoaded, setKeyLoaded] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  const competencyName = competencies.find((c) => c.id === question.master_competency_template_id)?.name ?? "—";

  async function toggleExpand() {
    const next = !expanded;
    setExpanded(next);
    if (next && !keyLoaded) {
      try {
        const key = await getAnswerKey(question.id);
        if (key) {
          setCorrectAnswer(Array.isArray(key.correct_answer) ? key.correct_answer.join(", ") : key.correct_answer);
        }
      } catch (e) {
        setError(e instanceof Error ? e.message : "Failed to load answer key.");
      } finally {
        setKeyLoaded(true);
      }
    }
  }

  async function handleSave() {
    setSaving(true);
    setError("");
    try {
      const options = optionsText
        .split("\n")
        .map((line) => line.trim())
        .filter(Boolean)
        .map((label, idx) => ({ id: String.fromCharCode(97 + idx), label }));

      await updateQuestion(question.id, { prompt, scenario: scenario || null, options });

      if (correctAnswer.trim()) {
        const isMulti = question.type === "multiple_select";
        await upsertAnswerKey({
          question_id: question.id,
          correct_answer: isMulti ? correctAnswer.split(",").map((s) => s.trim()) : correctAnswer.trim(),
        });
      }
      onChanged();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to save question.");
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete() {
    if (!window.confirm("Delete this question and its answer key?")) return;
    try {
      await deleteQuestion(question.id);
      onChanged();
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to delete question.");
    }
  }

  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950">
      <button onClick={toggleExpand} className="flex w-full items-center justify-between p-4 text-left">
        <div>
          <p className="text-sm text-slate-400">
            {competencyName} · {TYPE_LABELS[question.type]}
          </p>
          <p className="mt-1">{question.prompt}</p>
        </div>
        <span className="text-slate-500">{expanded ? "▲" : "▼"}</span>
      </button>

      {expanded && (
        <div className="space-y-4 border-t border-slate-800 p-4">
          {error && <p className="text-sm text-rose-300">{error}</p>}
          <div>
            <label className="mb-2 block text-sm text-slate-300">Prompt</label>
            <textarea
              value={prompt}
              onChange={(e) => setPrompt(e.target.value)}
              rows={2}
              className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <div>
            <label className="mb-2 block text-sm text-slate-300">Scenario</label>
            <textarea
              value={scenario}
              onChange={(e) => setScenario(e.target.value)}
              rows={2}
              className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <div>
            <label className="mb-2 block text-sm text-slate-300">Options (one per line)</label>
            <textarea
              value={optionsText}
              onChange={(e) => setOptionsText(e.target.value)}
              rows={4}
              className="w-full rounded-lg border border-slate-700 bg-slate-900 px-4 py-2 outline-none focus:border-cyan-500"
            />
          </div>
          <div className="rounded-lg border border-amber-700/40 bg-amber-950/20 p-4">
            <label className="mb-2 block text-sm text-amber-300">
              Answer key — option letter, or comma-separated for Multiple Select
            </label>
            <input
              value={correctAnswer}
              onChange={(e) => setCorrectAnswer(e.target.value)}
              className="w-full rounded-lg border border-amber-700/40 bg-slate-900 px-4 py-2 outline-none focus:border-amber-500"
            />
          </div>
          <div className="flex gap-3">
            <button
              onClick={handleSave}
              disabled={saving}
              className="rounded-lg bg-cyan-500 px-4 py-2 text-sm font-semibold text-slate-950 hover:bg-cyan-400 disabled:opacity-50"
            >
              {saving ? "Saving…" : "Save"}
            </button>
            <button onClick={handleDelete} className="rounded-lg border border-rose-700/50 px-4 py-2 text-sm text-rose-300 hover:bg-rose-950/30">
              Delete
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
