"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import AppShell from "@/components/AppShell";
import { supabase } from "@/lib/supabase";

type SystemLayoutProps = {
  children: React.ReactNode;
};

type UserClientRole = {
  role: string;
  client_id: string | null;
};

type VerificationAssignment = {
  employee_id: string;
};

type LoggedInEmployee = {
  first_name: string;
  last_name: string;
  email: string | null;
};

export default function SystemLayout({
  children,
}: SystemLayoutProps) {
  const router = useRouter();

  const [loading, setLoading] = useState(true);
  const [isIntegrateAdmin, setIsIntegrateAdmin] =
    useState(false);
  const [isClientAdmin, setIsClientAdmin] =
    useState(false);
  const [canVerify, setCanVerify] =
    useState(false);

  const [displayName, setDisplayName] =
    useState("");

  const [accountEmail, setAccountEmail] =
    useState("");

  const [accessLabel, setAccessLabel] =
    useState("Employee");

  useEffect(() => {
    async function loadShellAccess() {
      const {
        data: sessionData,
        error: sessionError,
      } = await supabase.auth.getSession();

      if (
        sessionError ||
        !sessionData.session
      ) {
        router.push("/");
        return;
      }

      const userId =
        sessionData.session.user.id;

      const sessionEmail =
        sessionData.session.user.email ?? "";

      setAccountEmail(sessionEmail);

      const {
        data: employeeData,
        error: employeeError,
      } = await supabase
        .from("employees")
        .select(`
          first_name,
          last_name,
          email
        `)
        .eq("auth_user_id", userId)
        .maybeSingle();

      if (employeeError) {
        console.error(
          "Unable to load logged-in employee:",
          employeeError
        );
      }

      const employee =
        employeeData as LoggedInEmployee | null;

      if (employee) {
        setDisplayName(
          `${employee.first_name} ${employee.last_name}`.trim()
        );
      }

      const {
        data: roles,
        error: rolesError,
      } = await supabase
        .from("user_client_roles")
        .select(`
          role,
          client_id
        `)
        .eq("user_id", userId);

      if (rolesError) {
        console.error(
          "Unable to load system roles:",
          rolesError
        );
      }

      const typedRoles =
        (roles ?? []) as UserClientRole[];

      setIsIntegrateAdmin(
        typedRoles.some(
          (role) =>
            role.role ===
              "INTEGRATEU_ADMIN" ||
            role.role ===
              "INTEGRATEU_SUPER_ADMIN"
        )
      );

      const integrateAdmin =
        typedRoles.some(
          (role) =>
            role.role ===
              "INTEGRATEU_ADMIN" ||
            role.role ===
              "INTEGRATEU_SUPER_ADMIN"
        );

      const clientAdmin =
        typedRoles.some(
          (role) =>
            role.role ===
              "CLIENT_ADMIN" &&
            Boolean(role.client_id)
        );

      setIsIntegrateAdmin(
        integrateAdmin
      );

      setIsClientAdmin(
        clientAdmin
      );

      const {
        data: verifierData,
        error: verifierError,
      } = await supabase.rpc(
        "wri_list_my_verification_employees"
      );

      let verifierAccess = false;

      if (verifierError) {
        console.error(
          "Unable to load verifier access:",
          verifierError
        );
      } else {
        verifierAccess =
          (
            (verifierData ?? []) as
              VerificationAssignment[]
          ).length > 0;
      }

      setCanVerify(
        verifierAccess
      );

      if (integrateAdmin) {
        setAccessLabel(
          "IntegrateU Admin"
        );

        if (!employee) {
          setDisplayName(
            sessionEmail
          );
        }
      } else if (
        clientAdmin &&
        verifierAccess
      ) {
        setAccessLabel(
          "Company Admin · Verifier"
        );
      } else if (clientAdmin) {
        setAccessLabel(
          "Company Admin"
        );
      } else if (verifierAccess) {
        setAccessLabel(
          "Verifier"
        );
      } else {
        setAccessLabel(
          "Employee"
        );
      }

      if (!employee && !integrateAdmin) {
        setDisplayName(
          clientAdmin
            ? "Company Admin"
            : verifierAccess
              ? "Verifier"
              : "Employee"
        );
      }

      setLoading(false);
    }

    loadShellAccess();
  }, [router]);

  if (loading) {
    return (
      <div className="min-h-screen bg-[var(--page-background)] p-8 text-[var(--text-secondary)]">
        Loading RISE...
      </div>
    );
  }

  return (
    <AppShell
      isIntegrateAdmin={isIntegrateAdmin}
      isClientAdmin={isClientAdmin}
      canVerify={canVerify}
      displayName={displayName}
      accountEmail={accountEmail}
      accessLabel={accessLabel}
    >
      {children}
    </AppShell>
  );
}
