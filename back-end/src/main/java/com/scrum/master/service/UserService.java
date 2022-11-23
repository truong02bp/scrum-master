package com.scrum.master.service;


import com.scrum.master.data.dto.ActiveUserRequest;
import com.scrum.master.data.dto.MediaDto;
import com.scrum.master.data.dto.UserDto;
import com.scrum.master.data.entities.User;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    /**
     * Create a new user
     *
     * @param user user need to create
     *
     * @return non-active user
     */
    User create(User user);

    /**
     * Active a new user
     *
     * @param activeUserRequest contains email, new password
     *
     * @return active user
     */
    User activeUser(ActiveUserRequest activeUserRequest);
    User update(UserDto userDto);
    User updatePassword(UserDto userDto);
    User updateAvatar(MediaDto dto);

    List<User> findAll();
}
