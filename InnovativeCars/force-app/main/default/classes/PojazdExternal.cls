/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description class for wrapping cars and unwrapping external cars
*/
global class PojazdExternal {
    public PojazdExternal(){
        
    }
    
    public PojazdExternal(Car__c inCar){
        pojazdId = inCar.Id;
        name = inCar.Serial_Number__c;
        marka = inCar.Brand__c;
        model = inCar.Model__c;
        stan = Constants.CAR_STATE_TO_POJAZD_EXTERNAL_STAN_MAP.get(inCar.State__c);
        cena = inCar.Price__c;
        wyposazenie = inCar.Equipment__c;
        moc = inCar.Power__c;
        ladownosc = inCar.Capacity_kg__c;
        spalanie = inCar.Fuel_Usage__c;
        rodzaj = Constants.CAR_TYPE_TO_POJAZD_EXTERNAL_RODZAJ_MAP.get(inCar.Type__c);
        manager_notes = inCar.Manager_Notes__c;
        salonId = inCar.Showroom__c;
        accountId = inCar.Account__c;
        czy_usunac = inCar.Is_Another_Consortium_Interested__c;
    }
    
    public String pojazdId;
    public String name;
    public String marka;
    public String model;
    public String stan;
    public Double cena;
    public String wyposazenie;
    public Double moc;
    public Double ladownosc;
    public Double spalanie;
    public String rodzaj;
    public String manager_notes;
    public String salonId;
    public String accountId;
    public Boolean czy_usunac;
      
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for parsing JSON to PojazdExternal
    * @param json serialized PojazdExternal
    * @return parsed PojazdExternal
    */
    public static PojazdExternal parse(String json) {
        return (PojazdExternal) System.JSON.deserialize(json, PojazdExternal.class);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for getiing car from PojazdExternal
    * @return Car object
    */
    public Car__c getCar(){
        String serialNumber = '';
        if(name.length() < 6){
            for(Integer i=0; i<6-name.length(); i++){
                serialNumber += 'X';
            }
            serialNumber+=name;
        }
        else{
            serialNumber=name.substring(0, 6);
        }
        Car__c car = new Car__c(
            Brand__c = marka,
            Model__c = model,
            State__c = Constants.POJAZD_EXTERNAL_STAN_TO_CAR_STATE_MAP.get(stan),
            Price__c = cena,
            Equipment__c = wyposazenie,
            Power__c = moc,
            Capacity_kg__c = ladownosc,
            Fuel_Usage__c = spalanie,
            Type__c = Constants.POJAZD_EXTERNAL_RODZAJ_TO_CAR_TYPE_MAP.get(rodzaj),
            Manager_Notes__c = manager_notes,
            Serial_Number__c = serialNumber
        );
        if(czy_usunac != null){
            car.Is_Another_Consortium_Interested__c = czy_usunac;
        }
        
        return car;
    }
}