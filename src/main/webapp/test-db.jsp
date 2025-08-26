<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.gsk.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Test - FoodZone</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .test-section {
            background: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .success { color: #28a745; font-weight: bold; }
        .error { color: #dc3545; font-weight: bold; }
        .warning { color: #ffc107; font-weight: bold; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th { background: #f8f9fa; }
        .back-link {
            display: inline-block;
            margin: 20px 0;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover { background: #0056b3; }
    </style>
</head>
<body>
    <h1>🔍 Database Connection Test</h1>
    <a href="<%= request.getContextPath() %>/" class="back-link">← Back to Home</a>
    
    <div class="test-section">
        <h2>1. Database Connection Test</h2>
        <%
        try {
            Connection con = DBConnection.getNewConnection();
            if (con != null && !con.isClosed()) {
                out.println("<p class='success'>✅ Database connection successful!</p>");
                out.println("<p>Database: " + con.getMetaData().getDatabaseProductName() + "</p>");
                out.println("<p>Version: " + con.getMetaData().getDatabaseProductVersion() + "</p>");
                con.close();
            } else {
                out.println("<p class='error'>❌ Database connection failed!</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Database connection error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>2. Restaurants Table Test</h2>
        <%
        try {
            Connection con = DBConnection.getNewConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM restaurants LIMIT 5");
            
            boolean hasData = false;
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Name</th><th>Cuisine</th><th>Rating</th><th>Status</th></tr>");
            
            while (rs.next()) {
                if (!hasData) {
                    out.println("<p class='success'>✅ Restaurants table has data!</p>");
                    hasData = true;
                }
                out.println("<tr>");
                out.println("<td>" + rs.getInt("restaurantId") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getString("cuisineType") + "</td>");
                out.println("<td>" + rs.getDouble("rating") + "</td>");
                out.println("<td>" + (rs.getBoolean("isActive") ? "Active" : "Inactive") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            if (!hasData) {
                out.println("<p class='warning'>⚠️ Restaurants table is empty!</p>");
            }
            
            rs.close();
            stmt.close();
            con.close();
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error reading restaurants: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>3. Menu Table Test</h2>
        <%
        try {
            Connection con = DBConnection.getNewConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM menu LIMIT 5");
            
            boolean hasData = false;
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Restaurant ID</th><th>Item Name</th><th>Category</th><th>Price</th><th>Available</th></tr>");
            
            while (rs.next()) {
                if (!hasData) {
                    out.println("<p class='success'>✅ Menu table has data!</p>");
                    hasData = true;
                }
                out.println("<tr>");
                out.println("<td>" + rs.getInt("menuId") + "</td>");
                out.println("<td>" + rs.getInt("restaurantId") + "</td>");
                out.println("<td>" + rs.getString("itemName") + "</td>");
                out.println("<td>" + rs.getString("category") + "</td>");
                out.println("<td>₹" + rs.getDouble("price") + "</td>");
                out.println("<td>" + (rs.getBoolean("isAvailable") ? "Yes" : "No") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            if (!hasData) {
                out.println("<p class='warning'>⚠️ Menu table is empty!</p>");
            }
            
            rs.close();
            stmt.close();
            con.close();
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error reading menu: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>4. Menu Items for First Restaurant</h2>
        <%
        try {
            Connection con = DBConnection.getNewConnection();
            Statement stmt = con.createStatement();
            
            // Get first restaurant ID
            ResultSet rs = stmt.executeQuery("SELECT restaurantId FROM restaurants LIMIT 1");
            if (rs.next()) {
                int firstRestaurantId = rs.getInt("restaurantId");
                out.println("<p>Testing menu for restaurant ID: " + firstRestaurantId + "</p>");
                
                rs.close();
                
                // Get menu items for this restaurant
                PreparedStatement ps = con.prepareStatement("SELECT * FROM menu WHERE restaurantId = ? AND isAvailable = 1");
                ps.setInt(1, firstRestaurantId);
                rs = ps.executeQuery();
                
                boolean hasMenuData = false;
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Item Name</th><th>Category</th><th>Price</th></tr>");
                
                while (rs.next()) {
                    if (!hasMenuData) {
                        out.println("<p class='success'>✅ Found menu items for restaurant " + firstRestaurantId + "!</p>");
                        hasMenuData = true;
                    }
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("menuId") + "</td>");
                    out.println("<td>" + rs.getString("itemName") + "</td>");
                    out.println("<td>" + rs.getString("category") + "</td>");
                    out.println("<td>₹" + rs.getDouble("price") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                if (!hasMenuData) {
                    out.println("<p class='warning'>⚠️ No available menu items found for restaurant " + firstRestaurantId + "</p>");
                    
                    // Check if there are any menu items at all for this restaurant
                    ps = con.prepareStatement("SELECT COUNT(*) FROM menu WHERE restaurantId = ?");
                    ps.setInt(1, firstRestaurantId);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        out.println("<p>Total menu items (including unavailable): " + count + "</p>");
                    }
                }
                
                rs.close();
                ps.close();
            } else {
                out.println("<p class='error'>❌ No restaurants found!</p>");
            }
            
            stmt.close();
            con.close();
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error testing menu: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>5. Next Steps & Testing</h2>
        <ul>
            <li>If database connection failed, check your MySQL settings in DBConnection.java</li>
            <li>If restaurants table is empty, run the schema.sql script in your database</li>
            <li>If menu table is empty, the restaurants don't have menu items yet</li>
            <li>If everything works, the issue might be in the DAO implementation</li>
        </ul>
        
        <h3>Test Your Website</h3>
        <p>If the database tests above are successful, try these:</p>
        <div style="margin-top: 15px;">
            <a href="<%= request.getContextPath() %>/index.jsp" class="back-link" style="margin-right: 10px;">🏠 Test Homepage</a>
            <a href="<%= request.getContextPath() %>/debug-restaurant.jsp" class="back-link" style="margin-right: 10px;">🔧 Debug Restaurant Links</a>
            <a href="<%= request.getContextPath() %>/restaurants" class="back-link" style="margin-right: 10px;">📋 Test Restaurant Listing</a>
        </div>
    </div>
</body>
</html>



