package com.scrum.master.controller;

import com.scrum.master.common.utils.JwtUtils;
import com.scrum.master.data.dto.AuthenticationRequest;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final UserService userService;

    @PostMapping("/authenticate")
    public ResponseEntity<String> authenticate(@RequestBody AuthenticationRequest request) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));
        } catch (BadCredentialsException e) {
            throw new BadCredentialsException("Invalid email " + request.getEmail());
        }
        MyUserDetails myUserDetails = (MyUserDetails) userService.loadUserByUsername(request.getEmail());
        String jwt = JwtUtils.generateToken(myUserDetails);
        return ResponseEntity.ok(jwt);
    }
}
