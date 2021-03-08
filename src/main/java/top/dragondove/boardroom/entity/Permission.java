package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@Entity
public class Permission implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String permission;

    @Column
    private String name;

    @JsonIgnore
    @ManyToMany(mappedBy = "permissions")
    private List<Role> roles;

}
