/**
* @author Agnieszka Ząbkowicz
* @date 16.06.2021
* @description test class for DeleteOldTelemetriesScheduler class
*/
@isTest
public with sharing class DeleteOldTelemetriesSchedulerTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 16.06.2021
    * @description method testing running scheduler for deleting old telemetries
    */
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