package com.gsk.model;

public class CartItem {
    private int cartItemId;
    private int userId;
    private int restaurantId;
    private int menuId;
    private String itemName;
    private String description;
    private double price;
    private int quantity;
    private String restaurantName;
    
    // Default constructor
    public CartItem() {
        this.quantity = 1;
    }
    
    // Constructor for new cart item
    public CartItem(int userId, int restaurantId, int menuId, String itemName, String description, double price, String restaurantName) {
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.menuId = menuId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.quantity = 1;
        this.restaurantName = restaurantName;
    }
    
    // Full constructor
    public CartItem(int cartItemId, int userId, int restaurantId, int menuId, String itemName, String description, double price, int quantity, String restaurantName) {
        this.cartItemId = cartItemId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.menuId = menuId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.restaurantName = restaurantName;
    }
    
    // Getters and Setters
    public int getCartItemId() {
        return cartItemId;
    }
    
    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getRestaurantId() {
        return restaurantId;
    }
    
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
    
    public int getMenuId() {
        return menuId;
    }
    
    public void setMenuId(int menuId) {
        this.menuId = menuId;
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
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getRestaurantName() {
        return restaurantName;
    }
    
    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
    
    // Calculate subtotal for this item
    public double getSubtotal() {
        return price * quantity;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "cartItemId=" + cartItemId +
                ", userId=" + userId +
                ", restaurantId=" + restaurantId +
                ", menuId=" + menuId +
                ", itemName='" + itemName + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", restaurantName='" + restaurantName + '\'' +
                '}';
    }
}
