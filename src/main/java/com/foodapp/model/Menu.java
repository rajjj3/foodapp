package com.foodapp.model;

public class Menu {
	int menu_id;
	int restaurant_id;
	String item_name;
	String description;
	double price;
	boolean isAvailable;
	
	public int getMenuId() {
		return menu_id;
	}
	public void setMenuId(int menu_id) {
		this.menu_id = menu_id;
	}
	
	public int getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(int restaurent_id) {
		this.restaurant_id = restaurent_id;
	}
	
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
	public boolean isAvailable() {
		return isAvailable;
	}
	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}
	
	public Menu(int menu_id, int restaurant_id, String item_name, String description, double price, boolean isAvailable) {
		super();
		this.menu_id = menu_id;
		this.restaurant_id = restaurant_id;
		this.item_name = item_name;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
	}
	
	public Menu() {
		super();
	}
	@Override
	public String toString() {
		return "Menu [menu_id=" + menu_id + ", restaurant_id=" + restaurant_id + ", item_name=" + item_name
				+ ", description=" + description + ", price=" + price + ", isAvailable=" + isAvailable + "]";
	}
}
