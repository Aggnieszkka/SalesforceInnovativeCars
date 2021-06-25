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
}