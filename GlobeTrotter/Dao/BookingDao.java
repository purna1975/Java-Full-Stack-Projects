package com.tap.dao;

import java.util.List;
import com.tap.model.Booking;

public interface BookingDao {
    void addBooking(Booking booking);
    List<Booking> getUserBookings(int userId);
    void cancelBooking(int bookingId);
    
    // New method to update booking status
    void updateBookingStatus(int bookingId, String status);
    
    // New method to get a booking by its ID
    Booking getBookingById(int bookingId);
    
    // New method to get all bookings
    List<Booking> getAllBookings();
}