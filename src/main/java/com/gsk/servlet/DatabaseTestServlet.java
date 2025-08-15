package com.gsk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gsk.util.DBConnection;

@WebServlet("/test-db")
public class DatabaseTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Database Connection Test</h1>");
        
        // Test database connection
        try {
            Connection conn = DBConnection.getNewConnection();
            if (conn != null) {
                out.println("<p style='color: green;'>✓ Database connection successful!</p>");
                
                // Test restaurants table structure first
                out.println("<h2>Restaurants Table Structure:</h2>");
                String descSql = "DESCRIBE restaurants";
                try (PreparedStatement ps = conn.prepareStatement(descSql);
                     ResultSet rs = ps.executeQuery()) {
                    out.println("<table border='1'>");
                    out.println("<tr><th>Column</th><th>Type</th><th>Null</th><th>Key</th></tr>");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Field") + "</td>");
                        out.println("<td>" + rs.getString("Type") + "</td>");
                        out.println("<td>" + rs.getString("Null") + "</td>");
                        out.println("<td>" + rs.getString("Key") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error describing restaurants: " + e.getMessage() + "</p>");
                }

                // Test restaurants table data
                out.println("<h2>Restaurants Table Data:</h2>");
                String sql = "SELECT * FROM restaurants LIMIT 5";
                try (PreparedStatement ps = conn.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {
                    
                    out.println("<table border='1'>");
                    // Get column names dynamically
                    java.sql.ResultSetMetaData metaData = rs.getMetaData();
                    int columnCount = metaData.getColumnCount();
                    out.println("<tr>");
                    for (int i = 1; i <= columnCount; i++) {
                        out.println("<th>" + metaData.getColumnName(i) + "</th>");
                    }
                    out.println("</tr>");
                    
                    int count = 0;
                    while (rs.next()) {
                        count++;
                        out.println("<tr>");
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<td>" + rs.getString(i) + "</td>");
                        }
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<p>Total restaurants found: " + count + "</p>");
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error querying restaurants: " + e.getMessage() + "</p>");
                }
                
                // Test menu table structure first
                out.println("<h2>Menu Table Structure:</h2>");
                String descMenuSql = "DESCRIBE menu";
                try (PreparedStatement ps = conn.prepareStatement(descMenuSql);
                     ResultSet rs = ps.executeQuery()) {
                    out.println("<table border='1'>");
                    out.println("<tr><th>Column</th><th>Type</th><th>Null</th><th>Key</th></tr>");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Field") + "</td>");
                        out.println("<td>" + rs.getString("Type") + "</td>");
                        out.println("<td>" + rs.getString("Null") + "</td>");
                        out.println("<td>" + rs.getString("Key") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error describing menu: " + e.getMessage() + "</p>");
                }

                // Test menu table data
                out.println("<h2>Menu Table Data:</h2>");
                String menuSql = "SELECT * FROM menu LIMIT 10";
                try (PreparedStatement ps = conn.prepareStatement(menuSql);
                     ResultSet rs = ps.executeQuery()) {
                    
                    out.println("<table border='1'>");
                    // Get column names dynamically
                    java.sql.ResultSetMetaData metaData = rs.getMetaData();
                    int columnCount = metaData.getColumnCount();
                    out.println("<tr>");
                    for (int i = 1; i <= columnCount; i++) {
                        out.println("<th>" + metaData.getColumnName(i) + "</th>");
                    }
                    out.println("</tr>");
                    
                    int count = 0;
                    while (rs.next()) {
                        count++;
                        out.println("<tr>");
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<td>" + rs.getString(i) + "</td>");
                        }
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<p>Total menu items found: " + count + "</p>");
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error querying menu: " + e.getMessage() + "</p>");
                }
                
                conn.close();
            } else {
                out.println("<p style='color: red;'>✗ Database connection failed!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color: red;'>✗ Database connection error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("<p><a href='" + request.getContextPath() + "/index.jsp'>← Back to Home Page</a></p>");
        out.println("</body></html>");
    }
}
