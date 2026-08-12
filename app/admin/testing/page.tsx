"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import SystemHeader from "@/components/SystemHeader";
import { supabase } from "@/lib/supabase";

type TestEmployee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  auth_user_id: string | null;
};

type DevelopmentPlan = {
  id: string;
  employee_id: string;
  title: string;
  status: string;
  resolution_status: string | null;
  action_type: string | null;
  action_key: string | null;
  master_competency_template_id: string | null;
  development_completed_at: string | null;
  awaiting_evidence_since: string | null;
  resolved_at: string | null;
  resolution_notes: string | null;
};

type DevelopmentActivity = {
  id: string;
  development_plan_id: string;
  title: string;
  status: string;
  completed_at: string | null;
};

type ReadinessAction = {
  action_key: string;
  employee_id: string;
  master_competency_template_id: string | null;
  action_type: string;
  action_label: string;
};


type RegressionEvent = {
  id: string;
  event_at: string;
  event_type: string;
  employee_id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  development_plan_id: string;
  plan_title: string;
  action_type: string | null;
  action_key: string | null;
  old_status: string | null;
  new_status: string | null;
  old_resolution_status: string | null;
  new_resolution_status: string | null;
  current_readiness_action_type: string | null;
  current_readiness_action_key: string | null;
};

type RegressionStatus = "pass" | "fail" | "info";

type RegressionCheck = {
  id: string;
  name: string;
  description: string;
  status: RegressionStatus;
  detail: string;
};


type ScenarioCoverageStatus =
  | "covered"
  | "partial"
  | "not_tested";

type ScenarioCoverage = {
  id: string;
  name: string;
  description: string;
  status: ScenarioCoverageStatus;
  detail: string;
  planTitle: string | null;
  developmentPlanId: string | null;
};

type EmployeeSummary = {
  employee: TestEmployee;
  planCount: number;
  activePlanCount: number;
  awaitingEvidenceCount: number;
  resolvedPlanCount: number;
  readinessActionCount: number;
};

const waitingStatuses = [
  "awaiting_reassessment",
  "awaiting_verification",
  "awaiting_reverification",
];

const allowedResolutionStatuses = [
  "development_in_progress",
  "awaiting_reassessment",
  "awaiting_verification",
  "awaiting_reverification",
  "resolved",
  "cancelled",
];

export default function SystemTestingPage() {
  const router = useRouter();

  const [employees, setEmployees] =
    useState<TestEmployee[]>([]);

  const [plans, setPlans] =
    useState<DevelopmentPlan[]>([]);

  const [activities, setActivities] =
    useState<DevelopmentActivity[]>([]);

  const [readinessActions, setReadinessActions] =
    useState<ReadinessAction[]>([]);


  const [history, setHistory] =
    useState<RegressionEvent[]>([]);

  const [message, setMessage] =
    useState("Loading testing workspace...");

  const [loading, setLoading] =
    useState(true);

  const [lastLoadedAt, setLastLoadedAt] =
    useState<Date | null>(null);

  const loadPage = useCallback(async () => {
    setLoading(true);
    setMessage("Loading testing workspace...");

    const {
      data: sessionData,
      error: sessionError,
    } = await supabase.auth.getSession();

    if (sessionError) {
      setMessage(sessionError.message);
      setLoading(false);
      return;
    }

    if (!sessionData.session) {
      router.push("/");
      return;
    }

    const userId =
      sessionData.session.user.id;

    const {
      data: roles,
      error: rolesError,
    } = await supabase
      .from("user_client_roles")
      .select("role, status")
      .eq("user_id", userId)
      .eq("status", "active");

    if (rolesError) {
      setMessage(rolesError.message);
      setLoading(false);
      return;
    }

    const isIntegrateAdmin =
      roles?.some(
        (row) =>
          row.role === "INTEGRATEU_ADMIN"
      ) ?? false;

    if (!isIntegrateAdmin) {
      router.push("/dashboard");
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
        auth_user_id
      `)
      .ilike(
        "employee_number",
        "%TEST%"
      )
      .order("last_name", {
        ascending: true,
      });

    if (employeeError) {
      setMessage(employeeError.message);
      setLoading(false);
      return;
    }

    const nextEmployees =
      (employeeData ?? []) as TestEmployee[];

    setEmployees(nextEmployees);

    if (nextEmployees.length === 0) {
      setPlans([]);
      setActivities([]);
      setReadinessActions([]);
      setMessage("");
      setLastLoadedAt(new Date());
      setLoading(false);
      return;
    }

    const employeeIds =
      nextEmployees.map(
        (employee) => employee.id
      );

    const [
      plansResult,
      readinessResult,
      historyResult,
    ] = await Promise.all([
      supabase
        .from("development_plans")
        .select(`
          id,
          employee_id,
          title,
          status,
          resolution_status,
          action_type,
          action_key,
          master_competency_template_id,
          development_completed_at,
          awaiting_evidence_since,
          resolved_at,
          resolution_notes
        `)
        .in("employee_id", employeeIds)
        .order("created_at", {
          ascending: false,
        }),

      supabase
        .from("v_readiness_action_queue")
        .select(`
          action_key,
          employee_id,
          master_competency_template_id,
          action_type,
          action_label
        `)
        .in("employee_id", employeeIds),

      supabase
        .from("v_system_regression_test_history")
        .select(`
          id,
          event_at,
          event_type,
          employee_id,
          first_name,
          last_name,
          employee_number,
          development_plan_id,
          plan_title,
          action_type,
          action_key,
          old_status,
          new_status,
          old_resolution_status,
          new_resolution_status,
          current_readiness_action_type,
          current_readiness_action_key
        `)
        .order("event_at", {
          ascending: false,
        })
        .limit(100),
    ]);

    if (plansResult.error) {
      setMessage(plansResult.error.message);
      setLoading(false);
      return;
    }

    if (readinessResult.error) {
      setMessage(readinessResult.error.message);
      setLoading(false);
      return;
    }

    if (historyResult.error) {
      setMessage(historyResult.error.message);
      setLoading(false);
      return;
    }

    setHistory(
      (historyResult.data ?? []) as RegressionEvent[]
    );

    const nextPlans =
      (plansResult.data ?? []) as DevelopmentPlan[];

    setPlans(nextPlans);

    const planIds =
      nextPlans.map(
        (plan) => plan.id
      );

    if (planIds.length > 0) {
      const {
        data: activityData,
        error: activityError,
      } = await supabase
        .from("development_plan_activities")
        .select(`
          id,
          development_plan_id,
          title,
          status,
          completed_at
        `)
        .in(
          "development_plan_id",
          planIds
        )
        .order("created_at", {
          ascending: true,
        });

      if (activityError) {
        setMessage(activityError.message);
        setLoading(false);
        return;
      }

      setActivities(
        (activityData ?? []) as DevelopmentActivity[]
      );
    } else {
      setActivities([]);
    }

    setReadinessActions(
      (readinessResult.data ?? []) as ReadinessAction[]
    );

    setMessage("");
    setLastLoadedAt(new Date());
    setLoading(false);
  }, [router]);

  useEffect(() => {
    loadPage();
  }, [loadPage]);

  const checks = useMemo<RegressionCheck[]>(() => {
    const nextChecks: RegressionCheck[] = [];

    const invalidResolutionPlans =
      plans.filter(
        (plan) =>
          !plan.resolution_status ||
          !allowedResolutionStatuses.includes(
            plan.resolution_status
          )
      );

    nextChecks.push({
      id: "resolution-status-values",
      name: "Resolution Status Integrity",
      description:
        "Every Development Plan should use one of the supported lifecycle resolution states.",
      status:
        invalidResolutionPlans.length === 0
          ? "pass"
          : "fail",
      detail:
        invalidResolutionPlans.length === 0
          ? `${plans.length} plans use supported resolution states.`
          : `${invalidResolutionPlans.length} plan(s) contain an unsupported or missing resolution status.`,
    });

    const brokenCancelledPlans =
      plans.filter(
        (plan) =>
          plan.status === "cancelled" &&
          plan.resolution_status !== "cancelled"
      );

    nextChecks.push({
      id: "cancelled-plan-state",
      name: "Cancellation Lifecycle",
      description:
        "Cancelled Development Plans must remain in the cancelled resolution state.",
      status:
        brokenCancelledPlans.length === 0
          ? "pass"
          : "fail",
      detail:
        brokenCancelledPlans.length === 0
          ? "Cancelled plans are lifecycle-consistent."
          : `${brokenCancelledPlans.length} cancelled plan(s) have an inconsistent resolution state.`,
    });

    const brokenResolvedPlans =
      plans.filter(
        (plan) =>
          plan.resolution_status === "resolved" &&
          (
            plan.resolved_at === null ||
            plan.awaiting_evidence_since !== null
          )
      );

    nextChecks.push({
      id: "resolved-plan-state",
      name: "Resolved Plan Integrity",
      description:
        "Resolved plans must have a resolved timestamp and must not remain in an awaiting-evidence state.",
      status:
        brokenResolvedPlans.length === 0
          ? "pass"
          : "fail",
      detail:
        brokenResolvedPlans.length === 0
          ? "Resolved plan timestamps are consistent."
          : `${brokenResolvedPlans.length} resolved plan(s) have inconsistent lifecycle timestamps.`,
    });

    const brokenWaitingPlans =
      plans.filter(
        (plan) =>
          plan.resolution_status !== null &&
          waitingStatuses.includes(
            plan.resolution_status
          ) &&
          (
            plan.status !== "completed" ||
            plan.development_completed_at === null ||
            plan.awaiting_evidence_since === null ||
            plan.resolved_at !== null
          )
      );

    nextChecks.push({
      id: "awaiting-evidence-state",
      name: "Awaiting Evidence Integrity",
      description:
        "Plans waiting for reassessment, verification, or reverification must have completed development and an active evidence-wait timestamp.",
      status:
        brokenWaitingPlans.length === 0
          ? "pass"
          : "fail",
      detail:
        brokenWaitingPlans.length === 0
          ? "All waiting plans have consistent lifecycle timestamps."
          : `${brokenWaitingPlans.length} waiting plan(s) have inconsistent lifecycle state.`,
    });

    const completedActivitiesWithoutTimestamp =
      activities.filter(
        (activity) =>
          activity.status === "completed" &&
          activity.completed_at === null
      );

    nextChecks.push({
      id: "activity-completion",
      name: "Activity Completion Integrity",
      description:
        "Completed Development Plan activities must retain their completion timestamp.",
      status:
        completedActivitiesWithoutTimestamp.length === 0
          ? "pass"
          : "fail",
      detail:
        completedActivitiesWithoutTimestamp.length === 0
          ? `${activities.length} activities passed the completion timestamp check.`
          : `${completedActivitiesWithoutTimestamp.length} completed activity record(s) are missing completed_at.`,
    });

    const resolvedPlansWithOriginalAction =
      plans.filter(
        (plan) =>
          plan.resolution_status === "resolved" &&
          plan.action_key !== null &&
          readinessActions.some(
            (action) =>
              action.action_key ===
              plan.action_key
          )
      );

    nextChecks.push({
      id: "resolved-original-action",
      name: "Resolved Action Removal",
      description:
        "A resolved readiness-generated plan should not still have its exact original readiness action active.",
      status:
        resolvedPlansWithOriginalAction.length === 0
          ? "pass"
          : "fail",
      detail:
        resolvedPlansWithOriginalAction.length === 0
          ? "No resolved plan still has its original readiness action."
          : `${resolvedPlansWithOriginalAction.length} resolved plan(s) still have their original readiness action.`,
    });

    const practicalWaitingMismatch =
      plans.filter(
        (plan) =>
          (
            plan.action_type ===
              "PRACTICAL_VERIFICATION_NEEDED" ||
            plan.action_type ===
              "PRACTICAL_DEVELOPMENT_NEEDED"
          ) &&
          plan.resolution_status !== "resolved" &&
          plan.resolution_status !== "cancelled" &&
          plan.resolution_status !==
            "development_in_progress" &&
          plan.resolution_status !==
            "awaiting_verification"
      );

    nextChecks.push({
      id: "practical-lifecycle",
      name: "Practical Verification Lifecycle",
      description:
        "Practical plans should move only between development, awaiting verification, resolved, or cancelled.",
      status:
        practicalWaitingMismatch.length === 0
          ? "pass"
          : "fail",
      detail:
        practicalWaitingMismatch.length === 0
          ? "Practical verification plans are in valid lifecycle states."
          : `${practicalWaitingMismatch.length} practical plan(s) are in an unexpected lifecycle state.`,
    });

    const reverificationMismatch =
      plans.filter(
        (plan) =>
          (
            plan.action_type ===
              "REVERIFICATION_DUE_SOON" ||
            plan.action_type ===
              "REVERIFICATION_REQUIRED"
          ) &&
          plan.resolution_status !== "resolved" &&
          plan.resolution_status !== "cancelled" &&
          plan.resolution_status !==
            "development_in_progress" &&
          plan.resolution_status !==
            "awaiting_reverification"
      );

    nextChecks.push({
      id: "reverification-lifecycle",
      name: "Reverification Lifecycle",
      description:
        "Reverification plans should move only between development, awaiting reverification, resolved, or cancelled.",
      status:
        reverificationMismatch.length === 0
          ? "pass"
          : "fail",
      detail:
        reverificationMismatch.length === 0
          ? "Reverification plans are in valid lifecycle states."
          : `${reverificationMismatch.length} reverification plan(s) are in an unexpected lifecycle state.`,
    });

    const reassessmentMismatch =
      plans.filter(
        (plan) =>
          (
            plan.action_type ===
              "CRITICAL_SAFETY_GAP" ||
            plan.action_type ===
              "KNOWLEDGE_GAP" ||
            plan.action_type ===
              "KNOWLEDGE_DEVELOPMENT_NEEDED"
          ) &&
          plan.resolution_status !== "resolved" &&
          plan.resolution_status !== "cancelled" &&
          plan.resolution_status !==
            "development_in_progress" &&
          plan.resolution_status !==
            "awaiting_reassessment"
      );

    nextChecks.push({
      id: "reassessment-lifecycle",
      name: "Reassessment Lifecycle",
      description:
        "Knowledge and safety plans should move through development and reassessment before resolution.",
      status:
        reassessmentMismatch.length === 0
          ? "pass"
          : "fail",
      detail:
        reassessmentMismatch.length === 0
          ? "Reassessment-based plans are in valid lifecycle states."
          : `${reassessmentMismatch.length} reassessment plan(s) are in an unexpected lifecycle state.`,
    });

    const successorProtectedPlans =
      plans.filter(
        (plan) =>
          (
            plan.action_type ===
              "REVERIFICATION_DUE_SOON" ||
            plan.action_type ===
              "REVERIFICATION_REQUIRED"
          ) &&
          plan.resolution_status ===
            "development_in_progress" &&
          plan.master_competency_template_id !== null &&
          readinessActions.some(
            (action) =>
              action.employee_id ===
                plan.employee_id &&
              action.master_competency_template_id ===
                plan.master_competency_template_id &&
              (
                action.action_type ===
                  "PRACTICAL_DEVELOPMENT_NEEDED" ||
                action.action_type ===
                  "PRACTICAL_VERIFICATION_NEEDED"
              )
          )
      );

    nextChecks.push({
      id: "successor-action-protection",
      name: "Successor Action Protection",
      description:
        "Failed reverification may replace the original reverification action with a practical successor action without resolving the original plan.",
      status:
        "info",
      detail:
        successorProtectedPlans.length > 0
          ? `${successorProtectedPlans.length} plan(s) are currently demonstrating successor-action protection.`
          : "No live successor-action transition is currently present. This is normal when all test cases are resolved.",
    });

    return nextChecks;
  }, [
    plans,
    activities,
    readinessActions,
  ]);

  const scenarioCoverage =
    useMemo<ScenarioCoverage[]>(() => {
      const eventsByPlan =
        new Map<string, RegressionEvent[]>();

      for (const event of history) {
        const existing =
          eventsByPlan.get(
            event.development_plan_id
          ) ?? [];

        existing.push(event);

        eventsByPlan.set(
          event.development_plan_id,
          existing
        );
      }

      for (const events of eventsByPlan.values()) {
        events.sort(
          (a, b) =>
            new Date(a.event_at).getTime() -
            new Date(b.event_at).getTime()
        );
      }

      function containsOrderedSequence(
        values: Array<string | null>,
        sequence: string[]
      ) {
        let sequenceIndex = 0;

        for (const value of values) {
          if (
            value ===
            sequence[sequenceIndex]
          ) {
            sequenceIndex += 1;

            if (
              sequenceIndex ===
              sequence.length
            ) {
              return true;
            }
          }
        }

        return false;
      }

      function findLifecycleScenario(
        actionTypes: string[],
        sequence: string[]
      ) {
        let partial:
          | {
              planTitle: string;
              developmentPlanId: string;
            }
          | null = null;

        for (
          const [
            developmentPlanId,
            events,
          ] of eventsByPlan.entries()
        ) {
          const actionType =
            events.find(
              (event) =>
                event.action_type !== null
            )?.action_type ?? null;

          if (
            !actionType ||
            !actionTypes.includes(actionType)
          ) {
            continue;
          }

          const resolutionValues =
            events.map(
              (event) =>
                event.new_resolution_status
            );

          const planTitle =
            events[0]?.plan_title ??
            "Development Plan";

          if (
            containsOrderedSequence(
              resolutionValues,
              sequence
            )
          ) {
            return {
              status:
                "covered" as const,

              planTitle,

              developmentPlanId,
            };
          }

          if (!partial) {
            partial = {
              planTitle,
              developmentPlanId,
            };
          }
        }

        if (partial) {
          return {
            status:
              "partial" as const,

            ...partial,
          };
        }

        return {
          status:
            "not_tested" as const,

          planTitle: null,
          developmentPlanId: null,
        };
      }

      const reassessment =
        findLifecycleScenario(
          [
            "CRITICAL_SAFETY_GAP",
            "KNOWLEDGE_GAP",
            "KNOWLEDGE_DEVELOPMENT_NEEDED",
          ],
          [
            "awaiting_reassessment",
            "development_in_progress",
            "awaiting_reassessment",
            "resolved",
          ]
        );

      const practical =
        findLifecycleScenario(
          [
            "PRACTICAL_VERIFICATION_NEEDED",
            "PRACTICAL_DEVELOPMENT_NEEDED",
          ],
          [
            "awaiting_verification",
            "development_in_progress",
            "awaiting_verification",
            "resolved",
          ]
        );

      const reverification =
        findLifecycleScenario(
          [
            "REVERIFICATION_DUE_SOON",
            "REVERIFICATION_REQUIRED",
          ],
          [
            "awaiting_reverification",
            "development_in_progress",
            "awaiting_reverification",
            "resolved",
          ]
        );

      let successorEvent:
        RegressionEvent | null = null;

      for (const event of history) {
        if (
          (
            event.action_type ===
              "REVERIFICATION_DUE_SOON" ||
            event.action_type ===
              "REVERIFICATION_REQUIRED"
          ) &&
          (
            event.current_readiness_action_type ===
              "PRACTICAL_DEVELOPMENT_NEEDED" ||
            event.current_readiness_action_type ===
              "PRACTICAL_VERIFICATION_NEEDED"
          )
        ) {
          successorEvent = event;
          break;
        }
      }

      let cancellationEvent:
        RegressionEvent | null = null;

      for (const event of history) {
        if (
          event.new_resolution_status ===
            "cancelled" &&
          event.old_resolution_status !==
            "cancelled"
        ) {
          cancellationEvent = event;
          break;
        }
      }

      let manualResolvedEvent:
        RegressionEvent | null = null;

      for (const event of history) {
        if (
          event.action_type === null &&
          event.new_resolution_status ===
            "resolved"
        ) {
          manualResolvedEvent = event;
          break;
        }
      }

      return [
        {
          id:
            "reassessment-fail-pass",

          name:
            "Reassessment Fail → Redevelopment → Pass",

          description:
            "Development completes, reassessment fails, the same plan reopens for more development, then a later reassessment resolves it.",

          status:
            reassessment.status,

          detail:
            reassessment.status ===
            "covered"
              ? "Full reassessment fail-and-recovery lifecycle captured."
              : reassessment.status ===
                  "partial"
                ? "Reassessment history exists, but the complete fail → redevelopment → pass sequence has not been captured since history tracking began."
                : "No reassessment lifecycle has been captured since history tracking began.",

          planTitle:
            reassessment.planTitle,

          developmentPlanId:
            reassessment.developmentPlanId,
        },

        {
          id:
            "practical-fail-pass",

          name:
            "Practical Fail → Redevelopment → Pass",

          description:
            "Development completes, practical verification fails, prior activities remain intact, additional development occurs, and a later verification resolves the plan.",

          status:
            practical.status,

          detail:
            practical.status ===
            "covered"
              ? "Full practical verification fail-and-recovery lifecycle captured."
              : practical.status ===
                  "partial"
                ? "Practical verification history exists, but the complete fail → redevelopment → pass sequence has not been captured since history tracking began."
                : "No practical fail-and-recovery lifecycle has been captured since history tracking began.",

          planTitle:
            practical.planTitle,

          developmentPlanId:
            practical.developmentPlanId,
        },

        {
          id:
            "reverification-fail-pass",

          name:
            "Reverification Fail → Redevelopment → Pass",

          description:
            "A reverification fails, the original reverification plan reopens for development, then returns to awaiting reverification and ultimately resolves.",

          status:
            reverification.status,

          detail:
            reverification.status ===
            "covered"
              ? "Full reverification fail-and-recovery lifecycle captured."
              : reverification.status ===
                  "partial"
                ? "Reverification history exists, but the complete fail → redevelopment → pass sequence has not been captured since history tracking began."
                : "No reverification fail-and-recovery lifecycle has been captured since history tracking began.",

          planTitle:
            reverification.planTitle,

          developmentPlanId:
            reverification.developmentPlanId,
        },

        {
          id:
            "successor-action",

          name:
            "Reverification Successor Action",

          description:
            "A failed reverification changes the live readiness action to a practical successor action without falsely resolving the original reverification plan.",

          status:
            successorEvent
              ? "covered"
              : "not_tested",

          detail:
            successorEvent
              ? `Captured successor action: ${formatActionType(
                  successorEvent.current_readiness_action_type
                )}.`
              : "No reverification successor-action transition has been captured since history tracking began.",

          planTitle:
            successorEvent?.plan_title ??
            null,

          developmentPlanId:
            successorEvent?.development_plan_id ??
            null,
        },

        {
          id:
            "cancellation",

          name:
            "Development Plan Cancellation",

          description:
            "An active Development Plan transitions to the cancelled lifecycle state and remains terminal.",

          status:
            cancellationEvent
              ? "covered"
              : "not_tested",

          detail:
            cancellationEvent
              ? "Cancellation transition captured successfully."
              : "No Development Plan cancellation has been captured since history tracking began.",

          planTitle:
            cancellationEvent?.plan_title ??
            null,

          developmentPlanId:
            cancellationEvent?.development_plan_id ??
            null,
        },

        {
          id:
            "manual-resolution",

          name:
            "Manual Plan Resolution",

          description:
            "A manager-created Development Plan with no readiness action resolves after all active development activities are completed.",

          status:
            manualResolvedEvent
              ? "covered"
              : "not_tested",

          detail:
            manualResolvedEvent
              ? "Manual Development Plan resolution captured successfully."
              : "No manual Development Plan resolution has been captured since history tracking began.",

          planTitle:
            manualResolvedEvent?.plan_title ??
            null,

          developmentPlanId:
            manualResolvedEvent?.development_plan_id ??
            null,
        },
      ];
    }, [history]);


  const employeeSummaries =
    useMemo<EmployeeSummary[]>(() => {
      return employees.map((employee) => {
        const employeePlans =
          plans.filter(
            (plan) =>
              plan.employee_id ===
              employee.id
          );

        const employeeActions =
          readinessActions.filter(
            (action) =>
              action.employee_id ===
              employee.id
          );

        return {
          employee,
          planCount:
            employeePlans.length,

          activePlanCount:
            employeePlans.filter(
              (plan) =>
                plan.resolution_status ===
                  "development_in_progress"
            ).length,

          awaitingEvidenceCount:
            employeePlans.filter(
              (plan) =>
                plan.resolution_status !== null &&
                waitingStatuses.includes(
                  plan.resolution_status
                )
            ).length,

          resolvedPlanCount:
            employeePlans.filter(
              (plan) =>
                plan.resolution_status ===
                  "resolved"
            ).length,

          readinessActionCount:
            employeeActions.length,
        };
      });
    }, [
      employees,
      plans,
      readinessActions,
    ]);

  const failingChecks =
    checks.filter(
      (check) => check.status === "fail"
    ).length;

  const passingChecks =
    checks.filter(
      (check) => check.status === "pass"
    ).length;

  const awaitingEvidencePlans =
    plans.filter(
      (plan) =>
        plan.resolution_status !== null &&
        waitingStatuses.includes(
          plan.resolution_status
        )
    ).length;

  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">
      <div className="mx-auto max-w-7xl">
        <SystemHeader
          title="System Testing"
          subtitle="IntegrateU Admin regression workspace for workforce-readiness workflows."
          backHref="/dashboard"
          backLabel="Dashboard"
          showHome={true}
          showSignOut={true}
        />

        {message && (
          <div className="mb-8 rounded-2xl border border-slate-800 bg-slate-900 p-6 text-slate-300">
            {message}
          </div>
        )}

        <section className="mb-12">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
                Regression Control Center
              </p>

              <h2 className="mt-2 text-2xl font-semibold">
                Lifecycle Health
              </h2>

              <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
                Live database checks for Development Plan,
                reassessment, practical verification, and
                reverification lifecycle integrity.
              </p>

              {lastLoadedAt && (
                <p className="mt-2 text-xs text-slate-500">
                  Last refreshed{" "}
                  {lastLoadedAt.toLocaleTimeString()}
                </p>
              )}
            </div>

            <button
              type="button"
              onClick={loadPage}
              disabled={loading}
              className="rounded-lg bg-cyan-400 px-5 py-2.5 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300 disabled:cursor-not-allowed disabled:opacity-50"
            >
              {loading
                ? "Refreshing..."
                : "Refresh Tests"}
            </button>
          </div>

          <div className="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
            <MetricCard
              label="Test Employees"
              value={employees.length}
            />

            <MetricCard
              label="Development Plans"
              value={plans.length}
            />

            <MetricCard
              label="Awaiting Evidence"
              value={awaitingEvidencePlans}
            />

            <MetricCard
              label="Checks Passing"
              value={passingChecks}
            />

            <MetricCard
              label="Checks Failing"
              value={failingChecks}
              alert={failingChecks > 0}
            />
          </div>

          <div className="mt-6 grid gap-4 lg:grid-cols-2">
            {checks.map((check) => (
              <RegressionCheckCard
                key={check.id}
                check={check}
              />
            ))}
          </div>
        </section>

        <section className="mb-12">
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-emerald-400">
              Test Coverage
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Lifecycle Scenario Coverage
            </h2>

            <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
              Coverage is based only on durable regression
              events captured after history tracking was
              enabled. Earlier manual testing is not inferred.
            </p>
          </div>

          <div className="grid gap-4 lg:grid-cols-2 xl:grid-cols-3">
            {scenarioCoverage.map(
              (scenario) => (
                <ScenarioCoverageCard
                  key={scenario.id}
                  scenario={scenario}
                />
              )
            )}
          </div>
        </section>


        <section className="mb-12">
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-violet-400">
              Durable Evidence
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Regression Test History
            </h2>

            <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
              Automatically recorded Development Plan lifecycle
              transitions for TEST employees. History begins when
              regression tracking was enabled.
            </p>
          </div>

          {history.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">
              <p className="font-medium">
                No regression events recorded yet.
              </p>

              <p className="mt-2 text-sm text-slate-400">
                New TEST employee Development Plan transitions
                will appear here automatically.
              </p>
            </div>
          ) : (
            <div className="overflow-hidden rounded-2xl border border-slate-800 bg-slate-900">
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-slate-800">
                  <thead className="bg-slate-950">
                    <tr>
                      <TableHeader>Time</TableHeader>
                      <TableHeader>Employee</TableHeader>
                      <TableHeader>Plan</TableHeader>
                      <TableHeader>Event</TableHeader>
                      <TableHeader>
                        Resolution Transition
                      </TableHeader>
                      <TableHeader>
                        Current Readiness Action
                      </TableHeader>
                    </tr>
                  </thead>

                  <tbody className="divide-y divide-slate-800">
                    {history.map((event) => (
                      <tr
                        key={event.id}
                        className="align-top"
                      >
                        <TableCell>
                          <p className="whitespace-nowrap text-sm text-slate-300">
                            {new Date(
                              event.event_at
                            ).toLocaleString()}
                          </p>
                        </TableCell>

                        <TableCell>
                          <p className="font-medium text-white">
                            {event.first_name}{" "}
                            {event.last_name}
                          </p>

                          <p className="mt-1 text-xs text-slate-500">
                            {event.employee_number ??
                              "No employee number"}
                          </p>
                        </TableCell>

                        <TableCell>
                          <Link
                            href={`/development-plans/${event.development_plan_id}`}
                            className="font-medium text-cyan-300 hover:text-cyan-200"
                          >
                            {event.plan_title}
                          </Link>

                          <p className="mt-1 text-xs text-slate-500">
                            {formatActionType(
                              event.action_type
                            )}
                          </p>
                        </TableCell>

                        <TableCell>
                          <EventBadge
                            eventType={
                              event.event_type
                            }
                          />
                        </TableCell>

                        <TableCell>
                          <ResolutionTransition
                            oldValue={
                              event.old_resolution_status
                            }
                            newValue={
                              event.new_resolution_status
                            }
                          />
                        </TableCell>

                        <TableCell>
                          {event.current_readiness_action_type ? (
                            <span className="inline-flex rounded-full bg-cyan-500/10 px-3 py-1 text-xs font-medium text-cyan-300">
                              {formatActionType(
                                event.current_readiness_action_type
                              )}
                            </span>
                          ) : (
                            <span className="text-sm text-slate-500">
                              None
                            </span>
                          )}
                        </TableCell>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </section>


        <section>
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
              Admin Only
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Workflow Testing
            </h2>

            <p className="mt-2 max-w-3xl text-sm leading-6 text-slate-400">
              Jump directly into each part of the
              readiness lifecycle.
            </p>
          </div>

          <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
            <TestingCard
              href="/assessments"
              eyebrow="Assessments"
              title="Assessment Center"
              description="Test assessment attempts, reassessments, and results."
            />

            <TestingCard
              href="/readiness-actions"
              eyebrow="Readiness"
              title="Readiness Actions"
              description="Review live generated readiness actions and successor actions."
            />

            <TestingCard
              href="/development-plans"
              eyebrow="Development"
              title="Development Plans"
              description="Test plan creation, activities, completion, evidence states, resolution, and cancellation."
            />

            <TestingCard
              href="/verify"
              eyebrow="Verification"
              title="Verify Employees"
              description="Test practical verification and reverification workflows."
            />

            <TestingCard
              href="/admin/verifiers"
              eyebrow="Administration"
              title="Verifier Management"
              description="Manage verifier assignments and test authorization."
            />

            <TestingCard
              href="/admin/library"
              eyebrow="Configuration"
              title="Master Library"
              description="Review roles, competencies, industries, assessments, and reverification settings."
            />
          </div>
        </section>

        <section className="mt-12">
          <div className="mb-5">
            <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
              Test Accounts
            </p>

            <h2 className="mt-2 text-2xl font-semibold">
              Test Employees
            </h2>

            <p className="mt-2 text-sm text-slate-400">
              Employees with TEST in their employee
              number appear here automatically.
            </p>
          </div>

          {employees.length === 0 ? (
            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">
              <p className="font-medium">
                No test employees found.
              </p>
            </div>
          ) : (
            <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
              {employeeSummaries.map(
                (summary) => (
                  <article
                    key={summary.employee.id}
                    className="rounded-2xl border border-slate-800 bg-slate-900 p-6"
                  >
                    <p className="text-xs font-medium uppercase tracking-wide text-cyan-400">
                      Test Employee
                    </p>

                    <h3 className="mt-2 text-xl font-semibold">
                      {summary.employee.first_name}{" "}
                      {summary.employee.last_name}
                    </h3>

                    <p className="mt-2 text-sm text-slate-400">
                      {summary.employee.employee_number ??
                        "No employee number"}
                    </p>

                    <p className="mt-1 text-xs text-slate-500">
                      {summary.employee.auth_user_id
                        ? "Login linked"
                        : "No login linked"}
                    </p>

                    <div className="mt-5 grid grid-cols-2 gap-3">
                      <EmployeeMetric
                        label="Plans"
                        value={summary.planCount}
                      />

                      <EmployeeMetric
                        label="In Development"
                        value={
                          summary.activePlanCount
                        }
                      />

                      <EmployeeMetric
                        label="Awaiting Evidence"
                        value={
                          summary.awaitingEvidenceCount
                        }
                      />

                      <EmployeeMetric
                        label="Readiness Actions"
                        value={
                          summary.readinessActionCount
                        }
                      />
                    </div>

                    <p className="mt-4 text-xs text-slate-500">
                      Resolved plans:{" "}
                      {summary.resolvedPlanCount}
                    </p>

                    <div className="mt-5 flex flex-wrap gap-3">
                      <Link
                        href={`/employees/${summary.employee.id}`}
                        className="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-slate-950 transition hover:bg-cyan-300"
                      >
                        Employee Profile
                      </Link>

                      <Link
                        href={`/employees/${summary.employee.id}/practical-verification`}
                        className="rounded-lg border border-slate-700 px-4 py-2 text-sm font-medium text-slate-200 transition hover:border-slate-500 hover:bg-slate-800 hover:text-white"
                      >
                        Practical Verification
                      </Link>
                    </div>
                  </article>
                )
              )}
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

function MetricCard({
  label,
  value,
  alert = false,
}: {
  label: string;
  value: number;
  alert?: boolean;
}) {
  return (
    <div
      className={`rounded-2xl border p-5 ${
        alert
          ? "border-red-500/40 bg-red-950/20"
          : "border-slate-800 bg-slate-900"
      }`}
    >
      <p className="text-xs font-medium uppercase tracking-wide text-slate-500">
        {label}
      </p>

      <p
        className={`mt-2 text-3xl font-semibold ${
          alert
            ? "text-red-300"
            : "text-white"
        }`}
      >
        {value}
      </p>
    </div>
  );
}

function RegressionCheckCard({
  check,
}: {
  check: RegressionCheck;
}) {
  const styles =
    check.status === "pass"
      ? {
          border:
            "border-emerald-500/30",
          badge:
            "bg-emerald-500/10 text-emerald-300",
          label: "PASS",
        }
      : check.status === "fail"
        ? {
            border:
              "border-red-500/40",
            badge:
              "bg-red-500/10 text-red-300",
            label: "FAIL",
          }
        : {
            border:
              "border-cyan-500/30",
            badge:
              "bg-cyan-500/10 text-cyan-300",
            label: "INFO",
          };

  return (
    <article
      className={`rounded-2xl border bg-slate-900 p-6 ${styles.border}`}
    >
      <div className="flex items-start justify-between gap-4">
        <div>
          <h3 className="text-lg font-semibold text-white">
            {check.name}
          </h3>

          <p className="mt-2 text-sm leading-6 text-slate-400">
            {check.description}
          </p>
        </div>

        <span
          className={`shrink-0 rounded-full px-3 py-1 text-xs font-semibold ${styles.badge}`}
        >
          {styles.label}
        </span>
      </div>

      <p className="mt-4 text-sm text-slate-300">
        {check.detail}
      </p>
    </article>
  );
}

function formatActionType(
  value: string | null
) {
  if (!value) {
    return "Manual Plan";
  }

  return value
    .toLowerCase()
    .split("_")
    .map(
      (word) =>
        word.charAt(0).toUpperCase() +
        word.slice(1)
    )
    .join(" ");
}


function ScenarioCoverageCard({
  scenario,
}: {
  scenario: ScenarioCoverage;
}) {
  const styles =
    scenario.status === "covered"
      ? {
          border:
            "border-emerald-500/30",
          badge:
            "bg-emerald-500/10 text-emerald-300",
          label:
            "COVERED",
        }
      : scenario.status === "partial"
        ? {
            border:
              "border-amber-500/30",
            badge:
              "bg-amber-500/10 text-amber-300",
            label:
              "PARTIAL",
          }
        : {
            border:
              "border-slate-700",
            badge:
              "bg-slate-800 text-slate-400",
            label:
              "NOT YET TESTED",
          };

  return (
    <article
      className={`rounded-2xl border bg-slate-900 p-6 ${styles.border}`}
    >
      <div className="flex items-start justify-between gap-4">
        <div>
          <h3 className="text-lg font-semibold text-white">
            {scenario.name}
          </h3>

          <p className="mt-2 text-sm leading-6 text-slate-400">
            {scenario.description}
          </p>
        </div>

        <span
          className={`shrink-0 rounded-full px-3 py-1 text-[11px] font-semibold ${styles.badge}`}
        >
          {styles.label}
        </span>
      </div>

      <p className="mt-4 text-sm text-slate-300">
        {scenario.detail}
      </p>

      {scenario.developmentPlanId &&
        scenario.planTitle && (
          <Link
            href={`/development-plans/${scenario.developmentPlanId}`}
            className="mt-4 inline-flex text-sm font-medium text-cyan-300 hover:text-cyan-200"
          >
            Open {scenario.planTitle} →
          </Link>
        )}
    </article>
  );
}


function EventBadge({
  eventType,
}: {
  eventType: string;
}) {
  const isCreated =
    eventType === "plan_created";

  return (
    <span
      className={`inline-flex rounded-full px-3 py-1 text-xs font-semibold ${
        isCreated
          ? "bg-violet-500/10 text-violet-300"
          : "bg-slate-700 text-slate-200"
      }`}
    >
      {isCreated
        ? "Plan Created"
        : "Lifecycle Transition"}
    </span>
  );
}


function ResolutionTransition({
  oldValue,
  newValue,
}: {
  oldValue: string | null;
  newValue: string | null;
}) {
  return (
    <div className="flex min-w-[220px] items-center gap-2 text-sm">
      <span className="rounded-md bg-slate-950 px-2 py-1 text-slate-400">
        {oldValue ?? "None"}
      </span>

      <span className="text-slate-600">
        →
      </span>

      <span className="rounded-md bg-slate-800 px-2 py-1 font-medium text-white">
        {newValue ?? "None"}
      </span>
    </div>
  );
}


function TableHeader({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <th
      scope="col"
      className="px-5 py-4 text-left text-xs font-semibold uppercase tracking-wide text-slate-500"
    >
      {children}
    </th>
  );
}


function TableCell({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <td className="px-5 py-4">
      {children}
    </td>
  );
}


function EmployeeMetric({
  label,
  value,
}: {
  label: string;
  value: number;
}) {
  return (
    <div className="rounded-xl border border-slate-800 bg-slate-950 p-3">
      <p className="text-xs text-slate-500">
        {label}
      </p>

      <p className="mt-1 text-lg font-semibold text-white">
        {value}
      </p>
    </div>
  );
}

function TestingCard({
  href,
  eyebrow,
  title,
  description,
}: {
  href: string;
  eyebrow: string;
  title: string;
  description: string;
}) {
  return (
    <Link
      href={href}
      className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
    >
      <p className="text-sm font-medium text-cyan-400">
        {eyebrow}
      </p>

      <h3 className="mt-2 text-xl font-semibold">
        {title}
      </h3>

      <p className="mt-2 text-sm leading-6 text-slate-400">
        {description}
      </p>

      <p className="mt-5 text-sm font-medium text-cyan-400">
        Open →
      </p>
    </Link>
  );
}
