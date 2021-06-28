/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing CarRESTAPI
*/
@isTest
public class CarRESTAPITest {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing CarRESTAPI get method
    */
	@isTest static void testGetCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIGetMock()); 
        
        Id showroomId = TestFactory.createShowrooms(1)[0].Id;
        List<Car__c> cars = TestFactory.createCars(151);
        for(Car__c car : cars){
            car.Showroom__c = showroomId;
        }
        
        Test.startTest();
        List<Car__c> testCars = CarRESTAPI.callGetCar(showroomId);
        Test.stopTest();

        System.assertEquals(151, testCars.size());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 28.06.2021
    * @description method for testing CarRESTAPI get method
    */
	@isTest static void testGetCarUsingRESTAPIUnauthorized() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIGetMockUnauthorized()); 
        
        Id showroomId = TestFactory.createShowrooms(1)[0].Id;
        
        Test.startTest();
        List<Car__c> testCars = CarRESTAPI.callGetCar(showroomId);
        Test.stopTest();

        System.assertEquals(0, testCars.size());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing CarRESTAPI post method
    */
    @isTest static void testPatchCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIPatchMock()); 
        
        Id carId = TestFactory.createCars(1)[0].Id;
        
        Test.startTest();
        Boolean isInterested = CarRESTAPI.callPatchCar(carId);
        Test.stopTest();

        System.assertEquals(true, isInterested);
    }

    /**
    * @author Agnieszka Ząbkowicz
    * @date 28.06.2021
    * @description method for testing CarRESTAPI post method
    */
    @isTest static void testPatchCarUsingRESTAPIUnauthorized() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIPatchMockUnauthorized()); 
        
        Id carId = TestFactory.createCars(1)[0].Id;
        
        Test.startTest();
        Boolean isInterested = CarRESTAPI.callPatchCar(carId);
        Test.stopTest();

        System.assertEquals(null, isInterested);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing CarRESTAPI post method
    */
    @isTest static void testPostCarUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIPostMock()); 
        
        Car__c car = TestFactory.createCars(1)[0];
        PojazdExternal external = new PojazdExternal(car);
        
        Test.startTest();
        Car__c testCar = CarRESTAPI.callPostCar(external);
        Test.stopTest();

        System.assert(testCar != null);
        System.assertEquals(car.Serial_Number__c, testCar.Serial_Number__c);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 28.06.2021
    * @description method for testing CarRESTAPI post method
    */
    @isTest static void testPostCarUsingRESTAPIUnauthorized() {
        Test.setMock(HttpCalloutMock.class, new CarRESTAPIUnauthorized()); 
        
        Car__c car = TestFactory.createCars(1)[0];
        PojazdExternal external = new PojazdExternal(car);
        
        Test.startTest();
        Car__c testCar = CarRESTAPI.callPostCar(external);
        Test.stopTest();

        System.assert(testCar == null);
    }
}