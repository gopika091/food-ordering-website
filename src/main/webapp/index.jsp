<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodZone - Order Food Online</title>
    <link rel="stylesheet" href="css/index.css">
    
    
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
            </div>
            
            <div class="restaurants-grid">
                <!-- Restaurant Card 1 -->
                <div class="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=1'">
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #ff6b6b, #4ecdc4); height: 100%; display: flex; align-items: center; justify-content: center; color: white; font-size: 3em;">🍕</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Mario's Pizza Palace</div>
                                <div class="restaurant-details">📍 Downtown • ₹₹</div>
                            </div>
                            <div class="rating">4.3 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">Italian</span>
                            <span class="cuisine-tag">Pizza</span>
                            <span class="cuisine-tag">Fast Food</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 25-30 mins</span>
                            <span>💰 ₹50 delivery fee</span>
                        </div>
                    </div>
                </div>
                
                <!-- Restaurant Card 2 -->
                <div class="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=2'">
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #f093fb, #f5576c); height: 100%; display: flex; align-items: center; justify-content: center; color: white; font-size: 3em;">🍔</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Burger Junction</div>
                                <div class="restaurant-details">📍 Mall Road • ₹₹</div>
                            </div>
                            <div class="rating">4.1 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">American</span>
                            <span class="cuisine-tag">Burgers</span>
                            <span class="cuisine-tag">Fast Food</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 20-25 mins</span>
                            <span>💰 ₹40 delivery fee</span>
                        </div>
                    </div>
                </div>
                
                <!-- Restaurant Card 3 -->
                <div class="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=3'">
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #667eea, #764ba2); height: 100%; display: flex; align-items: center; justify-content: center; color: white; font-size: 3em;">🍛</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Spice Garden</div>
                                <div class="restaurant-details">📍 City Center • ₹₹₹</div>
                            </div>
                            <div class="rating">4.5 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">Indian</span>
                            <span class="cuisine-tag">Biryani</span>
                            <span class="cuisine-tag">North Indian</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 30-40 mins</span>
                            <span>💰 ₹60 delivery fee</span>
                        </div>
                    </div>
                </div>
                
                <!-- Restaurant Card 4 -->
                <div class="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=4'">
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #fa709a, #fee140); height: 100%; display: flex; align-items: center; justify-content: center; color: white; font-size: 3em;">🍜</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Dragon Wok</div>
                                <div class="restaurant-details">📍 Main Street • ₹₹</div>
                            </div>
                            <div class="rating">4.2 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">Chinese</span>
                            <span class="cuisine-tag">Thai</span>
                            <span class="cuisine-tag">Asian</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 25-35 mins</span>
                            <span>💰 ₹45 delivery fee</span>
                        </div>
                    </div>
                </div>
                
                <!-- Restaurant Card 5 -->
     
             <!--  <div  class="restaurant-card" onclick="window.location.href='customer/restaurant-menu.jsp?id=5'">  -->
                <div  class ="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=5'">
                
                
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #a8edea, #fed6e3); height: 100%; display: flex; align-items: center; justify-content: center; color: #333; font-size: 3em;">🍝</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Pasta Bella</div>
                                <div class="restaurant-details">📍 Park Avenue • ₹₹₹</div>
                            </div>
                            <div class="rating">4.4 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">Italian</span>
                            <span class="cuisine-tag">Pasta</span>
                            <span class="cuisine-tag">Continental</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 35-45 mins</span>
                            <span>💰 ₹70 delivery fee</span>
                        </div>
                    </div>
                </div>
                
                <!-- Restaurant Card 6 -->
                <div class="restaurant-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurant?id=6'">
                    <div class="restaurant-image">
                        <div style="background: linear-gradient(45deg, #ffecd2, #fcb69f); height: 100%; display: flex; align-items: center; justify-content: center; color: #333; font-size: 3em;">🌮</div>
                    </div>
                    <div class="restaurant-info">
                        <div class="restaurant-header">
                            <div>
                                <div class="restaurant-name">Taco Fiesta</div>
                                <div class="restaurant-details">📍 Food Court • ₹₹</div>
                            </div>
                            <div class="rating">4.0 ⭐</div>
                        </div>
                        <div class="cuisine-tags">
                            <span class="cuisine-tag">Mexican</span>
                            <span class="cuisine-tag">Tex-Mex</span>
                            <span class="cuisine-tag">Fast Food</span>
                        </div>
                        <div class="delivery-info">
                            <span class="delivery-time">⏰ 20-30 mins</span>
                            <span>💰 ₹35 delivery fee</span>
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
</body>
</html>
