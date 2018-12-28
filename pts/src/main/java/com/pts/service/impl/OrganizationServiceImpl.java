package com.pts.service.impl;

import com.pts.dao.OrganizationDao;
import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.vo.OrganizationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OrganizationServiceImpl implements OrganizationService {

    @Autowired
    private OrganizationDao organizationDao;

    @Override
    public Organization getOrganizationById(String id) {
        return organizationDao.getOrganizationById(id);
    }


    @Override
    public List<OrganizationVO> getOrganizations(OrganizationVO organizationVO) {
        if(organizationVO == null)
            return organizationDao.getAllOrganization();
        else
            return organizationDao.getAllOrganizationBySole(organizationVO);
    }

    @Override
    public int insert(Organization organization) {
        return organizationDao.insert(organization);
    }

    @Override
    public int update(Organization organization) {
        return organizationDao.update(organization);
    }

    @Override
    public int deleteOrganizationBySole(Organization organization) {
        return organizationDao.deleteOrganizationBySole(organization);
    }

    @Override
    public int getOrganizationsCount(OrganizationVO organizationVO) {
        return organizationDao.getOrganizationsCount(organizationVO);
    }

    @Override
    public Organization getOrganizationBySole(Organization organization) {
        return organizationDao.getOrganizationBySole(organization);
    }

    @Override
    public int getMaxSort(Map map) {
        return organizationDao.getMaxSort(map);
    }
}
