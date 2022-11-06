package com.scrum.master.service.impl;

import com.scrum.master.data.entities.Issue;
import com.scrum.master.data.repositories.IssueRepository;
import com.scrum.master.service.IssueService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class IssueServiceImpl implements IssueService {

    private final IssueRepository issueRepository;

    @Override
    public Issue create(Issue issue) {
        return issueRepository.save(issue);
    }

    @Override
    public Issue update(Issue issue) {
        return issueRepository.save(issue);
    }

    @Override
    public void delete(Long issueId) {
        issueRepository.deleteById(issueId);
    }
}
