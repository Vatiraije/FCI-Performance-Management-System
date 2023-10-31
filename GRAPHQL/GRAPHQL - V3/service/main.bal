import ballerina/time;
import ballerinax/mysql.driver as _;
import ballerinax/mysql;
import ballerina/sql;


configurable string USER = "root";
configurable string PASSWORD = "dankibwika18072001";
configurable string HOST = "localhost";
configurable int PORT = 3360;
configurable string DATABASE = " PERFOMANCE_MANAGEMENT_SYSTEM";

final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database=DATABASE
);


public type Department record{|

    int departmentID;
    string departmentName ;
    string depatymentGoal;
    string departmentOveral;

|};


public type Employee record {|
    int employee_id?;
    string first_name;
    string last_name;
    string email;
    string phone;
    time:Date hire_date;
    int? manager_id;
    string job_title;
    int Kpis ;
    int employeeScore;

|};














// ====================
//EMPLOYEE SECTION 
// ====================

    isolated function addEmployee(Employee emp) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`
            INSERT INTO EmployeeRecord  (employee_id, first_name, last_name, email, phone,
                                hire_date, manager_id, job_title,  Kpis , employeeScore )
            VALUES (${emp.employee_id}, ${emp.first_name}, ${emp.last_name},  
                    ${emp.email}, ${emp.phone}, ${emp.hire_date}, ${emp.manager_id},
                    ${emp.job_title}, ${emp. Kpis}, ${emp. employeeScore})
        `);
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            return lastInsertId;
        } else {
            return error("Unable to obtain last insert ID");
        }
    }

    isolated function getEmployee(int id) returns Employee|error {
        Employee employee = check dbClient->queryRow(
            `SELECT * FROM EmployeeRecord WHERE employee_id = ${id}`
        );
        return employee;
    }

    isolated function getAllEmployees() returns Employee[]|error {
        Employee[] employees = [];
        stream<Employee, error?> resultStream = dbClient->query(
            `SELECT * FROM EmployeeRecord`
        );
        check from Employee employee in resultStream
            do {
                employees.push(employee);
            };
        check resultStream.close();
        return employees;
    }

    isolated function updateEmployee(Employee emp) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`

            UPDATE EmployeeRecord  SET
                first_name = ${emp.first_name}, 
                last_name = ${emp.last_name},
                email = ${emp.email},
                phone = ${emp.phone},
                hire_date = ${emp.hire_date}, 
                manager_id = ${emp.manager_id},
                job_title = ${emp.job_title},
                Kpis  = ${emp.Kpis },
	            employeeScore=  ${emp.employeeScore}

            WHERE employee_id = ${emp.employee_id}  
        `);
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            return lastInsertId;
        } else {
            return error("Unable to obtain last insert ID");
        }
    }

    isolated function removeEmployee(int id) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`
            DELETE FROM Employees WHERE employee_id = ${id}
        `);
        int? affectedRowCount = result.affectedRowCount;
        if affectedRowCount is int {
            return affectedRowCount;
        } else {
            return error("Unable to obtain the affected row count");
        }
    }



    // ====================
    //department SECTION 
    // ====================

    



    isolated function addDepartment(Department emp) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`
            INSERT INTO department_record (departmentID, departmentName, depatymentGoal ,departmentOveral)
            VALUES (${emp.departmentID}, ${emp.departmentName}, ${emp.depatymentGoal }, ${emp.departmentOveral})
        `);
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            return lastInsertId;
        } else {
            return error("Unable to obtain last insert ID");
        }
    }

    isolated function getDepartment(int id) returns Department|error {
        Department department = check dbClient->queryRow(
            `SELECT * FROM department_record WHERE departmentID = ${id}`
        );
        return department;
    }

    isolated function getAllDepartment() returns Department[]|error {
        Department[] departments = [];
        stream<Department, error?> resultStream = dbClient->query(
            `SELECT * FROM department_record`
        );
        check from Department department in resultStream
            do {
               departments.push(department);
            };
        check resultStream.close();
        return departments;
    }

    isolated function updateDepartment(Department emp) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`

            UPDATE department_record  SET
                departmentName= ${emp.departmentName}, 
                depatymentGoal = ${emp.depatymentGoal},
                departmentOveral = ${emp.departmentOveral},

            WHERE departmentID = ${emp.departmentID}  
        `);
        int|string? lastInsertId = result.lastInsertId;
        if lastInsertId is int {
            return lastInsertId;
        } else {
            return error("Unable to obtain last insert ID");
        }
    }

    isolated function removeDepartment(int id) returns int|error {
        sql:ExecutionResult result = check dbClient->execute(`
            DELETE FROM department_record WHERE departmentID = ${id}
        `);
        int? affectedRowCount = result.affectedRowCount;
        if affectedRowCount is int {
            return affectedRowCount;
        } else {
            return error("Unable to obtain the affected row count");
        }
    }

