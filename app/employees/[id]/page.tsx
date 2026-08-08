"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";


type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
  client_id: string;
};


type Readiness = {
  status: string;
  readiness_percent: number;
  requirements_met: number;
  requirements_total: number;
  competencies_met: number;
  competencies_total: number;
};


export default function EmployeePage() {

  const params = useParams();
  const router = useRouter();

  const employeeId = params.id as string;


  const [employee, setEmployee] =
    useState<Employee | null>(null);

  const [readiness, setReadiness] =
    useState<Readiness | null>(null);

  const [message, setMessage] =
    useState("Loading...");



  useEffect(() => {


    async function loadEmployee() {


      const {
        data: sessionData
      } = await supabase.auth.getSession();


      if (!sessionData.session) {

        router.push("/");

        return;

      }


      const userId =
        sessionData.session.user.id;



      const {
        data: roles
      } =
      await supabase
        .from("user_client_roles")
        .select(
          "role, client_id"
        )
        .eq(
          "user_id",
          userId
        );



      const isAdmin =
        roles?.some(
          r => r.role === "INTEGRATEU_ADMIN"
        );


      const allowedClients =
        roles
          ?.filter(
            r => r.role === "CLIENT_ADMIN"
          )
          .map(
            r => r.client_id
          ) ?? [];



      console.log(
        "URL EMPLOYEE:",
        employeeId
      );


      const {
        data: employeeData,
        error
      } =
      await supabase
        .from("employees")
        .select(
          `
          id,
          first_name,
          last_name,
          employee_number,
          client_id
          `
        )
        .eq(
          "id",
          employeeId
        )
        .maybeSingle();



      console.log(
        "FOUND EMPLOYEE:",
        employeeData
      );


      if (
        error ||
        !employeeData
      ) {

        setMessage(
          "Employee not found or access denied."
        );

        return;

      }



      if (
        !isAdmin &&
        !allowedClients.includes(
          employeeData.client_id
        )
      ) {

        setMessage(
          "Employee not found or access denied."
        );

        return;

      }



      setEmployee(
        employeeData
      );



      const {
        data: readinessData
      } =
      await supabase
        .from("role_readiness")
        .select(
          `
          status,
          readiness_percent,
          requirements_met,
          requirements_total,
          competencies_met,
          competencies_total
          `
        )
        .eq(
          "employee_id",
          employeeId
        )
        .maybeSingle();



      setReadiness(
        readinessData
      );


      setMessage("");

    }



    loadEmployee();


  }, [employeeId, router]);




  async function logout() {

    await supabase.auth.signOut();

    router.push("/");

  }




  return (

    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">

      <div className="mx-auto max-w-5xl">


        <div className="mb-10 flex justify-between">

          <div>

            <p className="text-cyan-400">
              IntegrateU
            </p>

            <h1 className="text-4xl font-bold">
              Role Readiness
            </h1>

          </div>


          <button
            onClick={logout}
            className="rounded-lg border border-slate-700 px-4 py-2"
          >
            Sign Out
          </button>


        </div>



        {message && (

          <div className="rounded-xl bg-slate-900 p-6">

            {message}

          </div>

        )}




        {employee && (

          <div className="rounded-2xl bg-slate-900 p-8">


            <p className="text-slate-400">
              Employee
            </p>


            <h2 className="text-3xl font-bold">

              {employee.first_name} {employee.last_name}

            </h2>


            <p className="text-slate-400">

              {employee.employee_number}

            </p>



            {readiness && (

              <div className="mt-8">

                <p>
                  Readiness
                </p>


                <div className="text-6xl font-bold">

                  {readiness.readiness_percent}%

                </div>


                <div className="mt-4 text-emerald-300">

                  {readiness.status}

                </div>


              </div>

            )}



          </div>

        )}



        <Link
          href="/dashboard"
          className="mt-6 block text-cyan-400"
        >
          ← Back to Dashboard
        </Link>



      </div>

    </main>

  );


}
