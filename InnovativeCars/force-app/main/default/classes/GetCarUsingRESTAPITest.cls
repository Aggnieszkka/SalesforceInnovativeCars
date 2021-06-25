/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing GetCarUsingRESTAPI
*/
@isTest
public class GetCarUsingRESTAPITest {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetCarUsingRESTAPI get method
    */
	@isTest static void testGetCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new GetCarUsingRESTAPIGetMock()); 
        
        Id showroomId = TestFactory.createShowrooms(1)[0].Id;
        List<Car__c> cars = TestFactory.createCars(151);
        for(Car__c car : cars){
            car.Showroom__c = showroomId;
        }
        
        Test.startTest();
        List<Car__c> testCars = GetCarUsingRESTAPI.callGetCar(showroomId);
        Test.stopTest();

        System.assertEquals(151, testCars.size());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetCarUsingRESTAPI post method
    */
    @isTest static void testPatchCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new GetCarUsingRESTAPIPatchMock()); 
        
        Id carId = TestFactory.createCars(1)[0].Id;
        
        Test.startTest();
        Boolean isInterested = GetCarUsingRESTAPI.callPatchCar(carId);
        Test.stopTest();

        System.assertEquals(true, isInterested);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetCarUsingRESTAPI post method
    */
    @isTest static void testPostCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new GetCarUsingRESTAPIPostMock()); 
        
        Car__c car = TestFactory.createCars(1)[0];
        PojazdExternal external = new PojazdExternal(car);
        
        Test.startTest();
        Car__c testCar = GetCarUsingRESTAPI.callPostCar(external);
        Test.stopTest();

        System.assert(testCar != null);
        System.assertEquals(car.Serial_Number__c, testCar.Serial_Number__c);
    }
}