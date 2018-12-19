package com.pts.service.impl;

import com.pts.dao.PermissionDao;
import com.pts.model.Permission;
import com.pts.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    @Override
    public List<Permission> getPermission(Permission permission) {
        if (permission == null)
            return permissionDao.getAllPermission();
        else
            return permissionDao.getAllPermissionByStatus(permission);
    }

    @Override
    public int insert(Permission permission) {
        return permissionDao.insert(permission);
    }

    @Override
    public int update(Permission permission) {
        return permissionDao.update(permission);
    }

    @Override
    public int deletePermissionBySole(Permission permission) {
        return permissionDao.deletePermissionBySole(permission);
    }
}
