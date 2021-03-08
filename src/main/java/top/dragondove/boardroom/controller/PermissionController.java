package top.dragondove.boardroom.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.service.PermissionService;

import javax.annotation.Resource;

@RestController
@RequestMapping("/permission")
public class PermissionController {

    @Resource
    PermissionService permissionService;

    @GetMapping("/all")
    public Msg getAllPermissions() {
        return Msg.success().addExtra("permissions", permissionService.getAllPermissions());
    }

//    @PostMapping
//    public Msg addPermission(@RequestBody Permission permission) {
//        permissionService.savePermission(permission);
//        return Msg.success();
//    }
//
//    @PutMapping
//    public Msg updatePermission(@RequestBody Permission permission) {
//        if (null == permission.getId()) {
//            return Msg.error("请指定权限id");
//        }
//        permissionService.savePermission(permission);
//        return Msg.success();
//    }

}
