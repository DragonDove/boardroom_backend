package top.dragondove.boardroom.controller;

import org.springframework.web.bind.annotation.*;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.entity.Remind;
import top.dragondove.boardroom.service.RemindService;

import javax.annotation.Resource;

@RestController
@RequestMapping("/remind")
public class RemindController {

    @Resource
    private RemindService remindService;

    @GetMapping
    public Msg getRemindById(@RequestParam Long id) {
        return Msg.success().addExtra("remind", remindService.getRemindById(id));
    }

    @PostMapping
    public Msg addRemind(@RequestBody Remind remind) {
        remindService.saveRemind(remind);
        return Msg.success();
    }

    @PutMapping
    public Msg updateRemind(@RequestBody Remind remind) {
        if (null == remind.getId()) {
            return Msg.error("请提供提醒id");
        }
        remindService.saveRemind(remind);
        return Msg.success();
    }

    @DeleteMapping
    public Msg deleteRemind(@RequestParam Long id) {
        remindService.deleteRemindById(id);
        return Msg.success();
    }

}
