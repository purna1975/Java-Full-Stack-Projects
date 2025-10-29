<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.daoimpl.BookingDaoImpl, com.tap.model.Booking" %>

<%
    // Check if the admin is logged in
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Get the booking ID from the request parameter
    String bookingIdParam = request.getParameter("id");
    if (bookingIdParam == null) {
        response.sendRedirect("manageBookings.jsp");  // Redirect if ID is not provided
        return;
    }

    int bookingId = Integer.parseInt(bookingIdParam);

    // Create an instance of BookingDaoImpl to fetch the booking details by ID
    BookingDaoImpl bookingDao = new BookingDaoImpl();
    Booking booking = bookingDao.getBookingById(bookingId); // Fetch the booking by its ID
    if (booking == null) {
        out.println("Booking not found.");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Details | Wonderland Travels</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <style>
        .booking-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
        }
        .status-pending { background-color: #fef3c7; color: #92400e; }
        .status-approved { background-color: #d1fae5; color: #065f46; }
        .status-rejected { background-color: #fee2e2; color: #991b1b; }
        .action-buttons .btn {
            min-width: 120px;
            margin: 0 10px;
            padding: 10px 20px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .detail-row {
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 0;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            font-weight: 600;
            color: #4b5563;
        }
        .detail-value {
            color: #1f2937;
        }
        .booking-header {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .navigation-links {
            margin-bottom: 2rem;
        }
        .navigation-links a {
            color: #6b7280;
            text-decoration: none;
            margin-right: 1rem;
        }
        .navigation-links a:hover {
            color: #3b82f6;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <!-- Navigation Links -->
        <div class="navigation-links">
            <a href="admindashboard.jsp">← Back to Dashboard</a>
            <a href="manageBookings.jsp">← Back to Bookings</a>
        </div>

        <!-- Booking Header -->
        <div class="booking-header">
            <h2 class="m-0">Booking Details</h2>
            <p class="text-white-50 mb-0">Booking ID: #<%= booking.getBookingId() %></p>
        </div>

        <!-- Booking Details Card -->
        <div class="booking-card">
            <!-- Status Section -->
            <div class="text-center mb-4">
                <span class="status-badge <%= booking.getStatus().toLowerCase().equals("pending") ? "status-pending" : 
                                            booking.getStatus().toLowerCase().equals("approved") ? "status-approved" : 
                                            "status-rejected" %>">
                    <%= booking.getStatus().toUpperCase() %>
                </span>
            </div>

            <!-- Details Grid -->
            <div class="row">
                <div class="col-md-6">
                    <div class="detail-row">
                        <div class="detail-label">User ID</div>
                        <div class="detail-value">#<%= booking.getUserId() %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Wonder ID</div>
                        <div class="detail-value">#<%= booking.getWonderId() %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Booking Date</div>
                        <div class="detail-value"><%= booking.getBookingDate() %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Time Slot</div>
                        <div class="detail-value"><%= booking.getTimeSlot() %></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-row">
                        <div class="detail-label">Language</div>
                        <div class="detail-value"><%= booking.getLanguage() %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Number of Guests</div>
                        <div class="detail-value"><%= booking.getGuests() %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Total Amount</div>
                        <div class="detail-value">₹<%= booking.getTotalAmount() %></div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="text-center mt-4 action-buttons">
                <% if (booking.getStatus().toLowerCase().equals("pending")) { %>
                    <a href="approveBookingServlet?id=<%= booking.getBookingId() %>" 
                       class="btn btn-success">
                        Approve Booking
                    </a>
                    <a href="rejectBookingServlet?id=<%= booking.getBookingId() %>" 
                       class="btn btn-danger">
                        Reject Booking
                    </a>
                <% } else { %>
                    <button class="btn btn-secondary" disabled>
                        Status: <%= booking.getStatus() %>
                    </button>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>