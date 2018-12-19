package com.pts.controller;

import com.pts.base.Response;
import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.vo.OrganizationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class OrganizationController extends BaseController {

    @Autowired
    private OrganizationService organizationService;


    /**
     * Description： 获取组织机构列表
     * Author: 刘永红
     * Date: Created in 2018/12/7 17:02
     */
    @RequestMapping(value = "/organizations",method = RequestMethod.POST)
    @ResponseBody
    public Response organizations(OrganizationVO organizationVO){
        if(organizationVO.getLimit()!=null &&organizationVO.getPage() != null) {
            organizationVO.setStart((organizationVO.getPage() - 1) * organizationVO.getLimit());
        }else {
            organizationVO.setStart(0);
            organizationVO.setLimit(10);
        }
        List<OrganizationVO> organizationVOList = organizationService.getOrganizations(organizationVO);
        for(OrganizationVO organizationVO1 : organizationVOList)
            System.out.println("---------------->"+organizationVO1.getExceptionDesc());
        return returnSuccess(organizationVOList);
    }

    /**
     * Description： 获取总数
     * Author: 刘永红
     * Date: Created in 2018/12/11 16:12
     */
    @RequestMapping(value = "organizations-count",method = RequestMethod.POST)
    @ResponseBody
    public Response organizationCount(OrganizationVO organizationVO){
        return returnSuccess(organizationService.getOrganizationsCount(organizationVO));
    }

    /**
     * Description： 获取组织机构树信息
     * Author: 刘永红
     * Date: Created in 2018/12/7 17:02
     */
    @RequestMapping(value = "/organization-tree-list",method = RequestMethod.GET)
    @ResponseBody
    public Response organizationTreeList(){
        List<OrganizationVO> organizationList = organizationService.getOrganizations(null);
        return returnSuccess(organizationList);
    }

    /**
     * Description： 新增机构
     * Author: 刘永红
     * Date: Created in 2018/12/10 13:44
     */
    @RequestMapping(value = "/organization-add")
    public ModelAndView organizationAdd(Organization organization){
        String organizationId = organization.getId();
        List<OrganizationVO> organizationVOS = organizationService.getOrganizations(new OrganizationVO());
        ModelAndView modelAndView = new ModelAndView("pts/organization-add");
        modelAndView.addObject("organizations",organizationVOS);
        if(organizationId == null)
            return modelAndView;
        else{
            Organization organization1 = organizationService.getOrganizationById(organizationId);
            modelAndView.addObject("organization",organization1);
            return modelAndView;
        }
    }

    /**
     * Description： 保存提交信息
     * Author: 刘永红
     * Date: Created in 2018/12/10 11:37
     */
    @RequestMapping(value = "/organization-save",method = RequestMethod.POST)
    @ResponseBody
    public Response organizationsSave(Organization organization){
        if(organization.getId() == null){
            //新增
            return returnSuccess("新增成功");
        }else{
            //修改
            return returnSuccess("修改成功");
        }
    }
    /**
     * Description： 通过id删除组织机构信息
     * Author: 刘永红
     * Date: Created in 2018/12/19 16:27
     */
    @RequestMapping(value = "/organization-delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Response organizationDelete(@PathVariable("id") String id){
        return returnSuccess("成功");
    }
}
