package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		if(session != null && session.getAttribute("email") != null) {
			
			RestaurantDAOImpl rd = new RestaurantDAOImpl();
			List<Restaurant> allrestaurants = rd.getAllRestaurants();
			request.setAttribute("restaurants", allrestaurants);
			
			request.getRequestDispatcher("Home.jsp").forward(request, response);
		}
	}

}
