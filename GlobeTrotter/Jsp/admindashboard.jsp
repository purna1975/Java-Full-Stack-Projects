<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("home.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wonderland Travels - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .dashboard-card {
            transition: transform 0.3s ease;
            cursor: pointer;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .stat-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .welcome-section {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
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
                    <a href="admindashboard.jsp" class="nav-link active text-dark">
                        <i class="bi bi-speedometer2 me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageUsers.jsp" class="nav-link text-dark">
                        <i class="bi bi-people me-2"></i> Manage Users
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageBookings.jsp" class="nav-link text-dark">
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
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h2><i class="bi bi-person-circle me-2"></i>Welcome, <%= admin %></h2>
                <p class="mb-0">Manage your travel business operations from this dashboard</p>
            </div>

            <!-- Stats Row -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="card stat-card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-people-fill me-2"></i>Total Users</h5>
                            <h2 class="mb-0">250</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card stat-card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-calendar2-check me-2"></i>Active Bookings</h5>
                            <h2 class="mb-0">45</h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card stat-card bg-info text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="bi bi-graph-up me-2"></i>Monthly Revenue</h5>
                            <h2 class="mb-0">$12,450</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row">
                <div class="col-12 mb-4">
                    <h4>Quick Actions</h4>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card dashboard-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-plus fs-1 text-primary mb-3"></i>
                            <h5 class="card-title">Add New User</h5>
                            <p class="card-text">Register new users to the system</p>
                            <a href="AdminAddUser.jsp" class="btn btn-primary">Add User</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card dashboard-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-calendar-plus fs-1 text-success mb-3"></i>
                            <h5 class="card-title">Create Booking</h5>
                            <p class="card-text">Create new travel bookings</p>
                            <a href="addBooking.jsp" class="btn btn-success">New Booking</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card dashboard-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-file-earmark-text fs-1 text-info mb-3"></i>
                            <h5 class="card-title">Generate Report</h5>
                            <p class="card-text">Create business reports</p>
                            <a href="#" class="btn btn-info text-white">Generate</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>