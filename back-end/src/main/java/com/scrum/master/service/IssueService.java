package com.scrum.master.service;

import com.scrum.master.data.entities.Issue;

import java.util.List;

public interface IssueService {

    List<Issue> findByProjectId(Long projectId);
    List<Issue> updateIndex(List<Issue> issues);

    Issue create(Issue issue);

    Issue update(Issue issue);

    void delete(Long issueId);
}
