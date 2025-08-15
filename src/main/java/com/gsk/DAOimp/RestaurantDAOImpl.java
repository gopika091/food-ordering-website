package com.gsk.DAOimp;



import com.gsk.DAO.RestaurantDAO;
import com.gsk.model.Restaurant;
import com.gsk.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    // SQL queries
    private static final String INSERT_RESTAURANT_SQL = 
        "INSERT INTO restaurants (name, address, phone, cuisineType, deliveryTime, adminUserId, imagePath, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_RESTAURANT_BY_ID = 
        "SELECT * FROM restaurants WHERE restaurantId = ?";
    private static final String SELECT_ALL_RESTAURANTS = 
        "SELECT * FROM restaurants";
    private static final String SELECT_ACTIVE_RESTAURANTS = 
    	    "SELECT * FROM restaurants WHERE isActive = 1";

    private static final String SELECT_RESTAURANTS_BY_CUISINE = 
        "SELECT * FROM restaurants WHERE cuisineType = ?";
    private static final String SELECT_RESTAURANTS_BY_ADMIN_ID = 
        "SELECT * FROM restaurants WHERE adminUserId = ?";
    private static final String SELECT_RESTAURANTS_BY_NAME =
        "SELECT * FROM restaurants WHERE name LIKE ?";
    private static final String UPDATE_RESTAURANT_SQL = 
        "UPDATE restaurants SET name = ?, address = ?, phone = ?, cuisine_type = ?, is_active = ?, eta = ?, image_path = ? WHERE restaurant_id = ?";
    private static final String UPDATE_RESTAURANT_RATING = 
        "UPDATE restaurants SET rating = ? WHERE restaurant_id = ?";
    private static final String UPDATE_RESTAURANT_STATUS = 
        "UPDATE restaurants SET is_active = ? WHERE restaurant_id = ?";
    private static final String DELETE_RESTAURANT_SQL = 
        "DELETE FROM restaurants WHERE restaurant_id = ?";
    private static final String SELECT_SORTED_BY_RATING =
        "SELECT * FROM restaurants ORDER BY rating DESC";
    private static final String SELECT_BY_DELIVERY_TIME =
        "SELECT * FROM restaurants WHERE eta <= ?";
    
    // Helper method to map a ResultSet row to a Restaurant object
    private Restaurant mapResultSetToRestaurant(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurantId(rs.getInt("restaurantId"));
        restaurant.setName(rs.getString("name"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setPhone(rs.getString("phone"));
        restaurant.setRating(rs.getDouble("rating"));
        restaurant.setCuisineType(rs.getString("cuisineType"));
        restaurant.setActive(rs.getBoolean("isActive"));
        restaurant.setDeliveryTime(rs.getString("deliveryTime"));
        restaurant.setAdminUserId(rs.getInt("adminUserId"));
        restaurant.setImagePath(rs.getString("imagePath"));
        return restaurant;
    }

    @Override
    public boolean addRestaurant(Restaurant restaurant) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_RESTAURANT_SQL)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhone());
            ps.setString(4, restaurant.getCuisineType());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setInt(6, restaurant.getAdminUserId());
            ps.setString(7, restaurant.getImagePath());
            ps.setBoolean(8, restaurant.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        Restaurant restaurant = null;
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANT_BY_ID)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    restaurant = mapResultSetToRestaurant(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL_RESTAURANTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }
    
    @Override
    public List<Restaurant> getActiveRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_ACTIVE_RESTAURANTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }


    @Override
    public List<Restaurant> getRestaurantsByCuisine(String cuisineType) {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANTS_BY_CUISINE)) {
            ps.setString(1, cuisineType);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public List<Restaurant> getRestaurantsByAdminId(int adminUserId) {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANTS_BY_ADMIN_ID)) {
            ps.setInt(1, adminUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public List<Restaurant> searchRestaurantsByName(String name) {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANTS_BY_NAME)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public boolean updateRestaurant(Restaurant restaurant) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_RESTAURANT_SQL)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getAddress());
            ps.setString(3, restaurant.getPhone());
            ps.setString(4, restaurant.getCuisineType());
            ps.setBoolean(5, restaurant.isActive());
            ps.setString(6, restaurant.getDeliveryTime());
            ps.setString(7, restaurant.getImagePath());
            ps.setInt(8, restaurant.getRestaurantId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateRestaurantRating(int restaurantId, double rating) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_RESTAURANT_RATING)) {
            ps.setDouble(1, rating);
            ps.setInt(2, restaurantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateRestaurantStatus(int restaurantId, boolean isActive) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_RESTAURANT_STATUS)) {
            ps.setBoolean(1, isActive);
            ps.setInt(2, restaurantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteRestaurant(int restaurantId) {
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_RESTAURANT_SQL)) {
            ps.setInt(1, restaurantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Restaurant> getRestaurantsSortedByRating() {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_SORTED_BY_RATING);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public List<Restaurant> getRestaurantsByDeliveryTime(String maxEta) {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection con = DBConnection.getNewConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_DELIVERY_TIME)) {
            ps.setString(1, maxEta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }
}