package top.dragondove.boardroom.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;
import top.dragondove.boardroom.entity.Meeting;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.exception.CustomException;
import top.dragondove.boardroom.service.MeetingService;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/meeting")
public class MeetingController {

    @Resource
    private MeetingService meetingService;

    @GetMapping("/list")
    public Msg getAllMeetings(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size) {
        return Msg.success().addExtra("meetings", meetingService.getAllMeetings(page, size));
    }

    @GetMapping("/all")
    public Msg getAllMeetings() {
        return Msg.success().addExtra("meetings", meetingService.getAllMeetings());
    }

    @GetMapping("/today")
    public Msg getMeetingsToday() {
        return Msg.success().addExtra("meetings",
                meetingService.getMeetingsByDate(LocalDate.now()));
    }

    @GetMapping("/count")
    public Msg getMeetingCount(Meeting meeting) {
        return Msg.success().addExtra("count", meetingService.getMeetingCount(meeting));
    }

    @GetMapping("/count/week")
    public Msg getMeetingCountWeekly() {
        return Msg.success().addExtra("count", meetingService.getMeetingCountWeekly());
    }

    @GetMapping("/users")
    public Msg getMeetingUsers(@RequestParam Long id) {
        return Msg.success().addExtra("userMeetings", meetingService.getAllUsersById(id));
    }

    @GetMapping("/register")
    public Msg registerMeeting(@RequestParam Long roomId,
                               @RequestParam Long userId) {
        try {
            meetingService.registerMeeting(roomId, userId);
        } catch (CustomException ce) {
            return Msg.error(ce.getMsg());
        }
        return Msg.success("签到成功");
    }

    @GetMapping("/signOut")
    public Msg signOutMeeting(@RequestParam Long roomId,
                              @RequestParam Long userId) {
        try {
            meetingService.signOutMeeting(roomId, userId);
        } catch (CustomException ce) {
            return Msg.msg(ce.getCode(), ce.getMsg());
        }
        return Msg.success("签离成功");
    }

    @GetMapping
    public Msg getMeetingById(@RequestParam Long id) {
        return Msg.success().addExtra("meeting", meetingService.getMeetingById(id));
    }

    @GetMapping("/registerRate")
    public Msg getRegisterRate() {
        return Msg.success().addExtra("rate", meetingService.getRegisterRate());
    }

    @GetMapping("/approve")
    @RequiresPermissions("meeting:approve")
    public Msg approveMeeting(@RequestParam Long id) {
        try {
            meetingService.approveMeeting(id);
        } catch (CustomException ce) {
            return Msg.error(ce.getMsg());
        }
        return Msg.success();
    }

    @GetMapping("/disapprove")
    @RequiresPermissions("meeting:approve")
    public Msg disapproveMeeting(@RequestParam Long id) {
        try {
            meetingService.disapproveMeeting(id);
        } catch (CustomException ce) {
            return Msg.error(ce.getMsg());
        }
        return Msg.success();
    }

    @PostMapping
    public Msg addMeeting(@RequestBody Meeting meeting) {
        try {
            meetingService.saveMeeting(meeting);
        } catch (CustomException ce) {
            return Msg.error(ce.getMsg());
        }
        return Msg.success().addExtra("meeting", meeting);
    }

    @PutMapping("/users")
    public Msg saveMeetingMembers(@RequestParam Long id,
                                  @RequestBody List<User> users) {
        meetingService.saveMeetingMembers(id, users);
        return Msg.success();
    }

    @PutMapping
    public Msg updateMeeting(@RequestBody Meeting meeting) {
        if (null == meeting.getId()) {
            return Msg.error("请指定会议id");
        }
        try {
            meetingService.saveMeeting(meeting);
        } catch (CustomException ce) {
            return Msg.error(ce.getMsg());
        }
        return Msg.success();
    }

    @DeleteMapping
    public Msg deleteMeeting(@RequestParam Long id) {
        meetingService.deleteMeetingById(id);
        return Msg.success();
    }

}
