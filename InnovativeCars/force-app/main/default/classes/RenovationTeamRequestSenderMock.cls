/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for RenovationTeamRequestSenderTest
*/
@isTest
global class RenovationTeamRequestSenderMock implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(201);
        return response; 
    }
}