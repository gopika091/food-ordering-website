package com.gsk.model;


import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private int restaurantId;
    private double totalAmount;
    private String orderStatus; // PENDING, CONFIRMED, PREPARING, OUT_FOR_DELIVERY, DELIVERED, CANCELLED
    private String paymentMethod;
    private String paymentStatus; // PENDING, PAID, FAILED, REFUNDED
    private LocalDateTime orderDate;
    private LocalDateTime deliveryDate;
    private String deliveryAddress;
    private String specialInstructions;
    private List<OrderItem> orderItems;
    
    // Default constructor
    public Order() {}
    
    // Parameterized constructor
    public Order(int orderId, int userId, int restaurantId, double totalAmount, 
                 String orderStatus, String paymentMethod, String paymentStatus,
                 LocalDateTime orderDate, LocalDateTime deliveryDate, 
                 String deliveryAddress, String specialInstructions) {
        this.orderId = orderId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
        this.deliveryAddress = deliveryAddress;
        this.specialInstructions = specialInstructions;
    }
    
    // Constructor without orderId (for new order creation)
    public Order(int userId, int restaurantId, String paymentMethod, 
                 String deliveryAddress, String specialInstructions) {
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.totalAmount = 0.0; // Will be calculated
        this.orderStatus = "PENDING"; // Default status
        this.paymentMethod = paymentMethod;
        this.paymentStatus = "PENDING"; // Default payment status
        this.orderDate = LocalDateTime.now();
        this.deliveryAddress = deliveryAddress;
        this.specialInstructions = specialInstructions;
    }
    
    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getOrderStatus() {
        return orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public LocalDateTime getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }
    
    public LocalDateTime getDeliveryDate() {
        return deliveryDate;
    }
    
    public void setDeliveryDate(LocalDateTime deliveryDate) {
        this.deliveryDate = deliveryDate;
    }
    
    public String getDeliveryAddress() {
        return deliveryAddress;
    }
    
    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
    
    public String getSpecialInstructions() {
        return specialInstructions;
    }
    
    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    
    // Utility methods
    public void calculateTotalAmount() {
        if (orderItems != null && !orderItems.isEmpty()) {
            this.totalAmount = orderItems.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
        }
    }
    
    public boolean isDelivered() {
        return "DELIVERED".equals(this.orderStatus);
    }
    
    public boolean isCancelled() {
        return "CANCELLED".equals(this.orderStatus);
    }
    
    public boolean isPaid() {
        return "PAID".equals(this.paymentStatus);
    }
    
    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", restaurantId=" + restaurantId +
                ", totalAmount=" + totalAmount +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", orderDate=" + orderDate +
                ", deliveryDate=" + deliveryDate +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                ", specialInstructions='" + specialInstructions + '\'' +
                '}';
    }
}
