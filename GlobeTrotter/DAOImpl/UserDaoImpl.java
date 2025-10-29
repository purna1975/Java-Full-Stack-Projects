package com.tap.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.tap.dao.UserDao;
import com.tap.model.User;

public class UserDaoImpl implements UserDao {

    private static Connection con;
    private PreparedStatement pstmt;
    private static Statement stmt;
    private static ResultSet resultSet;

    // Queries
    private static final String insertUser = "INSERT INTO users (name, email, password, phone, status) VALUES (?, ?, ?, ?, 'active')";
    private static final String getAllUsersQuery = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ?";
    private static final String getUserByEmailAndPassword = "SELECT * FROM users WHERE email = ? AND password = ?";
    private static final String deleteUserQuery = "DELETE FROM users WHERE user_id = ?";
    private static final String getUserStatusQuery = "SELECT status FROM users WHERE user_id = ?";
    private static final String updateUserStatusQuery = "UPDATE users SET status = ? WHERE user_id = ?";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sevwonders", "root", "Mahesh@123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int registerUser(User user) {
        int x = -1;
        try {
            pstmt = con.prepareStatement(insertUser);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getPhone());
            x = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    @Override
    public User loginUser(String email, String password) {
        try {
            pstmt = con.prepareStatement(getUserByEmailAndPassword);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                return new User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> getAllUsers(String searchQuery) {
        List<User> userList = new ArrayList<>();
        try {
            pstmt = con.prepareStatement(getAllUsersQuery);
            pstmt.setString(1, "%" + searchQuery + "%");  // Adding wildcard for partial match
            pstmt.setString(2, "%" + searchQuery + "%");
            resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                userList.add(new User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    @Override
    public int deleteUser(int userId) {
        int rowsAffected = 0;
        try {
            pstmt = con.prepareStatement(deleteUserQuery);
            pstmt.setInt(1, userId);
            rowsAffected = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowsAffected;
    }

    @Override
    public int toggleUserStatus(int userId) {
        int rowsAffected = 0;
        String newStatus = "active";

        try {
            pstmt = con.prepareStatement(getUserStatusQuery);
            pstmt.setInt(1, userId);
            resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                newStatus = resultSet.getString("status").equals("active") ? "blocked" : "active";
            }

            pstmt = con.prepareStatement(updateUserStatusQuery);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, userId);
            rowsAffected = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowsAffected;
    }
}