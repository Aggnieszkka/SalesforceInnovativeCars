/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description handler for CarTrigger
*/
public class CarHandler {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method checking if there is space in showroom for a car 
    * and adding error to car when appropriate
    * @param newCars list of car objects to check
    */
    public static void checkIfThereIsSpaceInShowroom(List<Car__c> newCars) {
        Set<Id> showroomIds = new Set<Id>();
        for(Car__c car : newCars){
            if(car.Showroom__c != null){
                showroomIds.add(car.Showroom__c);
            }
        }
        
        List<Showroom__c> showrooms = [SELECT Id, Car_Spaces__c FROM Showroom__c WHERE Id IN :showroomIds];
 		List<Car__c> cars = [SELECT Id, Showroom__c FROM Car__c WHERE Showroom__c IN :showroomIds];
 		
        Map<Id, Decimal> showroomIdToCarCount = new Map<Id, Decimal>();
        Map<Id, Decimal> showroomIdToCarSpaces = new Map<Id, Decimal>();
        
        for(Showroom__c showroom : showrooms) {
            showroomIdToCarCount.put(showroom.Id, 0);
            showroomIdToCarSpaces.put(showroom.Id, showroom.Car_Spaces__c);
        }
        for(Car__c car : cars){
            Decimal carCount = showroomIdToCarCount.get(car.Showroom__c);
           	showroomIdToCarCount.put(car.Showroom__c, carCount + 1);
        }
        
    	for(Car__c car : newCars){
        	if(car.Showroom__c == null){
                continue;
            }
            Decimal showroomCarSpaces = showroomIdToCarSpaces.get(car.Showroom__c);
            if(showroomCarSpaces == null){
                continue;
            }
            
            Decimal carInShowroomCount = showroomIdToCarCount.get(car.Showroom__c);
            
            if(carInShowroomCount < showroomCarSpaces) {
                showroomIdToCarCount.put(car.Showroom__c, carInShowroomCount + 1);
            } else {
                car.addError(
                    Constants.FULL_SHOWROOM_ERROR);
            }
    	}
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method creating new utilization report object based on list of deleted cars
    * @param deletedCars list of car objects to create reports for
    */
    public static void createUtilizationReport(List<Car__c> deletedCars) {
        List<Utilization_Report__c> reportsToInsert = new List<Utilization_Report__c>();
    
    	for(Car__c car : deletedCars){
        	Utilization_Report__c report = new Utilization_Report__c(Car_Serial_Number__c = car.Serial_Number__c);
        	reportsToInsert.add(report);
    	}
    	insert reportsToInsert;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method deleting telemetries of deleted cars
    * @param deletedCars list of car objects
    */
    public static void deleteTelemetries(List<Car__c> deletedCars) {
    		List<Telemetry__c> telemetries = [SELECT Id FROM Telemetry__c WHERE Car__c IN :deletedCars];
    		delete telemetries;
    }
    
    public static Map<Boolean, List<Car__c>> divideByDestination(List<Car__c> deletedCars){
        Map<Boolean, List<Car__c>> destinationMap = new Map<Boolean, List<Car__c>>();
        destinationMap.put(false, new List<Car__c>());
        destinationMap.put(true, new List<Car__c>());
        
        for(Car__c car : deletedCars){
            Boolean isAnotherConsortiumInterested = car.Is_Another_Consortium_Interested__c != null && car.Is_Another_Consortium_Interested__c;
        	List<Car__c> temporaryList = destinationMap.get(isAnotherConsortiumInterested);
            temporaryList.add(car);
            destinationMap.put(isAnotherConsortiumInterested, temporaryList);
        }
        
        return destinationMap;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for sending deleted cars to another consortium
    * @param carsToSend list of car objects
    */
    public static void sendToAnotherConsortium(List<Car__c> carsToSend){
        List<String> serializedExternals = new List<String>();
        
        for(Car__c car : carsToSend){
            PojazdExternal external = new PojazdExternal(car);
            serializedExternals.add(JSON.serialize(external));
        }
        
        sendToAnotherConsortiumFuture(serializedExternals);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description future method for sending deleted cars to another consortium
    * @param carsToSend list of car objects
    */
    @future(callout=true)
    public static void sendToAnotherConsortiumFuture(List<String> carsToSend){
        for(String car : carsToSend){
            GetCarUsingRESTAPI.callPostCar(PojazdExternal.parse(car));
        }
    }
}