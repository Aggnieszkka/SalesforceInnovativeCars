/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing GetAccountUsingRESTAPI
*/
@isTest
public class GetAccountUsingRESTAPITest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetAccountUsingRESTAPI get method
    */
	@isTest static void testGetAccountUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new GetAccountUsingRESTAPIMock()); 
        
        Test.startTest();
        List<Account> accounts = GetAccountUsingRESTAPI.callGetAccount(10);
        Test.stopTest();

        System.assertEquals(1, accounts.size());
    }
}