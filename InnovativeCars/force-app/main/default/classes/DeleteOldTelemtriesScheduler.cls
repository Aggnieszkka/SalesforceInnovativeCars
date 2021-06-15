/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description class for scheduling deleting old telemetries
*/
global class DeleteOldTelemtriesScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
        DeleteOldTelemetries deleteOldTelemetries = new DeleteOldTelemetries();
        database.executebatch(deleteOldTelemetries);
    }
}