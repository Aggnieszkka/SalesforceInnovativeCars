/**
* @author Agnieszka Ząbkowicz
* @date 17.06.2021
* @description class for creating cases to send to renovation team
* when a showroom is being closed
*/
public class RenovationTeamCaseCreator implements Queueable, Database.AllowsCallouts{
    private List<Showroom__c> closedShowrooms;
    
    public RenovationTeamCaseCreator(List<Showroom__c> showrooms){
        this.closedShowrooms = showrooms;
    }

    public void execute(QueueableContext context){
        List<Case> newCases = new List<Case>();
        for(Showroom__c showroom : closedShowrooms){
            newCases.add(new Case(
                Subject = Constants.CASE_SUBJECT_RENOVATION + showroom.Name, 
                Showroom__c = showroom.Id, 
                Origin = Constants.CASE_ORIGIN_WEB
                ));
        }
        insert newCases;
        RenovationTeamRequestSender request = new RenovationTeamRequestSender(newCases);
        if(!Test.isRunningTest()){
            System.enqueueJob(request);
        }
    }
}
