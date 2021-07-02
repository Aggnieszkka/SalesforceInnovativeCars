/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for callout to get external cars or changing value of checkbox
* if interested or sending cars to another consortium
*/
public class CarRESTAPI {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description class for callout to get external cars
    * @param showroomId id of the showroom from which are returned cars
    * @return list of cars
    */
    @AuraEnabled(cacheable=true)
    public static List<Car__c> callGetCar(String showroomId){
        String accessToken;
        if(!Test.isRunningTest()){
            AccessTokenRESTAPI tokenRESTAPI = new AccessTokenRESTAPI();
            accessToken = tokenRESTAPI.returnAccessToken();
        } else {
            accessToken = 'testToken';
        }
        List<Car__c> carList = new List<Car__c>();
        if(accessToken != null) {
            String endPoint = 'https://mindful-shark-iwybc-dev-ed.my.salesforce.com/services/apexrest/v1/pojazdy?salonid='+showroomId;
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
                
                List<PojazdExternal> pojazdExternalList = (List<PojazdExternal>)JSON.deserialize(newResponse.getBody(), List<PojazdExternal>.class);
                for(PojazdExternal pojazdExternal : pojazdExternalList){
                    System.debug('###CarEx###' + pojazdExternal.name + ' - ' + pojazdExternal.pojazdId);
                    Car__c car = pojazdExternal.getCar();
                    carList.add(car);
                }
            } catch(Exception e) {
                System.debug('###Exception###' + e);
			}
        }
        return carList;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for callout for changing value of checkbox of a car
    * if interested 
    * @param carId id of the updated car
    * @return result of the change
    */
    @AuraEnabled
    public static Boolean callPatchCar(String carId){
        String accessToken;
        if(!Test.isRunningTest()){
            AccessTokenRESTAPI tokenRESTAPI = new AccessTokenRESTAPI();
            accessToken = tokenRESTAPI.returnAccessToken();
        } else {
            accessToken = 'testToken';
        }
        if(accessToken != null) {
            String endPoint = 'https://mindful-shark-iwybc-dev-ed.my.salesforce.com/services/apexrest/v1/pojazdy?pojazdid='+carId;
            Http newHttp = new Http();
            HttpRequest newRequest = new HttpRequest();
            newRequest.setHeader('Authorization','Bearer ' + accessToken);
            newRequest.setHeader('Content-Type','application/json');
            newRequest.setHeader('accept','application/json');
            newRequest.setMethod('PATCH');
            newRequest.setEndpoint(endPoint);
            HttpResponse newResponse = newHttp.send(newRequest);
            try {
                String trimmedResponse = newResponse.getBody().unescapeCsv().remove('\\');
                system.debug('@@@RESPONSE@@'+trimmedResponse);
                
                Boolean pojazdExternal = (Boolean)JSON.deserialize(newResponse.getBody(), Boolean.class);
                System.debug('###Result###' + pojazdExternal);
                return pojazdExternal;
            } catch(Exception e) {
                System.debug('###Exception###' + e);
			}
        }
        return null;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for sending cars to another consortium
    * @param pojazdExternal car to be sent
    * @return sent car
    */
    public static Car__c callPostCar(PojazdExternal pojazdExternal){
        String accessToken;
        if(!Test.isRunningTest()){
            AccessTokenRESTAPI tokenRESTAPI = new AccessTokenRESTAPI();
            accessToken = tokenRESTAPI.returnAccessToken();
        } else {
            accessToken = 'testToken';
        }
        if(accessToken != null) {
            String endPoint = 'https://mindful-shark-iwybc-dev-ed.my.salesforce.com/services/apexrest/v1/pojazdy';
            Http newHttp = new Http();
            HttpRequest newRequest = new HttpRequest();
            newRequest.setHeader('Authorization','Bearer ' + accessToken);
            newRequest.setHeader('Content-Type','application/json');
            newRequest.setHeader('accept','application/json');
            newRequest.setMethod('POST');
            newRequest.setEndpoint(endPoint);
            if(pojazdExternal != null) {
                pojazdExternal.salonId = null;
                pojazdExternal.accountId = null;
                if(pojazdExternal.cena == null){
                    pojazdExternal.cena = 1;
                }
                if(pojazdExternal.marka == null){
                    pojazdExternal.marka = '<unknown>';
                }
                if(pojazdExternal.model == null){
                    pojazdExternal.model = '<unknown>';
                }
            }
                
            newRequest.setBody(JSON.serialize(pojazdExternal));
            HttpResponse newResponse = newHttp.send(newRequest);
            
            try {
                String trimmedResponse = newResponse.getBody().unescapeCsv().remove('\\');
                system.debug('@@@RESPONSE@@'+trimmedResponse);
                
                PojazdExternal pojazdExternalResult = (PojazdExternal)JSON.deserialize(newResponse.getBody(), PojazdExternal.class);
                System.debug('###Result###' + pojazdExternalResult.name);
                return pojazdExternalResult.getCar();
            } catch(Exception e) {
                System.debug('###Exception###' + e);
			}
        }
        return null;
    }
}