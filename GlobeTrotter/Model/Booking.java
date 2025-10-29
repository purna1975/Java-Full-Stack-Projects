package com.tap.model;

import java.sql.Date;

public class Booking {
    private int bookingId;
    private int userId;
    private int wonderId;
    private Date bookingDate;
    private String timeSlot;
    private String language;
    private int guests;
    private double totalAmount;
    private String status;

    // Default constructor
    public Booking() {
    }

    // Constructor with all fields
    public Booking(int bookingId, int userId, int wonderId, Date bookingDate, 
                  String timeSlot, String language, int guests, double totalAmount, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.wonderId = wonderId;
        this.bookingDate = bookingDate;
        this.timeSlot = timeSlot;
        this.language = language;
        this.guests = guests;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getWonderId() {
        return wonderId;
    }

    public void setWonderId(int wonderId) {
        this.wonderId = wonderId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public int getGuests() {
        return guests;
    }

    public void setGuests(int guests) {
        this.guests = guests;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", userId=" + userId +
                ", wonderId=" + wonderId +
                ", bookingDate=" + bookingDate +
                ", timeSlot='" + timeSlot + '\'' +
                ", language='" + language + '\'' +
                ", guests=" + guests +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}