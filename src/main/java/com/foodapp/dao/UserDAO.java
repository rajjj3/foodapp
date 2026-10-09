package com.foodapp.dao;

import com.foodapp.model.User;

public interface UserDAO {
	int addUser(User user);
	
	User fetchOneUser(String mobile);
	
	int updatePassword(String email,String password);
	
	int deleteUser(int user_id);
	
	User getUserByEmail(String email);

}
