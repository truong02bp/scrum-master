package com.scrum.master.service;

import com.scrum.master.data.dto.IssueStatics;
import com.scrum.master.data.dto.PerformanceStatics;
import com.scrum.master.data.dto.ProjectMemberStatics;
import com.scrum.master.data.dto.ProjectStatics;

public interface StaticsService {
    IssueStatics exportIssueStatics(Long userId);
    PerformanceStatics exportPerformanceStatics(Long userId);
    ProjectStatics exportProjectStatics(Long userId);

    ProjectMemberStatics exportProjectMemberStatics(Long projectId);

}
