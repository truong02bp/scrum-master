package com.scrum.master.common.exceptions;

import org.springframework.http.HttpStatus;

/**
 * @author TruongNH
 */
public class UserNotFoundException extends BusinessException {

    public UserNotFoundException() {
        this.message = "User not found";
        this.status = HttpStatus.BAD_REQUEST;
    }

    public UserNotFoundException(String email) {
        this.message = "User not found with email: " + email;
        this.status = HttpStatus.BAD_REQUEST;
    }
}
