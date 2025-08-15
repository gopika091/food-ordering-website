package com.gsk.servlet;

import com.gsk.DAO.MenuDAO;
import com.gsk.DAO.RestaurantDAO;
import com.gsk.DAOimp.MenuDAOImpl;
import com.gsk.DAOimp.RestaurantDAOImpl;
import com.gsk.model.Menu;
import com.gsk.model.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurant")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MenuDAO menuDAO = new MenuDAOImpl();
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String restaurantIdParam = request.getParameter("id");
        System.out.println("RestaurantServlet: Received request with id parameter: " + restaurantIdParam);
        
        if (restaurantIdParam == null || restaurantIdParam.trim().isEmpty()) {
            System.out.println("RestaurantServlet: No id parameter, redirecting to index");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        try {
            int restaurantId = Integer.parseInt(restaurantIdParam);
            System.out.println("RestaurantServlet: Parsed restaurant ID: " + restaurantId);
            
            // Test database connection first
            try {
                java.sql.Connection testConn = com.gsk.util.DBConnection.getNewConnection();
                if (testConn != null) {
                    System.out.println("RestaurantServlet: Database connection successful");
                    testConn.close();
                } else {
                    System.out.println("RestaurantServlet: Database connection failed - null connection");
                }
            } catch (Exception dbEx) {
                System.out.println("RestaurantServlet: Database connection error: " + dbEx.getMessage());
                dbEx.printStackTrace();
            }
            
            // Get restaurant details
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
            System.out.println("RestaurantServlet: Restaurant found: " + (restaurant != null ? restaurant.getName() : "null"));
            
            if (restaurant == null) {
                System.out.println("RestaurantServlet: Restaurant is NULL - redirecting to index");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            if (!restaurant.isActive()) {
                System.out.println("RestaurantServlet: Restaurant is INACTIVE - redirecting to index");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            // Get available menu items for this restaurant
            List<Menu> menuItems = menuDAO.getAvailableMenuItemsByRestaurantId(restaurantId);
            System.out.println("RestaurantServlet: Found " + (menuItems != null ? menuItems.size() : 0) + " menu items");
            
            // Set attributes for JSP
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuItems", menuItems);
            
            System.out.println("RestaurantServlet: Forwarding to restaurant-menu.jsp");
            // Forward to restaurant menu page
            request.getRequestDispatcher("/customer/restaurant-menu.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.out.println("RestaurantServlet: Invalid restaurant ID format, redirecting");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (Exception e) {
            System.out.println("RestaurantServlet: Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
