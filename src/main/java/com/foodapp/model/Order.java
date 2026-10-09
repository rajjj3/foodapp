package com.foodapp.model;

import java.sql.Timestamp;

public class Order {
	private int order_id;
	private int user_id;
	private int restaurant_id;
	private double total_amount;
	private Timestamp order_date;
	private String status;
	private String payment_mode;
	
	public int getOrderId() {
		return order_id;
	}
	public void setOrderId(int orderId) {
		this.order_id = orderId;
	}
	
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int userId) {
		this.user_id = userId;
	}
	
	public int getRestaurantId() {
		return restaurant_id;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurant_id = restaurantId;
	}
	
	public double getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(double total_amount) {
		this.total_amount = total_amount;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getPayment_mode() {
		return payment_mode;
	}
	public void setPayment_mode(String payment_mode) {
		this.payment_mode = payment_mode;
	}
	
	public Order(int orderId, int userId, int restaurantId, double total_amount,Timestamp order_date, String status,String payment_mode) {
		super();
		this.order_id = orderId;
		this.user_id = userId;
		this.restaurant_id = restaurantId;
		this.total_amount = total_amount;
		this.status = status;
		this.payment_mode = payment_mode;
	}
	public Order() {
		super();
	}
	@Override
	public String toString() {
		return "Orders [orderId=" + order_id + ", userId=" + user_id + ", restaurantId=" + restaurant_id + ", total_amount=" + total_amount + ", order_date = " + order_date + ",  status=" + status +", payment_mode="
				+ payment_mode + "]";
	}
	public Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
}
