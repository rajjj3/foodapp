<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.foodapp.model.Menu, com.foodapp.model.Restaurant"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Menu - FoodApp</title>

<style>
*{
    box-sizing:border-box;
    margin:0;
    padding:0;
    font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
}

body{
    background-color:#f8f9fa;
    color:#333;
    line-height:1.4;
    width:100%;
    min-height:100vh;
}

.full-container{
    width:100%;
    min-height:100vh;
    background:#ffffff;
    display:flex;
    flex-direction:column;
}

/* ================= HEADER ================= */

.header{
    background:linear-gradient(135deg,#ff6b6b,#ee5253);
    color:white;
    padding:16px 5%;
    text-align:center;
    width:100%;
    box-shadow:0 2px 6px rgba(0,0,0,0.08);
}

.restaurant-name{
    font-size:1.6rem;
    font-weight:700;
    margin-bottom:2px;
}

.rating-badge{
    display:inline-block;
    background-color:#ffb142;
    color:#222;
    padding:2px 10px;
    border-radius:12px;
    font-weight:bold;
    font-size:0.8rem;
    margin-bottom:4px;
}

.address{
    font-size:0.85rem;
    opacity:0.95;
}

/* ================= MENU ================= */

.menu-container{
    width:100%;
    padding:20px 5%;
    flex-grow:1;
}

.section-title{
    font-size:1.35rem;
    color:#2d3436;
    margin-top:15px;
    margin-bottom:12px;
    padding-bottom:8px;
    border-bottom:2px solid #ff6b6b;
}

.menu-list{
    width:100%;
}

.menu-item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:14px 6px;
    border-bottom:1px dashed #e0e0e0;
    transition:background 0.15s ease;
}

.menu-item:hover{
    background-color:#fcfcfc;
}

/* ================= LEFT SIDE ================= */

.item-details{
    flex:1;
    padding-right:15px;
}

.item-name{
    font-size:0.95rem;
    font-weight:600;
    color:#2d3436;
}

.item-description{
    font-size:0.8rem;
    color:#636e72;
    margin-top:1px;
}

/* ================= RIGHT SIDE ================= */

.item-actions{
    display:flex;
    align-items:center;
    gap:15px;
}

.item-price{
    font-size:0.95rem;
    font-weight:bold;
    color:#10ac84;
    white-space:nowrap;
}

/* ================= CART FORM ================= */

.cart-form{
    width:100%;
}

/* ================= QUANTITY ================= */

.quantity-control{
    display:flex;
    align-items:center;
    background:#f1f2f6;
    border-radius:16px;
    padding:2px 4px;
    border:1px solid #dfe4ea;
}

.qty-btn{
    background-color:#ff6b6b;
    color:white;
    border:none;
    width:22px;
    height:22px;
    border-radius:50%;
    font-size:0.9rem;
    font-weight:bold;
    cursor:pointer;
    display:flex;
    justify-content:center;
    align-items:center;
    transition:background 0.15s,transform 0.1s;
}

.qty-btn:hover{
    background-color:#ee5253;
}

.qty-btn:active{
    transform:scale(0.9);
}

.qty-number{
    font-size:0.85rem;
    font-weight:bold;
    min-width:24px;
    text-align:center;
    color:#2d3436;
}

/* ================= ADD TO CART ================= */

.add-to-cart-btn{
    display:block;
    margin:30px auto 10px;
    border:none;
    background-color:#10ac84;
    color:white;
    padding:11px 25px;
    border-radius:6px;
    font-size:0.9rem;
    font-weight:600;
    cursor:pointer;
    text-transform:capitalize;
    transition:background 0.15s,transform 0.1s;
}

.add-to-cart-btn:hover{
    background-color:#0e9673;
}

.add-to-cart-btn:active{
    transform:scale(0.96);
}

/* ================= EMPTY MENU ================= */

.empty-message{
    text-align:center;
    padding:40px;
    color:#777;
    font-size:1rem;
}

/* ================= MOBILE ================= */

@media (max-width:700px){

    .menu-item{
        align-items:flex-start;
        gap:10px;
    }

    .item-actions{
        flex-direction:column;
        align-items:flex-end;
        gap:7px;
    }

    .restaurant-name{
        font-size:1.3rem;
    }

    .item-description{
        font-size:0.75rem;
    }

    .item-price{
        font-size:0.85rem;
    }
}
</style>
</head>

<body>

<div class="full-container">
<%
Restaurant rs = (Restaurant) request.getAttribute("restaurantinfo");
%>
<header class="header">
    <h1 class="restaurant-name"> <%= rs.getName() %> </h1>
    <div class="rating-badge">⭐ <%= rs.getRating() %> </div>
    <p class="address"> <%= rs.getAddress() %> </p>
</header>

<main class="menu-container">

<%
List<Menu> menulist = (List<Menu>) request.getAttribute("menulist");

if(menulist != null && !menulist.isEmpty()){
%>

<form action="CartServletF" method="post" class="cart-form">
    <input type="hidden" name="restaurantId" value="<%= rs.getRestaurant_id() %>">
    <input type="hidden" name="action" value="add">
    <h2 class="section-title">Food Menu</h2>
    <div class="menu-list">

<%
int foodCount = Math.min(15, menulist.size());
for(int i = 0; i < foodCount; i++){
    Menu m = menulist.get(i);
%>

        <div class="menu-item">
            <div class="item-details">
                <div class="item-name"><%= m.getItem_name() %></div>
                <div class="item-description"><%= m.getDescription() %></div>
            </div>
            <div class="item-actions">
                <div class="item-price">₹<%= String.format("%.2f",m.getPrice()) %></div>
                <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                <input type="hidden" name="quantity" value="0" class="quantity-input">
                <div class="quantity-control">
                    <button type="button" class="qty-btn" onclick="decreaseCount(this)">−</button>
                    <span class="qty-number">0</span>
                    <button type="button"class="qty-btn"onclick="increaseCount(this)">+</button>
                </div>
            </div>
        </div>
<%
}
%>
    </div>
<%
if(menulist.size() > 15){
%>
    <h2 class="section-title">Beverages,Ice creams</h2>
    <div class="menu-list">
<%
for(int i = 15; i < menulist.size(); i++){
    Menu m = menulist.get(i);
%>
        <div class="menu-item">
            <div class="item-details">
                <div class="item-name"> <%= m.getItem_name() %> </div>
                <div class="item-description"> <%= m.getDescription() %> </div>
            </div>
            <div class="item-actions">
                <div class="item-price">
                    ₹<%= String.format("%.2f",m.getPrice()) %>
                </div>
                <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                <input type="hidden" name="quantity" value="0" class="quantity-input">
                <div class="quantity-control">
                    <button type="button" class="qty-btn" onclick="decreaseCount(this)"> −
                    </button><span class="qty-number">0</span>
                    <button type="button" class="qty-btn" onclick="increaseCount(this)">+</button>
                </div>
            </div>
        </div>
<%
}
%>
    </div>

<%
}
%>
    <button type="submit" class="add-to-cart-btn"> Add to Cart</button>
</form>

<%
}else{
%>

    <div class="empty-message">
        No menu items available.
    </div>

<%
}
%>

</main>

</div>

<script>

function increaseCount(button){
	
    let quantityControl = button.parentElement;
    let quantitySpan = quantityControl.querySelector(".qty-number");
    let quantityInput = quantityControl.parentElement.querySelector(".quantity-input");
    let currentQuantity = parseInt(quantitySpan.textContent);
    currentQuantity++;
    quantitySpan.textContent = currentQuantity;
    quantityInput.value = currentQuantity;
}

function decreaseCount(button){
	
    let quantityControl = button.parentElement;
    let quantitySpan = quantityControl.querySelector(".qty-number");
    let quantityInput = quantityControl.parentElement.querySelector(".quantity-input");
    let currentQuantity = parseInt(quantitySpan.textContent);
    if(currentQuantity > 0){
        currentQuantity--;
        quantitySpan.textContent = currentQuantity;
        quantityInput.value = currentQuantity;
    }
}

</script>

</body>
</html>
