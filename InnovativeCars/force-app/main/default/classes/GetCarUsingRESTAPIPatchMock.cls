/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for GetCarUsingRESTAPITest patch method test
*/
global class GetCarUsingRESTAPIPatchMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(JSON.serialize(true));
        
        return response; 
	}
}