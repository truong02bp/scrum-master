package com.scrum.master.controller;

import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.Sprint;
import com.scrum.master.data.repositories.SprintRepository;
import com.scrum.master.service.SprintService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class SprintController {

    private final SprintService sprintService;

    @GetMapping("/sprints")
    public ResponseEntity<List<Sprint>> findByProject(@RequestParam("projectId") Long projectId) {
        return ResponseEntity.ok(sprintService.findByProjectId(projectId));
    }

    @GetMapping("/sprint")
    public ResponseEntity<Sprint> findSprintActiveByProject(@RequestParam("projectId") Long projectId) {
        return ResponseEntity.ok(sprintService.findSprintActiveByProjectId(projectId));
    }

    @PostMapping("/sprint")
    public ResponseEntity<Sprint> create(@RequestBody Sprint sprint) {
        return ResponseEntity.ok(sprintService.create(sprint));
    }

    @PutMapping("/sprint/active")
    public ResponseEntity<Sprint> active(@RequestParam("sprintId") Long sprintId) {
        return ResponseEntity.ok(sprintService.active(sprintId));
    }

    @DeleteMapping("/sprint")
    public ResponseEntity<String> delete(@RequestParam("sprintId") Long sprintId) {
        sprintService.delete(sprintId);
        return ResponseEntity.ok("ok");
    }
}
