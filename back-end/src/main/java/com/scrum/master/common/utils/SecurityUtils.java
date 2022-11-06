package com.scrum.master.common.utils;

import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.entities.Organization;
import com.scrum.master.data.entities.User;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtils {
    public static User getCurrentUser() {
        MyUserDetails myUserDetails = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return myUserDetails.getUser();
    }

    public static Organization getCurrentOrganization() {
        MyUserDetails myUserDetails = (MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return myUserDetails.getUser().getOrganization();
    }
}
