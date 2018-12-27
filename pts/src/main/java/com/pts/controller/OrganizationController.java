package com.pts.controller;

import com.pts.base.Constants;
import com.pts.base.Response;
import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.util.SystemUtil;
import com.pts.vo.OrganizationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

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
    public Response organizationTreeList(OrganizationVO organizationVO){
        List<OrganizationVO> organizationList = organizationService.getOrganizations(organizationVO);
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
            if(organization.getOrganizationName().equals("") || organization.getOrganizationName() == null)
                return returnValidateError("机构名不能为空");
            if(organization.getOrganizationShortName().equals("") || organization.getOrganizationShortName() == null)
                return  returnValidateError("机构简称不能为空");
            //新增
            //查询父节点level,并设置当前
            if(organization.getParentId() != null){
                Organization parentOrganization = organizationService.getOrganizationById(organization.getParentId());
                switch (parentOrganization.getLevel()){
                    case 1: organization.setLevel(Constants.LEVEL2);
                    case 2: organization.setLevel(Constants.LEVEL3);
                }
            }

            organization.setId(UUID.randomUUID().toString().replace("-",""));
            organization.setStatus(1);
            organization.setCreateBy(SystemUtil.getLoginUser());
            organization.setCreateTime(new Date(System.currentTimeMillis()));
            int sum = organizationService.insert(organization);
            if (sum > 0)
                return returnSuccess("新增成功");
            else
                return returnValidateError("新增失败");
        }else{
            //修改
            organization.setUpdateBy(SystemUtil.getLoginUser());
            organization.setUpdateTime(new Date(System.currentTimeMillis()));
            //如果停用且未输入停用理由，给予默认值
            if(organization.getStatus() == 0 && organization.getExceptionDesc().isEmpty()){
                organization.setExceptionDesc("操作员未填写停用理由");
            }
            //如果启用，设置异常描述为""
            if(organization.getStatus() ==1)
                organization.setExceptionDesc("");
            organizationService.update(organization);
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

    @RequestMapping(value = "/organization-sort")
    public String organizationSort(){
        return "pts/organization-sort";
    }

    /**
     * Description： 排序改变
     * Author: 刘永红
     * Date: Created in 2018/12/27 16:49
     */
    @RequestMapping(value = "/organization-sort-change",method = RequestMethod.POST)
    @ResponseBody
    public Response organizationSortChange(String id,Integer sort,Integer level,String op){
        Organization o = new Organization();
        Map<String,Object> map = new HashMap();
        if(op.equals("up")){
            //排序上移一位   1:查出当前level的上一个排序 2:交换
            map.put("MIN","min");
            int minSort = organizationService.getMaxSort(map);
            if(sort == minSort)
                return returnValidateError("已是当前层级第一");
            o.setLevel(level);
            o.setSort(sort-1);
            Organization preOrganization = organizationService.getOrganizationBySole(o);
            if(preOrganization == null) {
                //如果前一个序号为空
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort - 1);
                organizationService.update(thisOrganization);
            }else{
                //如果不为空
                preOrganization.setSort(sort);
                preOrganization.setId(preOrganization.getId());
                organizationService.update(preOrganization);
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort - 1);
                organizationService.update(thisOrganization);
            }
        }else if(op.equals("down")){
            //排序下移一位   1:查出当前level的下一个排序 2:交换
            map.put("MAX","max");
            int maxSort = organizationService.getMaxSort(map);
            if(sort == maxSort)
                return returnValidateError("已是当前层级最后");
            o.setLevel(level);
            o.setSort(sort+1);
            Organization preOrganization = organizationService.getOrganizationBySole(o);
            if(preOrganization == null) {
                //如果后一个序号为空
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort + 1);
                organizationService.update(thisOrganization);
            }else{
                //如果不为空
                preOrganization.setSort(sort);
                preOrganization.setId(preOrganization.getId());
                organizationService.update(preOrganization);
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort + 1);
                organizationService.update(thisOrganization);
            }
        }else if(op.equals("tofirst")){
            //设置为排序第一
        }else if(op.equals("tolast")){
            //设置为排序最后
        }
        return returnSuccess("操作成功");
    }
}
