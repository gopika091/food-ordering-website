<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gsk.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurants - FoodZone</title>
    <link rel="stylesheet" href="css/index.css">
    <style>
        .filters-section {
            background: #f8f9fa;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
        }
        
        .filter-row {
            display: flex;
            gap: 20px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .filter-group label {
            font-weight: 600;
            color: #333;
        }
        
        .filter-group select,
        .filter-group input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .filter-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .filter-btn:hover {
            background: #0056b3;
        }
        
        .results-info {
            margin: 20px 0;
            padding: 15px;
            background: #e9ecef;
            border-radius: 6px;
            font-size: 16px;
        }
        
        .restaurants-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
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
            height: 200px;
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
        
        .restaurant-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .restaurant-name {
            font-size: 20px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }
        
        .restaurant-details {
            color: #666;
            font-size: 14px;
        }
        
        .rating {
            background: #28a745;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
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
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .delivery-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #666;
            font-size: 14px;
        }
        
        .delivery-time {
            color: #dc3545;
            font-weight: 600;
        }
        
        .no-restaurants {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            font-size: 18px;
        }
        
        .no-restaurants h3 {
            color: #333;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="logo">🍕 FoodZone</a>
            <div class="nav-buttons">
                <a href="login.jsp" class="btn btn-outline">Login</a>
                <a href="register.jsp" class="btn btn-primary">Sign Up</a>
            </div>
        </div>
    </nav>
    
    <div class="container">
        <!-- Page Header -->
        <div class="section-title" style="margin-top: 40px;">
            <h1>All Restaurants</h1>
            <p>Discover amazing restaurants and cuisines</p>
        </div>
        
        <!-- Filters Section -->
        <div class="filters-section">
            <form action="<%= request.getContextPath() %>/restaurants" method="GET" class="filter-row">
                <div class="filter-group">
                    <label for="search">Search Restaurants</label>
                    <input type="text" id="search" name="search" placeholder="Restaurant name..." 
                           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" style="min-width: 200px;">
                </div>
                
                <div class="filter-group">
                    <label for="cuisine">Cuisine Type</label>
                    <select id="cuisine" name="cuisine">
                        <option value="">All Cuisines</option>
                        <option value="Italian" <%= "Italian".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Italian</option>
                        <option value="Indian" <%= "Indian".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Indian</option>
                        <option value="Chinese" <%= "Chinese".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Chinese</option>
                        <option value="Mexican" <%= "Mexican".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Mexican</option>
                        <option value="American" <%= "American".equals(request.getParameter("cuisine")) ? "selected" : "" %>>American</option>
                        <option value="Thai" <%= "Thai".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Thai</option>
                        <option value="Japanese" <%= "Japanese".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Japanese</option>
                        <option value="Mediterranean" <%= "Mediterranean".equals(request.getParameter("cuisine")) ? "selected" : "" %>>Mediterranean</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="sort">Sort By</label>
                    <select id="sort" name="sort">
                        <option value="">Default</option>
                        <option value="rating" <%= "rating".equals(request.getParameter("sort")) ? "selected" : "" %>>Highest Rated</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="filter-btn">Apply Filters</button>
                </div>
            </form>
        </div>
        
        <!-- Results Info -->
        <div class="results-info">
            <%
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
            int totalRestaurants = restaurants != null ? restaurants.size() : 0;
            String searchParam = request.getParameter("search");
            String cuisineParam = request.getParameter("cuisine");
            %>
            <strong><%= totalRestaurants %></strong> restaurants found
            <% if (cuisineParam != null && !cuisineParam.isEmpty()) { %>
                in <strong><%= cuisineParam %></strong> cuisine
            <% } %>
            <% if (searchParam != null && !searchParam.isEmpty()) { %>
                matching "<strong><%= searchParam %></strong>"
            <% } %>
        </div>
        
        <!-- Restaurants Grid -->
        <%
        if (restaurants != null && !restaurants.isEmpty()) {
        %>
            <div class="restaurants-grid">
                <%
                for (Restaurant restaurant : restaurants) {
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
                            <div class="restaurant-header">
                                <div>
                                    <div class="restaurant-name"><%= restaurant.getName() %></div>
                                    <div class="restaurant-details">
                                        📍 <%= restaurant.getAddress() %> • 
                                        <%
                                        double rating = restaurant.getRating();
                                        if (rating >= 4.5) {
                                            out.print("₹₹₹");
                                        } else if (rating >= 3.5) {
                                            out.print("₹₹");
                                        } else {
                                            out.print("₹");
                                        }
                                        %>
                                    </div>
                                </div>
                                <div class="rating"><%= restaurant.getRating() %> ⭐</div>
                            </div>
                            <div class="cuisine-tags">
                                <span class="cuisine-tag"><%= restaurant.getCuisineType() %></span>
                                <% if (restaurant.getRating() >= 4.0) { %>
                                    <span class="cuisine-tag" style="background: #d4edda; color: #155724;">Top Rated</span>
                                <% } %>
                                <% 
                                String deliveryTime = restaurant.getDeliveryTime();
                                if (deliveryTime != null && deliveryTime.contains("20")) { 
                                %>
                                    <span class="cuisine-tag" style="background: #fff3cd; color: #856404;">Fast Delivery</span>
                                <% } %>
                            </div>
                            <div class="delivery-info">
                                <span class="delivery-time">
                                    ⏰ <%= deliveryTime != null ? deliveryTime : "30-40 mins" %>
                                </span>
                                <span>
                                    💰 ₹<%= restaurant.getRating() >= 4.0 ? "40" : "50" %> delivery fee
                                </span>
                            </div>
                        </div>
                    </div>
                <%
                }
                %>
            </div>
        <%
        } else {
        %>
            <div class="no-restaurants">
                <h3>No restaurants found</h3>
                <p>Try adjusting your search criteria or filters</p>
                <a href="<%= request.getContextPath() %>/restaurants" class="btn btn-primary" style="margin-top: 20px; display: inline-block;">View All Restaurants</a>
            </div>
        <%
        }
        %>
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
