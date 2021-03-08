package top.dragondove.boardroom.config;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import top.dragondove.boardroom.entity.Permission;
import top.dragondove.boardroom.entity.Role;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.service.PermissionService;
import top.dragondove.boardroom.service.RoleService;
import top.dragondove.boardroom.service.UserService;

import javax.annotation.Resource;

public class MyRealm extends AuthorizingRealm {

    @Resource
    private UserService userService;

    @Resource
    private RoleService roleService;

    @Resource
    private PermissionService permissionService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        User user = (User) principals.getPrimaryPrincipal();
        for (Role role : roleService.getRolesByUserId(user.getId())) {
            authorizationInfo.addRole(role.getRole());
            for (Permission permission : permissionService.getPermissionsByRoleId(role.getId())) {
                authorizationInfo.addStringPermission(permission.getPermission());
            }
        }
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String) token.getPrincipal();
        User user = userService.findByUsername(username);
        if (null == user) {
            return null;
        }
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user, user.getPassword(), getName());
        
        authenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(user.getSalt()));
        return authenticationInfo;
    }
}
