package com.gsk.DAO;

import com.gsk.model.Menu;
import java.util.List;

public interface MenuDAO {
    
    // Create - Insert a new menu item
    boolean addMenuItem(Menu menuItem);
    
    // Read - Get menu item by ID
    Menu getMenuItemById(int menuId);
    
    // Read - Get all menu items for a restaurant
    List<Menu> getMenuItemsByRestaurantId(int restaurantId);
    
    // Read - Get available menu items for a restaurant
    List<Menu> getAvailableMenuItemsByRestaurantId(int restaurantId);
    
    // Read - Get menu items by category
    List<Menu> getMenuItemsByCategory(int restaurantId, String category);
    
    // Read - Search menu items by name
    List<Menu> searchMenuItemsByName(int restaurantId, String name);
    
    // Update - Update menu item information
    boolean updateMenuItem(Menu menuItem);
    
    // Update - Update menu item availability
    boolean updateMenuItemAvailability(int menuId, boolean isAvailable);
    
    // Update - Update menu item price
    boolean updateMenuItemPrice(int menuId, double price);
    
    // Delete - Delete menu item by ID
    boolean deleteMenuItem(int menuId);
    
    // Utility - Get menu items sorted by price
    List<Menu> getMenuItemsSortedByPrice(int restaurantId, boolean ascending);
    
    // Utility - Get menu items sorted by category
    List<Menu> getMenuItemsSortedByCategory(int restaurantId);
}
