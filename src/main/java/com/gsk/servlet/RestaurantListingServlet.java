package com.gsk.servlet;

import com.gsk.DAO.RestaurantDAO;
import com.gsk.DAOimp.RestaurantDAOImpl;
import com.gsk.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantListingServlet extends HttpServlet {
    
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cuisineFilter = request.getParameter("cuisine");
        String searchQuery = request.getParameter("search");
        String sortBy = request.getParameter("sort");
        
        List<Restaurant> restaurants;
        
        // Apply filters based on parameters
        if (cuisineFilter != null && !cuisineFilter.trim().isEmpty()) {
            restaurants = restaurantDAO.getRestaurantsByCuisine(cuisineFilter);
        } else if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            restaurants = restaurantDAO.searchRestaurantsByName(searchQuery);
        } else if ("rating".equals(sortBy)) {
            restaurants = restaurantDAO.getRestaurantsSortedByRating();
        } else {
            // Default: get all active restaurants
            restaurants = restaurantDAO.getActiveRestaurants();
        }
        
        // Set restaurants in request attribute
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("totalRestaurants", restaurants.size());
        
        // Forward to restaurant listing page
        request.getRequestDispatcher("/restaurant-listing.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
