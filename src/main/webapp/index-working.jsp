<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gsk.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodZone - Order Food Online</title>
    <link rel="stylesheet" href="css/index.css">
    <style>
        .no-restaurants {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            font-size: 18px;
            grid-column: 1 / -1;
        }
        
        .no-restaurants h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .no-restaurants p {
            margin-bottom: 20px;
        }
        
        .debug-info {
            background: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            font-size: 14px;
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
    
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Order Food Online</h1>
            <p>Discover restaurants and cuisines around you</p>
            <div class="search-container">
                <input type="text" class="search-input" placeholder="Search for restaurants, cuisines...">
                <button class="search-btn">🔍</button>
            </div>
        </div>
    </section>
    
    <div class="container">
        <!-- Food Categories -->
        <section class="categories">
            <div class="section-title">
                <h2>Explore Categories</h2>
                <p>Discover your favorite cuisine</p>
            </div>
            <div class="categories-grid">
                <div class="category-item">
                    <span class="category-icon">🍕</span>
                    <div class="category-name">Pizza</div>
                </div>
                <div class="category-item">
                    <span class="category-icon">🍔</span>
                    <div class="category-name">Burgers</div>
                </div>
                <div class="category-item">
                    <span class="category-icon">🍜</span>
                    <div class="category-name">Chinese</div>
                </div>
                <div class="category-item">
                    <span class="category-icon">🍛</span>
                    <div class="category-name">Indian</div>
                </div>
                <div class="category-item">
                    <span class="category-icon">🍝</span>
                    <div class="category-name">Italian</div>
                </div>
                <div class="category-item">
                    <span class="category-icon">🌮</span>
                    <div class="category-name">Mexican</div>
                </div>
            </div>
        </section>
        
        <!-- Featured Restaurants -->
        <section class="restaurants">
            <div class="section-title">
                <h2>Featured Restaurants</h2>
                <p>Popular restaurants in your area</p>
                <button onclick="toggleAllRestaurants()" class="btn btn-outline" id="viewAllBtn" style="margin-top: 10px; display: inline-block;">View All Restaurants</button>
                <a href="<%= request.getContextPath() %>/test-db.jsp" class="btn btn-outline" style="margin-top: 10px; margin-left: 10px; display: inline-block;">🔍 Test Database</a>
                <a href="<%= request.getContextPath() %>/debug-restaurant.jsp" class="btn btn-outline" style="margin-top: 10px; margin-left: 10px; display: inline-block;">🔧 Debug Links</a>
            </div>
            
            <div class="restaurants-grid">
                <%
                // Get restaurants from the database
                boolean showDbRestaurants = false;
                try {
                    com.gsk.DAO.RestaurantDAO restaurantDAO = new com.gsk.DAOimp.RestaurantDAOImpl();
                    java.util.List<com.gsk.model.Restaurant> restaurants = restaurantDAO.getActiveRestaurants();
                    
                    if (restaurants != null && !restaurants.isEmpty()) {
                        showDbRestaurants = true;
                        // Show first 6 restaurants as featured
                        int count = 0;
                        for (com.gsk.model.Restaurant restaurant : restaurants) {
                            if (count >= 6) break; // Limit to 6 featured restaurants
                %>
                            <div class="restaurant-card" onclick="window.location.href='<%= request.getContextPath() %>/restaurant-details.jsp?id=<%= restaurant.getRestaurantId() %>'"> 
                                <div class="restaurant-image">
                                    <%
                                    String cuisineType = restaurant.getCuisineType();
                                    if ("Italian".equals(cuisineType)) {
                                        out.print("🍕");
                                    } else if ("Indian".equals(cuisineType) || "North Indian".equals(cuisineType) || "South Indian".equals(cuisineType)) {
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
                                    } else if ("Kerala".equals(cuisineType)) {
                                        out.print("🥥");
                                    } else if ("Mughlai".equals(cuisineType)) {
                                        out.print("🍖");
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
                                                📍 <%= restaurant.getAddress() != null ? restaurant.getAddress().length() > 20 ? restaurant.getAddress().substring(0, 20) + "..." : restaurant.getAddress() : "Location" %> • 
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
                            count++;
                        }
                    }
                } catch (Exception e) {
                    out.println("<div class='debug-info'>Database error: " + e.getMessage() + "</div>");
                }
                
                // If no database restaurants, show sample restaurants
                if (!showDbRestaurants) {
                %>
                    <!-- Fallback Sample Restaurants -->
                    <div class="debug-info">
                        <strong>⚠️ Note:</strong> Showing sample restaurants because database restaurants couldn't be loaded. 
                        Check your database connection.
                    </div>
                    
                    <!-- Sample Restaurant 1 -->
                    <div class="restaurant-card" onclick="testRestaurantClick(1)"> 
                        <div class="restaurant-image">🍛</div>
                        <div class="restaurant-info">
                            <div class="restaurant-header">
                                <div>
                                    <div class="restaurant-name">Spice Garden</div>
                                    <div class="restaurant-details">
                                        📍 Brigade Road • ₹₹₹
                                    </div>
                                </div>
                                <div class="rating">4.5 ⭐</div>
                            </div>
                            <div class="cuisine-tags">
                                <span class="cuisine-tag">North Indian</span>
                                <span class="cuisine-tag" style="background: #d4edda; color: #155724;">Top Rated</span>
                            </div>
                            <div class="delivery-info">
                                <span class="delivery-time">⏰ 30-40 mins</span>
                                <span>💰 ₹40 delivery fee</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sample Restaurant 2 -->
                    <div class="restaurant-card" onclick="testRestaurantClick(2)"> 
                        <div class="restaurant-image">🍕</div>
                        <div class="restaurant-info">
                            <div class="restaurant-header">
                                <div>
                                    <div class="restaurant-name">Pizza Palace</div>
                                    <div class="restaurant-details">
                                        📍 Koramangala • ₹₹₹
                                    </div>
                                </div>
                                <div class="rating">4.4 ⭐</div>
                            </div>
                            <div class="cuisine-tags">
                                <span class="cuisine-tag">Italian</span>
                                <span class="cuisine-tag" style="background: #d4edda; color: #155724;">Top Rated</span>
                            </div>
                            <div class="delivery-info">
                                <span class="delivery-time">⏰ 35-45 mins</span>
                                <span>💰 ₹40 delivery fee</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sample Restaurant 3 -->
                    <div class="restaurant-card" onclick="testRestaurantClick(3)"> 
                        <div class="restaurant-image">🍜</div>
                        <div class="restaurant-info">
                            <div class="restaurant-header">
                                <div>
                                    <div class="restaurant-name">Chinese Wok</div>
                                    <div class="restaurant-details">
                                        📍 HSR Layout • ₹₹
                                    </div>
                                </div>
                                <div class="rating">4.2 ⭐</div>
                            </div>
                            <div class="cuisine-tags">
                                <span class="cuisine-tag">Chinese</span>
                                <span class="cuisine-tag" style="background: #d4edda; color: #155724;">Top Rated</span>
                            </div>
                            <div class="delivery-info">
                                <span class="delivery-time">⏰ 40-50 mins</span>
                                <span>💰 ₹50 delivery fee</span>
                            </div>
                        </div>
                    </div>
                <%
                }
                %>
            </div>
            
            <!-- All Restaurants Section (Hidden by default) -->
            <div id="allRestaurantsSection" style="display: none; margin-top: 30px;">
                <div class="section-title">
                    <h2>All Restaurants</h2>
                    <button onclick="toggleAllRestaurants()" class="btn btn-outline">Show Featured Only</button>
                </div>
                
                <div class="restaurants-grid">
                    <%
                    // Show all restaurants when expanded
                    try {
                        com.gsk.DAO.RestaurantDAO allRestaurantDAO = new com.gsk.DAOimp.RestaurantDAOImpl();
                        java.util.List<com.gsk.model.Restaurant> allRestaurants = allRestaurantDAO.getActiveRestaurants();
                        
                        if (allRestaurants != null && !allRestaurants.isEmpty()) {
                            for (com.gsk.model.Restaurant restaurant : allRestaurants) {
                    %>
                                <div class="restaurant-card" onclick="window.location.href='<%= request.getContextPath() %>/restaurant-details.jsp?id=<%= restaurant.getRestaurantId() %>'"> 
                                    <div class="restaurant-image">
                                        <%
                                        String cuisineType = restaurant.getCuisineType();
                                        if ("Italian".equals(cuisineType)) {
                                            out.print("🍕");
                                        } else if ("Indian".equals(cuisineType) || "North Indian".equals(cuisineType) || "South Indian".equals(cuisineType)) {
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
                                        } else if ("Kerala".equals(cuisineType)) {
                                            out.print("🥥");
                                        } else if ("Mughlai".equals(cuisineType)) {
                                            out.print("🍖");
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
                                                    📍 <%= restaurant.getAddress() != null ? restaurant.getAddress().length() > 20 ? restaurant.getAddress().substring(0, 20) + "..." : restaurant.getAddress() : "Location" %> • 
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
                        } else {
                            out.println("<div class='no-restaurants'><h3>No restaurants found in database</h3><p>Please check your database setup.</p></div>");
                        }
                    } catch (Exception e) {
                        out.println("<div class='debug-info'>Error loading all restaurants: " + e.getMessage() + "</div>");
                    }
                    %>
                </div>
            </div>
        </section>
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
    
    <script>
        function toggleAllRestaurants() {
            const featuredSection = document.querySelector('.restaurants .restaurants-grid');
            const allRestaurantsSection = document.getElementById('allRestaurantsSection');
            const viewAllBtn = document.getElementById('viewAllBtn');
            
            if (allRestaurantsSection.style.display === 'none') {
                // Show all restaurants
                featuredSection.style.display = 'none';
                allRestaurantsSection.style.display = 'block';
                viewAllBtn.textContent = 'Show Featured Only';
                // Scroll to the all restaurants section
                allRestaurantsSection.scrollIntoView({ behavior: 'smooth' });
            } else {
                // Show featured only
                featuredSection.style.display = 'grid';
                allRestaurantsSection.style.display = 'none';
                viewAllBtn.textContent = 'View All Restaurants';
                // Scroll to the featured restaurants section
                document.querySelector('.restaurants').scrollIntoView({ behavior: 'smooth' });
            }
        }
        
        function testRestaurantClick(id) {
            // Navigate to restaurant details page (JSP version)
            window.location.href = '<%= request.getContextPath() %>/restaurant-details.jsp?id=' + id;
        }
    </script>
</body>
</html>
