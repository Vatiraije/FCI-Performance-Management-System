import ballerina/http;
import ballerina/io;

public function main() {
    // Define the GraphQL query to get all employees
    string graphqlQuery = "query { allEmployees { employeeId, firstName, lastName, jobTitle, position, role, supervisorId } }";

    // Set the GraphQL server endpoint
    http:ClientEndpointConfig endpointConfig = {
        url: "http://localhost:9000/performance", // Update with your actual service URL
        method: http:HTTP_GET
    };

    // Send a GraphQL request to the server
    http:Response response = check send(endpointConfig, graphqlQuery);

    if (response is http:Response) {
        if (response.statusCode == 200) {
            // Parse the response JSON
            json? result = check response.getJsonPayload();

            if (result is json) {
                io:println("GraphQL Query Response:");
                io:println(result);
            } else {
                io:println("Failed to parse response JSON.");
            }
        } else {
            io:println("Failed to execute the GraphQL query. Status code: ", response.statusCode);
        }
    } else {
        io:println("Failed to get a response from the server.");
    }
}
