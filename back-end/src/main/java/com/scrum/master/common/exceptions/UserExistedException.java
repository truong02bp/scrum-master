package com.scrum.master.common.exceptions;

import org.springframework.http.HttpStatus;

/**
 * @author TruongNH
 */
public class UserExistedException extends BusinessException {
    public UserExistedException(String email) {
        this.status = HttpStatus.BAD_REQUEST;
        this.message = "User is existed with email: " + email;
    }
}
