package com.foodapp.dao;

import java.util.List;

import com.foodapp.model.Restaurant;

public interface RestaurantDAO {
	int addRestaurant(Restaurant restaurant);
	
	Restaurant getRestaurantById(int restaurantId);
	
	int updateRestaurant(String mobile,int   Rest_id);
	
	int deleteRestaurant(int restaurantId);
	
	List<Restaurant> getAllRestaurants();
	
	List<Restaurant> getActiveRestaurants();
	
	List<Restaurant> searchRestaurantByName(String name);

}
