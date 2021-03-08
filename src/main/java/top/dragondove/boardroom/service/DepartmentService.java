package top.dragondove.boardroom.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.Department;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.repository.DepartmentRepository;
import top.dragondove.boardroom.util.UpdateUtils;

import java.util.Collections;
import java.util.List;

@Service
public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    public DepartmentService(DepartmentRepository departmentRepository) {
        this.departmentRepository = departmentRepository;
    }

    public Department getDepartmentById(Long id) {
        return departmentRepository.findById(id).orElse(null);
    }

    public Page<Department> getAllDepartments(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return departmentRepository.findAll(pageable);
    }

    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    public void saveDepartment(Department department) {
        if (null != department.getId()) {
            Department origin = getDepartmentById(department.getId());
            if (null != origin) {
                UpdateUtils.copyNullProperties(origin, department);
            }
        }
        departmentRepository.save(department);
    }

    public void deleteDepartment(Department department) {
             departmentRepository.delete(department);
    }

    public void deleteDepartmentById(Long id) {
        getAllUsersById(id).forEach(user -> user.setDepartment(null));
        departmentRepository.deleteById(id);
    }

    public List<User> getAllUsersById(Long id) {
        return departmentRepository.findById(id).map(Department::getUsers).orElse(Collections.emptyList());
    }
}
