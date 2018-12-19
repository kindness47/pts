package com.pts.service.impl;

import com.pts.dao.UserDao;
import com.pts.model.User;
import com.pts.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public int insert(User user) {
        return userDao.insert(user);
    }

    @Override
    public User getUserBySole(User user) {
        return userDao.getUserBySole(user);
    }

    @Override
    public List<User> getUser(User user) {
        return userDao.getUser(user);
    }
}
