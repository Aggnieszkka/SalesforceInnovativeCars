/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for CarRESTAPI get method
*/
@isTest
global class CarRESTAPIGetMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        List<Car__c> cars = [SELECT Id, Name, Brand__c, Serial_Number__c,
                                Model__c, State__c, Price__c, 
                                Equipment__c, Power__c, Capacity_kg__c, 
                                Fuel_Usage__c, Type__c, Manager_Notes__c, 
                                Showroom__c, Account__c, Is_Another_Consortium_Interested__c 
                             	FROM Car__c];
        List<PojazdExternal> externals = new List<PojazdExternal>();
        for(Car__c car : cars){
            PojazdExternal external = new PojazdExternal(car);
            externals.add(external);
        }
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
		response.setBody(JSON.serialize(externals));
        
        return response; 
	}
}