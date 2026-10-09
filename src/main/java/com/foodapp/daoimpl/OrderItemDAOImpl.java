package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderItemDAO;
import com.foodapp.model.OrderItem;
import com.foodapp.util.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String ADD_ORDER_ITEM = "INSERT INTO order_item(order_id,menu_id,quantity,item_total) VALUES(?,?,?,?)";

    private static final String GET_ITEMS = "SELECT * FROM order_item WHERE order_id=?";

    private static final String DELETE_ORDER_ITEM = "DELETE FROM order_item WHERE order_id=?";

    private static final String GET_MENU_PRICE = "SELECT price FROM menu WHERE menu_id=?";


    @Override
    public int addOrderItem(OrderItem item) {

        try (Connection con = DBConnection.connect()) {

            double menuPrice = 0;

            // Step 1: fetch menu price
            try (PreparedStatement priceStmt =
                     con.prepareStatement(GET_MENU_PRICE)) {

                priceStmt.setInt(1, item.getMenu_id());

                try (ResultSet rs = priceStmt.executeQuery()) {
                    if (rs.next()) {
                        menuPrice = rs.getDouble("price"); // ✅ FIXED
                    } else {
                        throw new RuntimeException("Menu item not found");
                    }
                }
            }

            // Step 2: calculate total
            double itemTotal = menuPrice * item.getQuantity();
            item.setItems_total(itemTotal); // ⭐ good practice

            // Step 3: insert order item
            try (PreparedStatement insertStmt =
                     con.prepareStatement(
                         ADD_ORDER_ITEM,
                         PreparedStatement.RETURN_GENERATED_KEYS)) {

                insertStmt.setInt(1, item.getOrder_id());
                insertStmt.setInt(2, item.getMenu_id());
                insertStmt.setInt(3, item.getQuantity());
                insertStmt.setDouble(4, itemTotal);

                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    try (ResultSet rs = insertStmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            int generatedId = rs.getInt(1);
                            item.setOrder_item_id(generatedId);
                            return generatedId; // ⭐ return new id
                        }
                    }
                }

            }

        } catch (Exception e) {
            throw new RuntimeException("Error while adding order item", e);
        }

        return -1;
    }

    @Override
    public List<OrderItem> getItemsByOrderId(int orderId) {
        List<OrderItem> orderitemlist = new ArrayList<>();

        try (Connection con = DBConnection.connect();
             PreparedStatement pstmt = con.prepareStatement(GET_ITEMS)) {

            pstmt.setInt(1, orderId);

            try (ResultSet res = pstmt.executeQuery()) {
                while (res.next()) {
                    orderitemlist.add(mapRow(res));
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Error while fetching order item", e);
        }

        return orderitemlist;
    }


    @Override
    public int deleteOrderItemsByOrderId(int orderId) {
        try (Connection con = DBConnection.connect();
             PreparedStatement pstmt = con.prepareStatement(DELETE_ORDER_ITEM)) {

            pstmt.setInt(1, orderId);
            return pstmt.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Error deleting order items", e);
        }
    }


    public OrderItem mapRow(ResultSet res) throws SQLException {
        return new OrderItem(
                res.getInt("order_item_id"),
                res.getInt("order_id"),
                res.getInt("menu_id"),
                res.getInt("quantity"),
                res.getDouble("item_total")
        );
    }
}
