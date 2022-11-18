package com.scrum.master.service;

import com.scrum.master.data.entities.Issue;

import java.util.List;
import java.util.Set;

public interface IssueService {

    List<Issue> findByProjectId(Long projectId);
    List<Issue> findBySprintId(Long sprintId);
    List<Issue> updateIndex(List<Issue> issues);

    List<Issue> assignToSprint(Long sprintId, Set<Long> ids);

    Issue create(Issue issue);

    Issue update(Issue issue);

    void delete(Long issueId);
}
