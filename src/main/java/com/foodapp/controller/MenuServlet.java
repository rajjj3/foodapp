package com.foodapp.controller;

import java.io.IOException;
import java.util.List;

import com.foodapp.daoimpl.MenuDAOImpl;
import com.foodapp.daoimpl.RestaurantDAOImpl;
import com.foodapp.model.Menu;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		if(session != null && session.getAttribute("email") != null) {
			
			int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
			RestaurantDAOImpl rd = new RestaurantDAOImpl();
			Restaurant restaurantinfo = rd.getRestaurantById(restaurantId);
			request.setAttribute("restaurantinfo", restaurantinfo);
		
			MenuDAOImpl mn = new MenuDAOImpl();		
			List<Menu> menu = (List<Menu>) mn.getMenuByRestaurantId(restaurantId);
			request.setAttribute("menulist", menu);
			request.getRequestDispatcher("Menu.jsp").forward(request,response);
	
		}
		
	}
	
}
