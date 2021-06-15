global class DeleteOldTelemtriesScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
        DeleteOldTelemetries deleteOldTelemetries = new DeleteOldTelemetries();
        database.executebatch(deleteOldTelemetries);
    }
}