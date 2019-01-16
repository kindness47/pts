package com.pts.service.impl;

import com.pts.base.Constants;
import com.pts.dao.PermissionDao;
import com.pts.exceptions.PermissionException;
import com.pts.model.Permission;
import com.pts.model.User;
import com.pts.service.PermissionService;
import com.pts.service.UserService;
import com.pts.util.SystemUtil;
import com.pts.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    @Autowired
    private UserService userService;

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

    @Override
    public void deletePermissionBuUserId(String userId) {
        Permission p = new Permission();
        p.setUserId(userId);
        permissionDao.deletePermissionBySole(p);
    }

    /**
     * Description： 保存用户-权限信息表
     * Author: 刘永红
     * Date: Created in 2019/1/16 16:23
     */
    @Override
    @Transactional(rollbackFor = {Exception.class})
    public void saveUserPermission(String dataStr ,User user, String opUserId) {
        if(user == null) {
            User u = new User();
            u.setId(opUserId);
            user = userService.getUserBySole(u);
            /*
            if (user.getRoleName().equals(Constants.SUPER_ADMIN))
                throw new PermissionException("你不能变更管理员权限");
            */
        }else
            opUserId = user.getId();
        List<String> permissionStrList = Arrays.asList(dataStr.split(","));

        List<Permission> permissionList = new ArrayList<>();

        for(String permissionStr : permissionStrList){
            Permission p = new Permission();
            switch (permissionStr.length()){
                case 2 : p.setPermissionType(Constants.PERMISSION_TYPE1); break;
                case 4 : p.setPermissionType(Constants.PERMISSION_TYPE2); break;
                case 7 : p.setPermissionType(Constants.PERMISSION_TYPE3); break;
            }
            p.setId(UUIDUtil.getUUIDString());
            p.setUserId(opUserId);
            p.setPermission(permissionStr);
            p.setStatus(Constants.STATUS_EFFECTIVE);
            p.setExceptionDesc("");
            p.setCreateBy(SystemUtil.getLoginUser());
            p.setUpdateBy(SystemUtil.getLoginUser());
            permissionList.add(p);
        }
        //删除用户之前的权限
        deletePermissionBuUserId(opUserId);
        //添加新的用户权限
        int count = permissionDao.insertByBatch(permissionList);
        if(count <= 0)
            throw new PermissionException("分配新权限失败");
    }
}
