package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.Permission;

import java.util.List;

public interface PermissionRepository extends JpaRepository<Permission, Long> {


    @Query(value = "select * from permission, role_permission where role_permission.role_id = ?1 and permission.id = role_permission.permission_id", nativeQuery = true)
    List<Permission> findByRoleId(Long roleId);
}
