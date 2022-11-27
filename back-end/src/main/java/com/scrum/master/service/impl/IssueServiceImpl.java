package com.scrum.master.service.impl;

import com.scrum.master.common.enums.IssueStatus;
import com.scrum.master.common.exceptions.BusinessException;
import com.scrum.master.data.entities.Issue;
import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.Sprint;
import com.scrum.master.data.repositories.IssueRepository;
import com.scrum.master.data.repositories.ProjectRepository;
import com.scrum.master.data.repositories.SprintRepository;
import com.scrum.master.service.IssueService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class IssueServiceImpl implements IssueService {

    private final IssueRepository issueRepository;
    private final SprintRepository sprintRepository;
    private final ProjectRepository projectRepository;

    @Override
    public List<Issue> findByProjectId(Long projectId) {
        return issueRepository.findByProjectId(projectId);
    }

    @Override
    public List<Issue> findBySprintId(Long sprintId) {
        return issueRepository.findBySprintId(sprintId);
    }

    @Override
    public List<Issue> findByUserId(Long userId) {
        return issueRepository.findByUserId(userId);
    }

    @Override
    public List<Issue> updateIndex(List<Issue> issues) {
        for (int i = 0; i < issues.size(); i++) {
            issues.get(i).setPriority(i);
        }
        return issueRepository.saveAll(issues);
    }

    @Override
    public List<Issue> assignToSprint(Long projectId, Set<Long> ids) {
        List<Issue> issues = issueRepository.findAllById(ids);
        Sprint sprint = sprintRepository.findById(projectId).orElse(null);
        for (Issue issue : issues) {
            issue.setSprint(sprint);
        }
        return issueRepository.saveAll(issues);
    }

    @Override
    public Issue create(Issue issue) {
        issue.setReporter(issue.getProject().getProjectLeader());
        int count = issueRepository.count(issue.getProject().getId());
        issue.setPriority(count);
        issue.setCode(issue.getProject().getKey() + "-" + (count + 1));
        return issueRepository.save(issue);
    }

    @Override
    public Issue updateStatus(Long issueId, IssueStatus status) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(() -> {
            throw BusinessException.builder()
                .message("Can't find issue")
                .status(HttpStatus.BAD_REQUEST)
                .build();
        });
        issue.setStatus(status);
        return issueRepository.save(issue);
    }

    @Override
    public Issue update(Issue issue) {
        Issue existedIssue = issueRepository.findById(issue.getId()).orElseThrow(() -> {
            throw BusinessException.builder()
                .message("Can't find issue")
                .status(HttpStatus.BAD_REQUEST)
                .build();
        });
        existedIssue.setAssignee(issue.getAssignee());
        existedIssue.setDescription(issue.getDescription());
        existedIssue.setLabel(issue.getLabel());
        if (issue.getSprintId() != null) {
            existedIssue.setSprint(sprintRepository.findById(issue.getSprintId()).orElse(null));
        }
        existedIssue.setEstimate(issue.getEstimate());
        existedIssue.setTitle(issue.getTitle());
        existedIssue.setType(issue.getType());
        return issueRepository.save(existedIssue);
    }

    @Override
    public void delete(Long issueId) {
        issueRepository.deleteById(issueId);
    }
}
