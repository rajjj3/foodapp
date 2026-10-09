<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.foodapp.model.CartItem"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Cart - FoodApp</title>

<style>
*{
    box-sizing:border-box;
    margin:0;
    padding:0;
    font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
}

body{
    background:#f8f9fa;
    color:#333;
    min-height:100vh;
}

.container{
    width:100%;
    min-height:100vh;
    background:#fff;
}

.header{
    width:100%;
    background:linear-gradient(135deg,#ff6b6b,#ee5253);
    color:white;
    padding:18px 5%;
    text-align:center;
    box-shadow:0 2px 6px rgba(0,0,0,0.08);
}

.header h1{
    font-size:1.6rem;
}

.cart-container{
    width:90%;
    max-width:900px;
    margin:25px auto;
}

.cart-title{
    font-size:1.4rem;
    color:#2d3436;
    margin-bottom:15px;
    border-bottom:2px solid #ff6b6b;
    padding-bottom:8px;
}

.cart-item{
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:20px;
    padding:16px 10px;
    border-bottom:1px dashed #ddd;
}

.item-details{
    flex:1;
}

.item-name{
    font-size:1rem;
    font-weight:600;
    color:#2d3436;
}

.item-price{
    margin-top:4px;
    font-size:0.85rem;
    color:#10ac84;
}

.quantity-form{
    display:flex;
    align-items:center;
}

.qty-btn{
    width:28px;
    height:28px;
    border:none;
    border-radius:50%;
    background:#ff6b6b;
    color:white;
    font-size:1rem;
    font-weight:bold;
    cursor:pointer;
}

.qty-btn:hover{
    background:#ee5253;
}

.quantity{
    min-width:35px;
    text-align:center;
    font-weight:bold;
}

.item-total{
    min-width:90px;
    text-align:right;
    font-weight:bold;
    color:#10ac84;
}

.remove-form{
    margin-left:10px;
}

.remove-btn{
    border:none;
    background:#e74c3c;
    color:white;
    padding:6px 10px;
    border-radius:5px;
    cursor:pointer;
    font-size:0.75rem;
}

.remove-btn:hover{
    background:#c0392b;
}

.cart-summary{
    margin-top:25px;
    padding:20px;
    background:#f1f2f6;
    border-radius:8px;
}

.total-row{
    display:flex;
    justify-content:space-between;
    font-size:1.1rem;
    font-weight:bold;
}

.grand-total{
    color:#10ac84;
}

.checkout-btn{
    display:block;
    width:100%;
    margin-top:15px;
    padding:12px;
    border:none;
    border-radius:6px;
    background:#10ac84;
    color:white;
    font-size:1rem;
    font-weight:600;
    cursor:pointer;
}

.checkout-btn:hover{
    background:#0e9673;
}

.clear-btn{
    display:block;
    width:100%;
    margin-top:8px;
    padding:10px;
    border:none;
    border-radius:6px;
    background:#636e72;
    color:white;
    cursor:pointer;
}

.clear-btn:hover{
    background:#2d3436;
}

.empty-cart{
    text-align:center;
    padding:60px 20px;
    color:#777;
}

.empty-cart h2{
    margin-bottom:8px;
    color:#555;
}

.empty-cart p{
    font-size:0.9rem;
}

.continue-btn{
    display:inline-block;
    margin-top:20px;
    padding:10px 20px;
    background:#ff6b6b;
    color:white;
    text-decoration:none;
    border-radius:6px;
}

@media(max-width:700px){

    .cart-container{
        width:94%;
    }

    .cart-item{
        gap:8px;
    }

    .item-total{
        min-width:70px;
        font-size:0.85rem;
    }

    .remove-btn{
        padding:5px 7px;
    }
}
</style>
</head>

<body>

<div class="container">

<header class="header">
    <h1>Your Cart</h1>
</header>

<main class="cart-container">

<%
List<CartItem> cart =
    (List<CartItem>) session.getAttribute("cart");

if(cart != null && !cart.isEmpty()){
%>

<h2 class="cart-title">
    Cart Items
</h2>

<%
double grandTotal = 0;

for(CartItem item : cart){

    grandTotal += item.getTotalPrice();
%>

<div class="cart-item">

    <div class="item-details">

        <div class="item-name">
            <%= item.getItem_name() %>
        </div>

        <div class="item-price">
            ₹<%= String.format("%.2f",item.getPrice()) %>
            each
        </div>

    </div>

    <form action="CartServletF"
          method="post"
          class="quantity-form">

        <input type="hidden"
               name="itemId"
               value="<%= item.getMenu_id() %>">

        <input type="hidden"
               name="action"
               value="decrease">

        <button type="submit"
                class="qty-btn">
            −
        </button>

        <span class="quantity">
            <%= item.getQuantity() %>
        </span>

    </form>

    <form action="CartServletF"
          method="post"
          class="quantity-form">

        <input type="hidden"
               name="itemId"
               value="<%= item.getMenu_id() %>">

        <input type="hidden"
               name="action"
               value="increase">

        <button type="submit"
                class="qty-btn">
            +
        </button>

    </form>

    <div class="item-total">
        ₹<%= String.format("%.2f",item.getTotalPrice()) %>
    </div>

    <form action="CartServletF"
          method="post"
          class="remove-form">

        <input type="hidden"
               name="itemId"
               value="<%= item.getMenu_id() %>">

        <input type="hidden"
               name="action"
               value="remove">

        <button type="submit"
                class="remove-btn">
            Remove
        </button>

    </form>

</div>

<%
}
%>

<div class="cart-summary">

    <div class="total-row">

        <span>
            Grand Total
        </span>

        <span class="grand-total">
            ₹<%= String.format("%.2f",grandTotal) %>
        </span>

    </div>

    <button class="checkout-btn"
            onclick="location.href='Checkout.jsp'">
        Proceed to Checkout
    </button>

    <form action="CartServletF" method="post">

        <input type="hidden"
               name="action"
               value="clear">

        <button type="submit"
                class="clear-btn">
            Clear Cart
        </button>

    </form>

</div>

<%
}else{
%>

<div class="empty-cart">

    <h2>Your cart is empty</h2>

    <p>
        Add some delicious food to your cart.
    </p>

    <a href="HomeServlet"
       class="continue-btn">
        Continue Shopping
    </a>

</div>

<%
}
%>

</main>

</div>

</body>
</html>