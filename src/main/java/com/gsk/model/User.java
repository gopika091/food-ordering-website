package com.gsk.model
;

import java.util.Date;

public class User {
    private int userId;
    private String name;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String address;
    private String role;
    private String profileImage;
    private boolean isActive;
    private boolean isEmailVerified;
    private Date createdDate;
    private Date lastLoginDate;
    private Date updatedDate;
    
    // Default constructor
    public User() {
        this.profileImage = "/images/default-profile.jpg";
        this.isActive = true;
        this.isEmailVerified = false;
    }
    
    // Parameterized constructor
    public User(int userId, String name, String username, String password, String email, 
                String phone, String address, String role, String profileImage, 
                boolean isActive, boolean isEmailVerified, Date createdDate, 
                Date lastLoginDate, Date updatedDate) {
        this.userId = userId;
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.profileImage = profileImage;
        this.isActive = isActive;
        this.isEmailVerified = isEmailVerified;
        this.createdDate = createdDate;
        this.lastLoginDate = lastLoginDate;
        this.updatedDate = updatedDate;
    }
    
    // Constructor without userId (for new user creation)
    public User(String name, String username, String password, String email, 
                String phone, String address, String role) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.profileImage = "/images/default-profile.jpg";
        this.isActive = true;
        this.isEmailVerified = false;
        this.createdDate = new Date();
        this.updatedDate = new Date();
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public Date getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    public Date getLastLoginDate() {
        return lastLoginDate;
    }
    
    public void setLastLoginDate(Date lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }
    
    public String getProfileImage() {
        return profileImage;
    }
    
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public boolean isEmailVerified() {
        return isEmailVerified;
    }
    
    public void setEmailVerified(boolean emailVerified) {
        isEmailVerified = emailVerified;
    }
    
    public Date getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", role='" + role + '\'' +
                ", createdDate=" + createdDate +
                ", lastLoginDate=" + lastLoginDate +
                '}';
    }
}
