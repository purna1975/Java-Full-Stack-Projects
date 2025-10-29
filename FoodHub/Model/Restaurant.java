package com.tap.model;

import java.io.InputStream;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String address;
    private String phoneNumber;
    private String cuisineType;
    private String deliveryTime;
    private int adminUserId;
    private double rating;
    private boolean isActive;
    private InputStream imagePath;

    private String base64Image; // for Base64 image

    // Zero-parameter constructor
    public Restaurant() {
        super();
    }

    // All-parameter constructor
    public Restaurant(int restaurantId, String name, String address, String phoneNumber,
                      String cuisineType, String deliveryTime, int adminUserId,
                      double rating, boolean isActive, InputStream imagePath, String base64Image) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.cuisineType = cuisineType;
        this.deliveryTime = deliveryTime;
        this.adminUserId = adminUserId;
        this.rating = rating;
        this.isActive = isActive;
        this.imagePath = imagePath;
        this.base64Image = base64Image;
    }

    // Getters and Setters
    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public int getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(int adminUserId) {
        this.adminUserId = adminUserId;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public InputStream getImagePath() {
        return imagePath;
    }

    public void setImagePath(InputStream imagePath) {
        this.imagePath = imagePath;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    // toString method
    @Override
    public String toString() {
        return "Restaurant{" +
                "restaurantId=" + restaurantId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", cuisineType='" + cuisineType + '\'' +
                ", deliveryTime='" + deliveryTime + '\'' +
                ", adminUserId=" + adminUserId +
                ", rating=" + rating +
                ", isActive=" + isActive +
                ", base64Image='" + (base64Image != null ? "Present" : "Null") + '\'' +
                '}';
    }
}