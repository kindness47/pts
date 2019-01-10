package com.pts.service;

import com.pts.model.User;
import com.pts.vo.UserVO;

import java.util.List;

public interface UserService {
    //插入
    int insert(User user);

    //通过唯一标识符获取用户(id,account)
    User getUserBySole(User user);

    //获取用户
    List<User> getUser(UserVO user);

    int deleteByPrimaryKey(String id);

    int updateUserByPrimaryKeySelective(User user);

    Integer getUserCount(UserVO userVO);
}
