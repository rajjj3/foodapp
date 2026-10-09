package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.model.Restaurant;
import com.foodapp.util.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO{
	private static final String ADD_QUERY = "INSERT INTO restaurant(name,address,mobile,rating,isActive,cuisineType) VALUES(?,?,?,?,?,?)";
	
	private static final String GET_RESTAURANT_QUERY = "SELECT * FROM restaurant WHERE restaurant_id = ?";
	
	private static final String UPDATE_MOBILE = "UPDATE restaurant SET mobile=? WHERE restaurant_id=?";
	
	private static final String DELETE_QUERY = "DELETE FROM restaurant WHERE restaurant_id=?";
	
	@Override
	public int addRestaurant(Restaurant restaurant) {

	    try (Connection con = DBConnection.connect();
	         PreparedStatement pstmt = con.prepareStatement(ADD_QUERY,
	                 PreparedStatement.RETURN_GENERATED_KEYS)) {

	        pstmt.setString(1, restaurant.getName());
	        pstmt.setString(2, restaurant.getAddress());
	        pstmt.setString(3, restaurant.getMobile());
	        pstmt.setFloat(4, restaurant.getRating());
	        pstmt.setBoolean(5, restaurant.isActive());
	        pstmt.setString(6, restaurant.getCuisineType());

	        int rows = pstmt.executeUpdate();

	        if (rows > 0) {
	            try (ResultSet rs = pstmt.getGeneratedKeys()) {
	                if (rs.next()) {
	                    int id = rs.getInt(1);
	                    restaurant.setRestaurant_id(id);
	                    return id;
	                }
	            }
	        }

	    } catch (Exception e) {
	        throw new RuntimeException("Error registering restaurant ", e);
	    }

	    return -1;
	}

	@Override
	public Restaurant getRestaurantById(int restaurantId) {
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(GET_RESTAURANT_QUERY)) {
			
			pstmt.setInt(1, restaurantId);
			try(ResultSet res = pstmt.executeQuery()){
				if(res.next()) {
					return mapRow(res);
				}
			}
		}catch(Exception e) {
			throw new RuntimeException("Error getting Restaurent data ", e);
		}
		return null;
	}
	@Override
	public int updateRestaurant(String mobile,int Rest_id) {
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(UPDATE_MOBILE)) {
			
			pstmt.setString(1, mobile);
			pstmt.setInt(2, Rest_id); 
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			throw new RuntimeException("Error getting Restaurent data ", e);
		}
	}

	@Override
	public int deleteRestaurant(int restaurantId) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(DELETE_QUERY)) {
			
			pstmt.setInt(1, restaurantId); 
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			throw new RuntimeException("Error getting Restaurent data ", e);
		}
	}
	
    private Restaurant mapRow(ResultSet rs) throws Exception {
        Restaurant r = new Restaurant();
        r.setRestaurant_id(rs.getInt("restaurant_id"));
        r.setName(rs.getString("name"));
        r.setAddress(rs.getString("address"));
        r.setMobile(rs.getString("mobile"));
        r.setRating(rs.getFloat("rating"));
        r.setActive(rs.getBoolean("isActive"));
        r.setCuisineType(rs.getString("cuisineType"));
        r.setImageData(rs.getString("imageData"));
        return r;
    }

    // 🔷 1. Get All Restaurants
    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurant";

        try (Connection con = DBConnection.connect();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            throw new RuntimeException("Error getting all restaurants ", e);
        }

        return list;
    }

    // 🔷 2. Get Active Restaurants
    @Override
    public List<Restaurant> getActiveRestaurants() {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurant WHERE isActive = true";

        try (
            Connection con = DBConnection.connect();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching active restauarants ",e);
        }

        return list;
    }

    // 🔷 3. Search Restaurant By Name
    @Override
    public List<Restaurant> searchRestaurantByName(String name) {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurant WHERE name LIKE ?";

        try (
            Connection con = DBConnection.connect();
            PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setString(1, "%" + name + "%");

            try(ResultSet rs = ps.executeQuery()) {

            	while (rs.next()) {
            		list.add(mapRow(rs));
            	}
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching restaurant by name ",e);
        }

        return list;
    }
}
