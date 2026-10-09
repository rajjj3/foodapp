package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.foodapp.dao.UserDAO;
import com.foodapp.model.User;
import com.foodapp.util.DBConnection;
import com.foodapp.util.SecureData;

public class UserDAOImpl implements UserDAO {
	
	private static final String ADD_USER = "INSERT INTO USER(username,password,email,city,mobile,role) VALUES(?,?,?,?,?,?)";
	
	private static final String FETCH_ONE_USER = "SELECT * FROM USER WHERE mobile=?";
	
	private static final String CHANGE_PASSWORD = "UPDATE USER SET password = ? WHERE email=?";
	
	private static final String DELETE_USER ="DELETE FROM USER WHERE user_id=?";
	
	private static final String FETCH_BY_EMAIL = "SELECT * FROM USER WHERE email = ?";
	
	@Override
	public int addUser(User user)  {
		
		try(Connection con=DBConnection.connect(); 
				PreparedStatement pstmt=con.prepareStatement(ADD_USER,PreparedStatement.RETURN_GENERATED_KEYS)){
			pstmt.setString(1, SecureData.encrypt(user.getUsername()));
			pstmt.setString(2, SecureData.encrypt(user.getPassword()));
			pstmt.setString(3, SecureData.encrypt(user.getEmail()));
			pstmt.setString(4, SecureData.encrypt(user.getCity()));
			pstmt.setString(5, SecureData.encrypt(user.getMobile()));
			pstmt.setString(6, SecureData.encrypt(user.getRole()));
			int rows= pstmt.executeUpdate();
			if(rows>0) {
				try(ResultSet res=pstmt.getGeneratedKeys()) {
					if(res.next()) {
						int generatedId=res.getInt(1);
						user.setUser_id(generatedId);
						return generatedId;
					}
				}
			}
			
		}catch(Exception e) {
			throw new RuntimeException("Error while adding a user", e);
		}
		return -1;
	}
	

	@Override
	public User fetchOneUser(String mobile) {
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(FETCH_ONE_USER)){
			
			pstmt.setString(1, SecureData.encrypt(mobile));
			
			try(ResultSet res=pstmt.executeQuery()) {
				if(res.next()) {
					return mapRow(res);
				}
			}
		}
		catch(Exception e) {
			throw new RuntimeException("Error fetching user data ", e);
		}
		return null;
	}
	
	@Override
	public int updatePassword(String email,String password) {
		
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(CHANGE_PASSWORD)){
			
			pstmt.setString(1, SecureData.encrypt(password));
			pstmt.setString(2, SecureData.encrypt(email));
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new RuntimeException("Error updating password ", e);
			
		}
	}

	@Override
	public int deleteUser(int user_id) {
		try(Connection con=DBConnection.connect();
				PreparedStatement pstmt=con.prepareStatement(DELETE_USER)){
			
			pstmt.setInt(1, user_id);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new RuntimeException("Error deleting user ", e);
		}
	}

	@Override
	public User getUserByEmail(String email) {

	    try (Connection con = DBConnection.connect();
	         PreparedStatement pstmt = con.prepareStatement(FETCH_BY_EMAIL)) {

	        pstmt.setString(1, SecureData.encrypt((email)));

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                return mapRow(rs);
	            }
	        }

	    } catch (Exception e) {
	        throw new RuntimeException("Error fetching user by email", e);
	    }

	    return null;
	}

	
	private User mapRow(ResultSet rs) throws SQLException {

	    User user = new User(
	        SecureData.decrypt(rs.getString("username")),
	        SecureData.decrypt(rs.getString("password")),
	        SecureData.decrypt(rs.getString("email")),
	        SecureData.decrypt(rs.getString("city")),
	        SecureData.decrypt(rs.getString("mobile")),
	        SecureData.decrypt(rs.getString("role"))
	    );

	    user.setUser_id(rs.getInt("user_id"));

	    return user;
	}

	
}
