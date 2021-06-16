/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description trigger handling:
* - check if there is only one warehouse for each account
* - check if showroom is empty before closing it
* - check if number of car spaces in showroom is equal or greater than zero
*   or number of cars available at the showroom
*/
trigger ShowroomTrigger on Showroom__c (before insert, before update, after insert, after update) {
    
    if(trigger.isBefore){
    	if(trigger.isInsert || trigger.isUpdate){
        	ShowroomHandler.checkIfOnlyOneWarehouse(Trigger.New);
            ShowroomHandler.checkIfShowroomIsEmptyBeforeClosing(Trigger.New);
            ShowroomHandler.checkEditingNumberOfCarSpaces(Trigger.New);
        }
    }
    if(trigger.isAfter){
    	if(trigger.isInsert || trigger.isUpdate){
            ShowroomHandler.SendRequestForClosedShowrooms(Trigger.New);
        }
    }
}