package com.scrum.master.data.dto;

import com.scrum.master.data.entities.Project;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProjectStatics {

    @Getter
    @Setter
    public static class ProjectIssue {
        private Project project;
        private int totalIssue;
    }

    private List<ProjectIssue> projectIssues;
}
