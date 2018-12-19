package com.pts.dao;

import com.pts.model.Permission;

import java.util.List;

public interface PermissionDao {
    //获取所有的Permission
    List<Permission> getAllPermission();
    //根据状态获取所有Permission
    List<Permission> getAllPermissionByStatus(Permission permission);
    //插入Permission
    int insert(Permission permission);
    //更新Permission
    int update(Permission permission);
    //删除权限
    int deletePermissionBySole(Permission permission);

}
