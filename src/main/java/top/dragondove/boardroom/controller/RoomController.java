package top.dragondove.boardroom.controller;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.entity.Room;
import top.dragondove.boardroom.service.RoomService;

import javax.annotation.Resource;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/room")
public class RoomController {

    @Resource
    private RoomService roomService;

    @GetMapping("/all")
    public Msg getAllRooms() {
        return Msg.success().addExtra("rooms", roomService.getAllRooms());
    }

    @GetMapping("/list")
    public Msg getAllRooms(@RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "10") int size) {
        return Msg.success().addExtra("rooms", roomService.getAllRooms(page, size));
    }

    @GetMapping("/available")
    public Msg getAvailableRooms(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime startTime,
                                 @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endTime) {
        return Msg.success().addExtra("rooms", roomService.getAvailableRooms(startTime, endTime));
    }

    @GetMapping("/meetings")
    public Msg getAllMeetings(@RequestParam Long id) {
        return Msg.success().addExtra("meetings", roomService.getAllMeetingsById(id));
    }

    @GetMapping("/most")
    public Msg getMostUsedRooms() {
        return Msg.success().addExtra("count", roomService.getMostUsedRooms());
    }

    @GetMapping
    public Msg getRoomById(@RequestParam Long id) {
        return Msg.success().addExtra("room", roomService.getRoomById(id));
    }

    @PostMapping
    public Msg addRoom(@RequestBody Room room) {
        roomService.saveRoom(room);
        return Msg.success();
    }

    @PutMapping
    public Msg updateRoom(@RequestBody Room room) {
        if (null == room.getId()) {
            return Msg.error("请输入房间id");
        }
        roomService.saveRoom(room);
        return Msg.success();
    }

    @DeleteMapping
    public Msg deleteRoom(@RequestParam Long id) {
        roomService.deleteRoomById(id);
        return Msg.success();
    }

}
