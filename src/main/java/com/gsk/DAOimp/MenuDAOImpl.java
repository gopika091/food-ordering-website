package com.gsk.DAOimp;

import com.gsk.DAO.MenuDAO;
import com.gsk.model.Menu;
import com.gsk.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    // SQL queries
    private static final String INSERT_MENU_ITEM_SQL = 
        "INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath, isAvailable) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_MENU_ITEM_BY_ID = 
        "SELECT * FROM menu WHERE menuId = ?";
    private static final String SELECT_MENU_ITEMS_BY_RESTAURANT = 
        "SELECT * FROM menu WHERE restaurantId = ?";
    private static final String SELECT_AVAILABLE_MENU_ITEMS_BY_RESTAURANT = 
        "SELECT * FROM menu WHERE restaurantId = ? AND isAvailable = 1";
    private static final String SELECT_MENU_ITEMS_BY_CATEGORY = 
        "SELECT * FROM menu WHERE restaurantId = ? AND category = ?";
    private static final String SELECT_MENU_ITEMS_BY_NAME = 
        "SELECT * FROM menu WHERE restaurantId = ? AND itemName LIKE ?";
    private static final String UPDATE_MENU_ITEM_SQL = 
        "UPDATE menu SET itemName = ?, description = ?, price = ?, category = ?, imagePath = ?, isAvailable = ? WHERE menuId = ?";
    private static final String UPDATE_MENU_ITEM_AVAILABILITY = 
        "UPDATE menu SET isAvailable = ? WHERE menuId = ?";
    private static final String UPDATE_MENU_ITEM_PRICE = 
        "UPDATE menu SET price = ? WHERE menuId = ?";
    private static final String DELETE_MENU_ITEM_SQL = 
        "DELETE FROM menu WHERE menuId = ?";
    private static final String SELECT_SORTED_BY_PRICE = 
        "SELECT * FROM menu WHERE restaurantId = ? ORDER BY price " + 
        "CASE WHEN ? = 1 THEN ASC ELSE DESC END";
    private static final String SELECT_SORTED_BY_CATEGORY = 
        "SELECT * FROM menu WHERE restaurantId = ? ORDER BY category";
    
    // Helper method to map a ResultSet row to a Menu object
    private Menu mapResultSetToMenu(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("menuId"));
        menu.setRestaurantId(rs.getInt("restaurantId"));
        menu.setItemName(rs.getString("itemName"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setCategory(rs.getString("category"));
        menu.setAvailable(rs.getBoolean("isAvailable"));
        menu.setImagePath(rs.getString("imagePath"));
        return menu;
    }

    @Override
    public boolean addMenuItem(Menu menuItem) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_MENU_ITEM_SQL)) {
            ps.setInt(1, menuItem.getRestaurantId());
            ps.setString(2, menuItem.getItemName());
            ps.setString(3, menuItem.getDescription());
            ps.setDouble(4, menuItem.getPrice());
            ps.setString(5, menuItem.getCategory());
            ps.setString(6, menuItem.getImagePath());
            ps.setBoolean(7, menuItem.isAvailable());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Menu getMenuItemById(int menuId) {
        Menu menu = null;
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_ITEM_BY_ID)) {
            ps.setInt(1, menuId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    menu = mapResultSetToMenu(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    @Override
    public List<Menu> getMenuItemsByRestaurantId(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_ITEMS_BY_RESTAURANT)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }

    @Override
    public List<Menu> getAvailableMenuItemsByRestaurantId(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_AVAILABLE_MENU_ITEMS_BY_RESTAURANT)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }

    @Override
    public List<Menu> getMenuItemsByCategory(int restaurantId, String category) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_ITEMS_BY_CATEGORY)) {
            ps.setInt(1, restaurantId);
            ps.setString(2, category);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }

    @Override
    public List<Menu> searchMenuItemsByName(int restaurantId, String name) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_ITEMS_BY_NAME)) {
            ps.setInt(1, restaurantId);
            ps.setString(2, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }

    @Override
    public boolean updateMenuItem(Menu menuItem) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_MENU_ITEM_SQL)) {
            ps.setString(1, menuItem.getItemName());
            ps.setString(2, menuItem.getDescription());
            ps.setDouble(3, menuItem.getPrice());
            ps.setString(4, menuItem.getCategory());
            ps.setString(5, menuItem.getImagePath());
            ps.setBoolean(6, menuItem.isAvailable());
            ps.setInt(7, menuItem.getMenuId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateMenuItemAvailability(int menuId, boolean isAvailable) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_MENU_ITEM_AVAILABILITY)) {
            ps.setBoolean(1, isAvailable);
            ps.setInt(2, menuId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateMenuItemPrice(int menuId, double price) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_MENU_ITEM_PRICE)) {
            ps.setDouble(1, price);
            ps.setInt(2, menuId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteMenuItem(int menuId) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_MENU_ITEM_SQL)) {
            ps.setInt(1, menuId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Menu> getMenuItemsSortedByPrice(int restaurantId, boolean ascending) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_SORTED_BY_PRICE)) {
            ps.setInt(1, restaurantId);
            ps.setBoolean(2, ascending);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }

    @Override
    public List<Menu> getMenuItemsSortedByCategory(int restaurantId) {
        List<Menu> menuItems = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_SORTED_BY_CATEGORY)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenu(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuItems;
    }
}
