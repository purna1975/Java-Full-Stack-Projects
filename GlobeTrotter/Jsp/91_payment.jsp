<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Wonderland Travels</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap/css/mdb.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --border-radius: 12px;
        }

        body {
            background-color: #f8fafc;
        }

        .payment-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        .payment-option {
            border: 2px solid #e2e8f0;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .payment-option:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
        }

        .payment-option.selected {
            border-color: var(--primary-color);
            background-color: #eff6ff;
        }

        .payment-option.selected::before {
            content: '✓';
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--primary-color);
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .payment-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
            transition: transform 0.3s ease;
        }

        .payment-option:hover .payment-icon {
            transform: scale(1.1);
        }

        .payment-details {
            background: #f8fafc;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .upi-details {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
        }

        .upi-details.show {
            max-height: 200px;
            margin-top: 1rem;
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
            background-color: var(--secondary-color);
            transform: translateY(-1px);
        }

        .btn-primary:disabled {
            background-color: #94a3b8;
            cursor: not-allowed;
        }

        .amount-badge {
            background: #dbeafe;
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            display: inline-block;
            margin-bottom: 2rem;
        }

        .payment-method-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .payment-method-description {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 0;
        }

        /* Custom input styling */
        .form-control {
            border-radius: var(--border-radius);
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Secure badge */
        .secure-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            color: #64748b;
            margin-top: 1rem;
        }

        .secure-badge i {
            color: #10b981;
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
    
    Double totalAmount = (Double) session.getAttribute("totalAmount");
    if (totalAmount == null) {
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
    <div class="payment-container">
        <div class="text-center mb-5">
            <h2 class="mb-4">Complete Your Payment</h2>
            <div class="amount-badge">
                Total Amount: $<%= String.format("%.2f", totalAmount) %>
            </div>
        </div>

        <div class="payment-details">
            <h5 class="mb-3">Booking Summary</h5>
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-2"><strong>Customer:</strong> <%= user.getName() %></p>
                    <p class="mb-2"><strong>Booking ID:</strong> #<%= System.currentTimeMillis() % 100000 %></p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p class="mb-2"><strong>Date:</strong> <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></p>
                </div>
            </div>
        </div>

        <form action="BookingServlet" id="paymentForm">
            <input type="hidden" name="step" value="2">
            
            <h5 class="mb-4">Select Payment Method</h5>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="payment-option" onclick="selectPayment('card')">
                        <div class="text-center">
                            <div class="payment-icon">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <h4 class="payment-method-title">Credit/Debit Card</h4>
                            <p class="payment-method-description">Pay securely with your card</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 mb-4">
                    <div class="payment-option" onclick="selectPayment('upi')">
                        <div class="text-center">
                            <div class="payment-icon">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h4 class="payment-method-title">UPI Payment</h4>
                            <p class="payment-method-description">Pay using any UPI app</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="payment-option" onclick="selectPayment('netbanking')">
                        <div class="text-center">
                            <div class="payment-icon">
                                <i class="fas fa-university"></i>
                            </div>
                            <h4 class="payment-method-title">Net Banking</h4>
                            <p class="payment-method-description">Pay through your bank account</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="payment-option" onclick="selectPayment('wallet')">
                        <div class="text-center">
                            <div class="payment-icon">
                                <i class="fas fa-wallet"></i>
                            </div>
                            <h4 class="payment-method-title">Digital Wallet</h4>
                            <p class="payment-method-description">Pay using digital wallets</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="upi-details" id="upiDetails">
                <div class="form-group">
                    <label for="upiId">Enter UPI ID</label>
                    <input type="text" class="form-control" id="upiId" name="upiId" 
                           placeholder="yourname@upi" pattern="[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}">
                    <small class="form-text text-muted">Example: yourname@okaxis or yourname@okhdfcbank</small>
                </div>
            </div>

            <input type="hidden" name="paymentMethod" id="paymentMethod">
            
            <div class="text-center mt-5">
                <button type="submit" class="btn btn-primary btn-lg" disabled id="proceedBtn">
                    Proceed to Pay
                    <i class="fas fa-lock ml-2"></i>
                </button>
                <div class="secure-badge">
                    <i class="fas fa-shield-alt"></i>
                    <span>Secure Payment Gateway</span>
                </div>
            </div>
        </form>
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
<script>
    function selectPayment(method) {
        // Remove selected class from all options
        document.querySelectorAll('.payment-option').forEach(option => {
            option.classList.remove('selected');
        });
        
        // Add selected class to clicked option
        const selectedOption = event.currentTarget;
        selectedOption.classList.add('selected');
        
        // Update hidden input
        document.getElementById('paymentMethod').value = method;
        
        // Enable proceed button
        document.getElementById('proceedBtn').disabled = false;
        
        // Handle UPI details
        const upiDetails = document.getElementById('upiDetails');
        if (method === 'upi') {
            upiDetails.classList.add('show');
            document.getElementById('upiId').required = true;
        } else {
            upiDetails.classList.remove('show');
            document.getElementById('upiId').required = false;
        }

        // Update button text based on selection
        const proceedBtn = document.getElementById('proceedBtn');
        switch(method) {
            case 'card':
                proceedBtn.innerHTML = 'Pay with Card <i class="fas fa-lock ml-2"></i>';
                break;
            case 'upi':
                proceedBtn.innerHTML = 'Pay with UPI <i class="fas fa-mobile-alt ml-2"></i>';
                break;
            case 'netbanking':
                proceedBtn.innerHTML = 'Pay with Net Banking <i class="fas fa-university ml-2"></i>';
                break;
            case 'wallet':
                proceedBtn.innerHTML = 'Pay with Wallet <i class="fas fa-wallet ml-2"></i>';
                break;
        }
    }

    document.getElementById('paymentForm').onsubmit = function(e) {
        const method = document.getElementById('paymentMethod').value;
        if (method === 'upi') {
            const upiId = document.getElementById('upiId').value;
            if (!upiId) {
                e.preventDefault();
                alert('Please enter your UPI ID');
                return false;
            }
            
            const upiPattern = /[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}/;
            if (!upiPattern.test(upiId)) {
                e.preventDefault();
                alert('Please enter a valid UPI ID');
                return false;
            }
        }
        return true;
    };
</script>

</body>
</html>