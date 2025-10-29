<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.tap.daoimpl.BookingDaoImpl, com.tap.model.Booking" %>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    BookingDaoImpl bookingDao = new BookingDaoImpl();
    List<Booking> bookings = bookingDao.getAllBookings();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wonderland Travels - Manage Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .page-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            overflow-x: auto;
        }
        .table {
            margin-bottom: 0;
        }
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            white-space: nowrap;
        }
        .status-badge {
            padding: 0.5em 1em;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }
        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }
        .action-buttons .btn {
            margin: 0.2rem;
        }
        .booking-stats {
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block bg-white sidebar p-4">
            <div class="text-center mb-4">
                <i class="bi bi-airplane-engines fs-1 text-primary"></i>
                <h4 class="mt-2">Wonderland Travels</h4>
            </div>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item mb-2">
                    <a href="admindashboard.jsp" class="nav-link text-dark">
                        <i class="bi bi-speedometer2 me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageUsers.jsp" class="nav-link text-dark">
                        <i class="bi bi-people me-2"></i> Manage Users
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageBookings.jsp" class="nav-link active text-primary">
                        <i class="bi bi-calendar-check me-2"></i> Manage Bookings
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="adminLogoutServlet" class="nav-link text-danger">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 ms-sm-auto px-4 py-3">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2><i class="bi bi-calendar-check-fill me-2"></i>Manage Bookings</h2>
                        <p class="mb-0">View and manage all travel bookings</p>
                    </div>
                    <div>
                        <a href="addBooking.jsp" class="btn btn-light">
                            <i class="bi bi-plus-circle me-2"></i>Add New Booking
                        </a>
                    </div>
                </div>
            </div>

            <!-- Booking Statistics -->
            <div class="row booking-stats">
                <div class="col-md-4 mb-3">
                    <div class="stat-card text-center">
                        <i class="bi bi-calendar2-check text-primary fs-1"></i>
                        <h3 class="mt-2"><%= bookings.size() %></h3>
                        <p class="text-muted mb-0">Total Bookings</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stat-card text-center">
                        <i class="bi bi-hourglass-split text-warning fs-1"></i>
                        <h3 class="mt-2">
                            <%= bookings.stream().filter(b -> "pending".equalsIgnoreCase(b.getStatus())).count() %>
                        </h3>
                        <p class="text-muted mb-0">Pending Approvals</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stat-card text-center">
                        <i class="bi bi-check-circle text-success fs-1"></i>
                        <h3 class="mt-2">
                            <%= bookings.stream().filter(b -> "approved".equalsIgnoreCase(b.getStatus())).count() %>
                        </h3>
                        <p class="text-muted mb-0">Approved Bookings</p>
                    </div>
                </div>
            </div>

            <!-- Bookings Table -->
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>User ID</th>
                            <th>Wonder ID</th>
                            <th>Booking Date</th>
                            <th>Time Slot</th>
                            <th>Language</th>
                            <th>Guests</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking booking : bookings) { %>
                        <tr>
                            <td><%= booking.getBookingId() %></td>
                            <td><i class="bi bi-person me-1"></i><%= booking.getUserId() %></td>
                            <td><i class="bi bi-geo-alt me-1"></i><%= booking.getWonderId() %></td>
                            <td><i class="bi bi-calendar me-1"></i><%= booking.getBookingDate() %></td>
                            <td><i class="bi bi-clock me-1"></i><%= booking.getTimeSlot() %></td>
                            <td><i class="bi bi-translate me-1"></i><%= booking.getLanguage() %></td>
                            <td><i class="bi bi-people me-1"></i><%= booking.getGuests() %></td>
                            <td><i class="bi bi-currency-dollar me-1"></i><%= booking.getTotalAmount() %></td>
                            <td>
                                <span class="status-badge status-<%= booking.getStatus().toLowerCase() %>">
                                    <i class="bi bi-circle-fill me-1"></i>
                                    <%= booking.getStatus() %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <div class="btn-group">
                                    <a href="approveBookingServlet?id=<%= booking.getBookingId() %>" 
                                       class="btn btn-success btn-sm"
                                       title="Approve Booking">
                                        <i class="bi bi-check-circle"></i>
                                    </a>
                                    <a href="rejectBookingServlet?id=<%= booking.getBookingId() %>" 
                                       class="btn btn-danger btn-sm"
                                       title="Reject Booking">
                                        <i class="bi bi-x-circle"></i>
                                    </a>
                                    <a href="viewBookingDetails.jsp?id=<%= booking.getBookingId() %>" 
                                       class="btn btn-info btn-sm"
                                       title="View Details">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>