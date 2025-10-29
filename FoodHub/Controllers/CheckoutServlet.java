package com.tap.servlet;

import com.tap.daoimpl.OrderDAOImpl;
import com.tap.daoimpl.OrderItemDAOImpl;
import com.tap.daoimpl.OrderHistoryDAOImpl;
import com.tap.test.Cart;
import com.tap.test.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/checkoutServlet")
public class CheckoutServlet extends HttpServlet {
	
	private OrderDAOImpl orderDao;
	private OrderItemDAOImpl orderItemDAO;
	
	@Override
	public void init() throws ServletException {
		
		orderDao = new OrderDAOImpl();
		orderItemDAO = new OrderItemDAOImpl();
	}

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve user and cart details from the session
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user != null && cart != null && !cart.getItems().isEmpty()) {
            // Get the form inputs
            String address = req.getParameter("address");
            String modeOfPayment = req.getParameter("modeOfPayment");


            
            Order order = new Order();
            order.setRestaurantId((int)session.getAttribute("restaurantId"));
            order.setUserId(user.getUserId());
            order.setOrderDate(new java.sql.Date(new Date().getTime()));
            
         // Calculate total amount
            double totalAmount = 0;
            for (CartItem item : cart.getItems().values()) {
                totalAmount += item.getPrice() * item.getQuantity();
            }
            order.setTotalAmount(totalAmount);
            order.setStatus("pending");
            order.setPaymentMode(modeOfPayment);
            
            int orderId = orderDao.addOrder(order);
            
           
            for (CartItem item : cart.getItems().values()) {
            	
        			int itemId = item.getItemId();
        			double price = item.getPrice();
        			int quantity = item.getQuantity();
        			double totalPrice = price * quantity;
        			
//        			OrderItem oi = new OrderItem(orderId, itemId,quantity,totalPrice);
//        			
//        			orderItemDAO.addOrderItem(oi);
        			
        			int i = orderItemDAO.insertOrderItem(orderId, itemId, quantity, totalPrice);
                
            }
            
            OrderHistoryDAOImpl orderHistoryDAO = new OrderHistoryDAOImpl();
            int orderHistoryResult = orderHistoryDAO.insertOrderHistory(orderId, user.getUserId(), new Date(), (int) totalAmount, "pending", (int)session.getAttribute("restaurantId"));
            if(orderHistoryResult > 0) {
            	cart.clear();
            	resp.sendRedirect("orderconfirmation.jsp");
            }
            else {
            	resp.sendRedirect("error.jsp");            	
            }
        } 
        else {

            resp.sendRedirect("home.jsp");
        }
    }
}