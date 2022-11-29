package com.scrum.master.controller;

import com.scrum.master.service.StaticsService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class StaticsController {
    private final StaticsService staticsService;

    @GetMapping("/statics/issue")
    public ResponseEntity<Object> exportIssueStatics(@RequestParam("userId") Long userId) {
        return ResponseEntity.ok(staticsService.exportIssueStatics(userId));
    }

    @GetMapping("/statics/project")
    public ResponseEntity<Object> exportProjectStatics(@RequestParam("userId") Long userId) {
        return ResponseEntity.ok(staticsService.exportProjectStatics(userId));
    }

    @GetMapping("/statics/performance")
    public ResponseEntity<Object> exportPerformanceStatics(@RequestParam("userId") Long userId) {
        return ResponseEntity.ok(staticsService.exportPerformanceStatics(userId));
    }
}
