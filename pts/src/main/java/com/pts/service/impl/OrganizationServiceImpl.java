package com.pts.service.impl;

import com.pts.dao.OrganizationDao;
import com.pts.exceptions.OrganizationException;
import com.pts.model.Organization;
import com.pts.service.OrganizationService;
import com.pts.vo.OrganizationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Iterator;
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

    @Override
    public void organizationSortChange(String id, Integer sort, Integer level, String parentId, String op) {
        Organization o = new Organization();
        Map<String,Object> map = new HashMap();
        if(op.equals("up")){
            //排序上移一位   1:查出当前level和相同parentId的上一个排序 2:序号变更
            //查出当前level且parentId相同的对象中最小序号
            map.put("MIN","min");
            map.put("level",level);
            map.put("parentId",parentId);
            int minSort = organizationDao.getMaxSort(map);

            if(sort == minSort)
                throw new OrganizationException("已是当前层级第一");
            //如果更小序号存在，则查询比当前操作对象序号小1的organization对象
            o.setLevel(level);
            o.setSort(sort-1);
            o.setParentId(parentId);
            Organization preOrganization = organizationDao.getOrganizationBySole(o);
            if(preOrganization == null) {
                //如果更小序号存在且前一个序号为空 , 则更新现在的序号-1 例如  1 2 4 5 , 4 前移 , 更改为 1 2 3 5
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort - 1);
                organizationDao.update(thisOrganization);
            }else{
                //如果更小序号存在且前一个序号不为空 , 则更新上一个对象序号+1 , 当前对象序号-1
                //更新上一个对象序号为当前对象序号 , 即上一个对象序号+1
                preOrganization.setSort(sort);
                preOrganization.setId(preOrganization.getId());
                organizationDao.update(preOrganization);
                //更新当前操作对象序号-1
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort - 1);
                organizationDao.update(thisOrganization);
            }
        }else if(op.equals("down")){
            //排序下移一位   1:查出当前level和想通parentId的下一个排序 2:序号变更
            //查出当前level且parentId相同的对象中最大序号
            map.put("MAX","max");
            map.put("level",level);
            map.put("parentId",parentId);
            int maxSort = organizationDao.getMaxSort(map);

            if(sort == maxSort)
                throw new OrganizationException("已是当前层级最后");
            //如果存在比当前操作对象序号更大的对象序号，则查询比当前操作对象序号大1的organization对象
            o.setLevel(level);
            o.setSort(sort+1);
            o.setParentId(parentId);
            Organization nextOrganization = organizationDao.getOrganizationBySole(o);
            if(nextOrganization == null) {
                //如果后一个序号为空
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort + 1);
                organizationDao.update(thisOrganization);
            }else{
                //如果不为空 1:当前对象序号+1 2:后一个对象序号-1
                //更新下一个对象,下一个对象序号-1,即为当前序号
                nextOrganization.setSort(sort);
                nextOrganization.setId(nextOrganization.getId());
                organizationDao.update(nextOrganization);
                //更新当前对象,序号+1
                Organization thisOrganization = new Organization();
                thisOrganization.setId(id);
                thisOrganization.setSort(sort + 1);
                Organization ooo = new Organization();
                organizationDao.update(thisOrganization);
            }
        }else if(op.equals("tofirst")){
            //设置为排序第一
            map.put("MIN","min");
            map.put("level",level);
            map.put("parentId",parentId);
            int minSort = organizationDao.getMaxSort(map);
            if(sort == minSort)
                throw new OrganizationException("已是当前层级第一");

            //     查询所有当前层级相同parentId的organization对象，并对连续的organization的sort+1，直到下一个sort不是连续
            OrganizationVO oVO = new OrganizationVO();
            oVO.setLevel(level);
            oVO.setParentId(parentId);
            List<OrganizationVO> organizationVOList = organizationDao.getAllOrganizationBySole(oVO);
            //移除当前操作的organization对象
            Iterator iterator = organizationVOList.iterator();
            while(iterator.hasNext()){
                OrganizationVO organizationVO = (OrganizationVO) iterator.next();
                if(organizationVO.getId().equals(id))
                    iterator.remove();
            }
            //需要更新的sort
            int nextSort = 1;
            for(OrganizationVO organizationVO : organizationVOList){
                if(organizationVO.getSort() == nextSort) {
                    //存在当前序号需要变更的organization;更新organization
                    o.setId(organizationVO.getId());
                    nextSort++;
                    o.setSort(nextSort);
                    organizationDao.update(o);
                }else
                    break;
            }
            o.setId(id);
            o.setSort(1);
            organizationDao.update(o);
        }else if(op.equals("tolast")){
            //设置为排序最后
            map.put("MAX","max");
            map.put("level",level);
            map.put("parentId",parentId);
            int maxSort = organizationDao.getMaxSort(map);
            if(sort == maxSort)
                throw new OrganizationException("已是当前层级最后");
            //     查询所有当前层级 organization对象，并对连续的organization的sort+1，知道下一个sort不是连续
            OrganizationVO oVO = new OrganizationVO();
            oVO.setLevel(level);
            oVO.setParentId(parentId);
            List<OrganizationVO> organizationVOList = organizationDao.getAllOrganizationBySole(oVO);

            //移除当前organization
            oVO.setId(id);
            Iterator iterator = organizationVOList.iterator();
            while(iterator.hasNext()){
                OrganizationVO organizationVO = (OrganizationVO) iterator.next();
                if(organizationVO.getId().equals(id))
                    iterator.remove();
            }
            //需要更新的sort
            int nextSort = 1;
            for(OrganizationVO organizationVO : organizationVOList){
                if(organizationVO.getSort() != nextSort) {
                    //当前序号的organization需要变更
                    o.setId(organizationVO.getId());
                    o.setSort(nextSort);
                    organizationDao.update(o);
                }
                nextSort++;
            }
            o.setId(id);
            o.setSort(nextSort);
            organizationDao.update(o);
        }
    }
}
