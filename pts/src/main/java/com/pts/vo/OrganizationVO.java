package com.pts.vo;

import com.pts.model.Organization;
/**
 * Description： 组织机构VO对象
 * Author: 刘永红
 * Date: Created in 2018/12/7 15:47
 */
public class OrganizationVO extends Organization {
    //父节点名称
    private String parentName;
    //父节点名称简称
    private String parentShortName;
    //页码
    private Integer page;
    //每页显示数量
    private Integer limit;
    //开始查询的索引
    private Integer start;
    //排序描述 Contants.SORTDESC 降序 Contants.SORTASC 升序
    private String sortDesc;

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getParentShortName() {
        return parentShortName;
    }

    public void setParentShortName(String parentShortName) {
        this.parentShortName = parentShortName;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public String getSortDesc() {
        return sortDesc;
    }

    public void setSortDesc(String sortDesc) {
        this.sortDesc = sortDesc;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }
}
