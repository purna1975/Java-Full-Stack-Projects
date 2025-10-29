package com.tap.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoimpl.BookingDaoImpl;
import com.tap.model.Booking;

@WebServlet("/addBookingServlet")
public class AddBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve data from the request (form data)
            String userIdStr = request.getParameter("user_id"); // Updated parameter name
            String wonderIdStr = request.getParameter("wonder_id"); // Updated parameter name
            String bookingDateStr = request.getParameter("booking_date"); // Updated parameter name
            String timeSlot = request.getParameter("time_slot"); // Updated parameter name
            String language = request.getParameter("language");
            String guestsStr = request.getParameter("guests");
            String totalAmountStr = request.getParameter("total_amount"); // Updated parameter name
            String status = request.getParameter("status");

            // Validate input parameters
            if (userIdStr == null || wonderIdStr == null || bookingDateStr == null ||
                timeSlot == null || language == null || guestsStr == null || totalAmountStr == null || status == null) {
                // Missing parameter, return an error
                response.sendRedirect("errorPage.jsp");
                return;
            }

            // Parse integers and handle invalid format
            int userId = Integer.parseInt(userIdStr);
            int wonderId = Integer.parseInt(wonderIdStr);
            java.sql.Date bookingDate = java.sql.Date.valueOf(bookingDateStr);
            int guests = Integer.parseInt(guestsStr);
            double totalAmount = Double.parseDouble(totalAmountStr);

            // Create a new Booking object
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setWonderId(wonderId);
            booking.setBookingDate(bookingDate);
            booking.setTimeSlot(timeSlot);
            booking.setLanguage(language);
            booking.setGuests(guests);
            booking.setTotalAmount(totalAmount);
            booking.setStatus(status);

            // Use the BookingDaoImpl to add the booking
            BookingDaoImpl bookingDao = new BookingDaoImpl();
            bookingDao.addBooking(booking);

            // Redirect the admin to the Manage Bookings page after adding the booking
            response.sendRedirect("manageBookings.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }
}