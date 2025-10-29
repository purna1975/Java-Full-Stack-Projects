<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.tap.model.OrderHistory" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - FoodHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            padding-top: 60px;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .order-history-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .order-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .order-header {
            background-color: #fc8019;
            color: white;
            padding: 15px 20px;
            font-size: 1.1rem;
        }
        .order-body {
            padding: 20px;
        }
        .order-footer {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-top: 1px solid #e9ecef;
        }
        .view-details-btn {
            background-color: #fc8019;
            border-color: #fc8019;
            transition: all 0.3s ease;
        }
        .view-details-btn:hover {
            background-color: #e67312;
            border-color: #e67312;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(230, 115, 18, 0.3);
        }
        .status-badge {
            font-size: 0.85rem;
            padding: 0.35em 0.65em;
            border-radius: 20px;
            font-weight: 600;
        }
        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }
        .order-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .order-info-label {
            font-weight: 600;
            color: #6c757d;
        }
        .order-info-value {
            font-weight: 500;
        }
        .no-orders {
            text-align: center;
            padding: 40px 20px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .no-orders i {
            font-size: 3rem;
            color: #fc8019;
            margin-bottom: 20px;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .order-card {
            animation: fadeInUp 0.5s ease-out forwards;
            opacity: 0;
        }
        .order-card:nth-child(1) { animation-delay: 0.1s; }
        .order-card:nth-child(2) { animation-delay: 0.2s; }
        .order-card:nth-child(3) { animation-delay: 0.3s; }
        .order-card:nth-child(4) { animation-delay: 0.4s; }
        .order-card:nth-child(5) { animation-delay: 0.5s; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-danger" href="#">
                <i class="bi bi-egg-fried me-2"></i>FoodHub
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="home.jsp">Home</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-5 order-history-container">
        <h1 class="mb-4 text-center">Your Order History</h1>

        <%
            List<OrderHistory> orderHistoryList = (List<OrderHistory>) request.getAttribute("orderHistoryList");
            if (orderHistoryList == null || orderHistoryList.isEmpty()) {
        %>
            <div class="no-orders">
                <i class="bi bi-clock-history"></i>
                <h3>No orders found</h3>
                <p class="text-muted">Start ordering to see your history here!</p>
                <a href="home.jsp" class="btn btn-primary mt-3">
                    <i class="bi bi-arrow-left me-2"></i>Browse Restaurants
                </a>
            </div>
        <%
            } else {
                for (OrderHistory order : orderHistoryList) {
        %>
                    <div class="order-card">
                        <div class="order-header">
                            <h5 class="mb-0"><i class="bi bi-shop me-2"></i>Order #<%= order.getOrderId() %></h5>
                        </div>
                        <div class="order-body">
                            <div class="order-info">
                                <span class="order-info-label">Date:</span>
                                <span class="order-info-value"><%= order.getDate() %></span>
                            </div>
                            <div class="order-info">
                                <span class="order-info-label">Total Amount:</span>
                                <span class="order-info-value">₹<%= order.getTotalAmount() %></span>
                            </div>
                            <div class="order-info">
                                <span class="order-info-label">Status:</span>
                                <span class="status-badge status-pending">
                                    <%= order.getStatus() %>
                                </span>
                            </div>
                        </div>
                        <div class="order-footer">
                            <form action="viewdetailsServlet" method="post" class="text-end">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <button type="submit" class="btn btn-primary view-details-btn">
                                    <i class="bi bi-eye me-2"></i>View Details
                                </button>
                            </form>
                        </div>
                    </div>
        <%
                }
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const orderCards = document.querySelectorAll('.order-card');
            orderCards.forEach((card, index) => {
                card.style.animationDelay = `${0.1 * (index + 1)}s`;
            });
        });
    </script>
</body>
</html>