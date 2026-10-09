package com.foodapp.dao;

import java.util.List;
import com.foodapp.model.OrderHistory;

public interface OrderHistoryDAO {

    int addHistory(int orderId, String status);

    List<OrderHistory> getHistoryByOrderId(int orderId);
}
