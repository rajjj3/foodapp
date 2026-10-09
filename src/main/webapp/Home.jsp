<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.foodapp.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodApp - Home</title>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f8fafc;
        color: #1a202c;
        overflow-x: hidden;
    }

    /* ================= KEYFRAME ANIMATIONS ================= */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes floatIcon {
        0%, 100% { transform: translateY(0px) rotate(0deg); }
        50% { transform: translateY(-6px) rotate(3deg); }
    }

    /* ================= NAVBAR (SCALED DOWN) ================= */

    .navbar {
        height: 56px;
        background: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 5%;
        box-shadow: 0 2px 10px rgba(10, 25, 47, 0.06);
        position: sticky;
        top: 0;
        z-index: 100;
        gap: 15px;
    }

    .logo {
        font-size: 22px;
        font-weight: 800;
        color: #0F172A;
        text-decoration: none;
        white-space: nowrap;
        transition: transform 0.2s ease;
    }

    .logo span {
        color: #2563EB;
    }

    .logo:hover {
        transform: scale(1.02);
    }

    /* Search Box in Navbar */
    .search-box {
        flex: 1;
        max-width: 420px;
        height: 36px;
        background: #f1f5f9;
        border-radius: 18px;
        display: flex;
        align-items: center;
        padding: 0 14px;
        border: 1.5px solid transparent;
        transition: all 0.25s ease;
    }

    .search-box:focus-within {
        background: white;
        border-color: #2563EB;
        box-shadow: 0 0 8px rgba(37, 99, 235, 0.12);
    }

    .search-box i {
        color: #64748b;
        margin-right: 8px;
        font-size: 13px;
    }

    .search-box input {
        border: none;
        outline: none;
        background: transparent;
        width: 100%;
        font-size: 13px;
    }

    .nav-right {
        display: flex;
        align-items: center;
        gap: 18px;
        white-space: nowrap;
    }

    .nav-link {
        text-decoration: none;
        color: #334155;
        font-size: 13.5px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: all 0.2s ease;
    }

    .nav-link:hover {
        color: #2563EB;
        transform: translateY(-1px);
    }

    .profile-container {
    position: relative;
    display: inline-block;
    cursor: pointer;
}

.profile-icon {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #2563EB;
    color: white;
    font-size: 17px;
}

/* Hidden initially */
.profile-info {
    position: absolute;
    top: 52px;
    right: 0;

    width: 210px;
    padding: 15px;

    background: white;
    border-radius: 10px;

    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.18);

    opacity: 0;
    visibility: hidden;
    transform: translateY(-8px);

    transition: all 0.2s ease;

    z-index: 1000;
}

/* Show when hovering profile */
.profile-container:hover .profile-info {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.profile-name {
    font-size: 16px;
    font-weight: 600;
    color: #222;
    margin-bottom: 5px;
}

.profile-email {
    font-size: 13px;
    color: #777;
    word-break: break-word;
}

    /* ================= HERO (SCALED DOWN) ================= */

    .hero {
        margin: 20px 5%;
        min-height: 190px;
        border-radius: 14px;
        background: linear-gradient(135deg, #0A192F 0%, #1E3A8A 60%, #1D4ED8 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 28px 40px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(10, 25, 47, 0.18);
        animation: fadeIn 0.6s ease-out;
    }

    .hero-content {
        max-width: 480px;
    }

    .hero-content h1 {
        font-size: 28px;
        margin-bottom: 8px;
        font-weight: 800;
        line-height: 1.25;
    }

    .hero-content p {
        font-size: 13px;
        line-height: 1.5;
        opacity: 0.9;
        margin-bottom: 16px;
    }

    .hero-btn {
        display: inline-block;
        text-decoration: none;
        background: #F59E0B;
        color: #0A192F;
        padding: 8px 20px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: bold;
        transition: all 0.25s ease;
        box-shadow: 0 3px 10px rgba(245, 158, 11, 0.35);
    }

    .hero-btn:hover {
        background: #FFB020;
        transform: translateY(-2px);
        box-shadow: 0 6px 14px rgba(245, 158, 11, 0.5);
    }

    .hero-icon {
        font-size: 90px;
        opacity: 0.2;
        margin-right: 20px;
        animation: floatIcon 4s ease-in-out infinite;
    }

    /* ================= SPECIAL DEALS BANNER ================= */

    .deals-section {
        margin: 20px 5%;
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        animation: fadeIn 0.8s ease-out;
    }

    .deal-card {
        background: white;
        border-radius: 12px;
        padding: 14px 18px;
        display: flex;
        align-items: center;
        gap: 15px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
        transition: all 0.25s ease;
    }

    .deal-card:hover {
        transform: translateY(-3px);
        border-color: #2563EB;
        box-shadow: 0 6px 14px rgba(37, 99, 235, 0.1);
    }

    .deal-icon {
        width: 42px;
        height: 42px;
        border-radius: 10px;
        background: #eff6ff;
        color: #2563EB;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        flex-shrink: 0;
    }

    .deal-info h4 {
        font-size: 14px;
        color: #0F172A;
        margin-bottom: 2px;
    }

    .deal-info p {
        font-size: 11.5px;
        color: #64748b;
    }

    /* ================= SECTION SCAFOLDING ================= */

    .section {
        margin: 28px 5%;
        animation: fadeIn 0.9s ease-out;
    }

    .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 16px;
    }

    .section-header h2 {
        font-size: 19px;
        color: #0A192F;
        font-weight: 700;
    }

    .view-all {
        color: #2563EB;
        font-size: 12.5px;
        cursor: pointer;
        font-weight: bold;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .view-all:hover {
        color: #1E3A8A;
    }

    /* ================= CATEGORIES (SCALED DOWN) ================= */

    .categories {
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        gap: 14px;
    }

    .category {
        background: white;
        border-radius: 12px;
        padding: 14px 8px;
        text-align: center;
        cursor: pointer;
        transition: all 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        border: 1px solid #e2e8f0;
        text-decoration: none;
    }

    .category:hover {
        transform: translateY(-5px) scale(1.02);
        box-shadow: 0 8px 16px rgba(30, 58, 138, 0.08);
        border-color: #2563EB;
    }

    .category-icon {
        width: 46px;
        height: 46px;
        margin: 0 auto 8px auto;
        border-radius: 50%;
        background: #eff6ff;
        color: #1E3A8A;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        transition: all 0.25s ease;
    }

    .category:hover .category-icon {
        background: #1E3A8A;
        color: white;
        transform: rotate(360deg);
    }

    .category p {
        font-size: 12px;
        font-weight: 700;
        color: #1e293b;
    }

    /* ================= RESTAURANTS (SCALED DOWN) ================= */

    .restaurant-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
    }

    .restaurant-card {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.25s ease;
        box-shadow: 0 3px 10px rgba(0,0,0,0.03);
        border: 1px solid #e2e8f0;
    }

    .restaurant-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 18px rgba(10, 25, 47, 0.1);
        border-color: #2563EB;
    }

    .restaurant-image {
        width: 100%;
        height: 135px;
        object-fit: cover;
        display: block;
        transition: transform 0.4s ease;
    }

    .restaurant-card:hover .restaurant-image {
        transform: scale(1.04);
    }

    .restaurant-info {
        padding: 12px;
    }

    .restaurant-info h3 {
        font-size: 15px;
        margin-bottom: 4px;
        color: #0F172A;
    }

    .cuisine {
        color: #64748b;
        font-size: 11.5px;
        margin-bottom: 8px;
    }

    .restaurant-bottom {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .rating {
        background: #F59E0B;
        color: white;
        padding: 2px 7px;
        border-radius: 4px;
        font-size: 10.5px;
        font-weight: bold;
    }

    /* ================= FDA FEATURED DISHES (BELOW RESTAURANTS, SCALED DOWN) ================= */

    #fda_product_tile {
        margin: 32px 5% 20px 5%;
        animation: fadeIn 1s ease-out;
    }

    #fda_product_tile span {
        display: block;
    }

    .fda_food_row {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        overflow-x: auto;
        gap: 16px;
        padding-top: 45px;
        padding-bottom: 12px;
        scroll-behavior: smooth;
    }

    .fda_food_row::-webkit-scrollbar {
        height: 5px;
    }

    .fda_food_row::-webkit-scrollbar-track {
        background: #e2e8f0;
        border-radius: 10px;
    }

    .fda_food_row::-webkit-scrollbar-thumb {
        background: #2563EB;
        border-radius: 10px;
    }

    .fda_food_item {
        flex: 0 0 190px;
        max-width: 190px;
    }

    .fda_food_row div.food_tile {
        background-color: white;
        font-size: 10px;
        padding: 0 14px 14px 14px;
        border-radius: 16px;
        text-align: center;
        border: 1px solid #e2e8f0;
        box-shadow: 0 3px 10px rgba(0,0,0,0.03);
        transition: all 0.25s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-between;
    }

    .fda_food_row div.food_tile:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 18px rgba(37, 99, 235, 0.1);
    }

    .fda_food_row div.food_tile.active {
        background-color: #eff6ff;
        border-color: #93c5fd;
    }

    .fda_food_row div.food_tile img {
        position: relative;
        width: 95px;
        height: 95px;
        object-fit: cover;
        border-radius: 100%;
        padding: 8px;
        background-color: #ffffff;
        box-shadow: inset 0 0 15px rgba(255,255,255,0.15),
                    inset 0 3px 0 rgba(0,0,0,0.04),
                    inset 0 -3px 0 rgba(0,0,0,0.04),
                    inset 0 6px 6px rgba(0,0,0,0.07),
                    0 1px 0px rgba(0,0,0,0.08),
                    0 5px 5px rgba(0,0,0,0.12);
        border: 1px solid rgba(0,0,0,0.08);
        margin-top: -40px;
        margin-bottom: 10px;
    }

    div.food_tile.active img {
        background-color: #dbeafe; 
    }

    .food_name {
        font-size: 13.5px;
        font-weight: 700;
        color: #0F172A;
        margin-bottom: 5px;
    }

    .food_detail {
        font-size: 10.5px;
        color: #64748b;
        line-height: 1.35;
        margin-bottom: 12px;   
    }

    .btn-default {
        border: 1px solid #cbd5e1;
        padding: 7px 20px;
        border-radius: 16px;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.3px;
        background-color: #f8fafc;
        color: #334155;
        cursor: pointer;
        transition: all 0.25s ease;
    }

    .btn-default:hover {
        background-color: #2563EB;
        color: #ffffff;
        border-color: #2563EB;
    }

    .active .btn-default {
        border: 1px solid transparent;
        background-color: #f88e7c;
        color: #fff;
        box-shadow: 0 3px 8px rgba(248,142,124,0.35);
    }

    .active .btn-default:hover {
        background-color: #e07765;
    }

    /* ================= EMPTY STATE ================= */

    .no-restaurants {
        background: white;
        padding: 30px;
        text-align: center;
        border-radius: 12px;
        color: #64748b;
        grid-column: 1 / -1;
        border: 2px dashed #cbd5e1;
        font-size: 13px;
    }

    /* ================= FOOTER (SCALED DOWN) ================= */

    footer {
        margin-top: 50px;
        background: #0A192F;
        color: white;
        padding: 35px 5% 20px 5%;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        gap: 20px;
        padding-bottom: 20px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    }

    .footer-logo {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 6px;
    }

    .footer-logo span {
        color: #2563EB;
    }

    .footer-text {
        color: #94a3b8;
        font-size: 12px;
        max-width: 300px;
        line-height: 1.5;
    }

    .footer-copyright {
        text-align: center;
        margin-top: 18px;
        font-size: 11.5px;
        color: #64748b;
    }

    /* ================= RESPONSIVE ================= */

    @media (max-width: 1024px) {
        .restaurant-grid { grid-template-columns: repeat(3, 1fr); }
        .categories { grid-template-columns: repeat(3, 1fr); }
        .hero-icon { font-size: 75px; }
    }

    @media (max-width: 700px) {
        .navbar {
            padding: 8px 4%;
            flex-wrap: wrap;
            height: auto;
            gap: 10px;
        }

        .search-box {
            order: 3;
            width: 100%;
            max-width: 100%;
        }

        .nav-link span { display: none; }
        .deals-section { grid-template-columns: 1fr; }

        .hero {
            margin: 15px 4%;
            padding: 22px 20px;
            min-height: 170px;
        }

        .hero-content h1 { font-size: 22px; }
        .hero-content p { font-size: 12px; }
        .hero-icon { display: none; }
        .section { margin: 20px 4%; }
        .categories { grid-template-columns: repeat(3, 1fr); gap: 10px; }
        .category { padding: 10px 4px; }
        .category-icon { width: 38px; height: 38px; font-size: 16px; }
        .restaurant-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
        .restaurant-image { height: 110px; }
        .restaurant-info { padding: 10px; }
        .restaurant-info h3 { font-size: 13.5px; }
        .footer-content { flex-direction: column; }
    }

    @media (max-width: 450px) {
        .restaurant-grid { grid-template-columns: 1fr; }
        .categories { grid-template-columns: repeat(3, 1fr); }
        .hero-content h1 { font-size: 20px; }
    }

</style>
</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <a href="HomeServlet" class="logo">Food<span>App</span></a>

    <div class="search-box">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" id="searchInput" placeholder="Search restaurants or food...">
    </div>

    <div class="nav-right">
        <a href="Cart.jsp" class="nav-link"><i class="fa-solid fa-cart-shopping"></i><span>Cart</span></a>
        <div class="profile-container">
    		<div class="profile-icon">
        		<i class="fa-solid fa-user"></i>
    		</div>

    		<div class="profile-info">
        		<div class="profile-name">
            		${sessionScope.username}
        		</div>

        		<div class="profile-email">
            		${sessionScope.email}
        		</div>
    		</div>
		</div>
    </div>

</nav>

<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-content">
        <h1>Good food.<br>Good mood.</h1>

        <p>
            Discover delicious food from the best restaurants
            around you and get it delivered right to your doorstep.
        </p>
    </div>

    <div class="hero-icon">
        <i class="fa-solid fa-bowl-food"></i>
    </div>
    
</section>

<!-- ================= FEATURED DEALS ================= -->

<div class="deals-section">
    <div class="deal-card">
        <div class="deal-icon">
            <i class="fa-solid fa-bolt"></i>
        </div>
        <div class="deal-info">
            <h4>Fast Express Delivery</h4>
            <p>Average delivery time under 30 minutes</p>
        </div>
    </div>

    <div class="deal-card">
        <div class="deal-icon">
            <i class="fa-solid fa-percent"></i>
        </div>
        <div class="deal-info">
            <h4>Exclusive Daily Offers</h4>
            <p>Save up to 50% off on selected restaurants</p>
        </div>
    </div>
</div>

<!-- ================= CATEGORIES ================= -->

<section class="section">

    <div class="section-header">
        <h2>What's on your mind?</h2>
    </div>

    <div class="categories">
        <a href="#" class="category">
            <div class="category-icon">
                <i class="fa-solid fa-bowl-food"></i>
            </div>
            <p>Biryani</p>
        </a>

        <a href="#" class="category"><!-- Restaurant.jsp?category=Pizza -->
            <div class="category-icon">
                <i class="fa-solid fa-pizza-slice"></i>
            </div>
            <p>Pizza</p>
        </a>

        <a href="#" class="category">
            <div class="category-icon">
                <i class="fa-solid fa-burger"></i>
            </div>
            <p>Burgers</p>
        </a>

        <a href="#" class="category">
            <div class="category-icon">
                <i class="fa-solid fa-utensils"></i>
            </div>
            <p>South Indian</p>
        </a>

        <a href="#" class="category">
            <div class="category-icon">
                <i class="fa-solid fa-ice-cream"></i>
            </div>
            <p>Desserts</p>
        </a>

        <a href="#" class="category">
            <div class="category-icon">
                <i class="fa-solid fa-mug-hot"></i>
            </div>
            <p>Drinks</p>
        </a>
    </div>

</section>

<!-- ================= RESTAURANTS ================= -->

<section class="section">

    <div class="section-header">
        <h2>Popular Restaurants</h2>
    </div>

    <div class="restaurant-grid" id="restaurantGrid">
        <%
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");

            if (restaurants != null && !restaurants.isEmpty()) {
                for (Restaurant r : restaurants) {
                	
        %>

        <a href="MenuServlet?restaurantId=<%= r.getRestaurant_id() %>"
           class="restaurant-card"
           data-name="<%= r.getName() %>"
           style="text-decoration: none; color: inherit;">

            <img src="<%= request.getContextPath() %>/<%= r.getImageData() %>" class="restaurant-image" alt="<%= r.getName() %>">
            <div class="restaurant-info">
                <h3><%= r.getName() %></h3>

                <p class="cuisine"><%= r.getCuisineType() %></p>
                <div class="restaurant-bottom">
                    <span class="rating">
                        ★ <%= r.getRating() %>
                    </span>
                </div>
            </div>

        </a>

        <%
                }
            } else {
        %>

            <div class="no-restaurants">
                <i class="fa-solid fa-utensils" style="font-size: 28px; margin-bottom: 10px;"></i>
                <h3>No restaurants available</h3>
                <p>Please check again later.</p>
            </div>

        <%
            }
        %>

    </div>

</section>

<!-- ================= HORIZONTAL FEATURED DISH CARDS (ADDED BELOW RESTAURANTS) ================= -->

<!-- ================= CHEF'S SPECIAL DISHES ================= -->

<section id="fda_product_tile">

    <div class="section-header" style="margin-bottom: 0;">
        <h2>Chef's Special Dishes</h2>
    </div>

    <div class="fda_food_row">
        <div class="fda_food_item">
            <div class="food_tile active" onclick="openMenu(102)" style="cursor: pointer;">

                <img src="fImages/chickenbiryani.jpg" alt="Chicken biryani" class="fda_product_img">
                <span class="food_name">Chicken biryani</span>
                <span class="food_name">★ 4.8</span>
                <span class="food_detail">Meghana foods</span>

                <!-- ORDER NOW -->
                <form action="CartServletF" method="post" class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="102">
                    <input type="hidden" name="itemId" value="1021">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>

        <div class="fda_food_item">
            <div class="food_tile" onclick="openMenu(106)" style="cursor: pointer">
                <img src="fImages/andhrabhojanam.jpg" alt="Andhra bhojanam" class="fda_product_img">
                <span class="food_name">Andhra bhojanam</span>
                <span class="food_name">★ 4.9</span>
                <span class="food_detail">Nandhana palace</span>
                <!-- ORDER NOW -->
                <form action="CartServletF" method="post" class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="106">
                    <input type="hidden" name="itemId" value="1102">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">

                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>

        <div class="fda_food_item">
            <div class="food_tile active" onclick="openMenu(109);" style="cursor: pointer">
                <img src="fImages/muttonbiryani.jpg" alt="Hyderabad mutton biryani" class="fda_product_img">
                <span class="food_name">Hyderabad mutton biryani</span>
                <span class="food_name">★ 4.7</span>
                <span class="food_detail">
                    Hanumanthu biryani
                </span>
                <!-- ORDER NOW -->
                <form action="cart" method="post"class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="109">
                    <input type="hidden" name="itemId" value="1162">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>

        <div class="fda_food_item">
            <div class="food_tile" onclick="openMenu(104);" style="cursor: pointer">
                <img src="fImages/ragimudda.jpg" alt="Muddha and Natu kodi" class="fda_product_img">
                <span class="food_name"> Muddha &amp; Natu kodi</span>
                <span class="food_name">★ 4.7</span>
                <span class="food_detail">Antera</span>
                <!-- ORDER NOW -->
                <form action="CartServletF" method="post" class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="104">
                    <input type="hidden" name="itemId" value="1061">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>

        <div class="fda_food_item">
            <div class="food_tile active" onclick="openMenu(105);" style="cursor: pointer">
                <img src="fImages/paneerbiryani.jpg" alt="Paneer biryani" class="fda_product_img">
                <span class="food_name">Paneer biryani</span>
                <span class="food_detail">★ 4.6</span>
                <span class="food_detail">Olive</span>
                <!-- ORDER NOW -->
                <form action="CartServletF" method="post" class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="105">
                    <input type="hidden" name="itemId" value="1081">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>

        <div class="fda_food_item">
            <div class="food_tile" onclick="openMenu(104);" style="cursor: pointer">
                <img src="fImages/apricot delight.jpg"  alt="Capricot delight" class="fda_product_img">
                <span class="food_name"> apricot delight</span>
                <span class="food_name">★ 5.0 </span>
                <span class="food_detail"> Antera</span>
                <!-- ORDER NOW -->
                <form action="CartServletF" method="post" class="featured-cart-form" onclick="event.stopPropagation();">
                    <input type="hidden" name="restaurantId" value="104">
                    <input type="hidden" name="itemId" value="1076">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn btn-default">Order Now</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-content">
        <div>
            <div class="footer-logo">Food<span>App</span></div>
            <p class="footer-text">
                Discover great food from amazing restaurants
                and enjoy delicious meals wherever you are.
            </p>
        </div>
    </div>

    <div class="footer-copyright">
        &copy; 2026 FoodApp. All rights reserved.
    </div>

</footer>

<!-- ================= SEARCH JAVASCRIPT ================= -->

<script>
    const searchInput = document.getElementById("searchInput");

    searchInput.addEventListener("keyup", function () {
        const searchValue = this.value.toLowerCase().trim();
        const cards = document.querySelectorAll(".restaurant-card");

        cards.forEach(function (card) {
            const restaurantName = card.getAttribute("data-name").toLowerCase();

            if (restaurantName.includes(searchValue)) {
                card.style.display = "";
            } else {
                card.style.display = "none";
            }
        });
    });
    
    function openMenu(restaurantId) {
        window.location.href =
            "<%= request.getContextPath() %>/MenuServlet?restaurantId=" + restaurantId;
    }
</script>

</body>
</html>