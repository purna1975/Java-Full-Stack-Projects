<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - Wonderland Travels</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap/css/mdb.css">
    <style>
        :root {
            --success-color: #10b981;
            --primary-color: #2563eb;
            --border-radius: 16px;
        }

        body {
            background-color: #f8fafc;
        }

        .confirmation-container {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        /* Enhanced Animated Success Checkmark */
        .success-animation {
            margin: 0 auto;
            width: 150px;
            height: 150px;
            position: relative;
            margin-bottom: 3rem;
            background: linear-gradient(145deg, #ebfaf5, #dcfce7);
            border-radius: 50%;
            padding: 15px;
            box-shadow: 
                0 10px 20px rgba(16, 185, 129, 0.1),
                0 3px 6px rgba(16, 185, 129, 0.05),
                inset 0 -3px 6px rgba(16, 185, 129, 0.2);
            animation: container-scale 0.5s cubic-bezier(0.165, 0.84, 0.44, 1) forwards;
            transform: scale(0.8);
            opacity: 0;
        }

        @keyframes container-scale {
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .success-animation::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            border-radius: 50%;
            background: linear-gradient(145deg, rgba(16, 185, 129, 0.2), transparent);
            filter: blur(10px);
            z-index: -1;
        }

        .success-animation::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            box-shadow: inset 0 0 0 2px rgba(16, 185, 129, 0.2);
            animation: ring-pulse 2s cubic-bezier(0.165, 0.84, 0.44, 1) infinite;
        }

        @keyframes ring-pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.5;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        .checkmark {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            display: block;
            stroke-width: 4;
            stroke: var(--success-color);
            stroke-miterlimit: 10;
            animation: 
                fill .4s ease-in-out .4s forwards,
                scale-check .3s ease-in-out .9s both;
            filter: drop-shadow(0 2px 4px rgba(16, 185, 129, 0.3));
        }

        .checkmark__circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 4;
            stroke-miterlimit: 10;
            stroke: var(--success-color);
            fill: none;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
            filter: drop-shadow(0 2px 4px rgba(16, 185, 129, 0.2));
        }

        .checkmark__check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            stroke-width: 4;
            animation: 
                stroke 0.2s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards,
                bounce 0.2s cubic-bezier(0.65, 0, 0.45, 1) 1s forwards;
        }

        @keyframes stroke {
            100% { 
                stroke-dashoffset: 0;
            }
        }

        @keyframes scale-check {
            0%, 100% { 
                transform: none;
            }
            50% { 
                transform: scale3d(1.1, 1.1, 1);
            }
        }

        @keyframes fill {
            100% { 
                box-shadow: inset 0px 0px 0px 80px transparent;
            }
        }

        @keyframes bounce {
            50% {
                transform: scale(0.9) translate(0, 5px);
            }
            100% {
                transform: scale(1) translate(0, 0);
            }
        }

        .confirmation-message {
            font-size: 2.5rem;
            color: var(--success-color);
            margin-bottom: 1rem;
            font-weight: 600;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.5s ease-out 1.2s forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .booking-details {
            background: #f8fafc;
            padding: 2rem;
            border-radius: var(--border-radius);
            margin: 2rem 0;
            text-align: left;
            border: 2px dashed #e2e8f0;
            position: relative;
            overflow: hidden;
        }

        .booking-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--success-color), #34d399);
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .booking-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .detail-item {
            padding: 1.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 
                0 4px 6px -1px rgba(0, 0, 0, 0.05),
                0 2px 4px -1px rgba(0, 0, 0, 0.03);
            transition: all 0.3s ease;
            border: 1px solid #f1f5f9;
        }

        .detail-item:hover {
            transform: translateY(-2px);
            box-shadow: 
                0 6px 8px -1px rgba(0, 0, 0, 0.08),
                0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border-color: #e2e8f0;
        }

        .detail-item h6 {
            color: #64748b;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .detail-item p {
            margin: 0;
            font-weight: 600;
            color: #1e293b;
            font-size: 1.125rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border-radius: 9999px;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(16, 185, 129, 0.1);
        }

        .status-badge i {
            margin-right: 0.5rem;
        }

        .email-notification {
            margin-top: 2rem;
            padding: 1rem 1.5rem;
            background: #eff6ff;
            border-radius: var(--border-radius);
            color: #1e40af;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 2px 4px rgba(30, 64, 175, 0.05);
            border: 1px solid rgba(30, 64, 175, 0.1);
        }

        .confirmation-actions {
            margin-top: 3rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
        }

        .btn-outline {
            border: 2px solid #e2e8f0;
            background: transparent;
            color: #64748b;
            padding: 0.75rem 2rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline:hover {
            border-color: #94a3b8;
            color: #1e293b;
            background: #f8fafc;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Integer bookingId = (Integer) session.getAttribute("bookingId");
    if (bookingId == null) {
        response.sendRedirect("booking.jsp");
        return;
    }
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <i class="fas fa-globe-americas mr-2"></i>
            Wonderland Travels
        </a>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <span class="nav-link">Welcome, <%= user.getName() %>!</span>
            </li>
        </ul>
    </div>
</nav>

<div class="container my-5">
    <div class="confirmation-container">
        <div class="success-animation">
            <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                <circle class="checkmark__circle" cx="26" cy="26" r="23" fill="none"/>
                <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
            </svg>
        </div>

        <h1 class="confirmation-message">Booking Confirmed!</h1>
        <p class="lead mb-4">Thank you for choosing Wonderland Travels for your journey</p>
        
        <div class="booking-details">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="mb-0">Booking Details</h4>
                <span class="status-badge">
                    <i class="fas fa-check-circle"></i>
                    Confirmed
                </span>
            </div>
            
            <div class="booking-details-grid">
                <div class="detail-item">
                    <h6>Booking ID</h6>
                    <p>#<%= bookingId %></p>
                </div>
                <div class="detail-item">
                    <h6>Booking Date</h6>
                    <p><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></p>
                </div>
                <div class="detail-item">
                    <h6>Customer Name</h6>
                    <p><%= user.getName() %></p>
                </div>
                <div class="detail-item">
                    <h6>Payment Status</h6>
                    <p class="text-success">Paid</p>
                </div>
            </div>
        </div>
        
        <div class="email-notification">
            <i class="fas fa-envelope"></i>
            <span>A confirmation email has been sent to your registered email address</span>
        </div>
        
        <div class="confirmation-actions">
            <a href="home.jsp" class="btn btn-primary">
                <i class="fas fa-home mr-2"></i>
                Return to Home
            </a>
            <button class="btn btn-outline" onclick="window.print()">
                <i class="fas fa-print mr-2"></i>
                Print Details
            </button>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Wonderland Travels</h5>
                <p>Making your wonder-visits memorable.</p>
            </div>
            <div class="col-md-3">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="home.jsp" class="text-white">Home</a></li>
                    <li><a href="#" class="text-white">About</a></li>
                    <li><a href="#" class="text-white">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Need Help?</h5>
                <ul class="list-unstyled">
                    <li><i class="fas fa-phone mr-2"></i> +1 234 567 890</li>
                    <li><i class="fas fa-envelope mr-2"></i> support@wonderland.com</li>
                </ul>
            </div>
        </div>
        <hr class="bg-light">
        <p class="text-center mb-0">&copy; 2025 Wonderland Travels. All rights reserved.</p>
    </div>
</footer>

<!-- Scripts -->
<script src="bootstrap/js/jquery.js"></script>
<script src="bootstrap/js/popper.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
<script src="bootstrap/js/mdb.js"></script>

<%
    // Clear the booking ID from session after displaying
    session.removeAttribute("bookingId");
%>

</body>
</html>