package com.foodapp.model;

public class CartItem {

    private int menu_id;
    private int restaurant_id;
    private String item_name;
    private double price;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int menu_id, int restaurant_id, String item_name,
                    double price, int quantity) {

        this.menu_id = menu_id;
        this.restaurant_id = restaurant_id;
        this.item_name = item_name;
        this.price = price;
        this.quantity = quantity;
    }

    public int getMenu_id() {
        return menu_id;
    }

    public void setMenu_id(int menu_id) {
        this.menu_id = menu_id;
    }

    public int getRestaurant_id() {
        return restaurant_id;
    }

    public void setRestaurant_id(int restaurant_id) {
        this.restaurant_id = restaurant_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return price * quantity;
    }
}
