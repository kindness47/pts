package com.pts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NavController {

    //组织机构预览
    @RequestMapping(value = "/organization-list")
    public String organizationList(){
        return "pts/organization-list";
    }

    //组织机构管理
    @RequestMapping(value = "/organization-manage")
    public String organizationManage(){
        return "pts/organization-manage";
    }
}
