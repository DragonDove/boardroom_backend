package top.dragondove.boardroom.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;
import top.dragondove.boardroom.entity.Department;
import top.dragondove.boardroom.entity.Msg;
import top.dragondove.boardroom.service.DepartmentService;

import javax.annotation.Resource;

@RestController
@RequestMapping("/department")
public class DepartmentController {

    @Resource
    private DepartmentService departmentService;

    @GetMapping("/all")
    public Msg getAllDepartments() {
        return Msg.success().addExtra("departments", departmentService.getAllDepartments());
    }

    @GetMapping("/users")
    public Msg getDepartmentUsers(@RequestParam Long id) {
        return Msg.success().addExtra("users", departmentService.getAllUsersById(id));
    }

    @GetMapping
    public Msg getDepartmentById(@RequestParam Long id) {
        return Msg.success().addExtra("department", departmentService.getDepartmentById(id));
    }

    @PostMapping
    public Msg addDepartment(@RequestBody Department department) {
        departmentService.saveDepartment(department);
        return Msg.success();
    }

    @PutMapping
    public Msg updateDepartment(@RequestBody Department department) {
        if (null == department.getId()) {
            return Msg.error("找不到此部门");
        }
        departmentService.saveDepartment(department);
        return Msg.success();
    }

    @DeleteMapping
    public Msg deleteDepartment(@RequestParam Long id) {
        departmentService.deleteDepartmentById(id);
        return Msg.success();
    }

}
