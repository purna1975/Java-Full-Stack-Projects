package com.tap.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoimpl.UserDaoImpl;
import com.tap.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        
        if(password.equals(cpassword)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phonenumber");

            User user = new User();
            user.setName(name.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPassword(password);
            user.setPhone(phone.trim());

            UserDaoImpl userDao = new UserDaoImpl();
            int result = userDao.registerUser(user);

            if (result == 1) {
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed! Please try again.");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}