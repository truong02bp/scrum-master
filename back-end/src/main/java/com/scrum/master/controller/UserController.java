package com.scrum.master.controller;

import com.scrum.master.data.dto.ActiveUserRequest;
import com.scrum.master.data.dto.MediaDto;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.dto.UserDto;
import com.scrum.master.data.entities.User;
import com.scrum.master.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/user/all")
    public ResponseEntity<List<User>> findAll() {
        return ResponseEntity.ok(userService.findAll());
    }

    @GetMapping("/user")
    public ResponseEntity<User> gerCurrentUser() {
        MyUserDetails myUserDetails = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return ResponseEntity.ok(myUserDetails.getUser());
    }

    @PostMapping("/user")
    public ResponseEntity<User> create(@RequestBody User user) {
        return ResponseEntity.ok(userService.create(user));
    }

    @PutMapping("/user")
    public ResponseEntity<User> update(@RequestBody UserDto userDto) {
        return ResponseEntity.ok(userService.update(userDto));
    }

    @DeleteMapping("/user")
    public ResponseEntity<String> deleteUser(@RequestParam("id") Long id) {
        userService.delete(id);
        return ResponseEntity.ok("ok");
    }

    @DeleteMapping("/test")
    public ResponseEntity<String> delete() {
        userService.generateData();
        return ResponseEntity.ok("ok");
    }

    @PutMapping("/user/password")
    public ResponseEntity<User> updatePassword(@RequestBody UserDto userDto) {
        return ResponseEntity.ok(userService.updatePassword(userDto));
    }

    @PutMapping("/user/avatar")
    public ResponseEntity<User> updateAvatar(@RequestBody MediaDto mediaDto) {
        return ResponseEntity.ok(userService.updateAvatar(mediaDto));
    }

    @PostMapping("/user/active")
    public ResponseEntity<User> activeUser(@RequestBody ActiveUserRequest activeUserRequest) {
        return ResponseEntity.ok(userService.activeUser(activeUserRequest));
    }
}
