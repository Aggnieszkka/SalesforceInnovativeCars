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
            if(newOffer.Availability__c == 'Available at the showroom') {
                carIds.add(newOffer.Car__c);
            }
        }
        List<Car_To_Showroom__c> carToShowroomsList = new List <Car_To_Showroom__c>(
            [SELECT Car__c, Showroom__c FROM Car_To_Showroom__c 
             WHERE Availability__c LIKE 'Available at the showroom' 
             AND Car__c IN :carIds]);
        
        for (Car_To_Showroom__c carToShowroom : newOffers){
            if(carToShowroom.Availability__c == 'Available at the showroom'){
                for(Car_To_Showroom__c existingCarToShowroom : carToShowroomsList){
                    if(existingCarToShowroom.Car__c == carToShowroom.Car__c){
                        if(existingCarToShowroom.Id != carToShowroom.ID){
                        	carToShowroom.addError(
                            	'The car is already available at showroom');
                        }
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
    * @description method checking before adding new offer if the car is in the showroom
    * @param newOffers list of offers objects to check
    */
    public static void checkIfCarIsInShowroom(List<Car_To_Showroom__c> newOffers) {
        Set<Id> carIds = new Set<Id>();
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c == 'Available at the showroom') {
                carIds.add(newOffer.Car__c);
            }
        }
        List<Car__c> carList = new List <Car__c>([SELECT Id, Showroom__c FROM Car__c WHERE Id in :carIds]);
        
        for(Car_To_Showroom__c newOffer : newOffers) {
            if(newOffer.Availability__c != 'Available at the showroom') {
                continue;
            }
            
            for(Car__c car : carList) {
                if(newOffer.Car__c == car.Id) {
                    if(newOffer.Showroom__c != car.Showroom__c) {
                        newOffer.addError(
                                'The car is not in selected showroom');
                    } 
                    break;
                }
            }
        }
    }
}