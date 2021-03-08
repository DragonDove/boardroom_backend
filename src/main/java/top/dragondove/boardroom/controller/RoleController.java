package top.dragondove.boardroom.controller;

import org.springframework.web.bind.annotation.*;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.entity.Permission;
import top.dragondove.boardroom.entity.Role;
import top.dragondove.boardroom.service.RoleService;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/role")
public class RoleController {

    @Resource
    private RoleService roleService;

    @GetMapping("/all")
    public Msg getAllRoles() {
        return Msg.success().addExtra("roles", roleService.getAllRoles());
    }

    @GetMapping
    public Msg getRoleById(@RequestParam Long id) {
        return Msg.success().addExtra("role", roleService.getRoleById(id));
    }

    @PostMapping("/permissions")
    public Msg addRolePermission(@RequestParam Long id,
                                 @RequestBody List<Permission> permissions) {
        roleService.saveRolePermissions(id, permissions);
        return Msg.success();
    }

    @PostMapping
    public Msg addRole(@RequestBody Role role) {
        roleService.saveRole(role);
        return Msg.success().addExtra("role", role);
    }

    @PutMapping
    public Msg updateRole(@RequestBody Role role) {
        if (null == role.getId()) {
            return Msg.error("请输入角色id");
        }
        roleService.saveRole(role);
        return Msg.success();
    }

    @DeleteMapping
    public Msg deleteRole(@RequestParam Long id) {
        roleService.deleteRoleById(id);
        return Msg.success();
    }

}
