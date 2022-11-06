package com.scrum.master.service;

import com.scrum.master.data.entities.Project;

import java.util.List;

public interface ProjectService {

    List<Project> getAll(Long organizationId);

    Project create(Project project);

}
