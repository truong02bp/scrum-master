package com.scrum.master.data.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.scrum.master.common.enums.ProjectRole;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "project_member")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProjectMember extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "project_id")
    @JsonIgnore
    private Project project;

    private ProjectRole role;
}
