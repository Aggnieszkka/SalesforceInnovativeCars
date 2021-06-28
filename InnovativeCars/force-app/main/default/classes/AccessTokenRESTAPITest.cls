/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing AccessTokenRESTAPI
*/
@isTest
public class AccessTokenRESTAPITest {
	@isTest static void testAccessTokenRESTAPI() {
        Test.setMock(HttpCalloutMock.class, new AccessTokenRESTAPIMock()); 
        AccessTokenRESTAPI accessToken = new AccessTokenRESTAPI();
        
        Test.startTest();
        String token = accessToken.returnAccessToken();
        Test.stopTest();

        System.assertEquals('XXXXXX', token);
    }
}