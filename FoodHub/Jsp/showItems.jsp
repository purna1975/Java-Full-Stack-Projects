<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.tap.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - FoodHub</title>
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
        .order-details-container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .order-header {
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        .item-card {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .item-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 1rem;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-price {
            font-weight: bold;
            color: #fc8019;
        }
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 2rem;
        }
        .btn-primary {
            background-color: #fc8019;
            border-color: #fc8019;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #e67312;
            border-color: #e67312;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(230, 115, 18, 0.3);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .item-card {
            animation: fadeIn 0.5s ease-out forwards;
        }
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

    <div class="container order-details-container">
        <div class="order-header">
            <h1 class="mb-3">Order Details</h1>
            <p class="text-muted mb-0">Order #<%= session.getAttribute("orderId") %></p>
        </div>

        <%
            List<OrderItem> orderItemsList = (List<OrderItem>) session.getAttribute("orderItemsList");
            if (orderItemsList == null || orderItemsList.isEmpty()) {
        %>
            <div class="alert alert-info text-center" role="alert">
                <i class="bi bi-info-circle me-2"></i>No items found for this order.
            </div>
        <%
            } else {
                int totalOrderAmount = 0;
        %>
            <div class="order-items">
                <%
                    for (OrderItem item : orderItemsList) {
                        totalOrderAmount += item.getTotalAmount();
                %>
                    <div class="item-card">
                        
               
                        <div class="item-details">
                            <h5 class="mb-1">Item #<%= item.getMenuId() %></h5>
                            <p class="mb-0 text-muted">Quantity: <%= item.getQuantity() %></p>
                        </div>
                        <div class="item-price">
                            ₹<%= item.getTotalAmount() %>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>

            <div class="order-summary">
                <div class="d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Total Order Amount</h4>
                    <h4 class="mb-0 text-primary">₹<%= totalOrderAmount %></h4>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="OrderHistory" class="btn btn-primary">
                    <i class="bi bi-arrow-left me-2"></i>Back to Order History
                </a>
            </div>
        <%
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const itemCards = document.querySelectorAll('.item-card');
            itemCards.forEach((card, index) => {
                card.style.animationDelay = `${0.1 * (index + 1)}s`;
            });
        });
    </script>
</body>
</html>
