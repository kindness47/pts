package com.pts.dao;

import com.pts.model.Organization;
import com.pts.vo.OrganizationVO;

import java.util.List;
import java.util.Map;

public interface OrganizationDao {
    //获取Organization
    Organization getOrganizationById(String id);
    //获取所有的Organization
    List<OrganizationVO> getAllOrganization();
    //根据状态获取所有Organization
    List<OrganizationVO> getAllOrganizationBySole(OrganizationVO organizationVO);
    //插入Organization
    int insert(Organization organization);
    //更新Organization
    int update(Organization organization);
    //删除Organization
    int deleteOrganizationBySole(Organization organization);
    //获取数量
    int getOrganizationsCount(OrganizationVO organizationVO);

    Organization getOrganizationBySole(Organization organization);

    int getMaxSort(Map map);
}
