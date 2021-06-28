/**
* @author Agnieszka Ząbkowicz
* @date 28.06.2021
* @description mock class for CarRESTAPI patch method test
*/
global class CarRESTAPIPatchMockUnauthorized implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(401);
        
        return response; 
	}
}