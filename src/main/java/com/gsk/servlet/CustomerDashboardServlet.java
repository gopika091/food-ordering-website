
package com.gsk.servlet;

import com.gsk.DAO.RestaurantDAO;
import com.gsk.DAOimp.RestaurantDAOImpl;
import com.gsk.model.Restaurant;
import com.gsk.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer/dashboard")
public class CustomerDashboardServlet extends HttpServlet {
    
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Check if user is a customer
        if (!"CUSTOMER".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Get featured restaurants for customer
            List<Restaurant> featuredRestaurants = restaurantDAO.getActiveRestaurants();
            
            // Limit to 8 restaurants for dashboard
            if (featuredRestaurants.size() > 8) {
                featuredRestaurants = featuredRestaurants.subList(0, 8);
            }
            
            // Set attributes for JSP
            request.setAttribute("user", user);
            request.setAttribute("featuredRestaurants", featuredRestaurants);
            request.setAttribute("totalRestaurants", featuredRestaurants.size());
            
            // Forward to customer dashboard
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
