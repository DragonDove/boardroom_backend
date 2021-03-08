package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import top.dragondove.boardroom.entity.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {



}
