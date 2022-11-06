package com.scrum.master.common.exceptions;

import lombok.*;
import org.springframework.http.HttpStatus;

/**
 * @author TruongNH
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BusinessException extends RuntimeException {

    protected HttpStatus status;
    protected String message;

}
