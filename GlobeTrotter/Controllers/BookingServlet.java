package com.tap.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoimpl.BookingDaoImpl;
import com.tap.model.Booking;
import com.tap.model.User;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDaoImpl bookingDao = new BookingDaoImpl();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String step = request.getParameter("step");
        
        if ("1".equals(step)) {
            // Store booking details in session
            session.setAttribute("bookingDate", request.getParameter("bookingDate"));
            session.setAttribute("guests", request.getParameter("guests"));
            session.setAttribute("wonderId", request.getParameter("wonderId"));
            session.setAttribute("timeSlot", request.getParameter("timeSlot"));
            session.setAttribute("language", request.getParameter("language"));
            
            int guests = Integer.parseInt(request.getParameter("guests"));
            double totalAmount = guests * 50.0;
            session.setAttribute("totalAmount", totalAmount);
            
            response.sendRedirect("91_payment.jsp");
            
        } else if ("2".equals(step)) {
            // Process payment
            String paymentMethod = request.getParameter("paymentMethod");
            session.setAttribute("paymentMethod", paymentMethod);
            
            if ("cod".equals(paymentMethod)) {
                // For Cash on Delivery, directly create booking
                createBooking(request, response, session, user);
            } else {
                // For UPI, store payment details and create booking
                session.setAttribute("upiId", request.getParameter("upiId"));
                createBooking(request, response, session, user);
            }
        }
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response,
                             HttpSession session, User user) throws ServletException, IOException {
        try {
            Booking booking = new Booking();
            booking.setUserId(user.getUserId());
            booking.setWonderId(Integer.parseInt((String) session.getAttribute("wonderId")));
            booking.setBookingDate(java.sql.Date.valueOf((String) session.getAttribute("bookingDate")));
            booking.setTimeSlot((String) session.getAttribute("timeSlot"));
            booking.setLanguage((String) session.getAttribute("language"));
            booking.setGuests(Integer.parseInt((String) session.getAttribute("guests")));
            booking.setTotalAmount((Double) session.getAttribute("totalAmount"));
            booking.setStatus("Confirmed");
            
            bookingDao.addBooking(booking);
            
            // Clear session attributes
            session.removeAttribute("bookingDate");
            session.removeAttribute("guests");
            session.removeAttribute("wonderId");
            session.removeAttribute("timeSlot");
            session.removeAttribute("language");
            session.removeAttribute("totalAmount");
            session.removeAttribute("paymentMethod");
            session.removeAttribute("upiId");
            
            // Store booking ID for confirmation
            session.setAttribute("bookingId", booking.getBookingId());
            
            response.sendRedirect("92_confirmation.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your booking.");
            request.getRequestDispatcher("91_payment.jsp").forward(request, response);
        }
    }
}