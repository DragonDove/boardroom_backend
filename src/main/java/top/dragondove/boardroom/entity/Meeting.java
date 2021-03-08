package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
@EqualsAndHashCode(exclude = "userMeetings")
public class Meeting implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String name;

    @ManyToOne
    @JoinColumn(name = "leaderId")
    private User leader;

    @ManyToOne
    @JoinColumn(name = "roomId")
    private Room room;

    @Column
    private Integer routineId;

    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;

    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;

    @Column(columnDefinition = "int not null default 0")
    private Integer state;

    @Column
    private String description;

    @JsonIgnore
    @OneToMany(mappedBy = "meeting", cascade = CascadeType.ALL)
    private List<UserMeeting> userMeetings;

    @JsonIgnore
    @OneToMany(mappedBy = "meeting", cascade = CascadeType.ALL)
    private List<Remind> reminds;

}
