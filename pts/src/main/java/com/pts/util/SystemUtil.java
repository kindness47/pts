package com.pts.util;

import com.pts.model.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

public class SystemUtil {

    public static Session getSession(){
        Subject subject = SecurityUtils.getSubject();
        Session session = subject.getSession(true);
        return session;
    }

    public static User getSessionUser(){
        User user = (User)getSession().getAttribute("user");
        return user;
    }

    public static String getLoginUser() {
        String userName = getSessionUser().getUserName();
        return userName;
    }
}
