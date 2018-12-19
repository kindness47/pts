package com.pts.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Payment extends BaseModel{
    //支付编码
    private String paymentCode;
    //结算单编码
    private String settlementCode;
    //结算时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date paymentTime;
    //结算状态
    private Integer paymentStatus;
    //结算描述
    private String paymentRemark;
    //发票接收时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date billDeliveryTime;
    //发票接收状态
    private Integer billDeliveryStatus;
    //发票接收描述
    private String billDeliveryRemark;

    public String getPaymentCode() {
        return paymentCode;
    }

    public void setPaymentCode(String paymentCode) {
        this.paymentCode = paymentCode;
    }

    public String getSettlementCode() {
        return settlementCode;
    }

    public void setSettlementCode(String settlementCode) {
        this.settlementCode = settlementCode;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Integer getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(Integer paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentRemark() {
        return paymentRemark;
    }

    public void setPaymentRemark(String paymentRemark) {
        this.paymentRemark = paymentRemark;
    }

    public Date getBillDeliveryTime() {
        return billDeliveryTime;
    }

    public void setBillDeliveryTime(Date billDeliveryTime) {
        this.billDeliveryTime = billDeliveryTime;
    }

    public Integer getBillDeliveryStatus() {
        return billDeliveryStatus;
    }

    public void setBillDeliveryStatus(Integer billDeliveryStatus) {
        this.billDeliveryStatus = billDeliveryStatus;
    }

    public String getBillDeliveryRemark() {
        return billDeliveryRemark;
    }

    public void setBillDeliveryRemark(String billDeliveryRemark) {
        this.billDeliveryRemark = billDeliveryRemark;
    }
}
