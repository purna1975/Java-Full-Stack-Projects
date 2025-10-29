package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDAO;
import com.tap.model.Order;

public class OrderDAOImpl implements OrderDAO {

    private static Connection con;
    private static PreparedStatement stmt;
    private static Statement st;
    private static ResultSet res;

    private static final String url = "jdbc:mysql://localhost:3306/foodapp";
    private static final String username = "root";
    private static final String password = "Mahesh@123";

    private static final String ins_query = "INSERT INTO `order` (restaurantId, userId, orderDate, totalAmount, status, paymentMode) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String get_query = "SELECT * FROM `order` WHERE orderId = ?";
    private static final String update_query = "UPDATE `order` SET restaurantId=?, userId=?, orderDate=?, totalAmount=?, status=?, paymentMode=? WHERE orderId=?";
    private static final String delete_query = "DELETE FROM `order` WHERE orderId=?";
    private static final String getAll_query = "SELECT * FROM `order`";

    private Order o = null;

    @Override
    public int addOrder(Order o) {
        int generatedId = -1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            stmt = con.prepareStatement(ins_query, Statement.RETURN_GENERATED_KEYS);

            stmt.setInt(1, o.getRestaurantId());
            stmt.setInt(2, o.getUserId());
            stmt.setDate(3, o.getOrderDate());
            stmt.setDouble(4, o.getTotalAmount());
            stmt.setString(5, o.getStatus());
            stmt.setString(6, o.getPaymentMode());

            int i = stmt.executeUpdate();
            System.out.println("Rows inserted: " + i);

            if (i > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1); // get auto-generated orderId
                    System.out.println("Generated Order ID: " + generatedId);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }


    @Override
    public Order getOrder(int orderId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            stmt = con.prepareStatement(get_query);

            stmt.setInt(1, orderId);

            res = stmt.executeQuery();
            while (res.next()) {
                o = extractOrderInfo(res);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return o;
    }

    @Override
    public void updateOrder(Order o) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            stmt = con.prepareStatement(update_query);

            stmt.setInt(1, o.getRestaurantId());
            stmt.setInt(2, o.getUserId());
            stmt.setDate(3, o.getOrderDate());
            stmt.setDouble(4, o.getTotalAmount());
            stmt.setString(5, o.getStatus());
            stmt.setString(6, o.getPaymentMode());
            stmt.setInt(7, o.getOrderId());

            int i = stmt.executeUpdate();
            System.out.println(i);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            stmt = con.prepareStatement(delete_query);

            stmt.setInt(1, orderId);
            int i = stmt.executeUpdate();
            System.out.println(i);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            st = con.createStatement();
            res = st.executeQuery(getAll_query);

            while (res.next()) {
                o = extractOrderInfo(res);
                list.add(o);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Order extractOrderInfo(ResultSet res) throws SQLException {
        int orderId = res.getInt("orderId");
        int restaurantId = res.getInt("restaurantId");
        int userId = res.getInt("userId");
        Date orderDate = res.getDate("orderDate");
        double totalAmount = res.getDouble("totalAmount");
        String status = res.getString("status");
        String paymentMode = res.getString("paymentMode");

        return new Order(orderId, restaurantId, userId, orderDate, totalAmount, status, paymentMode);
    }
}