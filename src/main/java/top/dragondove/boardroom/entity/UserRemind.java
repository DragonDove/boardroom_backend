package top.dragondove.boardroom.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@NoArgsConstructor
public class UserRemind implements Serializable {

    @Id
    @ManyToOne
    @JoinColumn
    private User user;

    @Id
    @ManyToOne
    @JoinColumn
    private Remind remind;

    @Column(columnDefinition = "bit default 0")
    private Boolean checked;

    public UserRemind(User user, Remind remind) {
        this.user = user;
        this.remind = remind;
    }


}
