package top.dragondove.boardroom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.*;
import top.dragondove.boardroom.exception.CustomException;
import top.dragondove.boardroom.repository.MeetingRepository;
import top.dragondove.boardroom.util.UpdateUtils;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class MeetingService {

    private final MeetingRepository meetingRepository;

    @Resource
    private RemindService remindService;

    @Autowired
    public MeetingService(MeetingRepository meetingRepository) {
        this.meetingRepository = meetingRepository;
    }

    public Meeting getMeetingById(Long id) {
        return meetingRepository.findById(id).orElse(null);
    }

    public Page<Meeting> getAllMeetings(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return meetingRepository.findAll(pageable);
    }

    public List<Meeting> getAllMeetings() {
        return meetingRepository.findRecent(500);
    }

    public void saveMeeting(Meeting meeting) {
        if (null != meeting.getId()) {
            Meeting origin = getMeetingById(meeting.getId());
            if (null != origin) {
                UpdateUtils.copyNullProperties(origin, meeting);
            }
        }
        List<Meeting> conflicts = meetingRepository.findByRoomIdAndStartTimeToEndTime(meeting.getRoom().getId(),
                meeting.getStartTime(), meeting.getEndTime());
        for (Meeting conflict : conflicts) {
            if (!conflict.getId().equals(meeting.getId())) {
                throw new CustomException(101, "与其他会议时间冲突");
            }
        }
        meetingRepository.save(meeting);
    }

    public void changeStateByMeetingId(Long id, Integer state) {
        meetingRepository.changeState(id, state);
    }

    public List<UserMeeting> getAllUsersById(Long id) {
        return getMeetingById(id).getUserMeetings();
    }

    public void deleteMeetingById(Long id) {
        meetingRepository.deleteById(id);
    }

    public void saveMeetingMembers(Long id, List<User> users) {
        meetingRepository.deleteMeetingMembers(id);
        List<Remind> reminds = getMeetingById(id).getReminds();
        users.forEach(user -> meetingRepository.addMeetingMember(id, user.getId()));
        reminds.forEach(remind -> users.forEach(user -> remindService.addUserRemind(user, remind)));
    }

    public List<Meeting> getMeetingsByDate(LocalDate date) {
        return meetingRepository.findByStartTimeToEndTime(date.atStartOfDay(),
                date.plusDays(1).atStartOfDay());
    }

    public Long getMeetingCount(Meeting meeting) {
        Example<Meeting> example = Example.of(meeting);
        return meetingRepository.count(example);
    }

    public List<CountEntity> getRegisterRate() {
        return meetingRepository.countRegister();
    }

    public List<CountEntity> getMeetingCountWeekly() {
        return meetingRepository.countWeekly();
    }

    public void registerMeeting(Long roomId, Long userId) {
        List<Meeting> meetings = meetingRepository.findByRoomIdAndUserId(roomId, userId);
        if (0 == meetings.size()) {
            throw new CustomException(103, "您不属于此次会议");
        }
        Meeting meeting = meetings.get(0);
        List<UserMeeting> userMeetings = meeting.getUserMeetings();
        for (UserMeeting userMeeting : userMeetings) {
            if (userId.equals(userMeeting.getUser().getId())) {
                if (userMeeting.getRegistered()) {
                    throw new CustomException(102, "用户已签到");
                } else {
                    userMeeting.setRegistered(true);
                    meetingRepository.save(meeting);
                    break;
                }
            }
        }
    }

    public List<Meeting> getCurrentMeetings() {
        return meetingRepository.findCurrentMeetings();
    }

    public void signOutMeeting(Long roomId, Long leaderId) {
        List<Meeting> meetings = meetingRepository.findByRoomIdAndLeaderId(roomId, leaderId);
        if (0 == meetings.size()) {
            throw new CustomException(104, "您不是此次会议的发起人");
        }
        meetings.forEach(meeting -> {
            if (3 == meeting.getState()) {
                throw new CustomException(105, "此次会议已经结束");
            } else {
                meeting.setState(3);
                meeting.setEndTime(LocalDateTime.now());
                meetingRepository.save(meeting);
            }
        });
    }

    public void setOutOfDate() {
        meetingRepository.setOutOfDate();
    }

    public List<Meeting> getMeetingsUnchecked() {
        Meeting example = new Meeting();
        example.setState(0);
        return meetingRepository.findAll(Example.of(example));
    }

    public List<Meeting> getMeetingsChecked() {
        return meetingRepository.findAllChecked();
    }

    public void approveMeeting(Long id) {
        Meeting meeting = getMeetingById(id);
        if (meeting.getState().equals(0)) {
            meeting.setState(1);
            meetingRepository.save(meeting);
        } else {
            throw new CustomException(210, "授权失败，此会议已经授权或已过期");
        }
        Remind remind = new Remind();
        remind.setContent("您有一个会议" + meeting.getName() +
                "此会议将在" + meeting.getRoom().getLocation() + "-" +
                meeting.getRoom().getName() + "于" + meeting.getStartTime() + "举行");
        remind.setMeeting(meeting);
        remindService.saveRemind(remind);
        meeting.getUserMeetings().forEach(userMeeting -> remindService.addUserRemind(userMeeting.getUser(), remind));
    }

    public void disapproveMeeting(Long id) {
        Meeting meeting = getMeetingById(id);
        if (meeting.getState().equals(0)) {
            meeting.setState(4);
            meetingRepository.save(meeting);
        } else {
            throw new CustomException(210, "授权失败，此会议已经反授权或已过期");
        }
    }
}
