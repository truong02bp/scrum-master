package com.scrum.master.service;

import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.ProjectMember;

import java.util.List;

public interface ProjectService {

    List<Project> getAll();

    Project create(Project project);

    ProjectMember addMember(Long id, ProjectMember member);
    ProjectMember removeMember(Long id, ProjectMember member);

    void delete(Long id);
}
