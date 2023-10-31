import ballerina/http;
import ballerina/io;
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
    int Kpis;
    int employeeScore;
}

type DepartmentInput record {
    int departmentID;
    string departmentName;
    string departmentGoal;
    string departmentOverall;
}

function main() {
    // Set the GraphQL service endpoint URL
    endpoint graphql:Client client {
        clientConfig: {
            url: "http://localhost:8080/performanceSystem", // Replace with your service URL
            auth: {
                username: "your_username", // Optional username for authentication
                password: "your_password" // Optional password for authentication
            }
        }
    };

    // Execute a sample mutation
    var employeeInput = createEmployeeInput(); // Define this function to create an EmployeeInput
    var addEmployeeMutation = "mutation($employee: EmployeeInput) { addEmployee(emp: $employee) }";
    var addEmployeeResponse = client->executeMutation(addEmployeeMutation, { "employee": employeeInput });
    check addEmployeeResponse is graphql:Response;

    // Handle the response here
    match addEmployeeResponse {
        graphql:SuccessResponse successResponse => {
            io:println("Employee added successfully. Employee ID: " + successResponse.data.toString());
        }
        graphql:ErrorResponse errorResponse => {
            io:println("Error adding an employee: " + errorResponse.toString());
        }
        _ => {
            io:println("Unexpected response received.");
        }
    }
}

function createEmployeeInput() returns EmployeeInput {
    // Define your EmployeeInput data here
    EmployeeInput empInput = {
        employee_id: 1,
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        phone: "1234567890",
        hire_date: time:parse("2023-10-30"),
        manager_id: 2,
        job_title: "Engineer",
        Kpis: 5,
        employeeScore: 100
    };
    return empInput;
}
