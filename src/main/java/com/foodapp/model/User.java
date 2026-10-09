package com.foodapp.model;

public class User {
	private int user_id;
	private String username;
	private String password;
	private String email;
	private String city;
	private String mobile;
	private String role;
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", username=" + username + ", email=" + email
				+ ", city=" + city + ", mobile=" + mobile + ", role=" + role + "]";
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public User( String username, String password, String email, String city,String mobile,String role) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.city = city;
		this.mobile=mobile;
		this.role=role;
	}
	
	public User() {
		super();// will be very useful when we work with hibernate i.e to create objects[Java Bean standard] or spring
	}
}
