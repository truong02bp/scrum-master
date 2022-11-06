package com.scrum.master.data.entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "projects")
@Getter
@Setter
public class Project extends BaseEntity {

    private String name;
    private String key;

    @ManyToOne
    private Organization organization;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "project_id")
    private List<ProjectMember> members;

    @Transient
    private User owner;

    @Transient
    private User projectLeader;

}
