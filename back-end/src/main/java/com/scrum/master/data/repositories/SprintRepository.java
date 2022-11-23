package com.scrum.master.data.repositories;

import com.scrum.master.common.enums.SprintStatus;
import com.scrum.master.data.entities.Sprint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface SprintRepository extends JpaRepository<Sprint, Long> {

    @Query(value = "SELECT sprint FROM Sprint sprint WHERE sprint.project.id = ?1")
    List<Sprint> findByProjectId(Long projectId);

    @Query(value = "SELECT sprint FROM Sprint sprint WHERE sprint.project.id = ?1 AND sprint.status = ?2")
    Optional<Sprint> findByProjectIdAndStatus(Long projectId, SprintStatus status);
}
