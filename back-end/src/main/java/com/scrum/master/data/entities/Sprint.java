package com.scrum.master.data.entities;

import com.scrum.master.common.enums.SprintStatus;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "sprints")
@Getter
@Setter
public class Sprint extends BaseEntity {

    private String name;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private SprintStatus status;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;
}
