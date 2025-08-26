<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug Restaurant Links</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-link { 
            display: block; 
            margin: 10px 0; 
            padding: 10px; 
            background: #f0f0f0; 
            border: 1px solid #ccc; 
            text-decoration: none; 
            color: #333; 
        }
        .test-link:hover { background: #e0e0e0; }
    </style>
</head>
<body>
    <h1>🔍 Restaurant Link Debug</h1>
    <a href="index.jsp" class="test-link">← Back to Home</a>
    
    <h2>Test Restaurant Links</h2>
    <p>Click these links to test if the restaurant servlet is working:</p>
    
    <!-- Test with JSP-based restaurant details -->
    <a href="<%= request.getContextPath() %>/restaurant-details.jsp?id=1" class="test-link">
        Test Restaurant ID 1 (JSP) - <%= request.getContextPath() %>/restaurant-details.jsp?id=1
    </a>
    
    <a href="<%= request.getContextPath() %>/restaurant-details.jsp?id=2" class="test-link">
        Test Restaurant ID 2 (JSP) - <%= request.getContextPath() %>/restaurant-details.jsp?id=2
    </a>
    
    <a href="<%= request.getContextPath() %>/restaurant-details.jsp?id=3" class="test-link">
        Test Restaurant ID 3 (JSP) - <%= request.getContextPath() %>/restaurant-details.jsp?id=3
    </a>
    
    <h2>Servlet Tests (These might give 404)</h2>
    <a href="<%= request.getContextPath() %>/restaurant?id=1" class="test-link">
        Test Restaurant ID 1 (Servlet) - <%= request.getContextPath() %>/restaurant?id=1
    </a>
    
    <h2>Context Path Info</h2>
    <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
    <p><strong>Server Name:</strong> <%= request.getServerName() %></p>
    <p><strong>Server Port:</strong> <%= request.getServerPort() %></p>
    <p><strong>Full URL Pattern:</strong> http://<%= request.getServerName() %>:<%= request.getServerPort() %><%= request.getContextPath() %>/restaurant?id=1</p>
    
    <h2>Direct Servlet Test</h2>
    <form action="<%= request.getContextPath() %>/restaurant" method="get">
        <label>Restaurant ID: </label>
        <input type="number" name="id" value="1" min="1">
        <button type="submit">Test Servlet</button>
    </form>
    
    <h2>Servlet Tests</h2>
    <a href="<%= request.getContextPath() %>/test" class="test-link">
        🧪 Test Basic Servlet - <%= request.getContextPath() %>/test
    </a>
    
    <h2>Database Test</h2>
    <a href="test-db.jsp" class="test-link">🔍 Test Database Connection</a>
    
    <h2>Troubleshooting Steps</h2>
    <div style="background: #fff3cd; padding: 15px; margin: 10px 0; border-radius: 5px;">
        <h3>If you get 404 errors:</h3>
        <ol>
            <li><strong>Clean and rebuild your project</strong> in Eclipse</li>
            <li><strong>Restart your server</strong> (Tomcat/etc)</li>
            <li><strong>Check server logs</strong> for compilation errors</li>
            <li><strong>Verify deployment</strong> - check if the project is deployed</li>
        </ol>
        
        <h3>Quick fixes to try:</h3>
        <ul>
            <li>Right-click project → Clean → Rebuild</li>
            <li>Project → Clean → Select your project</li>
            <li>Restart Eclipse and your web server</li>
            <li>Check if the .class files exist in build/classes/</li>
        </ul>
    </div>
</body>
</html>
