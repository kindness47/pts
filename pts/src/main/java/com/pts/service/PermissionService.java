package com.pts.service;

import com.pts.model.Permission;
import com.pts.model.User;

import java.util.List;

public interface PermissionService {
    //获取Permission
    List<Permission> getPermission(Permission permission);
    //插入Permission
    int insert(Permission permission);
    //更新Permission
    int update(Permission permission);
    //删除权限
    int deletePermissionBySole(Permission permission);

    void saveUserPermission(String dataStr, User user, String opUserId);

    void deletePermissionBuUserId(String userId);
}
