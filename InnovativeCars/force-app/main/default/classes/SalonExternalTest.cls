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
        
        for(Showroom__c showroom : showrooms) {
            SalonExternal external = new SalonExternal(showroom);
            System.assertEquals(external.name, showroom.name);
            System.assertEquals(external.salonId, showroom.Id);
            System.assertEquals(external.typ, Constants.SHOWROOM_TYPE_TO_SALON_EXTERNAL_TYP_MAP.get(showroom.Type__c));
            System.assertEquals(external.status, Constants.SHOWROOM_STATUS_TO_SALON_EXTERNAL_STATUS_MAP.get(showroom.Status__c));
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
            System.assertEquals(Constants.SALON_EXTERNAL_TYP_TO_SHOWROOM_TYPE_MAP.get(external.typ), showroom.Type__c);
            System.assertEquals(Constants.SALON_EXTERNAL_STATUS_TO_SHOWROOM_STATUS_MAP.get(external.status), showroom.Status__c);
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