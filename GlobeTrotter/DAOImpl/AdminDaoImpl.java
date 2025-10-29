package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tap.dao.AdminDao;

public class AdminDaoImpl implements AdminDao {

    private static Connection con;
    private static String validateAdminQuery = "SELECT * FROM admin WHERE username = ? AND password = ?";

    private PreparedStatement pstmt;
    private static ResultSet resultSet;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sevwonders", "root", "Mahesh@123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean validateAdmin(String username, String password) {
        try {
            pstmt = con.prepareStatement(validateAdminQuery);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            resultSet = pstmt.executeQuery();
            return resultSet.next(); // Returns true if credentials match, false otherwise
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}