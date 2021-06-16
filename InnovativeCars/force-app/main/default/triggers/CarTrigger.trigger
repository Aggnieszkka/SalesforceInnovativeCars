/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description trigger handling:
* - check if there is space in showroom for a car before inserting and updating
* - creating utilization reports and deleting telemetries when car is being deleted
*/
trigger CarTrigger on Car__c (before insert, before update, before delete) {
	
    if(trigger.isBefore){
    	if(trigger.isInsert || trigger.isUpdate){
			CarHandler.checkIfThereIsSpaceInShowroom(Trigger.New);
    	}
        
    	if(trigger.isDelete){
    		CarHandler.createUtilizationReport(Trigger.old);
    		CarHandler.deleteTelemetries(Trigger.old);
    	}
	}
}