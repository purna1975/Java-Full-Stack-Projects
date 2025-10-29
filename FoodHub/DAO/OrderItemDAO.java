package com.tap.dao;

import java.util.List;
import com.tap.model.OrderItem;

public interface OrderItemDAO {
	int insertOrderItem(int orderId, int menuId, int quantity, double totalAmount);
    void addOrderItem(OrderItem oi);
    OrderItem getOrderItem(int orderItemId);
    void updateOrderItem(OrderItem oi);
    void deleteOrderItem(int orderItemId);
    List<OrderItem> getAllOrderItems();
    List<OrderItem> fetchOrderItemsByOrderId(int orderId);
}