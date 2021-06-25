/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for testing SalonExternal class
*/
@isTest
public class SalonExternalTest {
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing creating SalonExternal object
    */
    @isTest 
    static void testCreatingSalonExternal(){
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);

        showrooms[0].Type__c = 'Personal Cars';
        showrooms[0].Status__c = 'Open';
        showrooms[1].Type__c = 'Specialist Cars';
        showrooms[1].Status__c = 'Closed';
        showrooms[2].Type__c = 'All';
        showrooms[2].Status__c = 'Open Day';
        
        for(Integer i = 0; i<151; i++) {
            Showroom__c showroom = showrooms[i];
            SalonExternal external = new SalonExternal(showroom);
            System.assertEquals(external.name, showroom.name);
            System.assertEquals(external.salonId, showroom.Id);
            switch on showroom.Type__c {
                when 'Personal Cars'{
                    System.assertEquals(external.typ, 'personal_cars');
                }
                when 'Specialist Cars'{
                    System.assertEquals(external.typ, 'specialist_cars');
                }
                when 'All'{
                    System.assertEquals(external.typ, 'all');
                }
            }
            switch on showroom.Status__c {
                when 'Open'{
                    System.assertEquals(external.status, 'open');
                }
                when 'Closed'{
                    System.assertEquals(external.status, 'closed');
                }
                when 'Open Day'{
                    System.assertEquals(external.status, 'open_day');
                }
            }
        }
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing getting showroom from SalonExternal object
    */
    @isTest 
    static void testGetingShowroomFromSalonExternal(){
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
		List<SalonExternal> salonExternals = new List<SalonExternal>();
        for(Integer i = 0; i<151; i++) {
            salonExternals.add(new SalonExternal(showrooms[i]));
        }
        
        salonExternals[0].typ = 'personal_cars';
        salonExternals[0].status = 'open';
        salonExternals[1].typ = 'specialist_cars';
        salonExternals[1].status = 'closed';
        salonExternals[2].typ = 'all';
        salonExternals[2].status = 'open_day';
        
        for(Integer i = 0; i<151; i++) {
            SalonExternal external = salonExternals[i];
            Showroom__c showroom = external.getShowroom();
            System.assertEquals(external.name, showroom.name);
            switch on external.typ {
                when 'personal_cars'{
                    System.assertEquals(showroom.Type__c, 'Personal Cars');
                }
                when 'specialist_cars'{
                    System.assertEquals(showroom.Type__c, 'Specialist Cars');
                }
                when 'all'{
                    System.assertEquals(showroom.Type__c, 'All');
                }
            }
            switch on external.status {
                when 'open'{
                    System.assertEquals(showroom.Status__c, 'Open');
                }
                when 'closed'{
                    System.assertEquals(showroom.Status__c, 'Closed');
                }
                when 'open_day'{
                    System.assertEquals(showroom.Status__c, 'Open Day');
                }
            }
        }

    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for testing parsing JSON to SalonExternal object
    */
    @isTest 
    static void testParseJSONToSalonExternal(){
        List<Showroom__c> showrooms = TestFactory.createShowrooms(151);
        for(Showroom__c showroom : showrooms) {
            SalonExternal salonExternalOriginal = new SalonExternal(showroom);
            String salonExternalJSON = JSON.serialize(salonExternalOriginal);
            SalonExternal deserializedSalonExternal = (SalonExternal) System.JSON.deserialize(salonExternalJSON, SalonExternal.class);
            System.assertEquals(deserializedSalonExternal.salonId, SalonExternal.parse(salonExternalJSON).salonId);
            System.assertEquals(deserializedSalonExternal.name, SalonExternal.parse(salonExternalJSON).name);
        }
    }
}