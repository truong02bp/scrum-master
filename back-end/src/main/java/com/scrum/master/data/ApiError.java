package com.scrum.master.data;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ApiError {
    private int code;
    private String message;

    public ApiError(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
