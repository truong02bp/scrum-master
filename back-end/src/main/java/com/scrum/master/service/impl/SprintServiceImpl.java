package com.scrum.master.service.impl;

import com.scrum.master.common.enums.SprintStatus;
import com.scrum.master.common.exceptions.BusinessException;
import com.scrum.master.data.entities.Sprint;
import com.scrum.master.data.repositories.SprintRepository;
import com.scrum.master.service.SprintService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class SprintServiceImpl implements SprintService {

    private final SprintRepository sprintRepository;

    @Override
    public List<Sprint> findByProjectId(Long projectId) {
        return sprintRepository.findByProjectId(projectId).stream()
            .filter(sprint -> sprint.getStatus() != SprintStatus.COMPLETED).collect(Collectors.toList());
    }

    @Override
    public Sprint findSprintActiveByProjectId(Long projectId) {
        return sprintRepository.findByProjectIdAndStatus(projectId, SprintStatus.ACTIVE).orElse(null);
    }

    @Override
    public Sprint create(Sprint sprint) {
        return sprintRepository.save(sprint);
    }

    @Override
    public Sprint active(Long sprintId) {

        Sprint sprint = sprintRepository.findById(sprintId).orElseThrow(() -> {
            throw BusinessException.builder().message("Sprint not available").status(HttpStatus.BAD_REQUEST).build();
        });

        Sprint activeSprint = sprintRepository.findByProjectIdAndStatus(sprint.getProject().getId(), SprintStatus.ACTIVE).orElse(null);
        if (activeSprint != null) {
            throw BusinessException.builder().message("Project have 1 sprint active only").status(HttpStatus.BAD_REQUEST).build();
        }
        sprint.setStatus(SprintStatus.ACTIVE);
        return sprintRepository.save(sprint);
    }

    @Override
    public Sprint complete(Long sprintId) {
        Sprint sprint = sprintRepository.findById(sprintId).orElseThrow(() -> {
            throw BusinessException.builder().message("Sprint not available").status(HttpStatus.BAD_REQUEST).build();
        });
        sprint.setStatus(SprintStatus.COMPLETED);
        return sprintRepository.save(sprint);
    }

    @Override
    public void delete(Long sprintId) {
        sprintRepository.deleteById(sprintId);
    }
}
