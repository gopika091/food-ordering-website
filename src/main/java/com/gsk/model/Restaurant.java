package com.gsk.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String description;
    private String address;
    private String phone;
    private String email;
    private double rating;
    private String cuisineType;
    private boolean isActive;
    private String deliveryTime;
    private int adminUserId;
    private String imagePath;
    
    // Default constructor
    public Restaurant() {
        this.isActive = true;
    }
    
    // Parameterized constructor (original)
    public Restaurant(int restaurantId, String name, String address, String phone, 
                      double rating, String cuisineType, boolean isActive, String deliveryTime, 
                      int adminUserId, String imagePath) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.rating = rating;
        this.cuisineType = cuisineType;
        this.isActive = isActive;
        this.deliveryTime = deliveryTime;
        this.adminUserId = adminUserId;
        this.imagePath = imagePath;
    }
    
    // Constructor without restaurantId (for new restaurant creation)
    public Restaurant(String name, String address, String phone, String cuisineType, 
                      String deliveryTime, int adminUserId, String imagePath) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.rating = 0.0;
        this.cuisineType = cuisineType;
        this.isActive = true;
        this.deliveryTime = deliveryTime;
        this.adminUserId = adminUserId;
        this.imagePath = imagePath;
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
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public String getCuisineType() {
        return cuisineType;
    }
    
    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
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
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    @Override
    public String toString() {
        return "Restaurant{" +
                "restaurantId=" + restaurantId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", rating=" + rating +
                ", cuisineType='" + cuisineType + '\'' +
                ", isActive=" + isActive +
                ", deliveryTime='" + deliveryTime + '\'' +
                ", adminUserId=" + adminUserId +
                ", imagePath='" + imagePath + '\'' +
                '}';
    }
}
