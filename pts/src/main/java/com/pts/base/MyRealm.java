package com.pts.base;

import com.pts.model.Permission;
import com.pts.model.User;
import com.pts.service.PermissionService;
import com.pts.service.UserService;
import com.pts.util.SystemUtil;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Description： 自定义权限控制
 * Author: 刘永红
 * Date: Created in 2018/11/30 9:56
 */
public class MyRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;

    //用户授权认证
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String account = principalCollection.getPrimaryPrincipal().toString();
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        //通过用户account查询用户对象
        User u = new User();
        u.setAccount(account);
        User user = userService.getUserBySole(u);
        //通过用户id查询用户权限列表
        Permission p = new Permission();
        p.setUserId(user.getId());
        List<Permission> permissionList = permissionService.getPermission(p);
        //将用户权限集合添加到simpleAuthorizationInfo
        Set<String> permissionSet = new HashSet<String>();
        for(Permission permission : permissionList)
            permissionSet.add(permission.getPermission());
        simpleAuthorizationInfo.setStringPermissions(permissionSet);
        return simpleAuthorizationInfo;
    }
    //用户登录认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String account = authenticationToken.getPrincipal().toString();
        User u = new User();
        u.setAccount(account);
        User user = userService.getUserBySole(u);
        if(user != null){
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getAccount(),user.getPassWord(),account);
            Session session = SystemUtil.getSession();
            session.setAttribute("user",user);
            return authenticationInfo;
        }
        return null;
    }
}
