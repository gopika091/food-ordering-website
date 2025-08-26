<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Test - FoodZone</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background: #f5f5f5; 
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        .success { 
            color: #28a745; 
            font-weight: bold; 
            font-size: 1.2em;
        }
        .info {
            background: #e9f7ff;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }
        .link {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px;
        }
        .link:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 Server is Working!</h1>
        <p class="success">✅ Your web server and JSP pages are functioning correctly!</p>
        
        <div class="info">
            <h3>Server Information:</h3>
            <p><strong>Current Time:</strong> <%= new java.util.Date() %></p>
            <p><strong>Server:</strong> <%= application.getServerInfo() %></p>
            <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
            <p><strong>Session ID:</strong> <%= session.getId() %></p>
        </div>
        
        <h3>Test Links:</h3>
        <a href="<%= request.getContextPath() %>/index.jsp" class="link">🏠 Try Homepage</a>
        <a href="<%= request.getContextPath() %>/test-db.jsp" class="link">🔍 Test Database</a>
        <a href="<%= request.getContextPath() %>/debug-restaurant.jsp" class="link">🔧 Debug Tools</a>
        
        <h3>Quick Project Recovery:</h3>
        <div class="info">
            <h4>If your main site isn't working:</h4>
            <ol>
                <li><strong>Check server status</strong> - This page working means server is fine</li>
                <li><strong>Try the database test</strong> - Click the test database link above</li>
                <li><strong>Check Eclipse console</strong> - Look for compilation errors</li>
                <li><strong>Refresh project</strong> - Right-click project → Refresh</li>
            </ol>
        </div>
        
        <h3>Manual Restaurant Test:</h3>
        <form action="<%= request.getContextPath() %>/restaurant" method="get" style="margin: 15px 0;">
            <label>Test Restaurant ID: </label>
            <input type="number" name="id" value="1" min="1" style="padding: 5px;">
            <button type="submit" style="background: #28a745; color: white; border: none; padding: 6px 12px; border-radius: 3px;">Test Restaurant Servlet</button>
        </form>
        
        <p><strong>If the form above gives a 404 error, the servlet compilation failed.</strong></p>
    </div>
</body>
</html>
