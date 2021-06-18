/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description trigger handling:
* - check if car is not already available in another showroom before inserting and updating
* - check if there is space in showroom for a car before inserting and updating
*/
trigger CarToShowroomTrigger on Car_To_Showroom__c (before insert, before update, after insert) {
    
    if(trigger.isBefore){
    	if(trigger.isInsert || trigger.isUpdate){
            CarToShowroomHandler.checkIfCarIsAlreadyAvailable(Trigger.New);
            CarToShowroomHandler.checkIfCarIsInShowroom(Trigger.New);
        }
    }
    if(trigger.isAfter){
    	if(trigger.isInsert){
            CarToShowroomHandler.sendEmailAboutNewOffers(Trigger.New);
        }
    }
}