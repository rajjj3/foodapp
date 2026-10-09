package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.MenuDAO;
import com.foodapp.model.Menu;
import com.foodapp.util.DBConnection;

public class MenuDAOImpl
implements MenuDAO{
	
	private static final String ADD_ITEM ="INSERT INTO menu(restaurant_id,item_name,description,price,isAvailable) VALUES(?,?,?,?,?)";
	
	private static final String GET_ITEM ="SELECT * FROM menu WHERE menu_id = ?";
	
	private static final String GET_MENU_BY_RESTAURANTID ="SELECT * FROM menu WHERE restaurant_id = ?";
	
	private static final String UPDATE_ITEM ="UPDATE menu SET item_name=?, description=?, price=?, isAvailable=? WHERE menu_id=?";
	
	private static final String DELETE_ITEM ="DELETE FROM menu WHERE menu_id=?";
	
	private static final String GET_AVAILABLE_MENU ="SELECT * FROM menu WHERE restaurant_id=? AND isAvailable='true'";
	@Override
	public int addMenuItem(Menu menu) {

	    try (Connection con = DBConnection.connect();
	         PreparedStatement pstmt = con.prepareStatement(
	                 ADD_ITEM,
	                 PreparedStatement.RETURN_GENERATED_KEYS)) {

	        pstmt.setInt(1, menu.getRestaurant_id());
	        pstmt.setString(2, menu.getItem_name());
	        pstmt.setString(3, menu.getDescription());
	        pstmt.setDouble(4, menu.getPrice());
	        pstmt.setBoolean(5, menu.isAvailable());

	        int rows = pstmt.executeUpdate();

	        if (rows > 0) {
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    int generatedId = rs.getInt(1);
	                    menu.setMenuId(generatedId); 
	                    return generatedId;
	                }
	            }
	        }

	    } catch (Exception e) {
	        throw new RuntimeException("Error adding menu item", e);
	    }

	    return -1;
	}

	@Override
	public Menu getMenuById(int menuId) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(GET_ITEM)) {
			
			pstmt.setInt(1, menuId);
			
			try(ResultSet res=pstmt.executeQuery()){
				if(res.next()) {
					return mapRow(res);
				}
			}
		}catch(Exception e) {
			throw new RuntimeException("Error getting menu ", e);
		}
		return null;
	}

	@Override
	public int updateMenuItem(Menu menu) {

	    try (Connection con = DBConnection.connect();
	         PreparedStatement pstmt = con.prepareStatement(UPDATE_ITEM)) {

	        pstmt.setString(1, menu.getItem_name());
	        pstmt.setString(2, menu.getDescription());
	        pstmt.setDouble(3, menu.getPrice());
	        pstmt.setBoolean(4, menu.isAvailable());
	        pstmt.setInt(5, menu.getMenuId());

	        return pstmt.executeUpdate();

	    } catch (Exception e) {
	        throw new RuntimeException("Error updating menu item", e);
	    }
	}

	@Override
	public int deleteMenuItem(int menuId) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(DELETE_ITEM)) {
			
			pstmt.setInt(1, menuId);
		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			throw new RuntimeException("Error deleting menu item ", e);
		}
	}

	@Override
	public List<Menu> getMenuByRestaurantId(int restaurantId) {
		List<Menu> menulist =new ArrayList<>();
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(GET_MENU_BY_RESTAURANTID)) {
			
			pstmt.setInt(1, restaurantId);
			
			try(ResultSet res=pstmt.executeQuery()){
				while(res.next()) {
					menulist.add(mapRow(res));
				}
			}
		}catch(Exception e) {
			throw new RuntimeException("Error getting menu ", e);
		}
		return menulist;
	}
	
	@Override
	public List<Menu> getAvailableMenuByRestaurantId(int restaurantId){
		List<Menu> availablemenulist =new ArrayList<>();
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(GET_AVAILABLE_MENU)){
			pstmt.setInt(1, restaurantId);
			
			try(ResultSet res=pstmt.executeQuery()){
				while(res.next()) {
					availablemenulist.add(mapRow(res));
				}
			}
		}catch(Exception e) {
			throw new RuntimeException("Error fetching available menu items ", e);
		}
		
		return availablemenulist;
	}
	 private Menu mapRow(ResultSet rs) throws Exception {
	        Menu r = new Menu(
	        		rs.getInt("menu_id"),rs.getInt("restaurant_id"),rs.getString("item_name"),rs.getString("description"),rs.getDouble("price"),rs.getBoolean("isAvailable")
	        		);
	        
	        return r;
	    }
}
