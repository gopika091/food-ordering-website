<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.gsk.model.Restaurant" %>
<%@ page import="com.gsk.model.Menu" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <% 
        Restaurant titleRestaurant = (Restaurant) request.getAttribute("restaurant");
    %>
    <title><%= titleRestaurant != null ? titleRestaurant.getName() : "Restaurant" %> - Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .back-btn {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s;
        }
        .back-btn:hover {
            background-color: #5a6268;
        }
        .cart-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s;
            position: relative;
        }
        .cart-btn:hover {
            background-color: #218838;
        }
        .cart-count {
            background-color: #dc3545;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
            position: absolute;
            top: -5px;
            right: -5px;
            min-width: 18px;
            text-align: center;
        }
        .restaurant-header {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .restaurant-header h1 {
            margin: 0 0 10px;
            color: #333;
        }
        .restaurant-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-weight: bold;
            color: #666;
            font-size: 0.9em;
        }
        .info-value {
            color: #333;
            margin-top: 2px;
        }
        .rating {
            color: #f8c000;
            font-weight: bold;
        }
        .menu-section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .menu-section h2 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .menu-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .menu-item-img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .menu-item-content {
            padding: 15px;
        }
        .menu-item h3 {
            margin: 0 0 8px;
            color: #333;
            font-size: 1.1em;
        }
        .menu-item-desc {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        .menu-item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        .price {
            font-size: 1.2em;
            font-weight: bold;
            color: #28a745;
        }
        .item-rating {
            color: #f8c000;
            font-size: 0.9em;
        }
        .add-to-cart-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 0.9em;
        }
        .add-to-cart-btn:hover {
            background-color: #0056b3;
        }
        .add-to-cart-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        .no-menu {
            text-align: center;
            color: #666;
            font-style: italic;
            margin-top: 40px;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 5px;
        }
        .qty-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            width: 25px;
            height: 25px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background-color: #5a6268;
        }
        .qty-input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 3px;
            padding: 3px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-actions">
            <a href="<%= request.getContextPath() %>/index.jsp" class="back-btn">← Back to Restaurants</a>
            <a href="<%= request.getContextPath() %>/cart" class="cart-btn">
                🛒 Cart
                <span class="cart-count" id="cartCount">0</span>
            </a>
        </div>

        <% 
        Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
        List<Menu> menuItems = (List<Menu>) request.getAttribute("menuItems");
        %>

        <!-- Restaurant Header -->
        <div class="restaurant-header">
            <h1><%= restaurant.getName() %></h1>
            <div class="restaurant-info">
                <div class="info-item">
                    <span class="info-label">Cuisine Type</span>
                    <span class="info-value"><%= restaurant.getCuisineType() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Address</span>
                    <span class="info-value"><%= restaurant.getAddress() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Phone</span>
                    <span class="info-value"><%= restaurant.getPhone() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Rating</span>
                    <span class="info-value rating"><%= String.format("%.1f", restaurant.getRating()) %> ★</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Estimated Delivery</span>
                    
                </div>
            </div>
        </div>

        <!-- Menu Section -->
        <div class="menu-section">
            <h2>Our Menu</h2>
            
            <% if (menuItems != null && !menuItems.isEmpty()) { %>
                <div class="menu-grid">
                    <% for (Menu item : menuItems) { %>
                        <div class="menu-item">
                            <img src="<%= item.getImagePath() != null ? item.getImagePath() : "https://source.unsplash.com/400x250/?food" %>" 
                                 class="menu-item-img" 
                                 alt="<%= item.getItemName() %> image">
                            <div class="menu-item-content">
                                <h3><%= item.getItemName() %></h3>
                                <p class="menu-item-desc"><%= item.getDescription() %></p>
                                <div class="menu-item-footer">
                                    <div>
                                        <div class="price">₹<%= String.format("%.2f", item.getPrice()) %></div>
                                        <div class="item-rating">
                                            <%= item.getRatings() > 0 ? String.format("%.1f", item.getRatings()) + " ★" : "New Item" %>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="quantity-controls">
                                            <button type="button" class="qty-btn" onclick="decreaseQty(<%= item.getMenuId() %>)">-</button>
                                            <input type="number" class="qty-input" id="qty_<%= item.getMenuId() %>" value="1" min="1" max="10">
                                            <button type="button" class="qty-btn" onclick="increaseQty(<%= item.getMenuId() %>)">+</button>
                                        </div>
                                        <button type="button" class="add-to-cart-btn" onclick="addToCart(<%= item.getMenuId() %>, '<%= item.getItemName() %>', <%= item.getPrice() %>)">
                                            Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-menu">
                    <h3>No menu items available at the moment.</h3>
                    <p>Please check back later or contact the restaurant directly.</p>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        let cart = JSON.parse(sessionStorage.getItem('cart')) || [];
        updateCartCount();

        function updateCartCount() {
            const cartCount = document.getElementById('cartCount');
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            cartCount.textContent = totalItems;
        }

        function increaseQty(menuId) {
            const qtyInput = document.getElementById('qty_' + menuId);
            const currentQty = parseInt(qtyInput.value);
            if (currentQty < 10) {
                qtyInput.value = currentQty + 1;
            }
        }

        function decreaseQty(menuId) {
            const qtyInput = document.getElementById('qty_' + menuId);
            const currentQty = parseInt(qtyInput.value);
            if (currentQty > 1) {
                qtyInput.value = currentQty - 1;
            }
        }

        function addToCart(menuId, itemName, price) {
            const qtyInput = document.getElementById('qty_' + menuId);
            const quantity = parseInt(qtyInput.value);
            
            // Check if item already exists in cart
            const existingItemIndex = cart.findIndex(item => item.menuId === menuId);
            
            if (existingItemIndex !== -1) {
                // Update quantity
                cart[existingItemIndex].quantity += quantity;
            } else {
                // Add new item
                cart.push({
                    menuId: menuId,
                    itemName: itemName,
                    price: price,
                    quantity: quantity,
                    restaurantId: <%= restaurant.getRestaurantId() %>,
                    restaurantName: '<%= restaurant.getName() %>'
                });
            }
            
            // Save to session storage
            sessionStorage.setItem('cart', JSON.stringify(cart));
            updateCartCount();
            
            // Reset quantity to 1
            qtyInput.value = 1;
            
            // Show confirmation (optional)
            alert(quantity + ' x ' + itemName + ' added to cart!');
        }
    </script>
</body>
</html>
