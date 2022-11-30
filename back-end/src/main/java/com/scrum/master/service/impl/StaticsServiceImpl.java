package com.scrum.master.service.impl;

import com.scrum.master.common.enums.IssueStatus;
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

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class StaticsServiceImpl implements StaticsService {
    private final IssueService issueService;

    @Override
    public IssueStatics exportIssueStatics(Long userId) {
        List<Issue> issues = issueService.findByUserId(userId, null);
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
        List<Issue> issues = issueService.findByUserId(userId, null);
        int earlyIssueTotal = 0;
        int lateIssueTotal = 0;
        int notCompletedIssueTotal = 0;
        for (Issue issue : issues) {
            if (issue.getStartDate() == null) {
                continue;
            }
            LocalDateTime startDate = issue.getStartDate();
            LocalDateTime endDate = issue.getEndDate();
            LocalDateTime estimateDate = startDate.plusDays(issue.getEstimate());
            if (!issue.getStatus().equals(IssueStatus.Done) && LocalDateTime.now().isAfter(estimateDate)) {
                notCompletedIssueTotal++;
                continue;
            }
            if (issue.getStatus().equals(IssueStatus.Done) && endDate != null) {
                if (endDate.isBefore(estimateDate)) {
                    earlyIssueTotal++;
                } else {
                    lateIssueTotal++;
                }
            }

        }
        PerformanceStatics statics = new PerformanceStatics();
        statics.setEarlyIssueTotal(earlyIssueTotal);
        statics.setNotCompletedIssueTotal(notCompletedIssueTotal);
        statics.setLateIssueTotal(lateIssueTotal);
        return statics;
    }

    @Override
    public ProjectStatics exportProjectStatics(Long userId) {
        return null;
    }

}
