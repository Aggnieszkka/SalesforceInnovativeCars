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
        switch on inShowroom.Type__c {
            when 'Personal Cars'{
                typ = 'personal_cars';
            }
            when 'Specialist Cars'{
                typ = 'specialist_cars';
            }
            when 'All'{
                typ = 'all';
            }
        }
        accountId = inShowroom.Account__c;
        strona = inShowroom.Website__c;
        switch on inShowroom.Status__c {
            when 'Open'{
                status = 'open';
            }
            when 'Closed'{
                status = 'closed';
            }
            when 'Open Day'{
                status = 'open_day';
            }
        }
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
        String showroomStatus = null;
        String showroomType = null;
       	switch on status {
            when 'open'{
                showroomStatus = 'Open';
            }
            when 'closed'{
                showroomStatus = 'Closed';
            }
            when 'open_day'{
                showroomStatus = 'Open Day';
            }
        }
        switch on typ {
            when 'personal_cars'{
                showroomType = 'Personal Cars';
            }
            when 'specialist_cars'{
                showroomType = 'Specialist Cars';
            }
            when 'all'{
                showroomType = 'All';
            }
        }
        Showroom__c showroom = new Showroom__c(
            Name = name,
           	Address__c = adres,
            Website__c = strona,
            Car_Spaces__c = liczba_miejsc,
            Warehouse__c = magazyn,
            Region__c = region,
            Interns__c = liczba_stazystow,
            Type__c = showroomType,
            Status__c = showroomStatus
        );
        return showroom;
    }
}