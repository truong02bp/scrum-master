package com.scrum.master.service.impl;

import com.scrum.master.data.entities.ActivityLog;
import com.scrum.master.data.entities.ProjectMember;
import com.scrum.master.data.repositories.ActivityLogRepository;
import com.scrum.master.data.repositories.ProjectMemberRepository;
import com.scrum.master.service.ActivityLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ActivityLogServiceImpl implements ActivityLogService {

    private final ActivityLogRepository activityLogRepository;
    private final ProjectMemberRepository projectMemberRepository;

    @Override
    public List<ActivityLog> getByUserId(Long userId, Pageable pageable) {
        List<ProjectMember> members = projectMemberRepository.findByUserId(userId);
        List<Long> projectIds = members.stream().map(projectMember -> projectMember.getProject().getId()).toList();

        return activityLogRepository.findByProjectIds(projectIds, pageable);
    }

    @Override
    public ActivityLog create(ActivityLog activityLog) {
        return activityLogRepository.save(activityLog);
    }
}
