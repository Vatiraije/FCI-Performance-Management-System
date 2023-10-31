import ballerina/http;
import ballerina/graphql;
import ballerina/time;

type EmployeeInput record {
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
    
};

type DepartmentInput record {
    
       int departmentID;
    string departmentName ;
    string depatymentGoal;
    string departmentOveral;

    
};


service /performanceSystem on new graphql:Listener(8080) {

    isolated remote function addEmployee(@http:Payload EmployeeInput emp) returns int|error? {
        return addEmployee(<Employee>emp);
    }

    isolated remote function getEmployee(int id) returns Employee|error? {
        return getEmployee(id);
    }

    isolated remote function getAllEmployees() returns Employee[]|error {
        return getAllEmployees();
    }

    isolated remote function updateEmployee(@http:Payload EmployeeInput emp) returns int|error? {
        return updateEmployee(<Employee>emp);
    }

    isolated remote function removeEmployee(int id) returns int|error? {
        return removeEmployee(id);
    }

    isolated remote function addDepartment(@http:Payload DepartmentInput dept) returns int|error? {
        return addDepartment(<Department>dept);
    }

    isolated remote function getDepartment(int id) returns Department|error? {
        return getDepartment(id);
    }

    isolated remote function getAllDepartments() returns Department[]|error {
        return getAllDepartment();
    }

    isolated remote function updateDepartment(@http:Payload DepartmentInput dept) returns int|error? {
        return updateDepartment(<Department>dept);
    }

    isolated remote function removeDepartment(int id) returns int|error? {
        return removeDepartment(id);
    }
}
