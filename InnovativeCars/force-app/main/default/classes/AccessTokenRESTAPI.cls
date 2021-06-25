/**
* @author Agnieszka Ząbkowicz
* @date 24.06.2021
* @description class for getting access token
*/
public class AccessTokenRESTAPI {
    private final String clientId = '3MVG9SOw8KERNN08MBdULtqQcYMzCoEBbMN3IPY6BRlRKC_Ha176oZ_3iFOQQ7ww3WKEnXKZk2xBkep64qcZ4';
    private final String clientSecret = '2EA4F1F78ECC57691ABCBD2F2D90A908E609022080647347919456DDA3ADB7D9';
    private final String username = 'externaluseradamrosiak@gmail.com';
    private final String password = 'ZAQ!2wsxnBaLL33neeh00Fdfw7mgnIaYI';
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description class for storing body of response
    */
    public class DeserializeResponse{
        public String id;
        public String access_token;
    }
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 24.06.2021
    * @description method for getting access token
    * @return response.access_token access token for a callout
    */
    public String returnAccessToken(){
        String requestBody = 'grant_type=password' 
            + '&client_id='+clientId 
            + '&client_secret='+clientSecret 
            + '&username='+username 
            + '&password='+password;

        Http newHttp = new Http();
        HttpRequest newRequest = new HttpRequest();
        newRequest.setBody(requestBody);
        newRequest.setMethod('POST');
        newRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse newResponse = newHttp.send(newRequest);
        DeserializeResponse response = (DeserializeResponse)JSON.deserialize(newResponse.getbody(), DeserializeResponse.class);
        system.debug('@@@@access_token@@'+response );
        return response.access_token;
    }
}