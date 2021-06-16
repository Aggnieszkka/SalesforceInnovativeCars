/**
* @author Agnieszka Ząbkowicz
* @date 15.06.2021
* @description class for sending request to renovation team
* when a showroom is being closed
*/
public class RenovationTeamRequestSender implements Queueable, Database.AllowsCallouts{
    private List<Showroom__c> closedShowrooms;

    public RenovationTeamRequestSender(List<Showroom__c> showrooms){
        this.closedShowrooms = showrooms;
    }

    public void execute(QueueableContext context){
        if(!Test.isRunningTest()){
            List<Case> newCases = new List<Case>();
            for(Showroom__c showroom : closedShowrooms){
                newCases.add(new Case(
                    Subject = Constants.CASE_SUBJECT_RENOVATION + showroom.Name, 
                    Showroom__c = showroom.Id, 
                    Origin = Constants.CASE_ORIGIN_WEB
                    ));
            }

            Http server = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Constants.RENOVATION_ENDPOINT);
            req.setMethod('POST');
            req.setBody(JSON.serialize(newCases)); 
            HttpResponse resp = server.send(req);
            if(resp.getStatusCode() == 201){
                for(Case newCase : newCases){
                    newCase.Status = Constants.PICKLIST_CLOSED;
                }
            }
            else{
                for(Case newCase : newCases){
                    newCase.Status = Constants.PICKLIST_FAILED;
                }
                System.debug(LoggingLevel.ERROR, Constants.CONNECTION_FAILED_MESSAGE);
            }
            insert newCases;
        }
    }
}