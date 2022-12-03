package com.scrum.master.data.dto;

import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.User;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProjectMemberStatics {

    @Getter
    @Setter
    public static class MemberStatics {
        private User user;
        private int totalIssue;
    }

    private Project project;
    private List<MemberStatics> members;
}
