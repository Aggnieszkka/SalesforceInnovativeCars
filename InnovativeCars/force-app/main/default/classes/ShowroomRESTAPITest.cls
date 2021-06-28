/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing ShowroomRESTAPI
*/
@isTest
public class ShowroomRESTAPITest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing ShowroomRESTAPI get method
    */
    @isTest static void testGetShowroomUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new ShowroomRESTAPIMock()); 
        
        Id accountId = TestFactory.getAccount()[0].Id;
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        
        Test.startTest();
        List<Showroom__c> testShowrooms = ShowroomRESTAPI.callGetShowroom(accountId);
        Test.stopTest();

        System.assertEquals(151, testShowrooms.size());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 28.06.2021
    * @description method for testing ShowroomRESTAPI get method
    */
    @isTest static void testGetShowroomUsingRESTAPIUnauthorized() {
        Test.setMock(HttpCalloutMock.class, new ShowroomRESTAPIMockUnauthorized()); 
        
        Id accountId = TestFactory.getAccount()[0].Id;
        
        Test.startTest();
        List<Showroom__c> testShowrooms = ShowroomRESTAPI.callGetShowroom(accountId);
        Test.stopTest();

        System.assertEquals(0, testShowrooms.size());
    }
}