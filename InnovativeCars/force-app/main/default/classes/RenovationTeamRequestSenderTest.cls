/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing RenovationTeamRequestSender
*/
@isTest
public class RenovationTeamRequestSenderTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description class for testing RenovationTeamRequestSender callout
    */
    @isTest static void testRenovationTeamRequestSender() {
        Test.setMock(HttpCalloutMock.class, new RenovationTeamRequestSenderMock()); 
        List<Case> newCases = new List<Case>{new Case(Status = 'New', Origin = 'Phone')};
        insert newCases;
        RenovationTeamRequestSender sender = new RenovationTeamRequestSender(newCases);
        
        Test.startTest();
        HttpResponse response = sender.sendRequest();
        Test.stopTest();

        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        System.assertEquals(201, response.getStatusCode());
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description class for testing RenovationTeamRequestSender queueable
    */
    @isTest static void testRenovationTeamRequestSenderEnqueue(){
        Test.setMock(HttpCalloutMock.class, new RenovationTeamRequestSenderMock()); 
        List<Case> newCases = new List<Case>{new Case(Status = 'New', Origin = 'Phone')};
        insert newCases;
        RenovationTeamRequestSender sender = new RenovationTeamRequestSender(newCases);
    
        Test.startTest();
        id jobId = System.enqueueJob(sender);
        Test.stopTest();
        
        System.assert(jobId != null);
    }
}