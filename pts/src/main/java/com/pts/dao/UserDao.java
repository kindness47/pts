package com.pts.dao;

import com.pts.model.User;

import java.util.List;

public interface UserDao {

    //插入
    int insert(User user);

    //通过唯一标识符获取用户(id,account)
    User getUserBySole(User user);

    //获取用户
    List<User> getUser(User user);

}