package com.gsk.model;

public class Menu {
    private int menuId;
    private int restaurantId;
    private String itemName;
    private String description;
    private double price;
    private double ratings;
    private boolean isAvailable;
    private String imagePath;
    
    // Default constructor
    public Menu() {}
    
    // Parameterized constructor
    public Menu(int menuId, int restaurantId, String itemName, String description, 
                double price, double ratings, boolean isAvailable, String imagePath) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.ratings = ratings;
        this.isAvailable = isAvailable;
        this.imagePath = imagePath;
    }
    
    // Constructor without menuId (for new menu item creation)
    public Menu(int restaurantId, String itemName, String description, double price, 
                String imagePath) {
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.ratings = 0.0; // Default rating
        this.isAvailable = true; // Default to available
        this.imagePath = imagePath;
    }
    
    // Getters and Setters
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
    
    public double getRatings() {
        return ratings;
    }
    
    public void setRatings(double ratings) {
        this.ratings = ratings;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean available) {
        isAvailable = available;
    }
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    @Override
    public String toString() {
        return "Menu{" +
                "menuId=" + menuId +
                ", restaurantId=" + restaurantId +
                ", itemName='" + itemName + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", ratings=" + ratings +
                ", isAvailable=" + isAvailable +
                ", imagePath='" + imagePath + '\'' +
                '}';
    }
}
