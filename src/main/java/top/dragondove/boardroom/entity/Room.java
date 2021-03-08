package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@Entity
public class Room implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String name;

    @Column
    private String location;

    @Column
    private Integer capacity;

    @Column
    private Boolean available;

    @Column
    private Boolean microphoneAvailable;

    @Column
    private Boolean projectorAvailable;

    @JsonIgnore
    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL)
    private List<Meeting> meetings;

}
