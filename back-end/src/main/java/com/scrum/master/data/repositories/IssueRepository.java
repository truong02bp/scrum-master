package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.Issue;
import org.springframework.data.jpa.repository.JpaRepository;


public interface IssueRepository extends JpaRepository<Issue, Long> {
}
