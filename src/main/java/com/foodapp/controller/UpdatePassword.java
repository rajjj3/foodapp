package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UpdatePassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession();
//
//        // Get logged-in user
//        Integer userId = (Integer) session.getAttribute("user_id");
//
//        if (userId == null) {
//            response.sendRedirect("Login.jsp");
//            return;
//        }

        // Get passwords from JSP
    	String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check whether passwords match
        if (!password.equals(confirmPassword)) {

            request.setAttribute("error","Passwords do not match");
            request.getRequestDispatcher("UpdatePassword.jsp").forward(request, response);
            return;
        }

        // Update password
        UserDAO userDAO = new UserDAOImpl();

        int updated = userDAO.updatePassword(email, password);

        if (updated==1) {
            request.setAttribute("success","Password changed successfully");

        } else {

            request.setAttribute("error","Password update failed");
        }
        request.getRequestDispatcher("UpdatePassword.jsp")
        .forward(request, response);
    }
}