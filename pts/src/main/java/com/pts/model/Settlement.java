package com.pts.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Settlement extends BaseModel {
    //结算单编码
    private String settlementCode;
    //订单编码
    private String orderCode;
    //结算金额
    private Integer settlementAmount;
    //结算单开立时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date settlementOpenTime;
    //结算单接收时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date settlementDeliveryTime;
    //结算单接收状态
    private Integer settlementDeliveryStatus;
    //结算单接收描述
    private String settlementDeliveryRemark;

    public String getSettlementCode() {
        return settlementCode;
    }

    public void setSettlementCode(String settlementCode) {
        this.settlementCode = settlementCode;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public Integer getSettlementAmount() {
        return settlementAmount;
    }

    public void setSettlementAmount(Integer settlementAmount) {
        this.settlementAmount = settlementAmount;
    }

    public Date getSettlementOpenTime() {
        return settlementOpenTime;
    }

    public void setSettlementOpenTime(Date settlementOpenTime) {
        this.settlementOpenTime = settlementOpenTime;
    }

    public Date getSettlementDeliveryTime() {
        return settlementDeliveryTime;
    }

    public void setSettlementDeliveryTime(Date settlementDeliveryTime) {
        this.settlementDeliveryTime = settlementDeliveryTime;
    }

    public Integer getSettlementDeliveryStatus() {
        return settlementDeliveryStatus;
    }

    public void setSettlementDeliveryStatus(Integer settlementDeliveryStatus) {
        this.settlementDeliveryStatus = settlementDeliveryStatus;
    }

    public String getSettlementDeliveryRemark() {
        return settlementDeliveryRemark;
    }

    public void setSettlementDeliveryRemark(String settlementDeliveryRemark) {
        this.settlementDeliveryRemark = settlementDeliveryRemark;
    }
}
