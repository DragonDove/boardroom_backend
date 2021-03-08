package top.dragondove.boardroom.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String username;

    @Column
    private String realName;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Column(nullable = false)
    private String password;

    @JsonIgnore
    @Column
    private String salt;

    @Column
    private String phone;

    @Column
    @Email(message = "邮箱格式错误")
    private String email;

    @Column
    private String photoPath;

    @ManyToOne
    @JoinColumn(name = "departmentId")
    private Department department;

    @JsonIgnore
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<UserMeeting> userMeetings;

    @JsonIgnore
    @OneToMany(mappedBy = "leader", cascade = CascadeType.ALL)
    private List<Meeting> leadMeetings;

    @JsonIgnore
    @ManyToMany
    @JoinTable(name = "UserRole", joinColumns = {@JoinColumn(name = "userId")},
            inverseJoinColumns = {@JoinColumn(name = "roleId")})
    private List<Role> roles;

    @JsonIgnore
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<UserRemind> userReminds;

}
