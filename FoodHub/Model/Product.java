package com.tap.model;

public class Product {
    private int pId;
    private String pName;
    private String pPrice;
    private String pRating;
    private String pDescription;

    // Zero-parameter constructor
    public Product() {
    }

    // Parameterized constructor without pId
    public Product(String pName, String pPrice, String pRating, String pDescription) {
        this.pName = pName;
        this.pPrice = pPrice;
        this.pRating = pRating;
        this.pDescription = pDescription;
    }

    // Parameterized constructor with pId
    public Product(int pId, String pName, String pPrice, String pRating, String pDescription) {
        this.pId = pId;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pRating = pRating;
        this.pDescription = pDescription;
    }

    // Getters and Setters
    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpPrice() {
        return pPrice;
    }

    public void setpPrice(String pPrice) {
        this.pPrice = pPrice;
    }

    public String getpRating() {
        return pRating;
    }

    public void setpRating(String pRating) {
        this.pRating = pRating;
    }

    public String getpDescription() {
        return pDescription;
    }

    public void setpDescription(String pDescription) {
        this.pDescription = pDescription;
    }

    // toString method
    @Override
    public String toString() {
        return pId + " " + pName + " " + pPrice + " " + pRating + " " + pDescription;
    }
}