package com.pts.controller;

import com.mysql.cj.util.StringUtils;
import com.pts.base.Constants;
import com.pts.base.Response;
import com.pts.exceptions.MenuException;
import com.pts.model.Menu;
import com.pts.service.MenuService;
import com.pts.vo.MenuVO;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MenuController extends BaseController{

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/menu-list")
    public String menuList(){
        return "manage/menu-list";
    }
    /**
     * Description： 根据查询条件获取menus
     * Author: 刘永红
     * Date: Created in 2019/1/17 10:44
     */
    @RequestMapping(value = "/getmenus",method = RequestMethod.POST)
    @ResponseBody
    public Response getMenus(MenuVO menuVO){
        List<MenuVO> menuList = menuService.getMenuByVO(menuVO);
        return returnSuccess(menuList);
    }
    /**
     * Description： 获取数量
     * Author: 刘永红
     * Date: Created in 2019/1/18 10:38
     */
    @RequestMapping(value = "/get-menu-count",method = RequestMethod.POST)
    @ResponseBody
    public Response getCount(MenuVO menuVO){
        int resultCount = menuService.getMenusCount(menuVO);
        return returnSuccess(resultCount);
    }

    @RequestMapping(value = "/menu-add")
    public String menuAdd(Model model){
        //查出
        List<MenuVO> menuList = menuService.getMenuByVO(null);
        List<MenuVO> menus = menuList.stream()
                .filter(menuVO -> menuVO.getLevel() == Constants.LEVEL1 || menuVO.getLevel() == Constants.LEVEL2)
                .collect(Collectors.toList());
        model.addAttribute("menus",menus);
        return "manage/menu-add";
    }

    /**
     * Description： 通过id获取menu信息
     * Author: 刘永红
     * Date: Created in 2019/1/17 10:44
     */
    @RequestMapping(value = "/menu/{id}")
    public String getMenu(@PathVariable("id") String id , Model model){
        Menu menu = menuService.selectById(id);

        //查出
        List<MenuVO> menuList = menuService.getMenuByVO(null);
        List<MenuVO> menus = menuList.stream().filter(menuVO -> menuVO.getLevel() == Constants.LEVEL1 || menuVO.getLevel() == Constants.LEVEL2)
                    .collect(Collectors.toList());
        model.addAttribute("menu",menu);
        model.addAttribute("menus",menus);
        return "manage/menu-add";
    }

    @RequestMapping(value = "/change-menustatus",method = RequestMethod.POST)
    @ResponseBody
    public Response changeMenuStatus(Menu menu){
        menuService.updateByPrimaryKeySelective(menu);
        return returnSuccess("改变状态成功");
    }

    @RequestMapping(value = "/menu-save",method = RequestMethod.POST)
    @ResponseBody
    public Response menuSave(Menu menu){
        if(StringUtils.isNullOrEmpty(menu.getId())){
            //新增
            try {
                menuService.insert(menu);
            } catch (MenuException e) {
                Response response = new Response();
                response.setErrCode("1234");
                response.setMessage(e.getMessage());
                response.setSuccess(false);
                return response;
            }
            return returnSuccess("新增成功");
        }else{
            //更新
            menuService.updateByPrimaryKeySelective(menu);
            return returnSuccess("更新成功");
        }
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Response deleteById(@PathVariable("id") String id){
        menuService.deleteById(id);
        return returnSuccess("删除成功");
    }
}
