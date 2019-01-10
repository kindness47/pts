package com.pts.service.impl;

import com.pts.dao.MenuDao;
import com.pts.model.Menu;
import com.pts.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        return menuDao.insert(menu);
    }

    @Override
    public int deleteById(String id) {
        return menuDao.deleteById(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Menu menu) {
        return updateByPrimaryKeySelective(menu);
    }
}
