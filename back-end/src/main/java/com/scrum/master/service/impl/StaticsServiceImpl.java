package com.scrum.master.service.impl;

import com.scrum.master.common.enums.IssueType;
import com.scrum.master.data.dto.IssueStatics;
import com.scrum.master.data.dto.PerformanceStatics;
import com.scrum.master.data.dto.ProjectStatics;
import com.scrum.master.data.entities.Issue;
import com.scrum.master.service.IssueService;
import com.scrum.master.service.StaticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class StaticsServiceImpl implements StaticsService {
    private final IssueService issueService;

    @Override
    public IssueStatics exportIssueStatics(Long userId) {
        List<Issue> issues = issueService.findByUserId(userId);
        int taskTotal = issues.stream().filter(issue -> issue.getType().equals(IssueType.Task)).toList().size();
        int bugTotal = issues.stream().filter(issue -> issue.getType().equals(IssueType.Bug)).toList().size();
        int storyTotal = issues.stream().filter(issue -> issue.getType().equals(IssueType.Story)).toList().size();

        IssueStatics statics = new IssueStatics();
        statics.setBugTotal(bugTotal);
        statics.setTaskTotal(taskTotal);
        statics.setStoryTotal(storyTotal);
        return statics;
    }

    @Override
    public PerformanceStatics exportPerformanceStatics(Long userId) {
        return null;
    }

    @Override
    public ProjectStatics exportProjectStatics(Long userId) {
        return null;
    }

}
