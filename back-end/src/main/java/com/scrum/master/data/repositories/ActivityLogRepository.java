package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.ActivityLog;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ActivityLogRepository extends JpaRepository<ActivityLog, Long> {

    @Query(value = "SELECT log FROM ActivityLog log WHERE log.project.id in ?1 ORDER BY log.createdDate DESC ")
    List<ActivityLog> findByProjectIds(List<Long> projectIds, Pageable pageable);
}
