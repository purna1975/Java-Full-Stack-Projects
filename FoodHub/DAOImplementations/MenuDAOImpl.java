package com.tap.daoimpl;

import java.io.ByteArrayInputStream;
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

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;

public class MenuDAOImpl implements MenuDAO {
	
	private static final String URL = "jdbc:mysql://localhost:3306/foodapp";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "Mahesh@123";
	
	private static final String INS_QUERY = 
		"INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, ratings, imagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_QUERY = "SELECT * FROM menu WHERE menuId = ?";
	private static final String UPDATE_QUERY = 
		"UPDATE menu SET restaurantId = ?, itemName = ?, description = ?, price = ?, isAvailable = ?, ratings = ?, imagePath = ? WHERE menuId = ?";
	private static final String DELETE_QUERY = "DELETE FROM menu WHERE menuId = ?";
	private static final String GETALL_QUERY = "SELECT * FROM menu";
	private static final String GETBYRESTAURANT_QUERY = "SELECT * FROM menu WHERE restaurantId = ?";
	
	// ---------------- ADD MENU ----------------
	@Override
	public void addMenu(Menu m) {
		try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 PreparedStatement ps = con.prepareStatement(INS_QUERY)) {
			
			ps.setInt(1, m.getRestaurantId());
			ps.setString(2, m.getItemName());
			ps.setString(3, m.getDescription());
			ps.setDouble(4, m.getPrice());
			ps.setBoolean(5, m.isAvailable());
			ps.setDouble(6, m.getRatings());
			
			// image as InputStream (nullable)
			if (m.getImagePath() != null) {
				ps.setBinaryStream(7, m.getImagePath());
			} else {
				ps.setNull(7, java.sql.Types.BLOB);
			}
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// ---------------- GET MENU BY ID ----------------
	@Override
	public Menu getMenu(int menuId) {
		Menu m = null;
		try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 PreparedStatement ps = con.prepareStatement(GET_QUERY)) {
			
			ps.setInt(1, menuId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					m = extractMenuInfo(rs);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return m;
	}
	
	// ---------------- UPDATE MENU ----------------
	@Override
	public void updateMenu(Menu m) {
		try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 PreparedStatement ps = con.prepareStatement(UPDATE_QUERY)) {
			
			ps.setInt(1, m.getRestaurantId());
			ps.setString(2, m.getItemName());
			ps.setString(3, m.getDescription());
			ps.setDouble(4, m.getPrice());
			ps.setBoolean(5, m.isAvailable());
			ps.setDouble(6, m.getRatings());
			
			if (m.getImagePath() != null) {
				ps.setBinaryStream(7, m.getImagePath());
			} else {
				ps.setNull(7, java.sql.Types.BLOB);
			}
			
			ps.setInt(8, m.getMenuId());
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// ---------------- DELETE MENU ----------------
	@Override
	public void deleteMenu(int menuId) {
		try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 PreparedStatement ps = con.prepareStatement(DELETE_QUERY)) {
			
			ps.setInt(1, menuId);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// ---------------- GET ALL MENUS ----------------
	@Override
	public List<Menu> getAllMenus() {
		List<Menu> list = new ArrayList<>();
		try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			 Statement st = con.createStatement();
			 ResultSet rs = st.executeQuery(GETALL_QUERY)) {
			
			while (rs.next()) {
				list.add(extractMenuInfo(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// ---------------- GET ALL MENUS BY RESTAURANT ----------------
	@Override
	public List<Menu> getAllMenusByRestaurantId(int restaurantId) {
	    List<Menu> list = new ArrayList<>();

	    try (Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	         PreparedStatement ps = con.prepareStatement(GETBYRESTAURANT_QUERY)) {
	        
	        ps.setInt(1, restaurantId);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                list.add(extractMenuInfo(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	
	// ---------------- HELPER METHOD ----------------
	private Menu extractMenuInfo(ResultSet rs) throws SQLException {
		int menuId = rs.getInt("menuId");
	    int restaurantId = rs.getInt("restaurantId");
	    String itemName = rs.getString("itemName");
	    String description = rs.getString("description");
	    double price = rs.getDouble("price");
	    boolean isAvailable = rs.getBoolean("isAvailable");
	    double ratings = rs.getDouble("ratings");
	    
	    byte[] imgBytes = rs.getBytes("imagePath");
	    InputStream imageStream = null;
	    String base64Image = null;

	    if (imgBytes != null) {
	        imageStream = new ByteArrayInputStream(imgBytes);
	        base64Image = Base64.getEncoder().encodeToString(imgBytes);
	    }
	    
	    return new Menu(menuId, restaurantId, itemName, description, price, isAvailable, ratings, imageStream, base64Image);
	}
}
