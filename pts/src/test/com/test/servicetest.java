package com.test;

import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.vo.OrganizationVO;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class servicetest {

    @Test
    public void testOrganization(){
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:springconfig.xml");
        OrganizationService organizationService = (OrganizationService) ac.getBean("organizationServiceImpl");
        List<OrganizationVO> organizationList = organizationService.getOrganizations(new OrganizationVO());
        System.out.println("----------------------------"+organizationList.size());
    }
}
