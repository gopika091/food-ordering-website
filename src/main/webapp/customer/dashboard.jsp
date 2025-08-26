
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gsk.model.Restaurant" %>
<%@ page import="com.gsk.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - FoodZone</title>
    <link rel="stylesheet" href="../css/index.css">
    <style>
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .welcome-message {
            font-size: 1.2em;
            margin-bottom: 20px;
            opacity: 0.9;
        }
        
        .user-info {
            background: rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
        }
        
        .user-info h3 {
            margin: 0 0 10px 0;
            font-size: 1.5em;
        }
        
        .user-stats {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 20px 0;
            flex-wrap: wrap;
        }
        
        .stat-item {
            text-align: center;
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 10px;
            min-width: 120px;
        }
        
        .stat-value {
            font-size: 2em;
            font-weight: bold;
            display: block;
        }
        
        .stat-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        .quick-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 30px 0;
            flex-wrap: wrap;
        }
        
        .action-btn {
            background: white;
            color: #667eea;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        
        .action-btn:hover {
            background: transparent;
            color: white;
            border-color: white;
            transform: translateY(-2px);
        }
        
        .restaurants-section {
            margin: 40px 0;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .section-title h2 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .restaurants-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .restaurant-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }
        
        .restaurant-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .restaurant-image {
            height: 150px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3em;
        }
        
        .restaurant-info {
            padding: 20px;
        }
        
        .restaurant-name {
            font-size: 1.3em;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }
        
        .restaurant-details {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .cuisine-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }
        
        .cuisine-tag {
            background: #f8f9fa;
            color: #495057;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: 500;
        }
        
        .delivery-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9em;
            color: #666;
        }
        
        .rating {
            color: #ffc107;
            font-weight: 600;
        }
        
        .logout-section {
            text-align: center;
            margin: 40px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .logout-btn {
            background: #dc3545;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.2s;
        }
        
        .logout-btn:hover {
            background: #c82333;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 6px;
            margin: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
    User user = (User) request.getAttribute("user");
    List<Restaurant> featuredRestaurants = (List<Restaurant>) request.getAttribute("featuredRestaurants");
    String error = (String) request.getAttribute("error");
    
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    %>
    
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Welcome back, <%= user.getUsername() %>! 👋</h1>
        <p class="welcome-message">Ready to discover amazing food? Here's what's happening today.</p>
        
        <div class="user-info">
            <h3>Your Account</h3>
            <p>Email: <%= user.getEmail() != null ? user.getEmail() : "Not provided" %></p>
            <p>Member since: <%= user.getRegistrationDate() != null ? user.getRegistrationDate() : "Recently" %></p>
        </div>
        
        <div class="user-stats">
            <div class="stat-item">
                <span class="stat-value">0</span>
                <span class="stat-label">Orders</span>
            </div>
            <div class="stat-item">
                <span class="stat-value">0</span>
                <span class="stat-label">Favorites</span>
            </div>
            <div class="stat-item">
                <span class="stat-value">₹0</span>
                <span class="stat-label">Saved</span>
            </div>
        </div>
        
        <div class="quick-actions">
            <a href="<%= request.getContextPath() %>/index.jsp" class="action-btn">🍽️ Browse Restaurants</a>
            <a href="<%= request.getContextPath() %>/cart" class="action-btn">🛒 View Cart</a>
            <a href="<%= request.getContextPath() %>/" class="action-btn">🏠 Go Home</a>
        </div>
    </div>
    
    <div class="container">
        <%
        if (error != null) {
        %>
            <div class="error-message">
                <strong>Error:</strong> <%= error %>
            </div>
        <%
        }
        %>
        
        <!-- Featured Restaurants -->
        <div class="restaurants-section">
            <div class="section-title">
                <h2>🍽️ Featured Restaurants</h2>
                <p>Discover the best restaurants in your area</p>
            </div>
            
            <%
            if (featuredRestaurants != null && !featuredRestaurants.isEmpty()) {
            %>
                <div class="restaurants-grid">
                    <%
                    for (Restaurant restaurant : featuredRestaurants) {
                    %>
                        <div class="restaurant-card" onclick="window.location.href='<%= request.getContextPath() %>/restaurant?id=<%= restaurant.getRestaurantId() %>'">
                            <div class="restaurant-image">
                                <%
                                String cuisineType = restaurant.getCuisineType();
                                if ("Italian".equals(cuisineType)) {
                                    out.print("🍕");
                                } else if ("Indian".equals(cuisineType)) {
                                    out.print("🍛");
                                } else if ("Chinese".equals(cuisineType)) {
                                    out.print("🍜");
                                } else if ("Mexican".equals(cuisineType)) {
                                    out.print("🌮");
                                } else if ("American".equals(cuisineType)) {
                                    out.print("🍔");
                                } else if ("Thai".equals(cuisineType)) {
                                    out.print("🍜");
                                } else if ("Japanese".equals(cuisineType)) {
                                    out.print("🍱");
                                } else if ("Mediterranean".equals(cuisineType)) {
                                    out.print("🥗");
                                } else {
                                    out.print("🍽️");
                                }
                                %>
                            </div>
                            <div class="restaurant-info">
                                <div class="restaurant-name"><%= restaurant.getName() %></div>
                                <div class="restaurant-details">
                                    📍 <%= restaurant.getAddress() != null ? restaurant.getAddress().length() > 25 ? restaurant.getAddress().substring(0, 25) + "..." : restaurant.getAddress() : "Location" %>
                                </div>
                                <div class="cuisine-tags">
                                    <span class="cuisine-tag"><%= restaurant.getCuisineType() %></span>
                                    <% if (restaurant.getRating() >= 4.0) { %>
                                        <span class="cuisine-tag" style="background: #d4edda; color: #155724;">Top Rated</span>
                                    <% } %>
                                </div>
                                <div class="delivery-info">
                                    <span class="rating">⭐ <%= restaurant.getRating() %></span>
                                    <span>⏰ <%= restaurant.getDeliveryTime() != null ? restaurant.getDeliveryTime() : "30-40 mins" %></span>
                                </div>
                            </div>
                        </div>
                    <%
                    }
                    %>
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary">View All Restaurants</a>
                </div>
            <%
            } else {
            %>
                <div style="text-align: center; padding: 40px; color: #666;">
                    <h3>No restaurants available</h3>
                    <p>Please check back later or contact support.</p>
                </div>
            <%
            }
            %>
        </div>
        
        <!-- Logout Section -->
        <div class="logout-section">
            <h3>Need to take a break?</h3>
            <p>You can log out and come back anytime.</p>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
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
