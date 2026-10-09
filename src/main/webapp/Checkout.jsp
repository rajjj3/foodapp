<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.foodapp.model.CartItem"%>

<%
    if (session.getAttribute("email") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<CartItem> cart =
            (List<CartItem>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("Cart.jsp");
        return;
    }

    double grandTotal = 0;

    for (CartItem item : cart) {
        grandTotal += item.getTotalPrice();
    }

    int restaurantId = cart.get(0).getRestaurant_id();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
    content="width=device-width, initial-scale=1.0">

<title>Checkout - FoodApp</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f5f5;
    color: #333;
}

.header {
    width: 100%;
    background: #008080;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    font-size: 25px;
}

.header a {
    color: white;
    text-decoration: none;
    font-size: 15px;
}

.container {
    width: 85%;
    max-width: 1100px;
    margin: 30px auto;
}

.page-title {
    margin-bottom: 20px;
}

.page-title h2 {
    font-size: 27px;
}

.checkout-container {
    display: flex;
    gap: 25px;
    align-items: flex-start;
}

.left-section {
    width: 65%;
}

.right-section {
    width: 35%;
}

.card {
    background: white;
    border-radius: 10px;
    padding: 22px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.card h3 {
    margin-bottom: 18px;
    font-size: 20px;
}

.restaurant-box {
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.restaurant-box p {
    margin-top: 5px;
    color: #666;
}

.item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 0;
    border-bottom: 1px solid #eee;
}

.item:last-child {
    border-bottom: none;
}

.item-name {
    font-weight: bold;
}

.item-details {
    color: #666;
    margin-top: 5px;
    font-size: 14px;
}

.item-total {
    font-weight: bold;
}

.address-box {
    width: 100%;
}

.address-box textarea {
    width: 100%;
    height: 100px;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    resize: vertical;
    font-size: 15px;
}

.payment-option {
    margin: 12px 0;
}

.payment-option label {
    cursor: pointer;
    margin-left: 8px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
}

.summary-row.total {
    border-top: 1px solid #ddd;
    margin-top: 10px;
    padding-top: 18px;
    font-size: 21px;
    font-weight: bold;
}

.place-order-btn {
    width: 100%;
    padding: 14px;
    margin-top: 20px;
    border: none;
    border-radius: 7px;
    background: #008080;
    color: white;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
}

.place-order-btn:hover {
    background: #006666;
}

.back-btn {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #008080;
    text-decoration: none;
}

@media(max-width: 768px) {

    .container {
        width: 92%;
    }

    .checkout-container {
        flex-direction: column;
    }

    .left-section,
    .right-section {
        width: 100%;
    }

}

</style>

</head>

<body>

<div class="header">

    <h1>FoodApp</h1>

    <a href="Cart.jsp">← Back to Cart</a>

</div>


<div class="container">

    <div class="page-title">
        <h2>Checkout</h2>
    </div>


    <div class="checkout-container">


        <!-- LEFT SECTION -->

        <div class="left-section">


            <!-- ORDER ITEMS -->

            <div class="card">

                <h3>Your Order</h3>

                <div class="restaurant-box">

                    <strong>Restaurant</strong>

                    <p>
                        Restaurant ID: <%= restaurantId %>
                    </p>

                </div>


                <%
                    for (CartItem item : cart) {
                %>

                <div class="item">

                    <div>

                        <div class="item-name">
                            <%= item.getItem_name() %>
                        </div>

                        <div class="item-details">

                            ₹<%= String.format("%.2f", item.getPrice()) %>
                            ×
                            <%= item.getQuantity() %>

                        </div>

                    </div>

                    <div class="item-total">

                        ₹<%= String.format("%.2f",
                                item.getTotalPrice()) %>

                    </div>

                </div>

                <%
                    }
                %>

            </div>


            <!-- DELIVERY ADDRESS -->

            <div class="card">

                <h3>Delivery Address</h3>

                <div class="address-box">

                    <textarea
                        name="address"
                        form="orderForm"
                        placeholder="Enter your delivery address"
                        required></textarea>

                </div>

            </div>


            <!-- PAYMENT -->

            <div class="card">

                <h3>Payment Method</h3>

                <div class="payment-option">

                    <input
                        type="radio"
                        id="cod"
                        name="paymentMode"
                        value="Cash on Delivery"
                        form="orderForm"
                        checked>

                    <label for="cod">
                        Cash on Delivery
                    </label>

                </div>


                <div class="payment-option">

                    <input
                        type="radio"
                        id="online"
                        name="paymentMode"
                        value="Online Payment"
                        form="orderForm">

                    <label for="online">
                        Online Payment
                    </label>

                </div>

            </div>

        </div>


        <!-- RIGHT SECTION -->

        <div class="right-section">

            <div class="card">

                <h3>Order Summary</h3>

                <div class="summary-row">

                    <span>Items</span>

                    <span>
                        <%= cart.size() %>
                    </span>

                </div>


                <div class="summary-row">

                    <span>Subtotal</span>

                    <span>
                        ₹<%= String.format("%.2f", grandTotal) %>
                    </span>

                </div>


                <div class="summary-row">

                    <span>Delivery Fee</span>

                    <span>₹0.00</span>

                </div>


                <div class="summary-row total">

                    <span>Total</span>

                    <span>
                        ₹<%= String.format("%.2f", grandTotal) %>
                    </span>

                </div>


                <form action="placeOrder"
                      method="post"
                      id="orderForm">

                    <input type="hidden"
                           name="restaurantId"
                           value="<%= restaurantId %>">

                    <input type="hidden"
                           name="totalAmount"
                           value="<%= grandTotal %>">

                    <button type="submit"
                            class="place-order-btn">

                        Place Order

                    </button>

                </form>


                <a href="Cart.jsp"
                   class="back-btn">

                    Back to Cart

                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>