package top.dragondove.boardroom.controller;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.entity.Role;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.service.UserService;
import top.dragondove.boardroom.util.BeanValidationUtils;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @GetMapping("/list")
    public Msg getAllUsers(@RequestParam(defaultValue = "0") int page,
                           @RequestParam(defaultValue = "10") int size) {
        return Msg.success().addExtra("users", userService.getAllUsers(page, size));
    }

    @GetMapping("/all")
    public Msg getAllUsers() {
        return Msg.success().addExtra("users", userService.getAllUsers());
    }

    @GetMapping("/leadMeetings")
    public Msg getLeadMeetings(@RequestParam Long id) {
        if (null == id) {
            return Msg.error("请提供用户id");
        }
        return Msg.success().addExtra("meetings", userService.getLeadMeetingsById(id));
    }

    @GetMapping("/meetings")
    public Msg getMeetings(@RequestParam Long id) {
        if (null == id) {
            return Msg.error("请提供用户id");
        }
        return Msg.success().addExtra("meetings", userService.getMeetingsByUserId(id));
    }

    @GetMapping
    public Msg getUserById(@RequestParam Long id) {
        User user = userService.getUserById(id);
        if (null == user) {
            return Msg.error("不存在此用户");
        }
        return Msg.success().addExtra("user", user);
    }

    @PostMapping("/roles")
    public Msg updateRoles(@RequestParam Long id,
                           @RequestBody List<Role> roles) {
        userService.saveUserRoles(id, roles);
        return Msg.success();
    }

    @PostMapping
    public Msg addUser(@Valid @RequestBody User user, BindingResult result) {
        if (result.hasErrors()) {
            String error = Objects.requireNonNull(result.getFieldError()).getDefaultMessage();
            return Msg.error(error);
        }
        if (BeanValidationUtils.invalidatePassword(user.getPassword())) {
            return Msg.error("密码必须包含数字和字母且长度为6-16位");
        }
        String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
        user.setSalt(salt);
        user.setPassword(new Md5Hash(user.getPassword(), salt, 3).toString());
        userService.saveUser(user);
        return Msg.success("新增用户成功");
    }

    @PostMapping("/uploadPhoto")
    public Msg uploadPhoto(@RequestParam Long id, MultipartFile file) {
        try {
            userService.saveUserPhoto(id, file);
        } catch (IOException e) {
            return Msg.error(e.getMessage());
        }
        return Msg.success("照片保存成功");
    }

    @PostMapping("/uploadPhotoChannel")
    public Msg uploadPhoto(MultipartFile file) {
        try {
            userService.saveUserPhoto(file);
        } catch (IOException e) {
            return Msg.error(e.getMessage());
        }
        return Msg.success("照片保存成功");
    }

    @PostMapping("/uploadPhotos")
    public Msg uploadPhotos(MultipartFile[] files) {
        try {
            userService.saveUserPhotos(files);
        } catch (IOException e) {
            return Msg.error(e.getMessage());
        }
        return Msg.success("上传照片成功");
    }

    @PutMapping
    public Msg updateUser(@Valid @RequestBody User user, BindingResult result) {
        if (null == user.getId()) {
            return Msg.error("请指定用户id");
        }
        if (result.hasErrors()) {
            String error = Objects.requireNonNull(result.getFieldError()).getDefaultMessage();
            return Msg.error(error);
        }
        if (null != user.getPassword()) {
            return Msg.error("请勿更改密码");
        }
        userService.saveUser(user);
        return Msg.success("更新用户成功");
    }

    @DeleteMapping
    public Msg deleteUser(@RequestParam Long id) {
        userService.deleteUserById(id);
        return Msg.success();
    }

}
