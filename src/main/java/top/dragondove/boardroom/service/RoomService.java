package top.dragondove.boardroom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.CountEntity;
import top.dragondove.boardroom.entity.Meeting;
import top.dragondove.boardroom.entity.Room;
import top.dragondove.boardroom.repository.MeetingRepository;
import top.dragondove.boardroom.repository.RoomRepository;
import top.dragondove.boardroom.util.UpdateUtils;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RoomService {

    private final RoomRepository roomRepository;
    private final MeetingRepository meetingRepository;

    @Autowired
    public RoomService(RoomRepository roomRepository,
                       MeetingRepository meetingRepository) {
        this.roomRepository = roomRepository;
        this.meetingRepository = meetingRepository;
    }

    public Room getRoomById(Long id) {
        return roomRepository.findById(id).orElse(null);
    }

    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    public Page<Room> getAllRooms(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return roomRepository.findAll(pageable);
    }

    public void saveRoom(Room room) {
        if (null != room.getId()) {
            Room origin = getRoomById(room.getId());
            if (null != origin) {
                UpdateUtils.copyNullProperties(origin, room);
            }
        }
        roomRepository.save(room);
    }

    public List<Meeting> getAllMeetingsById(Long id) {
        return roomRepository.findById(id).map(Room::getMeetings).orElse(Collections.emptyList());
    }

    public List<Room> getAvailableRooms(LocalDateTime start, LocalDateTime end) {
        List<Meeting> invalid = meetingRepository.findByStartTimeToEndTime(start, end);
        List<Room> rooms = roomRepository.findAll();
        rooms.removeAll(invalid.stream().map(Meeting::getRoom).collect(Collectors.toList()));
        rooms.removeIf(room -> !room.getAvailable());
        return rooms;
    }

    public List<CountEntity> getMostUsedRooms() {
        return roomRepository.countMostUsedRooms();
    }

    public void deleteRoomById(Long id) {
        roomRepository.deleteById(id);
    }
}
