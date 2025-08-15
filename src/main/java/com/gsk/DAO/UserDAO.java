package com.gsk.DAO;

import com.gsk.model.User;
import java.util.List;

public interface UserDAO {
    
    // Create - Insert a new user
    boolean addUser(User user);
    
    // Read - Get user by ID
    User getUserById(int userId);
    
    // Read - Get user by username
    User getUserByUsername(String username);
    
    // Read - Get user by email
    User getUserByEmail(String email);
    
    // Read - Get all users
    List<User> getAllUsers();
    
    // Read - Get users by role
    List<User> getUsersByRole(String role);
    
    // Update - Update user information
    boolean updateUser(User user);
    
    // Update - Update user password
    boolean updatePassword(int userId, String newPassword);
    
    // Update - Update last login date
    boolean updateLastLogin(int userId);
    
    // Delete - Delete user by ID
    boolean deleteUser(int userId);
    
    // Authentication - Verify user credentials
    User authenticateUser(String username, String password);
    
    // Utility - Check if username exists
    boolean isUsernameExists(String username);
    
    // Utility - Check if email exists
    boolean isEmailExists(String email);
}
