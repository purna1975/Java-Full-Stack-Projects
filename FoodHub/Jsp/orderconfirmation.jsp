<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - FoodHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .confirmation-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .confirmation-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }
        .animation-container {
            position: relative;
            height: 120px;
            margin-bottom: 2rem;
            overflow: hidden;
        }
        .bike {
            position: absolute;
            font-size: 3rem;
            color: #fc8019;
            animation: ride 4s linear forwards;
        }
        @keyframes ride {
            0% { left: -50px; }
            100% { left: calc(100% + 50px); }
        }
        .road {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 5px;
            background-color: #333;
        }
        .tick-mark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0);
            font-size: 5rem;
            color: #28a745;
            opacity: 0;
            animation: popIn 0.5s ease-out 4s forwards;
        }
        @keyframes popIn {
            to {
                transform: translate(-50%, -50%) scale(1);
                opacity: 1;
            }
        }
        .confirmation-text {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeIn 0.5s ease-out 4.5s forwards;
        }
        @keyframes fadeIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .btn-primary {
            background-color: #fc8019;
            border-color: #fc8019;
            transition: all 0.3s ease;
            padding: 10px 20px;
            font-size: 1.1rem;
        }
        .btn-primary:hover {
            background-color: #e67312;
            border-color: #e67312;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(230, 115, 18, 0.3);
        }
        .order-details {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e9ecef;
        }
        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
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

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="confirmation-container">
                    <div class="animation-container">
                        <div class="bike">
                            <i class="bi bi-bicycle"></i>
                        </div>
                        <div class="road"></div>
                        <div class="tick-mark">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                    <div class="confirmation-text">
                        <h1 class="mb-4">Order Placed Successfully!</h1>
                        <p class="mb-4">Your delicious meal is on its way. Thank you for choosing FoodHub!</p>
                        <div class="order-details">
                            <h4 class="mb-3">Order Details</h4>
                            <div class="detail-item">
                                <span>Order Number:</span>
                                <span>#FH12345</span>
                            </div>
                            <div class="detail-item">
                                <span>Estimated Delivery Time:</span>
                                <span>30-45 minutes</span>
                            </div>
                        </div>
                        <a href="home.jsp" class="btn btn-primary btn-lg mt-4">
                            <i class="bi bi-house-door me-2"></i>Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                document.querySelector('.confirmation-container').style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>