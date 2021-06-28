/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for ShowroomRESTAPITest
*/
@isTest
global class ShowroomRESTAPIMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        List<Showroom__c> showrooms = [SELECT Id, Name, Address__c, 
                                          Type__c, Account__c, Website__c, 
                                          Status__c, Car_Spaces__c, Warehouse__c, 
                                          Region__c, Interns__c  FROM Showroom__c];
        List<SalonExternal> externals = new List<SalonExternal>();
        for(Showroom__c showroom : showrooms){
            SalonExternal external = new SalonExternal(showroom);
            externals.add(external);
        }
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
		response.setBody(JSON.serialize(externals));
        
        return response; 
    }
}