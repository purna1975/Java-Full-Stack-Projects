<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Wonder Tour - Wonderland Travels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1a5f7a;
            --secondary-color: #f9a825;
            --text-light: #ffffff;
            --text-dark: #333333;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: var(--primary-color);
        }
        .booking-container {
            max-width: 1000px;
            margin: 2rem auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .booking-header {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: var(--text-light);
            padding: 2rem;
            text-align: center;
        }
        .booking-step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255,255,255,0.2);
            color: var(--text-light);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin: 0 auto;
        }
        .booking-step.active {
            background-color: var(--text-light);
            color: var(--primary-color);
        }
        .booking-step-label {
            margin-top: 0.5rem;
            text-align: center;
            color: var(--text-light);
        }
        .booking-form {
            padding: 2rem;
        }
        .form-control, .form-select {
            border-radius: 7px;
            padding: 0.75rem 1rem;
            border: 1px solid #ced4da;
        }
        .btn-next {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: var(--text-light);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-next:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .tour-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
        }
        .footer {
            background-color: var(--primary-color);
            color: var(--text-light);
            padding: 2rem 0;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("home.jsp");
        return;
    }
    
    String wonderId = request.getParameter("wonderId");
    if (wonderId == null) wonderId = "1"; // Default to Taj Mahal

    Map<String, String> wonders = new HashMap<>();
    wonders.put("1", "Taj Mahal");
    wonders.put("2", "Colosseum");
    wonders.put("3", "Great Wall of China");
    wonders.put("4", "Machu Picchu");
    wonders.put("5", "Christ the Redeemer");
    wonders.put("6", "Petra");
    wonders.put("7", "Chichen Itza");

    String wonderName = wonders.get(wonderId);
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <i class="fas fa-globe-americas me-2"></i>
            Wonderland Travels
        </a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <span class="nav-link">Welcome, <%= user.getName() %>!</span>
            </li>
        </ul>
    </div>
</nav>

<div class="booking-container">
    <!-- Booking Header -->
    <div class="booking-header">
        <h2 class="mb-4">Book Your <%= wonderName %> Tour</h2>
        <div class="row justify-content-center">
            <div class="col-4">
                <div class="booking-step active">1</div>
                <div class="booking-step-label">Tour Details</div>
            </div>
            <div class="col-4">
                <div class="booking-step">2</div>
                <div class="booking-step-label">Payment</div>
            </div>
            <div class="col-4">
                <div class="booking-step">3</div>
                <div class="booking-step-label">Confirmation</div>
            </div>
        </div>
    </div>

    <!-- Booking Form -->
    <div class="booking-form">
        <form action="BookingServlet">
            <input type="hidden" name="wonderId" value="<%= wonderId %>">
            <input type="hidden" name="step" value="1">
            
            <div class="row">
                <div class="col-md-8">
                    <div class="mb-3">
                        <label class="form-label"><i class="far fa-calendar-alt me-2"></i>Select Date</label>
                        <input type="date" 
                               name="bookingDate" 
                               class="form-control" 
                               required 
                               min="<%= java.time.LocalDate.now() %>">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-users me-2"></i>Number of Guests</label>
                        <select name="guests" class="form-select" required>
                            <% for(int i = 1; i <= 10; i++) { %>
                                <option value="<%= i %>"><%= i %> <%= i == 1 ? "Guest" : "Guests" %></option>
                            <% } %>
                        </select>
                    </div>
                    
                     <div class="mb-3">
                        <label class="form-label"><i class="fas fa-clock me-2"></i>Preferred Time Slot</label>
                        <select name="timeSlot" class="form-select" required>
                            <option value="sunrise">Sunrise (6:00 AM - 8:00 AM)</option>
                            <option value="morning">Morning (8:00 AM - 11:00 AM)</option>
                            <option value="afternoon">Afternoon (11:00 AM - 2:00 PM)</option>
                            <option value="evening">Evening (2:00 PM - Sunset)</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-language me-2"></i>Guide Language</label>
                        <select name="language" class="form-select" required>
                            <option value="english">English</option>
                            <option value="spanish">Spanish</option>
                            <option value="french">French</option>
                            <option value="german">German</option>
                            <option value="italian">Italian</option>
                            <option value="chinese">Chinese</option>
                            <option value="japanese">Japanese</option>
                        </select>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="tour-summary">
                        <h4 class="mb-4">Tour Summary</h4>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Base Price</span>
                            <span>$50.00/person</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Guide Service</span>
                            <span>Included</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Entry Tickets</span>
                            <span>Included</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total</span>
                            <span id="totalPrice">$50.00</span>
                        </div>
                        <small class="text-muted d-block mt-2">* Price will update based on number of guests</small>
                    </div>
                </div>
            </div>

            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-next">
                    Continue to Payment
                    <i class="fas fa-arrow-right ms-2"></i>
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-5">
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
                    <li><i class="fas fa-phone me-2"></i> +1 234 567 890</li>
                    <li><i class="fas fa-envelope me-2"></i> support@wonderland.com</li>
                </ul>
            </div>
        </div>
        <hr class="mt-4 mb-4">
        <p class="text-center mb-0">&copy; 2025 Wonderland Travels. All rights reserved.</p>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Update total price when number of guests changes
    document.querySelector('select[name="guests"]').addEventListener('change', function(e) {
        const guests = parseInt(e.target.value);
        const pricePerPerson = 50;
        const total = guests * pricePerPerson;
        document.getElementById('totalPrice').textContent = `$${total}.00`;
    });
</script>

</body>
</html>