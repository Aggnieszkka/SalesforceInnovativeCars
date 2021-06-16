/**
* @author Agnieszka Ząbkowicz
* @date 15.06.2021
* @description class for deleting telemetries older than 90 days
*/
public class DeleteOldTelemetries implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        date d = system.today().adddays(-90);
        return Database.getQueryLocator(
            'SELECT Id FROM Telemetry__c WHERE DAY_ONLY(CreatedDate) <= :d'
        );
    }
    public void execute(Database.BatchableContext bc, List<sObject> records){
        delete records;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(Constants.TELEMETRIES_DELETED_MESSAGE);
    }
}