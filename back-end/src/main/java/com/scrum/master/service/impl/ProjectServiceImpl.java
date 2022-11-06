package com.scrum.master.service.impl;

import com.scrum.master.common.enums.ProjectRole;
import com.scrum.master.common.exceptions.BusinessException;
import com.scrum.master.common.utils.SecurityUtils;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.entities.Organization;
import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.ProjectMember;
import com.scrum.master.data.entities.User;
import com.scrum.master.data.repositories.ProjectRepository;
import com.scrum.master.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;

    @Override
    public List<Project> getAll() {
        Organization organization = SecurityUtils.getCurrentOrganization();
        return projectRepository.findByOrganization(organization.getId()).stream().peek(project -> {
            List<ProjectMember> members = project.getMembers();
            for (ProjectMember member : members) {
                if (member.getRole().equals(ProjectRole.LEADER)) {
                    project.setProjectLeader(member.getUser());
                }
                if (member.getRole().equals(ProjectRole.OWNER)) {
                    project.setOwner(member.getUser());
                }
            }
        }).collect(Collectors.toList());
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
        List<ProjectMember> members = new ArrayList<>();

        members.add(ProjectMember.builder()
            .user(project.getProjectLeader())
            .role(ProjectRole.LEADER)
            .build());

        members.add(ProjectMember.builder()
            .user(user)
            .role(ProjectRole.OWNER)
            .build());

        project.setMembers(members);
        project.setOrganization(user.getOrganization());
        return projectRepository.save(project);
    }
}
