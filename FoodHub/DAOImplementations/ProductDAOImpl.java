package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.ProductDAO;
import com.tap.model.Product;

public class ProductDAOImpl implements ProductDAO {

    private static Connection con;
    private static Statement stmt;
    private static ResultSet resultSet;

    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM products";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodapp", "root", "Mahesh@123");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> fetchAll() {
        List<Product> productList = new ArrayList<>();
        try {
            stmt = con.createStatement();
            resultSet = stmt.executeQuery(SELECT_ALL_PRODUCTS);
            while (resultSet.next()) {
                productList.add(new Product(
                    resultSet.getInt("pId"),
                    resultSet.getString("pName"),
                    resultSet.getString("pPrice"),
                    resultSet.getString("pRating"),
                    resultSet.getString("pDescription")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }
}