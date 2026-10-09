package com.foodapp.model;

public class OrderHistory {

    private int orderHistoryId;
    private int orderId;
    private String status;
    private String changedAt;

    public OrderHistory() {}

    public OrderHistory(int orderHistoryId, int orderId,
                        String status, String changedAt) {
        this.orderHistoryId = orderHistoryId;
        this.orderId = orderId;
        this.status = status;
        this.changedAt = changedAt;
    }

    public int getOrderHistoryId() {
        return orderHistoryId;
    }

    public void setOrderHistoryId(int orderHistoryId) {
        this.orderHistoryId = orderHistoryId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getChangedAt() {
        return changedAt;
    }

    public void setChangedAt(String changedAt) {
        this.changedAt = changedAt;
    }

    @Override
    public String toString() {
        return "OrderHistory [orderHistoryId=" + orderHistoryId +
                ", orderId=" + orderId +
                ", status=" + status +
                ", changedAt=" + changedAt + "]";
    }
}
