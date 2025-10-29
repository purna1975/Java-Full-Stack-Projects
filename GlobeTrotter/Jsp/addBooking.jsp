<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.daoimpl.BookingDaoImpl, com.tap.model.Booking" %>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wonderland Travels - Add New Booking</title>
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
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        .form-floating {
            margin-bottom: 1rem;
        }
        .form-floating > label {
            padding-left: 1rem;
        }
        .form-control:focus {
            border-color: #1e3c72;
            box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.25);
        }
        .btn-submit {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 500;
        }
        .btn-submit:hover {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            transform: translateY(-1px);
        }
        .input-group-text {
            background: transparent;
            border-right: none;
        }
        .input-group .form-control {
            border-left: none;
        }
        .form-section {
            border-bottom: 1px solid #eee;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
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
                    <a href="manageBookings.jsp" class="nav-link text-primary">
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
                        <h2><i class="bi bi-plus-circle-fill me-2"></i>Add New Booking</h2>
                        <p class="mb-0">Create a new travel booking for a user</p>
                    </div>
                    <a href="manageBookings.jsp" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to Bookings
                    </a>
                </div>
            </div>

            <!-- Booking Form -->
            <div class="form-container">
                <form action="addBookingServlet" class="needs-validation" novalidate>
                    <!-- User Details Section -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-person-circle me-2"></i>User Information</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="text" class="form-control" id="userId" name="user_id" required>
                                        <label for="userId">User ID</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="text" class="form-control" id="wonderId" name="wonder_id" required>
                                        <label for="wonderId">Wonder ID</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Details Section -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-calendar-event me-2"></i>Booking Details</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="date" class="form-control" id="bookingDate" name="booking_date" required>
                                        <label for="bookingDate">Booking Date</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-clock"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="time" class="form-control" id="timeSlot" name="time_slot" required>
                                        <label for="timeSlot">Time Slot</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Details Section -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-info-circle me-2"></i>Additional Details</h5>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-translate"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="text" class="form-control" id="language" name="language" required>
                                        <label for="language">Language</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-people"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="number" class="form-control" id="guests" name="guests" required min="1">
                                        <label for="guests">Number of Guests</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-currency-dollar"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="number" class="form-control" id="totalAmount" name="total_amount" required min="0">
                                        <label for="totalAmount">Total Amount</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-check-circle"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="Pending">Pending</option>
                                            <option value="Approved">Approved</option>
                                            <option value="Rejected">Rejected</option>
                                        </select>
                                        <label for="status">Booking Status</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="button" class="btn btn-light me-2" onclick="location.href='manageBookings.jsp'">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </button>
                        <button type="submit" class="btn btn-primary btn-submit">
                            <i class="bi bi-check-circle me-2"></i>Create Booking
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>

























  













