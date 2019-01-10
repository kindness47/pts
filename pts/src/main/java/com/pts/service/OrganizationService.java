package com.pts.service;

import com.pts.model.Organization;
import com.pts.vo.OrganizationVO;

import java.util.List;
import java.util.Map;

public interface OrganizationService {
    //获取Organization
    Organization getOrganizationById(String id);
    //获取Organization
    List<OrganizationVO> getOrganizations(OrganizationVO organizationVO);
    //插入Organization
    int insert(Organization organization);
    //更新Organization
    int update(Organization organization);
    //删除机构
    int deleteOrganizationBySole(Organization organization);
    //获取数量
    int getOrganizationsCount(OrganizationVO organizationVO);

    Organization getOrganizationBySole(Organization organization);

    int getMaxSort(Map map);

    void organizationSortChange(String id,Integer sort,Integer level,String parentId,String op);
}
