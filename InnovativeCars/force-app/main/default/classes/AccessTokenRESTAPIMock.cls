/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for AccessTokenRESTAPITest
*/
@isTest
global class AccessTokenRESTAPIMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        AccessTokenRESTAPI.DeserializeResponse deserializeResponse = new AccessTokenRESTAPI.DeserializeResponse();
        deserializeResponse.id = 'XXX';
        deserializeResponse.access_token = 'XXXXXX';
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(JSON.serialize(deserializeResponse));
        
        return response; 
    }
}