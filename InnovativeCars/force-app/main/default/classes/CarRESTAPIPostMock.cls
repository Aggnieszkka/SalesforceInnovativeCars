/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for CarRESTAPITest post method test
*/
@isTest
global class CarRESTAPIPostMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(request.getBody());
        
        return response; 
	}
}