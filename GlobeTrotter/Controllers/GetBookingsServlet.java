package com.tap.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.tap.dao.BookingDao;
import com.tap.daoimpl.BookingDaoImpl;
import com.tap.model.Booking;

@WebServlet("/getbookingservlet")
public class GetBookingsServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch user ID from session
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        // Fetch user-specific bookings
        BookingDao bookingDao = new BookingDaoImpl();
        List<Booking> allBookings = bookingDao.getUserBookings(userId);

        // Set the bookings as an attribute
        request.setAttribute("allBookings", allBookings);

        // Forward to the displaybookings.jsp
        request.getRequestDispatcher("displaybookings.jsp").forward(request, response);
    }
}