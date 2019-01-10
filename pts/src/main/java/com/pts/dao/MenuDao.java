package com.pts.dao;

import com.pts.model.Menu;

import java.util.List;

public interface MenuDao {
    //根据id获取Menu
    Menu selectById(String id);
    //获取Menu
    List<Menu> getMenusByUserId(String userId);
    //获取所有menu
    List<Menu> getAll();
    //插入menu
    int insert(Menu menu);
    //删除menu
    int deleteById(String id);
    //更新menu
    int updateByPrimaryKeySelective(Menu menu);
}
