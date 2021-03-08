package top.dragondove.boardroom.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresGuest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.dragondove.boardroom.component.GlobalConfiguration;
import top.dragondove.boardroom.service.*;

import javax.annotation.Resource;

@Controller
@RequestMapping("/manage")
public class ManagePageController {

    private GlobalConfiguration configuration;

    @Resource
    private RoomService roomService;

    @Resource
    private MeetingService meetingService;

    @Resource
    private UserService userService;

    @Resource
    private RoleService roleService;

    @Resource
    private PermissionService permissionService;

    @Autowired
    public ManagePageController(GlobalConfiguration configuration) {
        this.configuration = configuration;
    }

    @RequiresPermissions({"meeting:approve"})
    @RequestMapping("/index")
    public String home() {
        return "manage/index";
    }

    @RequestMapping({"", "/", "/loginPage"})
    public String login() {
        if (null != SecurityUtils.getSubject().getPrincipal()) {
            return "redirect:/manage/index";
        }
        return "manage/login";
    }

    @RequestMapping("/feedbackPage")
    public String feedback() {
        return "manage/feedback";
    }

    @RequestMapping("/mainPage")
    public String main() {
        return "manage/main";
    }

    @RequestMapping("/permissionManagementPage")
    public String permissionManagement(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("roles", roleService.getAllRoles());
        model.addAttribute("permissions", permissionService.getAllPermissions());
        return "manage/permman";
    }

    @RequestMapping("/roomPage")
    public String room(@RequestParam Long id, Model model) {
        model.addAttribute("room", roomService.getRoomById(id));
        return "manage/room";
    }

    @RequestMapping("/roomListPage")
    public String roomList() {
        return "manage/roomList";
    }

    @RequestMapping("/meetingRequestPage")
    public String meetingRequest(Model model) {
        model.addAttribute("checked", meetingService.getMeetingsChecked());
        model.addAttribute("unchecked", meetingService.getMeetingsUnchecked());
        return "manage/meetingReq";
    }

    @RequestMapping("/meetingListPage")
    public String meetingList() {
        return "manage/meetingList";
    }

    @RequestMapping("/systemLogPage")
    public String systemLog() {
        return "manage/syslog";
    }

    @RequestMapping("/systemConfigPage")
    public String config() {
        return "manage/sysConfig";
    }

    @RequestMapping("/userListPage")
    public String userList() {
        return "manage/userList";
    }

    @RequestMapping("/passwordChangePage")
    public String password() {
        return "manage/pwdchange";
    }

}
