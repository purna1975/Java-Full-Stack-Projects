package com.tap.dao;

import com.tap.model.OrderHistory;
import java.util.List;

public interface OrderHistoryDAO {

    // Insert a new OrderHistory with additional fields, including restaurantId
    int insertOrderHistory(int orderId, int userId, java.util.Date date, int totalAmount, String status, int restaurantId);

    // Fetch OrderHistory by User ID, including restaurantId
    List<OrderHistory> fetchOrderHistoryByUserId(int userId);
}