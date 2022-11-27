package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.ProjectMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProjectMemberRepository extends JpaRepository<ProjectMember, Long> {
    @Query(value = "SELECT member FROM ProjectMember member WHERE member.user.id = ?1")
    List<ProjectMember> findByUserId(Long userId);
}
