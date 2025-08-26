package com.gsk.servlet;

import com.gsk.DAO.MenuDAO;
import com.gsk.DAOimp.MenuDAOImpl;
import com.gsk.model.Menu;
import com.gsk.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {
    
    private MenuDAO menuDAO;
    
    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show cart
            showCart(request, response);
        } else if (pathInfo.equals("/add")) {
            // Add item to cart
            addToCart(request, response);
        } else if (pathInfo.equals("/update")) {
            // Update quantity
            updateQuantity(request, response);
        } else if (pathInfo.equals("/remove")) {
            // Remove item from cart
            removeFromCart(request, response);
        } else if (pathInfo.equals("/clear")) {
            // Clear cart
            clearCart(request, response);
        } else {
            // Default: show cart
            showCart(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            String restaurantName = request.getParameter("restaurantName");
            
            // Get menu item details
            Menu menuItem = menuDAO.getMenuItemById(menuId);
            
            if (menuItem == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Menu item not found\"}");
                return;
            }
            
            // Get or create cart in session
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            
            // Check if item already exists in cart
            CartItem existingItem = null;
            for (CartItem item : cart) {
                if (item.getMenuId() == menuId) {
                    existingItem = item;
                    break;
                }
            }
            
            if (existingItem != null) {
                // Increase quantity
                existingItem.setQuantity(existingItem.getQuantity() + 1);
            } else {
                // Add new item
                CartItem newItem = new CartItem(
                    1, // userId (hardcoded for now)
                    restaurantId,
                    menuId,
                    menuItem.getItemName(),
                    menuItem.getDescription(),
                    menuItem.getPrice(),
                    restaurantName
                );
                cart.add(newItem);
            }
            
            // Calculate cart total
            double total = calculateCartTotal(cart);
            int itemCount = cart.size();
            
            // Return JSON response
            String jsonResponse = String.format(
                "{\"success\": true, \"message\": \"Added to cart\", \"total\": %.2f, \"itemCount\": %d}",
                total, itemCount
            );
            
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid parameters\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error adding to cart\"}");
        }
    }
    
    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                removeFromCart(request, response);
                return;
            }
            
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            
            if (cart != null) {
                for (CartItem item : cart) {
                    if (item.getMenuId() == menuId) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
            
            double total = calculateCartTotal(cart);
            String jsonResponse = String.format(
                "{\"success\": true, \"total\": %.2f}",
                total
            );
            
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid parameters\"}");
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            
            if (cart != null) {
                cart.removeIf(item -> item.getMenuId() == menuId);
            }
            
            double total = calculateCartTotal(cart);
            int itemCount = cart != null ? cart.size() : 0;
            
            String jsonResponse = String.format(
                "{\"success\": true, \"message\": \"Item removed\", \"total\": %.2f, \"itemCount\": %d}",
                total, itemCount
            );
            
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid parameters\"}");
        }
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        
        String jsonResponse = "{\"success\": true, \"message\": \"Cart cleared\", \"total\": 0.00, \"itemCount\": 0}";
        
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse);
    }
    
    private void showCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        double total = calculateCartTotal(cart);
        
        request.setAttribute("cartItems", cart);
        request.setAttribute("cartTotal", total);
        request.setAttribute("itemCount", cart.size());
        
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
    
    private double calculateCartTotal(List<CartItem> cart) {
        if (cart == null) return 0.0;
        
        double total = 0.0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
        return total;
    }
}
