package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.ProjectMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProjectMemberRepository extends JpaRepository<ProjectMember, Long> {
    @Query(value = "SELECT projectMember FROM ProjectMember projectMember WHERE projectMember.user.id = ?1")
    List<ProjectMember> findByUserId(Long userId);
}
