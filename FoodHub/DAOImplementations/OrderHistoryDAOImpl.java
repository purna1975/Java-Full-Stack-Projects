package com.tap.daoimpl;

import com.tap.dao.OrderHistoryDAO;
import com.tap.model.OrderHistory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {

    private static Connection con;
    private PreparedStatement pstmt;
    private static ResultSet resultSet;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodapp", "root", "Mahesh@123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int insertOrderHistory(int orderId, int userId, java.util.Date date, int totalAmount, String status, int restaurantId) {
        String insertQuery = "INSERT INTO OrderHistory (orderId, userId, date, totalAmount, status, restaurantId) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            pstmt = con.prepareStatement(insertQuery);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, userId);
            pstmt.setDate(3, new java.sql.Date(date.getTime()));
            pstmt.setInt(4, totalAmount);
            pstmt.setString(5, status);
            pstmt.setInt(6, restaurantId); // Add restaurantId to the query
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public List<OrderHistory> fetchOrderHistoryByUserId(int userId) {
        List<OrderHistory> orderHistoryList = new ArrayList<>();
        String fetchQuery = """
        	    SELECT oh.orderHistoryId, oh.orderId, oh.userId, oh.date, oh.totalAmount, oh.status, oh.restaurantId, 
        	           r.name AS restaurantName
        	    FROM OrderHistory oh
        	    LEFT JOIN restaurant r ON oh.restaurantId = r.restaurantId
        	    WHERE oh.userId = ?
        	""";



        try {
            pstmt = con.prepareStatement(fetchQuery);
            pstmt.setInt(1, userId);
            resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                orderHistoryList.add(new OrderHistory(
                    resultSet.getInt("orderHistoryId"),
                    resultSet.getInt("orderId"),
                    resultSet.getInt("userId"),
                    resultSet.getDate("date"),
                    resultSet.getInt("totalAmount"),
                    resultSet.getString("status"),
                    resultSet.getInt("restaurantId"), // Retrieve restaurantId
                    resultSet.getString("restaurantName")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderHistoryList;
    }
}