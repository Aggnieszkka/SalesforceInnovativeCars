/**
* @author Agnieszka Ząbkowicz
* @date 15.06.2021
* @description class for sending email about new offers
*/
public class NewOffersEmailSender {
    
    /**
    * @author Agnieszka Ząbkowicz
    * @date 15.06.2021
    * @description method sending email about new offers
    * @param newOffersIds list of new offers
    */
    @future (callout = true)
    public static void sendEmail(List<ID> newOffersIds){

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'noviv37645@0ranges.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.NEW_OFFERS_EMAIL_SUBJECT);
        mail.setPlainTextBody(Constants.NEW_OFFERS_EMAIL_BODY + newOffersIds.size());
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });

        if (results[0].success) {
            System.debug(LoggingLevel.INFO, Constants.EMAIL_SEND_SUCCESSFULLY_MESSAGE);
        } else {
            System.debug(LoggingLevel.ERROR, Constants.EMAIL_SEND_FAILED_MESSAGE + results[0].errors[0].message);
        }
    }
}