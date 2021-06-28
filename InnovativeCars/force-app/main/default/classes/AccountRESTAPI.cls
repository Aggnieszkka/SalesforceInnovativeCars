/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for callout to get external accounts
*/
public class AccountRESTAPI{

    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for callout to get external accounts
    * @param inLimit limit of returned accounts
    * @return list of returned accounts
    */
    public static List<Account> callGetAccount(Integer inLimit){
        String accessToken;
        if(!Test.isRunningTest()){
            AccessTokenRESTAPI tokenRESTAPI = new AccessTokenRESTAPI();
        	accessToken = tokenRESTAPI.returnAccessToken();
        } else {
            accessToken = 'testToken';
        }
        List<Account> accountList = new List<Account>();
        if(accessToken != null) {
            String endPoint = 'https://mindful-shark-iwybc-dev-ed.my.salesforce.com/services/apexrest/v1/accounts?limit='+inLimit;
            Http newHttp = new Http();
            HttpRequest newRequest = new HttpRequest();
            newRequest.setHeader('Authorization','Bearer ' + accessToken);
            newRequest.setHeader('Content-Type','application/json');
            newRequest.setHeader('accept','application/json');
            newRequest.setMethod('GET');
            newRequest.setEndpoint(endPoint);
            HttpResponse newResponse = newHttp.send(newRequest);
            try {
                String trimmedResponse = newResponse.getBody().unescapeCsv().remove('\\');
                system.debug('@@@RESPONSE@@'+trimmedResponse);
                
                List<AccountExternal> accountExternalList = (List<AccountExternal>)JSON.deserialize(newResponse.getBody(), List<AccountExternal>.class);
                for(AccountExternal accountExternal : accountExternalList){
                    System.debug('###AccountEx###' + accountExternal.Name + ' - ' + accountExternal.accountId + '(' + accountExternal.liczba_nieruchomosci + ')');
                    Account account = accountExternal.getAccount();
                    accountList.add(account);
                }
            } catch(Exception e) {
                System.debug('###Exception###' + e);
			}
        }
        return accountList;
    }
}