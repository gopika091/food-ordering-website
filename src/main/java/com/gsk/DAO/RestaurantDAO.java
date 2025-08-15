package com.gsk.DAO;

import com.gsk.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    
    // Create - Insert a new restaurant
    boolean addRestaurant(Restaurant restaurant);
    
    // Read - Get restaurant by ID
    Restaurant getRestaurantById(int restaurantId);
    
    // Read - Get all restaurants
    List<Restaurant> getAllRestaurants();
    
    // Read - Get active restaurants only
    List<Restaurant> getActiveRestaurants();
    
    // Read - Get restaurants by cuisine type
    List<Restaurant> getRestaurantsByCuisine(String cuisineType);
    
    // Read - Get restaurants by admin user ID
    List<Restaurant> getRestaurantsByAdminId(int adminUserId);
    
    // Read - Search restaurants by name
    List<Restaurant> searchRestaurantsByName(String name);
    
    // Update - Update restaurant information
    boolean updateRestaurant(Restaurant restaurant);
    
    // Update - Update restaurant rating
    boolean updateRestaurantRating(int restaurantId, double rating);
    
    // Update - Update restaurant status (active/inactive)
    boolean updateRestaurantStatus(int restaurantId, boolean isActive);
    
    // Delete - Delete restaurant by ID
    boolean deleteRestaurant(int restaurantId);
    
    // Utility - Get restaurants sorted by rating (highest first)
    List<Restaurant> getRestaurantsSortedByRating();
    
    // Utility - Get restaurants within delivery time range
    List<Restaurant> getRestaurantsByDeliveryTime(String maxEta);
}
