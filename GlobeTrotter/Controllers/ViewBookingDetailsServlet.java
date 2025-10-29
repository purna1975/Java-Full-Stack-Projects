package com.tap.controllers;

import com.tap.daoimpl.BookingDaoImpl;
import com.tap.model.Booking;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/viewBookingDetails")
public class ViewBookingDetailsServlet extends HttpServlet {
	@Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDaoImpl bookingDao = new BookingDaoImpl();

        // Fetch the booking details
        Booking booking = bookingDao.getBookingById(bookingId);
        
        // Set the booking details in the request scope
        request.setAttribute("booking", booking);

        // Forward to a JSP page that displays the booking details
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewBookingDetails.jsp");
        dispatcher.forward(request, response);
    }
}