package unsw.comp4920.project;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {
    final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    private String to;
    private String from = "comp4920mealplannerG03@gmail.com";
    private String host = "localhost";

    // Get system properties object
    private Properties props = System.getProperties();

    public SendEmail(String to){
        this.to = to;
    }

    public void sendActivateEmail(String code, String user){
        // Setup mail server
        //properties.setProperty("mail.smtp.host", host);
        // Get session
        //properties.put("mail.smtp.auth", "true"); //这样才能通过验证


        /* Get the default Session object.
        Session session = Session.getDefaultInstance(properties);*/

        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.setProperty("mail.smtp.socketFactory.fallback", "false");
        props.setProperty("mail.smtp.port", "465");
        props.setProperty("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        props.put("mail.store.protocol", "pop3");
        props.put("mail.transport.protocol", "smtp");
        final String password = "mealplanner";
        Session session = Session.getDefaultInstance(props,
                new Authenticator(){
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }});
        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject("Activate your account!");

            // Now set the actual message
            message.setContent("<h1>Hi! This is MealPlanner. Thank you for joining us!<h1> <h3>Please click on the link below" +
                    " to activate your account.<h3>\n" +
                    "<a href='http://localhost:8080/control?action="+ ControllerActions.ACTIVATE_ACCOUNT +
                    "&&code="+code+"&&user="+user+"'>http://localhost:8080/activate_account</a>","text/html");

            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
        }catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}