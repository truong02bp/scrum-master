package com.scrum.master.service.impl;

import com.scrum.master.common.exceptions.*;
import com.scrum.master.common.utils.Validator;
import com.scrum.master.data.dto.ActiveUserRequest;
import com.scrum.master.data.dto.MediaDto;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.dto.UserDto;
import com.scrum.master.data.entities.Organization;
import com.scrum.master.data.entities.User;
import com.scrum.master.data.repositories.RoleRepository;
import com.scrum.master.data.repositories.UserRepository;
import com.scrum.master.service.MailService;
import com.scrum.master.service.MinioService;
import com.scrum.master.service.UserService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final RoleRepository roleRepository;
    private final MailService mailService;
    private final MinioService minioService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email).orElseThrow(() -> {
            throw new UsernameNotFoundException("Not found email : " + email);
        });
        List<GrantedAuthority> authorities = new ArrayList<>() {{
            add(new SimpleGrantedAuthority("ROLE_" + user.getRole().getCode()));
        }};
        return new MyUserDetails(user.getEmail(), user.getPassword(), true, true, true, true, authorities, user);
    }

    @Override
    public int update(User user) {
        int rowUpdated = userRepository.update(user.getName(), user.getAddress(), user.getPhone(), user.getId());
        if (rowUpdated != 1) {
            throw BusinessException.builder().status(HttpStatus.INTERNAL_SERVER_ERROR).message("Update user failed").build();
        }
        return rowUpdated;
    }

    @Override
    public User updatePassword(UserDto userDto) {
        User user = findById(userDto.getId());
        if (!bCryptPasswordEncoder.matches(userDto.getOldPassword(), user.getPassword())) {
            throw BusinessException.builder().status(HttpStatus.INTERNAL_SERVER_ERROR).message("Old password don't match").build();
        }
        user.setPassword(bCryptPasswordEncoder.encode(userDto.getNewPassword()));
        return userRepository.save(user);
    }

    @Override
    public User updateAvatar(MediaDto mediaDto) {
        if (mediaDto.getBytes() == null) {
            throw BusinessException.builder().status(HttpStatus.BAD_REQUEST).message("Bytes media must not be empty").build();
        }

        final String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
        String folder = "/" + time + "/";
        minioService.upload(folder, mediaDto.getName(), new ByteArrayInputStream(mediaDto.getBytes()));
        String url = folder + mediaDto.getName();
        User user = getCurrentUser();
        user.setAvatarUrl(url);
        return userRepository.save(user);
    }

    @Override
    public List<User> findAll() {
        Organization organization = getCurrentOrganization();
        return userRepository.findByOrganization(organization.getId());
    }

    public User findById(Long id) {
        return userRepository.findById(id).orElseThrow(() -> {
            throw BusinessException.builder().message("User not found with id {" + id + "}").status(HttpStatus.NOT_FOUND).build();
        });
    }

    @Override
    public User create(User user) {
        String email = user.getEmail();
        if (!Validator.isValidEmail(email) || user.getRole() == null) {
            throw new UserRegisterInvalidException();
        }
        User existedUser = userRepository.findByEmail(email).orElse(null);
        if (existedUser != null && existedUser.isActive()) {
            throw new UserExistedException(email);
        }
        // send email active user
        mailService.sendActiveUserMail(email);
        if (existedUser != null) {
            return existedUser;
        }
        user.setOrganization(getCurrentOrganization());
        user.setAvatarUrl("/anonymous.png");
        return userRepository.save(user);
    }

    @Override
    public User activeUser(ActiveUserRequest activeUserRequest) {
        String email = activeUserRequest.getEmail();
        if (StringUtils.isBlank(email)) {
            throw new ActiveUserInvalidException();
        }
        User user = userRepository.findInactiveUserByEmail(email).orElseThrow(() -> {
            throw new UserNotFoundException(email);
        });
        user.setActive(true);
        // user yet active by email
        if (user.getPassword() == null) {
            String password = activeUserRequest.getPassword();
            String name = activeUserRequest.getName();
            if (StringUtils.isBlank(password) || StringUtils.isBlank(name)) {
                throw new ActiveUserInvalidException();
            }
            user.setName(name);
            user.setPassword(bCryptPasswordEncoder.encode(password));
        }
        return userRepository.save(user);
    }

    private User getCurrentUser() {
        MyUserDetails myUserDetails = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return myUserDetails.getUser();
    }

    private Organization getCurrentOrganization() {
        MyUserDetails myUserDetails = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return myUserDetails.getUser().getOrganization();
    }
}
