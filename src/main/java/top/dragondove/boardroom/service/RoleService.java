package top.dragondove.boardroom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.Permission;
import top.dragondove.boardroom.entity.Role;
import top.dragondove.boardroom.repository.RoleRepository;
import top.dragondove.boardroom.util.UpdateUtils;

import java.util.List;

@Service
public class RoleService {

    private final RoleRepository roleRepository;

    @Autowired
    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public Role getRoleById(Long id) {
        return roleRepository.findById(id).orElse(null);
    }

    public Page<Role> getAllRoles(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return roleRepository.findAll(pageable);
    }

    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    public void saveRole(Role role) {
        if (null != role.getId()) {
            Role origin = getRoleById(role.getId());
            if (null != origin) {
                UpdateUtils.copyNullProperties(origin, role);
            }
        }
        roleRepository.save(role);
    }

    public List<Role> getRolesByUserId(Long id) {
        return roleRepository.findByUserId(id);
    }

    public void deleteRoleById(Long id) {
        Role role = getRoleById(id);
        role.getPermissions().forEach(permission -> permission.getRoles().remove(role));
        role.getUsers().forEach(user -> user.getRoles().remove(role));
        roleRepository.deleteById(id);
    }

    public void saveRolePermissions(Long id, List<Permission> permissions) {
        roleRepository.removePermissionsById(id);
        permissions.forEach(permission -> roleRepository.addPermission(id, permission.getId()));

    }
}
