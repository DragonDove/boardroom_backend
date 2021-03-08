package top.dragondove.boardroom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import top.dragondove.boardroom.entity.User;

import javax.transaction.Transactional;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username);

    @Modifying
    @Transactional
    @Query(value = "insert into user_role values (?1, 2)", nativeQuery = true)
    void setBaseRole(Long id);

    @Modifying
    @Transactional
    @Query(value = "insert into user_role values (?1, ?2)", nativeQuery = true)
    void addRole(Long userId, Long roleId);

    @Modifying
    @Transactional
    @Query(value = "delete from user_role where user_id = ?1", nativeQuery = true)
    void removeRolesById(Long id);
}
