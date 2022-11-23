package com.scrum.master.data.dto;

import lombok.Data;

import java.util.List;

@Data
public class UserDto {
    private Long id;
    private String oldPassword;
    private String newPassword;
    private String name;
    private String phone;
    private String address;
    private List<Byte> bytes;
}
