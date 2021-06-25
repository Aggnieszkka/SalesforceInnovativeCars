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
        switch on inCar.State__c {
            when 'New'{
                stan = 'new';
            }
            when 'Ready for sale'{
                stan = 'ready_for_sale';
            }
            when 'Sold'{
                stan = 'sold';
            }
            when 'In repair'{
                stan = 'in_repair';
            }
            when 'Broken'{
                stan = 'broken';
            }
        }
        cena = inCar.Price__c;
        wyposazenie = inCar.Equipment__c;
        moc = inCar.Power__c;
        ladownosc = inCar.Capacity_kg__c;
        spalanie = inCar.Fuel_Usage__c;
        switch on inCar.Type__c {
            when 'Sport'{
                rodzaj = 'sport';
            }
            when 'Family'{
                rodzaj = 'family';
            }
            when 'Truck'{
                rodzaj = 'truck';
            }
        }
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
        String carState = null;
        String carType = null;
        switch on stan {
            when 'new'{
                carState = 'New';
            }
            when 'ready_for_sale'{
                carState = 'Ready for sale';
            }
            when 'sold'{
                carState = 'Sold';
            }
            when 'in_repair'{
                carState = 'In repair';
            }
            when 'broken'{
                carState = 'Broken';
            }
        }
        switch on rodzaj {
            when 'sport'{
                carType = 'Sport';
            }
            when 'family'{
                carType = 'Family';
            }
            when 'truck'{
                carType = 'Truck';
            }
        }
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
            State__c = carState,
            Price__c = cena,
            Equipment__c = wyposazenie,
            Power__c = moc,
            Capacity_kg__c = ladownosc,
            Fuel_Usage__c = spalanie,
            Type__c = carType,
            Manager_Notes__c = manager_notes,
            Serial_Number__c = serialNumber
        );
        if(czy_usunac != null){
            car.Is_Another_Consortium_Interested__c = czy_usunac;
        }
        
        return car;
    }
}