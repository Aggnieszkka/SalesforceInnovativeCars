/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description class for wrapping showrooms and unwrapping external showrooms
*/
global class SalonExternal {
    public SalonExternal() {
        
    }
    
    public SalonExternal(Showroom__c inShowroom) {
        salonId = inShowroom.Id;
        name = inShowroom.Name;
        adres = inShowroom.Address__c;
        typ = Constants.SHOWROOM_TYPE_TO_SALON_EXTERNAL_TYP_MAP.get(inShowroom.Type__c);
        accountId = inShowroom.Account__c;
        strona = inShowroom.Website__c;
        status = Constants.SHOWROOM_STATUS_TO_SALON_EXTERNAL_STATUS_MAP.get(inShowroom.Status__c);
        liczba_miejsc = inShowroom.Car_Spaces__c;
        magazyn = inShowroom.Warehouse__c;
        region = inShowroom.Region__c;
        liczba_stazystow = inShowroom.Interns__c;
    }
    
    public String salonId;
    public String name;
    public String adres;
    public String typ;
    public String accountId;
    public String strona;
    public String status;
    public Double liczba_miejsc;
    public Boolean magazyn;
    public String region;
    public Double liczba_stazystow;
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for parsing JSON to SalonExternal
    * @param json serialized SalonExternal
    * @return parsed SalonExternal
    */
    public static SalonExternal parse(String json) {
        return (SalonExternal) System.JSON.deserialize(json, SalonExternal.class);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for getting Showroom from SalonExternal
    * @return Showroom object
    */
    public Showroom__c getShowroom(){
        Showroom__c showroom = new Showroom__c(
            External_ID__c = salonId,
            Name = name,
           	Address__c = adres,
            Website__c = strona,
            Car_Spaces__c = liczba_miejsc,
            Warehouse__c = magazyn,
            Region__c = region,
            Interns__c = liczba_stazystow,
            Type__c = Constants.SALON_EXTERNAL_TYP_TO_SHOWROOM_TYPE_MAP.get(typ),
            Status__c = Constants.SALON_EXTERNAL_STATUS_TO_SHOWROOM_STATUS_MAP.get(status)
        );
        return showroom;
    }
}