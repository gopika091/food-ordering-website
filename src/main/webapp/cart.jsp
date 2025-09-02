<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gsk.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - FoodZone</title>
    <link rel="stylesheet" href="css/index.css">
    <style>
        .container { max-width: 1000px; margin: 30px auto; padding: 0 16px; }
        .cart-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .cart-item { display: grid; grid-template-columns: 1fr 120px 140px 40px; gap: 12px; align-items: center; padding: 14px 0; border-bottom: 1px solid #eee; }
        .qty-input { width: 70px; padding: 6px; }
        .price { font-weight: 700; color: #28a745; }
        .remove-btn { background: transparent; border: none; color: #dc3545; cursor: pointer; font-size: 18px; }
        .empty { text-align: center; color: #666; padding: 60px 0; }
        .summary { display: flex; justify-content: flex-end; margin-top: 20px; gap: 16px; align-items: center; }
        .btn { background: #007bff; color: #fff; border: none; padding: 10px 16px; border-radius: 6px; cursor: pointer; }
        .btn.secondary { background: #6c757d; }
    </style>
</head>
<body>
<div class="container">
    <div class="cart-header">
        <h2>🛒 Your Cart</h2>
        <a class="btn secondary" href="<%= request.getContextPath() %>/index.jsp">Continue shopping</a>
    </div>

    <%
        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
        Double cartTotal = (Double) request.getAttribute("cartTotal");
        if (cartItems == null || cartItems.isEmpty()) {
    %>
        <div class="empty">
            <h3>Your cart is empty</h3>
            <p>Add some tasty items to get started.</p>
        </div>
    <%
        } else {
    %>
        <div class="cart-list">
            <div class="cart-item" style="font-weight:700; border-top:1px solid #eee;">
                <div>Item</div>
                <div>Quantity</div>
                <div>Subtotal</div>
                <div></div>
            </div>
            <%
                for (CartItem item : cartItems) {
            %>
            <div class="cart-item">
                <div>
                    <div style="font-weight:700;"><%= item.getItemName() %></div>
                    <div style="color:#666; font-size: 13px;">₹<%= String.format("%.2f", item.getPrice()) %> · <%= item.getRestaurantName() %></div>
                </div>
                <div>
                    <input class="qty-input" type="number" min="1" value="<%= item.getQuantity() %>"
                           onchange="updateQty(<%= item.getMenuId() %>, this.value)" />
                </div>
                <div class="price">₹<%= String.format("%.2f", item.getSubtotal()) %></div>
                <div>
                    <button class="remove-btn" title="Remove" onclick="removeItem(<%= item.getMenuId() %>)">✕</button>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <div class="summary">
            <div style="font-size: 18px;">Total: <span class="price">₹<%= String.format("%.2f", cartTotal != null ? cartTotal : 0.0) %></span></div>
            <button class="btn" onclick="window.location.href='<%= request.getContextPath() %>/checkout.jsp'">Checkout</button>
            <button class="btn secondary" onclick="clearCart()">Clear cart</button>
        </div>
    <%
        }
    %>
</div>

<script>
function updateQty(menuId, qty) {
    fetch('<%= request.getContextPath() %>/cart/update', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'menuId=' + menuId + '&quantity=' + qty
    })
    .then(() => location.reload());
}

function removeItem(menuId) {
    fetch('<%= request.getContextPath() %>/cart/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'menuId=' + menuId
    })
    .then(() => location.reload());
}

function clearCart() {
    fetch('<%= request.getContextPath() %>/cart/clear', { method: 'POST' })
    .then(() => location.reload());
}
</script>
</body>
</html>


