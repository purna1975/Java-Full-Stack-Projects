package com.tap.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String url = "jdbc:mysql://localhost:3306/foodapp";
    private static final String username = "root";
    private static final String password = "Mahesh@123";

    private static final String ins_query = "INSERT INTO `orderItem` (orderId, menuId, quantity, totalAmount) VALUES (?, ?, ?, ?)";
    private static final String get_query = "SELECT * FROM `orderItem` WHERE orderItemId = ?";
    private static final String update_query = "UPDATE `orderItem` SET orderId=?, menuId=?, quantity=?, totalAmount=? WHERE orderItemId=?";
    private static final String delete_query = "DELETE FROM `orderItem` WHERE orderItemId=?";
    private static final String getAll_query = "SELECT * FROM `orderItem` ";

    private OrderItem oi = null;

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }
    
    @Override
	public int insertOrderItem(int orderId, int menuId, int quantity, double totalAmount) {
    	try (Connection con = getConnection();
                PreparedStatement stmt = con.prepareStatement(ins_query)) {

               stmt.setInt(1, orderId);
               stmt.setInt(2, menuId);
               stmt.setInt(3, quantity);
               stmt.setDouble(4, totalAmount);

               return stmt.executeUpdate();
               

           } catch (Exception e) {
               e.printStackTrace();
           }
    	return -1;
    	
    }

    @Override
    public void addOrderItem(OrderItem oi) {
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(ins_query)) {

            stmt.setInt(1, oi.getOrderId());
            stmt.setInt(2, oi.getMenuId());
            stmt.setInt(3, oi.getQuantity());
            stmt.setDouble(4, oi.getTotalAmount());

            int i = stmt.executeUpdate();
            System.out.println("jai babu " + i);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(get_query)) {

            stmt.setInt(1, orderItemId);
            try (ResultSet res = stmt.executeQuery()) {
                while (res.next()) {
                    oi = extractOrderItemInfo(res);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return oi;
    }

    @Override
    public void updateOrderItem(OrderItem oi) {
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(update_query)) {

            stmt.setInt(1, oi.getOrderId());
            stmt.setInt(2, oi.getMenuId());
            stmt.setInt(3, oi.getQuantity());
            stmt.setDouble(4, oi.getTotalAmount());
            stmt.setInt(5, oi.getOrderItemId());

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(delete_query)) {

            stmt.setInt(1, orderItemId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet res = st.executeQuery(getAll_query)) {

            while (res.next()) {
                oi = extractOrderItemInfo(res);
                list.add(oi);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<OrderItem> fetchOrderItemsByOrderId(int orderId) {
        String fetchOrderItemsQuery = "SELECT * FROM orderItem WHERE orderId=?";
        List<OrderItem> orderItemsList = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(fetchOrderItemsQuery)) {

            stmt.setInt(1, orderId);
            try (ResultSet res = stmt.executeQuery()) {
                while (res.next()) {
                    orderItemsList.add(new OrderItem(
                            res.getInt("orderItemId"),
                            res.getInt("orderId"),
                            res.getInt("menuId"),
                            res.getInt("quantity"),
                            res.getDouble("totalAmount")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderItemsList;
    }

    private OrderItem extractOrderItemInfo(ResultSet res) throws SQLException {
        int orderItemId = res.getInt("orderItemId");
        int orderId = res.getInt("orderId");
        int menuId = res.getInt("menuId");
        int quantity = res.getInt("quantity");
        double totalAmount = res.getDouble("totalAmount");

        return new OrderItem(orderItemId, orderId, menuId, quantity, totalAmount);
    }
}
