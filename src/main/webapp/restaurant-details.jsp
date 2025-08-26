<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gsk.model.Restaurant" %>
<%@ page import="com.gsk.model.Menu" %>
<%@ page import="com.gsk.DAO.RestaurantDAO" %>
<%@ page import="com.gsk.DAO.MenuDAO" %>
<%@ page import="com.gsk.DAOimp.RestaurantDAOImpl" %>
<%@ page import="com.gsk.DAOimp.MenuDAOImpl" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu - FoodZone</title>
    <link rel="stylesheet" href="css/index.css">
    <style>
        .restaurant-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .restaurant-header h1 {
            margin: 0 0 10px 0;
            font-size: 2.5em;
        }
        
        .restaurant-meta {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        
        .meta-item {
            text-align: center;
        }
        
        .meta-value {
            font-size: 1.5em;
            font-weight: bold;
            display: block;
        }
        
        .meta-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        .menu-categories {
            margin: 30px 0;
        }
        
        .category-section {
            margin-bottom: 40px;
        }
        
        .category-title {
            font-size: 1.8em;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #007bff;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .menu-item {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .menu-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .menu-item-image {
            height: 150px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2em;
        }
        
        .menu-item-info {
            padding: 20px;
        }
        
        .menu-item-name {
            font-size: 1.3em;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }
        
        .menu-item-description {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        
        .menu-item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .menu-item-price {
            font-size: 1.4em;
            font-weight: 700;
            color: #28a745;
        }
        
        .add-to-cart-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.2s;
        }
        
        .add-to-cart-btn:hover {
            background: #0056b3;
        }
        
        .back-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            z-index: 1000;
            transition: background 0.2s;
        }
        
        .back-btn:hover {
            background: rgba(0,0,0,0.9);
        }
        
        .no-menu {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            font-size: 18px;
        }
        
        .no-menu h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .debug-info {
            background: #ffebee;
            padding: 20px;
            margin: 20px;
            border: 1px solid #f44336;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Back Button -->
    <a href="<%= request.getContextPath() %>/index.jsp" class="back-btn">← Back to Restaurants</a>
    
    <%
    // Get restaurant ID from parameter
    String restaurantIdParam = request.getParameter("id");
    Restaurant restaurant = null;
    List<Menu> menuItems = null;
    String errorMessage = null;
    
    if (restaurantIdParam != null && !restaurantIdParam.trim().isEmpty()) {
        try {
            int restaurantId = Integer.parseInt(restaurantIdParam);
            
            // Get restaurant details
            RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
            restaurant = restaurantDAO.getRestaurantById(restaurantId);
            
            if (restaurant != null && restaurant.isActive()) {
                // Get menu items
                MenuDAO menuDAO = new MenuDAOImpl();
                menuItems = menuDAO.getAvailableMenuItemsByRestaurantId(restaurantId);
            } else {
                errorMessage = "Restaurant not found or inactive";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Invalid restaurant ID: " + restaurantIdParam;
        } catch (Exception e) {
            errorMessage = "Database error: " + e.getMessage();
            e.printStackTrace();
        }
    } else {
        errorMessage = "No restaurant ID provided";
    }
    
    if (restaurant != null) {
    %>
        <!-- Restaurant Header -->
        <div class="restaurant-header">
            <h1><%= restaurant.getName() %></h1>
            <p><%= restaurant.getDescription() != null ? restaurant.getDescription() : "Delicious food awaits you!" %></p>
            <div class="restaurant-meta">
                <div class="meta-item">
                    <span class="meta-value">⭐ <%= restaurant.getRating() %></span>
                    <span class="meta-label">Rating</span>
                </div>
                <div class="meta-item">
                    <span class="meta-value">🍽️ <%= restaurant.getCuisineType() %></span>
                    <span class="meta-label">Cuisine</span>
                </div>
                <div class="meta-item">
                    <span class="meta-value">⏰ <%= restaurant.getDeliveryTime() != null ? restaurant.getDeliveryTime() : "30-40 mins" %></span>
                    <span class="meta-label">Delivery Time</span>
                </div>
                <div class="meta-item">
                    <span class="meta-value">📍 <%= restaurant.getAddress() != null ? restaurant.getAddress() : "Location" %></span>
                    <span class="meta-label">Address</span>
                </div>
            </div>
        </div>
        
        <div class="container">
            <!-- Menu Categories -->
            <div class="menu-categories">
                <%
                if (menuItems != null && !menuItems.isEmpty()) {
                    // Group menu items by category
                    Map<String, List<Menu>> categoryMap = new HashMap<>();
                    for (Menu item : menuItems) {
                        String category = item.getCategory();
                        if (!categoryMap.containsKey(category)) {
                            categoryMap.put(category, new ArrayList<>());
                        }
                        categoryMap.get(category).add(item);
                    }
                    
                    // Display menu items by category
                    for (Map.Entry<String, List<Menu>> entry : categoryMap.entrySet()) {
                        String category = entry.getKey();
                        List<Menu> items = entry.getValue();
                %>
                        <div class="category-section">
                            <h2 class="category-title"><%= category %></h2>
                            <div class="menu-grid">
                                <%
                                for (Menu item : items) {
                                %>
                                    <div class="menu-item">
                                        <div class="menu-item-image">
                                            <%
                                            // Show different emojis based on category
                                            if ("Starters".equals(category)) {
                                                out.print("🥗");
                                            } else if ("Main Course".equals(category)) {
                                                out.print("🍽️");
                                            } else if ("Desserts".equals(category)) {
                                                out.print("🍰");
                                            } else if ("Beverages".equals(category)) {
                                                out.print("🥤");
                                            } else if ("Rice & Breads".equals(category) || "Breads".equals(category)) {
                                                out.print("🍚");
                                            } else if ("Pizzas".equals(category)) {
                                                out.print("🍕");
                                            } else if ("Burgers".equals(category)) {
                                                out.print("🍔");
                                            } else if ("Kebabs".equals(category)) {
                                                out.print("🍖");
                                            } else if ("Sushi Rolls".equals(category) || "Nigiri".equals(category)) {
                                                out.print("🍱");
                                            } else if ("Tacos".equals(category)) {
                                                out.print("🌮");
                                            } else if ("Curries".equals(category)) {
                                                out.print("🍛");
                                            } else if ("Noodles".equals(category)) {
                                                out.print("🍜");
                                            } else if ("Soups".equals(category)) {
                                                out.print("🥣");
                                            } else if ("Sides".equals(category)) {
                                                out.print("🥗");
                                            } else if ("Dosas".equals(category)) {
                                                out.print("🥞");
                                            } else if ("Breakfast".equals(category)) {
                                                out.print("🍳");
                                            } else if ("Snacks".equals(category)) {
                                                out.print("🥨");
                                            } else if ("Sauces".equals(category)) {
                                                out.print("🥄");
                                            } else {
                                                out.print("🍽️");
                                            }
                                            %>
                                        </div>
                                        <div class="menu-item-info">
                                            <div class="menu-item-name"><%= item.getItemName() %></div>
                                            <div class="menu-item-description">
                                                <%= item.getDescription() != null ? item.getDescription() : "Delicious " + item.getItemName().toLowerCase() %>
                                            </div>
                                            <div class="menu-item-footer">
                                                <div class="menu-item-price">₹<%= String.format("%.2f", item.getPrice()) %></div>
                                                <button class="add-to-cart-btn" onclick="alert('Add to Cart: <%= item.getItemName() %>')">
                                                    Add to Cart
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }
                                %>
                            </div>
                        </div>
                <%
                    }
                } else {
                %>
                    <div class="no-menu">
                        <h3>No menu items available</h3>
                        <p>This restaurant's menu is currently being updated. Please check back later.</p>
                        <p><strong>Restaurant ID:</strong> <%= restaurantIdParam %></p>
                        <p><a href="<%= request.getContextPath() %>/test-db.jsp" style="color: #007bff;">🔍 Test Database Connection</a></p>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    <%
    } else {
    %>
        <!-- Debug Info Section -->
        <div class="container">
            <div class="debug-info">
                <h2 style="color: #d32f2f;">🚨 Restaurant Not Found</h2>
                <p><strong>Restaurant ID Parameter:</strong> <%= restaurantIdParam %></p>
                <p><strong>Error:</strong> <%= errorMessage %></p>
                <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
                <p><strong>Request URL:</strong> <%= request.getRequestURL() %></p>
                <p><strong>Query String:</strong> <%= request.getQueryString() %></p>
                
                <h3>Debug Steps:</h3>
                <ul>
                    <li><a href="<%= request.getContextPath() %>/test-db.jsp" style="color: #1976d2;">🔍 Test Database Connection</a></li>
                    <li><a href="<%= request.getContextPath() %>/debug-restaurant.jsp" style="color: #1976d2;">🔧 Debug Restaurant Links</a></li>
                    <li><a href="<%= request.getContextPath() %>/index.jsp" style="color: #1976d2;">🏠 Back to Homepage</a></li>
                </ul>
            </div>
        </div>
    <%
    }
    %>
    
    <!-- Footer -->
    <footer class="footer">
        <h3>FoodZone</h3>
        <p>Your favorite food, delivered fast</p>
        <div class="footer-links">
            <a href="#">About Us</a>
            <a href="#">Contact</a>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </div>
    </footer>
</body>
</html>
