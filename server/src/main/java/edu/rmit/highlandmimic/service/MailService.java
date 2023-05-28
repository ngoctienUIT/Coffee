package edu.rmit.highlandmimic.service;

import edu.rmit.highlandmimic.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
@RequiredArgsConstructor
public class MailService {
    private static final String EMAIL_SENDER = "resetpass@auf.com";
    private final JavaMailSender mailSender;

    public void issueResetPassword(User receiver, String resetToken) throws MessagingException {
        String to = receiver.getEmail();

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setSubject("Action needed: Reset Password for your account");
        helper.setFrom(EMAIL_SENDER);
        helper.setTo(to);

        String mailContent = """
                <p>Hello, <b> %s </b></p>
                 <p>This is an automatic issued email based on your request of resetting password. <em>Please do not reply to this email</em></p>
                 <p>You have just require us to reset your forgotten password. Before we allow you to do so, please follow upcoming instructions to let us know who exact you are.</p>
                 <p>Please use the code (<em>6 characters</em>) below for validation on your app. After a successful validation, the app will forward you automatically to create new password form.</p>

                 <p style="border: 2.5px solid darkblue; background: white; border-radius: 5px; padding: 25px; font-size: 2em; text-align: center; color: darkblue; font-family: monospace;">
                     %s
                 </p>
                """.formatted(receiver.getDisplayName(), resetToken);

        helper.setText(
                this.renderTitleHeader("Reset Your Password")
                + this.renderContentTemplate(mailContent)
                + this.renderSignatureAndFooter()
        ,true);

        mailSender.send(message);
    }

    private String renderTitleHeader(String title) {
        return """
               <h1 style="padding: 1em; margin-bottom: 0px; font-size: 2em; font-family: 'Cambria'; text-align: right; background: linear-gradient(to left, #191654, #43C6AC); color: white;">
                     %s
                 </h1>
               """.formatted(title);
    }

    private String renderSignatureAndFooter() {
        return """
               <footer style="padding: 25px; background: #202124; color: white;">
                     <strong>Aufgabe Tasks</strong> mailing service. 2023 &copy;
                 </footer>
               """;
    }

    private String renderContentTemplate(String htmlContent) {
        return """
                <div style="display: flex; width: 100%%; padding-top: 50px; padding-bottom: 50px;">
                     <div style="margin: auto; padding: 1em">
                         %s
                         <br>
                         <p>If there are any further issues or supports required, please contact the <strong>Aufgabe Mailing Support Team</strong> at <em>support@auf.com</em>.</p>
                         <br>
                         <hr><br>
                         <p>Thanks for choosing us for your business.</p>
                         <p>Best regards,</p>
                         <br>
                         <p><strong>Aufgabe Mailing Team</strong></p>
                     </div>
                 </div>
               """.formatted(htmlContent);
    }
}
