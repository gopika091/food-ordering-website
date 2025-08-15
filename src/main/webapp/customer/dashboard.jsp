
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>
<html>
<head>
<title>Customer Dashboard</title>
</head>
<body>
	<h1>
		Welcome,
		<%= session.getAttribute("username") != null ? session.getAttribute("username") : "Customer" %>!
	</h1>
	<h2>Your Orders</h2>
	<!-- TODO: List user's orders here -->
	<p>No orders to display.</p>
	<hr>
	<a href="<%= request.getContextPath() %>/order/new">Place New Order</a>
	|
	<a href="<%= request.getContextPath() %>/Logout">Logout</a>
</body>
</html>
