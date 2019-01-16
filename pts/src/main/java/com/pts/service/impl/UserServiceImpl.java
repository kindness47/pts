package com.pts.service.impl;

import com.pts.base.Constants;
import com.pts.dao.UserDao;
import com.pts.model.Menu;
import com.pts.model.User;
import com.pts.service.MenuService;
import com.pts.service.PermissionService;
import com.pts.service.UserService;
import com.pts.util.SystemUtil;
import com.pts.util.UUIDUtil;
import com.pts.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private MenuService menuService;

    @Autowired
    private PermissionService permissionService;

    @Override
    public int insert(User user) {
        user.setId(UUIDUtil.getUUIDString());
        user.setStatus(1);
        user.setCreateTime(new Date(System.currentTimeMillis()));
        user.setCreateBy(SystemUtil.getLoginUser());
        int resultCount = userDao.insert(user);
        //管理员默认分配所有权限
        if(user.getRoleName().equals(Constants.SUPER_ADMIN)){
            List<Menu> menuList = menuService.getAll();
            String permissionStr = "";
            for(int i = 0 ; i < menuList.size() ; i++){
                if(i == menuList.size()-1)
                    permissionStr += menuList.get(i).getMenuCode();
                else
                    permissionStr += menuList.get(i).getMenuCode()+",";
            }
            permissionService.saveUserPermission(permissionStr,user,user.getId());
        }
        return resultCount;
    }

    @Override
    public User getUserBySole(User user) {
        return userDao.getUserBySole(user);
    }

    @Override
    public List<User> getUser(UserVO user) {
        return userDao.getUser(user);
    }

    @Override
    public int deleteByPrimaryKey(String id) {
        return userDao.deleteByPrimaryKey(id);
    }

    @Override
    public int updateUserByPrimaryKeySelective(User user) {
        return userDao.updateUserByPrimaryKeySelective(user);
    }

    @Override
    public Integer getUserCount(UserVO userVO) {
        return userDao.getUserCount(userVO);
    }
}
