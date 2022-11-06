package com.scrum.master.data.entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "issues")
@Getter
@Setter
public class Issue extends BaseEntity {

    private String code;
    private String title;
    @ManyToOne
    @JoinColumn(name = "sprint_id")
    private Sprint sprint;

}
