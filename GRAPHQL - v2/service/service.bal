
import ballerina/graphql;
import ballerina/http;

service /performanceSystem on new graphql:Listener(8080) {


    // FOR EMPLOYEE

    isolated resource function post .(@http:Payload Employee emp) returns int|error? {
        return addEmployee(emp);
    }
    
    isolated resource function get [int id]() returns Employee|error? {
        return getEmployee(id);
    }
    
    isolated resource function get .() returns Employee[]|error? {
        return getAllEmployees();
    }
    
    isolated resource function put .(@http:Payload Employee emp) returns int|error? {
        return updateEmployee(emp);
    }
    
    isolated resource function delete [int id]() returns int|error? {
        return removeEmployee(id);       
    }

}
