@isTest
public class DeleteOldTelemetriesTest {

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

    @isTest static void runScheduler(){
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
         Constants.CRON_EXP,
         new DeleteOldTelemtriesScheduler());
        Test.stopTest();

        CronTrigger cronTrigger = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
            FROM CronTrigger WHERE id = :jobId];
 
        System.assertEquals(Constants.CRON_EXP, cronTrigger.CronExpression);
    }
}