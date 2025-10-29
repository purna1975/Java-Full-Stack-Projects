package com.tap.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
    	
    	String password = req.getParameter("password");
        String confirmPassword = req.getParameter("cpassword");
        
        if(password.equals(confirmPassword)) {
        	// Database connection details
            String url = "jdbc:mysql://localhost:3306/foodapp";
            String username = "root";
            String passw = "Mahesh@123";
            
            // Insert query (NOW() for createdDate & lastLogin_Date)
            String query = "INSERT INTO user (name, username, password, email, phone, address, role, createdDate, lastLogin_Date) "
                         + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
            
            // Fetching parameters from form
            String name = req.getParameter("name");
            String uname = req.getParameter("username");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            String role = req.getParameter("role");

            resp.setContentType("text/html");
            PrintWriter out = resp.getWriter();
            
            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Connect to DB
                Connection con = DriverManager.getConnection(url, username, passw);
                
                // Prepare statement with RETURN_GENERATED_KEYS
                PreparedStatement stmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, name);
                stmt.setString(2, uname);
                stmt.setString(3, password);
                stmt.setString(4, email);
                stmt.setString(5, phone);
                stmt.setString(6, address);
                stmt.setString(7, role);
                
                // Execute query
                int i = stmt.executeUpdate();
                
                if (i > 0) {
                    // Get generated keys (userId)
                    ResultSet rs = stmt.getGeneratedKeys();
                    int userId = -1;
                    if (rs.next()) {
                        userId = rs.getInt(1);
                    }
                    
                    // Create User object
                    User user = new User();
                    user.setUserId(userId);
                    user.setName(name);
                    user.setUsername(uname);
                    user.setPassword(password);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setAddress(address);
                    user.setRole(role);
                    user.setCreatedDate(new java.sql.Timestamp(System.currentTimeMillis()));
                    user.setLastLoginDate(new java.sql.Timestamp(System.currentTimeMillis()));
                    
                    // Set user object into session
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);
                    
                    // Forward to home.jsp
                    RequestDispatcher rd = req.getRequestDispatcher("CallHomeServlet");
                    rd.forward(req, resp);
                } else {
                    out.println("<h2 style='color:red;'>❌ Registration Failed!</h2>");
                }
                
                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            }
        	
        }
    	
    }
}
