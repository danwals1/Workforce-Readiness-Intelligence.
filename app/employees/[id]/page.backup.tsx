"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type Employee = {
  id: string;
  first_name: string;
  last_name: string;
  employee_number: string | null;
};

type Readiness = {
  employee_id: string;
  status: string;
  readiness_percent: number;
  requirements_met: number;
  requirements_total: number;
  competencies_met: number;
  competencies_total: number;
};

type EmployeeWithReadiness = Employee & {
  readiness: Readiness | null;
};


export default function DashboardPage() {

  const router = useRouter();


  const [employees, setEmployees] =
    useState<EmployeeWithReadiness[]>([]);


  const [message, setMessage] =
    useState("Loading...");



  async function handleLogout() {

    await supabase.auth.signOut();

    router.push("/");

  }



  useEffect(() => {


    async function loadDashboard() {


      const {
        data: sessionData
      } = await supabase.auth.getSession();



      if (!sessionData.session) {

        setMessage(
          "Not signed in."
        );

        return;

      }



      const userId =
        sessionData.session.user.id;




      const {
        data: roles,
        error: rolesError
      } = await supabase
        .from("user_client_roles")
        .select(`
          role,
          client_id
        `)
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




      const isIntegrateAdmin =
        roles?.some(
          (role) =>
            role.role === "INTEGRATEU_ADMIN"
        );



      const clientIds =
        roles
          ?.filter(
            (role) =>
              role.role === "CLIENT_ADMIN"
          )
          .map(
            (role) =>
              role.client_id
          ) ?? [];




      let employeeQuery =
        supabase
          .from("employees")
          .select(`
            id,
            first_name,
            last_name,
            employee_number,
            client_id,
            auth_user_id
          `);




      if (isIntegrateAdmin) {


        // IntegrateU admins see all employees


      } else if (clientIds.length > 0) {


        employeeQuery =
          employeeQuery.in(
            "client_id",
            clientIds
          );


      } else {


        employeeQuery =
          employeeQuery.eq(
            "auth_user_id",
            userId
          );


      }



      const {
        data: employeeData,
        error: employeeError
      } =
        await employeeQuery;




      if (employeeError) {

        setMessage(
          employeeError.message
        );

        return;

      }




      if (
        !employeeData ||
        employeeData.length === 0
      ) {

        setMessage(
          "No team members have been added to this client yet."
        );

        return;

      }



      const employeeIds =
        employeeData.map(
          (employee) =>
            employee.id
        );




      const {
        data: readinessData,
        error: readinessError
      } =
        await supabase
          .from("role_readiness")
          .select(`
            employee_id,
            status,
            readiness_percent,
            requirements_met,
            requirements_total,
            competencies_met,
            competencies_total
          `)
          .in(
            "employee_id",
            employeeIds
          );



      if (readinessError) {

        setMessage(
          readinessError.message
        );

        return;

      }



      const combined =
        employeeData.map(
          (employee) => ({

            id: employee.id,

            first_name:
              employee.first_name,

            last_name:
              employee.last_name,

            employee_number:
              employee.employee_number,


            readiness:
              readinessData?.find(
                (row) =>
                  row.employee_id === employee.id
              ) ?? null

          })
        );



      setEmployees(
        combined
      );


      setMessage("");

    }



    loadDashboard();


  }, []);



  return (
    <main className="min-h-screen bg-slate-950 px-6 py-10 text-white">

      <div className="mx-auto max-w-6xl">


        <div className="mb-10 flex items-start justify-between">


          <div>

            <p className="text-sm font-medium text-cyan-400">
              IntegrateU
            </p>


            <h1 className="mt-2 text-3xl font-semibold">
              Role Readiness
            </h1>


            <p className="mt-2 text-slate-400">
              Team overview
            </p>


          </div>



          <button
            onClick={handleLogout}
            className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-300 hover:bg-slate-800"
          >
            Sign Out
          </button>


        </div>




        {message && (

          <div className="rounded-xl border border-slate-800 bg-slate-900 p-6 text-slate-300">

            {message}

          </div>

        )}






        {employees.length > 0 && (

          <div className="grid gap-6 md:grid-cols-2">


            {employees.map((employee) => (


              <Link
                key={employee.id}
                href={`/employees/${employee.id}`}
                className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-cyan-400"
              >


                <p className="text-sm text-slate-400">
                  Employee
                </p>



                <h2 className="mt-1 text-2xl font-semibold">

                  {employee.first_name}{" "}
                  {employee.last_name}

                </h2>



                <p className="mt-2 text-sm text-slate-400">

                  {employee.employee_number}

                </p>





                {employee.readiness ? (


                  <div className="mt-6">


                    <div className="flex items-end justify-between">


                      <div>

                        <p className="text-sm text-slate-400">
                          Readiness
                        </p>


                        <p className="mt-1 text-4xl font-bold">

                          {
                            employee.readiness
                              .readiness_percent
                          }%

                        </p>


                      </div>



                      <span className="rounded-full bg-emerald-500/15 px-3 py-1 text-sm text-emerald-300">

                        {
                          employee.readiness.status
                        }

                      </span>


                    </div>





                    <div className="mt-5 h-3 overflow-hidden rounded-full bg-slate-800">


                      <div
                        className="h-full rounded-full bg-cyan-400"
                        style={{
                          width:
                            `${employee.readiness.readiness_percent}%`
                        }}
                      />


                    </div>





                    <div className="mt-6 grid grid-cols-2 gap-4">


                      <div>

                        <p className="text-sm text-slate-400">
                          Requirements
                        </p>


                        <p className="text-lg font-semibold">

                          {
                            employee.readiness.requirements_met
                          }
                          /
                          {
                            employee.readiness.requirements_total
                          }

                        </p>


                      </div>




                      <div>

                        <p className="text-sm text-slate-400">
                          Competencies
                        </p>


                        <p className="text-lg font-semibold">

                          {
                            employee.readiness.competencies_met
                          }
                          /
                          {
                            employee.readiness.competencies_total
                          }

                        </p>


                      </div>



                    </div>



                  </div>



                ) : (


                  <p className="mt-6 text-slate-400">

                    No readiness assessment yet.

                  </p>


                )}



              </Link>


            ))}



          </div>


        )}



      </div>


    </main>
  );
}