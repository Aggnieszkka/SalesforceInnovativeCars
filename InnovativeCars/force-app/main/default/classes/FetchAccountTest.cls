/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing FetchAccount
*/
@isTest
public class FetchAccountTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing fetching account
    */
	@isTest static void testFetchAccount() {
        TestFactory.getAccount();
        RestRequest request = new RestRequest();
        request.requestUri ='https://yourInstance.salesforce.com/services/apexrest/v1/accounts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        List<AccountExternal> accounts = FetchAccount.fetchAccount();
        System.assertEquals(accounts.size(), 1);
        System.assertEquals(Constants.TEST_ACCOUNT_NAME, accounts[0].name);
    }
}