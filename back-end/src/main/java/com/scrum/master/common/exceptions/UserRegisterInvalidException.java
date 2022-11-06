package com.scrum.master.common.exceptions;

import org.springframework.http.HttpStatus;

/**
 * @author TruongNH
 */
public class UserRegisterInvalidException extends BusinessException {
    public UserRegisterInvalidException() {
        this.status = HttpStatus.BAD_REQUEST;
        this.message = "User is invalid !";
    }
}
