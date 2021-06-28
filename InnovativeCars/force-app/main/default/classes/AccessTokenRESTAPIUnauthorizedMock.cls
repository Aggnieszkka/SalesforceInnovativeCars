/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for AccessTokenRESTAPITest
*/
@isTest
global class AccessTokenRESTAPIUnauthorizedMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(401);
        
        return response; 
    }
}