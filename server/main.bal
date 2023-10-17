


```
import "ballerina/lang/graphql"

type Query {
  employeeScores(id: ID!): EmployeeScores
  employeeKPIs(id: ID!): EmployeeKPIs
  departmentObjectives(): DepartmentObjectives
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Mutation {
  createEmployee(firstName: String!, lastName: String!, jobTitle: String!, position: String!, role: String!): Employee
  deleteEmployee(id: ID!): Employee
  assignEmployeeToSupervisor(id: ID!, supervisorId: ID!): Employee
  updateEmployeeKPIs(id: ID!, kpi1: Float!, kpi2: Float!, kpi3: Float!): Employee
  gradeEmployeeKPIs(id: ID!, score1: Float!, score2: Float!, score3: Float!): Employee
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3: Float!
}

type Employee {
  id: ID!
  firstName: String!
  lastName: String!
  jobTitle: String!
  position: String!
  role: String!
  scores: EmployeeScores!
  kpis: EmployeeKPIs!
  department: Department!
}

type Department {
  id: ID!
  name: String!
  objectives: DepartmentObjectives!
  employees: [Employee!]!
}

type EmployeeScores {
  score1: Float!
  score2: Float!
  score3: Float!
}

type EmployeeKPIs {
  kpi1: Float!
  kpi2: Float!
  kpi3: Float!
}

type DepartmentObjectives {
  objective1: Float!
  objective2: Float!
  objective3