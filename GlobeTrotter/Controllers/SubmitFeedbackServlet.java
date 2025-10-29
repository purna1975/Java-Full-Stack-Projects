package com.tap.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.tap.daoimpl.FeedbackDaoImpl;
import com.tap.model.Feedback;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {

	@Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve data from the form
        String name = request.getParameter("fname");
        String email = request.getParameter("fmail");
        String mobile = request.getParameter("fmno");
        String message = request.getParameter("fmsg");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Create Feedback object
        Feedback feedback = new Feedback(userId, message, rating);

        // Create DAO object and submit feedback
        FeedbackDaoImpl feedbackDao = new FeedbackDaoImpl();
        feedbackDao.submitFeedback(feedback);

        // Redirect to home.jsp or show success message
        response.sendRedirect("home.jsp?feedbackSuccess=true");
        
       
    }
}