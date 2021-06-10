/**
* @author Agnieszka Ząbkowicz
* @date 06.2021
*
* @description class for delivering data for tests
*/
@isTest
public class TestFactory {

    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method for delivering cars for tests
    * @param number of cars to create and add to database
    * @return list of created cars
    */
    public static List<Car__c> createCars(Integer carsNumber){

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :Constants.testAccountName];
        if(accounts.size() == 0){
            accounts = createAccount();
        }
        
        List<Car__c> cars = new List<Car__c>();
        Car__c newCar = new Car__c();
        for(Integer i = 0; i < carsNumber; i++){
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
    * @date 06.2021
    *
    * @description method for delivering showrooms for tests
    * @param number of showrooms to create and add to database
    * @return list of created showrooms
    */
    public static List<Showroom__c> createShowrooms(Integer showroomsNumber){

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :Constants.testAccountName];
        if(accounts.size() == 0){
            accounts = createAccount();
        }

        List<Showroom__c> showrooms = new List<Showroom__c>();
        for(Integer i = 0; i < showroomsNumber; i++){
            Showroom__c newShowroom = new Showroom__c(
                Name = Constants.testCarName + i, 
                Type__c = Constants.picklistPersonalCars, 
                Account__c = accounts[0].Id);
            showrooms.add(newShowroom);
        }

        insert showrooms;
        return showrooms;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 06.2021
    *
    * @description method for creating an account for cars and showrooms
    * to be assigned to
    * @return list containing created account
    */
    private static List<Account> createAccount(){
        Account newAccount = new Account(Name = Constants.testAccountName);
        List<Account> newAccounts = new List<Account>{newAccount};
        insert newAccounts;
        return newAccounts;
    }
}