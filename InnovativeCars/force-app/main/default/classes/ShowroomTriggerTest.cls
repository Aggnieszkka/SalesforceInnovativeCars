/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description test class for ShowroomTrigger
*/
@isTest
public class ShowroomTriggerTest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing closing showroom when there are no cars in it
    */
    @isTest static void testClosingEmptyShowroom() {
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        
        for(Integer i=0; i<151; i++) {
            showrooms[i].Status__c = Constants.picklistClosed;
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(showrooms, false);
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
    * @description method testing closing showroom when there are cars in it
    */
    @isTest static void testClosingNotEmptyShowroom() {
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        List<Car__c> cars = TestFactory.createCars(151);
        
        for(Integer i=0; i<151; i++) {
            cars[i].Showroom__c = showrooms[i].Id;
        }
        update cars;
        
        for(Integer i=0; i<151; i++) {
            showrooms[i].Status__c = Constants.picklistClosed;
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(showrooms, false);
        Test.stopTest();
        
        for(Integer i=0; i<151; i++) {
            System.assert(!testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() > 0);
            System.assertEquals(Constants.cannotCloseError,
                                 testResult[i].getErrors()[0].getMessage());
   		}
    }
        
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing adding first showroom as a warehouse to an account
    */
    @isTest static void CheckFirstWarehouseToAccount(){
        List<Showroom__c> showrooms = TestFactory.createShowrooms(2);
        showrooms[0].Warehouse__c = true;
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(showrooms, false);
        Test.stopTest();
        
        System.assert(testResult[0].isSuccess());
        System.assert(testResult[0].getErrors().size() == 0);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing adding second showroom as a warehouse to an account
    */
    @isTest static void CheckSecondWarehouseToAccount(){
        List<Showroom__c> showrooms = TestFactory.createShowrooms(2);
        
        showrooms[0].Warehouse__c = true;
        update showrooms;
        showrooms[1].Warehouse__c = true;
        
        Test.startTest();
        Database.SaveResult[] testResult = Database.update(new List<Showroom__c>{showrooms[1]}, false);
        Test.stopTest();
        
        System.assert(!testResult[0].isSuccess());
        System.assert(testResult[0].getErrors().size() > 0);
        System.assertEquals(Constants.thereAlreadyIsWarehouseError + showrooms[0].Name,
                             testResult[0].getErrors()[0].getMessage());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing changing number of car spaces in a showroom
    * to a number equal to number of cars available at the showroom
    */
    @isTest static void testEnoughCarSpaces(){
        List<Car__c> cars = TestFactory.createCars(151);
        List<Showroom__c> showrooms = TestFactory.createShowrooms(1);
        
        for(Integer i=0; i<151; i++) {
        	cars[i].Showroom__c = showrooms[0].Id;
        }
        update cars;
        
        showrooms[0].Car_Spaces__c = 151;
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(showrooms, false);
        Test.stopTest();
        
        System.assert(testResult[0].isSuccess());
        System.assert(testResult[0].getErrors().size() == 0);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing changing number of car spaces in a showroom
    * to a number lower than number of cars available at the showroom
    */
    @isTest static void testNotEnoughCarSpaces(){
        List<Car__c> cars = TestFactory.createCars(151);
        List<Showroom__c> showrooms = TestFactory.createShowrooms(1);
        
        for(Integer i=0; i<151; i++) {
        	cars[i].Showroom__c = showrooms[0].Id;
        }
        update cars;
        
        showrooms[0].Car_Spaces__c = 1;
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.update(showrooms, false);
        Test.stopTest();
        
        System.assert(!testResult[0].isSuccess());
        System.assert(testResult[0].getErrors().size() > 0);
        System.assertEquals(Constants.lessThanCarsAvailableError,
                             testResult[0].getErrors()[0].getMessage());
    }
}