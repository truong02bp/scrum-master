package com.scrum.master.data.entities;

import com.scrum.master.common.enums.SprintStatus;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "sprints")
@Getter
@Setter
public class Sprint extends BaseEntity {

    private String name;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    @Enumerated(EnumType.STRING)
    private SprintStatus status;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

}
