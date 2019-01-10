package com.pts.vo;

import com.pts.model.User;

import java.util.Date;

public class UserVO extends User {
    //页码
    private Integer page;
    //每页显示数量
    private Integer limit;
    //开始查询的索引
    private Integer start;
    //排序描述 Contants.SORTDESC 降序 Contants.SORTASC 升序
    private String sortDesc;

    private String startDate;

    private String endDate;

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

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public String getSortDesc() {
        return sortDesc;
    }

    public void setSortDesc(String sortDesc) {
        this.sortDesc = sortDesc;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
}
