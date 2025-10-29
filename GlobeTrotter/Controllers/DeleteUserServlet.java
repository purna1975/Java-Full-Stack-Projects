package com.tap.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.tap.daoimpl.UserDaoImpl;

@WebServlet("/deleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	@Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        UserDaoImpl userDao = new UserDaoImpl();
        userDao.deleteUser(userId);
        response.sendRedirect("manageUsers.jsp");
    }
}
