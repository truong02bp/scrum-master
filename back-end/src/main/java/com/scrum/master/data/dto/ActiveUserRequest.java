package com.scrum.master.data.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

/**
 * @author TruongNH
 */
@Getter
@Setter
public class ActiveUserRequest {
    @Schema(required = true)
    private String email;
    @Schema(required = true)
    private String name;
    @Schema(required = true)
    private String password;

}
