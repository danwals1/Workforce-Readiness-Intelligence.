"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

export type AdminGuardStatus = "checking" | "authorized" | "denied";

/**
 * Same check already used inline in app/dashboard/page.tsx and
 * app/employees/[id]/page.tsx (session -> user_client_roles -> role ===
 * 'INTEGRATEU_ADMIN'), centralized so every /admin page doesn't repeat it.
 * RLS on the master_* tables enforces the same rule server-side — this
 * hook only gates the UI; it is not the security boundary by itself.
 */
export function useIntegrateAdminGuard(): AdminGuardStatus {
  const router = useRouter();
  const [status, setStatus] = useState<AdminGuardStatus>("checking");

  useEffect(() => {
    let active = true;

    async function check() {
      const { data: sessionData } = await supabase.auth.getSession();

      if (!sessionData.session) {
        router.push("/");
        return;
      }

      const userId = sessionData.session.user.id;

      const { data: roles, error } = await supabase
        .from("user_client_roles")
        .select("role")
        .eq("user_id", userId);

      if (!active) return;

      if (error) {
        setStatus("denied");
        return;
      }

      const isAdmin = roles?.some((r) => r.role === "INTEGRATEU_ADMIN") ?? false;
      setStatus(isAdmin ? "authorized" : "denied");
    }

    check();

    return () => {
      active = false;
    };
  }, [router]);

  return status;
}

/** One-off check (no redirect) — used by app/dashboard/page.tsx to decide
 * whether to show the Master Library link, without duplicating this query. */
export async function checkIsIntegrateAdmin(): Promise<boolean> {
  const { data: sessionData } = await supabase.auth.getSession();
  if (!sessionData.session) return false;

  const { data: roles } = await supabase
    .from("user_client_roles")
    .select("role")
    .eq("user_id", sessionData.session.user.id);

  return roles?.some((r) => r.role === "INTEGRATEU_ADMIN") ?? false;
}
