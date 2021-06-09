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
            List<Showroom__c> warehouseShowrooms = [SELECT Account__c, Name FROM Showroom__c WHERE Warehouse__c = true];
            
            for(Showroom__c showroom : newShowrooms){
                if(showroom.Warehouse__c == true){
                    for(Showroom__c warehouse : warehouseShowrooms){
                        if(warehouse.Account__c == showroom.Account__c && warehouse.Id != showroom.Id){
                            showroom.addError(
                               'Account of this showroom already has a warehouse: ' + warehouse.Name);
                            break;
                        }
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
            if(showroom.Status__c == 'Closed'){
                showroomsToClose.add(showroom);
            }
        }
        
        List<Car__c> carsInShowroom = new List<Car__c>(
            [SELECT Id, Showroom__c From Car__c
             WHERE Showroom__c IN :showroomsToClose]);
            

        for(Showroom__c showroom : showroomsToClose){
            for(Car__c car : carsInShowroom){
                if(car.Showroom__c == showroom.Id){
                    showroom.addError(
                        'Cannot close because there are cars left in the showroom');
                    break;
                }
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

            List<Car__c> carsAtShowrooms = new List<Car__c>(
                [SELECT Id, Showroom__c FROM Car__c WHERE Showroom__c != null]);
            List<Car__c> carsAtShowroom = new List<Car__c>();
            
            for(Showroom__c showroom : newShowrooms){
                if(showroom.Car_Spaces__c < 0){
                    showroom.addError(
                               'Number of car spaces cannot be less then 0!');
                    continue;
                }

                for(Car__c carAtShowroom : carsAtShowrooms){
                    if(carAtShowroom.Showroom__c == showroom.Id){
                        carsAtShowroom.add(carAtShowroom);
                    }
                }
                if(showroom.Car_Spaces__c < carsAtShowroom.size()){
                    showroom.addError(
                               'Number of car spaces cannot be less then number of cars available at the showroom!');
                }
            }
    }
}