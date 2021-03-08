package top.dragondove.boardroom.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.dragondove.boardroom.component.GlobalConfiguration;
import top.dragondove.boardroom.service.*;

import javax.annotation.Resource;

@Controller
public class PageController {

    private GlobalConfiguration configuration;

    @Resource
    private RoomService roomService;

    @Resource
    private MeetingService meetingService;

    @Resource
    private UserService userService;

    @Resource
    private DepartmentService departmentService;

    @Resource RemindService remindService;

    @Resource
    private RoleService roleService;

    @Resource
    private PermissionService permissionService;

    @Autowired
    public PageController(GlobalConfiguration configuration) {
        this.configuration = configuration;
    }

    @RequestMapping("/index")
    @RequiresUser
    public String home() {
        return "index";
    }

    @RequestMapping("/testPage")
    public String test() {
        return "test";
    }

    @RequestMapping({"", "/", "/loginPage"})
    public String login() {
        if (null != SecurityUtils.getSubject().getPrincipal()) {
            return "/index";
        }
        return "login";
    }
//
//
//    @RequestMapping("/mainPage")
//    public String main() {
//        return "main";
//    }
//
    @RequestMapping("/roomPage")
    public String room(@RequestParam Long id, Model model) {
        model.addAttribute("user", userService.getCurrentUser());
        model.addAttribute("room", roomService.getRoomById(id));
        return "room";
    }
//
//    @RequestMapping("/roomListPage")
//    public String roomList() {
//        return "roomList";
//    }

    @RequestMapping("/meetingPage")
    public String meeting(@RequestParam Long id, Model model) {
        model.addAttribute("meeting", meetingService.getMeetingById(id));
        return "meeting";
    }

    @RequestMapping("/meetingListPage")
    public String meetingList(Model model) {
        model.addAttribute("user", userService.getCurrentUser());
        return "meetingList";
    }

    @RequestMapping("/remindPage")
    public String remind(Model model) {
        Long userId = userService.getCurrentUser().getId();
        model.addAttribute("unreads", remindService.getUnreadRemindsByUserId(userId));
        model.addAttribute("reminds", remindService.getRemindsByUserId(userId));
        return "remind";
    }

    @RequestMapping("/informationPage")
    public String password(Model model) {
        model.addAttribute("user", userService.getCurrentUser());
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "information";
    }

    @RequestMapping("/meetingRequestPage")
    public String meetingRequest(Model model) {
        model.addAttribute("rooms", roomService.getAllRooms());
        return "meetingreq";
    }

}
