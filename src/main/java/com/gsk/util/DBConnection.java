package com.gsk.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // Database configuration
    private static final String URL = "jdbc:mysql://localhost:3306/food_ordering_db";
    private static final String USERNAME = "root";  // Change as per your MySQL setup
    private static final String PASSWORD = "root";  // Change as per your MySQL setup
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Static connection instance
    private static Connection connection = null;
    
    // Private constructor to prevent instantiation
    private DBConnection() {}
    
    /**
     * Get database connection
     * @return Connection object
     */
    public static Connection getConnection() {
        if (connection == null) {
            try {
                // Load MySQL JDBC driver
                Class.forName(DRIVER);
                
                // Create connection
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                System.out.println("Database connected successfully!");
                
            } catch (ClassNotFoundException e) {
                System.err.println("MySQL JDBC Driver not found!");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Failed to create database connection!");
                e.printStackTrace();
            }
        }
        return connection;
    }
    
    /**
     * Get a new database connection (for multi-threading scenarios)
     * @return New Connection object
     */
    public static Connection getNewConnection() {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to create database connection!");
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Close the database connection
     */
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
                System.out.println("Database connection closed!");
            } catch (SQLException e) {
                System.err.println("Failed to close database connection!");
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connectivity
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        try {
            Connection testConn = getNewConnection();
            if (testConn != null && !testConn.isClosed()) {
                testConn.close();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
