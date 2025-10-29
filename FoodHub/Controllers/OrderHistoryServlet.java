package com.tap.servlet;

import com.tap.daoimpl.OrderHistoryDAOImpl;
import com.tap.model.OrderHistory;
import com.tap.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderHistory")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Fetch the current session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("Session UserId = " + user.getUserId());


        // Check if the user is logged in
        if (user != null) {
            OrderHistoryDAOImpl orderHistoryDao = new OrderHistoryDAOImpl();

            // Fetch order history for the logged-in user
            List<OrderHistory> orderHistoryList = orderHistoryDao.fetchOrderHistoryByUserId(user.getUserId());

            // Set the order history list as a request attribute
            request.setAttribute("orderHistoryList", orderHistoryList);

            // Forward to the JSP for display
            RequestDispatcher dispatcher = request.getRequestDispatcher("orderhistory.jsp");
            dispatcher.forward(request, response);
        } else {
            // If no user is logged in, redirect to the login page
            response.sendRedirect("login.jsp");
        }
    }
}