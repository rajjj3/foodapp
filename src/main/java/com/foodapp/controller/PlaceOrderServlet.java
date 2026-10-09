package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.daoimpl.OrderDAOImpl;
import com.foodapp.daoimpl.OrderHistoryDAOImpl;
import com.foodapp.daoimpl.OrderItemDAOImpl;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.CartItem;
import com.foodapp.model.Order;
import com.foodapp.model.OrderItem;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // SESSION VALIDATION
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // GET CART
        @SuppressWarnings("unchecked")
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("Cart.jsp");
            return;
        }

        // GET LOGGED-IN USER
        String email = (String) session.getAttribute("email");

        UserDAOImpl userDAO = new UserDAOImpl();
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUser_id();

        // GET RESTAURANT ID FROM CART
        int restaurantId = cart.get(0).getRestaurant_id();

        // GET PAYMENT MODE
        String paymentMode = request.getParameter("paymentMode");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            paymentMode = "Cash on Delivery";
        }

        // CALCULATE TOTAL FROM CART
        double totalAmount = 0;
        for (CartItem item : cart) {
            if (item.getQuantity() <= 0) {
                continue;
            }
            totalAmount += item.getTotalPrice();
        }

        if (totalAmount <= 0) {
            response.sendRedirect("Cart.jsp");
            return;
        }

        /** CREATE ORDER*/
        Order order = new Order();

        order.setUserId(userId);
        order.setRestaurantId(restaurantId);
        order.setTotal_amount(totalAmount);
        order.setStatus("Placed");
        order.setPayment_mode(paymentMode);

        OrderDAOImpl orderDAO = new OrderDAOImpl();

        int orderId = orderDAO.createOrder(order);

        if (orderId <= 0) {
            response.sendRedirect("Checkout.jsp");
            return;
        }

        /** CREATE ORDER ITEMS*/
        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

        for (CartItem cartItem : cart) {

            if (cartItem.getQuantity() <= 0) {
                continue;
            }

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder_id(orderId);
            orderItem.setMenu_id(cartItem.getMenu_id());
            orderItem.setQuantity(cartItem.getQuantity());
            int orderItemId = orderItemDAO.addOrderItem(orderItem);

            if (orderItemId <= 0) {
                response.sendRedirect("Checkout.jsp");
                return;
            }
        }

        /** ADD INITIAL ORDER HISTORY*/
        OrderHistoryDAOImpl orderHistoryDAO = new OrderHistoryDAOImpl();

        orderHistoryDAO.addHistory(
                orderId,
                "Placed"
        );

        /** ORDER COMPLETED* CLEAR CART */
        session.removeAttribute("cart");
        
        /** SEND ORDER ID TO SUCCESS PAGE */
        session.setAttribute(
                "lastOrderId",
                orderId
        );

        response.sendRedirect("OrderSuccess.jsp");
    }
}
