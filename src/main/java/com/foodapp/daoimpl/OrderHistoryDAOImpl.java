package com.foodapp.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.dao.OrderHistoryDAO;
import com.foodapp.model.OrderHistory;
import com.foodapp.util.DBConnection;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {

    private static final String INSERT_HISTORY =
        "INSERT INTO ORDER_HISTORY(order_id,status) VALUES(?,?)";

    private static final String FETCH_BY_ORDER_ID =
        "SELECT * FROM ORDER_HISTORY WHERE order_id=? ORDER BY changed_at";


    @Override
    public int addHistory(int orderId, String status) {

        try (Connection con = DBConnection.connect();
             PreparedStatement pstmt = con.prepareStatement(INSERT_HISTORY)) {

            pstmt.setInt(1, orderId);
            pstmt.setString(2, status);

            return pstmt.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("Error adding order history", e);
        }
    }


    @Override
    public List<OrderHistory> getHistoryByOrderId(int orderId) {

        List<OrderHistory> list = new ArrayList<>();

        try (Connection con = DBConnection.connect();
             PreparedStatement pstmt = con.prepareStatement(FETCH_BY_ORDER_ID)) {

            pstmt.setInt(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching order history", e);
        }

        return list;
    }


    private OrderHistory mapRow(ResultSet rs) throws Exception {
        return new OrderHistory(
                rs.getInt("order_history_id"),
                rs.getInt("order_id"),
                rs.getString("status"),
                rs.getString("changed_at")
        );
    }
}
