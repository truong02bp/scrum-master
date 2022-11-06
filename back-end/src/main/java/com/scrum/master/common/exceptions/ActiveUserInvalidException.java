package com.scrum.master.common.exceptions;

import org.springframework.http.HttpStatus;

/**
 * @author TruongNH
 */
public class ActiveUserInvalidException extends BusinessException {
    public ActiveUserInvalidException() {
        this.status = HttpStatus.BAD_REQUEST;
        this.message = "Invalid information confirm register";
    }
}
