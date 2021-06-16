/**
* @author Agnieszka Ząbkowicz
* @date 15.06.2021
* @description test class for DeleteOldTelemetries class
*/
@isTest
public class DeleteOldTelemetriesTest {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 15.06.2021
    * @description method testing deleting telemetries older than 90 days
    */
    @isTest static void deleteOldTelemetries(){
        List<Telemetry__c> telemetries = TestFactory.createTelemetries(151);
        
        Datetime createdDate = Datetime.now().addDays(-100);
        for(Telemetry__c telemetry : telemetries){
            Test.setCreatedDate(telemetry.Id, createdDate);
        }

        Map<Id, Telemetry__c> IdToTelemetryMap = new Map<Id, Telemetry__c>(telemetries);
        List<Id> telemetriesIds = new List<Id>(IdToTelemetryMap.keySet());
      
        Test.startTest();
        DeleteOldTelemetries deleteOld = new DeleteOldTelemetries();
        Id batchId = Database.executeBatch(deleteOld);
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM Telemetry__c WHERE Id IN :telemetriesIds]);
    }
}