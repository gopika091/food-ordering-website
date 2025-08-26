<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        
        .test-info {
            background: #fff3cd;
            color: #856404;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }
        
        .test-link {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px;
        }
        
        .test-link:hover {
            background: #0056b3;
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
        <!-- Test Information -->
        <div class="test-info">
            <h3>🚧 Project Recovery Mode</h3>
            <p>This is a simplified version to help debug your project.</p>
            <div style="margin-top: 15px;">
                <a href="<%= request.getContextPath() %>/simple-test.jsp" class="test-link">🧪 Test Server</a>
                <a href="<%= request.getContextPath() %>/test-db.jsp" class="test-link">🔍 Test Database</a>
                <a href="<%= request.getContextPath() %>/debug-restaurant.jsp" class="test-link">🔧 Debug Tools</a>
            </div>
        </div>
        
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
        
        <!-- Sample Restaurants (hardcoded for testing) -->
        <section class="restaurants">
            <div class="section-title">
                <h2>Featured Restaurants</h2>
                <p>Popular restaurants in your area</p>
            </div>
            
            <div class="restaurants-grid">
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
        function testRestaurantClick(id) {
            alert('Testing restaurant ID: ' + id + '\nURL would be: ' + '<%= request.getContextPath() %>/restaurant?id=' + id);
            
            // Try to navigate to the restaurant page
            window.location.href = '<%= request.getContextPath() %>/restaurant?id=' + id;
        }
    </script>
</body>
</html>
