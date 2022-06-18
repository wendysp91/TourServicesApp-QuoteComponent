@isTest
global class ResponseMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"statusCode":200,"body":{"Inventory":[{"name":"CL1010_Inv","ProductID":"CL1010","Quan":2988,"BlockedQuan":90},{"name":"MC1020_Inv","ProductID":"MC1020","Quan":2595,"BlockedQuan":49},{"name":"DLL1030_Inv","ProductID":"DLL1030","Quan":6235,"BlockedQuan":64}]}}');
        response.setStatusCode(200);
        return response; 
    }
}