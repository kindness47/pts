package com.pts.controller;

import com.mysql.cj.util.StringUtils;
import com.pts.base.Constants;
import com.pts.base.Response;
import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.util.SystemUtil;
import com.pts.vo.OrganizationVO;
import org.apache.ibatis.binding.BindingException;
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
            organizationVO.setLimit(Constants.SIZE);
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
        if(StringUtils.isNullOrEmpty(organization.getId())){
            //新增
            if(StringUtils.isNullOrEmpty(organization.getOrganizationName()))
                return returnValidateError("机构名不能为空");
            if(StringUtils.isNullOrEmpty(organization.getOrganizationShortName()))
                return  returnValidateError("机构简称不能为空");

            if(!StringUtils.isNullOrEmpty(organization.getParentId())){
                //添加的不为一级
                Organization parentOrganization = organizationService.getOrganizationById(organization.getParentId());
                System.out.println("---------------------------------");
                System.out.println(parentOrganization.getLevel());
                switch (parentOrganization.getLevel()){
                    case 1: organization.setLevel(Constants.LEVEL2); break;
                    case 2: organization.setLevel(Constants.LEVEL3); break;
                    case 3: return  returnValidateError("最都只能三级目录");
                }
            }else{
                //添加的为一级
                organization.setLevel(Constants.LEVEL1);
                organization.setParentId("0");
            }

            //查询当前最大sort   ，并将新插入的sort设置为最大+1
            Map<String,Object> map = new HashMap();
            map.put("MAX","max");
            map.put("level",organization.getLevel());
            map.put("parentId",organization.getParentId());
            int maxSort;
            try {
                maxSort = organizationService.getMaxSort(map);
            }catch (BindingException e){
                maxSort = 0;
            }catch (Exception e){
                return returnValidateError("新增失败");
            }

            organization.setId(UUID.randomUUID().toString().replace("-",""));
            organization.setSort(maxSort+1);
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
            //查询修改前信息
            Organization oldOrganization = organizationService.getOrganizationById(organization.getId());

            if (oldOrganization.getLevel() == Constants.LEVEL1 || oldOrganization.getParentId().equals("0"))
                return returnValidateError("一级目录不允许修改");
            if(StringUtils.isNullOrEmpty(organization.getParentId())){
                //修改为一级目录
                Map<String,Object> map = new HashMap<>();
                map.put("MAX","max");
                map.put("level",Constants.LEVEL1);
                map.put("parentId","0");
                int maxSort;
                try {
                    maxSort = organizationService.getMaxSort(map);
                }catch (BindingException e){
                    maxSort = 0;
                }catch (Exception e){
                    return returnValidateError("修改失败");
                }
                organization.setParentId("0");
                organization.setLevel(Constants.LEVEL1);
                organization.setSort(maxSort+1);
            }else {
                //修改后不是一级目录
                //父元素信息
                Organization parentOrganization = organizationService.getOrganizationById(organization.getParentId());
                if (!oldOrganization.getParentId().equals(organization.getParentId())) {

                    Map<String, Object> map = new HashMap<>();
                    map.put("MAX", "max");
                    map.put("level", parentOrganization.getLevel() + 1);
                    map.put("parentId",organization.getParentId());
                    int maxSort;
                    try {
                        maxSort = organizationService.getMaxSort(map);
                    } catch (BindingException e) {
                        maxSort = 0;
                    } catch (Exception e) {
                        return returnValidateError("修改失败");
                    }
                    organization.setLevel(parentOrganization.getLevel()+1);
                    organization.setSort(maxSort + 1);
                }
            }
            //判断其子目录下是否有organization  ,有则更新子目录level
            OrganizationVO oVO = new OrganizationVO();
            oVO.setParentId(organization.getId());
            List<OrganizationVO> organizationVOList = organizationService.getOrganizations(oVO);
            if(organizationVOList.size() > 0) {
                Organization o1 = new Organization();
                for (OrganizationVO organizationVO : organizationVOList) {
                    o1.setId(organizationVO.getId());
                    o1.setLevel(organization.getLevel() + 1);
                    organizationService.update(o1);
                }
            }

            organization.setUpdateBy(SystemUtil.getLoginUser());
            organization.setUpdateTime(new Date(System.currentTimeMillis()));
            //如果停用且未输入停用理由，给予默认值
            if(organization.getStatus() != null) {
                //修改状态
                if (organization.getStatus() == 0 && organization.getExceptionDesc().isEmpty()) {
                    organization.setExceptionDesc("操作员未填写停用理由");
                }
                //如果启用，设置异常描述为""
                if (organization.getStatus() == 1)
                    organization.setExceptionDesc("");
            }

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
        Organization o = new Organization();
        o.setId(id);
        int i = organizationService.deleteOrganizationBySole(o);
        return i>0?returnSuccess("删除成功"):returnValidateError("删除失败");
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
            map.put("level",level);
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
            map.put("level",level);
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
                Organization ooo = new Organization();
                organizationService.update(thisOrganization);
            }
        }else if(op.equals("tofirst")){
            //设置为排序第一
            map.put("MIN","min");
            map.put("level",level);
            int minSort = organizationService.getMaxSort(map);
            if(sort == minSort)
                return returnValidateError("已是当前层级第一");

            //     查询所有当前层级 organization对象，并对连续的organization的sort+1，知道下一个sort不是连续
            OrganizationVO oVO = new OrganizationVO();
            oVO.setLevel(level);
            List<OrganizationVO> organizationVOList = organizationService.getOrganizations(oVO);
            //需要更新的sort
            int nextSort = 1;
            for(OrganizationVO organizationVO : organizationVOList){
                if(organizationVO.getSort() == nextSort) {
                    //存在当前序号需要变更的organization;更新organization
                    o.setId(organizationVO.getId());
                    nextSort++;
                    o.setSort(nextSort);
                    organizationService.update(o);
                }else
                    break;
            }
            o.setId(id);
            o.setSort(1);
            organizationService.update(o);
        }else if(op.equals("tolast")){
            //设置为排序最后
            map.put("MAX","max");
            map.put("level",level);
            int maxSort = organizationService.getMaxSort(map);
            if(sort == maxSort)
                return returnValidateError("已是当前层级最后");
            //     查询所有当前层级 organization对象，并对连续的organization的sort+1，知道下一个sort不是连续
            OrganizationVO oVO = new OrganizationVO();
            oVO.setLevel(level);
            List<OrganizationVO> organizationVOList = organizationService.getOrganizations(oVO);

            //移除当前organization
            oVO.setId(id);
            Iterator iterator = organizationVOList.iterator();
            while(iterator.hasNext()){
                OrganizationVO organizationVO = (OrganizationVO) iterator.next();
                if(organizationVO.getId().equals(id))
                    iterator.remove();
            }

            System.out.println("-----------------------------------");
            for (OrganizationVO organizationVO :organizationVOList)
                System.out.println("-------------"+organizationVO.getOrganizationName()+"--->"+organizationVO.getSort());

            //需要更新的sort
            int nextSort = 1;
            for(OrganizationVO organizationVO : organizationVOList){
                if(organizationVO.getSort() != nextSort) {
                    //当前序号的organization需要变更
                    o.setId(organizationVO.getId());
                    o.setSort(nextSort);
                    organizationService.update(o);
                }
                nextSort++;
            }
            o.setId(id);
            o.setSort(nextSort);
            organizationService.update(o);
        }
        return returnSuccess("操作成功");
    }
}
