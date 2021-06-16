/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description test class for CarToShowroomTrigger
*/
@isTest
public class CarToShowroomTriggerTest {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method testing adding new offers to cars which
    * are already available at the showroom
    */
    @isTest static void TestCorrectAddingCarToShowroom(){
        List<Car__c> testCars = TestFactory.createCars(151);
        List<Showroom__c> testShowrooms = TestFactory.createShowrooms(1);
         
        List<Car_To_Showroom__c> testCarToShowrooms = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            testCars[i].Showroom__c = testShowrooms[0].Id;
            
            String availability;
            if(i < 100){
                availability = Constants.PICKLIST_AVAILABLE;
            } else {
                availability = Constants.PICKLIST_AVAILABLE_AT_DIFFERENT;
            }
            
            Car_To_Showroom__c testCarToShowroom = new Car_To_Showroom__c(
                Car__c = testCars[i].Id, 
                Showroom__c = testShowrooms[0].Id, 
                Availability__c = availability);
            testCarToShowrooms.add(testCarToShowroom);
        }
         
        update testCars;
         
        Test.startTest();
		Database.SaveResult[] testResult = Database.insert(testCarToShowrooms, false);
        Test.stopTest();
        
         
        for(Integer i = 0; i<151; i++){
            System.assert(testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() == 0);
        }

    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method testing adding new offers to cars which
    * are already available at the showroom and already have their offers
    */
    @isTest static void testAddingCarToShowroomWhereAlreadyAvailable(){
        List<Car__c> testCars = TestFactory.createCars(151);
        List<Showroom__c> testShowrooms = TestFactory.createShowrooms(1);
        
        for(Integer i=0; i<151; i++){
            testCars[i].Showroom__c = testShowrooms[0].Id;
        }
        update testCars;
        
        List<Car_To_Showroom__c> testCarToShowrooms = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            Car_To_Showroom__c newCarToShowroom = new Car_To_Showroom__c(
            	Car__c = testCars[i].Id, 
            	Showroom__c = testShowrooms[0].Id, 
            	Availability__c = Constants.PICKLIST_AVAILABLE);
        	testCarToShowrooms.add(newCarToShowroom);
        }
        insert testCarToShowrooms;
        
        List<Car_To_Showroom__c> newCarToShowrooms = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            Car_To_Showroom__c newCarToShowroom = new Car_To_Showroom__c(
            	Car__c = testCars[i].Id, 
            	Showroom__c = testShowrooms[0].Id, 
            	Availability__c = Constants.PICKLIST_AVAILABLE);
        	newCarToShowrooms.add(newCarToShowroom);
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.insert(newCarToShowrooms, false);
        Test.stopTest();
        
        for(Integer i=0; i<151; i++){
            System.assert(!testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() > 0);
            System.assertEquals(Constants.ALREADY_AVAILABLE_ERROR + ' ' + testShowrooms[0].Name,
                                 testResult[i].getErrors()[0].getMessage());
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method testing adding new offers clones (for the same
    * showroom and the same car) to cars which are already available at 
    * the showroom and already have their offers
    */
    @isTest static void testAddingCarToShowroomClones(){
        List<Car__c> testCars = TestFactory.createCars(1);
        List<Showroom__c> testShowrooms = TestFactory.createShowrooms(1);
        
        testCars[0].Showroom__c = testShowrooms[0].Id;

        update testCars;
        
        List<Car_To_Showroom__c> newCarToShowrooms = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            Car_To_Showroom__c newCarToShowroom = new Car_To_Showroom__c(
            	Car__c = testCars[0].Id, 
            	Showroom__c = testShowrooms[0].Id, 
            	Availability__c = Constants.PICKLIST_AVAILABLE);
        	newCarToShowrooms.add(newCarToShowroom);
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.insert(newCarToShowrooms, false);
        Test.stopTest();
        
        for(Integer i=1; i<151; i++){
            System.assert(!testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() > 0);
            System.assertEquals(Constants.ALREADY_AVAILABLE_ERROR + ' ' + testShowrooms[0].Name,
                                 testResult[i].getErrors()[0].getMessage());
        }
    }
   
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method testing adding new offers to cars which
    * are not available at the showroom
    */
    @isTest static void testAddingCarToShowroomWhereNotAvailableInShowroom(){
        List<Car__c> testCars = TestFactory.createCars(151);
        List<Showroom__c> testShowrooms = TestFactory.createShowrooms(1);
        
        List<Car_To_Showroom__c> newCarToShowrooms = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            Car_To_Showroom__c newCarToShowroom = new Car_To_Showroom__c(
            	Car__c = testCars[i].Id, 
            	Showroom__c = testShowrooms[0].Id, 
            	Availability__c = Constants.PICKLIST_AVAILABLE);
        	newCarToShowrooms.add(newCarToShowroom);
        }
        
        Test.startTest();
		Database.SaveResult[] testResult = Database.insert(newCarToShowrooms, false);
        Test.stopTest();
        
        for(Integer i=0; i<151; i++){
            System.assert(!testResult[i].isSuccess());
            System.assert(testResult[i].getErrors().size() > 0);
            System.assertEquals(Constants.NOT_IN_SHOWROOM_ERROR,
                                 testResult[i].getErrors()[0].getMessage());
        }
    }
}