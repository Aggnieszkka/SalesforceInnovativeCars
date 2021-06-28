/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description mock class for AccountRESTAPITest
*/
@isTest
global class AccountRESTAPIMock implements HttpCalloutMock{
    
	global HTTPResponse respond(HTTPRequest request) {
        List<Account> account = TestFactory.getAccount();
        
        AccountExternal external = new AccountExternal(account[0]);
        List<AccountExternal> externalList = new List<AccountExternal>{external};
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
		response.setBody(JSON.serialize(externalList));
        
        return response; 
    }
}