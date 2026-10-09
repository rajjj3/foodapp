package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderDAO;
import com.foodapp.model.Order;
import com.foodapp.util.DBConnection;

public class OrderDAOImpl implements OrderDAO{
	private static final String CREATE_ORDER ="INSERT INTO orders(user_id,restaurant_id,total_amount,status,payment_mode) VALUES(?,?,?,?,?)";
	
	private static final String UPDATE_STATUS = "UPDATE orders SET status=? WHERE order_id=?";

	private static final String FETCH_ORDER ="SELECT order_id, user_id, restaurant_id, total_amount,"
			+ "order_date, status, payment_mode FROM orders WHERE order_id=?";
	
	private static final String FETCH_ORDER_BY_USER_ID = "SELECT order_id, user_id, restaurant_id, total_amount,"
			+ "order_date, status, payment_mode FROM orders WHERE user_id=?";
	
	private static final String FETCH_ORDER_BY_RESTAURANT_ID = "SELECT order_id, user_id, restaurant_id, total_amount,order_date, status,"
			+ "payment_mode FROM orders WHERE restaurant_id=?";
	
	
	@Override
	public int createOrder(Order order) {
 
	    try (Connection con = DBConnection.connect();
	         PreparedStatement pstmt = con.prepareStatement(CREATE_ORDER,
	                 PreparedStatement.RETURN_GENERATED_KEYS)) {

	        pstmt.setInt(1, order.getUserId());
	        pstmt.setInt(2, order.getRestaurantId());
	        pstmt.setDouble(3, order.getTotal_amount());
	        pstmt.setString(4, order.getStatus());
	        pstmt.setString(5, order.getPayment_mode());

	        int rows = pstmt.executeUpdate();

	        if (rows > 0) {
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    int generatedId = rs.getInt(1);
	                    order.setOrderId(generatedId);  
	                    return generatedId;              
	                }
	            }
	        }

	    } catch (Exception e) {
	        throw new RuntimeException("error creating an order", e);
	    }

	    return -1;
	}


	@Override
	public Order getOrderById(int orderId) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(FETCH_ORDER)){
			pstmt.setInt(1, orderId);
			
			try(ResultSet res=pstmt.executeQuery()){
				if(res.next()) {
					return mapRow(res);
				}
			}
		}
		catch(Exception e) {
			throw new RuntimeException("Error fetching order ",e);
		}
		return null;
	}

	@Override
	public int updateOrderStatus(int orderId, String status) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(UPDATE_STATUS)){
			pstmt.setString(1,status);
			pstmt.setInt(2, orderId);
			
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			throw new RuntimeException("Error updating order status ",e);
		}
		
	}

	@Override
	public List<Order> getOrdersByUserId(int userId) {
		List<Order> orderlist = new ArrayList<>();
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(FETCH_ORDER_BY_USER_ID)){
			pstmt.setInt(1,userId);
			
			try(ResultSet res=pstmt.executeQuery()){
				while(res.next()) {
					orderlist.add(mapRow(res));
				}
			}
		}
		catch(Exception e) {
			throw new RuntimeException("Error fetching orders by user ",e);
		}
		return orderlist;
	}

	@Override
	public List<Order> getOrdersByRestaurantId(int restaurantId) {
		List<Order> orderlist = new ArrayList<>();
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(FETCH_ORDER_BY_RESTAURANT_ID)){
			pstmt.setInt(1,restaurantId);
			
			try(ResultSet res=pstmt.executeQuery()){
				while(res.next()) {
					orderlist.add(mapRow(res));
				}
			}
		}
		catch(Exception e) {
			throw new RuntimeException("Error fetching orders by restaurant ",e);
		}
		return orderlist;
	}
	
	
	public Order mapRow(ResultSet res) throws SQLException {
	    return new Order(
	        res.getInt("order_id"),
	        res.getInt("user_id"),
	        res.getInt("restaurant_id"),
	        res.getDouble("total_amount"),
	        res.getTimestamp("order_date"),
	        res.getString("status"),
	        res.getString("payment_mode"));
	}

	
}
