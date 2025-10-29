<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.test.Cart" %>
<%@ page import="com.tap.test.CartItem" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.daoimpl.OrderDAOImpl" %>
<%@ page import="com.tap.daoimpl.OrderItemDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FoodHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .checkout-container {
            margin: 30px auto;
            max-width: 800px;
        }
        .checkout-form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .total-amount {
            font-size: 1.2em;
            font-weight: bold;
            color: #fc8019;
        }
        .btn-primary {
            background-color: #fc8019;
            border-color: #fc8019;
        }
        .btn-primary:hover {
            background-color: #e67312;
            border-color: #e67312;
        }
        .payment-method-option {
            border: 1px solid #ced4da;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .payment-method-option:hover, .payment-method-option.selected {
            border-color: #fc8019;
            background-color: #fff5e6;
        }
        .payment-details {
            display: none;
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 8px;
        }
        .upi-options {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .upi-option {
            text-align: center;
            cursor: pointer;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .upi-option:hover, .upi-option.selected {
            background-color: #fff5e6;
        }
        .upi-option i {
            font-size: 2rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-danger" href="#">FoodHub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="CallHomeServlet">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container checkout-container">
        <h1 class="text-center mb-4">Checkout</h1>
        <%
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null || cart.getItems().isEmpty()) {
        %>
        <div class="text-center">
            <p class="mb-4">Your cart is empty.</p>
            <a href="home.jsp" class="btn btn-primary">Browse Restaurants</a>
        </div>
        <%
            } else {
                User user = (User) session.getAttribute("user");
                if (user == null) {
        %>
        <div class="text-center">
            <p class="mb-4">You need to log in to complete your order.</p>
            <a href="login.jsp" class="btn btn-primary">Login</a>
        </div>
        <%
                } else {
        %>
        <div class="checkout-form">
            <div class="order-summary mb-4">
                <h3 class="mb-3">Order Summary</h3>
                <%
                    double totalAmount = 0;
                    for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                        CartItem item = entry.getValue();
                        totalAmount += item.getPrice() * item.getQuantity();
                %>
                <div class="order-item">
                    <span><%= item.getName() %> x <%= item.getQuantity() %></span>
                    <span>₹<%= String.format("%.2f", item.getTotalPrice()) %></span>
                </div>
                <%
                    }
                %>
                <hr>
                <div class="order-item total-amount">
                    <span>Total Amount:</span>
                    <span>₹<%= String.format("%.2f", totalAmount) %></span>
                </div>
            </div>

            <form action="checkoutServlet"  id="checkoutForm">
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Delivery Address</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required><%= user.getAddress() %></textarea>
                </div>
                <div class="mb-4">
                    <label class="form-label">Payment Method</label>
                    <div class="payment-method-option" data-method="creditCard">
                        <i class="bi bi-credit-card me-2"></i> Credit Card
                    </div>
                    <div class="payment-method-option" data-method="debitCard">
                        <i class="bi bi-credit-card me-2"></i> Debit Card
                    </div>
                    <div class="payment-method-option" data-method="upi">
                        <i class="bi bi-phone me-2"></i> UPI
                    </div>
                    <div class="payment-method-option" data-method="cashOnDelivery">
                        <i class="bi bi-cash me-2"></i> Cash on Delivery
                    </div>
                </div>
                <input type="hidden" id="modeOfPayment" name="modeOfPayment" required>
                <div id="cardDetails" class="payment-details">
                    <div class="mb-3">
                        <label for="cardNumber" class="form-label">Card Number</label>
                        <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="expiryDate" class="form-label">Expiry Date</label>
                            <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="cvv" class="form-label">CVV</label>
                            <input type="text" class="form-control" id="cvv" placeholder="123">
                        </div>
                    </div>
                </div>
                <div id="upiDetails" class="payment-details">
                    <div class="upi-options">
                        <div class="upi-option" data-upi="phonepe">
                            <i class="bi bi-phone"></i>
                            <div>PhonePe</div>
                        </div>
                        <div class="upi-option" data-upi="paytm">
                            <i class="bi bi-wallet2"></i>
                            <div>Paytm</div>
                        </div>
                        <div class="upi-option" data-upi="googlepay">
                            <i class="bi bi-google"></i>
                            <div>Google Pay</div>
                        </div>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="upiId" class="form-label">UPI ID</label>
                        <input type="text" class="form-control" id="upiId" placeholder="yourname@upi">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-lock-fill me-2"></i>Place Order
                </button>
            </form>
        </div>
        <%
                }
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const paymentOptions = document.querySelectorAll('.payment-method-option');
            const cardDetails = document.getElementById('cardDetails');
            const upiDetails = document.getElementById('upiDetails');
            const modeOfPaymentInput = document.getElementById('modeOfPayment');
            const upiOptions = document.querySelectorAll('.upi-option');

            paymentOptions.forEach(option => {
                option.addEventListener('click', function() {
                    paymentOptions.forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    const method = this.dataset.method;
                    modeOfPaymentInput.value = method;

                    cardDetails.style.display = (method === 'creditCard' || method === 'debitCard') ? 'block' : 'none';
                    upiDetails.style.display = method === 'upi' ? 'block' : 'none';
                });
            });

            upiOptions.forEach(option => {
                option.addEventListener('click', function() {
                    upiOptions.forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    // You can add additional logic here for UPI selection
                });
            });

            // Simple form validation
            document.getElementById('checkoutForm').addEventListener('submit', function(e) {
                const selectedPaymentMethod = modeOfPaymentInput.value;
                if (!selectedPaymentMethod) {
                    e.preventDefault();
                    alert('Please select a payment method');
                }
                // Add more validation as needed
            });
        });
    </script>
</body>
</html>