/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for fetching accounts in response of external callout
*/
@RestResource(urlMapping='/v1/accounts/*')
global with sharing class FetchAccount {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for fetching accounts in response of external callout
    * @return list of external accounts
    */
    @HttpGet
    global static list<AccountExternal> fetchAccount(){
        List<account> listAccount =[Select 
                                    Id, Name, Type, 
                                    BillingCity, BillingCountry, BillingGeocodeAccuracy, BillingLatitude,
                                    BillingLongitude, BillingPostalCode, BillingState, BillingStreet,
                                    ShippingCity, ShippingCountry, ShippingGeocodeAccuracy, ShippingLatitude,
                                    ShippingLongitude, ShippingPostalCode, ShippingState, ShippingStreet,
									Estate_Count__c 
                                    from Account];
        List<AccountExternal> listExternalAccount = new List<AccountExternal>();
        for(Account account : listAccount){
            listExternalAccount.add(new Accountexternal(account));
        }
        return listExternalAccount ;
    }
}