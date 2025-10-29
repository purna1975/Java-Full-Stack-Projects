package com.tap.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Invalidate the current session to log the user out
        HttpSession session = req.getSession(false); // Get the existing session
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }
        
        // Redirect the user to the login page or home page
        resp.sendRedirect("home.jsp"); // Change this to the appropriate page for your app
    }
}