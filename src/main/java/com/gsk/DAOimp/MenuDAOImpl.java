package com.gsk.DAOimp;

import com.gsk.DAO.MenuDAO;
import com.gsk.model.Menu;
import com.gsk.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    
    private Connection connection;
    
    public MenuDAOImpl() {
        this.connection = DBConnection.getConnection();
    }
    
    @Override
    public boolean addMenuItem(Menu menu) {
        String sql = "INSERT INTO menu (restaurant_id, item_name, description, price, ratings, is_available, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRatings());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public Menu getMenuItemById(int menuId) {
        String sql = "SELECT * FROM menu WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menuId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractMenuFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Menu> getAllMenuItems() {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu ORDER BY item_name";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public List<Menu> getMenuItemsByRestaurantId(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE restaurant_id = ? ORDER BY item_name";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public List<Menu> getAvailableMenuItemsByRestaurantId(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE restaurant_id = ? AND is_available = true ORDER BY item_name";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public List<Menu> searchMenuItemsByName(String itemName) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE item_name LIKE ? AND is_available = true ORDER BY item_name";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, "%" + itemName + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public List<Menu> getMenuItemsByPriceRange(double minPrice, double maxPrice) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE price BETWEEN ? AND ? AND is_available = true ORDER BY price";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDouble(1, minPrice);
            pstmt.setDouble(2, maxPrice);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public boolean updateMenuItem(Menu menu) {
        String sql = "UPDATE menu SET restaurant_id = ?, item_name = ?, description = ?, price = ?, ratings = ?, is_available = ?, image_path = ? WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRatings());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());
            pstmt.setInt(8, menu.getMenuId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateMenuItemPrice(int menuId, double price) {
        String sql = "UPDATE menu SET price = ? WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDouble(1, price);
            pstmt.setInt(2, menuId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateMenuItemAvailability(int menuId, boolean isAvailable) {
        String sql = "UPDATE menu SET is_available = ? WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, menuId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateMenuItemRating(int menuId, double rating) {
        String sql = "UPDATE menu SET ratings = ? WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDouble(1, rating);
            pstmt.setInt(2, menuId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteMenuItem(int menuId) {
        String sql = "DELETE FROM menu WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menuId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteMenuItemsByRestaurantId(int restaurantId) {
        String sql = "DELETE FROM menu WHERE restaurant_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Menu> getTopRatedMenuItems(int restaurantId, int limit) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE restaurant_id = ? AND is_available = true ORDER BY ratings DESC LIMIT ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    @Override
    public List<Menu> getMenuItemsSortedByRating(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE restaurant_id = ? AND is_available = true ORDER BY ratings DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                menuItems.add(extractMenuFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
    
    // Helper method to extract Menu object from ResultSet
    private Menu extractMenuFromResultSet(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("menu_id"));
        menu.setRestaurantId(rs.getInt("restaurant_id"));
        menu.setItemName(rs.getString("item_name"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setRatings(rs.getDouble("ratings"));
        menu.setAvailable(rs.getBoolean("is_available"));
        menu.setImagePath(rs.getString("image_path"));
        return menu;
    }
}
