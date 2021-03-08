package top.dragondove.boardroom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.Remind;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.repository.RemindRepository;

import java.util.Collections;
import java.util.List;

@Service
public class RemindService {

    private final RemindRepository remindRepository;

    @Autowired
    public RemindService(RemindRepository remindRepository) {
        this.remindRepository = remindRepository;
    }

    public Remind getRemindById(Long id) {
        return remindRepository.findById(id).orElse(null);
    }

    public void saveRemind(Remind remind) {
        remindRepository.save(remind);
    }

    public void deleteRemindById(Long id) {
        remindRepository.deleteById(id);
    }

    public List<Remind> getRemindsByUserId(Long id) {
        List<Remind> reminds = remindRepository.findByUserId(id);
        Collections.reverse(reminds);
        return reminds;
    }

    public List<Remind> getUnreadRemindsByUserId(Long id) {
        return remindRepository.findUnreadByUserId(id);
    }

    public void setRemindsAsReadByUserId(Long id) {
        remindRepository.setAsReadByUserId(id);
    }

    public void addUserRemind(User user, Remind remind) {
        remindRepository.addUserRemind(user.getId(), remind.getId());
    }

    public List<Remind> getRemindsByMeetingId(Long id) {
        return remindRepository.findByMeetingId(id);
    }

}
