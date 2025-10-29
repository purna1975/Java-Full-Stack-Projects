package com.tap.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.tap.daoimpl.AdminDaoImpl;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDaoImpl adminDao = new AdminDaoImpl();
        boolean isValidAdmin = adminDao.validateAdmin(username, password);

        if (isValidAdmin) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", username);  // Store admin in session
            response.sendRedirect("admindashboard.jsp"); // Redirect to admin dashboard
        } else {
            request.setAttribute("error", "Invalid Admin Credentials!");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}