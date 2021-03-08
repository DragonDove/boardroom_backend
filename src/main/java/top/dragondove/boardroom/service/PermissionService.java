package top.dragondove.boardroom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import top.dragondove.boardroom.entity.Permission;
import top.dragondove.boardroom.repository.PermissionRepository;

import java.util.List;

@Service
public class PermissionService {

    private final PermissionRepository permissionRepository;

    @Autowired
    public PermissionService(PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    public Permission getPermissionById(Long id) {
        return permissionRepository.findById(id).orElse(null);
    }

    public Page<Permission> getAllPermissions(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return permissionRepository.findAll(pageable);
    }

    public List<Permission> getAllPermissions() {
        return permissionRepository.findAll();
    }

//    public void savePermission(Permission permission) {
//
//        permissionRepository.save(permission);
//    }

    public List<Permission> getPermissionsByRoleId(Long roleId) {
        return permissionRepository.findByRoleId(roleId);
    }
}
