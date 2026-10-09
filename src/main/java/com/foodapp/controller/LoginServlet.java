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

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
   @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		HttpSession session = request.getSession();
		
		UserDAO udao = new UserDAOImpl();
		User existingUser = udao.getUserByEmail(email);
		
		if(existingUser != null) {
			if(!password.equals(existingUser.getPassword())) {
				
				request.setAttribute("passwordError", "Wrong password, Try again");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
				return;
				
			}else {
				
				session.setAttribute("username", existingUser.getUsername());
				session.setAttribute("email", email);
				response.sendRedirect("HomeServlet");
				
			}
		}else {
			
			request.setAttribute("emailError", "You're not registered with us");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			return;
		}
		
	}

}
