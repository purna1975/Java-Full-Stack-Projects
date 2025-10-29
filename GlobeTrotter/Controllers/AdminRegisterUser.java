package com.tap.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoimpl.UserDaoImpl;
import com.tap.model.User;

@WebServlet("/AdminRegister")
public class AdminRegisterUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("cpassword");
        String phone = request.getParameter("phonenumber");
        
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("addUser.jsp?error=Passwords do not match");
            return;
        }
        
        User user = new User(name, email, password, phone);
        UserDaoImpl userDao = new UserDaoImpl();
        
        int result = userDao.registerUser(user);
        
        if (result > 0) {
            response.sendRedirect("admindashboard.jsp?success=User registered successfully");
        } else {
            response.sendRedirect("addUser.jsp?error=Registration failed");
        }
    }
}