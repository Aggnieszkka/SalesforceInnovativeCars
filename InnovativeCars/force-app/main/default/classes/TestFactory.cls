/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description class for delivering data for tests
*/
@isTest
public class TestFactory {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method for delivering cars for tests
    * @param inCarsNumber number of cars to create and add to database
    * @return list of created cars
    */
    public static List<Car__c> createCars(Integer inCarsNumber){

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :Constants.TEST_ACCOUNT_NAME];
        if(accounts.size() == 0){
            accounts = createAccount();
        }
        
        List<Car__c> cars = new List<Car__c>();
        Car__c newCar = new Car__c();
        for(Integer i = 0; i < inCarsNumber; i++){
            if(i<10){
            	newCar = new Car__c(Serial_Number__c = '00000'+i, Account__c = accounts[0].Id);
            }
            else if(i<100){
                newCar = new Car__c(Serial_Number__c = '0000'+i, Account__c = accounts[0].Id);
            }
            else if(i<1000){
                newCar = new Car__c(Serial_Number__c = '000'+i, Account__c = accounts[0].Id);
            }
            else if(i<10000){
                newCar = new Car__c(Serial_Number__c = '00'+i, Account__c = accounts[0].Id);
            }
            else if(i<100000){
                newCar = new Car__c(Serial_Number__c = '0'+i, Account__c = accounts[0].Id);
            }
            else if(i<1000000){
                newCar = new Car__c(Serial_Number__c = ''+i, Account__c = accounts[0].Id);
            }
            else{
                break;
            }
        	cars.add(newCar);   
        }

        insert cars;
        return cars;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method for delivering showrooms for tests
    * @param inShowroomsNumber number of showrooms to create and add to database
    * @return list of created showrooms
    */
    public static List<Showroom__c> createShowrooms(Integer inShowroomsNumber){

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :Constants.TEST_ACCOUNT_NAME];
        if(accounts.size() == 0){
            accounts = createAccount();
        }

        List<Showroom__c> showrooms = new List<Showroom__c>();
        for(Integer i = 0; i < inShowroomsNumber; i++){
            Showroom__c newShowroom = new Showroom__c(
                Name = Constants.TEST_CAR_NAME + i, 
                Type__c = Constants.PICKLIST_PERSONAL_CARS, 
                Account__c = accounts[0].Id);
            showrooms.add(newShowroom);
        }

        insert showrooms;
        return showrooms;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 11.06.2021
    * @description method for creating an account for cars and showrooms
    * to be assigned to
    * @return list containing created account
    */
    private static List<Account> createAccount(){
        Account newAccount = new Account(Name = Constants.TEST_ACCOUNT_NAME);
        List<Account> newAccounts = new List<Account>{newAccount};
        insert newAccounts;
        return newAccounts;
    }

    /**
    * @author Agnieszka Ząbkowicz
    * @date 15.06.2021
    * @description method for delivering telemetries for tests
    * @param inTelemetriesNumber number of telemetries to create and add to database
    * @return list of created telemetries
    */
    public static List<Telemetry__c> createTelemetries(Integer inTelemetriesNumber){
        List<Car__c> cars = createCars(1);
        List<Telemetry__c> telemetries = new List<Telemetry__c>();
        
        for(Integer i = 0; i < inTelemetriesNumber; i++){
            Telemetry__c telemetry = new Telemetry__c(Type__c = 'Temperature', Car__c = cars[0].Id);
            telemetries.add(telemetry);
        }
        insert telemetries;
        return telemetries;
    }
}