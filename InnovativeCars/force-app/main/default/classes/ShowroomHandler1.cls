/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description handler for ShowroomTrigger
*/
public class ShowroomHandler1 {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method checking if there is only one warehouse per each account 
    * and adding error when appropriate
    * @param newShowrooms list of showroom objects to check
    */
    public static void checkIfOnlyOneWarehouse(List<Showroom__c> newShowrooms) {
            Set<Id> accountsIds = new Set<Id>();
            for(Showroom__c showroom : newShowrooms){
                if(showroom.Warehouse__c == true){
                    accountsIds.add(showroom.Account__c);
                }
            }

            List<Showroom__c> warehouseList = [SELECT Id, Account__c, Name FROM Showroom__c 
                WHERE Warehouse__c = true 
                AND Account__c IN :accountsIds];

            Map<Id, Showroom__c> accountIdToWarehouseMap = new Map<Id, Showroom__c>();
            for(Showroom__c warehouse : warehouseList){
                accountIdToWarehouseMap.put(warehouse.Account__c, warehouse);
            }

            for(Showroom__c showroom : newShowrooms){
                if(showroom.Warehouse__c == true){
                    Showroom__c warehouse = accountIdToWarehouseMap.get(showroom.Account__c);
                    if(warehouse == null){
                        accountIdToWarehouseMap.put(showroom.Account__c, showroom);
                    }
                    else if(warehouse.Id != showroom.Id){
                        showroom.addError(
                            Constants.THERE_ALREADY_IS_WAREHOUSE_ERROR + warehouse.Name);
                    }
                }
            }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method checking if there are no cars available at showroom before closing 
    * and adding error when appropriate
    * @param newShowrooms list of showroom objects to check
    */
    public static void checkIfShowroomIsEmptyBeforeClosing(List<Showroom__c> newShowrooms) {
        List<Showroom__c> showroomsToClose = new List<Showroom__c>();
        for(Showroom__c showroom : newShowrooms){
            if(showroom.Status__c == Constants.PICKLIST_CLOSED){
                showroomsToClose.add(showroom);
            }
        }
        
        List<Car__c> carsInShowrooms = [SELECT Id, Showroom__c FROM Car__c
             WHERE Showroom__c IN :showroomsToClose];

        Set<Id> showroomsWithCarsIds = new Set<Id>();
        for(Car__c car : carsInShowrooms){
            showroomsWithCarsIds.add(car.Showroom__c);
        }
            
        for(Showroom__c showroom : showroomsToClose){
            if(showroomsWithCarsIds.contains(showroom.Id)){
                showroom.addError(
                    Constants.CANNOT_CLOSE_ERROR);
            }   
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method checking if number of car spaces in showroom is equal or greater than zero
	* or number of cars available at the showroom and adding error when appropriate
    * @param newShowrooms list of showroom objects to check
    */
    public static void checkEditingNumberOfCarSpaces(List<Showroom__c> newShowrooms) {

            List<Car__c> carsAtShowrooms = [SELECT Id, Showroom__c FROM Car__c WHERE Showroom__c IN :newShowrooms];
            List<Car__c> carsAtShowroom = new List<Car__c>();

            Map<Id, Integer> showroomToCarCount = new Map<Id, Integer>();
            for(Showroom__c showroom : newShowrooms){
                showroomToCarCount.put(showroom.Id, 0);
            }
            for(Car__c car : carsAtShowrooms){
                Integer carCount = showroomToCarCount.get(car.Showroom__c);
                showroomToCarCount.put(car.Showroom__c, carCount+1);
            }
            
            for(Showroom__c showroom : newShowrooms){
                if(showroom.Car_Spaces__c < 0){
                    showroom.addError(
                               Constants.LESS_THAN_ZERO_ERROR);
                    continue;
                }
                if(showroom.Car_Spaces__c < showroomToCarCount.get(showroom.Id)){
                    showroom.addError(
                               Constants.LESS_THAN_CARS_AVAILABLE_ERROR);
                }
            }
    }

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method selecting closed showrooms from new showrooms
    * and sending them to a class responsible for sending request to a renovation team
    * @param newShowrooms list of showroom objects
    */
    public static void SendRequestForClosedShowrooms(List<Showroom__c> newShowrooms) {
        List<Showroom__c> closedShowrooms = new List<Showroom__c>();
        for(Showroom__c showroom : newShowrooms){
            if(showroom.Status__c == Constants.PICKLIST_CLOSED){
                closedShowrooms.add(showroom);
            }
        }
        RenovationTeamRequestSender request = new RenovationTeamRequestSender(closedShowrooms);
        System.enqueueJob(request);
    }
}