package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
public class Remind implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String content;

    @Column(columnDefinition = "datetime not null")
    private LocalDateTime time = LocalDateTime.now();

    @ManyToOne
    private Meeting meeting;

    @JsonIgnore
    @OneToMany(mappedBy = "remind", cascade = CascadeType.ALL)
    private List<UserRemind> userReminds;

}
