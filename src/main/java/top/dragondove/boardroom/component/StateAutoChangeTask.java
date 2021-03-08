package top.dragondove.boardroom.component;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import top.dragondove.boardroom.entity.Meeting;
import top.dragondove.boardroom.entity.Remind;
import top.dragondove.boardroom.service.MeetingService;
import top.dragondove.boardroom.service.RemindService;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@Component
public class StateAutoChangeTask {

    @Resource
    private MeetingService meetingService;

    @Resource
    private RemindService remindService;

    private boolean notRemind(Meeting meeting, String message) {
        List<Remind> reminds = remindService.getRemindsByMeetingId(meeting.getId());
        for (Remind remind : reminds) {
            if (remind.getContent().equals(message)) {
                return false;
            }
        }
        return true;
    }

    @Scheduled(fixedRate = 60000)
    public void meetingAutoUpdate() {
        meetingService.setOutOfDate();
        List<Meeting> meetings = meetingService.getCurrentMeetings();
        LocalDateTime now = LocalDateTime.now();
        for (Meeting meeting : meetings) {
            if (meeting.getStartTime().isBefore(now)) {
                if (meeting.getState().equals(0)) {
                    meeting.setState(5);
                } else if (meeting.getState().equals(1)) {
                    meeting.setState(2);
                }
            } else {
                if (meeting.getState().equals(1)) {
                    String remindMessage = "您有一场在" + meeting.getRoom().getLocation() + "-" +
                            meeting.getRoom().getName() + "的会议——" + meeting.getName() + "即将开始";
                    if (notRemind(meeting, remindMessage)) {
                        Remind remind = new Remind();
                        remind.setMeeting(meeting);
                        remind.setContent(remindMessage);
                        remindService.saveRemind(remind);
                        meeting.getUserMeetings().forEach(userMeeting ->
                                remindService.addUserRemind(userMeeting.getUser(), remind));
                    }
                }
            }
            if (meeting.getEndTime().isBefore(now)) {
                if (meeting.getEndTime().isBefore(now.minusHours(1))) {
                    meeting.setState(3);
                } else {
                    String remindMessage = "这个会议已经超时，请签离";
                    if (notRemind(meeting, remindMessage)) {
                        System.err.println("new a remind");
                        Remind remind = new Remind();
                        remind.setContent(remindMessage);
                        remind.setMeeting(meeting);
                        remindService.saveRemind(remind);
                        remindService.addUserRemind(meeting.getLeader(), remind);
                    }
                }
            }
            meetingService.changeStateByMeetingId(meeting.getId(), meeting.getState());
        }
    }

}
