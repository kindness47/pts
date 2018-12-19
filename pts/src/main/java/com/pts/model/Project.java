package com.pts.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Project extends BaseModel{
    //组织机构id
    private String organizationId;
    //项目编码
    private String projectCode;
    //项目名称
    private String projectName;
    //供应商
    private String supplier;
    //合同签订时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date contractSignTime;
    //合同签订金额
    private Integer contractSignAmount;
    //责任人
    private String responsiblePerson;
    //剩余金额
    private Integer residueAmount;
    //是否完成 1 完成 0 未完成
    private Integer isCompletion;
    //项目类型 1 采购 2 施工
    private Integer category;

    public String getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(String organizationId) {
        this.organizationId = organizationId;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public Date getContractSignTime() {
        return contractSignTime;
    }

    public void setContractSignTime(Date contractSignTime) {
        this.contractSignTime = contractSignTime;
    }

    public Integer getContractSignAmount() {
        return contractSignAmount;
    }

    public void setContractSignAmount(Integer contractSignAmount) {
        this.contractSignAmount = contractSignAmount;
    }

    public String getResponsiblePerson() {
        return responsiblePerson;
    }

    public void setResponsiblePerson(String responsiblePerson) {
        this.responsiblePerson = responsiblePerson;
    }

    public Integer getResidueAmount() {
        return residueAmount;
    }

    public void setResidueAmount(Integer residueAmount) {
        this.residueAmount = residueAmount;
    }

    public Integer getIsCompletion() {
        return isCompletion;
    }

    public void setIsCompletion(Integer isCompletion) {
        this.isCompletion = isCompletion;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }
}
