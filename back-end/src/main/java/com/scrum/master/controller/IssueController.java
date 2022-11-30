package com.scrum.master.controller;

import com.scrum.master.common.enums.IssueStatus;
import com.scrum.master.data.entities.Issue;
import com.scrum.master.service.IssueService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class IssueController {

    private final IssueService issueService;

    @GetMapping("/issue")
    public ResponseEntity<List<Issue>> getByProjectId(@RequestParam("projectId") Long projectId) {
        return ResponseEntity.ok(issueService.findByProjectId(projectId));
    }

    @GetMapping("/issue/sprint")
    public ResponseEntity<List<Issue>> getBySprintId(@RequestParam("sprintId") Long sprintId) {
        return ResponseEntity.ok(issueService.findBySprintId(sprintId));
    }

    @GetMapping("/issue/user")
    public ResponseEntity<List<Issue>> getByUserId(@RequestParam("userId") Long userId,
                                                   @RequestParam(value = "isDone", required = false) Boolean isDone) {
        return ResponseEntity.ok(issueService.findByUserId(userId, isDone));
    }

    @PostMapping("/issue")
    public ResponseEntity<Issue> create(@RequestBody Issue issue) {
        return ResponseEntity.ok(issueService.create(issue));
    }

    @PutMapping("/issue")
    public ResponseEntity<Issue> update(@RequestBody Issue issue) {
        return ResponseEntity.ok(issueService.update(issue));
    }

    @PutMapping("/issue/index")
    public ResponseEntity<List<Issue>> updateIndex(@RequestBody List<Issue> issues) {
        return ResponseEntity.ok(issueService.updateIndex(issues));
    }

    @PutMapping("/issue/assign")
    public ResponseEntity<List<Issue>> assignIssueToSprint(@RequestParam("ids") Set<Long> ids,
                                                           @RequestParam("sprintId") Long sprintId) {
        return ResponseEntity.ok(issueService.assignToSprint(sprintId, ids));
    }

    @PutMapping("/issue/status")
    public ResponseEntity<Issue> updateStatus(@RequestParam("status") IssueStatus status,
                                              @RequestParam("issueId") Long issueId) {
        return ResponseEntity.ok(issueService.updateStatus(issueId, status));
    }


    @DeleteMapping("/issue")
    public ResponseEntity<String> delete(@RequestParam("issueId") Long issueId) {
        issueService.delete(issueId);
        return ResponseEntity.ok("ok");
    }

}
