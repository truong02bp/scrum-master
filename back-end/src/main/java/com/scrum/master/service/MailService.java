package com.scrum.master.service;

/**
 * @author TruongNH
 */
public interface MailService {
    /**
     * Send an email active new user
     *
     * @param email email of new user
     */
    void sendActiveUserMail(String email);

}
