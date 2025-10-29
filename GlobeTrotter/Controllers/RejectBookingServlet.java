package com.tap.controllers;

import com.tap.daoimpl.BookingDaoImpl;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/rejectBookingServlet")
public class RejectBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDaoImpl bookingDao = new BookingDaoImpl();

        // Reject the booking by changing its status to 'Cancelled'
        bookingDao.updateBookingStatus(bookingId, "Cancelled");

        // Redirect to the manage bookings page
        response.sendRedirect("manageBookings.jsp");
    }
}
