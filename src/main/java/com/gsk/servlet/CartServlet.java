package com.gsk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gsk.DAO.MenuDAO;
import com.gsk.DAOimp.MenuDAOImpl;
import com.gsk.model.Menu;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MenuDAO menuDAO = new MenuDAOImpl();

    // Inner class to represent cart items
    public static class CartItem {
        private int menuId;
        private String itemName;
        private double price;
        private int quantity;
        private int restaurantId;
        private String restaurantName;
        private String imagePath;

        // Constructors
        public CartItem() {}

        public CartItem(int menuId, String itemName, double price, int quantity, 
                       int restaurantId, String restaurantName, String imagePath) {
            this.menuId = menuId;
            this.itemName = itemName;
            this.price = price;
            this.quantity = quantity;
            this.restaurantId = restaurantId;
            this.restaurantName = restaurantName;
            this.imagePath = imagePath;
        }

        // Getters and Setters
        public int getMenuId() { return menuId; }
        public void setMenuId(int menuId) { this.menuId = menuId; }
        
        public String getItemName() { return itemName; }
        public void setItemName(String itemName) { this.itemName = itemName; }
        
        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }
        
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
        
        public int getRestaurantId() { return restaurantId; }
        public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
        
        public String getRestaurantName() { return restaurantName; }
        public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }
        
        public String getImagePath() { return imagePath; }
        public void setImagePath(String imagePath) { this.imagePath = imagePath; }
        
        public double getSubtotal() {
            return price * quantity;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Forward to cart JSP page
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                handleAddToCart(request, response, out);
            } else if ("update".equals(action)) {
                handleUpdateCart(request, response, out);
            } else if ("remove".equals(action)) {
                handleRemoveFromCart(request, response, out);
            } else if ("clear".equals(action)) {
                handleClearCart(request, response, out);
            } else {
                out.write("{\"success\":false,\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            out.write("{\"success\":false,\"message\":\"Server error: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response,
                                PrintWriter out) throws IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = getCartFromSession(session);
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Get menu item details from database
            Menu menuItem = menuDAO.getMenuItemById(menuId);
            if (menuItem == null || !menuItem.isAvailable()) {
                out.write("{\"success\":false,\"message\":\"Item not available\"}");
                return;
            }
            
            // Check if item already exists in cart
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getMenuId() == menuId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }
            
            if (!found) {
                // Add new item to cart
                CartItem newItem = new CartItem(
                    menuId,
                    menuItem.getItemName(),
                    menuItem.getPrice(),
                    quantity,
                    menuItem.getRestaurantId(),
                    "",  // Restaurant name will be set if needed
                    menuItem.getImagePath()
                );
                cart.add(newItem);
            }
            
            session.setAttribute("cart", cart);
            
            int totalItems = getTotalCartItems(cart);
            out.write("{\"success\":true,\"message\":\"Item added to cart\",\"cartCount\":" + totalItems + "}");
            
        } catch (NumberFormatException e) {
            out.write("{\"success\":false,\"message\":\"Invalid parameters\"}");
        }
    }

    private void handleUpdateCart(HttpServletRequest request, HttpServletResponse response,
                                 PrintWriter out) throws IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = getCartFromSession(session);
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                // Remove item if quantity is 0 or negative
                cart.removeIf(item -> item.getMenuId() == menuId);
            } else {
                // Update quantity
                for (CartItem item : cart) {
                    if (item.getMenuId() == menuId) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
            
            session.setAttribute("cart", cart);
            
            int totalItems = getTotalCartItems(cart);
            out.write("{\"success\":true,\"message\":\"Cart updated\",\"cartCount\":" + totalItems + "}");
            
        } catch (NumberFormatException e) {
            out.write("{\"success\":false,\"message\":\"Invalid parameters\"}");
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response,
                                     PrintWriter out) throws IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = getCartFromSession(session);
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            cart.removeIf(item -> item.getMenuId() == menuId);
            
            session.setAttribute("cart", cart);
            
            int totalItems = getTotalCartItems(cart);
            out.write("{\"success\":true,\"message\":\"Item removed from cart\",\"cartCount\":" + totalItems + "}");
            
        } catch (NumberFormatException e) {
            out.write("{\"success\":false,\"message\":\"Invalid parameters\"}");
        }
    }

    private void handleClearCart(HttpServletRequest request, HttpServletResponse response,
                                PrintWriter out) throws IOException {
        
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        
        out.write("{\"success\":true,\"message\":\"Cart cleared\",\"cartCount\":0}");
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCartFromSession(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private int getTotalCartItems(List<CartItem> cart) {
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }
}
