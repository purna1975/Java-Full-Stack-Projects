package com.tap.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoimpl.UserDaoImpl;
import com.tap.model.User;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // Track attempts per user session
        Integer attempts = (Integer) session.getAttribute("attempts");
        if (attempts == null) {
            attempts = 3; // start with 3 chances
        }

        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.loginUser(email, password);

        if (user != null) {
            // ✅ Successful login → reset attempts
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            session.removeAttribute("attempts");

            System.out.println("User logged in successfully. userId: " + user.getUserId());
            response.sendRedirect("home.jsp");

        } else {
            attempts--;

            if (attempts > 0) {
                session.setAttribute("attempts", attempts);
                request.setAttribute("error", "Wrong credentials! " + attempts + " attempt(s) left.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                session.removeAttribute("attempts");
                request.setAttribute("error", "Your attempts are over!");
                request.getRequestDispatcher("failure.jsp").forward(request, response);
            }
        }

    }
}
