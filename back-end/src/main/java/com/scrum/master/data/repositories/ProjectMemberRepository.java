package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.ProjectMember;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectMemberRepository extends JpaRepository<ProjectMember, Long> {

}
