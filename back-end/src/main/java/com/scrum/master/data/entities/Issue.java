package com.scrum.master.data.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.scrum.master.common.enums.IssueStatus;
import com.scrum.master.common.enums.IssueType;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "issues")
@Getter
@Setter
public class Issue extends BaseEntity {

    private int priority;
    private String code;
    private String title;
    private String description;
    private String label;
    @Enumerated(EnumType.STRING)
    private IssueType type;
    private Integer estimate;
    @Enumerated(EnumType.STRING)
    private IssueStatus status = IssueStatus.Todo;


    @OneToMany
    @JoinColumn(name = "issue_id")
    private List<Issue> subTasks;

    @ManyToOne
    @JoinColumn(name = "reporter")
    private User reporter;

    @ManyToOne
    @JoinColumn(name = "assignee")
    private User assignee;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "sprint_id")
    @JsonIgnore
    private Sprint sprint;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "project_id")
    private Project project;

    @Transient
    private Long sprintId;

}
