package com.scrum.master.service;

import com.scrum.master.data.entities.Sprint;

import java.util.List;

public interface SprintService {

    List<Sprint> findByProjectId(Long projectId);

    Sprint findSprintActiveByProjectId(Long projectId);

    Sprint create(Sprint sprint);

    Sprint active(Long sprintId);

    void delete(Long sprintId);
}
