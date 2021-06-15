/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description test class for NewOffersEmailSender
*/
@isTest
public class NewOffersEmailSenderTest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method testing sending email
    */
    @isTest static void testSendingEmail(){
        List<Car__c> testCars = TestFactory.createCars(151);
        List<Showroom__c> testShowrooms = TestFactory.createShowrooms(151);
        
        List<Car_To_Showroom__c> testOffers = new List<Car_To_Showroom__c>();
        for(Integer i=0; i<151; i++){
            testCars[i].Showroom__c = testShowrooms[i].Id;

            Car_To_Showroom__c testCarToShowroom = new Car_To_Showroom__c(
                Car__c = testCars[i].Id, 
                Showroom__c = testShowrooms[i].Id, 
                Availability__c = Constants.PICKLIST_AVAILABLE);
                testOffers.add(testCarToShowroom);
        }
        update testCars;

        Test.startTest();
        insert testOffers;
        Integer calls = Limits.getFutureCalls();
        Test.stopTest();

        System.assertEquals(1, calls);
    }
}