<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu - FoodZone</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f8f9fa;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 20px;
            text-align: center;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .back-btn {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 20px;
            transition: background 0.2s;
        }
        .back-btn:hover {
            background: #0056b3;
        }
        .restaurant-info {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .menu-item {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-5px);
        }
        .menu-image {
            height: 120px;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5em;
            color: white;
        }
        .menu-content {
            padding: 20px;
        }
        .menu-name {
            font-size: 1.2em;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }
        .menu-desc {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        .menu-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .price {
            font-size: 1.3em;
            font-weight: 700;
            color: #28a745;
        }
        .add-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .add-btn:hover {
            background: #0056b3;
        }
        .category-title {
            font-size: 1.6em;
            color: #333;
            margin: 30px 0 15px 0;
            padding-bottom: 8px;
            border-bottom: 3px solid #007bff;
        }
        .debug {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }
        .success {
            background: #e8f5e8;
            color: #2e7d2e;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🍽️ Restaurant Menu</h1>
        <p>Delicious food awaits you!</p>
    </div>
    
    <div class="container">
        <a href="<%= request.getContextPath() %>/index.jsp" class="back-btn">← Back to Restaurants</a>
        
        <%
        // Get restaurant ID from URL parameter
        String restaurantId = request.getParameter("id");
        
        if (restaurantId != null && !restaurantId.trim().isEmpty()) {
        %>
            <div class="success">
                <h3>✅ Restaurant Menu Loaded Successfully!</h3>
                <p><strong>Restaurant ID:</strong> <%= restaurantId %></p>
                <p><strong>URL:</strong> <%= request.getRequestURL() + "?" + request.getQueryString() %></p>
            </div>
        <%
        } else {
        %>
            <div class="debug">
                <h3>❌ No Restaurant ID Provided</h3>
                <p>The restaurant ID parameter is missing from the URL.</p>
                <p><strong>Current URL:</strong> <%= request.getRequestURL() %></p>
                <p><strong>Query String:</strong> <%= request.getQueryString() %></p>
            </div>
        <%
        }
        %>
        
        <div class="restaurant-info">
            <%
            com.gsk.model.Restaurant restaurant = null;
            java.util.List<com.gsk.model.Menu> menuItems = null;
            
            if (restaurantId != null && !restaurantId.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(restaurantId);
                    
                    // Get restaurant details
                    com.gsk.DAO.RestaurantDAO restaurantDAO = new com.gsk.DAOimp.RestaurantDAOImpl();
                    restaurant = restaurantDAO.getRestaurantById(id);
                    
                    if (restaurant != null) {
                        // Get menu items
                        com.gsk.DAO.MenuDAO menuDAO = new com.gsk.DAOimp.MenuDAOImpl();
                        menuItems = menuDAO.getAvailableMenuItemsByRestaurantId(id);
            %>
                        <h2>🏪 <%= restaurant.getName() %></h2>
                        <p><strong>Cuisine:</strong> <%= restaurant.getCuisineType() %></p>
                        <p><strong>Rating:</strong> <%= restaurant.getRating() %> ⭐</p>
                        <p><strong>Address:</strong> <%= restaurant.getAddress() %></p>
                        <p><strong>Delivery Time:</strong> <%= restaurant.getDeliveryTime() != null ? restaurant.getDeliveryTime() : "30-40 mins" %></p>
                        <% if (restaurant.getDescription() != null) { %>
                            <p><strong>Description:</strong> <%= restaurant.getDescription() %></p>
                        <% } %>
            <%
                    } else {
            %>
                        <div class="debug">
                            <h3>❌ Restaurant Not Found</h3>
                            <p>No restaurant found with ID: <%= restaurantId %></p>
                            <p>The restaurant might be inactive or doesn't exist in the database.</p>
                        </div>
            <%
                    }
                } catch (NumberFormatException e) {
            %>
                    <div class="debug">
                        <h3>❌ Invalid Restaurant ID</h3>
                        <p>Restaurant ID must be a number. Received: <%= restaurantId %></p>
                    </div>
            <%
                } catch (Exception e) {
            %>
                    <div class="debug">
                        <h3>❌ Database Error</h3>
                        <p><strong>Error:</strong> <%= e.getMessage() %></p>
                        <p>Please check your database connection.</p>
                        <p><a href="<%= request.getContextPath() %>/test-db.jsp" style="color: #007bff;">🔍 Test Database</a></p>
                    </div>
            <%
                    e.printStackTrace();
                }
            } else {
            %>
                <div class="debug">
                    <h3>❌ No Restaurant Selected</h3>
                    <p>Please select a restaurant from the homepage.</p>
                    <p><a href="<%= request.getContextPath() %>/index.jsp" style="color: #007bff;">🏠 Go to Homepage</a></p>
                </div>
            <%
            }
            %>
        </div>
        
        <!-- Menu Items Section -->
        <%
        if (restaurant != null && menuItems != null && !menuItems.isEmpty()) {
            // Group menu items by category
            java.util.Map<String, java.util.List<com.gsk.model.Menu>> categoryMap = new java.util.HashMap<>();
            for (com.gsk.model.Menu item : menuItems) {
                String category = item.getCategory();
                if (!categoryMap.containsKey(category)) {
                    categoryMap.put(category, new java.util.ArrayList<>());
                }
                categoryMap.get(category).add(item);
            }
            
            // Display each category
            for (java.util.Map.Entry<String, java.util.List<com.gsk.model.Menu>> entry : categoryMap.entrySet()) {
                String category = entry.getKey();
                java.util.List<com.gsk.model.Menu> items = entry.getValue();
        %>
                <h2 class="category-title">🍽️ <%= category %></h2>
                <div class="menu-grid">
                    <%
                    for (com.gsk.model.Menu item : items) {
                    %>
                        <div class="menu-item">
                            <div class="menu-image">
                                <%
                                // Simple emoji based on item name
                                String itemName = item.getItemName().toLowerCase();
                                if (itemName.contains("pizza")) {
                                    out.print("🍕");
                                } else if (itemName.contains("chicken") || itemName.contains("kebab")) {
                                    out.print("🍖");
                                } else if (itemName.contains("rice") || itemName.contains("biryani")) {
                                    out.print("🍚");
                                } else if (itemName.contains("dosa") || itemName.contains("idli")) {
                                    out.print("🥞");
                                } else if (itemName.contains("burger")) {
                                    out.print("🍔");
                                } else if (itemName.contains("noodles") || itemName.contains("soup")) {
                                    out.print("🍜");
                                } else if (itemName.contains("dessert") || itemName.contains("sweet")) {
                                    out.print("🍰");
                                } else if (itemName.contains("drink") || itemName.contains("tea") || itemName.contains("coffee")) {
                                    out.print("🥤");
                                } else {
                                    out.print("🍽️");
                                }
                                %>
                            </div>
                            <div class="menu-content">
                                <div class="menu-name"><%= item.getItemName() %></div>
                                <div class="menu-desc">
                                    <%= item.getDescription() != null ? item.getDescription() : "Delicious " + item.getItemName() %>
                                </div>
                                <div class="menu-footer">
                                    <div class="price">₹<%= String.format("%.2f", item.getPrice()) %></div>
                                    <button class="add-btn" onclick="addToCart('<%= item.getItemName() %>', <%= item.getPrice() %>)">
                                        Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    <%
                    }
                    %>
                </div>
        <%
            }
        } else if (restaurant != null) {
        %>
            <div class="debug">
                <h3>⚠️ No Menu Items Available</h3>
                <p>This restaurant doesn't have any menu items in the database yet.</p>
                <p><strong>Restaurant:</strong> <%= restaurant.getName() %></p>
                <p><strong>Restaurant ID:</strong> <%= restaurant.getRestaurantId() %></p>
            </div>
        <%
        }
        %>
        
        <!-- Test Links -->
        <div style="margin-top: 40px; text-align: center;">
            <h3>🔧 Test Other Restaurants:</h3>
            <a href="<%= request.getContextPath() %>/menu.jsp?id=1" class="back-btn" style="margin: 5px;">Restaurant 1</a>
            <a href="<%= request.getContextPath() %>/menu.jsp?id=2" class="back-btn" style="margin: 5px;">Restaurant 2</a>
            <a href="<%= request.getContextPath() %>/menu.jsp?id=3" class="back-btn" style="margin: 5px;">Restaurant 3</a>
        </div>
    </div>
    
    <script>
        function addToCart(itemName, price) {
            alert('Added to Cart: ' + itemName + ' - ₹' + price);
            // Here you can add actual cart functionality later
        }
        
        // Show success message if this page loads properly
        console.log('Menu page loaded successfully with restaurant ID: <%= request.getParameter("id") %>');
        
        // Debug information
        console.log('Current URL: ' + window.location.href);
        console.log('Context path: <%= request.getContextPath() %>');
    </script>
</body>
</html>
