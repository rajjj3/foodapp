package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.Order;

public interface OrderDAO {
	int createOrder(Order order); 
	
	Order getOrderById(int orderId);
	
	int updateOrderStatus(int orderId, String status);
	
	List<Order> getOrdersByUserId(int userId);
	
	List<Order> getOrdersByRestaurantId(int restaurantId);

}
