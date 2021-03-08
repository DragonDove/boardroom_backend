package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.CountEntity;
import top.dragondove.boardroom.entity.Room;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long> {

    @Query(value = "select room.name as name, count(*) as value from meeting," +
            "room where room.id = room_id group by room_id asc limit 10",
            nativeQuery = true)
    List<CountEntity> countMostUsedRooms();

}
