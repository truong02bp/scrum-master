package com.scrum.master.controller;

import com.scrum.master.data.entities.Issue;
import com.scrum.master.service.IssueService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class IssueController {

    private final IssueService issueService;

    @GetMapping("/issue")
    public ResponseEntity<List<Issue>> getByProjectId(@RequestParam("projectId") Long projectId) {
        return ResponseEntity.ok(issueService.findByProjectId(projectId));
    }

    @PostMapping("/issue")
    public ResponseEntity<Issue> create(@RequestBody Issue issue) {
        return ResponseEntity.ok(issueService.create(issue));
    }

    @PutMapping("/issue")
    public ResponseEntity<Issue> update(@RequestBody Issue issue) {
        return ResponseEntity.ok(issueService.update(issue));
    }

    @DeleteMapping("/issue")
    public ResponseEntity<String> delete(@RequestParam("issueId") Long issueId) {
        issueService.delete(issueId);
        return ResponseEntity.ok("ok");
    }

}
