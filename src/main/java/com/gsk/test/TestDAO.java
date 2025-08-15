package com.gsk.test;


import com.gsk.DAO.UserDAO;
import com.gsk.DAOimp.UserDAOImpl;
import com.gsk.model.User;
import com.gsk.util.DBConnection;

import java.util.Date;
import java.util.List;

public class TestDAO {
    
    public static void main(String[] args) {
        System.out.println("=== Food Ordering Website - DAO Pattern Test ===");
        
        // Test database connection
        testDatabaseConnection();
        
        // Test User DAO operations
        testUserDAO();
    }
    
    private static void testDatabaseConnection() {
        System.out.println("\n1. Testing Database Connection...");
        boolean isConnected = DBConnection.testConnection();
        if (isConnected) {
            System.out.println("✓ Database connection successful!");
        } else {
            System.out.println("✗ Database connection failed!");
            System.out.println("Please check your database configuration in DBConnection.java");
            return;
        }
    }
    
    private static void testUserDAO() {
        System.out.println("\n2. Testing User DAO Operations...");
        
        UserDAO userDAO = new UserDAOImpl();
        
        // Test 1: Add a new user
        System.out.println("\n2.1 Adding a new user...");
        User newUser = new User("John Doe", "johndoe", "password123", 
                               "john@example.com", "1234567890", 
                               "123 Main St, City", "customer");
        
        boolean isAdded = userDAO.addUser(newUser);
        if (isAdded) {
            System.out.println("✓ User added successfully!");
        } else {
            System.out.println("✗ Failed to add user!");
        }
        
        // Test 2: Get user by username
        System.out.println("\n2.2 Retrieving user by username...");
        User retrievedUser = userDAO.getUserByUsername("johndoe");
        if (retrievedUser != null) {
            System.out.println("✓ User retrieved successfully!");
            System.out.println("User Details: " + retrievedUser.toString());
        } else {
            System.out.println("✗ User not found!");
        }
        
        // Test 3: Authenticate user
        System.out.println("\n2.3 Authenticating user...");
        User authenticatedUser = userDAO.authenticateUser("johndoe", "password123");
        if (authenticatedUser != null) {
            System.out.println("✓ User authentication successful!");
            System.out.println("Welcome, " + authenticatedUser.getName() + "!");
        } else {
            System.out.println("✗ User authentication failed!");
        }
        
        // Test 4: Check if username exists
        System.out.println("\n2.4 Checking username availability...");
        boolean usernameExists = userDAO.isUsernameExists("johndoe");
        System.out.println("Username 'johndoe' exists: " + usernameExists);
        
        boolean newUsernameExists = userDAO.isUsernameExists("newuser");
        System.out.println("Username 'newuser' exists: " + newUsernameExists);
        
        // Test 5: Get all users
        System.out.println("\n2.5 Retrieving all users...");
        List<User> allUsers = userDAO.getAllUsers();
        System.out.println("Total users found: " + allUsers.size());
        
        for (User user : allUsers) {
            System.out.println("- " + user.getUsername() + " (" + user.getRole() + ")");
        }
        
        // Test 6: Get users by role
        System.out.println("\n2.6 Retrieving users by role (customer)...");
        List<User> customers = userDAO.getUsersByRole("customer");
        System.out.println("Total customers found: " + customers.size());
        
        System.out.println("\n=== DAO Pattern Test Completed ===");
    }
}
