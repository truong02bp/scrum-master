package com.scrum.master.service;

import com.scrum.master.data.entities.ActivityLog;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ActivityLogService {

    List<ActivityLog> getByUserId(Long userId, Pageable pageable);
    ActivityLog create(ActivityLog activityLog);
    void deleteByIssueId(Long issueId);
}
