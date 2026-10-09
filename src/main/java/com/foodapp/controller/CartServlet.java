package com.foodapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.model.CartItem;
import com.foodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // session validation
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        @SuppressWarnings("unchecked")
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("add".equals(action)) {
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            String[] itemIds = request.getParameterValues("itemId");
            String[] quantities = request.getParameterValues("quantity");
            if (itemIds != null && quantities != null) {
               if (!cart.isEmpty()) {
                    int existingRestaurantId =cart.get(0).getRestaurant_id();
                    if (existingRestaurantId != restaurantId) {
                        cart.clear();
                    }
                }
                MenuDAOImpl menuDAO = new MenuDAOImpl();
                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = Integer.parseInt(itemIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    if (quantity <= 0) {
                        continue;
                    }
                    Menu menu = menuDAO.getMenuById(itemId);
                    if (menu == null) {
                        continue;
                    }

                    CartItem existingItem = null;

                    /** CHECK WHETHER ITEM IS ALREADY IN CART*/
                    for (CartItem item : cart) {
                        if (item.getMenu_id() == itemId) {
                            existingItem = item;
                            break;
                        }
                    }
                    if (existingItem != null) {
                        // ITEM ALREADY EXISTS
                        existingItem.setQuantity(
                                existingItem.getQuantity() + quantity
                        );
                    } else {
                        // NEW ITEM
                        CartItem cartItem = new CartItem();
                        cartItem.setMenu_id(menu.getMenuId());
                        cartItem.setRestaurant_id(restaurantId);
                        cartItem.setItem_name(menu.getItem_name());
                        cartItem.setPrice(menu.getPrice());
                        cartItem.setQuantity(quantity);
                        cart.add(cartItem);
                    }
                }
            }
        }

        // INCREASE QUANTITY
        else if ("increase".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            for (CartItem item : cart) {
                if (item.getMenu_id() == itemId) {
                    item.setQuantity(item.getQuantity() + 1);
                    break;
                }
            }
        }

        // DECREASE QUANTITY
        else if ("decrease".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            for (int i = 0; i < cart.size(); i++) {
                CartItem item = cart.get(i);
                if (item.getMenu_id() == itemId) {
                    if (item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    } else {
                        cart.remove(i);
                    }
                    break;
                }
            }
        }

        // REMOVE ITEM
        else if ("remove".equals(action)) {

            int itemId = Integer.parseInt(request.getParameter("itemId"));
            for (int i = 0; i < cart.size(); i++) {
                if (cart.get(i).getMenu_id() == itemId) {
                    cart.remove(i);
                    break;
                }
            }
        }

        // CLEAR CART
        else if ("clear".equals(action)) {
            cart.clear();
        }

        // SAVE CART BACK TO SESSION
        session.setAttribute("cart", cart);
        response.sendRedirect("Cart.jsp");
    }

    protected void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        // SESSION VALIDATIOn
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        @SuppressWarnings("unchecked")
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("Cart.jsp")
               .forward(request, response);
    }
}