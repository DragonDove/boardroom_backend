package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;


@Data
@Entity
@NoArgsConstructor
public class UserMeeting implements Serializable {

    @Id
    @ManyToOne
    @JoinColumn
    private User user;

    @Id
    @ManyToOne
    @JoinColumn
    @JsonIgnore
    private Meeting meeting;

    @Column(columnDefinition = "bit default 0")
    private Boolean registered;

    public UserMeeting(User user, Meeting meeting) {
        this.user = user;
        this.meeting = meeting;
    }

}
