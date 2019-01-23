package com.pts.service;

import com.pts.model.Menu;
import com.pts.vo.MenuVO;

import java.util.List;

public interface MenuService {
    //根据id获取Menu
    Menu selectById(String id);
    //获取Menu
    List<Menu> getMenusByUserId(String userId);
    //根据条件获取menu
    List<MenuVO> getMenuByVO(MenuVO menuVO);

    int getMenusCount(MenuVO menuVO);
    //获取所有menu
    List<Menu> getAll();
    //插入menu
    int insert(Menu menu);
    //删除menu
    int deleteById(String id);
    //更新menu
    int updateByPrimaryKeySelective(Menu menu);

    int getMaxSort(Menu menu);
}
