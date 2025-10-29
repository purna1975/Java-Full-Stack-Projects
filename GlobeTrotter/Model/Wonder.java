package com.tap.model;

public class Wonder {
    private int wonderId;
    private String name;
    private String location;
    private String description;
    private String imageUrl;

    // Constructors
    public Wonder() {
    }

    public Wonder(String name, String location, String description, String imageUrl) {
        this.name = name;
        this.location = location;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    public Wonder(int wonderId, String name, String location, String description, String imageUrl) {
        this.wonderId = wonderId;
        this.name = name;
        this.location = location;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getWonderId() {
        return wonderId;
    }

    public void setWonderId(int wonderId) {
        this.wonderId = wonderId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return wonderId + " " + name + " " + location + " " + description + " " + imageUrl;
    }
}