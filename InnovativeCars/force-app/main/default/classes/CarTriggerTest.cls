/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description test class for CarTrigger
*/
@isTest
public class CarTriggerTest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing adding new cars available at the showroom
    * where are enough car spaces
    */
    @isTest static void testAddingCarWhereIsEnoughSpaceInShowroom(){
        List<Car__c> cars = TestFactory.createCars(151);
        List<Showroom__c> showrooms = TestFactory.createShowrooms(2);
        
        showrooms[0].Car_Spaces__c = 151;
        update showrooms;
        
        for(Integer i=0; i<100; i++) {
            cars[i].Showroom__c = showrooms[0].Id;
        }
        for(Integer i=100; i<151; i++) {
            cars[i].Showroom__c = showrooms[1].Id;
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(cars, false);
        Test.stopTest();

        for(Integer i=0; i<151; i++) {
            System.assert(testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() == 0);
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing adding new cars available at the showroom
    * where are not enough car spaces
    */
    @isTest static void testAddingCarWhereIsNotEnoughSpaceInShowroom(){
        List<Car__c> cars = TestFactory.createCars(151);
        List<Showroom__c> showrooms = TestFactory.createShowrooms(1);
        
        showrooms[0].Car_Spaces__c = 0;
        update showrooms;
        
        for(Integer i=0; i<151; i++) {
            cars[i].Showroom__c = showrooms[0].Id;
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(cars, false);
        Test.stopTest();
		
        for(Integer i=0; i<151; i++) {
            System.assert(!testResult[i].isSuccess());
        	System.assert(testResult[i].getErrors().size() > 0);
        	System.assertEquals('Cannot add a new car because the showroom is full!',
                             testResult[i].getErrors()[0].getMessage());
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing deleting cars with telemetries
    */
    @isTest static void testCarDeleting(){
        List<Car__c> testCars = TestFactory.createCars(151);
        
        List<Telemetry__c> telemetries = new List<Telemetry__c>();
        
        for(Integer i = 0; i<151; i++){
            telemetries.add(new Telemetry__c(Car__c = testCars[i].Id, Type__c = 'Temperature'));
        	telemetries.add(new Telemetry__c(Car__c = testCars[i].Id, Type__c = 'Rotation speed'));
            
        }
        insert telemetries;
        
        Test.startTest();
		Database.DeleteResult[] testResult = Database.delete(testCars, false);
        Test.stopTest();
        
        for(Integer i = 0; i<151; i++){
            System.assert(testResult[0].isSuccess());
            System.assert(testResult[0].getErrors().size() == 0);
        }
    }
}