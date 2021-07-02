/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for callout to get external showrooms
*/
public class ShowroomRESTAPI{
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for callout to get external showrooms
    * @param accountId id of the account to which returned showrooms belong
    * @return list of returned showrooms
    */
    @AuraEnabled(cacheable=true)
    public static List<Showroom__c> callGetShowroom(String accountId){
        String accessToken;
        if(!Test.isRunningTest()){
            AccessTokenRESTAPI tokenRESTAPI = new AccessTokenRESTAPI();
            accessToken = tokenRESTAPI.returnAccessToken();
        } else {
            accessToken = 'testToken';
        }
        List<Showroom__c> showroomList = new List<Showroom__c>();
        if(accessToken != null) {
            String endPoint = 'https://mindful-shark-iwybc-dev-ed.my.salesforce.com/services/apexrest/v1/salony?accountid='+accountId;
            Http newHttp = new Http();
            HttpRequest newRequest = new HttpRequest();
            newRequest.setHeader('Authorization','Bearer ' + accessToken);
            newRequest.setHeader('Content-Type','application/json');
            newRequest.setHeader('accept','application/json');
            newRequest.setMethod('GET');
            newRequest.setEndpoint(endPoint);
            HttpResponse newResponse = newHttp.send(newRequest);
            
            try {
                String trimmedResponse = newResponse.getBody().unescapeCsv().remove('\\');
                system.debug('@@@RESPONSE@@'+trimmedResponse);
                
                List<SalonExternal> salonExternalList = (List<SalonExternal>)JSON.deserialize(newResponse.getBody(), List<SalonExternal>.class);
                for(SalonExternal salonExternal : salonExternalList){
                    Showroom__c showroom = salonExternal.getShowroom();
                    showroomList.add(showroom);
                    System.debug('###Showroom###' + salonExternal.Name + ' - ' + salonExternal.SalonId);
                }
            } catch(Exception e){
                System.debug('###Exception###' + e);
            }
        }
        return showroomList;
    }
}