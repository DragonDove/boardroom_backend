package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.Remind;

import javax.transaction.Transactional;
import java.util.List;

public interface RemindRepository extends JpaRepository<Remind, Long> {

    @Query(value = "select * from remind, user_remind where user_id = ?1 and id = user_remind.remind_id",
            nativeQuery = true)
    List<Remind> findByUserId(Long id);

    @Query(value = "select * from remind, user_remind where user_id = ?1 and checked = 0 and id = remind_id",
            nativeQuery = true)
    List<Remind> findUnreadByUserId(Long id);

    @Modifying
    @Transactional
    @Query(value = "update user_remind set checked = 1 where user_id = ?1 and checked = 0", nativeQuery = true)
    void setAsReadByUserId(Long id);

    @Modifying
    @Transactional
    @Query(value = "insert into user_remind values (?1, ?2, 0)", nativeQuery = true)
    void addUserRemind(Long userId, Long remindId);

    List<Remind> findByMeetingId(Long id);
}
