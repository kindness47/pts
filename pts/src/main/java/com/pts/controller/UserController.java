package com.pts.controller;

import com.mysql.cj.util.StringUtils;
import com.pts.base.Constants;
import com.pts.base.Response;
import com.pts.model.Menu;
import com.pts.model.User;
import com.pts.service.MenuService;
import com.pts.service.UserService;
import com.pts.util.SystemUtil;
import com.pts.util.UUIDUtil;
import com.pts.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/user-list")
    public String userList(){
        return "manage/user-list";
    }

    @RequestMapping(value = "/list-user-by-selective",method = RequestMethod.POST)
    @ResponseBody
    public Response listUserBySelective(UserVO userVO){
        Integer count = userService.getUserCount(userVO);
        List<User> users = userService.getUser(userVO);
        Map<String,Object> resultmap = new HashMap<>();
        resultmap.put("count",count);
        resultmap.put("resultdata",users);
        return returnSuccess(resultmap);
    }

    @RequestMapping(value = "/user-add")
    public String userAdd(){
        return "manage/user-add";
    }
    @RequestMapping(value = "/user-edit/{id}")
    public ModelAndView userEdit(@PathVariable("id") String id){
        ModelAndView mav = new ModelAndView("manage/user-add");
        User u = new User();
        u.setId(id);
        User opUser = userService.getUserBySole(u);
        mav.addObject("currentUser",opUser);
        return mav;
    }

    @RequestMapping(value = "/changeUserStatus",method = RequestMethod.POST)
    @ResponseBody
    public Response changeUserStatus(User user){
        if(user.getStatus() == 0){//禁用
            if(StringUtils.isNullOrEmpty(user.getExceptionDesc()))
                user.setExceptionDesc("操作员未填写停用理由");
        }else{//启用
            user.setExceptionDesc("");
        }
        int resultCount = userService.updateUserByPrimaryKeySelective(user);
        return resultCount > 0 ? returnSuccess("操作成功"):returnValidateError("操作失败");
    }

    @RequestMapping(value="/user-save",method = RequestMethod.POST)
    @ResponseBody
    public Response userSave(User user){
        int resultCount = 0;
        if(StringUtils.isNullOrEmpty(user.getId())){
            //新增
            user.setId(UUIDUtil.getUUIDString());
            user.setStatus(1);
            user.setCreateTime(new Date(System.currentTimeMillis()));
            user.setCreateBy(SystemUtil.getLoginUser());
            resultCount = userService.insert(user);
        }else{
            //修改
            user.setUpdateTime(new Date(System.currentTimeMillis()));
            user.setUpdateBy(SystemUtil.getLoginUser());
            resultCount = userService.updateUserByPrimaryKeySelective(user);
        }
        return resultCount > 0 ? returnSuccess("操作成功") : returnValidateError("操作失败");
    }

    @RequestMapping(value = "/user-delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Response userDelete(@PathVariable("id") String id){
        int resultCount = userService.deleteByPrimaryKey(id);
        return resultCount > 0 ? returnSuccess("删除成功") : returnValidateError("删除失败");
    }

    @RequestMapping(value = "/user-reset-password/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Response userResetPassword(@PathVariable("id") String id){
        User u = new User();
        u.setId(id);
        u.setPassWord("123");
        int resultCount = userService.updateUserByPrimaryKeySelective(u);
        return resultCount > 0 ? returnSuccess("重置成功,重置后密码为123") : returnValidateError("重置失败");
    }

    @RequestMapping(value = "/user-permission/{id}")
    public ModelAndView userPermission(@PathVariable("id")String id){
        List<Menu> currentUserMenus = new ArrayList<>();
        if(SystemUtil.getSessionUser().getRoleName().equals(Constants.SUPER_ADMIN))
            currentUserMenus = menuService.getAll();
        else
            currentUserMenus = menuService.getMenusByUserId(SystemUtil.getSessionUser().getId());
        List<Menu> opUserMenus = menuService.getMenusByUserId(id);
        ModelAndView mav = new ModelAndView("manage/user-permission");
        mav.addObject("currentLoginUserMenus",currentUserMenus);
        mav.addObject("opUserMenus",opUserMenus);
        return mav;
    }
}
