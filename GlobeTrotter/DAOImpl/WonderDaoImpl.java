package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.WonderDao;
import com.tap.model.Wonder;

public class WonderDaoImpl implements WonderDao {

    private static Connection con;
    private static Statement stmt;
    private PreparedStatement pstmt;
    private static ResultSet resultSet;
    
    static List<Wonder> wonderList = new ArrayList<>();
    static String getAllWondersQuery = "SELECT * FROM wonders";
    static String getWonderByIdQuery = "SELECT * FROM wonders WHERE wonder_id = ?";
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sevwonders", "root", "Mahesh@123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public List<Wonder> getAllWonders() {
        try {
            stmt = con.createStatement();
            resultSet = stmt.executeQuery(getAllWondersQuery);
            wonderList = extractWonderListFromResultSet(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wonderList;
    }
    
    @Override
    public Wonder getWonderById(int wonderId) {
        try {
            pstmt = con.prepareStatement(getWonderByIdQuery);
            pstmt.setInt(1, wonderId);
            resultSet = pstmt.executeQuery();
            wonderList = extractWonderListFromResultSet(resultSet);
            if (!wonderList.isEmpty()) {
                return wonderList.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    static List<Wonder> extractWonderListFromResultSet(ResultSet resultSet) {
        List<Wonder> wonders = new ArrayList<>();
        try {
            while (resultSet.next()) {
                wonders.add(new Wonder(
                        resultSet.getInt("wonder_id"),
                        resultSet.getString("name"),
                        resultSet.getString("location"),
                        resultSet.getString("description"),
                        resultSet.getString("image_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wonders;
    }
}