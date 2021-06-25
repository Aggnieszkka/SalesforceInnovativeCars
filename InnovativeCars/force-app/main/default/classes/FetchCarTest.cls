/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing FetchCar
*/
@isTest
public class FetchCarTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing fetching cars
    */
    @isTest static void testFetchCar() {
        List<Car__c> cars = TestFactory.createCars(151);
        Showroom__c showroom = TestFactory.createShowrooms(1)[0];
        for(Car__c car : cars){
            car.Showroom__c = showroom.Id;
        }
        update cars;
        RestRequest request = new RestRequest();
        request.requestUri ='https://yourInstance.salesforce.com/services/apexrest/v1/cars?salonId='+ showroom.Id;
        request.params.put('salonId', showroom.Id);
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        List<PojazdExternal> pojazdExternalList = FetchCar.fetchCar();
        System.assertEquals(pojazdExternalList.size(), 151);
        System.assertEquals('000000', pojazdExternalList[0].Name);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing updating checkbox value
    * if interested
    */
    @isTest static void testUpdateCarField() {
        Car__c car = TestFactory.createCars(1)[0];
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/v1/cars/'+ car.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.params.put('czy_usunac', 'true');
        RestContext.request = request;
        
        ID carId = FetchCar.updateCarField();
        System.assert(carId != null);
        Car__c testCar = [SELECT Id, Is_Another_Consortium_Interested__c FROM Car__c WHERE Id=:carId];
        System.assert(testCar != null);
        System.assertEquals(testCar.Is_Another_Consortium_Interested__c, true);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing inserting cars sent from 
    * another consortium
    */
    @isTest static void testCreateCar() {
        TestFactory.getAccount();
        Car__c car = new Car__c(Serial_Number__c = 'YYYYYY');
        PojazdExternal external = new PojazdExternal(car);
        String externalJSON = JSON.serialize(external);
        
        RestRequest request = new RestRequest();
        request.addHeader('Content-Type','application/json');
        request.requestBody = Blob.valueOf(externalJSON);
        RestContext.request = request;
        ID carId = FetchCar.createCar();
        
        System.assert(carId != null);
        Car__c testCar = [SELECT Id, Serial_Number__c FROM Car__c WHERE Id=:carId];
        System.assert(testCar != null);
        System.assertEquals(testCar.Serial_Number__c, 'YYYYYY');
    }    
}