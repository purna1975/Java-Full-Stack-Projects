package com.tap.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoimpl.MenuDAOImpl;
import com.tap.model.Menu;
import com.tap.test.Cart;
import com.tap.test.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
	    Cart cart = (Cart) session.getAttribute("cart");

	    Integer newRestaurantId = null;

	    String restParam = req.getParameter("restaurantId");
	    if (restParam != null) {
	        newRestaurantId = Integer.parseInt(restParam);
	    } else {
	        newRestaurantId = (Integer) session.getAttribute("restaurantId");
	    }

	    Integer currentRestaurantId = (Integer) session.getAttribute("restaurantId");

	    if (cart == null || currentRestaurantId == null || !currentRestaurantId.equals(newRestaurantId)) {
	        cart = new Cart();
	        session.setAttribute("cart", cart);
	        session.setAttribute("restaurantId", newRestaurantId);
	    }


	    String action = req.getParameter("action");

	    if ("add".equals(action)) {
	        addItemToCart(req, cart);
	    } else if ("update".equals(action)) {
	        updateCartItem(req, cart);
	    } else if ("remove".equals(action)) {
	        removeItemFromCart(req, cart);
	    }

	    resp.sendRedirect("cart.jsp");
		
		
		
	}

	private void removeItemFromCart(HttpServletRequest req, Cart cart) {
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		cart.removeItem(itemId);
		
	}

	private void updateCartItem(HttpServletRequest req, Cart cart) {
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		cart.updateItem(itemId, quantity);
		
		
	}

	private void addItemToCart(HttpServletRequest req, Cart cart) {
		
		int itemId = Integer.parseInt(req.getParameter("itemId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		MenuDAOImpl menuDAO = new MenuDAOImpl();
		Menu menuItem = menuDAO.getMenu(itemId);
		
		if(menuItem != null) {
			CartItem item = new CartItem(menuItem.getMenuId(), menuItem.getRestaurantId(), menuItem.getItemName(), quantity, menuItem.getPrice());
			cart.addItem(item);
		}
		
	}

}
