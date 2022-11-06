package com.scrum.master.configs;

import com.scrum.master.common.exceptions.BusinessException;
import com.scrum.master.data.ApiError;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionHandlerConfig {
    @ExceptionHandler(BusinessException.class)
    ResponseEntity<ApiError> apiException(BusinessException e) {
        e.printStackTrace();
        return ResponseEntity.badRequest().body(new ApiError(e.getStatus().value(), e.getMessage()));
    }
}
