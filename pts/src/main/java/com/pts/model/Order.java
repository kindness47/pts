package com.pts.model;

public class Order extends BaseModel {
    //订单编码
    private String orderCode;
    //项目编码
    private String projectCode;
    //订单描述
    private String orderDesc;
    //订单金额
    private Integer orderAmount;
    //订单剩余未结算金额
    private Integer residueAmount;
    //订单质量 1 好 2 不好
    private Integer qualityStatus;
    //质量标注
    private String qualityRemark;
    //服务状态 1 好 2 不好
    private Integer service;
    //服务描述
    private String serviceRemark;

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getOrderDesc() {
        return orderDesc;
    }

    public void setOrderDesc(String orderDesc) {
        this.orderDesc = orderDesc;
    }

    public Integer getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(Integer orderAmount) {
        this.orderAmount = orderAmount;
    }

    public Integer getResidueAmount() {
        return residueAmount;
    }

    public void setResidueAmount(Integer residueAmount) {
        this.residueAmount = residueAmount;
    }

    public Integer getQualityStatus() {
        return qualityStatus;
    }

    public void setQualityStatus(Integer qualityStatus) {
        this.qualityStatus = qualityStatus;
    }

    public String getQualityRemark() {
        return qualityRemark;
    }

    public void setQualityRemark(String qualityRemark) {
        this.qualityRemark = qualityRemark;
    }

    public Integer getService() {
        return service;
    }

    public void setService(Integer service) {
        this.service = service;
    }

    public String getServiceRemark() {
        return serviceRemark;
    }

    public void setServiceRemark(String serviceRemark) {
        this.serviceRemark = serviceRemark;
    }
}
