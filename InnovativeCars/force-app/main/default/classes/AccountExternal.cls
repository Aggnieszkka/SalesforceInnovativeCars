/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description class for wrapping accounts and unwrapping external accounts
*/
global class AccountExternal {
    public AccountExternal(){
        
    }
    
    public AccountExternal(Account inAccount){
        accountId = inAccount.Id;
        name = inAccount.Name;
        type = inAccount.Type;
        liczba_nieruchomosci = inAccount.Estate_Count__c;
        
        billingAddress = new AccountExternal.BillingAddress();
       	billingAddress.city = inAccount.BillingCity;
        billingAddress.country = inAccount.BillingCountry;
        billingAddress.geocodeAccuracy = inAccount.BillingGeocodeAccuracy;
        billingAddress.latitude = inAccount.BillingLatitude != null ? ''+inAccount.BillingLatitude : null;
        billingAddress.longitude = inAccount.BillingLongitude != null ? ''+inAccount.BillingLongitude : null;
        billingAddress.postalCode = inAccount.BillingPostalCode;
        billingAddress.state = inAccount.BillingState;
        billingAddress.street = inAccount.BillingStreet;
        
        shippingAddress = new AccountExternal.ShippingAddress();
        shippingAddress.city = inAccount.ShippingCity;
        shippingAddress.country = inAccount.ShippingCountry;
        shippingAddress.geocodeAccuracy = inAccount.ShippingGeocodeAccuracy;
        shippingAddress.latitude = inAccount.ShippingLatitude != null ? ''+inAccount.ShippingLatitude : null;
        shippingAddress.longitude = inAccount.ShippingLongitude != null ? ''+inAccount.ShippingLongitude : null;
        shippingAddress.postalCode = inAccount.ShippingPostalCode;
        shippingAddress.state = inAccount.ShippingState;
        shippingAddress.street = inAccount.ShippingStreet;
    }
    
    public class BillingAddress {
        public String city;
        public String country;
        public String geocodeAccuracy;
        public String latitude;
        public String longitude;
        public String postalCode;
        public String state;
        public String street;
    }
    public String accountId;
    public String name;
    public String type;
    public BillingAddress billingAddress;
    public ShippingAddress shippingAddress;
    public Double liczba_nieruchomosci;
    public class ShippingAddress {
        public String city;
        public String country;
        public String geocodeAccuracy;
        public String latitude;
        public String longitude;
        public String postalCode;
        public String state;
        public String street;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for parsing JSON to AccountExternal
    * @param json serialized AccountExternal
    * @return parsed AccountExternal
    */
    public static AccountExternal parse(String json) {
        return (AccountExternal) System.JSON.deserialize(json, AccountExternal.class);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for getting Account from ExternalAccount
    * @return Account object
    */
    public Account getAccount(){
        Account account = new Account(
            Name = name,
            Type = type,   
            External_ID__c = accountId,
            External_Estate_Count__c = liczba_nieruchomosci,         
            
            BillingCity = billingAddress.city,
            BillingCountry = billingAddress.country,
            BillingGeocodeAccuracy = billingAddress.geocodeAccuracy,
            BillingLatitude = billingAddress.latitude != null ? Decimal.valueOf(BillingAddress.latitude) : 0,
            BillingLongitude = billingAddress.longitude != null ? Decimal.valueOf(BillingAddress.longitude) : 0,
            BillingPostalCode = billingAddress.postalCode,
            BillingState = billingAddress.state,
            BillingStreet = billingAddress.street,
            
            ShippingCity = shippingAddress.city,
            ShippingCountry = shippingAddress.country,
            ShippingGeocodeAccuracy = shippingAddress.geocodeAccuracy,
            ShippingLatitude = shippingAddress.latitude != null ? Decimal.valueOf(ShippingAddress.latitude) : 0,
            ShippingLongitude = shippingAddress.longitude != null ? Decimal.valueOf(ShippingAddress.longitude) : 0,
            ShippingPostalCode = shippingAddress.postalCode,
            ShippingState = shippingAddress.state,
            ShippingStreet = shippingAddress.street
            );

        return account;
    }
}