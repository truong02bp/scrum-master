package com.scrum.master.service.impl;

import com.scrum.master.service.MailService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;

/**
 * @author TruongNH
 */
@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService {

    @Value("${url.redirect.active.user}")
    private String urlRedirect;

    private final JavaMailSender mailSender;

    @Override
    public void sendActiveUserMail(String email) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        String activeUrl = urlRedirect + "?email=" + email;
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setTo(email);
            helper.setSubject("Invite to using Scrum Master system");
            helper.setSentDate(new Date());
            helper.setText(createActiveUserMailContent(activeUrl), true);
            ClassPathResource classPathResource = new ClassPathResource("static/scrum.png");
            helper.addInline("imageUrl", classPathResource);
            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            throw new RuntimeException();
        }
    }

    private String createActiveUserMailContent(String activeUrl) {
        return "<html>\n" +
            "\n" +
            "<body style=\"margin: 0 !important; padding: 0 !important;\">\n" +
            "  <div\n" +
            "    style=\"display: flex; justify-content: center; align-items: center; height: 100%; font-family: Helvetica, Arial, sans-serif;\">\n" +
            "    <div\n" +
            "      style=\"border-radius: 4px; border: 1px solid #d1d5db; max-width: 600px; margin: 0 auto 10px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.08), 0 2px 4px -1px rgba(0, 0, 0, 0.02);\">\n" +
            "      <div style=\"display: flex; align-items: center; padding: 5px 30px; border-bottom: 1px solid #cbd5e1\">\n" +
            "        <img src=\"cid:imageUrl\" width=\"44px\" height=\"44px\" style=\"margin: auto 0;\"/>\n" +
            "        <h1 style=\"font-size: 20px; font-weight: 600; margin-left: 6px;color: black !important;\">Scrum Master</h1>\n" +
            "      </div>\n" +
            "\n" +
            "      <div style=\"padding: 18px 30px;\">\n" +
            "        <div style=\"font-weight: 600; font-size: 20px; margin-bottom: 15px;color: black !important;\">Welcome!</div>\n" +
            "        <div style=\"color: #27272a; font-size: 16px; font-weight: 400; line-height: 25px;\">\n" +
            "          <div>We're excited to invite you to use User Acquisition system. First, you need to confirm your account. Just\n" +
            "            press the button below.</div>\n" +
            "        </div>\n" +
            "        <a href=\"" + activeUrl + "\" target=\"_blank\"\n" +
            "          style=\"background-color: #4f46e5 !important; margin-top: 12px; font-size: 16px; color: #ffffff; text-decoration: none; text-decoration: none; padding: 10px 12px; border-radius: 2px; border: 1px solid #4f46e5; display: inline-block;\">Join\n" +
            "          your team</a>\n" +
            "      </div>\n" +
            "      <div\n" +
            "        style=\"background-color: #e5e5e5; border-top: 1px solid #d1d5db; text-align: center; color: #525252; padding: 14px 30px; font-size: 13px;\">\n" +
            "        <div>\n" +
            "          <span style=\"margin-right: 4px; opacity: 0.8;\">Send by Scrum Master |</span>\n" +
            "          <span><a href=\"https://falcongames.com/\" style=\"text-decoration: none; color: #4f46e5 !important\">Terms and\n" +
            "              Conditions</a></span>\n" +
            "        </div>\n" +
            "        <div style=\"margin-top: 16px; font-size: 14px;\">Do not reply to this email.</div>\n" +
            "      </div>\n" +
            "    </div>\n" +
            "  </div>\n" +
            "</body>\n" +
            "\n" +
            "</html>";
    }

}
