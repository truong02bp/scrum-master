package com.scrum.master.controller;

import com.scrum.master.data.entities.ActivityLog;
import com.scrum.master.service.ActivityLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
public class ActivityLogController {
    private final ActivityLogService activityLogService;

    @GetMapping("/activity-log")
    public ResponseEntity<List<ActivityLog>> findByUserId(@RequestParam("userId") Long userId, Pageable pageable) {
        return ResponseEntity.ok(activityLogService.getByUserId(userId, pageable));
    }
}
