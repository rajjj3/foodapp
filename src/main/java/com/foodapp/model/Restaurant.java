package com.foodapp.model;

public class Restaurant {
	int restaurant_id;
	String name;
	String address;
	String mobile;
	float rating;
	boolean isActive;
	String cuisine;
	String imageData;
	
	public int getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(int restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) { 
		this.address = address;
	}
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	
	
	public String getCuisineType() {
		return cuisine;
	}
	public void setCuisineType(String cuisine) {
		this.cuisine = cuisine;
	}
	public void setImageData(String imageData) {
		this.imageData = imageData;
	}
	public String getImageData() {
		return imageData;
	}
	
	public Restaurant(int restaurent_id, String name, String address, String mobile, float rating, boolean isActive,String cuisine,String imageData) {
		super();
		this.restaurant_id = restaurent_id;
		this.name = name;
		this.address = address;
		this.mobile = mobile;
		this.rating = rating;
		this.isActive = isActive;
		this.cuisine = cuisine;
		this.imageData = imageData;
	}
	
	public Restaurant() {
		super();
	}
	@Override
	public String toString() {
		return "Restaurant [restaurant_id=" + restaurant_id + ", name=" + name + ", address=" + address + ", mobile="
				+ mobile + ", rating=" + rating + ", isActive=" + isActive + ",cuisine="+ cuisine +", imageurl=" + imageData +"]";
	}
	
}
