package com.scrum.master.service.impl;

import com.scrum.master.common.exceptions.BusinessException;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.User;
import com.scrum.master.data.repositories.ProjectRepository;
import com.scrum.master.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;

    @Override
    public List<Project> getAll(Long organizationId) {
        return projectRepository.findByOrganization(organizationId);
    }

    @Override
    public Project create(Project project) {
        if (StringUtils.isBlank(project.getName())) {
            throw BusinessException.builder()
                .message("Name must not empty")
                .status(HttpStatus.BAD_REQUEST)
                .build();
        }
        User user = ((MyUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser();
        project.setUsers(List.of(user));
        project.setOrganization(user.getOrganization());
        return projectRepository.save(project);
    }
}
