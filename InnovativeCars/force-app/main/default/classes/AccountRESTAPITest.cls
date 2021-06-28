/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing AccountRESTAPI
*/
@isTest
public class AccountRESTAPITest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing GetAccountUsingRESTAPI get method
    */
	@isTest static void testGetAccountUsingRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new AccountRESTAPIMock()); 
        
        Test.startTest();
        List<Account> accounts = AccountRESTAPI.callGetAccount(10);
        Test.stopTest();

        System.assertEquals(1, accounts.size());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 28.06.2021
    * @description method for testing GetAccountUsingRESTAPI get method
    */
	@isTest static void testGetAccountUsingRESTAPIUnauthorized() {
        Test.setMock(HttpCalloutMock.class, new AccountRESTAPIMockUnauthorized()); 
        
        Test.startTest();
        List<Account> accounts = AccountRESTAPI.callGetAccount(10);
        Test.stopTest();

        System.assertEquals(0, accounts.size());
    }
}