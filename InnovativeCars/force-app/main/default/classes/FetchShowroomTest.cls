/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing FetchShowroom
*/
@isTest
public class FetchShowroomTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing fetching schowrooms
    */
	@isTest static void testFetchShowroom() {
        Id accountId = TestFactory.getAccount()[0].id;
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        RestRequest request = new RestRequest();
        request.requestUri ='https://yourInstance.salesforce.com/services/apexrest/v1/showrooms?accountId=' + accountId;
        request.params.put('accountId', accountId);
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        List<SalonExternal> testShowrooms = FetchShowroom.fetchShowroom();
        System.assertEquals(testShowrooms.size(), 151);
        System.assert(testShowrooms[0].name.startsWith(Constants.TEST_SHOWROOM_NAME));
    }
}