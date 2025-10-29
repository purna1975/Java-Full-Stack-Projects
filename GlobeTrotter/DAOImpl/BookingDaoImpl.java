package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.tap.dao.BookingDao;
import com.tap.model.Booking;

public class BookingDaoImpl implements BookingDao {

    private static final String URL = "jdbc:mysql://localhost:3306/sevwonders";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Mahesh@123";

    private static final String INSERT_BOOKING = 
        "INSERT INTO bookings (user_id, wonder_id, booking_date, time_slot, language, guests, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_USER_BOOKINGS = "SELECT * FROM bookings WHERE user_id = ?";
    private static final String CANCEL_BOOKING = "UPDATE bookings SET status = 'Cancelled' WHERE booking_id = ?";
    private static final String UPDATE_BOOKING_STATUS = "UPDATE bookings SET status = ? WHERE booking_id = ?";
    private static final String GET_BOOKING_BY_ID = "SELECT * FROM bookings WHERE booking_id = ?";
    private static final String GET_ALL_BOOKINGS = "SELECT * FROM bookings";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    @Override
    public void addBooking(Booking booking) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_BOOKING, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, booking.getUserId());
            pstmt.setInt(2, booking.getWonderId());
            pstmt.setDate(3, booking.getBookingDate());
            pstmt.setString(4, booking.getTimeSlot());
            pstmt.setString(5, booking.getLanguage());
            pstmt.setInt(6, booking.getGuests());
            pstmt.setDouble(7, booking.getTotalAmount());
            pstmt.setString(8, booking.getStatus());

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        booking.setBookingId(generatedKeys.getInt(1)); // Set generated booking ID
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding booking: " + e.getMessage());
        }
    }

    @Override
    public List<Booking> getUserBookings(int userId) {
        List<Booking> bookingList = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_USER_BOOKINGS)) {
             
            pstmt.setInt(1, userId);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                while (resultSet.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(resultSet.getInt("booking_id"));
                    booking.setUserId(resultSet.getInt("user_id"));
                    booking.setWonderId(resultSet.getInt("wonder_id"));
                    booking.setBookingDate(resultSet.getDate("booking_date"));
                    booking.setTimeSlot(resultSet.getString("time_slot"));
                    booking.setLanguage(resultSet.getString("language"));
                    booking.setGuests(resultSet.getInt("guests"));
                    booking.setTotalAmount(resultSet.getDouble("total_amount"));
                    booking.setStatus(resultSet.getString("status"));
                    bookingList.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookingList;
    }

    @Override
    public void cancelBooking(int bookingId) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(CANCEL_BOOKING)) {

            pstmt.setInt(1, bookingId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateBookingStatus(int bookingId, String status) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_BOOKING_STATUS)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating booking status: " + e.getMessage());
        }
    }

    @Override
    public Booking getBookingById(int bookingId) {
        Booking booking = null;
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_BOOKING_BY_ID)) {
             
            pstmt.setInt(1, bookingId);
            try (ResultSet resultSet = pstmt.executeQuery()) {
                if (resultSet.next()) {
                    booking = new Booking();
                    booking.setBookingId(resultSet.getInt("booking_id"));
                    booking.setUserId(resultSet.getInt("user_id"));
                    booking.setWonderId(resultSet.getInt("wonder_id"));
                    booking.setBookingDate(resultSet.getDate("booking_date"));
                    booking.setTimeSlot(resultSet.getString("time_slot"));
                    booking.setLanguage(resultSet.getString("language"));
                    booking.setGuests(resultSet.getInt("guests"));
                    booking.setTotalAmount(resultSet.getDouble("total_amount"));
                    booking.setStatus(resultSet.getString("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }

    @Override
    public List<Booking> getAllBookings() {
        List<Booking> bookingList = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_BOOKINGS)) {
             
            try (ResultSet resultSet = pstmt.executeQuery()) {
                while (resultSet.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(resultSet.getInt("booking_id"));
                    booking.setUserId(resultSet.getInt("user_id"));
                    booking.setWonderId(resultSet.getInt("wonder_id"));
                    booking.setBookingDate(resultSet.getDate("booking_date"));
                    booking.setTimeSlot(resultSet.getString("time_slot"));
                    booking.setLanguage(resultSet.getString("language"));
                    booking.setGuests(resultSet.getInt("guests"));
                    booking.setTotalAmount(resultSet.getDouble("total_amount"));
                    booking.setStatus(resultSet.getString("status"));
                    bookingList.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookingList;
    }
}