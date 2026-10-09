package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.Menu;

public interface MenuDAO {
	int addMenuItem(Menu menu);
	
	Menu getMenuById(int menuId);
	
	int updateMenuItem(Menu menu);
	
	int deleteMenuItem(int menuId);
	
	List<Menu> getMenuByRestaurantId(int restaurantId);

	List<Menu> getAvailableMenuByRestaurantId(int restaurant_id);
}
