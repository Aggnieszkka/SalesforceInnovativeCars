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
        Set<Id> showroomIds = new Set<Id>();
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c == Constants.picklistAvailable) {
                carIds.add(newOffer.Car__c);
                showroomIds.add(newOffer.Showroom__c);
            }
        }

        Map<Id, Showroom__c> showroomMap = new Map<Id, Showroom__c>([SELECT Id, Name FROM Showroom__c WHERE Id IN :showroomIds]);

        List<Car_To_Showroom__c> carToShowroomsList = [SELECT Id, Car__c, Showroom__c FROM Car_To_Showroom__c 
             WHERE Availability__c = :Constants.picklistAvailable 
             AND Car__c IN :carIds];

        Map<Id, Id> existingCarAtShowrooms = new Map<Id, Id>();
        for(Car_To_Showroom__c carToShowroom : carToShowroomsList){
            existingCarAtShowrooms.put(carToShowroom.Car__c, carToShowroom.Id);
        }
        
        for (Car_To_Showroom__c carToShowroom : newOffers){
            if(carToShowroom.Availability__c == Constants.picklistAvailable){
                Id existingCarToShowroomId = existingCarAtShowrooms.get(carToShowroom.Car__c);
                if(existingCarToShowroomId == null){
                    existingCarAtShowrooms.put(carToShowroom.Car__c, carToShowroom.Id);
                }
                else if(existingCarToShowroomId != carToShowroom.ID){
                    String name = showroomMap.get(carToShowroom.Showroom__c).Name;
                    carToShowroom.addError(
                        Constants.alreadyAvailableError + ' ' + name);
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
            if(newOffer.Availability__c == Constants.picklistAvailable) {
                carIds.add(newOffer.Car__c);
            }
        }
        List<Car__c> carList = [SELECT Id, Showroom__c FROM Car__c WHERE Id in :carIds];
        
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c != Constants.picklistAvailable) {
                continue;
            }
            
            for(Car__c car : carList) {
                if(newOffer.Car__c == car.Id) {
                    if(newOffer.Showroom__c != car.Showroom__c) {
                        newOffer.addError(
                            Constants.notInShowroomError);
                    } 
                    break;
                }
            }
        }
    }
}