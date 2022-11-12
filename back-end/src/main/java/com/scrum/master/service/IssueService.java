package com.scrum.master.service;

import com.scrum.master.data.entities.Issue;

import java.util.List;

public interface IssueService {

    List<Issue> findByProjectId(Long projectId);

    Issue create(Issue issue);

    Issue update(Issue issue);

    void delete(Long issueId);
}
