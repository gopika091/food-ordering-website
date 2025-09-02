package com.gsk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet Test - FoodZone</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 40px; }");
        out.println(".success { color: #28a745; font-weight: bold; }");
        out.println(".info { background: #e9f7ff; padding: 15px; border-radius: 5px; margin: 10px 0; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>🎉 Servlet Test Successful!</h1>");
        out.println("<p class='success'>✅ Your servlets are working correctly!</p>");
        
        out.println("<div class='info'>");
        out.println("<h3>Request Information:</h3>");
        out.println("<p><strong>Context Path:</strong> " + request.getContextPath() + "</p>");
        out.println("<p><strong>Servlet Path:</strong> " + request.getServletPath() + "</p>");
        out.println("<p><strong>Server Info:</strong> " + getServletContext().getServerInfo() + "</p>");
        out.println("<p><strong>Request URL:</strong> " + request.getRequestURL() + "</p>");
        out.println("</div>");
        
        out.println("<h3>Next Steps:</h3>");
        out.println("<ul>");
        out.println("<li>If you see this page, your servlet container is working</li>");
        out.println("<li>The RestaurantServlet should also work now</li>");
        out.println("<li>Try clicking on restaurants from the homepage</li>");
        out.println("</ul>");
        
        out.println("<h3>Test Links:</h3>");
        out.println("<p><a href='" + request.getContextPath() + "/index.jsp' style='color: #007bff; text-decoration: none; margin-right: 15px;'>🏠 Homepage</a>");
        out.println("<a href='" + request.getContextPath() + "/restaurant?id=1' style='color: #007bff; text-decoration: none; margin-right: 15px;'>🍽️ Test Restaurant ID 1</a>");
        out.println("<a href='" + request.getContextPath() + "/restaurants' style='color: #007bff; text-decoration: none; margin-right: 15px;'>📋 All Restaurants</a></p>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
