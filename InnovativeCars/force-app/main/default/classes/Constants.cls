/**
* @author Agnieszka Ząbkowicz
* @date 11.06.2021
* @description class storing constants
*/
global class Constants {
    global static final String TEST_ACCOUNT_NAME = 'Super Cars';
    global static final String TEST_SHOWROOM_NAME = 'Super fast cars';

    global static final String PICKLIST_PERSONAL_CARS = 'Personal Cars';
    global static final String PICKLIST_AVAILABLE = 'Available at the showroom';
    global static final String PICKLIST_AVAILABLE_AT_DIFFERENT = 'Available at different showroom';
    global static final String PICKLIST_TEMPERATURE = 'Temperature';
    global static final String PICKLIST_ROTATION_SPEED = 'Rotation speed';
    global static final String PICKLIST_CLOSED = 'Closed';
    global static final String PICKLIST_FAILED = 'Failed';

    global static final String FULL_SHOWROOM_ERROR = 'Cannot add a new car because the showroom is full!';
    global static final String ALREADY_AVAILABLE_ERROR = 'The car offer is already available at the showroom';
    global static final String NOT_IN_SHOWROOM_ERROR = 'The car is not in selected showroom';
    global static final String THERE_ALREADY_IS_WAREHOUSE_ERROR = 'Account of this showroom already has a warehouse: ';
    global static final String CANNOT_CLOSE_ERROR = 'Cannot close because there are cars left in the showroom';
    global static final String LESS_THAN_ZERO_ERROR = 'Number of car spaces cannot be less then 0!';
    global static final String LESS_THAN_CARS_AVAILABLE_ERROR = 'Number of car spaces cannot be less then number of cars available at the showroom!';
    global static final String TELEMETRIES_DELETED_MESSAGE = 'Telemetries older than 90 days deleted successfully';
    global static final String EMAIL_SEND_SUCCESSFULLY_MESSAGE = 'The email was sent successfully.';
    global static final String EMAIL_SEND_FAILED_MESSAGE = 'The email failed to send: ';
    global static final String NEW_OFFERS_EMAIL_SUBJECT = 'New offers added!';
    global static final String NEW_OFFERS_EMAIL_BODY = 'New offers have been added to showrooms. Number of offers: ';
    global static final String CASE_SUBJECT_RENOVATION = 'Renovation Case ';
    global static final String CASE_ORIGIN_WEB = 'Web';
    global static final String RENOVATION_ENDPOINT = 'https://jsonplaceholder.typicode.com/posts';
    global static final String CONNECTION_FAILED_MESSAGE = 'Connection failed';
    global static final String CRON_EXP = '0 0 0 15 6 ? *';
    global static string ACCOUNT_ID_FOR_CAR_FROM_REST = '0010900000Qz9oRAAR';
    
    global static Map<String, String> CAR_TYPE_TO_POJAZD_EXTERNAL_RODZAJ_MAP = new Map<String, String>
    {
         'Sport'=>'sport',
         'Family'=>'family',
         'Truck'=>'truck'
    };
    global static Map<String, String> POJAZD_EXTERNAL_RODZAJ_TO_CAR_TYPE_MAP = new Map<String, String>
    {
         'sport'=>'Sport',
         'family'=>'Family',
         'truck'=>'Truck'
    };
    global static Map<String, String> CAR_STATE_TO_POJAZD_EXTERNAL_STAN_MAP = new Map<String, String>
    {
		'New' => 'new',
		'Ready for sale' => 'ready_for_sale',
		'Sold' => 'sold',
		'In repair' => 'in_repair',
		'Broken' => 'broken'
    };
    global static Map<String, String> POJAZD_EXTERNAL_STAN_TO_CAR_STATE_MAP = new Map<String, String>
    {
		'new' =>'New' ,
		'ready_for_sale'=> 'Ready for sale',
		'sold' =>'Sold',
		'in_repair' =>'In repair',
		'broken' => 'Broken'
    };
    global static Map<String, String> SHOWROOM_TYPE_TO_SALON_EXTERNAL_TYP_MAP = new Map<String, String>
    {
		'Personal Cars' => 'personal_cars',
		'Specialist Cars' => 'specialist_cars',
		'All' => 'all'
    };
    global static Map<String, String> SALON_EXTERNAL_TYP_TO_SHOWROOM_TYPE_MAP = new Map<String, String>
    {
		'personal_cars' => 'Personal Cars',
		'specialist_cars' => 'Specialist Cars',
		'all' => 'All'
    };        
	global static Map<String, String> SHOWROOM_STATUS_TO_SALON_EXTERNAL_STATUS_MAP = new Map<String, String>
    {
		'Open' => 'open',
		'Closed' => 'closed',
		'Open Day' => 'open_day'
    };
    global static Map<String, String> SALON_EXTERNAL_STATUS_TO_SHOWROOM_STATUS_MAP = new Map<String, String>
    {
		 'open' => 'Open',
		 'closed' => 'Closed',
		 'open_day' => 'Open Day'
    };     
}