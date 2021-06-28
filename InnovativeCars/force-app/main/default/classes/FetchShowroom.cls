/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for fetching showrooms in response of external callout
*/
@RestResource(urlMapping='/v1/showrooms/*')
global with sharing class FetchShowroom {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for fetching showrooms in response of external callout
    */
	@HttpGet
    global static list<SalonExternal> fetchShowroom(){
        RestRequest request = RestContext.request;
        Id accountId = (Id)request.params.get('accountId');
        List<Showroom__c> listShowrooms =[Select 
                                          Id, Name, Address__c, 
                                          Type__c, Account__c, Website__c, 
                                          Status__c, Car_Spaces__c, Warehouse__c, 
                                          Region__c, Interns__c 
                                          from Showroom__c where Account__c = :accountId];
        List<SalonExternal> listExternalShowrooms = new List<SalonExternal>();
        for(Showroom__c showroom : listShowrooms){
            listExternalShowrooms.add(new SalonExternal(showroom));
        }
        return listExternalShowrooms ;
    }   
}