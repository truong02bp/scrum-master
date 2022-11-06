package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProjectRepository extends JpaRepository<Project, Long> {

    @Query(value = "SELECT project FROM Project project WHERE project.organization.id = ?1")
    List<Project> findByOrganization(Long organizationId);
}
