/**
* @author Agnieszka Ząbkowicz
* @date 28.06.2021
* @description mock class for CarRESTAPI get method
*/
@isTest
global class CarRESTAPIGetMockUnauthorized implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(401);
        
        return response; 
	}
}