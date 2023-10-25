import ballerina/graphql;

// Define the Employee record type
type Employee record {
    readonly string employeeId;
    string firstName;
    string lastName;
    string jobTitle;
    string position;
    string role;
    string supervisorId;
    decimal supervisorScore;
};

// Define the DepartmentObjective record type
type DepartmentObjective record {
    readonly string objectiveId;
    string objective;
    decimal percentage;
};

// Define the KeyPerformanceIndicator record type
type KeyPerformanceIndicator record {
    readonly string kpiId;
    string employeeId;
    string kpiName;
    decimal kpiScore;
    string kpiUnit;
    boolean approved;
};

// Define a table to store employee records hendrina
table<Employee> key(employeeId) employeesTable = table [
    // Initialize the table with sample employee data
    // Each row represents an employee
    {employeeId: "1", firstName: "John", lastName: "Doe", jobTitle: "Lecturer", position: "Academic", role: "Employee", supervisorId: "3", supervisorScore: 0.0},
    {employeeId: "2", firstName: "Alice", lastName: "Smith", jobTitle: "Head of Department", position: "Academic", role: "HoD", supervisorId: "", supervisorScore: 0.0},
    {employeeId: "3", firstName: "Bob", lastName: "Johnson", jobTitle: "Supervisor", position: "Academic", role: "Supervisor", supervisorId: "2", supervisorScore: 0.0},
    {employeeId: "4", firstName: "Eve", lastName: "Brown", jobTitle: "Lecturer", position: "Academic", role: "Employee", supervisorId: "3", supervisorScore: 0.0},
    {employeeId: "5", firstName: "Grace", lastName: "Williams", jobTitle: "Lecturer", position: "Academic", role: "Employee", supervisorId: "3", supervisorScore: 0.0}
];

// Define a table to store department objectives
table<DepartmentObjective> key(objectiveId) objectivesTable = table [
    // Initialize the table with sample department objectives
    {objectiveId: "1", objective: "Increase Student Progress", percentage: 30},
    {objectiveId: "2", objective: "Achieve Peer Recognition", percentage: 20},
    {objectiveId: "3", objective: "Improve Research Output", percentage: 25},
    {objectiveId: "4", objective: "Enhance Teaching Methods", percentage: 15},
    {objectiveId: "5", objective: "Support Professional Development", percentage: 10}
];

// Define a table to store Key Performance Indicators (KPIs)
table<KeyPerformanceIndicator> key(kpiId) kpisTable = table [
    // Initialize the table with sample KPI data
    // Each row represents a KPI
    {kpiId: "101", employeeId: "1", kpiName: "Peer Recognition", kpiScore: 4.5, kpiUnit: "Score", approved: false},
    {kpiId: "102", employeeId: "1", kpiName: "Research Output", kpiScore: 80, kpiUnit: "Percentage", approved: false},
    {kpiId: "103", employeeId: "2", kpiName: "Student Progress", kpiScore: 90, kpiUnit: "Percentage", approved: false},
    {kpiId: "104", employeeId: "3", kpiName: "Innovative Teaching Methods", kpiScore: 4, kpiUnit: "Score", approved: false},
    {kpiId: "105", employeeId: "3", kpiName: "Professional Development", kpiScore: 70, kpiUnit: "Percentage", approved: false}
];

// Define a service to expose GraphQL APIs
public distinct service class EmployeeData {
    private readonly &Employee employeeRecord;

    function init(Employee employeeRecord) {
        self.employeeRecord = employeeRecord.cloneReadOnly();
    }

    resource function get employeeId() returns string {
        return self.employeeRecord.employeeId;
    }

    resource function get firstName() returns string {
        return self.employeeRecord.firstName;
    }

    resource function get lastName() returns string {
        return self.employeeRecord.lastName;
    }

    resource function get jobTitle() returns string {
        return self.employeeRecord.jobTitle;
    }

    resource function get position() returns string {
        return self.employeeRecord.position;
    }

    resource function get role() returns string {
        return self.employeeRecord.role;
    }

    resource function get supervisorId() returns string {
        return self.employeeRecord.supervisorId;
    }
}

// Define a service to expose GraphQL APIs on port 9000
service /performance on new graphql:Listener(9000) {

    // Query to get all employees
    resource function get allEmployees() returns EmployeeData[] {
        Employee[] employees = employeesTable.toArray().cloneReadOnly();
        return employees.map(employee => new EmployeeData(employee));
    }

    // Query to get an employee by ID
    resource function get getEmployee(string employeeId) returns EmployeeData? {
        Employee? employee = employeesTable[employeeId];
        if (employee is Employee) {
            return new (employee);
        }
        return;
    }

    // Query to get department objectives
    resource function get departmentObjectives() returns DepartmentObjective[] {
        return objectivesTable.toArray();
    }

    // Query to get employee-specific KPIs
    resource function get employeeKPIs(string employeeId) returns KeyPerformanceIndicator[] {
        KeyPerformanceIndicator[] kpiArray = [];
        
        // Iterate through the table and filter the relevant KPIs
        foreach var kpi in kpisTable {
            if (kpi.employeeId == employeeId) {
                kpiArray.push(kpi);
            }
        }
        
        return kpiArray;
    }

        // Mutation to create a new KPI
        resource function get createKPI(KeyPerformanceIndicator kpi) returns KeyPerformanceIndicator {
            kpisTable.add(kpi);
            return kpi;
        }

        // Mutation to grade a KPI
        resource function get gradeKPI(string kpiId, decimal score) returns KeyPerformanceIndicator? {
            KeyPerformanceIndicator? kpi = kpisTable[kpiId];
            if (kpi is KeyPerformanceIndicator) {
                _ = kpisTable.remove(kpiId);
                kpi.kpiScore = score;
                kpisTable.add(kpi);
                return kpi;
            }
            return;
        }


    // HoD-specific mutation: Create department objectives (Tjihimise)
    resource function post createDepartmentObjectives(DepartmentObjective objective) returns DepartmentObjective {
        objectivesTable.add(objective);
        return objective;
    }

    // HoD-specific mutation: Delete department objectives
    resource function delete deleteDepartmentObjectives(string objectiveId) returns DepartmentObjective? {
        DepartmentObjective? objective = objectivesTable[objectiveId];
        if (objective is DepartmentObjective) {
            var removedObjective = objectivesTable.remove(objectiveId);
            return removedObjective;
        }
        return;
    }

    // HoD-specific query: View total scores of employees
    resource function get viewTotalScores() returns DepartmentObjective[] {
        return objectivesTable.toArray();
    }

    // Supervisor-specific mutation: Assign an employee to a supervisor
    resource function post assignEmployeeToSupervisor(string employeeId, string supervisorId) returns Employee? {
        Employee? employee = employeesTable[employeeId];
        if (employee is Employee) {
            employee.supervisorId = supervisorId;
            Employee removedEmployee = employeesTable.remove(employeeId);
            employeesTable.add(removedEmployee);
            return removedEmployee;
        }
        return;
    }

    // Supervisor-specific mutation: Approve an employee's KPIs
    resource function post approveEmployeeKPIs(string supervisorId, string kpiId) {
        KeyPerformanceIndicator? kpi = kpisTable[kpiId];
        if (kpi is KeyPerformanceIndicator && kpi.employeeId != supervisorId) {
            KeyPerformanceIndicator remove = kpisTable.remove(kpiId);
            kpi.approved = true;
            kpisTable.add(kpi);
        }
    }

    // Supervisor-specific mutation: Delete an employee's KPIs
    resource function delete deleteEmployeeKPIs(string supervisorId, string kpiId) {
        _ = kpisTable.remove(kpiId);
    }

    // Supervisor-specific mutation: Update an employee's KPIs
    resource function put updateEmployeeKPIs(string supervisorId, KeyPerformanceIndicator kpi) returns KeyPerformanceIndicator {
        KeyPerformanceIndicator? existingKpi = kpisTable[kpi.kpiId];
        if (existingKpi is KeyPerformanceIndicator) {
            var removedKpi = kpisTable.remove(kpi.kpiId);
            kpi.employeeId = supervisorId;
            kpisTable.add(kpi);
            return kpi;
        } else {
            // Handle the case where the KPI with the specified ID doesn't exist
            // You can return an error or handle it as needed
            return kpi;
        }
    }

    // Employee-specific mutation: Grade their supervisor
    resource function post gradeSupervisor(string employeeId, decimal score) returns Employee? {
        Employee? supervisor = employeesTable[employeeId];
        if (supervisor is Employee && supervisor.role == "Supervisor") {
            supervisor.supervisorScore = score;
            Employee remove = employeesTable.remove(employeeId);
            employeesTable.add(supervisor);
            return supervisor;
        }
        return;
    }

    // Employee-specific query: View their KPI scores
    resource function get viewEmployeeScores(string employeeId) returns KeyPerformanceIndicator[] {
        KeyPerformanceIndicator[] kpiArray = [];
        
        // Iterate through the table and filter the relevant KPIs
        foreach var kpi in kpisTable {
            if (kpi.employeeId == employeeId) {
                kpiArray.push(kpi);
            }
        }
        
        return kpiArray;
    }
}
