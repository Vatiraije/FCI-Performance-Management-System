query {
  department(id: "1") {
    id
    name
    objectives {
      id
      name
      percentage
    }
  }
  employee(id: "1") {
    id
    firstName
    lastName
    jobTitle
    position
    role
    department {
      id
      name
      objectives {
        id
        name
        percentage
      }
    }
    kpis {
      id
      name
      unit
      value
    }
  }
  supervisor(id: "1") {
    id
    firstName
    lastName
    department {
      id
      name
      objectives {
        id
        name
        percentage
      }
    }
    employees {
      id
      firstName
      lastName
      jobTitle
      position
      role
    }
  }
}

mutation {
  createDepartment(name: "New Department", percentage: 0.5)
  deleteDepartment(id: "1")
  createObjective(name: "New Objective", percentage: 0.25)
  deleteObjective(id: "1")
  createEmployee(firstName: "John", lastName: "Doe", jobTitle: "Lecturer", position: "Senior", role: "Manager", departmentId: "1")
  deleteEmployee(id: "1")
  assignEmployeeToSupervisor(employeeId: "1", supervisorId: "1")
  updateKpi(employeeId: "1", kpiId: "1", value: 85.5)
  gradeKpi(employeeId: "1", kpiId: "1", grade: 4)
}

subscription {
  employeeScores(employeeId: "1", listener: {
    onEmployeeScores(employee: Employee) {
      println("Employee scores: ${employee.id} ${employee.firstName} ${employee.lastName}")
    }
  })
  departmentScores(departmentId: "1", listener: {
    onDepartmentScores(department: Department) {
      println("Department scores: ${department.id} ${department.name}")
    }
  })
}