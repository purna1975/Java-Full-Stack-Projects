package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDAO;
import com.tap.model.User;

public class UserDAOImpl implements UserDAO {
	
	private static Connection con;
	private static Statement st;
	private static PreparedStatement stmt;
	private static ResultSet res;
	
	
	private static final String url = "jdbc:mysql://localhost:3306/foodapp";
	private static final String username = "root";
	private static final String password = "Mahesh@123";
	
	
	private static final String ins_query = "insert into `user` (`name`, `username`, `password`, `email`, `phone`, `address`, `role`, `createdDate`, `lastLogin_Date`) values(?,?,?,?,?,?,?,?,?)";
	private static final String get_query = "select * from `user` where `userId` = ? ";
	private static final String update_query = "update `user` set `name` = ?, `username` = ?, `password` = ?, `email` = ?, `phone` = ?, `address` = ?, `role` = ? where userId = ? ";
	private static final String delete_query = "delete from `user` where `userId` = ? ";
	private static final String getAll_query = "select * from `user`";
	
	User u = null;

	@Override
	public void addUser(User u) {
		
		
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, username, password);
			stmt = con.prepareStatement(ins_query);
			
			stmt.setString(1, u.getName());
			stmt.setString(2, u.getUsername());
			stmt.setString(3, u.getPassword());
			stmt.setString(4, u.getEmail());
			stmt.setString(5, u.getPhone());
			stmt.setString(6, u.getAddress());
			stmt.setString(7, u.getRole());
			stmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			
			
			
			int i = stmt.executeUpdate();
			System.out.println(i);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public User getUser(int userId) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, username, password);
			stmt = con.prepareStatement(get_query);
			stmt.setInt(1, userId);
			res = stmt.executeQuery();
			
			while(res.next()) {
			   u = extractUserInfo(res);
			}   
			
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return u;
		
	}

	@Override
	public void updateUser(User u) {
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, username, password);
			stmt = con.prepareStatement(update_query);
			
			stmt.setString(1, u.getName());
			stmt.setString(2, u.getUsername());
			stmt.setString(3, u.getPassword());
			stmt.setString(4, u.getEmail());
			stmt.setString(5, u.getPhone());
			stmt.setString(6, u.getAddress());
			stmt.setString(7, u.getRole());
			stmt.setInt(8, u.getUserId());
			
			
			int i = stmt.executeUpdate();
			System.out.println(i);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteUser(int userId) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,username,password);
			stmt = con.prepareStatement(delete_query);
			
			stmt.setInt(1, userId);
			
			int i = stmt.executeUpdate();
			
			System.out.println(i);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUsers() {
		
		List<User> usersList = new ArrayList<User>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,username,password);
			st = con.createStatement();
			res = st.executeQuery(getAll_query);
			
			while(res.next()) {
				u = extractUserInfo(res);
				usersList.add(u);
			}
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return usersList;
		
	}
	
	public User extractUserInfo(ResultSet res) throws SQLException {
		
		int userId = res.getInt("userId");
		String name = res.getString("name");
		String username = res.getString("username");
		String password = res.getString("password");
		String email = res.getString("email");
		String phone = res.getString("phone");
		String address = res.getString("address");
		String role = res.getString("role");
		Timestamp createdDate = res.getTimestamp("createdDate");
		Timestamp lastLogin_Date = res.getTimestamp("lastLogin_Date");
		
		
		u = new User(userId, name, username, password, email, phone, address, role, createdDate, lastLogin_Date);
		return u;	
	}



}
