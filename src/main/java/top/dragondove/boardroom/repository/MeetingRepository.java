package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.CountEntity;
import top.dragondove.boardroom.entity.Meeting;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

public interface MeetingRepository extends JpaRepository<Meeting, Long> {

    @Query(value = "from Meeting meeting where meeting.startTime < ?1 and meeting.endTime > ?1 or " +
            "meeting.startTime >= ?1 and meeting.endTime <= ?2 or meeting.startTime < ?2 and meeting.endTime > ?2")
    List<Meeting> findByStartTimeToEndTime(LocalDateTime start, LocalDateTime end);

    @Query(value = "from Meeting meeting where meeting.room.id = ?1 and meeting.state <> 4 and " +
            "(meeting.startTime < ?2 and meeting.endTime > ?2 or meeting.startTime >= ?2 and " +
            "meeting.endTime <= ?3 or meeting.startTime < ?3 and meeting.endTime > ?3)")
    List<Meeting> findByRoomIdAndStartTimeToEndTime(Long roomId, LocalDateTime start, LocalDateTime end);

    @Query(value = "select dayofweek(start_time) as name, sum(case registered when 1 then 1 else 0 end) " +
            "* 100.0 / count(*) as value from user_meeting, meeting where meeting_id = id and week(start_time) " +
            "= week(current_date() - 7) group by dayofweek(start_time)", nativeQuery = true)
    List<CountEntity> countRegister();

    @Query(value = "select dayofweek(start_time) as name, count(*) as value from meeting where week(start_time) " +
            "= (week(current_date()) - 1) group by dayofweek(start_time);", nativeQuery = true)
    List<CountEntity> countWeekly();

    @Query(value = "select * from meeting, user_meeting where user_id = ?2 and id = " +
            "meeting_id and room_id = ?1 and start_time " +
            "< date_add(now(), interval 10 minute) and start_time > date_sub(now(), " +
            "interval 10 minute)", nativeQuery = true)
    List<Meeting> findByRoomIdAndUserId(Long roomId, Long userId);

    @Query(value = "select * from meeting where leader_id = ?2 and room_id = ?1 and " +
            "state = 2 and end_time > date_sub(now(), interval 10 minute)", nativeQuery = true)
    List<Meeting> findByRoomIdAndLeaderId(Long roomId, Long leaderId);

    @Query(value = "select * from meeting where state <> 3 and state <> 4 and state <> 5 and ("
            + "start_time < date_add(now(), interval 10 minute) or end_time < date_sub(now(), interval 10 minute))",
            nativeQuery = true)
    List<Meeting> findCurrentMeetings();

    @Modifying
    @Transactional
    @Query(value = "update meeting set state = ?2 where id = ?1", nativeQuery = true)
    void changeState(Long id, Integer state);

    @Modifying
    @Transactional
    @Query(value = "delete from user_meeting where meeting_id = ?1", nativeQuery = true)
    void deleteMeetingMembers(Long meetingId);

    @Modifying
    @Transactional
    @Query(value = "insert into user_meeting value (0, ?2, ?1)", nativeQuery = true)
    void addMeetingMember(Long meetingId, Long userId);

    @Modifying
    @Transactional
    @Query(value = "update meeting set state = case when state = 0 then 5 else 3 end where " +
            "end_time < date_sub(now(), interval 1 hour) and (state = 0 or state = 1 or state = 2)", nativeQuery = true)
    void setOutOfDate();

    @Query(value = "select * from meeting where state = 1 or state =2", nativeQuery = true)
    List<Meeting> findAllChecked();

    @Query(value = "select * from meeting order by id desc limit ?1", nativeQuery = true)
    List<Meeting> findRecent(int no);
}
