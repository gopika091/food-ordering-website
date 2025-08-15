package com.gsk.model;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int menuId;
    private String itemName;
    private double price;
    private int quantity;
    private double subtotal;
    private String specialRequests;
    
    // Default constructor
    public OrderItem() {}
    
    // Parameterized constructor
    public OrderItem(int orderItemId, int orderId, int menuId, String itemName, 
                     double price, int quantity, String specialRequests) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.menuId = menuId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.subtotal = price * quantity;
        this.specialRequests = specialRequests;
    }
    
    // Constructor without orderItemId (for new order item creation)
    public OrderItem(int orderId, int menuId, String itemName, double price, 
                     int quantity, String specialRequests) {
        this.orderId = orderId;
        this.menuId = menuId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.subtotal = price * quantity;
        this.specialRequests = specialRequests;
    }
    
    // Constructor with Menu object
    public OrderItem(int orderId, Menu menu, int quantity, String specialRequests) {
        this.orderId = orderId;
        this.menuId = menu.getMenuId();
        this.itemName = menu.getItemName();
        this.price = menu.getPrice();
        this.quantity = quantity;
        this.subtotal = menu.getPrice() * quantity;
        this.specialRequests = specialRequests;
    }
    
    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }
    
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
        // Recalculate subtotal when price changes
        this.subtotal = price * quantity;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        // Recalculate subtotal when quantity changes
        this.subtotal = price * quantity;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public String getSpecialRequests() {
        return specialRequests;
    }
    
    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }
    
    // Utility methods
    public void calculateSubtotal() {
        this.subtotal = this.price * this.quantity;
    }
    
    public void updateQuantity(int newQuantity) {
        this.quantity = newQuantity;
        calculateSubtotal();
    }
    
    public void updatePrice(double newPrice) {
        this.price = newPrice;
        calculateSubtotal();
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemId=" + orderItemId +
                ", orderId=" + orderId +
                ", menuId=" + menuId +
                ", itemName='" + itemName + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", subtotal=" + subtotal +
                ", specialRequests='" + specialRequests + '\'' +
                '}';
    }
}
