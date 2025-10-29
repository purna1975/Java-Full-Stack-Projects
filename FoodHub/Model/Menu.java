package com.tap.model;

import java.io.InputStream;

public class Menu {
    
    private int menuId;
    private int restaurantId;
    private String itemName;
    private String description;
    private double price;
    private boolean isAvailable;
    private double ratings;
    private InputStream imagePath;   // original blob
    private String base64Image;      // new Base64 field

    public Menu() {
        super();
    }
    
    

    public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			double ratings, InputStream imagePath) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.ratings = ratings;
		this.imagePath = imagePath;
	}



	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
            double ratings, InputStream imagePath, String base64Image) {
        super();
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.isAvailable = isAvailable;
        this.ratings = ratings;
        this.imagePath = imagePath;
        this.base64Image = base64Image;
    }

    public int getMenuId() {
        return menuId;
    }
    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return isAvailable;
    }
    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public double getRatings() {
        return ratings;
    }
    public void setRatings(double ratings) {
        this.ratings = ratings;
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
}