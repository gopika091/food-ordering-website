package com.gsk.servlet;

import com.gsk.DAO.UserDAO;
import com.gsk.DAOimp.UserDAOImpl;
import com.gsk.model.User;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Validation
        if (name == null || username == null || password == null || email == null) {
            request.setAttribute("error", "All required fields must be filled!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username or email already exists
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user object
        User user = new User();
        user.setName(name);
        user.setUsername(username);
        user.setPassword(password); // In production, hash the password
        user.setEmail(email);
        user.setPhone(phone != null ? phone : "");
        user.setAddress(address != null ? address : "");
        user.setRole(role != null ? role : "CUSTOMER");
        user.setCreatedDate(new Date());
        
        // Save user to database
        boolean isRegistered = userDAO.addUser(user);
        
        if (isRegistered) {
            request.setAttribute("success", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}
