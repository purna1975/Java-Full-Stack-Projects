package com.tap.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoimpl.UserDAOImpl;
import com.tap.model.User;

@WebServlet("/CallLoginServ")
public class Login extends HttpServlet {
    int n = 3;    

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String url = "jdbc:mysql://localhost:3306/foodapp";
        String un = "root";
        String passw = "Mahesh@123";
        String query = "select * from user where username = ? and password = ? ";
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null) {
            username = (String) req.getAttribute("username");
        }
        if (password == null) {
            password = (String) req.getAttribute("password");
        }

        
        boolean validUser = false;
        User user = null;
        PrintWriter out = resp.getWriter();
        
        resp.setContentType("text/html");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url,un,passw);
            PreparedStatement stmt = con.prepareStatement(query);
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            ResultSet res = stmt.executeQuery();
            
            if(res.next()) {
                validUser = true;

                UserDAOImpl userDAO = new UserDAOImpl();
                user = userDAO.extractUserInfo(res);
                
            }
        }
        catch(ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        if(validUser && user != null) {
            // Add user object to session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            RequestDispatcher rd = req.getRequestDispatcher("CallHomeServlet");
            rd.include(req, resp);
        }
        else if(n > 0) {
        	resp.sendRedirect("login.jsp?error=Wrong+username+or+password.+Retry!+" + n + "+attempts+left");
        	n--;

        }

        else  {
            RequestDispatcher rd = req.getRequestDispatcher("failure.jsp");
            rd.include(req, resp);
        }
        
    }
}
