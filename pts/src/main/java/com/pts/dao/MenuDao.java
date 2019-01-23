package com.pts.dao;

import com.pts.model.Menu;
import com.pts.vo.MenuVO;

import java.util.List;

public interface MenuDao {
    //根据id获取Menu
    Menu selectById(String id);
    //获取Menu
    List<Menu> getMenusByUserId(String userId);
    //获取所有menu
    List<Menu> getAll();
    //根据条件获取menu
    List<MenuVO> getMenuByVO(MenuVO menuVO);
    //根据条件获取menu数量
    int getMenusCount(MenuVO menuVO);
    // 插入menu
    int insert(Menu menu);
    //删除menu
    int deleteById(String id);
    //更新menu
    int updateByPrimaryKeySelective(Menu menu);

    int getMaxSort(Menu menu);
    Menu select(Menu menu);
}
