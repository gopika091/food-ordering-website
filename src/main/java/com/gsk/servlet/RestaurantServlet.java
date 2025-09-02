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
    private final MenuDAO menuDAO = new MenuDAOImpl();
    private final RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String restaurantIdParam = request.getParameter("id");

        try {
            if (restaurantIdParam == null || restaurantIdParam.trim().isEmpty()) {
                // No ID → go back to index where all restaurants are shown
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                // 👉 ID present → show single restaurant details
                int restaurantId = Integer.parseInt(restaurantIdParam);

                Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
                if (restaurant == null || !restaurant.isActive()) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }

                List<Menu> menuItems = menuDAO.getAvailableMenuItemsByRestaurantId(restaurantId);

                request.setAttribute("restaurant", restaurant);
                request.setAttribute("menuItems", menuItems);

                request.getRequestDispatcher("/restaurant-menu.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            // invalid ID → redirect to all restaurants
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
