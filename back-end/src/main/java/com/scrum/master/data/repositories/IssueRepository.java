package com.scrum.master.data.repositories;

import com.scrum.master.data.entities.Issue;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface IssueRepository extends JpaRepository<Issue, Long> {

    @Query(value = "SELECT issue FROM Issue issue WHERE issue.project.id = ?1")
    List<Issue> findByProjectId(Long projectId);

    @Query(value = "SELECT count(issue.id) FROM Issue issue WHERE issue.project.id = ?1")
    int count(Long projectId);
}
