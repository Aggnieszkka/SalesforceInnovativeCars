/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description handler for CarToShowroomTrigger
*/
public class CarToShowroomHandler1 {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method checking if car is already available in showroom 
    * and adding error when appropriate
    * @param newOffers list of offers objects to check
    */
    public static void checkIfCarIsAlreadyAvailable(List<Car_To_Showroom__c> newOffers) {
        Set<Id> carIds = new Set<Id>();
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c == Constants.PICKLIST_AVAILABLE) {
                carIds.add(newOffer.Car__c);
            }
        }

        List<Car__c> cars = [SELECT Id FROM Car__c WHERE Id IN :carIds];
        Map<Car__c, String> carToShowroomNameMap = new Map<Car__c, String>();
        for(Car__c car : cars){
            carToShowroomNameMap.put(car, car.Showroom__r.Name);
        }

        List<Car_To_Showroom__c> carToShowroomsList = [SELECT Id, Car__c, Showroom__c FROM Car_To_Showroom__c 
             WHERE Availability__c = :Constants.PICKLIST_AVAILABLE 
             AND Car__c IN :carIds];

        Map<Id, Id> existingCarAtShowrooms = new Map<Id, Id>();
        for(Car_To_Showroom__c carToShowroom : carToShowroomsList){
            existingCarAtShowrooms.put(carToShowroom.Car__c, carToShowroom.Id);
        }
        
        for (Car_To_Showroom__c carToShowroom : newOffers){
            if(carToShowroom.Availability__c == Constants.PICKLIST_AVAILABLE){
                Id existingCarToShowroomId = existingCarAtShowrooms.get(carToShowroom.Car__c);
                if(existingCarToShowroomId == null){
                    existingCarAtShowrooms.put(carToShowroom.Car__c, carToShowroom.Id);
                }
                else if(existingCarToShowroomId != carToShowroom.ID){
                    String name = carToShowroomNameMap.get(carToShowroom.Car__r);
                    carToShowroom.addError(
                        Constants.ALREADY_AVAILABLE_ERROR + ' ' + name);
                }
            }
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method checking before adding new offer if the car is in the showroom
    * @param newOffers list of offers objects to check
    */
    public static void checkIfCarIsInShowroom(List<Car_To_Showroom__c> newOffers) {
        Set<Id> carIds = new Set<Id>();
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c == Constants.PICKLIST_AVAILABLE) {
                carIds.add(newOffer.Car__c);
            }
        }
        List<Car__c> carList = [SELECT Id, Showroom__c FROM Car__c WHERE Id in :carIds];
        
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c != Constants.PICKLIST_AVAILABLE) {
                continue;
            }
            
            for(Car__c car : carList) {
                if(newOffer.Car__c == car.Id) {
                    if(newOffer.Showroom__c != car.Showroom__c) {
                        newOffer.addError(
                            Constants.NOT_IN_SHOWROOM_ERROR);
                    } 
                    break;
                }
            }
        }
    }
}