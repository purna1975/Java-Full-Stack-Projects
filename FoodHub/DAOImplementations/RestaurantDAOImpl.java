package com.tap.daoimpl;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;

public class RestaurantDAOImpl implements RestaurantDAO {

    private static Connection con;
    private static Statement st;
    private static PreparedStatement stmt;
    private static ResultSet res;

    private static final String url = "jdbc:mysql://localhost:3306/foodapp";
    private static final String username = "root";
    private static final String password = "Mahesh@123";

    private static final String ins_query = "insert into restaurant (name, address, phoneNumber, cuisineType, deliveryTime, adminUserId, rating, isActive, imagePath) values(?,?,?,?,?,?,?,?,?)";
    private static final String get_query = "select * from `restaurant` where `restaurantId` = ? ";
    private static final String update_query = "update `restaurant` set name = ?, address = ?, phoneNumber = ?, cuisineType = ?, deliveryTime = ?, adminUserId = ?, rating = ?, isActive = ?, imagePath = ?  where restaurantId = ? ";
    private static final String delete_query = "delete from `restaurant` where `restaurantId` = ? ";
    private static final String getAll_query = "select * from `restaurant`";

    Restaurant r = null;

    @Override
    public void addRestaurant(Restaurant r) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            stmt = con.prepareStatement(ins_query);

            stmt.setString(1, r.getName());
            stmt.setString(2, r.getAddress());
            stmt.setString(3, r.getPhoneNumber());
            stmt.setString(4, r.getCuisineType());
            stmt.setString(5, r.getDeliveryTime());
            stmt.setInt(6, r.getAdminUserId());
            stmt.setDouble(7, r.getRating());
            stmt.setBoolean(8, r.getIsActive());
            stmt.setBinaryStream(9, r.getImagePath());

            int i = stmt.executeUpdate();
            System.out.println(i);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            stmt = con.prepareStatement(get_query);
            stmt.setInt(1, restaurantId);
            res = stmt.executeQuery();

            while (res.next()) {
                r = extractRestaurantInfo(res);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return r;
    }

    @Override
    public void updateRestaurant(Restaurant r) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            stmt = con.prepareStatement(update_query);

            stmt.setString(1, r.getName());
            stmt.setString(2, r.getAddress());
            stmt.setString(3, r.getPhoneNumber());
            stmt.setString(4, r.getCuisineType());
            stmt.setString(5, r.getDeliveryTime());
            stmt.setInt(6, r.getAdminUserId());
            stmt.setDouble(7, r.getRating());
            stmt.setBoolean(8, r.getIsActive());
            stmt.setBinaryStream(9, r.getImagePath());
            stmt.setInt(10, r.getRestaurantId());

            int i = stmt.executeUpdate();

            System.out.println(i);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void deleteRestaurant(int restaurantId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            stmt = con.prepareStatement(delete_query);
            stmt.setInt(1, restaurantId);
            int i = stmt.executeUpdate();
            System.out.println(i);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> ls = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            st = con.createStatement();
            res = st.executeQuery(getAll_query);
            while (res.next()) {
                r = extractRestaurantInfo(res);
                ls.add(r);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return ls;
    }

    public Restaurant extractRestaurantInfo(ResultSet res) throws SQLException {
        int restaurantId = res.getInt("restaurantId");
        String name = res.getString("name");
        String address = res.getString("address");
        String phoneNumber = res.getString("phoneNumber");
        String cuisineType = res.getString("cuisineType");
        String deliveryTime = res.getString("deliveryTime");
        int adminUserId = res.getInt("adminUserId");
        double rating = res.getDouble("rating");
        boolean isActive = res.getBoolean("isActive");
        InputStream imagePath = res.getBinaryStream("imagePath");

        String base64Image = null;
        if (imagePath != null) {
            try {
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = imagePath.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        r = new Restaurant(restaurantId, name, address, phoneNumber, cuisineType, deliveryTime, adminUserId, rating,
                isActive, imagePath, base64Image);

        return r;
    }

}