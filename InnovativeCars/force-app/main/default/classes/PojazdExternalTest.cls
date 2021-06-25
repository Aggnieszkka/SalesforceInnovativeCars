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
        
        for(Integer i = 0; i<151; i++) {
            Car__c car = cars[i];
            PojazdExternal external = new PojazdExternal(car);
            System.assertEquals(external.name, car.Serial_Number__c);
            System.assertEquals(external.pojazdId, car.Id);
            switch on car.State__c {
                when 'New'{
                    System.assertEquals(external.stan, 'new');
                }
                when 'Ready for sale'{
                    System.assertEquals(external.stan, 'ready_for_sale');
                }
                when 'Sold'{
                    System.assertEquals(external.stan, 'sold');
                }
                when 'In repair'{
                    System.assertEquals(external.stan, 'in_repair');
                }
                when 'Broken'{
                    System.assertEquals(external.stan, 'broken');
                }
            }
            switch on car.Type__c {
                when 'Sport'{
                    System.assertEquals(external.rodzaj, 'sport');
                }
                when 'Family'{
                    System.assertEquals(external.rodzaj, 'family');
                }
                when 'Truck'{
                    System.assertEquals(external.rodzaj, 'truck');
                }
            }
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
            switch on external.stan {
                when 'new'{
                    System.assertEquals(car.State__c, 'New');
                }
                when 'ready_for_sale'{
                    System.assertEquals(car.State__c, 'Ready for sale');
                }
                when 'sold'{
                    System.assertEquals(car.State__c, 'Sold');
                }
                when 'in_repair'{
                    System.assertEquals(car.State__c, 'In repair');
                }
                when 'broken'{
                    System.assertEquals(car.State__c, 'Broken');
                }
            }
            switch on external.rodzaj {
                when 'sport'{
                    System.assertEquals(car.Type__c, 'Sport');
                }
                when 'family'{
                    System.assertEquals(car.Type__c, 'Family');
                }
                when 'truck'{
                    System.assertEquals(car.Type__c, 'Truck');
                }
            }
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