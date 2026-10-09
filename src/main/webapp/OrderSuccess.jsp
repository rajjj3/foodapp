<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("email") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Object orderIdObj =
            session.getAttribute("lastOrderId");

    if (orderIdObj == null) {
        response.sendRedirect("Home.jsp");
        return;
    }

    int orderId =
            (Integer) orderIdObj;

    session.removeAttribute("lastOrderId");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
    content="width=device-width, initial-scale=1.0">

<title>Order Placed - FoodApp</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f5f5;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.success-card {
    width: 90%;
    max-width: 500px;
    background: white;
    padding: 45px 35px;
    text-align: center;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.success-icon {
    width: 70px;
    height: 70px;
    margin: 0 auto 20px;
    border-radius: 50%;
    background: #008080;
    color: white;
    font-size: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.success-card h1 {
    color: #008080;
    margin-bottom: 12px;
}

.success-card p {
    color: #666;
    font-size: 16px;
    margin-bottom: 10px;
}

.order-id {
    font-weight: bold;
    color: #333;
    margin: 20px 0;
}

.home-btn {
    display: inline-block;
    margin-top: 15px;
    padding: 13px 28px;
    background: #008080;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
}

.home-btn:hover {
    background: #006666;
}

</style>

</head>

<body>

<div class="success-card">

    <div class="success-icon">✓</div>
    <h1>Order Placed!</h1>
    <p>Your order has been placed successfully.</p>
    <p class="order-id">Order ID: #<%= orderId %></p>
    <p>Thank you for ordering with FoodApp.</p>
    <a href="HomeServlet" class="home-btn">
        Continue Shopping
    </a>

</div>

</body>
</html>
