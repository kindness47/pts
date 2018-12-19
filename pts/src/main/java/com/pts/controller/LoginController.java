package com.pts.controller;

import com.pts.model.User;
import com.pts.util.SystemUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.UUID;

@Controller
public class LoginController extends BaseController{

    @RequestMapping("/")
    public String toLogin(){
        return "login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(User user, Model model){
        if(user == null)
            return "login";
        if(user.getAccount() == null || user.getPassWord() == null)
            return "login";
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccount(),user.getPassWord(),null);
        try{
            subject.login(token);
            User user1 = (User)SystemUtil.getSession().getAttribute("user");
            model.addAttribute("user",user1);
        }catch (Exception e){
            System.out.println("-----------------登陆失败:"+e.getMessage());
            return "login";
        }
        return "index";
    }
    @RequestMapping("/welcome")
    public ModelAndView welCome(){
        ModelAndView mav = new ModelAndView("welcome");
        return mav;
    }

    @RequestMapping("/logout")
    public String logOut(){
        Subject subject = SecurityUtils.getSubject();
       if(subject != null)
           try{
               subject.logout();
           }catch (Exception e){

           }
        return "redirect:/";
    }
}
