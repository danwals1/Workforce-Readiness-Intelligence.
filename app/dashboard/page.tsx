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



  async function handleLogout() {

    await supabase.auth.signOut();

    router.push("/");

  }



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
        data: roles,
        error: rolesError
      } =
      await supabase
        .from("user_client_roles")
        .select(
          `
          role,
          client_id
          `
        )
        .eq(
          "user_id",
          userId
        );



      if (rolesError) {

        setMessage(
          rolesError.message
        );

        return;

      }

const {
  data: access,
  error: accessError,
} = await supabase
  .from("user_client_roles")
  .select("client_id")
  .eq("user_id", user.id);

if (accessError) {
  console.error("ACCESS ERROR:", accessError);
  setError("Access check failed");
  return;
}

const allowedClients = access.map(
  (item) => item.client_id
);

console.log("Allowed clients:", allowedClients);
console.log("Employee client:", employee.client_id);

if (!allowedClients.includes(employee.client_id)) {
  setError("Employee not found or access denied.");
  return;
}

      const isIntegrateAdmin =
        roles?.some(
          (r) =>
            r.role === "INTEGRATEU_ADMIN"
        );



      const allowedClients =
        roles
          ?.filter(
            (r) =>
              r.role === "CLIENT_ADMIN"
          )
          .map(
            (r) =>
              r.client_id
          ) ?? [];




      console.log(
        "REQUESTED EMPLOYEE:",
        employeeId
      );

      console.log(
        "ALLOWED CLIENTS:",
        allowedClients
      );




      /*
        IMPORTANT:
        Load ONLY the employee from the URL.
        Do not load first employee.
        Do not load employee list.
      */


      const {
        data: employeeData,
        error: employeeError
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




      if (
        employeeError ||
        !employeeData
      ) {

        setMessage(
          "Employee not found or access denied."
        );

        return;

      }




      if (
        !isIntegrateAdmin &&
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
      }
      =
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
        .order(
          "created_at",
          {
            ascending: false
          }
        )
        .limit(1)
        .maybeSingle();



      if (readinessData) {

        setReadiness(
          readinessData
        );

      }



      setMessage("");

    }



    loadEmployee();


  }, [employeeId, router]);







  return (

    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">


      <div className="mx-auto max-w-5xl">



        <div className="mb-10 flex justify-between">


          <div>

            <p className="text-cyan-400">
              IntegrateU
            </p>


            <h1 className="mt-2 text-4xl font-bold">
              Role Readiness
            </h1>


          </div>




          <button

            onClick={handleLogout}

            className="rounded-lg border border-slate-700 px-4 py-2 hover:bg-slate-800"

          >

            Sign Out

          </button>



        </div>






        {message && (

          <div className="rounded-xl border border-slate-800 bg-slate-900 p-6">

            {message}

          </div>

        )}







        {employee && (


          <div className="space-y-6">



            <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">


              <p className="text-sm text-slate-400">
                Employee
              </p>



              <h2 className="mt-2 text-3xl font-bold">

                {employee.first_name}{" "}

                {employee.last_name}

              </h2>




              <p className="mt-2 text-slate-400">

                {employee.employee_number}

              </p>



            </div>







            {readiness && (


              <div className="rounded-2xl border border-slate-800 bg-slate-900 p-8">



                <div className="flex justify-between">


                  <div>


                    <p className="text-sm text-slate-400">
                      Readiness
                    </p>


                    <p className="text-6xl font-bold">

                      {readiness.readiness_percent}%

                    </p>


                  </div>




                  <span className="rounded-full bg-emerald-500/20 px-4 py-2 text-emerald-300">

                    {readiness.status}

                  </span>



                </div>





                <div className="mt-6 h-3 rounded-full bg-slate-800">


                  <div

                    className="h-full rounded-full bg-cyan-400"

                    style={{
                      width:
                      `${readiness.readiness_percent}%`
                    }}

                  />


                </div>





                <div className="mt-8 grid grid-cols-2 gap-6">


                  <div>

                    <p className="text-slate-400">
                      Requirements
                    </p>

                    <p className="text-3xl font-bold">

                      {readiness.requirements_met}/
                      {readiness.requirements_total}

                    </p>


                  </div>



                  <div>

                    <p className="text-slate-400">
                      Competencies
                    </p>


                    <p className="text-3xl font-bold">

                      {readiness.competencies_met}/
                      {readiness.competencies_total}

                    </p>


                  </div>



                </div>



              </div>


            )}



            <Link

              href="/dashboard"

              className="text-cyan-400"

            >

              ← Back to Dashboard

            </Link>




          </div>


        )}



      </div>


    </main>

  );


}