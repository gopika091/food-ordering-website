package com.gsk.DAO;

import com.gsk.model.Menu;
import java.util.List;

public interface MenuDAO {
    
    // Create - Insert a new menu item
    boolean addMenuItem(Menu menu);
    
    // Read - Get menu item by ID
    Menu getMenuItemById(int menuId);
    
    // Read - Get all menu items
    List<Menu> getAllMenuItems();
    
    // Read - Get menu items by restaurant ID
    List<Menu> getMenuItemsByRestaurantId(int restaurantId);
    
    // Read - Get available menu items by restaurant ID
    List<Menu> getAvailableMenuItemsByRestaurantId(int restaurantId);
    
    // Read - Search menu items by name
    List<Menu> searchMenuItemsByName(String itemName);
    
    // Read - Get menu items by price range
    List<Menu> getMenuItemsByPriceRange(double minPrice, double maxPrice);
    
    // Update - Update menu item information
    boolean updateMenuItem(Menu menu);
    
    // Update - Update menu item price
    boolean updateMenuItemPrice(int menuId, double price);
    
    // Update - Update menu item availability
    boolean updateMenuItemAvailability(int menuId, boolean isAvailable);
    
    // Update - Update menu item rating
    boolean updateMenuItemRating(int menuId, double rating);
    
    // Delete - Delete menu item by ID
    boolean deleteMenuItem(int menuId);
    
    // Delete - Delete all menu items by restaurant ID
    boolean deleteMenuItemsByRestaurantId(int restaurantId);
    
    // Utility - Get top-rated menu items by restaurant
    List<Menu> getTopRatedMenuItems(int restaurantId, int limit);
    
    // Utility - Get menu items sorted by rating (highest first)
    List<Menu> getMenuItemsSortedByRating(int restaurantId);
}
