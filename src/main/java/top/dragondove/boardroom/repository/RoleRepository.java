package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.Role;

import javax.transaction.Transactional;
import java.util.List;

public interface RoleRepository extends JpaRepository<Role, Long> {


    @Query(value = "select * from role, user_role where user_role.user_id = ?1 and role.id = user_role.role_id", nativeQuery = true)
    List<Role> findByUserId(Long userId);

    @Modifying
    @Transactional
    @Query(value = "delete from role_permission where role_id = ?1", nativeQuery = true)
    void removePermissionsById(Long id);

    @Modifying
    @Transactional
    @Query(value = "insert into role_permission values (?1, ?2)", nativeQuery = true)
    void addPermission(Long roleId, Long permissionId);
}
