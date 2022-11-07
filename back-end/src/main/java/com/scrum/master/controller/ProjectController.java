package com.scrum.master.controller;

import com.scrum.master.data.entities.Project;
import com.scrum.master.data.entities.ProjectMember;
import com.scrum.master.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/projects")
    public ResponseEntity<List<Project>> findByOrganization() {
        return ResponseEntity.ok(projectService.getAll());
    }

    @PostMapping("/project")
    public ResponseEntity<Project> create(@RequestBody Project project) {
        return ResponseEntity.ok(projectService.create(project));
    }

    @PutMapping("/project/{id}/member")
    public ResponseEntity<ProjectMember> addMember(@PathVariable Long id,
                                                   @RequestBody ProjectMember projectMember) {
        return ResponseEntity.ok(projectService.addMember(id, projectMember));
    }

    @DeleteMapping("/project/{id}/member")
    public ResponseEntity<ProjectMember> deleteMember(@PathVariable Long id,
                                                   @RequestBody ProjectMember projectMember) {
        return ResponseEntity.ok(projectService.removeMember(id, projectMember));
    }
}
