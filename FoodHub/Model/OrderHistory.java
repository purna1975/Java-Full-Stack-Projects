package com.tap.model;

import java.util.Date;

public class OrderHistory {
    private int orderHistoryId;
    private int orderId;
    private int userId;
    private Date date;
    private int totalAmount;
    private String status;
    private int restaurantId; 
    private String restaurantName;

    
    public OrderHistory(int orderHistoryId, int orderId, int userId, Date date, int totalAmount, String status, int restaurantId, String restaurantName) {
        this.orderHistoryId = orderHistoryId;
        this.orderId = orderId;
        this.userId = userId;
        this.date = date;
        this.totalAmount = totalAmount;
        this.status = status;
        this.restaurantId = restaurantId; 
        this.restaurantName = restaurantName;
    }

    // Getters and Setters

    public int getOrderHistoryId() {
        return orderHistoryId;
    }

    public void setOrderHistoryId(int orderHistoryId) {
        this.orderHistoryId = orderHistoryId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getRestaurantId() {
        return restaurantId; // Getter for restaurantId
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId; // Setter for restaurantId
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
}