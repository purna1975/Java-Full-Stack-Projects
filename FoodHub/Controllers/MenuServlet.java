package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoimpl.MenuDAOImpl;
import com.tap.model.Menu;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        int rId = Integer.parseInt(req.getParameter("restaurantId"));
        
        MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
        
        List<Menu> ls = menuDAOImpl.getAllMenusByRestaurantId(rId);
        
        req.setAttribute("menus", ls);
        
        RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, resp);
    }
}