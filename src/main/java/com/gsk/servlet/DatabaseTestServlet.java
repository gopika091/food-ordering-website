package com.gsk.servlet;

import com.gsk.DAO.RestaurantDAO;
import com.gsk.DAO.MenuDAO;
import com.gsk.DAOimp.RestaurantDAOImpl;
import com.gsk.DAOimp.MenuDAOImpl;
import com.gsk.model.Restaurant;
import com.gsk.model.Menu;
import com.gsk.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/test-db")
public class DatabaseTestServlet extends HttpServlet {
    
    private RestaurantDAO restaurantDAO;
    private MenuDAO menuDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html><head><title>Database Test</title></head><body>");
        response.getWriter().println("<h1>Database Connection Test</h1>");
        
        try {
            // Test database connection
            response.getWriter().println("<h2>1. Testing Database Connection</h2>");
            Connection con = DBConnection.getNewConnection();
            if (con != null && !con.isClosed()) {
                response.getWriter().println("<p style='color: green;'>✅ Database connection successful!</p>");
                con.close();
            } else {
                response.getWriter().println("<p style='color: red;'>❌ Database connection failed!</p>");
            }
            
            // Test restaurant data
            response.getWriter().println("<h2>2. Testing Restaurant Data</h2>");
            List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
            if (restaurants != null && !restaurants.isEmpty()) {
                response.getWriter().println("<p style='color: green;'>✅ Found " + restaurants.size() + " restaurants</p>");
                response.getWriter().println("<ul>");
                for (int i = 0; i < Math.min(5, restaurants.size()); i++) {
                    Restaurant r = restaurants.get(i);
                    response.getWriter().println("<li>ID: " + r.getRestaurantId() + " - " + r.getName() + " (" + r.getCuisineType() + ")</li>");
                }
                response.getWriter().println("</ul>");
                
                // Test specific restaurant
                if (!restaurants.isEmpty()) {
                    Restaurant testRestaurant = restaurants.get(0);
                    response.getWriter().println("<h3>Testing Restaurant ID: " + testRestaurant.getRestaurantId() + "</h3>");
                    
                    Restaurant foundRestaurant = restaurantDAO.getRestaurantById(testRestaurant.getRestaurantId());
                    if (foundRestaurant != null) {
                        response.getWriter().println("<p style='color: green;'>✅ Restaurant found: " + foundRestaurant.getName() + "</p>");
                    } else {
                        response.getWriter().println("<p style='color: red;'>❌ Restaurant not found by ID!</p>");
                    }
                }
            } else {
                response.getWriter().println("<p style='color: red;'>❌ No restaurants found!</p>");
            }
            
            // Test menu data
            response.getWriter().println("<h2>3. Testing Menu Data</h2>");
            if (!restaurants.isEmpty()) {
                int testRestaurantId = restaurants.get(0).getRestaurantId();
                response.getWriter().println("<p>Testing menu for restaurant ID: " + testRestaurantId + "</p>");
                
                List<Menu> menuItems = menuDAO.getAvailableMenuItemsByRestaurantId(testRestaurantId);
                if (menuItems != null && !menuItems.isEmpty()) {
                    response.getWriter().println("<p style='color: green;'>✅ Found " + menuItems.size() + " menu items</p>");
                    response.getWriter().println("<ul>");
                    for (int i = 0; i < Math.min(5, menuItems.size()); i++) {
                        Menu m = menuItems.get(i);
                        response.getWriter().println("<li>ID: " + m.getMenuId() + " - " + m.getItemName() + " (₹" + m.getPrice() + ") - " + m.getCategory() + "</li>");
                    }
                    response.getWriter().println("</ul>");
                } else {
                    response.getWriter().println("<p style='color: red;'>❌ No menu items found for restaurant ID: " + testRestaurantId + "</p>");
                    
                    // Test if restaurant exists in menu table
                    response.getWriter().println("<p>Checking if restaurant exists in menu table...</p>");
                    List<Menu> allMenuItems = menuDAO.getMenuItemsByRestaurantId(testRestaurantId);
                    if (allMenuItems != null && !allMenuItems.isEmpty()) {
                        response.getWriter().println("<p style='color: orange;'>⚠️ Found " + allMenuItems.size() + " menu items (including unavailable ones)</p>");
                    } else {
                        response.getWriter().println("<p style='color: red;'>❌ No menu items at all for this restaurant!</p>");
                    }
                }
            }
            
        } catch (Exception e) {
            response.getWriter().println("<p style='color: red;'>❌ Error during testing: " + e.getMessage() + "</p>");
            e.printStackTrace(response.getWriter());
        }
        
        response.getWriter().println("<hr><p><a href='" + request.getContextPath() + "'>Back to Home</a></p>");
        response.getWriter().println("</body></html>");
    }
}
