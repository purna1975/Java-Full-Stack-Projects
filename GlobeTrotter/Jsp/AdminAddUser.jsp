<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

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
    <title>Wonderland Travels - Add New User</title>
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
                    <a href="manageUsers.jsp" class="nav-link text-primary">
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
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2><i class="bi bi-person-plus-fill me-2"></i>Add New User</h2>
                        <p class="mb-0">Create a new user account</p>
                    </div>
                    <a href="manageUsers.jsp" class="btn btn-light">
                        <i class="bi bi-arrow-left me-2"></i>Back to Users
                    </a>
                </div>
            </div>

            <!-- User Form -->
            <div class="form-container">
                <form action="AdminRegister" method="post" class="needs-validation" novalidate>
                    <!-- Basic Information Section -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-person-circle me-2"></i>Basic Information</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="text" class="form-control" id="name" name="name" required>
                                        <label for="name">Full Name</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="email" class="form-control" id="email" name="email" required>
                                        <label for="email">Email Address</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Security Section -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-shield-lock me-2"></i>Security Details</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="password" class="form-control" id="password" name="password" required>
                                        <label for="password">Password</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="password" class="form-control" id="cpassword" name="cpassword" required>
                                        <label for="cpassword">Confirm Password</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="form-section">
                        <h5 class="mb-3"><i class="bi bi-telephone me-2"></i>Contact Information</h5>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-phone"></i></span>
                                    <div class="form-floating flex-grow-1">
                                        <input type="number" class="form-control" id="phonenumber" name="phonenumber" required>
                                        <label for="phonenumber">Phone Number</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="button" class="btn btn-light me-2" onclick="location.href='manageUsers.jsp'">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </button>
                        <button type="submit" class="btn btn-primary btn-submit">
                            <i class="bi bi-check-circle me-2"></i>Create User
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