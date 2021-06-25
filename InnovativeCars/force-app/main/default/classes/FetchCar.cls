/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for fetching cars, changing checkbox value if interested
* and inserting cars send from another consortium in response of external callout
*/
@RestResource(urlMapping='/v1/cars/*')
global with sharing class FetchCar{
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for fetching cars in response of external callout
    * @return list of external cars objects
    */
	@HttpGet
    global static List<PojazdExternal> fetchCar(){
        RestRequest request = RestContext.request;
        Id showroomId = (Id)request.params.get('salonId');
        List<Car__c> listCars =[Select 
                                Id, Name, Brand__c, Serial_Number__c,
                                Model__c, State__c, Price__c, 
                                Equipment__c, Power__c, Capacity_kg__c, 
                                Fuel_Usage__c, Type__c, Manager_Notes__c, 
                                Showroom__c, Account__c, Is_Another_Consortium_Interested__c 
                                from Car__c where Showroom__c = :showroomId];
        
        system.debug(showroomId);
        List<PojazdExternal> listExternalCars = new List<PojazdExternal>();
        for(Car__c car : listCars){
            listExternalCars.add(new PojazdExternal(car));
        }
        return listExternalCars;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for changing checkbox value if interested
    * in response of external callout
    * @return id of updated car
    */
    @HttpPatch
    global static ID updateCarField() {
        RestRequest request = RestContext.request;
        String carId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Car__c car = [SELECT Id, Is_Another_Consortium_Interested__c FROM Car__c WHERE Id = :carId];
        car.Is_Another_Consortium_Interested__c = Boolean.valueOf(request.params.get('czy_usunac'));

        update car;
        return car.Id;
    } 

    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for inserting cars send from another consortium
    * in response of external callout
    * @return id of inserted car
    */
    @HttpPost
    global static ID createCar() {
        RestRequest request = RestContext.request;
 
        PojazdExternal pojazdExternal = PojazdExternal.parse(request.requestBody.toString());
        Car__c car = pojazdExternal.getCar();
        car.Id = null;
        Account account;
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :Constants.ACCOUNT_ID_FOR_CAR_FROM_REST];
        if(accounts.size() > 0){
            account = accounts[0];
        } else {
            account = [SELECT Id FROM Account LIMIT 1];
        }
        car.Account__c = account.Id;
        insert car;
        return car.Id;
    }
}