<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - FoodZone</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #e23744 0%, #d12736 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .register-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
            position: relative;
            overflow: hidden;
        }
        
        .register-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #e23744 0%, #d12736 100%);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .register-header h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .register-header p {
            color: #666;
            font-size: 16px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
            flex: 1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #e23744;
            background: white;
            box-shadow: 0 0 0 3px rgba(226, 55, 68, 0.1);
        }
        
        .form-group textarea {
            height: 80px;
            resize: vertical;
        }
        
        .register-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #e23744 0%, #d12736 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(226, 55, 68, 0.3);
        }
        
        .register-btn:active {
            transform: translateY(0);
        }
        
        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .login-link a {
            color: #e23744;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .login-link a:hover {
            color: #d12736;
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            font-size: 16px;
            opacity: 0.9;
            transition: opacity 0.3s ease;
        }
        
        .back-home:hover {
            opacity: 1;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            font-size: 14px;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            font-size: 14px;
        }
        
        .required {
            color: #e23744;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .register-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .register-header h1 {
                font-size: 28px;
            }
        }
        
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid #fff;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <a href="index.jsp" class="back-home">← Back to Home</a>
    
    <div class="register-container">
        <div class="register-header">
            <h1>🍕 Join FoodZone</h1>
            <p>Create your account to start ordering delicious food</p>
        </div>
        
        <!-- Display error or success messages -->
        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (error != null) {
        %>
            <div class="error-message">
                <%= error %>
            </div>
        <%
            }
            if (success != null) {
        %>
            <div class="success-message">
                <%= success %>
            </div>
        <%
            }
        %>
        
        <form action="Register" method="post" id="registerForm" novalidate>
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name <span class="required">*</span></label>
                    <input type="text" id="firstName" name="firstName" required 
                           placeholder="Enter your first name"
                           value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>">
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name <span class="required">*</span></label>
                    <input type="text" id="lastName" name="lastName" required 
                           placeholder="Enter your last name"
                           value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="username">Username <span class="required">*</span></label>
                <input type="text" id="username" name="username" required 
                       placeholder="Choose a unique username"
                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required 
                       placeholder="Enter your email address"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Create a strong password" minlength="6">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Confirm your password" minlength="6">
                </div>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>
                <input type="tel" id="phone" name="phone" required 
                       placeholder="Enter your phone number" pattern="[0-9]{10}"
                       value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
            </div>
            
            <div class="form-group">
                <label for="address">Address <span class="required">*</span></label>
                <textarea id="address" name="address" required 
                         placeholder="Enter your complete address"><%= request.getParameter("address") != null ? request.getParameter("address") : "" %></textarea>
            </div>
            
            <button type="submit" class="register-btn" id="submitBtn">Create Account</button>
        </form>
        
        <div class="login-link">
            <p>Already have an account? <a href="login.jsp">Sign in here</a></p>
        </div>
    </div>
    
    <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const submitBtn = document.getElementById('submitBtn');
            
            // Password validation
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return;
            }
            
            // Phone validation
            const phone = document.getElementById('phone').value;
            if (!/^[0-9]{10}$/.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid 10-digit phone number!');
                return;
            }
            
            // Show loading state
            submitBtn.classList.add('loading');
            submitBtn.textContent = 'Creating Account...';
            submitBtn.disabled = true;
        });
        
        // Real-time password match validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#dc3545';
            } else {
                this.style.borderColor = '#e1e5e9';
            }
        });
        
        // Phone number formatting
        document.getElementById('phone').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);
        });
    </script>
</body>
</html>
