package com.scrum.master.data.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PerformanceStatics {
    private int earlyIssueTotal;
    private int lateIssueTotal;
    private int notCompletedIssueTotal;
}
