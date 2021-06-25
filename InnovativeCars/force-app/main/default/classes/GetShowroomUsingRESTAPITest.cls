/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing GetAccountUsingRESTAPI
*/
@isTest
public class GetShowroomUsingRESTAPITest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetShowroomUsingRESTAPI get method
    */
    @isTest static void testGetShowroomUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new GetShowroomUsingRESTAPIMock()); 
        
        Id accountId = TestFactory.getAccount()[0].Id;
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        
        Test.startTest();
        List<Showroom__c> testShowrooms = GetShowroomUsingRESTAPI.callGetShowroom(accountId);
        Test.stopTest();

        System.assertEquals(151, testShowrooms.size());
    }
}