package com.scrum.master.service;

import com.scrum.master.data.entities.Issue;

public interface IssueService {

    Issue create(Issue issue);

    Issue update(Issue issue);

    void delete(Long issueId);
}
