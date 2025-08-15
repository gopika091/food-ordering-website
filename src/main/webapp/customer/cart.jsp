<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.gsk.servlet.CartServlet.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart - Food Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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
        h1 {
            color: #333;
            margin: 0;
        }
        .cart-container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 15px;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-name {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .item-price {
            color: #28a745;
            font-size: 1.1em;
            font-weight: bold;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
        }
        .qty-btn {
            background-color: #007bff;
            color: white;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background-color: #0056b3;
        }
        .qty-input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
        }
        .remove-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 15px;
        }
        .remove-btn:hover {
            background-color: #c82333;
        }
        .subtotal {
            text-align: right;
            color: #333;
            font-weight: bold;
            margin-left: 15px;
            min-width: 80px;
        }
        .cart-summary {
            border-top: 2px solid #007bff;
            padding-top: 20px;
            margin-top: 20px;
        }
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: background-color 0.2s;
        }
        .btn-clear {
            background-color: #6c757d;
            color: white;
        }
        .btn-clear:hover {
            background-color: #5a6268;
        }
        .btn-checkout {
            background-color: #28a745;
            color: white;
        }
        .btn-checkout:hover {
            background-color: #218838;
        }
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-cart h2 {
            color: #999;
            margin-bottom: 20px;
        }
        .continue-shopping {
            background-color: #007bff;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
        }
        .continue-shopping:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="<%= request.getContextPath() %>/index.jsp" class="back-btn">← Continue Shopping</a>
            <h1>Your Cart</h1>
        </div>

        <div class="cart-container">
            <% 
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            
            if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart">
                    <h2>Your cart is empty</h2>
                    <p>Looks like you haven't added any items to your cart yet.</p>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="continue-shopping">
                        Start Shopping
                    </a>
                </div>
            <% 
            } else {
                double total = 0;
                for (CartItem item : cart) {
                    total += item.getSubtotal();
            %>
                <div class="cart-item">
                    <img src="<%= item.getImagePath() != null ? item.getImagePath() : "https://source.unsplash.com/200x200/?food" %>" 
                         class="item-image" 
                         alt="<%= item.getItemName() %>">
                    
                    <div class="item-details">
                        <div class="item-name"><%= item.getItemName() %></div>
                        <div class="item-price">₹<%= String.format("%.2f", item.getPrice()) %></div>
                        
                        <div class="quantity-controls">
                            <button type="button" class="qty-btn" onclick="updateQuantity(<%= item.getMenuId() %>, -1)">-</button>
                            <input type="number" class="qty-input" id="qty_<%= item.getMenuId() %>" 
                                   value="<%= item.getQuantity() %>" min="1" max="10" 
                                   onchange="updateQuantity(<%= item.getMenuId() %>, 0)">
                            <button type="button" class="qty-btn" onclick="updateQuantity(<%= item.getMenuId() %>, 1)">+</button>
                        </div>
                    </div>
                    
                    <div class="subtotal">
                        ₹<span id="subtotal_<%= item.getMenuId() %>"><%= String.format("%.2f", item.getSubtotal()) %></span>
                    </div>
                    
                    <button type="button" class="remove-btn" onclick="removeItem(<%= item.getMenuId() %>)">
                        Remove
                    </button>
                </div>
            <% 
                }
            %>
            
            <div class="cart-summary">
                <div class="total-row">
                    <span>Total: ₹<span id="grandTotal"><%= String.format("%.2f", total) %></span></span>
                </div>
                
                <div class="action-buttons">
                    <button type="button" class="btn btn-clear" onclick="clearCart()">Clear Cart</button>
                    <a href="<%= request.getContextPath() %>/checkout" class="btn btn-checkout">Proceed to Checkout</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <script>
        function updateQuantity(menuId, change) {
            const qtyInput = document.getElementById('qty_' + menuId);
            let newQuantity;
            
            if (change === 0) {
                // Called from input change event
                newQuantity = parseInt(qtyInput.value);
            } else {
                // Called from +/- buttons
                newQuantity = parseInt(qtyInput.value) + change;
            }
            
            if (newQuantity < 1) {
                newQuantity = 1;
            } else if (newQuantity > 10) {
                newQuantity = 10;
            }
            
            qtyInput.value = newQuantity;
            
            // Send update to server
            fetch('<%= request.getContextPath() %>/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'action=update&menuId=' + menuId + '&quantity=' + newQuantity
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Refresh the page to update totals
                    location.reload();
                } else {
                    alert('Error updating cart: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error updating cart');
            });
        }

        function removeItem(menuId) {
            if (confirm('Are you sure you want to remove this item from your cart?')) {
                fetch('<%= request.getContextPath() %>/cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'action=remove&menuId=' + menuId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Refresh the page
                        location.reload();
                    } else {
                        alert('Error removing item: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error removing item');
                });
            }
        }

        function clearCart() {
            if (confirm('Are you sure you want to clear your entire cart?')) {
                fetch('<%= request.getContextPath() %>/cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'action=clear'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Refresh the page
                        location.reload();
                    } else {
                        alert('Error clearing cart: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error clearing cart');
                });
            }
        }
    </script>
</body>
</html>
