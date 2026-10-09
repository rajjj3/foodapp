package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.UserDAO;
import com.foodapp.daoimpl.UserDAOImpl;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
                           throws ServletException, IOException {

        String username = req.getParameter("username").trim();
        String email = req.getParameter("email").trim().toLowerCase();
        String password = req.getParameter("password");
        String cpassword = req.getParameter("cpassword");
        String mobile = req.getParameter("mobile").trim();
        String role = req.getParameter("role").trim();
        String city = req.getParameter("city").trim();

        UserDAO udao = new UserDAOImpl();


        if (password == null || cpassword == null || !password.equals(cpassword)) {

            req.setAttribute("errorMessage",
                    "Passwords do not match. Please enter the same password.");

            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("mobile", mobile);
            req.setAttribute("city", city);

            req.getRequestDispatcher("Registration.jsp")
               .forward(req, resp);

            return;
        }


        //Check whether email already exists
        User existingUser = udao.getUserByEmail(email);

        if (existingUser != null) {

            req.setAttribute("errorMessage",
                    "Email is already registered. Please login.");

            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("mobile", mobile);
            req.setAttribute("city", city);

            req.getRequestDispatcher("Registration.jsp")
               .forward(req, resp);

            return;
        }
        
        //check whether mobile already exists
        User existingMobile = udao.fetchOneUser(mobile);
        
        if(existingMobile != null) {
        	
        	req.setAttribute("errorMessage", "Number already exists");
        	
        	req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("mobile", mobile);
            req.setAttribute("city", city);
        	
        	req.getRequestDispatcher("Registration.jsp").forward(req, resp);
        	return;
        }

        User user = new User(username,password,email,city,mobile,role);

        int res = udao.addUser(user);

        if (res != -1) {

        	HttpSession session = req.getSession();

            session.setAttribute("user_id", res);
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("mobile", mobile);
            session.setAttribute("city", city);
            session.setAttribute("role", role);

            resp.getWriter().println("Registration successful");

        }

        else {

            req.setAttribute("errorMessage",
                    "Registration failed. Please try again.");

            req.getRequestDispatcher("Registration.jsp")
               .forward(req, resp);
        }
    }
}