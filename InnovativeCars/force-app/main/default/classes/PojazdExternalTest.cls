/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing PojazdExternal class
*/
@isTest
public class PojazdExternalTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing creating PojazdExternal object
    */
	@isTest 
    static void testCreatingPojazdExternal(){
        List<Car__c> cars = TestFactory.createCars(151);

        cars[0].Type__c = 'Sport';
        cars[0].State__c = 'New';
        cars[1].Type__c = 'Family';
        cars[1].State__c = 'Ready for sale';
        cars[2].Type__c = 'Truck';
        cars[2].State__c = 'Sold';
        cars[3].State__c = 'In repair';
        cars[4].State__c = 'Broken';
        
        for(Car__c car : cars) {
            PojazdExternal external = new PojazdExternal(car);
            System.assertEquals(external.name, car.Serial_Number__c);
            System.assertEquals(external.pojazdId, car.Id);
            System.assertEquals(external.stan, Constants.CAR_STATE_TO_POJAZD_EXTERNAL_STAN_MAP.get(car.State__c));
			System.assertEquals(external.rodzaj, Constants.CAR_TYPE_TO_POJAZD_EXTERNAL_RODZAJ_MAP.get(car.Type__c));
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing getting car from PojazdExternal object
    */
    @isTest 
    static void testGetingCarFromPojazdExternal(){
        List<Car__c> cars = TestFactory.createCars(151);
		List<PojazdExternal> pojazdExternals = new List<PojazdExternal>();
        for(Integer i = 0; i<151; i++) {
            pojazdExternals.add(new PojazdExternal(cars[i]));
        }
        
        pojazdExternals[0].rodzaj = 'sport';
        pojazdExternals[0].stan = 'new';
        pojazdExternals[1].rodzaj = 'family';
        pojazdExternals[1].stan = 'ready_for_sale';
        pojazdExternals[2].rodzaj = 'truck';
        pojazdExternals[2].stan = 'sold';
        pojazdExternals[3].stan = 'in_repair';
        pojazdExternals[4].stan = 'broken';
        pojazdExternals[149].name='X';
        pojazdExternals[150].name='XXXXXXX';
        
        for(Integer i = 0; i<149; i++) {
            PojazdExternal external = pojazdExternals[i];
            Car__c car = external.getCar();
            System.assertEquals(external.name, car.Serial_Number__c);
            System.assertEquals(Constants.POJAZD_EXTERNAL_STAN_TO_CAR_STATE_MAP.get(external.stan), car.State__c);
            System.assertEquals(Constants.POJAZD_EXTERNAL_RODZAJ_TO_CAR_TYPE_MAP.get(external.rodzaj), car.Type__c);
        }
        
        Car__c car149 = pojazdExternals[149].getCar();
        System.assertEquals('XXXXXX', car149.Serial_Number__c);
        
        Car__c car150 = pojazdExternals[149].getCar();
        System.assertEquals('XXXXXX', car150.Serial_Number__c);
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing parsing JSON to PojazdExternal object
    */
    @isTest 
    static void testParseJSONToPojazdExternal(){
        List<Car__c> cars = TestFactory.createCars(151);
        for(Car__c car : cars) {
            PojazdExternal pojazdExternalOriginal = new PojazdExternal(car);
            String pojazdExternalJSON = JSON.serialize(pojazdExternalOriginal);
            PojazdExternal deserializedPojazdExternal = (PojazdExternal) System.JSON.deserialize(pojazdExternalJSON, PojazdExternal.class);
            System.assertEquals(deserializedPojazdExternal.pojazdId, PojazdExternal.parse(pojazdExternalJSON).pojazdId);
            System.assertEquals(deserializedPojazdExternal.name, PojazdExternal.parse(pojazdExternalJSON).name);
        }
    }
}