package com.scrum.master.data.repositories;

import com.scrum.master.common.enums.IssueStatus;
import com.scrum.master.data.entities.Issue;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface IssueRepository extends JpaRepository<Issue, Long> {

    @Query(value = "SELECT issue FROM Issue issue WHERE issue.project.id = ?1 AND issue.sprint is NULL ORDER BY issue.priority ASC")
    List<Issue> findByProjectId(Long projectId);

    @Query(value = "SELECT issue FROM Issue issue WHERE  issue.sprint.id = ?1 ORDER BY issue.priority ASC")
    List<Issue> findBySprintId(Long sprintId);

    @Query(value = "SELECT count(issue.id) FROM Issue issue WHERE issue.project.id = ?1")
    int count(Long projectId);

    @Query(value = "SELECT issue FROM Issue issue WHERE issue.assignee.id = ?1 AND ( issue.status <> 'Done' or (issue.sprint.status <> 'Completed' AND issue.status = 'Done')) ORDER BY issue.priority ASC")
    List<Issue> findByUserId(Long userId);

    @Query(value = "SELECT issue FROM Issue issue WHERE issue.assignee.id = ?1 ORDER BY issue.priority ASC")
    List<Issue> findAllByUserId(Long userId);

    @Query(value = "SELECT count(issue.id) FROM Issue issue WHERE issue.assignee.id = ?1 AND issue.project.id = ?2")
    int countByUserIdAndProjectId(Long userId, Long projectId);

    @Query(value = "SELECT issue FROM Issue issue WHERE issue.assignee.id = ?1 AND issue.status <> ?2 ORDER BY issue.priority ASC")
    List<Issue> findByUserIdAndExcludeStatus(Long userId, IssueStatus status);
}
