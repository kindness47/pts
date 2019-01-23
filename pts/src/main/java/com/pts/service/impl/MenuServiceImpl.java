package com.pts.service.impl;

import com.mysql.cj.util.StringUtils;
import com.pts.base.Constants;
import com.pts.dao.MenuDao;
import com.pts.exceptions.MenuException;
import com.pts.model.Menu;
import com.pts.service.MenuService;
import com.pts.util.SystemUtil;
import com.pts.util.UUIDUtil;
import com.pts.vo.MenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;

    @Override
    public Menu selectById(String id) {
        return menuDao.selectById(id);
    }

    @Override
    public List<Menu> getMenusByUserId(String userId) {
        return menuDao.getMenusByUserId(userId);
    }

    @Override
    public List<Menu> getAll() {
        return menuDao.getAll();
    }

    @Override
    public int insert(Menu menu) {
        //初始化系统排序
        Menu resultMenu = menuDao.select(menu);
        if(resultMenu != null)
            throw new MenuException("当前排序已被占用");

        menu.setId(UUIDUtil.getUUIDString());
        menu.setMenuClass(menu.getMenuClass().replace("-",""));
        menu.setStatus(Constants.STATUS_EFFECTIVE);
        menu.setCreateBy(SystemUtil.getLoginUser());
        menu.setCreateTime(new Date(System.currentTimeMillis()));
        return menuDao.insert(menu);
    }

    @Override
    public int deleteById(String id) {
        return menuDao.deleteById(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Menu menu) {
        menu.setUpdateBy(SystemUtil.getLoginUser());
        menu.setUpdateTime(new Date(System.currentTimeMillis()));
        if(menu.getStatus() == Constants.STATUS_EFFECTIVE)
            menu.setExceptionDesc("");
        else
            if(StringUtils.isNullOrEmpty(menu.getExceptionDesc()))
                menu.setExceptionDesc("操作员未填写操作理由");
        return menuDao.updateByPrimaryKeySelective(menu);
    }

    @Override
    public List<MenuVO> getMenuByVO(MenuVO menuVO) {
        return menuDao.getMenuByVO(menuVO);
    }

    @Override
    public int getMenusCount(MenuVO menuVO) {
        return menuDao.getMenusCount(menuVO);
    }

    @Override
    public int getMaxSort(Menu menu) {
        return menuDao.getMaxSort(menu);
    }
}
